Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E37C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:22:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3B71205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L5Y14zDd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="aID6pQOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B71205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuNe-0007Ey-33
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1jDsUN-0000UT-FU
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1jDsUL-0004Kc-05
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:21:15 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:26743)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1jDsUJ-0003rc-5o
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1584375671; x=1615911671;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fPg+jc+IvHPUzOBB2FYYnYqnKSb1EDy3DluJkh0bCWg=;
 b=L5Y14zDdGpqCMYnqFi/mQ4+jeg7+PNH3TZP6r5c7/mCHk0pI1uEYaIZg
 UE2s8H44OxCXeRFVHzElYIapezsxjlrQyAQsDlm0x6q7y8U/B7maQFT1/
 mQQF0opGe1t7uOTV4wqzD91YlF1uzBP1FVUSx44JamKbtZXnOpKQiKO15 k=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 16 Mar 2020 09:21:07 -0700
Received: from nasanexm01b.na.qualcomm.com ([10.85.0.82])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA;
 16 Mar 2020 09:21:07 -0700
Received: from eusanexr01e.eu.qualcomm.com (10.85.0.100) by
 NASANEXM01B.na.qualcomm.com (10.85.0.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 16 Mar 2020 09:21:06 -0700
Received: from nasanexm03f.na.qualcomm.com (10.85.0.47) by
 eusanexr01e.eu.qualcomm.com (10.85.0.100) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 16 Mar 2020 09:21:04 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03f.na.qualcomm.com (10.85.0.47) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 16 Mar 2020 09:21:04 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB4197.namprd02.prod.outlook.com (2603:10b6:a02:ff::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Mon, 16 Mar
 2020 16:21:03 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62%6]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 16:21:03 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Laurent Vivier <laurent@vivier.eu>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH v3 1/4] scripts: add a script to generate syscall_nr.h
Thread-Topic: [PATCH v3 1/4] scripts: add a script to generate syscall_nr.h
Thread-Index: AQHV+3DS+Ab8fmhERUaut8JIIMz4GKhLY3Uw
Date: Mon, 16 Mar 2020 16:21:02 +0000
Message-ID: <BYAPR02MB4886D8ECC90C0845C3BFE27FDEF90@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <20200316085620.309769-1-laurent@vivier.eu>
 <20200316085620.309769-2-laurent@vivier.eu>
