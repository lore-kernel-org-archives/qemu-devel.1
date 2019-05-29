Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7BCC28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 13:58:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3993722CF6
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 13:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZhZwYNUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3993722CF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54927 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVz5w-0006ck-GZ
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 09:58:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hVz4b-00061s-GN
	for qemu-devel@nongnu.org; Wed, 29 May 2019 09:56:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hVz4Z-00082q-DA
	for qemu-devel@nongnu.org; Wed, 29 May 2019 09:56:57 -0400
Received: from mail-eopbgr150105.outbound.protection.outlook.com
	([40.107.15.105]:2567
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
	id 1hVz4W-0007uC-6O; Wed, 29 May 2019 09:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=3D9/74NRfoiFYNW9QxhJpf4nAxsjimrxiN4P3UuKROA=;
	b=ZhZwYNUhjMb8AnWqASLiRE5NSFfNG9FBGr5as1ohLm+gV1Eb9Teqe5Q7CW/bntymIOunj31odPjaFJZyKCJ6IJrLq2spplFBguoUCVzkZTImTnZftY4408yXtLaJDNuzX9qN5MUPBEqDPhyFGAU0js2N7Bv+it7avA64IV6JDNQ=
Received: from VI1PR08MB3677.eurprd08.prod.outlook.com (20.177.61.92) by
	VI1PR08MB4318.eurprd08.prod.outlook.com (20.179.26.77) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1922.19; Wed, 29 May 2019 13:56:47 +0000
Received: from VI1PR08MB3677.eurprd08.prod.outlook.com
	([fe80::3c2b:bc42:b670:6c5e]) by
	VI1PR08MB3677.eurprd08.prod.outlook.com
	([fe80::3c2b:bc42:b670:6c5e%7]) with mapi id 15.20.1922.021;
	Wed, 29 May 2019 13:56:47 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH] hw/block/fdc: floppy command FIFO memory
	initialization
Thread-Index: AQHVFhklDZxIAxK8j0qgesEHbr1LuqaCHBeAgAAEaoA=
Date: Wed, 29 May 2019 13:56:47 +0000
Message-ID: <ecd5c524-8b4a-5abf-af0c-f74c3c78b38f@virtuozzo.com>
References: <1559132524-228613-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<3a76e673-8142-a64d-c595-4c8fcecd12b2@redhat.com>
In-Reply-To: <3a76e673-8142-a64d-c595-4c8fcecd12b2@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0067.eurprd09.prod.outlook.com
	(2603:10a6:7:3d::11) To VI1PR08MB3677.eurprd08.prod.outlook.com
	(2603:10a6:803:85::28)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5201e0b1-bab4-4109-550b-08d6e43d7d98
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
	SRVR:VI1PR08MB4318; 
