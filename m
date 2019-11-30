Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F213C432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 08:32:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1191C2082E
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 08:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="jlFja19H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1191C2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iayB7-0006va-9R
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 03:32:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1iayA8-0006Tp-5L
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 03:31:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1iayA7-00044I-41
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 03:31:32 -0500
Received: from ma1-aaemail-dr-lapp01.apple.com ([17.171.2.60]:48198)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1iayA6-00041c-RR
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 03:31:31 -0500
Received: from pps.filterd (ma1-aaemail-dr-lapp01.apple.com [127.0.0.1])
 by ma1-aaemail-dr-lapp01.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 xAU8R3ah036192; Sat, 30 Nov 2019 00:31:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : content-type
 : mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=eGUHB1ln+Tw9CnwnWZGhUjlpzAArqXX/2qD5+2U7Jls=;
 b=jlFja19HPdWhs3Wps7wYJIL5WzoxH6e2ohLUp0bBIbOG0ihWciSU7rg51GyXoBBRtFTt
 P6dPlWORDBkrJC3YwRVFpjoumHBOR6NKDLS5/G9o5eUHeGX79RBE/4DyZ9ZLC0mAVnTm
 1VwMnL7aygsK7m68FGVbJRB+gNK4H6Ktn13k9HZzlJsX9f1mhbpEKfdGPyJgcIKiuMDK
 c0iVHZJbWZo5B0FmUhsWUXaw0aSW84UsProMaV5sDeBfrCdexCnVeoP92y8R1/RJueIN
 p6L90/I6ytZr/y5ATbk2iLxq8fjZCTU+7CFya0fLYcyK1uE42lKxsKU4evVqR/vhCKuY DA== 
Received: from mr2-mtap-s02.rno.apple.com (mr2-mtap-s02.rno.apple.com
 [17.179.226.134])
 by ma1-aaemail-dr-lapp01.apple.com with ESMTP id 2wf4aa3935-11
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Sat, 30 Nov 2019 00:31:29 -0800
Received: from nwk-mmpp-sz13.apple.com
 (nwk-mmpp-sz13.apple.com [17.128.115.216]) by mr2-mtap-s02.rno.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPS id <0Q1R004CRX055H50@mr2-mtap-s02.rno.apple.com>; Sat,
 30 Nov 2019 00:31:17 -0800 (PST)
Received: from process_milters-daemon.nwk-mmpp-sz13.apple.com by
 nwk-mmpp-sz13.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) id <0Q1R00700WY1TD00@nwk-mmpp-sz13.apple.com>; Sat,
 30 Nov 2019 00:31:17 -0800 (PST)
X-Va-A: 
X-Va-T-CD: 07468e1da2f6e987d649ff6cb4055ea6
X-Va-E-CD: 41404d9c28fbc215bab670c20d826187
X-Va-R-CD: eb29b0577443ea815658bc1e1be1b1f2
X-Va-CD: 0
X-Va-ID: 1918bde5-1433-4931-807f-0e22e3aff915
X-V-A: 
X-V-T-CD: 07468e1da2f6e987d649ff6cb4055ea6
X-V-E-CD: 41404d9c28fbc215bab670c20d826187
X-V-R-CD: eb29b0577443ea815658bc1e1be1b1f2
X-V-CD: 0
X-V-ID: 6daa0aad-75af-4534-ae8c-f315f5d71c71
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-11-30_02:,, signatures=0
Received: from [17.234.99.197] (unknown [17.234.99.197])
 by nwk-mmpp-sz13.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPSA id <0Q1R004C6X037G90@nwk-mmpp-sz13.apple.com>; Sat,
 30 Nov 2019 00:31:17 -0800 (PST)
Content-type: text/plain; charset=us-ascii
MIME-version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2 5/5] hvf: save away type as well as vector so we can
 reinject them
In-reply-to: <cdc4958b-6ef5-aee2-1cf2-8cb59ca031fe@redhat.com>
Date: Sat, 30 Nov 2019 00:31:14 -0800
Cc: qemu-devel@nongnu.org
Content-transfer-encoding: quoted-printable
Message-id: <4EA34107-C294-47F4-8747-5407588BCA5C@apple.com>
References: <cover.1574625592.git.dirty@apple.com>
 <e07e6085d8ab9054e58f85ae58e112df6adc024d.1574625592.git.dirty@apple.com>
 <eb3a2de7-fcfe-f0d5-8534-1c59ff40f61e@redhat.com>
 <5F8C8B54-3653-4417-9A08-E724032294F9@apple.com>
 <cdc4958b-6ef5-aee2-1cf2-8cb59ca031fe@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-30_02:, , signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 17.171.2.60
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Cameron Esfahani <dirty@apple.com>
From: Cameron Esfahani via <qemu-devel@nongnu.org>

So far so good.  Without any workaround, I could get it to fail within a =
few seconds.  With your change, I've been running for a few minutes =
without a problem.  But, this is on my laptop, so I'll wait until I can =
test it on a wider-range of machines at work next week.  If it continues =
to work, I'll update my patch to include this fix.

Now, can you help me understand why this approach is better than what I =
had written?  When we're in hvf_store_events(), we have vector type and =
number.  All the information we need to reinject later.  So why not save =
vector type away, instead of attempting to reconstruct it from other =
information (env->ins_len) in hvf_inject_interrupts()?

Cameron Esfahani
dirty@apple.com

"There are times in the life of a nation when the only place a decent =
man can find himself is in prison."



> On Nov 28, 2019, at 5:56 AM, Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>=20
> On 26/11/19 21:04, Cameron Esfahani wrote:
>> Our test case was booting many concurrent macOS VMs under heavy
>> system load.  I don't know if I could create one to replicate that.
>=20
> Does this work?
>=20
> diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
> index 1485b95776..26c6c3a49f 100644
> --- a/target/i386/hvf/x86hvf.c
> +++ b/target/i386/hvf/x86hvf.c
> @@ -357,7 +357,11 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
>     bool have_event =3D true;
>     if (env->interrupt_injected !=3D -1) {
>         vector =3D env->interrupt_injected;
> -        intr_type =3D VMCS_INTR_T_SWINTR;
> +        if (env->ins_len) {
> +            intr_type =3D VMCS_INTR_T_SWINTR;
> +        } else {
> +            intr_type =3D VMCS_INTR_T_HWINTR;
> +        }
>     } else if (env->exception_nr !=3D -1) {
>         vector =3D env->exception_nr;
>         if (vector =3D=3D EXCP03_INT3 || vector =3D=3D EXCP04_INTO) {
>=20
> Thanks,
>=20
> Paolo
>=20


