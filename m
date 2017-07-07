Received: from eggs.gnu.org ([2001:4830:134:3::10]:56906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dTUbv-0004jg-PP
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:52:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dTUbs-00088Z-K0
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:51:59 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:16987)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dTUbs-000876-2m
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:51:56 -0400
References: <1499182263-19139-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1499182263-19139-7-git-send-email-pradeep.jagadeesh@huawei.com>
	<87poddbdxd.fsf@dusky.pond.sub.org>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <42a24929-e618-5aec-7b78-e99a5c1e3bd9@huawei.com>
Date: Fri, 7 Jul 2017 16:50:46 +0200
MIME-Version: 1.0
In-Reply-To: <87poddbdxd.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 6/6] fsdev: QMP interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Cc: eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>, qemu-devel@nongnu.org, jani kokkonen <jani.kokkonen@huawei.com>, alberto
	garcia <berto@igalia.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 7/6/2017 8:47 PM, Markus Armbruster wrote:
> Pradeep Jagadeesh <pradeepkiruvale@gmail.com> writes:
>
>> This patch introduces qmp interfaces for the fsdev
>> devices. This provides two interfaces one
>> for querying info of all the fsdev devices. The second one
>> to set the IO limits for the required fsdev device.
>>
>> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
>> ---
>>  Makefile                    |  4 +++
>>  fsdev/qemu-fsdev-dummy.c    | 10 ++++++
>>  fsdev/qemu-fsdev-throttle.c | 76 +++++++++++++++++++++++++++++++++++++++-
>>  fsdev/qemu-fsdev-throttle.h | 13 +++++++
>>  fsdev/qemu-fsdev.c          | 37 ++++++++++++++++++++
>>  monitor.c                   |  5 +++
>>  qapi-schema.json            |  3 ++
>>  qapi/fsdev.json             | 84 +++++++++++++++++++++++++++++++++++++++++++++
>>  qmp.c                       | 14 ++++++++
>>  9 files changed, 245 insertions(+), 1 deletion(-)
>>  create mode 100644 qapi/fsdev.json
>>
>> diff --git a/Makefile b/Makefile
>> index 16a0430..4fd7625 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -416,6 +416,10 @@ qapi-modules = $(SRC_PATH)/qapi-schema.json $(SRC_PATH)/qapi/common.json \
>>                 $(SRC_PATH)/qapi/crypto.json $(SRC_PATH)/qapi/rocker.json \
>>                 $(SRC_PATH)/qapi/trace.json
>>
>> +ifdef CONFIG_VIRTFS
>
> Uh, qapi-schema.json includes fsdev.json *unconditionally*, doesn't it?
Yes, that is right. I did not find a way to include fsdev.json 
conditionally. If I can do that, mostly can avoid many dump functions 
that are added in qmp.c,monitor.c and qemu-fsdev-dummy.c

