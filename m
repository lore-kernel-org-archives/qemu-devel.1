Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D50C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 11:02:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25B2621473
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 11:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="itA3thDL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25B2621473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38470 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbNUr-0007Pc-2b
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 07:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40558)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbNRU-0004uN-CK
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 06:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbNJv-0007dk-8G
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 06:51:04 -0400
Received: from mail-eopbgr20116.outbound.protection.outlook.com
 ([40.107.2.116]:36869 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbNJv-0007d2-1R; Thu, 13 Jun 2019 06:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vF3bUxE71mDjtOeL2fGG/Ykg/vz74cjQTLFhvfZYtg=;
 b=itA3thDLJMpGYEDm720Md8VJMTNBhi5BmCePpkbZ9278kSEHMmbsjxy5EYCuVx54sNJ9nIez0yKwSNeQdEg/gVi3B69EGxNpNMgMbZgPnvLayROK4lo+UNH72Ook2/oCYrVhI09xf1yhNOuypn40vhTInrP+ytW1LeX/3Ivb6jc=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB4241.eurprd08.prod.outlook.com (20.179.32.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Thu, 13 Jun 2019 10:51:00 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 10:51:00 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 03/42] throttle: Support compressed writes
Thread-Index: AQHVIWudES3qKN4xPUm3kVZUkPmmfqaZaOwA
Date: Thu, 13 Jun 2019 10:51:00 +0000
Message-ID: <25b8f628-ac8c-c3e6-6285-6c4da4f1740c@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-4-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-4-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0026.eurprd09.prod.outlook.com
 (2603:10a6:7:15::15) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190613135058830
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bca8ab3-e72f-4103-cb01-08d6efed05d1
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB4241; 
x-ms-traffictypediagnostic: AM0PR08MB4241:
x-microsoft-antispam-prvs: <AM0PR08MB42419284C794B1E963FCEB52C1EF0@AM0PR08MB4241.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:229;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39850400004)(136003)(346002)(376002)(366004)(199004)(189003)(52116002)(476003)(110136005)(99286004)(54906003)(486006)(86362001)(6486002)(386003)(6506007)(6436002)(8676002)(81166006)(81156014)(229853002)(8936002)(31696002)(76176011)(186003)(6116002)(71200400001)(2906002)(71190400001)(3846002)(26005)(316002)(102836004)(66066001)(66476007)(66556008)(256004)(2616005)(446003)(2501003)(7736002)(305945005)(14454004)(53936002)(6512007)(66446008)(66946007)(73956011)(4326008)(64756008)(478600001)(5660300002)(25786009)(11346002)(6246003)(31686004)(36756003)(68736007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4241;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XMbyFCejBrQt7L9NMlWZj59ah/GltZn4PUQNrUHsAW3uf8+BlO4j7V8Xqb2h0XDcp3Wvp/49THcA8B9l8zJfdlVH6hShHEQ0wrGiiVtQiN1hxepOkBw007iPy3gSsiCMO1zeVCZa6JtqBqSTqYd6MEcdtiBUBoWXvRoRXwicfIfPYN3Gs5i3KxgpuxpQI2KZ6WQ4ZDU1SKHVU/2YfEI5c90QSt5jtJRtsr25j9FrGD9L3x50CrMTkqBqGT4AozaGz/n9f546c31voMEUFX1+Zl6KTbpCPcKht/XeHd0Izr6T1PsRdZ0ey2Y8Glc5ZpC5NVocxze/NTiuU9ib5taPYC6uccvjfHrhaUxue7aRuCXHWgfgNczMr0+xtRQ5YiFVmqMp5y9f0krbZbXCdRyEQEVWM7IiT6NzHoyny3gVamk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69569265EC1F0A4BAC90F53F3D96FA9D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bca8ab3-e72f-4103-cb01-08d6efed05d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 10:51:00.5975 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4241
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.116
Subject: Re: [Qemu-devel] [PATCH v5 03/42] throttle: Support compressed
 writes
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

MTMuMDYuMjAxOSAxOjA5LCBNYXggUmVpdHogd3JvdGU6DQo+IFNpZ25lZC1vZmYtYnk6IE1heCBS
ZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRz
b3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQoNCj4gLS0tDQo+ICAgYmxv
Y2svdGhyb3R0bGUuYyB8IDEwICsrKysrKysrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5z
ZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Jsb2NrL3Rocm90dGxlLmMgYi9ibG9jay90
aHJvdHRsZS5jDQo+IGluZGV4IGY2NGRjYzI3YjkuLmRlMWI2YmQ3ZTggMTAwNjQ0DQo+IC0tLSBh
L2Jsb2NrL3Rocm90dGxlLmMNCj4gKysrIGIvYmxvY2svdGhyb3R0bGUuYw0KPiBAQCAtMTUyLDYg
KzE1MiwxNSBAQCBzdGF0aWMgaW50IGNvcm91dGluZV9mbiB0aHJvdHRsZV9jb19wZGlzY2FyZChC
bG9ja0RyaXZlclN0YXRlICpicywNCj4gICAgICAgcmV0dXJuIGJkcnZfY29fcGRpc2NhcmQoYnMt
PmZpbGUsIG9mZnNldCwgYnl0ZXMpOw0KPiAgIH0NCj4gICANCj4gK3N0YXRpYyBpbnQgY29yb3V0
aW5lX2ZuIHRocm90dGxlX2NvX3B3cml0ZXZfY29tcHJlc3NlZChCbG9ja0RyaXZlclN0YXRlICpi
cywNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB1aW50NjRfdCBvZmZzZXQsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3QgYnl0ZXMsDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUUVNVUlPVmVjdG9yICpx
aW92KQ0KPiArew0KPiArICAgIHJldHVybiB0aHJvdHRsZV9jb19wd3JpdGV2KGJzLCBvZmZzZXQs
IGJ5dGVzLCBxaW92LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJEUlZfUkVR
X1dSSVRFX0NPTVBSRVNTRUQpOw0KPiArfQ0KPiArDQo+ICAgc3RhdGljIGludCB0aHJvdHRsZV9j
b19mbHVzaChCbG9ja0RyaXZlclN0YXRlICpicykNCj4gICB7DQo+ICAgICAgIHJldHVybiBiZHJ2
X2NvX2ZsdXNoKGJzLT5maWxlLT5icyk7DQo+IEBAIC0yNTAsNiArMjU5LDcgQEAgc3RhdGljIEJs
b2NrRHJpdmVyIGJkcnZfdGhyb3R0bGUgPSB7DQo+ICAgDQo+ICAgICAgIC5iZHJ2X2NvX3B3cml0
ZV96ZXJvZXMgICAgICAgICAgICAgID0gICB0aHJvdHRsZV9jb19wd3JpdGVfemVyb2VzLA0KPiAg
ICAgICAuYmRydl9jb19wZGlzY2FyZCAgICAgICAgICAgICAgICAgICA9ICAgdGhyb3R0bGVfY29f
cGRpc2NhcmQsDQo+ICsgICAgLmJkcnZfY29fcHdyaXRldl9jb21wcmVzc2VkICAgICAgICAgPSAg
IHRocm90dGxlX2NvX3B3cml0ZXZfY29tcHJlc3NlZCwNCj4gICANCj4gICAgICAgLmJkcnZfcmVj
dXJzZV9pc19maXJzdF9ub25fZmlsdGVyICAgPSAgIHRocm90dGxlX3JlY3Vyc2VfaXNfZmlyc3Rf
bm9uX2ZpbHRlciwNCj4gICANCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

