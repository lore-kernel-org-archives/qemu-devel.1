Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3664BC2D0C3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 18:07:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0200B206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 18:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O0Xwby5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0200B206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igumD-0000HV-4V
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 13:07:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42159)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igulZ-00089m-N9
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 13:06:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igulX-0001ST-4q
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 13:06:45 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39441)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igulW-0001Qs-Uh
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 13:06:43 -0500
Received: by mail-oi1-x244.google.com with SMTP id a67so4035857oib.6
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 10:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MirDbpR4oYKNUHsUc37Lmf2tFcn7WlaGv1P9OqWE3II=;
 b=O0Xwby5+qMCAZNks4hGLGdbDjf7JhZdBAJMxRR+OkUlf+41I8x8Rmr/7n4BdRII2i/
 A4q+wIj6zNJbNWeoeeYQaE8B2GdGEcRKr1BfiLIWZfnJY2OEwF6o9cWnAEvZlK7L6zGr
 YL8CBPYvWUeSpRoxGKfRvnRxPjPgw7R6ZvKj1JuEeVgDQ6LuDMdPQYT9bSdAbqhBSBs5
 BqvsLft43G02Qgl1T8nG7NPWMxBGRwhhCIQMwkFEDVkmofx8yfI+dRyZe//YbOsINzVi
 JtKeXB69PBPKlCs1nn2/t4nbUri+pCxlYjTn2R6t+FRsvNrh55JpqxBbXqHN3rrKLaNR
 bwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MirDbpR4oYKNUHsUc37Lmf2tFcn7WlaGv1P9OqWE3II=;
 b=OqiFc253/SV9BLYcZP+HSlxktOjr+oPvNOTyum8FEA+JwEHdPBl76JMLaSDJL4qPFU
 0jlGVLWBGWDOK6ChvDcxIZNnHlutA6vdAioMbJm4t5Wh5x3i/5FrkWD24rUkA/NLtjHi
 NjqDY8rVKiw16QGk2menHbkxjobdy0I+3uWngQxYG+esuA1lsTnKfPWUGNcqntjGOeG3
 Y6A8cVpTrIC/VNTVcXq+IrE4Cw/POADiaQQkyqw0jAID674npHYNtIudKfvDaektpYad
 aqIya6iXv6ZJJKYLjtrWEOK2llCraXa+8r2V+uYM6qRnMJPsBsnwwFLoEJxzhnGEwXbe
 lvFg==
X-Gm-Message-State: APjAAAWprt9NjRaQ4Cnkv4CQhjhWYELxMqcMEBreCKckALJ56Zhb7ApX
 BYhnphnJ861GMENy0yuUOgHLNmHyNZqtU6/Ti692OA==
X-Google-Smtp-Source: APXvYqwCA+iqnTv4OZy4k7jGOEAVhPzgv9IxxB5Ne9ckGmf8WAi9kgkdqYRqVqmNfi3CQ7w/jlgMr2/wztj14Ku3l94=
X-Received: by 2002:aca:f5cc:: with SMTP id t195mr153912oih.163.1576519601929; 
 Mon, 16 Dec 2019 10:06:41 -0800 (PST)
MIME-Version: 1.0
References: <20191212173320.11610-1-drjones@redhat.com>
 <20191212173320.11610-4-drjones@redhat.com>
 <CAFEAcA_u94O8WYLgB8DF=pu-3V7LrNWpiQFV5mDYeeqLj1Ee2Q@mail.gmail.com>
 <CAFEAcA9ZoOZt6Jh42hi6q91=kRM9T9z436J99NF+Ns5KVKUYow@mail.gmail.com>
 <20191216164355.i5rpfuqlfqv2z7m7@kamzik.brq.redhat.com>
