Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16534C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 13:59:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D88F72084B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 13:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="I7QZTOwW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88F72084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58288 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdEeH-0002pS-1w
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 09:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56725)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hdEdG-00026t-6e
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 09:58:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hdEdE-0006fH-9c
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 09:58:41 -0400
Received: from mail-eopbgr70113.outbound.protection.outlook.com
 ([40.107.7.113]:40777 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hdEdA-0006au-QE; Tue, 18 Jun 2019 09:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tObQzFgH3lyx7NgAORIK6RqJbIKEWfzp7hDYDoWjdBQ=;
 b=I7QZTOwWOq2KHe1KwqUVIulSuQBAOJyWTfC5uTjL9EoyUGbww5u4p7nFzjuRcR8Bkca2flJWnn6l+diwP4pWpqGx/RGPs4xO+QTVfcmEY1TCCUjiYBnS2eKemxKjW2GjfidaNUdaLwnqx7afW+3Bb4+8N2HRNvjpPHMhw5Urfsc=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB4474.eurprd08.prod.outlook.com (20.179.43.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Tue, 18 Jun 2019 13:58:31 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 13:58:31 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 29/42] nbd: Use CAF when looking for dirty bitmap
Thread-Index: AQHVIWvGnDemPTXXKEaa8XjadZHnxaahePcA
Date: Tue, 18 Jun 2019 13:58:31 +0000
Message-ID: <d27020e0-c4a7-bca7-98a6-97aa33a74ae9@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-30-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-30-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0015.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::25) To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190618165828677
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7459ab3f-b31b-41e5-ebd0-08d6f3f50ba0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4474; 
x-ms-traffictypediagnostic: DBBPR08MB4474:
x-microsoft-antispam-prvs: <DBBPR08MB4474D13DF4030DFB55CAEBFAC1EA0@DBBPR08MB4474.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(346002)(376002)(396003)(39850400004)(136003)(366004)(189003)(199004)(476003)(66066001)(2501003)(446003)(2906002)(6116002)(52116002)(71200400001)(5660300002)(76176011)(478600001)(53936002)(6486002)(305945005)(99286004)(86362001)(7736002)(6512007)(71190400001)(31696002)(4326008)(31686004)(66556008)(81166006)(64756008)(66476007)(486006)(81156014)(256004)(68736007)(66446008)(229853002)(6246003)(6436002)(110136005)(11346002)(186003)(3846002)(36756003)(386003)(25786009)(6506007)(316002)(26005)(8676002)(2616005)(102836004)(54906003)(8936002)(66946007)(73956011)(14454004)(14143004)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4474;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eN0wVT8JnbSLaF/fHGKeGDVwrrrMCAimWIwC1sFcgpvCe+5f4KUeVV9+yOBoVz4xiBM3s7eGyBIpUr+UGMFIdREOuwn42P3ZWwfbhXBsPJ5fchF2XqBPNJygwZx6kVSSlq0h0KmRYZMAAfIhAfOwLUeAH0ZLpR5TxYkHUFNeqp9JbZXKyKW9TeOP4cQD5ai9TY5n3WF26WAQ0ZFluf6UyyEAyVhY0qDZsv2qIB7T5ye+vgPVa+38FpUFqEon9O7SCfCBpxBMDoHzOrVEpu1Q42Qh46Oo95Mmkk0DMNBLOGKFEmV5pHUWKx27z0NdcnqZTvC5eqDhCyAnuPdSVEDwTTKoxDMKOsJPSuO0eDWl4n0Pk+ToxuC6/zFkEH0Vpf10d1xP6lN0Vq0Gv9L4oN15b9daGITLvTHzAooX2rU6/0g=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD1CDFB14DACD04FAA6BBE417D1911B7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7459ab3f-b31b-41e5-ebd0-08d6f3f50ba0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 13:58:31.0784 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4474
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.113
Subject: Re: [Qemu-devel] [PATCH v5 29/42] nbd: Use CAF when looking for
 dirty bitmap
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

