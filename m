Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62EAC31E40
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 09:21:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CFED2186A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 09:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CFED2186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyBwg-0007Xw-PM
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 05:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1hyBvI-0006k8-M6
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 05:19:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1hyBvG-0001wi-1g
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 05:19:55 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:48201)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1hyBvE-0001ul-3I
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 05:19:53 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 16E0874581E;
 Thu, 15 Aug 2019 11:19:47 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E330A7456D4; Thu, 15 Aug 2019 11:19:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E219E74569A;
 Thu, 15 Aug 2019 11:19:46 +0200 (CEST)
Date: Thu, 15 Aug 2019 11:19:46 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Gerd Hoffmann <kraxel@redhat.com>
In-Reply-To: <20190815062313.ve26cevmbyuewlo5@sirius.home.kraxel.org>
Message-ID: <alpine.BSF.2.21.9999.1908151051570.23526@zero.eik.bme.hu>
References: <20190815002652.79FDE7456E2@zero.eik.bme.hu>
 <20190815062313.ve26cevmbyuewlo5@sirius.home.kraxel.org>
User-Agent: Alpine 2.21.9999 (BSF 287 2018-06-16)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
Subject: Re: [Qemu-devel] [RFC PATCH] ati-vga: Implement dummy VBlank IRQ
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 15 Aug 2019, Gerd Hoffmann wrote:
> On Thu, Aug 15, 2019 at 02:25:07AM +0200, BALATON Zoltan wrote:
>> The MacOS driver exits if the card does not have an interrupt. If we
>> set PCI_INTERRUPT_PIN to 1 then it enables VBlank interrupts and it
>> boots but the mouse poniter can not be moved. This patch implements a
>> dummy VBlank interrupt by a timer triggered at 60 Hz to test if it
>> helps. Unfortunately it doesn't: MacOS with this patch hangs during
>> boot just polling interrupts and acknowledging them so maybe it needs
>> something else or there may be some other problem with this
>> implementation.
>>
>> This is posted for comments and to let others experiment with it but
>> probably should not be committed upstream yet.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  hw/display/ati.c      | 41 +++++++++++++++++++++++++++++++++++++++++
>>  hw/display/ati_dbg.c  |  1 +
>>  hw/display/ati_int.h  |  4 ++++
>>  hw/display/ati_regs.h |  1 +
>>  4 files changed, 47 insertions(+)
>>
>> diff --git a/hw/display/ati.c b/hw/display/ati.c
>> index a365e2455d..e06cbf3e91 100644
>> --- a/hw/display/ati.c
>> +++ b/hw/display/ati.c
>> @@ -243,6 +243,21 @@ static uint64_t ati_i2c(bitbang_i2c_interface *i2c, uint64_t data, int base)
>>      return data;
>>  }
>>
>> +static void ati_vga_update_irq(ATIVGAState *s)
>> +{
>> +    pci_set_irq(&s->dev, s->regs.gen_int_status & 1);
>
> This should be "s->regs.gen_int_status & s->regs.gen_int_cntl" I guess?

Probably, but we only try to emulate VBlank yet so to avoid any problems 
due to raising irq for unknown bits I restricted it for that now.

>> +static void ati_vga_vblank_irq(void *opaque)
>> +{
>> +    ATIVGAState *s = opaque;
>> +
>> +    timer_mod(&s->vblank_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
>> +              NANOSECONDS_PER_SECOND / 60);
>> +    s->regs.gen_int_status |= 1;
>
> #defines for the irq status bits would be nice.

Yes, I thought about that but this was only for quick testing. I'll add 
constant for this in next version.

>> +    case GEN_INT_CNTL:
>> +        s->regs.gen_int_cntl = data;
>> +        if (data & 1) {
>> +            ati_vga_vblank_irq(s);
>> +        } else {
>> +            timer_del(&s->vblank_timer);
>> +        }
>
> ati_vga_update_irq() needed here.
>
>> +        break;
>> +    case GEN_INT_STATUS:
>> +        data &= (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF ?
>> +                 0x000f040fUL : 0xfc080effUL);
>
> Add IRQ_MASK #define ?

I'd leave these as constants because there are many of them (basically 
reserved bit mask for regs where we care or in this case writable bits) 
and one has to check docs to verify them and also in some cases we combine 
rage128p and rv100 so hiding them behind a constant would just make code 
less readable in my opinion. (This would become 3 lines for example with 
defines you'd have to look up in a different header so it's easier to see 
this way.)

>> +        s->regs.gen_int_status &= ~data;
>
> ati_vga_update_irq() needed here too.

Thanks. Indeed I forgot this. With that it works a bit better, mouse now 
can be moved but only vertically... No idea why, I'll have to check,

Regards,
BALATON Zoltan

