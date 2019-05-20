Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD85C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 10:39:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C4242081C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 10:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hnfx8iVb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C4242081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33130 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSfhN-0000cj-Nu
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 06:39:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hSfg5-0008RZ-B8
	for qemu-devel@nongnu.org; Mon, 20 May 2019 06:37:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hSfg4-0003jd-6y
	for qemu-devel@nongnu.org; Mon, 20 May 2019 06:37:57 -0400
Received: from mail-eopbgr00095.outbound.protection.outlook.com
	([40.107.0.95]:55070
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hSfg0-0003hm-TW; Mon, 20 May 2019 06:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=UFU26S3lyW/UN26DU7s946I0yc6Vwn1rvmJBxS3HDBg=;
	b=hnfx8iVb41YRGtvyM2LmwPbj/+fxvlVZYc7uzuT4i7Jizoaim/n7NfOYdzObhaDTdGbQsQkCzegTiiPyNNtF/actxG/COXxefEubsnE8wKswKC2ufycp/dO4K4onwqzHrSt7lKNeGDu2p11cDOkLzyE3aEK5YF4I+qLnpyvDYE4=
Received: from AM6PR08MB4675.eurprd08.prod.outlook.com (10.255.96.78) by
	AM6PR08MB5256.eurprd08.prod.outlook.com (10.255.123.148) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1900.16; Mon, 20 May 2019 10:37:49 +0000
Received: from AM6PR08MB4675.eurprd08.prod.outlook.com
	([fe80::9051:3c85:28c6:a0c1]) by
	AM6PR08MB4675.eurprd08.prod.outlook.com
	([fe80::9051:3c85:28c6:a0c1%6]) with mapi id 15.20.1878.024;
	Mon, 20 May 2019 10:37:49 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [Qemu-block] [Qemu-devel] [PATCH v2] migration/dirty-bitmaps:
	change bitmap enumeration method
Thread-Index: AQHVCpJiO5csnRf0D0OxXxQO3Uu316ZtvN+AgABiIICAATLlAIAEdX2AgAATmgA=
Date: Mon, 20 May 2019 10:37:49 +0000
Message-ID: <d3ff832a-d185-13f6-129a-b531f04b3b0b@virtuozzo.com>
References: <20190514201926.10407-1-jsnow@redhat.com>
	<72986b5d-0772-abfb-2c99-97470e8fd3da@virtuozzo.com>
	<ab26708f-9199-32da-29ac-3202ba2df0d5@redhat.com>
	<f68e1472-26be-aa15-b2e2-f96029c9ce97@virtuozzo.com>
	<20190520092737.GA5699@localhost.localdomain>
In-Reply-To: <20190520092737.GA5699@localhost.localdomain>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0041.eurprd05.prod.outlook.com
	(2603:10a6:3:1a::51) To AM6PR08MB4675.eurprd08.prod.outlook.com
	(2603:10a6:20b:c2::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190520133746480
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bc5b63b-43c8-47ed-93d9-08d6dd0f3421
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:AM6PR08MB5256; 
x-ms-traffictypediagnostic: AM6PR08MB5256:
x-microsoft-antispam-prvs: <AM6PR08MB525624172E7F164DB3206565C1060@AM6PR08MB5256.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(136003)(396003)(366004)(39850400004)(346002)(54094003)(52314003)(199004)(189003)(2616005)(86362001)(11346002)(66066001)(446003)(31686004)(476003)(99286004)(486006)(76176011)(53546011)(31696002)(52116002)(7416002)(6246003)(81166006)(6436002)(26005)(5024004)(68736007)(14444005)(256004)(81156014)(8676002)(6512007)(6486002)(53936002)(54906003)(14454004)(4326008)(229853002)(8936002)(5660300002)(25786009)(478600001)(36756003)(305945005)(66476007)(64756008)(66446008)(3846002)(6116002)(102836004)(66946007)(186003)(73956011)(71200400001)(71190400001)(7736002)(66556008)(2906002)(6916009)(316002)(6506007)(386003)(14143004);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5256;
	H:AM6PR08MB4675.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y0ETyrbKYpXddSBpYJxtOjP/dFRFoYebRLeG25FRJCgu73g3mVQzv7sSEmleM3V09JoW+YCRC1G20owICtRUpy0tJ2lBpgC6lNRbSrFIG3AwMTX7WkIoOPTfqLcXi4bV3ABRRgMZj/2ub1GAQ2mIhrrH+YGf8n4KKaAdMVjsYMhx+m2gIWrMxn2t+vspz47ncnNgZrAOWbuqA8a9KK150XOWVW91CPdeLX9zJAHw0FFgkO0riap9B62Nekc/1XKVHsO8awORG5xrGwUNxWRrwANDXD7NREITQjpeXNScKSV6d/sPeyfUT/omtTnG5q3UKfgsWb8Kk+u/zVtFdZ3xvBT+4iKFoVSphXIhlpTlQjMwkyFSBxiPcZbqkEl+LIHLi40R4SG82voiS0VlQ9XjcQ7Cm7yzXgTyiEdEZPC0GO0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <16EAEE5D60ABE242AB9615A5ED2A3EE6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc5b63b-43c8-47ed-93d9-08d6dd0f3421
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 10:37:49.2924 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5256
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.95
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] migration/dirty-bitmaps:
 change bitmap enumeration method
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
	aihua liang <aliang@redhat.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	Juan Quintela <quintela@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Dr. David Alan
	Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
	John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjAuMDUuMjAxOSAxMjoyNywgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMTcuMDUuMjAxOSB1bSAx
MjoyMiBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IDE2
LjA1LjIwMTkgMjI6MDMsIEpvaG4gU25vdyB3cm90ZToNCj4+PiBPbiA1LzE2LzE5IDY6MTIgQU0s
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4+IEJ1dCwgb24gdGhlIG90
aGVyLCBoYW5kLCBpZiB3ZSBoYXZlIGltcGxpY2l0bHktZmlsdGVyZWQgbm9kZSBvbiB0YXJnZXQs
IHdlIHdlcmUgZG9pbmcgd3JvbmcgdGhpbmcgYW55d2F5LA0KPj4+PiBhcyBkaXJ0eV9iaXRtYXBf
bG9hZF9oZWFkZXIgZG9uJ3Qgc2tpcCBpbXBsaWNpdCBub2Rlcy4NCj4+Pj4NCj4+Pj4+ICsgICAg
Zm9yIChicyA9IGJkcnZfbmV4dF9hbGxfc3RhdGVzKE5VTEwpOyBiczsgYnMgPSBiZHJ2X25leHRf
YWxsX3N0YXRlcyhicykpIHsNCj4+Pj4NCj4+Pj4gQXMgSSB1bmRlcnN0YW5kLCBkaWZmZXJlbmNl
IHdpdGggYmRydl9uZXh0X25vZGUgaXMgdGhhdCB3ZSBkb24ndCBza2lwIHVubmFtZWQgbm9kZXMg
Wy4uLl0NCj4+Pj4NCj4+Pg0KPj4+IFRoZSBkaWZmZXJlbmNlIGlzIHRoYXQgd2UgaXRlcmF0ZSBv
dmVyIHN0YXRlcyB0aGF0IGFyZW4ndCByb290cyBvZg0KPj4+IHRyZWVzOyBzbyBub3QganVzdCB1
bm5hbWVkIG5vZGVzIGJ1dCByYXRoZXIgaW50ZXJtZWRpYXRlIG5vZGVzIGFzIHdlbGwNCj4+PiBh
cyBub2RlcyBub3QgYXR0YWNoZWQgdG8gYSBzdG9yYWdlIGRldmljZS4NCj4+Pg0KPj4+IGJkcnZf
bmV4dCBzYXlzOiBgSXRlcmF0ZXMgb3ZlciBhbGwgdG9wLWxldmVsIEJsb2NrRHJpdmVyU3RhdGVz
LCBpLmUuDQo+Pj4gQkRTcyB0aGF0IGFyZSBvd25lZCBieSB0aGUgbW9uaXRvciBvciBhdHRhY2hl
ZCB0byBhIEJsb2NrQmFja2VuZGANCj4+Pg0KPj4+IFNvIHRoaXMgbG9vcCBpcyBnb2luZyB0byBp
dGVyYXRlIG92ZXIgKmV2ZXJ5dGhpbmcqLCBub3QganVzdCB0b3AtbGV2ZWwNCj4+PiBub2Rlcy4g
VGhpcyBsZXRzIG1lIHNraXAgdGhlIHRyZWUtY3Jhd2xpbmcgbG9vcCB0aGF0IGRpZG4ndCB3b3Jr
IHF1aXRlDQo+Pj4gcmlnaHQuDQo+Pg0KPj4gSSBtZWFudCBub3QgYmRydl9uZXh0IGJ1dCBiZHJ2
X25leHRfbm9kZSwgd2hpY2ggaXRlcmF0ZXMgdGhyb3VnaCBncmFwaCBub2Rlcy4uDQo+PiBXaGF0
IGlzIHJlYWwgZGlmZmVyZW5jZSBiZXR3ZWVuIGdyYXBoX2JkcnZfc3RhdGVzIGFuZCBhbGxfYmRy
dl9zdGF0ZXMgPw0KPiANCj4gSSBkb24ndCB0aGluayB0aGVyZSBpcyBhbnkgcmVsZXZhbnQgZGlm
ZmVyZW5jZSBhbnkgbW9yZSBzaW5jZSBjb21taXQNCj4gMTU0ODljNzY5YjkgKCdibG9jazogYXV0
by1nZW5lcmF0ZWQgbm9kZS1uYW1lcycpLiBXZSBjYW4gb25seSBzZWUgYQ0KPiBkaWZmZXJlbmNl
IGlmIGEgQkRTIHdhcyBjcmVhdGVkLCBidXQgbmV2ZXIgb3BlbmVkLiBUaGlzIG1lYW5zIGVpdGhl
cg0KPiB0aGF0IHdlIGFyZSBzdGlsbCBpbiB0aGUgcHJvY2VzcyBvZiBvcGVuaW5nIGFuIGltYWdl
IG9yIHRoYXQgd2UgaGF2ZSBhDQo+IGJ1ZyBzb21ld2hlcmUuDQo+IA0KPiBNYXliZSB3ZSBzaG91
bGQgcmVtb3ZlIGdyYXBoX2JkcnZfc3RhdGVzIGFuZCByZXBsYWNlIGFsbCBvZiBpdHMgdXNlcw0K
PiB3aXRoIHRoZSBtb3JlIG9idmlvdXNseSBjb3JyZWN0IGFsbF9iZHJ2X3N0YXRlcyAoaWYgd2Ug
YXJlIHN1cmUgdGhhdA0KPiBhbGwgdXNlcnMgYXJlbid0IGNhbGxlZCBiZXR3ZWVuIGNyZWF0aW5n
IGFuZCBvcGVuaW5nIGEgQkRTKS4NCj4gDQo+PiBOb2RlIGlzIGluc2VydGVkIHRvIGdyYXBoX2Jk
cnZfc3RhdGVzIGluIGJkcnZfYXNzaWduX25vZGVfbmFtZSgpLCBhbmQgdG8NCj4+IGFsbF9iZHJ2
X3N0YXRlcyBpbiBiZHJ2X25ldygpLg0KPj4NCj4+IFRocmVlIGNhbGxzIHRvIGJkcnZfbmV3Og0K
Pj4NCj4+IGJkcnZfbmV3X29wZW5fZHJpdmVyLCBjYWxscyBiZHJ2X25ldyBhbmQgdGhlbiBiZHJ2
X29wZW5fZHJpdmVyLCB3aGljaCBjYWxscyBiZHJ2X2Fzc2lnbl9ub2RlX25hbWUsDQo+PiBhbmQg
aWYgaXQgZmFpbHMgbmV3IGNyZWF0ZWQgbm9kZSBpcyByZWxlYXNlZC4NCj4+DQo+PiBiZHJ2X29w
ZW5faW5oZXJpdA0KPj4gICAgICBiZHJ2X25ldw0KPj4gICAgICAuLg0KPj4gICAgICBiZHJ2X29w
ZW5fY29tbW9uDQo+PiAgICAgICAgIGJkcnZfb3Blbl9kcml2ZXINCj4+ICAgICAgICAgICAgIGJk
cnZfYXNzaWduX25vZGVfbmFtZQ0KPj4NCj4+DQo+PiBpc2NzaV9jb19jcmVhdGVfb3B0cw0KPj4g
ICAgICBiZHJ2X25ldw0KPj4NCj4+ICAgICAgLi4uIGhtbS4uIGxvb2tzIGxpa2UgaXQgYSBraW5k
IG9mIHRlbXBvcmFyeSB1bm5hbWVkIGJzDQo+Pg0KPj4gU28sIG5vdywgSSdtIG5vdCBzdXJlLiBQ
b3NzaWJseSB3ZSdkIGJldHRlciB1c2UgYmRydl9uZXh0X25vZGUoKS4NCj4gDQo+IEkgd29uZGVy
IGlmIHRoZSBpc2NzaSBvbmUgY2FuJ3QgYmUgcmVwbGFjZWQgd2l0aCBiZHJ2X25ld19vcGVuX2Ry
aXZlcigpLg0KPiBNYW51YWxseSBidWlsZGluZyBhIGhhbGYtb3BlbmVkIEJEUyBsaWtlIGl0IGRv
ZXMgY3VycmVudGx5IGxvb2tzDQo+IHN1c3BpY2lvdXMuDQo+IA0KPj4gS2V2aW4gaW50cm9kdWNl
ZCBhbGxfYmRydl9zdGF0ZXMgaW4gMGYxMjI2NGU3YTQxNDUgLCB0byB1c2UgaW4gZHJhaW4gaW5z
dGVhZCBvZg0KPj4gYmRydl9uZXh0Li4uIEJ1dCBJIGRvbid0IHVuZGVyc3RhbmQsIHdoeSBoZSBk
aWRuJ3QgdXNlIGdyYXBoX2JkcnZfc3RhdGVzIGFuZA0KPj4gY29ycmVzcG9uZGluZyBiZHJ2X25l
eHRfbm9kZSgpLCB3aGljaCBpcyBvbmx5IHNraXBzIHNvbWUgdGVtcG9yYXJ5IG9yIHVuZGVyLWNv
bnN0dWN0aW9uDQo+PiBub2Rlcy4uDQo+IA0KPiBJIHByb2JhYmx5IGp1c3QgZGlkbid0IHJlYWxp
c2UgdGhhdCBncmFwaF9iZHJ2X3N0YXRlcyBleGlzdHMgYW5kIGlzDQo+IGVmZmVjdGl2ZWx5IHRo
ZSBzYW1lLiBJIGtuZXcgdGhhdCBhbGxfYmRydl9zdGF0ZXMgY29udGFpbnMgd2hhdCBJIHdhbnQs
DQo+IHNvIEkganVzdCB3YW50ZWQgdG8gYWNjZXNzIHRoYXQuDQo+IA0KPiBCdXQgaWYgYW5vbnlt
b3VzIEJEU2VzIGRpZCBhY3R1YWxseSBzdGlsbCBleGlzdCwgZHJhaW4gd291bGQgd2FudCB0bw0K
PiB3YWl0IGZvciB0aG9zZSBhcyB3ZWxsLCBzbyBpdCdzIHRoZSBtb3JlIG5hdHVyYWwgY2hvaWNl
IGFueXdheS4NCj4gDQo+IEtldmluDQo+IA0KDQpUaGFuayB5b3UgZm9yIGNsYXJpZmljYXRpb24u
IFRoZW4sIG15IHItYiBzdGlsbCBzdGFuZCBoZXJlLCBhbmQgZml4aW5nL3JlZmFjdGluZw0KZ3Jh
cGhfbm9kZXMgdnMgYWxsX3N0YXRlcyBzaG91bGQgYmUgYSBzZXBhcmF0ZSB0aGluZy4NCg0KUmV2
aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVv
enpvLmNvbT4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

