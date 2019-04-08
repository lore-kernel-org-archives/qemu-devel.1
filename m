Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C3AC282DD
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 09:47:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EA9C20880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 09:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RLsdDdPO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EA9C20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50264 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDQrw-0005VS-GL
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 05:47:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDQpQ-0003vd-PE
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:44:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDQpP-0007uU-Nf
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:44:36 -0400
Received: from mail-eopbgr50107.outbound.protection.outlook.com
	([40.107.5.107]:16029
	helo=EUR03-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
	id 1hDQpM-0007sA-No; Mon, 08 Apr 2019 05:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=xqmC7BOxNRJZ3rJeuB87g7s8I+oSuXcLC5NgMhBe46c=;
	b=RLsdDdPOD0+Gw4icpx9jg3lEIteoF7GW2t6IOiJEi/V2+xea0ULQQ9E3z8njvt1kgRMotYJbblxbjxszTGyGYbiZD1wuVyE8ZBvwzFo9tO+zs4iQkoK/7HeHA90f/T8+arjKUEZIArkR/mqVtgHnimF/syQr7+ajVkT3rV+0Xmc=
Received: from AM6PR08MB4421.eurprd08.prod.outlook.com (20.179.18.23) by
	AM6PR08MB3848.eurprd08.prod.outlook.com (20.178.90.89) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.13; Mon, 8 Apr 2019 09:44:14 +0000
Received: from AM6PR08MB4421.eurprd08.prod.outlook.com
	([fe80::d15a:3eaa:44bc:2644]) by
	AM6PR08MB4421.eurprd08.prod.outlook.com
	([fe80::d15a:3eaa:44bc:2644%4]) with mapi id 15.20.1771.019;
	Mon, 8 Apr 2019 09:44:14 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [Qemu-block] [PATCH] block/io.c: fix for the allocation failure
Thread-Index: AQHU67tCeBQBY4L5bEGNNolBmRLa5KYuLFmAgAPbbYA=
Date: Mon, 8 Apr 2019 09:44:14 +0000
Message-ID: <468cc6c9-c338-a4fe-57b1-b4df5b2b24c0@virtuozzo.com>
References: <1554474244-553661-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<ad53e61a-a911-c019-3f68-2bd05b7be944@redhat.com>
In-Reply-To: <ad53e61a-a911-c019-3f68-2bd05b7be944@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0026.eurprd07.prod.outlook.com
	(2603:10a6:7:66::12) To AM6PR08MB4421.eurprd08.prod.outlook.com
	(2603:10a6:20b:71::23)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b34df1f8-0a59-466b-01cb-08d6bc06c289
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:AM6PR08MB3848; 
x-ms-traffictypediagnostic: AM6PR08MB3848:
x-microsoft-antispam-prvs: <AM6PR08MB38480018C7F0B37278E2DD5AF42C0@AM6PR08MB3848.eurprd08.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(366004)(136003)(346002)(396003)(39840400004)(199004)(189003)(71200400001)(102836004)(36756003)(6506007)(5660300002)(71190400001)(66066001)(8676002)(25786009)(316002)(386003)(110136005)(26005)(53546011)(54906003)(6486002)(6436002)(229853002)(256004)(8936002)(81156014)(81166006)(3846002)(14444005)(186003)(31686004)(2501003)(2201001)(6512007)(97736004)(2906002)(52116002)(99286004)(6116002)(76176011)(53936002)(446003)(478600001)(44832011)(305945005)(107886003)(105586002)(86362001)(68736007)(6246003)(106356001)(2616005)(31696002)(14454004)(476003)(7736002)(4326008)(11346002)(486006);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3848;
	H:AM6PR08MB4421.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 98wcZDZA02vbt4XfyLwtLGKOuUxlidjksu7MzBRng6AYpDSkbQxhPCxarRCPrEPmo4c2f3TpTHXCM8c6g2ZD2Hku15kQaJmWsl4m21lCPDzp6m/Or5/UdIthOSNpWCFXfGcmbderbDRwToEQgpStC4YLDBh+WpTH0sQlokvkh71LFDafzx1chW2n3lkA3HyfNPSh0Zw3wD+FZehCBVpki11CV3xsrtAhw9sAbQBLvJfmdpJXf/YAwp4dNDfVCHL9H6xRYgOpKtcweah7Hpzgn/NBkbdVSjCyQNASGw1ukMSiiQoOvTN/St5G2iw/CIjyxt+2H1yWUcuOctpvFMV1H2DAVqV9bM7Pm7iGOOlhXXjtusez32z6XMKSZKHWTEOxZE34CG94TwE3fx3esbr3wlxRIzhBmiOLT6l7i47N2JA=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <0352ABD972FE7F47B395379B8413D1F2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b34df1f8-0a59-466b-01cb-08d6bc06c289
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 09:44:14.1810 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3848
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.107
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block/io.c: fix for the
 allocation failure
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408094414.60zNgisjWsKigUszxoQXPr5WVp8Er3c2RW9v_K1G3sM@z>

DQoNCk9uIDA2LzA0LzIwMTkgMDE6NTAsIEpvaG4gU25vdyB3cm90ZToNCj4gDQo+IA0KPiBPbiA0
LzUvMTkgMTA6MjQgQU0sIEFuZHJleSBTaGlua2V2aWNoIHdyb3RlOg0KPj4gT24gYSBmaWxlIHN5
c3RlbSB1c2VkIGJ5IHRoZSBjdXN0b21lciwgZmFsbG9jYXRlKCkgcmV0dXJucyBhbiBlcnJvcg0K
Pj4gaWYgdGhlIGJsb2NrIGlzIG5vdCBwcm9wZXJseSBhbGlnbmVkLiBTbywgYmRydl9jb19wd3Jp
dGVfemVyb2VzKCkNCj4+IGZhaWxzLiBXZSBjYW4gaGFuZGxlIHRoYXQgY2FzZSB0aGUgc2FtZSB3
YXkgYXMgaXQgaXMgZG9uZSBmb3IgdGhlDQo+PiB1bnN1cHBvcnRlZCBjYXNlcywgbmFtZWx5LCBj
YWxsIHRvIGJkcnZfZHJpdmVyX3B3cml0ZXYoKSB0aGF0IHdyaXRlcw0KPj4gemVyb2VzIHRvIGFu
IGltYWdlIGZvciB0aGUgdW5hbGlnbmVkIGNodW5rIG9mIHRoZSBibG9jay4NCj4+DQo+PiBTdWdn
ZXN0ZWQtYnk6IERlbmlzIFYuIEx1bmV2IDxkZW5Ab3BlbnZ6Lm9yZz4NCj4+IFNpZ25lZC1vZmYt
Ynk6IEFuZHJleSBTaGlua2V2aWNoIDxhbmRyZXkuc2hpbmtldmljaEB2aXJ0dW96em8uY29tPg0K
Pj4gLS0tDQo+PiAgIGJsb2NrL2lvLmMgfCAyICstDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ibG9jay9pby5j
IGIvYmxvY2svaW8uYw0KPj4gaW5kZXggZGZjMTUzYi4uMDQxMmE1MSAxMDA2NDQNCj4+IC0tLSBh
L2Jsb2NrL2lvLmMNCj4+ICsrKyBiL2Jsb2NrL2lvLmMNCj4+IEBAIC0xNTE2LDcgKzE1MTYsNyBA
QCBzdGF0aWMgaW50IGNvcm91dGluZV9mbiBiZHJ2X2NvX2RvX3B3cml0ZV96ZXJvZXMoQmxvY2tE
cml2ZXJTdGF0ZSAqYnMsDQo+PiAgICAgICAgICAgICAgIGFzc2VydCghYnMtPnN1cHBvcnRlZF96
ZXJvX2ZsYWdzKTsNCj4+ICAgICAgICAgICB9DQo+PiAgIA0KPj4gLSAgICAgICAgaWYgKHJldCA9
PSAtRU5PVFNVUCAmJiAhKGZsYWdzICYgQkRSVl9SRVFfTk9fRkFMTEJBQ0spKSB7DQo+PiArICAg
ICAgICBpZiAocmV0IDwgMCAmJiAhKGZsYWdzICYgQkRSVl9SRVFfTk9fRkFMTEJBQ0spKSB7DQo+
PiAgICAgICAgICAgICAgIC8qIEZhbGwgYmFjayB0byBib3VuY2UgYnVmZmVyIGlmIHdyaXRlIHpl
cm9lcyBpcyB1bnN1cHBvcnRlZCAqLw0KPj4gICAgICAgICAgICAgICBCZHJ2UmVxdWVzdEZsYWdz
IHdyaXRlX2ZsYWdzID0gZmxhZ3MgJiB+QkRSVl9SRVFfWkVST19XUklURTsNCj4+ICAgDQo+Pg0K
PiANCj4gSSBzdXBwb3NlIHRoYXQgaWYgZmFsbG9jYXRlIGZhaWxzIGZvciBhbnkgcmVhc29uIGFu
ZCB3ZSdyZSBhbGxvd2luZw0KPiBmYWxsYmFjaywgd2UncmUgZWl0aGVyIGdvaW5nIHRvIHN1Y2Nl
ZWQgLi4uIG9yIGZhaWwgYWdhaW4gdmVyeSBzb29uDQo+IHRoZXJlYWZ0ZXIuDQo+IA0KPiBBcmUg
dGhlcmUgYW55IGNhc2VzIHdoZXJlIGl0IGlzIHZpdGFsIHRvIG5vdCBpZ25vcmUgdGhlIGZpcnN0
IGZhbGxvY2F0ZQ0KPiBmYWlsdXJlPyBJJ20gYSBsaXR0bGUgd2FyeSBvZiBpZ25vcmluZyB0aGUg
cmV0dXJuIGNvZGUgZnJvbQ0KPiBiZHJ2X2NvX3B3cml0ZV96ZXJvZXMsIGJ1dCBJIGFtIGFzc3Vt
aW5nIHRoYXQgaWYgdGhlcmUgaXMgYSAicmVhbCINCj4gZmFpbHVyZSBoZXJlIHRoYXQgdGhlIGZv
bGxvd2luZyBib3VuY2Ugd3JpdGVzIHdpbGwgYWxzbyBmYWlsICJzYWZlbHkuIg0KPiANCj4gSSdt
IG5vdCBjb21wbGV0ZWx5IGNvbmZpZGVudCwgYnV0IEkgaGF2ZSBubyB0YW5naWJsZSBvYmplY3Rp
b25zOg0KPiBSZXZpZXdlZC1ieTogSm9obiBTbm93IDxqc25vd0ByZWRoYXQuY29tPg0KPiANCg0K
VGhhbmsgeW91IGZvciB5b3VyIHJldmlldywgSm9obiENCg0KTGV0IG1lIGNsYXJpZnkgdGhlIGNp
cmN1bXN0YW5jZXMgYW5kIHF1b3RlIHRoZSBidWcgcmVwb3J0Og0KIkN1c3RvbWVyIGhhZCBXaW4t
MjAxMiBWTSB3aXRoIDUwR0Igc3lzdGVtIGRpc2sgd2hpY2ggd2FzIGxhdGVyIHJlc2l6ZWQgDQp0
byAyNTZHQiB3aXRob3V0IHJlc2l6aW5nIHRoZSBwYXJ0aXRpb24gaW5zaWRlIFZNLg0KTm93LCB3
aGlsZSB0cnlpbmcgdG8gcmVzaXplIHRvIDUwRywgdGhlIGZvbGxvd2luZyBlcnJvciB3aWxsIGFw
cGVhcg0KJ0ZhaWxlZCB0byByZWR1Y2UgdGhlIG51bWJlciBvZiBMMiB0YWJsZXM6IEludmFsaWQg
YXJndW1lbnQnDQpJdCB3YXMgZm91bmQgdGhhdCBpdCBpcyBwb3NzaWJsZSB0byBzaHJpbmsgdGhl
IGRpc2sgdG8gMTI4RyBhbmQgYW55IHNpemUgDQphYm92ZSB0aGF0IG51bWJlciwgYnV0IHNpemUg
YmVsb3cgMTI4RyB3aWxsIGJyaW5nIHRoZSBtZW50aW9uZWQgZXJyb3IuIg0KDQpUaGUgZmFsbG9j
YXRlKCkgcmV0dXJucyBubyBlcnJvciBvbiB0aGF0IGZpbGUgc3lzdGVtIGlmIHRoZSBvZmZzZXQg
YW5kDQp0aGUgKG9mZnNldCArIGJ5dGVzKSBwYXJhbWV0ZXJzIG9mIHRoZSBiZHJ2X2NvX2RvX3B3
cml0ZV96ZXJvZXMoKSBib3RoDQphcmUgYWxpZ25lZCB0byA0Sy4NCi0tIA0KV2l0aCB0aGUgYmVz
dCByZWdhcmRzLA0KQW5kcmV5IFNoaW5rZXZpY2gNCg==

