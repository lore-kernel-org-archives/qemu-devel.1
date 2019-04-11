Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5288C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 13:42:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AE872133D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 13:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UTfwCoIU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE872133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49122 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEZy9-0004ZH-4Z
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 09:42:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEZx7-00048S-9W
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 09:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEZx6-0001C6-1K
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 09:41:17 -0400
Received: from mail-eopbgr10110.outbound.protection.outlook.com
	([40.107.1.110]:54178
	helo=EUR02-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hEZx4-0000q8-Fj; Thu, 11 Apr 2019 09:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=1lbsoM5m7SSln+SIP++8X5H2RR2Fh+Ne9NwRutyYPck=;
	b=UTfwCoIUvWgd9sLZxF9eG50TQNlHzaDT9aN9x3V1SoCClmJLSfWgqCyL9Yv8+FbinZRLGe3NWOGasgo998Tc+syJK5Gos72ski5clNHG2yxNTII0od2J63ETWmKG+UT4YnQOM0/mEOdBA5uxgrW9bTCjRSiw11U+sqxsUpAxFC8=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3179.eurprd08.prod.outlook.com (52.134.110.153) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.16; Thu, 11 Apr 2019 13:40:52 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1771.021;
	Thu, 11 Apr 2019 13:40:51 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PULL 16/71] nbd: Increase bs->in_flight during
	AioContext switch
Thread-Index: AQHUzR9xRI5FuNnn4EOD4L0Dttict6Y3PhmA
Date: Thu, 11 Apr 2019 13:40:51 +0000
Message-ID: <4f9792a1-4702-62d0-cad4-4da1169baa3b@virtuozzo.com>
References: <20190225152053.15976-1-kwolf@redhat.com>
	<20190225152053.15976-17-kwolf@redhat.com>
