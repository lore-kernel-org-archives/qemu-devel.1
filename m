Received: from eggs.gnu.org ([2001:4830:134:3::10]:45060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dqG7I-0005nx-6g
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:02:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dqG77-0001Zk-NU
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:02:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dqG77-0001Z3-FS
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:02:17 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1504541267-36954-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1504541267-36954-6-git-send-email-pradeep.jagadeesh@huawei.com>
Date: Fri, 08 Sep 2017 12:02:14 +0200
In-Reply-To: <1504541267-36954-6-git-send-email-pradeep.jagadeesh@huawei.com>
	(Pradeep Jagadeesh's message of "Mon, 4 Sep 2017 12:07:46 -0400")
Message-ID: <87d171fqzd.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v10 5/6] fsdev: QMP interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Cc: eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>, alberto garcia <berto@igalia.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, jani kokkonen <jani.kokkonen@huawei.com>

Pradeep Jagadeesh <pradeepkiruvale@gmail.com> writes:

> This patch introduces qmp interfaces for the fsdev
> devices. This provides two interfaces one
> for querying info of all the fsdev devices. The second one
> to set the IO limits for the required fsdev device.
>
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> ---
>  Makefile                    |   4 ++
>  fsdev/qemu-fsdev-dummy.c    |  11 ++++
>  fsdev/qemu-fsdev-throttle.c | 145 ++++++++++++++++++++++++++++++++++++++++++--
>  fsdev/qemu-fsdev-throttle.h |   9 ++-
>  fsdev/qemu-fsdev.c          |  30 +++++++++
>  monitor.c                   |   5 ++
>  qapi-schema.json            |   3 +
>  qapi/fsdev.json             |  81 +++++++++++++++++++++++++
>  qmp.c                       |  14 +++++
>  9 files changed, 294 insertions(+), 8 deletions(-)
>  create mode 100644 qapi/fsdev.json
>
> diff --git a/Makefile b/Makefile
> index 81447b1..ec31ffa 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -414,6 +414,10 @@ qapi-modules = $(SRC_PATH)/qapi-schema.json $(SRC_PATH)/qapi/common.json \
>                 $(SRC_PATH)/qapi/crypto.json $(SRC_PATH)/qapi/rocker.json \
>                 $(SRC_PATH)/qapi/trace.json
>  
> +ifdef CONFIG_VIRTFS
> +qapi-modules += $(SRC_PATH)/qapi/fsdev.json
> +endif
> +

The ifdef is a *lie*: qapi.py *will* include this file no matter what.
Lying to make is not a good idea.  Drop the ifdef.

>  qapi-types.c qapi-types.h :\
>  $(qapi-modules) $(SRC_PATH)/scripts/qapi-types.py $(qapi-py)
>  	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-types.py \
> diff --git a/fsdev/qemu-fsdev-dummy.c b/fsdev/qemu-fsdev-dummy.c
> index 6dc0fbc..28c82d2 100644
> --- a/fsdev/qemu-fsdev-dummy.c
> +++ b/fsdev/qemu-fsdev-dummy.c
> @@ -14,8 +14,19 @@
>  #include "qemu-fsdev.h"
>  #include "qemu/config-file.h"
>  #include "qemu/module.h"
> +#include "qmp-commands.h"
>  
>  int qemu_fsdev_add(QemuOpts *opts)
>  {
>      return 0;
>  }
> +
> +void qmp_fsdev_set_io_throttle(IOThrottle *arg, Error **errp)
> +{
> +    return;
> +}
> +
> +IOThrottleList *qmp_query_fsdev_io_throttle(Error **errp)
> +{
> +    return NULL;
> +}

Predates this patch: should this be in stubs/?  Might simplify
fsdev/Makefile.objs.

> diff --git a/fsdev/qemu-fsdev-throttle.c b/fsdev/qemu-fsdev-throttle.c
> index 0e6fb86..525352e 100644
> --- a/fsdev/qemu-fsdev-throttle.c
> +++ b/fsdev/qemu-fsdev-throttle.c
[Skipping this one...]
> diff --git a/fsdev/qemu-fsdev-throttle.h b/fsdev/qemu-fsdev-throttle.h
> index e418643..bfeab40 100644
> --- a/fsdev/qemu-fsdev-throttle.h
> +++ b/fsdev/qemu-fsdev-throttle.h
> @@ -15,8 +15,6 @@
>  #ifndef _FSDEV_THROTTLE_H
>  #define _FSDEV_THROTTLE_H
>  
> -#include "block/aio.h"
> -#include "qemu/main-loop.h"
>  #include "qemu/coroutine.h"
>  #include "qapi/error.h"
>  #include "qemu/throttle.h"
> @@ -25,6 +23,7 @@ typedef struct FsThrottle {
>      ThrottleState ts;
>      ThrottleTimers tt;
>      ThrottleConfig cfg;
> +    AioContext *ctx;
>      CoQueue      throttled_reqs[2];
>  } FsThrottle;
>  
> @@ -36,4 +35,10 @@ void coroutine_fn fsdev_co_throttle_request(FsThrottle *, bool ,
>                                              struct iovec *, int);
>  
>  void fsdev_throttle_cleanup(FsThrottle *);
> +
> +void fsdev_set_io_throttle(IOThrottle *, FsThrottle *, Error **errp);
> +
> +void fsdev_get_io_throttle(FsThrottle *, IOThrottle **iothp,
> +                           char *);

Include the last parameter's name, for consistency with the other
parameter declarations.

> +
>  #endif /* _FSDEV_THROTTLE_H */
> diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
> index 266e442..0f701fc 100644
> --- a/fsdev/qemu-fsdev.c
> +++ b/fsdev/qemu-fsdev.c
> @@ -16,6 +16,7 @@
>  #include "qemu-common.h"
>  #include "qemu/config-file.h"
>  #include "qemu/error-report.h"
> +#include "qmp-commands.h"
>  
>  static QTAILQ_HEAD(FsDriverEntry_head, FsDriverListEntry) fsdriver_entries =
>      QTAILQ_HEAD_INITIALIZER(fsdriver_entries);
> @@ -98,3 +99,32 @@ FsDriverEntry *get_fsdev_fsentry(char *id)
>      }
>      return NULL;
>  }
> +
> +void qmp_fsdev_set_io_throttle(IOThrottle *arg, Error **errp)
> +{
> +
> +    FsDriverEntry *fse;
> +
> +    fse = get_fsdev_fsentry(arg->has_id ? arg->id : NULL);

!arg->has_id implies !arg->id.  Therefore, Just arg->id would do, no
need to check arg->has_id first.  It's not wrong, though.

> +    if (!fse) {
> +        error_setg(errp, "Not a valid fsdev device");
> +        return;
> +    }
> +
> +    fsdev_set_io_throttle(arg, &fse->fst, errp);
> +}
> +
> +IOThrottleList *qmp_query_fsdev_io_throttle(Error **errp)
> +{
> +    IOThrottleList *head = NULL, *p_next;
> +    struct FsDriverListEntry *fsle;
> +
> +    QTAILQ_FOREACH(fsle, &fsdriver_entries, next) {
> +        p_next = g_new0(IOThrottleList, 1);
> +        fsdev_get_io_throttle(&fsle->fse.fst, &p_next->value,
> +                              fsle->fse.fsdev_id);
> +        p_next->next = head;
> +        head = p_next;
> +    }
> +    return head;
> +}
> diff --git a/monitor.c b/monitor.c
> index e0f8801..eebda1c 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -998,6 +998,11 @@ static void qmp_unregister_commands_hack(void)
>      && !defined(TARGET_S390X)
>      qmp_unregister_command(&qmp_commands, "query-cpu-definitions");
>  #endif
> +#ifndef CONFIG_VIRTFS
> +    qmp_unregister_command(&qmp_commands, "fsdev-set-io-throttle");
> +    qmp_unregister_command(&qmp_commands, "query-fsdev-io-throttle");
> +#endif
> +
>  }
>  
>  void monitor_init_qmp_commands(void)
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 802ea53..8cf8140 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -81,6 +81,9 @@
>  # QAPI block definitions
>  { 'include': 'qapi/block.json' }
>  
> +# QAPI fsdev definitions
> +{ 'include': 'qapi/fsdev.json' }
> +
>  # QAPI event definitions
>  { 'include': 'qapi/event.json' }
>  
> diff --git a/qapi/fsdev.json b/qapi/fsdev.json
> new file mode 100644
> index 0000000..21d074d
> --- /dev/null
> +++ b/qapi/fsdev.json
> @@ -0,0 +1,81 @@
> +# -*- Mode: Python -*-
> +
> +##
> +# == QAPI fsdev definitions
> +##
> +
> +##
> +# @fsdev-set-io-throttle:
> +#
> +# Change I/O limits for a 9p/fsdev device.
> +#
> +# I/O limits can be enabled by setting throttle value to non-zero number.
> +#
> +# I/O limits can be disabled by setting all throttle values to 0.
> +#
> +# Returns: Nothing on success
> +#          If @device is not a valid fsdev device, GenericError
> +#
> +# Since: 2.10

