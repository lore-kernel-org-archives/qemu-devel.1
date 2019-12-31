Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB45C2D0C8
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 04:58:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8A4F205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 04:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="pu1GUS+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A4F205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1im9cM-00085L-4W
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 23:58:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1im9bk-0007dQ-PM
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 23:58:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1im9bj-0000it-BN
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 23:58:16 -0500
Received: from nwk-aaemail-lapp03.apple.com ([17.151.62.68]:39726)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1im9bj-0000aj-17
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 23:58:15 -0500
Received: from pps.filterd (nwk-aaemail-lapp03.apple.com [127.0.0.1])
 by nwk-aaemail-lapp03.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 xBV4v1SG036023; Mon, 30 Dec 2019 20:58:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : content-type
 : mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=rZjk425/rkEe15fxuePFjvnSmPtgAmVmIQ3h34ms11A=;
 b=pu1GUS+Fh1SMxIpQHx5OjNm2Jrr4xOWfmK0fbDE56CVkbuwWEi+BnPNPBqKLyP3uNn0e
 Bsq43U2PxOG8QrEy0UHBftKt+Tf13endPO/LhFsAq53aiVf/upriDJi2xfL/8yLN6RC3
 bKC7sO2opmebUOm6Jw67kj+3iPJo3e/SxWeONBoA7NbIMzUyxPL4gG5Pb2nVQM1TZHCE
 q6/jVIhpcLfywE8yOT3rV2OE3hBGNwGa5He2KrH1vgSXQ9ulO5EONlifESZieoLKQh42
 CLYR4ma/ALxT2yRnMF1OOEu7AjQ9DRZSyKQUCCaJvsf7kr5oblCaEQNQcSFj5URmmm0l yA== 
Received: from ma1-mtap-s03.corp.apple.com (ma1-mtap-s03.corp.apple.com
 [17.40.76.7])
 by nwk-aaemail-lapp03.apple.com with ESMTP id 2x6r5nxh0b-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Mon, 30 Dec 2019 20:58:11 -0800
Received: from nwk-mmpp-sz09.apple.com
 (nwk-mmpp-sz09.apple.com [17.128.115.80]) by ma1-mtap-s03.corp.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPS id <0Q3D00EK11SYUO30@ma1-mtap-s03.corp.apple.com>; Mon,
 30 Dec 2019 20:58:10 -0800 (PST)
Received: from process_milters-daemon.nwk-mmpp-sz09.apple.com by
 nwk-mmpp-sz09.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) id <0Q3D009001BKMF00@nwk-mmpp-sz09.apple.com>; Mon,
 30 Dec 2019 20:58:10 -0800 (PST)
X-Va-A: 
X-Va-T-CD: 
X-Va-E-CD: 
X-Va-R-CD: 
X-Va-CD: 0
X-Va-ID: 606823f8-07f2-46dd-91be-6ed92181f38d
X-V-A: 
X-V-T-CD: 28dcae055a9810d223bc2f1d630b1f19
X-V-E-CD: dbeeba7a2d460cfb8987fc4b7b7c5c32
X-V-R-CD: 03a1fb280ccfad160357b09557fc2f42
X-V-CD: 0
X-V-ID: c0b2602a-c962-40e7-9ec3-1405d2970845
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-12-30_08:,, signatures=0
Received: from [17.235.96.115] (unknown [17.235.96.115])
 by nwk-mmpp-sz09.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPSA id <0Q3D00BH91SWW500@nwk-mmpp-sz09.apple.com>; Mon,
 30 Dec 2019 20:58:10 -0800 (PST)
Content-type: text/plain; charset=us-ascii
MIME-version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [Bug 1818937] Crash with HV_ERROR on macOS host
In-reply-to: <157772410599.5239.8975502245585267506.malone@gac.canonical.com>
Date: Mon, 30 Dec 2019 20:58:07 -0800
Cc: qemu-devel@nongnu.org
Content-transfer-encoding: quoted-printable
Message-id: <A88841B2-A540-46B7-93C7-5C77B0CAE67F@apple.com>
References: <155192472106.28960.15645485731508389788.malonedeb@chaenomeles.canonical.com>
 <157772410599.5239.8975502245585267506.malone@gac.canonical.com>
To: Bug 1818937 <1818937@bugs.launchpad.net>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-12-30_08:, , signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 17.151.62.68
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

Try against 4.2.

Cameron Esfahani
dirty@apple.com

"In the elder days of Art, Builders wrought with greatest care each =
minute and unseen part; For the gods see everywhere."

