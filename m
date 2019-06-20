Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F5AC43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:58:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FE3D20644
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE3D20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49808 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdzRq-0000Wl-VS
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 11:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52898)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <balaton@eik.bme.hu>) id 1hdzIq-00009R-3J
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 11:48:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1hdzAf-0006kl-0c
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 11:40:18 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:63720)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1hdzAe-0006he-L4
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 11:40:16 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id BBF587462D7;
 Thu, 20 Jun 2019 17:40:12 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9354C7462D6; Thu, 20 Jun 2019 17:40:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 922017462BB;
 Thu, 20 Jun 2019 17:40:12 +0200 (CEST)
Date: Thu, 20 Jun 2019 17:40:12 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Gerd Hoffmann <kraxel@redhat.com>
In-Reply-To: <20190620150923.gpe4rqn3qc54gcsn@sirius.home.kraxel.org>
Message-ID: <alpine.BSF.2.21.9999.1906201729320.50442@zero.eik.bme.hu>
References: <cover.1561028123.git.balaton@eik.bme.hu>
 <046ddebb7ec8db48c4e877ee444ec1c41e385a74.1561028123.git.balaton@eik.bme.hu>
 <20190620150923.gpe4rqn3qc54gcsn@sirius.home.kraxel.org>
User-Agent: Alpine 2.21.9999 (BSF 287 2018-06-16)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
Subject: Re: [Qemu-devel] [PATCH v5 2/2] ati-vga: Implement DDC and EDID
 info from monitor
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
Cc: Corey Minyard <cminyard@mvista.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Jun 2019, Gerd Hoffmann wrote:
> On Thu, Jun 20, 2019 at 12:55:23PM +0200, BALATON Zoltan wrote:
>> This adds DDC support to ati-vga and connects i2c-ddc to it. This
>> allows at least MacOS with an ATI ndrv, Linux radeonfb and MorphOS to
>
> linux radeonfb is rv100 only, and aty128fb has no i2c support.
> Do MacOS and MorphOS have working edid with both card variants?

I've only tested EDID with MacOS with an NDRV from an ATI card ROM and 
MorphOS on mac99. These could read EDID with this patch. Haven't tried 
RV100 as that's known to be very incomplete to work yet (probably needs at 
least command FIFO to do something). The rage128 Xorg driver might load 
but that wants to use VESA BIOS function mentioned in the commit message 
to read EDID so it does not work yet. If you can add that function to 
vesabios it might get further.

>> +    case GPIO_MONID ... GPIO_MONID + 3:
>> +        /* FIXME What does Radeon have here? */
>> +        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
>> +            /* Rage128p accesses DDC used to get EDID on these pins */
>> +            ati_reg_write_offs(&s->regs.gpio_monid,
>> +                               addr - GPIO_MONID, data, size);
>> +            if ((s->regs.gpio_monid & BIT(25)) &&
>
> Extra enable bit, ok.

This bit is listed as mask bit in docs and clients set this to enable 
other bits. It could probably safely be ignored (does not seem to be 
present on RV100 only on older card) but checking it does not hurt either.

>> +                addr <= GPIO_MONID + 2 && addr + size > GPIO_MONID + 2) {
>
> Hmm, isn't this just "addr == GPIO_MONID + 2" ?

No because there could be all kinds of unalligned or multibyte access and 
we only want to trigger this when the byte with the enable bits are 
touched. (The MacOS NDRV accesses this 1 byte at a time so this is needed 
to avoid spurious i2c bit banging but other drivers write 4 bytes so then 
addr is not equal but covering above byte which is what this test allows.

>> +                s->regs.gpio_monid = ati_i2c(s->bbi2c, s->regs.gpio_monid, 1);
>
> So all i2c bits are shifted by one compared to rv100, correct?

They are in a different register and drivers I've tried poke bits shifted 
by one on R128P.

Regards,
BALATON Zoltan