x-ms-traffictypediagnostic: VI1PR08MB4318:
x-microsoft-antispam-prvs: <VI1PR08MB431867D16F36E3AF2AF15DF7F41F0@VI1PR08MB4318.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(346002)(136003)(39850400004)(396003)(366004)(199004)(189003)(3846002)(6116002)(81166006)(14454004)(53936002)(2906002)(81156014)(8936002)(6512007)(6486002)(71200400001)(31686004)(7736002)(44832011)(36756003)(66066001)(2201001)(86362001)(31696002)(478600001)(110136005)(107886003)(71190400001)(2501003)(6246003)(4326008)(305945005)(54906003)(6436002)(6506007)(386003)(8676002)(99286004)(68736007)(446003)(11346002)(2616005)(476003)(316002)(186003)(256004)(486006)(5660300002)(66946007)(229853002)(52116002)(73956011)(26005)(66476007)(66556008)(64756008)(25786009)(66446008)(53546011)(76176011)(102836004);
	DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB4318;
	H:VI1PR08MB3677.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6SXxlbyeR0RwPOAQLa5yMeDhwXIrnVJiS75EmvSnGRAE0HkUILod+TPdSvVxU5S5fmOgAY3CDYCbS6E4fZ/Ti2Hk8Py6p9PkHtrUil+HN/NVzdm5oTNKCzpPnfhUvp7nsViDOBZJ/rT9sNKZtvqSmENXMKX5PWzK/kE34Aab4sOelLuOMgJoqQ0pszRm/EJ7YnQBA74N1nSJ3kI5hiDs38XqGfTCoSpkFQUdT9ZT3QujpeB2dQ4c7ZpvlZuqCkhjJxpF0RSZRfls7xSG6XOrjByfJKJICefITQ87eL5DlZXIz5r2TOnsJueEwomYiFB34f9fQ38wNc3416TcM3rJbeSM+Rt1l5jbOsc8ubxqqVTvmxEtB1wGVtRpCv+i9gYNsI6GqYP29kgfUsrXKkFtPudS9Mj/pIwFV1IwgsD3deI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23775488AA64D54C88DE6616102B5759@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5201e0b1-bab4-4109-550b-08d6e43d7d98
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 13:56:47.3505 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andrey.shinkevich@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4318
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.105
Subject: Re: [Qemu-devel] [PATCH] hw/block/fdc: floppy command FIFO memory
 initialization
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDI5LzA1LzIwMTkgMTY6NDAsIEpvaG4gU25vdyB3cm90ZToNCj4gDQo+IA0KPiBPbiA1
LzI5LzE5IDg6MjIgQU0sIEFuZHJleSBTaGlua2V2aWNoIHdyb3RlOg0KPj4gVGhlIHVuaW5pdGlh
bGl6ZWQgbWVtb3J5IGFsbG9jYXRlZCBmb3IgdGhlIGNvbW1hbmQgRklGTyBvZiB0aGUNCj4+IGZs
b3BweSBjb250cm9sbGVyIGR1cmluZyB0aGUgVk0gaGFyZHdhcmUgaW5pdGlhbGl6YXRpb24gaW5j
dXJzDQo+PiBtYW55IHVud2FudGVkIHJlcG9ydHMgYnkgVmFsZ3JpbmQgd2hlbiBWTSBzdGF0ZSBp
cyBiZWluZyBzYXZlZC4NCj4+IFRoYXQgdmVyYm9zaXR5IGhhcmRlbnMgYSBzZWFyY2ggZm9yIHRo
ZSByZWFsIG1lbW9yeSBpc3N1ZXMgd2hlbg0KPj4gdGhlIGlvdGVzdHMgcnVuLiBQYXJ0aWN1bGFy
bHksIHRoZSBwYXRjaCBlbGltaW5hdGVzIDIwIHVubmVjZXNzYXJ5DQo+PiByZXBvcnRzIG9mIHRo
ZSBWYWxncmluZCB0b29sIGluIHRoZSBpb3Rlc3QgIzE2OS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBBbmRyZXkgU2hpbmtldmljaCA8YW5kcmV5LnNoaW5rZXZpY2hAdmlydHVvenpvLmNvbT4NCj4+
IC0tLQ0KPj4gICBody9ibG9jay9mZGMuYyB8IDQgKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwg
NCBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3L2Jsb2NrL2ZkYy5jIGIvaHcv
YmxvY2svZmRjLmMNCj4+IGluZGV4IDZmMTlmMTIuLjU0ZTQ3MGMgMTAwNjQ0DQo+PiAtLS0gYS9o
dy9ibG9jay9mZGMuYw0KPj4gKysrIGIvaHcvYmxvY2svZmRjLmMNCj4+IEBAIC0yNjQ3LDYgKzI2
NDcsMTAgQEAgc3RhdGljIHZvaWQgZmRjdHJsX3JlYWxpemVfY29tbW9uKERldmljZVN0YXRlICpk
ZXYsIEZEQ3RybCAqZmRjdHJsLA0KPj4gICANCj4+ICAgICAgIEZMT1BQWV9EUFJJTlRGKCJpbml0
IGNvbnRyb2xsZXJcbiIpOw0KPj4gICAgICAgZmRjdHJsLT5maWZvID0gcWVtdV9tZW1hbGlnbig1
MTIsIEZEX1NFQ1RPUl9MRU4pOw0KPj4gKyAgICBpZiAoZmRjdHJsLT5maWZvKSB7DQo+PiArICAg
ICAgICAvKiBUbyBhdm9pZCB1c2luZyB0aGUgdW5pbml0aWFsaXplZCBtZW1vcnkgd2hpbGUgc2F2
aW5nIFZNIHN0YXRlICovDQo+PiArICAgICAgICBtZW1zZXQoZmRjdHJsLT5maWZvLCAwLCBGRF9T
RUNUT1JfTEVOKTsNCj4+ICsgICAgfQ0KPiANCj4gcWVtdV9tZW1hbGlnbiBkb2Vzbid0IGxvb2sg
bGlrZSBpdCBjYW4gZmFpbCAobG9va2luZyBhdA0KPiB1dGlsL29zbGliLXBvc2l4KTsgaXMgdGhp
cyBjb25kaXRpb25hbCBuZWNlc3Nhcnk/DQo+IA0KPiBJIHRoaW5rIHlvdSBjb3VsZCBqdXN0Og0K
PiANCj4gZmRjdHJsLT5maWZvID0gcWVtdV9tZW1hbGlnbig1MTIsIEZEX1NFQ1RPUl9MRU4pOw0K
PiBtZW1zZXQoZmRjdHJsLT5maWZvLCAwLCBGRF9TRUNUT1JfTEVOKTsNCj4gDQo+PiAgICAgICBm
ZGN0cmwtPmZpZm9fc2l6ZSA9IDUxMjsNCj4+ICAgICAgIGZkY3RybC0+cmVzdWx0X3RpbWVyID0g
dGltZXJfbmV3X25zKFFFTVVfQ0xPQ0tfVklSVFVBTCwNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZmRjdHJsX3Jlc3VsdF90aW1lciwgZmRjdHJsKTsN
Cj4+DQoNClllcywgdGhhdCdzIHJpZ2h0Lg0KVGhhbmsgeW91LCBKb2huLg0KDQpBbmRyZXkNCg0K

