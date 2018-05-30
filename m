Received: from eggs.gnu.org ([2001:4830:134:3::10]:43198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fNsdA-0005RR-NG
	for qemu-devel@nongnu.org; Wed, 30 May 2018 00:22:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fNsd9-0000j1-FR
	for qemu-devel@nongnu.org; Wed, 30 May 2018 00:22:36 -0400
Date: Wed, 30 May 2018 00:22:25 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180530042225.GC9904@localhost.localdomain>
References: <20180529203910.7615-1-kwolf@redhat.com>
	<20180529203910.7615-5-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529203910.7615-5-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 04/16] block/create: Make
 x-blockdev-create a job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

On Tue, May 29, 2018 at 10:38:58PM +0200, Kevin Wolf wrote:
> This changes the x-blockdev-create QMP command so that it doesn't block
> the monitor and the main loop any more, but starts a background job that
> performs the image creation.
> 
> The basic job as implemented here is all that is necessary to make image
> creation asynchronous and to provide a QMP interface that can be marked
> stable, but it still lacks a few features that jobs usually provide: The
> job will ignore pause commands and it doesn't publish more than very
> basic progress yet (total-progress is 1 and current-progress advances
> from 0 to 1 when the driver callbacks returns). These features can be
> added later without breaking compatibility.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Jeff Cody <jcody@redhat.com>

