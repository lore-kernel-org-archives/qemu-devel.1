Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3830C10F29
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:10:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C28DD22464
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PmY5Iw3m";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="qrBPQONv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28DD22464
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC18J-000503-39
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 09:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54870)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1jC17U-0004AV-9c
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:09:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1jC17T-00033W-0r
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:09:56 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:26318)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1jC17S-0002tE-KC
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1583932194; x=1615468194;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MBPec2y0pnpWFHcb5NCMhHmUmbzuCDxqgiT6CjYmPzA=;
 b=PmY5Iw3mxNc8j+ZxefqeFL+x09WUvPksM1xLZYOaGKFyrP7bZaF8/txd
 bWufDeYFFeyU9md8vFVJPMPVHxew//vjp7+5jzC0gMgSmWGxFqnYRcuAO
 tZ4/RseJMqYkKKWGXXIqIZpnAwG7zD8aziqz8LUpKzvnv8j2GyO4VF8Ey I=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 11 Mar 2020 06:09:51 -0700
Received: from nasanexm01h.na.qualcomm.com ([10.85.0.34])
 by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 11 Mar 2020 06:09:50 -0700
Received: from eusanexr01b.eu.qualcomm.com (10.85.0.99) by
 NASANEXM01H.na.qualcomm.com (10.85.0.34) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 Mar 2020 06:09:50 -0700
Received: from NASANEXM01F.na.qualcomm.com (10.85.0.32) by
 eusanexr01b.eu.qualcomm.com (10.85.0.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 Mar 2020 06:09:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01F.na.qualcomm.com (10.85.0.32) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Wed, 11 Mar 2020 06:09:48 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB5573.namprd02.prod.outlook.com (2603:10b6:a03:9b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Wed, 11 Mar
 2020 13:09:47 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62%6]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 13:09:46 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Laurent Vivier <laurent@vivier.eu>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH 1/4] scripts: add a script to generate syscall_nr.h
Thread-Topic: [PATCH 1/4] scripts: add a script to generate syscall_nr.h
Thread-Index: AQHV9sxk7UMXugtUwUCjf3ztBHT+y6hCf4kg
Date: Wed, 11 Mar 2020 13:09:46 +0000
Message-ID: <BYAPR02MB4886F6639727FE784EB4A062DEFC0@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <20200310110759.3331020-1-laurent@vivier.eu>
 <20200310110759.3331020-2-laurent@vivier.eu>
