Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA6AC3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 00:25:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90BB720717
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 00:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ha67Xqo/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="kCzxLK29"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90BB720717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA0nd-0002YF-JA
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 19:25:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1jA0mv-00026w-Hc
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 19:24:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1jA0mt-00008a-BA
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 19:24:25 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:51367)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1jA0mn-0008QE-Vs; Thu, 05 Mar 2020 19:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1583454258; x=1614990258;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=PcpiXlftb0eDBkgOO5aBTjxoJLECms1GsF/eesfS7jc=;
 b=ha67Xqo/a5ZwMKnkU2rxCi7FVImaYRQJAYXVuKz+7Mv5GYSkLhPwmpSn
 GtZzvK0X8VGGFCVVzyYl7ulV9gLVeo7/j83lgHsajkqfNkr8hqX4VxBl7
 WtSKADUY5CidyGryrw4RnPlTi7CK7AYdgoT8GBG7NAl24IlG1Fm0Circd Y=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 05 Mar 2020 16:24:15 -0800
Received: from nasanexm01f.na.qualcomm.com ([10.85.0.32])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA;
 05 Mar 2020 16:24:15 -0800
Received: from APSANEXR01A.ap.qualcomm.com (10.85.0.36) by
 NASANEXM01F.na.qualcomm.com (10.85.0.32) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 5 Mar 2020 16:24:14 -0800
Received: from nasanexm03a.na.qualcomm.com (10.85.0.103) by
 APSANEXR01A.ap.qualcomm.com (10.85.0.36) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 5 Mar 2020 16:24:11 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03a.na.qualcomm.com (10.85.0.103) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 5 Mar 2020 16:24:11 -0800
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB5110.namprd02.prod.outlook.com (2603:10b6:a03:62::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Fri, 6 Mar
 2020 00:24:10 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62%6]) with mapi id 15.20.2772.019; Fri, 6 Mar 2020
 00:24:10 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Laurent Vivier <laurent@vivier.eu>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH v3 00/21] linux-user: generate syscall_nr.sh
