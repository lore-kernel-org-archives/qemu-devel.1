Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C032C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 14:44:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 237422084F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 14:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="E5aw1Rdk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237422084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42677 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDryy-0006Nx-81
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 10:44:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hDry5-0005yS-He
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:43:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hDry4-00089i-Cb
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:43:21 -0400
Received: from mail-eopbgr140132.outbound.protection.outlook.com
	([40.107.14.132]:13619
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hDry1-00087l-M8; Tue, 09 Apr 2019 10:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=cum4fMNCxpup9GsUa90v1T/k8YpRwuxb0EdNolf/Wes=;
	b=E5aw1Rdk1/ZpX+vTV0sC1XzeeS7m8sCFJtq2znISDlii2uKTUE6uGA7S2EHfx+E7T7p6RNivKTEJkmbiVvDyK4z6ifIhMvbF8S9qWT9x47SEpPHFfHYFbVl3xDisaRvhpgtt2tYxVxzTYhsOTKMv0IcWnjdpNt7J9ZqnVa+SrnY=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3676.eurprd08.prod.outlook.com (20.177.120.158) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.21; Tue, 9 Apr 2019 14:43:12 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1771.021;
	Tue, 9 Apr 2019 14:43:12 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Alberto Garcia <berto@igalia.com>, Andrey Shinkevich
	<andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v4 1/3] block: include base when checking image chain for
	block allocation
Thread-Index: AQHU7jgLaMkJ3yREgUSKZnS0r5BSCqYz4cgAgAAG4YA=
Date: Tue, 9 Apr 2019 14:43:12 +0000
Message-ID: <e27a15f8-c299-7a08-3594-680aa1342b2b@virtuozzo.com>
References: <1554747741-918964-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1554747741-918964-2-git-send-email-andrey.shinkevich@virtuozzo.com>
	<w517ec345zb.fsf@maestria.local.igalia.com>
