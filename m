Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F028C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 23:19:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69F6D2075F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 23:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rqqSFfpG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="sq8fT4ZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F6D2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNlNs-00036x-GD
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 19:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=535555f00=Dmitry.Fomichev@wdc.com>)
 id 1kNlMb-0002XU-2N; Wed, 30 Sep 2020 19:18:21 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:31241)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=535555f00=Dmitry.Fomichev@wdc.com>)
 id 1kNlMY-0000fU-KS; Wed, 30 Sep 2020 19:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601507898; x=1633043898;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=UVhv11wI2MPjwolfqeDC7cfKr0y0q/Z/iX+1HjIh+zY=;
 b=rqqSFfpGlfiwOJJ2UhmubUcDkxlS2HlKdFnIWYlFF4r7ghogzPwXg2zs
 YpwY5XmfpTMiH+3ZmRHVN/YAtNRjvh9L7yXzmV4MlfnaE1Mpq3plhFx9u
 WIRq7rP+WPLua+KxTcP00BvyWj5hB+M0fhkhmnQbXE4QhclEPd/K3gG7+
 E87MNr4U3YBGIZm3TGU5MvU/m4FWLMoCtFdOtYIQMiMJ6DxEUPx+QESAc
 v36rOYSfEhW52VTtehJvR+aR7C5Y0zkHxg8PQNjveWKn61BCublkcJEKL
 EzJFM3OBgVibriUdcVCMEhoEAe+AMbEazN1yJMxi5Uy+uQqbAn3xkzeXW Q==;
IronPort-SDR: VCuSdTzotBe2GBhpEc9ZypqevrmXmvXV3iebR7weuiYyJvA+NxHFyI6bidzxBnyRgKv25T3LRC
 PZMtR3bg6qyT3RG16uY7GwI9RVi5OuORNIrcReH7Sx7iFnkPPJRJJyKOj24OeNZS98xK/yEVAn
 MC6VHj2TqaLvJDMsB9HjhOKoIldVsMGOHIc/uvg7fwCHjttOD9V8lWbClvL+Bod3WDNu8vXoUA
 /tkZzcRrrr+fazd+N5ElDMKVsqrvv9SxCSTYNiLNQq9xCR6XxBvPVuneNHPnyo8ef2tACNSImL
 j5Y=
X-IronPort-AV: E=Sophos;i="5.77,322,1596470400"; d="scan'208";a="153079112"
Received: from mail-bn3nam04lp2057.outbound.protection.outlook.com (HELO
 NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.57])
 by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2020 07:18:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fH5p6WhIyqr1b3PIgX53Xm/8fbow79LuY1lNDT9YaM9yFsu6h50qHJchd99cs2oG+A6oIKjUE8FSbuKCximmbVdjU2tvKM2UuN8fXRnbxdV4fKoL1f1L85Q1EPFPOI3SpW2xdbynmhlD9CVWrohj1/thFlJeVGrqAowPNIDBSIke8ZzCdbAxH2kduT2fWdnXD8eZCbqyR+mtb0iRTqBQRDAxVoXX4hn30L/4DCQieAtdzObPZGmK9PxZ32Jz46IHLObfMLSApsEcFkmK3t0ZWoCGYPZWpRDQ7+aw0BgKWKwDN04DbbwZFLjHYlbJpsPk0n0tBPHbU2qGOweJGtOGWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5qf3+r8Swp5bEhZC9ed98iVssl1TPKR1nnKJTBnghY=;
 b=SItrG/zre1FihUBN7vE7/xuUFbXjcrO19JyWgw2gwQrYL3MypRyrJ9H+CnvZGNGyolRd/F7H+l5nhCT0BcHiKbP3rgL+xdL1jzKLjvPm2tspfJcJLw+8i1k8vsTW+L0rDLb3zP/GG8xedeIUbWfhjQV+SYJP9fVX1rYeQVAPyu+TlXFYW9MG/3R29wj69tR+bAdWjISI67phrGXOxyY3cGgzPggkA0vVVt45C56IyzQNdsaVRIvgTXSPvAoz3AynvzWvdPnEzUG09FmE58XDi3f6dAtrNzpWWvrYCh/tZ7J5Rhj+DIhGYTVnAEig9molD6A1saKcLiZ+yeAcV+YtMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5qf3+r8Swp5bEhZC9ed98iVssl1TPKR1nnKJTBnghY=;
 b=sq8fT4ZOOX5D+nF0Ey/APjzcFZqOr4UcYpUJmppfcBAvqGFvY8ZpFDjtrzbEyTztEXYTlgD4gVQkRej2krEPEGBl4eGofaAEBzU3VuqMhlFzmTPYzb/VEN5lxI2vWPHeYhmZCZTYh0eqA7/3nxAfGJkptVxBTNTm8hjtO4QBFhk=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB6174.namprd04.prod.outlook.com (2603:10b6:208:e5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25; Wed, 30 Sep
 2020 23:18:14 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94%6]) with mapi id 15.20.3433.034; Wed, 30 Sep 2020
 23:18:14 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: RE: [PATCH 2/9] hw/block/nvme: fix log page offset check
