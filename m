Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47577C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 16:52:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F85C21738
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 16:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F85C21738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpbY7-00058E-Ak
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 12:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42764)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mark.rutland@arm.com>) id 1hpbXx-0004e1-Du
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 12:52:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.rutland@arm.com>) id 1hpbXw-0007A4-Bq
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 12:52:21 -0400
Received: from foss.arm.com ([217.140.110.172]:40696)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <mark.rutland@arm.com>)
 id 1hpbXt-000782-Of; Mon, 22 Jul 2019 12:52:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FE0F1509;
 Mon, 22 Jul 2019 09:52:16 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8FBC3F694;
 Mon, 22 Jul 2019 09:52:15 -0700 (PDT)
Date: Mon, 22 Jul 2019 17:52:08 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190722165208.GA6261@lakrids.cambridge.arm.com>
References: <20190722151804.25467-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722151804.25467-1-peter.maydell@linaro.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.140.110.172
Subject: Re: [Qemu-devel] [PATCH for-4.1? 0/2] arm: further improve initrd
 positioning
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
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On Mon, Jul 22, 2019 at 04:18:02PM +0100, Peter Maydell wrote:
> In commit e6b2b20d9735d4ef we made the boot loader code try to avoid
> putting the initrd on top of the kernel.  However the expression used
> to calculate the start of the initrd:
> 
>     info->initrd_start = info->loader_start +
>         MAX(MIN(info->ram_size / 2, 128 * 1024 * 1024), kernel_size);
> 
> incorrectly uses 'kernel_size' as the offset within RAM of the
> highest address to avoid.  This is incorrect because the kernel
> doesn't start at address 0, but slightly higher than that.  This
> means that we can still incorrectly end up overlaying the initrd on
> the kernel in some cases, for example:
> 
> * The kernel's image_size is 0x0a7a8000
> * The kernel was loaded at   0x40080000
> * The end of the kernel is   0x4A828000
> * The DTB was loaded at      0x4a800000
> 
> To get this right we need to track the actual highest address used
> by the kernel and use that rather than kernel_size. We already
> trace the low_addr and high_addr for ELF images; set them
> also for the various other image types we support, and then use
> high_addr as the lowest allowed address for the initrd.
> 
> Patch 1 just does a preliminary variable rename; patch 2 is the meat.
> 
> Only very lightly tested...

FWIW, I've given this a spin, and it manages to boot my growing
collection of problematic images, along with all the previously-working
images I had lying around.

For both patches, feel free to take that as:

Tested-by: Mark Rutland <mark.rutland@arm.com>

> Marked as 'maybe for 4.1' because it is a bug fix and to code which
> is new in 4.1. OTOH cases that fail now would have failed with 4.0
> so it is not a regression strictly speaking. And we're getting
> steadily closer to release and I haven't very heavily tested this
> patch. I incline towards including it, overall.

Having these in 4.1 would be nice. AIUI the logic is correct, and this
seems low risk to me, but it is your call.

If you decide to hold off for a release, I can apply these patches
locally without too much pain.

Thanks for dealing with this, anyhow!

Mark.

> 
> thanks
> -- PMM
> 
> Peter Maydell (2):
>   hw/arm/boot: Rename elf_{low,high}_addr to image_{low,high}_addr
>   hw/arm/boot: Further improve initrd positioning code
> 
>  hw/arm/boot.c | 37 +++++++++++++++++++++++++++----------
>  1 file changed, 27 insertions(+), 10 deletions(-)
> 
> -- 
> 2.20.1
> 

