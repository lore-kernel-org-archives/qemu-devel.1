Return-Path: <SRS0=gcBw=UA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B81C28CC1
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Jun 2019 14:17:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A58027694
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Jun 2019 14:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="mzsc7sGW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A58027694
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37640 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hX4om-0003rP-MI
	for qemu-devel@archiver.kernel.org; Sat, 01 Jun 2019 10:17:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hX4nv-0003LW-8v
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 10:16:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hX4nt-0001w2-Tb
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 10:16:15 -0400
Received: from mail-eopbgr770094.outbound.protection.outlook.com
	([40.107.77.94]:65249
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hX4nt-0001uk-J8
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 10:16:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=iqys8OfMkMav0a6HExbdV7WLj6HPLAFsnHz9lnM+i+g=;
	b=mzsc7sGW/vaK9jB5AbU01/diRT03K+YNUUjFp4nYm72dabijILu9KQHRmjIRPRuNStgHnwSwOGsxFv8GZvR+QGEc1tbWucvWrZsZLXmh7pQrM9fhjH4GVGlFFD16HOY5CKh5Jhqj7ujdhA0aMFntMkXZelmfa/+rnSWGAXmlqQs=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
	BN6PR2201MB1012.namprd22.prod.outlook.com (10.174.88.38) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1922.18; Sat, 1 Jun 2019 14:16:08 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::854a:15e2:b5f:e2c8]) by
	BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::854a:15e2:b5f:e2c8%8]) with mapi id 15.20.1922.021;
	Sat, 1 Jun 2019 14:16:08 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
Thread-Topic: [PATCH 1/2] target/mips: Improve performance for MSA binary
	operations
