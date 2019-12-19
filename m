Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA988C2D0D2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:34:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B910024679
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DFck97H6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B910024679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwst-0007Jf-53
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:34:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1ihwoq-0002lp-GY
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:30:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1ihwok-0002Q2-L9
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:30:24 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23527
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1ihwok-0002MR-AX
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:30:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576765817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=28rSLX4X8eSxZ8C3IwwotEZqVgOkmB31hF2ovohmpwg=;
 b=DFck97H6c2dZQ0jkNrDfAESajZuT6sjjZy/uUuTVh4TqD4YvOZ5/IxudMJmD3RniPes2nn
 f67YNoO/+Cry/LdrNn/bGQtRpf3XI63d9PBryCih0p6HahPSz7qv/EhnVbB6U+s/b7YS9b
 KKtuP+KI4dKsdSo0PwVLKcm8P6EG5WY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-t6Nxs0jWMMOjzt_qKRNfUg-1; Thu, 19 Dec 2019 09:30:14 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6EE81005502;
 Thu, 19 Dec 2019 14:30:12 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.36.118.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 41F816B566;
 Thu, 19 Dec 2019 14:30:08 +0000 (UTC)
Date: Thu, 19 Dec 2019 15:30:05 +0100
From: Andrew Jones <drjones@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH v2 3/5] target/arm/kvm: Implement virtual time
 adjustment
Message-ID: <20191219143005.gw43k2hug2n5nvto@kamzik.brq.redhat.com>
References: <20191212173320.11610-1-drjones@redhat.com>
 <20191212173320.11610-4-drjones@redhat.com>
 <CAFEAcA_u94O8WYLgB8DF=pu-3V7LrNWpiQFV5mDYeeqLj1Ee2Q@mail.gmail.com>
 <CAFEAcA9ZoOZt6Jh42hi6q91=kRM9T9z436J99NF+Ns5KVKUYow@mail.gmail.com>
 <20191216164355.i5rpfuqlfqv2z7m7@kamzik.brq.redhat.com>
 <CAFEAcA8NzQ8QYE2NMnviPPnmBn1Dwm4W_KvhMbwCNwFzkurK-Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8NzQ8QYE2NMnviPPnmBn1Dwm4W_KvhMbwCNwFzkurK-Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: t6Nxs0jWMMOjzt_qKRNfUg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On Mon, Dec 16, 2019 at 06:06:30PM +0000, Peter Maydell wrote:
> On Mon, 16 Dec 2019 at 16:44, Andrew Jones <drjones@redhat.com> wrote:
> >
> > On Mon, Dec 16, 2019 at 03:40:16PM +0000, Peter Maydell wrote:
> > > On Mon, 16 Dec 2019 at 15:14, Peter Maydell <peter.maydell@linaro.org=
> wrote:
> > > > How does this interact with the usual register sync to/from
> > > > KVM (ie kvm_arch_get_registers(), which I think will do a
> > > > GET_ONE_REG read of the TIMER_CNT register the way it does
> > > > any other sysreg, inside write_kvmstate_to_list(), plus
> > > > kvm_arch_set_registers() which does the write back to the
> > > > kernel in write_list_to_kvmstate()) ? Presumably we want this
> > > > version to take precedence by the set_virtual_time call
> > > > happening after the kvm_arch_set_registers, but is this
> > > > guaranteed ?
> > >
> > > ...you might also want to look at the effects of simply
> > > removing the KVM_REG_ARM_TIMER_CNT entry from the
> > > 'non_runtime_cpregs[]' array -- in commit 4b7a6bf402bd064
> > > we explicitly stopped reading/writing this register's value
> > > to/from the kernel except for inbound migration, and it
> > > feels like this patchset is now rolling back that approach,
> > > so maybe we should also be (configurably) rolling back some
> > > of its implementation rather than just leaving it in place.
> >
> > I feel like I already considered that, maybe even tried it, a few month=
s
> > ago when I first looked at this. I must have decided against it for som=
e
> > reason at the time, but I don't recall what. Now I can say the reason i=
s
> > because we only do this save/restore when we transition to/from paused
> > state, though.
>=20
> I found the thread which discussed the bug which originally
> caused us to add commit 4b7a6bf402bd064:
> https://lists.cs.columbia.edu/pipermail/kvmarm/2015-July/015665.html
>  -- there are some codepaths which cause us to do a sync from/to
> KVM for one VCPU while others are still running. If we do a
> read-CNT-and-write-back then we effectively cause time to jump
> backwards for the other still-running CPUs.
>=20
> So we do still want to have TIMER_CNT listed as being KVM_PUT_FULL_STATE
> regardless, or we re-introduce that bug.

