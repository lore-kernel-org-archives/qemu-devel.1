Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4147C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:19:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C04BE21537
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ExORSsKM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C04BE21537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51954 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbn2n-00089A-No
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 10:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47096)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbmTK-0002Jo-U1
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:42:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbmTE-0006sB-Jr
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:42:22 -0400
Received: from mail-eopbgr40110.outbound.protection.outlook.com
 ([40.107.4.110]:24878 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbmTB-0006oy-Lr; Fri, 14 Jun 2019 09:42:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tdffe7PY0nUFSAncLwuW6zzdxuo9iuCjoBHhF+nMAac=;
 b=ExORSsKMoUJweN5iKMBvZlD6REqseLYjgXaPW1pAahfcfMKmT9uUEyMv0GjrYYCRAzMC9aB9Fkg+eUkpBCJ/KU/SiYnn7kUiVYVsiMKIWk4hsmLTMQQhDjkuTCFWp4VdxnV2GlDPj+PWzNUx7V4szfvtqNitQvY5mQTKE6V+oU0=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB3521.eurprd08.prod.outlook.com (20.177.109.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Fri, 14 Jun 2019 13:42:13 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Fri, 14 Jun 2019
 13:42:13 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 15/42] block: Re-evaluate backing file handling in
 reopen
Thread-Index: AQHVIWuwf7wnR9ymBkSFfDsy80Nj7qabKxeA
Date: Fri, 14 Jun 2019 13:42:12 +0000
Message-ID: <9e448427-1d53-c1a7-c51f-123acf6eccaf@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-16-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-16-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0502CA0005.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::15) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190614164211142
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17e0e20a-d0f0-4d5c-69f1-08d6f0ce1b0a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB3521; 
x-ms-traffictypediagnostic: AM0PR08MB3521:
x-microsoft-antispam-prvs: <AM0PR08MB35215D99A8CC068FB977B369C1EE0@AM0PR08MB3521.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:159;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39850400004)(346002)(396003)(136003)(376002)(189003)(199004)(6512007)(486006)(6436002)(11346002)(476003)(2616005)(68736007)(446003)(256004)(14444005)(478600001)(14454004)(316002)(305945005)(99286004)(7736002)(6486002)(2906002)(31686004)(229853002)(36756003)(52116002)(8676002)(6116002)(81156014)(81166006)(3846002)(6506007)(53936002)(73956011)(64756008)(6246003)(66446008)(66476007)(66946007)(66556008)(386003)(8936002)(5660300002)(25786009)(26005)(86362001)(110136005)(31696002)(76176011)(66066001)(102836004)(186003)(4326008)(71200400001)(71190400001)(54906003)(2501003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3521;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X4bc+/ocl+E/UevuCTJpgTTG60agw8feQ9P1mY7W+UUBwVC6n0NCaKkQBiGHIohXgouPbQEasrtArrq+Yc/UV/UBGogSM0nvLZMRXdTYt3NUKyXTFgEPvEiRMrgNIfc3wjk0ZbVXU+Ac5XpJU0Dc3dbE4hfPz8qXDlcNKRKtQ7CWdG1TYx05ztXjgOQaI4S3788HZrhDEVWDGovwJbWvMG/FWu2xZytC/A44K5rG31hPVe/Az/Mxi9N6lZLthFizM3P9o/aw/doieKYAWTxtkJhoF0F7L+fPvw4DXnpfRBPsE6iRuvWZekvZ/wDj1v8+BC0DrZoebA64LJXOc5Y/4O5UhklxVHnXHDzta4Ftg45wgkhhK/9Nhb7kcgllCyHEoVts4d7oF/u3GHE4DIEJZCFgCUSwuE1w0mhZkGfytUM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01F0AD77A9BDEC46B9E0C4C074C71251@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e0e20a-d0f0-4d5c-69f1-08d6f0ce1b0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 13:42:12.9668 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3521
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.110
Subject: Re: [Qemu-devel] [PATCH v5 15/42] block: Re-evaluate backing file
 handling in reopen
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

MTMuMDYuMjAxOSAxOjA5LCBNYXggUmVpdHogd3JvdGU6DQo+IFJlb3BlbmluZyBhIG5vZGUncyBi
YWNraW5nIGNoaWxkIG5lZWRzIGEgYml0IG9mIHNwZWNpYWwgaGFuZGxpbmcgYmVjYXVzZQ0KPiB0
aGUgImJhY2tpbmciIGNoaWxkIGhhcyBkaWZmZXJlbnQgZGVmYXVsdHMgdGhhbiBhbGwgb3RoZXIg
Y2hpbGRyZW4NCj4gKGFtb25nIG90aGVyIHRoaW5ncykuICBBZGRpbmcgZmlsdGVyIHN1cHBvcnQg
aGVyZSBpcyBhIGJpdCBtb3JlDQo+IGRpZmZpY3VsdCB0aGFuIGp1c3QgdXNpbmcgdGhlIGNoaWxk
IGFjY2VzcyBmdW5jdGlvbnMuICBJbiBmYWN0LCB3ZSBvZnRlbg0KPiBoYXZlIHRvIGRpcmVjdGx5
IHVzZSBicy0+YmFja2luZyBiZWNhdXNlIHRoZXNlIGZ1bmN0aW9ucyBhcmUgYWJvdXQgdGhlDQo+
ICJiYWNraW5nIiBjaGlsZCAod2hpY2ggbWF5IG9yIG1heSBub3QgYmUgdGhlIENPVyBiYWNraW5n
IGZpbGUpLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWF4IFJlaXR6IDxtcmVpdHpAcmVkaGF0LmNv
bT4NCj4gLS0tDQo+ICAgYmxvY2suYyB8IDM2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Jsb2NrLmMgYi9ibG9jay5jDQo+IGluZGV4IDUwNWIz
ZTlhMDEuLmRiMjc1OWMxMGQgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrLmMNCj4gKysrIGIvYmxvY2su
Yw0KPiBAQCAtMzU0MiwxNyArMzU0MiwzOSBAQCBzdGF0aWMgaW50IGJkcnZfcmVvcGVuX3BhcnNl
X2JhY2tpbmcoQkRSVlJlb3BlblN0YXRlICpyZW9wZW5fc3RhdGUsDQo+ICAgICAgICAgICB9DQo+
ICAgICAgIH0NCj4gICANCj4gKyAgICAvKg0KPiArICAgICAqIEVuc3VyZSB0aGF0IEBicyBjYW4g
cmVhbGx5IGhhbmRsZSBiYWNraW5nIGZpbGVzLCBiZWNhdXNlIHdlIGFyZQ0KPiArICAgICAqIGFi
b3V0IHRvIGdpdmUgaXQgb25lIChvciBzd2FwIHRoZSBleGlzdGluZyBvbmUpDQo+ICsgICAgICov
DQo+ICsgICAgaWYgKGJzLT5kcnYtPmlzX2ZpbHRlcikgew0KPiArICAgICAgICAvKiBGaWx0ZXJz
IGFsd2F5cyBoYXZlIGEgZmlsZSBvciBhIGJhY2tpbmcgY2hpbGQgKi8NCj4gKyAgICAgICAgaWYg
KCFicy0+YmFja2luZykgew0KPiArICAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiJyVzJyBp
cyBhICVzIGZpbHRlciBub2RlIHRoYXQgZG9lcyBub3Qgc3VwcG9ydCBhICINCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgImJhY2tpbmcgY2hpbGQiLCBicy0+bm9kZV9uYW1lLCBicy0+ZHJ2LT5m
b3JtYXRfbmFtZSk7DQo+ICsgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gKyAgICAgICAg
fQ0KPiArICAgIH0gZWxzZSBpZiAoIWJzLT5kcnYtPnN1cHBvcnRzX2JhY2tpbmcpIHsNCj4gKyAg
ICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiRHJpdmVyICclcycgb2Ygbm9kZSAnJXMnIGRvZXMgbm90
IHN1cHBvcnQgYmFja2luZyAiDQo+ICsgICAgICAgICAgICAgICAgICAgImZpbGVzIiwgYnMtPmRy
di0+Zm9ybWF0X25hbWUsIGJzLT5ub2RlX25hbWUpOw0KPiArICAgICAgICByZXR1cm4gLUVJTlZB
TDsNCj4gKyAgICB9DQoNCmhtbSwgc2hvdWxkbid0IHdlIGhhdmUgdGhlc2UgY2hlY2tzIGZvciBv
dmVybGF5X2JzPw0KDQo+ICsNCj4gICAgICAgLyoNCj4gICAgICAgICogRmluZCB0aGUgImFjdHVh
bCIgYmFja2luZyBmaWxlIGJ5IHNraXBwaW5nIGFsbCBsaW5rcyB0aGF0IHBvaW50DQo+ICAgICAg
ICAqIHRvIGFuIGltcGxpY2l0IG5vZGUsIGlmIGFueSAoZS5nLiBhIGNvbW1pdCBmaWx0ZXIgbm9k
ZSkuDQo+ICsgICAgICogV2UgY2Fubm90IHVzZSBhbnkgb2YgdGhlIGJkcnZfc2tpcF8qKCkgZnVu
Y3Rpb25zIGhlcmUgYmVjYXVzZQ0KPiArICAgICAqIHRob3NlIHJldHVybiB0aGUgZmlyc3QgZXhw
bGljaXQgbm9kZSwgd2hpbGUgd2UgYXJlIGxvb2tpbmcgZm9yDQo+ICsgICAgICogaXRzIG92ZXJs
YXkgaGVyZS4NCj4gICAgICAgICovDQo+ICAgICAgIG92ZXJsYXlfYnMgPSBiczsNCj4gLSAgICB3
aGlsZSAoYmFja2luZ19icyhvdmVybGF5X2JzKSAmJiBiYWNraW5nX2JzKG92ZXJsYXlfYnMpLT5p
bXBsaWNpdCkgew0KPiAtICAgICAgICBvdmVybGF5X2JzID0gYmFja2luZ19icyhvdmVybGF5X2Jz
KTsNCj4gKyAgICB3aGlsZSAoYmRydl9maWx0ZXJlZF9icyhvdmVybGF5X2JzKSAmJg0KPiArICAg
ICAgICAgICBiZHJ2X2ZpbHRlcmVkX2JzKG92ZXJsYXlfYnMpLT5pbXBsaWNpdCkNCj4gKyAgICB7
DQo+ICsgICAgICAgIG92ZXJsYXlfYnMgPSBiZHJ2X2ZpbHRlcmVkX2JzKG92ZXJsYXlfYnMpOw0K
PiAgICAgICB9DQoNCmhlcmUsIG92ZXJsYXlfYnMgbWF5IGJlIHNvbWUgZmlsdGVyIHdpdGggZmls
ZSBjaGlsZCAuLg0KDQo+ICAgDQo+ICAgICAgIC8qIElmIHdlIHdhbnQgdG8gcmVwbGFjZSB0aGUg
YmFja2luZyBmaWxlIHdlIG5lZWQgc29tZSBleHRyYSBjaGVja3MgKi8NCj4gLSAgICBpZiAobmV3
X2JhY2tpbmdfYnMgIT0gYmFja2luZ19icyhvdmVybGF5X2JzKSkgew0KPiArICAgIGlmIChuZXdf
YmFja2luZ19icyAhPSBiZHJ2X2ZpbHRlcmVkX2JzKG92ZXJsYXlfYnMpKSB7DQo+ICAgICAgICAg
ICAvKiBDaGVjayBmb3IgaW1wbGljaXQgbm9kZXMgYmV0d2VlbiBicyBhbmQgaXRzIGJhY2tpbmcg
ZmlsZSAqLw0KPiAgICAgICAgICAgaWYgKGJzICE9IG92ZXJsYXlfYnMpIHsNCj4gICAgICAgICAg
ICAgICBlcnJvcl9zZXRnKGVycnAsICJDYW5ub3QgY2hhbmdlIGJhY2tpbmcgbGluayBpZiAnJXMn
IGhhcyAiDQo+IEBAIC0zNTYwLDggKzM1ODIsOCBAQCBzdGF0aWMgaW50IGJkcnZfcmVvcGVuX3Bh
cnNlX2JhY2tpbmcoQkRSVlJlb3BlblN0YXRlICpyZW9wZW5fc3RhdGUsDQo+ICAgICAgICAgICAg
ICAgcmV0dXJuIC1FUEVSTTsNCj4gICAgICAgICAgIH0NCj4gICAgICAgICAgIC8qIENoZWNrIGlm
IHRoZSBiYWNraW5nIGxpbmsgdGhhdCB3ZSB3YW50IHRvIHJlcGxhY2UgaXMgZnJvemVuICovDQo+
IC0gICAgICAgIGlmIChiZHJ2X2lzX2JhY2tpbmdfY2hhaW5fZnJvemVuKG92ZXJsYXlfYnMsIGJh
Y2tpbmdfYnMob3ZlcmxheV9icyksDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGVycnApKSB7DQo+ICsgICAgICAgIGlmIChiZHJ2X2lzX2JhY2tpbmdfY2hhaW5f
ZnJvemVuKG92ZXJsYXlfYnMsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGNoaWxkX2JzKG92ZXJsYXlfYnMtPmJhY2tpbmcpLCBlcnJwKSkgew0KDQouLiBhbmQg
aGVyZSB3ZSBhcmUgZG9pbmcgd3JvbmcgdGhpbmcsIGFzIGl0IGRvbid0IGhhdmUgYmFja2luZyBj
aGlsZA0KDQpBaGEsIHlvdSB1c2UgdGhlIGZhY3QgdGhhdCB3ZSBub3cgZG9uJ3QgaGF2ZSBpbXBs
aWNpdCBmaWx0ZXJzIHdpdGggZmlsZSBjaGlsZC4gVGhlbiwgc2hvdWxkDQp3ZSBhZGQgYW4gYXNz
ZXJ0aW9uIGZvciB0aGlzPw0KDQo+ICAgICAgICAgICAgICAgcmV0dXJuIC1FUEVSTTsNCj4gICAg
ICAgICAgIH0NCj4gICAgICAgICAgIHJlb3Blbl9zdGF0ZS0+cmVwbGFjZV9iYWNraW5nX2JzID0g
dHJ1ZTsNCj4gQEAgLTM3MTIsNyArMzczNCw3IEBAIGludCBiZHJ2X3Jlb3Blbl9wcmVwYXJlKEJE
UlZSZW9wZW5TdGF0ZSAqcmVvcGVuX3N0YXRlLCBCbG9ja1Jlb3BlblF1ZXVlICpxdWV1ZSwNCj4g
ICAgICAgICogaXRzIG1ldGFkYXRhLiBPdGhlcndpc2UgdGhlICdiYWNraW5nJyBvcHRpb24gY2Fu
IGJlIG9taXR0ZWQuDQo+ICAgICAgICAqLw0KPiAgICAgICBpZiAoZHJ2LT5zdXBwb3J0c19iYWNr
aW5nICYmIHJlb3Blbl9zdGF0ZS0+YmFja2luZ19taXNzaW5nICYmDQo+IC0gICAgICAgIChiYWNr
aW5nX2JzKHJlb3Blbl9zdGF0ZS0+YnMpIHx8IHJlb3Blbl9zdGF0ZS0+YnMtPmJhY2tpbmdfZmls
ZVswXSkpIHsNCj4gKyAgICAgICAgKHJlb3Blbl9zdGF0ZS0+YnMtPmJhY2tpbmcgfHwgcmVvcGVu
X3N0YXRlLT5icy0+YmFja2luZ19maWxlWzBdKSkgew0KPiAgICAgICAgICAgZXJyb3Jfc2V0Zyhl
cnJwLCAiYmFja2luZyBpcyBtaXNzaW5nIGZvciAnJXMnIiwNCj4gICAgICAgICAgICAgICAgICAg
ICAgcmVvcGVuX3N0YXRlLT5icy0+bm9kZV9uYW1lKTsNCj4gICAgICAgICAgIHJldCA9IC1FSU5W
QUw7DQo+IEBAIC0zODU3LDcgKzM4NzksNyBAQCB2b2lkIGJkcnZfcmVvcGVuX2NvbW1pdChCRFJW
UmVvcGVuU3RhdGUgKnJlb3Blbl9zdGF0ZSkNCj4gICAgICAgICogZnJvbSBiZHJ2X3NldF9iYWNr
aW5nX2hkKCkpIGhhcyB0aGUgbmV3IHZhbHVlcy4NCj4gICAgICAgICovDQo+ICAgICAgIGlmIChy
ZW9wZW5fc3RhdGUtPnJlcGxhY2VfYmFja2luZ19icykgew0KPiAtICAgICAgICBCbG9ja0RyaXZl
clN0YXRlICpvbGRfYmFja2luZ19icyA9IGJhY2tpbmdfYnMoYnMpOw0KPiArICAgICAgICBCbG9j
a0RyaXZlclN0YXRlICpvbGRfYmFja2luZ19icyA9IGNoaWxkX2JzKGJzLT5iYWNraW5nKTsNCj4g
ICAgICAgICAgIGFzc2VydCghb2xkX2JhY2tpbmdfYnMgfHwgIW9sZF9iYWNraW5nX2JzLT5pbXBs
aWNpdCk7DQo+ICAgICAgICAgICAvKiBBYm9ydCB0aGUgcGVybWlzc2lvbiB1cGRhdGUgb24gdGhl
IGJhY2tpbmcgYnMgd2UncmUgZGV0YWNoaW5nICovDQo+ICAgICAgICAgICBpZiAob2xkX2JhY2tp
bmdfYnMpIHsNCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