Thread-Index: AQHU0qqIl/K0DkPLJkmgHbdIuPoLNaaHYsbP
Date: Sat, 1 Jun 2019 14:16:08 +0000
Message-ID: <BN6PR2201MB1251E8A4D8209209DAC36D69C61A0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1551718283-4487-1-git-send-email-mateja.marjanovic@rt-rk.com>,
	<1551718283-4487-2-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1551718283-4487-2-git-send-email-mateja.marjanovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 686da7f8-3255-4744-30c4-08d6e69bb158
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:BN6PR2201MB1012; 
x-ms-traffictypediagnostic: BN6PR2201MB1012:
x-microsoft-antispam-prvs: <BN6PR2201MB1012FD4D92A4BBF225228C34C61A0@BN6PR2201MB1012.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:243;
x-forefront-prvs: 00550ABE1F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(136003)(396003)(39850400004)(366004)(376002)(189003)(199004)(107886003)(55016002)(316002)(9686003)(478600001)(53936002)(33656002)(256004)(54906003)(52536014)(66476007)(66946007)(6436002)(110136005)(66446008)(64756008)(229853002)(66556008)(6246003)(102836004)(76176011)(68736007)(2906002)(5660300002)(7696005)(73956011)(76116006)(7736002)(305945005)(14454004)(91956017)(186003)(486006)(53546011)(26005)(6506007)(74316002)(99286004)(6116002)(66066001)(3846002)(446003)(55236004)(81166006)(86362001)(2501003)(71200400001)(81156014)(71190400001)(4326008)(8676002)(476003)(11346002)(25786009)(8936002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1012;
	H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KdWibop5garI9fpS5Mrt2oPGoMnkW6Ryo7G3Vx1ai3zMs7QgJHi40R0J9eAQFtNUTUkjpdXP3s7HypwdT7EQQNcC70wpEWm3H7BEERBZc7O7Ndt3Zi+1BnW+qiOCe2BAzTtgcfqMGbmL612wjEylC3kvC+w/E9d15j4K2BYid9uPIlmXwFvtLAT8d42EwYVeom14cNvFm4Jbib9/yvZAwsJc05U7rUtgPQD255uOCaZZvj0Mdo4gshdMtMTYEKFEuNNzEfFhj4juDVBixfNyWxD55VOrSdr5fw8LBR6EXlImEnbT1iS4AG5ufRxY8ApL0GYbLw/dPndbjQkGmoTfxz14/pmi9oFYjCo4u+7xh95b4ElKL6M4BAPKb11yXJGrLgB64jUhkcP7quXk6Z/jGU/tMukTaxrc0+fUF7TI25E=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 686da7f8-3255-4744-30c4-08d6e69bb158
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2019 14:16:08.6708 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: amarkovic@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1012
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.77.94
Subject: Re: [Qemu-devel] [PATCH 1/2] target/mips: Improve performance for
 MSA binary operations
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	"aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> Sent: Monday, March 4, 2019 5:51 PM
> To: qemu-devel@nongnu.org
> Cc: aurelien@aurel32.net; Aleksandar Markovic; Aleksandar Rikalo
> Subject: [PATCH 1/2] target/mips: Improve performance for MSA binary oper=
ations
>=20
> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>=20
> Eliminate loops for better performance.
>=20
> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> ---
>  target/mips/msa_helper.c | 43 ++++++++++++++++++++++++++++++------------=
-
>  1 file changed, 30 insertions(+), 13 deletions(-)
>=20

The commit message should be a little bit more informative - for example,
it could list the affected instructions. Please consider other groups of
MSA instructions that are implemented via helpers that use similar "for"
loops. Otherwise:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

> diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
> index 4c7ec05..1152fda 100644
> --- a/target/mips/msa_helper.c
> +++ b/target/mips/msa_helper.c
> @@ -804,28 +804,45 @@ void helper_msa_ ## func ## _df(CPUMIPSState *env, =
uint32_t > df,         \
>      wr_t *pwd =3D &(env->active_fpu.fpr[wd].wr);                        =
  \
>      wr_t *pws =3D &(env->active_fpu.fpr[ws].wr);                        =
  \
>      wr_t *pwt =3D &(env->active_fpu.fpr[wt].wr);                        =
  \
> -    uint32_t i;                                                         =
\
>                                                                          =
\
>      switch (df) {                                                       =
\
>      case DF_BYTE:                                                       =
\
> -        for (i =3D 0; i < DF_ELEMENTS(DF_BYTE); i++) {                  =
  \
> -            pwd->b[i] =3D msa_ ## func ## _df(df, pws->b[i], pwt->b[i]);=
  \
> -        }                                                               =
\
> +        pwd->b[0]  =3D msa_ ## func ## _df(df, pws->b[0], pwt->b[0]);   =
  \
> +        pwd->b[1]  =3D msa_ ## func ## _df(df, pws->b[1], pwt->b[1]);   =
  \
> +        pwd->b[2]  =3D msa_ ## func ## _df(df, pws->b[2], pwt->b[2]);   =
  \
> +        pwd->b[3]  =3D msa_ ## func ## _df(df, pws->b[3], pwt->b[3]);   =
  \
> +        pwd->b[4]  =3D msa_ ## func ## _df(df, pws->b[4], pwt->b[4]);   =
  \
> +        pwd->b[5]  =3D msa_ ## func ## _df(df, pws->b[5], pwt->b[5]);   =
  \
> +        pwd->b[6]  =3D msa_ ## func ## _df(df, pws->b[6], pwt->b[6]);   =
  \
> +        pwd->b[7]  =3D msa_ ## func ## _df(df, pws->b[7], pwt->b[7]);   =
  \
> +        pwd->b[8]  =3D msa_ ## func ## _df(df, pws->b[8], pwt->b[8]);   =
  \
> +        pwd->b[9]  =3D msa_ ## func ## _df(df, pws->b[9], pwt->b[9]);   =
  \
> +        pwd->b[10] =3D msa_ ## func ## _df(df, pws->b[10], pwt->b[10]); =
  \
> +        pwd->b[11] =3D msa_ ## func ## _df(df, pws->b[11], pwt->b[11]); =
  \
> +        pwd->b[12] =3D msa_ ## func ## _df(df, pws->b[12], pwt->b[12]); =
  \
> +        pwd->b[13] =3D msa_ ## func ## _df(df, pws->b[13], pwt->b[13]); =
  \
> +        pwd->b[14] =3D msa_ ## func ## _df(df, pws->b[14], pwt->b[14]); =
  \
> +        pwd->b[15] =3D msa_ ## func ## _df(df, pws->b[15], pwt->b[15]); =
  \
>          break;                                                          =
\
>      case DF_HALF:                                                       =
\
> -        for (i =3D 0; i < DF_ELEMENTS(DF_HALF); i++) {                  =
  \
> -            pwd->h[i] =3D msa_ ## func ## _df(df, pws->h[i], pwt->h[i]);=
  \
> -        }                                                               =
\
> +        pwd->h[0] =3D msa_ ## func ## _df(df, pws->h[0], pwt->h[0]);    =
  \
> +        pwd->h[1] =3D msa_ ## func ## _df(df, pws->h[1], pwt->h[1]);    =
  \
> +        pwd->h[2] =3D msa_ ## func ## _df(df, pws->h[2], pwt->h[2]);    =
  \
> +        pwd->h[3] =3D msa_ ## func ## _df(df, pws->h[3], pwt->h[3]);    =
  \
> +        pwd->h[4] =3D msa_ ## func ## _df(df, pws->h[4], pwt->h[4]);    =
  \
> +        pwd->h[5] =3D msa_ ## func ## _df(df, pws->h[5], pwt->h[5]);    =
  \
> +        pwd->h[6] =3D msa_ ## func ## _df(df, pws->h[6], pwt->h[6]);    =
  \
> +        pwd->h[7] =3D msa_ ## func ## _df(df, pws->h[7], pwt->h[7]);    =
  \
>          break;                                                          =
\
>      case DF_WORD:                                                       =
\
> -        for (i =3D 0; i < DF_ELEMENTS(DF_WORD); i++) {                  =
  \
> -            pwd->w[i] =3D msa_ ## func ## _df(df, pws->w[i], pwt->w[i]);=
  \
> -        }                                                               =
\
> +        pwd->w[0] =3D msa_ ## func ## _df(df, pws->w[0], pwt->w[0]);    =
  \
> +        pwd->w[1] =3D msa_ ## func ## _df(df, pws->w[1], pwt->w[1]);    =
  \
> +        pwd->w[2] =3D msa_ ## func ## _df(df, pws->w[2], pwt->w[2]);    =
  \
> +        pwd->w[3] =3D msa_ ## func ## _df(df, pws->w[3], pwt->w[3]);    =
  \
>          break;                                                          =
\
>      case DF_DOUBLE:                                                     =
\
> -        for (i =3D 0; i < DF_ELEMENTS(DF_DOUBLE); i++) {                =
  \
> -            pwd->d[i] =3D msa_ ## func ## _df(df, pws->d[i], pwt->d[i]);=
  \
> -        }                                                               =
\
> +        pwd->d[0] =3D msa_ ## func ## _df(df, pws->d[0], pwt->d[0]);    =
  \
> +        pwd->d[1] =3D msa_ ## func ## _df(df, pws->d[1], pwt->d[1]);    =
  \
>          break;                                                          =
\
>      default:                                                            =
\
>          assert(0);                                                      =
\
> --
> 2.7.4
>=20
> =