2.11

> +#
> +# Example:
> +#
> +# -> { "execute": "fsdev-set-io-throttle",
> +#      "arguments": { "id": "id0-1-0",
> +#                     "bps": 1000000,
> +#                     "bps_rd": 0,
> +#                     "bps_wr": 0,
> +#                     "iops": 0,
> +#                     "iops_rd": 0,
> +#                     "iops_wr": 0,
> +#                     "bps_max": 8000000,
> +#                     "bps_rd_max": 0,
> +#                     "bps_wr_max": 0,
> +#                     "iops_max": 0,
> +#                     "iops_rd_max": 0,
> +#                     "iops_wr_max": 0,
> +#                     "bps_max_length": 60,
> +#                     "iops_size": 0 } }
> +# <- { "returns": {} }
> +##
> +{ 'command': 'fsdev-set-io-throttle', 'boxed': true,
> +  'data': 'IOThrottle' }
> +##
> +# @query-fsdev-io-throttle:
> +#
> +# Returns: a list of @IOThrottle describing I/O throttle
> +#          values of each fsdev device
> +#
> +# Since: 2.10

2.11

IOThrottle serves both as parameter of fsdev-set-io-throttle and as
result of query-fsdev-io-throttle.

The former needs many of its members to be optional.

Which of the optional members are *actually* optional in the result of
query-fsdev-io-throttle?  Under what conditions can they be absent?

