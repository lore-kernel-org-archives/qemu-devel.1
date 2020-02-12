Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C119AC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:29:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E60A20714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W+LYKKgy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="K6VpmppR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E60A20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1utV-00076V-R9
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 11:29:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1j1usb-000697-K3
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:28:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1j1usa-00084o-Eb
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:28:49 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:47448)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1j1usa-00084D-5v
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:28:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1581524928; x=1613060928;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1kloJvDSr2RtmQGp5wWYBSn4sPyRR0kE5R3yRLs7wCQ=;
 b=W+LYKKgy7fu531Xy0tPhIW5derNhaP1A6r4N4ETBPxBlOnbnhfyxEHmv
 jbHBzVXpSCbSxVn5ZnFMTlQgKlN16z4mZ/z8JRPMCExMejV48L7CNCiKa
 pnn9N76LWHDX7z3nfv3ZwWupoVLn2vLzbJeBhs1521fbUHeF5WvQTqIOR A=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 12 Feb 2020 08:28:47 -0800
Received: from nasanexm03d.na.qualcomm.com ([10.85.0.91])
 by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 12 Feb 2020 08:28:47 -0800
Received: from eusanexr01f.eu.qualcomm.com (10.85.0.101) by
 nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Wed, 12 Feb 2020 08:28:46 -0800
Received: from NASANEXM01D.na.qualcomm.com (10.85.0.84) by
 eusanexr01f.eu.qualcomm.com (10.85.0.101) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Wed, 12 Feb 2020 08:28:44 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01D.na.qualcomm.com (10.85.0.84) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Wed, 12 Feb 2020 08:28:44 -0800
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (52.135.234.160) by
 BYAPR02MB4646.namprd02.prod.outlook.com (52.135.238.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.29; Wed, 12 Feb 2020 16:28:43 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62%6]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 16:28:43 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH 1/2] tcg: Add tcg_gen_gvec_5_ptr
Thread-Topic: [PATCH 1/2] tcg: Add tcg_gen_gvec_5_ptr
Thread-Index: AQHV4U9t3CkgnkdCdU6xVirB3lTGJqgXwD+w
Date: Wed, 12 Feb 2020 16:28:43 +0000
Message-ID: <BYAPR02MB4886262FA735035F33CD76F2DE1B0@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <20200212025145.24300-1-richard.henderson@linaro.org>
 <20200212025145.24300-2-richard.henderson@linaro.org>
In-Reply-To: <20200212025145.24300-2-richard.henderson@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [199.106.103.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74f542ba-107c-4ac2-8b4d-08d7afd8a065
x-ms-traffictypediagnostic: BYAPR02MB4646:
x-microsoft-antispam-prvs: <BYAPR02MB4646986166B1A254430DD474DE1B0@BYAPR02MB4646.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39860400002)(376002)(346002)(366004)(396003)(199004)(189003)(53546011)(186003)(33656002)(52536014)(6506007)(4326008)(478600001)(26005)(71200400001)(86362001)(8936002)(54906003)(66476007)(66946007)(76116006)(66446008)(64756008)(7696005)(66556008)(55016002)(5660300002)(81156014)(2906002)(110136005)(316002)(9686003)(81166006)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB4646;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4qSWZRZREQ4CsbnrWNfEWg7ZLGoblQAsuPcmp06/PMKLjnxSItPyojovRcNUSfG2NemGHDOLlJ/DLA3cyWG2DYdQtJH23xXoTLo/46TeNgadsTbX2XT9fMSSK9k9jV9NAUPbqsUXVgartDl+wiUpFKgjH1kDrQRQ4PFqa7f9wvJ1edgh4udA+ZAHkMRe4/Tnh/A+JlrS8d289SH2KJFUHVetanrmFOEnbioXXZbpr3UbtKMSXafUk+aN5PYSFHvnFKPWY9BJrPDISxQtjFb9DmJzCGDMGW+Mwkwdp29iukM1KglgjCyChaIU5u6fgViV85wAhFTBAJJoMMEmJZxbZWvNSil+E7smnShnjKiBmhgnYyGCSwE9aRNw36X21GoetjvYMWxMditr1qSN+Tgu+Nl0ik2+FE03pA/VwvGhJ1CRGmzVDnv/T3iNx/rPLU3B
x-ms-exchange-antispam-messagedata: D0Tc1pArNvkPKGcP+e6v5YJloj5oUArFIQjekwWNomWb2dcRFu6amUH3K4OqnzzWIJnd+K75SuGCSw27QD/9c6mmWSSiaT+pVGKkzfi4gC/yhaGSv2xULggaPW1NI4iPMW0ulQ4RNBk/rHJMOss6ig==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVsbF8K3Iu4m7USeZaxAdsIgp8Y8X9Yh0LIf61bF5X0rFDdxio3+aKZeYBv3ohpaSsxKzbs+DFWb+tqUzssZENXYp3MkaRwuu51AYxlZHid6VGwdlo0GvHrYv47mJaQZPsF0Zh7oDQhIFbZk5QVPfPegGYyX95zcx/ovquYmbmgTiAHNd2g2DiMK1g8Xe//IfVFwMOLGmLDPf7E8OLPnSiH1FyTW50egFBkliIRGtERODn0sQRaHVvvfhc0I6OxKTrNPygk8WG9etM+4uMEAfx20UY8ZrM+xR89MFqxdcrWL61xd3XU8HnPDVMS68I12NZKwy71pnEgJo7V58UTE8A==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CD7CkBhAy8zCkHZQORtHlnoRI9qaag5GZ8qf9iVkOJ4=;
 b=QqGkgGL4IZxFKItZhZrdLyd1YBMI98nU5oY4P0XMkIxBWKLk5jBTntjz5K2HqmHZzt+f0EGXL8heGhORQdR/IMCnQANbSCX/GQzfiicIYvYzkPY7QDkWxXEUW8Mcv5H7GtLn9Zk3ocv+0dYqeqbe2UX7HM0x/Lv9hPEZI99VH4kNy7m/20JRiGDyLjW4ElVKUOwY11tUhdD8Zz0jEqX+0ruDCcn+ydcB59sFxBozql2g0KLT1CcZZ+LgjQBpO40rc2lQ0Jly54TkHF6UoiPOlelpHLC+n3bmNHSKq+WEu2LzquCt2k/WDMy1m+anqxhyggE2Q2iwWc9P4iN6z/IV9Q==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CD7CkBhAy8zCkHZQORtHlnoRI9qaag5GZ8qf9iVkOJ4=;
 b=K6VpmppRIA5DrcLl0h4eC4tpW5HF9KMgZBI3VR2NnxsIWn87ZBIFa5a7TuM79I1ThG32pzS60KcSiotfvPjnSm75Ro8nxIfEinABPjQMkVIMQv9LUrP3+cfAP8gahtLP/4mUXSPRdmE1Ys+kMwTVbvF0v/6inS8U86NFDwp9olU=