Thread-Topic: [PATCH 2/9] hw/block/nvme: fix log page offset check
Thread-Index: AQHWl3WqRYHzGQmuW0eVauho5KeD7amB0IAg
Date: Wed, 30 Sep 2020 23:18:14 +0000
Message-ID: <MN2PR04MB5951576C7AB55E838B23D88BE1330@MN2PR04MB5951.namprd04.prod.outlook.com>
References: <20200930220414.562527-1-kbusch@kernel.org>
 <20200930220414.562527-3-kbusch@kernel.org>
In-Reply-To: <20200930220414.562527-3-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ec83d406-0b61-48c8-bc6a-08d865971b0d
x-ms-traffictypediagnostic: MN2PR04MB6174:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6174E21651FBB0D26C6AC53BE1330@MN2PR04MB6174.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +waUwSmKD0MxHodbvtiiyXwen+PPeCUp+8B5Fy8OZpZXW7kmWSiSuQ05Wv5b9lmqpp6+W+xIuBo/U59nlS3Yb5V0yiEzwtJr74clGbpFXsB7YtTziB+abaa46hPB49+TUgqe/iZSVcCocp0vAX+CJJZUuNEFgwLl3UMyJYorexzUbdWHosxt8HCG3hWt1g9S9gaf0kO7AlepD48mgJaV9nfaPJMhr7DZB+eAl+D3mEmtjb5c1ZnG/vhF1Skui62vLv0uXSAqvGkwEJ7AsR6Yv5oegWFyhJSsVaxW41r2Ew9Bdh7uZnRfYflY0o/SdZGimD4/K1blNyJXzwBZQPy1TTRPfQ19DrCQNVIvlMbjNf8qP1S0M15NPf0AYIovsM5z
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(6506007)(53546011)(26005)(8936002)(66446008)(66556008)(64756008)(71200400001)(66476007)(186003)(4326008)(2906002)(7696005)(5660300002)(76116006)(66946007)(86362001)(478600001)(55016002)(33656002)(8676002)(9686003)(54906003)(316002)(52536014)(83380400001)(110136005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: d3MgtQeZSZ+aiPeVn+xTS+/1I93yz9yRkGKnqZn/ojGAoAoBJeTjg8sYiByMAFirDqWxXWMg5XL+rPOq9OF3KkiZ5yv/17h08pUq9cKWxEmW7s9drbQVdaS0onWL2dpU3kqUjCtgsAfDRz2PKRPVpaOr+3ArgWq0iRzX6q0/uenHMTGT7E5GsVvaVBA/nvjqJPldPDJLE6ryFLogcbZlhlzus0EgKp5Ty8Y25qle7XbSGLoZAFRokA9KpD7DpSREImlEbJpsiEKOljOrxJFngf6r0MNCeQscNBYjBXPILq5KCRDQSH721XcsQj32oRIUwA0jmHGNSn3VHvoicTDOiDasDpjmqF0Roj2rHMUfQwF/FtqMXydvmboJ1bLugJCa/v0BmgSOoblWmem7KHlCjEemsOb4x7JkMnBHeGPVmUbmXCLMaZuGVBj05b3TM45Mq1f5dfzi0qzyRGkmCrW9Kff+qMkIVJ526qIRJdAe0Zq70RZ9NBvR3/TL8RCe8aAm4VZ+AgEHnUcqzsMHPNWqzY7+rMftrsHeF9+bwzrLyw9KtLGEoU8BA2uQhHNfjjEBdhmG2k8POK96ODBlfYsSR9s/l14mzo4VrwJJccDfR1jAAz6RyNRP0qdz3nT+ZbqGLa7AiecA+Uk2ii5Ik0F0Dw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec83d406-0b61-48c8-bc6a-08d865971b0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 23:18:14.0697 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N01KgWp6Je4vGEQYIxGA31ilPDLslBSBcCwzyj9X/nsfLwA4ntDYj24cJiaTckHnX6xxHz3j+MAXeRixu9gnfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6174
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=535555f00=Dmitry.Fomichev@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 19:18:16
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Keith Busch <kbusch@kernel.org>
> Sent: Wednesday, September 30, 2020 6:04 PM
> To: qemu-block@nongnu.org; qemu-devel@nongnu.org; Klaus Jensen
> <k.jensen@samsung.com>
> Cc: Niklas Cassel <Niklas.Cassel@wdc.com>; Dmitry Fomichev
> <Dmitry.Fomichev@wdc.com>; Kevin Wolf <kwolf@redhat.com>; Philippe
> Mathieu-Daud=E9 <philmd@redhat.com>; Keith Busch <kbusch@kernel.org>
> Subject: [PATCH 2/9] hw/block/nvme: fix log page offset check
>=20
> Return error if the requested offset starts after the size of the log
> being returned. Also, move the check for earlier in the function so
> we're not doing unnecessary calculations.
>=20
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed- by: Dmitry Fomichev <dmitry.fomichev@wdc.com>

> ---
>  hw/block/nvme.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index db52ea0db9..8d2b5be567 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1179,6 +1179,10 @@ static uint16_t nvme_smart_info(NvmeCtrl *n,
> uint8_t rae, uint32_t buf_len,
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
>=20
> +    if (off >=3D sizeof(smart)) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
>      for (int i =3D 1; i <=3D n->num_namespaces; i++) {
>          NvmeNamespace *ns =3D nvme_ns(n, i);
>          if (!ns) {
> @@ -1193,10 +1197,6 @@ static uint16_t nvme_smart_info(NvmeCtrl *n,
> uint8_t rae, uint32_t buf_len,
>          write_commands +=3D s->nr_ops[BLOCK_ACCT_WRITE];
>      }
>=20
> -    if (off > sizeof(smart)) {
> -        return NVME_INVALID_FIELD | NVME_DNR;
> -    }
> -
>      trans_len =3D MIN(sizeof(smart) - off, buf_len);
>=20
>      memset(&smart, 0x0, sizeof(smart));
> @@ -1234,12 +1234,11 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n,
> uint32_t buf_len, uint64_t off,
>          .afi =3D 0x1,
>      };
>=20
> -    strpadcpy((char *)&fw_log.frs1, sizeof(fw_log.frs1), "1.0", ' ');
> -
> -    if (off > sizeof(fw_log)) {
> +    if (off >=3D sizeof(fw_log)) {
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
>=20
> +    strpadcpy((char *)&fw_log.frs1, sizeof(fw_log.frs1), "1.0", ' ');
>      trans_len =3D MIN(sizeof(fw_log) - off, buf_len);
>=20
>      return nvme_dma(n, (uint8_t *) &fw_log + off, trans_len,
> @@ -1252,16 +1251,15 @@ static uint16_t nvme_error_info(NvmeCtrl *n,
> uint8_t rae, uint32_t buf_len,
>      uint32_t trans_len;
>      NvmeErrorLog errlog;
>=20
> -    if (!rae) {
> -        nvme_clear_events(n, NVME_AER_TYPE_ERROR);
> +    if (off >=3D sizeof(errlog)) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
>      }
>=20
> -    if (off > sizeof(errlog)) {
> -        return NVME_INVALID_FIELD | NVME_DNR;
> +    if (!rae) {
> +        nvme_clear_events(n, NVME_AER_TYPE_ERROR);
>      }
>=20
>      memset(&errlog, 0x0, sizeof(errlog));
> -
>      trans_len =3D MIN(sizeof(errlog) - off, buf_len);
>=20
>      return nvme_dma(n, (uint8_t *)&errlog, trans_len,
> --
> 2.24.1


