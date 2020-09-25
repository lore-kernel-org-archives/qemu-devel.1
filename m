Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B71C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 17:08:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8DC320936
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 17:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="i0Fp7dNd";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NG8IiWWl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8DC320936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLrCa-0001UT-D5
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 13:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=530cb6e47=Dmitry.Fomichev@wdc.com>)
 id 1kLrB8-0008TY-Qs; Fri, 25 Sep 2020 13:06:40 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:62391)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=530cb6e47=Dmitry.Fomichev@wdc.com>)
 id 1kLrB4-0004Zh-Nr; Fri, 25 Sep 2020 13:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601053594; x=1632589594;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mURWLOT9Nw05lrPEugMroSX6exCkB1Deb5cqXSo1WXo=;
 b=i0Fp7dNdgsvxpDiOo8XuqDRUU7iDbfXtARSN70MNFNBH6QhFkaEf06me
 FyiE1Z4uDxP4OHAIUvNwNWJlpPHcABd/YAdVjZWk28p1CNftq7iqbO6sZ
 ifxtS64X5oDGy+3p03hMSj5EIDzDfr1hG+Qr/Rc5xQi3GkMoPtFupEzxv
 axN+YQhkg81ZQ4wivlvvtaPprOJ5ZLQj80yfIu9BFFYW6mtYB1LpNUm00
 sIOZv8rnyK48FOSFWHbaAtRsqe3JFSIiy8Zkqj3xYItQ/I7b6vusu81yV
 iCfP1Xi1KdkiwOezUWlTWgm1xgR+eDoXWZVEpIKlIKiY0XOhME6q3sa8I A==;
IronPort-SDR: 72espCmIkqp+RZm1d/RAmzqMpCNJwgT9nZS3Abp8Yp0MM2Y/xeCxZf6qKlDi6POCS7YwhtZ+dY
 cubqo6bv3dCBDrotpCCiy3b+Oan8623EAOgu+5Qe+qFnHzivorUugSszZp/UOgemQ0r3baeheq
 D0fQRpllIvfKIGF5KWCqVwjbB5GumCToVKXSkSlj20JBt2/ZQtEYpPJxTMbgPRay9XI9OW/tEy
 a5/N01OiK+8IhtgibeBu1kPOlWUhvhHLWV1vLp7M7rtEbNPJUPXdYs5xIlE0tGxNtWdjfu/E20
 Qv8=
X-IronPort-AV: E=Sophos;i="5.77,302,1596470400"; d="scan'208";a="258005416"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
 by ob1.hgst.iphmx.com with ESMTP; 26 Sep 2020 01:06:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6c2GXkyOL4qWbjcIT5paaPGnRF4UhAM1cxbDXQFtL7IyiVAoeAyXYuhosAAOBW8VZxcw/svY+KcNNXHxmvCbX6EO6kkNMH5znZ3kbkq/WBwbSKrkkGuI5V5wczEWf2vl9WG/8hOhYD0K7wlVLmzZDUn3uNgNQiSg+sBqCx1RkjTiXtw53GGW5/igjjKHMlgCaTaAro93CHrb9X2ombSYNhye2txi+6cYFMJfcFdh0sB5MTFBDOkq41ZtAlBXQIxWS71x1+ywC8Tm7E5ySwxfJU9Q8fn54FZ9fEiM5TmVGHG0N47gsmeqXlxBb96vFLz0R4fw7C+firBcfasXvqESA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mURWLOT9Nw05lrPEugMroSX6exCkB1Deb5cqXSo1WXo=;
 b=OvGvMb/bR2qrVPSzhWbNgERe+evQgnDs42EEPX0W2t1iGiAersAczzot0015+9wY32vs00EL4OFgoIGvq2W2QuTyPwX4/9KAAeNLx8CUYg7wMNHPyQCf9z35BDOINANpvZRvqBr7qFThl0Yj1kB5anqKJZpOgeBYSHDUVv6AZSDZQVtdDg0Lgs8CiwBwC2XgDm3k7TGWjOcE4+rXiGL0Jg6srlh8rox/idVgja1wSAIDOGODcimx5yTaWFBr31FswHJECFwE55vfPjBLk3vLZIlMNeVNAOokmTmGcmGTRWRjAVaoepAYSgS5Hxw8KYmCyvPXoup37/XbvgAzvErrBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mURWLOT9Nw05lrPEugMroSX6exCkB1Deb5cqXSo1WXo=;
 b=NG8IiWWl/Av4vzxbUNNyIE213O8zWaC0MH887i4fDV/8VTqQn2YCj0U+GWTgXEv5EqOqj2uhFya0dbjDaDVT5vEHhU/GL8oJA2As86xd2CewjsueqtoW69eMZjkiUS07FB9yGqDTNF5xUdemyC0tRPCzjQ6m1pn4CNJBgg9A2h8=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5566.namprd04.prod.outlook.com (2603:10b6:208:e3::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Fri, 25 Sep
 2020 17:06:26 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94%6]) with mapi id 15.20.3412.024; Fri, 25 Sep 2020
 17:06:26 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH 00/16] hw/block/nvme: zoned namespace command set
