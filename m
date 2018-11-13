Received: from eggs.gnu.org ([2001:4830:134:3::10]:45419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gMi3t-0004jr-G0
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 18:25:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gMi3l-0001vY-7s
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 18:25:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gMi3i-0001j4-V0
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 18:25:29 -0500
References: <cover.1542110461.git.xiezhide@huawei.com>
	<457f3168eca2d041bbfcad822ad9004e29a3840c.1542110461.git.xiezhide@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e14ebd78-b622-fc98-7317-c6ce63be8f60@redhat.com>
Date: Tue, 13 Nov 2018 17:25:10 -0600
MIME-Version: 1.0
In-Reply-To: <457f3168eca2d041bbfcad822ad9004e29a3840c.1542110461.git.xiezhide@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] fsdev-throttle-qmp: refactor code
 for qmp interface for io throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiezhide <xiezhide@huawei.com>, qemu-devel@nongnu.org
Cc: groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, armbru@redhat.com, berto@igalia.com, zengcanfu@huawei.com, jinxuefeng@huawei.com, johnny.chenyi@huawei.com

On 11/13/18 6:12 AM, xiezhide wrote:
> This patch includes two parts:
> 1. factor out throttle code to reuse code
> 2. use ThrottleLimits structure

Any time your patch mentions two independent things, you have to ask if 
that can be two independent patches.  It's fine if they are to 
intertwined to separate, but giving more justification never hurts.

> 
> Signed-off-by: xiezhide <xiezhide@huawei.com>
> ---
>   Makefile                        |  20 +++-
>   Makefile.objs                   |   8 ++
>   block/throttle.c                |   6 +-
>   blockdev.c                      |  96 +----------------
>   include/qemu/throttle-options.h |   3 +-
>   include/qemu/throttle.h         |   4 +-
>   include/qemu/typedefs.h         |   1 +
>   qapi/block-core.json            | 122 +---------------------
>   qapi/fsdev.json                 |  20 ++++
>   qapi/qapi-schema.json           |   1 +
>   qapi/tlimits.json               |  89 ++++++++++++++++
>   util/throttle.c                 | 224 ++++++++++++++++++++++++++--------------
>   12 files changed, 298 insertions(+), 296 deletions(-)
>   create mode 100644 qapi/fsdev.json
>   create mode 100644 qapi/tlimits.json

Still feels big; I don't know if it can be easily split into 
easier-to-manage patches, but it may be worth the effort.  For example, 
why are you adding both fsdev.json AND tlimits.json in the same patch?

> 
> diff --git a/Makefile b/Makefile
> index f294718..9ae2460 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -94,6 +94,7 @@ GENERATED_FILES += qapi/qapi-types-block-core.h qapi/qapi-types-block-core.c
>   GENERATED_FILES += qapi/qapi-types-block.h qapi/qapi-types-block.c
>   GENERATED_FILES += qapi/qapi-types-char.h qapi/qapi-types-char.c
>   GENERATED_FILES += qapi/qapi-types-common.h qapi/qapi-types-common.c
> +GENERATED_FILES += qapi/qapi-types-tlimits.h qapi/qapi-types-tlimits.c
>   GENERATED_FILES += qapi/qapi-types-crypto.h qapi/qapi-types-crypto.c
>   GENERATED_FILES += qapi/qapi-types-introspect.h qapi/qapi-types-introspect.c
>   GENERATED_FILES += qapi/qapi-types-job.h qapi/qapi-types-job.c

[Hmm - ages ago, I threatened to refactor this so there was a lot less 
manual duplication when adding a new file. I should return to that thread]

Please keep this list quasi-sorted (tlimits does NOT fall between common 
and crypto, but later in the list).

