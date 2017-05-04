Received: from eggs.gnu.org ([2001:4830:134:3::10]:55519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d67Q9-0004CI-Dx
	for qemu-devel@nongnu.org; Wed, 03 May 2017 23:27:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d67Q6-0000Yi-13
	for qemu-devel@nongnu.org; Wed, 03 May 2017 23:27:13 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1d67Q5-0000Y0-R9
	for qemu-devel@nongnu.org; Wed, 03 May 2017 23:27:09 -0400
Received: by mail-pg0-x241.google.com with SMTP id s62so342689pgc.0
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 20:27:09 -0700 (PDT)
References: <20170412095111.11728-1-xiaoguangrong@tencent.com>
	<20170412095111.11728-2-xiaoguangrong@tencent.com>
	<65524a48-e39a-1db4-b173-2ba488a762f8@redhat.com>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <e9c40b05-1f90-cb54-ab9b-397148fe0551@gmail.com>
Date: Thu, 4 May 2017 11:27:11 +0800
MIME-Version: 1.0
In-Reply-To: <65524a48-e39a-1db4-b173-2ba488a762f8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] mc146818rtc: update periodic timer
 only if it is needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, yunfangtai@tencent.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 05/03/2017 11:42 PM, Paolo Bonzini wrote:
> 
> 
> On 12/04/2017 11:51, guangrong.xiao@gmail.com wrote:
>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>
>> Currently, the timer is updated whenever RegA or RegB is written
>> even if the periodic timer related configuration is not changed
>>
>> This patch optimizes it slightly to make the update happen only
>> if its period or enable-status is changed, also later patches are
>> depend on this optimization
>>
>> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
>> ---
>>   hw/timer/mc146818rtc.c | 31 +++++++++++++++++++++++++++++--
>>   1 file changed, 29 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
>> index 4165450..749e206 100644
>> --- a/hw/timer/mc146818rtc.c
>> +++ b/hw/timer/mc146818rtc.c
>> @@ -387,10 +387,25 @@ static void rtc_update_timer(void *opaque)
>>       check_update_timer(s);
>>   }
>>   
>> +static bool rtc_periodic_timer_updated_by_regA(RTCState *s, uint64_t data)
>> +{
>> +    uint8_t orig = s->cmos_data[RTC_REG_A];
>> +
>> +    return (orig & 0x0f) != (data & 0x0f);
>> +}
>> +
>> +static bool rtc_periodic_timer_updated_by_regB(RTCState *s, uint64_t data)
>> +{
>> +    uint8_t orig = s->cmos_data[RTC_REG_B];
>> +
>> +    return (orig & REG_B_PIE) != (data & REG_B_PIE);
>> +}
>> +
>>   static void cmos_ioport_write(void *opaque, hwaddr addr,
>>                                 uint64_t data, unsigned size)
>>   {
>>       RTCState *s = opaque;
>> +    bool update_periodic_timer;
>>   
>>       if ((addr & 1) == 0) {
>>           s->cmos_index = data & 0x7f;
>> @@ -423,6 +438,8 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
>>               }
>>               break;
>>           case RTC_REG_A:
>> +            update_periodic_timer = rtc_periodic_timer_updated_by_regA(s, data);
> 
> I think you can change it to a...
> 
>>               if ((data & 0x60) == 0x60) {
>>                   if (rtc_running(s)) {
>>                       rtc_update_time(s);
>> @@ -445,10 +462,16 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
>>               /* UIP bit is read only */
> 
> ... inlined update_periodic_timer assignment here:
> 
>      update_periodic_timer = (s->cmos_data[RTC_REG_A] ^ data) & REG_A_PERIOD;
> 
>>               s->cmos_data[RTC_REG_A] = (data & ~REG_A_UIP) |
>>                   (s->cmos_data[RTC_REG_A] & REG_A_UIP);
>> -            periodic_timer_update(s, qemu_clock_get_ns(rtc_clock));
>> +
>> +            if (update_periodic_timer) {
>> +                periodic_timer_update(s, qemu_clock_get_ns(rtc_clock));
>> +            }
>> +
>>               check_update_timer(s);
>>               break;
>>           case RTC_REG_B:
>> +            update_periodic_timer = rtc_periodic_timer_updated_by_regB(s, data);
>> +
>>               if (data & REG_B_SET) {
>>                   /* update cmos to when the rtc was stopping */
>>                   if (rtc_running(s)) {
>> @@ -475,7 +498,11 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
>>                   qemu_irq_lower(s->irq);
>>               }
> 
> Same here:
> 
>      update_periodic_timer = (s->cmos_data[RTC_REG_A] ^ data) & REG_B_PIE;
> 

Okay, will do, thanks!