Thanks for digging that up. I now recall also having read that history
back when I first discovered KVM_REG_ARM_TIMER_CNT was special.

>=20
> Your approach in this patchset reads and writes on vm-paused,
> so it won't have the pre-2015 problems.
>=20
> It still feels odd that we're storing this bit of guest state
> in two places now though -- in kvm_vtime, and also in its usual
> place in the cpreg_array data structures (we write back the
> value from kvm_vtime when the VM starts running, and we write
> back the value from the cpreg_array for a PUT_FULL_STATE, which
> the comments claim is only on startup or when we just loaded
> migration state (and also undocumentedly but reasonably on
> cpu-hotplug, which arm doesn't have yet).
>=20
> I've just spent a little while digging through code, and
> haven't been able to satisfy myself on the ordering of which
> writeback wins: for a loadvm I think we first do a
> cpu_synchronize_all_post_init() (writing back the counter
> value from the migration data) and then after than we will
> unpause the VM -- why doesn't this overwrite the correct
> value with the wrong value from kvm_vtime ?

Hmm... I think I may have gotten lost when I went through this before.
I just went through again, and still won't claim that I'm not a bit
lost, but it does appear I got it backwards. When I get a chance I'll
try to test this properly.

We could use the same location as normal, in the cpreg_array. I'd just
need to add a search of cpreg_indexes[] in order to get the index
needed for cpreg_values[].=20

>=20
> I just noticed also that the logic used in this patch
> doesn't match what other architectures do in their vm_state_change
> function -- eg cpu_ppc_clock_vm_state_change() has an
> "if (running) { load } else { save }", and kvmclock_vm_state_change()
> for i386 also has "if (running) { ... } else { ... }", though
> it has an extra wrinkle where it captures "are we PAUSED?"
> to use in the pre_save function; the comment above
> kvmclock_pre_save() suggests maybe that would be useful for other
> than x86, too. kvm_s390_tod_vm_state_change() has
> logic that's a slightly more complicated variation on just
> testing the 'running' flag, but it doesn't look at the
> specific new state.

Yes, originally I had just if (running) {} else {}, but after looking at
https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg03695.html and
seeing that the other architectures were careful to track the "are we
paused" state, I got the feeling that we should be more specific and
changed to if (running) {} else if (paused) {}. That's probably wrong,
though, if we want to track all vm-stopped time.

>=20
> > > I note also that the commit message there had a remark
> > > about inconsistencies between VCPUs -- is the right thing
> > > to handle this per-VM rather than per-VCPU somehow?
> >
> > per-VM would make sense, because the counters should be synchronized
> > among the VCPUs. KVM does that for us, though, so whichever VCPU last
> > restores its counter is the one that will determine the final value.
> >
> > Maybe we should have a VM ioctl instead, but ATM we only have VCPU ioct=
ls.
>=20
> I meant more "only do the save/load once per VM in QEMU but
> do it by working with just one VCPU". But I guess since migration
> works on all the VCPUs we're ok to do pause-resume the same way
> (and I've now tracked down what the 'inconsistentencies between VCPUs'
> were: they're when we were syncing the CNT value for one vCPU when
> others were still running.)
>=20
> thanks
> -- PMM
>=20

Thanks,
drew


