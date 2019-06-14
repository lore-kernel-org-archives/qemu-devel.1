Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1A3C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 15:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A831C2173C
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 15:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gYfHwe2W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A831C2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52834 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hboLg-0006Uh-DN
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 11:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56679)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hboI4-0003zf-Bl
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:38:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbo8s-0000Cc-SH
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:29:28 -0400
Received: from mail-eopbgr10095.outbound.protection.outlook.com
 ([40.107.1.95]:57568 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbo8h-0008UX-MQ; Fri, 14 Jun 2019 11:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfIrfRsH7QLLk3qSaC/UkVdAG9fuo35n0Z7DLYLMNaE=;
 b=gYfHwe2W7BAgf9M8HcQSEhgUfWmBl95oUlfjPQHdKR7Inn1/dKgT0pA/LpzUPngWZCQ6KJG36dTW6gv6iNySPQ51052iym4tYIZgoDSLUEqRuY+cDTANBDM1SWo3A+2ipS/tv2dBh1A3j4fQVAuCkOFxfwQ4LA980+NyDkuIOaY=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB3107.eurprd08.prod.outlook.com (52.134.95.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Fri, 14 Jun 2019 15:29:09 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Fri, 14 Jun 2019
 15:29:09 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 21/42] block: Use CAFs for debug breakpoints
Thread-Index: AQHVIWu5eGmtL0yGDU6pFl61nMSK4qabSPiA
Date: Fri, 14 Jun 2019 15:29:09 +0000
Message-ID: <9ab668f2-1ce2-c9ac-ab8a-325f0d3ea15e@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-22-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-22-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0326.eurprd05.prod.outlook.com
 (2603:10a6:7:92::21) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190614182907175
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00ef1c8b-b47a-44eb-628b-08d6f0dd0b6e
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB3107; 
x-ms-traffictypediagnostic: AM0PR08MB3107:
x-microsoft-antispam-prvs: <AM0PR08MB3107BD1BF1D01362F38CCF96C1EE0@AM0PR08MB3107.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(136003)(376002)(346002)(39850400004)(199004)(189003)(256004)(66066001)(6506007)(52116002)(73956011)(66476007)(386003)(66946007)(99286004)(6246003)(2501003)(66556008)(64756008)(316002)(102836004)(76176011)(478600001)(14444005)(4326008)(66446008)(5660300002)(68736007)(31686004)(71190400001)(71200400001)(26005)(25786009)(31696002)(446003)(486006)(8676002)(11346002)(2616005)(476003)(229853002)(7736002)(3846002)(6486002)(81166006)(81156014)(6116002)(86362001)(53936002)(36756003)(305945005)(54906003)(6436002)(8936002)(14454004)(110136005)(6512007)(2906002)(186003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3107;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ysf9eRNC9xfakIMm9a0hD1b2yDgjLchIFUIbb+g1VG0r8rjOE/tOVL1/0PAyZh8GvslEWm3j3cHDG3jw5XP8PIAToXgpdqg2oMSJ/nhTvN4y9KSexFxCXwGJGlUa4tY4ScbmPvbcNpVWLkO5zFIOiugRlevYNhcsyoJUY8iqTl3wuWW8rUerz2aho/OFvc6VrRa/qmuoMQHLOQH0hcARB5HoI6ahrc/wZbmNibWRlXT/IDN7qNlHIxk/4JWxrsgc1HW5BoOSTp8Mfw9THdedc5gsff7rL9Z2mXx0X/9xPs6ZYfzAl8B769VyDc8Hz9X6ZvGiPgZqaYLCtaB1rR7kInku8ljl4VNpNGsIpiVQJIYfTx7+G4ttRcoqkyhkQuAC7iRZ55rAjYzuEwWUQ0arsp0S+ViT9pr468sPhOm5p6s=
Content-Type: text/plain; charset="utf-8"
Content-ID: <460483267277914A8BE7FD3F811DCC8E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ef1c8b-b47a-44eb-628b-08d6f0dd0b6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 15:29:09.2494 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3107
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.95
Subject: Re: [Qemu-devel] [PATCH v5 21/42] block: Use CAFs for debug
 breakpoints
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

MTMuMDYuMjAxOSAxOjA5LCBNYXggUmVpdHogd3JvdGU6DQo+IFdoZW4gbG9va2luZyBmb3IgYSBi
bGtkZWJ1ZyBub2RlICh3aGljaCBpbXBsZW1lbnRzIGRlYnVnIGJyZWFrcG9pbnRzKSwNCj4gdXNl
IGJkcnZfcHJpbWFyeV9icygpIHRvIGl0ZXJhdGUgdGhyb3VnaCB0aGUgZ3JhcGgsIGJlY2F1c2Ug
dGhhdCBpcw0KPiB3aGVyZSBhIGJsa2RlYnVnIG5vZGUgd291bGQgYmUuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBNYXggUmVpdHogPG1yZWl0ekByZWRoYXQuY29tPg0KDQpIb25lc3RseSwgZG9uJ3Qg
a25vdyB3aHkgYmxrZGVidWcgaXMgYWx3YXlzIHNlYXJjaGVkIGluIC0+ZmlsZSBzZXF1ZW5jZSwg
YnV0IHRoaXMNCnBhdGNoIG9idmlvdXNseSBzdXBwb3J0cyBiYWNraW5nLWJhc2VkIGZpbHRlcnMg
Zm9yIGJsa2RlYnVnIHNjZW5hcmlvcywgd2hpY2ggSSBuZWVkDQpmb3IgbXkgYmFja3VwLXRvcCBz
ZXJpZXMgKGFuZCBoYXZlIGNvcnJlc3BvbmRpbmcgcGF0Y2ggaW4gaXQsIHdoaWNoIGlzIG5vdCBu
ZWVkZWQNCmlmIHRoaXMgZ29lcyBmaXJzdCkNCg0KDQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2Vt
ZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQoNCj4gLS0tDQo+
ICAgYmxvY2suYyB8IDggKysrKy0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Jsb2NrLmMgYi9ibG9jay5j
DQo+IGluZGV4IDc5N2JlYzAzMjYuLjExYjdiYThjZjYgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrLmMN
Cj4gKysrIGIvYmxvY2suYw0KPiBAQCAtNTA5Nyw3ICs1MDk3LDcgQEAgaW50IGJkcnZfZGVidWdf
YnJlYWtwb2ludChCbG9ja0RyaXZlclN0YXRlICpicywgY29uc3QgY2hhciAqZXZlbnQsDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICp0YWcpDQo+ICAgew0KPiAgICAg
ICB3aGlsZSAoYnMgJiYgYnMtPmRydiAmJiAhYnMtPmRydi0+YmRydl9kZWJ1Z19icmVha3BvaW50
KSB7DQo+IC0gICAgICAgIGJzID0gYnMtPmZpbGUgPyBicy0+ZmlsZS0+YnMgOiBOVUxMOw0KPiAr
ICAgICAgICBicyA9IGJkcnZfcHJpbWFyeV9icyhicyk7DQo+ICAgICAgIH0NCj4gICANCj4gICAg
ICAgaWYgKGJzICYmIGJzLT5kcnYgJiYgYnMtPmRydi0+YmRydl9kZWJ1Z19icmVha3BvaW50KSB7
DQo+IEBAIC01MTEwLDcgKzUxMTAsNyBAQCBpbnQgYmRydl9kZWJ1Z19icmVha3BvaW50KEJsb2Nr
RHJpdmVyU3RhdGUgKmJzLCBjb25zdCBjaGFyICpldmVudCwNCj4gICBpbnQgYmRydl9kZWJ1Z19y
ZW1vdmVfYnJlYWtwb2ludChCbG9ja0RyaXZlclN0YXRlICpicywgY29uc3QgY2hhciAqdGFnKQ0K
PiAgIHsNCj4gICAgICAgd2hpbGUgKGJzICYmIGJzLT5kcnYgJiYgIWJzLT5kcnYtPmJkcnZfZGVi
dWdfcmVtb3ZlX2JyZWFrcG9pbnQpIHsNCj4gLSAgICAgICAgYnMgPSBicy0+ZmlsZSA/IGJzLT5m
aWxlLT5icyA6IE5VTEw7DQo+ICsgICAgICAgIGJzID0gYmRydl9wcmltYXJ5X2JzKGJzKTsNCj4g
ICAgICAgfQ0KPiAgIA0KPiAgICAgICBpZiAoYnMgJiYgYnMtPmRydiAmJiBicy0+ZHJ2LT5iZHJ2
X2RlYnVnX3JlbW92ZV9icmVha3BvaW50KSB7DQo+IEBAIC01MTIzLDcgKzUxMjMsNyBAQCBpbnQg
YmRydl9kZWJ1Z19yZW1vdmVfYnJlYWtwb2ludChCbG9ja0RyaXZlclN0YXRlICpicywgY29uc3Qg
Y2hhciAqdGFnKQ0KPiAgIGludCBiZHJ2X2RlYnVnX3Jlc3VtZShCbG9ja0RyaXZlclN0YXRlICpi
cywgY29uc3QgY2hhciAqdGFnKQ0KPiAgIHsNCj4gICAgICAgd2hpbGUgKGJzICYmICghYnMtPmRy
diB8fCAhYnMtPmRydi0+YmRydl9kZWJ1Z19yZXN1bWUpKSB7DQo+IC0gICAgICAgIGJzID0gYnMt
PmZpbGUgPyBicy0+ZmlsZS0+YnMgOiBOVUxMOw0KPiArICAgICAgICBicyA9IGJkcnZfcHJpbWFy
eV9icyhicyk7DQo+ICAgICAgIH0NCj4gICANCj4gICAgICAgaWYgKGJzICYmIGJzLT5kcnYgJiYg
YnMtPmRydi0+YmRydl9kZWJ1Z19yZXN1bWUpIHsNCj4gQEAgLTUxMzYsNyArNTEzNiw3IEBAIGlu
dCBiZHJ2X2RlYnVnX3Jlc3VtZShCbG9ja0RyaXZlclN0YXRlICpicywgY29uc3QgY2hhciAqdGFn
KQ0KPiAgIGJvb2wgYmRydl9kZWJ1Z19pc19zdXNwZW5kZWQoQmxvY2tEcml2ZXJTdGF0ZSAqYnMs
IGNvbnN0IGNoYXIgKnRhZykNCj4gICB7DQo+ICAgICAgIHdoaWxlIChicyAmJiBicy0+ZHJ2ICYm
ICFicy0+ZHJ2LT5iZHJ2X2RlYnVnX2lzX3N1c3BlbmRlZCkgew0KPiAtICAgICAgICBicyA9IGJz
LT5maWxlID8gYnMtPmZpbGUtPmJzIDogTlVMTDsNCj4gKyAgICAgICAgYnMgPSBiZHJ2X3ByaW1h
cnlfYnMoYnMpOw0KPiAgICAgICB9DQo+ICAgDQo+ICAgICAgIGlmIChicyAmJiBicy0+ZHJ2ICYm
IGJzLT5kcnYtPmJkcnZfZGVidWdfaXNfc3VzcGVuZGVkKSB7DQo+IA0KDQoNCi0tIA0KQmVzdCBy
ZWdhcmRzLA0KVmxhZGltaXINCg==

