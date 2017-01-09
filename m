Received: from eggs.gnu.org ([2001:4830:134:3::10]:40021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cQYk2-0006ST-DH
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 07:07:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cQYjz-0001CR-8K
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 07:07:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cQYjz-0001By-31
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 07:07:55 -0500
References: <20161219060336.10176-1-hangaohuai@huawei.com>
	<33183CC9F5247A488A2544077AF19020DA180CB2@DGGEMA505-MBX.china.huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fdf51620-656e-9da2-d2d7-40685e7c5d62@redhat.com>
Date: Mon, 9 Jan 2017 13:07:51 +0100
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA180CB2@DGGEMA505-MBX.china.huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] bugfix: vm halt when in reset looping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, Hangaohuai <hangaohuai@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>



On 09/01/2017 10:08, Gonglei (Arei) wrote:
>>
>> From: Hangaohuai
>> Sent: Monday, December 19, 2016 2:04 PM
>> To: qemu-devel@nongnu.org
>> Cc: mst@redhat.com; pbonzini@redhat.com; Gonglei (Arei); Hangaohuai
>> Subject: [PATCH v4] bugfix: vm halt when in reset looping
>>
>> reset mc146818rtc device when RESET event happens.
>>
>> Fix the problem:
>>   1. Guest boot the second cpu, set CMOS_RESET_CODE 0x0a to protect
>> selfboot;
>>   2. VM being reset by others, hmp_system_reset;
>>   3. seabios resume check the CMOS_RESET_CODE, if 0x0a, jump to the BDA
>>      resume execution by jump via 40h:0067h;
>>   4. Guest halt;
>>
>> Signed-off-by: hangaohuai <hangaohuai@huawei.com>
>> ---
>>  hw/timer/mc146818rtc.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
> 
> Reviewed-by: Gonglei <arei.gonglei@huawei.com>
> 
> Paolo, could you pls pick up this patch?

Yes, it's queued.  Maybe this week--sorry for the delay.

Paolo

> Thanks,
> -Gonglei
> 
>> diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
>> index da209d0..637f872 100644
>> --- a/hw/timer/mc146818rtc.c
>> +++ b/hw/timer/mc146818rtc.c
>> @@ -946,11 +946,23 @@ static Property mc146818rtc_properties[] = {
>>      DEFINE_PROP_END_OF_LIST(),
>>  };
>>
>> +static void rtc_resetdev(DeviceState *d)
>> +{
>> +    RTCState *s = MC146818_RTC(d);
>> +
>> +    /* Reason: VM do suspend self will set 0xfe
>> +     * Reset any values other than 0xfe(Guest suspend case) */
>> +    if (s->cmos_data[0x0f] != 0xfe) {
>> +        s->cmos_data[0x0f] = 0x00;
>> +    }
>> +}
>> +
>>  static void rtc_class_initfn(ObjectClass *klass, void *data)
>>  {
>>      DeviceClass *dc = DEVICE_CLASS(klass);
>>
>>      dc->realize = rtc_realizefn;
>> +    dc->reset = rtc_resetdev;
>>      dc->vmsd = &vmstate_rtc;
>>      dc->props = mc146818rtc_properties;
>>      /* Reason: needs to be wired up by rtc_init() */
>> --
>> 1.8.3.1
>>
> 
