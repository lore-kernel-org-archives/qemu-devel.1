Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1446EC31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 10:11:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6C23206E0
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 10:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="f6Ju0DJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C23206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36510 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdXYb-0006m4-2a
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 06:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50913)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hdXWj-0005b7-Hb
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 06:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hdXWh-00049s-4q
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 06:09:13 -0400
Received: from mail-eopbgr130119.outbound.protection.outlook.com
 ([40.107.13.119]:12454 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hdXWb-00042Q-T5; Wed, 19 Jun 2019 06:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJmUHk5VZCCS1RiISXId21IEFHRex8v3nVlQQ6/LF+I=;
 b=f6Ju0DJr3VKKYWrP2zA9OWMhCRNWBHwo6DKWXu5bK7fZGcQC5iZ78n5IHV/nPU7KaUshvcObIl3wCkNZW0omKmPgDZx/QIt0pSOhbzzKXTc2156OSpapqAtJk+xIi/cMZEn646M+JcDZiplyo91yCRNuEWXnKQ++o1Vxwqsbd/A=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB4556.eurprd08.prod.outlook.com (20.179.44.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Wed, 19 Jun 2019 10:09:02 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Wed, 19 Jun 2019
 10:09:02 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH v6] qemu-io: add pattern file for write
 command
Thread-Index: AQHVH5BI2RKXq9hEOEShEqXiMWkDCaaizuWA
Date: Wed, 19 Jun 2019 10:09:02 +0000
Message-ID: <9c2edd2b-766c-26e8-436a-d2763e2537c8@virtuozzo.com>
References: <20190610132124.3568-1-dplotnikov@virtuozzo.com>
In-Reply-To: <20190610132124.3568-1-dplotnikov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0041.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::30)
 To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190619130859367
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6225e90-3922-4424-b0d8-08d6f49e2753
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4556; 
x-ms-traffictypediagnostic: DBBPR08MB4556:
x-microsoft-antispam-prvs: <DBBPR08MB4556458ED32F264E7E475AE2C1E50@DBBPR08MB4556.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0073BFEF03
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(376002)(396003)(39850400004)(346002)(136003)(199004)(189003)(8936002)(52116002)(6436002)(446003)(66066001)(478600001)(476003)(6512007)(2906002)(71200400001)(53936002)(86362001)(76176011)(6116002)(99286004)(6486002)(2201001)(305945005)(7736002)(31696002)(71190400001)(68736007)(66446008)(2501003)(66476007)(229853002)(486006)(81166006)(2616005)(81156014)(5660300002)(256004)(66946007)(6246003)(64756008)(316002)(3846002)(14454004)(102836004)(6506007)(386003)(36756003)(66556008)(186003)(25786009)(54906003)(8676002)(26005)(11346002)(31686004)(110136005)(73956011)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4556;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 83SNNXEcrXMfCcHJ+WGjMREXwnkbrwCzLF1IXLOCoJW9MkwBlhD676AovKEopsPQmmguXHW6rPGYQFDf9GapnxCHOPQ/UQENgVGawY1jn1ceYSfzIyfBDQZGYSzL3Oucqbe5Tan1equmOaBL+ufsKslhExff37Ars1N/Y/SCsjUcJYBkSFQ3hZcqqnAZO5M5o+H2B4CJYKWtdvMz4exqPcxdpm3OEKKETkS9XCEuTR+E10MH6fFLmnmoby15RKk2yLXNBaAivOOFKUk+ZYtZW3OCp6i0WtPM6Umiqs9Xye/i0Tc1kLRiWCwQgd/R71dZlwkE6/diWsyY2DoltWMT0cCiIfj+pqTUNRscvtD86K/ZQZyGNdeaifuz2ovUJHHcIHs7xGlQCx6fgU/gbitvDe6wL37e79mYtkXufFb0Eww=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F58C7BCFEE3F6C459E2ED0E08EA698C1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6225e90-3922-4424-b0d8-08d6f49e2753
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2019 10:09:02.5087 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4556
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.119
Subject: Re: [Qemu-devel] [PATCH v6] qemu-io: add pattern file for write
 command
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTAuMDYuMjAxOSAxNjoyMSwgRGVuaXMgUGxvdG5pa292IHdyb3RlOg0KPiBUaGUgcGF0Y2ggYWxs
b3dzIHRvIHByb3ZpZGUgYSBwYXR0ZXJuIGZpbGUgZm9yIHdyaXRlDQo+IGNvbW1hbmQuIFRoZXJl
IHdhcyBubyBzaW1pbGFyIGFiaWxpdHkgYmVmb3JlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGVu
aXMgUGxvdG5pa292IDxkcGxvdG5pa292QHZpcnR1b3p6by5jb20+DQo+IC0tLQ0KPiB2NjoNCj4g
ICAgKiB0aGUgcGF0dGVybiBmaWxlIGlzIHJlYWQgb25jZSB0byByZWR1Y2UgaW8NCj4gDQo+IHY1
Og0KPiAgICAqIGZpbGUgbmFtZSBpbml0aWF0ZWQgd2l0aCBudWxsIHRvIG1ha2UgY29tcGlsZXJz
IGhhcHB5DQo+IA0KPiB2NDoNCj4gICAgKiBtaXNzaW5nIHNpZ25lZC1vZmYgY2xhdXNlIGFkZGVk
DQo+IA0KPiB2MzoNCj4gICAgKiBtaXNzaW5nIGZpbGUgY2xvc2luZyBhZGRlZA0KPiAgICAqIGV4
Y2x1c2l2ZSBmbGFncyBwcm9jZXNzaW5nIGNoYW5nZWQNCj4gICAgKiBidWZmZXIgdm9pZCogY29u
dmVydGVkIHRvIGNoYXIqIHRvIGZpeCBwb2ludGVyIGFyaXRobWV0aWNzDQo+ICAgICogZmlsZSBy
ZWFkaW5nIGVycm9yIHByb2Nlc3NpbmcgYWRkZWQNCj4gLS0tDQo+ICAgcWVtdS1pby1jbWRzLmMg
fCA4OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQ0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCA4MiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL3FlbXUtaW8tY21kcy5jIGIvcWVtdS1pby1jbWRzLmMNCj4gaW5kZXgg
MDk3NTBhMjNjZS4uZTI3MjAzZjc0NyAxMDA2NDQNCj4gLS0tIGEvcWVtdS1pby1jbWRzLmMNCj4g
KysrIGIvcWVtdS1pby1jbWRzLmMNCj4gQEAgLTM0Myw2ICszNDMsNjkgQEAgc3RhdGljIHZvaWQg
KnFlbXVfaW9fYWxsb2MoQmxvY2tCYWNrZW5kICpibGssIHNpemVfdCBsZW4sIGludCBwYXR0ZXJu
KQ0KPiAgICAgICByZXR1cm4gYnVmOw0KPiAgIH0NCj4gICANCj4gK3N0YXRpYyB2b2lkICpxZW11
X2lvX2FsbG9jX2Zyb21fZmlsZShCbG9ja0JhY2tlbmQgKmJsaywgc2l6ZV90IGxlbiwNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjaGFyICpmaWxlX25hbWUpDQo+ICt7
DQo+ICsgICAgY2hhciAqYnVmLCAqYnVmX29yaWdpbjsNCj4gKyAgICBGSUxFICpmID0gZm9wZW4o
ZmlsZV9uYW1lLCAiciIpOw0KPiArICAgIGludCBsOw0KDQpzaG91bGQgYmUgc2l6ZV90LCBhbmQg
Y291bGQgeW91IGdldCBpdCBkZXNjcmlwdGl2ZSBuYW1lIHBhdHRlcm5fbGVuIG9yIGxpa2UgdGhp
cz8NCg0KPiArDQo+ICsgICAgaWYgKCFmKSB7DQo+ICsgICAgICAgIHByaW50ZigiJyVzJzogJXNc
biIsIGZpbGVfbmFtZSwgc3RyZXJyb3IoZXJybm8pKTsNCj4gKyAgICAgICAgcmV0dXJuIE5VTEw7
DQo+ICsgICAgfQ0KPiArDQo+ICsgICAgaWYgKHFlbXVpb19taXNhbGlnbikgew0KPiArICAgICAg
ICBsZW4gKz0gTUlTQUxJR05fT0ZGU0VUOw0KPiArICAgIH0NCj4gKyAgICBidWZfb3JpZ2luID0g
YmxrX2Jsb2NrYWxpZ24oYmxrLCBsZW4pOw0KPiArICAgIG1lbXNldChidWZfb3JpZ2luLCAwLCBs
ZW4pOw0KPiArDQo+ICsgICAgYnVmID0gYnVmX29yaWdpbjsNCj4gKw0KPiArICAgIGwgPSBmcmVh
ZChidWYsIHNpemVvZihjaGFyKSwgbGVuLCBmKTsNCj4gKw0KPiArICAgIGlmIChmZXJyb3IoZikp
IHsNCj4gKyAgICAgICAgcHJpbnRmKCInJXMnOiAlc1xuIiwgZmlsZV9uYW1lLCBzdHJlcnJvcihl
cnJubykpOw0KPiArICAgICAgICBnb3RvIGVycm9yOw0KPiArICAgIH0NCj4gKw0KPiArICAgIGlm
IChsID09IDApIHsNCj4gKyAgICAgICAgcHJpbnRmKCInJXMnIGlzIGVtcHR5XG4iLCBmaWxlX25h
bWUpOw0KPiArICAgICAgICBnb3RvIGVycm9yOw0KPiArICAgIH0NCj4gKw0KPiArICAgIGlmIChs
IDwgbGVuKSB7DQo+ICsgICAgICAgIGNoYXIgKmZpbGVfYnVmID0gZ19tYWxsb2Moc2l6ZW9mKGNo
YXIpICogbCk7DQo+ICsgICAgICAgIG1lbWNweShmaWxlX2J1ZiwgYnVmLCBsKTsNCg0KSSBzZWUg
bm8gcmVhc29uIHRvIGNvcHkgaXQsIHlvdSBjYW4ganVzdCB1c2UgYnVmX29yaWdpbiBwb2ludGVy
DQppbnN0ZWFkLg0KDQo+ICsgICAgICAgIGxlbiAtPSBsOw0KPiArICAgICAgICBidWYgKz0gbDsN
Cj4gKw0KPiArICAgICAgICB3aGlsZSAobGVuID4gMCkgew0KPiArICAgICAgICAgICAgc2l6ZV90
IGxlbl90b19jb3B5ID0gbGVuID4gbCA/IGwgOiBsZW47DQoNCnlvdSBtYXkgdXNlIE1JTihsZW4s
IGwpDQoNCj4gKw0KPiArICAgICAgICAgICAgbWVtY3B5KGJ1ZiwgZmlsZV9idWYsIGxlbl90b19j
b3B5KTsNCj4gKw0KPiArICAgICAgICAgICAgbGVuIC09IGxlbl90b19jb3B5Ow0KPiArICAgICAg
ICAgICAgYnVmICs9IGxlbl90b19jb3B5Ow0KPiArICAgICAgICB9DQo+ICsgICAgICAgIHFlbXVf
dmZyZWUoZmlsZV9idWYpOw0KPiArICAgIH0NCj4gKw0KPiArICAgIGlmIChxZW11aW9fbWlzYWxp
Z24pIHsNCj4gKyAgICAgICAgYnVmX29yaWdpbiArPSBNSVNBTElHTl9PRkZTRVQ7DQo+ICsgICAg
fQ0KPiArDQo+ICsgICAgZ290byBvdXQ7DQo+ICsNCj4gK2Vycm9yOg0KPiArICAgIHFlbXVfdmZy
ZWUoYnVmKTsNCj4gKyAgICBidWZfb3JpZ2luID0gTlVMTDsNCj4gK291dDoNCj4gKyAgICBmY2xv
c2UoZik7DQo+ICsgICAgcmV0dXJuIGJ1Zl9vcmlnaW47DQo+ICt9DQo+ICsNCj4gICBzdGF0aWMg
dm9pZCBxZW11X2lvX2ZyZWUodm9pZCAqcCkNCj4gICB7DQo+ICAgICAgIGlmIChxZW11aW9fbWlz
YWxpZ24pIHsNCj4gQEAgLTk2NSw3ICsxMDI4LDcgQEAgc3RhdGljIGNvbnN0IGNtZGluZm9fdCB3
cml0ZV9jbWQgPSB7DQo+ICAgICAgIC5wZXJtICAgICAgID0gQkxLX1BFUk1fV1JJVEUsDQo+ICAg
ICAgIC5hcmdtaW4gICAgID0gMiwNCj4gICAgICAgLmFyZ21heCAgICAgPSAtMSwNCj4gLSAgICAu
YXJncyAgICAgICA9ICJbLWJjQ2ZucXV6XSBbLVAgcGF0dGVybl0gb2ZmIGxlbiIsDQo+ICsgICAg
LmFyZ3MgICAgICAgPSAiWy1iY0NmbnF1el0gWy1QIHBhdHRlcm4gfCAtcyBzb3VyY2VfZmlsZV0g
b2ZmIGxlbiIsDQo+ICAgICAgIC5vbmVsaW5lICAgID0gIndyaXRlcyBhIG51bWJlciBvZiBieXRl
cyBhdCBhIHNwZWNpZmllZCBvZmZzZXQiLA0KPiAgICAgICAuaGVscCAgICAgICA9IHdyaXRlX2hl
bHAsDQo+ICAgfTsNCj4gQEAgLTk3NCw3ICsxMDM3LDcgQEAgc3RhdGljIGludCB3cml0ZV9mKEJs
b2NrQmFja2VuZCAqYmxrLCBpbnQgYXJnYywgY2hhciAqKmFyZ3YpDQo+ICAgew0KPiAgICAgICBz
dHJ1Y3QgdGltZXZhbCB0MSwgdDI7DQo+ICAgICAgIGJvb2wgQ2ZsYWcgPSBmYWxzZSwgcWZsYWcg
PSBmYWxzZSwgYmZsYWcgPSBmYWxzZTsNCj4gLSAgICBib29sIFBmbGFnID0gZmFsc2UsIHpmbGFn
ID0gZmFsc2UsIGNmbGFnID0gZmFsc2U7DQo+ICsgICAgYm9vbCBQZmxhZyA9IGZhbHNlLCB6Zmxh
ZyA9IGZhbHNlLCBjZmxhZyA9IGZhbHNlLCBzZmxhZyA9IGZhbHNlOw0KPiAgICAgICBpbnQgZmxh
Z3MgPSAwOw0KPiAgICAgICBpbnQgYywgY250LCByZXQ7DQo+ICAgICAgIGNoYXIgKmJ1ZiA9IE5V
TEw7DQo+IEBAIC05ODMsOCArMTA0Niw5IEBAIHN0YXRpYyBpbnQgd3JpdGVfZihCbG9ja0JhY2tl
bmQgKmJsaywgaW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0KPiAgICAgICAvKiBTb21lIGNvbXBpbGVy
cyBnZXQgY29uZnVzZWQgYW5kIHdhcm4gaWYgdGhpcyBpcyBub3QgaW5pdGlhbGl6ZWQuICAqLw0K
PiAgICAgICBpbnQ2NF90IHRvdGFsID0gMDsNCj4gICAgICAgaW50IHBhdHRlcm4gPSAweGNkOw0K
PiArICAgIGNoYXIgKmZpbGVfbmFtZSA9IE5VTEw7DQo+ICAgDQo+IC0gICAgd2hpbGUgKChjID0g
Z2V0b3B0KGFyZ2MsIGFyZ3YsICJiY0NmbnBQOnF1eiIpKSAhPSAtMSkgew0KPiArICAgIHdoaWxl
ICgoYyA9IGdldG9wdChhcmdjLCBhcmd2LCAiYmNDZm5wUDpxdXpzOiIpKSAhPSAtMSkgew0KPiAg
ICAgICAgICAgc3dpdGNoIChjKSB7DQo+ICAgICAgICAgICBjYXNlICdiJzoNCj4gICAgICAgICAg
ICAgICBiZmxhZyA9IHRydWU7DQo+IEBAIC0xMDIwLDYgKzEwODQsMTAgQEAgc3RhdGljIGludCB3
cml0ZV9mKEJsb2NrQmFja2VuZCAqYmxrLCBpbnQgYXJnYywgY2hhciAqKmFyZ3YpDQo+ICAgICAg
ICAgICBjYXNlICd6JzoNCj4gICAgICAgICAgICAgICB6ZmxhZyA9IHRydWU7DQo+ICAgICAgICAg
ICAgICAgYnJlYWs7DQo+ICsgICAgICAgIGNhc2UgJ3MnOg0KPiArICAgICAgICAgICAgc2ZsYWcg
PSB0cnVlOw0KPiArICAgICAgICAgICAgZmlsZV9uYW1lID0gZ19zdHJkdXAob3B0YXJnKTsNCj4g
KyAgICAgICAgICAgIGJyZWFrOw0KPiAgICAgICAgICAgZGVmYXVsdDoNCj4gICAgICAgICAgICAg
ICBxZW11aW9fY29tbWFuZF91c2FnZSgmd3JpdGVfY21kKTsNCj4gICAgICAgICAgICAgICByZXR1
cm4gLUVJTlZBTDsNCj4gQEAgLTEwNTEsOCArMTExOSw5IEBAIHN0YXRpYyBpbnQgd3JpdGVfZihC
bG9ja0JhY2tlbmQgKmJsaywgaW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0KPiAgICAgICAgICAgcmV0
dXJuIC1FSU5WQUw7DQo+ICAgICAgIH0NCj4gICANCj4gLSAgICBpZiAoemZsYWcgJiYgUGZsYWcp
IHsNCj4gLSAgICAgICAgcHJpbnRmKCIteiBhbmQgLVAgY2Fubm90IGJlIHNwZWNpZmllZCBhdCB0
aGUgc2FtZSB0aW1lXG4iKTsNCj4gKyAgICBpZiAoKGludCl6ZmxhZyArIChpbnQpUGZsYWcgKyAo
aW50KXNmbGFnID4gMSkgew0KPiArICAgICAgICBwcmludGYoIk9ubHkgb25lIG9mIC16LCAtUCwg
YW5kIC1zIg0KPiArICAgICAgICAgICAgICAgImNhbiBiZSBzcGVjaWZpZWQgYXQgdGhlIHNhbWUg
dGltZVxuIik7DQo+ICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gICAgICAgfQ0KPiAgIA0K
PiBAQCAtMTA4OCw3ICsxMTU3LDE0IEBAIHN0YXRpYyBpbnQgd3JpdGVfZihCbG9ja0JhY2tlbmQg
KmJsaywgaW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0KPiAgICAgICB9DQo+ICAgDQo+ICAgICAgIGlm
ICghemZsYWcpIHsNCj4gLSAgICAgICAgYnVmID0gcWVtdV9pb19hbGxvYyhibGssIGNvdW50LCBw
YXR0ZXJuKTsNCj4gKyAgICAgICAgaWYgKHNmbGFnKSB7DQo+ICsgICAgICAgICAgICBidWYgPSBx
ZW11X2lvX2FsbG9jX2Zyb21fZmlsZShibGssIGNvdW50LCBmaWxlX25hbWUpOw0KPiArICAgICAg
ICAgICAgaWYgKCFidWYpIHsNCj4gKyAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4g
KyAgICAgICAgICAgIH0NCj4gKyAgICAgICAgfSBlbHNlIHsNCj4gKyAgICAgICAgICAgIGJ1ZiA9
IHFlbXVfaW9fYWxsb2MoYmxrLCBjb3VudCwgcGF0dGVybik7DQo+ICsgICAgICAgIH0NCj4gICAg
ICAgfQ0KPiAgIA0KPiAgICAgICBnZXR0aW1lb2ZkYXkoJnQxLCBOVUxMKTsNCj4gDQoNCg0KLS0g
DQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

