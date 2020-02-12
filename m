Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A630CC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:29:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FB5120714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pvttn9hJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="b8OXhz6Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FB5120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1usp-0006Cw-Ja
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 11:29:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1j1us8-0005hH-6d
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:28:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1j1us5-0007d9-KV
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:28:20 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:38493)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1j1us5-0007c5-5p
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:28:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1581524897; x=1613060897;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3Trs6O1PKq7U8zJa4L864Ef3ckqPeOGsMgaCmrECBBg=;
 b=pvttn9hJ+sNXePMQZZu+YApPveAChaqO9SAEfnsi+y1+b7by6D8MjVc/
 hMVblASnXVdC3ri8FEEmqEq+fg+YUL5WLnbBPmNZ/7UD+ZryvYJWSV3qA
 RY45jLP0VX564Y2TReJY+I/h831zEK7LagLFvHtwpbXs7AzF4qTMmlzHv s=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 12 Feb 2020 08:28:15 -0800
Received: from nasanexm03g.na.qualcomm.com ([10.85.0.49])
 by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 12 Feb 2020 08:28:15 -0800
Received: from apsanexr02a.ap.qualcomm.com (10.85.0.26) by
 nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Wed, 12 Feb 2020 08:28:14 -0800
Received: from nasanexm03b.na.qualcomm.com (10.85.0.98) by
 apsanexr02a.ap.qualcomm.com (10.85.0.26) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Wed, 12 Feb 2020 08:28:12 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03b.na.qualcomm.com (10.85.0.98) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Wed, 12 Feb 2020 08:28:12 -0800
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (52.135.234.160) by
 BYAPR02MB4646.namprd02.prod.outlook.com (52.135.238.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.29; Wed, 12 Feb 2020 16:28:10 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62%6]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 16:28:10 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH 2/2] target/arm: Use tcg_gen_gvec_5_ptr for sve FMLA/FCMLA
Thread-Topic: [PATCH 2/2] target/arm: Use tcg_gen_gvec_5_ptr for sve FMLA/FCMLA
Thread-Index: AQHV4U95SgAjFCyyu0eijOnVcbval6gXv9BA
Date: Wed, 12 Feb 2020 16:28:10 +0000
Message-ID: <BYAPR02MB48867D98A07E6112EFB31F13DE1B0@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <20200212025145.24300-1-richard.henderson@linaro.org>
 <20200212025145.24300-3-richard.henderson@linaro.org>
