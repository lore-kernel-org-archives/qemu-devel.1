Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F41CC35666
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 11:48:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ECF82071E
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 11:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ECF82071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5TGn-0006NU-77
	for qemu-devel@archiver.kernel.org; Sat, 22 Feb 2020 06:48:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56459)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j5TGA-0005xs-Mi
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 06:47:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j5TG8-0002aa-PD
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 06:47:50 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:10625)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1j5TG8-0002Zy-Ia
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 06:47:48 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id CF05E74637E;
 Sat, 22 Feb 2020 12:47:44 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9D408745953; Sat, 22 Feb 2020 12:47:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9B27374569F;
 Sat, 22 Feb 2020 12:47:44 +0100 (CET)
Date: Sat, 22 Feb 2020 12:47:44 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: jasper.lowell@bt.com
Subject: Re: [PATCH] hw/ide: Remove status register read side effect
In-Reply-To: <d805ea83320fdb2de626b0657e94a87bc0ea5015.camel@bt.com>
Message-ID: <alpine.BSF.2.22.395.2002221219340.4684@zero.eik.bme.hu>
References: <20200221065015.337915-1-jasper.lowell@bt.com>
 <alpine.BSF.2.22.395.2002211635360.45267@zero.eik.bme.hu>
 <d805ea83320fdb2de626b0657e94a87bc0ea5015.camel@bt.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 22 Feb 2020, jasper.lowell@bt.com wrote:
> I think the reason why the Solaris 10 driver crashes fatally whereas
> Linux and OpenBSD ignore the side effect is because when clearing
> interrupts, Solaris 10 expects the interrupt bit to be set and checks
> this. Linux and OpenBSD appear to clear it regardless of its state.

I've also found this thread:

https://lucky.openbsd.misc.narkive.com/hA6XG7Fu/bus-master-dma-error-missing-interrupt

which seems to talk about missing IRQ in UDMA mode similar to our problem 
and it suggests OpenBSD detects this and downgrades to PIO mode so it 
would still work. Did you check if this is why it works with OpenBSD or it 
really uses UDMA mode?

> This patch doesn't solve all the problems for Solaris 10. It gets
> further in the boot process but it is still unable to mount the file
> system. I suspect that there are more bugs in the IDE/CMD646 emulation.
> I'm going to continue looking into it. It's still possible we are being
> affected by the same bugs. Right now, I'm considering that the
> unresponsive serial console under Sun4u on Solaris 10 is due to not
> being able to mount the file system and pull the required assets for
> the installation menu.

This is possible. The hang I get during boot with PPC OSes I've tried is 
also becuase not being able to read CD drive after switching to UDMA mode. 
This would suggest bug may be in either common ide code or ide-cd 
emulation but could as well be in irq routing (in which case it's separate 
but similar bug in different machine emulations). Is there a way to 
disable UDMA mode in Solaris to check if it would work better when only 
using PIO? That might help locate the bug further.

In my case I've tested with both on board IDE and adding an sii3112 PCI 
card emulation, these both use common bmdma code but route IRQs 
differently. I see some irqs arriving up to the interrupt controller but 
CPU irq is not raised for some reason so I'm not sure it's a bug in common 
code or somewhere else.

>> this change seems to break
>> something else according to a CI test report from patchew.
>
> The test appears to break here in /tests/qtest/ide-test.c for obvious
> reasons:
> /* Reading the status register clears the IRQ */
> g_assert(!qtest_get_irq(qts, IDE_PRIMARY_IRQ));
>
> Should the patch I've suggested be correct, this test would need to be
> updated. This is my first patch attempt for QEMU so I'm not sure what

OK, I haven't checked the test just noticed the failure.

> the process is. Should I be submitting a new V2 patch with these
> changes? I won't have the opportunity to update the patch for a few
> days but will continue watching the thread for reviews.

I'd suggest to wait a few days to give people a chance to review the patch 
then submit a v2 with all the requested changes if any. You can submit v2 
right away but then if someone finds something you'll need more versions 
which is OK as well, your decision how many versions you want to submit. 
Since this patch is only 1 line there's not much people could ask to 
change about it and v2 could allow CI to run and maybe reveal problems so 
maybe in this case a v2 with also fixing the test might help to get it 
reviewed faster. I assume you're aware of the page about patch submission:

https://wiki.qemu.org/Contribute/SubmitAPatch

Regards,
BALATON Zoltan

