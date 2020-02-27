Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BB1C3F2C1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 21:10:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24EAA2469F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 21:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FdiGpmBJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24EAA2469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7QQP-0004mo-9N
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 16:10:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37229)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1j7QPn-0004Gf-Md
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 16:09:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1j7QPl-0005I8-SB
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 16:09:50 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40953
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1j7QPl-0005HL-O0
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 16:09:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582837788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+uKzgDkReUE3yEYadCxRh+6g/RZ+WXc8FImNkXyb1sI=;
 b=FdiGpmBJeGKPiPSN661cAUrbOQU80gU9sEIzfGa5Iz+HX25wIfU5lLHA7dxZ1MONFxeBPg
 rtbk7IP/pbJ/wHoqukQUjjqY2i9XNN2PhxzzAxQmBhSy7vqd0MODVdbGb3pmGjpIQ0zG8j
 Nf4kf2riH9eJ7LKZhFACfcQRpXWBxw8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-2dkElgrJM02y37UYq1h3eA-1; Thu, 27 Feb 2020 16:09:46 -0500
X-MC-Unique: 2dkElgrJM02y37UYq1h3eA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 108B713E6;
 Thu, 27 Feb 2020 21:09:45 +0000 (UTC)
Received: from localhost (unused-10-15-17-6.yyz.redhat.com [10.15.17.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7332C60BE0;
 Thu, 27 Feb 2020 21:09:44 +0000 (UTC)
Date: Thu, 27 Feb 2020 16:09:43 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Sunil Muthuswamy <sunilmut@microsoft.com>
Subject: Re: [PATCH] WHPX: Use QEMU values for trapped CPUID
Message-ID: <20200227210943.GJ4440@habkost.net>
References: <SN4PR2101MB0880A8323EAD0CD0E8E2F423C0EB0@SN4PR2101MB0880.namprd21.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <SN4PR2101MB0880A8323EAD0CD0E8E2F423C0EB0@SN4PR2101MB0880.namprd21.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 27, 2020 at 09:01:04PM +0000, Sunil Muthuswamy wrote:
> Currently, WHPX is using some default values for the trapped CPUID
> functions. These were not in sync with the QEMU values because the
> CPUID values were never set with WHPX during VCPU initialization.
> Additionally, at the moment, WHPX doesn't support setting CPUID
> values in the hypervisor at runtime (i.e. after the partition has
> been setup). That is needed to be able to set the CPUID values in
> the hypervisor during VCPU init.
> Until that support comes, use the QEMU values for the trapped CPUIDs.
>=20
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>

I like the change, but I wonder if any if your users would still
prefer to use the default result chosen by WHPX instead of the
ones chosen by QEMU.

On the KVM side I have always wondered if we should have a mode
where all CPUID leaves are the ones chosen by KVM, making no
KVM_SET_CPUID calls.  It would be useful for experimentation and
debugging of KVM/QEMU defaults.


> ---
>  target/i386/whpx-all.c | 42 ++++++++++++++++++------------------------
>  1 file changed, 18 insertions(+), 24 deletions(-)
>=20
> diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
> index 35601b8176..4fe5a78b29 100644
> --- a/target/i386/whpx-all.c
> +++ b/target/i386/whpx-all.c
> @@ -980,38 +980,32 @@ static int whpx_vcpu_run(CPUState *cpu)
>              WHV_REGISTER_VALUE reg_values[5];
>              WHV_REGISTER_NAME reg_names[5];
>              UINT32 reg_count =3D 5;
> -            UINT64 rip, rax, rcx, rdx, rbx;
> +            UINT64 cpuid_fn, rip =3D 0, rax =3D 0, rcx =3D 0, rdx =3D 0,=
 rbx =3D 0;
> +            X86CPU *x86_cpu =3D X86_CPU(cpu);
> +            CPUX86State *env =3D &x86_cpu->env;
> =20
>              memset(reg_values, 0, sizeof(reg_values));
> =20
>              rip =3D vcpu->exit_ctx.VpContext.Rip +
>                    vcpu->exit_ctx.VpContext.InstructionLength;
> -            switch (vcpu->exit_ctx.CpuidAccess.Rax) {
> -            case 1:
> -                rax =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
> -                /* Advertise that we are running on a hypervisor */
> -                rcx =3D
> -                    vcpu->exit_ctx.CpuidAccess.DefaultResultRcx |
> -                    CPUID_EXT_HYPERVISOR;
> -
> -                rdx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
> -                rbx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
> -                break;
> +            cpuid_fn =3D vcpu->exit_ctx.CpuidAccess.Rax;
> +
> +            /*
> +             * Ideally, these should be supplied to the hypervisor durin=
g VCPU
> +             * initialization and it should be able to satisfy this requ=
est.
> +             * But, currently, WHPX doesn't support setting CPUID values=
 in the
> +             * hypervisor once the partition has been setup, which is to=
o late
> +             * since VCPUs are realized later. For now, use the values f=
rom
> +             * QEMU to satisfy these requests, until WHPX adds support f=
or
> +             * being able to set these values in the hypervisor at runti=
me.
> +             */
> +            cpu_x86_cpuid(env, cpuid_fn, 0, (UINT32 *)&rax, (UINT32 *)&r=
bx,
> +                (UINT32 *)&rcx, (UINT32 *)&rdx);
> +            switch (cpuid_fn) {
>              case 0x80000001:
> -                rax =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
>                  /* Remove any support of OSVW */
> -                rcx =3D
> -                    vcpu->exit_ctx.CpuidAccess.DefaultResultRcx &
> -                    ~CPUID_EXT3_OSVW;
> -
> -                rdx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
> -                rbx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
> +                rcx &=3D ~CPUID_EXT3_OSVW;
>                  break;
> -            default:
> -                rax =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
> -                rcx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRcx;
> -                rdx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
> -                rbx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
>              }
> =20
>              reg_names[0] =3D WHvX64RegisterRip;
> --=20
> 2.17.1
>=20

--=20
Eduardo


