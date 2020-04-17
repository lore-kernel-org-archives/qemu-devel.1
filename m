Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A3FC2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 19:16:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 514082076D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 19:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSV16RgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 514082076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPWTh-0000mk-Hb
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 15:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60170)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jPWSV-0008FM-8Q
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 15:15:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jPWST-000476-5m
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 15:15:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44845
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jPWST-00045K-0O
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 15:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587150924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MEhB/OyykWO2OkIVhBuDuZl5ra8QacGxxwL4NJe9+J0=;
 b=QSV16RgRGA6+BhVph66JzR3ymkyQsqT1XIxYAdTLVoKasMYhgcsvdy8b70C2c58CQWEnNR
 QJ+HTdAUqnfPFlniXKEoQHDKQnYKktaLQSnz/yKla2REKBbgNDsGQH01l88dIbSLUzeVWh
 /44A8dkpsO8qqM4yAUTtxME9oARBhtw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-jn7c0a8IO1OQDCilsMgepw-1; Fri, 17 Apr 2020 15:15:16 -0400
X-MC-Unique: jn7c0a8IO1OQDCilsMgepw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF046107ACC9;
 Fri, 17 Apr 2020 19:15:14 +0000 (UTC)
Received: from localhost (ovpn-114-67.phx2.redhat.com [10.3.114.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 799DC9E0D4;
 Fri, 17 Apr 2020 19:15:14 +0000 (UTC)
Date: Fri, 17 Apr 2020 15:15:13 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH] target/i386: Fix the CPUID leaf CPUID_Fn80000008
Message-ID: <20200417191513.GD4952@habkost.net>
References: <20200417151432.46867.72601.stgit@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200417151432.46867.72601.stgit@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: pbonzini@redhat.com, imammedo@redhat.com, 1871842@bugs.launchpad.net,
 qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Good catch, thanks for the patch.  Comments below:

On Fri, Apr 17, 2020 at 10:14:32AM -0500, Babu Moger wrote:
> CPUID leaf CPUID_Fn80000008_ECX provides information about the
> number of threads supported by the processor. It was found that
> the field ApicIdSize(bits 15-12) was not set correctly.
>=20
> ApicIdSize is defined as the number of bits required to represent
> all the ApicId values within a package.
>=20
> Valid Values: Value Description
> 3h-0h=09=09Reserved.
> 4h=09=09up to 16 threads.
> 5h=09=09up to 32 threads.
> 6h=09=09up to 64 threads.
> 7h=09=09up to 128 threads.
> Fh-8h=09=09Reserved.
>=20
> Fix the bit appropriately.
>=20
> This came up during following thread.
> https://lore.kernel.org/qemu-devel/158643709116.17430.1599506912571677894=
3.malonedeb@wampee.canonical.com/#t
>=20
> Refer the Processor Programming Reference (PPR) for AMD Family 17h
> Model 01h, Revision B1 Processors. The documentation is available
> from the bugzilla Link below.
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537
>=20
> Reported-by: Philipp Eppelt <1871842@bugs.launchpad.net>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  target/i386/cpu.c |   12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 90ffc5f..68210f6 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5830,11 +5830,17 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t ind=
ex, uint32_t count,
>              *eax =3D cpu->phys_bits;
>          }
>          *ebx =3D env->features[FEAT_8000_0008_EBX];
> -        *ecx =3D 0;
> -        *edx =3D 0;
>          if (cs->nr_cores * cs->nr_threads > 1) {
> -            *ecx |=3D (cs->nr_cores * cs->nr_threads) - 1;

I'm not sure we want a compatibility flag to keep ABI on older
machine types, here.  Strictly speaking, CPUID must never change
on older machine types, but sometimes trying hard to emulate bugs
of old QEMU versions is a pointless exercise.


> +            unsigned int max_apicids, bits_required;
> +
> +            max_apicids =3D (cs->nr_cores * cs->nr_threads) - 1;
> +            /* Find out the number of bits to represent all the apicids =
*/
> +            bits_required =3D 32 - clz32(max_apicids);

This won't work if nr_cores > 1 and nr_threads is not a power of
2, will it?

For reference, the field is documented[1] as:

"The number of bits in the initial Core::X86::Apic::ApicId[ApicId]
value that indicate thread ID within a package"

This sounds like the value already stored at
CPUX86State::pkg_offset.


> +            *ecx =3D bits_required << 12 | max_apicids;

Bits 7:0 are documented as "The number of threads in the package
is NC+1", with no reference to APIC IDs at all.

Using ((nr_cores * nr_threads) - 1) for bits 7:0 sounds correct,
but the variable name seems misleading.


> +        } else {
> +            *ecx =3D 0;
>          }
> +        *edx =3D 0;
>          break;
>      case 0x8000000A:
>          if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
>=20
>=20

References:

[1] Processor Programming Reference (PPR) for
    AMD Family 17h Model 18h, Revision B1 Processors
    55570-B1 Rev 3.14 - Sep 26, 2019
    https://bugzilla.kernel.org/attachment.cgi?id=3D287395&action=3Dedit


--=20
Eduardo


