Received: from eggs.gnu.org ([2001:4830:134:3::10]:48928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dpCyx-0006Wc-JX
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:29:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dpCys-0005kB-Ph
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:29:31 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170905112152.8851-1-ppandit@redhat.com>
	<CAFEAcA8B4EwXCPSBsftt=QkAuH8jCBbK23-uU7NA7G3k6ADHLw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <38d7ca82-43ca-a98a-e727-8fb5968c7d1b@amsat.org>
Date: Tue, 5 Sep 2017 09:29:22 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8B4EwXCPSBsftt=QkAuH8jCBbK23-uU7NA7G3k6ADHLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] intc: arm_gicv3: limit GICR
 ipriority index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Prasad J Pandit <ppandit@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Guoxiang Niu <niuguoxiang@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

On 09/05/2017 08:58 AM, Peter Maydell wrote:
> On 5 September 2017 at 12:21, P J P <ppandit@redhat.com> wrote:
>> From: Prasad J Pandit <pjp@fedoraproject.org>
>>
>> When reading or writing to GICR ipriority array, index 'irq'
>> could go beyond its bounds; Restrict it within array limits.
>>
>> Reported-by: Guoxiang Niu <niuguoxiang@huawei.com>
>> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
>> ---
>>   hw/intc/arm_gicv3_redist.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/intc/arm_gicv3_redist.c b/hw/intc/arm_gicv3_redist.c
>> index 77e5cfa327..7683c4cc7f 100644
>> --- a/hw/intc/arm_gicv3_redist.c
>> +++ b/hw/intc/arm_gicv3_redist.c
>> @@ -187,7 +187,7 @@ static MemTxResult gicr_readl(GICv3CPUState *cs, hwaddr offset,
>>       case GICR_ICACTIVER0:
>>           *data = gicr_read_bitmap_reg(cs, attrs, cs->gicr_iactiver0);
>>           return MEMTX_OK;
>> -    case GICR_IPRIORITYR ... GICR_IPRIORITYR + 0x1f:

0x1f are only the cpu (private) irqs, then the range is valid up-to:
(extract64(cs->gicr_typer, 0, 5) + 1) * 32 - 1 supported irqs

>> +    case GICR_IPRIORITYR ... GICR_IPRIORITYR + 0x1c:
>>       {
>>           int i, irq = offset - GICR_IPRIORITYR;
>>           uint32_t value = 0;
>> @@ -310,7 +310,7 @@ static MemTxResult gicr_writel(GICv3CPUState *cs, hwaddr offset,
>>       case GICR_ICACTIVER0:
>>           gicr_write_clear_bitmap_reg(cs, attrs, &cs->gicr_iactiver0, value);
>>           return MEMTX_OK;
>> -    case GICR_IPRIORITYR ... GICR_IPRIORITYR + 0x1f:
>> +    case GICR_IPRIORITYR ... GICR_IPRIORITYR + 0x1c:
>>       {
>>           int i, irq = offset - GICR_IPRIORITYR;
> 
> Why do you think the buffer can be overrun? These functions
> are the word (4 byte) access functions, and they cannot
> be called with a non-4-aligned offset (see the asserts in
> gicv3_redist_read() and gicv3_redist_write()).
> 
> thanks
> -- PMM
> 
