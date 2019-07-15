Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D0DC76192
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:41:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FDAD20C01
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FDAD20C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn1EI-0006FF-8z
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 09:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51431)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <Dave.Martin@arm.com>) id 1hn1E5-0005Nd-1Q
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:41:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Dave.Martin@arm.com>) id 1hn1E4-0005fT-36
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:41:08 -0400
Received: from foss.arm.com ([217.140.110.172]:48000)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <Dave.Martin@arm.com>)
 id 1hn1E0-0005e9-OS; Mon, 15 Jul 2019 09:41:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 242E228;
 Mon, 15 Jul 2019 06:41:03 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 390B03F71F;
 Mon, 15 Jul 2019 06:41:02 -0700 (PDT)
Date: Mon, 15 Jul 2019 14:41:00 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Guoheyi <guoheyi@huawei.com>
Message-ID: <20190715134059.GJ2790@e103592.cambridge.arm.com>
References: <1b0aa6b2-80b1-a72e-6849-7323c3b9c6bc@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b0aa6b2-80b1-a72e-6849-7323c3b9c6bc@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.140.110.172
Subject: Re: [Qemu-devel] [RFC] Add virtual SDEI support in qemu
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
Cc: Marc Zyngier <marc.zyngier@arm.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jul 13, 2019 at 05:53:57PM +0800, Guoheyi wrote:
> Hi folks,
> 
> Do it make sense to implement virtual SDEI in qemu? So that we can have the
> standard way for guest to handle NMI watchdog, RAS events and something else
> which involves SDEI in a physical ARM64 machine.
> 
> My basic idea is like below:
> 
> 1. Change a few lines of code in kvm to allow unhandled SMC invocations
> (like SDEI) to be sent to qemu, with exit reason of KVM_EXIT_HYPERCALL, so
> we don't need to add new API.

So long as KVM_EXIT_HYPERCALL reports sufficient information so that
userspace can identify the cause as an SMC and retrieve the SMC
immediate field, this seems feasible.

For its own SMCCC APIs, KVM exclusively uses HVC, so rerouting SMC to
userspace shouldn't conflict.

This bouncing of SMCs to userspace would need to be opt-in, otherwise
old userspace would see exits that it doesn't know what to do with.

> 2. qemu handles supported SDEI calls just as the spec says for what a
> hypervisor should do for a guest OS.
> 
> 3. For interrupts bound to hypervisor, qemu should stop injecting the IRQ to
> guest through KVM, but jump to the registered event handler directly,
> including context saving and restoring. Some interrupts like virtual timer
> are handled by kvm directly, so we may refuse to bind such interrupts to
> SDEI events.

Something like that.

Interactions between SDEI and PSCI would need some thought: for example,
after PSCI_CPU_ON, the newly online cpu needs to have SDEs masked.

One option (suggested to me by James Morse) would be to allow userspace
to disable in the in-kernel PSCI implementation and provide its own
PSCI to the guest via SMC -- in which case userspace that wants to
implement SDEI would have to implement PSCI as well.

There may be reasons why this wouldn't work ... I haven't thought about
it in depth.

Cheers
---Dave

