Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F8BC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 16:53:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DBD62183F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 16:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="W9sf2Rl3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DBD62183F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53504 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbpSN-0005Wx-Oc
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 12:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47600)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbpMs-0001kw-Ex
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 12:47:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbpMr-0005wT-A8
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 12:47:58 -0400
Received: from mail-eopbgr30114.outbound.protection.outlook.com
 ([40.107.3.114]:15392 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbpMr-0005vB-4A; Fri, 14 Jun 2019 12:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAv4rwlqksdSfwFvxnAR1to30yEAYWW7p4CpfUm4BQA=;
 b=W9sf2Rl3A6RKUcVmBJuLCOXN/X7YE9j8gvccu3xWA2GUdgLNhY80keFsz7jWZ5sIS/gSqi5D0gdDNN2J1ToaBzTmGD3Vn1ii8BuVp10aEDiZdtB70iRfIbnS3NCGVlwYr/ciu4mcyFNIPjQd7VVCui+awEa9gHnXFbXv/ylJg90=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB3649.eurprd08.prod.outlook.com (20.177.43.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Fri, 14 Jun 2019 16:47:55 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Fri, 14 Jun 2019
 16:47:55 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 20/42] block/snapshot: Fall back to storage child
Thread-Index: AQHVIWu4l6UN/Up3D0WYM48oNvM85KabeYeA///bB4CAAApqAA==
Date: Fri, 14 Jun 2019 16:47:54 +0000
Message-ID: <c5a08e6f-d89c-28b2-803e-a9bf3f55b603@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-21-mreitz@redhat.com>
 <ceef507e-16d0-0edf-0e2d-64c5b4d613ef@virtuozzo.com>
 <bc1cdeca-2708-e122-c157-d08750e32ed6@redhat.com>
In-Reply-To: <bc1cdeca-2708-e122-c157-d08750e32ed6@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0802CA0015.eurprd08.prod.outlook.com (10.172.123.153)
 To AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190614194752055
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f07f7217-1728-4540-513b-08d6f0e80c2a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB3649; 
x-ms-traffictypediagnostic: AM0PR08MB3649:
x-microsoft-antispam-prvs: <AM0PR08MB364968B13ACE61B9C0081CCFC1EE0@AM0PR08MB3649.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(39850400004)(346002)(376002)(136003)(189003)(199004)(4326008)(73956011)(31696002)(316002)(14454004)(6116002)(478600001)(66476007)(86362001)(8936002)(2501003)(54906003)(2906002)(71190400001)(229853002)(6436002)(3846002)(66946007)(71200400001)(6486002)(53936002)(66446008)(64756008)(6512007)(66556008)(36756003)(11346002)(53546011)(110136005)(25786009)(486006)(14444005)(256004)(31686004)(81166006)(2616005)(476003)(68736007)(386003)(305945005)(186003)(52116002)(76176011)(446003)(7736002)(26005)(8676002)(6506007)(102836004)(81156014)(99286004)(66066001)(6246003)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3649;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2AnmR2zY37MfKlqiflPRHGuMN7H13bD+1IAVkIhgGwefEqkJX4atHusX1+rcvGapZGBJnazNoAHkRiHYpCvtg6yQvJjGBpcY6p/F5LHm+VMGE62YibVDKHWd397Vf791NQ4ciFvDoCH99MtvyXn/hhpHF+zNSd3/V9gjr+Ymliqdvv3477quSS2xFa3uLHlHUv81hSHYkBzIzKsjg13qApA95GIWKAv1c7utgYaeJUJggipokO5zK3o2wGFD3ePA+4ZwuAUdjJXm2bwyoWdaTsW+ARUx1rvGEMBB4NPORHGffKMMQaclXqhjj8fVRTmc8a7pBfcNV1ucXREa/2458XCwSpO4MvcA7jcF6/owbd6xC9FL1SBnjAsB/DdvNTq8/jqO4FbF4A6br/VsrnLjLtAnXHqtQxQ+7xTo1FprpoI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C27B86F065D85B4A82EF69B3F1C9C2D0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f07f7217-1728-4540-513b-08d6f0e80c2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 16:47:54.9591 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3649
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.114
Subject: Re: [Qemu-devel] [PATCH v5 20/42] block/snapshot: Fall back to
 storage child
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

MTQuMDYuMjAxOSAxOToxMCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxNC4wNi4xOSAxNzoyMiwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDEzLjA2LjIwMTkgMTowOSwg
TWF4IFJlaXR6IHdyb3RlOg0KPj4+IElmIHRoZSB0b3Agbm9kZSdzIGRyaXZlciBkb2VzIG5vdCBw
cm92aWRlIHNuYXBzaG90IGZ1bmN0aW9uYWxpdHkgYW5kIHdlDQo+Pj4gd2FudCB0byBnbyBkb3du
IHRoZSBjaGFpbiwgd2Ugc2hvdWxkIGdvIHRvd2FyZHMgdGhlIGNoaWxkIHdoaWNoIHN0b3Jlcw0K
Pj4+IHRoZSBkYXRhLCBpLmUuIHRoZSBzdG9yYWdlIGNoaWxkLg0KPj4+DQo+Pj4gYmRydl9zbmFw
c2hvdF9nb3RvKCkgYmVjb21lcyBhIGJpdCB3ZWlyZCBiZWNhdXNlIHdlIG1heSBoYXZlIHRvIHJl
ZGlyZWN0DQo+Pj4gdGhlIGFjdHVhbCBjaGlsZCBwb2ludGVyLCBzbyBpdCBvbmx5IHdvcmtzIGlm
IHRoZSBzdG9yYWdlIGNoaWxkIGlzDQo+Pj4gYnMtPmZpbGUgb3IgYnMtPmJhY2tpbmcgKGFuZCB0
aGVuIHdlIGhhdmUgdG8gZmluZCBvdXQgd2hpY2ggaXQgaXMpLg0KPj4+DQo+Pj4gU2lnbmVkLW9m
Zi1ieTogTWF4IFJlaXR6IDxtcmVpdHpAcmVkaGF0LmNvbT4NCj4+PiAtLS0NCj4+PiAgICBibG9j
ay9zbmFwc2hvdC5jIHwgNzQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tDQo+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDUzIGluc2VydGlvbnMoKyksIDIxIGRl
bGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2Jsb2NrL3NuYXBzaG90LmMgYi9ibG9j
ay9zbmFwc2hvdC5jDQo+Pj4gaW5kZXggZjJmNDhmOTI2YS4uNThjZDY2N2YzYSAxMDA2NDQNCj4+
PiAtLS0gYS9ibG9jay9zbmFwc2hvdC5jDQo+Pj4gKysrIGIvYmxvY2svc25hcHNob3QuYw0KPj4+
IEBAIC0xNTQsOCArMTU0LDkgQEAgaW50IGJkcnZfY2FuX3NuYXBzaG90KEJsb2NrRHJpdmVyU3Rh
dGUgKmJzKQ0KPj4+ICAgICAgICB9DQo+Pj4gICAgDQo+Pj4gICAgICAgIGlmICghZHJ2LT5iZHJ2
X3NuYXBzaG90X2NyZWF0ZSkgew0KPj4+IC0gICAgICAgIGlmIChicy0+ZmlsZSAhPSBOVUxMKSB7
DQo+Pj4gLSAgICAgICAgICAgIHJldHVybiBiZHJ2X2Nhbl9zbmFwc2hvdChicy0+ZmlsZS0+YnMp
Ow0KPj4+ICsgICAgICAgIEJsb2NrRHJpdmVyU3RhdGUgKnN0b3JhZ2VfYnMgPSBiZHJ2X3N0b3Jh
Z2VfYnMoYnMpOw0KPj4+ICsgICAgICAgIGlmIChzdG9yYWdlX2JzKSB7DQo+Pj4gKyAgICAgICAg
ICAgIHJldHVybiBiZHJ2X2Nhbl9zbmFwc2hvdChzdG9yYWdlX2JzKTsNCj4+PiAgICAgICAgICAg
IH0NCj4+PiAgICAgICAgICAgIHJldHVybiAwOw0KPj4+ICAgICAgICB9DQo+Pg0KPj4gSG1tIGlz
IGl0IGNvcnJlY3QgYXQgYWxsIGRvaW5nIGEgc25hcHNob3QsIHdoZW4gdG9wIGZvcm1hdCBub2Rl
IGRvZXNuJ3Qgc3VwcG9ydCBpdCwNCj4+IG1ldGFkYXRhIGNoaWxkIGRvZXNuJ3Qgc3VwcG9ydCBp
dCBhbmQgc3RvcmFnZSBjaGlsZCBzdXBwb3J0cz8gRG9pbmcgc25hcHNob3RzIG9mDQo+PiBzdG9y
YWdlIGNoaWxkIHNlZW1zIHVzZWxlc3MsIGFzIGRhdGEgZmlsZSBtdXN0IGJlIGluIHN5bmMgd2l0
aCBtZXRhZGF0YS4NCj4gDQo+IFlvdeKAmXJlIHJpZ2h0Lg0KPiANCj4gVGhhdOKAmXMgYWN0dWFs
bHkgYSBidWcgYWxyZWFkeS4gIFZNREsgY2FuIHN0b3JlIGRhdGEgaW4gbXVsdGlwbGUNCj4gY2hp
bGRyZW4sIGJ1dCBpdCBkb2VzIG5vdCBzdXBwb3J0IHNuYXBzaG90cy4gIFNvIGlmIHlvdSBzdG9y
ZSBzdWNoIGENCj4gc3BsaXQgVk1ESyBkaXNrIG9uIGFuIFJCRCB2b2x1bWUsIGl0IGlzIHBvc3Np
YmxlIHRoYXQganVzdCB0aGUNCj4gZGVzY3JpcHRvciBmaWxlIGlzIHNuYXBzaG90dGVkLCBidXQg
bm90aGluZyBlbHNlLg0KPiANCj4gSG1tbS4gIEkgdGhpbmsgdGhlIGJlc3Qgd2F5IGlzIHRvIGNo
ZWNrIHdoZXRoZXIgdGhlcmUgaXMgZXhhY3RseSBvbmUNCj4gY2hpbGQgdGhhdCBpcyBub3QgdGhl
IGJkcnZfZmlsdGVyZWRfY293X2NoaWxkKCkuICBJZiBzbywgd2UgY2FuIGdvIGRvd24NCj4gdG8g
aXQgYW5kIHNuYXBzaG90IGl0LiAgT3RoZXJ3aXNlLCB0aGUgbm9kZSBkb2VzIG5vdCBzdXBwb3J0
IHNuYXBzaG90cy4NCj4gDQoNCkFueXRoaW5nIHByZXZlbnRzIGZvcm1hdCBub2RlIHRvIHN0b3Jl
IHNvbWV0aGluZyBub3QgaW4gYSBiZHJ2IGNoaWxkIGJ1dCBpbiBzb21ldGhpbmcgc2VwYXJhdGU/
DQoNCk1heSBiZSB0aGUgc2FmZXN0IHdheSBpcyB0byBmYWxsIGJhY2sgb25seSBmb3IgZmlsdGVy
IG5vZGVzLg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