"The Builders", H. W. Longfellow



> On Dec 30, 2019, at 8:41 AM, Alex Fliker =
<alexandru.barbovschi@gmail.com> wrote:
>=20
> Are there any updates? Trying to run the IE11 image from Microsoft
> (based on Windows 8.1) and it is crashing with this error sporadically
> :-\
>=20
> --=20
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1818937
>=20
> Title:
>  Crash with HV_ERROR on macOS host
>=20
> Status in QEMU:
>  New
>=20
> Bug description:
>  On macOS host running Windows 10 guest, qemu crashed with error
>  message: Error: HV_ERROR.
>=20
>  Host: macOS Mojave 10.14.3 (18D109) Late 2014 Mac mini presumably =
Core i5 4278U.
>  QEMU: git commit a3e3b0a7bd5de211a62cdf2d6c12b96d3c403560
>  QEMU parameter: qemu-system-x86_64 -m 3000 -drive =
file=3Ddisk.img,if=3Dvirtio,discard=3Dunmap -accel hvf -soundhw hda -smp =
3
>=20
>  thread list
>  Process 56054 stopped
>    thread #1: tid =3D 0x2ffec8, 0x00007fff48d0805a =
vImage`vLookupTable_Planar16 + 970, queue =3D 'com.apple.main-thread'
>    thread #2: tid =3D 0x2ffecc, 0x00007fff79d6d7de =
libsystem_kernel.dylib`__psynch_cvwait + 10
>    thread #3: tid =3D 0x2ffecd, 0x00007fff79d715aa =
libsystem_kernel.dylib`__select + 10
>    thread #4: tid =3D 0x2ffece, 0x00007fff79d71d9a =
libsystem_kernel.dylib`__sigwait + 10
>  * thread #6: tid =3D 0x2ffed0, 0x00007fff79d7023e =
libsystem_kernel.dylib`__pthread_kill + 10, stop reason =3D signal =
SIGABRT
>    thread #7: tid =3D 0x2ffed1, 0x00007fff79d6d7de =
libsystem_kernel.dylib`__psynch_cvwait + 10
>    thread #8: tid =3D 0x2ffed2, 0x00007fff79d6d7de =
libsystem_kernel.dylib`__psynch_cvwait + 10
>    thread #11: tid =3D 0x2fff34, 0x00007fff79d6a17a =
libsystem_kernel.dylib`mach_msg_trap + 10, name =3D =
'com.apple.NSEventThread'
>    thread #30: tid =3D 0x300c04, 0x00007fff79e233f8 =
libsystem_pthread.dylib`start_wqthread
>    thread #31: tid =3D 0x300c16, 0x00007fff79e233f8 =
libsystem_pthread.dylib`start_wqthread
>    thread #32: tid =3D 0x300c17, 0x0000000000000000
>    thread #33: tid =3D 0x300c93, 0x00007fff79d6d7de =
libsystem_kernel.dylib`__psynch_cvwait + 10
>=20
>=20
>  Crashed thread:
>=20
>  * thread #6, stop reason =3D signal SIGABRT
>    * frame #0: 0x00007fff79d7023e =
libsystem_kernel.dylib`__pthread_kill + 10
>      frame #1: 0x00007fff79e26c1c libsystem_pthread.dylib`pthread_kill =
+ 285
>      frame #2: 0x00007fff79cd91c9 libsystem_c.dylib`abort + 127
>      frame #3: 0x000000010baa476d =
qemu-system-x86_64`assert_hvf_ok(ret=3D<unavailable>) at hvf.c:106 [opt]
>      frame #4: 0x000000010baa4c8f =
qemu-system-x86_64`hvf_vcpu_exec(cpu=3D0x00007f8e5283de00) at hvf.c:681 =
[opt]
>      frame #5: 0x000000010b988423 =
qemu-system-x86_64`qemu_hvf_cpu_thread_fn(arg=3D0x00007f8e5283de00) at =
cpus.c:1636 [opt]
>      frame #6: 0x000000010bd9dfce =
qemu-system-x86_64`qemu_thread_start(args=3D<unavailable>) at =
qemu-thread-posix.c:502 [opt]
>      frame #7: 0x00007fff79e24305 =
libsystem_pthread.dylib`_pthread_body + 126
>      frame #8: 0x00007fff79e2726f =
libsystem_pthread.dylib`_pthread_start + 70
>      frame #9: 0x00007fff79e23415 libsystem_pthread.dylib`thread_start =
+ 13
>=20
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1818937/+subscriptions
>=20


