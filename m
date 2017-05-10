Received: from eggs.gnu.org ([2001:4830:134:3::10]:41731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1d8TWb-0007qS-RI
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:27:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1d8TWZ-00031z-5d
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:27:37 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:13252)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1d8TWY-0002y2-JC
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:27:35 -0400
References: <1494405683-20877-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1494405683-20877-2-git-send-email-pradeep.jagadeesh@huawei.com>
	<20170510161201.387edc47@bahia.kaod.org>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <22325f3a-133a-a1e3-77ae-57e0c8235696@huawei.com>
Date: Wed, 10 May 2017 17:27:07 +0200
MIME-Version: 1.0
In-Reply-To: <20170510161201.387edc47@bahia.kaod.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/4] throttle: factor out duplicate code
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
	kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

On 5/10/2017 4:12 PM, Greg Kurz wrote:
> On Wed, 10 May 2017 04:41:20 -0400
> Pradeep Jagadeesh <pradeepkiruvale@gmail.com> wrote:
>
>> This patch factor out the duplicate throttle code that was present in
>> block and fsdev devices.
>>
>> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
>> ---
>>  blockdev.c                      | 44 +----------------------------------
>>  fsdev/qemu-fsdev-throttle.c     | 43 +---------------------------------
>>  fsdev/qemu-fsdev-throttle.h     |  1 +
>>  include/qemu/throttle-options.h |  5 ++++
>>  util/Makefile.objs              |  1 +
>>  util/throttle-options.c         | 51 +++++++++++++++++++++++++++++++++++++++++
>>  6 files changed, 60 insertions(+), 85 deletions(-)
>>  create mode 100644 util/throttle-options.c
>>
>> diff --git a/blockdev.c b/blockdev.c
>> index 6428206..a0eb2ed 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -386,49 +386,7 @@ static void extract_common_blockdev_options(QemuOpts *opts, int *bdrv_flags,
>>      }
>>
>>      if (throttle_cfg) {
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
>> -            qemu_opt_get_number(opts, "throttling.bps-total-max-length", 1);
>> -        throttle_cfg->buckets[THROTTLE_BPS_READ].burst_length  =
>> -            qemu_opt_get_number(opts, "throttling.bps-read-max-length", 1);
>> -        throttle_cfg->buckets[THROTTLE_BPS_WRITE].burst_length =
>> -            qemu_opt_get_number(opts, "throttling.bps-write-max-length", 1);
>> -        throttle_cfg->buckets[THROTTLE_OPS_TOTAL].burst_length =
>> -            qemu_opt_get_number(opts, "throttling.iops-total-max-length", 1);
>> -        throttle_cfg->buckets[THROTTLE_OPS_READ].burst_length =
>> -            qemu_opt_get_number(opts, "throttling.iops-read-max-length", 1);
>> -        throttle_cfg->buckets[THROTTLE_OPS_WRITE].burst_length =
>> -            qemu_opt_get_number(opts, "throttling.iops-write-max-length", 1);
>> -
>> -        throttle_cfg->op_size =
>> -            qemu_opt_get_number(opts, "throttling.iops-size", 0);
>> -
>> +        parse_io_throttle_options(throttle_cfg, opts);
>>          if (!throttle_is_valid(throttle_cfg, errp)) {
>>              return;
>>          }
>> diff --git a/fsdev/qemu-fsdev-throttle.c b/fsdev/qemu-fsdev-throttle.c
>> index 7ae4e86..db386a7 100644
>> --- a/fsdev/qemu-fsdev-throttle.c
>> +++ b/fsdev/qemu-fsdev-throttle.c
>> @@ -31,48 +31,7 @@ static void fsdev_throttle_write_timer_cb(void *opaque)
>>
>>  void fsdev_throttle_parse_opts(QemuOpts *opts, FsThrottle *fst, Error **errp)
>>  {
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
>> -        qemu_opt_get_number(opts, "throttling.iops-total-max-length", 1);
>> -    fst->cfg.buckets[THROTTLE_OPS_READ].burst_length =
>> -        qemu_opt_get_number(opts, "throttling.iops-read-max-length", 1);
>> -    fst->cfg.buckets[THROTTLE_OPS_WRITE].burst_length =
>> -        qemu_opt_get_number(opts, "throttling.iops-write-max-length", 1);
>> -    fst->cfg.op_size =
>> -        qemu_opt_get_number(opts, "throttling.iops-size", 0);
>> -
>> +    parse_io_throttle_options(&fst->cfg, opts);
>>      throttle_is_valid(&fst->cfg, errp);
>>  }
>>
>> diff --git a/fsdev/qemu-fsdev-throttle.h b/fsdev/qemu-fsdev-throttle.h
>> index e418643..c493e83 100644
>> --- a/fsdev/qemu-fsdev-throttle.h
>> +++ b/fsdev/qemu-fsdev-throttle.h
>> @@ -20,6 +20,7 @@
>>  #include "qemu/coroutine.h"
>>  #include "qapi/error.h"
>>  #include "qemu/throttle.h"
>> +#include "qemu/throttle-options.h"
>>
>>  typedef struct FsThrottle {
>>      ThrottleState ts;
>> diff --git a/include/qemu/throttle-options.h b/include/qemu/throttle-options.h
>> index 3133d1c..9b68eb8 100644
>> --- a/include/qemu/throttle-options.h
>> +++ b/include/qemu/throttle-options.h
>> @@ -10,6 +10,9 @@
>>  #ifndef THROTTLE_OPTIONS_H
>>  #define THROTTLE_OPTIONS_H
>>
>> +#include "qemu/throttle.h"
>> +#include "qmp-commands.h"
>
> I believe we don't need qmp-commands.h here
>
>> +
>>  #define THROTTLE_OPTS \
>>            { \
>>              .name = "throttling.iops-total",\
>> @@ -89,4 +92,6 @@
>>              .help = "when limiting by iops max size of an I/O in bytes",\
>>          }
>>
>> +void parse_io_throttle_options(ThrottleConfig *, QemuOpts *);
>
> Maybe rename to throttle_parse_options() to follow the naming scheme used
> in the throttle infrastructure ?
>
OK
>> +
>>  #endif
>> diff --git a/util/Makefile.objs b/util/Makefile.objs
>> index c6205eb..7119ce0 100644
>> --- a/util/Makefile.objs
>> +++ b/util/Makefile.objs
>> @@ -43,3 +43,4 @@ util-obj-y += qdist.o
>>  util-obj-y += qht.o
>>  util-obj-y += range.o
>>  util-obj-y += systemd.o
>> +util-obj-y += throttle-options.o
>> diff --git a/util/throttle-options.c b/util/throttle-options.c
>> new file mode 100644
>> index 0000000..02b26b8
>> --- /dev/null
>> +++ b/util/throttle-options.c
>> @@ -0,0 +1,51 @@
>> +#include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>> +#include "qemu/throttle-options.h"
>> +#include "qemu/iov.h"
>> +
>> +void parse_io_throttle_options(ThrottleConfig *throttle_cfg, QemuOpts *opts)
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
>> +        qemu_opt_get_number(opts, "throttling.iops-total-max-length", 1);
>> +    throttle_cfg->buckets[THROTTLE_OPS_READ].burst_length =
>> +        qemu_opt_get_number(opts, "throttling.iops-read-max-length", 1);
>> +    throttle_cfg->buckets[THROTTLE_OPS_WRITE].burst_length =
>> +        qemu_opt_get_number(opts, "throttling.iops-write-max-length", 1);
>> +
>> +    throttle_cfg->op_size =
>> +        qemu_opt_get_number(opts, "throttling.iops-size", 0);
>> +
>> +}
>
> Isn't it a bit overkill to introduce a new file for a single function ?
> Maybe you could simply move this to util/throttle.c ?
>
OK, but I will add one more function later patch. Still do you think 
better to move to util/thottle.c?

-Pradeep
