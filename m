Received: from eggs.gnu.org ([2001:4830:134:3::10]:39754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dfnDF-0005NA-SK
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 09:09:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dfnDC-00077M-Dy
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 09:09:21 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:47179
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1dfnDC-00076o-4J
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 09:09:18 -0400
References: <1502367698-4539-1-git-send-email-frederic.konrad@adacore.com>
	<CAFEAcA8A+KC=8tR4i0UMgykdbKim-D0DFZ5FGyj1XDuyBBKTkw@mail.gmail.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <432cdd39-1016-c38e-ebaa-ecaabf51076d@adacore.com>
Date: Thu, 10 Aug 2017 15:08:47 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8A+KC=8tR4i0UMgykdbKim-D0DFZ5FGyj1XDuyBBKTkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10] xlnx-qspi: add a property for
 mmio-execution
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



On 08/10/2017 02:43 PM, Peter Maydell wrote:
> On 10 August 2017 at 13:21, KONRAD Frederic <frederic.konrad@adacore.com> wrote:
>> This adds mmio-exec property to workaround the migration bug.
>> When enabled the migration is blocked and will return an error.
>>
>> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
>> ---
>>   hw/ssi/xilinx_spips.c | 41 +++++++++++++++++++++++++++++++++--------
>>   1 file changed, 33 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
>> index e833028..f763bc3 100644
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
>> @@ -139,6 +141,8 @@ typedef struct {
>>
>>       uint8_t lqspi_buf[LQSPI_CACHE_SIZE];
>>       hwaddr lqspi_cached_addr;
>> +    Error *migration_blocker;
>> +    bool mmio_execution_enabled;
>>   } XilinxQSPIPS;
>>
>>   typedef struct XilinxSPIPSClass {
>> @@ -500,12 +504,13 @@ static void xilinx_qspips_invalidate_mmio_ptr(XilinxQSPIPS *q)
>>   {
>>       XilinxSPIPS *s = &q->parent_obj;
>>
>> -    if (q->lqspi_cached_addr != ~0ULL) {
>> +    if ((q->mmio_execution_enabled) && (q->lqspi_cached_addr != ~0ULL)) {
>>           /* Invalidate the current mapped mmio */
>>           memory_region_invalidate_mmio_ptr(&s->mmlqspi, q->lqspi_cached_addr,
>>                                             LQSPI_CACHE_SIZE);
>> -        q->lqspi_cached_addr = ~0ULL;
>>       }
>> +
>> +    q->lqspi_cached_addr = ~0ULL;
>>   }
> 
> This is safe, so it's probably the right thing to do for 2.10, but it
> does indicate that there's something weird in the mmio-enabled
> code. I was expecting this hunk not to be needed at all (on
> the basis that the lqspi_cached_addr should always be ~0ULL
> if there's no mapped mmio region), but it looks like calls to
> lqspi_read() will call load_cache which will set the
> lqspi_cached_addr even though we haven't actually set that up
> as an mmio_ptr backed region. Then the next time we call
> lqspi_load_cache() we'll call memory_region_invalidate_mmio_ptr()
> on a pointer value that we never returned from the
> request_mmio_ptr callback. The doc comment on the
> memory_region_invalidate_mmio_ptr() function doesn't say that's
> permitted.

Yes you're right: The device load a cache even if mmio-execution
isn't enabled this was the behavior before mmio-execution.

> 
> Looking at the implementation it seems like this will work in
> practice (because the invalidate code in memory.c checks that
> the MR it's about to drop really is an MMIO_INTERFACE), but
> if so we should document this. However, I'm not totally convinced
> that it really will work in complicated cases like where you
> have device A part of whose memory range is a container which
> holds a device B which is also using the mmio_pointer API:
> in that case if device A calls invalidate_mmio_ptr with an
> address that's in the part of A's memory region that is the
> device B container it could end up invalidating an mmio-interface
> that's actually inside device B. So it would be safer to say
> "the caller may only invalidate pointers it's actually told
> the memory system about".
> 

I see what you mean but I'm not sure this will happen because the
mmio-interface is mapped on @mr which is passed to invalidate.

So if device A doesn't have any mmio-interface mapped it can't
find the device B mmio-interface as we pass device A
MemoryRegion.

But I agree the doc is a little confusing about that.

> (Conversely if we're convinced that passing bogus pointers
> to memory_region_invalidate_mmio_ptr() is fine then we
> don't need to add the q->mmio_execution_enabled flag check.)

True but this will trigger an async_safe_work with all the
overhead.

> 
>>   static void xilinx_qspips_write(void *opaque, hwaddr addr,
>> @@ -601,12 +606,17 @@ static void *lqspi_request_mmio_ptr(void *opaque, hwaddr addr, unsigned *size,
>>                                       unsigned *offset)
>>   {
>>       XilinxQSPIPS *q = opaque;
>> -    hwaddr offset_within_the_region = addr & ~(LQSPI_CACHE_SIZE - 1);
>> -
>> -    lqspi_load_cache(opaque, offset_within_the_region);
>> -    *size = LQSPI_CACHE_SIZE;
>> -    *offset = offset_within_the_region;
>> -    return q->lqspi_buf;
>> +    hwaddr offset_within_the_region;
>> +
>> +    if (q->mmio_execution_enabled) {
>> +        offset_within_the_region = addr & ~(LQSPI_CACHE_SIZE - 1);
>> +        lqspi_load_cache(opaque, offset_within_the_region);
>> +        *size = LQSPI_CACHE_SIZE;
>> +        *offset = offset_within_the_region;
>> +        return q->lqspi_buf;
>> +    } else {
>> +        return NULL;
>> +    }
> 
> Rather than making the diffstat complicated like this, you can just say
>     if (!q->mmio_execution_enabled) {
>         return NULL;
>     }

Ok

> 
>>   }
>>
>>   static uint64_t
>> @@ -693,6 +703,15 @@ static void xilinx_qspips_realize(DeviceState *dev, Error **errp)
>>       sysbus_init_mmio(sbd, &s->mmlqspi);
>>
>>       q->lqspi_cached_addr = ~0ULL;
>> +
>> +    /* mmio_execution breaks migration better aborting than having strange
>> +     * bugs.
>> +     */
>> +    if (q->mmio_execution_enabled) {
>> +        error_setg(&q->migration_blocker,
>> +                   "enabling mmio_execution breaks migration");
>> +        migrate_add_blocker(q->migration_blocker, &error_fatal);
>> +    }
>>   }
>>
>>   static int xilinx_spips_post_load(void *opaque, int version_id)
>> @@ -716,6 +735,11 @@ static const VMStateDescription vmstate_xilinx_spips = {
>>       }
>>   };
>>
>> +static Property xilinx_qspips_properties[] = {
>> +    DEFINE_PROP_BOOL("mmio-exec", XilinxQSPIPS, mmio_execution_enabled, false),
> 
> This needs to be an x-property, ie to have a name beginning "x-",
> to indicate that it is experimental and will go away when we
> fix the underlying bug. It would also be helpful to comment
> here with the underlying reason why we've had to turn this off
> in 2.10, and what the property does (ie enable execution directly
> from the device, at the cost of preventing VM migration).

Ok will do.

Thanks,
Fred

> 
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>>   static Property xilinx_spips_properties[] = {
>>       DEFINE_PROP_UINT8("num-busses", XilinxSPIPS, num_busses, 1),
>>       DEFINE_PROP_UINT8("num-ss-bits", XilinxSPIPS, num_cs, 4),
>> @@ -729,6 +753,7 @@ static void xilinx_qspips_class_init(ObjectClass *klass, void * data)
>>       XilinxSPIPSClass *xsc = XILINX_SPIPS_CLASS(klass);
>>
>>       dc->realize = xilinx_qspips_realize;
>> +    dc->props = xilinx_qspips_properties;
>>       xsc->reg_ops = &qspips_ops;
>>       xsc->rx_fifo_size = RXFF_A_Q;
>>       xsc->tx_fifo_size = TXFF_A_Q;
>> --
>> 1.8.3.1
> 
> thanks
> -- PMM
> 
