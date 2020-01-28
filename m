Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4D5C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 22:29:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2CDB214D8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 22:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2CDB214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwZME-0001nx-0W
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 17:29:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fthain@telegraphics.com.au>) id 1iwZLc-0001H8-DX
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 17:28:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>) id 1iwZLb-0006VZ-Ag
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 17:28:40 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:36102)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>)
 id 1iwZLb-0006Tm-5b; Tue, 28 Jan 2020 17:28:39 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by kvm5.telegraphics.com.au (Postfix) with ESMTP id 4171D299A3;
 Tue, 28 Jan 2020 17:28:34 -0500 (EST)
Date: Wed, 29 Jan 2020 09:28:34 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 13/14] dp8393x: Don't reset Silicon Revision
 register
In-Reply-To: <dcd1dcd2-719c-1db0-e9ce-25d26ed1f6d4@redhat.com>
Message-ID: <alpine.LNX.2.21.1.2001290922330.8@nippy.intranet>
References: <cover.1579474761.git.fthain@telegraphics.com.au>
 <34caf9dea82cd30dc51b4f8768adb7a90b236bf2.1579474761.git.fthain@telegraphics.com.au>
 <dcd1dcd2-719c-1db0-e9ce-25d26ed1f6d4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 98.124.60.144
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org,
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jan 2020, Philippe Mathieu-Daud? wrote:

> On 1/19/20 11:59 PM, Finn Thain wrote:
> > The jazzsonic driver in Linux uses the Silicon Revision register value
> > to probe the chip. The driver fails unless the SR register contains 4.
> > Unfortunately, reading this register in QEMU usually returns 0 because
> > the s->regs[] array gets wiped after a software reset.
> > 
> > Fixes: bd8f1ebce4 ("net/dp8393x: fix hardware reset")
> > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> > ---
> >   hw/net/dp8393x.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> > index 1b73a8703b..71af0fad51 100644
> > --- a/hw/net/dp8393x.c
> > +++ b/hw/net/dp8393x.c
> > @@ -591,6 +591,10 @@ static uint64_t dp8393x_read(void *opaque, hwaddr addr,
> > unsigned int size)
> >                   val |= s->cam[s->regs[SONIC_CEP] & 0xf][2* (SONIC_CAP0 -
> > reg)];
> >               }
> >               break;
> > +        /* Read-only */
> > +        case SONIC_SR:
> > +            val = 4; /* only revision recognized by Linux/mips */
> > +            break;
> >           /* All other registers have no special contrainst */
> >           default:
> >               val = s->regs[reg];
> > @@ -971,7 +975,6 @@ static void dp8393x_realize(DeviceState *dev, Error
> > **errp)
> >       qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
> >         s->watchdog = timer_new_ns(QEMU_CLOCK_VIRTUAL, dp8393x_watchdog, s);
> > -    s->regs[SONIC_SR] = 0x0004; /* only revision recognized by Linux */
> >         memory_region_init_ram(&s->prom, OBJECT(dev),
> >                              "dp8393x-prom", SONIC_PROM_SIZE, &local_err);
> > 
> 
> Please fix in dp8393x_reset() instead:
> 
> -- >8 --
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index cdc2631c0c..65eb9c23a7 100644
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -862,6 +862,7 @@ static void dp8393x_reset(DeviceState *dev)
>      timer_del(s->watchdog);
> 
>      memset(s->regs, 0, sizeof(s->regs));
> +    s->regs[SONIC_SR] = 0x0004; /* only revision recognized by Linux */
>      s->regs[SONIC_CR] = SONIC_CR_RST | SONIC_CR_STP | SONIC_CR_RXDIS;
>      s->regs[SONIC_DCR] &= ~(SONIC_DCR_EXBUS | SONIC_DCR_LBR);
>      s->regs[SONIC_RCR] &= ~(SONIC_RCR_LB0 | SONIC_RCR_LB1 | SONIC_RCR_BRD |
> SONIC_RCR_RNT);
> @@ -914,7 +915,6 @@ static void dp8393x_realize(DeviceState *dev, Error
> **errp)
>      qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
> 
>      s->watchdog = timer_new_ns(QEMU_CLOCK_VIRTUAL, dp8393x_watchdog, s);
> -    s->regs[SONIC_SR] = 0x0004; /* only revision recognized by Linux */
> 
>      memory_region_init_ram(&s->prom, OBJECT(dev),
>                             "dp8393x-prom", SONIC_PROM_SIZE, &local_err);
> ---
> 

This would allow the host to change the value of the Silicon Revision 
register. However, the datasheet says,

    4.3.13 Silicon Revision Register
    This is a 16-bit read only register. It contains information on the 
    current revision of the SONIC. The value of the DP83932CVF revision 
    register is 6h.

I haven't actually tried storing a different value in this register on 
National Semiconductor hardware, but I'm willing to do that test if you 
wish.

