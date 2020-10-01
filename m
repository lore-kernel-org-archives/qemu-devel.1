Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC76C4363D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 00:14:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DA8B2074A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 00:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fi6St7V8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eFwvzOZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA8B2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNmF0-000837-Kn
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 20:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=536915954=Dmitry.Fomichev@wdc.com>)
 id 1kNmCA-0006z0-M1; Wed, 30 Sep 2020 20:11:39 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:35883)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=536915954=Dmitry.Fomichev@wdc.com>)
 id 1kNmC7-0007NH-OM; Wed, 30 Sep 2020 20:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601511095; x=1633047095;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Zi6Bv/C3uA2AzfDqjiudcmJRCqW44j6Qc+un8U9m6EI=;
 b=fi6St7V8NCmWaAfjQIAg1qNXYqDnPjKM00578vmF01qWfWgfbEC3YMK8
 uwjClSeodtC8lRDYVR8bgITIF3CdhOjfc/sxlfvrt0dQaq2EToG3MAjfk
 X5hjK79oo3NCQcr6DGaL3Qwer6iE5PmOFrNQPs+A/RYAIb53dypo9zoA3
 rrAiIM8p/AxHsXLx+lTDiMU3+28O0W/q4z+EmV/1fMMwoMnnVk5q7VaQh
 h1g1rTBXMVmtpdrWValGacIeIadMY5miM9lOnvzswudhUJAA2GWogaEoV
 k+H1W2ad/SgGrLDUjeiOTbEQK2AAX1O76KYZCTVq+Bk7Ozp2ay2hifWEh g==;
IronPort-SDR: 3LSFpUWSkLVApFfQlLIutpNg50XccTvbNIwvDemo0JUZ6H2EUiXX3tV6+RMOWDvy5FbIzl2vbq
 bFZXm18gmW1hUlaFTzzO/8SxjDT2Z+Bvkc5yVmgc3a2GZzNx+Wz2xt+co9VIctmEgv+NpjSe9i
 EPrPcp+2dd7EdgImDg8uKu1T3+uoU58EN9m1zv7BSLW7oV/vGFSBEipuMHtJ3dh2s7iAYifDx8
 J9tqoW78uP98CPmMkw5uR60Fm6ufV7bqO1Ga9Lq9YuUK8n8b5pbTBckPq65n2h26h6glqDaUDQ
 J74=
X-IronPort-AV: E=Sophos;i="5.77,322,1596470400"; d="scan'208";a="148620357"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
 by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2020 08:11:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQ0LjRolL0doR3Ua9l6H3w9JHvDfUpG5fvBnH9u6MhwatHKOArUyWoEDkjqj+1p8bL9xuC3dm5/W2VpGA6f0b2GkIuYpioB/IpKwdVEIEsUObNBiIEfh0hOW0s9mhahXWV/fEn9FwsSPqrZvyY1KO8jNyAbk+3+7wcn1G2aSG7gKgg/jsUSPIhA+f4qxYxVoWBv8Y8zNOWr81VaDeHaRuXAkqKKrZPmyxj7tTttVjNvmUxmWag023UaeZMu3pQLLFg2wNKPHXZS7dXMuT26t7ZzgWSXs0xqBe4GCS3pTh1l0n2TyagdoKQ4p9bC/FM9WoXjVeZ/paelJsbjDRNpTxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9eIXrV9O1RVU7WGqrazQRxUdmXpJOtF1mBuhb4WLGE=;
 b=H9gjR7e/Jt1vdITTH0vqVMX7I90oVyJeB/XxfAjn87adspw9SH1W6ja4BdduyiaU2m5WqAnDpxfFvQ3GaQOkX03A4wto8wthRTe6zDVrKJ8lXATfmDifIF+ptyEyv+M2C1enfEx8QN4jUgbpcFFt6pZP51iTddOb5l80sotx0FRg/zzrMe1PLabtXHEnUJMB+yf2cNsRpX6RMfUxBSU5JmD6D3UG66oDfbwHvTQCsainfSb6s/1mOtA8Mtmusx9MhYFsO0P2wJdL5y3KB2OXe1XSxhVq3UMeytxfq829T7auzneHVOU9ZZHtVDl9f9YC5bgbavLylyADABekOoqPjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9eIXrV9O1RVU7WGqrazQRxUdmXpJOtF1mBuhb4WLGE=;
 b=eFwvzOZYxv27+wZNOdH3MZ/UcY3yfPId+E4e5xNadBeeHXNAyyDG68TloUzUGbfCy9dk7vc21R+3DhwFvJvZS8vicleruhCXQYvOt6QS32pKRcCj+m/T7Ck5LRIlxGTbQ21fjPkAg5siBkEaL67On+8wilb5mn7ONaMdrZWM/qY=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5504.namprd04.prod.outlook.com (2603:10b6:208:df::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Thu, 1 Oct
 2020 00:11:28 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94%6]) with mapi id 15.20.3433.034; Thu, 1 Oct 2020
 00:11:28 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: RE: [PATCH 5/9] hw/block/nvme: support for admin-only command set
Thread-Topic: [PATCH 5/9] hw/block/nvme: support for admin-only command set
Thread-Index: AQHWl3Wq428Tvs6+U0GDIeNhKdh68KmB3BZQ
Date: Thu, 1 Oct 2020 00:11:28 +0000
Message-ID: <MN2PR04MB5951E346CE7886F58A58F29BE1300@MN2PR04MB5951.namprd04.prod.outlook.com>
References: <20200930220414.562527-1-kbusch@kernel.org>
 <20200930220414.562527-6-kbusch@kernel.org>