In-Reply-To: <20200212025145.24300-3-richard.henderson@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [199.106.103.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14807ca3-cc3e-45c6-72de-08d7afd88cb5
x-ms-traffictypediagnostic: BYAPR02MB4646:
x-microsoft-antispam-prvs: <BYAPR02MB464658D1F90ABA31DD77192DDE1B0@BYAPR02MB4646.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(199004)(189003)(53546011)(186003)(33656002)(52536014)(6506007)(4326008)(26005)(71200400001)(86362001)(8936002)(498600001)(54906003)(66476007)(66946007)(76116006)(66446008)(64756008)(7696005)(66556008)(55016002)(5660300002)(81156014)(2906002)(110136005)(9686003)(30864003)(81166006)(8676002)(579004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB4646;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H8QCzzr0fpe4HYHTZCYUPpE9Qa23/ERCfzKxvPK0/BXttEM257tzAmyM2Mw2BgijfLCeR60bc0wOEA1zKncuwLOoh7gmN52LWcGuCYbYEcT8+HbAVhdFD9cKD6OYUiWVhw4YZHcxroUcA7kvaf8HhmqziGRwmkpZUrEIo3Y2BmrAOYwOM4V/Yn8LGQX94CTSJWsPWTCRyMbRzXkU5H7XetEkAOwY6X3KAfG/ZblcX0QC2PrcAJc+K7UpozJCMqmJsp47cTFPemXl51nGUJjVocMHABKv7kOZBs3YiMPnghS8yTHfgEKpK44/ZGGzbPjQGMDzznWKXyOLvFo7fZaJ8t6yycNHw4ihdWS3y7rHTSaqhs4D70hX9EAMw/t21G7AtDr/523k5H6I6IPUaXqcBgx4NXpFPQIPcpX2zyCdbWwUzbYtWWKAGhr0bd9ow33O
x-ms-exchange-antispam-messagedata: isfEthpxcLn6tKvj79T6iyGBtn8ljoKaQ117aj77FOg+ErtMXJMr/E4NyaxfoFjv+fkXm//eUSJMKHlblwXdl8xys4u6d4vZQfkJ6B6hxkmrGdZgYqBd/Par/Mg8ViyX5awwbY792l/wKqKI4yA+Kg==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjCygto8HKmKufJoYBQkSW6qGQsGutAyX0WxVlJXZkPESGJb7iUJyCG1vdLd2S/Jg4L+j9+C4x9uLcOyPoQbZrr7mfkm35AhJe2L8bgi4GDbq/smfr+AtqIXXqZNrxE7IlMGPylzvppC7cKoNyqiCmKRYTC98RHbXrmLogFML5JgvLpGWYkIbDylND6gKpV9DoOmXKrBQOTS0eJ4LqyqkKQjIqZC/7TWA3BgRuf8PmCyGDRRQRqdohIm4Uom8YbsytDm4OnXqmqusmvVI5HgI8hg61PVZGXPmf+6R0XYTpyURxHheCD0MnLOk9+rsF+w6APDu9n2uTWvn1vw8Od2kw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlJDIz+UpUVFsL4DZBINtBh8WcdcQhjrBOh+c95aRTY=;
 b=JL4D+zwkAvRcPTFdXx9M4Q3E053haXuL9mE/UYHW7TwPppSX+zWu4P8JDdzHpKI1CCUcBL2qNtGDQuX0/RyWUaKvfOB+dVyrrtG98Ya4YT4vmslGQ9m01yIjOr0gpiA+r3S6J6l5jjpipeLs3o1yE0dNWheo3XFiQAMFg6vmKVTm6PsmyIDe/RhcLmi8H/aax1/obhQEpHVajsS400k0QgjMVHJ8WOthb9tBHAhbI0SeAoPtWs7h7d7wxVteXTFJuA4tVdQgcnMZlz7OJhGNFrAG4pyEzDlipRQbfYdYvrQvDPacoY/Vb/CW29ph6B4kUysdSbBcPHv4HQifLbVXAA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlJDIz+UpUVFsL4DZBINtBh8WcdcQhjrBOh+c95aRTY=;
 b=b8OXhz6ZTgUlszyODhh8v7Q8Izu/F8hq5c8XMrU3kUD9ShnIfqqnBuANlROMEB5QY44lyYofkeQfqACN0Cw59QbX+OBBq6+Ia43aRhaYA4T0YqnUQ2FsUTzIV6THgJpMqSG8R1MMizoLROdzco8U0DfPmpSbuoYiF9cRZwwc5B4=
x-ms-exchange-crosstenant-network-message-id: 14807ca3-cc3e-45c6-72de-08d7afd88cb5
x-ms-exchange-crosstenant-originalarrivaltime: 12 Feb 2020 16:28:10.3003 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: n4q1pZGK4BLo845YQNWFg9oVAIBf8LHHUdiav6gSYyYGH8pf1MgELuMchdPsB0a8MIJjfSSw0rUmuq2M3Crwyw==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4646
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
> Subject: [PATCH 2/2] target/arm: Use tcg_gen_gvec_5_ptr for sve
> FMLA/FCMLA
>
> Now that we can pass 7 parameters, do not encode register
> operands within simd_data.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    |  45 +++++++----
>  target/arm/sve_helper.c    | 157 ++++++++++++++-----------------------
>  target/arm/translate-sve.c |  68 ++++++----------
>  3 files changed, 114 insertions(+), 156 deletions(-)
>
> diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
> index 9e79182ab4..bd8b91bdb6 100644
> --- a/target/arm/helper-sve.h
> +++ b/target/arm/helper-sve.h
> @@ -1099,25 +1099,40 @@ DEF_HELPER_FLAGS_6(sve_fcadd_s,
> TCG_CALL_NO_RWG,
>  DEF_HELPER_FLAGS_6(sve_fcadd_d, TCG_CALL_NO_RWG,
>                     void, ptr, ptr, ptr, ptr, ptr, i32)
>
> -DEF_HELPER_FLAGS_3(sve_fmla_zpzzz_h, TCG_CALL_NO_RWG, void, env,
> ptr, i32)
> -DEF_HELPER_FLAGS_3(sve_fmla_zpzzz_s, TCG_CALL_NO_RWG, void, env,
> ptr, i32)
> -DEF_HELPER_FLAGS_3(sve_fmla_zpzzz_d, TCG_CALL_NO_RWG, void, env,
> ptr, i32)
> +DEF_HELPER_FLAGS_7(sve_fmla_zpzzz_h, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_7(sve_fmla_zpzzz_s, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_7(sve_fmla_zpzzz_d, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
>
> -DEF_HELPER_FLAGS_3(sve_fmls_zpzzz_h, TCG_CALL_NO_RWG, void, env,
> ptr, i32)
> -DEF_HELPER_FLAGS_3(sve_fmls_zpzzz_s, TCG_CALL_NO_RWG, void, env,
> ptr, i32)
> -DEF_HELPER_FLAGS_3(sve_fmls_zpzzz_d, TCG_CALL_NO_RWG, void, env,
> ptr, i32)
> +DEF_HELPER_FLAGS_7(sve_fmls_zpzzz_h, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_7(sve_fmls_zpzzz_s, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_7(sve_fmls_zpzzz_d, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
>
> -DEF_HELPER_FLAGS_3(sve_fnmla_zpzzz_h, TCG_CALL_NO_RWG, void,
> env, ptr, i32)
> -DEF_HELPER_FLAGS_3(sve_fnmla_zpzzz_s, TCG_CALL_NO_RWG, void, env,
> ptr, i32)
> -DEF_HELPER_FLAGS_3(sve_fnmla_zpzzz_d, TCG_CALL_NO_RWG, void,
> env, ptr, i32)
> +DEF_HELPER_FLAGS_7(sve_fnmla_zpzzz_h, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_7(sve_fnmla_zpzzz_s, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_7(sve_fnmla_zpzzz_d, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
>
> -DEF_HELPER_FLAGS_3(sve_fnmls_zpzzz_h, TCG_CALL_NO_RWG, void, env,
> ptr, i32)
> -DEF_HELPER_FLAGS_3(sve_fnmls_zpzzz_s, TCG_CALL_NO_RWG, void, env,
> ptr, i32)
> -DEF_HELPER_FLAGS_3(sve_fnmls_zpzzz_d, TCG_CALL_NO_RWG, void, env,
> ptr, i32)
> +DEF_HELPER_FLAGS_7(sve_fnmls_zpzzz_h, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_7(sve_fnmls_zpzzz_s, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_7(sve_fnmls_zpzzz_d, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
>
> -DEF_HELPER_FLAGS_3(sve_fcmla_zpzzz_h, TCG_CALL_NO_RWG, void, env,
> ptr, i32)
> -DEF_HELPER_FLAGS_3(sve_fcmla_zpzzz_s, TCG_CALL_NO_RWG, void, env,
> ptr, i32)
> -DEF_HELPER_FLAGS_3(sve_fcmla_zpzzz_d, TCG_CALL_NO_RWG, void, env,
> ptr, i32)
> +DEF_HELPER_FLAGS_7(sve_fcmla_zpzzz_h, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_7(sve_fcmla_zpzzz_s, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_7(sve_fcmla_zpzzz_d, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
>
>  DEF_HELPER_FLAGS_5(sve_ftmad_h, TCG_CALL_NO_RWG, void, ptr, ptr,
> ptr, ptr, i32)
>  DEF_HELPER_FLAGS_5(sve_ftmad_s, TCG_CALL_NO_RWG, void, ptr, ptr,
> ptr, ptr, i32)
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index fdfa652094..33b5a54a47 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -3372,23 +3372,11 @@ DO_ZPZ_FP(sve_ucvt_dd, uint64_t,     ,
> uint64_to_float64)
>
>  #undef DO_ZPZ_FP
>
> -/* 4-operand predicated multiply-add.  This requires 7 operands to pass
> - * "properly", so we need to encode some of the registers into DESC.
> - */
> -QEMU_BUILD_BUG_ON(SIMD_DATA_SHIFT + 20 > 32);
> -
> -static void do_fmla_zpzzz_h(CPUARMState *env, void *vg, uint32_t desc,
> +static void do_fmla_zpzzz_h(void *vd, void *vn, void *vm, void *va, void
> *vg,
> +                            float_status *status, uint32_t desc,
>                              uint16_t neg1, uint16_t neg3)
>  {
>      intptr_t i =3D simd_oprsz(desc);
> -    unsigned rd =3D extract32(desc, SIMD_DATA_SHIFT, 5);
> -    unsigned rn =3D extract32(desc, SIMD_DATA_SHIFT + 5, 5);
> -    unsigned rm =3D extract32(desc, SIMD_DATA_SHIFT + 10, 5);
> -    unsigned ra =3D extract32(desc, SIMD_DATA_SHIFT + 15, 5);
> -    void *vd =3D &env->vfp.zregs[rd];
> -    void *vn =3D &env->vfp.zregs[rn];
> -    void *vm =3D &env->vfp.zregs[rm];
> -    void *va =3D &env->vfp.zregs[ra];
>      uint64_t *g =3D vg;
>
>      do {
> @@ -3401,45 +3389,42 @@ static void do_fmla_zpzzz_h(CPUARMState
> *env, void *vg, uint32_t desc,
>                  e1 =3D *(uint16_t *)(vn + H1_2(i)) ^ neg1;
>                  e2 =3D *(uint16_t *)(vm + H1_2(i));
>                  e3 =3D *(uint16_t *)(va + H1_2(i)) ^ neg3;
> -                r =3D float16_muladd(e1, e2, e3, 0, &env->vfp.fp_status_=
f16);
> +                r =3D float16_muladd(e1, e2, e3, 0, status);
>                  *(uint16_t *)(vd + H1_2(i)) =3D r;
>              }
>          } while (i & 63);
>      } while (i !=3D 0);
>  }
>
> -void HELPER(sve_fmla_zpzzz_h)(CPUARMState *env, void *vg, uint32_t
> desc)
> +void HELPER(sve_fmla_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
> +                              void *vg, void *status, uint32_t desc)
>  {
> -    do_fmla_zpzzz_h(env, vg, desc, 0, 0);
> +    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0, 0);
>  }
>
> -void HELPER(sve_fmls_zpzzz_h)(CPUARMState *env, void *vg, uint32_t
> desc)
> +void HELPER(sve_fmls_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
> +                              void *vg, void *status, uint32_t desc)
>  {
> -    do_fmla_zpzzz_h(env, vg, desc, 0x8000, 0);
> +    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0x8000, 0);
>  }
>
> -void HELPER(sve_fnmla_zpzzz_h)(CPUARMState *env, void *vg, uint32_t
> desc)
> +void HELPER(sve_fnmla_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
> +                               void *vg, void *status, uint32_t desc)
>  {
> -    do_fmla_zpzzz_h(env, vg, desc, 0x8000, 0x8000);
> +    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0x8000, 0x8000);
>  }
>
> -void HELPER(sve_fnmls_zpzzz_h)(CPUARMState *env, void *vg, uint32_t
> desc)
> +void HELPER(sve_fnmls_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
> +                               void *vg, void *status, uint32_t desc)
>  {
> -    do_fmla_zpzzz_h(env, vg, desc, 0, 0x8000);
> +    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0, 0x8000);
>  }
>
> -static void do_fmla_zpzzz_s(CPUARMState *env, void *vg, uint32_t desc,
> +static void do_fmla_zpzzz_s(void *vd, void *vn, void *vm, void *va, void
> *vg,
> +                            float_status *status, uint32_t desc,
>                              uint32_t neg1, uint32_t neg3)
>  {
>      intptr_t i =3D simd_oprsz(desc);
> -    unsigned rd =3D extract32(desc, SIMD_DATA_SHIFT, 5);
> -    unsigned rn =3D extract32(desc, SIMD_DATA_SHIFT + 5, 5);
> -    unsigned rm =3D extract32(desc, SIMD_DATA_SHIFT + 10, 5);
> -    unsigned ra =3D extract32(desc, SIMD_DATA_SHIFT + 15, 5);
> -    void *vd =3D &env->vfp.zregs[rd];
> -    void *vn =3D &env->vfp.zregs[rn];
> -    void *vm =3D &env->vfp.zregs[rm];
> -    void *va =3D &env->vfp.zregs[ra];
>      uint64_t *g =3D vg;
>
>      do {
> @@ -3452,45 +3437,42 @@ static void do_fmla_zpzzz_s(CPUARMState *env,
> void *vg, uint32_t desc,
>                  e1 =3D *(uint32_t *)(vn + H1_4(i)) ^ neg1;
>                  e2 =3D *(uint32_t *)(vm + H1_4(i));
>                  e3 =3D *(uint32_t *)(va + H1_4(i)) ^ neg3;
> -                r =3D float32_muladd(e1, e2, e3, 0, &env->vfp.fp_status)=
;
> +                r =3D float32_muladd(e1, e2, e3, 0, status);
>                  *(uint32_t *)(vd + H1_4(i)) =3D r;
>              }
>          } while (i & 63);
>      } while (i !=3D 0);
>  }
>
> -void HELPER(sve_fmla_zpzzz_s)(CPUARMState *env, void *vg, uint32_t
> desc)
> +void HELPER(sve_fmla_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
> +                              void *vg, void *status, uint32_t desc)
>  {
> -    do_fmla_zpzzz_s(env, vg, desc, 0, 0);
> +    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0, 0);
>  }
>
> -void HELPER(sve_fmls_zpzzz_s)(CPUARMState *env, void *vg, uint32_t
> desc)
> +void HELPER(sve_fmls_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
> +                              void *vg, void *status, uint32_t desc)
>  {
> -    do_fmla_zpzzz_s(env, vg, desc, 0x80000000, 0);
> +    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0x80000000, 0);
>  }
>
> -void HELPER(sve_fnmla_zpzzz_s)(CPUARMState *env, void *vg, uint32_t
> desc)
> +void HELPER(sve_fnmla_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
> +                               void *vg, void *status, uint32_t desc)
>  {
> -    do_fmla_zpzzz_s(env, vg, desc, 0x80000000, 0x80000000);
> +    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0x80000000,
> 0x80000000);
>  }
>
> -void HELPER(sve_fnmls_zpzzz_s)(CPUARMState *env, void *vg, uint32_t
> desc)
> +void HELPER(sve_fnmls_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
> +                               void *vg, void *status, uint32_t desc)
>  {
> -    do_fmla_zpzzz_s(env, vg, desc, 0, 0x80000000);
> +    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0, 0x80000000);
>  }
>
> -static void do_fmla_zpzzz_d(CPUARMState *env, void *vg, uint32_t desc,
> +static void do_fmla_zpzzz_d(void *vd, void *vn, void *vm, void *va, void
> *vg,
> +                            float_status *status, uint32_t desc,
>                              uint64_t neg1, uint64_t neg3)
>  {
>      intptr_t i =3D simd_oprsz(desc);
> -    unsigned rd =3D extract32(desc, SIMD_DATA_SHIFT, 5);
> -    unsigned rn =3D extract32(desc, SIMD_DATA_SHIFT + 5, 5);
> -    unsigned rm =3D extract32(desc, SIMD_DATA_SHIFT + 10, 5);
> -    unsigned ra =3D extract32(desc, SIMD_DATA_SHIFT + 15, 5);
> -    void *vd =3D &env->vfp.zregs[rd];
> -    void *vn =3D &env->vfp.zregs[rn];
> -    void *vm =3D &env->vfp.zregs[rm];
> -    void *va =3D &env->vfp.zregs[ra];
>      uint64_t *g =3D vg;
>
>      do {
> @@ -3503,31 +3485,35 @@ static void do_fmla_zpzzz_d(CPUARMState
> *env, void *vg, uint32_t desc,
>                  e1 =3D *(uint64_t *)(vn + i) ^ neg1;
>                  e2 =3D *(uint64_t *)(vm + i);
>                  e3 =3D *(uint64_t *)(va + i) ^ neg3;
> -                r =3D float64_muladd(e1, e2, e3, 0, &env->vfp.fp_status)=
;
> +                r =3D float64_muladd(e1, e2, e3, 0, status);
>                  *(uint64_t *)(vd + i) =3D r;
>              }
>          } while (i & 63);
>      } while (i !=3D 0);
>  }
>
> -void HELPER(sve_fmla_zpzzz_d)(CPUARMState *env, void *vg, uint32_t
> desc)
> +void HELPER(sve_fmla_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
> +                              void *vg, void *status, uint32_t desc)
>  {
> -    do_fmla_zpzzz_d(env, vg, desc, 0, 0);
> +    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, 0, 0);
>  }
>
> -void HELPER(sve_fmls_zpzzz_d)(CPUARMState *env, void *vg, uint32_t
> desc)
> +void HELPER(sve_fmls_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
> +                              void *vg, void *status, uint32_t desc)
>  {
> -    do_fmla_zpzzz_d(env, vg, desc, INT64_MIN, 0);
> +    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, INT64_MIN, 0);
>  }
>
> -void HELPER(sve_fnmla_zpzzz_d)(CPUARMState *env, void *vg, uint32_t
> desc)
> +void HELPER(sve_fnmla_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
> +                               void *vg, void *status, uint32_t desc)
>  {
> -    do_fmla_zpzzz_d(env, vg, desc, INT64_MIN, INT64_MIN);
> +    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, INT64_MIN,
> INT64_MIN);
>  }
>
> -void HELPER(sve_fnmls_zpzzz_d)(CPUARMState *env, void *vg, uint32_t
> desc)
> +void HELPER(sve_fnmls_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
> +                               void *vg, void *status, uint32_t desc)
>  {
> -    do_fmla_zpzzz_d(env, vg, desc, 0, INT64_MIN);
> +    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, 0, INT64_MIN);
>  }
>
>  /* Two operand floating-point comparison controlled by a predicate.
> @@ -3809,22 +3795,13 @@ void HELPER(sve_fcadd_d)(void *vd, void *vn,
> void *vm, void *vg,
>   * FP Complex Multiply
>   */
>
> -QEMU_BUILD_BUG_ON(SIMD_DATA_SHIFT + 22 > 32);
> -
> -void HELPER(sve_fcmla_zpzzz_h)(CPUARMState *env, void *vg, uint32_t
> desc)
> +void HELPER(sve_fcmla_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
> +                               void *vg, void *status, uint32_t desc)
>  {
>      intptr_t j, i =3D simd_oprsz(desc);
> -    unsigned rd =3D extract32(desc, SIMD_DATA_SHIFT, 5);
> -    unsigned rn =3D extract32(desc, SIMD_DATA_SHIFT + 5, 5);
> -    unsigned rm =3D extract32(desc, SIMD_DATA_SHIFT + 10, 5);
> -    unsigned ra =3D extract32(desc, SIMD_DATA_SHIFT + 15, 5);
> -    unsigned rot =3D extract32(desc, SIMD_DATA_SHIFT + 20, 2);
> +    unsigned rot =3D simd_data(desc);
>      bool flip =3D rot & 1;
>      float16 neg_imag, neg_real;
> -    void *vd =3D &env->vfp.zregs[rd];
> -    void *vn =3D &env->vfp.zregs[rn];
> -    void *vm =3D &env->vfp.zregs[rm];
> -    void *va =3D &env->vfp.zregs[ra];
>      uint64_t *g =3D vg;
>
>      neg_imag =3D float16_set_sign(0, (rot & 2) !=3D 0);
> @@ -3851,32 +3828,25 @@ void HELPER(sve_fcmla_zpzzz_h)(CPUARMState
> *env, void *vg, uint32_t desc)
>
>              if (likely((pg >> (i & 63)) & 1)) {
>                  d =3D *(float16 *)(va + H1_2(i));
> -                d =3D float16_muladd(e2, e1, d, 0, &env->vfp.fp_status_f=
16);
> +                d =3D float16_muladd(e2, e1, d, 0, status);
>                  *(float16 *)(vd + H1_2(i)) =3D d;
>              }
>              if (likely((pg >> (j & 63)) & 1)) {
>                  d =3D *(float16 *)(va + H1_2(j));
> -                d =3D float16_muladd(e4, e3, d, 0, &env->vfp.fp_status_f=
16);
> +                d =3D float16_muladd(e4, e3, d, 0, status);
>                  *(float16 *)(vd + H1_2(j)) =3D d;
>              }
>          } while (i & 63);
>      } while (i !=3D 0);
>  }
>
> -void HELPER(sve_fcmla_zpzzz_s)(CPUARMState *env, void *vg, uint32_t
> desc)
> +void HELPER(sve_fcmla_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
> +                               void *vg, void *status, uint32_t desc)
>  {
>      intptr_t j, i =3D simd_oprsz(desc);
> -    unsigned rd =3D extract32(desc, SIMD_DATA_SHIFT, 5);
> -    unsigned rn =3D extract32(desc, SIMD_DATA_SHIFT + 5, 5);
> -    unsigned rm =3D extract32(desc, SIMD_DATA_SHIFT + 10, 5);
> -    unsigned ra =3D extract32(desc, SIMD_DATA_SHIFT + 15, 5);
> -    unsigned rot =3D extract32(desc, SIMD_DATA_SHIFT + 20, 2);
> +    unsigned rot =3D simd_data(desc);
>      bool flip =3D rot & 1;
>      float32 neg_imag, neg_real;
> -    void *vd =3D &env->vfp.zregs[rd];
> -    void *vn =3D &env->vfp.zregs[rn];
> -    void *vm =3D &env->vfp.zregs[rm];
> -    void *va =3D &env->vfp.zregs[ra];
>      uint64_t *g =3D vg;
>
>      neg_imag =3D float32_set_sign(0, (rot & 2) !=3D 0);
> @@ -3903,32 +3873,25 @@ void HELPER(sve_fcmla_zpzzz_s)(CPUARMState
> *env, void *vg, uint32_t desc)
>
>              if (likely((pg >> (i & 63)) & 1)) {
>                  d =3D *(float32 *)(va + H1_2(i));
> -                d =3D float32_muladd(e2, e1, d, 0, &env->vfp.fp_status);
> +                d =3D float32_muladd(e2, e1, d, 0, status);
>                  *(float32 *)(vd + H1_2(i)) =3D d;
>              }
>              if (likely((pg >> (j & 63)) & 1)) {
>                  d =3D *(float32 *)(va + H1_2(j));
> -                d =3D float32_muladd(e4, e3, d, 0, &env->vfp.fp_status);
> +                d =3D float32_muladd(e4, e3, d, 0, status);
>                  *(float32 *)(vd + H1_2(j)) =3D d;
>              }
>          } while (i & 63);
>      } while (i !=3D 0);
>  }
>
> -void HELPER(sve_fcmla_zpzzz_d)(CPUARMState *env, void *vg, uint32_t
> desc)
> +void HELPER(sve_fcmla_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
> +                               void *vg, void *status, uint32_t desc)
>  {
>      intptr_t j, i =3D simd_oprsz(desc);
> -    unsigned rd =3D extract32(desc, SIMD_DATA_SHIFT, 5);
> -    unsigned rn =3D extract32(desc, SIMD_DATA_SHIFT + 5, 5);
> -    unsigned rm =3D extract32(desc, SIMD_DATA_SHIFT + 10, 5);
> -    unsigned ra =3D extract32(desc, SIMD_DATA_SHIFT + 15, 5);
> -    unsigned rot =3D extract32(desc, SIMD_DATA_SHIFT + 20, 2);
> +    unsigned rot =3D simd_data(desc);
>      bool flip =3D rot & 1;
>      float64 neg_imag, neg_real;
> -    void *vd =3D &env->vfp.zregs[rd];
> -    void *vn =3D &env->vfp.zregs[rn];
> -    void *vm =3D &env->vfp.zregs[rm];
> -    void *va =3D &env->vfp.zregs[ra];
>      uint64_t *g =3D vg;
>
>      neg_imag =3D float64_set_sign(0, (rot & 2) !=3D 0);
> @@ -3955,12 +3918,12 @@ void HELPER(sve_fcmla_zpzzz_d)(CPUARMState
> *env, void *vg, uint32_t desc)
>
>              if (likely((pg >> (i & 63)) & 1)) {
>                  d =3D *(float64 *)(va + H1_2(i));
> -                d =3D float64_muladd(e2, e1, d, 0, &env->vfp.fp_status);
> +                d =3D float64_muladd(e2, e1, d, 0, status);
>                  *(float64 *)(vd + H1_2(i)) =3D d;
>              }
>              if (likely((pg >> (j & 63)) & 1)) {
>                  d =3D *(float64 *)(va + H1_2(j));
> -                d =3D float64_muladd(e4, e3, d, 0, &env->vfp.fp_status);
> +                d =3D float64_muladd(e4, e3, d, 0, status);
>                  *(float64 *)(vd + H1_2(j)) =3D d;
>              }
>          } while (i & 63);
> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index b35bad245e..7607593f6b 100644
> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -3950,40 +3950,30 @@ static bool trans_FCADD(DisasContext *s,
> arg_FCADD *a)
>
>  typedef void gen_helper_sve_fmla(TCGv_env, TCGv_ptr, TCGv_i32);
>
> -static bool do_fmla(DisasContext *s, arg_rprrr_esz *a,
> gen_helper_sve_fmla *fn)
> +static bool do_fmla(DisasContext *s, arg_rprrr_esz *a,
> +                    gen_helper_gvec_5_ptr *fn)
>  {
> -    if (fn =3D=3D NULL) {
> +    if (a->esz =3D=3D 0) {
>          return false;
>      }
> -    if (!sve_access_check(s)) {
> -        return true;
> +    if (sve_access_check(s)) {
> +        unsigned vsz =3D vec_full_reg_size(s);
> +        TCGv_ptr status =3D get_fpstatus_ptr(a->esz =3D=3D MO_16);
> +        tcg_gen_gvec_5_ptr(vec_full_reg_offset(s, a->rd),
> +                           vec_full_reg_offset(s, a->rn),
> +                           vec_full_reg_offset(s, a->rm),
> +                           vec_full_reg_offset(s, a->ra),
> +                           pred_full_reg_offset(s, a->pg),
> +                           status, vsz, vsz, 0, fn);
> +        tcg_temp_free_ptr(status);
>      }
> -
> -    unsigned vsz =3D vec_full_reg_size(s);
> -    unsigned desc;
> -    TCGv_i32 t_desc;
> -    TCGv_ptr pg =3D tcg_temp_new_ptr();
> -
> -    /* We would need 7 operands to pass these arguments "properly".
> -     * So we encode all the register numbers into the descriptor.
> -     */
> -    desc =3D deposit32(a->rd, 5, 5, a->rn);
> -    desc =3D deposit32(desc, 10, 5, a->rm);
> -    desc =3D deposit32(desc, 15, 5, a->ra);
> -    desc =3D simd_desc(vsz, vsz, desc);
> -
> -    t_desc =3D tcg_const_i32(desc);
> -    tcg_gen_addi_ptr(pg, cpu_env, pred_full_reg_offset(s, a->pg));
> -    fn(cpu_env, pg, t_desc);
> -    tcg_temp_free_i32(t_desc);
> -    tcg_temp_free_ptr(pg);
>      return true;
>  }
>
>  #define DO_FMLA(NAME, name) \
>  static bool trans_##NAME(DisasContext *s, arg_rprrr_esz *a)          \
>  {                                                                    \
> -    static gen_helper_sve_fmla * const fns[4] =3D {                    \
> +    static gen_helper_gvec_5_ptr * const fns[4] =3D {                  \
>          NULL, gen_helper_sve_##name##_h,                             \
>          gen_helper_sve_##name##_s, gen_helper_sve_##name##_d         \
>      };                                                               \
> @@ -3999,7 +3989,8 @@ DO_FMLA(FNMLS_zpzzz, fnmls_zpzzz)
>
>  static bool trans_FCMLA_zpzzz(DisasContext *s, arg_FCMLA_zpzzz *a)
>  {
> -    static gen_helper_sve_fmla * const fns[3] =3D {
> +    static gen_helper_gvec_5_ptr * const fns[4] =3D {
> +        NULL,
>          gen_helper_sve_fcmla_zpzzz_h,
>          gen_helper_sve_fcmla_zpzzz_s,
>          gen_helper_sve_fcmla_zpzzz_d,
> @@ -4010,25 +4001,14 @@ static bool trans_FCMLA_zpzzz(DisasContext *s,
> arg_FCMLA_zpzzz *a)
>      }
>      if (sve_access_check(s)) {
>          unsigned vsz =3D vec_full_reg_size(s);
> -        unsigned desc;
> -        TCGv_i32 t_desc;
> -        TCGv_ptr pg =3D tcg_temp_new_ptr();
> -
> -        /* We would need 7 operands to pass these arguments "properly".
> -         * So we encode all the register numbers into the descriptor.
> -         */
> -        desc =3D deposit32(a->rd, 5, 5, a->rn);
> -        desc =3D deposit32(desc, 10, 5, a->rm);
> -        desc =3D deposit32(desc, 15, 5, a->ra);
> -        desc =3D deposit32(desc, 20, 2, a->rot);
> -        desc =3D sextract32(desc, 0, 22);
> -        desc =3D simd_desc(vsz, vsz, desc);
> -
> -        t_desc =3D tcg_const_i32(desc);
> -        tcg_gen_addi_ptr(pg, cpu_env, pred_full_reg_offset(s, a->pg));
> -        fns[a->esz - 1](cpu_env, pg, t_desc);
> -        tcg_temp_free_i32(t_desc);
> -        tcg_temp_free_ptr(pg);
> +        TCGv_ptr status =3D get_fpstatus_ptr(a->esz =3D=3D MO_16);
> +        tcg_gen_gvec_5_ptr(vec_full_reg_offset(s, a->rd),
> +                           vec_full_reg_offset(s, a->rn),
> +                           vec_full_reg_offset(s, a->rm),
> +                           vec_full_reg_offset(s, a->ra),
> +                           pred_full_reg_offset(s, a->pg),
> +                           status, vsz, vsz, a->rot, fns[a->esz]);
> +        tcg_temp_free_ptr(status);
>      }
>      return true;
>  }
> --
> 2.20.1
>