MTMuMDYuMjAxOSAxOjA5LCBNYXggUmVpdHogd3JvdGU6DQo+IFdoZW4gbG9va2luZyBmb3IgYSBk
aXJ0eSBiaXRtYXAgdG8gc2hhcmUsIHdlIHNob3VsZCBoYW5kbGUgZmlsdGVycyBieQ0KPiBqdXN0
IGluY2x1ZGluZyB0aGVtIGluIHRoZSBzZWFyY2ggKHNvIHRoZXkgZG8gbm90IGJyZWFrIGJhY2tp
bmcgY2hhaW5zKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1heCBSZWl0eiA8bXJlaXR6QHJlZGhh
dC5jb20+DQo+IC0tLQ0KPiAgIG5iZC9zZXJ2ZXIuYyB8IDYgKysrLS0tDQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9uYmQvc2VydmVyLmMgYi9uYmQvc2VydmVyLmMNCj4gaW5kZXggYWVjYTM4OTNmZS4uMGQ1MWQ0
NmI4MSAxMDA2NDQNCj4gLS0tIGEvbmJkL3NlcnZlci5jDQo+ICsrKyBiL25iZC9zZXJ2ZXIuYw0K
PiBAQCAtMTUwOCwxMyArMTUwOCwxMyBAQCBOQkRFeHBvcnQgKm5iZF9leHBvcnRfbmV3KEJsb2Nr
RHJpdmVyU3RhdGUgKmJzLCB1aW50NjRfdCBkZXZfb2Zmc2V0LA0KPiAgICAgICBpZiAoYml0bWFw
KSB7DQo+ICAgICAgICAgICBCZHJ2RGlydHlCaXRtYXAgKmJtID0gTlVMTDsNCj4gICANCj4gLSAg
ICAgICAgd2hpbGUgKHRydWUpIHsNCj4gKyAgICAgICAgd2hpbGUgKGJzKSB7DQo+ICAgICAgICAg
ICAgICAgYm0gPSBiZHJ2X2ZpbmRfZGlydHlfYml0bWFwKGJzLCBiaXRtYXApOw0KPiAtICAgICAg
ICAgICAgaWYgKGJtICE9IE5VTEwgfHwgYnMtPmJhY2tpbmcgPT0gTlVMTCkgew0KPiArICAgICAg
ICAgICAgaWYgKGJtICE9IE5VTEwpIHsNCj4gICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ICAg
ICAgICAgICAgICAgfQ0KPiAgIA0KPiAtICAgICAgICAgICAgYnMgPSBicy0+YmFja2luZy0+YnM7
DQo+ICsgICAgICAgICAgICBicyA9IGJkcnZfZmlsdGVyZWRfYnMoYnMpOw0KPiAgICAgICAgICAg
fQ0KPiAgIA0KPiAgICAgICAgICAgaWYgKGJtID09IE5VTEwpIHsNCj4gDQoNCkhtbSwgSSdtIGEg
Yml0IGNvbmZ1c2VkIGJ5IHRoZSBmYWN0IHRoYXQgd2UgcmV1c2UgYnMgZm9yIHRoZSBvdGhlciBw
dXJwb3NlIChpdCB3YXMgbXkgaWRlYSwgYnV0IGJhZCBvbmUpLA0KaXQgc2VlbXMgc2FmZSBoZXJl
LCBhcyB0aGUgb25seSBmb2xsb3dpbmcgdXNhZ2Ugb2YgYnMgc2VlbXMgd2FudCBlbnRpcmVseSBi
cyBjb250YWluaW5nIHRoZSBiaXRtYXAsIHNvIGl0J3MNCk9LLi4gSXQgbWF5IGJlIHdvcnRoIGFk
ZGluZyBuZWFyICJCZHJ2RGlydHlCaXRtYXAgKmJtIiBhbmQgYWRkaXRpb25hbCAiQmxvY2tEcml2
ZXJTdGF0ZSAqYm1fYnMgPSBicyIgYW5kDQpvcGVyYXRlIG9uIGl0Lg0KDQoNCkFueXdheToNCg0K
UmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmly
dHVvenpvLmNvbT4NCg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

