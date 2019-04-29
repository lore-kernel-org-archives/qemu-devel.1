Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA2EC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 08:49:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78C192063F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 08:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gIbnhFlL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C192063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54170 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL1yU-0006X9-DE
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 04:49:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hL1xX-0006BK-PN
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 04:48:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hL1xW-0002nh-Iw
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 04:48:23 -0400
Received: from mail-eopbgr90123.outbound.protection.outlook.com
	([40.107.9.123]:33965
	helo=FRA01-MR2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hL1xT-0002la-9q; Mon, 29 Apr 2019 04:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=wRXxh85jyFBbGNCg70ViocV6HzOHQ8oCQIiQWBmSh1o=;
	b=gIbnhFlLgIDMIXIYPZyiVZ1pLRY93WnMacCk3AE39XxNT2kgwQYTcqiZs5SGNh2hgfoSrESvpjyST0o16Ck9arqWWhPSTtrM1Nv0crlcsSAkA+iRXY7cykIiK1q8WgpaEqFaGteEcmuSN4Btf+mtOvesp6IPrW+0SgaeQjFlOOM=
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com (52.133.109.209) by
	PR2SPR01MB0004.eurprd08.prod.outlook.com (52.133.108.205) with
	Microsoft SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.18; Mon, 29 Apr 2019 08:48:15 +0000
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::88d7:ecf0:1120:f1a1]) by
	PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::88d7:ecf0:1120:f1a1%3]) with mapi id 15.20.1835.018;
	Mon, 29 Apr 2019 08:48:15 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 00/10] qcow2: encryption threads
Thread-Index: AQHU6WoB+NIZnh166UOvlio9dNC4LKZSdJkAgACJH4A=
Date: Mon, 29 Apr 2019 08:48:15 +0000
Message-ID: <2e94347c-4aab-bbf0-18c5-35a0b09b1a39@virtuozzo.com>
References: <20190402153730.54145-1-vsementsov@virtuozzo.com>
	<2292e073-b32e-a2db-59d5-755ddcf31417@redhat.com>
