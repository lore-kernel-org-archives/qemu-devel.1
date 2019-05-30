Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAAAC072B1
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 06:48:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 442EB25B5F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 06:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OnNt/mag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 442EB25B5F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43043 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWErt-0005Mm-Uf
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 02:48:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hWEqz-00051h-LH
	for qemu-devel@nongnu.org; Thu, 30 May 2019 02:47:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hWEqy-0003Dv-DD
	for qemu-devel@nongnu.org; Thu, 30 May 2019 02:47:57 -0400
Received: from mail-eopbgr150128.outbound.protection.outlook.com
	([40.107.15.128]:40078
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
	id 1hWEqv-00039Q-AG; Thu, 30 May 2019 02:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=vKGRTfvclYiTDiykXxoyYbDzPGMLucBQW3MghaUxReM=;
	b=OnNt/mag31LGVIeQNcm2TGtsnSleykjT72H6jpfXa5rew3oueQbyVaygsLIFq/GqkyzFPBaS4URZo6bApJt+BOv8a0JArroopZ608qbExz8OIR04rTJCE6c3jO3vIs1ITPsCtQeDHPTBnS3ElQE75NFWAygCwClKxwhshh5fHks=
Received: from VI1PR08MB3677.eurprd08.prod.outlook.com (20.177.61.92) by
	VI1PR08MB3215.eurprd08.prod.outlook.com (52.133.15.155) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1922.18; Thu, 30 May 2019 06:47:50 +0000
Received: from VI1PR08MB3677.eurprd08.prod.outlook.com
	([fe80::3c2b:bc42:b670:6c5e]) by
	VI1PR08MB3677.eurprd08.prod.outlook.com
	([fe80::3c2b:bc42:b670:6c5e%7]) with mapi id 15.20.1922.021;
	Thu, 30 May 2019 06:47:50 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v2] hw/block/fdc: floppy command FIFO memory
	initialization
