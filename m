Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32B2C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 13:11:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C39520776
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 13:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LeNz2Uy2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C39520776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPQme-0003pK-Ji
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 09:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33696)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1jPQld-0002zZ-27
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 09:10:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1jPQlZ-0002aq-HA
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 09:10:46 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59879
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1jPQlZ-0002a6-9z
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 09:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587129043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UIWGFNTVhWPNBow8DtRZ8iIscOSllsxNFMydloAjCDM=;
 b=LeNz2Uy2KNEQlzQEVJxGLaYBb6Tw8hZEyOiTs4ZXVPT64qfQrcUC0odUDhj6rxsdiK4QnG
 RMJbLG3vWGx9n/OcIqtUC9IUeOE3+dBdVACygsKNCQuzkmEL7BFayLhhSYbZOOd/ET1dYt
 o8zvYzvcw21oVqfL4ULGcANacxb0pC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-RZYgCtYdM9uF51XGOYBrDg-1; Fri, 17 Apr 2020 09:10:41 -0400
X-MC-Unique: RZYgCtYdM9uF51XGOYBrDg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 266518018A6;
 Fri, 17 Apr 2020 13:10:40 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.194.141])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B1D49120C00;
 Fri, 17 Apr 2020 13:10:35 +0000 (UTC)
Date: Fri, 17 Apr 2020 15:10:32 +0200
From: Andrew Jones <drjones@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v4 1/2] target/arm: kvm: Handle DABT with no valid ISS
Message-ID: <20200417131032.lcyunbjwofsn2nzz@kamzik.brq.redhat.com>
References: <20200323113227.3169-1-beata.michalska@linaro.org>
 <20200323113227.3169-2-beata.michalska@linaro.org>
 <CAFEAcA_uWS+cVRk=BKra8AhsD+B1syVzhXeCMttSKwQDdo=j3w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_uWS+cVRk=BKra8AhsD+B1syVzhXeCMttSKwQDdo=j3w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Beata Michalska <beata.michalska@linaro.org>, quintela@redhat.com,
 Christoffer Dall <Christoffer.Dall@arm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Apr 17, 2020 at 11:39:25AM +0100, Peter Maydell wrote:
> On Mon, 23 Mar 2020 at 11:32, Beata Michalska
> <beata.michalska@linaro.org> wrote:
> >
> > On ARMv7 & ARMv8 some load/store instructions might trigger a data abor=
t
> > exception with no valid ISS info to be decoded. The lack of decode info
> > makes it at least tricky to emulate those instruction which is one of t=
he
> > (many) reasons why KVM will not even try to do so.
> >
> > Add support for handling those by requesting KVM to inject external
> > dabt into the quest.
> >
> > Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
> > ---
> >  target/arm/cpu.h     |  2 ++
> >  target/arm/kvm.c     | 54 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  target/arm/kvm_arm.h | 11 +++++++++++
> >  3 files changed, 67 insertions(+)
> >
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index 4ffd991..4f834c1 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -560,6 +560,8 @@ typedef struct CPUARMState {
> >          uint64_t esr;
> >      } serror;
> >
> > +    uint8_t ext_dabt_pending; /* Request for injecting ext DABT */
>=20
> I was trying to work out whether we need to migrate this state,
> and I'm not sure. Andrew, do you know? I think this comes down
> to "at what points in QEMU's kvm run loop can migration kick in",
> and specifically if we get a KVM_EXIT_ARM_NISV do we definitely
> go round the loop and KVM_RUN again without ever checking
> to see if we should do a migration ?
>

I'd prefer a migration expert confirm this, so I've CC'ed David and Juan,
but afaict there's no way to break out of the KVM_RUN loop after a
successful (ret=3D0) call to kvm_arch_handle_exit() until after the next
KVM_RUN ioctl. This is because even if migration kicks the vcpus between
kvm_arch_handle_exit() and the next run, the signal won't do anything
other than prepare the vcpu for an immediate exit.

Thanks,
drew=20