For what it's worth, the corresponding block layer query doesn't reuse
IOThrottle.  Instead, it repeats the throttling stuff in
BlockDeviceInfo, with the same members optional.  BlockDeviceInfo
documentation neglects to specify under what conditions they can be
absent.  Berto?

> +#
> +# Example:
> +#
> +# -> { "Execute": "query-fsdev-io-throttle" }
> +# <- { "returns" : [
> +#          {
> +#              "id": "id0-hd0",
> +#              "bps":1000000,
> +#              "bps_rd":0,
> +#              "bps_wr":0,
> +#              "iops":1000000,
> +#              "iops_rd":0,
> +#              "iops_wr":0,
> +#              "bps_max": 8000000,
> +#              "bps_rd_max": 0,
> +#              "bps_wr_max": 0,
> +#              "iops_max": 0,
> +#              "iops_rd_max": 0,
> +#              "iops_wr_max": 0,
> +#              "bps_max_length": 0,
> +#              "bps_rd_max_length": 0,
> +#              "bps_wr_max_length": 0,
> +#              "iops_max_length": 0,
> +#              "iops_rd_max_length": 0,
> +#              "iops_wr_max_length": 0,
> +#              "iops_size": 0
> +#            }
> +#          ]
> +#      }
> +#
> +##
> +{ 'command': 'query-fsdev-io-throttle', 'returns': [ 'IOThrottle' ] }
> diff --git a/qmp.c b/qmp.c
> index b86201e..eed91e5 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -130,6 +130,20 @@ void qmp_cpu_add(int64_t id, Error **errp)
>      }
>  }
>  
> +#if defined(_WIN64) || defined(_WIN32) || defined(__FreeBSD__)
> +
> +void qmp_fsdev_set_io_throttle(IOThrottle *arg, Error **errp)
> +{
> +    return;
> +}
> +
> +IOThrottleList *qmp_query_fsdev_io_throttle(Error **errp)
> +{
> +    return NULL;
> +}
> +
> +#endif
> +
>  #ifndef CONFIG_VNC
>  /* If VNC support is enabled, the "true" query-vnc command is
>     defined in the VNC subsystem */

Why do we need *two* stubs for these functions, one here and one in
fsdev/qemu-fsdev-dummy.c?
