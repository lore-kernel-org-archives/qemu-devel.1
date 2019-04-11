Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038C5C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 17:21:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA1D820693
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 17:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ht4KLoom"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1D820693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52477 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEdOT-00037Q-P0
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 13:21:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEdNI-0002Ee-EF
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:20:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEdNH-0000tK-8S
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:20:32 -0400
Received: from mail-vi1eur04on0726.outbound.protection.outlook.com
	([2a01:111:f400:fe0e::726]:59365
	helo=EUR04-VI1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hEdNG-0000sJ-V2; Thu, 11 Apr 2019 13:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=wBNz5xU+QeYvng8qeg0VLUTnIh6vSCV7WZGNxVo4nu4=;
	b=ht4KLoomrisp2QE2CMBJEZvkAhTXkzMUmMXvyHsCfNJVBUbnUp7IYh2wZRA/3t5ONVhmqGTyGW1PKqk0Y5oYYAB7TMyrmcD++cQPSj2BPFyqyxiMcMBeB7iyIzPHbkDnB1859mJLkcR8vv6slfOe/ojslSQzN3JUt5zNLuiV6X4=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3180.eurprd08.prod.outlook.com (52.134.110.154) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.18; Thu, 11 Apr 2019 17:20:27 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1771.021;
	Thu, 11 Apr 2019 17:20:26 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [Qemu-devel] [PULL 16/71] nbd: Increase bs->in_flight during
	AioContext switch
Thread-Index: AQHUzR9xRI5FuNnn4EOD4L0Dttict6Y3cGSA///XewCAAAkmAIAAIWSAgAA5ZoD//8+kAA==
Date: Thu, 11 Apr 2019 17:20:26 +0000
Message-ID: <0b088cc0-6ea9-297d-6989-2d61e1c25075@virtuozzo.com>
References: <20190225152053.15976-1-kwolf@redhat.com>
	<20190225152053.15976-17-kwolf@redhat.com>
	<4f9792a1-4702-62d0-cad4-4da1169baa3b@virtuozzo.com>
	<20190411141548.GE5694@linux.fritz.box>
	<1391b876-74ed-21f0-c41f-f2fb22d2eae7@virtuozzo.com>
	<20190411164803.GF5694@linux.fritz.box>
	<2558f6fa-03d5-9483-07ff-7ec0a4d37835@virtuozzo.com>
In-Reply-To: <2558f6fa-03d5-9483-07ff-7ec0a4d37835@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0060.eurprd01.prod.exchangelabs.com
	(2603:10a6:7:7d::37) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190411202024102
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b405a4c9-d455-4cc6-6331-08d6bea1fd29
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3180; 
x-ms-traffictypediagnostic: DB7PR08MB3180:
x-microsoft-antispam-prvs: <DB7PR08MB31807246FAC726DBE3C96F00C12F0@DB7PR08MB3180.eurprd08.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39850400004)(366004)(396003)(346002)(376002)(136003)(199004)(189003)(76176011)(52116002)(99286004)(305945005)(71200400001)(6246003)(53936002)(105586002)(54906003)(8676002)(7736002)(71190400001)(81156014)(86362001)(93886005)(97736004)(8936002)(36756003)(316002)(31696002)(4326008)(5660300002)(2906002)(81166006)(6512007)(68736007)(6506007)(6436002)(486006)(5024004)(31686004)(446003)(2616005)(6916009)(66066001)(3846002)(229853002)(26005)(386003)(476003)(6486002)(106356001)(6116002)(11346002)(478600001)(102836004)(25786009)(186003)(256004)(14444005)(14454004);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3180;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xPDcEm4XIuW5AW1a6lGaNHcOP70sILk5Hpyz8Ww5hcs+U14yIZxae7wQ2uD4Y/NGlWD1TC4cVGclBlOzM+a5cc4TDpbXvNP29CS5PT6PI4/97lQQbKSRtHgJk2TVjl8urK4TleOcxgavB/faTyxV1jcXiiN8dIqRTCwXbVtSX4Zor+WVL6NcC6Ubv5il91gJCPPV1rOxzgKWKs17fPvQB3UBqnZbzoLBas0WhzcBDAb2Mes6V8LCaxlEkkLLvHvZ5k/hAF+JsHcDuShB4GZeNqX1UIm/EV+bihyI+sNyH1FnuuN/AuFCkgZ1+bIxC/tscJyuVKasDGKoXUlbs+ED0Jr22T/EgL2K6wISu0o/7aWb37zab2tc1LcUFYUx0WiYHC+OWmnjmgHg6aK0cy2f8gDSfI6ZvjbvHl3UtGnrhZo=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <80EE4C91104FE04E81650F9AE3887801@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b405a4c9-d455-4cc6-6331-08d6bea1fd29
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 17:20:26.8015 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3180
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0e::726
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411172026.49fpxdTw6_sEGVHYVNy-pizXosqtpZDHNjojKpXGO9E@z>

