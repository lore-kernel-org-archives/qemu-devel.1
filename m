Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C48AC48BE0
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 13:29:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2C38208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 13:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="L91Oy56W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C38208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34862 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heJbb-00046U-WE
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 09:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51141)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1heJYd-0001of-OQ
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 09:26:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1heJYa-000721-Lh
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 09:26:23 -0400
Received: from mail-ve1eur01on0720.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::720]:9283
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1heJYW-0006s1-S8; Fri, 21 Jun 2019 09:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1uigyxDMrbKr8bl+7W/RNHu9p3Iykc++vJU2jF1rKA=;
 b=L91Oy56W0ZS37oJoWgdoGV2O4vBYi9xDtvk+lh3xoNtyZUJQkq7SaMSg+r61nWgJ80bA7wwsnbXumDG94wcorYjFpgC7JTE5qFaIqniIPMCePI3vhtkOlt/h8HLXl7kGmxMbv9ISHRawIqxKnu6jdJkWW4kckYfHJv6JFRUvmac=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB4744.eurprd08.prod.outlook.com (10.255.79.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Fri, 21 Jun 2019 13:26:13 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 13:26:13 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 33/42] blockdev: Fix active commit choice
Thread-Index: AQHVIWvMnB+nkUgz2kCIZe++5LqMP6aiwJeAgABsYgCAAvn0AA==
Date: Fri, 21 Jun 2019 13:26:13 +0000
Message-ID: <72c0be9e-cff6-1c6d-3f9b-d257d92a8cc6@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-34-mreitz@redhat.com>
 <2670e61d-6c9b-9499-8e41-01c294379e47@virtuozzo.com>
 <761c245d-3bb3-5fb3-21e4-0085caaffd2a@redhat.com>