>> +qapi-modules += $(SRC_PATH)/qapi/fsdev.json
>> +endif
>> +
>>  qapi-types.c qapi-types.h :\
>>  $(qapi-modules) $(SRC_PATH)/scripts/qapi-types.py $(qapi-py)
>>  	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-types.py \
>> diff --git a/fsdev/qemu-fsdev-dummy.c b/fsdev/qemu-fsdev-dummy.c
>> index 6dc0fbc..f33305d 100644
>> --- a/fsdev/qemu-fsdev-dummy.c
>> +++ b/fsdev/qemu-fsdev-dummy.c
>> @@ -19,3 +19,13 @@ int qemu_fsdev_add(QemuOpts *opts)
>>  {
>>      return 0;
>>  }
>> +
>> +void qmp_fsdev_set_io_throttle(IOThrottle *arg, Error **errp)
>> +{
>> +  return;
>
> Indentation is off.
I will fix.
>
>> +}
>> +
>> +IOThrottleList *qmp_query_fsdev_io_throttle(Error **errp)
>> +{
>> +    abort();
>> +}
>
> Any particular reason why one of the stubs abort()s, but not the other?
Just to avoid proceeding further.
>
>> diff --git a/fsdev/qemu-fsdev-throttle.c b/fsdev/qemu-fsdev-throttle.c
>> index c5e2499..4483533 100644
>> --- a/fsdev/qemu-fsdev-throttle.c
>> +++ b/fsdev/qemu-fsdev-throttle.c
>> @@ -16,7 +16,6 @@
>>  #include "qemu/error-report.h"
>>  #include "qemu-fsdev-throttle.h"
>>  #include "qemu/iov.h"
>> -#include "qemu/throttle-options.h"
>>
>>  static void fsdev_throttle_read_timer_cb(void *opaque)
>>  {
>> @@ -30,6 +29,81 @@ static void fsdev_throttle_write_timer_cb(void *opaque)
>>      qemu_co_enter_next(&fst->throttled_reqs[true]);
>>  }
>>
>> +void fsdev_set_io_throttle(IOThrottle *arg, FsThrottle *fst, Error **errp)
>> +{
>> +    ThrottleConfig cfg;
>> +
>> +    throttle_set_io_limits(&cfg, arg);
>> +
>> +    if (throttle_is_valid(&cfg, errp)) {
>> +        fst->cfg = cfg;
>> +        fsdev_throttle_init(fst);
>> +    }
>> +}
>> +
>> +void fsdev_get_io_throttle(FsThrottle *fst, IOThrottle **fs9pcfg,
>> +                           char *fsdevice, Error **errp)
>> +{
>> +
>> +    ThrottleConfig cfg = fst->cfg;
>> +    IOThrottle *fscfg = g_malloc0(sizeof(*fscfg));
>> +
>> +    fscfg->has_id = true;
>> +    fscfg->id = g_strdup(fsdevice);
>> +    fscfg->bps = cfg.buckets[THROTTLE_BPS_TOTAL].avg;
>> +    fscfg->bps_rd = cfg.buckets[THROTTLE_BPS_READ].avg;
>> +    fscfg->bps_wr = cfg.buckets[THROTTLE_BPS_WRITE].avg;
>> +
>> +    fscfg->iops = cfg.buckets[THROTTLE_OPS_TOTAL].avg;
>> +    fscfg->iops_rd = cfg.buckets[THROTTLE_OPS_READ].avg;
>> +    fscfg->iops_wr = cfg.buckets[THROTTLE_OPS_WRITE].avg;
>> +
>> +    fscfg->has_bps_max     = cfg.buckets[THROTTLE_BPS_TOTAL].max;
>> +    fscfg->bps_max         = cfg.buckets[THROTTLE_BPS_TOTAL].max;
>> +    fscfg->has_bps_rd_max  = cfg.buckets[THROTTLE_BPS_READ].max;
>> +    fscfg->bps_rd_max      = cfg.buckets[THROTTLE_BPS_READ].max;
>> +    fscfg->has_bps_wr_max  = cfg.buckets[THROTTLE_BPS_WRITE].max;
>> +    fscfg->bps_wr_max      = cfg.buckets[THROTTLE_BPS_WRITE].max;
>> +
>> +    fscfg->has_iops_max    = cfg.buckets[THROTTLE_OPS_TOTAL].max;
>> +    fscfg->iops_max        = cfg.buckets[THROTTLE_OPS_TOTAL].max;
>> +    fscfg->has_iops_rd_max = cfg.buckets[THROTTLE_OPS_READ].max;
>> +    fscfg->iops_rd_max     = cfg.buckets[THROTTLE_OPS_READ].max;
>> +    fscfg->has_iops_wr_max = cfg.buckets[THROTTLE_OPS_WRITE].max;
>> +    fscfg->iops_wr_max     = cfg.buckets[THROTTLE_OPS_WRITE].max;
>> +
>> +    fscfg->has_bps_max_length     = fscfg->has_bps_max;
>> +    fscfg->bps_max_length         =
>> +         cfg.buckets[THROTTLE_BPS_TOTAL].burst_length;
>> +    fscfg->has_bps_rd_max_length  = fscfg->has_bps_rd_max;
>> +    fscfg->bps_rd_max_length      =
>> +         cfg.buckets[THROTTLE_BPS_READ].burst_length;
>> +    fscfg->has_bps_wr_max_length  = fscfg->has_bps_wr_max;
>> +    fscfg->bps_wr_max_length      =
>> +         cfg.buckets[THROTTLE_BPS_WRITE].burst_length;
>> +
>> +    fscfg->has_iops_max_length    = fscfg->has_iops_max;
>> +    fscfg->iops_max_length        =
>> +         cfg.buckets[THROTTLE_OPS_TOTAL].burst_length;
>> +    fscfg->has_iops_rd_max_length = fscfg->has_iops_rd_max;
>> +    fscfg->iops_rd_max_length     =
>> +         cfg.buckets[THROTTLE_OPS_READ].burst_length;
>> +    fscfg->has_iops_wr_max_length = fscfg->has_iops_wr_max;
>> +    fscfg->iops_wr_max_length     =
>> +         cfg.buckets[THROTTLE_OPS_WRITE].burst_length;
>> +
>> +    fscfg->bps_max_length = cfg.buckets[THROTTLE_BPS_TOTAL].burst_length;
>> +    fscfg->bps_rd_max_length = cfg.buckets[THROTTLE_BPS_READ].burst_length;
>> +    fscfg->bps_wr_max_length = cfg.buckets[THROTTLE_BPS_WRITE].burst_length;
>> +    fscfg->iops_max_length = cfg.buckets[THROTTLE_OPS_TOTAL].burst_length;
>> +    fscfg->iops_rd_max_length = cfg.buckets[THROTTLE_OPS_READ].burst_length;
>> +    fscfg->iops_wr_max_length = cfg.buckets[THROTTLE_OPS_WRITE].burst_length;
>> +
>> +    fscfg->iops_size = cfg.op_size;
>
> Duplicates bdrv_block_device_info(), which makes me sad.  Could the
> common code be factored out?
>
May be in the next patch.
>> +
>> +    *fs9pcfg = fscfg;
>> +}
>
> Why do you need to store through a parameter?  What's wrong with simply
> returning fscfg?
>
OK
>> +
>>  void fsdev_throttle_parse_opts(QemuOpts *opts, FsThrottle *fst, Error **errp)
>>  {
>>      throttle_parse_options(&fst->cfg, opts);
>> diff --git a/fsdev/qemu-fsdev-throttle.h b/fsdev/qemu-fsdev-throttle.h
>> index e418643..a49b2e5 100644
>> --- a/fsdev/qemu-fsdev-throttle.h
>> +++ b/fsdev/qemu-fsdev-throttle.h
>> @@ -20,6 +20,13 @@
>
>    #include "block/aio.h"
>    #include "qemu/main-loop.h"
>>  #include "qemu/coroutine.h"
>>  #include "qapi/error.h"
>>  #include "qemu/throttle.h"
>> +#include "qemu/throttle-options.h"
>> +#include "qapi/qmp/qerror.h"
>> +#include "qapi/qmp/types.h"
>> +#include "qapi-visit.h"
>> +#include "qapi/qobject-output-visitor.h"
>> +#include "qapi/util.h"
>> +#include "qmp-commands.h"
>
> The header actually needs two out of these twelve: coroutine.h and
> throttle.h.  Lazy use of include makes for slow compiles.  Drop the ten
> unused ones, then fix up the .c to include what they need.
OK
>
>>
>>  typedef struct FsThrottle {
>>      ThrottleState ts;
>> @@ -36,4 +43,10 @@ void coroutine_fn fsdev_co_throttle_request(FsThrottle *, bool ,
>>                                              struct iovec *, int);
>>
>>  void fsdev_throttle_cleanup(FsThrottle *);
>> +
>> +void fsdev_set_io_throttle(IOThrottle *, FsThrottle *, Error **errp);
>> +
>> +void fsdev_get_io_throttle(FsThrottle *, IOThrottle **iothp,
>> +                           char *, Error **errp);
>> +
>>  #endif /* _FSDEV_THROTTLE_H */
>> diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
>> index 266e442..0eca7c3 100644
>> --- a/fsdev/qemu-fsdev.c
>> +++ b/fsdev/qemu-fsdev.c
>> @@ -16,6 +16,7 @@
>>  #include "qemu-common.h"
>>  #include "qemu/config-file.h"
>>  #include "qemu/error-report.h"
>> +#include "qmp-commands.h"
>>
>>  static QTAILQ_HEAD(FsDriverEntry_head, FsDriverListEntry) fsdriver_entries =
>>      QTAILQ_HEAD_INITIALIZER(fsdriver_entries);
>> @@ -98,3 +99,39 @@ FsDriverEntry *get_fsdev_fsentry(char *id)
>>      }
>>      return NULL;
>>  }
>> +
>> +void qmp_fsdev_set_io_throttle(IOThrottle *arg, Error **errp)
>> +{
>> +
>> +    FsDriverEntry *fse;
>> +
>> +    fse = get_fsdev_fsentry(arg->has_id ? arg->id : NULL);
>> +    if (!fse) {
>> +        return;
>
> Why isn't this an error?
You mean returning error or printing error message?
>
>> +    }
>> +
>> +    fsdev_set_io_throttle(arg, &fse->fst, errp);
>> +}
>> +
>> +IOThrottleList *qmp_query_fsdev_io_throttle(Error **errp)
>> +{
>> +    IOThrottleList *head = NULL, *p_next;
>> +    struct FsDriverListEntry *fsle;
>> +    Error *local_err = NULL;
>> +
>> +    QTAILQ_FOREACH(fsle, &fsdriver_entries, next) {
>> +        p_next = g_malloc0(sizeof(*p_next));
>
> Okay, but you might want to consider g_new0(IOThrottleList) for a bit of
> extra type checking.
OK
>
>> +        fsdev_get_io_throttle(&fsle->fse.fst, &p_next->value,
>> +                            fsle->fse.fsdev_id, &local_err);
>
> Indentation is off.
Will fix
>
>> +        if (local_err) {
>> +            error_propagate(errp, local_err);
>> +            g_free(p_next);
>> +            qapi_free_IOThrottleList(head);
>> +            return NULL;
>> +        }
>> +
>> +        p_next->next = head;
>> +        head = p_next;
>> +    }
>> +    return head;
>> +}
>> diff --git a/monitor.c b/monitor.c
>> index 3c369f4..592a39e 100644
>> --- a/monitor.c
>> +++ b/monitor.c
>> @@ -997,6 +997,11 @@ static void qmp_unregister_commands_hack(void)
>>      && !defined(TARGET_S390X)
>>      qmp_unregister_command(&qmp_commands, "query-cpu-definitions");
>>  #endif
>> +#ifndef CONFIG_VIRTFS
>> +    qmp_unregister_command(&qmp_commands, "fsdev-set-io-throttle");
>> +    qmp_unregister_command(&qmp_commands, "query-fsdev-io-throttle");
>> +#endif
>> +
>>  }
>>
>>  void monitor_init_qmp_commands(void)
>> diff --git a/qapi-schema.json b/qapi-schema.json
>> index 4b50b65..dc676be 100644
>> --- a/qapi-schema.json
>> +++ b/qapi-schema.json
>> @@ -81,6 +81,9 @@
>>  # QAPI block definitions
>>  { 'include': 'qapi/block.json' }
>>
>> +# QAPI fsdev definitions
>> +{ 'include': 'qapi/fsdev.json' }
>> +
>>  # QAPI event definitions
>>  { 'include': 'qapi/event.json' }
>>
>> diff --git a/qapi/fsdev.json b/qapi/fsdev.json
>> new file mode 100644
>> index 0000000..eff1efe
>> --- /dev/null
>> +++ b/qapi/fsdev.json
>> @@ -0,0 +1,84 @@
>> +# -*- Mode: Python -*-
>> +
>> +##
>> +# == QAPI fsdev definitions
>> +##
>> +
>> +# QAPI common definitions
>> +{ 'include': 'iothrottle.json' }
>> +
>> +##
>> +# @fsdev-set-io-throttle:
>> +#
>> +# Change I/O limits for a 9p/fsdev device.
>> +#
>> +# I/O limits can be enabled by setting throttle value to non-zero number.
>> +#
>> +# I/O limits can be disabled by setting all throttle values to 0.
>> +#
>> +# Returns: Nothing on success
>> +#          If @device is not a valid fsdev device, DeviceNotFound
>
> Aha, qmp_fsdev_set_io_throttle()'s early return should be an error!
> Make it GenericError rather than DeviceNotFound, please; just use
> error_setg().
ok
>
>> +#
>> +# Since: 2.10
>> +#
>> +# Example:
>> +#
>> +# -> { "execute": "fsdev-set-io-throttle",
>> +#      "arguments": { "id": "id0-1-0",
>> +#                     "bps": 1000000,
>> +#                     "bps_rd": 0,
>> +#                     "bps_wr": 0,
>> +#                     "iops": 0,
>> +#                     "iops_rd": 0,
>> +#                     "iops_wr": 0,
>> +#                     "bps_max": 8000000,
>> +#                     "bps_rd_max": 0,
>> +#                     "bps_wr_max": 0,
>> +#                     "iops_max": 0,
>> +#                     "iops_rd_max": 0,
>> +#                     "iops_wr_max": 0,
>> +#                     "bps_max_length": 60,
>> +#                     "iops_size": 0 } }
>> +# <- { "returns": {} }
>> +##
>> +{ 'command': 'fsdev-set-io-throttle', 'boxed': true,
>> +  'data': 'IOThrottle' }
>> +##
>> +# @query-fsdev-io-throttle:
>> +#
>> +# Returns: a list of @IOThrottle describing io throttle values of each fsdev device
>
> "io" is not a word, make it "I/O".  Also: long line.  Please wrap your
> comment lines around column 70.
ok
>
>> +#
>> +# Since: 2.10
>> +#
>> +# Example:
>> +#
>> +# -> { "Execute": "query-fsdev-io-throttle" }
>> +# <- { "returns" : [
>> +#          {
>> +#             "id": "id0-hd0",
>
> Indentation is off again.
ok
>
>> +#              "bps":1000000,
>> +#              "bps_rd":0,
>> +#              "bps_wr":0,
>> +#              "iops":1000000,
>> +#              "iops_rd":0,
>> +#              "iops_wr":0,
>> +#              "bps_max": 8000000,
>> +#              "bps_rd_max": 0,
>> +#              "bps_wr_max": 0,
>> +#              "iops_max": 0,
>> +#              "iops_rd_max": 0,
>> +#              "iops_wr_max": 0,
>> +#              "bps_max_length": 0,
>> +#              "bps_rd_max_length": 0,
>> +#              "bps_wr_max_length": 0,
>> +#              "iops_max_length": 0,
>> +#              "iops_rd_max_length": 0,
>> +#              "iops_wr_max_length": 0,
>> +#              "iops_size": 0
>> +#            }
>> +#          ]
>> +#      }
>> +#
>> +##
>> +{ 'command': 'query-fsdev-io-throttle', 'returns': [ 'IOThrottle' ] }
>> +
>
> Trailing blank line.
>
Removed
>> diff --git a/qmp.c b/qmp.c
>> index 7ee9bcf..8a60f2c 100644
>> --- a/qmp.c
>> +++ b/qmp.c
>> @@ -130,6 +130,20 @@ void qmp_cpu_add(int64_t id, Error **errp)
>>      }
>>  }
>>
>> +#if defined(_WIN64) || defined(_WIN32) || defined(__FreeBSD__)
>> +
>> +void qmp_fsdev_set_io_throttle(IOThrottle *arg, Error **errp)
>> +{
>> +  return;
>
> Indentation is off.
ok
>
>> +}
>> +
>> +IOThrottleList *qmp_query_fsdev_io_throttle(Error **errp)
>> +{
>> +    abort();
>> +}
>> +
>> +#endif
>> +
>
> Why do you need stubs both here and in fsdev/qemu-fsdev-dummy.c?
Had compilation issues, as explained above, while compiling on different 
pltforms.

-Pradeep

>
>>  #ifndef CONFIG_VNC
>>  /* If VNC support is enabled, the "true" query-vnc command is
>>     defined in the VNC subsystem */
