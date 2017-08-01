Received: from eggs.gnu.org ([2001:4830:134:3::10]:60357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dcTFy-0007k3-5B
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 05:14:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dcTFt-0006XA-KM
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 05:14:26 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:50837
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1dcTFt-0006Vl-Di
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 05:14:21 -0400
References: <1501575048-13485-1-git-send-email-frederic.konrad@adacore.com>
	<1501575048-13485-3-git-send-email-frederic.konrad@adacore.com>
	<CAFEAcA__hzcs_wvtYA35F4wAPhgHX0=-z8TJ8uwTSom6zxjN=A@mail.gmail.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <086e70d6-d5c1-2879-874f-ea1804c6ab38@adacore.com>
Date: Tue, 1 Aug 2017 11:13:56 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA__hzcs_wvtYA35F4wAPhgHX0=-z8TJ8uwTSom6zxjN=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 2/2] xilinx-spips: add a migration
 blocker when using mmio_execution
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>



On 08/01/2017 11:00 AM, Peter Maydell wrote:
> On 1 August 2017 at 09:10, KONRAD Frederic <frederic.konrad@adacore.com> wrote:
>> This adds a migration blocker when mmio_execution has been used.
>>
>> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
>> ---
>>   hw/ssi/xilinx_spips.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
>> index e833028..d46491f 100644
>> --- a/hw/ssi/xilinx_spips.c
>> +++ b/hw/ssi/xilinx_spips.c
>> @@ -31,6 +31,8 @@
>>   #include "hw/ssi/ssi.h"
>>   #include "qemu/bitops.h"
>>   #include "hw/ssi/xilinx_spips.h"
>> +#include "qapi/error.h"
>> +#include "migration/blocker.h"
>>
>>   #ifndef XILINX_SPIPS_ERR_DEBUG
>>   #define XILINX_SPIPS_ERR_DEBUG 0
>> @@ -139,6 +141,7 @@ typedef struct {
>>
>>       uint8_t lqspi_buf[LQSPI_CACHE_SIZE];
>>       hwaddr lqspi_cached_addr;
>> +    Error *migration_blocker;
>>   } XilinxQSPIPS;
>>
>>   typedef struct XilinxSPIPSClass {
>> @@ -603,6 +606,14 @@ static void *lqspi_request_mmio_ptr(void *opaque, hwaddr addr, unsigned *size,
>>       XilinxQSPIPS *q = opaque;
>>       hwaddr offset_within_the_region = addr & ~(LQSPI_CACHE_SIZE - 1);
>>
>> +    /* mmio_execution breaks migration better aborting than having strange
>> +     * bugs.
>> +     */
>> +    if (!q->migration_blocker) {
>> +        error_setg(&q->migration_blocker, "booting from SPI breaks migration");
>> +        migrate_add_blocker(q->migration_blocker, &error_fatal);
>> +    }
>> +
> 
> This doesn't handle the case when migration is already in progress
> and this function is called (which will cause migrate_add_blocker
> to fail).

Maybe I can make the request_ptr to fail if migration is in
progress.. But is that safe or do I risk a race.

Fred

> 
> thanks
> -- PMM
> 
