Received: from eggs.gnu.org ([2001:4830:134:3::10]:43001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQZ8C-0002C3-06
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:09:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQZ8B-0008FW-0x
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:09:43 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:43314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQZ8A-0008F6-Qr
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:09:42 -0400
Received: by mail-ot0-x241.google.com with SMTP id i19-v6so7374199otk.10
	for <qemu-devel@nongnu.org>; Wed, 06 Jun 2018 07:09:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fdb61fc16922f78190f0db04a11dd20519cd2fb5.1528291908.git.balaton@eik.bme.hu>
References: <cover.1528291908.git.balaton@eik.bme.hu>
	<fdb61fc16922f78190f0db04a11dd20519cd2fb5.1528291908.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Jun 2018 15:09:05 +0100
Message-ID: <CAFEAcA_GwgmiZPQ9NmY9a7_OwYFCBHFZiVQzk1nZEoxYaD+mwQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 7/8] sm501: Do not clear read only bits
 when writing register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

On 6 June 2018 at 14:31, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> When writing a register that has read only bits besides reserved bits
> we have to avoid changing read only bits that may have non zero
> default values.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/display/sm501.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index e47be99..7ec1434 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -836,10 +836,10 @@ static void sm501_system_config_write(void *opaque, hwaddr addr,
>
>      switch (addr) {
>      case SM501_SYSTEM_CONTROL:
> -        s->system_control = value & 0xE300B8F7;
> +        s->system_control |= value & 0xEF00B8F7;

This will mean that you can't clear a r/w bit by writing a
zero to it -- is that the hardware behaviour? The
description in the commit message suggests that you want
   s->whatever = (value & rw_bit_mask) | ro_one_bits_mask;

?

>          break;
>      case SM501_MISC_CONTROL:
> -        s->misc_control = value & 0xFF7FFF20;
> +        s->misc_control |= value & 0xFF7FFF10;
>          break;
>      case SM501_GPIO31_0_CONTROL:
>          s->gpio_31_0_control = value;
> @@ -853,7 +853,7 @@ static void sm501_system_config_write(void *opaque, hwaddr addr,
>          s->dram_control |=  value & 0x7FFFFFC3;
>          break;
>      case SM501_ARBTRTN_CONTROL:
> -        s->arbitration_control =  value & 0x37777777;
> +        s->arbitration_control = value & 0x37777777;

Was this intended to be changed too?

>          break;
>      case SM501_IRQ_MASK:
>          s->irq_mask = value;

thanks
-- PMM
