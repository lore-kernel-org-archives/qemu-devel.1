Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB22C48BE3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 09:52:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D219620665
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 09:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DYpc+ms7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D219620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57606 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heGDU-0003lX-Jm
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 05:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51654)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1heGAd-0002YJ-SJ
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 05:49:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1heGAa-0000Vd-7W
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 05:49:23 -0400
Received: from mail-eopbgr50138.outbound.protection.outlook.com
 ([40.107.5.138]:6528 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1heGAH-0000EZ-0U; Fri, 21 Jun 2019 05:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lorfm/rpohjJN197l8F0zoxI5SefIAcT1fscDLSR00w=;
 b=DYpc+ms7CSKupe9IzdyOw+8vjvK27BZm5FMPW4FARfEXDNir0tUu7wrxpCXPzawL4NlIQHzs7Vy+AYuK3ggT7Rhv4kPULgWCVFyB27rpY3cW6mm7oZ+5STeCEx62AIdKxpRQqDVDYsqg+1y7Br4O1njbQwT4fXHdg0vtfWz0J0M=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB4662.eurprd08.prod.outlook.com (10.255.78.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Fri, 21 Jun 2019 09:48:56 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 09:48:56 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: zhenwei pi <pizhenwei@bytedance.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>
Thread-Topic: [PATCH 2/3] block/accounting: introduce block size histogram
Thread-Index: AQHVJ0XQHntZYTKrRUeOUX9cmHKMRKal3oaA
Date: Fri, 21 Jun 2019 09:48:56 +0000
Message-ID: <662ef0da-6009-2a44-4c52-523ed1240a45@virtuozzo.com>
References: <1561020872-6214-1-git-send-email-pizhenwei@bytedance.com>
 <1561020872-6214-3-git-send-email-pizhenwei@bytedance.com>
In-Reply-To: <1561020872-6214-3-git-send-email-pizhenwei@bytedance.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0057.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::46) To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190621124853205
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86f499e3-eb89-4d0c-567e-08d6f62dad41
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4662; 
x-ms-traffictypediagnostic: DBBPR08MB4662:
x-microsoft-antispam-prvs: <DBBPR08MB4662ADF2AC098F1B71710E9FC1E70@DBBPR08MB4662.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39840400004)(376002)(346002)(366004)(396003)(189003)(199004)(7736002)(3846002)(6116002)(31686004)(478600001)(2501003)(186003)(110136005)(52116002)(316002)(386003)(36756003)(14454004)(71190400001)(71200400001)(76176011)(68736007)(99286004)(54906003)(8936002)(73956011)(81166006)(476003)(2616005)(305945005)(6436002)(8676002)(81156014)(486006)(6486002)(4326008)(6506007)(6246003)(66476007)(53936002)(229853002)(25786009)(14444005)(2201001)(26005)(66066001)(102836004)(66946007)(64756008)(66556008)(66446008)(256004)(86362001)(2906002)(11346002)(31696002)(446003)(15650500001)(6512007)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4662;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U3ZOFKAv5JxXQv8SwbjJnJ+FDYaVxPbXgL7mFV1LnRfKLnQ8ECe1BMEqbQwBoVXGE0vErc+wnlZC/MlfYKdLQnFgq+z9OKup0ocmYioy2B1dLGy8R3zYQEnkuwuAPp77nCtnCK6jCUmLI5HOuEJhvZre/j5dmryLcaEpQWao8gnee6allYdBRkUyDDCli/avn6j1zBd0bNppSLgMf77g6Iecfig/PhoVkSqRkwu7S7cFl3tXZhM2RTCInfv5t8SwfvjUusBNBKpuTfcZSgmSaPEV2qZ+FnfEeDxFy9oDmfgOqOfy1dOqgVSrvHICFQYgCOvvcoxwkVDp6tneyhtJ22spVsWkzd+grXX2cwNEG8w1+wtvv0A9/UXRmlkoXjXRbBENpLrCx64EB3zJswWsjTupqw015GLpqQwUQjPD9ZI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB4FE01DC22DB74FB97A29487FBCDD2B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f499e3-eb89-4d0c-567e-08d6f62dad41
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 09:48:56.5272 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4662
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.138
Subject: Re: [Qemu-devel] [PATCH 2/3] block/accounting: introduce block size
 histogram
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
Cc: "fam@euphon.net" <fam@euphon.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjAuMDYuMjAxOSAxMTo1NCwgemhlbndlaSBwaSB3cm90ZToNCj4gSW50cm9kdWNlIGJsb2NrIHNp
emUgaGlzdG9ncmFtIHN0YXRpY3MgZm9yIGJsb2NrIGRldmljZXMuDQo+IA0KPiBGb3IgcmVhZC93
cml0ZS9mbHVzaCBvcGVyYXRpb24gdHlwZSwgdGhlIGJsb2NrIHNpemUgcmVnaW9uDQo+IFswLCAr
aW5mKSBpcyBkaXZpZGVkIGludG8gc3VicmVnaW9ucyBieSBzZXZlcmFsIHBvaW50cy4NCj4gSXQg
d29ya3MgbGlrZSBibG9jayBsYXRlbmN5IGhpc3RvZ3JhbS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IHpoZW53ZWkgcGkgPHBpemhlbndlaUBieXRlZGFuY2UuY29tPg0KPiAtLS0NCj4gICBibG9jay9h
Y2NvdW50aW5nLmMgICAgICAgICB8IDI0ICsrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIGlu
Y2x1ZGUvYmxvY2svYWNjb3VudGluZy5oIHwgIDQgKysrKw0KPiAgIDIgZmlsZXMgY2hhbmdlZCwg
MjggaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2FjY291bnRpbmcuYyBi
L2Jsb2NrL2FjY291bnRpbmcuYw0KPiBpbmRleCBiYjgxNDhiNmIxLi45NGQ1YWEyOTJlIDEwMDY0
NA0KPiAtLS0gYS9ibG9jay9hY2NvdW50aW5nLmMNCj4gKysrIGIvYmxvY2svYWNjb3VudGluZy5j
DQo+IEBAIC0xODcsNiArMTg3LDI3IEBAIHZvaWQgYmxvY2tfbGF0ZW5jeV9oaXN0b2dyYW1zX2Ns
ZWFyKEJsb2NrQWNjdFN0YXRzICpzdGF0cykNCj4gICAgICAgfQ0KPiAgIH0NCj4gICANCj4gK2lu
dCBibG9ja19zaXplX2hpc3RvZ3JhbV9zZXQoQmxvY2tBY2N0U3RhdHMgKnN0YXRzLCBlbnVtIEJs
b2NrQWNjdFR5cGUgdHlwZSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWlu
dDY0TGlzdCAqYm91bmRhcmllcykNCj4gK3sNCj4gKyAgICBCbG9ja0hpc3RvZ3JhbSAqaGlzdCA9
ICZzdGF0cy0+c2l6ZV9oaXN0b2dyYW1bdHlwZV07DQo+ICsNCj4gKyAgICByZXR1cm4gYmxvY2tf
aGlzdG9ncmFtX3NldChoaXN0LCBib3VuZGFyaWVzKTsNCj4gK30NCj4gKw0KPiArdm9pZCBibG9j
a19zaXplX2hpc3RvZ3JhbXNfY2xlYXIoQmxvY2tBY2N0U3RhdHMgKnN0YXRzKQ0KPiArew0KPiAr
ICAgIGludCBpOw0KPiArDQo+ICsgICAgZm9yIChpID0gMDsgaSA8IEJMT0NLX01BWF9JT1RZUEU7
IGkrKykgew0KPiArICAgICAgICBCbG9ja0hpc3RvZ3JhbSAqaGlzdCA9ICZzdGF0cy0+c2l6ZV9o
aXN0b2dyYW1baV07DQo+ICsgICAgICAgIGdfZnJlZShoaXN0LT5iaW5zKTsNCj4gKyAgICAgICAg
Z19mcmVlKGhpc3QtPmJvdW5kYXJpZXMpOw0KPiArICAgICAgICBtZW1zZXQoaGlzdCwgMCwgc2l6
ZW9mKCpoaXN0KSk7DQoNCkFuZCB0aGlzIGlzIHRoZSBkdXBsaWNhdGlvbiBJJ3ZlIHRvbGQgYWJv
dXQgaW4gMDENCg0KPiArICAgIH0NCj4gK30NCj4gKw0KPiArDQo+ICAgc3RhdGljIHZvaWQgYmxv
Y2tfYWNjb3VudF9vbmVfaW8oQmxvY2tBY2N0U3RhdHMgKnN0YXRzLCBCbG9ja0FjY3RDb29raWUg
KmNvb2tpZSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIGZhaWxl
ZCkNCj4gICB7DQo+IEBAIC0yMTEsNiArMjMyLDkgQEAgc3RhdGljIHZvaWQgYmxvY2tfYWNjb3Vu
dF9vbmVfaW8oQmxvY2tBY2N0U3RhdHMgKnN0YXRzLCBCbG9ja0FjY3RDb29raWUgKmNvb2tpZSwN
Cj4gICANCj4gICAgICAgYmxvY2tfaGlzdG9ncmFtX2FjY291bnQoJnN0YXRzLT5sYXRlbmN5X2hp
c3RvZ3JhbVtjb29raWUtPnR5cGVdLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGxhdGVuY3lfbnMpOw0KPiArICAgIGJsb2NrX2hpc3RvZ3JhbV9hY2NvdW50KCZzdGF0
cy0+c2l6ZV9oaXN0b2dyYW1bY29va2llLT50eXBlXSwNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGNvb2tpZS0+Ynl0ZXMpOw0KPiArDQo+ICAgDQo+ICAgICAgIGlmICgh
ZmFpbGVkIHx8IHN0YXRzLT5hY2NvdW50X2ZhaWxlZCkgew0KPiAgICAgICAgICAgc3RhdHMtPnRv
dGFsX3RpbWVfbnNbY29va2llLT50eXBlXSArPSBsYXRlbmN5X25zOw0KPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9ibG9jay9hY2NvdW50aW5nLmggYi9pbmNsdWRlL2Jsb2NrL2FjY291bnRpbmcuaA0K
PiBpbmRleCAyNzBmZGRiNjljLi40OWQzYTc4ZjQ4IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2Js
b2NrL2FjY291bnRpbmcuaA0KPiArKysgYi9pbmNsdWRlL2Jsb2NrL2FjY291bnRpbmcuaA0KPiBA
QCAtODksNiArODksNyBAQCBzdHJ1Y3QgQmxvY2tBY2N0U3RhdHMgew0KPiAgICAgICBib29sIGFj
Y291bnRfaW52YWxpZDsNCj4gICAgICAgYm9vbCBhY2NvdW50X2ZhaWxlZDsNCj4gICAgICAgQmxv
Y2tIaXN0b2dyYW0gbGF0ZW5jeV9oaXN0b2dyYW1bQkxPQ0tfTUFYX0lPVFlQRV07DQo+ICsgICAg
QmxvY2tIaXN0b2dyYW0gc2l6ZV9oaXN0b2dyYW1bQkxPQ0tfTUFYX0lPVFlQRV07DQo+ICAgfTsN
Cj4gICANCj4gICB0eXBlZGVmIHN0cnVjdCBCbG9ja0FjY3RDb29raWUgew0KPiBAQCAtMTE3LDUg
KzExOCw4IEBAIGRvdWJsZSBibG9ja19hY2N0X3F1ZXVlX2RlcHRoKEJsb2NrQWNjdFRpbWVkU3Rh
dHMgKnN0YXRzLA0KPiAgIGludCBibG9ja19sYXRlbmN5X2hpc3RvZ3JhbV9zZXQoQmxvY2tBY2N0
U3RhdHMgKnN0YXRzLCBlbnVtIEJsb2NrQWNjdFR5cGUgdHlwZSwNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHVpbnQ2NExpc3QgKmJvdW5kYXJpZXMpOw0KPiAgIHZvaWQgYmxv
Y2tfbGF0ZW5jeV9oaXN0b2dyYW1zX2NsZWFyKEJsb2NrQWNjdFN0YXRzICpzdGF0cyk7DQo+ICtp
bnQgYmxvY2tfc2l6ZV9oaXN0b2dyYW1fc2V0KEJsb2NrQWNjdFN0YXRzICpzdGF0cywgZW51bSBC
bG9ja0FjY3RUeXBlIHR5cGUsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVp
bnQ2NExpc3QgKmJvdW5kYXJpZXMpOw0KDQpIbW0sIHVuY29tbW9uIGluZGVudGF0aW9uIHlvdSB1
c2UuIEluIFFlbXUgdGhlIHNlY29uZCBsaW5lIG9mIHBhcmFtZXRlcnMgc2hvdWxkIHN0YXJ0DQph
dCB0aGUgcG9zaXRpb24gb2YgZmlyc3Qgc3ltYm9sIGFmdGVyICcoJywgbGlrZSB0aGlzOg0KDQpp
bnQgYmxvY2tfc2l6ZV9oaXN0b2dyYW1fc2V0KEJsb2NrQWNjdFN0YXRzICpzdGF0cywgZW51bSBC
bG9ja0FjY3RUeXBlIHR5cGUsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRM
aXN0ICpib3VuZGFyaWVzKTsNCg0KPiArdm9pZCBibG9ja19zaXplX2hpc3RvZ3JhbXNfY2xlYXIo
QmxvY2tBY2N0U3RhdHMgKnN0YXRzKTsNCj4gICANCj4gICAjZW5kaWYNCj4gDQoNCg0KLS0gDQpC
ZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

