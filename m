Received: from eggs.gnu.org ([2001:4830:134:3::10]:37093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cHqAO-0002Uo-CO
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 05:55:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cHqAI-0003hi-AH
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 05:55:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cHqAI-0003gq-4s
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 05:55:02 -0500
References: <20161216082322.14160-1-hangaohuai@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e85f9602-6914-9664-f3fa-cd37db89caff@redhat.com>
Date: Fri, 16 Dec 2016 11:54:58 +0100
MIME-Version: 1.0
In-Reply-To: <20161216082322.14160-1-hangaohuai@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] bugfix: vm halt when in reset looping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: hangaohuai <hangaohuai@huawei.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, arei.gonglei@huawei.com



On 16/12/2016 09:23, hangaohuai wrote:
> reset mc146818rtc device when RESET event happens.
> 
> Fix the problem:
>   1. Guest boot the second cpu, set CMOS_RESET_CODE 0x0a to protect selfboot;
>   2. VM being reset by others, hmp_system_reset;
>   3. seabios resume check the CMOS_RESET_CODE, if 0x0a, jump to the BDA
>      resume execution by jump via 40h:0067h;
>   4. Guest halt;
> 
> Signed-off-by: hangaohuai <hangaohuai@huawei.com>
> ---
>  hw/timer/mc146818rtc.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
> index da209d0..341b233 100644
> --- a/hw/timer/mc146818rtc.c
> +++ b/hw/timer/mc146818rtc.c
> @@ -946,11 +946,22 @@ static Property mc146818rtc_properties[] = {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> +static void rtc_resetdev(DeviceState *d)
> +{
> +    RTCState *s = MC146818_RTC(d);
> +
> +    /* Reason: VM do suspend self will set 0xfe
> +     * Only handle the VM boot case */
> +    if (s->cmos_data[0x0f] == 0x0a)
> +        s->cmos_data[0x0f] = 0x00;
> +}

Let's just do it for all values other than 0xfe.  Also, please run
checkpatch.pl on your patch.

Paolo

>  static void rtc_class_initfn(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
>      dc->realize = rtc_realizefn;
> +    dc->reset = rtc_resetdev;
>      dc->vmsd = &vmstate_rtc;
>      dc->props = mc146818rtc_properties;
>      /* Reason: needs to be wired up by rtc_init() */
> 
