Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5681EC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 12:36:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D80962054F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 12:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="V6u389Bh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80962054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiI1g-0003Bz-0e
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 08:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47903)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hiHzp-0001VQ-HN
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 08:34:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hiHzo-0005wY-9E
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 08:34:53 -0400
Received: from mail-eopbgr60134.outbound.protection.outlook.com
 ([40.107.6.134]:30532 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1hiHzo-0005vA-2P; Tue, 02 Jul 2019 08:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzpk4JoiagptWn++034ZG6Nk2lD6RvV+ZWrOZizbJJw=;
 b=V6u389Bhsvv0sSImkOWm6pgKtR67JDiKLv7welXGZbXM+3po2TLzeiA7vb74BjxHh1fH5djFOWS8iN1kQatMacwM0PA112oM/H79b6GD+1zJK4pEu2u1INAqn2qEtKCdjqAxkNX979W6gEnAHHlOVWSHwtHRR6L6ywNillJiDbs=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB3780.eurprd08.prod.outlook.com (20.178.82.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.18; Tue, 2 Jul 2019 12:34:49 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::44eb:4518:e1f2:144c]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::44eb:4518:e1f2:144c%7]) with mapi id 15.20.2032.019; Tue, 2 Jul 2019
 12:34:49 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH v0 2/3] qcow2: add compression type processing
Thread-Index: AQHVLZuN7Ey1lYD5REukjsp4qtAkE6aw7L0AgAAL2QCAAEBXgP//5kmAgAA2yID//9GEgIAATiaAgAXUMAA=
Date: Tue, 2 Jul 2019 12:34:49 +0000
Message-ID: <f326c5a2-6fb4-d3f4-4a40-9828e58c388e@virtuozzo.com>
References: <20190528143727.10529-1-dplotnikov@virtuozzo.com>
 <20190528143727.10529-3-dplotnikov@virtuozzo.com>
 <20190628102333.GG5179@dhcp-200-226.str.redhat.com>
 <08da0859-10da-5d4b-3203-72341a166255@virtuozzo.com>
 <20190628120622.GI5179@dhcp-200-226.str.redhat.com>
 <4fef0430-5a0c-36ca-eec0-a2c0ce10cb91@virtuozzo.com>
 <20190628142437.GL5179@dhcp-200-226.str.redhat.com>
 <bf5134a7-7c5e-2b28-9acb-3b82df982e1e@virtuozzo.com>
 <20190628145419.GM5179@dhcp-200-226.str.redhat.com>
 <9dea8cff-f540-3689-91d4-21afc5a4dd5e@redhat.com>
