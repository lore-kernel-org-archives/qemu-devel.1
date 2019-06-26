Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31074C48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 10:18:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 049FB20656
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 10:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="dEZ/y3k7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049FB20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg50Q-0007C5-91
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 06:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46686)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <arikalo@wavecomp.com>) id 1hg4vm-0004Nr-Ng
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 06:13:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arikalo@wavecomp.com>) id 1hg4vh-0002d1-A9
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 06:13:32 -0400
Received: from mail-eopbgr710135.outbound.protection.outlook.com
 ([40.107.71.135]:30386 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
 id 1hg4vZ-0002FL-2R
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 06:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uMek8ri2brabssvkG+bZ1M6wMMwRnpkj865iUclQMY=;
 b=dEZ/y3k7PY+lkgjQzIYPMKf2Lo19y9tGBjjvVop4yQkq8dHw5XDefY0T6CcAG5wsiPcc/VQJO8+T4RWp29hInlUAARTM+rJix3rkUFY1X26a0bssx+mzNSzrljhyeRxUadkSIzTrDENEAXqBMok5igK6oaafbIipFZc3EvFgi6Q=
Received: from DM5PR22MB1658.namprd22.prod.outlook.com (10.164.152.163) by
 DM5PR22MB0364.namprd22.prod.outlook.com (10.173.174.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Wed, 26 Jun 2019 10:13:09 +0000
Received: from DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::3579:1b6c:1f31:c6b9]) by DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::3579:1b6c:1f31:c6b9%7]) with mapi id 15.20.2008.018; Wed, 26 Jun 2019
 10:13:09 +0000
From: Aleksandar Rikalo <arikalo@wavecomp.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v6 8/8] target/mips: Fix big endian host behavior for
 interleave MSA instructions
Thread-Index: AQHVLAb1PbuKIgIXfE+6FY/hXfpZsKattze9
Date: Wed, 26 Jun 2019 10:13:09 +0000
Message-ID: <DM5PR22MB16581E0A25343FB6F5464D53D2E20@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1561543629-20327-1-git-send-email-aleksandar.markovic@rt-rk.com>,
 <1561543629-20327-9-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1561543629-20327-9-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arikalo@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04150d74-061f-4ea4-fcf4-08d6fa1ee38b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DM5PR22MB0364; 