> @@ -107,12 +108,14 @@ GENERATED_FILES += qapi/qapi-types-tpm.h qapi/qapi-types-tpm.c
>   GENERATED_FILES += qapi/qapi-types-trace.h qapi/qapi-types-trace.c
>   GENERATED_FILES += qapi/qapi-types-transaction.h qapi/qapi-types-transaction.c
>   GENERATED_FILES += qapi/qapi-types-ui.h qapi/qapi-types-ui.c
> +GENERATED_FILES += qapi/qapi-types-fsdev.h qapi/qapi-types-fsdev.c

Likewise, fsdev should appear earlier, way before ui.


> @@ -598,7 +606,9 @@ qapi-modules = $(SRC_PATH)/qapi/qapi-schema.json $(SRC_PATH)/qapi/common.json \
>                  $(SRC_PATH)/qapi/tpm.json \
>                  $(SRC_PATH)/qapi/trace.json \
>                  $(SRC_PATH)/qapi/transaction.json \
> -               $(SRC_PATH)/qapi/ui.json
> +               $(SRC_PATH)/qapi/ui.json \
> +               $(SRC_PATH)/qapi/fsdev.json \
> +               $(SRC_PATH)/qapi/tlimits.json

Another sorted list that you managed to scramble.

> +++ b/Makefile.objs
> @@ -8,6 +8,7 @@ util-obj-y += qapi/qapi-types-block-core.o
>   util-obj-y += qapi/qapi-types-block.o
>   util-obj-y += qapi/qapi-types-char.o
>   util-obj-y += qapi/qapi-types-common.o
> +util-obj-y += qapi/qapi-types-tlimits.o
>   util-obj-y += qapi/qapi-types-crypto.o

And more instances of poor sorting.

