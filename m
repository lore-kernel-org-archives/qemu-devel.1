Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FEAC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:32:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DD7B20772
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rEmyI/b5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="h7pFScvw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD7B20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIby-0006dZ-D6
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=45148fd95=Dmitry.Fomichev@wdc.com>)
 id 1jtIHx-0005sO-Ka; Wed, 08 Jul 2020 18:11:37 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:15435)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=45148fd95=Dmitry.Fomichev@wdc.com>)
 id 1jtIHt-00081O-Aq; Wed, 08 Jul 2020 18:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594246293; x=1625782293;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=+0HWQhhNg59F9KRyuxj9MWrM4TEi/vT4N6EKs81OPD4=;
 b=rEmyI/b5GVhwEi2JV2CV3286chmYt4bvQ9wPs/G4o4FJtbjnf41rLkPb
 Bl1WUUbGa823h8U0W1/NlyLkPwjN3FFcW/4H8q075G25nNrQIkVDcIzHP
 kuJ+cn+vPxpfB+JGZMxqnyTA/cAc9g7yWzpvAylAnhweaRWAAo5eyDsS2
 28E/c2BTVhQK0x4UVRTYuLMx/i9geZbTNmtf+2VwghntH4Mc9xvVLs/SU
 a1l7x7AwAITVjSJpRgW59FgSVVRAei/As+kjjTblB4P1JM9Pue8qk6bSC
 i7VZ4lIs4EKjX1ZcDKzv21939RbKsu1c1b2DH3/QeeM2mvHjn0/VlSeoM w==;
IronPort-SDR: pwW4RKNgFzFMdW14IOD0NIWnRjmkFtvI1K0Gwhua4wr5Z5jltKC94+gpYjwUDk1/9fmfsz1JlI
 77DLK925A5JFzeWQ2amz0nJeZcMyZ3DeftkA7ZFDyqFsH95PF9hW5KML4cQThXcdT6iTJGX+bz
 EpAQHzcvF7tgkCccLAfzN+cygQXQv3ceH7ruKcqLgont/Hzs9T60e/RlcDkIvSyYsOx1iBaLtQ
 KJk8gpv2YJDXz3jh5/kwVWqrOtA0juGNtHHF5EEeDJBLDbhjIgqbYZAVXZr8ssD/cJDsk899PW
 WHc=
X-IronPort-AV: E=Sophos;i="5.75,329,1589212800"; d="scan'208";a="141965960"
Received: from mail-bn8nam11lp2177.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.177])
 by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2020 06:11:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXqSXa2RNZu2I0POnfEg3EGPu8BxSFJwP6b08z9UyRBmlWw422uXqCWPtZOqjGJ6U2qKTAzuJCupf3cq5HQqPTP0kIt6VPsTe/eXCLBQhbCTsdmAqgMY46kUCHEWS4aUmEoQO33QrMDInBbSblZGd3I9UAW1j8hVabljA7b9UpJLEMaRHU41ugbXQcbtSO49YGclKLKzaLygkMCMcqZpS0nCnQztjIMnoNRdNzPpn85N4TUrgm0q5Rgj6jpqa2C/J8NAwb1rLayGC6l+5uq5tQvBbTmCYq0mwLeWZbrXuRp/b/NVsHdss0lB+vG0g8yar8Rs/U+ZpF93F1BF1IA4yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0HWQhhNg59F9KRyuxj9MWrM4TEi/vT4N6EKs81OPD4=;
 b=JU2SHFBeO9rZ2FabNYM1Epf5RFCDtE4/w+N0Ry3ON0KxCfhMSvNy0bRfBOUlR82rbUasM3DlwUc32j5JVajaLW9TwsBioKJX5OwOyNh/7lE64o2SI6S2FY/z1DX9xl4yrlsbTCywUe44YvS/YglwSU/XWX7aUToKxKe6gOirgZ7snph53B7mM9vGfXiehWsU/hlJ5Z87hN5NgV0yU03iwR5p+JGFtgsrxWPazOpPoLdpdWxkm5IpAzyXGhBml1SUfSppqHyW4/soEq7zwx0F713u98gblc0PkLfR6MWpqkVU61D57MfSvgzJ6/dAckO78F45ol3gDDAhUdAyT3BxEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0HWQhhNg59F9KRyuxj9MWrM4TEi/vT4N6EKs81OPD4=;
 b=h7pFScvwDihXjud2EvPZZZlqOqFwERE9x/PId3ic0vnzubzPaltR9EmsOV9F3dAe6O3U7cwfhA4qxu67i+5d157M8cLJd+S69DL1BiZhN9Qny6dBDTm5UKaPXe55CPncIB8Dv6kdQsmy1kM08kiO40Vs/bHIp+S73NPMQZPFOok=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5629.namprd04.prod.outlook.com (2603:10b6:208:a6::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Wed, 8 Jul
 2020 22:11:26 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9%5]) with mapi id 15.20.3153.029; Wed, 8 Jul 2020
 22:11:26 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: "philmd@redhat.com" <philmd@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 1/4] hw/block/nvme: Update specification URL
Thread-Topic: [PATCH v3 1/4] hw/block/nvme: Update specification URL
Thread-Index: AQHWTs5IX/GZFQcqYEqsstSyx6DlXKj+S9OA
Date: Wed, 8 Jul 2020 22:11:26 +0000
Message-ID: <d77bf9934304827d313a962ea5dc9b2ac37b4f97.camel@wdc.com>
References: <20200630110429.19972-1-philmd@redhat.com>
 <20200630110429.19972-2-philmd@redhat.com>