In-Reply-To: <20190225152053.15976-17-kwolf@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0083.eurprd09.prod.outlook.com
	(2603:10a6:7:3d::27) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190411164049182
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2e764e7-8bba-4b85-a321-08d6be835037
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3179; 
x-ms-traffictypediagnostic: DB7PR08MB3179:
x-microsoft-antispam-prvs: <DB7PR08MB31792D03CDA494BA613ADE4CC12F0@DB7PR08MB3179.eurprd08.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39850400004)(136003)(396003)(376002)(366004)(346002)(189003)(199004)(25786009)(105586002)(99286004)(6512007)(26005)(5660300002)(186003)(2501003)(14454004)(106356001)(11346002)(446003)(52116002)(6246003)(86362001)(3846002)(7736002)(476003)(6116002)(4326008)(53936002)(68736007)(305945005)(97736004)(6486002)(31686004)(2616005)(486006)(8936002)(76176011)(256004)(71200400001)(66066001)(14444005)(31696002)(36756003)(229853002)(8676002)(386003)(478600001)(6436002)(81156014)(6506007)(81166006)(110136005)(316002)(71190400001)(102836004)(5024004)(2906002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3179;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xe70+kG4J/41kk5joUwwUXPQzzy1oSW+YN79LffEw/QGF4XdfKKBNIoVhJT8TS5ooEtV5gsz9FqeCYdV+6bTtqgrZ1oQB7LrKzFEeCUtlrHDua0QzymeNkeXo09EeYQVhDKXvTL8vJzTn6WvEkadoQWuHb8CYtJxZUS6C3W47BrF7RVSAml+i16c6PBgJwiGLBd3oM/gS4GffWNCRKXLdyPBLQEdaQP5ZgVpUaZrkOGA6PE4O8xzFbudeGyzdBxJGvPa50h/shTHclXkAP8gbEPJgqzTZ4CJx+PlM4uR5PRp21nI34z5w1JXXhosF0zoZC/BtBeHJwEzPTnM6tKLUYGOF7ld7htkJ55juzPbIKZZMDByqHEkYkexBnbGlS3ngBd8DPP0heDy0fffnvkGEEkdQnP9VMqBS7MMXgM3/vA=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <49E7C8C8465B9949B978BAF007E59A4D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e764e7-8bba-4b85-a321-08d6be835037
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 13:40:51.7452 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3179
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.110
Subject: Re: [Qemu-devel] [PULL 16/71] nbd: Increase bs->in_flight during
 AioContext switch
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411134051.gIG_X6sln06rDQDGJCdFfSLLg7cNJhpQYIyQE9O4zLA@z>

MjUuMDIuMjAxOSAxODoxOSwgS2V2aW4gV29sZiB3cm90ZToNCj4gYmRydl9kcmFpbigpIG11c3Qg
bm90IGxlYXZlIGNvbm5lY3Rpb25fY28gc2NoZWR1bGVkLCBzbyBicy0+aW5fZmxpZ2h0DQo+IG5l
ZWRzIHRvIGJlIGluY3JlYXNlZCB3aGlsZSB0aGUgY29yb3V0aW5lIGlzIHdhaXRpbmcgdG8gYmUg
c2NoZWR1bGVkDQo+IGluIHRoZSBuZXcgQWlvQ29udGV4dCBhZnRlciBuYmRfY2xpZW50X2F0dGFj
aF9haW9fY29udGV4dCgpLg0KDQpIaSENCg0KSSBoYXZlIHNvbWUgcXVlc3Rpb25zLCBjb3VsZCB5
b3UgZXhwbGFpbiwgcGxlYXNlPw0KDQoiYmRydl9kcmFpbigpIG11c3Qgbm90IGxlYXZlIGNvbm5l
Y3Rpb25fY28gc2NoZWR1bGVkIiAtIGl0J3MgYmVjYXVzZSB3ZSB3YW50IHRvIGJlDQpzdXJlIHRo
YXQgY29ubmVjdGlvbl9jbyB5aWVsZGVkIGZyb20gbmJkX3JlYWRfZW9mLCB5ZXM/DQoNCkJ1dCBp
dCBpcyBndWFyYW50ZWVkIGJ5IGFpb193YWl0X2JoX29uZXNob3QuLiBXaHkgZG8gd2UgbmVlZCBh
ZGRpdGlvaW5hbGx5IGluYy9kZWMNCmJzLT5pbl9mbGlnaHQgPw0KDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBLZXZpbiBXb2xmIDxrd29sZkByZWRoYXQuY29tPg0KPiAtLS0NCj4gICBibG9jay9uYmQt
Y2xpZW50LmMgfCAyMCArKysrKysrKysrKysrKysrKystLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAx
OCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Jsb2Nr
L25iZC1jbGllbnQuYyBiL2Jsb2NrL25iZC1jbGllbnQuYw0KPiBpbmRleCA2MGYzOGYwMzIwLi5i
ZmJhZjdlYmU5IDEwMDY0NA0KPiAtLS0gYS9ibG9jay9uYmQtY2xpZW50LmMNCj4gKysrIGIvYmxv
Y2svbmJkLWNsaWVudC5jDQo+IEBAIC05NzcsMTQgKzk3NywzMCBAQCB2b2lkIG5iZF9jbGllbnRf
ZGV0YWNoX2Fpb19jb250ZXh0KEJsb2NrRHJpdmVyU3RhdGUgKmJzKQ0KPiAgICAgICBxaW9fY2hh
bm5lbF9kZXRhY2hfYWlvX2NvbnRleHQoUUlPX0NIQU5ORUwoY2xpZW50LT5pb2MpKTsNCj4gICB9
DQo+ICAgDQo+ICtzdGF0aWMgdm9pZCBuYmRfY2xpZW50X2F0dGFjaF9haW9fY29udGV4dF9iaCh2
b2lkICpvcGFxdWUpDQo+ICt7DQo+ICsgICAgQmxvY2tEcml2ZXJTdGF0ZSAqYnMgPSBvcGFxdWU7
DQo+ICsgICAgTkJEQ2xpZW50U2Vzc2lvbiAqY2xpZW50ID0gbmJkX2dldF9jbGllbnRfc2Vzc2lv
bihicyk7DQo+ICsNCj4gKyAgICAvKiBUaGUgbm9kZSBpcyBzdGlsbCBkcmFpbmVkLCBzbyB3ZSBr
bm93IHRoZSBjb3JvdXRpbmUgaGFzIHlpZWxkZWQgaW4NCj4gKyAgICAgKiBuYmRfcmVhZF9lb2Yo
KSwgdGhlIG9ubHkgcGxhY2Ugd2hlcmUgYnMtPmluX2ZsaWdodCBjYW4gcmVhY2ggMCwgb3IgaXQg
aXMNCj4gKyAgICAgKiBlbnRlcmVkIGZvciB0aGUgZmlyc3QgdGltZS4gQm90aCBwbGFjZXMgYXJl
IHNhZmUgZm9yIGVudGVyaW5nIHRoZQ0KPiArICAgICAqIGNvcm91dGluZS4qLw0KPiArICAgIHFl
bXVfYWlvX2Nvcm91dGluZV9lbnRlcihicy0+YWlvX2NvbnRleHQsIGNsaWVudC0+Y29ubmVjdGlv
bl9jbyk7DQo+ICsgICAgYmRydl9kZWNfaW5fZmxpZ2h0KGJzKTsNCj4gK30NCj4gKw0KPiAgIHZv
aWQgbmJkX2NsaWVudF9hdHRhY2hfYWlvX2NvbnRleHQoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBBaW9Db250ZXh0ICpuZXdfY29u
dGV4dCkNCj4gICB7DQo+ICAgICAgIE5CRENsaWVudFNlc3Npb24gKmNsaWVudCA9IG5iZF9nZXRf
Y2xpZW50X3Nlc3Npb24oYnMpOw0KPiAgICAgICBxaW9fY2hhbm5lbF9hdHRhY2hfYWlvX2NvbnRl
eHQoUUlPX0NIQU5ORUwoY2xpZW50LT5pb2MpLCBuZXdfY29udGV4dCk7DQo+ICAgDQo+IC0gICAg
LyogRklYTUUgUmVhbGx5IG5lZWQgYSBiZHJ2X2luY19pbl9mbGlnaHQoKSBoZXJlICovDQo+IC0g
ICAgYWlvX2NvX3NjaGVkdWxlKG5ld19jb250ZXh0LCBjbGllbnQtPmNvbm5lY3Rpb25fY28pOw0K
PiArICAgIGJkcnZfaW5jX2luX2ZsaWdodChicyk7DQo+ICsNCj4gKyAgICAvKiBOZWVkIHRvIHdh
aXQgaGVyZSBmb3IgdGhlIEJIIHRvIHJ1biBiZWNhdXNlIHRoZSBCSCBtdXN0IHJ1biB3aGlsZSB0
aGUNCj4gKyAgICAgKiBub2RlIGlzIHN0aWxsIGRyYWluZWQuICovDQo+ICsgICAgYWlvX3dhaXRf
Ymhfb25lc2hvdChuZXdfY29udGV4dCwgbmJkX2NsaWVudF9hdHRhY2hfYWlvX2NvbnRleHRfYmgs
IGJzKTsNCj4gICB9DQo+ICAgDQo+ICAgdm9pZCBuYmRfY2xpZW50X2Nsb3NlKEJsb2NrRHJpdmVy
U3RhdGUgKmJzKQ0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