In-Reply-To: <20200930220414.562527-6-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 77a3d6c9-0589-4e2f-4dad-08d8659e8b27
x-ms-traffictypediagnostic: MN2PR04MB5504:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB55049C744C46A2664122651EE1300@MN2PR04MB5504.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:346;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K/BIwCj21sqLT0vFO7laaomDKpB0MUuNRFkASwvXgG80jEVvwR2t6gsw7t/on6r4mT5cklS8fBdEJHNMIzNtvHbmqEQ5SrDtkKiIhGYGLOieDGWvKzTDkSY2Hm/KU+UON2qNg+AHATPgRgCJ7aj3uZ5yf+fkogSSEFWNH6NM6t3D1ZnmAxTbLQEmuVoLZa1Gtp3BSLw+MlCIOC//p9J2B6Hb4FmmW/oHMzX6NU6lUa78mlxDkUYWgyaSkM5NVLjMghu+mT/AmEwmTWpUZGKoZat4lCgdry3FRTxQElcjFLW9CVK/bIWIIaORhKN23nwRSPzXrok0w+UdflHXl/QYKp1Hl+NFvdYig7GIe90E/owq33zrzDt4hG1ilz2OIpJA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(316002)(55016002)(8936002)(5660300002)(86362001)(6506007)(2906002)(71200400001)(53546011)(186003)(26005)(478600001)(110136005)(33656002)(4326008)(9686003)(52536014)(76116006)(66446008)(64756008)(66476007)(66556008)(54906003)(7696005)(83380400001)(66946007)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: MQBT9e2wKv9Alp7KPqX0eifDIwRBt2pdPtIhndRhYmOM6gUKJJRkh+fjTHwqVelUKUYZHElXCM2H8qvoxVdktExJmujDwhM6iZavqUkW9gD9px7dt6bQ+HqfRPZlVGko+q5vck+JzbhhZfGx+NovZEVNbaGnQV5lMoT+GoC4kwCbt1xGSJbzmxAd5Vve5zJngHa9gVs57Agr8J99NzV+mqmR3BlxADL27QN3rNm9ERg+qoCohFX9dFekgfUWHNfwnv3IZM3Ha2hfxEGe2OfEQsTkClqG9E2T2oakeemPZDD1toQGzNF4vBPi5pMHIGxxdWLinL79Wtjtt27JLBnXMAWyImESSMg0XngWTceq7HL5hmE83JD2HZXzm3UNI65o7y8AyewaP+cP8TpIq9W1wgHo0IcRSamEe8jpr+SBTn80cXKFKVFiNbY0GwYwiJW1TrWFfGUBCW07iaSgvCm4PFSy3Kxapmi4CBsNkKqDKCAXYm5Md+aC5UgUqhonvpIdPOOpustKD1bIBQgpJo6oOLIfyjZi8jyfwzuLz2WI1EMRmgGPYzLY12EuuXUx9AcwaehVHz/Ryzn2f3XwnOiEiN3ig75s8x4HMprkmhdBgK+fjAvNjsX7QrfgjA4BvxYHtLykwMMKsm59OgOpSjKQJg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a3d6c9-0589-4e2f-4dad-08d8659e8b27
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 00:11:28.5992 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ia2vrrZZurFPxs29YwPg6m5eC/JOAE0olvcBfd3Sg4VCT0P7BCFNEz8cJqOm2ySAdILkk9qSOAY+wHdU/3VR5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5504
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=536915954=Dmitry.Fomichev@wdc.com; helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 20:11:31
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
> Subject: [PATCH 5/9] hw/block/nvme: support for admin-only command set
>=20
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  hw/block/nvme.c      | 1 +
>  include/block/nvme.h | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 6c582e6874..ec7363ea40 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -2755,6 +2755,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice
> *pci_dev)
>      NVME_CAP_SET_CQR(n->bar.cap, 1);
>      NVME_CAP_SET_TO(n->bar.cap, 0xf);
>      NVME_CAP_SET_CSS(n->bar.cap, NVME_CAP_CSS_NVM);
> +    NVME_CAP_SET_CSS(n->bar.cap, NVME_CAP_CSS_ADMIN_ONLY);

This could be

-     NVME_CAP_SET_CSS(n->bar.cap, NVME_CAP_CSS_NVM);
+    NVME_CAP_SET_CSS(n->bar.cap, (NVME_CAP_CSS_NVM  | NVME_CAP_CSS_ADMIN_O=
NLY));

Unfortunately, parentheses are needed above because NVME_CAP_SET_CSS macro =
and
other similar macros use "val" instead of (val). A possible cleanup topic..=
.

>      NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
>=20
>      n->bar.vs =3D NVME_SPEC_VER;
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index bc20a2ba5e..521533fd2a 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -83,7 +83,8 @@ enum NvmeCapMask {
>                                                              << CAP_PMR_S=
HIFT)
>=20
>  enum NvmeCapCss {
> -    NVME_CAP_CSS_NVM =3D 1 << 0,
> +    NVME_CAP_CSS_NVM        =3D 1 << 0,
> +    NVME_CAP_CSS_ADMIN_ONLY =3D 1 << 7,
>  };
>=20
>  enum NvmeCcShift {
> --
> 2.24.1