Thread-Index: AQHVFks3Tllfl2eGt0+onCghAvm5cKaCoTAAgACZaIA=
Date: Thu, 30 May 2019 06:47:50 +0000
Message-ID: <a5c19a68-dab3-5f55-dbae-45de03fd1773@virtuozzo.com>
References: <1559154027-282547-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<fd085c62-35fb-a054-7a75-cad24eda07a1@redhat.com>
In-Reply-To: <fd085c62-35fb-a054-7a75-cad24eda07a1@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR1001CA0008.EURPRD10.PROD.OUTLOOK.COM
	(2603:10a6:3:f7::18) To VI1PR08MB3677.eurprd08.prod.outlook.com
	(2603:10a6:803:85::28)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fc647cc-7145-46dd-ca8e-08d6e4cabb59
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:VI1PR08MB3215; 
x-ms-traffictypediagnostic: VI1PR08MB3215:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR08MB321510F97431EA4618CDDD6CF4180@VI1PR08MB3215.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(39850400004)(396003)(136003)(376002)(346002)(199004)(189003)(6436002)(966005)(44832011)(5660300002)(2201001)(478600001)(446003)(229853002)(2906002)(3846002)(256004)(2616005)(6486002)(316002)(6116002)(14444005)(31696002)(14454004)(11346002)(66066001)(25786009)(386003)(71190400001)(71200400001)(476003)(7736002)(6306002)(102836004)(107886003)(53546011)(52116002)(8676002)(81166006)(6506007)(31686004)(76176011)(486006)(4326008)(66446008)(81156014)(4744005)(73956011)(64756008)(66556008)(66946007)(66476007)(305945005)(186003)(26005)(68736007)(6246003)(36756003)(8936002)(110136005)(53936002)(2501003)(6512007)(99286004)(54906003)(86362001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3215;
	H:VI1PR08MB3677.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qaOlYjGvLDpYyUHPq9R5QgKfAxYoNUd4gEyEwP53oRkuIxXHu+hXsik+NgxYU/l9ADUQED7L3AOW9iaSkqpDfQ9Tw9sfc8Mh+XMYIS2F3AMtKK8FKa5TwwNsBupBcswTkWUNmFDBxJ7CEQ238xQDJYPcGhcNO+SgHKfUXyvgvOxFNW8wwQ+CAvzX/ICh9vvvpdxXGz3WoF+3mt8lVLRuBZrFprzSq/OJN4iW9W1vi/NYGc5RA0qiDfqfuuyYmTk0/ZeJkBKPXoIfNB/8S4TkCyKCQLZ/C4kGnx2FIf1yFBDhL2Z4nZHb2UFrXEMmARNqN37zDPEz/n21QJLp67sy6jkT6lBXCwClqjQ1dTUX9Izekb1nReIMKONfDOL0QojKbBwYO+SS13w2ewchah03G8qv7InF+Inj4oFSFdAiO0s=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B0AB254ACFA4846B1DC413ADD6C421D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc647cc-7145-46dd-ca8e-08d6e4cabb59
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 06:47:50.0622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andrey.shinkevich@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3215
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.128
Subject: Re: [Qemu-devel] [PATCH v2] hw/block/fdc: floppy command FIFO
 memory initialization
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
	"jsnow@redhat.com" <jsnow@redhat.com>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMzAvMDUvMjAxOSAwMDozOCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyOS4wNS4xOSAyMDoy
MCwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+PiBUaGUgdW5pbml0aWFsaXplZCBtZW1vcnkg
YWxsb2NhdGVkIGZvciB0aGUgY29tbWFuZCBGSUZPIG9mIHRoZQ0KPj4gZmxvcHB5IGNvbnRyb2xs
ZXIgZHVyaW5nIHRoZSBWTSBoYXJkd2FyZSBpbml0aWFsaXphdGlvbiBpbmN1cnMNCj4+IG1hbnkg
dW53YW50ZWQgcmVwb3J0cyBieSBWYWxncmluZCB3aGVuIFZNIHN0YXRlIGlzIGJlaW5nIHNhdmVk
Lg0KPj4gVGhhdCB2ZXJib3NpdHkgaGFyZGVucyBhIHNlYXJjaCBmb3IgdGhlIHJlYWwgbWVtb3J5
IGlzc3VlcyB3aGVuDQo+PiB0aGUgaW90ZXN0cyBydW4uIFBhcnRpY3VsYXJseSwgdGhlIHBhdGNo
IGVsaW1pbmF0ZXMgMjAgdW5uZWNlc3NhcnkNCj4+IHJlcG9ydHMgb2YgdGhlIFZhbGdyaW5kIHRv
b2wgaW4gdGhlIGlvdGVzdCAjMTY5Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBTaGlu
a2V2aWNoIDxhbmRyZXkuc2hpbmtldmljaEB2aXJ0dW96em8uY29tPg0KPj4gLS0tDQo+PiB2MjoN
Cj4+ICAgIDAxOiBUaGUgcG9pbnRlciB1bm5lY2Vzc2FyeSBjaGVjayAnaWYgKGZkY3RybC0+Zmlm
byknIHdhcyByZW1vdmVkDQo+PiAgICAgICAgYXMgc3VnZ2VzdGVkIGJ5IEpvaG4uDQo+Pg0KPj4g
ICBody9ibG9jay9mZGMuYyB8IDEgKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KykNCj4gDQo+IFRoYW5rcywgYXBwbGllZCB0byBteSBibG9jay1vbi1rZXZpbiBicmFuY2g6DQo+
IA0KPiBodHRwczovL2dpdC54YW5jbGljLm1vZS9YYW5DbGljL3FlbXUvY29tbWl0cy9icmFuY2gv
YmxvY2stb24ta2V2aW4NCj4gDQo+IChUbyBiZWNvbWUgbXkgYmxvY2sgYnJhbmNoIHdoZW4gbXkg
Y3VycmVudCBwdWxsIHJlcXVlc3QgaXMgZG9uZS4pDQo+IA0KPiBNYXgNCj4gDQoNClRoYW5rIHlv
dSB2ZXJ5IG11Y2guDQpBbmRyZXkNCg==

