Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EE8C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 22:38:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F174A2082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 22:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KcVkchrK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F174A2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izTJT-0005lq-3d
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 17:38:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1izTIu-0005Kr-19
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 17:37:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1izTIr-0006iE-Da
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 17:37:50 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32672
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1izTIr-0006i0-1d
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 17:37:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580942267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iz+qSUipjlMZWez+pgxx8mFfeZTQAIp1an7jT4OCwoc=;
 b=KcVkchrKWkXwmDLkuNuGxzpznuYDLUcJW3un/NT8eludjLRdK+awQ6bOjSA/O7ecaLpUDk
 Xhr2hJQcicEcdGP8UtA6Q8c4EwThR1FH4Ctv7zgMkdsKEQtfuMsG8IWK64TRyKo3YJWyLL
 qPIZjmF5OkRBnPBHsybpQHDmFYKc5z0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-V-2X9gXHONW3H647GpaNtg-1; Wed, 05 Feb 2020 17:37:33 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CEB9800D54;
 Wed,  5 Feb 2020 22:37:32 +0000 (UTC)
Received: from localhost (unused-10-15-17-6.yyz.redhat.com [10.15.17.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 95D53F6E8;
 Wed,  5 Feb 2020 22:37:31 +0000 (UTC)
Date: Wed, 5 Feb 2020 17:37:31 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Ani Sinha <ani.sinha@nutanix.com>
Subject: Re: [PATCH] i386: pass CLZERO to guests with EPYC CPU model on AMD
 ZEN platform
Message-ID: <20200205223731.GY25446@habkost.net>
References: <1576659933-37123-1-git-send-email-ani.sinha@nutanix.com>
 <2883fd0e-191a-c5a4-be1c-04442c8de1c9@redhat.com>
 <20191218151144.GN498046@habkost.net>
 <D67E411E-4398-4F1B-A397-E637BCD4F666@nutanix.com>
MIME-Version: 1.0
In-Reply-To: <D67E411E-4398-4F1B-A397-E637BCD4F666@nutanix.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: V-2X9gXHONW3H647GpaNtg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Babu Moger <babu.moger@amd.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Sorry for the delayed reply.  I was away from work for the whole
month of January.

On Mon, Jan 20, 2020 at 10:56:43AM +0000, Ani Sinha wrote:
> Sorry Eduardo, it took a little while for me to get to this thread again.
>=20
> > On Dec 18, 2019, at 8:41 PM, Eduardo Habkost <ehabkost@redhat.com> wrot=
e:
> >=20
> > On Wed, Dec 18, 2019 at 12:53:45PM +0100, Paolo Bonzini wrote:
> >> On 18/12/19 10:05, Ani Sinha wrote:
> >>> CLZERO CPUID should be passed on to the guests that use EPYC or EPYC-=
IBPB CPU
> >>> model when the AMD ZEN based host supports it. This change makes it r=
ecognize
> >>> this CPUID for guests which use EPYC or EPYC-IBPB CPU model.
> >=20
> > Can you clarify what's the intended use case here?  Why the
> > "if host supports it" conditional?
>=20
> Looking at https://www.amd.com/system/files/TechDocs/24594.pdf , it says =
:
>=20
> "The CLZERO instruction is supported if the feature flag CPUID Fn8000_000=
8_EBX[CLZERO] is set.=E2=80=9D
>=20
> This I interpreted to mean that not all AMD Zen architectures
> supports it. So when the host does support it, this CPUID
> should be passed on to the guest as well.

This is not a supported use case of named CPU models.  Named CPU
models should expose the same guest ABI on all hosts.  This means
CPUID should be the same on all hosts if using the same CPU
model (and same machine type).

If you need features to be automatically enabled/disabled
depending on host capabilities, I advise you to use "-cpu host"
or libvirt's mode=3Dhost-model.

>=20
>=20
> >=20
> > If you need host-dependent CPU configuration, "-cpu host" (or the
> > libvirt "host-model" mode) is the most appropriate solution.
>=20
> Yes that is an option but we are going to use EPYC-IBPB model for now.=20
>=20
>=20
> >=20
> >>>=20
> >>> Signed-off-by: Ani Sinha <ani.sinha@nutanix.com>
> >>> ---
> >>> target/i386/cpu.c | 2 ++
> >>> 1 file changed, 2 insertions(+)
> >>>=20
> >>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> >>> index 69f518a..55f0691 100644
> >>> --- a/target/i386/cpu.c
> >>> +++ b/target/i386/cpu.c
> >>> @@ -3813,6 +3813,8 @@ static X86CPUDefinition builtin_x86_defs[] =3D =
{
> >>>             CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A | CPUID_EXT3_AB=
M |
> >>>             CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM |
> >>>             CPUID_EXT3_TOPOEXT,
> >>> +        .features[FEAT_8000_0008_EBX] =3D
> >>> +            CPUID_8000_0008_EBX_CLZERO,
> >>>         .features[FEAT_7_0_EBX] =3D
> >>>             CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_E=
BX_AVX2 |
> >>>             CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_R=
DSEED |
> >>>=20
> >>=20
> >> This needs to be done only for newer machine type (or is it CPU model
> >> versions now? need Eduardo to respond).
> >=20
> > If we want to add it, it has to be done as a new CPU model version.
>=20
> I see what you mean.=20
>=20
> >=20
> > But I don't know yet if we want to add it.  Do all EPYC CPUs have
> > CLZERO available?  If not, it's probably not advisable to add it
> > to EPYC (even if it's just on EPYC-v3).
>=20
> Ok so I think we need to get this clarified from AMD if all
> their EPYC platforms supports this CPUID or not. Is there any
> contact point within AMD where we can get this information?

I'm CCing Brijesh Singh and Babu Moger, who works on the EPYC CPU
model recently.

>=20
> For our use case, I just verified that even without this patch,
> if we pass CLZERO through libvirt CPU definition xml, like "
> <feature policy=3D'require' name=3D'clzero=E2=80=99/>=E2=80=9D, it gets p=
assed on
> to the guest. So this patch is not super critical for us.

Note that this is done automatically by libvirt if using
mode=3Dhost-model.

--=20
Eduardo


