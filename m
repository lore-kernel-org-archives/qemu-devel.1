Received: from eggs.gnu.org ([2001:4830:134:3::10]:59527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dNb7N-0003eB-2d
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 04:36:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dNb7J-0005CC-TC
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 04:36:05 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:15100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dNb7J-00058o-EN
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 04:36:01 -0400
References: <1497877896-35700-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1497877896-35700-4-git-send-email-pradeep.jagadeesh@huawei.com>
	<20170620180516.143c5359@bahia.lab.toulouse-stg.fr.ibm.com>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <e44687fa-cc7a-8299-6abe-84ee59b9380e@huawei.com>
Date: Wed, 21 Jun 2017 10:34:42 +0200
MIME-Version: 1.0
In-Reply-To: <20170620180516.143c5359@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 3/5] qmp: refactor duplicate code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Cc: eric blake <eblake@redhat.com>, alberto garcia <berto@igalia.com>, jani
	kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org, Markus
	Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 6/20/2017 6:05 PM, Greg Kurz wrote:
> On Mon, 19 Jun 2017 09:11:34 -0400
> Pradeep Jagadeesh <pradeepkiruvale@gmail.com> wrote:
>
>> This patch factor out the duplicate qmp throttle interface code
>> that was present in both block and fsdev device files.
>>
>
> The text is obviously wrong. I don't see any duplicate code below.
OK, I will fix this.
>
> It is more something like: let's factor out the code that will be used
> by the existing QMP throttling API for block devices and the future
> QMP throttling API for fs devices.
>
> Please move the HMP part to another patch, as asked during v4 review.
I have moved the hmp patches for the fsdev into a separate patch. Do you 
want me to push this also into a separate patch?
>
> Also, blockdev.c and hmp.c do have maintainers. You should Cc: them each
> time because they know better than me and even if these patches are carried
> through my tree, I won't do it without an ack from them.

OK, I will add them next time on.

-Pradeep