Thread-Topic: [PATCH 00/16] hw/block/nvme: zoned namespace command set
Thread-Index: AQHWkrTWkatz0bfJ+EyKMe9WyoLXtql5k0fA
Date: Fri, 25 Sep 2020 17:06:26 +0000
Message-ID: <MN2PR04MB5951D128DA6A5C9F6101C707E1360@MN2PR04MB5951.namprd04.prod.outlook.com>
References: <20200924204516.1881843-1-its@irrelevant.dk>
In-Reply-To: <20200924204516.1881843-1-its@irrelevant.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9431d1e0-2432-4b0b-6620-08d861755699
x-ms-traffictypediagnostic: MN2PR04MB5566:
x-microsoft-antispam-prvs: <MN2PR04MB5566BE08C7EDBD903311D277E1360@MN2PR04MB5566.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6wSapDeiCATnD6klAH4NaOjzfqOp/jy3PAZ2PGCos5jGFAPRcTo2x5xQQDZ/yTqm1X9b7UdrusJOLvHS1LDUYMiBx8m4A/VSWioXmzvlAjBtPYB1zxIdpRRVw2wnChFzCW7iQQ8M51qc1/draxxWtlSpdkm9WHW20xG3TSiZhO/jjSkPRdhCaeNJVuAqZM7fEmyFG8kg/yKZHtd3XCraDsQ3R1hAiV+Bbtu97Z3xZrxfvig7j85sLRzzH8CV8pRKfDad8O2WzMzGgs+dgWOoqkwih7fAm7a3jMMUmQ0QpNMR/8ov5D0jH7oINL3ykWaKE5UrZTcKDiacQrC0D8S70qVIMorxYJIP/DVRg65SU907+HrBSlFc60EE5ymACbtq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(6506007)(53546011)(186003)(316002)(54906003)(86362001)(52536014)(71200400001)(2906002)(83380400001)(7696005)(4326008)(5660300002)(26005)(110136005)(55016002)(66476007)(66946007)(66556008)(76116006)(33656002)(64756008)(8676002)(478600001)(8936002)(66446008)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: MWMWOYglSOO6aJsFn8IJOYjC77fGLHAH5qrJIH7vSfSztMpluD2kO97Pfhmm8RCYzJK2w5S7HWWSHzhUkE0Dp4lwYgcJcmi0Ascgp6csbpjSYXx1FMz4+TrBKArWrv1tOyQJL4Y/u3mMaFnjFfJFSgNFz2X3fjHkszNduibGr1PSCD5TqkwPSt1VkfGCgq1w1to3AQs1nZAyXK35e4O5q2gA9TA/CqsCZlkLgJq51CadWo9AhbCVGn4rtYA1RKq+0u2AAxKzrz8YeW12th5dWaYYKulZ+dB8YNtDbE82jAYNhJKlbGbpbKHcoghXeS6fWht25fpN5VKPKOdIzwcBfJ8dSR5palvk0ewFU86V77oLNtgxyVjzV83sPcSPW61bqVoBcxXW2Q0WfdylO/5ASUp4UAQvEjZfdzL9w5D0Z712Q3Ka6m+qY+k+Jx3Ck64pg0Lbd3KlozspRytHy+4dFx72X6mfLJO9s+I5mORhFq1LG3KhFADkeC+mgHuQDSIqu46rQSCyiyZxm8b1mRFLRfYY5YzAM0IK6pZaIb3JeYQnnVATVLS4K1VTZu63KBdrgmWhhXdjTpqSEPDklnrqOiLtfBBMSFbargyycXj7xiAyLklcmYWNu8MNwztKk8S0LOMjOOSNW1YErf/9LrdozQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9431d1e0-2432-4b0b-6620-08d861755699
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2020 17:06:26.3697 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3MQutpXZJsU0bl5B7CsBL0WRsWQBYm/d70ScpDus0/dguU6BgIPs52x0f6neXcUPM9Mg3Z1m0cdDiwp7wKwlpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5566
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=530cb6e47=Dmitry.Fomichev@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 13:06:30
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Klaus Jensen <k.jensen@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUWVtdS1ibG9jayA8cWVt
dS1ibG9jay0NCj4gYm91bmNlcytkbWl0cnkuZm9taWNoZXY9d2RjLmNvbUBub25nbnUub3JnPiBP
biBCZWhhbGYgT2YgS2xhdXMNCj4gSmVuc2VuDQo+IFNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIg
MjQsIDIwMjAgNDo0NSBQTQ0KPiBUbzogcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBGYW0g
WmhlbmcgPGZhbUBldXBob24ubmV0PjsgS2V2aW4gV29sZiA8a3dvbGZAcmVkaGF0LmNvbT47IHFl
bXUtDQo+IGJsb2NrQG5vbmdudS5vcmc7IEtsYXVzIEplbnNlbiA8ay5qZW5zZW5Ac2Ftc3VuZy5j
b20+OyBNYXggUmVpdHoNCj4gPG1yZWl0ekByZWRoYXQuY29tPjsgS2VpdGggQnVzY2ggPGtidXNj
aEBrZXJuZWwub3JnPjsgS2xhdXMgSmVuc2VuDQo+IDxpdHNAaXJyZWxldmFudC5kaz4NCj4gU3Vi
amVjdDogW1BBVENIIDAwLzE2XSBody9ibG9jay9udm1lOiB6b25lZCBuYW1lc3BhY2UgY29tbWFu
ZCBzZXQNCj4gDQo+IEZyb206IEtsYXVzIEplbnNlbiA8ay5qZW5zZW5Ac2Ftc3VuZy5jb20+DQo+
IA0KPiANCj4gV2hpbGUgZ29pbmcgdGhyb3VnaCBhIGZldyByb3VuZHMgb2YgcmV2aWV3cyBvbiBE
bWl0cnkncyBzZXJpZXMgSSBoYXZlDQo+IA0KPiBhbHNvIGNvbnRpbnVlZCBudXJzaW5nIG15IG93
biBpbXBsZW1lbnRhdGlvbiBzaW5jZSBvcmlnaW5hbGx5IHBvc3RlZC4gSQ0KPiANCj4gZGlkIG5v
dCByZWNlaXZlIGFueSByZXZpZXdzIG9yaWdpbmFsbHksIHNpbmNlIGl0IGRlcGVuZGVkIG9uIGEg
bG90IG9mDQo+IA0KPiBwcmVjZWRpbmcgc2VyaWVzLCBidXQgbm93LCB3aXRoIHRoZSBzdGFnaW5n
IG9mIG11bHRpcGxlIG5hbWVzcGFjZXMgb24NCj4gDQo+IG52bWUtbmV4dCB5ZXN0ZXJkYXksIEkg
dGhpbmsgaXQgZGVzZXJ2ZXMgYW5vdGhlciBzaG90IHNpbmNlIGl0IG5vdw0KPiANCj4gYXBwbGll
cyBkaXJlY3RseS4gVGhlIHNlcmllcyBjb25zaXN0cyBvZiBhIGNvdXBsZSBvZiB0cml2aWFsIHBh
dGNoZXMNCj4gDQo+IGZvbGxvd2VkIGJ5IHRoZSAiaHcvYmxvY2svbnZtZTogYWRkIHN1cHBvcnQg
Zm9yIGR1bGJlIGFuZCBibG9jaw0KPiANCj4gdXRpbGl6YXRpb24gdHJhY2tpbmciLCAiaHcvYmxv
Y2svbnZtZTogc3VwcG9ydCBuYW1lc3BhY2UgdHlwZXMiIGFuZCB0aGUNCj4gDQo+IHNldCBvZiB6
b25lZCBuYW1lc3BhY2Ugc3VwcG9ydCBwYXRjaGVzLg0KPiANCj4gDQo+IA0KPiBBIGNvdXBsZSBv
ZiBwb2ludHMgb24gaG93IHRoaXMgZGVmZXJzIGZyb20gRG1pdHJ5IGV0LiBhbC4ncyBzZXJpZXMg
YW5kDQo+IA0KPiB3aHkgSSB0aGluayB0aGlzIGltcGxlbWVudGF0aW9uIGRlc2VydmVzIGEgcmV2
aWV3Lg0KPiANCj4gDQo+IA0KPiAgICogU3RhbmRhcmQgYmxvY2tkZXYtYmFzZWQgYXBwcm9hY2gg
dG8gcGVyc2lzdGVudCBzdGF0ZS4gVGhlDQo+IA0KPiAgICAgaW1wbGVtZW50YXRpb24gdXNlcyBh
IHBsYWluIGJsb2NrZGV2IGFzc29jaWF0ZWQgd2l0aCB0aGUgbnZtZS1ucw0KPiANCj4gICAgIGRl
dmljZSBmb3Igc3RvcmluZyBzdGF0ZSBwZXJzaXN0ZW50bHkuIFRoaXMgc2FtZSAncHN0YXRlJyBi
bG9ja2Rldg0KPiANCj4gICAgIGlzIGFsc28gdXNlZCBmb3IgbG9naWNhbCBibG9jayBhbGxvY2F0
aW9uIHRyYWNraW5nLg0KPiANCg0KSXMgcGVyc2lzdGVudCBzdGF0ZSBtYW5kYXRvcnkgb3Igb3B0
aW9uYWw/IFNvcnJ5IGZvciBhc2tpbmcsIGJ1dCBJIGFtDQpzdGlsbCBjYXRjaGluZyB1cCB3aXRo
IHlvdXIgb3RoZXIgcGF0Y2hlcy4gSSB0aGluayBoYXZpbmcgaXQgb3B0aW9uYWwgaXMNCmEgYmln
IGJlbmVmaXQgZm9yIHBlcmZvcm1hbmNlIHRlc3RpbmcuDQoNCj4gDQo+IA0KPiAgICogUmVsaWVz
IG9uIGF1dG9tYXRpYyBjb25maWd1cmF0aW9uIG9mIERMRkVBVCBhY2NvcmRpbmcgdG8gd2hhdCB0
aGUNCj4gDQo+ICAgICB1bmRlcmx5aW5nIGJsb2NrZGV2IHByb3ZpZGVzIChpLmUuIEJEUlZfT19V
Tk1BUCBmb3IgZ3VhcmFudGVlaW5nDQo+IA0KPiAgICAgemVyb2VzIG9uIGRpc2NhcmRlZCBibG9j
a3MpIGZvciBoYW5kbGluZyByZWFkcyBpbiB0aGUgZ2FwcyBiZXR3ZWVuDQo+IA0KPiAgICAgd3Jp
dGUgcG9pbnRlciwgWkNBUCBhbmQgWlNaRS4gSXNzdWVzIGRpc2NhcmRzIGZvciB6b25lIHJlc2V0
cy4gVGhpcw0KPiANCj4gICAgIHJlbW92ZXMgdGhlIHplcm8gZmlsbGluZy4NCj4gDQoNCkRvZXNu
J3QgdGhpcyBtYWtlIG5vbi16ZXJvIGZpbGwgcGF0dGVybnMgaW1wb3NzaWJsZT8gSW4gbWFueSBz
dG9yYWdlDQplbnZpcm9ubWVudHMsIHZlbmRvcnMgYW5kIGFkbWlucyBhcmUgYWRhbWFudCBhYm91
dCBoYXZpbmcgdmFyeWluZw0KZmlsbCBwYXR0ZXJucyB0byBzZWUgd2hvIGNhdXNlZCB0aGUgZGF0
YSBjb3JydXB0aW9uIGlmIHRoZXJlIGlzIG9uZS4NCk5vdCBzdXJlIGhvdyBpbXBvcnRhbnQgdGhp
cyBmb3IgdGhlIHBhcnRpY3VsYXIgYXBwbGljYXRpb24sIGJ1dCBXREMNCnNlcmllcyBwcm92aWRl
cyB0aGUgZnVuY3Rpb25hbGl0eSB0byBzcGVjaWZ5IHRoZSBmaWxsIHBhdHRlcm4uDQoNCj4gDQo+
IA0KPiBGaW5hbGx5LCBJIHdyb3RlIHRoaXMuIEkgYW0gKk5PVCogc2F5aW5nIHRoYXQgdGhpcyBz
b21laG93IG1ha2VzIGl0DQo+IA0KPiBiZXR0ZXIsIGJ1dCBhcyBhIG1haW50YWluZXIsIGlzIGEg
YmlnIGRlYWwgdG8gbWUgc2luY2UgYm90aCBzZXJpZXMgYXJlDQo+IA0KPiBhcmd1YWJseSBhIGxv
dCBvZiBjb2RlIHRvIG1haW50YWluIGFuZCBzdXBwb3J0IChib3RoIHNlcmllcyBhcmUgYWJvdXQN
Cj4gDQo+IHRoZSBzYW1lIHNpemUpLiBCdXQgLSBJIGFtIG5vdCB0aGUgb25seSBtYWludGFpbmVy
LCBzbyBpZiBLZWl0aCAobm93DQo+IA0KPiBzdWRkZW5seSBwbGFjZWQgaW4gdGhlIGdyaW0gcm9s
ZSBhcyBzb21lIHNvcnQgb2YgYXJiaXRlcikgc2lnbnMgb2ZmIG9uDQo+IA0KPiBEbWl0cnkncyBz
ZXJpZXMsIHRoZW4gc28gYmUgaXQsIEkgd2lsbCByZXN0IG15IGNhc2UuDQo+IA0KPiANCj4gDQo+
IEkgdGhpbmsgd2UgYWxsIHdhbnQgdG8gc2VlIGFuIGltcGxlbWVudGF0aW9uIG9mIHpvbmVkIG5h
bWVzcGFjZXMgaW4gUUVNVQ0KPiANCj4gc29vbmVyIHJhdGhlciB0aGFuIGxhdGVyLCBidXQgSSB3
b3VsZCBsaWUgaWYgSSBzYWlkIEkgd291bGRuJ3QgcHJlZmVyDQo+IA0KPiB0aGF0IGl0IHdhcyB0
aGlzIG9uZS4NCj4gDQo+IA0KPiANCj4gQmFzZWQtb246IDwyMDIwMDkyMjA4NDUzMy4xMjczOTYy
LTEtaXRzQGlycmVsZXZhbnQuZGs+DQo+IA0KPiANCj4gDQo+IEdvbGx1IEFwcGFsYW5haWR1ICgx
KToNCj4gDQo+ICAgaHcvYmxvY2svbnZtZTogYWRkIGNvbW1hbmRzIHN1cHBvcnRlZCBhbmQgZWZm
ZWN0cyBsb2cgcGFnZQ0KPiANCj4gDQo+IA0KPiBLbGF1cyBKZW5zZW4gKDE1KToNCj4gDQo+ICAg
aHcvYmxvY2svbnZtZTogYWRkIG5zaWQgdG8gZ2V0L3NldGZlYXQgdHJhY2UgZXZlbnRzDQo+IA0K
PiAgIGh3L2Jsb2NrL252bWU6IGFkZCB0cmFjZSBldmVudCBmb3IgcmVxdWVzdHMgd2l0aCBub24t
emVybyBzdGF0dXMgY29kZQ0KPiANCj4gICBody9ibG9jay9udm1lOiBtYWtlIGxiYSBkYXRhIHNp
emUgY29uZmlndXJhYmxlDQo+IA0KPiAgIGh3L2Jsb2NrL252bWU6IHJlamVjdCBpbyBjb21tYW5k
cyBpZiBvbmx5IGFkbWluIGNvbW1hbmQgc2V0IHNlbGVjdGVkDQo+IA0KPiAgIGh3L2Jsb2NrL252
bWU6IGNvbnNvbGlkYXRlIHJlYWQsIHdyaXRlIGFuZCB3cml0ZSB6ZXJvZXMNCj4gDQo+ICAgaHcv
YmxvY2svbnZtZTogYWRkIHN1cHBvcnQgZm9yIGR1bGJlIGFuZCBibG9jayB1dGlsaXphdGlvbiB0
cmFja2luZw0KPiANCj4gICBody9ibG9jay9udm1lOiBzdXBwb3J0IG5hbWVzcGFjZSB0eXBlcw0K
PiANCj4gICBody9ibG9jay9udm1lOiBhZGQgYmFzaWMgcmVhZC93cml0ZSBmb3Igem9uZWQgbmFt
ZXNwYWNlcw0KPiANCj4gICBody9ibG9jay9udm1lOiBhZGQgdGhlIHpvbmUgbWFuYWdlbWVudCBy
ZWNlaXZlIGNvbW1hbmQNCj4gDQo+ICAgaHcvYmxvY2svbnZtZTogYWRkIHRoZSB6b25lIG1hbmFn
ZW1lbnQgc2VuZCBjb21tYW5kDQo+IA0KPiAgIGh3L2Jsb2NrL252bWU6IGFkZCB0aGUgem9uZSBh
cHBlbmQgY29tbWFuZA0KPiANCj4gICBody9ibG9jay9udm1lOiB0cmFjayBhbmQgZW5mb3JjZSB6
b25lIHJlc291cmNlcw0KPiANCj4gICBody9ibG9jay9udm1lOiBhbGxvdyBvcGVuIHRvIGNsb3Nl
IHRyYW5zaXRpb25zIGJ5IGNvbnRyb2xsZXINCj4gDQo+ICAgaHcvYmxvY2svbnZtZTogc3VwcG9y
dCB6b25lIGFjdGl2ZSBleGN1cnNpb25zDQo+IA0KPiAgIGh3L2Jsb2NrL252bWU6IHN1cHBvcnQg
cmVzZXQvZmluaXNoIHJlY29tbWVuZGVkIGxpbWl0cw0KPiANCj4gDQo+IA0KPiAgZG9jcy9zcGVj
cy9udm1lLnR4dCAgIHwgICA0OSArLQ0KPiANCj4gIGh3L2Jsb2NrL252bWUtbnMuaCAgICB8ICAx
NjYgKysrLQ0KPiANCj4gIGh3L2Jsb2NrL252bWUuaCAgICAgICB8ICAgMjQgKw0KPiANCj4gIGlu
Y2x1ZGUvYmxvY2svbnZtZS5oICB8ICAyNjIgKysrKysrLQ0KPiANCj4gIGJsb2NrL252bWUuYyAg
ICAgICAgICB8ICAgIDQgKy0NCj4gDQo+ICBody9ibG9jay9udm1lLW5zLmMgICAgfCAgNDExICsr
KysrKysrKy0NCj4gDQo+ICBody9ibG9jay9udm1lLmMgICAgICAgfCAxNzI3ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gLQ0KPiANCj4gIGh3L2Jsb2NrL3RyYWNl
LWV2ZW50cyB8ICAgNTAgKy0NCj4gDQo+ICA4IGZpbGVzIGNoYW5nZWQsIDI1ODAgaW5zZXJ0aW9u
cygrKSwgMTEzIGRlbGV0aW9ucygtKQ0KPiANCj4gDQo+IA0KPiAtLQ0KPiANCj4gMi4yOC4wDQo+
IA0KPiANCj4gDQoNCg==

