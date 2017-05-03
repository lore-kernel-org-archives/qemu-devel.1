Received: from eggs.gnu.org ([2001:4830:134:3::10]:59982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1d5wP3-0000eP-LP
	for qemu-devel@nongnu.org; Wed, 03 May 2017 11:41:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1d5wOy-00007W-UP
	for qemu-devel@nongnu.org; Wed, 03 May 2017 11:41:21 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:12723)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1d5wOy-00006V-Ib
	for qemu-devel@nongnu.org; Wed, 03 May 2017 11:41:16 -0400
References: <1493735386-39622-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1493735386-39622-3-git-send-email-pradeep.jagadeesh@huawei.com>
	<4ccaf863-4c73-e168-3c09-c916a6aaa75e@redhat.com>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <25938992-bdea-4f0c-0b9c-0467b8684b98@huawei.com>
Date: Wed, 3 May 2017 17:40:56 +0200
MIME-Version: 1.0
In-Reply-To: <4ccaf863-4c73-e168-3c09-c916a6aaa75e@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/4] fsdev: QMP interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: alberto garcia <berto@igalia.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

On 5/3/2017 12:13 AM, Eric Blake wrote:
> On 05/02/2017 09:29 AM, Pradeep Jagadeesh wrote:
>> This patchset enables qmp interfaces for the fsdev
>> devices. This provides two interfaces one
>> for querying info of all the fsdev devices. The second one
>> to set the IO limits for the required fsdev device.
>>
>> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
>> ---
>
>> +++ b/fsdev/qemu-fsdev-throttle.c
>> @@ -29,6 +29,102 @@ static void fsdev_throttle_write_timer_cb(void *opaque)
>>      qemu_co_enter_next(&fst->throttled_reqs[true]);
>>  }
>>
>> +void fsdev_set_io_throttle(IOThrottle *arg, FsThrottle *fst, Error **errp)
>> +{
>> +    ThrottleConfig cfg;
>> +
>> +    throttle_config_init(&cfg);
>> +    cfg.buckets[THROTTLE_BPS_TOTAL].avg = arg->bps;
>> +    cfg.buckets[THROTTLE_BPS_READ].avg  = arg->bps_rd;
>> +    cfg.buckets[THROTTLE_BPS_WRITE].avg = arg->bps_wr;
>> +
>> +    cfg.buckets[THROTTLE_OPS_TOTAL].avg = arg->iops;
>> +    cfg.buckets[THROTTLE_OPS_READ].avg  = arg->iops_rd;
>> +    cfg.buckets[THROTTLE_OPS_WRITE].avg = arg->iops_wr;
>> +
>> +    if (arg->has_bps_max) {
>> +        cfg.buckets[THROTTLE_BPS_TOTAL].max = arg->bps_max;
>> +    }
>
> Should the bulk of this be replaced by a call to a common IOThrottle
> helper function, rather than open-coded duplication?
If we can reduce the duplicate code with a helper function its a good 
idea. But I can not think of any ways of doing it. Any suggestions?
>
>
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
>
> Shouldn't you be setting has_bps, has_bps_rd, has_bps_wr, and so on, to
> true?
Yes, I need to set, but its only for max values, I mean has_bps_max..etc
>
>
>> +++ b/fsdev/qemu-fsdev-throttle.h
>> @@ -19,7 +19,14 @@
>>  #include "qemu/main-loop.h"
>>  #include "qemu/coroutine.h"
>>  #include "qapi/error.h"
>> +#include "qapi/qmp/qerror.h"
>>  #include "qemu/throttle.h"
>> +#include "qapi/qmp/types.h"
>> +#include "qapi-visit.h"
>> +#include "qapi/qobject-output-visitor.h"
>> +#include "qapi/util.h"
>> +#include "qmp-commands.h"
>> +#include "qemu/throttle-options.h"
>>
>>  typedef struct FsThrottle {
>>      ThrottleState ts;
>> @@ -36,4 +43,10 @@ void coroutine_fn fsdev_co_throttle_request(FsThrottle *, bool ,
>>                                              struct iovec *, int);
>>
>>  void fsdev_throttle_cleanup(FsThrottle *);
>> +
>> +void fsdev_set_io_throttle(IOThrottle *, FsThrottle *, Error **);
>
> Even though it's not necessary per C, we tend to spell parameter names
> in function declarations as it aids legibility.  (Seeing 'Error **' is
> weird compared to the usual 'Error **errp')
OK, I will fix it.
>
>
>> @@ -1570,6 +1571,80 @@ void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)
>>      hmp_handle_error(mon, &err);
>>  }
>>
>> +#ifdef CONFIG_VIRTFS
>> +
>> +void hmp_fsdev_set_io_throttle(Monitor *mon, const QDict *qdict)
>> +{
>> +    Error *err = NULL;
>> +    IOThrottle throttle = {
>> +        .has_id = true,
>> +        .id = (char *) qdict_get_str(qdict, "id"),
>> +        .bps = qdict_get_int(qdict, "bps"),
>> +        .bps_rd = qdict_get_int(qdict, "bps_rd"),
>> +        .bps_wr = qdict_get_int(qdict, "bps_wr"),
>> +        .iops = qdict_get_int(qdict, "iops"),
>> +        .iops_rd = qdict_get_int(qdict, "iops_rd"),
>> +        .iops_wr = qdict_get_int(qdict, "iops_wr"),
>
> Again, don't you need to be setting .has_bps=true and so on?
Same as above. I have not set any max burst values here, because I 
wanted to keep it in line with the block device.
May be there is a room to enable these max values in both in future.
>
>
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
>
> This part looks okay.
>
>> +##
>> +# @query-fsdev-io-throttle:
>> +#
>> +# Returns: a list of @IOThrottle describing io throttle values of each fsdev device
>> +#
>> +# Since: 2.10
>> +#
>> +# Example:
>> +#
>> +# -> { "Execute": "query-fsdev-io-throttle" }
>> +# <- { "returns" : [
>> +#          {
>> +#             "id": "id0-hd0",
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
>> diff --git a/qapi/iothrottle.json b/qapi/iothrottle.json
>> index 124ab40..698d4bc 100644
>> --- a/qapi/iothrottle.json
>> +++ b/qapi/iothrottle.json
>> @@ -3,6 +3,7 @@
>>  ##
>>  # == QAPI IOThrottle definitions
>>  ##
>> +##
>>  # @IOThrottle:
>
> This looks like a spurious change
You mean the below sentence is not required?
I will remove it. Its not really required.
>
>>  #
>>  # A set of parameters describing iothrottle
>>
>