> Cc'ing Markus for blockdev.c and David for hmp.c.
>
>> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
>> ---
>>  blockdev.c                      | 53 +++---------------------------------
>>  hmp.c                           | 21 ++++++++++-----
>>  include/qemu/throttle-options.h |  3 +++
>>  util/throttle.c                 | 60 +++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 81 insertions(+), 56 deletions(-)
>>
>> diff --git a/blockdev.c b/blockdev.c
>> index 5db9e5c..3d06e9e 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -2593,6 +2593,7 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
>>      BlockDriverState *bs;
>>      BlockBackend *blk;
>>      AioContext *aio_context;
>> +    IOThrottle *iothrottle;
>>
>>      blk = qmp_get_blk(arg->has_device ? arg->device : NULL,
>>                        arg->has_id ? arg->id : NULL,
>> @@ -2610,56 +2611,8 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
>>          goto out;
>>      }
>>
>> -    throttle_config_init(&cfg);
>> -    cfg.buckets[THROTTLE_BPS_TOTAL].avg = arg->bps;
>> -    cfg.buckets[THROTTLE_BPS_READ].avg  = arg->bps_rd;
>> -    cfg.buckets[THROTTLE_BPS_WRITE].avg = arg->bps_wr;
>> -
>> -    cfg.buckets[THROTTLE_OPS_TOTAL].avg = arg->iops;
>> -    cfg.buckets[THROTTLE_OPS_READ].avg  = arg->iops_rd;
>> -    cfg.buckets[THROTTLE_OPS_WRITE].avg = arg->iops_wr;
>> -
>> -    if (arg->has_bps_max) {
>> -        cfg.buckets[THROTTLE_BPS_TOTAL].max = arg->bps_max;
>> -    }
>> -    if (arg->has_bps_rd_max) {
>> -        cfg.buckets[THROTTLE_BPS_READ].max = arg->bps_rd_max;
>> -    }
>> -    if (arg->has_bps_wr_max) {
>> -        cfg.buckets[THROTTLE_BPS_WRITE].max = arg->bps_wr_max;
>> -    }
>> -    if (arg->has_iops_max) {
>> -        cfg.buckets[THROTTLE_OPS_TOTAL].max = arg->iops_max;
>> -    }
>> -    if (arg->has_iops_rd_max) {
>> -        cfg.buckets[THROTTLE_OPS_READ].max = arg->iops_rd_max;
>> -    }
>> -    if (arg->has_iops_wr_max) {
>> -        cfg.buckets[THROTTLE_OPS_WRITE].max = arg->iops_wr_max;
>> -    }
>> -
>> -    if (arg->has_bps_max_length) {
>> -        cfg.buckets[THROTTLE_BPS_TOTAL].burst_length = arg->bps_max_length;
>> -    }
>> -    if (arg->has_bps_rd_max_length) {
>> -        cfg.buckets[THROTTLE_BPS_READ].burst_length = arg->bps_rd_max_length;
>> -    }
>> -    if (arg->has_bps_wr_max_length) {
>> -        cfg.buckets[THROTTLE_BPS_WRITE].burst_length = arg->bps_wr_max_length;
>> -    }
>> -    if (arg->has_iops_max_length) {
>> -        cfg.buckets[THROTTLE_OPS_TOTAL].burst_length = arg->iops_max_length;
>> -    }
>> -    if (arg->has_iops_rd_max_length) {
>> -        cfg.buckets[THROTTLE_OPS_READ].burst_length = arg->iops_rd_max_length;
>> -    }
>> -    if (arg->has_iops_wr_max_length) {
>> -        cfg.buckets[THROTTLE_OPS_WRITE].burst_length = arg->iops_wr_max_length;
>> -    }
>> -
>> -    if (arg->has_iops_size) {
>> -        cfg.op_size = arg->iops_size;
>> -    }
>> +    iothrottle = qapi_BlockIOThrottle_base(arg);
>> +    throttle_set_io_limits(&cfg, iothrottle);
>>
>>      if (!throttle_is_valid(&cfg, errp)) {
>>          goto out;
>> diff --git a/hmp.c b/hmp.c
>> index 8c72c58..220d301 100644
>> --- a/hmp.c
>> +++ b/hmp.c
>> @@ -1749,20 +1749,29 @@ void hmp_change(Monitor *mon, const QDict *qdict)
>>      hmp_handle_error(mon, &err);
>>  }
>>
>> +static void hmp_initialize_io_throttle(IOThrottle *iot, const QDict *qdict)
>> +{
>> +    iot->has_id = true;
>> +    iot->id = (char *) qdict_get_str(qdict, "id");
>> +    iot->bps = qdict_get_int(qdict, "bps");
>> +    iot->bps_rd = qdict_get_int(qdict, "bps_rd");
>> +    iot->bps_wr = qdict_get_int(qdict, "bps_wr");
>> +    iot->iops = qdict_get_int(qdict, "iops");
>> +    iot->iops_rd = qdict_get_int(qdict, "iops_rd");
>> +    iot->iops_wr = qdict_get_int(qdict, "iops_wr");
>> +}
>> +
>>  void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)
>>  {
>>      Error *err = NULL;
>> +    IOThrottle *iothrottle;
>>      BlockIOThrottle throttle = {
>>          .has_device = true,
>>          .device = (char *) qdict_get_str(qdict, "device"),
>> -        .bps = qdict_get_int(qdict, "bps"),
>> -        .bps_rd = qdict_get_int(qdict, "bps_rd"),
>> -        .bps_wr = qdict_get_int(qdict, "bps_wr"),
>> -        .iops = qdict_get_int(qdict, "iops"),
>> -        .iops_rd = qdict_get_int(qdict, "iops_rd"),
>> -        .iops_wr = qdict_get_int(qdict, "iops_wr"),
>>      };
>>
>> +    iothrottle = qapi_BlockIOThrottle_base(&throttle);
>> +    hmp_initialize_io_throttle(iothrottle, qdict);
>>      qmp_block_set_io_throttle(&throttle, &err);
>>      hmp_handle_error(mon, &err);
>>  }
>> diff --git a/include/qemu/throttle-options.h b/include/qemu/throttle-options.h
>> index 565553a..e94ea39 100644
>> --- a/include/qemu/throttle-options.h
>> +++ b/include/qemu/throttle-options.h
>> @@ -11,6 +11,7 @@
>>  #define THROTTLE_OPTIONS_H
>>
>>  #include "qemu/throttle.h"
>> +#include "qmp-commands.h"
>>
>>  #define THROTTLE_OPTS \
>>            { \
>> @@ -93,4 +94,6 @@
>>
>>  void throttle_parse_options(ThrottleConfig *, QemuOpts *);
>>
>> +void throttle_set_io_limits(ThrottleConfig *, IOThrottle *);
>> +
>>  #endif
>> diff --git a/util/throttle.c b/util/throttle.c
>> index ebe9dd0..2cf9ec5 100644
>> --- a/util/throttle.c
>> +++ b/util/throttle.c
>> @@ -27,6 +27,7 @@
>>  #include "qemu/throttle.h"
>>  #include "qemu/timer.h"
>>  #include "block/aio.h"
>> +#include "qemu/throttle-options.h"
>>
>>  /* This function make a bucket leak
>>   *
>> @@ -564,3 +565,62 @@ void throttle_parse_options(ThrottleConfig *throttle_cfg, QemuOpts *opts)
>>      throttle_cfg->op_size =
>>          qemu_opt_get_number(opts, "throttling.iops-size", 0);
>>  }
>> +
>> +/* set the throttle limits
>> + *
>> + * @arg: iothrottle limits
>> + * @cfg: throttle configuration
>> + */
>> +void throttle_set_io_limits(ThrottleConfig *cfg, IOThrottle *arg)
>> +{
>> +    throttle_config_init(cfg);
>> +    cfg->buckets[THROTTLE_BPS_TOTAL].avg = arg->bps;
>> +    cfg->buckets[THROTTLE_BPS_READ].avg  = arg->bps_rd;
>> +    cfg->buckets[THROTTLE_BPS_WRITE].avg = arg->bps_wr;
>> +
>> +    cfg->buckets[THROTTLE_OPS_TOTAL].avg = arg->iops;
>> +    cfg->buckets[THROTTLE_OPS_READ].avg  = arg->iops_rd;
>> +    cfg->buckets[THROTTLE_OPS_WRITE].avg = arg->iops_wr;
>> +
>> +    if (arg->has_bps_max) {
>> +        cfg->buckets[THROTTLE_BPS_TOTAL].max = arg->bps_max;
>> +    }
>> +    if (arg->has_bps_rd_max) {
>> +        cfg->buckets[THROTTLE_BPS_READ].max = arg->bps_rd_max;
>> +    }
>> +    if (arg->has_bps_wr_max) {
>> +        cfg->buckets[THROTTLE_BPS_WRITE].max = arg->bps_wr_max;
>> +    }
>> +    if (arg->has_iops_max) {
>> +        cfg->buckets[THROTTLE_OPS_TOTAL].max = arg->iops_max;
>> +    }
>> +    if (arg->has_iops_rd_max) {
>> +        cfg->buckets[THROTTLE_OPS_READ].max = arg->iops_rd_max;
>> +    }
>> +    if (arg->has_iops_wr_max) {
>> +        cfg->buckets[THROTTLE_OPS_WRITE].max = arg->iops_wr_max;
>> +    }
>> +
>> +    if (arg->has_bps_max_length) {
>> +        cfg->buckets[THROTTLE_BPS_TOTAL].burst_length = arg->bps_max_length;
>> +    }
>> +    if (arg->has_bps_rd_max_length) {
>> +        cfg->buckets[THROTTLE_BPS_READ].burst_length = arg->bps_rd_max_length;
>> +    }
>> +    if (arg->has_bps_wr_max_length) {
>> +        cfg->buckets[THROTTLE_BPS_WRITE].burst_length = arg->bps_wr_max_length;
>> +    }
>> +    if (arg->has_iops_max_length) {
>> +        cfg->buckets[THROTTLE_OPS_TOTAL].burst_length = arg->iops_max_length;
>> +    }
>> +    if (arg->has_iops_rd_max_length) {
>> +        cfg->buckets[THROTTLE_OPS_READ].burst_length = arg->iops_rd_max_length;
>> +    }
>> +    if (arg->has_iops_wr_max_length) {
>> +        cfg->buckets[THROTTLE_OPS_WRITE].burst_length = arg->iops_wr_max_length;
>> +    }
>> +
>> +    if (arg->has_iops_size) {
>> +        cfg->op_size = arg->iops_size;
>> +    }
>> +}
>
