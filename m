Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77314C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 18:25:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 833F6208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 18:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Zb7nobNo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 833F6208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50274 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZJYN-00086a-3P
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 14:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58409)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hZHAn-0001ia-Nv
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:53:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hZHAl-0006xR-RC
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:52:57 -0400
Received: from mail-eopbgr70119.outbound.protection.outlook.com
 ([40.107.7.119]:38599 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hZHAh-0006bh-AN; Fri, 07 Jun 2019 11:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqdGrLWO8vqe3HZGtw++kB22hg282X/kMm4YRAEt0tw=;
 b=Zb7nobNo9lJakN4FWpSHDePJJe/Vz9X/20Hb9SiSsJVkpCdyjWipb0JPOLbH/1VGJmAKq5gZpwQ4DfalnDo5z250HpKXXEYehJ3K0/zmF7pIUuFElwJk3L2E16NnahtDdIh7VrWRPMNHCtLC0BdNA9wGKCqxvTqtIrfK3R8glFg=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
 AM0PR08MB3474.eurprd08.prod.outlook.com (20.177.110.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.15; Fri, 7 Jun 2019 15:52:38 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
 ([fe80::8d90:32ae:bdd6:48e8]) by AM0PR08MB2961.eurprd08.prod.outlook.com
 ([fe80::8d90:32ae:bdd6:48e8%7]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 15:52:38 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH v6 5/7] qemu-coroutine-sleep: introduce qemu_co_sleep_wake
Thread-Index: AQHU8IvPncRKmUnNFESi2c9mvKXDwqaQLEMAgAA4CACAAB0MAIAAL54A
Date: Fri, 7 Jun 2019 15:52:38 +0000
Message-ID: <4e970256-1eb1-2d12-5d40-13341fd0890b@virtuozzo.com>
References: <20190411172709.205032-1-vsementsov@virtuozzo.com>
 <20190411172709.205032-6-vsementsov@virtuozzo.com>
 <20190607075740.GA5055@dhcp-200-226.str.redhat.com>
 <16b7ad42-611c-fc3e-2029-d491882b0750@virtuozzo.com>
 <20190607130210.GC5055@dhcp-200-226.str.redhat.com>
In-Reply-To: <20190607130210.GC5055@dhcp-200-226.str.redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0170.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::18) To AM0PR08MB2961.eurprd08.prod.outlook.com
 (2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190607185236202
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f74f31f0-5594-4cde-2850-08d6eb602a6a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:AM0PR08MB3474; 
x-ms-traffictypediagnostic: AM0PR08MB3474:
x-microsoft-antispam-prvs: <AM0PR08MB3474BA59D1A6B919C0536135C1100@AM0PR08MB3474.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(396003)(39850400004)(366004)(376002)(189003)(199004)(31686004)(478600001)(86362001)(31696002)(53936002)(36756003)(6436002)(5660300002)(7736002)(6512007)(6486002)(229853002)(4326008)(2906002)(68736007)(6116002)(3846002)(71190400001)(73956011)(66946007)(71200400001)(25786009)(107886003)(6246003)(256004)(64756008)(14454004)(81156014)(8676002)(8936002)(81166006)(305945005)(76176011)(54906003)(316002)(6916009)(52116002)(99286004)(66066001)(2616005)(476003)(102836004)(386003)(6506007)(26005)(486006)(11346002)(66556008)(446003)(66476007)(186003)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3474;
 H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RFDrXJnhZUAiBkjYovlhXXfZ00hEB0bsYnTAEXYpEfIrrLnZAJXZ2zvA3v5+mgyu8QnCsGozHsjrLhPVVLrxEAbTiKMWG6xeD0Xi2L7J5ianvzeZW4NAJdzaM9rlF65sJhvKIiYoMP8aHflMcExdaRVJz5iztOjSbh6PfAfJBrddDCd8S3gobHSEbHuzYN6A00+ofdH1GJ9c3iTfMfRhOBa+O+MIj0pfdnwGYRy51ZJyc8JrYOfQgQkglscMXM15ylsjnmPaBv7HRf5mB2S9IfmBva4wNwfzLnJWC/rQWt4WLix6g7Ygdw55xAFHhpyFXkzBsafrvc25mvtgAhuwdHnTfB/jxEyR0Tuq+XHPtGz/2pyebO44FQOM0tQ+TJufHcSJK/taME/KkxiCxlAAei7XB2YdAAFv5LWOHNegG8w=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78CAEFF41494064194A3C0ACE01AD7C1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f74f31f0-5594-4cde-2850-08d6eb602a6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 15:52:38.3280 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3474
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.119
Subject: Re: [Qemu-devel] [PATCH v6 5/7] qemu-coroutine-sleep: introduce
 qemu_co_sleep_wake
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
Cc: Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDcuMDYuMjAxOSAxNjowMiwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMDcuMDYuMjAxOSB1bSAx
MzoxOCBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IDA3
LjA2LjIwMTkgMTA6NTcsIEtldmluIFdvbGYgd3JvdGU6DQo+Pj4gQW0gMTEuMDQuMjAxOSB1bSAx
OToyNyBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+Pj4g
SW50cm9kdWNlIGEgZnVuY3Rpb24gdG8gZ3JhY2VmdWxseSB3YWtlLXVwIGEgY29yb3V0aW5lLCBz
bGVlcGluZyBpbg0KPj4+PiBxZW11X2NvX3NsZWVwX25zKCkgc2xlZXAuDQo+Pj4+DQo+Pj4+IFNp
Z25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmly
dHVvenpvLmNvbT4NCj4+Pg0KPj4+IFlvdSBjYW4gc2ltcGx5IHJlZW50ZXIgdGhlIGNvcm91dGlu
ZSB3aGlsZSBpdCBoYXMgeWllbGRlZCBpbg0KPj4+IHFlbXVfY29fc2xlZXBfbnMoKS4gVGhpcyBp
cyBzdXBwb3J0ZWQuDQo+Pg0KPj4gTm8gaXQgZG9lc24ndC4gcWVtdV9haW9fY29yb3V0aW5lX2Vu
dGVyIGNoZWNrcyBmb3Igc2NoZWR1bGVkIGZpZWxkLA0KPj4gYW5kIGFib3J0cyBpZiBpdCBpcyBz
ZXQuDQo+IA0KPiBBaCwgeWVzLCBpdCBoYXMgYmVlbiBicm9rZW4gc2luY2UgY29tbWl0DQo+IA0K
PiBJIGFjdHVhbGx5IHRyaWVkIHRvIGZpeCBpdCBvbmNlLCBidXQgaXQgdHVybmVkIG91dCBtb3Jl
IGNvbXBsaWNhdGVkIGFuZA0KPiBJIHRoaW5rIHdlIGZvdW5kIGEgZGlmZmVyZW50IHNvbHV0aW9u
IGZvciB0aGUgcHJvYmxlbSBhdCBoYW5kOg0KPiANCj4gICAgICBTdWJqZWN0OiBbUEFUQ0ggZm9y
LTIuMTEgMC80XSBGaXggcWVtdS1pb3Rlc3RzIGZhaWx1cmVzDQo+ICAgICAgTWVzc2FnZS1JZDog
PDIwMTcxMTI4MTU0MzUwLjIxNTA0LTEta3dvbGZAcmVkaGF0LmNvbT4NCj4gDQo+IEluIHRoaXMg
Y2FzZSwgSSBndWVzcyB5b3VyIGFwcHJvYWNoIHdpdGggYSBuZXcgZnVuY3Rpb24gdG8gaW50ZXJy
dXB0DQo+IHFlbXVfY29fc2xlZXBfbnMoKSBpcyBva2F5Lg0KPiANCj4gRG8gd2UgbmVlZCB0byB0
aW1lcl9kZWwoKSB3aGVuIHRha2luZyB0aGUgc2hvcnRjdXQ/IFdlIGRvbid0IG5lY2Vzc2FyaWx5
DQo+IHJlZW50ZXIgdGhlIGNvcm91dGluZSBpbW1lZGlhdGVseSwgYnV0IG1pZ2h0IG9ubHkgYmUg
c2NoZWR1bGluZyBpdC4gSW4NCj4gdGhpcyBjYXNlLCB0aGUgdGltZXIgY291bGQgZmlyZSBiZWZv
cmUgcWVtdV9jb19zbGVlcF9ucygpIGhhcyBydW4gYW5kDQo+IHNjaGVkdWxlIHRoZSBjb3JvdXRp
bmUgYSBzZWNvbmQgdGltZQ0KDQpObyBpdCB3aWxsIG5vdCwgYXMgd2UgZG8gY21weGNoZywgc2No
ZWR1bGVkIHRvIE5VTEwsIHNvIHNlY29uZCBjYWxsIHdpbGwgZG8NCm5vdGhpbmcuLg0KDQpCdXQg
aXQgc2VlbXMgdW5zYWZlLCBhcyBldmVuIGNvcm91dGluZSBwb2ludGVyIG1heSBiZSBzdGFsZSB3
aGVuIHdlIGNhbGwNCnFlbXVfY29fc2xlZXBfd2FrZSBzZWNvbmQgdGltZS4gU28sIHdlIHBvc3Np
Ymx5IHNob3VsZCByZW1vdmUgdGltZXIsIGJ1dCAuLg0KDQogIChpZ25vcmluZyBjby0+c2NoZWR1
bGVkIGFnYWluIC0NCj4gbWF5YmUgd2Ugc2hvdWxkIGFjdHVhbGx5IG5vdCBkbyB0aGF0IGluIHRo
ZSB0aW1lciBjYWxsYmFjayBwYXRoLCBidXQNCj4gaW5zdGVhZCBsZXQgaXQgcnVuIGludG8gdGhl
IGFzc2VydGlvbiBiZWNhdXNlIGl0IHdvdWxkIGJlIGEgYnVnIGZvciB0aGUNCj4gdGltZXIgY2Fs
bGJhY2sgdG8gZW5kIHVwIGluIHRoaXMgc2l0dWF0aW9uKS4NCj4gDQo+IEtldmluDQo+IA0KDQpJ
bnRlcmVzdGluZywgY291bGQgdGhlcmUgYmUgYSByYWNlIGNvbmRpdGlvbiwgd2hlbiB3ZSBjYWxs
IHFlbXVfY29fc2xlZXBfd2FrZSwNCmJ1dCBjb19zbGVlcF9jYiBhbHJlYWR5IHNjaGVkdWxlZCBp
biBzb21lIHF1ZXVlIGFuZCB3aWxsIHJ1biBzb29uPyBUaGVuIHJlbW92aW5nDQp0aGUgdGltZXIg
d2lsbCBub3QgaGVscC4NCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

