Received: from eggs.gnu.org ([2001:4830:134:3::10]:34024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fR0as-0008Ta-HR
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 15:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fR0ar-0005DR-Id
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 15:29:10 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:45643)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fR0ar-00059x-DJ
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 15:29:09 -0400
Received: by mail-ot0-x244.google.com with SMTP id a5-v6so12868336otf.12
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 12:29:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180607171751.11510-5-mark.cave-ayland@ilande.co.uk>
References: <20180607171751.11510-1-mark.cave-ayland@ilande.co.uk>
	<20180607171751.11510-5-mark.cave-ayland@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Jun 2018 20:28:48 +0100
Message-ID: <CAFEAcA9Ur6rwLETdcS8mA_Se55eRWmfFWE8VRhtJgsp90D9U4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 4/4] mos6522: convert
 VMSTATE_TIMER_PTR_TEST to VMSTATE_TIMER_PTR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On 7 June 2018 at 18:17, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:
> The timers are configured in the mos6522 init function and therefore will
> always exist, so the function can never return false.
>
> Peter also pointed out that this is the only remaining user of
> VMSTATE_TIMER_PTR_TEST in the codebase, so we might as well just convert it
> over to VMSTATE_TIMER_PTR and remove mos6522_timer_exist() as it is no
> longer required.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/misc/mos6522.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
> index d0a0c9e5d9..e9b686ac92 100644
> --- a/hw/misc/mos6522.c
> +++ b/hw/misc/mos6522.c
> @@ -369,13 +369,6 @@ static const MemoryRegionOps mos6522_ops = {
>      },
>  };
>
> -static bool mos6522_timer_exist(void *opaque, int version_id)
> -{
> -    MOS6522Timer *s = opaque;
> -
> -    return s->timer != NULL;
> -}
> -
>  static const VMStateDescription vmstate_mos6522_timer = {
>      .name = "mos6522_timer",
>      .version_id = 0,
> @@ -385,7 +378,7 @@ static const VMStateDescription vmstate_mos6522_timer = {
>          VMSTATE_UINT16(counter_value, MOS6522Timer),
>          VMSTATE_INT64(load_time, MOS6522Timer),
>          VMSTATE_INT64(next_irq_time, MOS6522Timer),
> -        VMSTATE_TIMER_PTR_TEST(timer, MOS6522Timer, mos6522_timer_exist),
> +        VMSTATE_TIMER_PTR(timer, MOS6522Timer),
>          VMSTATE_END_OF_LIST()
>      }
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
