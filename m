Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C55C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 11:06:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1298220726
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 11:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQuZzC0n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1298220726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iedLe-0002Zm-36
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 06:06:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iedKr-0001av-PZ
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 06:05:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iedKn-0004VL-Tt
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 06:05:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54003
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1iedKn-0004VA-MN
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 06:05:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575975941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z5V5YY8ucihfErt16zYIpWs1KUH/OqX2XpnQG4ohYVk=;
 b=HQuZzC0nxs07fYH9XUT2bo/Wl4anCwgOw0X/6eblk1ZElZPA/Ql/trsJ8pxWCSeuIz3T32
 pwdlbnNBOyBA91THJG5bnT66/6RlIFrHm2XVmyQbEd4TNW82vUROWZmTiGONz9jnM1r9yp
 9MAs9PIFCYxvVZ9TbHM8HCYWO4r4uB8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-SR1kMiVrPKmk2g8b02wheA-1; Tue, 10 Dec 2019 06:05:37 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64049802C9B;
 Tue, 10 Dec 2019 11:05:36 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FD236FDCE;
 Tue, 10 Dec 2019 11:05:33 +0000 (UTC)
Date: Tue, 10 Dec 2019 12:05:31 +0100
From: Andrew Jones <drjones@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v1 0/5] target/arm/kvm: Provide an option to adjust
 virtual time
Message-ID: <20191210110531.psjzlikir2ep2omo@kamzik.brq.redhat.com>
References: <20191016143410.5023-1-drjones@redhat.com>
 <CAFEAcA8j8M_J8Ocdpms8a2XufigVQ6oB4JBy2BcYAkXfJX5y5A@mail.gmail.com>
 <20191206155327.7adiyjjkjh56mg2t@kamzik.brq.redhat.com>
 <596d07e933cb4da48dbba5b492e81a2438e78a2f.camel@redhat.com>
 <CAFEAcA9+G0jprsHRQp8g=Aso+2-_GhoWkDGx4WWxoC88maOKEg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9+G0jprsHRQp8g=Aso+2-_GhoWkDGx4WWxoC88maOKEg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: SR1kMiVrPKmk2g8b02wheA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
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
Cc: bijan.mottahedeh@oracle.com, Marc Zyngier <maz@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrea Bolognani <abologna@redhat.com>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Dec 10, 2019 at 10:29:22AM +0000, Peter Maydell wrote:
> On Tue, 10 Dec 2019 at 09:51, Andrea Bolognani <abologna@redhat.com> wrot=
e:
> >
> > On Fri, 2019-12-06 at 16:53 +0100, Andrew Jones wrote:
> > > On Fri, Dec 06, 2019 at 03:22:58PM +0000, Peter Maydell wrote:
> > > > On Wed, 16 Oct 2019 at 15:34, Andrew Jones <drjones@redhat.com> wro=
te:
> > > > > This series is inspired by a series[1] posted by Bijan Mottahedeh=
 about
> > > > > a year ago.  The problem described in the cover letter of [1] is =
easily
> > > > > reproducible and some users would like to have the option to avoi=
d it.
> > > > > However the solution, which is to adjust the virtual counter offs=
et each
> > > > > time the VM transitions to the running state, introduces a differ=
ent
> > > > > problem, which is that the virtual and physical counters diverge.=
  As
> > > > > described in the cover letter of [1] this divergence is easily ob=
served
> > > > > when comparing the output of `date` and `hwclock` after suspendin=
g the
> > > > > guest, waiting a while, and then resuming it.  Because this diffe=
rent
> > > > > problem may actually be worse for some users, unlike [1], the ser=
ies
> > > > > posted here makes the virtual counter offset adjustment optional =
and not
> > > > > even enabled by default.  Besides the adjustment being optional, =
this
> > > > > series approaches the needed changes differently to apply them in=
 more
> > > > > appropriate locations.  Finally, unlike [1], this series doesn't =
attempt
> > > > > to measure "pause time" itself.  Simply using QEMU_CLOCK_VIRTUAL,=
 which
> > > > > only ticks when the VM is not stopped, is sufficient.
> > > >
> > > > So I guess my overall question is "what is the x86 solution to
> > > > this problem, and why is this all arm-specific?" It would also
> > >
> > > x86 adjusts the counter offset by default, and I don't think there's =
any
> > > way to turn that behavior off. I think it's too late to follow that
> > > default for arm, but this series provides a way to opt into the same
> > > behavior.
> >
> > My understanding is that turning kvm-adjvtime either on or off
> > results in a different set of advantages and drawbacks, with neither
> > begin a one-size-fits-all solution. So it's good that we offer a way
> > for the user to pick one or the other based on their specific needs.
>=20
> If this is the case, shouldn't we be looking at having the
> option exist for all architectures, not just arm? Obviously
> pre-existing behaviour would imply having the default have
> to differ for some archs/machines.
>

x86 developers could easily add this feature if/when they need a way to
disable their current default behavior. But, since the kvm-adjvtime
default would likely be 'on' for them, then they'd probably prefer the
feature be named kvm-no-adjvtime, and default 'off'. Should we try to
anticipate what x86 might want when naming this feature? IMO, we should
not, especially because I'm doubtful that x86 will ever want to implement
it. Also, what about the other KVM capable architectures? Which defaults
do they have now? And do we expect them to want to expose a switch to the
user to change it?

OTOH, I agree with Andrea that it would be nice if arm had the same
default as x86, allowing the documentation regarding this stuff to apply
to both. If we did choose to turn this feature on by default for virt-5.0,
then maybe we should introduce the feature with the name kvm-no-adjvtime
instead.

Thanks,
drew