> +++ b/block/throttle.c
> @@ -41,7 +41,7 @@ static QemuOptsList throttle_opts = {
>    * @group and must be freed by the caller.
>    * If there's an error then @group remains unmodified.
>    */
> -static int throttle_parse_options(QDict *options, char **group, Error **errp)
> +static int throttle_parse_group(QDict *options, char **group, Error **errp)

Why the function rename? Can that be its own patch?

> +++ b/blockdev.c
> @@ -400,48 +400,7 @@ static void extract_common_blockdev_options(QemuOpts *opts, int *bdrv_flags,
>       }
>   
>       if (throttle_cfg) {
> -        throttle_config_init(throttle_cfg);
> -        throttle_cfg->buckets[THROTTLE_BPS_TOTAL].avg =
> -            qemu_opt_get_number(opts, "throttling.bps-total", 0);

> -        throttle_cfg->op_size =
> -            qemu_opt_get_number(opts, "throttling.iops-size", 0);
> +        throttle_parse_options(throttle_cfg, opts);

Okay, here, it looks like you are doing a code motion refactor - taking 
lots of lines of code, and putting them in a new function 
throttle_parse_options.  If that's all the patch does, great; but when 
it starts to mix in other things, it is hard to review.

>   
>           if (!throttle_is_valid(throttle_cfg, errp)) {
>               return;
> @@ -2725,6 +2684,7 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
>       BlockDriverState *bs;
>       BlockBackend *blk;
>       AioContext *aio_context;
> +    ThrottleLimits *tlimits;

Do you need this new variable, or...

> @@ -2742,56 +2702,8 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
>           goto out;
>       }
>   
> -    throttle_config_init(&cfg);
> -    cfg.buckets[THROTTLE_BPS_TOTAL].avg = arg->bps;
> -    cfg.buckets[THROTTLE_BPS_READ].avg  = arg->bps_rd;
> -    cfg.buckets[THROTTLE_BPS_WRITE].avg = arg->bps_wr;
> -
> -    cfg.buckets[THROTTLE_OPS_TOTAL].avg = arg->iops;
> -    cfg.buckets[THROTTLE_OPS_READ].avg  = arg->iops_rd;
> -    cfg.buckets[THROTTLE_OPS_WRITE].avg = arg->iops_wr;
> -
> -    if (arg->has_bps_max) {
> -        cfg.buckets[THROTTLE_BPS_TOTAL].max = arg->bps_max;
> -    }

> -    if (arg->has_iops_size) {
> -        cfg.op_size = arg->iops_size;
> -    }
> +    tlimits = qapi_BlockIOThrottle_base(arg);
> +    throttle_limits_to_config(tlimits, &cfg, errp);

...can you just call 
throttle_limits_to_config(qapi_BlockIOThrottle_base(arg), ...)

>   
>       if (!throttle_is_valid(&cfg, errp)) {
>           goto out;
> diff --git a/include/qemu/throttle-options.h b/include/qemu/throttle-options.h
> index 3528a8f..3eb1825 100644
> --- a/include/qemu/throttle-options.h
> +++ b/include/qemu/throttle-options.h
> @@ -9,6 +9,7 @@
>    */
>   #ifndef THROTTLE_OPTIONS_H
>   #define THROTTLE_OPTIONS_H
> +#include "typedefs.h"

Unnecessary include. You already get this file included by virtue of 
every .c file using osdep.h.

>   
>   #define QEMU_OPT_IOPS_TOTAL "iops-total"
>   #define QEMU_OPT_IOPS_TOTAL_MAX "iops-total-max"
> @@ -110,5 +111,5 @@
>               .type = QEMU_OPT_NUMBER,\
>               .help = "when limiting by iops max size of an I/O in bytes",\
>           }
> -
> +    void throttle_parse_options(ThrottleConfig *, QemuOpts *);
>   #endif
> diff --git a/include/qemu/throttle.h b/include/qemu/throttle.h
> index abeb886..f379d91 100644
> --- a/include/qemu/throttle.h
> +++ b/include/qemu/throttle.h
> @@ -90,10 +90,10 @@ typedef struct LeakyBucket {
>    * However it allows to keep the code clean and the bucket field is reset to
>    * zero at the right time.
>    */
> -typedef struct ThrottleConfig {
> +struct ThrottleConfig {
>       LeakyBucket buckets[BUCKETS_COUNT]; /* leaky buckets */
>       uint64_t op_size;         /* size of an operation in bytes */
> -} ThrottleConfig;
> +};
>   
>   typedef struct ThrottleState {
>       ThrottleConfig cfg;       /* configuration */
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index 3ec0e13..1d335aa 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -113,6 +113,7 @@ typedef struct uWireSlave uWireSlave;
>   typedef struct VirtIODevice VirtIODevice;
>   typedef struct Visitor Visitor;
>   typedef struct node_info NodeInfo;
> +typedef struct ThrottleConfig ThrottleConfig;

Another sorted list that you scrambled.

>   typedef void SaveStateHandler(QEMUFile *f, void *opaque);
>   typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_id);
>   
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index d4fe710..05296b0 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -8,6 +8,7 @@
>   { 'include': 'crypto.json' }
>   { 'include': 'job.json' }
>   { 'include': 'sockets.json' }
> +{ 'include': 'tlimits.json' }

Here, you're moving code out to the new tlimits.json.


> index 0000000..c5559bb
> --- /dev/null
> +++ b/qapi/fsdev.json
> @@ -0,0 +1,20 @@
> +# -*- Mode: Python -*-
> +
> +##
> +# == QAPI fsdev definitions
> +##
> +
> +{ 'include': 'tlimits.json' }
> +
> +##
> +# @FsdevIOThrottle:
> +#
> +# A set of parameters describing fsdev throttling.
> +#
> +# @id: device id
> +#
> +# Since: 3.2
> +##
> +{ 'struct': 'FsdevIOThrottle',
> +  'base': 'ThrottleLimits',
> +  'data': { '*id': 'str' } }

Here, you appear to be adding a brand new struct.  Separate patch, please.

> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index 65b6dc2..f653e7d 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -94,3 +94,4 @@
>   { 'include': 'trace.json' }
>   { 'include': 'introspect.json' }
>   { 'include': 'misc.json' }
> +{ 'include': 'fsdev.json' }

Shouldn't this include both fsdev.json and tlimits.json (on the grounds 
that we include everthing here, even if other files also repeat the 
inclusions that they need for standalone use)?

> diff --git a/qapi/tlimits.json b/qapi/tlimits.json
> new file mode 100644
> index 0000000..1916726
> --- /dev/null
> +++ b/qapi/tlimits.json
> @@ -0,0 +1,89 @@
> +# -*- Mode: Python -*-
> +
> +##
> +# == Throttle limits
> +##
> +

> +#
> +# Since: 3.2

Oh, and I've been reminded that there will be no 3.2 release; the next 
release is 4.0.

> +#
> +##
> +{ 'struct': 'ThrottleLimits',
> +  'data': { '*bps': 'int', '*bps_rd': 'int',
> +            '*bps_wr': 'int', '*iops': 'int', '*iops_rd': 'int', '*iops_wr': 'int',
> +            '*bps_max': 'int', '*bps_rd_max': 'int',
> +            '*bps_wr_max': 'int', '*iops_max': 'int',
> +            '*iops_rd_max': 'int', '*iops_wr_max': 'int',
> +            '*bps_max_length': 'int', '*bps_rd_max_length': 'int',
> +            '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
> +            '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int',
> +            '*iops_size': 'int' } }
> diff --git a/util/throttle.c b/util/throttle.c
> index b38e742..cea30f5 100644
> --- a/util/throttle.c

> @@ -596,43 +598,109 @@ void throttle_limits_to_config(ThrottleLimits *arg, ThrottleConfig *cfg,
>    */
>   void throttle_config_to_limits(ThrottleConfig *cfg, ThrottleLimits *var)
>   {
> -    var->bps_total               = cfg->buckets[THROTTLE_BPS_TOTAL].avg;
> -    var->bps_read                = cfg->buckets[THROTTLE_BPS_READ].avg;
> -    var->bps_write               = cfg->buckets[THROTTLE_BPS_WRITE].avg;
> -    var->iops_total              = cfg->buckets[THROTTLE_OPS_TOTAL].avg;
> -    var->iops_read               = cfg->buckets[THROTTLE_OPS_READ].avg;
> -    var->iops_write              = cfg->buckets[THROTTLE_OPS_WRITE].avg;
> -    var->bps_total_max           = cfg->buckets[THROTTLE_BPS_TOTAL].max;
> -    var->bps_read_max            = cfg->buckets[THROTTLE_BPS_READ].max;
> -    var->bps_write_max           = cfg->buckets[THROTTLE_BPS_WRITE].max;
> -    var->iops_total_max          = cfg->buckets[THROTTLE_OPS_TOTAL].max;
> -    var->iops_read_max           = cfg->buckets[THROTTLE_OPS_READ].max;
> -    var->iops_write_max          = cfg->buckets[THROTTLE_OPS_WRITE].max;
> -    var->bps_total_max_length    = cfg->buckets[THROTTLE_BPS_TOTAL].burst_length;
> -    var->bps_read_max_length     = cfg->buckets[THROTTLE_BPS_READ].burst_length;
> -    var->bps_write_max_length    = cfg->buckets[THROTTLE_BPS_WRITE].burst_length;
> -    var->iops_total_max_length   = cfg->buckets[THROTTLE_OPS_TOTAL].burst_length;
> -    var->iops_read_max_length    = cfg->buckets[THROTTLE_OPS_READ].burst_length;
> -    var->iops_write_max_length   = cfg->buckets[THROTTLE_OPS_WRITE].burst_length;
> +    var->bps               = cfg->buckets[THROTTLE_BPS_TOTAL].avg;
> +    var->bps_rd                = cfg->buckets[THROTTLE_BPS_READ].avg;
> +    var->bps_wr               = cfg->buckets[THROTTLE_BPS_WRITE].avg;
> +    var->iops              = cfg->buckets[THROTTLE_OPS_TOTAL].avg;

Why is the alignment all messed up?  Either keep the '=' aligned, or get 
rid of the variable spacing.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