x-ms-exchange-crosstenant-network-message-id: 74f542ba-107c-4ac2-8b4d-08d7afd8a065
x-ms-exchange-crosstenant-originalarrivaltime: 12 Feb 2020 16:28:43.2751 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: bL8Yd7jTv+wdZF3C7KQxDqhkpe+sG/VO8CWgUvKkdvnwn0dWHJ1AqO678Ds5/cqFTzWQTBcoLcRprjyyWGJIgQ==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4646
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>


> -----Original Message-----
> From: Richard Henderson <richard.henderson@linaro.org>
> Sent: Tuesday, February 11, 2020 8:52 PM
> To: qemu-devel@nongnu.org
> Cc: peter.maydell@linaro.org; alex.bennee@linaro.org; Taylor Simpson
> <tsimpson@quicinc.com>
> Subject: [PATCH 1/2] tcg: Add tcg_gen_gvec_5_ptr
>
> Extend the vector generator infrastructure to handle
> 5 vector arguments.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/tcg/tcg-op-gvec.h |  7 +++++++
>  tcg/tcg-op-gvec.c         | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
>
> diff --git a/include/tcg/tcg-op-gvec.h b/include/tcg/tcg-op-gvec.h
> index 830d68f697..74534e2480 100644
> --- a/include/tcg/tcg-op-gvec.h
> +++ b/include/tcg/tcg-op-gvec.h
> @@ -83,6 +83,13 @@ void tcg_gen_gvec_4_ptr(uint32_t dofs, uint32_t aofs,
> uint32_t bofs,
>                          uint32_t maxsz, int32_t data,
>                          gen_helper_gvec_4_ptr *fn);
>
> +typedef void gen_helper_gvec_5_ptr(TCGv_ptr, TCGv_ptr, TCGv_ptr,
> TCGv_ptr,
> +                                   TCGv_ptr, TCGv_ptr, TCGv_i32);
> +void tcg_gen_gvec_5_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                        uint32_t cofs, uint32_t eofs, TCGv_ptr ptr,
> +                        uint32_t oprsz, uint32_t maxsz, int32_t data,
> +                        gen_helper_gvec_5_ptr *fn);
> +
>  /* Expand a gvec operation.  Either inline or out-of-line depending on
>     the actual vector size and the operations supported by the host.  */
>  typedef struct {
> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> index 41b4a3c661..327d9588e0 100644
> --- a/tcg/tcg-op-gvec.c
> +++ b/tcg/tcg-op-gvec.c
> @@ -290,6 +290,38 @@ void tcg_gen_gvec_4_ptr(uint32_t dofs, uint32_t
> aofs, uint32_t bofs,
>      tcg_temp_free_i32(desc);
>  }
>
> +/* Generate a call to a gvec-style helper with five vector operands
> +   and an extra pointer operand.  */
> +void tcg_gen_gvec_5_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                        uint32_t cofs, uint32_t eofs, TCGv_ptr ptr,
> +                        uint32_t oprsz, uint32_t maxsz, int32_t data,
> +                        gen_helper_gvec_5_ptr *fn)
> +{
> +    TCGv_ptr a0, a1, a2, a3, a4;
> +    TCGv_i32 desc =3D tcg_const_i32(simd_desc(oprsz, maxsz, data));
> +
> +    a0 =3D tcg_temp_new_ptr();
> +    a1 =3D tcg_temp_new_ptr();
> +    a2 =3D tcg_temp_new_ptr();
> +    a3 =3D tcg_temp_new_ptr();
> +    a4 =3D tcg_temp_new_ptr();
> +
> +    tcg_gen_addi_ptr(a0, cpu_env, dofs);
> +    tcg_gen_addi_ptr(a1, cpu_env, aofs);
> +    tcg_gen_addi_ptr(a2, cpu_env, bofs);
> +    tcg_gen_addi_ptr(a3, cpu_env, cofs);
> +    tcg_gen_addi_ptr(a4, cpu_env, eofs);
> +
> +    fn(a0, a1, a2, a3, a4, ptr, desc);
> +
> +    tcg_temp_free_ptr(a0);
> +    tcg_temp_free_ptr(a1);
> +    tcg_temp_free_ptr(a2);
> +    tcg_temp_free_ptr(a3);
> +    tcg_temp_free_ptr(a4);
> +    tcg_temp_free_i32(desc);
> +}
> +
>  /* Return true if we want to implement something of OPRSZ bytes
>     in units of LNSZ.  This limits the expansion of inline code.  */
>  static inline bool check_size_impl(uint32_t oprsz, uint32_t lnsz)
> --
> 2.20.1
>


