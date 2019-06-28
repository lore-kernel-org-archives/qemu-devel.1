Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422FEC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 12:34:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C8432083B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 12:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="exnnJs2K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8432083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgq5D-0002HH-A1
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 08:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35051)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hgq37-0000T9-4J
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:32:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hgq35-0003jn-TZ
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:32:17 -0400
Received: from mail-eopbgr140118.outbound.protection.outlook.com
 ([40.107.14.118]:59630 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1hgq35-0003jC-9w; Fri, 28 Jun 2019 08:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddce2P12f2wZ03XthsIPVnu7eZug6Om8CYre6aExTjU=;
 b=exnnJs2KtizGaOzDM32S6TPZzVYO2T39Pg9ZMHEkZZzrIYPmnfuzHgbzu+4BQXI8l1P0PASC/pVDkLL4JyXzUWJFhpvFE7W53eipTlF3P5pl5gwj3Ajo46+c7n8GkEa19KWFKALTLCEgyhuOw6FY6LchUQJT1WyH3KdDrOpZFmc=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB3298.eurprd08.prod.outlook.com (52.134.94.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.18; Fri, 28 Jun 2019 11:07:29 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::44eb:4518:e1f2:144c]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::44eb:4518:e1f2:144c%7]) with mapi id 15.20.2008.014; Fri, 28 Jun 2019
 11:07:29 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH v0 1/3] qcow2: introduce compression type feature
Thread-Index: AQHVLZeBBWXoEDPLg0S3Dlr71aYMYaaw6CcA
Date: Fri, 28 Jun 2019 11:07:29 +0000
Message-ID: <6d4d55f2-eecc-86ce-1622-3156f73632e0@virtuozzo.com>
References: <20190528143727.10529-1-dplotnikov@virtuozzo.com>
 <20190528143727.10529-2-dplotnikov@virtuozzo.com>
 <20190628095433.GD5179@dhcp-200-226.str.redhat.com>
