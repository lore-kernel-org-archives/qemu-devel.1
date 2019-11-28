Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0357C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 05:59:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A980A208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 05:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="D4+F/DM3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A980A208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaCpe-0006AD-T6
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 00:59:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1iaCoa-0005gV-ID
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 00:58:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1iaCoY-0003p8-F1
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 00:58:08 -0500
Received: from ma1-aaemail-dr-lapp03.apple.com ([17.171.2.72]:39860)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1iaCoW-0003mB-CP
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 00:58:04 -0500
Received: from pps.filterd (ma1-aaemail-dr-lapp03.apple.com [127.0.0.1])
 by ma1-aaemail-dr-lapp03.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 xAS5qD3L031284; Wed, 27 Nov 2019 21:58:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : content-type
 : mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=RQO/zO3qgoUpIwqQUBwfPO7J+2Ti+xjEWPNRuUk//aw=;
 b=D4+F/DM3fKegHQQZ9RXuvWBeoD8uhz9AcIDPDOPUW8aJpssqlYS63KURtuTDdQyuCi00
 JnfAP/+nTRqL9/jFvPpUEsKJOCgOUwGo/Uw4EgbvrDrZd7/HNlkk/Psm9SL+mfwwlzdN
 dieViV7bmO6kp7G8O84CTh19lYUjm1p2gEnt8nXXt0Uq1KbNJz9qkkHiUEDMOKBaPTx7
 cIDtmneLoBCrZkD1EVj8Qd+jG8rzFNwNzza4Aw35dsrpdBwhTDhayWqWj6sogW/Lb+Ww
 Q22KkGmxc+YtWn98srefE2/V2CNDNOyQMpF2G/Mp01Tz4vSe9AJSNEx2+OeVzuuf33CJ VQ== 
Received: from ma1-mtap-s03.corp.apple.com (ma1-mtap-s03.corp.apple.com
 [17.40.76.7])
 by ma1-aaemail-dr-lapp03.apple.com with ESMTP id 2wf4n89x0c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Wed, 27 Nov 2019 21:58:01 -0800
Received: from nwk-mmpp-sz11.apple.com
 (nwk-mmpp-sz11.apple.com [17.128.115.155]) by ma1-mtap-s03.corp.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPS id <0Q1O009P70KOXZ50@ma1-mtap-s03.corp.apple.com>; Wed,
 27 Nov 2019 21:58:01 -0800 (PST)
Received: from process_milters-daemon.nwk-mmpp-sz11.apple.com by
 nwk-mmpp-sz11.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) id <0Q1O00I00092GX00@nwk-mmpp-sz11.apple.com>; Wed,
 27 Nov 2019 21:58:00 -0800 (PST)
X-Va-A: 
X-Va-T-CD: 07468e1da2f6e987d649ff6cb4055ea6
X-Va-E-CD: 41404d9c28fbc215bab670c20d826187
X-Va-R-CD: eb29b0577443ea815658bc1e1be1b1f2
X-Va-CD: 0
X-Va-ID: ae3096fb-6ecc-4156-b25a-7ec69f9c8718
X-V-A: 
X-V-T-CD: 07468e1da2f6e987d649ff6cb4055ea6
X-V-E-CD: 41404d9c28fbc215bab670c20d826187
X-V-R-CD: eb29b0577443ea815658bc1e1be1b1f2
X-V-CD: 0
X-V-ID: 5dacfd3d-d8f6-4776-9a08-736b7b3218fe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-11-27_07:,, signatures=0
Received: from [17.234.102.11] (unknown [17.234.102.11])
 by nwk-mmpp-sz11.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPSA id <0Q1O00J8E0KNYE10@nwk-mmpp-sz11.apple.com>; Wed,
 27 Nov 2019 21:58:00 -0800 (PST)
Content-type: text/plain; charset=us-ascii
MIME-version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2 5/5] hvf: save away type as well as vector so we can
 reinject them