x-ms-traffictypediagnostic: DM5PR22MB0364:
x-microsoft-antispam-prvs: <DM5PR22MB0364AB6DA8EF9348506EF3D3D2E20@DM5PR22MB0364.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(366004)(346002)(39850400004)(136003)(199004)(189003)(9686003)(68736007)(102836004)(54896002)(66066001)(2501003)(25786009)(55016002)(316002)(107886003)(6246003)(53936002)(110136005)(14454004)(33656002)(8936002)(229853002)(6116002)(8676002)(7736002)(81156014)(81166006)(2906002)(3846002)(26005)(186003)(6606003)(4326008)(478600001)(74316002)(6436002)(76176011)(66946007)(76116006)(64756008)(91956017)(71200400001)(446003)(66446008)(11346002)(71190400001)(6506007)(66556008)(486006)(5660300002)(256004)(19627405001)(66476007)(476003)(73956011)(99286004)(86362001)(7696005)(52536014)(53546011)(55236004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR22MB0364;
 H:DM5PR22MB1658.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vJVG8fa86VIFbylWRyfx+6Mtqjo/31aihRaGZhFl2WsSuo6avrvB5wig7qgWnOPJzNRrBEuT7rJmpxWV3DJYx4MSZMSDPFdW1n93K2QRJ4k6pqp60Xq3FOMhJy28WaL+Y7ehioDHXt5wDfMTeU4AT7XuQP6nK7Sx3jpozlf+GcflG4IBUWMIZ+aDa7FpFmtCNePGL+Kya2bRBqi3b4FsUXI2Pi4Y6q7cbpeYA9KeczJzv2oK5dTXmMV3TWqCRr8uUt6yt09MbWJqduUoHKUHfeHlY0E+Zcb9vxk8SC15s8zMEeNNHRlRN1eSkWeSOiilPyYdLvdL2jWoyc2u8TAdOCcT6mqMlFjreMKkcrwbt/5BKpi1zAHIztkBOwf7wJEQT8g7TB0Plf+IsgVDlCHhqaO1MuxQ/7ssga0/48vZs7k=
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04150d74-061f-4ea4-fcf4-08d6fa1ee38b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 10:13:09.1489 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: arikalo@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR22MB0364
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.135
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v6 8/8] target/mips: Fix big endian host
 behavior for interleave MSA instructions
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Wednesday, June 26, 2019 12:07 PM
> To: qemu-devel@nongnu.org
> Cc: Aleksandar Markovic; Aleksandar Rikalo
> Subject: [PATCH v6 8/8] target/mips: Fix big endian host behavior for int=
erleave MSA instructions
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Fix big endian host behavior for interleave MSA instructions. Previous
> fix used TARGET_WORDS_BIGENDIAN instead of HOST_WORDS_BIGENDIAN, which
> was a mistake.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/msa_helper.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
> index 7a9bfb3..8bad636 100644
> --- a/target/mips/msa_helper.c
> +++ b/target/mips/msa_helper.c
> @@ -1737,7 +1737,7 @@ void helper_msa_ilvev_df(CPUMIPSState *env, uint32_=
t df, uint32_t wd,
>
>      switch (df) {
>      case DF_BYTE:
> -#if defined(TARGET_WORDS_BIGENDIAN)
> +#if defined(HOST_WORDS_BIGENDIAN)
>          pwd->b[8]  =3D pws->b[9];
>          pwd->b[9]  =3D pwt->b[9];
>          pwd->b[10] =3D pws->b[11];
> @@ -1774,7 +1774,7 @@ void helper_msa_ilvev_df(CPUMIPSState *env, uint32_=
t df, uint32_t wd,
>  #endif
>          break;
>      case DF_HALF:
> -#if defined(TARGET_WORDS_BIGENDIAN)
> +#if defined(HOST_WORDS_BIGENDIAN)
>          pwd->h[4] =3D pws->h[5];
>          pwd->h[5] =3D pwt->h[5];
>          pwd->h[6] =3D pws->h[7];
> @@ -1795,7 +1795,7 @@ void helper_msa_ilvev_df(CPUMIPSState *env, uint32_=
t df, uint32_t wd,
>  #endif
>          break;
>      case DF_WORD:
> -#if defined(TARGET_WORDS_BIGENDIAN)
> +#if defined(HOST_WORDS_BIGENDIAN)
>          pwd->w[2] =3D pws->w[3];
>          pwd->w[3] =3D pwt->w[3];
>          pwd->w[0] =3D pws->w[1];
> @@ -1825,7 +1825,7 @@ void helper_msa_ilvod_df(CPUMIPSState *env, uint32_=
t df, uint32_t wd,
>
>      switch (df) {
>      case DF_BYTE:
> -#if defined(TARGET_WORDS_BIGENDIAN)
> +#if defined(HOST_WORDS_BIGENDIAN)
>          pwd->b[7]  =3D pwt->b[6];
>          pwd->b[6]  =3D pws->b[6];
>          pwd->b[5]  =3D pwt->b[4];
> @@ -1862,7 +1862,7 @@ void helper_msa_ilvod_df(CPUMIPSState *env, uint32_=
t df, uint32_t wd,
>  #endif
>          break;
>      case DF_HALF:
> -#if defined(TARGET_WORDS_BIGENDIAN)
> +#if defined(HOST_WORDS_BIGENDIAN)
>          pwd->h[3] =3D pwt->h[2];
>          pwd->h[2] =3D pws->h[2];
>          pwd->h[1] =3D pwt->h[0];
> @@ -1883,7 +1883,7 @@ void helper_msa_ilvod_df(CPUMIPSState *env, uint32_=
t df, uint32_t wd,
>  #endif
>          break;
>      case DF_WORD:
> -#if defined(TARGET_WORDS_BIGENDIAN)
> +#if defined(HOST_WORDS_BIGENDIAN)
>          pwd->w[1] =3D pwt->w[0];
>          pwd->w[0] =3D pws->w[0];
>          pwd->w[3] =3D pwt->w[2];
> @@ -1913,7 +1913,7 @@ void helper_msa_ilvl_df(CPUMIPSState *env, uint32_t=
 df, uint32_t wd,
>
>      switch (df) {
>      case DF_BYTE:
> -#if defined(TARGET_WORDS_BIGENDIAN)
> +#if defined(HOST_WORDS_BIGENDIAN)
>          pwd->b[7]  =3D pwt->b[15];
>          pwd->b[6]  =3D pws->b[15];
>          pwd->b[5]  =3D pwt->b[14];
> @@ -1950,7 +1950,7 @@ void helper_msa_ilvl_df(CPUMIPSState *env, uint32_t=
 df, uint32_t wd,
>  #endif
>          break;
>      case DF_HALF:
> -#if defined(TARGET_WORDS_BIGENDIAN)
> +#if defined(HOST_WORDS_BIGENDIAN)
>          pwd->h[3] =3D pwt->h[7];
>          pwd->h[2] =3D pws->h[7];
>          pwd->h[1] =3D pwt->h[6];
> @@ -1971,7 +1971,7 @@ void helper_msa_ilvl_df(CPUMIPSState *env, uint32_t=
 df, uint32_t wd,
>  #endif
>          break;
>      case DF_WORD:
> -#if defined(TARGET_WORDS_BIGENDIAN)
> +#if defined(HOST_WORDS_BIGENDIAN)
>          pwd->w[1] =3D pwt->w[3];
>          pwd->w[0] =3D pws->w[3];
>          pwd->w[3] =3D pwt->w[2];
> @@ -2001,7 +2001,7 @@ void helper_msa_ilvr_df(CPUMIPSState *env, uint32_t=
 df, uint32_t wd,
>
>      switch (df) {
>      case DF_BYTE:
> -#if defined(TARGET_WORDS_BIGENDIAN)
> +#if defined(HOST_WORDS_BIGENDIAN)
>          pwd->b[8]  =3D pws->b[0];
>          pwd->b[9]  =3D pwt->b[0];
>          pwd->b[10] =3D pws->b[1];
> @@ -2038,7 +2038,7 @@ void helper_msa_ilvr_df(CPUMIPSState *env, uint32_t=
 df, uint32_t wd,
>  #endif
>          break;
>      case DF_HALF:
> -#if defined(TARGET_WORDS_BIGENDIAN)
> +#if defined(HOST_WORDS_BIGENDIAN)
>          pwd->h[4] =3D pws->h[0];
>          pwd->h[5] =3D pwt->h[0];
>          pwd->h[6] =3D pws->h[1];
> @@ -2059,7 +2059,7 @@ void helper_msa_ilvr_df(CPUMIPSState *env, uint32_t=
 df, uint32_t wd,
>  #endif
>          break;
>      case DF_WORD:
> -#if defined(TARGET_WORDS_BIGENDIAN)
> +#if defined(HOST_WORDS_BIGENDIAN)
>          pwd->w[2] =3D pws->w[0];
>          pwd->w[3] =3D pwt->w[0];
>          pwd->w[0] =3D pws->w[1];
> --
> 2.7.4

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>

