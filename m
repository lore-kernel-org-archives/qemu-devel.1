Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869C7C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 09:01:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51C57205C9
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 09:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwndYhxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C57205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iexs2-0003Qa-D9
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 04:01:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40193)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iexqu-0002nC-MF
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 04:00:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iexqr-0007z5-1O
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 04:00:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49060
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1iexqq-0007wV-Gp
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 04:00:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576054807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dsHsAeCyGP+9vg/yV/H6LJG7OyvEe3wO3zM0wa/wLoI=;
 b=RwndYhxdTxXfuLYil7CH1+SBJxmYwXQEea8szCsM+2C37GHO2CImvUC+b6kkkwhEM2qUN6
 zmSVpIrlUVhFbDx4ZaYd87NJzJE71lH9qstOCzrNW4FX467ufXl/7BUm1rIXvJY0W/K7m3
 uQavfg6SsErIBwhtAMI+T+7UeRXeM6s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-RBmE-DGYPhCnVrDWe5RguQ-1; Wed, 11 Dec 2019 04:00:06 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C23C48E30B0;
 Wed, 11 Dec 2019 09:00:04 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 178DF19756;
 Wed, 11 Dec 2019 09:00:02 +0000 (UTC)
Date: Wed, 11 Dec 2019 10:00:00 +0100
From: Andrew Jones <drjones@redhat.com>
To: Guoheyi <guoheyi@huawei.com>
Subject: Re: [PATCH v1 0/5] target/arm/kvm: Provide an option to adjust
 virtual time
Message-ID: <20191211090000.kajcyk7oqlqr3chk@kamzik.brq.redhat.com>
References: <20191016143410.5023-1-drjones@redhat.com>
 <CAFEAcA8j8M_J8Ocdpms8a2XufigVQ6oB4JBy2BcYAkXfJX5y5A@mail.gmail.com>
 <5679d43f-3f29-6ee1-0894-19ef2f3e08a2@huawei.com>
MIME-Version: 1.0
In-Reply-To: <5679d43f-3f29-6ee1-0894-19ef2f3e08a2@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: RBmE-DGYPhCnVrDWe5RguQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, bijan.mottahedeh@oracle.com,
 Marc Zyngier <maz@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 11, 2019 at 04:02:52PM +0800, Guoheyi wrote:
>=20
> =E5=9C=A8 2019/12/6 23:22, Peter Maydell =E5=86=99=E9=81=93:
> > On Wed, 16 Oct 2019 at 15:34, Andrew Jones <drjones@redhat.com> wrote:
> > > v2:
> > >   - move from RFC status to v1
> > >   - put kvm_arm_vm_state_change() in kvm.c to share among kvm32.c and=
 kvm64.c
> > >   - add r-b's from Richard
> > >=20
> > >=20
> > > This series is inspired by a series[1] posted by Bijan Mottahedeh abo=
ut
> > > a year ago.  The problem described in the cover letter of [1] is easi=
ly
> > > reproducible and some users would like to have the option to avoid it=
.
> > > However the solution, which is to adjust the virtual counter offset e=
ach
> > > time the VM transitions to the running state, introduces a different
> > > problem, which is that the virtual and physical counters diverge.  As
> > > described in the cover letter of [1] this divergence is easily observ=
ed
> > > when comparing the output of `date` and `hwclock` after suspending th=
e
> > > guest, waiting a while, and then resuming it.  Because this different
> > > problem may actually be worse for some users, unlike [1], the series
> > > posted here makes the virtual counter offset adjustment optional and =
not
> > > even enabled by default.  Besides the adjustment being optional, this
> > > series approaches the needed changes differently to apply them in mor=
e
> > > appropriate locations.  Finally, unlike [1], this series doesn't atte=
mpt
> > > to measure "pause time" itself.  Simply using QEMU_CLOCK_VIRTUAL, whi=
ch
> > > only ticks when the VM is not stopped, is sufficient.
> > So I guess my overall question is "what is the x86 solution to
> > this problem, and why is this all arm-specific?" It would also
> > be helpful to know how it fits into all the other proposals regarding
> > time in VMs.
>=20
> I also sent a RFC in March and ARM KVM experts were also invoved in the
> discussion:
>=20
> https://lists.cs.columbia.edu/pipermail/kvmarm/2019-March/035026.html
>=20
> According to the discussion, qemu on x86 is using KVM_KVMCLOCK_CTRL to
> request KVM to set a flag "PVCLOCK_GUEST_STOPPED" in pvclock, informing V=
M
> kernel about external force stop.
>=20
> Thanks,
>=20
> Heyi

Hi Heyi,

Apologies for having forgotten about that thread. I recall now having
followed it last March. Indeed it even addresses the issue in the way
we're coming around to now (save/restore vs. update with virtual time).

I just reread the whole thread, and my feeling is that, while there are
still many issues left to work, until we get a pvclock for arm, a patch
like this one, but with a way to opt-in/out in order to give users a
chance to choose their poison, is the best we can do. Also a patch like
this one is a step in the right direction, as it will be needed as part
of the bigger pvclock solution eventually, just as it is for x86.

One comment on the patch is that I would prefer to do the save/restore
for all VCPUs, even though KVM does currently handle synchronization.
Not only does it "feel" more correct to apply VCPU APIs to all VCPUs,
but I assume it will be less problematic to implement CPU hotplug at
some point.

Thanks,
drew