In-Reply-To: <20191216164355.i5rpfuqlfqv2z7m7@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Dec 2019 18:06:30 +0000
Message-ID: <CAFEAcA8NzQ8QYE2NMnviPPnmBn1Dwm4W_KvhMbwCNwFzkurK-Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/5] target/arm/kvm: Implement virtual time
 adjustment
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: bijan.mottahedeh@oracle.com, Marc Zyngier <maz@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Heyi Guo <guoheyi@huawei.com>, msys.mizuma@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 16 Dec 2019 at 16:44, Andrew Jones <drjones@redhat.com> wrote:
>
> On Mon, Dec 16, 2019 at 03:40:16PM +0000, Peter Maydell wrote:
> > On Mon, 16 Dec 2019 at 15:14, Peter Maydell <peter.maydell@linaro.org> wrote:
> > > How does this interact with the usual register sync to/from
> > > KVM (ie kvm_arch_get_registers(), which I think will do a
> > > GET_ONE_REG read of the TIMER_CNT register the way it does
> > > any other sysreg, inside write_kvmstate_to_list(), plus
> > > kvm_arch_set_registers() which does the write back to the
> > > kernel in write_list_to_kvmstate()) ? Presumably we want this
> > > version to take precedence by the set_virtual_time call
> > > happening after the kvm_arch_set_registers, but is this
> > > guaranteed ?
> >
> > ...you might also want to look at the effects of simply
> > removing the KVM_REG_ARM_TIMER_CNT entry from the
> > 'non_runtime_cpregs[]' array -- in commit 4b7a6bf402bd064
> > we explicitly stopped reading/writing this register's value
> > to/from the kernel except for inbound migration, and it
> > feels like this patchset is now rolling back that approach,
> > so maybe we should also be (configurably) rolling back some
> > of its implementation rather than just leaving it in place.
>
> I feel like I already considered that, maybe even tried it, a few months
> ago when I first looked at this. I must have decided against it for some
> reason at the time, but I don't recall what. Now I can say the reason is
> because we only do this save/restore when we transition to/from paused
> state, though.

I found the thread which discussed the bug which originally
caused us to add commit 4b7a6bf402bd064:
https://lists.cs.columbia.edu/pipermail/kvmarm/2015-July/015665.html
 -- there are some codepaths which cause us to do a sync from/to
KVM for one VCPU while others are still running. If we do a
read-CNT-and-write-back then we effectively cause time to jump
backwards for the other still-running CPUs.

So we do still want to have TIMER_CNT listed as being KVM_PUT_FULL_STATE
regardless, or we re-introduce that bug.

Your approach in this patchset reads and writes on vm-paused,
so it won't have the pre-2015 problems.

It still feels odd that we're storing this bit of guest state
in two places now though -- in kvm_vtime, and also in its usual
place in the cpreg_array data structures (we write back the
value from kvm_vtime when the VM starts running, and we write
back the value from the cpreg_array for a PUT_FULL_STATE, which
the comments claim is only on startup or when we just loaded
migration state (and also undocumentedly but reasonably on
cpu-hotplug, which arm doesn't have yet).

I've just spent a little while digging through code, and
haven't been able to satisfy myself on the ordering of which
writeback wins: for a loadvm I think we first do a
cpu_synchronize_all_post_init() (writing back the counter
value from the migration data) and then after than we will
unpause the VM -- why doesn't this overwrite the correct
value with the wrong value from kvm_vtime ?

I just noticed also that the logic used in this patch
doesn't match what other architectures do in their vm_state_change
function -- eg cpu_ppc_clock_vm_state_change() has an
"if (running) { load } else { save }", and kvmclock_vm_state_change()
for i386 also has "if (running) { ... } else { ... }", though
it has an extra wrinkle where it captures "are we PAUSED?"
to use in the pre_save function; the comment above
kvmclock_pre_save() suggests maybe that would be useful for other
than x86, too. kvm_s390_tod_vm_state_change() has
logic that's a slightly more complicated variation on just
testing the 'running' flag, but it doesn't look at the
specific new state.

> > I note also that the commit message there had a remark
> > about inconsistencies between VCPUs -- is the right thing
> > to handle this per-VM rather than per-VCPU somehow?
>
> per-VM would make sense, because the counters should be synchronized
> among the VCPUs. KVM does that for us, though, so whichever VCPU last
> restores its counter is the one that will determine the final value.
>
> Maybe we should have a VM ioctl instead, but ATM we only have VCPU ioctls.

I meant more "only do the save/load once per VM in QEMU but
do it by working with just one VCPU". But I guess since migration
works on all the VCPUs we're ok to do pause-resume the same way
(and I've now tracked down what the 'inconsistentencies between VCPUs'
were: they're when we were syncing the CNT value for one vCPU when
others were still running.)

thanks
-- PMM