MTEuMDQuMjAxOSAyMDoxMywgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MTEuMDQuMjAxOSAxOTo0OCwgS2V2aW4gV29sZiB3cm90ZToNCj4+IEFtIDExLjA0LjIwMTkgdW0g
MTY6NDggaGF0IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgZ2VzY2hyaWViZW46DQo+Pj4g
MTEuMDQuMjAxOSAxNzoxNSwgS2V2aW4gV29sZiB3cm90ZToNCj4+Pj4gQW0gMTEuMDQuMjAxOSB1
bSAxNTo0MCBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+
Pj4+IDI1LjAyLjIwMTkgMTg6MTksIEtldmluIFdvbGYgd3JvdGU6DQo+Pj4+Pj4gYmRydl9kcmFp
bigpIG11c3Qgbm90IGxlYXZlIGNvbm5lY3Rpb25fY28gc2NoZWR1bGVkLCBzbyBicy0+aW5fZmxp
Z2h0DQo+Pj4+Pj4gbmVlZHMgdG8gYmUgaW5jcmVhc2VkIHdoaWxlIHRoZSBjb3JvdXRpbmUgaXMg
d2FpdGluZyB0byBiZSBzY2hlZHVsZWQNCj4+Pj4+PiBpbiB0aGUgbmV3IEFpb0NvbnRleHQgYWZ0
ZXIgbmJkX2NsaWVudF9hdHRhY2hfYWlvX2NvbnRleHQoKS4NCj4+Pj4+DQo+Pj4+PiBIaSENCj4+
Pj4+DQo+Pj4+PiBJIGhhdmUgc29tZSBxdWVzdGlvbnMsIGNvdWxkIHlvdSBleHBsYWluLCBwbGVh
c2U/DQo+Pj4+Pg0KPj4+Pj4gImJkcnZfZHJhaW4oKSBtdXN0IG5vdCBsZWF2ZSBjb25uZWN0aW9u
X2NvIHNjaGVkdWxlZCIgLSBpdCdzIGJlY2F1c2Ugd2Ugd2FudCB0byBiZQ0KPj4+Pj4gc3VyZSB0
aGF0IGNvbm5lY3Rpb25fY28geWllbGRlZCBmcm9tIG5iZF9yZWFkX2VvZiwgeWVzPw0KPj4+Pj4N
Cj4+Pj4+IEJ1dCBpdCBpcyBndWFyYW50ZWVkIGJ5IGFpb193YWl0X2JoX29uZXNob3QuLiBXaHkg
ZG8gd2UgbmVlZCBhZGRpdGlvaW5hbGx5IGluYy9kZWMNCj4+Pj4+IGJzLT5pbl9mbGlnaHQgPw0K
Pj4+Pg0KPj4+PiBXaXRob3V0IGluY3JlbWVudGluZyBicy0+aW5fZmxpZ2h0LCBub3RoaW5nIHdv
dWxkIGd1YXJhbnRlZSB0aGF0DQo+Pj4+IGFpb19wb2xsKCkgaXMgY2FsbGVkIGFuZCB0aGUgQkgg
aXMgYWN0dWFsbHkgZXhlY3V0ZWQgYmVmb3JlIGJkcnZfZHJhaW4oKQ0KPj4+PiByZXR1cm5zLg0K
Pj4+DQo+Pj4gRG9uJ3QgZm9sbG93Li4gRG9uJ3Qgd2Ugd2FudCBleGFjdGx5IHRoaXMsIHdlIHdh
bnQgQkggdG8gYmUgZXhlY3V0ZWQgd2hpbGUgbm9kZSBpcyBzdGlsbA0KPj4+IGRyYWluZWQsIGFz
IHlvdSB3cml0ZSBpbiBjb21tZW50Pw0KPj4NCj4+IFllcywgZXhhY3RseS4gQnV0IGlmIGJzLT5p
bl9mbGlnaHQgPT0gMCwgdGhlIEFJT19XQUlUX1dISUxFKCkgY29uZGl0aW9uDQo+PiBpbiB0aGUg
ZHJhaW4gY29kZSBjb3VsZCBiZWNvbWUgZmFsc2UsIHNvIGFpb19wb2xsKCkgd291bGQgbm90IGJl
IGNhbGxlZA0KPj4gYWdhaW4gYW5kIGRyYWluIHdvdWxkIHJldHVybiBldmVuIGlmIHRoZSBCSCBp
cyBzdGlsbCBwZW5kaW5nLg0KPj4NCj4gDQo+IEFoLCBvb3BzLCBzb3JyeSBteSBFbmdsaXNoLCBJ
IHJlYWQgaXQgbGlrZSAibm90aGluZyB3b3VsZCBwcmV2ZW50Ii4gVW5kZXJzdGFuZCBub3csIHRo
YW5rcy4NCg0KT3Igbm90IGFnYWluLi4gV2Ugd2lsbCBub3QgcmV0dXJuIHRvIGRyYWluIGNvZGUs
IGFzIHdlIHdpbGwgbG9vcCBpbiBhaW9fd2FpdF9iaF9vbmVzaG90LA0Kd2hpY2ggd2lsbCBub3Qg
cmV0dXJuIHVudGlsIEJIIGhhbmRsZWQNCg0KPiANCj4+Pj4NCj4+Pj4+Pg0KPj4+Pj4+IFNpZ25l
ZC1vZmYtYnk6IEtldmluIFdvbGYgPGt3b2xmQHJlZGhhdC5jb20+DQo+Pj4+Pj4gLS0tDQo+Pj4+
Pj4gwqDCoMKgIGJsb2NrL25iZC1jbGllbnQuYyB8IDIwICsrKysrKysrKysrKysrKysrKy0tDQo+
Pj4+Pj4gwqDCoMKgIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQ0KPj4+Pj4+DQo+Pj4+Pj4gZGlmZiAtLWdpdCBhL2Jsb2NrL25iZC1jbGllbnQuYyBiL2Js
b2NrL25iZC1jbGllbnQuYw0KPj4+Pj4+IGluZGV4IDYwZjM4ZjAzMjAuLmJmYmFmN2ViZTkgMTAw
NjQ0DQo+Pj4+Pj4gLS0tIGEvYmxvY2svbmJkLWNsaWVudC5jDQo+Pj4+Pj4gKysrIGIvYmxvY2sv
bmJkLWNsaWVudC5jDQo+Pj4+Pj4gQEAgLTk3NywxNCArOTc3LDMwIEBAIHZvaWQgbmJkX2NsaWVu
dF9kZXRhY2hfYWlvX2NvbnRleHQoQmxvY2tEcml2ZXJTdGF0ZSAqYnMpDQo+Pj4+Pj4gwqDCoMKg
wqDCoMKgwqAgcWlvX2NoYW5uZWxfZGV0YWNoX2Fpb19jb250ZXh0KFFJT19DSEFOTkVMKGNsaWVu
dC0+aW9jKSk7DQo+Pj4+Pj4gwqDCoMKgIH0NCj4+Pj4+PiArc3RhdGljIHZvaWQgbmJkX2NsaWVu
dF9hdHRhY2hfYWlvX2NvbnRleHRfYmgodm9pZCAqb3BhcXVlKQ0KPj4+Pj4+ICt7DQo+Pj4+Pj4g
K8KgwqDCoCBCbG9ja0RyaXZlclN0YXRlICpicyA9IG9wYXF1ZTsNCj4+Pj4+PiArwqDCoMKgIE5C
RENsaWVudFNlc3Npb24gKmNsaWVudCA9IG5iZF9nZXRfY2xpZW50X3Nlc3Npb24oYnMpOw0KPj4+
Pj4+ICsNCj4+Pj4+PiArwqDCoMKgIC8qIFRoZSBub2RlIGlzIHN0aWxsIGRyYWluZWQsIHNvIHdl
IGtub3cgdGhlIGNvcm91dGluZSBoYXMgeWllbGRlZCBpbg0KPj4+Pj4+ICvCoMKgwqDCoCAqIG5i
ZF9yZWFkX2VvZigpLCB0aGUgb25seSBwbGFjZSB3aGVyZSBicy0+aW5fZmxpZ2h0IGNhbiByZWFj
aCAwLCBvciBpdCBpcw0KPj4+Pj4+ICvCoMKgwqDCoCAqIGVudGVyZWQgZm9yIHRoZSBmaXJzdCB0
aW1lLiBCb3RoIHBsYWNlcyBhcmUgc2FmZSBmb3IgZW50ZXJpbmcgdGhlDQo+Pj4+Pj4gK8KgwqDC
oMKgICogY29yb3V0aW5lLiovDQo+Pj4+Pj4gK8KgwqDCoCBxZW11X2Fpb19jb3JvdXRpbmVfZW50
ZXIoYnMtPmFpb19jb250ZXh0LCBjbGllbnQtPmNvbm5lY3Rpb25fY28pOw0KPj4+Pj4+ICvCoMKg
wqAgYmRydl9kZWNfaW5fZmxpZ2h0KGJzKTsNCj4+Pj4+PiArfQ0KPj4+Pj4+ICsNCj4+Pj4+PiDC
oMKgwqAgdm9pZCBuYmRfY2xpZW50X2F0dGFjaF9haW9fY29udGV4dChCbG9ja0RyaXZlclN0YXRl
ICpicywNCj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEFpb0NvbnRleHQgKm5ld19jb250ZXh0
KQ0KPj4+Pj4+IMKgwqDCoCB7DQo+Pj4+Pj4gwqDCoMKgwqDCoMKgwqAgTkJEQ2xpZW50U2Vzc2lv
biAqY2xpZW50ID0gbmJkX2dldF9jbGllbnRfc2Vzc2lvbihicyk7DQo+Pj4+Pj4gwqDCoMKgwqDC
oMKgwqAgcWlvX2NoYW5uZWxfYXR0YWNoX2Fpb19jb250ZXh0KFFJT19DSEFOTkVMKGNsaWVudC0+
aW9jKSwgbmV3X2NvbnRleHQpOw0KPj4+Pj4+IC3CoMKgwqAgLyogRklYTUUgUmVhbGx5IG5lZWQg
YSBiZHJ2X2luY19pbl9mbGlnaHQoKSBoZXJlICovDQo+Pj4+Pj4gLcKgwqDCoCBhaW9fY29fc2No
ZWR1bGUobmV3X2NvbnRleHQsIGNsaWVudC0+Y29ubmVjdGlvbl9jbyk7DQo+Pj4+Pj4gK8KgwqDC
oCBiZHJ2X2luY19pbl9mbGlnaHQoYnMpOw0KPj4+Pj4+ICsNCj4+Pj4+PiArwqDCoMKgIC8qIE5l
ZWQgdG8gd2FpdCBoZXJlIGZvciB0aGUgQkggdG8gcnVuIGJlY2F1c2UgdGhlIEJIIG11c3QgcnVu
IHdoaWxlIHRoZQ0KPj4+Pj4+ICvCoMKgwqDCoCAqIG5vZGUgaXMgc3RpbGwgZHJhaW5lZC4gKi8N
Cj4+Pj4+PiArwqDCoMKgIGFpb193YWl0X2JoX29uZXNob3QobmV3X2NvbnRleHQsIG5iZF9jbGll
bnRfYXR0YWNoX2Fpb19jb250ZXh0X2JoLCBicyk7DQo+Pj4+Pj4gwqDCoMKgIH0NCj4+Pj4+PiDC
oMKgwqAgdm9pZCBuYmRfY2xpZW50X2Nsb3NlKEJsb2NrRHJpdmVyU3RhdGUgKmJzKQ0KPj4+Pj4+
DQo+Pj4+Pg0KPj4+Pj4NCj4+Pj4+IC0tIA0KPj4+Pj4gQmVzdCByZWdhcmRzLA0KPj4+Pj4gVmxh
ZGltaXINCj4+Pg0KPj4+DQo+Pj4gLS0gDQo+Pj4gQmVzdCByZWdhcmRzLA0KPj4+IFZsYWRpbWly
DQo+IA0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

