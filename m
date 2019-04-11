Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C32C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 17:14:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B92AB20693
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 17:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OL0nBFC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B92AB20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52368 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEdHl-0000JE-Vy
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 13:14:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEdGo-0008Me-DE
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:13:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEdGg-0005OL-Uu
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:13:45 -0400
Received: from mail-eopbgr10101.outbound.protection.outlook.com
	([40.107.1.101]:49203
	helo=EUR02-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hEdGb-0005Kl-Sx; Thu, 11 Apr 2019 13:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=pIontNhzEaSMyx1BF4TUZewZ3XLu17dPK5ruAd+RW+A=;
	b=OL0nBFC4RmkoDV4ccz+EyGcU8BqFdyMaNFYwmhAa+n6DYPhfbWO6mldK23kZoxZ9mhQ4MLGQ40Q+1mNTs8BhJKP428Ow+EuIpFKkoSuq52/Yx2fyzKbTZInQslFrZUwzA4VO7Jip4AbaAZU+V1lHlhHRDR+QRqfNE9bN1LVXxYI=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3004.eurprd08.prod.outlook.com (52.134.109.158) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.19; Thu, 11 Apr 2019 17:13:31 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1771.021;
	Thu, 11 Apr 2019 17:13:31 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [Qemu-devel] [PULL 16/71] nbd: Increase bs->in_flight during
	AioContext switch
Thread-Index: AQHUzR9xRI5FuNnn4EOD4L0Dttict6Y3cGSA///XewCAAAkmAIAAIWSAgAAHG4A=
Date: Thu, 11 Apr 2019 17:13:31 +0000
Message-ID: <2558f6fa-03d5-9483-07ff-7ec0a4d37835@virtuozzo.com>
References: <20190225152053.15976-1-kwolf@redhat.com>
	<20190225152053.15976-17-kwolf@redhat.com>
	<4f9792a1-4702-62d0-cad4-4da1169baa3b@virtuozzo.com>
	<20190411141548.GE5694@linux.fritz.box>
	<1391b876-74ed-21f0-c41f-f2fb22d2eae7@virtuozzo.com>
	<20190411164803.GF5694@linux.fritz.box>
In-Reply-To: <20190411164803.GF5694@linux.fritz.box>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0001.eurprd07.prod.outlook.com
	(2603:10a6:7:67::11) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190411201329013
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa2944e2-f338-40e1-9e29-08d6bea10586
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3004; 
x-ms-traffictypediagnostic: DB7PR08MB3004:
x-microsoft-antispam-prvs: <DB7PR08MB3004E5E85A302F8302727157C12F0@DB7PR08MB3004.eurprd08.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(979002)(396003)(366004)(376002)(136003)(346002)(39850400004)(189003)(199004)(93886005)(6506007)(11346002)(305945005)(229853002)(6486002)(25786009)(6436002)(97736004)(105586002)(14454004)(66066001)(31686004)(478600001)(106356001)(256004)(71200400001)(5660300002)(6246003)(36756003)(53936002)(14444005)(6512007)(386003)(31696002)(8936002)(4326008)(54906003)(52116002)(86362001)(6916009)(71190400001)(81166006)(316002)(2906002)(5024004)(68736007)(446003)(2616005)(486006)(186003)(8676002)(7736002)(26005)(476003)(102836004)(81156014)(99286004)(76176011)(6116002)(3846002)(969003)(989001)(999001)(1009001)(1019001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3004;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: h/r3YRejRSh4GXTmo5sEpQaC6HC7GdXCpahC+srrBl1ryKKP+sJlqmkJHSrscCRtgSbEfopLfokavgcVXsneANWVVLG1eNiA2eL5hbq5elKphWRxcHyKoQMMlfPfJObdua2XmYZwEfrL6lF6Lah++7ghwKoxw6UauoUh6IshIiblTDOu0T86E8CdIm5+xgkZLCJ8MZxaCkNdn+JlZ7yP3s+Ptb3hlHCViPctB/kZxISELQogyYuQ4AV6tA9wMwM+stqY9FEVKTXFYcQT7TUBBvhGwqW74JnyTn0FFbFIrE21zUKoHDuOfNN436fg62KBlmhz80WwzCSUZUDkfxfNmECn9Hk8sEldfKgJ2C6gdWRSVvoR/4xelul29SKCKL3Viw86AXQgeWzFyunuBHKSNYkQ62C0VyRyMNDROjdNE1U=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <085C5C82281A3C44A2B64E3B0040496A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2944e2-f338-40e1-9e29-08d6bea10586
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 17:13:31.4026 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3004
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.101
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
Message-ID: <20190411171331.L8fVijY1QwvKWAg3iCnC-4SGJLPtIyZT6uYAurRbehk@z>

MTEuMDQuMjAxOSAxOTo0OCwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMTEuMDQuMjAxOSB1bSAx
Njo0OCBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IDEx
LjA0LjIwMTkgMTc6MTUsIEtldmluIFdvbGYgd3JvdGU6DQo+Pj4gQW0gMTEuMDQuMjAxOSB1bSAx
NTo0MCBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+Pj4g
MjUuMDIuMjAxOSAxODoxOSwgS2V2aW4gV29sZiB3cm90ZToNCj4+Pj4+IGJkcnZfZHJhaW4oKSBt
dXN0IG5vdCBsZWF2ZSBjb25uZWN0aW9uX2NvIHNjaGVkdWxlZCwgc28gYnMtPmluX2ZsaWdodA0K
Pj4+Pj4gbmVlZHMgdG8gYmUgaW5jcmVhc2VkIHdoaWxlIHRoZSBjb3JvdXRpbmUgaXMgd2FpdGlu
ZyB0byBiZSBzY2hlZHVsZWQNCj4+Pj4+IGluIHRoZSBuZXcgQWlvQ29udGV4dCBhZnRlciBuYmRf
Y2xpZW50X2F0dGFjaF9haW9fY29udGV4dCgpLg0KPj4+Pg0KPj4+PiBIaSENCj4+Pj4NCj4+Pj4g
SSBoYXZlIHNvbWUgcXVlc3Rpb25zLCBjb3VsZCB5b3UgZXhwbGFpbiwgcGxlYXNlPw0KPj4+Pg0K
Pj4+PiAiYmRydl9kcmFpbigpIG11c3Qgbm90IGxlYXZlIGNvbm5lY3Rpb25fY28gc2NoZWR1bGVk
IiAtIGl0J3MgYmVjYXVzZSB3ZSB3YW50IHRvIGJlDQo+Pj4+IHN1cmUgdGhhdCBjb25uZWN0aW9u
X2NvIHlpZWxkZWQgZnJvbSBuYmRfcmVhZF9lb2YsIHllcz8NCj4+Pj4NCj4+Pj4gQnV0IGl0IGlz
IGd1YXJhbnRlZWQgYnkgYWlvX3dhaXRfYmhfb25lc2hvdC4uIFdoeSBkbyB3ZSBuZWVkIGFkZGl0
aW9pbmFsbHkgaW5jL2RlYw0KPj4+PiBicy0+aW5fZmxpZ2h0ID8NCj4+Pg0KPj4+IFdpdGhvdXQg
aW5jcmVtZW50aW5nIGJzLT5pbl9mbGlnaHQsIG5vdGhpbmcgd291bGQgZ3VhcmFudGVlIHRoYXQN
Cj4+PiBhaW9fcG9sbCgpIGlzIGNhbGxlZCBhbmQgdGhlIEJIIGlzIGFjdHVhbGx5IGV4ZWN1dGVk
IGJlZm9yZSBiZHJ2X2RyYWluKCkNCj4+PiByZXR1cm5zLg0KPj4NCj4+IERvbid0IGZvbGxvdy4u
IERvbid0IHdlIHdhbnQgZXhhY3RseSB0aGlzLCB3ZSB3YW50IEJIIHRvIGJlIGV4ZWN1dGVkIHdo
aWxlIG5vZGUgaXMgc3RpbGwNCj4+IGRyYWluZWQsIGFzIHlvdSB3cml0ZSBpbiBjb21tZW50Pw0K
PiANCj4gWWVzLCBleGFjdGx5LiBCdXQgaWYgYnMtPmluX2ZsaWdodCA9PSAwLCB0aGUgQUlPX1dB
SVRfV0hJTEUoKSBjb25kaXRpb24NCj4gaW4gdGhlIGRyYWluIGNvZGUgY291bGQgYmVjb21lIGZh
bHNlLCBzbyBhaW9fcG9sbCgpIHdvdWxkIG5vdCBiZSBjYWxsZWQNCj4gYWdhaW4gYW5kIGRyYWlu
IHdvdWxkIHJldHVybiBldmVuIGlmIHRoZSBCSCBpcyBzdGlsbCBwZW5kaW5nLg0KPiANCg0KQWgs
IG9vcHMsIHNvcnJ5IG15IEVuZ2xpc2gsIEkgcmVhZCBpdCBsaWtlICJub3RoaW5nIHdvdWxkIHBy
ZXZlbnQiLiBVbmRlcnN0YW5kIG5vdywgdGhhbmtzLg0KDQo+Pj4NCj4+Pj4+DQo+Pj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBLZXZpbiBXb2xmIDxrd29sZkByZWRoYXQuY29tPg0KPj4+Pj4gLS0tDQo+Pj4+
PiAgICAgYmxvY2svbmJkLWNsaWVudC5jIHwgMjAgKysrKysrKysrKysrKysrKysrLS0NCj4+Pj4+
ICAgICAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+
Pj4+DQo+Pj4+PiBkaWZmIC0tZ2l0IGEvYmxvY2svbmJkLWNsaWVudC5jIGIvYmxvY2svbmJkLWNs
aWVudC5jDQo+Pj4+PiBpbmRleCA2MGYzOGYwMzIwLi5iZmJhZjdlYmU5IDEwMDY0NA0KPj4+Pj4g
LS0tIGEvYmxvY2svbmJkLWNsaWVudC5jDQo+Pj4+PiArKysgYi9ibG9jay9uYmQtY2xpZW50LmMN
Cj4+Pj4+IEBAIC05NzcsMTQgKzk3NywzMCBAQCB2b2lkIG5iZF9jbGllbnRfZGV0YWNoX2Fpb19j
b250ZXh0KEJsb2NrRHJpdmVyU3RhdGUgKmJzKQ0KPj4+Pj4gICAgICAgICBxaW9fY2hhbm5lbF9k
ZXRhY2hfYWlvX2NvbnRleHQoUUlPX0NIQU5ORUwoY2xpZW50LT5pb2MpKTsNCj4+Pj4+ICAgICB9
DQo+Pj4+PiAgICAgDQo+Pj4+PiArc3RhdGljIHZvaWQgbmJkX2NsaWVudF9hdHRhY2hfYWlvX2Nv
bnRleHRfYmgodm9pZCAqb3BhcXVlKQ0KPj4+Pj4gK3sNCj4+Pj4+ICsgICAgQmxvY2tEcml2ZXJT
dGF0ZSAqYnMgPSBvcGFxdWU7DQo+Pj4+PiArICAgIE5CRENsaWVudFNlc3Npb24gKmNsaWVudCA9
IG5iZF9nZXRfY2xpZW50X3Nlc3Npb24oYnMpOw0KPj4+Pj4gKw0KPj4+Pj4gKyAgICAvKiBUaGUg
bm9kZSBpcyBzdGlsbCBkcmFpbmVkLCBzbyB3ZSBrbm93IHRoZSBjb3JvdXRpbmUgaGFzIHlpZWxk
ZWQgaW4NCj4+Pj4+ICsgICAgICogbmJkX3JlYWRfZW9mKCksIHRoZSBvbmx5IHBsYWNlIHdoZXJl
IGJzLT5pbl9mbGlnaHQgY2FuIHJlYWNoIDAsIG9yIGl0IGlzDQo+Pj4+PiArICAgICAqIGVudGVy
ZWQgZm9yIHRoZSBmaXJzdCB0aW1lLiBCb3RoIHBsYWNlcyBhcmUgc2FmZSBmb3IgZW50ZXJpbmcg
dGhlDQo+Pj4+PiArICAgICAqIGNvcm91dGluZS4qLw0KPj4+Pj4gKyAgICBxZW11X2Fpb19jb3Jv
dXRpbmVfZW50ZXIoYnMtPmFpb19jb250ZXh0LCBjbGllbnQtPmNvbm5lY3Rpb25fY28pOw0KPj4+
Pj4gKyAgICBiZHJ2X2RlY19pbl9mbGlnaHQoYnMpOw0KPj4+Pj4gK30NCj4+Pj4+ICsNCj4+Pj4+
ICAgICB2b2lkIG5iZF9jbGllbnRfYXR0YWNoX2Fpb19jb250ZXh0KEJsb2NrRHJpdmVyU3RhdGUg
KmJzLA0KPj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQWlvQ29u
dGV4dCAqbmV3X2NvbnRleHQpDQo+Pj4+PiAgICAgew0KPj4+Pj4gICAgICAgICBOQkRDbGllbnRT
ZXNzaW9uICpjbGllbnQgPSBuYmRfZ2V0X2NsaWVudF9zZXNzaW9uKGJzKTsNCj4+Pj4+ICAgICAg
ICAgcWlvX2NoYW5uZWxfYXR0YWNoX2Fpb19jb250ZXh0KFFJT19DSEFOTkVMKGNsaWVudC0+aW9j
KSwgbmV3X2NvbnRleHQpOw0KPj4+Pj4gICAgIA0KPj4+Pj4gLSAgICAvKiBGSVhNRSBSZWFsbHkg
bmVlZCBhIGJkcnZfaW5jX2luX2ZsaWdodCgpIGhlcmUgKi8NCj4+Pj4+IC0gICAgYWlvX2NvX3Nj
aGVkdWxlKG5ld19jb250ZXh0LCBjbGllbnQtPmNvbm5lY3Rpb25fY28pOw0KPj4+Pj4gKyAgICBi
ZHJ2X2luY19pbl9mbGlnaHQoYnMpOw0KPj4+Pj4gKw0KPj4+Pj4gKyAgICAvKiBOZWVkIHRvIHdh
aXQgaGVyZSBmb3IgdGhlIEJIIHRvIHJ1biBiZWNhdXNlIHRoZSBCSCBtdXN0IHJ1biB3aGlsZSB0
aGUNCj4+Pj4+ICsgICAgICogbm9kZSBpcyBzdGlsbCBkcmFpbmVkLiAqLw0KPj4+Pj4gKyAgICBh
aW9fd2FpdF9iaF9vbmVzaG90KG5ld19jb250ZXh0LCBuYmRfY2xpZW50X2F0dGFjaF9haW9fY29u
dGV4dF9iaCwgYnMpOw0KPj4+Pj4gICAgIH0NCj4+Pj4+ICAgICANCj4+Pj4+ICAgICB2b2lkIG5i
ZF9jbGllbnRfY2xvc2UoQmxvY2tEcml2ZXJTdGF0ZSAqYnMpDQo+Pj4+Pg0KPj4+Pg0KPj4+Pg0K
Pj4+PiAtLSANCj4+Pj4gQmVzdCByZWdhcmRzLA0KPj4+PiBWbGFkaW1pcg0KPj4NCj4+DQo+PiAt
LSANCj4+IEJlc3QgcmVnYXJkcywNCj4+IFZsYWRpbWlyDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMs
DQpWbGFkaW1pcg0K

