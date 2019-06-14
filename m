Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE5CC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:24:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89256217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YLWA0z4L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89256217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53742 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbpvv-0002dA-R3
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 13:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53959)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbphO-0005se-JK
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:09:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbpWr-000642-1U
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 12:58:18 -0400
Received: from mail-eopbgr150120.outbound.protection.outlook.com
 ([40.107.15.120]:35406 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbpWq-00061f-R3; Fri, 14 Jun 2019 12:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0OAkxfSh0LW63s9vzJb5xTXobySFyWQiuXtsTx/SAc=;
 b=YLWA0z4LRp+PCxeVPPN8+ZMtC2a/m64/KU8G2IsobSo4rXWPT7EmPK+MdHQFxzvGuwZe8KiqBMWtMDKg0spNdBOP4nfJRjJ8a4oAk1KAFpZpg80PLBN7wmdeZmfFLNvzubbdbMZVaxgsO5xXyt23oB1go2M5QSaEhNXGY/qY+4E=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB3076.eurprd08.prod.outlook.com (52.134.93.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Fri, 14 Jun 2019 16:58:14 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Fri, 14 Jun 2019
 16:58:14 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 23/42] blockdev: Use CAF in external_snapshot_prepare()
Thread-Index: AQHVIWu9uMzK/TD2M0yxTGXrEn+VtaabgCGA///XNwCAAAqDAA==
Date: Fri, 14 Jun 2019 16:58:13 +0000
Message-ID: <50d7843c-5110-fb93-41a0-e45d8a9b43f6@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-24-mreitz@redhat.com>
 <112404e2-7172-865c-d888-6a5cddcc40ec@virtuozzo.com>
 <b875c83b-c3a8-3a2c-2e92-716f5dc4411a@redhat.com>
In-Reply-To: <b875c83b-c3a8-3a2c-2e92-716f5dc4411a@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0901CA0046.eurprd09.prod.outlook.com
 (2603:10a6:3:45::14) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190614195812005
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a99f87c3-3bc7-4335-f0d3-08d6f0e97d1f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB3076; 
x-ms-traffictypediagnostic: AM0PR08MB3076:
x-microsoft-antispam-prvs: <AM0PR08MB3076CE9A4EADB67FFF52531EC1EE0@AM0PR08MB3076.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(366004)(376002)(346002)(396003)(136003)(189003)(199004)(14454004)(110136005)(7736002)(99286004)(36756003)(54906003)(26005)(76176011)(52116002)(305945005)(478600001)(186003)(68736007)(316002)(53546011)(386003)(25786009)(31696002)(53936002)(2906002)(8936002)(8676002)(6506007)(86362001)(102836004)(81156014)(81166006)(6486002)(11346002)(6116002)(6512007)(256004)(14444005)(6436002)(71200400001)(71190400001)(476003)(3846002)(229853002)(2616005)(446003)(31686004)(486006)(6246003)(73956011)(66556008)(64756008)(5660300002)(66476007)(4326008)(66066001)(66946007)(2501003)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3076;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fwEW47kkt30mweMF49sCrRwM6gBxjwnVRhLI3Xi3KOy7qT0NSuQ3EvxKiCjHV8AU9Up3Jg9XuVu/hrbsP29fO1wCkNiS8u2xiEZkI1zJUsk6y5qrBvWDPPizmyJKrXgyeDsc0SSDwBVrGdsptXWfAOo6CByhfgRuhs+Etj1NPbu5A0TbW96Y5CLUzggova1di8Gl1Wk/OG9I8TU5e9e6QENFRHCYy/VbkWu9OZ49J4jiMIbFGyLMMYYDG7Bldi7ASCpnLIZumoUsrOV35NqINqjWwSKZB56rug7JR+SVLCJd8Cpcr6kYuVxygyOnx1kyMOpyABYhmLCwwMP3ouivsGx9HRkLttJtsoK2n0t0MsjqU24BPvE9LESa0AQha9t9gegYIhXmsRh3CTghiPhhBWj0fjaPwXCN3V82KlFSHsA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <732C993499998840924566E19B06C661@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a99f87c3-3bc7-4335-f0d3-08d6f0e97d1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 16:58:13.9243 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3076
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.120
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

MTQuMDYuMjAxOSAxOToyMCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxNC4wNi4xOSAxNzo0Niwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDEzLjA2LjIwMTkgMTowOSwg
TWF4IFJlaXR6IHdyb3RlOg0KPj4+IFRoaXMgYWxsb3dzIHVzIHRvIGRpZmZlcmVudGlhdGUgYmV0
d2VlbiBmaWx0ZXJzIGFuZCBub2RlcyB3aXRoIENPVw0KPj4+IGJhY2tpbmcgZmlsZXM6IEZpbHRl
cnMgY2Fubm90IGJlIHVzZWQgYXMgb3ZlcmxheXMgYXQgYWxsIChmb3IgdGhpcw0KPj4+IGZ1bmN0
aW9uKS4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IE1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5j
b20+DQo+Pg0KPj4gT3ZlcmxheSBjcmVhdGVkIGluIHNuYXBzaG90IG9wZXJhdGlvbiBhc3N1bWVk
IHRvIGNvbnN1bWUgZm9sbG93aW5nIHdyaXRlcw0KPj4gYW5kIGl0J3MgZmlsdGVyZWQgY2hpbGQg
YmVjb21lcyByZWFkb25seS4uIEFuZCBmaWx0ZXIgd29ya3MgaW4gY29tcGxldGVseSBhbm90aGVy
DQo+PiB3YXkuDQo+Pg0KPj4gUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNr
aXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+DQo+PiBbaG1tLCBJIHN0YXJ0IHRvIGxp
a2UgdXNpbmcgImZpbHRlcmVkIGNoaWxkIiBjb2xsb2NhdGlvbiB3aGVuIEkgc2F5IGFib3V0IHRo
aXMgdGhpbmcuDQo+PiAgICBkaWRuJ3QgeW91IHRoaW5rIGFib3V0IHJlbmFtaW5nIGJhY2tpbmcg
Y2hhaW4gdG8gZmlsdGVyZWQgY2hhaW4/XQ0KPiANCj4gSG0uICBUaGVyZSBhcmUgYmFja2luZyBj
aGFpbnMgYW5kIHRoZXJlIGFyZSBiYWNraW5nIGNoYWlucy4gIFRoZXJlIGFyZQ0KPiBxZW11LWlu
dGVybmFsIGJhY2tpbmcgY2hhaW5zIHRoYXQgY29uc2lzdCBvZiBhIGhlYWx0aHkgbWl4IG9mIGZp
bHRlcnMNCj4gYW5kIENPVyBvdmVybGF5cywgYW5kIHRoZW4gdGhlcmUgYXJlIHRoZSBtb3JlIGhp
Z2gtbGV2ZWwgYmFja2luZyBjaGFpbnMNCj4gdGhlIHVzZXIgYWN0dWFsbHkgbWFuYWdlcywgd2hl
cmUgb25seSB0aGUgb3ZlcmxheXMgYXJlIGltcG9ydGFudC4NCj4gDQo+IEkgdGhpbmsgaXQgd291
bGQgbWFrZSBzZW5zZSB0byByZW5hbWUgdGhlIOKAnHFlbXUtaW50ZXJuYWwgYmFja2luZyBjaGFp
bnMiDQo+IHRvIOKAnGZpbHRlciBjaGFpbnPigJ0gb3Igc29tZXRoaW5nLiAgQnV0IHRoYXQgbWFr
ZXMgaXQgc291bmQgYSBiaXQgbGlrZSBpdA0KPiB3b3VsZCBvbmx5IG1lYW4gUi9XIGZpbHRlcnMu
Li4gIE1heWJlIGp1c3Qg4oCcY2hhaW7igJ0/DQo+IA0KPiBBY3R1YWxseSwgdGhlIG9ubHkgZnVu
Y3Rpb25zIEkgZmluZCBhcmUgaXNfYmFja2luZ19jaGFpbl9mcm96ZW4gJiBDbywNCj4gYW5kIHRo
ZXkgY291bGQgc2ltcGx5IGJlY29tZSBpc19jaGFpbl9mcm96ZW4uICBJcyB0aGVyZSBhbnl0aGlu
ZyBlbHNlPw0KDQpDaGFpbiBpcyB0b28gZ2VuZXJhbCwgbWF5IGJlLCBibG9ja2NoYWluPyA6KSkp
DQoNCkFuZCB0byBiZSBzZXJpb3VzLCBvbmUgbW9yZSByZWFzb24gdG8gcmVuYW1lIGl0IGlzIHlv
dXJzDQpiZHJ2X2JhY2tpbmdfY2hhaW5fbmV4dCB3aGljaCBpcyBhYm91dCB1c2VyLWJhY2tpbmct
Y2hhaW4gYW5kIGRpZmZlcnMgZnJvbQ0KZnJvemVuLWNoYWluIHJlbGF0ZWQgZnVuY3Rpb25zLg0K
DQpIb3dldmVyLCBJIGRvbid0IHRoaW5rIHRoYXQgdGhlc2Ugc2VyaWVzIGlzIGdvb2QgcGxhY2Ug
Zm9yIHRoaXMgcmVuYW1pbmcsDQppdCdzIHJhdGhlciBiaWcgYWxyZWFkeS4NCg0KLS0gDQpCZXN0
IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