In-Reply-To: <20200316085620.309769-2-laurent@vivier.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [70.115.140.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a42ac6b-0793-45e1-2340-08d7c9c60592
x-ms-traffictypediagnostic: BYAPR02MB4197:
x-microsoft-antispam-prvs: <BYAPR02MB4197F1A226A61B201814D5E7DEF90@BYAPR02MB4197.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 03449D5DD1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(199004)(110136005)(54906003)(86362001)(64756008)(8936002)(66476007)(66556008)(33656002)(66446008)(8676002)(498600001)(186003)(6506007)(53546011)(71200400001)(26005)(5660300002)(81166006)(81156014)(52536014)(4326008)(2906002)(7696005)(55016002)(76116006)(9686003)(66946007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB4197;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X21UOsfFv5yJEUDfLA0nnAwCPELpXMhfBMm/aer3nyRHMRvDzF0SFvPhGYcaaZjSAMePSsolpc/oOQm+DhRWPqhnkfGaC8+KnoW8W+4J1ZposWlXgbJ5NdziTVCvMvNRV5O+8DSxIpzlXX6MR/V6TE1R8J4D+mXfRTeUOQBeHnZAeey53x2mKz6yjuLyiYxuDYNFpaxuxBNEwx0+SBQ+q1oRikOg+7u9w0S+zl8VmBjs/oZPxgiijMpnQhW7VYkG7PzTRWAEJuwd4mauI2on/jDAWAX8n5U5s0vxSDehg2GSXgzhM+fWFCnutiJ2by/NilhKlh1beMl7z1NC0jUE5XOjDEVcWp/SA2HZNg6GZqNYaGTZMfLF+gEf4vBSU+8SCknwGPD/xG6xPMrQ7TZlOWSENeqt98kBW0ADjjj7sp1rxuqnOp0Er0Rxn522ghTP
x-ms-exchange-antispam-messagedata: 8oFzRjSj37ip91X9taDhFCuRdcgrmVO64C9QvVL24YqfRQS8h+0HdtepE+4bbJDtDiMaSwSTqQIocwnb0be1pRneEt6B+oljbGm79Ox37r0yP1b9WCfmLdgQPZp+AnyENef+4p02qkouBCOebf4szg==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWOyjJrrchqXeDB0L6ABzGEvYZowgDt9U5AJh4We24zfbsxPN/InyeLSEaPnOZglFOwP6FMgniSqH2ddoyFOu+iMYI4Foe6sRIZdDT/K8JbzY0tXslGfVRakCgxnAnT+/FyJyRP9QrEgOmQzqJfldYPoUBHLTz8NeecugEjoVyjIgsxn+U6mQDNnkpJH8aVYBWhJU/PMF/9vvzembdtLaoOQ+aXK495ysjsZ+8+sS0CaCM+vBKixBR+5PwqAXbu6sjGF2zxoEZUjg9vh0C09IAnJ+u9PoWdCtKv8AtnJ6e+U19dr/vbJ83WwQrwRyy/af1U1//eB/g9FYGZmUKpmsA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcitaUP2psmXDvGNOWvQixTcty/DoPn1ZyfDLegjO3Q=;
 b=WY6tFuBnOs6KuYYxWvqUOFZDeFz9/EuvPRy0KrHkvT3sMShsyQeqqAHN1uqASmlN7l7nhgOJtlFevXYXgBQeTcECJsQ6zbm9F/fxKPLCcj00vEKgx2zX6RTAcUVNOhP67C7WNKePcULRXdcyF9ZqidT4TC1pOCQQxCD/2i8xzV8PEblEPgSof4WdKi9Tf4ZugUCS4UooIEtlioUr8lYVJi92ptSLwQX8dgjhxbLELwt0wAlisawseU0mEWzVFrRox3Bv47Ojm5iJQN5M2VL6leDZMXBkRuh6IOE8hw3CGoWOmf91OxurhRvvpjyP83c5lf4MuLCHSAnZV6nEHr+B6A==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcitaUP2psmXDvGNOWvQixTcty/DoPn1ZyfDLegjO3Q=;
 b=aID6pQOzRYmE/GQI9SuVPP50HBcH6BFMH9aW7tge4x1i8HwUDN1eF3iFka3K/SxVb5yEGFtHhymx4YvrkTXfoH4Z8nwSm4AZJRE2yjoemBxgsd9c+sIouOEuHOzKWgta6ny32+o6Tmw7uM8436pKqDF3Gd4kY2tTCUdjpCvvOYQ=
x-ms-exchange-crosstenant-network-message-id: 8a42ac6b-0793-45e1-2340-08d7c9c60592
x-ms-exchange-crosstenant-originalarrivaltime: 16 Mar 2020 16:21:02.8786 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 2wqPAe5+DddUop1WxjBL7Ojjo4obTV9UAJ2HzH1lLuXxNajZHy/WLaPEz2SqvW66dCocPIkc6+T9cGHzQMvpDQ==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4197
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Laurent Vivier <laurent@vivier.eu>
> Sent: Monday, March 16, 2020 3:56 AM
> To: qemu-devel@nongnu.org
> Cc: Laurent Vivier <laurent@vivier.eu>; Richard Henderson
> <richard.henderson@linaro.org>; Riku Voipio <riku.voipio@iki.fi>; Taylor
> Simpson <tsimpson@quicinc.com>; Alistair Francis
> <alistair.francis@wdc.com>
> Subject: [PATCH v3 1/4] scripts: add a script to generate syscall_nr.h
>
> This script is needed for targets based on asm-generic syscall numbers
> generation
>
> +
> +filter_defines()
> +{
> +    grep -e "#define __NR_" -e "#define __NR3264"

For Hexagon, we're still running a 4.9 kernel.  When I tried out this scrip=
t on that code base, there are a handful of these
    #undef __NR_syscalls
    #define __NR_syscalls 291
This works fine with normal C preprocessing, and the last one wins.  Howeve=
r, when the #undef's are filtered out, it lease to build errors from multip=
le #define's of TARGET_NR_syscalls.  AFAIK, qemu doesn't use this, so it sh=
ould be OK to filter out.  So, I changed the above line to
    grep -e "#define __NR_" -e "#define __NR3264" | grep -v "__NR_syscalls"

If you're OK incorporating that now, great!  Otherwise, I'll add it to the =
Hexagon RFC patch series until we get to a newer kernel.

Thanks,
Taylor


> +}
> +



