Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DFDC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:11:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1B5D2183E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Ew+Xw8nl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B5D2183E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53630 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbpjU-0007FL-6F
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 13:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45516)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbpEy-0005IZ-Vy
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 12:39:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbpEx-0007iw-0a
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 12:39:48 -0400
Received: from mail-eopbgr40107.outbound.protection.outlook.com
 ([40.107.4.107]:5767 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbpEv-0007bR-Ec; Fri, 14 Jun 2019 12:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TGLnP9J7Myfo7O+zocYWivM/1AZEhLEIk/kaeNIqwo=;
 b=Ew+Xw8nleSS59hTQCQ1bvD3wBN7i2IiSA3sFh/nVBQD+jqiSwW5SbzTjziGGvYGosQOhfPfNSYLsdBO6yVEdy/vu/b+M9CSUI2TlC9pNnN57IXEPJmDWN3mMfPbUZWvWnz09yQGBjj478Ibz10u2KH7uDPCYsngmQZvvIHvxY6c=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0SPR01MB0059.eurprd08.prod.outlook.com (20.178.117.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Fri, 14 Jun 2019 16:39:32 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Fri, 14 Jun 2019
 16:39:32 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 14/42] block: Use CAFs when working with backing chains
Thread-Index: AQHVIWuuPVMblAMNYkC6XowcCoyrZaabJqGAgAAGwYCAAD3OAP//5w6AgAAKZAA=
Date: Fri, 14 Jun 2019 16:39:31 +0000
Message-ID: <0800b03a-9209-3243-49a5-5102ec4dc36c@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-15-mreitz@redhat.com>
 <837ee511-af51-3062-8a2e-41adde1023b3@virtuozzo.com>
 <616b970a-2c06-11d8-8f91-c607fd986e18@redhat.com>
 <bfa2b6e6-7b5a-78c5-abb5-51c000fc81be@virtuozzo.com>
 <bc9cd825-3cd9-239b-0980-950e6489be6a@redhat.com>
In-Reply-To: <bc9cd825-3cd9-239b-0980-950e6489be6a@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0502CA0022.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::32) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190614193930372
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90eb744a-f0f2-46c0-dc9a-08d6f0e6e064
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0SPR01MB0059; 
x-ms-traffictypediagnostic: AM0SPR01MB0059:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0SPR01MB0059F0621B3DB48B1D697EA0C1EE0@AM0SPR01MB0059.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(366004)(346002)(39850400004)(376002)(136003)(396003)(189003)(199004)(2501003)(6246003)(54906003)(25786009)(478600001)(110136005)(52116002)(3846002)(966005)(76176011)(8936002)(14454004)(2906002)(99286004)(31686004)(256004)(36756003)(8676002)(14444005)(5660300002)(81156014)(81166006)(316002)(71190400001)(71200400001)(386003)(53936002)(4326008)(6436002)(486006)(6486002)(6116002)(102836004)(66066001)(31696002)(53546011)(6506007)(86362001)(26005)(476003)(68736007)(6512007)(186003)(11346002)(6306002)(446003)(2616005)(64756008)(66446008)(7736002)(66946007)(229853002)(73956011)(305945005)(66556008)(66476007)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0SPR01MB0059;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: G6meGzeCKPOhd2JYCdq9FUGH+W82F60n9ysVRwVZZZZjEOGCRFcJLN3tyQ54nxkqFblQIvMktXClLzOQDT/uYPr/DFTAXHbdYoATAIajBQTgGmdB0vD+9PvYuTK9TPIjrUkoMFPT+Bg4oyaodnNm5JUZW8faTdBMyiYedxqKt6H3RHTr+HCUJAvmCIzOUji9V7cXjrgaU6v/FK0XTrjRAPiWM8XKMT7T+eBJFf4kD0t5+qOj35XkccTDcWwcYxPprgcr6tt151eOQE4yEZPFR1YsU7FcOVWuiP4JC06s6jDilGbmGQX+RJ0RMxhhUgPACAgyT4+YylWe6VTHtzTMEylFrUg1llDc1Ib/yhc47QbxZnUTtndVjTAKBSydksxqB94MXPB2AMO7sHGZYW/XWKITD5gqeI103O1rRJ0sfj0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBBD2A396E9E414689B200A2C4E8B98B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90eb744a-f0f2-46c0-dc9a-08d6f0e6e064
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 16:39:31.9503 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0SPR01MB0059
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.107
Subject: Re: [Qemu-devel] [PATCH v5 14/42] block: Use CAFs when working with
 backing chains
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTQuMDYuMjAxOSAxOTowMiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxNC4wNi4xOSAxNjozMSwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDE0LjA2LjIwMTkgMTY6NTAs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAxNC4wNi4xOSAxNToyNiwgVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gMTMuMDYuMjAxOSAxOjA5LCBNYXggUmVpdHogd3Jv
dGU6DQo+Pj4+PiBVc2UgY2hpbGQgYWNjZXNzIGZ1bmN0aW9ucyB3aGVuIGl0ZXJhdGluZyB0aHJv
dWdoIGJhY2tpbmcgY2hhaW5zIHNvDQo+Pj4+PiBmaWx0ZXJzIGRvIG5vdCBicmVhayB0aGUgY2hh
aW4uDQo+Pj4+Pg0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogTWF4IFJlaXR6IDxtcmVpdHpAcmVkaGF0
LmNvbT4NCj4+Pj4+IC0tLQ0KPj4+Pj4gICAgIGJsb2NrLmMgfCA0MCArKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0tLS0tDQo+Pj4+PiAgICAgMSBmaWxlIGNoYW5nZWQsIDI4IGlu
c2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KPj4+Pj4NCj4+Pj4+IGRpZmYgLS1naXQgYS9i
bG9jay5jIGIvYmxvY2suYw0KPj4+Pj4gaW5kZXggMTFmMzc5ODNkOS4uNTA1YjNlOWEwMSAxMDA2
NDQNCj4+Pj4+IC0tLSBhL2Jsb2NrLmMNCj4+Pj4+ICsrKyBiL2Jsb2NrLmMNCj4+Pg0KPj4+IFsu
Li5dDQo+Pj4NCj4+Pj4+IEBAIC00MjczLDExICs0Mjc0LDE4IEBAIGludCBiZHJ2X2NoYW5nZV9i
YWNraW5nX2ZpbGUoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+Pj4+PiAgICAgQmxvY2tEcml2ZXJT
dGF0ZSAqYmRydl9maW5kX292ZXJsYXkoQmxvY2tEcml2ZXJTdGF0ZSAqYWN0aXZlLA0KPj4+Pj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJsb2NrRHJpdmVyU3RhdGUg
KmJzKQ0KPj4+Pj4gICAgIHsNCj4+Pj4+IC0gICAgd2hpbGUgKGFjdGl2ZSAmJiBicyAhPSBiYWNr
aW5nX2JzKGFjdGl2ZSkpIHsNCj4+Pj4+IC0gICAgICAgIGFjdGl2ZSA9IGJhY2tpbmdfYnMoYWN0
aXZlKTsNCj4+Pj4+ICsgICAgYnMgPSBiZHJ2X3NraXBfcndfZmlsdGVycyhicyk7DQo+Pj4+PiAr
ICAgIGFjdGl2ZSA9IGJkcnZfc2tpcF9yd19maWx0ZXJzKGFjdGl2ZSk7DQo+Pj4+PiArDQo+Pj4+
PiArICAgIHdoaWxlIChhY3RpdmUpIHsNCj4+Pj4+ICsgICAgICAgIEJsb2NrRHJpdmVyU3RhdGUg
Km5leHQgPSBiZHJ2X2JhY2tpbmdfY2hhaW5fbmV4dChhY3RpdmUpOw0KPj4+Pj4gKyAgICAgICAg
aWYgKGJzID09IG5leHQpIHsNCj4+Pj4+ICsgICAgICAgICAgICByZXR1cm4gYWN0aXZlOw0KPj4+
Pj4gKyAgICAgICAgfQ0KPj4+Pj4gKyAgICAgICAgYWN0aXZlID0gbmV4dDsNCj4+Pj4+ICAgICAg
ICAgfQ0KPj4+Pj4gICAgIA0KPj4+Pj4gLSAgICByZXR1cm4gYWN0aXZlOw0KPj4+Pj4gKyAgICBy
ZXR1cm4gTlVMTDsNCj4+Pj4+ICAgICB9DQo+Pj4+DQo+Pj4+IFNlbWFudGljcyBjaGFuZ2VkIGZv
ciB0aGlzIGZ1bmN0aW9uLg0KPj4+PiBJdCBpcyB1c2VkIGluIHR3byBwbGFjZXMNCj4+Pj4gMS4g
ZnJvbSBiZHJ2X2ZpbmRfYmFzZSB3dGloIEBicz1OVUxMLCBpdCBzaG91bGQgYmUgdW5jaGFuZ2Vk
LCBhcyBJIGhvcGUgd2Ugd2lsbCBuZXZlciBoYXZlDQo+Pj4+ICAgICAgIGZpbHRlciBub2RlIGFz
IGEgYm90dG9tIG9mIHNvbWUgdmFsaWQgY2hhaW4NCj4+Pj4NCj4+Pj4gMi4gZnJvbSBxbXBfYmxv
Y2tfY29tbWl0LCBvbmx5IHRvIGNoZWNrIG9wLWJsb2NrZXIuLi4gaG1tbS4gSSByZWFsbHkgZG9u
J3QgdW5kZXJzdGFuZCwNCj4+Pj4gd2h5IGRvIHdlIGNoZWNrIEJMT0NLX09QX1RZUEVfQ09NTUlU
X1RBUkdFVCBvbiB0b3BfYnMgb3ZlcmxheS4uIHRvcF9icyBvdmVybGF5IGlzIG91dCBvZiB0aGUg
am9iLA0KPj4+PiB3aGF0IGlzIHRoaXMgY2hlY2sgZm9yPw0KPj4+DQo+Pj4gVGhlcmUgaXMgYSBs
b29wIGJlZm9yZSB0aGlzIGNoZWNrIHdoaWNoIGNoZWNrcyB0aGF0IHRoZSBzYW1lIGJsb2NrZXIg
aXMNCj4+PiBub3Qgc2V0IG9uIGFueSBub2RlcyBiZXR3ZWVuIHRvcCBhbmQgYmFzZSAoYm90aCBp
bmNsdXNpdmUpLiAgSSBndWVzcw0KPj4+IG5vbi1hY3RpdmUgY29tbWl0IGNoZWNrcyB0aGUgbm9k
ZSBhYm92ZSBAdG9wLCB0b28sIGJlY2F1c2UgaXRzIGJhY2tpbmcNCj4+PiBmaWxlIHdpbGwgY2hh
bmdlLg0KPj4NCj4+IFNvIGluIHRoaXMgY2FzZSBmcm96ZW4gY2hhaW4gd29ya3MgYmV0dGVyLg0K
PiANCj4gUGVyaGFwcy4gIFRoZSBvcCBibG9ja2VycyBhcmUgaW4gdGhpcyB3ZWlyZCBzdGF0ZSBh
bnl3YXkuICBJIGRvbuKAmXQgdGhpbmsNCj4gd2UgZXZlbiBuZWVkIHRoZW0gYW55IG1vcmUsIGJl
Y2F1c2UgdGhlIHBlcm1pc3Npb25zIHdlcmUgaW50ZW5kZWQgdG8NCj4gcmVwbGFjZSB0aGVtICh0
aGV5IHdlcmUgb3JpZ2luYWxseSBjYWxsZWQg4oCcZmluZS1ncmFpbmVkIG9wIGJsb2NrZXJz4oCd
LCBJDQo+IHNlZW0gdG8gcmVtZW1iZXIpLg0KPiANCj4gSSBkYXJlIG5vdCB0b3VjaCB0aGVtLg0K
PiANCj4+Pj4+ICAgICAvKiBHaXZlbiBhIEJEUywgc2VhcmNoZXMgZm9yIHRoZSBiYXNlIGxheWVy
LiAqLw0KPj4+DQo+Pj4gWy4uLl0NCj4+Pg0KPj4+Pj4gQEAgLTUxNDksNyArNTE2NSw3IEBAIEJs
b2NrRHJpdmVyU3RhdGUgKmJkcnZfZmluZF9iYWNraW5nX2ltYWdlKEJsb2NrRHJpdmVyU3RhdGUg
KmJzLA0KPj4+Pj4gICAgICAgICAgICAgICAgIGNoYXIgKmJhY2tpbmdfZmlsZV9mdWxsX3JldDsN
Cj4+Pj4+ICAgICANCj4+Pj4+ICAgICAgICAgICAgICAgICBpZiAoc3RyY21wKGJhY2tpbmdfZmls
ZSwgY3Vycl9icy0+YmFja2luZ19maWxlKSA9PSAwKSB7DQo+Pj4+DQo+Pj4+IGhtbSwgaW50ZXJl
c3RpbmcsIHdoYXQgYnMtPmJhY2tpbmdfZmlsZSBub3cgbWVhbnM/IEl0J3Mgc3RyYW5nZSBlbm91
Z2ggdG8gc3RvcmUgc3VjaCBmaWVsZCBvbg0KPj4+PiBiZHMsIHdoZW4gd2UgaGF2ZSBiYWNraW5n
IGxpbmsgYW55d2F5Li4NCj4+Pg0KPj4+IFBhdGNoIDM3IGhhcyB5b3UgY292ZXJlZC4gOi0pDQo+
Pj4NCj4+DQo+PiBIbW0sIGlmIGl0IGhhcyByZW1vdmVkIHRoaXMgZmllbGQsIGJ1dCBpdCBkb2Vz
bid0KQ0KPiANCj4gQmVjYXVzZSBpdOKAmXMgbmVlZGVkLiAgKEp1c3Qgbm90IGluIHRoZSBjdXJy
ZW50IGZvcm0sIGJ1dCB0aGF04oCZcyB3aGF0IDM3DQo+IGlzIGZvci4pDQo+IA0KPj4gU28sIHdl
IGZpbmlzaGVkIHdpdGggc29tZSBvYmplY3QsIGNhbGxlZCAib3ZlcmxheSIsIGJ1dCBpdCBpcyBu
b3QgYW4gb3ZlcmxheSBvZiBicywgaXQncyBvdmVybGF5IG9mDQo+PiBmaXJzdCBub24taW1wbGlj
aXQgZmlsdGVyZWQgbm9kZSBpbiBicyBiYWNraW5nIGNoYWluLCBpdCBtYXkgYmUgZm91bmQgYnkg
YmRydl9maW5kX292ZXJsYXkoKSBoZWxwZXIgKHdoaWNoIGlzDQo+PiBhbG1vc3QgdW51c2VkIGFu
ZCBteSBiZSBzYWZlbHkgZHJvcHBlZCksIGFuZCBmaWxlbmFtZSBvZiB0aGlzICJvdmVybGF5IiBp
cyBzdG9yZWQgaW4gYnMtPmJhY2tpbmdfZmlsZSBzdHJpbmcNCj4+IHZhcmlhYmxlLCBrZWVwaW5n
IGluIG1pbmQgdGhhdCBicy0+YmFja2luZyBpcyBwb2ludGVyIHRvIGJhY2tpbmcgY2hpbGQgb2Yg
YnMgd2hpY2ggaXMgY29tcGxldGVseSBhbm90aGVyIHRoaW5nPw0KPiANCj4gSSBkb27igJl0IHF1
aXRlIHNlZSB3aGF0IHlvdSBtZWFuLiAgVGhlcmUgaXMgbm8g4oCcb3ZlcmxheeKAnSBpbiB0aGlz
IGZ1bmN0aW9uLg0KDQpIbW0sIHNvcnJ5LCBJIGtlcHQgaW4gbWluZCBvdmVybGF5IGZyb20gdGhl
IG5leHQgcGF0Y2guLg0KDQo+IA0KPj4gT2gsIG5vLCBldmVyeXRoaW5nIHJlbGF0ZWQgdG8gZmls
ZW5hbWUtYmFzZWQgYmFja2luZyBjaGFpbiBsb2dpYyBpcyBub3QgZm9yIG1lIG9fTy4gSWYgc29t
ZXRoaW5nIGRvZXNuJ3Qgd29yaw0KPj4gd2l0aCBmaWxlbmFtZS1iYXNlZCBsb2dpYyB1c2VycyBz
aG91bGQgdXNlIG5vZGUtbmFtZXMuLg0KPiANCj4gSW4gdGhlb3J5IHllcywgYnV0IHRoYXQgaXNu
4oCZdCBhbiBvcHRpb24gZm9yIHFlbXUtaW1nIGNvbW1pdCwgZm9yIGV4YW1wbGUuDQoNCkFuZCBp
ZiBzb21ldGhpbmcgZG9lc24ndCB3b3JrIHdpdGggcWVtdS1pbWcsIHVzZXJzIHNob3VsZCB1c2Ug
cWVtdSBwcm9jZXNzIGluIHN0b3BwZWQgc3RhdGUuIEFuZCBJJ2QgcHJlZmVyIHRvDQpkZXByZWNh
dGUgbW9zdCBvZiBxZW11LWltZyA6KSBBY3R1YWxseSB3ZSBpbiBWaXJ0dW96em8gYWxyZWFkeSBn
byB0aGlzIHdheSBmb3Igc29tZSB0aGluZ3MuIFFNUCBpbnRlcmZhY2UgaXMNCmEgbG90IG1vcmUg
dXNlZnVsIHRoYW4gcWVtdS1pbWcsIGFuZCBpdCdzIGFsd2F5cyBzaW1wbGVyIHRvIG1haW50YWlu
IGFuZCBkZXZlbG9wIG9uZSB0aGluZyB0aGFuIHR3by4NCg0KPiANCj4+IEFuZCBJJ2QgcHJlZmVy
IHRvIGRlcHJlY2F0ZSBmaWxlbmFtZSBiYXNlZCBpbnRlcmZhY2VzIGF0IGFsbC4NCj4gDQo+IE1l
IHRvby4NCj4gDQo+IGh0dHBzOi8vbGlzdHMubm9uZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1k
ZXZlbC8yMDE0LTA5L21zZzA0ODc4Lmh0bWwNCj4gDQo+IDotLw0KPiANCg0KUmVhbGx5IHNhZC4u
DQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