In-Reply-To: <w517ec345zb.fsf@maestria.local.igalia.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0049.eurprd09.prod.outlook.com
	(2603:10a6:7:3c::17) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190409174309283
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 717d2bcf-29bc-4d2c-eeba-08d6bcf9b0bd
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3676; 
x-ms-traffictypediagnostic: DB7PR08MB3676:
x-microsoft-antispam-prvs: <DB7PR08MB3676FA4582C4BDC5D596C1D3C12D0@DB7PR08MB3676.eurprd08.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(346002)(136003)(396003)(366004)(39840400004)(199004)(189003)(4326008)(14444005)(6512007)(106356001)(105586002)(316002)(6246003)(53936002)(25786009)(3846002)(2906002)(6116002)(107886003)(2201001)(81156014)(86362001)(36756003)(31686004)(6486002)(31696002)(7736002)(229853002)(305945005)(6436002)(66066001)(256004)(486006)(97736004)(2501003)(386003)(76176011)(8676002)(81166006)(68736007)(8936002)(6506007)(11346002)(446003)(2616005)(102836004)(476003)(26005)(186003)(5660300002)(14454004)(52116002)(478600001)(99286004)(71200400001)(54906003)(110136005)(71190400001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3676;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Lwf03VPGMNwhbdkg++7hDpfoKQj5xgWkFQHRX6qoTA2GHOSmZW3Izi+5SHGMosB5CfxY4ZBO/5Lm9UJOB2/06f9OULB87yb720snZyrGd1VUN80nUqMZS8he4YkW1t6Zsf7UE5VpZZG84vLF1BukVX7CRIkvaLC32VGRLl3AQcqWye52PIkAJKZyjUrQR4KGiquRERg/wt3AfhUlvL/BnL6kuG/Ah12kUIwywhFnpJYFclYb7Mnk/RMorYacAY8cERqCL6mB4AybTa7lYHH9acuxxPfr+XY8XqsuqbLVsIUfgZtjt+nN7MEadz11sW+AIURa6xuzWMafQqTbM+9EJKiMgBbAB+eNVt7KFOSHW7DKoKdojPspkE3jr7LN/A5X/yYugcP5oA+XY5OvfoVSO9OKlZ56/Hu7TUhvRycfEco=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <A783892F3956984CA2907AF13D325C90@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 717d2bcf-29bc-4d2c-eeba-08d6bcf9b0bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 14:43:12.0631 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3676
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.132
Subject: Re: [Qemu-devel] [PATCH v4 1/3] block: include base when checking
 image chain for block allocation
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
	Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409144312.StCPmzMPDLpqCy6ZEkv5Lo647XZRlURuLC-SsDB7NWk@z>

MDkuMDQuMjAxOSAxNzoxOCwgQWxiZXJ0byBHYXJjaWEgd3JvdGU6DQo+IE9uIE1vbiAwOCBBcHIg
MjAxOSAwODoyMjoxOSBQTSBDRVNULCBBbmRyZXkgU2hpbmtldmljaCB3cm90ZToNCj4+ICAgICog
UmV0dXJuIHRydWUgaWYgKGEgcHJlZml4IG9mKSB0aGUgZ2l2ZW4gcmFuZ2UgaXMgYWxsb2NhdGVk
IGluIGFueSBpbWFnZQ0KPj4gLSAqIGJldHdlZW4gQkFTRSBhbmQgVE9QIChpbmNsdXNpdmUpLiAg
QkFTRSBjYW4gYmUgTlVMTCB0byBjaGVjayBpZiB0aGUgZ2l2ZW4NCj4+ICsgKiBiZXR3ZWVuIEJB
U0UgYW5kIFRPUCAoVE9QIGluY2x1ZGVkKS4gVG8gY2hlY2sgdGhlIEJBU0UgaW1hZ2UsIHNldCB0
aGUNCj4+ICsgKiAnaW5jbHVkZV9iYXNlJyB0byAndHJ1ZScuIFRoZSBCQVNFIGNhbiBiZSBOVUxM
IHRvIGNoZWNrIGlmIHRoZSBnaXZlbg0KPj4gICAgKiBvZmZzZXQgaXMgYWxsb2NhdGVkIGluIGFu
eSBpbWFnZSBvZiB0aGUgY2hhaW4uICBSZXR1cm4gZmFsc2Ugb3RoZXJ3aXNlLA0KPj4gICAgKiBv
ciBuZWdhdGl2ZSBlcnJubyBvbiBmYWlsdXJlLg0KPiANCj4gSSdtIG5vdCBhIG5hdGl2ZSBzcGVh
a2VyIGJ1dCB0aGF0IHNvdW5kcyBhIGJpdCBvZGQgdG8gbWUuDQo+IA0KPiBBbHRlcm5hdGl2ZToN
Cj4gDQo+ICAgICogUmV0dXJuIHRydWUgaWYgKGEgcHJlZml4IG9mKSB0aGUgZ2l2ZW4gcmFuZ2Ug
aXMgYWxsb2NhdGVkIGluIGFueSBpbWFnZQ0KPiAgICAqIGJldHdlZW4gQkFTRSBhbmQgVE9QIChC
QVNFIGlzIG9ubHkgaW5jbHVkZWQgaWYgaW5jbHVkZV9iYXNlIGlzIHNldCkuDQo+ICAgICogQkFT
RSBjYW4gYmUgTlVMTCB0byBjaGVjayBpZiB0aGUgZ2l2ZW4gb2Zmc2V0IGlzIGFsbG9jYXRlZCBp
biBhbnkNCj4gICAgKiBpbWFnZSBvZiB0aGUgY2hhaW4uICBSZXR1cm4gZmFsc2Ugb3RoZXJ3aXNl
LCBvciBuZWdhdGl2ZSBlcnJubyBvbg0KPiAgICAqIGZhaWx1cmUuDQo+IA0KPj4gLSAgICB3aGls
ZSAoaW50ZXJtZWRpYXRlICYmIGludGVybWVkaWF0ZSAhPSBiYXNlKSB7DQo+PiArICAgIHdoaWxl
IChpbmNsdWRlX2Jhc2UgfHwgaW50ZXJtZWRpYXRlICE9IGJhc2UpIHsNCj4+ICAgICAgICAgICBp
bnQ2NF90IHBudW1faW50ZXI7DQo+PiAgICAgICAgICAgaW50NjRfdCBzaXplX2ludGVyOw0KPj4g
ICANCj4+IEBAIC0yMzYwLDYgKzIzNjQsMTAgQEAgaW50IGJkcnZfaXNfYWxsb2NhdGVkX2Fib3Zl
KEJsb2NrRHJpdmVyU3RhdGUgKnRvcCwNCj4+ICAgICAgICAgICAgICAgbiA9IHBudW1faW50ZXI7
DQo+PiAgICAgICAgICAgfQ0KPj4gICANCj4+ICsgICAgICAgIGlmIChpbnRlcm1lZGlhdGUgPT0g
YmFzZSkgew0KPj4gKyAgICAgICAgICAgIGJyZWFrOw0KPj4gKyAgICAgICAgfQ0KPj4gKw0KPj4g
ICAgICAgICAgIGludGVybWVkaWF0ZSA9IGJhY2tpbmdfYnMoaW50ZXJtZWRpYXRlKTsNCj4gDQo+
IEkgZmluZCB0aGF0IHRoZSBuZXcgY29uZGl0aW9uICsgdGhlIGJyZWFrIG1ha2UgdGhpbmdzIGEg
Yml0IGxlc3MNCj4gcmVhZGFibGUuIEkgdGhpbmsgaXQgd291bGQgYmUgc2ltcGxlciB3aXRoIHNv
bWV0aGluZyBsaWtlIHRoaXM6DQo+IA0KPiAgICAgQmxvY2tEcml2ZXJTdGF0ZSAqc3RvcF9hdCA9
IGluY2x1ZGVfYmFzZSA/IGJhY2tpbmdfYnMoYmFzZSkgOiBiYXNlOw0KPiANCj4gICAgIHdoaWxl
IChpbnRlcm1lZGlhdGUgIT0gc3RvcF9hdCkgew0KPiAgICAgICAgLi4uDQo+ICAgICB9DQo+IA0K
DQpCdXQgaW4gdGhpcyB3YXkgeW91IHJldHVybiBiYWNrIGRlcGVuZGVuY2Ugb24gYmFzZSwgd2hp
Y2ggd2UgZG9uJ3QgZnJlZXplIGFuZCB3aGljaA0KbWF5IGRpc2FwcGVhciBvbiBzb21lIGl0ZXJh
dGlvbi4gV2Ugc2hvdWxkIG5vdCB0b3VjaCBiYWNraW5nX2JzKGJhc2UpIGluIGFueSB3YXkuDQoN
Cg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

