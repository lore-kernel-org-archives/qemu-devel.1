Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4652BC28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 11:45:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 043FE21019
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 11:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YxTPt2j/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 043FE21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52255 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVx13-00060r-B0
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 07:45:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hVx0H-0005ce-Ef
	for qemu-devel@nongnu.org; Wed, 29 May 2019 07:44:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hVx0G-00050e-A1
	for qemu-devel@nongnu.org; Wed, 29 May 2019 07:44:21 -0400
Received: from mail-eopbgr50093.outbound.protection.outlook.com
	([40.107.5.93]:51845
	helo=EUR03-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hVx0A-0004pF-AZ; Wed, 29 May 2019 07:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=iGOJ4pkWDH9lpBmn7uwRp6uNvoSQz8GKLwURsP2XFQ4=;
	b=YxTPt2j/xk8QFuqW/D39bcqjvITH+VPnGFG6mo9R4rQ3D6hF9PHJ+K32kOekQJDuNiF1oklW1En0v4yzxO9IzNQVjGVM8WSQ+WVSj1AGqMlPc+Cmt6N+Q9LJh0F9PR5+fkZ9u/9Xbl5c7AfwNlokyrjljvvp3fzcz3AxWl9M0dY=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
	AM0PR08MB3187.eurprd08.prod.outlook.com (52.134.92.149) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1922.18; Wed, 29 May 2019 11:44:07 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::9499:ef6a:95e:a3c6]) by AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::9499:ef6a:95e:a3c6%4]) with mapi id 15.20.1922.021;
	Wed, 29 May 2019 11:44:07 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v6 3/3] block/stream: introduce a bottom node
Thread-Index: AQHVBCE9xsQwL5Xm6Ui8YJ6AfY9Z7qaA7sSAgAEdSgCAAA2dAIAABbQA
Date: Wed, 29 May 2019 11:44:07 +0000
Message-ID: <2a950448-96b1-e48a-684f-3c8e1bdfecf1@virtuozzo.com>
References: <20190506153429.52737-1-vsementsov@virtuozzo.com>
	<20190506153429.52737-4-vsementsov@virtuozzo.com>
	<ee950bac-f0d8-3bc9-f5ed-deaf4d36777b@redhat.com>
	<5a18f815-ed81-fd58-5f48-9ffe944f0ea4@virtuozzo.com>
	<3f1e1a61-41ba-cbd9-4dce-8516227336d5@redhat.com>
