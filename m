Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB97C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 14:43:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DACA8206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 14:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cYEBjvpo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DACA8206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiJzq-00006A-3t
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 10:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52020)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hiJyM-0007s4-5W
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:41:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hiJyK-00068C-NY
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:41:30 -0400
Received: from mail-eopbgr10138.outbound.protection.outlook.com
 ([40.107.1.138]:21991 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1hiJyJ-00064y-Ll; Tue, 02 Jul 2019 10:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRksMA0bSzSAtwsAbnqpYDJOj/jjiO9Pp5Iz1YDY8G4=;
 b=cYEBjvpon+NotnOhFATRCT9hvadojDRGFen/Zh/Q3twDFGKPaPqOt8idDaHPpEhWlpySs4xFvUTrQqB/fXT4EKRYsBJEOPSuZZpGfQEoVLEO5loF3lBlterEAtiOGIQcGgxcp0Wqb7xSSPbgXXUewR9Nf8LtVEV3FH/oOtklvo4=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB3316.eurprd08.prod.outlook.com (52.134.94.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.18; Tue, 2 Jul 2019 14:41:23 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::44eb:4518:e1f2:144c]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::44eb:4518:e1f2:144c%7]) with mapi id 15.20.2032.019; Tue, 2 Jul 2019
 14:41:23 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [Qemu-devel] [Qemu-block] [PATCH] blk: postpone request
 execution on a context protected with "drained section"
Thread-Index: AQHUjignkofN8gw/f0Gq8XBVqGcZF6V5+nkAgAEUmYCAAa8WAP//4guAgAG9WoCAi/MFgIAfI2CAgArmNACAcq2uAIAAC++AgATlsYCAAxPMgIADMYcAgAZtVoA=
Date: Tue, 2 Jul 2019 14:41:23 +0000
Message-ID: <b89dff2a-82ed-5ee9-0092-b4041647f0fd@virtuozzo.com>
References: <d0d2cab4-2157-1f9f-3bc9-a70f28a211b0@virtuozzo.com>
 <20181213122039.GC5427@linux.fritz.box>
 <f2fcbcc2-5e0f-053d-f4c7-fe0f5f6092f0@virtuozzo.com>
 <20190313160412.GF5167@linux.fritz.box>
 <101bbf98-0456-5022-e117-fd6f693a8786@virtuozzo.com>
 <20190409100142.GC6610@localhost.localdomain>
 <20190621091656.GA9744@localhost.localdomain>
 <d2ad5561-1806-d885-350a-b43dd0fe4339@virtuozzo.com>
 <ce694324-a2fd-2f03-351a-e54bc05973f1@virtuozzo.com>
 <08004ed8-73ba-1f36-ff46-ba29aba02c66@virtuozzo.com>
 <20190628123228.GJ5179@dhcp-200-226.str.redhat.com>