In-reply-to: <5F8C8B54-3653-4417-9A08-E724032294F9@apple.com>
Date: Wed, 27 Nov 2019 21:57:58 -0800
Cc: qemu-devel@nongnu.org
Content-transfer-encoding: quoted-printable
Message-id: <524CCF5D-EED6-4710-A561-6AD634015F5F@apple.com>
References: <cover.1574625592.git.dirty@apple.com>
 <e07e6085d8ab9054e58f85ae58e112df6adc024d.1574625592.git.dirty@apple.com>
 <eb3a2de7-fcfe-f0d5-8534-1c59ff40f61e@redhat.com>
 <5F8C8B54-3653-4417-9A08-E724032294F9@apple.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-27_07:, , signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 17.171.2.72
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

I added some asserts to our internal version of QEMU.  It's a few months =
off of master and, specifically, doesn't have =
fd13f23b8c95311eff74426921557eee592b0ed3.

With the previous version of hvf_inject_interrupts(), before our fix, =
the code looked like the following:

>     if (env->interrupt_injected !=3D -1) {
>         vector =3D env->interrupt_injected;
>         intr_type =3D VMCS_INTR_T_SWINTR;
>     } else if (env->exception_injected !=3D -1) {


What we were seeing was, under heavy loads, running many concurrent =
macOS VMs, that we would get spurious interrupts.  Tracking it down, we =
discovered that VMCS_INTR_T_SWINTR was getting injected when =
VMCS_INTR_T_HWINTR was expected.

If I take our proposed patch code, which built on top of master from a =
few days ago, and has fd13f23b8c95311eff74426921557eee592b0ed3,  and add =
an assert, like the following:

>     if (env->interrupt_injected !=3D -1) {
>         /* Type and vector are both saved in interrupt_injected. */
>         vector =3D env->interrupt_injected & VMCS_IDT_VEC_VECNUM;
>         intr_type =3D env->interrupt_injected & VMCS_IDT_VEC_TYPE;
>         if (VMCS_INTR_T_SWINTR !=3D intr_type) {
>             printf("VMCS_INTR_T_SWINTR (%x) !=3D intr_type (%llx)\n", =
VMCS_INTR_T_SWINTR, intr_type);
>             assert(VMCS_INTR_T_SWINTR =3D=3D intr_type);
>         }
>     } else if (env->exception_nr !=3D -1) {


Then we will see the assert trigger and get the following output:

> VMCS_INTR_T_SWINTR (400) !=3D intr_type (0)
> Assertion failed: (VMCS_INTR_T_SWINTR =3D=3D intr_type), function =
hvf_inject_interrupts, file qemu_upstream/target/i386/hvf/x86hvf.c, line =
362.


So, as far as I can see, the proposed changes are still necessary.

Cameron Esfahani
dirty@apple.com

"Americans are very skilled at creating a custom meaning from something =
that's mass-produced."

Ann Powers


> On Nov 26, 2019, at 12:04 PM, Cameron Esfahani via =
<qemu-devel@nongnu.org> wrote:
>=20
> Our test case was booting many concurrent macOS VMs under heavy system =
load.  I don't know if I could create one to replicate that.
>=20
> Cameron Esfahani
> dirty@apple.com
>=20
> "In the elder days of Art, Builders wrought with greatest care each =
minute and unseen part; For the gods see everywhere."
>=20
> "The Builders", H. W. Longfellow
>=20
>=20
>=20
>> On Nov 25, 2019, at 2:26 AM, Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>>=20
>> On 24/11/19 21:05, Cameron Esfahani wrote:
>>> Save away type as well as vector in hvf_store_events() so we can
>>> correctly reinject both in hvf_inject_interrupts().
>>>=20
>>> Make sure to clear ins_len and has_error_code when ins_len isn't
>>> valid and error_code isn't set.
>>=20
>> Do you have a testcase for this?  (I could guess it's about the INT1
>> instruction).
>>=20
>> Paolo
>>=20
>=20
>=20


