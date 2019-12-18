Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D625C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 15:13:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB6FB2146E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 15:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GgayuRYb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB6FB2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihb1I-0001KN-3A
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 10:13:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1ihazW-0007fp-0e
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 10:11:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1ihazU-0005zE-0w
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 10:11:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59931
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ihazT-0005l5-Cm
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 10:11:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576681910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4y3dxCgrBzf0atq0UaYCsV8MnPAsfK4jHvXp2ilPVWc=;
 b=GgayuRYbTP1dnGaBvYN7z6fwknsNS5Cysvpe9TrwXOkHkLIwIb5v1+BG+c2lcbg2Yx2zts
 t/kuQoAzlTTShYoz68UNuThyidUE6Q4A3nsFAsJYkC7oHY+kZw+anWNZ95rXOJ5xALkEaN
 FZoAmU+USKamCvYtk8zQ25rOXKbwI+c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-HmktsWCQOm-sgoWfNocuUA-1; Wed, 18 Dec 2019 10:11:47 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 524D9802B9A;
 Wed, 18 Dec 2019 15:11:46 +0000 (UTC)
Received: from localhost (ovpn-116-90.gru2.redhat.com [10.97.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF1FC6046B;
 Wed, 18 Dec 2019 15:11:45 +0000 (UTC)
Date: Wed, 18 Dec 2019 12:11:44 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] i386: pass CLZERO to guests with EPYC CPU model on AMD
 ZEN platform
Message-ID: <20191218151144.GN498046@habkost.net>
References: <1576659933-37123-1-git-send-email-ani.sinha@nutanix.com>
 <2883fd0e-191a-c5a4-be1c-04442c8de1c9@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2883fd0e-191a-c5a4-be1c-04442c8de1c9@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: HmktsWCQOm-sgoWfNocuUA-1
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
Cc: Ani Sinha <ani.sinha@nutanix.com>, qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 18, 2019 at 12:53:45PM +0100, Paolo Bonzini wrote:
> On 18/12/19 10:05, Ani Sinha wrote:
> > CLZERO CPUID should be passed on to the guests that use EPYC or EPYC-IB=
PB CPU
> > model when the AMD ZEN based host supports it. This change makes it rec=
ognize
> > this CPUID for guests which use EPYC or EPYC-IBPB CPU model.

Can you clarify what's the intended use case here?  Why the
"if host supports it" conditional?

If you need host-dependent CPU configuration, "-cpu host" (or the
libvirt "host-model" mode) is the most appropriate solution.

> >=20
> > Signed-off-by: Ani Sinha <ani.sinha@nutanix.com>
> > ---
> >  target/i386/cpu.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 69f518a..55f0691 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -3813,6 +3813,8 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
> >              CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A | CPUID_EXT3_ABM=
 |
> >              CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM |
> >              CPUID_EXT3_TOPOEXT,
> > +        .features[FEAT_8000_0008_EBX] =3D
> > +            CPUID_8000_0008_EBX_CLZERO,
> >          .features[FEAT_7_0_EBX] =3D
> >              CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EB=
X_AVX2 |
> >              CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_RD=
SEED |
> >=20
>=20
> This needs to be done only for newer machine type (or is it CPU model
> versions now? need Eduardo to respond).

If we want to add it, it has to be done as a new CPU model version.

But I don't know yet if we want to add it.  Do all EPYC CPUs have
CLZERO available?  If not, it's probably not advisable to add it
to EPYC (even if it's just on EPYC-v3).

--=20
Eduardo


