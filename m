Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB900C31E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:45:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C14E2133D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZD/Vdisi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C14E2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52232 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbnSI-0005EB-2t
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 10:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53297)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbmm1-0002o8-NC
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbmm0-0006Z6-DV
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:01:45 -0400
Received: from mail-eopbgr00112.outbound.protection.outlook.com
 ([40.107.0.112]:42276 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbmlz-0006Wx-L8; Fri, 14 Jun 2019 10:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pD19G2jIhbxtIl+w7t38ui03LGvAXf8APCotdJBnUyQ=;
 b=ZD/VdisiNmjWiBL/bGwSjK1Jnys6IDixHXSwV9YRn3ZJzkraabPfRmIUfPhRzYwwPhT3fvw1xrjW7Ntx8k/4p2+hmZ2vjqrmLTa32Vk4iXS4xnaaz6U7n7TFUq1066MCID6I62ICACHPn8fGo4b1BR4zkRTm6aI8+5XyjIYnVnk=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB3026.eurprd08.prod.outlook.com (52.134.125.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Fri, 14 Jun 2019 14:01:40 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Fri, 14 Jun 2019
 14:01:40 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 16/42] block: Use child access functions when flushing
Thread-Index: AQHVIWux6GL2TIka3kOwrYgeDB03saabMIYA
Date: Fri, 14 Jun 2019 14:01:40 +0000
Message-ID: <d3a6b385-6aa5-cec0-268a-5f6c3e2075c2@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-17-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-17-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0802CA0014.eurprd08.prod.outlook.com (10.172.123.152)
 To AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190614170138866
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22bde1a6-6381-4042-f35b-08d6f0d0d30b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB3026; 
x-ms-traffictypediagnostic: AM0PR08MB3026:
x-microsoft-antispam-prvs: <AM0PR08MB3026DE4AED618AD0F80939CBC1EE0@AM0PR08MB3026.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(346002)(376002)(39850400004)(366004)(199004)(189003)(6116002)(31686004)(3846002)(36756003)(71190400001)(71200400001)(66066001)(2906002)(31696002)(68736007)(478600001)(86362001)(14454004)(7736002)(305945005)(446003)(11346002)(2616005)(8676002)(81156014)(476003)(8936002)(66556008)(64756008)(486006)(73956011)(256004)(5660300002)(229853002)(66946007)(66476007)(66446008)(81166006)(14444005)(316002)(53936002)(99286004)(6436002)(6512007)(6246003)(4326008)(25786009)(6486002)(76176011)(186003)(54906003)(386003)(6506007)(2501003)(52116002)(26005)(110136005)(102836004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3026;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DoL/lKb3LOW9CVImK/aA6XbQYzvXsGJqSt0wJnaFQMm2jDkBItP6uscCuxm+z57iYPAn8H3u+i52/SYwtveE7/hKUSHgmcgxM4YMFdgvAf940bfdgoc+Xh3PRDTgzanr0vcB3QKpToMDvV/N6aTVeVOqaFU/QpCK85fPzcYrNSYpFWnRQfQrPcs0muxZZCZS1U0/e/KzLYhOziqhUV9Z1GWyWYx9L1FbIcSWih1KD7aPXfRyG/fJtUy1b73jEmmXCK3FKQKN9UiUBqx44RwP4SHDeZY/N3/ymJW92OAGcDzqHgzCZpEQV9BpfC4NBKBEbiEP5mGltmMPiQl0tj3Q3f7CJRvQoNOuEHYbFdM2R6M+13VRZqN93bRT6Uv73yXoaRkI0xGazrkcV5cW0+VSNk1ZOEZCYie00vaZst8STEQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C03CF6E72C0B046ABAA2C443E61DBA8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22bde1a6-6381-4042-f35b-08d6f0d0d30b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 14:01:40.6552 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3026
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.112
Subject: Re: [Qemu-devel] [PATCH v5 16/42] block: Use child access functions
 when flushing
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

MTMuMDYuMjAxOSAxOjA5LCBNYXggUmVpdHogd3JvdGU6DQo+IElmIHRoZSBkcml2ZXIgZG9lcyBu
b3Qgc3VwcG9ydCAuYmRydl9jb19mbHVzaCgpIHNvIGJkcnZfY29fZmx1c2goKQ0KPiBpdHNlbGYg
aGFzIHRvIGZsdXNoIHRoZSBjaGlsZHJlbiBvZiB0aGUgZ2l2ZW4gbm9kZSwgaXQgc2hvdWxkIG5v
dCBmbHVzaA0KPiBqdXN0IGJzLT5maWxlLT5icywgYnV0IGluIGZhY3QgYm90aCB0aGUgY2hpbGQg
dGhhdCBzdG9yZXMgZGF0YSwgYW5kIHRoZQ0KPiBvbmUgdGhhdCBzdG9yZXMgbWV0YWRhdGEgKGlm
IHRoZXkgYXJlIHNlcGFyYXRlKS4NCj4gDQo+IEluIGFueSBjYXNlLCB0aGUgQkxLREJHX0VWRU5U
KCkgc2hvdWxkIGJlIGVtaXR0ZWQgb24gdGhlIHByaW1hcnkgY2hpbGQsDQo+IGJlY2F1c2UgdGhh
dCBpcyB3aGVyZSBhIGJsa2RlYnVnIG5vZGUgd291bGQgYmUgaWYgdGhlcmUgaXMgYW55Lg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogTWF4IFJlaXR6IDxtcmVpdHpAcmVkaGF0LmNvbT4NCj4gLS0tDQo+
ICAgYmxvY2svaW8uYyB8IDIxICsrKysrKysrKysrKysrKysrKy0tLQ0KPiAgIDEgZmlsZSBjaGFu
Z2VkLCAxOCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2Jsb2NrL2lvLmMgYi9ibG9jay9pby5jDQo+IGluZGV4IDUzYWFiZjg2YjUuLjY0NDA4Y2YxOWEg
MTAwNjQ0DQo+IC0tLSBhL2Jsb2NrL2lvLmMNCj4gKysrIGIvYmxvY2svaW8uYw0KPiBAQCAtMjUz
Myw2ICsyNTMzLDggQEAgc3RhdGljIHZvaWQgY29yb3V0aW5lX2ZuIGJkcnZfZmx1c2hfY29fZW50
cnkodm9pZCAqb3BhcXVlKQ0KPiAgIA0KPiAgIGludCBjb3JvdXRpbmVfZm4gYmRydl9jb19mbHVz
aChCbG9ja0RyaXZlclN0YXRlICpicykNCj4gICB7DQo+ICsgICAgQmRydkNoaWxkICpwcmltYXJ5
X2NoaWxkID0gYmRydl9wcmltYXJ5X2NoaWxkKGJzKTsNCj4gKyAgICBCbG9ja0RyaXZlclN0YXRl
ICpzdG9yYWdlX2JzLCAqbWV0YWRhdGFfYnM7DQo+ICAgICAgIGludCBjdXJyZW50X2dlbjsNCj4g
ICAgICAgaW50IHJldCA9IDA7DQo+ICAgDQo+IEBAIC0yNTYyLDcgKzI1NjQsNyBAQCBpbnQgY29y
b3V0aW5lX2ZuIGJkcnZfY29fZmx1c2goQmxvY2tEcml2ZXJTdGF0ZSAqYnMpDQo+ICAgICAgIH0N
Cj4gICANCj4gICAgICAgLyogV3JpdGUgYmFjayBjYWNoZWQgZGF0YSB0byB0aGUgT1MgZXZlbiB3
aXRoIGNhY2hlPXVuc2FmZSAqLw0KPiAtICAgIEJMS0RCR19FVkVOVChicy0+ZmlsZSwgQkxLREJH
X0ZMVVNIX1RPX09TKTsNCj4gKyAgICBCTEtEQkdfRVZFTlQocHJpbWFyeV9jaGlsZCwgQkxLREJH
X0ZMVVNIX1RPX09TKTsNCj4gICAgICAgaWYgKGJzLT5kcnYtPmJkcnZfY29fZmx1c2hfdG9fb3Mp
IHsNCj4gICAgICAgICAgIHJldCA9IGJzLT5kcnYtPmJkcnZfY29fZmx1c2hfdG9fb3MoYnMpOw0K
PiAgICAgICAgICAgaWYgKHJldCA8IDApIHsNCj4gQEAgLTI1ODAsNyArMjU4Miw3IEBAIGludCBj
b3JvdXRpbmVfZm4gYmRydl9jb19mbHVzaChCbG9ja0RyaXZlclN0YXRlICpicykNCj4gICAgICAg
ICAgIGdvdG8gZmx1c2hfcGFyZW50Ow0KPiAgICAgICB9DQo+ICAgDQo+IC0gICAgQkxLREJHX0VW
RU5UKGJzLT5maWxlLCBCTEtEQkdfRkxVU0hfVE9fRElTSyk7DQo+ICsgICAgQkxLREJHX0VWRU5U
KHByaW1hcnlfY2hpbGQsIEJMS0RCR19GTFVTSF9UT19ESVNLKTsNCj4gICAgICAgaWYgKCFicy0+
ZHJ2KSB7DQo+ICAgICAgICAgICAvKiBicy0+ZHJ2LT5iZHJ2X2NvX2ZsdXNoKCkgbWlnaHQgaGF2
ZSBlamVjdGVkIHRoZSBCRFMNCj4gICAgICAgICAgICAqIChldmVuIGluIGNhc2Ugb2YgYXBwYXJl
bnQgc3VjY2VzcykgKi8NCj4gQEAgLTI2MjUsNyArMjYyNywyMCBAQCBpbnQgY29yb3V0aW5lX2Zu
IGJkcnZfY29fZmx1c2goQmxvY2tEcml2ZXJTdGF0ZSAqYnMpDQo+ICAgICAgICAqIGluIHRoZSBj
YXNlIG9mIGNhY2hlPXVuc2FmZSwgc28gdGhlcmUgYXJlIG5vIHVzZWxlc3MgZmx1c2hlcy4NCj4g
ICAgICAgICovDQo+ICAgZmx1c2hfcGFyZW50Og0KPiAtICAgIHJldCA9IGJzLT5maWxlID8gYmRy
dl9jb19mbHVzaChicy0+ZmlsZS0+YnMpIDogMDsNCj4gKyAgICBzdG9yYWdlX2JzID0gYmRydl9z
dG9yYWdlX2JzKGJzKTsNCj4gKyAgICBtZXRhZGF0YV9icyA9IGJkcnZfbWV0YWRhdGFfYnMoYnMp
Ow0KPiArDQo+ICsgICAgcmV0ID0gMDsNCj4gKyAgICBpZiAoc3RvcmFnZV9icykgew0KPiArICAg
ICAgICByZXQgPSBiZHJ2X2NvX2ZsdXNoKHN0b3JhZ2VfYnMpOw0KPiArICAgIH0NCj4gKyAgICBp
ZiAobWV0YWRhdGFfYnMgJiYgbWV0YWRhdGFfYnMgIT0gc3RvcmFnZV9icykgew0KPiArICAgICAg
ICBpbnQgcmV0X21ldGFkYXRhID0gYmRydl9jb19mbHVzaChtZXRhZGF0YV9icyk7DQo+ICsgICAg
ICAgIGlmICghcmV0KSB7DQo+ICsgICAgICAgICAgICByZXQgPSByZXRfbWV0YWRhdGE7DQo+ICsg
ICAgICAgIH0NCj4gKyAgICB9DQo+ICsNCj4gICBvdXQ6DQo+ICAgICAgIC8qIE5vdGlmeSBhbnkg
cGVuZGluZyBmbHVzaGVzIHRoYXQgd2UgaGF2ZSBjb21wbGV0ZWQgKi8NCj4gICAgICAgaWYgKHJl
dCA9PSAwKSB7DQo+IA0KDQpIbW0sIEknbSBub3Qgc3VyZSB0aGF0IGlmIGluIG9uZSBkcml2ZXIg
d2UgZGVjaWRlZCB0byBzdG9yZSBkYXRhIGFuZCBtZXRhZGF0YSBzZXBhcmF0ZWx5LA0Kd2UgbmVl
ZCB0byBzdXBwb3J0IGZsdXNoaW5nIHRoZW0gYm90aCBnZW5lcmljIGNvZGUuLiBJZiBhdCBzb21l
IHBvaW50IHFjb3cyIGRlY2lkZXMgc3RvcmUgcGFydA0Kb2YgbWV0YWRhdGEgaW4gdGhpcmQgY2hp
bGQsIHdlIHdpbGwgbm90IGZsdXNoIGl0IGhlcmUgdG9vPw0KDQpTaG91bGQgbm90IHdlIGluc3Rl
YWQgbG9vcCB0aHJvdWdoIGNoaWxkcmVuIGFuZCBmbHVzaCBhbGw/IEFuZCBJJ2Qgcy9mbHVzaF9w
YXJlbnQvZmx1c2hfY2hpbGRyZW4gYXMNCml0IGlzIHJhdGhlciB3ZWlyZC4NCg0KLS0gDQpCZXN0
IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

