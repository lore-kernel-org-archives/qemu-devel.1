Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75296C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 12:02:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B204208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 12:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KwiJ4VT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B204208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60184 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heIFb-0002Ci-99
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 08:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56543)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1heICD-0008He-OK
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:59:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1heIC9-0007Fm-0X
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:59:09 -0400
Received: from mail-eopbgr10128.outbound.protection.outlook.com
 ([40.107.1.128]:6470 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1heIBy-0006xn-27; Fri, 21 Jun 2019 07:58:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=An0dTZ+pufjeZXpyYOJltMkWhtta2ilcErxUIwfxB/Y=;
 b=KwiJ4VT9wR/W7ZtDtXQhRuZnxm6QKCI6kLPdm0QFT9LbWQNqCYkJmB3xsHBM9Ebwwl+Jen+XzRNKfcASHo8tUSnq6YfVzlc66omZ+BZ3eEZXlZiRo9jCrFvzMu7mwkzYePulR2qn0isQdzS2rN4W3JFQE6//DCJNKQ/QIrDXMfo=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB4632.eurprd08.prod.outlook.com (10.255.78.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Fri, 21 Jun 2019 11:58:49 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 11:58:49 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH 06/12] block/dirty-bitmap: add bdrv_dirty_bitmap_claim
Thread-Index: AQHVJwQTrKoWj2MjDECsOSktNfqKGKaktRmAgAAJmoCAAUSgAA==
Date: Fri, 21 Jun 2019 11:58:48 +0000
Message-ID: <18f08b6a-fbe8-2899-6901-3ba59c39072d@virtuozzo.com>
References: <20190620010356.19164-1-jsnow@redhat.com>
 <20190620010356.19164-7-jsnow@redhat.com>
 <f9296483-d48f-521f-1ddd-d514e56b8fdf@redhat.com>
 <c956b213-24bf-355a-02e3-6b39ba682ae4@redhat.com>
In-Reply-To: <c956b213-24bf-355a-02e3-6b39ba682ae4@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0042.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::31) To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190621145846497
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad9cb462-c945-403a-a4de-08d6f63fd1fb
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4632; 
x-ms-traffictypediagnostic: DBBPR08MB4632:
x-microsoft-antispam-prvs: <DBBPR08MB4632804BC090DCD0D2089C8DC1E70@DBBPR08MB4632.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(39850400004)(136003)(376002)(396003)(199004)(189003)(7736002)(7416002)(6436002)(14444005)(6116002)(5660300002)(71200400001)(3846002)(478600001)(2501003)(66446008)(305945005)(53936002)(6486002)(36756003)(66946007)(54906003)(71190400001)(8936002)(68736007)(2616005)(31686004)(26005)(446003)(186003)(256004)(6506007)(476003)(64756008)(6512007)(6246003)(4326008)(110136005)(81166006)(229853002)(81156014)(11346002)(99286004)(2906002)(316002)(66476007)(386003)(2201001)(86362001)(52116002)(486006)(14454004)(25786009)(66066001)(76176011)(53546011)(66556008)(8676002)(73956011)(102836004)(31696002)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4632;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E2+mQnHj8SW5FxsgrzhriSPysRKa4LznYne4GzCtsZgg7eMNj+pPChI/N3P0jubtNLQZYDWsSJjCA2L6uWC+wrsH7gw8WHLKFdXxG+XtptLy9FUb5q6n87YFpS6o1ZXTU68wCTHBzw2v/xiuT8Oo69td0JBSRKaIaQNXPYn9y5sRMhNysn5bAdNYHs+npqteNbvqX7m3l1fKzFefC2q1kKdlvFg1OASrYaiTeeCvK9N9+psxfQtBHkEFcG9MLkovENbulwx4XPg37rMlmDp7WFdwxOhuIBirWqd4i1xOBJlqGMzVSXbUXSE5RwJgvKgZQjO9Tbnt1C/TUvlasFZdLC3L+ay+R/3vWQHe/DwPAo/2Z8+GKM/iqfDDQr55d5fTR4KV35zchqUsUlnXcDt1z/LXOt1o5zCxMFy1mDssk2o=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CD3F268A07CEA4286604BA57D4F6DF6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad9cb462-c945-403a-a4de-08d6f63fd1fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 11:58:48.9354 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4632
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.128
Subject: Re: [Qemu-devel] [PATCH 06/12] block/dirty-bitmap: add
 bdrv_dirty_bitmap_claim
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjAuMDYuMjAxOSAxOTozNiwgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDYvMjAvMTkg
MTI6MDIgUE0sIE1heCBSZWl0eiB3cm90ZToNCj4+IE9uIDIwLjA2LjE5IDAzOjAzLCBKb2huIFNu
b3cgd3JvdGU6DQo+Pj4gVGhpcyBmdW5jdGlvbiBjYW4gY2xhaW0gYW4gaGJpdG1hcCB0byByZXBs
YWNlIGl0cyBvd24gY3VycmVudCBoYml0bWFwLg0KPj4+IEluIHRoZSBjYXNlIHRoYXQgdGhlIGdy
YW51bGFyaXRpZXMgZG8gbm90IG1hdGNoLCBpdCB3aWxsIHVzZQ0KPj4+IGhiaXRtYXBfbWVyZ2Ug
dG8gY29weSB0aGUgYml0IGRhdGEgaW5zdGVhZC4NCj4+DQo+PiBJIHJlYWxseSBkbyBub3QgbGlr
ZSB0aGlzIG5hbWUgYmVjYXVzZSB0byBtZSBpdCBpbXBsaWVzIGEgcmVsYXRpb25zaGlwDQo+PiB0
byBiZHJ2X3JlY2xhaW1fZGlydHlfYml0bWFwKCkuICBNYXliZSBqdXN0IGJkcnZfZGlydHlfYml0
bWFwX3Rha2UoKT8NCj4+IE9yLCBpZiB5b3Ugd2FudCB0byBnZXQgbW9yZSBmYW5jeSwgYmRydl9k
aXJ0eV9kaXJ0eV9iaXRtYXBfc3RlYWwoKS4NCj4+IChCZWNhdXNlIHJlZmVyZW5jZXMgYXJlIHRh
a2VuIG9yIHN0b2xlbi4pDQo+Pg0KPiANCj4gdGFrZSBvciBzdGVhbCBpcyBnb29kLiBJIGp1c3Qg
d2FudGVkIHRvIGhpZ2hsaWdodCB0aGF0IGl0IHRydWx5IHRha2VzDQo+IG93bmVyc2hpcC4gVGhl
IGRvdWJsZS1wb2ludGVyIGFuZCBlcmFzaW5nIHRoZSBjYWxsZXIncyByZWZlcmVuY2UgZm9yDQo+
IGVtcGhhc2lzIG9mIHRoaXMgaWRlYS4NCg0KRGlkbid0IHlvdSBjb25zaWRlciBiZHJ2X2RpcnR5
X2JpdG1hcF9zZXRfaGJpdG1hcD8gSG1tLCBidXQgeW91ciBmdW5jdGlvbg0KYWN0dWFsbHkgZWF0
cyBwb2ludGVyLCBzbyAnc2V0JyBpcyBub3QgZW5vdWdoLi4gYmRydl9kaXJ0eV9iaXRtYXBfZWF0
X2hiaXRtYXA/DQoNCkFuZCB0byBiZSBzZXJpb3VzOiBpdCBpcyB0aGUgcG9pbnQgd2hlcmUgd2Ug
ZGVmaW5pdGVseSBzaG91bGQgZHJvcCBIQml0bWFwOm1ldGENCmZpZWxkLCBhcyBpdCBpbiBiYWQg
cmVsYXRpb24gd2l0aCBwYXJlbnQgaGJpdG1hcCBzdGVhbGluZy4NCg0KPiANCj4+IFRoZSBsYXR0
ZXIgbWlnaHQgZml0IGluIG5pY2VseSB3aXRoIHRoZSBhYmRpY2F0aW9uIHRoZW1lLiAgV2XigJlk
IGp1c3QNCj4+IG5lZWQgdG8gcmVuYW1lIGJkcnZfcmVjbGFpbV9kaXJ0eV9iaXRtYXAoKSB0bw0K
Pj4gYmRydl9kaXJ0eV9iaXRtYXBfYmFja3N0YWIoKSwgYW5kIGl04oCZZCBiZSBwZXJmZWN0Lg0K
Pj4NCj4gDQo+IERvbid0IHRlbXB0IG1lOyBJIGRvIGxpa2UgbXkgc2lsbHkgZnVuY3Rpb24gbmFt
ZXMuIFlvdSBhcmUgbHVja3kgSSBkb24ndA0KPiBjYWxsDQo+IA0KPj4gKE9uIGFub3RoZXIgbm90
ZTogYmRydl9yZXN0b3JlX2RpcnR5X2JpdG1hcCgpIHZzLg0KPj4gYmRydl9kaXJ0eV9iaXRtYXBf
cmVzdG9yZSgpIOKAkyByZWFsbHk/IDotLykNCj4+DQo+IA0KPiBJIGhhdmUgZG9uZSBhIHRlcnJp
YmxlIGpvYiBhdCBlbmZvcmNpbmcgYW55IGtpbmQgb2YgY29uc2lzdGVuY3kgaGVyZSwNCj4gYW5k
IGl0IGdldHMgbWUgYWxsIHRoZSB0aW1lIHRvby4gSSBoYWQgYSBiaWcgc2VyaWVzIHRoYXQgcmUt
YXJyYW5nZWQgYW5kDQo+IHJlLW5hbWVkIGEgdG9uIG9mIHN0dWZmIGp1c3QgdG8gbWFrZSB0aGlu
Z3MgYSBsaXR0bGUgbW9yZSBuaWNlciwgYnV0IEkNCj4gbGV0IGl0IGJpdHJvdCBiZWNhdXNlIEkg
ZGlkbid0IHdhbnQgdG8gZGVhbCB3aXRoIHRoZSBiaWtlLXNoZWRkaW5nLg0KPiANCj4gSSBkbyBh
Z3JlZSBJIGFtIGluIGRlc3BlcmF0ZSBuZWVkIG9mIGEgc3ByaW5nIGNsZWFuaW5nIGluIGhlcmUu
DQo+IA0KPiBPbmUgdGhpbmcgdGhhdCBkb2VzIHVwc2V0IG1lIHF1aXRlIG9mdGVuIGlzIHRoYXQg
dGhlIGNhbm9uaWNhbCBuYW1lIGZvcg0KPiB0aGUgc3RydWN0dXJlIGlzICJiZHJ2IGRpcnR5IGJp
dG1hcCIsIHdoaWNoIG1ha2VzIHRoZSBmdW5jdGlvbiBuYW1lcyBhbGwNCj4gcXVpdGUgbG9uZy4N
Cj4gDQo+Pj4gU2lnbmVkLW9mZi1ieTogSm9obiBTbm93IDxqc25vd0ByZWRoYXQuY29tPg0KPj4+
IC0tLQ0KPj4+ICAgaW5jbHVkZS9ibG9jay9ibG9ja19pbnQuaCB8ICAxICsNCj4+PiAgIGluY2x1
ZGUvcWVtdS9oYml0bWFwLmggICAgfCAgOCArKysrKysrKw0KPj4+ICAgYmxvY2svZGlydHktYml0
bWFwLmMgICAgICB8IDE0ICsrKysrKysrKysrKysrDQo+Pj4gICB1dGlsL2hiaXRtYXAuYyAgICAg
ICAgICAgIHwgIDUgKysrKysNCj4+PiAgIDQgZmlsZXMgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygr
KQ0KPj4NCj4+IFRoZSBpbXBsZW1lbnRhdGlvbiBsb29rcyBnb29kIHRvIG1lLg0KPj4NCj4+IE1h
eA0KPj4NCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

