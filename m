Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8325AC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:11:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DD312077B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FcVlzrbw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD312077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iei75-0006wa-EK
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 11:11:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iei6P-0006UJ-M4
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:11:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iei6O-00070m-Kf
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:11:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51817
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1iei6O-00070K-Ga
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:11:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575994267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RL1wQzjB7ueQUertKiln5v+WwAvPFcgduWuDddphhwE=;
 b=FcVlzrbwu5/V1u1OmZm1IcNsjqEC0sgDLr8pcFpNKiotaRBlLNE87GLa0xGqjQXl0l76Nv
 d4fE9AdORDFjbtJPWUgLIqLqAfw3ujWjkR5TFS2O769LDGSMW7AI4oQr2SxWs/h2Avtbx3
 o0gg8NVdR74XbAaxv8E+G04LAQNtoMg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-TZK-Us21OFCP-9rmFixakg-1; Tue, 10 Dec 2019 11:11:04 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF551803BC4;
 Tue, 10 Dec 2019 16:11:02 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A2E5A5C21B;
 Tue, 10 Dec 2019 16:11:01 +0000 (UTC)
Date: Tue, 10 Dec 2019 17:10:58 +0100
From: Andrew Jones <drjones@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v1 3/5] target/arm/kvm: Implement cpu feature kvm-adjvtime
Message-ID: <20191210161058.f4ysoukuhf6k62xl@kamzik.brq.redhat.com>
References: <20191016143410.5023-1-drjones@redhat.com>
 <20191016143410.5023-4-drjones@redhat.com>
 <CAFEAcA-uP9eAMu=S98hv7Ge_3GU42acpfvWDMmcMSKagnD9rsQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-uP9eAMu=S98hv7Ge_3GU42acpfvWDMmcMSKagnD9rsQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: TZK-Us21OFCP-9rmFixakg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Marc Zyngier <maz@kernel.org>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, bijan.mottahedeh@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Dec 10, 2019 at 03:54:11PM +0000, Peter Maydell wrote:
> On Wed, 16 Oct 2019 at 15:34, Andrew Jones <drjones@redhat.com> wrote:
> >
> > When kvm-adjvtime is enabled the guest's cntvct[_el0] won't count
> > the time when the VM is stopped. That time is skipped by updating
> > cntvoff[_el2] on each transition to vm_running using the current
> > QEMU_CLOCK_VIRTUAL time. QEMU_CLOCK_VIRTUAL only ticks when the VM
> > is running.
> >
> > This patch only provides the implementation. A subsequent patch
> > will provide the CPU property allowing the feature to be enabled.
>=20
>=20
> > +void kvm_arm_set_virtual_time(CPUState *cs)
> > +{
> > +    uint64_t cnt;
> > +    struct kvm_one_reg reg =3D {
> > +        .id =3D KVM_REG_ARM_TIMER_CNT,
> > +        .addr =3D (uintptr_t)&cnt,
> > +    };
> > +    int ret;
> > +
> > +    cnt =3D muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> > +                   cpu_get_host_tick_frequency(),
> > +                   NANOSECONDS_PER_SECOND);
> > +
> > +    ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> > +    if (ret) {
> > +        error_report("Failed to set KVM_REG_ARM_TIMER_CNT");
> > +        abort();
> > +    }
>=20
> The commit message (and the doc comment for this function)
> say that we're updating the counter offset, but the
> kvm_one_reg operation here is updating the timer count
> (and relying on the kernel's handling of "if we update
> the timer count implement that by changing the offset").
> That seems a bit confusing.
>=20
> Would it be possible to implement "cntvct should not change while the
> VM is stopped" with "read cntvct when the VM stops, and just write
> back that value when the VM is restarted", rather than
> "write back a new value calculated from QEMU_CLOCK_VIRTUAL"?
> If I understand commit 00f4d64ee76e873be8 correctly, that's
> basically how x86 is doing it. It would also let you sidestep
> the need to know the tick frequency of the counter.

That's definitely worth some experimenting. Will do.

Thanks,
drew


