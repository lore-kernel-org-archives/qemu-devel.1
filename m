Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0CBC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:18:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B43D121721
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WVR1LBqU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43D121721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39638 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbPcd-0002Mq-U6
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 09:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35467)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbOp4-0005XT-Pc
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:27:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbOp2-0006gE-1V
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:27:18 -0400
Received: from mail-eopbgr40109.outbound.protection.outlook.com
 ([40.107.4.109]:48710 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbOp1-0006ec-1A; Thu, 13 Jun 2019 08:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/y4di4aaCjFptIMtvTaoLoza8yLOMz7BUk6VxxATye8=;
 b=WVR1LBqUrLQDVd9qbu6ByWTGX+kLYLCKACJzo5Z4OLu4+px29hlL6UxkpDIqKw53dnF0/yd+O/WKczIJ2L5sBVrtRKah4bP9vyLK1ynugdpqZEbWhaHWxOPcBclfIlh/iR0J8ifT38OUNZpeDH/lUD1cn/Hdug4ndeq8OkOlhbo=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB2977.eurprd08.prod.outlook.com (52.134.124.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.17; Thu, 13 Jun 2019 12:27:11 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 12:27:12 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 06/42] qcow2: Implement .bdrv_storage_child()
Thread-Index: AQHVIWujg1Ch15JgHEW/OeE2SRugAaaZg8yA
Date: Thu, 13 Jun 2019 12:27:11 +0000
Message-ID: <3d3586e4-8ab3-7011-039c-0536647bea92@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-7-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-7-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR1001CA0009.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::19) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190613152709855
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 416ee452-ec1e-40ab-fec8-08d6effa75bd
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB2977; 
x-ms-traffictypediagnostic: AM0PR08MB2977:
x-microsoft-antispam-prvs: <AM0PR08MB2977F52854C6E6CEAECF145EC1EF0@AM0PR08MB2977.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(136003)(366004)(396003)(346002)(376002)(189003)(199004)(31696002)(71190400001)(476003)(6116002)(73956011)(71200400001)(6506007)(6486002)(6246003)(66066001)(446003)(486006)(54906003)(5660300002)(2616005)(229853002)(11346002)(25786009)(110136005)(66946007)(4326008)(81156014)(2501003)(99286004)(8676002)(7736002)(14444005)(86362001)(316002)(81166006)(66556008)(8936002)(66476007)(66446008)(64756008)(305945005)(256004)(53936002)(14454004)(6436002)(52116002)(26005)(76176011)(102836004)(186003)(478600001)(3846002)(386003)(36756003)(68736007)(31686004)(2906002)(6512007)(142923001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB2977;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zA0kXpd9PwYZbH/eWSmfMUoHpk0bHere8hTAn8dl2q1sVWkDKY5iHPp9Gm8BiueqwT5+3wheqxv3jL0LWzg0FM57n8LAbUWZcxQ+gdMzN/cfJnPkeIulcK1ii7Jb5j+zIt+9xqif/p+cohAAreSgTguobVt5l5jqE8TX3HHLOSWZdFfKOV5fLeIDfx0fTYHLXaIIZqeloahdIeezCdxdjon4TJ44FrhPkM4kjkiUbxE1FAlh7Z2FknfF1DNxY1ZEjObL4XoAgE1ZsIkun5qzCByHpHBz+0qSEo0noQhYu4b0mTMoFlxu2OIPEBRe9QAh99OXZdMYGFv7/8Vn5Ozjf+kNoXvyzI3L/gB7IugimjAVTHh52wptSInfDty4AAcPZI6F9tmucAetpDnVDIDVR/EAiGk6SEVxWlyFVpqjimA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FBDD6529E9AF642A0C01C7BDA2A8D0A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 416ee452-ec1e-40ab-fec8-08d6effa75bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 12:27:11.9230 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB2977
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.109
Subject: Re: [Qemu-devel] [PATCH v5 06/42] qcow2: Implement
 .bdrv_storage_child()
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

MTMuMDYuMjAxOSAxOjA5LCBNYXggUmVpdHogd3JvdGU6DQo+IFNpZ25lZC1vZmYtYnk6IE1heCBS
ZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+DQoNCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVu
dHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KPiAtLS0NCj4gICBi
bG9jay9xY293Mi5jIHwgOSArKysrKysrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRp
b25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYmxvY2svcWNvdzIuYyBiL2Jsb2NrL3Fjb3cyLmMN
Cj4gaW5kZXggOTM5NmQ0OTBkNS4uNTc2NzVjOTQxNiAxMDA2NDQNCj4gLS0tIGEvYmxvY2svcWNv
dzIuYw0KPiArKysgYi9ibG9jay9xY293Mi5jDQo+IEBAIC01MDg1LDYgKzUwODUsMTMgQEAgdm9p
ZCBxY293Ml9zaWduYWxfY29ycnVwdGlvbihCbG9ja0RyaXZlclN0YXRlICpicywgYm9vbCBmYXRh
bCwgaW50NjRfdCBvZmZzZXQsDQo+ICAgICAgIHMtPnNpZ25hbGVkX2NvcnJ1cHRpb24gPSB0cnVl
Ow0KPiAgIH0NCj4gICANCj4gK3N0YXRpYyBCZHJ2Q2hpbGQgKnFjb3cyX3N0b3JhZ2VfY2hpbGQo
QmxvY2tEcml2ZXJTdGF0ZSAqYnMpDQo+ICt7DQo+ICsgICAgQkRSVlFjb3cyU3RhdGUgKnMgPSBi
cy0+b3BhcXVlOw0KPiArDQo+ICsgICAgcmV0dXJuIHMtPmRhdGFfZmlsZTsNCj4gK30NCj4gKw0K
PiAgIHN0YXRpYyBRZW11T3B0c0xpc3QgcWNvdzJfY3JlYXRlX29wdHMgPSB7DQo+ICAgICAgIC5u
YW1lID0gInFjb3cyLWNyZWF0ZS1vcHRzIiwNCj4gICAgICAgLmhlYWQgPSBRVEFJTFFfSEVBRF9J
TklUSUFMSVpFUihxY293Ml9jcmVhdGVfb3B0cy5oZWFkKSwNCj4gQEAgLTUyMzEsNiArNTIzOCw4
IEBAIEJsb2NrRHJpdmVyIGJkcnZfcWNvdzIgPSB7DQo+ICAgICAgIC5iZHJ2X3Jlb3Blbl9iaXRt
YXBzX3J3ID0gcWNvdzJfcmVvcGVuX2JpdG1hcHNfcncsDQo+ICAgICAgIC5iZHJ2X2Nhbl9zdG9y
ZV9uZXdfZGlydHlfYml0bWFwID0gcWNvdzJfY2FuX3N0b3JlX25ld19kaXJ0eV9iaXRtYXAsDQo+
ICAgICAgIC5iZHJ2X3JlbW92ZV9wZXJzaXN0ZW50X2RpcnR5X2JpdG1hcCA9IHFjb3cyX3JlbW92
ZV9wZXJzaXN0ZW50X2RpcnR5X2JpdG1hcCwNCj4gKw0KPiArICAgIC5iZHJ2X3N0b3JhZ2VfY2hp
bGQgPSBxY293Ml9zdG9yYWdlX2NoaWxkLA0KPiAgIH07DQo+ICAgDQo+ICAgc3RhdGljIHZvaWQg
YmRydl9xY293Ml9pbml0KHZvaWQpDQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGlt
aXINCg==