In-Reply-To: <20200630110429.19972-2-philmd@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [100.35.204.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5d0af543-e46a-48a9-9741-08d8238bdb98
x-ms-traffictypediagnostic: MN2PR04MB5629:
x-microsoft-antispam-prvs: <MN2PR04MB56290951513DECC53BFA4477E1670@MN2PR04MB5629.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 04583CED1A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3MyWN2wkcW0VqUp16/yp+cgD0qXsHjoL3cdyDh3K84gegF36XWFBc0ViODa4Ws/RA3Kud+19tFoVcGS5VBdeQfJGdzxo520e9S+TK/5biTQ4YWmm9+DrSwEBjpjNZh+CepX69j+gep991n5bGqpRk7XgH72ckxPaJQAaO0jDFwLbD+jXOcGR79tuIvzQGdWjtU/wOhfeERhUWnnFVYoNfGz5x2iH7q9u/Nw1n66lsuLbtbkVa+pXUASXj/XNxNV/cw0zjQ/cg4EgvnuXFfJ6QinISo8mtKncpyu2xGJM/MXenVZKq4imClmWOq4gkueKeCKSGyCB+4CDJEResP3pTFM8FkKWRNNPUQyJJeSUnZ6q2XABG+I/cZXoG4QrM+kJ8zTYuEnKrDg89xfK1sTJbw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(8676002)(966005)(15650500001)(71200400001)(5660300002)(2906002)(8936002)(26005)(186003)(66446008)(110136005)(86362001)(76116006)(54906003)(36756003)(4326008)(6506007)(2616005)(66476007)(64756008)(66556008)(6486002)(4744005)(83380400001)(6512007)(478600001)(316002)(66946007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 2v9W02MONE1vg/4Hg/1Ih8eqcwy7lmkur5CeYz7yoCO+1shCcn6cT0gmucbSMK+GktfFMSdQ9l6Sb46iifE0y8fIc19LfBFED+swst1MbUdCqtSgHa12zGxLATxYMJwWM0LoPNKUaM+XLDGo3J6tYO4UVNdCYUgygSPY+I2jccD7Znmux4TFgFrc9ymbyOv6ODSjYBI8nGDpZRaVjjLqNY6s1DmL1ZyP/jBmZklguqp1+GGXc26IRc/t9fpRbVH4xLBV6sOXzbi5N1xSTecqhVKCmnElMbEI5if/7G3vWTKQrfVOfm39New49Lsvu4Bu+lONC/FvHA5F7udSoarRvaKqd+OFAqHh4p1criAaC1WmFXA12+tw9DGMkg1gZRQbQtbhgU6kzkRSiS1hrYZotIhb9b9QVqOCrxgT5WetssYlax+YM7/CxDu5vWpswx9NcB4ATD+j9fR25AqUVAcChdsBb/MB3L6ygJQeW+ykKhZwXVE/mtc0Pb3zj0JclC4j
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E20E5ABC28A80B44960A30BFD3F6199A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0af543-e46a-48a9-9741-08d8238bdb98
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 22:11:26.2453 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +9/UCL7O3Vu+On6SruVh+xcRiO8la1DAb/leXvlvsSlONKIihX4/XGketSC2wgrHVy9Qc3DEUbI8OWbxQqatkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5629
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=45148fd95=Dmitry.Fomichev@wdc.com; helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 18:11:30
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "k.jensen@samsung.com" <k.jensen@samsung.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gVHVlLCAyMDIwLTA2LTMwIGF0IDEzOjA0ICswMjAwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSB3cm90ZToNCj4gQXQgc29tZSBwb2ludCB0aGUgVVJMIGNoYW5nZWQsIHVwZGF0ZSBpdCB0byBh
dm9pZCBvdGhlcg0KPiBkZXZlbG9wZXJzIHRvIHNlYXJjaCBmb3IgaXQuDQo+IA0KPiBSZXZpZXdl
ZC1ieTogS2xhdXMgSmVuc2VuIDxrLmplbnNlbkBzYW1zdW5nLmNvbT4NCj4gU2lnbmVkLW9mZi1i
eTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPg0KPiAtLS0NCj4g
IGh3L2Jsb2NrL252bWUuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L2Jsb2NrL252bWUuYyBiL2h3
L2Jsb2NrL252bWUuYw0KPiBpbmRleCAxYWVlMDQyZDRjLi42NjI4ZDBhNGJhIDEwMDY0NA0KPiAt
LS0gYS9ody9ibG9jay9udm1lLmMNCj4gKysrIGIvaHcvYmxvY2svbnZtZS5jDQo+IEBAIC0xMSw3
ICsxMSw3IEBADQo+ICAvKioNCj4gICAqIFJlZmVyZW5jZSBTcGVjczogaHR0cDovL3d3dy5udm1l
eHByZXNzLm9yZywgMS4yLCAxLjEsIDEuMGUNCj4gICAqDQo+IC0gKiAgaHR0cDovL3d3dy5udm1l
eHByZXNzLm9yZy9yZXNvdXJjZXMvDQo+ICsgKiAgaHR0cHM6Ly9udm1leHByZXNzLm9yZy9kZXZl
bG9wZXJzL252bWUtc3BlY2lmaWNhdGlvbi8NCj4gICAqLw0KPiAgDQo+ICAvKioNCj4gLS0gDQo+
IDIuMjEuMw0KPiANCj4gDQoNClJldmlld2VkLWJ5OiBEbWl0cnkgRm9taWNoZXYgPGRtaXRyeS5m
b21pY2hldkB3ZGMuY29tPg0KDQo=

