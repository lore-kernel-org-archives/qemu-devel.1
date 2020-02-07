Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B967C2D0B1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 07:42:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 367D220726
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 07:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dx4iYg4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 367D220726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izyHv-0003Fx-Ej
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 02:42:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37428)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1izyGX-00015X-Ko
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:41:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1izyGW-00009J-Hx
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:41:29 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45177
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1izyGW-00009A-Dd
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:41:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581061288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H8+dV5qOgRpncSSzSUiwmdaiC4cKdUtEBCRqg7fQpDw=;
 b=Dx4iYg4q4qOyGixN9qnuvAPKSXw2zJa1e/t99LL7OJkRnQXnz352PTfS3+g6WoBX9P/sQ6
 V4GSTy0KphUAiCf+YsskhHF+5wdiTB00hdVhVxFjHscquUpWaQnW/DUC4xeziHg1wGinrA
 lfpp/1L5A4yCFJGKu+yuoql1JJeqzIM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-x4rM60IcNg6d6naFPLjCbQ-1; Fri, 07 Feb 2020 02:41:25 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75396801E6C;
 Fri,  7 Feb 2020 07:41:24 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DC0771000325;
 Fri,  7 Feb 2020 07:41:22 +0000 (UTC)
Date: Fri, 7 Feb 2020 08:41:20 +0100
From: Andrew Jones <drjones@redhat.com>
To: Beata Michalska <beata.michalska@linaro.org>
Subject: Re: [PATCH v2 1/2] target/arm: kvm: Inject events at the last stage
 of sync
Message-ID: <20200207074120.emuqo4syqubpay4k@kamzik.brq.redhat.com>
References: <20200129202441.12745-1-beata.michalska@linaro.org>
 <20200129202441.12745-2-beata.michalska@linaro.org>
 <20200204103447.naw26xl2y2zbyrqb@kamzik.brq.redhat.com>
 <CADSWDzuQvZThaoFbeYM2QrDbwRPrZuiyDrVJV=jxiSMTW9O-rg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CADSWDzuQvZThaoFbeYM2QrDbwRPrZuiyDrVJV=jxiSMTW9O-rg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: x4rM60IcNg6d6naFPLjCbQ-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Christoffer Dall <Christoffer.Dall@arm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 06, 2020 at 09:41:10PM +0000, Beata Michalska wrote:
> On Tue, 4 Feb 2020 at 10:34, Andrew Jones <drjones@redhat.com> wrote:
> >
> > On Wed, Jan 29, 2020 at 08:24:40PM +0000, Beata Michalska wrote:
> > > KVM_SET_VCPU_EVENTS might actually lead to vcpu registers being modif=
ied.
> > > As such this should be the last step of sync to avoid potential overw=
riting
> > > of whatever changes KVM might have done.
> > >
> > > Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
> > > ---
> > >  target/arm/kvm32.c | 20 ++++++++++----------
> > >  target/arm/kvm64.c | 20 ++++++++++----------
> > >  2 files changed, 20 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
> > > index 32bf8d6..cf2b47f 100644
> > > --- a/target/arm/kvm32.c
> > > +++ b/target/arm/kvm32.c
> > > @@ -386,17 +386,17 @@ int kvm_arch_put_registers(CPUState *cs, int le=
vel)
> > >          return ret;
> > >      }
> > >
> > > -    ret =3D kvm_put_vcpu_events(cpu);
> > > -    if (ret) {
> > > -        return ret;
> > > -    }
> > > -
> > >      write_cpustate_to_list(cpu, true);
> > >
> > >      if (!write_list_to_kvmstate(cpu, level)) {
> > >          return EINVAL;
> > >      }
> > >
> > > +    ret =3D kvm_put_vcpu_events(cpu);
> > > +    if (ret) {
> > > +        return ret;
> > > +    }
> > > +
> >
> > I think we should put a comment above this that says basically the same
> > thing as the commit message in order to explain why kvm_put_vcpu_events=
()
> > *must* be after write_list_to_kvmstate().
> >
> Will do that.
>=20
> > >      kvm_arm_sync_mpstate_to_kvm(cpu);
> > >
> > >      return ret;
> > > @@ -462,11 +462,6 @@ int kvm_arch_get_registers(CPUState *cs)
> > >      }
> > >      vfp_set_fpscr(env, fpscr);
> > >
> > > -    ret =3D kvm_get_vcpu_events(cpu);
> > > -    if (ret) {
> > > -        return ret;
> > > -    }
> > > -
> > >      if (!write_kvmstate_to_list(cpu)) {
> > >          return EINVAL;
> > >      }
> > > @@ -475,6 +470,11 @@ int kvm_arch_get_registers(CPUState *cs)
> > >       */
> > >      write_list_to_cpustate(cpu);
> > >
> > > +    ret =3D kvm_get_vcpu_events(cpu);
> > > +    if (ret) {
> > > +        return ret;
> > > +    }
> > > +
> >
> > Why are we moving kvm_get_vcpu_events()?
>=20
> This is only to make things consistent with put_registeres.
> There is no functional change per se.

Without a functional change I wouldn't move it. It's much
more appealing to have the final state writes at the bottom
of this function.

Thanks,
drew


