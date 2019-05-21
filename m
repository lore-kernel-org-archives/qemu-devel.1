Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7534BC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 16:17:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33200217D7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 16:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="I7tOL1lq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33200217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56467 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT7SJ-00053A-Fz
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 12:17:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hT7RE-0004Ze-12
	for qemu-devel@nongnu.org; Tue, 21 May 2019 12:16:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hT7RC-0003GT-Sv
	for qemu-devel@nongnu.org; Tue, 21 May 2019 12:16:28 -0400
Received: from mail-eopbgr70120.outbound.protection.outlook.com
	([40.107.7.120]:5063
	helo=EUR04-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hT7RC-0003Fr-3W
	for qemu-devel@nongnu.org; Tue, 21 May 2019 12:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=qgPf+4o9IywA5svLqZARPITvbJD6Tu6VzGNjzipOTuw=;
	b=I7tOL1lqGTLb8vVWwF4kPJ9LmlbRHcEyTsAi6LhZ4A369tOUO8jh88bcsp10VF+x4zWUL+g1V7WuBtN5R3GqLbHVTJ1REhBN00zvWXPOo6dZWFXXJrtPx1wzOr4Hl9hem9Ag08bDojo/soE1eyQSP0qZx7w+6ObrESY1jyrJQYo=
Received: from AM6PR08MB4675.eurprd08.prod.outlook.com (10.255.96.78) by
	AM6PR08MB4343.eurprd08.prod.outlook.com (20.179.6.74) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1900.18; Tue, 21 May 2019 16:16:22 +0000
Received: from AM6PR08MB4675.eurprd08.prod.outlook.com
	([fe80::9051:3c85:28c6:a0c1]) by
	AM6PR08MB4675.eurprd08.prod.outlook.com
	([fe80::9051:3c85:28c6:a0c1%6]) with mapi id 15.20.1878.024;
	Tue, 21 May 2019 16:16:22 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "kraxel@redhat.com" <kraxel@redhat.com>
Thread-Topic: qemu vga crash
Thread-Index: AQHVCxmradqtfZ8GrUqnP/Tj0S9bcaZ11POA///vpgCAAAY+AA==
Date: Tue, 21 May 2019 16:16:21 +0000
Message-ID: <2bcaac7b-8bea-c87e-199d-5d40f9730d7b@virtuozzo.com>
References: <c2a0ab8b-8229-29be-3658-1a2c52df65ad@virtuozzo.com>
	<502cc23b-3c83-9f05-098c-7193085ce9ca@virtuozzo.com>
	<20190521155358.bjxpi3dpilq3qtnx@sirius.home.kraxel.org>
In-Reply-To: <20190521155358.bjxpi3dpilq3qtnx@sirius.home.kraxel.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0009.eurprd05.prod.outlook.com
	(2603:10a6:3:1a::19) To AM6PR08MB4675.eurprd08.prod.outlook.com
	(2603:10a6:20b:c2::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190521191618829
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c0dc4ac-32f1-4cd3-df75-08d6de07a9c3
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:AM6PR08MB4343; 
x-ms-traffictypediagnostic: AM6PR08MB4343:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM6PR08MB43430EFA1D2D70A658CAD9F9C1070@AM6PR08MB4343.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(136003)(396003)(39850400004)(376002)(346002)(189003)(199004)(7736002)(478600001)(486006)(2906002)(6512007)(305945005)(99286004)(36756003)(102836004)(5640700003)(6306002)(476003)(2501003)(81166006)(8936002)(386003)(6506007)(966005)(81156014)(3480700005)(1730700003)(71190400001)(8676002)(71200400001)(52116002)(2616005)(53936002)(14454004)(6916009)(4326008)(54906003)(14444005)(76176011)(256004)(2351001)(86362001)(73956011)(6486002)(107886003)(66476007)(66946007)(6246003)(25786009)(68736007)(186003)(66066001)(11346002)(66446008)(446003)(31696002)(6116002)(3846002)(26005)(7116003)(6436002)(5660300002)(31686004)(66556008)(316002)(64756008)(229853002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4343;
	H:AM6PR08MB4675.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yop3bnYQ0pnTUavfilQqNOlqFl75TcNN2j65k3RwPv62RSGss7PBxb+inuRSw3CqvLtTEXSRRzoZJ5zipQ/mOO08xwonGQwXdmSX2GBEJi2u0ngX93n5fREjuceVQEORYMBJf5azC6LGhBsjUDVMro1r2x7BUfYT5Z4oLnKgvQm5YmizEoSKrFLuIusJNdwHmKr/CDAuZhsuTrlT46Pv+NoaJboD8SvOzUVuRkd9Bsoom94H0uTzUwZRAohYja/qdnt9tcwyBmqBq7UTHmqJ8zeTTtNPn/Ak7tu5y6P+8UbR1aq336XuOtW024+vemG1rp1qM9ue/OkKDuu14HIyIqEC7hTf4S5nbpk/14ugbxWzHafrWV7OJ57zNfOFNtL99yAJ13W6UhJvbtPLpTtDWdEdIlI+mYd9wV895RHSErw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <031072C99213114B80F5035199617AC0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c0dc4ac-32f1-4cd3-df75-08d6de07a9c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 16:16:22.3132 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4343
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.120
Subject: Re: [Qemu-devel] qemu vga crash
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
Cc: Denis Lunev <den@virtuozzo.com>,
	"ross.lagerwall@citrix.com" <ross.lagerwall@citrix.com>,
	qemu-devel <qemu-devel@nongnu.org>,
	"pjp@fedoraproject.org" <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjEuMDUuMjAxOSAxODo1Mywga3JheGVsQHJlZGhhdC5jb20gd3JvdGU6DQo+IE9uIFR1ZSwgTWF5
IDIxLCAyMDE5IGF0IDAxOjUyOjMxUE0gKzAwMDAsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNr
aXkgd3JvdGU6DQo+PiBDb3VsZCBhbnlib2R5IGhlbHA/DQo+IA0KPiBIb3cgYWJvdXQgZG9pbmcg
eW91ciBob21ld29yayBwcm9wZXJseT8NCj4gDQo+Pj4gSGkgR2VyZCENCj4+Pg0KPj4+IFdyaXRp
bmcgdG8geW91LCBhcyB5b3Ugd2VyZSB0aGUgbGFzdCBvbmUgd2hvIGNvbW1pdHRlZCB0byB2Z2Ff
ZHJhd19ncmFwaGljLCBob3BlIHlvdSBjYW4gaGVscC4NCj4+Pg0KPj4+IFdlIGZhY2VkIHRoZSBm
b2xsb3dpbmcgY3Jhc2ggaW4gMi4xMi1iYXNlZCBRZW11LCBidXQgY29kZSBzZWVtcyBub3QgcmVh
bGx5IGNoYW5nZWQ6DQo+IA0KPiBQcmV0dHkgbGFtZSBleGN1c2UgZm9yIG5vdCB0ZXN0aW5nIGEg
bW9yZSByZWNlbnQgcmVsZWFzZSBvciBnaXQgbWFzdGVyLg0KPiANCj4gQW5kIHlvdSBhcmUgd3Jv
bmcuICBUaGUgY29kZSAqaGFzKiBjaGFuZ2VkLA0KPiBhbmQgdGhlIGJ1ZyBoYXMgYmVlbiBmaXhl
ZCBhIHllYXIgYWdvIGFscmVhZHkuDQoNCk9vcHMsIHNlZW1zIGxpa2UgSSBqdXN0IGNvbXBhcmVk
IHdyb25nIHZlcnNpb25zIHdoZW4gZm91bmQgbm8gcmVhbCBkaWZmZXJlbmNlLCBhcyBidWcgYWN0
dWFsbHkgZnJvbSAyLjEwLA0KYW5kIGZpeGVkIGluIDIuMTIuDQoNClRoYW5rIHlvdSBhbmQgc29y
cnkgZm9yIHRoZSBub2lzZS4NCg0KPiANCj4gY29tbWl0IGE4OWZlNmMzMjk3OTllNDdhYWExNjYz
NjUwZjA3NmIyODgwOGUxODYNCj4gQXV0aG9yOiBHZXJkIEhvZmZtYW5uIDxrcmF4ZWxAcmVkaGF0
LmNvbT4NCj4gRGF0ZTogICBNb24gTWF5IDE0IDEyOjMxOjE3IDIwMTggKzAyMDANCj4gDQo+ICAg
ICAgdmdhOiBjYXRjaCBkZXB0aCAwDQo+ICAgICAgDQo+ICAgICAgZGVwdGggPT0gMCBpcyB1c2Vk
IHRvIGluZGljYXRlIDI1NiBjb2xvciBtb2Rlcy4gIE91ciByZWdpb24gY2FsY3VsYXRpb24NCj4g
ICAgICBnb2VzIHdyb25nIGluIHRoYXQgY2FzZS4gIFNvIGRldGVjdCB0aGF0IGFuZCBqdXN0IHRh
a2UgdGhlIHNhZmUgY29kZQ0KPiAgICAgIHBhdGggd2UgYWxyZWFkeSBoYXZlIGZvciB0aGUgd3Jh
cGFyb3VuZCBjYXNlLg0KPiAgICAgIA0KPiAgICAgIFdoaWxlIGJlaW5nIGF0IGl0IGFsc28gY2F0
Y2ggZGVwdGggPT0gMTUgKHdoZXJlIG91ciByZWdpb24gc2l6ZQ0KPiAgICAgIGNhbGN1bGF0aW9u
IGdvZXMgd3JvbmcgdG9vKS4gIEFuZCBtYWtlIHRoZSBjb21tZW50IG1vcmUgdmVyYm9zZSwNCj4g
ICAgICBleHBsYWluaW5nIHdoYXQgaXMgZ29pbmcgb24gaGVyZS4NCj4gICAgICANCj4gICAgICBX
aXRob3V0IHRoaXMgd2luZG93cyBndWVzdCBpbnN0YWxsIG1pZ2h0IHRyaWdnZXIgYW4gYXNzZXJ0
IGR1ZSB0byB0cnlpbmcNCj4gICAgICB0byBjaGVjayBkaXJ0eSBiaXRtYXAgb3V0c2lkZSB0aGUg
c25hcHNob3QgcmVnaW9uLg0KPiAgICAgIA0KPiAgICAgIEZpeGVzOiBodHRwczovL2J1Z3ppbGxh
LnJlZGhhdC5jb20vc2hvd19idWcuY2dpP2lkPTE1NzU1NDENCj4gICAgICBTaWduZWQtb2ZmLWJ5
OiBHZXJkIEhvZmZtYW5uIDxrcmF4ZWxAcmVkaGF0LmNvbT4NCj4gICAgICBNZXNzYWdlLWlkOiAy
MDE4MDUxNDEwMzExNy4yMTA1OS0xLWtyYXhlbEByZWRoYXQuY29tDQo+IA0KPiBjaGVlcnMsDQo+
ICAgIEdlcmQNCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

