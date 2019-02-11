Received: from eggs.gnu.org ([209.51.188.92]:33480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtLJt-0002ac-2z
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:49:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtL70-0003N3-U4
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:35:43 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:39013)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gtL6y-00030H-UJ
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:35:41 -0500
Received: by mail-wm1-f52.google.com with SMTP id f16so1032470wmh.4
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 15:35:16 -0800 (PST)
References: <20190210174421.22062-1-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <442139a2-5ab2-9259-03a0-11d2f3c86c59@redhat.com>
Date: Tue, 12 Feb 2019 00:35:12 +0100
MIME-Version: 1.0
In-Reply-To: <20190210174421.22062-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] cuda: decrease time delay before raising
 VIA SR interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, hsp.cat7@gmail.com

Hi Mark,

On 2/10/19 6:44 PM, Mark Cave-Ayland wrote:
> In order to handle a race condition in MacOS 9, a delay was introduced when
> raising the VIA SR interrupt inspired by similar code in MacOnLinux.
> 
> During original testing of the MacOS 9 patches it was found that the 30us
> delay used in MacOnLinux did not work reliably within QEMU, and a value of
> 300us was required to function correctly.
> 
> Recent experiments have shown that the previous reliability issues are no
> longer present, and this value can be reduced down to 20us with no apparent
> ill effects in my local tests. This has the benefit of considerably improving
> the responsiveness of the ADB keyboard and mouse with the guest.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/misc/macio/cuda.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
> index c4f7a2f39b..3febacdd1e 100644
> --- a/hw/misc/macio/cuda.c
> +++ b/hw/misc/macio/cuda.c
> @@ -97,17 +97,8 @@ static void cuda_set_sr_int(void *opaque)
>  
>  static void cuda_delay_set_sr_int(CUDAState *s)
>  {
> -    MOS6522CUDAState *mcs = &s->mos6522_cuda;
> -    MOS6522State *ms = MOS6522(mcs);
> -    MOS6522DeviceClass *mdc = MOS6522_DEVICE_GET_CLASS(ms);
>      int64_t expire;
>  
> -    if (ms->dirb == 0xff || s->sr_delay_ns == 0) {
> -        /* Disabled or not in Mac OS, fire the IRQ directly */
> -        mdc->set_sr_int(ms);
> -        return;
> -    }

The change of sr_delay_ns below is well explained, but I don't
understand why you remove the previous if().

> -
>      trace_cuda_delay_set_sr_int();
>  
>      expire = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + s->sr_delay_ns;
> @@ -542,7 +533,7 @@ static void cuda_realize(DeviceState *dev, Error **errp)
>      s->tick_offset = (uint32_t)mktimegm(&tm) + RTC_OFFSET;
>  
>      s->sr_delay_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_set_sr_int, s);
> -    s->sr_delay_ns = 300 * SCALE_US;
> +    s->sr_delay_ns = 20 * SCALE_US;
>  
>      s->adb_poll_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_adb_poll, s);
>      s->adb_poll_mask = 0xffff;
> 