> ---
>  qapi/block-core.json     | 14 ++++++----
>  qapi/job.json            |  4 ++-
>  block/create.c           | 67 +++++++++++++++++++++++++++++++++---------------
>  tests/qemu-iotests/group | 14 +++++-----
>  4 files changed, 66 insertions(+), 33 deletions(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index ad66ad6f80..eb98596614 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4013,14 +4013,18 @@
>  ##
>  # @x-blockdev-create:
>  #
> -# Create an image format on a given node.
> -# TODO Replace with something asynchronous (block job?)
> +# Starts a job to create an image format on a given node. The job is
> +# automatically finalized, but a manual job-dismiss is required.
>  #
> -# Since: 2.12
> +# @job-id:          Identifier for the newly created job.
> +#
> +# @options:         Options for the image creation.
> +#
> +# Since: 3.0
>  ##
>  { 'command': 'x-blockdev-create',
> -  'data': 'BlockdevCreateOptions',
> -  'boxed': true }
> +  'data': { 'job-id': 'str',
> +            'options': 'BlockdevCreateOptions' } }
>  
>  ##
>  # @blockdev-open-tray:
> diff --git a/qapi/job.json b/qapi/job.json
> index 970124de76..69c1970a58 100644
> --- a/qapi/job.json
> +++ b/qapi/job.json
> @@ -17,10 +17,12 @@
>  #
>  # @backup: drive backup job type, see "drive-backup"
>  #
> +# @create: image creation job type, see "x-blockdev-create" (since 3.0)
> +#
>  # Since: 1.7
>  ##
>  { 'enum': 'JobType',
> -  'data': ['commit', 'stream', 'mirror', 'backup'] }
> +  'data': ['commit', 'stream', 'mirror', 'backup', 'create'] }
>  
>  ##
>  # @JobStatus:
> diff --git a/block/create.c b/block/create.c
> index 8bd8a03719..1a263e4b13 100644
> --- a/block/create.c
> +++ b/block/create.c
> @@ -24,28 +24,51 @@
>  
>  #include "qemu/osdep.h"
>  #include "block/block_int.h"
> +#include "qemu/job.h"
>  #include "qapi/qapi-commands-block-core.h"
> +#include "qapi/qapi-visit-block-core.h"
> +#include "qapi/clone-visitor.h"
>  #include "qapi/error.h"
>  
> -typedef struct BlockdevCreateCo {
> +typedef struct BlockdevCreateJob {
> +    Job common;
>      BlockDriver *drv;
>      BlockdevCreateOptions *opts;
>      int ret;
> -    Error **errp;
> -} BlockdevCreateCo;
> +    Error *err;
> +} BlockdevCreateJob;
>  
> -static void coroutine_fn bdrv_co_create_co_entry(void *opaque)
> +static void blockdev_create_complete(Job *job, void *opaque)
>  {
> -    BlockdevCreateCo *cco = opaque;
> -    cco->ret = cco->drv->bdrv_co_create(cco->opts, cco->errp);
> +    BlockdevCreateJob *s = container_of(job, BlockdevCreateJob, common);
> +
> +    job_completed(job, s->ret, s->err);
>  }
>  
> -void qmp_x_blockdev_create(BlockdevCreateOptions *options, Error **errp)
> +static void coroutine_fn blockdev_create_run(void *opaque)
>  {
> +    BlockdevCreateJob *s = opaque;
> +
> +    job_progress_set_remaining(&s->common, 1);
> +    s->ret = s->drv->bdrv_co_create(s->opts, &s->err);
> +    job_progress_update(&s->common, 1);
> +
> +    qapi_free_BlockdevCreateOptions(s->opts);
> +    job_defer_to_main_loop(&s->common, blockdev_create_complete, NULL);
> +}
> +
> +static const JobDriver blockdev_create_job_driver = {
> +    .instance_size = sizeof(BlockdevCreateJob),
> +    .job_type      = JOB_TYPE_CREATE,
> +    .start         = blockdev_create_run,
> +};
> +
> +void qmp_x_blockdev_create(const char *job_id, BlockdevCreateOptions *options,
> +                           Error **errp)
> +{
> +    BlockdevCreateJob *s;
>      const char *fmt = BlockdevDriver_str(options->driver);
>      BlockDriver *drv = bdrv_find_format(fmt);
> -    Coroutine *co;
> -    BlockdevCreateCo cco;
>  
>      /* If the driver is in the schema, we know that it exists. But it may not
>       * be whitelisted. */
> @@ -55,22 +78,24 @@ void qmp_x_blockdev_create(BlockdevCreateOptions *options, Error **errp)
>          return;
>      }
>  
> -    /* Call callback if it exists */
> +    /* Error out if the driver doesn't support .bdrv_co_create */
>      if (!drv->bdrv_co_create) {
>          error_setg(errp, "Driver does not support blockdev-create");
>          return;
>      }
>  
> -    cco = (BlockdevCreateCo) {
> -        .drv = drv,
> -        .opts = options,
> -        .ret = -EINPROGRESS,
> -        .errp = errp,
> -    };
> -
> -    co = qemu_coroutine_create(bdrv_co_create_co_entry, &cco);
> -    qemu_coroutine_enter(co);
> -    while (cco.ret == -EINPROGRESS) {
> -        aio_poll(qemu_get_aio_context(), true);
> +    /* Create the block job */
> +    /* TODO Running in the main context. Block drivers need to error out or add
> +     * locking when they use a BDS in a different AioContext. */
> +    s = job_create(job_id, &blockdev_create_job_driver, NULL,
> +                   qemu_get_aio_context(), JOB_DEFAULT | JOB_MANUAL_DISMISS,
> +                   NULL, NULL, errp);
> +    if (!s) {
> +        return;
>      }
> +
> +    s->drv = drv,
> +    s->opts = QAPI_CLONE(BlockdevCreateOptions, options),
> +
> +    job_start(&s->common);
>  }
> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> index 93f93d71ba..22b0082db3 100644
> --- a/tests/qemu-iotests/group
> +++ b/tests/qemu-iotests/group
> @@ -204,14 +204,16 @@
>  203 rw auto migration
>  204 rw auto quick
>  205 rw auto quick
> -206 rw auto
> -207 rw auto
> +# TODO The following commented out tests need to be reworked to work
> +# with the x-blockdev-create job
> +#206 rw auto
> +#207 rw auto
>  208 rw auto quick
>  209 rw auto quick
> -210 rw auto
> -211 rw auto quick
> -212 rw auto quick
> -213 rw auto quick
> +#210 rw auto
> +#211 rw auto quick
> +#212 rw auto quick
> +#213 rw auto quick
>  214 rw auto
>  215 rw auto quick
>  216 rw auto quick
> -- 
> 2.13.6
> 