In-Reply-To: <20190628095433.GD5179@dhcp-200-226.str.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0135.eurprd05.prod.outlook.com
 (2603:10a6:7:28::22) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34268c21-960c-4fd3-1206-08d6fbb8cf78
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB3298; 
x-ms-traffictypediagnostic: AM0PR08MB3298:
x-microsoft-antispam-prvs: <AM0PR08MB3298341F14E79589B52E6140CFFC0@AM0PR08MB3298.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(376002)(346002)(136003)(366004)(396003)(189003)(199004)(36756003)(53546011)(6506007)(5660300002)(102836004)(6116002)(386003)(3846002)(186003)(53936002)(31686004)(107886003)(6246003)(66066001)(26005)(71200400001)(8936002)(54906003)(2906002)(229853002)(316002)(81166006)(81156014)(8676002)(66446008)(64756008)(66556008)(66476007)(6486002)(66946007)(7736002)(446003)(305945005)(11346002)(73956011)(6512007)(86362001)(2616005)(486006)(31696002)(476003)(6436002)(25786009)(478600001)(68736007)(52116002)(256004)(4326008)(71190400001)(14454004)(99286004)(6916009)(76176011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3298;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1qBKNfKTEUXH5iTxh1a5hV5CTjPdcN/Aa4t65VQIjw7KF3Qz22u0O5syyzFEayyEAPImYumrmRmpw9A3yNXfVh6b8KLpJJhQMVXat70LRoHZF8l3Ub4Cig83VR+ut7mP18fB4H5OhAf37JhFFIBv3TEPqgs5M4bXdw1iVRNEgUVe/3ABz/BDHWLzDX4aWQom027QKCdbhe6EDOwUpMHHFqSsJLXP9rLVUnAj5wG3LvqDdYo+nziMghm7guS2NnUUTvFyV1lA7wHJqZlSLVogZl/S2dUTxXkcaKfHVkxOgzHmfpoYx0/OQv3H2JTM0jL3C4hh9AWLAVjFSRhmPgI77EB9Fu7pQi1a1iLPq9X6Z8aZJsKwv1TCr9vAU9pbMUB9yEdmwQspn1kWmH2LUy9xMYoddLn1b4QMsAEE6PQ1jTs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3ED745665B67A84A960F6067CEAD841B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34268c21-960c-4fd3-1206-08d6fbb8cf78
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 11:07:29.5859 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dplotnikov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3298
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.118
Subject: Re: [Qemu-devel] [PATCH v0 1/3] qcow2: introduce compression type
 feature
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
 "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDI4LjA2LjIwMTkgMTI6NTQsIEtldmluIFdvbGYgd3JvdGU6DQo+IEFtIDI4LjA1LjIw
MTkgdW0gMTY6MzcgaGF0IERlbmlzIFBsb3RuaWtvdiBnZXNjaHJpZWJlbjoNCj4+IFRoZSBwYXRj
aCBhZGRzIHNvbWUgcHJlcGFyYXRpb24gcGFydHMgZm9yIGluY29tcGF0aWJsZSBjb21wcmVzc2lv
biB0eXBlDQo+PiBmZWF0dXJlIHRvIFFDT1cyIGhlYWRlciB0aGF0IGluZGljYXRlcyB0aGF0ICph
bGwqIGNvbXByZXNzZWQgY2x1c3RlcnMNCj4+IG11c3QgYmUgKGRlKWNvbXByZXNzZWQgdXNpbmcg
YSBjZXJ0YWluIGNvbXByZXNzaW9uIHR5cGUuDQo+Pg0KPj4gSXQgaXMgaW1wbGllZCB0aGF0IHRo
ZSBjb21wcmVzc2lvbiB0eXBlIGlzIHNldCBvbiB0aGUgaW1hZ2UgY3JlYXRpb24gYW5kDQo+PiBj
YW4gYmUgY2hhbmdlZCBvbmx5IGxhdGVyIGJ5IGltYWdlIGNvbnZlcnNpb24sIHRodXMgY29tcHJl
c3Npb24gdHlwZQ0KPj4gZGVmaW5lcyB0aGUgb25seSBjb21wcmVzc2lvbiBhbGdvcml0aG0gdXNl
ZCBmb3IgdGhlIGltYWdlLg0KPj4NCj4+IFRoZSBnb2FsIG9mIHRoZSBmZWF0dXJlIGlzIHRvIGFk
ZCBzdXBwb3J0IG9mIG90aGVyIGNvbXByZXNzaW9uIGFsZ29yaXRobXMNCj4+IHRvIHFjb3cyLiBG
b3IgZXhhbXBsZSwgWlNURCB3aGljaCBpcyBtb3JlIGVmZmVjdGl2ZSBvbiBjb21wcmVzc2lvbiB0
aGFuIFpMSUIuDQo+PiBJdCB3b3JrcyByb3VnaGx5IHgyIGZhc3RlciB0aGFuIFpMSUIgcHJvdmlk
aW5nIGEgY29tcGFyYWJsZSBjb21wcmVzc2lvbiByYXRpbw0KPj4gYW5kIHRoZXJlZm9yZSBwcm92
aWRlIGEgcGVyZm9ybWFuY2UgYWR2YW50YWdlIGluIGJhY2t1cCBzY2VuYXJpb3MuDQo+Pg0KPj4g
VGhlIGRlZmF1bHQgY29tcHJlc3Npb24gaXMgWkxJQi4gSW1hZ2VzIGNyZWF0ZWQgd2l0aCBaTElC
IGNvbXByZXNzaW9uIHR5cGUNCj4+IGlzIGJhY2t3YXJkIGNvbXBhdGlibGUgd2l0aCBvbGRlciBx
ZW11IHZlcnNpb25zLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IERlbmlzIFBsb3RuaWtvdiA8ZHBs
b3RuaWtvdkB2aXJ0dW96em8uY29tPg0KPiANCj4+IEBAIC0zMTE5LDYgKzMxMjMsMTAgQEANCj4+
ICAgIyAgICAgICAgICAgICAgICAgICAgICAgICBhbiBpbWFnZSwgdGhlIGRhdGEgZmlsZSBuYW1l
IGlzIGxvYWRlZCBmcm9tIHRoZSBpbWFnZQ0KPj4gICAjICAgICAgICAgICAgICAgICAgICAgICAg
IGZpbGUuIChzaW5jZSA0LjApDQo+PiAgICMNCj4+ICsjIEBjb21wcmVzc2lvbi10eXBlOiAgICAg
IGNvbXByZXNzaW9uIG1ldGhvZCB0byB1c2UgZm9yIGltYWdlIGNsdXN0ZXJzIGNvbXByZXNzaW9u
DQo+PiArIyAgICAgICAgICAgICAgICAgICAgICAgICBUaGUgY29tcmVzc2lvbiBtZXRob2QgaXMg
c2V0IG9uIGltYWdlIGNyZWF0aW9uIGFuZCBjYW4NCj4+ICsjICAgICAgICAgICAgICAgICAgICAg
ICAgIGJlIGNoYW5nZWQgdmlhIGltYWdlIGNvbnZlcnRpbmcgb25seS4gKHNpbmNlIDQuMSkNCj4+
ICsjDQo+PiAgICMgU2luY2U6IDIuOQ0KPj4gICAjIw0KPj4gICB7ICdzdHJ1Y3QnOiAnQmxvY2tk
ZXZPcHRpb25zUWNvdzInLA0KPj4gQEAgLTMxMzQsNyArMzE0Miw4IEBADQo+PiAgICAgICAgICAg
ICAgICcqcmVmY291bnQtY2FjaGUtc2l6ZSc6ICdpbnQnLA0KPj4gICAgICAgICAgICAgICAnKmNh
Y2hlLWNsZWFuLWludGVydmFsJzogJ2ludCcsDQo+PiAgICAgICAgICAgICAgICcqZW5jcnlwdCc6
ICdCbG9ja2RldlFjb3cyRW5jcnlwdGlvbicsDQo+PiAtICAgICAgICAgICAgJypkYXRhLWZpbGUn
OiAnQmxvY2tkZXZSZWYnIH0gfQ0KPj4gKyAgICAgICAgICAgICcqZGF0YS1maWxlJzogJ0Jsb2Nr
ZGV2UmVmJywNCj4+ICsgICAgICAgICAgICAnKmNvbXByZXNzaW9uLXR5cGUnOiAnUWNvdzJDb21w
cmVzc2lvblR5cGUnIH0gfQ0KPiANCj4gcWNvdzJfb3BlbigpIGRvZXNuJ3QgYWN0dWFsbHkgcGFy
c2UgdGhpcyBvcHRpb24gKGFuZCBpdCBjb3VsZG4ndCBkbw0KPiBhbnl0aGluZyB1c2VmdWwgd2l0
aCBpdCBiZWNhdXNlIHRoZSBpbWFnZSBpcyBmaXhlZCB0byBhIHNpbmdsZQ0KPiBjb21wcmVzc2lv
biB0eXBlKSwgc28gdGhpcyBzaG91bGRuJ3QgYmUgYWRkZWQuDQoNClllcywgdGhhdCdzIHRydWUu
IFdpbGwgcmVtb3ZlIGl0Lg0KPiANCj4+ICAgIyMNCj4+ICAgIyBAU3NoSG9zdEtleUNoZWNrTW9k
ZToNCj4+IEBAIC00MjA2LDYgKzQyMTUsMTkgQEANCj4+ICAgICAnZGF0YSc6IFsgJ3YyJywgJ3Yz
JyBdIH0NCj4+ICAgDQo+PiAgIA0KPj4gKyMjDQo+PiArIyBAUWNvdzJDb21wcmVzc2lvblR5cGU6
DQo+PiArIw0KPj4gKyMgQ29tcHJlc3Npb24gdHlwZSB1c2VkIGluIHFjb3cyIGltYWdlIGZpbGUN
Cj4+ICsjDQo+PiArIyBAemxpYiAgICAgOiBnemlwIGNvbXByZXNzb3INCj4+ICsjIEB6c3RkICAg
ICA6IHpzdGQgY29tcHJlc3Npb24NCj4+ICsjDQo+PiArIyBTaW5jZTogNC4xDQo+PiArIyMNCj4+
ICt7ICdlbnVtJzogJ1Fjb3cyQ29tcHJlc3Npb25UeXBlJywNCj4+ICsgICdkYXRhJzogWyAnemxp
YicsICd6c3RkJyBdIH0NCj4gDQo+IEkgdGhpbmsgaXQgd291bGQgYmUgY2xlYW5lciB0byBzdGFy
dCB3aXRoIG9ubHkgJ3psaWInIGhlcmUsIGxpa2UgeW91ciBDDQo+IGNvZGUgdGhhdCBkb2Vzbid0
IGltcGxlbWVudCBhbnl0aGluZyBmb3Igbm9uLXpsaWIgY29tcHJlc3Npb24gdHlwZXMgeWV0Lg0K
PiANCj4gJ3pzdGQnIGNhbiBiZSBhZGRlZCB0byB0aGUgZW51bSB3aGVuIGl0J3MgYWN0dWFsbHkg
aW1wbGVtZW50ZWQuIFRoaXMNCj4gd2lsbCBhbHNvIG1ha2Ugc2NoZW1hIGludHJvc3BlY3Rpb24g
cHJvdmlkZSB0aGUgcmlnaHQgaW5mb3JtYXRpb24gd2l0aCBhDQo+IGJ1aWxkIHRoYXQgaW5jbHVk
ZXMgdGhpcyBwYXRjaCwgYnV0IG5vdCB0aGUgenN0ZCBjb21wcmVzc2lvbiB0eXBlDQo+IHBhdGNo
Lg0KTWFrZSBzZW5zZS4gV2lsbCBiZSBmaXhlZA0KPiANCj4gS2V2aW4NCj4gDQoNCi0tIA0KQmVz
dCwNCkRlbmlzDQo=