In-Reply-To: <20190628123228.GJ5179@dhcp-200-226.str.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0254.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::30) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: baa0aba7-f05f-494b-184a-08d6fefb5ac2
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB3316; 
x-ms-traffictypediagnostic: AM0PR08MB3316:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR08MB3316704BFB1D46A3EDC05BAACFF80@AM0PR08MB3316.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(366004)(396003)(39850400004)(136003)(199004)(189003)(81156014)(6436002)(229853002)(52116002)(81166006)(966005)(6916009)(386003)(6512007)(36756003)(99286004)(26005)(305945005)(7736002)(4326008)(8936002)(256004)(14444005)(68736007)(6486002)(6506007)(53546011)(6306002)(25786009)(71190400001)(102836004)(316002)(5660300002)(71200400001)(31686004)(66446008)(8676002)(53936002)(86362001)(54906003)(66476007)(66066001)(478600001)(66556008)(186003)(446003)(66946007)(2616005)(476003)(31696002)(11346002)(2906002)(6116002)(76176011)(6246003)(486006)(3846002)(64756008)(14454004)(73956011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3316;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IVnHQtEpoexFh0qa0DrDP9UiuQf5nwcQFGoQDcxebvigMOMc9NqI2LQXrnYZqWCKbuaLicfq1/hY15WuBooITUE6FCxMPZ4uMqtwj4vN4CHQFeQA+q9PyG6bfFNLUqT6SiYy4bnM/7IfG+jk+33tejNBWTrDxrN5jCd1WXCjBLVINoTy9Spo+8XA9KoxZtxLfwgBHrk4irj4SMLa0LXAqt9Ggr2E0YYKSQnHaeabruvwo5TUIZjV5mNDwBfLoskz3fmHC5Nn4/O6HEAow63bj4sX3ZJz48JegKdOJ4fxtnPc7ljEphig4YECaWskMDWaG3A4BcCZpwU6u+XHZcWbIn+tpTcDI2nM1vt0sU/FSNOSfYn4RP9hYo3tUgrhGam38wcBGbdnPgv1/L/4KXz/gQc8I9P2owiCWYZ8Wzgfo08=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11D7854E67E22746862C77D75641F0B3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baa0aba7-f05f-494b-184a-08d6fefb5ac2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 14:41:23.5368 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dplotnikov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3316
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.138
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] blk: postpone request
 execution on a context protected with "drained section"
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "keith.busch@intel.com" <keith.busch@intel.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDI4LjA2LjIwMTkgMTU6MzIsIEtldmluIFdvbGYgd3JvdGU6DQo+IEFtIDI2LjA2LjIw
MTkgdW0gMTA6NDYgaGF0IERlbmlzIFBsb3RuaWtvdiBnZXNjaHJpZWJlbjoNCj4+IE9uIDI0LjA2
LjIwMTkgMTI6NDYsIERlbmlzIFBsb3RuaWtvdiB3cm90ZToNCj4+PiBPbiAyMS4wNi4yMDE5IDEy
OjU5LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4+PiAyMS4wNi4yMDE5
IDEyOjE2LCBLZXZpbiBXb2xmIHdyb3RlOg0KPj4+Pj4gQW0gMDkuMDQuMjAxOSB1bSAxMjowMSBo
YXQgS2V2aW4gV29sZiBnZXNjaHJpZWJlbjoNCj4+Pj4+PiBBbSAwMi4wNC4yMDE5IHVtIDEwOjM1
IGhhdCBEZW5pcyBQbG90bmlrb3YgZ2VzY2hyaWViZW46DQo+Pj4+Pj4+IE9uIDEzLjAzLjIwMTkg
MTk6MDQsIEtldmluIFdvbGYgd3JvdGU6DQo+Pj4+Pj4+PiBBbSAxNC4xMi4yMDE4IHVtIDEyOjU0
IGhhdCBEZW5pcyBQbG90bmlrb3YgZ2VzY2hyaWViZW46DQo+Pj4+Pj4+Pj4gT24gMTMuMTIuMjAx
OCAxNToyMCwgS2V2aW4gV29sZiB3cm90ZToNCj4+Pj4+Pj4+Pj4gQW0gMTMuMTIuMjAxOCB1bSAx
MjowNyBoYXQgRGVuaXMgUGxvdG5pa292IGdlc2NocmllYmVuOg0KPj4+Pj4+Pj4+Pj4gU291bmRz
IGl0IHNob3VsZCBiZSBzbywgYnV0IGl0IGRvZXNuJ3Qgd29yayB0aGF0IHdheSBhbmQgdGhhdCdz
IHdoeToNCj4+Pj4+Pj4+Pj4+IHdoZW4gZG9pbmcgbWlycm9yIHdlIG1heSByZXN1bWUgcG9zdHBv
bmVkIGNvcm91dGluZXMgdG9vIGVhcmx5IHdoZW4gdGhlDQo+Pj4+Pj4+Pj4+PiB1bmRlcmx5aW5n
IGJzIGlzIHByb3RlY3RlZCBmcm9tIHdyaXRpbmcgYXQgYW5kIHRodXMgd2UgZW5jb3VudGVyIHRo
ZQ0KPj4+Pj4+Pj4+Pj4gYXNzZXJ0IG9uIGEgd3JpdGUgcmVxdWVzdCBleGVjdXRpb24gYXQgYmRy
dl9jb193cml0ZV9yZXFfcHJlcGFyZSB3aGVuDQo+Pj4+Pj4+Pj4+PiByZXN1bWluZyB0aGUgcG9z
dHBvbmVkIGNvcm91dGluZXMuDQo+Pj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+Pj4gVGhlIHRoaW5nIGlz
IHRoYXQgdGhlIGJzIGlzIHByb3RlY3RlZCBmb3Igd3JpdGluZyBiZWZvcmUgZXhlY3V0aW9uIG9m
DQo+Pj4+Pj4+Pj4+PiBiZHJ2X3JlcGxhY2Vfbm9kZSBhdCBtaXJyb3JfZXhpdF9jb21tb24gYW5k
IGJkcnZfcmVwbGFjZV9ub2RlIGNhbGxzDQo+Pj4+Pj4+Pj4+PiBiZHJ2X3JlcGxhY2VfY2hpbGRf
bm9wZXJtIHdoaWNoLCBpbiB0dXJuLCBjYWxscyBjaGlsZC0+cm9sZS0+ZHJhaW5lZF9lbmQNCj4+
Pj4+Pj4+Pj4+IHdoZXJlIG9uZSBvZiB0aGUgY2FsbGJhY2tzIGlzIGJsa19yb290X2RyYWluZWRf
ZW5kIHdoaWNoIGNoZWNrDQo+Pj4+Pj4+Pj4+PiBpZigtLWJsay0+cXVpZXNjZV9jb3VudGVyID09
IDApIGFuZCBydW5zIHRoZSBwb3N0cG9uZWQgcmVxdWVzdHMNCj4+Pj4+Pj4+Pj4+IChjb3JvdXRp
bmVzKSBpZiB0aGUgY291bmRpdGlvbiBpcyB0cnVlLg0KPj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+PiBI
bSwgc28gc29tZXRoaW5nIGlzIG1lc3NlZCB1cCB3aXRoIHRoZSBkcmFpbiBzZWN0aW9ucyBpbiB0
aGUgbWlycm9yDQo+Pj4+Pj4+Pj4+IGRyaXZlci4gV2UgaGF2ZToNCj4+Pj4+Pj4+Pj4NCj4+Pj4+
Pj4+Pj4gICAgICAgICAgIGJkcnZfZHJhaW5lZF9iZWdpbih0YXJnZXRfYnMpOw0KPj4+Pj4+Pj4+
PiAgICAgICAgICAgYmRydl9yZXBsYWNlX25vZGUodG9fcmVwbGFjZSwgdGFyZ2V0X2JzLCAmbG9j
YWxfZXJyKTsNCj4+Pj4+Pj4+Pj4gICAgICAgICAgIGJkcnZfZHJhaW5lZF9lbmQodGFyZ2V0X2Jz
KTsNCj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4gT2J2aW91c2x5LCB0aGUgaW50ZW50aW9uIHdhcyB0
byBrZWVwIHRoZSBCbG9ja0JhY2tlbmQgZHJhaW5lZCBkdXJpbmcNCj4+Pj4+Pj4+Pj4gYmRydl9y
ZXBsYWNlX25vZGUoKS4gU28gaG93IGNvdWxkIGJsay0+cXVpZXNjZV9jb3VudGVyIGV2ZXIgZ2V0
IHRvIDANCj4+Pj4+Pj4+Pj4gaW5zaWRlIGJkcnZfcmVwbGFjZV9ub2RlKCkgd2hlbiB0YXJnZXRf
YnMgaXMgZHJhaW5lZD8NCj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4gTG9va2luZyBhdCBiZHJ2X3Jl
cGxhY2VfY2hpbGRfbm9wZXJtKCksIGl0IHNlZW1zIHRoYXQgdGhlIGZ1bmN0aW9uIGhhcw0KPj4+
Pj4+Pj4+PiBhIGJ1ZzogRXZlbiBpZiBvbGRfYnMgYW5kIG5ld19icyBhcmUgYm90aCBkcmFpbmVk
LCB0aGUgcXVpZXNjZV9jb3VudGVyDQo+Pj4+Pj4+Pj4+IGZvciB0aGUgcGFyZW50IHJlYWNoZXMg
MCBmb3IgYSBtb21lbnQgYmVjYXVzZSB3ZSBjYWxsIC5kcmFpbmVkX2VuZCBmb3INCj4+Pj4+Pj4+
Pj4gdGhlIG9sZCBjaGlsZCBmaXJzdCBhbmQgLmRyYWluZWRfYmVnaW4gZm9yIHRoZSBuZXcgb25l
IGxhdGVyLg0KPj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+PiBTbyBpdCBzZWVtcyB0aGUgZml4IHdvdWxk
IGJlIHRvIHJldmVyc2UgdGhlIG9yZGVyIGFuZCBmaXJzdCBjYWxsDQo+Pj4+Pj4+Pj4+IC5kcmFp
bmVkX2JlZ2luIGZvciB0aGUgbmV3IGNoaWxkIGFuZCB0aGVuIC5kcmFpbmVkX2VuZCBmb3IgdGhl
IG9sZA0KPj4+Pj4+Pj4+PiBjaGlsZC4gU291bmRzIGxpa2UgYSBnb29kIG5ldyB0ZXN0Y2FzZSBm
b3IgdGVzdHMvdGVzdC1iZHJ2LWRyYWluLmMsIHRvby4NCj4+Pj4+Pj4+PiBZZXMsIGl0J3MgdHJ1
ZSwgYnV0IGl0J3Mgbm90IGVub3VnaC4uLg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IERpZCB5b3UgZXZl
ciBpbXBsZW1lbnQgdGhlIGNoYW5nZXMgc3VnZ2VzdGVkIHNvIGZhciwgc28gdGhhdCB3ZSBjb3Vs
ZA0KPj4+Pj4+Pj4gY29udGludWUgZnJvbSB0aGVyZT8gT3Igc2hvdWxkIEkgdHJ5IGFuZCBjb21l
IHVwIHdpdGggc29tZXRoaW5nIG15c2VsZj8NCj4+Pj4+Pj4NCj4+Pj4+Pj4gU29ycnkgZm9yIHRo
ZSBsYXRlIHJlcGx5Li4uDQo+Pj4+Pj4+IFllcywgSSBkaWQgLi4uDQo+Pj4+Pj4NCj4+Pj4+PiBJ
ZiB0aGVyZSBhcmUgbW9yZSBxdWVzdGlvbiBvciBwcm9ibGVtcywgY2FuIHlvdSBwb3N0IHRoZSBw
YXRjaGVzIGluDQo+Pj4+Pj4gdGhlaXIgY3VycmVudCBzaGFwZSAoYXMgYW4gUkZDKSBvciBhIGdp
dCBVUkwgc28gSSBjYW4gcGxheSB3aXRoIGl0IGENCj4+Pj4+PiBiaXQ/IElmIHlvdSBjb3VsZCBp
bmNsdWRlIGEgZmFpbGluZyB0ZXN0IGNhc2UsIHRvbywgdGhhdCB3b3VsZCBiZSBpZGVhbC4NCj4+
Pj4+DQo+Pj4+PiBEZW5pcz8gUGxlYXNlPw0KPj4+Pj4NCj4+Pj4+IFdlIHJlYWxseSBzaG91bGQg
Z2V0IHRoaXMgZml4ZWQgYW5kIEkgd291bGQgYmUgd2lsbGluZyB0byBsZW5kIGEgaGFuZCwNCj4+
Pj4+IGJ1dCBpZiB5b3Uga2VlcCB5b3VyIHBhdGNoZXMgc2VjcmV0LCBJIGNhbid0IHJlYWxseSBk
byBzbyBhbmQgd291bGQgaGF2ZQ0KPj4+Pj4gdG8gZHVwbGljYXRlIHlvdXIgd29yay4NCj4+Pj4+
DQo+Pj4+PiBBbHNvLCBwbGVhc2Ugc2VlIG15IG9sZCBhbnN3ZXIgZnJvbSBBcHJpbCBiZWxvdyBm
b3IgdGhlIGxhc3QgcHJvYmxlbSB5b3UNCj4+Pj4+IGhhZCB3aXRoIGltcGxlbWVudGluZyB0aGUg
Y29ycmVjdCBhcHByb2FjaC4NCj4+Pj4+DQo+Pj4+PiBLZXZpbg0KPj4+DQo+Pj4gSGkgS2V2aW4s
DQo+Pj4gSSdtIHNvcnJ5IGZvciBub3QgcmVwbHlpbmcgZm9yIHNvIGxvbmcuIFBsZWFzZSwgZ2l2
ZSBtZSBzb21lIHRpbWUgKGEgZGF5DQo+Pj4gb3IgdHdvKSBzbyBJIGNvdWxkIHJlZnJlc2ggZXZl
cnl0aGluZyBhbmQgc2VuZCB0aGUgY3VycmVudCBzdGF0ZSBvZiB0aGUNCj4+PiBwYXRjaGVzIGFz
IHdlbGwgYXMgdGhlIHRlc3QgY2FzZSBjaGVja2luZyB0aGUgaXNzdWUNCj4+DQo+PiBIaSBLZXZp
biwNCj4+IFRoZSBjdXJyZW50IHN0YXRlIG9mIHRoZSBwYXRjaGVzIGlzIGF2YWlsYWJsZSBhdA0K
Pj4gaHR0cHM6Ly9naXRodWIuY29tL2RlbmlzLXBsb3RuaWtvdi9xZW11L3RyZWUvcG9zdHBvbmVk
LXJlcXVlc3QNCj4gDQo+IEFyZSB5b3Ugc3VyZSB5b3UgcHVzaGVkIHRoZSBjb3JyZWN0IHZlcnNp
b24/DQo+IA0KPiBJIGRvbid0IHNlZSBhbnkgb2YgdGhlIHRoaW5ncyB3ZSBkaXNjdXNzZWQgYWJv
dmUgaW4gdGhpcyBicmFuY2gsIGkuZS4NCj4gdXNpbmcgYmxrX3Jvb3RfZHJhaW5lZF9iZWdpbi9l
bmQsIGZpeGluZyBiZHJ2X3JlcGxhY2VfY2hpbGRfbm9wZXJtKCksDQo+IGZpeGluZyB0aGUgZHJh
aW4gY2FsbHMgaW4gbWlycm9yIGV0Yy4NCkkgZGlkbid0IGluY2x1ZGUgdGhlbSBpbnRlbnRpb25h
bGx5IGJlY2F1c2UgSSBkaWRuJ3QgbWFuYWdlIHRvIG1ha2UgdGhlbSANCndvcmsuIEkganVzdCBz
dGljayB3aXRoIHNvbWV0aGluZyB0aGF0IHdvcmsgbW9yZSBvciBsZXNzIG9rLg0KSWYgeW91IHdh
bnQsIEkgY2FuIGRvIHRoZSByZWxhdGVkIG1vZGlmaWNhdGlvbnMgaW4gYSBzZXBhcmF0ZSBicnVu
Y2ggc28gDQp5b3UgY2FuIHRyeSB0aGVtIGJ5IHlvdXJzZWxmLg0KDQpEZW5pcw0KPiANCj4+IEkg
ZGlkbid0IG1hbmFnZSB0byBjcmVhdGUgYW4gYXV0b21hdGljIHJlcHJvZHVjZXIgYnV0IG9uZSBv
ZiB0aGUgcGF0Y2hlcw0KPj4gY29udGFpbnMgYSBzdGVwLWJ5LXN0ZXAgZGVzY3JpcHRpb24gb2Yg
aG93IHRvIHJlcHJvZHVjZSB0aGUgcHJvYmxlbS4NCj4gDQo+IE9rLCBJJ2xsIHRyeSB3aGV0aGVy
IEkgY2FuIHJlcHJvZHVjZSB0aGlzLg0KPiANCj4gS2V2aW4NCj4gDQoNCi0tIA0KQmVzdCwNCkRl
bmlzDQo=

