Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D7EC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 16:37:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05E0D2089E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 16:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E0D2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57689 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOm33-0002r4-7W
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 12:37:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.rutland@arm.com>) id 1hOm1V-0001fe-R1
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:35:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.rutland@arm.com>) id 1hOm1S-0006aj-G2
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:35:57 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42550
	helo=foss.arm.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.rutland@arm.com>)
	id 1hOm1H-0006OU-V4; Thu, 09 May 2019 12:35:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F060374;
	Thu,  9 May 2019 09:35:40 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
	[10.72.51.249])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B55C53F6C4;
	Thu,  9 May 2019 09:35:39 -0700 (PDT)
Date: Thu, 9 May 2019 17:35:37 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190509163536.GB46269@lakrids.cambridge.arm.com>
References: <20190503171347.13747-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503171347.13747-1-peter.maydell@linaro.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.140.101.70
Subject: Re: [Qemu-devel] [PATCH 0/2] hw/arm/boot: handle large Images more
 gracefully
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 03, 2019 at 06:13:45PM +0100, Peter Maydell wrote:
> This patchset attempts to fix https://bugs.launchpad.net/qemu/+bug/1823998
> which reports that we don't handle kernels larger than 128MB
> correctly, because we allow the initrd to be placed over the
> tail end of the kernel. AArch64 kernel Image files (since v3.17)
> report the total size they require (including any BSS area that
> isn't in the Image itself), so we can use that to be sure we
> place the initrd sufficiently far into the RAM.
> 
> Patch 1 in this series adjusts our "where do we put the initrd"
> heuristic so that it always places it at least after whatever
> our best guess at the kernel size is. (This might still not
> be right for images like self-decompressing 32-bit kernels, where
> there's no way to know how big the kernel will be after
> decompression.) Patch 2 makes load_aarch64_image() return the
> kernel size as indicated in the Image file header, so that for
> the specific case of AArch64 Image files we will definitely not
> put the initrd on top of them.
> 
> I've given this a quick smoke test but I don't have a very large
> Image kernel to hand, so testing appreciated.

I've just given this a go with three very large images built from v5.1:

* ~113.6MiB raw, ~134.5MiB effective
* ~131.0MiB raw, ~152.0MiB effective
* ~225.6MiB raw, ~247.0MiB effective

Prior to these patches (with pristine QEMU commit c56247e55bde4386) both
would silently fail to boot, and with these patches applied both all
three begin booting and produce console output. The first two get to
userspace, and the third crashes due to an unrelated Linux bug.

So FWIW:

Tested-by: Mark Rutland <mark.rutland@arm.com>

Thanks for putting this together!

Thanks,
Mark.

