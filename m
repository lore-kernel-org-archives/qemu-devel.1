Received: from eggs.gnu.org ([2001:4830:134:3::10]:47878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cH8X8-0004ZF-5Q
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 07:19:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cH8X3-0002q8-W6
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 07:19:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cH8X3-0002pq-Qa
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 07:19:37 -0500
References: <20161214064820.12480-1-hangaohuai@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4bfd3066-6c2b-c21f-b6ea-9cc156fa4389@redhat.com>
Date: Wed, 14 Dec 2016 13:19:34 +0100
MIME-Version: 1.0
In-Reply-To: <20161214064820.12480-1-hangaohuai@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] bugfix: vm halt when in reset looping
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



On 14/12/2016 07:48, hangaohuai wrote:
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

I think this would break S3 resume.

Paolo

> ---
>  hw/timer/mc146818rtc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
> index da209d0..67d707d 100644
> --- a/hw/timer/mc146818rtc.c
> +++ b/hw/timer/mc146818rtc.c
> @@ -946,11 +946,19 @@ static Property mc146818rtc_properties[] = {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> +static void rtc_resetdev(DeviceState *d)
> +{
> +    RTCState *s = MC146818_RTC(d);
> +
> +    s->cmos_data[0x0f] = 0x00;
> +}
> +
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
