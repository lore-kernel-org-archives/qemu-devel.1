Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FC6C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 14:57:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16BA620B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 14:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DGOxOl0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16BA620B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40650 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbRAS-0001V0-SD
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 10:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49487)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbPiT-0007fe-R8
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:24:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbPaW-0004Pj-IG
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:16:21 -0400
Received: from mail-vi1eur04on0719.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::719]:21239
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbPaT-0004Kb-2e; Thu, 13 Jun 2019 09:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TNe991GSOsfWz7jR37+k1hd4g7c7ezk8xNiGxOSvkU=;
 b=DGOxOl0eE4gcAAPSXUH2CcPrUpamZLXi8Ib+SoZsNikg+kYB263fmo25wdh+q+LwfJ/6WF+ZWQXWATYZYcMP4OzWGv1LUy6FYlha8bq+Qg0E5F4FMS0N0FSPjaNM/wfV9pzBEN9Fir+lUcFc88Q95rcBdaT1g3Ygj2FQ0O4YPcA=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB5092.eurprd08.prod.outlook.com (10.255.30.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Thu, 13 Jun 2019 13:16:13 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 13:16:13 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 10/42] block: Use CAF in bdrv_is_encrypted()
Thread-Index: AQHVIWupBrm6ibiB4EegT5rTduW7U6aZkX+A
Date: Thu, 13 Jun 2019 13:16:13 +0000
Message-ID: <ff13463f-04a8-d519-d61d-6766960fcddd@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-11-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-11-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0901CA0065.eurprd09.prod.outlook.com
 (2603:10a6:3:45::33) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190613161611820
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2353150-12b7-490b-57d9-08d6f0014f1e
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB5092; 
x-ms-traffictypediagnostic: AM0PR08MB5092:
x-microsoft-antispam-prvs: <AM0PR08MB509231E349F22B52EBF125F6C1EF0@AM0PR08MB5092.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(396003)(346002)(39850400004)(136003)(189003)(199004)(68736007)(71200400001)(386003)(6506007)(71190400001)(186003)(256004)(5660300002)(26005)(14444005)(52116002)(76176011)(99286004)(11346002)(476003)(66446008)(64756008)(66556008)(66476007)(2616005)(446003)(66946007)(486006)(73956011)(102836004)(31686004)(14454004)(7736002)(31696002)(53936002)(8936002)(2501003)(66066001)(305945005)(86362001)(36756003)(81166006)(81156014)(478600001)(54906003)(8676002)(25786009)(229853002)(6436002)(2906002)(6246003)(6512007)(316002)(110136005)(4326008)(3846002)(6486002)(6116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5092;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sUmea5ge6l3KXIwuIMvWn9saOKh4bmmlQ75bqPhM75k2jcw+gaEB1q596pIa/VjlR/zagydBOqZw4FxypJRJr80VStknFVLTuDO+fU8VR/KoMSo7SCKvyZsm7SgxvAsiKH/QIhDQ0qhKD0e48C62plm2qk0ZbtNzqR3dN03zCw8fULF+92XdEsABU3ku2ssE9NWE6l3Gg/AXBr8JNC4V4tEc4XhOeDh5trX8sB4FdnA2Q7Z24eTXIvgReAaIx38Yw+vKOESv3K0kBdxmFNhVMR6+Skbks0qGR4+et+b4SbgcdK/oV5zH9Dj5RmXdtMs9TsipEsUNXvg5FlqcPKZF0AbseofO6FRbjUV9STtcMDFptPgZLysU09bmuLp+v/Fl7W9Jl0W8tJx5cNLS6WSTpoDmRkmJaZ6vTifjdLvlbPU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74F644FAAEC23F41ACD058FB9179EB5C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2353150-12b7-490b-57d9-08d6f0014f1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 13:16:13.6213 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5092
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0e::719
Subject: Re: [Qemu-devel] [PATCH v5 10/42] block: Use CAF in
 bdrv_is_encrypted()
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

MTMuMDYuMjAxOSAxOjA5LCBNYXggUmVpdHogd3JvdGU6DQo+IGJkcnZfaXNfZW5jcnlwdGVkKCkg
c2hvdWxkIG5vdCBvbmx5IGNoZWNrIHRoZSBCRFMncyBiYWNraW5nIGNoaWxkLCBidXQNCj4gYW55
IGZpbHRlcmVkIGNoaWxkOiBJZiBhIGZpbHRlcidzIGNoaWxkIGlzIGVuY3J5cHRlZCwgdGhlIGZp
bHRlciBub2RlDQo+IGl0c2VsZiBuYXR1cmFsbHkgaXMgZW5jcnlwdGVkLCB0b28uICBGdXJ0aGVy
bW9yZSwgd2UgbmVlZCB0byByZWN1cnNlDQo+IGRvd24gdGhlIGNoYWluLg0KPiANCj4gKENBRiBt
ZWFucyBjaGlsZCBhY2Nlc3MgZnVuY3Rpb24uKQ0KDQpIbW0sIHNvLCBpZiBvbmx5IG9uZSBub2Rl
IGluIHRoZSBiYWNraW5nIGNoYWluIGlzIGVuY3J5cHRlZCwgYWxsIG92ZXJsYXlzLA0KZmlsdGVy
cyBvciBub3QgYXJlIGNvbnNpZGVyZWQgZW5jcnlwdGVkIHRvbz8gRXZlbiBpZiBhbGwgdGhlIGRh
dGEgaXMgaW4gdG9wDQpub2RlIGFuZCBpcyBub3QgZW5jcnlwdGVkPw0KDQpDaGVja2VkIHRoYXQg
dGhlIGZ1bmN0aW9uIGlzIHVzZWQgb25seSBmb3IgcmVwb3J0aW5nIHRocm91Z2gNCmJkcnZfcXVl
cnlfaW1hZ2VfaW5mbywgd2hpY2ggaXMgY2FsbGVkIGZyb20gYmRydl9ibG9ja19kZXZpY2VfaW5m
bygpICh3aGljaA0KbG9vcHMgdGhyb3VnaCBiYWNraW5ncyksIGFuZCBmcm9tIGNvbGxlY3RfaW1h
Z2VfaW5mb19saXN0KCksIHdoaWNoIGxvb3BzIHRocm91Z2gNCmJhY2tpbmdzIGlmIEBjaGFpbj10
cnVlLg0KDQpBbmQgY29sbGVjdF9pbWFnZV9pbmZvX2xpc3QoKSBpcyB1c2VkIG9ubHkgaW4gaW1n
X2luZm8oKSwgQGNoYWluIGlzIGEgbWlycm9yZWQNCi0tYmFja2luZy1jaGFpbiBwYXJhbWV0ZXIu
Lg0KDQpTbywgaXNuJ3QgaXQgbW9yZSBjb3JyZWN0IHRvIHJldHVybiBleGFjdGx5IGJzLT5lbmNy
eXB0ZWQgaW4gdGhpcyBmdW5jdGlvbj8gSXQgd2lsbA0KZ2l2ZSBtb3JlIGNvcnJlY3QgYW5kIGlu
Zm9ybWF0aXZlIHJlc3VsdHMgZm9yIHF1ZXJpZXMgZm9yIHRoZSB3aG9sZSBjaGFpbi4NCg0KDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXggUmVpdHogPG1yZWl0ekByZWRoYXQuY29tPg0KPiAtLS0N
Cj4gICBibG9jay5jIHwgOCArKysrKystLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYmxvY2suYyBiL2Jsb2Nr
LmMNCj4gaW5kZXggNDU4ODJhMzQ3MC4uNTY3YTBmODJjOCAxMDA2NDQNCj4gLS0tIGEvYmxvY2su
Yw0KPiArKysgYi9ibG9jay5jDQo+IEBAIC00NTc0LDEwICs0NTc0LDE0IEBAIGJvb2wgYmRydl9p
c19zZyhCbG9ja0RyaXZlclN0YXRlICpicykNCj4gICANCj4gICBib29sIGJkcnZfaXNfZW5jcnlw
dGVkKEJsb2NrRHJpdmVyU3RhdGUgKmJzKQ0KPiAgIHsNCj4gLSAgICBpZiAoYnMtPmJhY2tpbmcg
JiYgYnMtPmJhY2tpbmctPmJzLT5lbmNyeXB0ZWQpIHsNCj4gKyAgICBCbG9ja0RyaXZlclN0YXRl
ICpmaWx0ZXJlZCA9IGJkcnZfZmlsdGVyZWRfYnMoYnMpOw0KPiArICAgIGlmIChicy0+ZW5jcnlw
dGVkKSB7DQo+ICAgICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gICAgICAgfQ0KPiAtICAgIHJldHVy
biBicy0+ZW5jcnlwdGVkOw0KPiArICAgIGlmIChmaWx0ZXJlZCAmJiBiZHJ2X2lzX2VuY3J5cHRl
ZChmaWx0ZXJlZCkpIHsNCj4gKyAgICAgICAgcmV0dXJuIHRydWU7DQo+ICsgICAgfQ0KPiArICAg
IHJldHVybiBmYWxzZTsNCj4gICB9DQo+ICAgDQo+ICAgY29uc3QgY2hhciAqYmRydl9nZXRfZm9y
bWF0X25hbWUoQmxvY2tEcml2ZXJTdGF0ZSAqYnMpDQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRz
LA0KVmxhZGltaXINCg==