In-Reply-To: <761c245d-3bb3-5fb3-21e4-0085caaffd2a@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0502CA0020.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::30) To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190621162608081
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d41a88ab-de06-4e5c-0549-08d6f64c077e
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4744; 
x-ms-traffictypediagnostic: DBBPR08MB4744:
x-microsoft-antispam-prvs: <DBBPR08MB4744ACC3402AA6FC86948443C1E70@DBBPR08MB4744.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(376002)(136003)(39840400004)(346002)(189003)(199004)(6486002)(6436002)(73956011)(229853002)(36756003)(2906002)(8936002)(110136005)(53936002)(386003)(66946007)(86362001)(486006)(2501003)(53546011)(186003)(66066001)(316002)(68736007)(478600001)(31696002)(446003)(2616005)(6506007)(99286004)(102836004)(476003)(81166006)(52116002)(76176011)(305945005)(5660300002)(54906003)(6246003)(26005)(71200400001)(71190400001)(8676002)(81156014)(11346002)(4326008)(14454004)(6512007)(7736002)(14444005)(25786009)(66446008)(64756008)(6116002)(66556008)(3846002)(31686004)(66476007)(256004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4744;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EhIst4USuGa0ZyMezrx21lGH1IK7jZ3K9TlGZArIj7ds6GBcLo+bLmVHdkeGX33o8WVrdJGC5tBTxBLhrzInZY6AhstNDAv18n4T2PqbijKr22y53C9M21vV9NakyHnTqdPzoArdxIHKfQKVTV18da/xkpgNQgiPFoCdX9cmd0qlcVX8ap+coet0FDfVEEEdJIFk4fMdvvA3Ossu7Lp0kWorijkDpwtW5sD+ul6UwDbCczMx9LI2tn/i9EsdHs4Pt9qcSk3Mu/SIed8e0C6m12YU1gagMzortDnNpdZNRHvbao5mzd10IHrkVm3sGOXys1LAVa4kikVEW5XDMKjuEVVjzUQEkqfKUunfTGUYtIECQtcuU+atvfWY53lOJS9zuNg7iriykkYOuCyIxu2TYtRGFq38U0ByQCToG4eoT40=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01321B0712D270448F02EF7B74FC3EB6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41a88ab-de06-4e5c-0549-08d6f64c077e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 13:26:13.6463 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4744
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe1f::720
Subject: Re: [Qemu-devel] [PATCH v5 33/42] blockdev: Fix active commit choice
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

MTkuMDYuMjAxOSAxODo1OSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxOS4wNi4xOSAxMTozMSwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDEzLjA2LjIwMTkgMTowOSwg
TWF4IFJlaXR6IHdyb3RlOg0KPj4+IFdlIGhhdmUgdG8gcGVyZm9ybSBhbiBhY3RpdmUgY29tbWl0
IHdoZW5ldmVyIHRoZSB0b3Agbm9kZSBoYXMgYSBwYXJlbnQNCj4+PiB0aGF0IGhhcyB0YWtlbiB0
aGUgV1JJVEUgcGVybWlzc2lvbiBvbiBpdC4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IE1heCBS
ZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+DQo+Pj4gLS0tDQo+Pj4gICAgYmxvY2tkZXYuYyB8IDI0
ICsrKysrKysrKysrKysrKysrKysrKy0tLQ0KPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2Jsb2NrZGV2
LmMgYi9ibG9ja2Rldi5jDQo+Pj4gaW5kZXggYTQ2NGNhYmY5ZS4uNTM3MGYzYjczOCAxMDA2NDQN
Cj4+PiAtLS0gYS9ibG9ja2Rldi5jDQo+Pj4gKysrIGIvYmxvY2tkZXYuYw0KPj4+IEBAIC0zMjk0
LDYgKzMyOTQsNyBAQCB2b2lkIHFtcF9ibG9ja19jb21taXQoYm9vbCBoYXNfam9iX2lkLCBjb25z
dCBjaGFyICpqb2JfaWQsIGNvbnN0IGNoYXIgKmRldmljZSwNCj4+PiAgICAgICAgICovDQo+Pj4g
ICAgICAgIEJsb2NrZGV2T25FcnJvciBvbl9lcnJvciA9IEJMT0NLREVWX09OX0VSUk9SX1JFUE9S
VDsNCj4+PiAgICAgICAgaW50IGpvYl9mbGFncyA9IEpPQl9ERUZBVUxUOw0KPj4+ICsgICAgdWlu
dDY0X3QgdG9wX3Blcm0sIHRvcF9zaGFyZWQ7DQo+Pj4gICAgDQo+Pj4gICAgICAgIGlmICghaGFz
X3NwZWVkKSB7DQo+Pj4gICAgICAgICAgICBzcGVlZCA9IDA7DQo+Pj4gQEAgLTM0MDYsMTQgKzM0
MDcsMzEgQEAgdm9pZCBxbXBfYmxvY2tfY29tbWl0KGJvb2wgaGFzX2pvYl9pZCwgY29uc3QgY2hh
ciAqam9iX2lkLCBjb25zdCBjaGFyICpkZXZpY2UsDQo+Pj4gICAgICAgICAgICBnb3RvIG91dDsN
Cj4+PiAgICAgICAgfQ0KPj4+ICAgIA0KPj4+IC0gICAgaWYgKHRvcF9icyA9PSBicykgew0KPj4+
ICsgICAgLyoNCj4+PiArICAgICAqIEFjdGl2ZSBjb21taXQgaXMgcmVxdWlyZWQgaWYgYW5kIG9u
bHkgaWYgc29tZW9uZSBoYXMgdGFrZW4gYQ0KPj4+ICsgICAgICogV1JJVEUgcGVybWlzc2lvbiBv
biB0aGUgdG9wIG5vZGUuICBIaXN0b3JpY2FsbHksIHdlIGhhdmUgYWx3YXlzDQo+Pj4gKyAgICAg
KiB1c2VkIGFjdGl2ZSBjb21taXQgZm9yIHRvcCBub2Rlcywgc28gY29udGludWUgdGhhdCBwcmFj
dGljZS4NCj4+PiArICAgICAqIChBY3RpdmUgY29tbWl0IGlzIG5ldmVyIHJlYWxseSB3cm9uZy4p
DQo+Pg0KPj4gSG1tLCBpZiB3ZSBzdGFydCBhY3RpdmUgY29tbWl0IHdoZW4gbm9ib2R5IGhhcyB3
cml0ZSBhY2Nlc3MsIHRoYW4NCj4+IHdlIGxlYXZlIGEgcG9zc2liaWxpdHkgdG8gc29tZW9uZSB0
byBnZXQgdGhpcyBhY2Nlc3MgZHVyaW5nIGNvbW1pdC4NCj4gDQo+IElzbuKAmXQgdGhhdCBibG9j
a2VkIGJ5IHRoZSBjb21taXQgZmlsdGVyPyAgSWYgaXQgaXNu4oCZdCwgaXQgc2hvdWxkIGJlLg0K
PiANCj4+IEFuZCBkdXJpbmcNCj4+IHBhc3NpdmUgY29tbWl0IHdyaXRlIGFjY2VzcyBpcyBibG9j
a2VkLiBTbywgbWF5IGJlIHJpZ2h0IHdheSBpcyBkbyBhY3RpdmUgY29tbWl0DQo+PiBhbHdheXM/
IEJlbmVmaXRzOg0KPj4gMS4gT25lIGNvZGUgcGF0aC4gYW5kIGl0IHNob3VsZG4ndCBiZSB3b3Jz
ZSB3aGVuIG5vIHdyaXRlcnMsIHdpdGhvdXQgZ3Vlc3Qgd3JpdGVzDQo+PiBtaXJyb3IgY29kZSBz
aG91bGRuJ3Qgd29yayB3b3JzZSB0aGFuIHBhc3NpdmUgY29tbWl0LCBpZiBpdCBpcywgaXQgc2hv
dWxkIGJlIGZpeGVkLg0KPj4gMi4gUG9zc2liaWxpdHkgb2Ygd3JpdGUgYWNjZXNzIGlmIHVzZXIg
bmVlZHMgaXQgZHVyaW5nIGNvbW1pdA0KPj4gMy4gSSdtIHN1cmUgdGhhdCBhY3RpdmUgY29tbWl0
IChtaXJyb3IgY29kZSkgYWN0dWFsbHkgd29ya3MgZmFzdGVyLCBhcyBpdCB1c2VzDQo+PiBhc3lu
YyByZXF1ZXN0cyBhbmQgc21hcnRlciBoYW5kbGluZyBvZiBibG9jayBzdGF0dXMuDQo+IA0KPiBE
aXNhZHZhbnRhZ2U6IFNvbWV0aGluZyBtYXkgYnJlYWsgYmVjYXVzZSB0aGUgYmFzaWMgY29tbWl0
IGpvYiBkb2VzIG5vdA0KPiBlbWl0IEJMT0NLX0pPQl9SRUFEWSBhbmQgdGh1cyBkb2VzIG5vdCBy
ZXF1aXJlIGJsb2NrLWpvYi1jb21wbGV0ZS4NCj4gDQo+IFRlY2huaWNhbGx5IGV2ZXJ5dGhpbmcg
c2hvdWxkIGV4cGVjdCBqb2JzIHRvIHBvdGVudGlhbGx5IGVtaXQNCj4gQkxPQ0tfSk9CX1JFQURZ
LCBidXQgd2hvIGtub3dzLiAgSSB0aGluayB3ZeKAmWQgd2FudCBhdCBsZWFzdCBhDQo+IGRlcHJl
Y2F0aW9uIHBlcmlvZC4NCj4gDQo+IE1heA0KDQpPSywgc28gdGhpcyBpcyBmb3IgZnV0dXJlLi4g
VGhlbjoNCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1l
bnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KPiANCj4+PiArICAgICAqLw0KPj4+ICsgICAgYmRydl9n
ZXRfY3VtdWxhdGl2ZV9wZXJtKHRvcF9icywgJnRvcF9wZXJtLCAmdG9wX3NoYXJlZCk7DQo+Pj4g
KyAgICBpZiAodG9wX3Blcm0gJiBCTEtfUEVSTV9XUklURSB8fA0KPj4+ICsgICAgICAgIGJkcnZf
c2tpcF9yd19maWx0ZXJzKHRvcF9icykgPT0gYmRydl9za2lwX3J3X2ZpbHRlcnMoYnMpKQ0KPj4+
ICsgICAgew0KPj4+ICAgICAgICAgICAgaWYgKGhhc19iYWNraW5nX2ZpbGUpIHsNCj4+PiAgICAg
ICAgICAgICAgICBlcnJvcl9zZXRnKGVycnAsICInYmFja2luZy1maWxlJyBzcGVjaWZpZWQsIg0K
Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIiBidXQgJ3RvcCcgaXMgdGhlIGFj
dGl2ZSBsYXllciIpOw0KPj4+ICAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPj4+ICAgICAgICAg
ICAgfQ0KPj4+IC0gICAgICAgIGNvbW1pdF9hY3RpdmVfc3RhcnQoaGFzX2pvYl9pZCA/IGpvYl9p
ZCA6IE5VTEwsIGJzLCBiYXNlX2JzLA0KPj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
am9iX2ZsYWdzLCBzcGVlZCwgb25fZXJyb3IsDQo+Pj4gKyAgICAgICAgaWYgKCFoYXNfam9iX2lk
KSB7DQo+Pj4gKyAgICAgICAgICAgIC8qDQo+Pj4gKyAgICAgICAgICAgICAqIEVtdWxhdGUgaGVy
ZSB3aGF0IGJsb2NrX2pvYl9jcmVhdGUoKSBkb2VzLCBiZWNhdXNlIGl0DQo+Pj4gKyAgICAgICAg
ICAgICAqIGlzIHBvc3NpYmxlIHRoYXQgQGJzICE9IEB0b3BfYnMgKHRoZSBibG9jayBqb2Igc2hv
dWxkDQo+Pj4gKyAgICAgICAgICAgICAqIGJlIG5hbWVkIGFmdGVyIEBicywgZXZlbiBpZiBAdG9w
X2JzIGlzIHRoZSBhY3R1YWwNCj4+PiArICAgICAgICAgICAgICogc291cmNlKQ0KPj4+ICsgICAg
ICAgICAgICAgKi8NCj4+PiArICAgICAgICAgICAgam9iX2lkID0gYmRydl9nZXRfZGV2aWNlX25h
bWUoYnMpOw0KPj4+ICsgICAgICAgIH0NCj4+PiArICAgICAgICBjb21taXRfYWN0aXZlX3N0YXJ0
KGpvYl9pZCwgdG9wX2JzLCBiYXNlX2JzLCBqb2JfZmxhZ3MsIHNwZWVkLCBvbl9lcnJvciwNCj4+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZmlsdGVyX25vZGVfbmFtZSwgTlVMTCwg
TlVMTCwgZmFsc2UsICZsb2NhbF9lcnIpOw0KPj4+ICAgICAgICB9IGVsc2Ugew0KPj4+ICAgICAg
ICAgICAgQmxvY2tEcml2ZXJTdGF0ZSAqb3ZlcmxheV9icyA9IGJkcnZfZmluZF9vdmVybGF5KGJz
LCB0b3BfYnMpOw0KPj4+DQo+Pg0KPj4NCj4gDQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0K
VmxhZGltaXINCg==