In-Reply-To: <2292e073-b32e-a2db-59d5-755ddcf31417@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0045.eurprd07.prod.outlook.com
	(2603:10a6:3:9e::13) To PR2PR08MB4684.eurprd08.prod.outlook.com
	(2603:10a6:101:22::17)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190429114811879
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8685df5f-1a45-4c13-9983-08d6cc7f6b0a
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:PR2SPR01MB0004; 
x-ms-traffictypediagnostic: PR2SPR01MB0004:
x-microsoft-antispam-prvs: <PR2SPR01MB0004C19F5B1EC005A58D3D73C1390@PR2SPR01MB0004.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(396003)(346002)(39840400004)(376002)(366004)(199004)(189003)(8936002)(81156014)(81166006)(66946007)(73956011)(71200400001)(8676002)(71190400001)(2501003)(68736007)(66066001)(97736004)(36756003)(14444005)(66556008)(6246003)(4326008)(25786009)(31686004)(31696002)(6512007)(66446008)(64756008)(66476007)(53936002)(86362001)(2201001)(6486002)(186003)(102836004)(6436002)(446003)(26005)(476003)(6116002)(478600001)(305945005)(3846002)(386003)(6506007)(53546011)(52116002)(14454004)(76176011)(99286004)(5660300002)(7736002)(229853002)(256004)(2906002)(486006)(2616005)(11346002)(316002)(110136005)(54906003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:PR2SPR01MB0004;
	H:PR2PR08MB4684.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qlAb4wXR9rjmh1yDk64FpezMQp38/iY/o8uTcaKmAPvGxVB2PTvNytTPRlFFwUiNSq/ARTICAdDdb8q7KSn4WCIX10X3G8f9qT8WqeRu0MMA0Qr8j3NXJXTJzgoUln5LtQ594zsaMgHXbqdr/SgOiOkrhcgT5lWAZkMYxt1JFD2vHBVSqGw+4LzHiJTOzNF/2IcBZS1S/pHOMT38acWa5ldEgGjsuM/Q3ivkQ4hKVRfxPA/dgEWgI9FY0IR5qdmUTgOswk4TjcNSea41QoOaur+gvaFQFjrSFCtlp2k37+qg+eSR577QyuFCPuJ1KXjF+hrSUK8tc5jpmooxNZ9ELAaGCprayiALyAGxpNuHH10I3ZNTMPjSVKP/q2qUncbxE9LzN5xzupX7MsPhtK9OZOQG6WAl5BwHsYu7bDGBBNo=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <D279EF312DA9AA48A6E55C1210E49A3B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8685df5f-1a45-4c13-9983-08d6cc7f6b0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 08:48:15.1065 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2SPR01MB0004
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.9.123
Subject: Re: [Qemu-devel] [PATCH v5 00/10] qcow2: encryption threads
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
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429084815.d4v5II-uVXDrTZyLe8iyCHe3nlol5J4ZuY4B0-PlcSk@z>

MjkuMDQuMjAxOSAzOjM3LCBNYXggUmVpdHogd3JvdGU6DQo+IE9uIDAyLjA0LjE5IDE3OjM3LCBW
bGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gdjU6IHJlYmFzZSBvbiBtYXN0
ZXIsIHNvbWUgY29uZmxpY3RzIHJlc29sdmVkIGR1ZSB0byBkYXRhLWZpbGUgZmVhdHVyZQ0KPj4N
Cj4+IDAxOiBuZXcgcGF0Y2gsIGp1c3QgbW92ZSB0ZXN0IGZyb20gY292ZXIgbGV0dGVyIHRvIGEg
ZmlsZS4gSSByZWFsbHkgaG9wZSB0aGF0IGl0DQo+PiAgICAgIHdpbGwgbm90IGhhbmcgdGhlIHdo
b2xlIHNlcmllcywgc28sIGlmIHdlIGRvbid0IHdhbnQgaXQgYXMgaXMgb3Igd2l0aCByZWFsbHkN
Cj4+ICAgICAgdGlueSBpbXByb3ZlbWVudHMsIEknZCBwcmVmZXIgdG8gc2tpcCBpdCBhbmQgcXVl
dWUgMDItMTAgZmlyc3QuDQo+IA0KPiBZdXAsIG5vdGVkLg0KPiANCj4+IDA5OiAidHJ1ZSIgcGFy
YW1ldGVyIGFkZGVkIHRvIG1vdmVkIHFjb3cyX3ByZV93cml0ZV9vdmVybGFwX2NoZWNrKCkgY2Fs
bCBkdWUgdG8NCj4+ICAgICAgcmViYXNlIG9uIG1hc3RlciAoYm90aCBiZWZvcmUgYW5kIGFmdGVy
IHBhdGNoKS4gU2VlbXMgT0ssIHNvIGtlZXAgQWxiZXJ0bydzIHItYi4NCj4+DQo+PiBwZXJmb3Jt
YW5jZToNCj4+DQo+PiBhZnRlciAwMToNCj4+ICAgIyAuL3Rlc3RzL3BlcmYvYmxvY2svcWNvdzIv
Y29udmVydC10by1lbmNyeXB0ZWQgL3NzZC9zcmMucmF3IC9zc2QvZHN0LmVuYy5xY293Mg0KPj4g
MTQuMTgNCj4+ICAgIyAuL3Rlc3RzL3BlcmYvYmxvY2svcWNvdzIvY29udmVydC10by1lbmNyeXB0
ZWQgL3NzZC9zcmMucmF3IC9zc2QvZHN0LmVuYy5xY293MiAtVw0KPj4gMTMuNzcNCj4+DQo+PiBh
ZnRlciAxMDoNCj4+ICAgIyAuL3Rlc3RzL3BlcmYvYmxvY2svcWNvdzIvY29udmVydC10by1lbmNy
eXB0ZWQgL3NzZC9zcmMucmF3IC9zc2QvZHN0LmVuYy5xY293Mg0KPj4gMTQuMzUNCj4+ICAgIyAu
L3Rlc3RzL3BlcmYvYmxvY2svcWNvdzIvY29udmVydC10by1lbmNyeXB0ZWQgL3NzZC9zcmMucmF3
IC9zc2QvZHN0LmVuYy5xY293MiAtVw0KPj4gNS42Mg0KPiANCj4gSG0sIEkgc2VlIHRob3NlIHJl
c3VsdHMgYXMgd2VsbDoNCj4gDQo+IEJlZm9yZToNCj4gdy9vIC1XOiA3LjE1DQo+IHcvICAtVzog
Ni43Nw0KPiANCj4gQWZ0ZXI6DQo+IHcvbyAtVzogNy4xOQ0KPiB3LyAgLVc6IDMuNjUNCj4gDQo+
IA0KPiBCdXQgd2l0aCAtdCBub25lLCB0aGlzIGlzIHdoYXQgSSBnZXQ6DQo+IA0KPiBCZWZvcmU6
DQo+IHcvbyAtVzogMTUuOTgNCj4gdy8gIC1XOiAxMC45MQ0KPiANCj4gQWZ0ZXI6DQo+IHcvbyAt
VzogMTkuOTUNCj4gdy8gIC1XOiAxMS43Nw0KPiANCj4gDQo+IEZvciBnb29kIG1lYXN1cmUsIG9u
IHRtcGZzOg0KPiANCj4gQmVmb3JlOg0KPiB3L28gLVc6IDYuOTgNCj4gdy8gIC1XOiA2Ljc1DQo+
IA0KPiBBZnRlcjoNCj4gdy9vIC1XOiA3LjA0DQo+IHcvICAtVzogMy42Mw0KPiANCj4gDQo+IFNv
IGl0IGxvb2tzIGxpa2UgdGhlIHJlc3VsdHMgd2l0aCBjYWNoZSBlbmFibGVkIGFyZSByZWFsbHkg
b25seSBpbiB0aGUNCj4gY2FjaGUuICBXaGVuIGl0IGdvZXMgZG93biB0byBkaXNrLCB0aGlzIHNl
cmllcyBzZWVtcyB0byBkZWNyZWFzZQ0KPiBwZXJmb3JtYW5jZS4NCj4gDQo+IFRvIGNvbmZpcm0g
d2hldGhlciB0aGF04oCZcyBhY3R1YWxseSB0aGUgY2FzZSwgSSB0b29rIGFub3RoZXIgbWFjaGlu
ZSB3aXRoDQo+IGFuIFNTRCB3aGVyZSBJIGhhdmUgbW9yZSBlbXB0eSBzcGFjZSBhbmQgaW5jcmVh
c2VkIHRoZSBzaXplIHRvIDggR0IgKG5vdA0KPiB0aGUgJHNpemUsIGJlY2F1c2UgcWVtdS1pbyBk
b2Vzbid0IGxpa2UgdGhhdCwgYnV0IHdlbGwsIHllYWgpLCBhbmQgdGhlbg0KPiByYW4gaXQgYWdh
aW4gd2l0aG91dCBjYWNoZToNCj4gDQo+IEJlZm9yZToNCj4gdy9vIC1XOiB+NTAgLSB+NjAgKHZh
cmllcy4uLikNCj4gdy8gIC1XOiB+NTAgLSB+NzANCj4gDQo+IEFmdGVyOg0KPiB3L28gLVc6IH42
MA0KPiB3LyAgLVc6IH41NSAtIH44NQ0KPiANCj4gDQo+IFNvIGl0IGRvZXMgc2VlbSBzbG93ZXIs
IGFsdGhvdWdoIHRoZSB2YWx1ZXMgdmFyeSBzbyBtdWNoIHRoYXQgaXTigJlzDQo+IGRpZmZpY3Vs
dCB0byB0ZWxsLg0KPiANCj4gSG1tLi4uICBBbmQgb24gdGhhdCBtYWNoaW5lLCB0aGVyZSBpcyBu
byBkaWZmZXJlbmNlIGJldHdlZW4gYmVmb3JlIGFuZA0KPiBhZnRlciB3aGVuIHVzaW5nIC10IG5v
bmUuICBTbyBJIHN1cHBvc2UgaXQgYWxzbyBkZXBlbmRzIG9uIHRoZSBkZXZpY2U/DQo+IA0KPiAN
Cj4gDQo+IE9LLCBJIHRyaWVkIHVzaW5nIHFlbXUtaW1nIGJlbmNoLiAgQWZ0ZXIgcGF0Y2hpbmcg
aXQgdG8gYWNjZXB0IC0tb2JqZWN0LA0KPiB0aGVzZSBhcmUgdGhlIHJlc3VsdHMgSSBnb3Qgd2l0
aCAtdCBub25lIC13IG9uIGEgcHJlYWxsb2NhdGVkIChmdWxsKSA4DQo+IEdCIGltYWdlOg0KPiAN
Cj4gQmVmb3JlOg0KPiBIREQ6IDE3LjcgcywgMTcuOCBzLCAxOC4wIHMNCj4gU1NEIDE6IDEyLjkg
cywgMTUuOCBzLCAxNS4xIHMNCj4gU1NEIDI6IDEuOCBzLCAxLjcgcywgMS43IHMNCj4gDQo+IEFm
dGVyOg0KPiBIREQ6IDE2LjEgcywgMTUuOCBzLCAxNS44IHMNCj4gU1NEIDE6IDE2LjMgcywgMTgu
MCBzLCAxNy45IHMNCj4gU1NEIDI6IDIuMCBzLCAxLjUgcywgMS41IHMNCj4gDQo+IFJlc3VsdCAj
MTogTXkgU1NEIDEgaXMgdHJhc2guDQo+IA0KPiBSZXN1bHQgIzI6IEkgbmVlZCBtb3JlIHJlcXVl
c3RzIGZvciBTU0QgMiB0byBnZXQgYSB1c2VmdWwgcmVzdWx0cy4NCj4gTGV0J3MgdHJ5IGFnYWlu
IHdpdGggMl4yMDoNCj4gQmVmb3JlOiAyMy44LCAyMy41LCAyMy4zDQo+IEFmdGVyOiAgMjEuMCwg
MjAuNiwgMjAuNQ0KPiANCj4gT0ssIGFuZCBJIGNhbiBjbGVhcmx5IHNlZSB0aGF0IHRoaXMgc2Vy
aWVzIGluY3JlYXNlcyB0aGUgQ1BVIHVzYWdlDQo+ICh3aGljaCBpcyBnb29kKS4NCj4gDQo+IA0K
PiBTby4uLiAgSG0uICBJIHN1cHBvc2UgSSBjb25jbHVkZSB0aGF0IHRoaXMgc2VyaWVzIGRlY3Jl
YXNlcyBwZXJmb3JtYW5jZQ0KPiBvbiB0cmFzaHkgU1NEcz8gIEJ1dCBpdCBnZXRzIGJldHRlciBv
biBteSBIREQgYW5kIG9uIG15IGdvb2QgU1NELCBzby4uLg0KPiAgIEdvb2QgdGhpbmcgSSB0ZXN0
ZWQgaXQsIG9yIHNvbWV0aGluZy4NCg0KSW50ZXJlc3RpbmcsIHRoYW5rcyBmb3IgdGVzdGluZyEg
Tm8gaWRlYSBhYm91dCBkZWdyYWRhdGlvbiBvbiBiYWQgU1NELi4NCllvdSBjYW4gdHJ5IHRvIGNo
ZWNrIHRocmVhZHMgb3ZlcmhlYWQgYnkgc2V0IFFDT1cyX01BWF9USFJFQURTIHRvIDEuLg0KDQoN
Cj4gDQo+IFRoZSBvbmx5IHJlYWxseSBpbnRlcmVzdGluZyB0aGluZyB0aGF0IGNhbWUgb3V0IG9m
IHRoaXMgaXMgdGhhdCBJIGRpZG4ndA0KPiBzZWUgYW4gaW1wcm92ZW1lbnQgd2l0aCBxZW11LWlt
ZyBjb252ZXJ0IChvbmx5IG9uIHRtcGZzKSwgYnV0IHRoYXQgSSBkbw0KPiBzZWUgaXQgd2l0aCBx
ZW11LWltZyBiZW5jaC4gIFNvIEknbSB3b25kZXJpbmcgd2h5IHlvdSBhcmVuJ3QgdXNpbmcNCj4g
cWVtdS1pbWcgYmVuY2ggaW4gdGhlIHRlc3QgaW4geW91ciBmaXJzdCBwYXRjaC4uLj8NCj4gDQoN
CnRoZSBpZGVhIHdhcyB0aGF0IHBlcmZvcm1hbmNlIHRlc3RzIHNob3VsZCBkbyBvbmUgcnVuLCBh
bmQgdGhlcmUgc2hvdWxkIGJlDQpjb21tb24gc2NyaXB0IHRvIHJ1biB0ZXN0IHNldmVyYWwgdGlt
ZXMgYW5kIGNhbGN1bGF0ZSBvdmVyYWdlLg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGlt
aXINCg==