In-Reply-To: <3f1e1a61-41ba-cbd9-4dce-8516227336d5@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0301CA0004.eurprd03.prod.outlook.com
	(2603:10a6:3:76::14) To AM0PR08MB2961.eurprd08.prod.outlook.com
	(2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190529144404889
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98b3c689-3c53-4746-a477-08d6e42af522
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
	SRVR:AM0PR08MB3187; 
x-ms-traffictypediagnostic: AM0PR08MB3187:
x-microsoft-antispam-prvs: <AM0PR08MB3187231F10F6A65822A33E65C11F0@AM0PR08MB3187.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(346002)(366004)(136003)(39850400004)(396003)(199004)(189003)(53546011)(4326008)(386003)(76176011)(6506007)(476003)(2616005)(102836004)(2501003)(81156014)(81166006)(31686004)(7416002)(99286004)(36756003)(71200400001)(5660300002)(6246003)(256004)(8676002)(71190400001)(25786009)(8936002)(2201001)(31696002)(316002)(110136005)(53936002)(54906003)(52116002)(86362001)(66066001)(73956011)(68736007)(66446008)(64756008)(66556008)(66476007)(26005)(186003)(229853002)(6486002)(2906002)(3846002)(6116002)(11346002)(446003)(486006)(14454004)(66946007)(305945005)(6436002)(7736002)(6512007)(478600001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3187;
	H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7ayDQwcP99QRxWG+3IfmqWNf61/goLiM/t7gJdC0ez5wW21UZwbLRt04q4142glnSj4b8yUnpYRBFv3Jms804egHEhw91+g+cVPZlOPtDlfldEKKjz6dF3SxUuZMo6R3IyoWibr5PaVVVSornzYjYtjOSR2fGwr5dc2wlK4zO9PKtKTQNBMJla/TVgtOZA+dF/5N4iFgSbP72K7yACAmAVNmYXncqyTrRiZqcRbRPADxX1fHMcxYH9A23suadlYQ1SPpDUYXCsJoEEcLRU8/jvzqPc36J6fg15YU64GoNwzDIzD4WvJ7Ltn2bZkXrBq380LN9RBx0kI+Y+Vp4nheu/clecYolLQsHVVQCzLbObCt10XPbBrS7tYGVVbvvAYvMbPYNhQE0nVVxKgESI+/8v+wvhgpHzNWWjd145Y/E7Y=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A7B7C3D62902B4CB0B6E351812C22E2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b3c689-3c53-4746-a477-08d6e42af522
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 11:44:07.4519 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3187
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.93
Subject: Re: [Qemu-devel] [PATCH v6 3/3] block/stream: introduce a bottom
 node
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
	"berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>,
	"wencongyang2@huawei.com" <wencongyang2@huawei.com>,
	"xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
	"jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjkuMDUuMjAxOSAxNDoyMywgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyOS4wNS4xOSAwOTozNCwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDI4LjA1LjIwMTkgMjA6MzMs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAwNi4wNS4xOSAxNzozNCwgVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gRnJvbTogQW5kcmV5IFNoaW5rZXZpY2ggPGFuZHJl
eS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20+DQo+Pj4+DQo+Pj4+IFRoZSBib3R0b20gbm9kZSBp
cyB0aGUgaW50ZXJtZWRpYXRlIGJsb2NrIGRldmljZSB0aGF0IGhhcyB0aGUgYmFzZSBhcyBpdHMN
Cj4+Pj4gYmFja2luZyBpbWFnZS4gSXQgaXMgdXNlZCBpbnN0ZWFkIG9mIHRoZSBiYXNlIG5vZGUg
d2hpbGUgYSBibG9jayBzdHJlYW0NCj4+Pj4gam9iIGlzIHJ1bm5pbmcgdG8gYXZvaWQgZGVwZW5k
ZW5jeSBvbiB0aGUgYmFzZSB0aGF0IG1heSBjaGFuZ2UgZHVlIHRvIHRoZQ0KPj4+PiBwYXJhbGxl
bCBqb2JzLiBUaGUgY2hhbmdlIG1heSB0YWtlIHBsYWNlIGR1ZSB0byBhIGZpbHRlciBub2RlIGFz
IHdlbGwgdGhhdA0KPj4+PiBpcyBpbnNlcnRlZCBiZXR3ZWVuIHRoZSBiYXNlIGFuZCB0aGUgaW50
ZXJtZWRpYXRlIGJvdHRvbSBub2RlLiBJdCBvY2N1cnMNCj4+Pj4gd2hlbiB0aGUgYmFzZSBub2Rl
IGlzIHRoZSB0b3Agb25lIGZvciBhbm90aGVyIGNvbW1pdCBvciBzdHJlYW0gam9iLg0KPj4+PiBB
ZnRlciB0aGUgaW50cm9kdWN0aW9uIG9mIHRoZSBib3R0b20gbm9kZSwgZG9uJ3QgZnJlZXplIGl0
cyBiYWNraW5nIGNoaWxkLA0KPj4+PiB0aGF0J3MgdGhlIGJhc2UsIGFueW1vcmUuDQo+Pj4+DQo+
Pj4+IFN1Z2dlc3RlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNv
dkB2aXJ0dW96em8uY29tPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgU2hpbmtldmljaCA8
YW5kcmV5LnNoaW5rZXZpY2hAdmlydHVvenpvLmNvbT4NCj4+Pj4gUmV2aWV3ZWQtYnk6IFZsYWRp
bWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+Pj4g
UmV2aWV3ZWQtYnk6IEFsYmVydG8gR2FyY2lhIDxiZXJ0b0BpZ2FsaWEuY29tPg0KPj4+PiAtLS0N
Cj4+Pj4gICAgYmxvY2svc3RyZWFtLmMgICAgICAgICB8IDQ5ICsrKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4+PiAgICB0ZXN0cy9xZW11LWlvdGVzdHMvMjQ1IHwg
IDQgKystLQ0KPj4+PiAgICAyIGZpbGVzIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDI2IGRl
bGV0aW9ucygtKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvYmxvY2svc3RyZWFtLmMgYi9ibG9j
ay9zdHJlYW0uYw0KPj4+PiBpbmRleCA2NWIxM2IyN2UwLi5mYzk3Yzg5ZjgxIDEwMDY0NA0KPj4+
PiAtLS0gYS9ibG9jay9zdHJlYW0uYw0KPj4+PiArKysgYi9ibG9jay9zdHJlYW0uYw0KPj4+DQo+
Pj4gWy4uLl0NCj4+Pg0KPj4+PiBAQCAtMjQ4LDI2ICsyNTAsMjUgQEAgdm9pZCBzdHJlYW1fc3Rh
cnQoY29uc3QgY2hhciAqam9iX2lkLCBCbG9ja0RyaXZlclN0YXRlICpicywNCj4+Pj4gICAgICAg
ICAqIGFscmVhZHkgaGF2ZSBvdXIgb3duIHBsYW5zLiBBbHNvIGRvbid0IGFsbG93IHJlc2l6ZSBh
cyB0aGUgaW1hZ2Ugc2l6ZSBpcw0KPj4+PiAgICAgICAgICogcXVlcmllZCBvbmx5IGF0IHRoZSBq
b2Igc3RhcnQgYW5kIHRoZW4gY2FjaGVkLiAqLw0KPj4+PiAgICAgICAgcyA9IGJsb2NrX2pvYl9j
cmVhdGUoam9iX2lkLCAmc3RyZWFtX2pvYl9kcml2ZXIsIE5VTEwsIGJzLA0KPj4+PiAtICAgICAg
ICAgICAgICAgICAgICAgICAgIEJMS19QRVJNX0NPTlNJU1RFTlRfUkVBRCB8IEJMS19QRVJNX1dS
SVRFX1VOQ0hBTkdFRCB8DQo+Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgQkxLX1BFUk1f
R1JBUEhfTU9ELA0KPj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgIEJMS19QRVJNX0NPTlNJ
U1RFTlRfUkVBRCB8IEJMS19QRVJNX1dSSVRFX1VOQ0hBTkdFRCB8DQo+Pj4+IC0gICAgICAgICAg
ICAgICAgICAgICAgICAgQkxLX1BFUk1fV1JJVEUsDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgYmFzaWNfZmxhZ3MgfCBCTEtfUEVSTV9HUkFQSF9NT0QsDQo+Pj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgYmFzaWNfZmxhZ3MgfCBCTEtfUEVSTV9XUklURSwNCj4+Pj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHNwZWVkLCBjcmVhdGlvbl9mbGFncywgTlVMTCwgTlVMTCwg
ZXJycCk7DQo+Pj4+ICAgICAgICBpZiAoIXMpIHsNCj4+Pj4gICAgICAgICAgICBnb3RvIGZhaWw7
DQo+Pj4+ICAgICAgICB9DQo+Pj4+ICAgIA0KPj4+PiAtICAgIC8qIEJsb2NrIGFsbCBpbnRlcm1l
ZGlhdGUgbm9kZXMgYmV0d2VlbiBicyBhbmQgYmFzZSwgYmVjYXVzZSB0aGV5IHdpbGwNCj4+Pj4g
LSAgICAgKiBkaXNhcHBlYXIgZnJvbSB0aGUgY2hhaW4gYWZ0ZXIgdGhpcyBvcGVyYXRpb24uIFRo
ZSBzdHJlYW1pbmcgam9iIHJlYWRzDQo+Pj4+IC0gICAgICogZXZlcnkgYmxvY2sgb25seSBvbmNl
LCBhc3N1bWluZyB0aGF0IGl0IGRvZXNuJ3QgY2hhbmdlLCBzbyBibG9jayB3cml0ZXMNCj4+Pj4g
LSAgICAgKiBhbmQgcmVzaXplcy4gKi8NCj4+Pj4gLSAgICBmb3IgKGl0ZXIgPSBiYWNraW5nX2Jz
KGJzKTsgaXRlciAmJiBpdGVyICE9IGJhc2U7IGl0ZXIgPSBiYWNraW5nX2JzKGl0ZXIpKSB7DQo+
Pj4+IC0gICAgICAgIGJsb2NrX2pvYl9hZGRfYmRydigmcy0+Y29tbW9uLCAiaW50ZXJtZWRpYXRl
IG5vZGUiLCBpdGVyLCAwLA0KPj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgQkxLX1BF
Uk1fQ09OU0lTVEVOVF9SRUFEIHwgQkxLX1BFUk1fV1JJVEVfVU5DSEFOR0VELA0KPj4+PiAtICAg
ICAgICAgICAgICAgICAgICAgICAgICAgJmVycm9yX2Fib3J0KTsNCj4+Pj4gKyAgICAvKg0KPj4+
PiArICAgICAqIEJsb2NrIGFsbCBpbnRlcm1lZGlhdGUgbm9kZXMgYmV0d2VlbiBicyBhbmQgYm90
dG9tIChpbmNsdXNpdmUpLCBiZWNhdXNlDQo+Pj4+ICsgICAgICogdGhleSB3aWxsIGRpc2FwcGVh
ciBmcm9tIHRoZSBjaGFpbiBhZnRlciB0aGlzIG9wZXJhdGlvbi4gVGhlIHN0cmVhbWluZw0KPj4+
PiArICAgICAqIGpvYiByZWFkcyBldmVyeSBibG9jayBvbmx5IG9uY2UsIGFzc3VtaW5nIHRoYXQg
aXQgZG9lc24ndCBjaGFuZ2UsIHNvDQo+Pj4+ICsgICAgICogZm9yYmlkIHdyaXRlcyBhbmQgcmVz
aXplcy4NCj4+Pj4gKyAgICAgKi8NCj4+Pj4gKyAgICBmb3IgKGl0ZXIgPSBiczsgaXRlciAhPSBi
b3R0b207IGl0ZXIgPSBiYWNraW5nX2JzKGl0ZXIpKSB7DQo+Pj4+ICsgICAgICAgIGJsb2NrX2pv
Yl9hZGRfYmRydigmcy0+Y29tbW9uLCAiaW50ZXJtZWRpYXRlIG5vZGUiLCBiYWNraW5nX2JzKGl0
ZXIpLA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgMCwgYmFzaWNfZmxhZ3MsICZl
cnJvcl9hYm9ydCk7DQo+Pj4NCj4+PiBJIGRvbuKAmXQgdW5kZXJzdGFuZCB0aGlzIGNoYW5nZS4g
IElzbuKAmXQgaXQgZG9pbmcgZXhhY3RseSB0aGUgc2FtZSBhcyBiZWZvcmU/DQo+Pj4NCj4+PiAo
SWYgc28sIEkganVzdCBmaW5kIGl0IGhhcmRlciB0byByZWFkIGJlY2F1c2UgZXZlcnkgaXRlcmF0
aW9uIGlzbuKAmXQNCj4+PiBhYm91dCBAaXRlciBidXQgYmFja2luZ19icyhpdGVyKS4pDQo+Pg0K
Pj4gSG0sIGl0J3MgdGhlIHNhbWUsIGJ1dCBub3QgdXNpbmcgYmFzZS4gV2UgbWF5IHNhdmUgb2xk
IGxvb3AgaWYgY2FsY3VsYXRlIGJhc2UgZXhhY3RseSBiZWZvcmUNCj4+IHRoZSBsb29wIChvciBh
dCBsZWFzdCBub3Qgc2VwYXJhdGVkIGZyb20gaXQgYnkgYW55IHlpZWxkLXBvaW50KQ0KPiANCj4g
QnV0IHdlIGFyZSBzdGlsbCBpbiBzdHJlYW1fc3RhcnQoKSBoZXJlLiAgYmFzZSBjYW5ub3QgaGF2
ZSBjaGFuZ2VkIHlldCwNCj4gY2FuIGl0Pw0KPiANCj4gKEkgZG9u4oCZdCBldmVuIHRoaW5rIHRo
aXMgaXMgYWJvdXQgeWllbGQgcG9pbnRzLiAgQXMgbG9uZyBhcw0KPiBzdHJlYW1fc3RhcnQoKSBk
b2VzbuKAmXQgcmV0dXJuLCB0aGUgUU1QIG1vbml0b3Igd29u4oCZdCByZWNlaXZlIGFueSBuZXcN
Cj4gY29tbWFuZHMuKQ0KPiANCg0KQnV0IGJsb2NrIGdyYXBoIG1heSBiZSBtb2RpZmllZCBub3Qg
b25seSBmcm9tIHFtcC4gRnJvbSBibG9jayBqb2JzIHRvby4gSWYgYmFzZSBpcyBhbm90aGVyIGZp
bHRlciwgaXQgbWF5DQpiZSBkcm9wcGVkIGluIGFueSB0aW1lLg0KDQoNCg0KLS0gDQpCZXN0IHJl
Z2FyZHMsDQpWbGFkaW1pcg0K

