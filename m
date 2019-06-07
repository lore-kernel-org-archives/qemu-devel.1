Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E072C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 12:28:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5666A212F5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 12:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="f4KJwmk3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5666A212F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49984 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZDzO-0001HO-Kg
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 08:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52689)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hZCtb-0006N1-PS
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 07:18:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hZCta-0008Qj-GB
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 07:18:55 -0400
Received: from mail-eopbgr60094.outbound.protection.outlook.com
 ([40.107.6.94]:13094 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hZCt3-0007Cr-Sk; Fri, 07 Jun 2019 07:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9CXSM30U7JngZUfguuKbTszMTyCLt9KDOIVaKHOzm0=;
 b=f4KJwmk3YnF2mnUmqWtOegESCAbuOecjCcHf6ROUIEU1lJt46wNBF84rIfCZRPLOJadK1mPPHCNT6yPn+Bd4op+HxnMC9xxrR97ajGn8aAHSr2iTXKpU8ht6E469IXvbJDLF8obmkL3ysvrRn7UGZsKrQJpC339PwzdlyYqEwWA=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
 AM0PR08MB4049.eurprd08.prod.outlook.com (20.178.119.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.15; Fri, 7 Jun 2019 11:18:15 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
 ([fe80::8d90:32ae:bdd6:48e8]) by AM0PR08MB2961.eurprd08.prod.outlook.com
 ([fe80::8d90:32ae:bdd6:48e8%7]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 11:18:15 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH v6 5/7] qemu-coroutine-sleep: introduce qemu_co_sleep_wake
Thread-Index: AQHU8IvPncRKmUnNFESi2c9mvKXDwqaQLEMAgAA4CAA=
Date: Fri, 7 Jun 2019 11:18:15 +0000
Message-ID: <16b7ad42-611c-fc3e-2029-d491882b0750@virtuozzo.com>
References: <20190411172709.205032-1-vsementsov@virtuozzo.com>
 <20190411172709.205032-6-vsementsov@virtuozzo.com>
 <20190607075740.GA5055@dhcp-200-226.str.redhat.com>
In-Reply-To: <20190607075740.GA5055@dhcp-200-226.str.redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0144.eurprd05.prod.outlook.com
 (2603:10a6:7:28::31) To AM0PR08MB2961.eurprd08.prod.outlook.com
 (2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190607141812673
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7be076d8-4255-445b-614f-08d6eb39d578
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB4049; 
x-ms-traffictypediagnostic: AM0PR08MB4049:
x-microsoft-antispam-prvs: <AM0PR08MB4049163AB33490982925070FC1100@AM0PR08MB4049.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39850400004)(346002)(396003)(376002)(136003)(199004)(189003)(73956011)(2906002)(7736002)(54906003)(229853002)(305945005)(25786009)(316002)(53936002)(31686004)(6436002)(52116002)(11346002)(4326008)(81166006)(81156014)(66066001)(8676002)(6512007)(107886003)(68736007)(8936002)(71190400001)(71200400001)(6916009)(6486002)(6246003)(36756003)(14444005)(486006)(66476007)(102836004)(476003)(86362001)(99286004)(66446008)(3846002)(5660300002)(64756008)(6116002)(14454004)(66556008)(446003)(76176011)(2616005)(386003)(6506007)(26005)(478600001)(186003)(66946007)(31696002)(256004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4049;
 H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: I5SuRrHIvlnY5OBmYkS79mnP/qLzoilcvnME53OKZlk8jEOYRy27oTKwrPt2zTO5Q9dNQO+gouyRP5CPQJkTGddvuszr8yUs/wyl851nngUn0oXmtu9nc8RVo1uexGDdYcVNL4QPus2YybO95dwS+FX7Nxc7jwHtUomYg6mFidFlwC02sKKmDX1GFubHiO/qsGoWAjHZoGTSnZx3Z446PyDS9ZygCHmqU9WknxT6wcKDTi3rQ1wEKYLaMYpDnaV3ss2PmI81Q8m1bK7Omb8HTaeuRMio7/x2TWBuGkzMQI0tjjdzQiAhyN29CPd3U9VkOgh/y0QRDfuGC0xfl4AwMdVQ1Bz1saD9qNHKEvZB+ZE3tT2RHXe615SEOHraQqQ+a03kgLAswfBZuhfM6MB+3+rviYf6BJty5iiykW8HQr4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D51ACC93A4223F43A96085D8B0AA8BAE@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be076d8-4255-445b-614f-08d6eb39d578
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 11:18:15.4218 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4049
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.94
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

MDcuMDYuMjAxOSAxMDo1NywgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMTEuMDQuMjAxOSB1bSAx
OToyNyBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IElu
dHJvZHVjZSBhIGZ1bmN0aW9uIHRvIGdyYWNlZnVsbHkgd2FrZS11cCBhIGNvcm91dGluZSwgc2xl
ZXBpbmcgaW4NCj4+IHFlbXVfY29fc2xlZXBfbnMoKSBzbGVlcC4NCj4+DQo+PiBTaWduZWQtb2Zm
LWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5j
b20+DQo+IA0KPiBZb3UgY2FuIHNpbXBseSByZWVudGVyIHRoZSBjb3JvdXRpbmUgd2hpbGUgaXQg
aGFzIHlpZWxkZWQgaW4NCj4gcWVtdV9jb19zbGVlcF9ucygpLiBUaGlzIGlzIHN1cHBvcnRlZC4N
Cg0KTm8gaXQgZG9lc24ndC4gcWVtdV9haW9fY29yb3V0aW5lX2VudGVyIGNoZWNrcyBmb3Igc2No
ZWR1bGVkIGZpZWxkLCBhbmQgYWJvcnRzDQppZiBpdCBpcyBzZXQuDQoNCklmIEkganVzdCB1c2Ug
YWlvX2NvX2VudGVyIGluc3RlYWQgb2YgbXkgbmV3IGZ1bmN0aW9uLCBJIGdldCBpbnRvDQoNCiMx
ICAweDAwMDA3ZjVkMjUxNGY4ZjggaW4gX19HSV9hYm9ydCAoKSBhdCBhYm9ydC5jOjkwDQojMiAg
MHgwMDAwNTVlOWM4MTQ1Mjc4IGluIHFlbXVfYWlvX2Nvcm91dGluZV9lbnRlciAoY3R4PTB4NTVl
OWM5YjEyMzAwLCBjbz0weDU1ZTljOWIyM2NiMCkNCiAgICAgYXQgdXRpbC9xZW11LWNvcm91dGlu
ZS5jOjEzMg0KIzMgIDB4MDAwMDU1ZTljODEyNGY2ZCBpbiBhaW9fY29fZW50ZXIgKGN0eD0weDU1
ZTljOWIxMjMwMCwgY289MHg1NWU5YzliMjNjYjApIGF0IHV0aWwvYXN5bmMuYzo0OTQNCiM0ICAw
eDAwMDA1NWU5YzgxMjRlYjEgaW4gYWlvX2NvX3dha2UgKGNvPTB4NTVlOWM5YjIzY2IwKSBhdCB1
dGlsL2FzeW5jLmM6NDc4DQojNSAgMHgwMDAwNTVlOWM4MDhkNWQ0IGluIG5iZF90ZWFyZG93bl9j
b25uZWN0aW9uIChicz0weDU1ZTljOWIxYmM1MCkgYXQgYmxvY2svbmJkLWNsaWVudC5jOjg4DQoj
NiAgMHgwMDAwNTVlOWM4MDkwNjczIGluIG5iZF9jbGllbnRfY2xvc2UgKGJzPTB4NTVlOWM5YjFi
YzUwKSBhdCBibG9jay9uYmQtY2xpZW50LmM6MTI4OQ0KIzcgIDB4MDAwMDU1ZTljODA4Y2EzZiBp
biBuYmRfY2xvc2UgKGJzPTB4NTVlOWM5YjFiYzUwKSBhdCBibG9jay9uYmQuYzo0ODYNCiM4ICAw
eDAwMDA1NWU5YzgwMDZjZDYgaW4gYmRydl9jbG9zZSAoYnM9MHg1NWU5YzliMWJjNTApIGF0IGJs
b2NrLmM6Mzg0MQ0KDQooZ2RiKSBmciAyDQojMiAgMHgwMDAwNTVlOWM4MTQ1Mjc4IGluIHFlbXVf
YWlvX2Nvcm91dGluZV9lbnRlciAoY3R4PTB4NTVlOWM5YjEyMzAwLCBjbz0weDU1ZTljOWIyM2Ni
MCkNCiAgICAgYXQgdXRpbC9xZW11LWNvcm91dGluZS5jOjEzMg0KMTMyICAgICAgICAgICAgICAg
ICBhYm9ydCgpOw0KKGdkYikgbGlzdA0KMTI3ICAgICAgICAgICAgICAqIGJlZW4gZGVsZXRlZCAq
Lw0KMTI4ICAgICAgICAgICAgIGlmIChzY2hlZHVsZWQpIHsNCjEyOSAgICAgICAgICAgICAgICAg
ZnByaW50ZihzdGRlcnIsDQoxMzAgICAgICAgICAgICAgICAgICAgICAgICAgIiVzOiBDby1yb3V0
aW5lIHdhcyBhbHJlYWR5IHNjaGVkdWxlZCBpbiAnJXMnXG4iLA0KMTMxICAgICAgICAgICAgICAg
ICAgICAgICAgIF9fZnVuY19fLCBzY2hlZHVsZWQpOw0KMTMyICAgICAgICAgICAgICAgICBhYm9y
dCgpOw0KMTMzICAgICAgICAgICAgIH0NCjEzNA0KMTM1ICAgICAgICAgICAgIGlmICh0by0+Y2Fs
bGVyKSB7DQoxMzYgICAgICAgICAgICAgICAgIGZwcmludGYoc3RkZXJyLCAiQ28tcm91dGluZSBy
ZS1lbnRlcmVkIHJlY3Vyc2l2ZWx5XG4iKTsNCihnZGIpIHAgc2NoZWR1bGVkDQokMSA9IDB4NTVl
OWM4MThlOTkwICJxZW11X2NvX3NsZWVwX25zIg0KDQoNCj4gDQo+IEkgdGhpbmsgd2hhdCB5b3Ug
YWRkIGhlcmUgaXMganVzdCB0aGUgY29uZGl0aW9uIHRoYXQgeW91IHdha2UgdXAgdGhlDQo+IGNv
cm91dGluZSBvbmx5IGlmIGl0J3MgY3VycmVudGx5IHNsZWVwaW5nLCBidXQgbm90IHdoZW4gaXQg
aGFzIHlpZWxkZWQNCj4gZm9yIG90aGVyIHJlYXNvbnMuIFRoaXMgc3VnZ2VzdHMgdGhhdCB5b3Un
cmUgdHJ5aW5nIHRvIHJlZW50ZXIgYQ0KPiBjb3JvdXRpbmUgb2Ygd2hpY2ggeW91IGRvbid0IGtu
b3cgd2hlcmUgZXhhY3RseSBpbiBpdHMgY29kZSBpdCBjdXJyZW50bHkNCj4gaXMuIFRoaXMgaXMg
d3JvbmcuDQo+IA0KPiBKdXN0IGtub3dpbmcgdGhhdCBpdCdzIHNsZWVwaW5nIGRvZXNuJ3QgdGVs
bCB5b3Ugd2hlcmUgdGhlIGNvcm91dGluZSBpcy4NCj4gSXQgY291bGQgaGF2ZSBjYWxsZWQgYSBm
dW5jdGlvbiB0aGF0IHNsZWVwcyBpbnRlcm5hbGx5IGFuZCBtdXN0IG5vdCBiZQ0KPiB3b2tlbiB1
cCBlYXJseS4gSWYgeW91IHJlZW50ZXIgYSBjb3JvdXRpbmUsIHlvdSBhbHdheXMgbXVzdCBrbm93
IHRoZQ0KPiBleGFjdCBwb2ludCB3aGVyZSBpdCB5aWVsZGVkIChvciBpbiBleGNlcHRpb25hbCBj
YXNlcywgdGhlIGV4YWN0IHBvaW50cw0KPiAocGx1cmFsKSkuIEp1c3QgcmVlbnRlcmluZyBiZWNh
dXNlIGl0IHNsZWVwcyB3aWxsIHdha2UgaXQgdXAgaW4NCj4gdW5leHBlY3RlZCBwbGFjZXMsIGdl
bmVyYWxseSBzcGVha2luZy4NCj4gDQo+IFNvIEkgZG9uJ3QgdGhpbmsgdGhpcyBmdW5jdGlvbiBp
cyBhIGdvb2QgaWRlYS4gSXQncyB0b28gZWFzeSB0byBtaXN1c2UsDQo+IGFuZCBpZiB5b3UgZG9u
J3QgbWlzdXNlIGl0LCB5b3UgY2FuIGRpcmVjdGx5IGNhbGwgYWlvX2NvX3dha2UoKS4NCj4gDQo+
IEtldmluDQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

