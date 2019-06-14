Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464D6C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 16:12:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EC1C2084E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 16:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NUBluCEJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EC1C2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53056 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbooz-0001PD-B7
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 12:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59045)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hboPn-0000U0-HY
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:46:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hboPl-0005e8-MH
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:46:55 -0400
Received: from mail-eopbgr00120.outbound.protection.outlook.com
 ([40.107.0.120]:40459 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hboPk-0005TC-Ak; Fri, 14 Jun 2019 11:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=misyyMe+w2cGO0plCZrLgu9+pJZlacMdkmD1Ykmt9PI=;
 b=NUBluCEJFhneybf0vHWWzUV/I7OnqSJ2LUWVQMS4IzRxet0rm201YkhRe54FAIBDty0Gk5bUQkdRXfC+SFfRVDA3JlkUlwBhgThBXJCSaXcUtAJHQnSPFvpzcagprYjHMEsznG7rn8m9V97xP0y7/qFl1+E0lkbYWUkAu2hSMko=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB4498.eurprd08.prod.outlook.com (20.179.33.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Fri, 14 Jun 2019 15:46:36 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Fri, 14 Jun 2019
 15:46:36 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 23/42] blockdev: Use CAF in external_snapshot_prepare()
Thread-Index: AQHVIWu9uMzK/TD2M0yxTGXrEn+VtaabTdeA
Date: Fri, 14 Jun 2019 15:46:35 +0000
Message-ID: <112404e2-7172-865c-d888-6a5cddcc40ec@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-24-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-24-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0085.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::29) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190614184633443
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56910d3d-9441-4a5e-a007-08d6f0df7b04
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB4498; 
x-ms-traffictypediagnostic: AM0PR08MB4498:
x-microsoft-antispam-prvs: <AM0PR08MB4498E7954FADE194105185B5C1EE0@AM0PR08MB4498.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(136003)(346002)(366004)(396003)(39850400004)(189003)(199004)(476003)(76176011)(2616005)(11346002)(36756003)(81156014)(478600001)(6116002)(6506007)(66476007)(8936002)(386003)(73956011)(66946007)(31686004)(486006)(52116002)(305945005)(3846002)(7736002)(66556008)(2501003)(66446008)(64756008)(229853002)(446003)(99286004)(71200400001)(71190400001)(8676002)(53936002)(6246003)(6436002)(316002)(68736007)(110136005)(6486002)(5660300002)(14444005)(66066001)(14454004)(86362001)(4326008)(256004)(186003)(54906003)(81166006)(25786009)(31696002)(26005)(6512007)(102836004)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4498;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4g6TiwT8MV2W2KYfpMKADCvyGo/7cVdoP2J24zDnktqEYQFR92Llu+7yQ0tB0lKRt86LxCI1qi888Y4ESXXxAVJb93EFMH5hG0T48kINALH2VUfuWxPmeWhEpio6cIMaPybWc+T9/L4nbOfE9woteCu/321XYjmOTLchBS23Jq9Pe5DjKYHoTMr5D2jVekZUexcODZ71m+AY77SdjlXM0oT8iVa5vHv9sM7UgDkWltosLjjkuMNZx75mtjY+XF6NuEKnWUFyg3e1Xx3An/y6Kq+XcbGY6EFX09j1HyzN4l6VdMTbLPkvK6tFFcZ+m3wJto+tbA45bVtPhEQzVQyRNuTWPiTXxMgyyvQ2l3Z5u3/YVTx457DpxuNqpm5vmRN0riPLn2R0sOtySoWFkwjcrzEFzbqH++ROuoEYWofuzMw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78AD2A579EBDA74F9793526897A4388F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56910d3d-9441-4a5e-a007-08d6f0df7b04
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 15:46:35.9903 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4498
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.120
Subject: Re: [Qemu-devel] [PATCH v5 23/42] blockdev: Use CAF in
 external_snapshot_prepare()
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTMuMDYuMjAxOSAxOjA5LCBNYXggUmVpdHogd3JvdGU6DQo+IFRoaXMgYWxsb3dzIHVzIHRvIGRp
ZmZlcmVudGlhdGUgYmV0d2VlbiBmaWx0ZXJzIGFuZCBub2RlcyB3aXRoIENPVw0KPiBiYWNraW5n
IGZpbGVzOiBGaWx0ZXJzIGNhbm5vdCBiZSB1c2VkIGFzIG92ZXJsYXlzIGF0IGFsbCAoZm9yIHRo
aXMNCj4gZnVuY3Rpb24pLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWF4IFJlaXR6IDxtcmVpdHpA
cmVkaGF0LmNvbT4NCg0KT3ZlcmxheSBjcmVhdGVkIGluIHNuYXBzaG90IG9wZXJhdGlvbiBhc3N1
bWVkIHRvIGNvbnN1bWUgZm9sbG93aW5nIHdyaXRlcw0KYW5kIGl0J3MgZmlsdGVyZWQgY2hpbGQg
YmVjb21lcyByZWFkb25seS4uIEFuZCBmaWx0ZXIgd29ya3MgaW4gY29tcGxldGVseSBhbm90aGVy
DQp3YXkuDQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2Vt
ZW50c292QHZpcnR1b3p6by5jb20+DQoNCltobW0sIEkgc3RhcnQgdG8gbGlrZSB1c2luZyAiZmls
dGVyZWQgY2hpbGQiIGNvbGxvY2F0aW9uIHdoZW4gSSBzYXkgYWJvdXQgdGhpcyB0aGluZy4NCiAg
ZGlkbid0IHlvdSB0aGluayBhYm91dCByZW5hbWluZyBiYWNraW5nIGNoYWluIHRvIGZpbHRlcmVk
IGNoYWluP10NCg0KPiAtLS0NCj4gICBibG9ja2Rldi5jIHwgNyArKysrKystDQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2Jsb2NrZGV2LmMgYi9ibG9ja2Rldi5jDQo+IGluZGV4IGI1YzBmZDNjNDkuLjBmMGNmMGQ5
YWUgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrZGV2LmMNCj4gKysrIGIvYmxvY2tkZXYuYw0KPiBAQCAt
MTY2NSw3ICsxNjY1LDEyIEBAIHN0YXRpYyB2b2lkIGV4dGVybmFsX3NuYXBzaG90X3ByZXBhcmUo
QmxrQWN0aW9uU3RhdGUgKmNvbW1vbiwNCj4gICAgICAgICAgIGdvdG8gb3V0Ow0KPiAgICAgICB9
DQo+ICAgDQo+IC0gICAgaWYgKHN0YXRlLT5uZXdfYnMtPmJhY2tpbmcgIT0gTlVMTCkgew0KPiAr
ICAgIGlmIChzdGF0ZS0+bmV3X2JzLT5kcnYtPmlzX2ZpbHRlcikgew0KPiArICAgICAgICBlcnJv
cl9zZXRnKGVycnAsICJGaWx0ZXJzIGNhbm5vdCBiZSB1c2VkIGFzIG92ZXJsYXlzIik7DQo+ICsg
ICAgICAgIGdvdG8gb3V0Ow0KPiArICAgIH0NCj4gKw0KPiArICAgIGlmIChiZHJ2X2ZpbHRlcmVk
X2Nvd19jaGlsZChzdGF0ZS0+bmV3X2JzKSkgew0KPiAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJw
LCAiVGhlIG92ZXJsYXkgYWxyZWFkeSBoYXMgYSBiYWNraW5nIGltYWdlIik7DQo+ICAgICAgICAg
ICBnb3RvIG91dDsNCj4gICAgICAgfQ0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRp
bWlyDQo=

