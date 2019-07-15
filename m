Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2FFC76196
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:49:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B90662081C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B90662081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn1M5-0004Eq-Oc
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 09:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53235)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mark.rutland@arm.com>) id 1hn1Lh-0002zq-5Z
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:49:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.rutland@arm.com>) id 1hn1Lg-0001kd-0i
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:49:01 -0400
Received: from foss.arm.com ([217.140.110.172]:48182)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <mark.rutland@arm.com>)
 id 1hn1Ld-0001e9-JY; Mon, 15 Jul 2019 09:48:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DBAA28;
 Mon, 15 Jul 2019 06:48:52 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 697233F71F;
 Mon, 15 Jul 2019 06:48:51 -0700 (PDT)
Date: Mon, 15 Jul 2019 14:48:49 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Message-ID: <20190715134848.GI56232@lakrids.cambridge.arm.com>
References: <1b0aa6b2-80b1-a72e-6849-7323c3b9c6bc@huawei.com>
 <20190715134059.GJ2790@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715134059.GJ2790@e103592.cambridge.arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
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
Cc: Marc Zyngier <marc.zyngier@arm.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Guoheyi <guoheyi@huawei.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 15, 2019 at 02:41:00PM +0100, Dave Martin wrote:
> On Sat, Jul 13, 2019 at 05:53:57PM +0800, Guoheyi wrote:
> > Hi folks,
> > 
> > Do it make sense to implement virtual SDEI in qemu? So that we can have the
> > standard way for guest to handle NMI watchdog, RAS events and something else
> > which involves SDEI in a physical ARM64 machine.
> > 
> > My basic idea is like below:
> > 
> > 1. Change a few lines of code in kvm to allow unhandled SMC invocations
> > (like SDEI) to be sent to qemu, with exit reason of KVM_EXIT_HYPERCALL, so
> > we don't need to add new API.
> 
> So long as KVM_EXIT_HYPERCALL reports sufficient information so that
> userspace can identify the cause as an SMC and retrieve the SMC
> immediate field, this seems feasible.
> 
> For its own SMCCC APIs, KVM exclusively uses HVC, so rerouting SMC to
> userspace shouldn't conflict.

Be _very_ careful here! In systems without EL3 (and without NV), SMC
UNDEFs rather than trapping to EL2. Given that, we shouldn't build a
hypervisor ABI that depends on SMC.

I am strongly of the opinion that (for !NV) we should always use HVC
here and have KVM appropriately forward calls to userspace, rather than
trying to use HVC/SMC to distinguish handled-by-kernel and
handled-by-userspace events.

For NV, the first guest hypervisor would use SMC to talk to KVM, all
else being the same.

> This bouncing of SMCs to userspace would need to be opt-in, otherwise
> old userspace would see exits that it doesn't know what to do with.
> 
> > 2. qemu handles supported SDEI calls just as the spec says for what a
> > hypervisor should do for a guest OS.
> > 
> > 3. For interrupts bound to hypervisor, qemu should stop injecting the IRQ to
> > guest through KVM, but jump to the registered event handler directly,
> > including context saving and restoring. Some interrupts like virtual timer
> > are handled by kvm directly, so we may refuse to bind such interrupts to
> > SDEI events.
> 
> Something like that.
> 
> Interactions between SDEI and PSCI would need some thought: for example,
> after PSCI_CPU_ON, the newly online cpu needs to have SDEs masked.
> 
> One option (suggested to me by James Morse) would be to allow userspace
> to disable in the in-kernel PSCI implementation and provide its own
> PSCI to the guest via SMC -- in which case userspace that wants to
> implement SDEI would have to implement PSCI as well.

I think this would be the best approach, since it puts userspace in
charge of everything.

However, this interacts poorly with FW-based mitigations that we
implement in hyp. I suspect we'd probably need a mechanism to delegate
that responsibility back to the kernel, and figure out if that has any
interaction with thigns that got punted to userspace...

Thanks,
Mark.