In-Reply-To: <20200310110759.3331020-2-laurent@vivier.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [70.115.140.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc875395-20a3-4c5e-fbce-08d7c5bd793d
x-ms-traffictypediagnostic: BYAPR02MB5573:
x-microsoft-antispam-prvs: <BYAPR02MB55739CA54F4ECCFC4A798AA0DEFC0@BYAPR02MB5573.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:214;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(396003)(39860400002)(366004)(136003)(199004)(110136005)(54906003)(7696005)(71200400001)(52536014)(2906002)(186003)(53546011)(6506007)(4326008)(66476007)(66946007)(66556008)(66446008)(64756008)(86362001)(5660300002)(76116006)(478600001)(81166006)(81156014)(26005)(55016002)(316002)(33656002)(9686003)(8676002)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB5573;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iZo+wgLSiwe4GLKlTyBwEl68dfcrtFlE3ez2GCV/us/hw+3r6akysilUaR8LMCiie9gCuzW6fnV+xMtIYTLTesX1Ugy05usWX74Vlh97uWyhi8XNVqqqxzaM+G36RBppi1B0RbKw8PMpMmu9WoByVJpmS4mmaxs3vlhcsTumLXoWNr3rxFslr7A4XOcbPWXALHTbWbzQ7RfepuUKfEUWKXpTWXYL+pFxxD3iVs77AekeIatQjLTiJpWfrZaPj9wwTZZ0aULLuMjkTMTtZV2bOcau0op1wR2u0D9LHG/5zKADH0VzA1beQBU9/3COsuVvsKcNtVLpkDxK7oAynVElYKX0zdc81j4R8P2vSwd1pTundMYHKhOgsKrdvdGxqZuS1uqEf9aGz4ONhBc5mL8Rm12/8VG8aMOxRqVTex91cEQc7K/KokqqzDlv1iDTzTre
x-ms-exchange-antispam-messagedata: tAmn0dh0JDJfIKo0+dmmR3TWlCP4tbTnlbUvo1rz1jAINlYE37rxS5ss3kBVaCmiwWYE0zEUG0rc9WGG4P4x4Zevm0QEkcDa3A+3KLY2SnGUz1EA+y8dfLw8XdU7CO8UaSMXaaDM9+3EZBLbFcsqFA==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfJbivOG1ztPBtgL/s5Ih6/vbwXk1/IepYRLARyf8lcGUTi0zVEpCC3dcAn5dzMehcEPSCcA8szs1ttbIw6k0S7ksqCPQbUQMbdHyU8B2fzMJFdqFKE/5Y8fzVeHMG2ORvT5l+xC25DrcSmAUpYAyx1fUh9PBYl+aHt4xRev3pzoQPlaOwoCMUrx9xKDpoZN6cabsy6Jxxku18UwRzkcEBTK9ORwcSqUjhEgjdI/0p4sZ81shaaLYsco4dK+k9UnDb7IvBUYqGV5yFOHmpxCeNFuP/sHDtOQRDPdjQYoB3UBQBx7+B+rEhDkdJg6StfXCOtnTVnA1+fS4SJuPL0r0A==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YU5ofVK+KqFWi5e9z15uS8FZP5CZuODcSa2icxjH1X0=;
 b=hymU/a3OseSn0IO/rAjl6T2/ovil6/afz/s8HIwdvJoIM9hf49RaYN9WmftVXDdjAic0x3Za32f341nn1kZfJDwA4N08YU6sRD4FqgUvzyj+Prxr333WcM9oWcPorAfB/McFs+liTx5vJTCJBLT2dgOBIqVvoCfSpv8lGZrdqbJf59j1a1wcjgVJM7dO/XfhtQFmm7rI5Gs2dzwJWtCxmcgOUvp2ANFxlbdY042cJ0sz+vvtMfm6OfHoLoeLpW0KfcLfeLFJe5/tSRBJL3Pty5yJhhzQJBQo2tAKrFrm+saY+L7dHKb6Ky1fS19m6Xx0Q5oHvdHW0PEK1/xro4ZTug==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YU5ofVK+KqFWi5e9z15uS8FZP5CZuODcSa2icxjH1X0=;
 b=qrBPQONv/Vbcjb+af+mZ7eD0PyDU/+UstF/P3+BllXqBEYKuFQBGhjGg2ab+FTQn7PwM7vpt1SRGvmBPNB3AEhfMAycJ4r1IyIQQBtCWgPf23TfMs1P15m8mt6Y9x6c9Mgo79L2RjF1xwAQUda9vu/03lTJMize/MbPhGgcwCBU=
x-ms-exchange-crosstenant-network-message-id: bc875395-20a3-4c5e-fbce-08d7c5bd793d
x-ms-exchange-crosstenant-originalarrivaltime: 11 Mar 2020 13:09:46.8091 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: mOfnYSeYk+iUk+PMQJm8vp7FfLTWjAMNgEwthY3OQaY2+tKBmp8xrDT+OqAOE0TtuQlDcgiUO1QZjj+Gb3hJtQ==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB5573
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.38
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
Cc: Marek Vasut <marex@denx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Alistair Francis <alistair.francis@wdc.com>,
 Jia Liu <proljc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>

> -----Original Message-----
> From: Qemu-devel <qemu-devel-
> bounces+tsimpson=3Dquicinc.com@nongnu.org> On Behalf Of Laurent Vivier
> Sent: Tuesday, March 10, 2020 6:08 AM
> To: qemu-devel@nongnu.org
> Cc: Marek Vasut <marex@denx.de>; Peter Maydell
> <peter.maydell@linaro.org>; Jia Liu <proljc@gmail.com>; Riku Voipio
> <riku.voipio@iki.fi>; Laurent Vivier <laurent@vivier.eu>; Alistair Franci=
s
> <alistair.francis@wdc.com>
> Subject: [PATCH 1/4] scripts: add a script to generate syscall_nr.h
>
> This script is needed for targets based on asm-generic syscall numbers
> generation
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  scripts/gensyscalls.sh | 94
> ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100755 scripts/gensyscalls.sh
>
> diff --git a/scripts/gensyscalls.sh b/scripts/gensyscalls.sh
> new file mode 100755
> index 000000000000..3b549a665d0f
> --- /dev/null
> +++ b/scripts/gensyscalls.sh
> @@ -0,0 +1,94 @@
> +#!/bin/sh
> +

Include the license

> +linux=3D"$1"
> +output=3D"$2"
> +
> +TMP=3D$(mktemp -d)
> +
> +if [ "$linux" =3D "" ] ; then
> +    echo "Needs path to linux source tree" 1>&2
> +    exit 1
> +fi
> +
> +if [ "$output" =3D "" ] ; then
> +    output=3D"$PWD"
> +fi
> +
> +upper()
> +{
> +    echo "$1" | tr "[:lower:]" "[:upper:]" | tr "[:punct:]" "_"
> +}
> +
> +qemu_arch()
> +{
> +    case "$1" in
> +    arm64)
> +        echo "aarch64"
> +        ;;
> +    *)
> +        upper "$1"
> +        ;;
> +    esac
> +}
> +
> +read_includes()
> +{
> +    arch=3D$1
> +    bits=3D$2
> +
> +     cpp -P -nostdinc -fdirectives-only \
> +        -D_UAPI_ASM_$(upper ${arch})_BITSPERLONG_H \
> +        -D__BITS_PER_LONG=3D${bits} \
> +        -I${linux}/arch/${arch}/include/uapi/ \
> +        -I${linux}/include/uapi \
> +        -I${TMP} \
> +        "${linux}/arch/${arch}/include/uapi/asm/unistd.h"
> +}
> +
> +filter_defines()
> +{
> +    grep -e "#define __NR_" -e "#define __NR3264"
> +}
> +
> +rename_defines()
> +{
> +    sed "s/ __NR_/ TARGET_NR_/g;s/(__NR_/(TARGET_NR_/g"
> +}
> +
> +evaluate_values()
> +{
> +    sed "s/#define TARGET_NR_/QEMU TARGET_NR_/" | \
> +    cpp -P -nostdinc | \
> +    sed "s/^QEMU /#define /"
> +}
> +
> +generate_syscall_nr()
> +{
> +    arch=3D$1
> +    bits=3D$2
> +    file=3D"$3"
> +    guard=3D"$(upper LINUX_USER_$(qemu_arch $arch)_$(basename
> "$file"))"
> +
> +    (echo "/*"
> +    echo " * This file contains the system call numbers."

echo " * Do not modify."
echo " * This file is generated by: <qemu>/scripts/gensyscalls.sh ${linux} =
${output}"

> +    echo " */"
> +    echo "#ifndef ${guard}"
> +    echo "#define ${guard}"
> +    echo
> +    read_includes $arch $bits | filter_defines | rename_defines | \
> +                                evaluate_values | sort -n -k 3
> +    echo
> +    echo "#endif /* ${guard} */"
> +    echo) > "$file"
> +}
> +
> +mkdir "$TMP/asm"
> +> "$TMP/asm/bitsperlong.h"
> +
> +generate_syscall_nr arm64 64 "$output/linux-user/aarch64/syscall_nr.h"
> +generate_syscall_nr nios2 32 "$output/linux-user/nios2/syscall_nr.h"
> +generate_syscall_nr openrisc 32 "$output/linux-user/openrisc/syscall_nr.=
h"
> +
> +generate_syscall_nr riscv 32 "$output/linux-user/riscv/syscall32_nr.h"
> +generate_syscall_nr riscv 64 "$output/linux-user/riscv/syscall64_nr.h"
> +rm -fr "$TMP"
> --
> 2.24.1
>
>


