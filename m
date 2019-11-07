Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4301C5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 19:18:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A51DF21D79
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 19:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ci0frrB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51DF21D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSnIW-0006Uy-SH
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 14:18:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44161)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iSnH6-00061O-0S
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 14:16:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iSnH4-00012M-38
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 14:16:55 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25760
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iSnH2-00011J-0p
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 14:16:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573154211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6dk/54AOJd/w53p/v3z6WZiqwgOizhASa42ED5Fnwcg=;
 b=ci0frrB+io/ekjY9xy+u/MvLU5pXQRq6q9nyzxJKKkxd+hIiey5OQQ7HB5khB+XIfSFe68
 autuuPh/330sNv3GGU1Pau6SCkuYwLb4GBR112U9u3TZvlcRRI52WP0F+SVGdvc2tjQbyW
 DEwWJs859/pBXF6VeX7eQtyeg0DbxUE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-s5SBSjLZPNeI_Hphbbwqkw-1; Thu, 07 Nov 2019 14:16:49 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96A2E800C61;
 Thu,  7 Nov 2019 19:16:48 +0000 (UTC)
Received: from localhost (ovpn-116-57.gru2.redhat.com [10.97.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 21DBD5DA76;
 Thu,  7 Nov 2019 19:16:47 +0000 (UTC)
Date: Thu, 7 Nov 2019 16:16:46 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Kang, Luwei" <luwei.kang@intel.com>
Subject: Re: [PATCH v1 Resend] target/i386: set the CPUID level to 0x14 on
 old machine-type
Message-ID: <20191107191646.GV3812@habkost.net>
References: <1572416882-41378-1-git-send-email-luwei.kang@intel.com>
 <20191105211303.GK3812@habkost.net>
 <82D7661F83C1A047AF7DC287873BF1E173838407@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <82D7661F83C1A047AF7DC287873BF1E173838407@SHSMSX104.ccr.corp.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: s5SBSjLZPNeI_Hphbbwqkw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 06, 2019 at 12:55:32AM +0000, Kang, Luwei wrote:
> > > The CPUID level need to be set to 0x14 manually on old machine-type i=
f
> > > Intel PT is enabled in guest. e.g. in Qemu 3.1 -machine pc-i440fx-3.1
> > > -cpu qemu64,+intel-pt will be CPUID[0].EAX(level)=3D7 and
> > > CPUID[7].EBX[25](intel-pt)=3D1.
> > >
> > > Some Intel PT capabilities are exposed by leaf 0x14 and the missing
> > > capabilities will cause some MSRs access failed.
> > > This patch add a warning message to inform the user to extend the
> > > CPUID level.
> >=20
> > Note that a warning is not an acceptable fix for a QEMU crash.
> > We still need to fix the QEMU crash reported at:
> > https://lore.kernel.org/qemu-devel/20191024141536.GU6744@habkost.net/
> >=20
> >=20
> > >
> > > Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> > > Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> >=20
> > The subject line says "v1", but this patch is different from the
> > v1 you sent earlier.
> >=20
> > If you are sending a different patch, please indicate it is a new versi=
on.  Please also
> > indicate what changed between different patch versions, to help review.
>=20
> Got it. I fix a code style problem in resending patch (remove the '\n').
>=20
> ERROR: Error messages should not contain newlines
> #36: FILE: target/i386/cpu.c:5448:
> +                            "by \"-cpu ...,+intel-pt,level=3D0x14\"\n");
> total: 1 errors, 0 warnings, 14 lines checked
>=20
> >=20
> > > ---
> > >  target/i386/cpu.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c index
> > > a624163..f67c479 100644
> > > --- a/target/i386/cpu.c
> > > +++ b/target/i386/cpu.c
> > > @@ -5440,8 +5440,12 @@ static void x86_cpu_expand_features(X86CPU
> > > *cpu, Error **errp)
> > >
> > >          /* Intel Processor Trace requires CPUID[0x14] */
> > >          if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &=
&
> > > -             kvm_enabled() && cpu->intel_pt_auto_level) {
> >=20
> > Not directly related to the warning: do you know why we have a
> > kvm_enabled() check here?  It seems unnecessary.  We want CPUID level t=
o be correct
> > for all accelerators.
>=20
> Intel PT virtualization enabling in KVM guest need some hardware enhancem=
ent and
> EPT must be enabled in KVM.  I think it can't work for e.g. tcg pure simu=
lation accelerator.

I don't get it.  If what you are saying is true, checking for
kvm_enabled() here is completely unnecessary.  If it is not,
checking for kvm_enabled() here is incorrect.


>=20
> >=20
> > > -            x86_cpu_adjust_level(cpu, &cpu->env.cpuid_min_level, 0x1=
4);
> > > +             kvm_enabled()) {
> > > +            if (cpu->intel_pt_auto_level)
> > > +                x86_cpu_adjust_level(cpu, &cpu->env.cpuid_min_level,=
 0x14);
> > > +            else
> > > +                warn_report("Intel PT need CPUID leaf 0x14, please s=
et "
> > > +                            "by \"-cpu ...,+intel-pt,level=3D0x14\""=
);
> >=20
> > The warning shouldn't be triggered if level is already >=3D 0x14.
> >=20
> > It is probably a good idea to mention that this happens only on
> > pc-*-3.1 and older, as updating the machine-type is a better solution t=
o the problem
> > than manually setting the "level"
> > property.
> >=20
> > This will print the warning multiple times if there are multiple VCPUs.=
  You can use
> > warn_report_once() to avoid that.
>=20
> Got it. Will fix.
>=20
> As you mentioned in this email " a warning is not an acceptable fix for a=
 QEMU crash."
> We can't change the configuration of the old machine type because it may =
break the
> ABI compatibility. May I add more check on Intel PT, if CPUID[7].EBX[25] =
(intel-pt) =3D 1
> and level is <0x14, mask off this feature? Or do you have any other sugge=
stions?

Masking off the feature if level is < 0x14 would possibly work if
we are 100% sure that existing kernel+QEMU versions crashed when
  (intel-pt=3Don && level < 0x14)
so there's no ABI compatibility with working configurations to
worry about.  But it would be even better to make kvm_put_msrs()
less fragile.  Unexpected CPUID data shouldn't make the function
crash.

--=20
Eduardo


