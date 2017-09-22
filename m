Received: from eggs.gnu.org ([2001:4830:134:3::10]:40244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dvMCq-0002ZI-Cp
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:33:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dvMCn-0003R7-3R
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:33:16 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:24362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dvMCm-0003PI-LJ
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:33:13 -0400
References: <1505385610-35529-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1505385610-35529-2-git-send-email-pradeep.jagadeesh@huawei.com>
	<20170918162033.ee7fuarojpkwp5wr@postretch>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <209dd16d-8d97-090d-35e9-b355c53c3448@huawei.com>
Date: Fri, 22 Sep 2017 13:31:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170918162033.ee7fuarojpkwp5wr@postretch>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 1/6] throttle: factor out duplicate code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>, qemu-devel@nongnu.org, jani kokkonen <jani.kokkonen@huawei.com>, alberto garcia <berto@igalia.com>, Markus
	Armbruster <armbru@redhat.com>

On 9/18/2017 6:20 PM, Manos Pitsidianakis wrote:
> On Thu, Sep 14, 2017 at 06:40:05AM -0400, Pradeep Jagadeesh wrote:
>> This patch factors out the duplicate throttle code that was still
>> present in block and fsdev devices.
>>
>> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>> Reviewed-by: Greg Kurz <groug@kaod.org>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> ---
>> blockdev.c                      | 44 +---------------------------------
>> fsdev/qemu-fsdev-throttle.c     | 44 ++--------------------------------
>> include/qemu/throttle-options.h |  3 +++
>> include/qemu/throttle.h         |  4 ++--
>> include/qemu/typedefs.h         |  1 +
>> util/throttle.c                 | 52
>> +++++++++++++++++++++++++++++++++++++++++
>> 6 files changed, 61 insertions(+), 87 deletions(-)
>>
>> diff --git a/blockdev.c b/blockdev.c
>> index 56a6b24..9d33c25 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -387,49 +387,7 @@ static void
>> extract_common_blockdev_options(QemuOpts *opts, int *bdrv_flags,
>>     }
>>
>>     if (throttle_cfg) {
>> -        throttle_config_init(throttle_cfg);
>> -        throttle_cfg->buckets[THROTTLE_BPS_TOTAL].avg =
>> -            qemu_opt_get_number(opts, "throttling.bps-total", 0);
>> -        throttle_cfg->buckets[THROTTLE_BPS_READ].avg  =
>> -            qemu_opt_get_number(opts, "throttling.bps-read", 0);
>> -        throttle_cfg->buckets[THROTTLE_BPS_WRITE].avg =
>> -            qemu_opt_get_number(opts, "throttling.bps-write", 0);
>> -        throttle_cfg->buckets[THROTTLE_OPS_TOTAL].avg =
>> -            qemu_opt_get_number(opts, "throttling.iops-total", 0);
>> -        throttle_cfg->buckets[THROTTLE_OPS_READ].avg =
>> -            qemu_opt_get_number(opts, "throttling.iops-read", 0);
>> -        throttle_cfg->buckets[THROTTLE_OPS_WRITE].avg =
>> -            qemu_opt_get_number(opts, "throttling.iops-write", 0);
>> -
>> -        throttle_cfg->buckets[THROTTLE_BPS_TOTAL].max =
>> -            qemu_opt_get_number(opts, "throttling.bps-total-max", 0);
>> -        throttle_cfg->buckets[THROTTLE_BPS_READ].max  =
>> -            qemu_opt_get_number(opts, "throttling.bps-read-max", 0);
>> -        throttle_cfg->buckets[THROTTLE_BPS_WRITE].max =
>> -            qemu_opt_get_number(opts, "throttling.bps-write-max", 0);
>> -        throttle_cfg->buckets[THROTTLE_OPS_TOTAL].max =
>> -            qemu_opt_get_number(opts, "throttling.iops-total-max", 0);
>> -        throttle_cfg->buckets[THROTTLE_OPS_READ].max =
>> -            qemu_opt_get_number(opts, "throttling.iops-read-max", 0);
>> -        throttle_cfg->buckets[THROTTLE_OPS_WRITE].max =
>> -            qemu_opt_get_number(opts, "throttling.iops-write-max", 0);
>> -
>> -        throttle_cfg->buckets[THROTTLE_BPS_TOTAL].burst_length =
>> -            qemu_opt_get_number(opts,
>> "throttling.bps-total-max-length", 1);
>> -        throttle_cfg->buckets[THROTTLE_BPS_READ].burst_length  =
>> -            qemu_opt_get_number(opts,
>> "throttling.bps-read-max-length", 1);
>> -        throttle_cfg->buckets[THROTTLE_BPS_WRITE].burst_length =
>> -            qemu_opt_get_number(opts,
>> "throttling.bps-write-max-length", 1);
>> -        throttle_cfg->buckets[THROTTLE_OPS_TOTAL].burst_length =
>> -            qemu_opt_get_number(opts,
>> "throttling.iops-total-max-length", 1);
>> -        throttle_cfg->buckets[THROTTLE_OPS_READ].burst_length =
>> -            qemu_opt_get_number(opts,
>> "throttling.iops-read-max-length", 1);
>> -        throttle_cfg->buckets[THROTTLE_OPS_WRITE].burst_length =
>> -            qemu_opt_get_number(opts,
>> "throttling.iops-write-max-length", 1);
>> -
>> -        throttle_cfg->op_size =
>> -            qemu_opt_get_number(opts, "throttling.iops-size", 0);
>> -
>> +        throttle_parse_options(throttle_cfg, opts);
>>         if (!throttle_is_valid(throttle_cfg, errp)) {
>>             return;
>>         }
>> diff --git a/fsdev/qemu-fsdev-throttle.c b/fsdev/qemu-fsdev-throttle.c
>> index 49eebb5..0e6fb86 100644
>> --- a/fsdev/qemu-fsdev-throttle.c
>> +++ b/fsdev/qemu-fsdev-throttle.c
>> @@ -16,6 +16,7 @@
>> #include "qemu/error-report.h"
>> #include "qemu-fsdev-throttle.h"
>> #include "qemu/iov.h"
>> +#include "qemu/throttle-options.h"
>>
>> static void fsdev_throttle_read_timer_cb(void *opaque)
>> {
>> @@ -31,48 +32,7 @@ static void fsdev_throttle_write_timer_cb(void
>> *opaque)
>>
>> void fsdev_throttle_parse_opts(QemuOpts *opts, FsThrottle *fst, Error
>> **errp)
>> {
>> -    throttle_config_init(&fst->cfg);
>> -    fst->cfg.buckets[THROTTLE_BPS_TOTAL].avg =
>> -        qemu_opt_get_number(opts, "throttling.bps-total", 0);
>> -    fst->cfg.buckets[THROTTLE_BPS_READ].avg  =
>> -        qemu_opt_get_number(opts, "throttling.bps-read", 0);
>> -    fst->cfg.buckets[THROTTLE_BPS_WRITE].avg =
>> -        qemu_opt_get_number(opts, "throttling.bps-write", 0);
>> -    fst->cfg.buckets[THROTTLE_OPS_TOTAL].avg =
>> -        qemu_opt_get_number(opts, "throttling.iops-total", 0);
>> -    fst->cfg.buckets[THROTTLE_OPS_READ].avg =
>> -        qemu_opt_get_number(opts, "throttling.iops-read", 0);
>> -    fst->cfg.buckets[THROTTLE_OPS_WRITE].avg =
>> -        qemu_opt_get_number(opts, "throttling.iops-write", 0);
>> -
>> -    fst->cfg.buckets[THROTTLE_BPS_TOTAL].max =
>> -        qemu_opt_get_number(opts, "throttling.bps-total-max", 0);
>> -    fst->cfg.buckets[THROTTLE_BPS_READ].max  =
>> -        qemu_opt_get_number(opts, "throttling.bps-read-max", 0);
>> -    fst->cfg.buckets[THROTTLE_BPS_WRITE].max =
>> -        qemu_opt_get_number(opts, "throttling.bps-write-max", 0);
>> -    fst->cfg.buckets[THROTTLE_OPS_TOTAL].max =
>> -        qemu_opt_get_number(opts, "throttling.iops-total-max", 0);
>> -    fst->cfg.buckets[THROTTLE_OPS_READ].max =
>> -        qemu_opt_get_number(opts, "throttling.iops-read-max", 0);
>> -    fst->cfg.buckets[THROTTLE_OPS_WRITE].max =
>> -        qemu_opt_get_number(opts, "throttling.iops-write-max", 0);
>> -
>> -    fst->cfg.buckets[THROTTLE_BPS_TOTAL].burst_length =
>> -        qemu_opt_get_number(opts, "throttling.bps-total-max-length", 1);
>> -    fst->cfg.buckets[THROTTLE_BPS_READ].burst_length  =
>> -        qemu_opt_get_number(opts, "throttling.bps-read-max-length", 1);
>> -    fst->cfg.buckets[THROTTLE_BPS_WRITE].burst_length =
>> -        qemu_opt_get_number(opts, "throttling.bps-write-max-length", 1);
>> -    fst->cfg.buckets[THROTTLE_OPS_TOTAL].burst_length =
>> -        qemu_opt_get_number(opts, "throttling.iops-total-max-length",
>> 1);
>> -    fst->cfg.buckets[THROTTLE_OPS_READ].burst_length =
>> -        qemu_opt_get_number(opts, "throttling.iops-read-max-length", 1);
>> -    fst->cfg.buckets[THROTTLE_OPS_WRITE].burst_length =
>> -        qemu_opt_get_number(opts, "throttling.iops-write-max-length",
>> 1);
>> -    fst->cfg.op_size =
>> -        qemu_opt_get_number(opts, "throttling.iops-size", 0);
>> -
>> +    throttle_parse_options(&fst->cfg, opts);
>>     throttle_is_valid(&fst->cfg, errp);
>> }
>>
>> diff --git a/include/qemu/throttle-options.h
>> b/include/qemu/throttle-options.h
>> index 3528a8f..9709dcd 100644
>> --- a/include/qemu/throttle-options.h
>> +++ b/include/qemu/throttle-options.h
>> @@ -9,6 +9,7 @@
>>  */
>> #ifndef THROTTLE_OPTIONS_H
>> #define THROTTLE_OPTIONS_H
>> +#include "typedefs.h"
>>
>> #define QEMU_OPT_IOPS_TOTAL "iops-total"
>> #define QEMU_OPT_IOPS_TOTAL_MAX "iops-total-max"
>> @@ -111,4 +112,6 @@
>>             .help = "when limiting by iops max size of an I/O in bytes",\
>>         }
>>
>> +void throttle_parse_options(ThrottleConfig *, QemuOpts *);
>> +
>> #endif
>> diff --git a/include/qemu/throttle.h b/include/qemu/throttle.h
>> index 8c93237..b6ebc6d 100644
>> --- a/include/qemu/throttle.h
>> +++ b/include/qemu/throttle.h
>> @@ -89,10 +89,10 @@ typedef struct LeakyBucket {
>>  * However it allows to keep the code clean and the bucket field is
>> reset to
>>  * zero at the right time.
>>  */
>> -typedef struct ThrottleConfig {
>> +struct ThrottleConfig {
>>     LeakyBucket buckets[BUCKETS_COUNT]; /* leaky buckets */
>>     uint64_t op_size;         /* size of an operation in bytes */
>> -} ThrottleConfig;
>> +};
>>
>> typedef struct ThrottleState {
>>     ThrottleConfig cfg;       /* configuration */
>> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
>> index 39bc835..90fe0f9 100644
>> --- a/include/qemu/typedefs.h
>> +++ b/include/qemu/typedefs.h
>> @@ -100,6 +100,7 @@ typedef struct uWireSlave uWireSlave;
>> typedef struct VirtIODevice VirtIODevice;
>> typedef struct Visitor Visitor;
>> typedef struct node_info NodeInfo;
>> +typedef struct ThrottleConfig ThrottleConfig;
>
> Is this really needed? Just include include/qemu/throttle.h wherever you
> need.
>
>> typedef void SaveStateHandler(QEMUFile *f, void *opaque);
>> typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_id);
>>
>> diff --git a/util/throttle.c b/util/throttle.c
>> index 06bf916..9ef28c4 100644
>> --- a/util/throttle.c
>> +++ b/util/throttle.c
>> @@ -27,6 +27,7 @@
>> #include "qemu/throttle.h"
>> #include "qemu/timer.h"
>> #include "block/aio.h"
>> +#include "qemu/throttle-options.h"
>>
>> /* This function make a bucket leak
>>  *
>> @@ -635,3 +636,54 @@ void throttle_config_to_limits(ThrottleConfig
>> *cfg, ThrottleLimits *var)
>>     var->has_iops_write_max_length = true;
>>     var->has_iops_size = true;
>> }
>> +
>> +/* parse the throttle options
>> + *
>> + * @opts: qemu options
>> + * @throttle_cfg: throttle configuration
>> + */
>> +void throttle_parse_options(ThrottleConfig *throttle_cfg, QemuOpts
>> *opts)
>> +{
>> +    throttle_config_init(throttle_cfg);
>> +    throttle_cfg->buckets[THROTTLE_BPS_TOTAL].avg =
>> +        qemu_opt_get_number(opts, "throttling.bps-total", 0);
>> +    throttle_cfg->buckets[THROTTLE_BPS_READ].avg  =
>> +        qemu_opt_get_number(opts, "throttling.bps-read", 0);
>> +    throttle_cfg->buckets[THROTTLE_BPS_WRITE].avg =
>> +        qemu_opt_get_number(opts, "throttling.bps-write", 0);
>> +    throttle_cfg->buckets[THROTTLE_OPS_TOTAL].avg =
>> +        qemu_opt_get_number(opts, "throttling.iops-total", 0);
>> +    throttle_cfg->buckets[THROTTLE_OPS_READ].avg =
>> +        qemu_opt_get_number(opts, "throttling.iops-read", 0);
>> +    throttle_cfg->buckets[THROTTLE_OPS_WRITE].avg =
>> +        qemu_opt_get_number(opts, "throttling.iops-write", 0);
>> +
>> +    throttle_cfg->buckets[THROTTLE_BPS_TOTAL].max =
>> +        qemu_opt_get_number(opts, "throttling.bps-total-max", 0);
>> +    throttle_cfg->buckets[THROTTLE_BPS_READ].max  =
>> +        qemu_opt_get_number(opts, "throttling.bps-read-max", 0);
>> +    throttle_cfg->buckets[THROTTLE_BPS_WRITE].max =
>> +        qemu_opt_get_number(opts, "throttling.bps-write-max", 0);
>> +    throttle_cfg->buckets[THROTTLE_OPS_TOTAL].max =
>> +        qemu_opt_get_number(opts, "throttling.iops-total-max", 0);
>> +    throttle_cfg->buckets[THROTTLE_OPS_READ].max =
>> +        qemu_opt_get_number(opts, "throttling.iops-read-max", 0);
>> +    throttle_cfg->buckets[THROTTLE_OPS_WRITE].max =
>> +        qemu_opt_get_number(opts, "throttling.iops-write-max", 0);
>> +
>> +    throttle_cfg->buckets[THROTTLE_BPS_TOTAL].burst_length =
>> +        qemu_opt_get_number(opts, "throttling.bps-total-max-length", 1);
>> +    throttle_cfg->buckets[THROTTLE_BPS_READ].burst_length  =
>> +        qemu_opt_get_number(opts, "throttling.bps-read-max-length", 1);
>> +    throttle_cfg->buckets[THROTTLE_BPS_WRITE].burst_length =
>> +        qemu_opt_get_number(opts, "throttling.bps-write-max-length", 1);
>> +    throttle_cfg->buckets[THROTTLE_OPS_TOTAL].burst_length =
>> +        qemu_opt_get_number(opts, "throttling.iops-total-max-length",
>> 1);
>> +    throttle_cfg->buckets[THROTTLE_OPS_READ].burst_length =
>> +        qemu_opt_get_number(opts, "throttling.iops-read-max-length", 1);
>> +    throttle_cfg->buckets[THROTTLE_OPS_WRITE].burst_length =
>> +        qemu_opt_get_number(opts, "throttling.iops-write-max-length",
>> 1);
>> +
>> +    throttle_cfg->op_size =
>> +        qemu_opt_get_number(opts, "throttling.iops-size", 0);
>> +}
>
> You should reuse the #define's in include/qemu/throttle-options.h
> See throttle_extract_options() in this patch:
> http://patchwork.ozlabs.org/patch/803919/ Disregard the UINT_MAX checks,
> unsigned ints in LeakyBucket were replaced by uint64_t.
>
I can not use the #define's because I use throttling.*.
In my last patch also we wanted to have it like that to align with the 
block device throttle options.
If you see in blockdev.c, still there exists throttling.*

There may be change required every where, so would like to do it as part 
of another patch.

-Pradeep
> Don't forget to drop the reviews when you change a patch! The original
> reviews will probably not be valid anymore.