Thread-Topic: [PATCH v3 00/21] linux-user: generate syscall_nr.sh
Thread-Index: AQHV69pivm3rRW4QUka47u2Q6uvbjKg1dNzA
Date: Fri, 6 Mar 2020 00:24:10 +0000
Message-ID: <BYAPR02MB488629A01AD705E092CA633ADEE30@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <20200225121553.2191597-1-laurent@vivier.eu>
In-Reply-To: <20200225121553.2191597-1-laurent@vivier.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [199.106.103.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa5695aa-e7b9-4c7d-ce2b-08d7c164b0d8
x-ms-traffictypediagnostic: BYAPR02MB5110:
x-microsoft-antispam-prvs: <BYAPR02MB51101A4DF0A42F7C359A5198DEE30@BYAPR02MB5110.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0334223192
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(366004)(376002)(136003)(39860400002)(189003)(199004)(316002)(5660300002)(478600001)(71200400001)(110136005)(54906003)(2906002)(8936002)(86362001)(4326008)(66946007)(76116006)(6506007)(66446008)(55016002)(186003)(64756008)(53546011)(81166006)(81156014)(8676002)(52536014)(33656002)(66476007)(30864003)(26005)(7696005)(66556008)(9686003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB5110;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NAkJmWNFiD3V06FDDkSRQUur5lxDYVGiAovCryGSBCUH4XibpoGvzfaAE0QJNFrXMHWYEMjDRtanRkdTjm4amv9BOeAxLdV9oillCbyfaBMrQvH0mlVUjw99dWjNRISn4QbwMreR0UuuMLIzw2/nVl6XMdrNV0wb/VH8aKJL5ikasSVSbfOuQlrhw6aofE5jpj9PWqqv8h4ap7vvsq+BLr9k4Vuwy8v32Smai+WKE++K+RRJJDdJR9pWDwkZPi4+SoRuRoNDw9PZkQkPfW/rbopQe3ijEJQFjeFKhTjuVXrKuEXNNw5wbqFB6seOvcdJqYzZ5xkmy+ZReNdnHQzd/xTS9Fm9RBWeXTL9grHsOETziH8LhQNPv20vD1Fr43rTEUwg5UqCt4/l2QthRNVbdY+sMnv1OGiVS8yD8xzW3IcBOPNjDXCazWJ4oOql/Xcj
x-ms-exchange-antispam-messagedata: 3ioperWVHRPWBiJA9irbLZjU81l0SEVspDpsixFaWSAzeWtw5T8Uy1iOG/UMFC93CI2jSxlrOySYfjTpq1BJr1NzPoGaBPps+tznxUcEsQ+pLNyWEucXbXhHOV0V3FSdLXaOxny9/YWsTV6OEk5hqA==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhLQTsI4w97TznHWLfQe/RBoLaThT0j0WNXsd670Ez2Q9OKu3KToNbJh6OqLdhDATQNYEEcVFd+XWZZF7tDWTk157irZzdaj904ybnee+cYsDYWXi2tgdo6swfeu3Z6rUwz9JGH6CO3KyFqIkC+dnZkvR5a3GjNFQ7a1z6aglq9y9Jt7tSTZVFHFSmA0KMVNAO7HQz+HrVNoaCUFwIREkEp2zpPkaX0aFtS+ktW7Xl49QpeYUnkJ/QnOYq1i0I3qs6Q9nSpnV0NuiMJhz6nH4TEEKTazR0DEwB4FwbKO00uhPp3UmrfdNuJ7SLj1AWwUnlcjmQmKgd1d8kpJJ0Rizw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igjOxNW0TaHB2jQcdH1bXRnClp/xxKWPM4UMh/XTNSw=;
 b=EmOrA00gETlpXSdPmjStDX1Q/L2oh4WPXSCnZSpyAh9y/n/nO23DH9GGaGQwZO6e0tVRFOujQWPCPx3u5R4EZ+qQzDF1/Inlnwt2WTsUEfhSXQumYF+IYcfsIkvEZldgnbgANCEltXeO+MzFrgt0RXvZyXwpOEqPeejxW0wSjzECxzHP7nhoDG0zAScCzyKbLW9vluAE0M4uTRWBUXj8pQIZwB/69nUh0mg4vHN4FYHqoqblwgnyUg6k+W4aw4sZUQz/7k35knDFnsexBosOoH28lzQXyo29CcsOVuD+M5twsdcGiAhdxO+5dop249frEHZbmOpsQfm478+XCQ173g==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igjOxNW0TaHB2jQcdH1bXRnClp/xxKWPM4UMh/XTNSw=;
 b=kCzxLK29xTMVAgnqKPmnxmxteK3od5by6Cz+ptla8WSmZ4RQ73oke1RMeDShqBbv62O/hwYzf00L9MkE6ERtLPZpPzJlYojfgtez53n6cS8RoBJVRE1uQpFDReoQDws02iIdVTWNbv9gU+RX+Qtmrb2TO7XEkS3ZOif+WZmpbvQ=
x-ms-exchange-crosstenant-network-message-id: fa5695aa-e7b9-4c7d-ce2b-08d7c164b0d8
x-ms-exchange-crosstenant-originalarrivaltime: 06 Mar 2020 00:24:10.2894 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: h/zMHHb/l3jFcMR84leHlj5gQB+gnBzJGXfcolF3nSuMQdkEf4hym6eoeOVnrotsPlwfTvMrg2EMFkBQoUkwkg==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB5110
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.39
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
Cc: Cornelia Huck <cohuck@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>

FWIW, the Hexagon Linux port does not use this mechanism.  I can work with =
our kernel maintainer and in the meantime create something suitable for qem=
u.



> -----Original Message-----
> From: Qemu-devel <qemu-devel-
> bounces+tsimpson=3Dquicinc.com@nongnu.org> On Behalf Of Laurent Vivier
> Sent: Tuesday, February 25, 2020 6:16 AM
> To: qemu-devel@nongnu.org
> Cc: Riku Voipio <riku.voipio@iki.fi>; Cornelia Huck <cohuck@redhat.com>;
> Laurent Vivier <laurent@vivier.eu>; qemu-s390x@nongnu.org; Aleksandar
> Markovic <amarkovic@wavecomp.com>; Aleksandar Rikalo
> <aleksandar.rikalo@rt-rk.com>; Aurelien Jarno <aurelien@aurel32.net>
> Subject: [PATCH v3 00/21] linux-user: generate syscall_nr.sh
>
> -------------------------------------------------------------------------
> CAUTION: This email originated from outside of the organization.
> -------------------------------------------------------------------------
>
> This series copies the files syscall.tbl from linux v5.5 and generates
> the file syscall_nr.h from them.
>
> This is done for all the QEMU targets that have a syscall.tbl
> in the linux source tree: mips, mips64, i386, x86_64, sparc, s390x,
> ppc, arm, microblaze, sh4, xtensa, m68k, hppa and alpha.
>
> tilegx and cris are depecrated in linux (tilegx has no maintainer in QEMU=
)
>
> aarch64, nios2, openrisc and riscv have no syscall.tbl in linux and files
> are generated manually with the help of a script from the asm-
> generic/unistd.h
>
> Define do_arch_prctl() with -TARGET_ENOSYS for i386 as the syscall number
> is defined now.
>
> I have also removed all syscalls in s390x/syscall_nr.h defined for
> !defined(TARGET_S390X).
>
> I have added a script to copy all these files from linux and updated
> them at the end of the series with their latest version for today.
>
> Two patches manage the special case for mips O32 that needs
> to know the number of arguments. We find them in strace sources.
>
> v3:
>    Add a patch to define do_arch_prctl() for i386
>
> v2:
>     fix a typo (double comma) in $(call quiet-command)
>     add a script to remove dependencies to syscall_nr.h in source directo=
ry
>
> ppc, mips64:
>
>         we don't need to split syscall_nr.h as it is generated
>         according TARGET_SYSTBL_ABI to TARGET_ABI_DIR
>         and generated values are incorrect according to the file name.
>
> arm:
>
>         manage TARGET_NR_arm_sync_file_range
>
> Once the syscall_nr.h are built in the build directory, the following scr=
ipt
> allows to compare them with the original one (first argument is the path
> to build directory), it must be run from the source directory:
>
> cat > check_syscall_nr.sh <<EOF
> BUILD=3D"$1"
>
> ARCHS=3D"i386 alpha arm hppa i386 m68k microblaze s390x sh4 sparc sparc64
> xtensa ppc"
>
> syscall_nr_diff()
> {
>         arch=3D$1
>         target=3D$2
>         syscall_nr=3Dlinux-user/$arch/syscall_nr.h
>         offset=3D$3
>         REFERENCE=3D$(git log -1 --format=3Dformat:%h -- $syscall_nr)^
>         if [ "$offset" =3D "" ] ; then
>                 git show $REFERENCE:$syscall_nr | \
>                         sed 's/[[:blank:]]\/\*[^*]*\*\///' | \
>                         sed 's/(\([^)]*\))/\1/'  > /tmp/old
>         else
>                 git show $REFERENCE:$syscall_nr | \
>                         sed 's/[[:blank:]]\/\*[^*]*\*\///' | \
>                         sed "s/TARGET_NR_Linux/$offset/" > /tmp/old
>         fi
>         diff -wu --color=3Dalways /tmp/old \
>                                 $BUILD/$target/$syscall_nr | less -R
> }
>
> for arch in $ARCHS ; do
>         syscall_nr_diff $arch $arch-linux-user
> done
>
> syscall_nr_diff ppc    ppc64-linux-user
>
> syscall_nr_diff mips   mips-linux-user    4000
> syscall_nr_diff mips64 mips64-linux-user  5000
> syscall_nr_diff mips64 mipsn32-linux-user 6000
> EOF
>
> Laurent Vivier (21):
>   linux-user: introduce parameters to generate syscall_nr.h
>   linux-user,alpha: add syscall table generation support
>   linux-user,hppa: add syscall table generation support
>   linux-user,m68k: add syscall table generation support
>   linux-user,xtensa: add syscall table generation support
>   linux-user,sh4: add syscall table generation support
>   linux-user,microblaze: add syscall table generation support
>   linux-user,arm: add syscall table generation support
>   linux-user,ppc: add syscall table generation support
>   linux-user,s390x: remove syscall definitions for !TARGET_S390X
>   linux-user,s390x: add syscall table generation support
>   linux-user,sparc,sparc64: add syscall table generation support
>   linux-user,x86_64,i386: cleanup TARGET_NR_arch_prctl
>   linux-user,i386: add syscall table generation support
>   linux-user,x86_64: add syscall table generation support
>   linux-user,mips: add syscall table generation support
>   linux-user,mips64: add syscall table generation support
>   linux-user,scripts: add a script to update syscall.tbl
>   linux-user: update syscall.tbl from linux 0bf999f9c5e7
>   linux-user,mips: move content of mips_syscall_args
>   linux-user,mips: update syscall-args-o32.c.inc
>
>  MAINTAINERS                            |   1 +
>  Makefile.target                        |   3 +-
>  configure                              |  35 ++
>  linux-user/Makefile.objs               |  19 +-
>  linux-user/alpha/Makefile.objs         |   5 +
>  linux-user/alpha/syscall.tbl           | 479 ++++++++++++++++
>  linux-user/alpha/syscall_nr.h          | 492 -----------------
>  linux-user/alpha/syscallhdr.sh         |  32 ++
>  linux-user/arm/Makefile.objs           |   8 +
>  linux-user/arm/syscall.tbl             | 453 +++++++++++++++
>  linux-user/arm/syscall_nr.h            | 447 ---------------
>  linux-user/arm/syscallhdr.sh           |  31 ++
>  linux-user/hppa/Makefile.objs          |   5 +
>  linux-user/hppa/syscall.tbl            | 437 +++++++++++++++
>  linux-user/hppa/syscall_nr.h           | 358 ------------
>  linux-user/hppa/syscallhdr.sh          |  32 ++
>  linux-user/i386/Makefile.objs          |   5 +
>  linux-user/i386/syscall_32.tbl         | 444 +++++++++++++++
>  linux-user/i386/syscall_nr.h           | 387 -------------
>  linux-user/i386/syscallhdr.sh          |  28 +
>  linux-user/i386/target_cpu.h           |   4 +-
>  linux-user/m68k/Makefile.objs          |   5 +
>  linux-user/m68k/syscall.tbl            | 439 +++++++++++++++
>  linux-user/m68k/syscall_nr.h           | 434 ---------------
>  linux-user/m68k/syscallhdr.sh          |  32 ++
>  linux-user/microblaze/Makefile.objs    |   5 +
>  linux-user/microblaze/syscall.tbl      | 445 +++++++++++++++
>  linux-user/microblaze/syscall_nr.h     | 442 ---------------
>  linux-user/microblaze/syscallhdr.sh    |  32 ++
>  linux-user/mips/Makefile.objs          |   5 +
>  linux-user/mips/cpu_loop.c             | 440 +--------------
>  linux-user/mips/syscall-args-o32.c.inc | 436 +++++++++++++++
>  linux-user/mips/syscall_nr.h           | 425 ---------------
>  linux-user/mips/syscall_o32.tbl        | 427 +++++++++++++++
>  linux-user/mips/syscallhdr.sh          |  36 ++
>  linux-user/mips64/Makefile.objs        |  12 +
>  linux-user/mips64/syscall_n32.tbl      | 378 +++++++++++++
>  linux-user/mips64/syscall_n64.tbl      | 354 ++++++++++++
>  linux-user/mips64/syscall_nr.h         | 725 -------------------------
>  linux-user/mips64/syscallhdr.sh        |  33 ++
>  linux-user/ppc/Makefile.objs           |   6 +
>  linux-user/ppc/signal.c                |   2 +-
>  linux-user/ppc/syscall.tbl             | 521 ++++++++++++++++++
>  linux-user/ppc/syscall_nr.h            | 402 --------------
>  linux-user/ppc/syscallhdr.sh           |  34 ++
>  linux-user/s390x/Makefile.objs         |   5 +
>  linux-user/s390x/syscall.tbl           | 442 +++++++++++++++
>  linux-user/s390x/syscall_nr.h          | 398 --------------
>  linux-user/s390x/syscallhdr.sh         |  32 ++
>  linux-user/sh4/Makefile.objs           |   5 +
>  linux-user/sh4/syscall.tbl             | 442 +++++++++++++++
>  linux-user/sh4/syscall_nr.h            | 441 ---------------
>  linux-user/sh4/syscallhdr.sh           |  32 ++
>  linux-user/sparc/Makefile.objs         |   5 +
>  linux-user/sparc/syscall.tbl           | 485 +++++++++++++++++
>  linux-user/sparc/syscall_nr.h          | 363 -------------
>  linux-user/sparc/syscallhdr.sh         |  32 ++
>  linux-user/sparc64/Makefile.objs       |   5 +
>  linux-user/sparc64/syscall.tbl         | 485 +++++++++++++++++
>  linux-user/sparc64/syscall_nr.h        | 366 -------------
>  linux-user/sparc64/syscallhdr.sh       |  32 ++
>  linux-user/syscall.c                   |  25 +-
>  linux-user/x86_64/Makefile.objs        |   5 +
>  linux-user/x86_64/syscall_64.tbl       | 404 ++++++++++++++
>  linux-user/x86_64/syscall_nr.h         | 356 ------------
>  linux-user/x86_64/syscallhdr.sh        |  28 +
>  linux-user/xtensa/Makefile.objs        |   5 +
>  linux-user/xtensa/syscall.tbl          | 410 ++++++++++++++
>  linux-user/xtensa/syscall_nr.h         | 469 ----------------
>  linux-user/xtensa/syscallhdr.sh        |  32 ++
>  scripts/update-mips-syscall-args.sh    |  57 ++
>  scripts/update-syscalltbl.sh           |  49 ++
>  72 files changed, 8227 insertions(+), 6958 deletions(-)
>  create mode 100644 linux-user/alpha/Makefile.objs
>  create mode 100644 linux-user/alpha/syscall.tbl
>  delete mode 100644 linux-user/alpha/syscall_nr.h
>  create mode 100644 linux-user/alpha/syscallhdr.sh
>  create mode 100644 linux-user/arm/Makefile.objs
>  create mode 100644 linux-user/arm/syscall.tbl
>  delete mode 100644 linux-user/arm/syscall_nr.h
>  create mode 100644 linux-user/arm/syscallhdr.sh
>  create mode 100644 linux-user/hppa/Makefile.objs
>  create mode 100644 linux-user/hppa/syscall.tbl
>  delete mode 100644 linux-user/hppa/syscall_nr.h
>  create mode 100644 linux-user/hppa/syscallhdr.sh
>  create mode 100644 linux-user/i386/Makefile.objs
>  create mode 100644 linux-user/i386/syscall_32.tbl
>  delete mode 100644 linux-user/i386/syscall_nr.h
>  create mode 100644 linux-user/i386/syscallhdr.sh
>  create mode 100644 linux-user/m68k/Makefile.objs
>  create mode 100644 linux-user/m68k/syscall.tbl
>  delete mode 100644 linux-user/m68k/syscall_nr.h
>  create mode 100644 linux-user/m68k/syscallhdr.sh
>  create mode 100644 linux-user/microblaze/Makefile.objs
>  create mode 100644 linux-user/microblaze/syscall.tbl
>  delete mode 100644 linux-user/microblaze/syscall_nr.h
>  create mode 100644 linux-user/microblaze/syscallhdr.sh
>  create mode 100644 linux-user/mips/Makefile.objs
>  create mode 100644 linux-user/mips/syscall-args-o32.c.inc
>  delete mode 100644 linux-user/mips/syscall_nr.h
>  create mode 100644 linux-user/mips/syscall_o32.tbl
>  create mode 100644 linux-user/mips/syscallhdr.sh
>  create mode 100644 linux-user/mips64/Makefile.objs
>  create mode 100644 linux-user/mips64/syscall_n32.tbl
>  create mode 100644 linux-user/mips64/syscall_n64.tbl
>  delete mode 100644 linux-user/mips64/syscall_nr.h
>  create mode 100644 linux-user/mips64/syscallhdr.sh
>  create mode 100644 linux-user/ppc/Makefile.objs
>  create mode 100644 linux-user/ppc/syscall.tbl
>  delete mode 100644 linux-user/ppc/syscall_nr.h
>  create mode 100644 linux-user/ppc/syscallhdr.sh
>  create mode 100644 linux-user/s390x/Makefile.objs
>  create mode 100644 linux-user/s390x/syscall.tbl
>  delete mode 100644 linux-user/s390x/syscall_nr.h
>  create mode 100755 linux-user/s390x/syscallhdr.sh
>  create mode 100644 linux-user/sh4/Makefile.objs
>  create mode 100644 linux-user/sh4/syscall.tbl
>  delete mode 100644 linux-user/sh4/syscall_nr.h
>  create mode 100644 linux-user/sh4/syscallhdr.sh
>  create mode 100644 linux-user/sparc/Makefile.objs
>  create mode 100644 linux-user/sparc/syscall.tbl
>  delete mode 100644 linux-user/sparc/syscall_nr.h
>  create mode 100644 linux-user/sparc/syscallhdr.sh
>  create mode 100644 linux-user/sparc64/Makefile.objs
>  create mode 100644 linux-user/sparc64/syscall.tbl
>  delete mode 100644 linux-user/sparc64/syscall_nr.h
>  create mode 100644 linux-user/sparc64/syscallhdr.sh
>  create mode 100644 linux-user/x86_64/Makefile.objs
>  create mode 100644 linux-user/x86_64/syscall_64.tbl
>  delete mode 100644 linux-user/x86_64/syscall_nr.h
>  create mode 100644 linux-user/x86_64/syscallhdr.sh
>  create mode 100644 linux-user/xtensa/Makefile.objs
>  create mode 100644 linux-user/xtensa/syscall.tbl
>  delete mode 100644 linux-user/xtensa/syscall_nr.h
>  create mode 100644 linux-user/xtensa/syscallhdr.sh
>  create mode 100755 scripts/update-mips-syscall-args.sh
>  create mode 100755 scripts/update-syscalltbl.sh
>
> --
> 2.24.1
>
>


