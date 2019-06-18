Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC39C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 12:10:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD3CE2085A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 12:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eUnAQW6J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD3CE2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56448 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdCwD-0008UY-3r
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 08:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55052)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hdCsx-0005fB-Fo
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 08:06:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hdCsw-0000Ea-6X
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 08:06:47 -0400
Received: from mail-eopbgr00122.outbound.protection.outlook.com
 ([40.107.0.122]:6112 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hdCsv-0000DS-KG; Tue, 18 Jun 2019 08:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1QJCyP2iD1lxOnG70nloCQuj8PgHknmiTwZgdiLNx8=;
 b=eUnAQW6J7hVvvDftLm4Yy3ieJ3x7ZdbyY249LARGd1X6KenUiJjqq8MNbsx6cwfe39lQhGUwfQhHDvtmyu5x4CgnPW1T9w9MQB6rtpPe2NCNpZ4KkOqwl2/tDUGhQbMZGJXGA8ujvZwuTd+FuyFOuXD7oWEFpDfc4hJNSmwNNNA=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB4853.eurprd08.prod.outlook.com (20.179.46.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Tue, 18 Jun 2019 12:06:43 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 12:06:43 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 24/42] block: Use child access functions for QAPI
 queries
Thread-Index: AQHVIWu+986YGk0qo06VitZ9lzimE6ahWbsA
Date: Tue, 18 Jun 2019 12:06:43 +0000
Message-ID: <7cdd5863-e420-4816-7ca4-0148dd63993b@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-25-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-25-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0162.eurprd05.prod.outlook.com
 (2603:10a6:7:28::49) To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190618150640796
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 304f64d3-9def-4544-e1f4-08d6f3e56dd4
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4853; 
x-ms-traffictypediagnostic: DBBPR08MB4853:
x-microsoft-antispam-prvs: <DBBPR08MB485314D95299888B06C9ABD0C1EA0@DBBPR08MB4853.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:291;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(39850400004)(376002)(136003)(396003)(199004)(189003)(81166006)(53936002)(14444005)(256004)(71190400001)(71200400001)(68736007)(86362001)(36756003)(305945005)(3846002)(186003)(31696002)(7736002)(31686004)(6116002)(486006)(11346002)(446003)(476003)(66066001)(66476007)(66946007)(66556008)(66446008)(64756008)(73956011)(2616005)(26005)(81156014)(6512007)(14454004)(478600001)(52116002)(4326008)(8676002)(25786009)(54906003)(8936002)(110136005)(386003)(6506007)(76176011)(102836004)(2501003)(5660300002)(6246003)(99286004)(2906002)(316002)(229853002)(6486002)(6436002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4853;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jtML2BvLpkEXvid1JUK84skNmKMNcB3wRymq8BY/lETbh75ChFZtqDqkYUf/MkveNLmyCoxAGDOmT9wQ/QN7IlIDhQu0LakeggrY1C3gvUrAgy0bHhCPeCgaQqt7w3yFZG5jCwgeX7RZOlngWCNv01rp4Mj/n9W0Hogb/UIo/3lI5pMTxbgJ0C5x8a/kfC+sLXTVZDZnCd/ftvGU2kGGa43s+ZiSmrK0gIc8Pl2ridJcgwAT1pSI5CkLhd97wKwLU5VsWp03xb3dWPUBzYszq9LN9I7lAVx08iHJ03zhGa1b7pKSX3f5aTHG6bZfYAuND+oZGzgGtnYH+VR5obhyyL2LtKShjio/+yPy2AIFB1H0BlqqY+mgX5w6xjPkR4u/0gg26YsfsL11tgrGfsNr086qKfmZi3Ak9i81/9glVmU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C92D32E8FE2524AA4F42D7D0C0B8744@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 304f64d3-9def-4544-e1f4-08d6f3e56dd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 12:06:43.7440 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4853
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.122
Subject: Re: [Qemu-devel] [PATCH v5 24/42] block: Use child access functions
 for QAPI queries
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

MTMuMDYuMjAxOSAxOjA5LCBNYXggUmVpdHogd3JvdGU6DQo+IHF1ZXJ5LWJsb2NrIGFuZCBxdWVy
eS1uYW1lZC1ibG9jay1ub2RlcyBub3cgcmV0dXJuIGFueSBmaWx0ZXJlZCBjaGlsZA0KPiB1bmRl
ciAiYmFja2luZyIsIG5vdCBqdXN0IGJzLT5iYWNraW5nIG9yIENPVyBjaGlsZHJlbi4gIFRoaXMg
aXMgc28gdGhhdA0KPiBmaWx0ZXJzIGRvIG5vdCBpbnRlcnJ1cHQgdGhlIHJlcG9ydGVkIGJhY2tp
bmcgY2hhaW4uICBUaGlzIGNoYW5nZXMgdGhlDQo+IG91dHB1dCBmb3IgaW90ZXN0IDE4NCwgYXMg
dGhlIHRocm90dGxlZCBub2RlIG5vdyBhcHBlYXJzIGFzIGEgYmFja2luZw0KPiBjaGlsZC4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IE1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+DQo+IC0tLQ0K
PiAgIGJsb2NrL3FhcGkuYyAgICAgICAgICAgICAgIHwgMzUgKysrKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0tLS0tLS0NCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMTg0Lm91dCB8ICA3ICsrKysr
Ky0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Jsb2NrL3FhcGkuYyBiL2Jsb2NrL3FhcGkuYw0KPiBpbmRl
eCAwYzEzYzg2ZjRlLi4xZmQyOTM3YWJjIDEwMDY0NA0KPiAtLS0gYS9ibG9jay9xYXBpLmMNCj4g
KysrIGIvYmxvY2svcWFwaS5jDQo+IEBAIC0xNTAsOSArMTUwLDEzIEBAIEJsb2NrRGV2aWNlSW5m
byAqYmRydl9ibG9ja19kZXZpY2VfaW5mbyhCbG9ja0JhY2tlbmQgKmJsaywNCj4gICAgICAgICAg
ICAgICByZXR1cm4gTlVMTDsNCj4gICAgICAgICAgIH0NCj4gICANCj4gLSAgICAgICAgaWYgKGJz
MC0+ZHJ2ICYmIGJzMC0+YmFja2luZykgew0KPiArICAgICAgICBpZiAoYnMwLT5kcnYgJiYgYmRy
dl9maWx0ZXJlZF9jaGlsZChiczApKSB7DQo+ICsgICAgICAgICAgICAvKg0KPiArICAgICAgICAg
ICAgICogUHV0IGFueSBmaWx0ZXJlZCBjaGlsZCBoZXJlIChmb3IgYmFja3dhcmRzIGNvbXBhdGli
aWxpdHkgdG8gd2hlbg0KPiArICAgICAgICAgICAgICogd2UgcHV0IGJzMC0+YmFja2luZyBoZXJl
LCB3aGljaCBtaWdodCBiZSBhbnkgZmlsdGVyZWQgY2hpbGQpLg0KPiArICAgICAgICAgICAgICov
DQo+ICAgICAgICAgICAgICAgaW5mby0+YmFja2luZ19maWxlX2RlcHRoKys7DQo+IC0gICAgICAg
ICAgICBiczAgPSBiczAtPmJhY2tpbmctPmJzOw0KPiArICAgICAgICAgICAgYnMwID0gYmRydl9m
aWx0ZXJlZF9icyhiczApOw0KDQoNCnNvLCBoZXJlIHdlIHJlcG9ydCBhbGwgZmlsdGVyZWQgZmls
dGVyIGNoaWxkcmVuIGFzIGJhY2tpbmcgLi4uDQoNCj4gICAgICAgICAgICAgICAoKnBfaW1hZ2Vf
aW5mbyktPmhhc19iYWNraW5nX2ltYWdlID0gdHJ1ZTsNCj4gICAgICAgICAgICAgICBwX2ltYWdl
X2luZm8gPSAmKCgqcF9pbWFnZV9pbmZvKS0+YmFja2luZ19pbWFnZSk7DQo+ICAgICAgICAgICB9
IGVsc2Ugew0KPiBAQCAtMTYxLDkgKzE2NSw4IEBAIEJsb2NrRGV2aWNlSW5mbyAqYmRydl9ibG9j
a19kZXZpY2VfaW5mbyhCbG9ja0JhY2tlbmQgKmJsaywNCj4gICANCj4gICAgICAgICAgIC8qIFNr
aXAgYXV0b21hdGljYWxseSBpbnNlcnRlZCBub2RlcyB0aGF0IHRoZSB1c2VyIGlzbid0IGF3YXJl
IG9mIGZvcg0KPiAgICAgICAgICAgICogcXVlcnktYmxvY2sgKGJsayAhPSBOVUxMKSwgYnV0IG5v
dCBmb3IgcXVlcnktbmFtZWQtYmxvY2stbm9kZXMgKi8NCj4gLSAgICAgICAgd2hpbGUgKGJsayAm
JiBiczAtPmRydiAmJiBiczAtPmltcGxpY2l0KSB7DQo+IC0gICAgICAgICAgICBiczAgPSBiYWNr
aW5nX2JzKGJzMCk7DQo+IC0gICAgICAgICAgICBhc3NlcnQoYnMwKTsNCj4gKyAgICAgICAgaWYg
KGJsaykgew0KPiArICAgICAgICAgICAgYnMwID0gYmRydl9za2lwX2ltcGxpY2l0X2ZpbHRlcnMo
YnMwKTsNCj4gICAgICAgICAgIH0NCj4gICAgICAgfQ0KPiAgIA0KPiBAQCAtMzQ4LDkgKzM1MSw5
IEBAIHN0YXRpYyB2b2lkIGJkcnZfcXVlcnlfaW5mbyhCbG9ja0JhY2tlbmQgKmJsaywgQmxvY2tJ
bmZvICoqcF9pbmZvLA0KPiAgICAgICBCbG9ja0RyaXZlclN0YXRlICpicyA9IGJsa19icyhibGsp
Ow0KPiAgICAgICBjaGFyICpxZGV2Ow0KPiAgIA0KPiAtICAgIC8qIFNraXAgYXV0b21hdGljYWxs
eSBpbnNlcnRlZCBub2RlcyB0aGF0IHRoZSB1c2VyIGlzbid0IGF3YXJlIG9mICovDQo+IC0gICAg
d2hpbGUgKGJzICYmIGJzLT5kcnYgJiYgYnMtPmltcGxpY2l0KSB7DQo+IC0gICAgICAgIGJzID0g
YmFja2luZ19icyhicyk7DQo+ICsgICAgaWYgKGJzKSB7DQo+ICsgICAgICAgIC8qIFNraXAgYXV0
b21hdGljYWxseSBpbnNlcnRlZCBub2RlcyB0aGF0IHRoZSB1c2VyIGlzbid0IGF3YXJlIG9mICov
DQo+ICsgICAgICAgIGJzID0gYmRydl9za2lwX2ltcGxpY2l0X2ZpbHRlcnMoYnMpOw0KPiAgICAg
ICB9DQo+ICAgDQo+ICAgICAgIGluZm8tPmRldmljZSA9IGdfc3RyZHVwKGJsa19uYW1lKGJsaykp
Ow0KPiBAQCAtNTA3LDYgKzUxMCw3IEBAIHN0YXRpYyB2b2lkIGJkcnZfcXVlcnlfYmxrX3N0YXRz
KEJsb2NrRGV2aWNlU3RhdHMgKmRzLCBCbG9ja0JhY2tlbmQgKmJsaykNCj4gICBzdGF0aWMgQmxv
Y2tTdGF0cyAqYmRydl9xdWVyeV9iZHNfc3RhdHMoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgYmxrX2xldmVsKQ0K
PiAgIHsNCj4gKyAgICBCbG9ja0RyaXZlclN0YXRlICpzdG9yYWdlX2JzLCAqY293X2JzOw0KPiAg
ICAgICBCbG9ja1N0YXRzICpzID0gTlVMTDsNCj4gICANCj4gICAgICAgcyA9IGdfbWFsbG9jMChz
aXplb2YoKnMpKTsNCj4gQEAgLTUxOSw5ICs1MjMsOCBAQCBzdGF0aWMgQmxvY2tTdGF0cyAqYmRy
dl9xdWVyeV9iZHNfc3RhdHMoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+ICAgICAgIC8qIFNraXAg
YXV0b21hdGljYWxseSBpbnNlcnRlZCBub2RlcyB0aGF0IHRoZSB1c2VyIGlzbid0IGF3YXJlIG9m
IGluDQo+ICAgICAgICAqIGEgQmxvY2tCYWNrZW5kLWxldmVsIGNvbW1hbmQuIFN0YXkgYXQgdGhl
IGV4YWN0IG5vZGUgZm9yIGEgbm9kZS1sZXZlbA0KPiAgICAgICAgKiBjb21tYW5kLiAqLw0KPiAt
ICAgIHdoaWxlIChibGtfbGV2ZWwgJiYgYnMtPmRydiAmJiBicy0+aW1wbGljaXQpIHsNCj4gLSAg
ICAgICAgYnMgPSBiYWNraW5nX2JzKGJzKTsNCj4gLSAgICAgICAgYXNzZXJ0KGJzKTsNCj4gKyAg
ICBpZiAoYmxrX2xldmVsKSB7DQo+ICsgICAgICAgIGJzID0gYmRydl9za2lwX2ltcGxpY2l0X2Zp
bHRlcnMoYnMpOw0KPiAgICAgICB9DQo+ICAgDQo+ICAgICAgIGlmIChiZHJ2X2dldF9ub2RlX25h
bWUoYnMpWzBdKSB7DQo+IEBAIC01MzEsMTQgKzUzNCwxNiBAQCBzdGF0aWMgQmxvY2tTdGF0cyAq
YmRydl9xdWVyeV9iZHNfc3RhdHMoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+ICAgDQo+ICAgICAg
IHMtPnN0YXRzLT53cl9oaWdoZXN0X29mZnNldCA9IHN0YXQ2NF9nZXQoJmJzLT53cl9oaWdoZXN0
X29mZnNldCk7DQo+ICAgDQo+IC0gICAgaWYgKGJzLT5maWxlKSB7DQo+ICsgICAgc3RvcmFnZV9i
cyA9IGJkcnZfc3RvcmFnZV9icyhicyk7DQo+ICsgICAgaWYgKHN0b3JhZ2VfYnMpIHsNCj4gICAg
ICAgICAgIHMtPmhhc19wYXJlbnQgPSB0cnVlOw0KPiAtICAgICAgICBzLT5wYXJlbnQgPSBiZHJ2
X3F1ZXJ5X2Jkc19zdGF0cyhicy0+ZmlsZS0+YnMsIGJsa19sZXZlbCk7DQo+ICsgICAgICAgIHMt
PnBhcmVudCA9IGJkcnZfcXVlcnlfYmRzX3N0YXRzKHN0b3JhZ2VfYnMsIGJsa19sZXZlbCk7DQoN
Ci4uLiBhbmQgaGVyZSBub3QgYXMgImJhY2tpbmciIGJ1dCBhcyAicGFyZW50Ig0KDQpTaG91bGRu
J3Qgd2UgcmVwb3J0IGZpbHRlci1jaGlsZCBhcyBiYWNraW5nIGhlcmUgdG9vLCBmb3IgY29uc2lz
dGVuY3k/DQoNCmFueXdheToNCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2ll
dnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KPiAgICAgICB9DQo+ICAgDQo+IC0g
ICAgaWYgKGJsa19sZXZlbCAmJiBicy0+YmFja2luZykgew0KPiArICAgIGNvd19icyA9IGJkcnZf
ZmlsdGVyZWRfY293X2JzKGJzKTsNCj4gKyAgICBpZiAoYmxrX2xldmVsICYmIGNvd19icykgew0K
PiAgICAgICAgICAgcy0+aGFzX2JhY2tpbmcgPSB0cnVlOw0KPiAtICAgICAgICBzLT5iYWNraW5n
ID0gYmRydl9xdWVyeV9iZHNfc3RhdHMoYnMtPmJhY2tpbmctPmJzLCBibGtfbGV2ZWwpOw0KPiAr
ICAgICAgICBzLT5iYWNraW5nID0gYmRydl9xdWVyeV9iZHNfc3RhdHMoY293X2JzLCBibGtfbGV2
ZWwpOw0KPiAgICAgICB9DQo+ICAgDQo+ICAgICAgIHJldHVybiBzOw0KPiBkaWZmIC0tZ2l0IGEv
dGVzdHMvcWVtdS1pb3Rlc3RzLzE4NC5vdXQgYi90ZXN0cy9xZW11LWlvdGVzdHMvMTg0Lm91dA0K
PiBpbmRleCAzZGViM2NmYjk0Li4xZDYxZjdlMjI0IDEwMDY0NA0KPiAtLS0gYS90ZXN0cy9xZW11
LWlvdGVzdHMvMTg0Lm91dA0KPiArKysgYi90ZXN0cy9xZW11LWlvdGVzdHMvMTg0Lm91dA0KPiBA
QCAtMjcsNiArMjcsMTEgQEAgVGVzdGluZzoNCj4gICAgICAgICAgICAgICAiaW9wc19yZCI6IDAs
DQo+ICAgICAgICAgICAgICAgImRldGVjdF96ZXJvZXMiOiAib2ZmIiwNCj4gICAgICAgICAgICAg
ICAiaW1hZ2UiOiB7DQo+ICsgICAgICAgICAgICAgICAgImJhY2tpbmctaW1hZ2UiOiB7DQo+ICsg
ICAgICAgICAgICAgICAgICAgICJ2aXJ0dWFsLXNpemUiOiAxMDczNzQxODI0LA0KPiArICAgICAg
ICAgICAgICAgICAgICAiZmlsZW5hbWUiOiAibnVsbC1jbzovLyIsDQo+ICsgICAgICAgICAgICAg
ICAgICAgICJmb3JtYXQiOiAibnVsbC1jbyINCj4gKyAgICAgICAgICAgICAgICB9LA0KPiAgICAg
ICAgICAgICAgICAgICAidmlydHVhbC1zaXplIjogMTA3Mzc0MTgyNCwNCj4gICAgICAgICAgICAg
ICAgICAgImZpbGVuYW1lIjogImpzb246e1widGhyb3R0bGUtZ3JvdXBcIjogXCJncm91cDBcIiwg
XCJkcml2ZXJcIjogXCJ0aHJvdHRsZVwiLCBcImZpbGVcIjoge1wiZHJpdmVyXCI6IFwibnVsbC1j
b1wifX0iLA0KPiAgICAgICAgICAgICAgICAgICAiZm9ybWF0IjogInRocm90dGxlIg0KPiBAQCAt
MzQsNyArMzksNyBAQCBUZXN0aW5nOg0KPiAgICAgICAgICAgICAgICJpb3BzX3dyIjogMCwNCj4g
ICAgICAgICAgICAgICAicm8iOiBmYWxzZSwNCj4gICAgICAgICAgICAgICAibm9kZS1uYW1lIjog
InRocm90dGxlMCIsDQo+IC0gICAgICAgICAgICAiYmFja2luZ19maWxlX2RlcHRoIjogMCwNCj4g
KyAgICAgICAgICAgICJiYWNraW5nX2ZpbGVfZGVwdGgiOiAxLA0KPiAgICAgICAgICAgICAgICJk
cnYiOiAidGhyb3R0bGUiLA0KPiAgICAgICAgICAgICAgICJpb3BzIjogMCwNCj4gICAgICAgICAg
ICAgICAiYnBzX3dyIjogMCwNCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