In-Reply-To: <9dea8cff-f540-3689-91d4-21afc5a4dd5e@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0243.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::19) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13e4b006-c1b8-44b4-0a67-08d6fee9ac29
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB3780; 
x-ms-traffictypediagnostic: AM0PR08MB3780:
x-microsoft-antispam-prvs: <AM0PR08MB3780CC121D7D304BE29BA2E1CFF80@AM0PR08MB3780.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(346002)(136003)(376002)(366004)(396003)(199004)(189003)(446003)(2616005)(86362001)(14454004)(476003)(64756008)(66476007)(2906002)(73956011)(66446008)(66556008)(486006)(305945005)(14444005)(8676002)(76176011)(186003)(102836004)(5660300002)(25786009)(31696002)(6116002)(11346002)(3846002)(478600001)(26005)(53546011)(66946007)(386003)(6506007)(316002)(229853002)(66066001)(52116002)(6436002)(71200400001)(6486002)(99286004)(256004)(53936002)(81166006)(81156014)(54906003)(8936002)(7736002)(110136005)(6246003)(107886003)(36756003)(4326008)(71190400001)(68736007)(6512007)(31686004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3780;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ka/2005NSi9TFkA+JpC9nvYZQzIM5u5GtNMsTNAItfCm4oPoFNSVzHj3bg8BNl7ps3uJ3A0Uyc9RW/4tw1RbdyR36Mhx0BRnN4AUSt3c56w+vrWP/6SFGDjEuKNeegNH2YesmNN3Zsb7ZGdAR4AvLyGMCTOW02gMOt3xKZYgxrjN5k0xjhhKyuzE+kDS+ySNVW6z6rySSI9Z0+SVGCYKjVYR6wuIOlG8p6gRWaBEL6ngy/BhwSHEUmSbofqkFwjWXPh2jJMUCA8hIVyh49DfS9sJXsyVV+9CbI4zAWWd6LZk7Idzc917i6mgd4pghhCbhCn1Pg/WBJXI3ALAXJw3+jr2FX+IdUDAj0C2I30+O0Kq7zc/S9cjXJkDZ2IwuVF75pfMxrhffvmN5S7QoV2YofuZuFaNOX3PAYu8Owm6ToI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <931B4EADF7DA7A41AC39EE31C7D26C72@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e4b006-c1b8-44b4-0a67-08d6fee9ac29
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 12:34:49.2197 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dplotnikov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3780
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.134
Subject: Re: [Qemu-devel] [PATCH v0 2/3] qcow2: add compression type
 processing
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

DQoNCk9uIDI4LjA2LjIwMTkgMjI6MzQsIEVyaWMgQmxha2Ugd3JvdGU6DQo+IE9uIDYvMjgvMTkg
OTo1NCBBTSwgS2V2aW4gV29sZiB3cm90ZToNCj4gDQo+Pj4+Pj4+PiBXZSB3b3VsZCBzYXZlIG1v
c3Qgb2YgdGhpcyBjb2RlIGlmIHdlIGFkZGVkIGEgbmV3IGZpZWxkIHRvIHRoZSBoZWFkZXINCj4+
Pj4+Pj4+IGluc3RlYWQgb2YgYWRkaW5nIGEgaGVhZGVyIGV4dGVuc2lvbi4gTm90IHNheWluZyB0
aGF0IHdlIHNob3VsZA0KPj4+Pj4+Pj4gZGVmaW5pdGVseSBkbyB0aGlzLCBidXQgbGV0J3MgZGlz
Y3VzcyBpdCBhdCBsZWFzdC4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gSWYgd2UgYWRkIHRoZSBuZXcgZmll
bGQgdG8gdGhlIGhlYWRlciB3aWxsIHRoZSBvbGRlciBxZW11IGJlIGFibGUgdG8gdXNlDQo+Pj4+
Pj4+IGl0LiBPciB3ZSB3aWxsIGFkZCB0aGUgaGVhZGVyIG9ubHkgaWYgbmVlZGVkLCBpLmUuIGlm
IGNvbXByZXNzaW9uX3R5cGUNCj4+Pj4+Pj4gIT0gemxpYg0KPj4+Pj4+DQo+Pj4+Pj4gSW5jcmVh
c2luZyB0aGUgaGVhZGVyIHNpemUgaXMgYmFja3dhcmRzIGNvbXBhdGlibGUuIE9sZGVyIHFlbXUg
dmVyc2lvbnMNCj4+Pj4+PiBzaG91bGQgaGFuZGxlIHN1Y2ggaW1hZ2VzIGNvcnJlY3RseS4gVGhl
eSB3b3VsZCBzdG9yZSB0aGUgdW5rbm93biBwYXJ0DQo+Pj4+Pj4gb2YgdGhlIGhlYWRlciBpbiBz
LT51bmtub3duX2hlYWRlcl9maWVsZHMgYW5kIGtlZXAgaXQgdW5tb2RpZmllZCB3aGVuDQo+Pj4+
Pj4gdXBkYXRpbmcgdGhlIGltYWdlIGhlYWRlci4NCj4+Pj4+Pg0KPj4+Pj4+IFdlIHdvdWxkIHN0
aWxsIGFkZCB0aGUgaW5jb21wYXRpYmxlIGZlYXR1cmUgZmxhZyBmb3Igbm9uLXpsaWIsIG9mDQo+
Pj4+Pj4gY291cnNlLg0KPj4+Pj4gc28sIHdlIGJhc2ljYWxseSBuZWVkIHRvIGRvIHRoZSBzYW1l
OiBzdG9yZSBjb21wcmVzc2lvbiB0eXBlIGFuZCBmb3JiaWQNCj4+Pj4+IHRvIHVzZSBiZWNhdXNl
IG9mIGZsYWcgaWYgbm90IHpsaWIuDQo+Pj4+Pg0KPj4+Pj4gU291bmRzIGxpa2UgaXQgZG9lc24n
dCBkaWZmZXIgdGhhdCBtdWNoIGZyb20gdGhlIGV4dGVuc2lvbiBoZWFkZXIgYXBwcm9hY2guDQo+
Pj4+DQo+Pj4+IEl0IHByb3ZpZGVzIG1vcmUgb3IgbGVzcyB0aGUgc2FtZSBmdW5jdGlvbmFsaXR5
LCBidXQgd291bGQgcHJvYmFibHkgbWFrZQ0KPj4+PiB0aGlzIHBhdGNoIGhhbGYgdGhlIHNpemUg
YmVjYXVzZSBhbGwgb2YgdGhlIGNvZGUgcmVsYXRlZCB0byByZWFkaW5nIGFuZA0KPj4+PiBjaGVj
a2luZyB0aGUgaGVhZGVyIGV4dGVuc2lvbiB3b3VsZCBnbyBhd2F5LiBJdCBhbHNvIHNhdmVzIGEg
ZmV3IGJ5dGVzDQo+Pj4+IGluIHRoZSBoZWFkZXIgY2x1c3RlciAoNCBieXRlcyB2cy4gMTYgYnl0
ZXMpLg0KPj4+IG9rLCB3aWxsIHJlLWRvIGl0IHRoYXQgd2F5Lg0KPj4+DQo+Pj4gRG8geW91IGFn
cmVlIGluIGdlbmVyYWwgd2l0aCBob3cgemxpYiBjb21wcmVzc2lvbiB0eXBlIGlzIHRyZWF0ZWQ/
DQo+Pg0KPj4gQXMgSSBzYWlkLCBJIHRoaW5rIGJvdGggd2F5cyBhcmUganVzdGlmaWFibGUgYXMg
bG9uZyBhcyB3ZSBzdGF5DQo+PiBjb25zaXN0ZW50IGJldHdlZW4gcWVtdSBhbmQgc3BlYy4NCj4+
DQo+PiBJJ2QgcHJlZmVyIHRvIGFsbG93IHpsaWIgaW4gdGhlIGV4dGVuc2lvbiwgeW91J2QgcHJl
ZmVyIHRvIGZvcmJpZCBpdC4NCj4+IFNvIEknZCBsaWtlIHRvIGhlYXIgb3BpbmlvbnMgZnJvbSBz
b21lIG1vcmUgcGVvcGxlIG9uIHdoaWNoIHdheSB0aGV5DQo+PiBwcmVmZXIuDQo+IA0KPiBNeSBw
cmVmZXJlbmNlcyAtIHVzZSBhIDQgYnl0ZSBoZWFkZXIgZmllbGQsIGFuZCByZXF1aXJlIHRoZSBp
bmNvbXBhdGlibGUNCj4gZmVhdHVyZSBiaXQgaWYgdGhlIGZpZWxkIGlzIG5vbi16ZXJvLiBUaGUg
c3RhbmRhcmQgc2hvdWxkIGFsbG93IHNvbWVvbmUNCj4gdG8gZXhwbGljaXRseSByZXF1ZXN0IHps
aWIgY29tcHJlc3Npb24gKGRvbmUgYnkgbGVhdmluZyB0aGUgaW5jb21wYXRpYmxlDQo+IGJpdCBj
bGVhciwgdGhlbiBzcGVjaWZ5aW5nIGEgaGVhZGVyIGxlbmd0aCBvZiAxMDggaW5zdGVhZCBvZiAx
MDQsIGJ1dA0KPiBsZWF2aW5nIHRoZSBjb21wcmVzc2lvbiBmaWVsZCBhdCAxMDQtMTA3IGF0IDAp
LCB0byBpbXBsaWNpdGx5IHJlcXVlc3QNCj4gemxpYiBjb21wcmVzc2lvbiAoZG9uZSBieSBsZWF2
aW5nIHRoZSBpbmNvbXBhdGlibGUgYml0IGNsZWFyLCBhbmQNCj4gc3BlY2lmeWluZyBhIGhlYWRl
ciBsZW5ndGggb2YgMTA0KTsgb3IgdG8gZXhwbGljaXRseSByZXF1ZXN0IHNvbWUgb3RoZXINCj4g
Y29tcHJlc3Npb24gKGRvbmUgYnkgc2V0dGluZyB0aGUgaW5jb21wYXRpYmxlIGJpdCwgc3BlY2lm
eWluZyBhIGhlYWRlcg0KPiBsZW5ndGggb2YgMTA4LCBhbmQgcHV0dGluZyBhIG5vbi16ZXJvIHZh
bHVlIGluIHRoZSBjb21wcmVzc2lvbiBmaWVsZA0KPiAxMDQtMTA3KS4NCj4gDQo+IFVuZGVyIHRo
ZXNlIHJ1bGVzLCBpZiB5b3UgaW1wbGljaXRseSBvciBleHBsaWNpdGx5IHJlcXVlc3QgemxpYiwg
eW91cg0KPiBpbWFnZSBjYW4gYmUgb3BlbmVkIHdpdGhvdXQgcHJvYmxlbXMgYnkgYm90aCBvbGRl
ciBhbmQgbmV3ZXIgcWVtdS4gIElmDQo+IHlvdSBleHBsaWNpdGx5IHJlcXVlc3QgenN0ZCwgeW91
ciBpbWFnZSB3aWxsIGZhaWwgdG8gb3BlbiBieSBvbGRlciBxZW11DQo+IChnb29kLCBiZWNhdXNl
IHRoZXkgd291bGQgbWlzaW50ZXJwcmV0IGNvbXByZXNzZWQgY2x1c3RlcnMpLCBhbmQgd29yaw0K
PiB3aXRoIG5ld2VyIHFlbXUuICBBbmQgc2luY2UgcHJvdmlkaW5nIGEgMTA4LWJ5dGUgaGVhZGVy
IHdvcmtzIGp1c3QgZmluZQ0KPiB3aXRoIG9sZGVyIHFlbXUgYXMgbG9uZyBhcyB0aGUgaGVhZGVy
IGNvbnRhaW5zIDAsIEkgcmVjb21tZW5kIHRoYXQgd2UNCj4ganVzdCBhbHdheXMgbWFrZSBuZXdl
ciBxZW11IHByb3ZpZGUgdGhhdCBmaWVsZCAoZXZlbiBpZiBpdCBpcyBleHBsaWNpdGx5DQo+IHNl
dCB0byB6bGliKSwgYXMgdGhhdCBpcyBsZXNzIGNvbXBsaWNhdGVkIHRoYW4gb25seSBwcm92aWRp
bmcgdGhlIGxhcmdlcg0KPiBoZWFkZXIgZm9yIG5vbi16bGliIGZpbGVzICh3ZSBzdGlsbCBoYXZl
IHRvIHBhcnNlIDEwNC1ieXRlIGhlYWRlcnMsIGJ1dA0KPiB0aGF0IGRvZXNuJ3QgbWVhbiB3ZSBo
YXZlIHRvIGNyZWF0ZSBicmFuZC1uZXcgZmlsZXMgdGhhdCB3YXkpLg0KPiANCj4gVGhlcmUncyBv
bmUgbW9yZSBjb3JuZXIgY2FzZS4gSSByZWNvbW1lbmQgdGhhdCB0aGUgc3RhbmRhcmQgcmVxdWly
ZSB0aGF0DQo+IGl0IGJlIGFuIGVycm9yIHRvIHNldCB0aGUgaW5jb21wYXRpYmxlIGZlYXR1cmUg
Yml0IGJ1dCB1c2UgYSBoZWFkZXIgc2l6ZQ0KPiBvZiAxMDQgLSBpZiB5b3UgaGF2ZSBhbiBpbWFi
ZSBsaWtlIHRoYXQsIHRoZSBpbWFnZSB3b3VsZCBiZSB0cmVhdGVkIGFzDQo+IHVzaW5nIHpsaWIg
KGltcGxpY2l0bHkgZHVlIHRvIHRoZSBoZWFkZXIgc2l6ZSksIHNvIG9sZGVyIGltYWdlcyBfY291
bGRfDQo+IHVzZSBpdCBvdGhlciB0aGFuIHRoZSBmYWN0IHRoYXQgdGhleSBkb24ndCByZWNvZ25p
emUgdGhlIGluY29tcGF0aWJsZQ0KPiBmZWF0dXJlIGJpdC4gIE9uIHRoZSBvdGhlciBoYW5kLCBy
ZXF1aXJpbmcgc3VjaCBhbiBpbWFnZSB0byBiZSByZWplY3RlZA0KPiBpcyBhIGJpdCBvZiBhIHN0
cmV0Y2ggLSBubyBxZW11ICh3aGV0aGVyIG9uZSB0aGF0IHVuZGVyc3RhbmRzIHRoZQ0KPiBmZWF0
dXJlIGJpdCBvciBvbmUgdGhhdCBkb2VzIG5vdCkgd291bGQgbWlzaW50ZXJwcmV0IHRoZSBpbWFn
ZSBjb250ZW50cw0KPiBhcyBiZWluZyB6bGliIGNvbXByZXNzZWQsIGlmIGl0IGhhZCBub3QgYmVl
biBmb3IgdGhlIGJpdCBiZWluZyBzZXQuICBTbw0KPiBpbiB0aGlzIGNvcm5lciBjYXNlLCBJJ20g
ZmluZSBpZiB5b3UgZW5kIHVwIGRvY3VtZW50aW5nIHdoYXRldmVyIGlzDQo+IGVhc2llc3QgdG8g
Y29kZS4NCj4gDQoNCk9rLCBJJ2xsIHJlLWRvIHRoZSBzZXJpZXMgaW50cm9kdWNpbmcgY29tcHJl
c3Npb24gdHlwZSBpbiB0aGUgaGVhZGVyLg0KVGhhbmtzIQ0KDQpEZW5pcw0KDQotLSANCkJlc3Qs
DQpEZW5pcw0K

