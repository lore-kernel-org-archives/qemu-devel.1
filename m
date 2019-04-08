Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A708C10F14
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 11:56:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33C0B21473
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 11:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Bz1sCFuD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C0B21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51650 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDStP-0002Us-D5
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 07:56:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDSsV-0002C8-HY
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:55:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDSsQ-0003pJ-Vw
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:55:52 -0400
Received: from mail-eopbgr20126.outbound.protection.outlook.com
	([40.107.2.126]:31822
	helo=EUR02-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
	id 1hDSsK-0003jb-VC; Mon, 08 Apr 2019 07:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=6nmegihZHrXw4C7MC+ZwUSBvDr/s2J0up4MK8msEdmc=;
	b=Bz1sCFuD7fWvT+JnWQF61QtJ5vkiQOHx328606bs7BEMX4R9VM/ZrNjaIfgvWcwmiHLpQ2SQpTnxpvvAC+STYJ0QZlXrklnn0VLffw2ZP/QydCG8sxQd5uls8ymL4rN3MDuOrdO6ii00flOSz13q+xFjzyigX3cvhM9upnz4wiI=
Received: from AM6PR08MB4421.eurprd08.prod.outlook.com (20.179.18.23) by
	AM6PR08MB3797.eurprd08.prod.outlook.com (20.178.89.150) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.13; Mon, 8 Apr 2019 11:55:37 +0000
Received: from AM6PR08MB4421.eurprd08.prod.outlook.com
	([fe80::d15a:3eaa:44bc:2644]) by
	AM6PR08MB4421.eurprd08.prod.outlook.com
	([fe80::d15a:3eaa:44bc:2644%4]) with mapi id 15.20.1771.019;
	Mon, 8 Apr 2019 11:55:37 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [Qemu-block] [PATCH] block/io.c: fix for the allocation failure
Thread-Index: AQHU67tCeBQBY4L5bEGNNolBmRLa5KYuLFmAgAQNt4D//9NxAIAAHvoA
Date: Mon, 8 Apr 2019 11:55:37 +0000
Message-ID: <009d858c-40e5-6397-44b0-d395fa9d0cf9@virtuozzo.com>
References: <1554474244-553661-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<ad53e61a-a911-c019-3f68-2bd05b7be944@redhat.com>
	<468cc6c9-c338-a4fe-57b1-b4df5b2b24c0@virtuozzo.com>
	<20190408100442.GA11997@linux.fritz.box>
In-Reply-To: <20190408100442.GA11997@linux.fritz.box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0502CA0012.eurprd05.prod.outlook.com
	(2603:10a6:3:e3::22) To AM6PR08MB4421.eurprd08.prod.outlook.com
	(2603:10a6:20b:71::23)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f323f271-5fc2-4fdd-4760-08d6bc191d79
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:AM6PR08MB3797; 
x-ms-traffictypediagnostic: AM6PR08MB3797:
x-microsoft-antispam-prvs: <AM6PR08MB3797B505C38D9649E4E5CEF3F42C0@AM6PR08MB3797.eurprd08.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(346002)(396003)(136003)(366004)(39840400004)(199004)(189003)(66066001)(6486002)(53936002)(31686004)(105586002)(107886003)(446003)(476003)(106356001)(11346002)(4326008)(76176011)(186003)(486006)(6512007)(316002)(305945005)(54906003)(2616005)(229853002)(44832011)(25786009)(36756003)(31696002)(7736002)(2906002)(14454004)(86362001)(6116002)(386003)(53546011)(81166006)(26005)(81156014)(68736007)(99286004)(8936002)(14444005)(256004)(8676002)(6506007)(52116002)(478600001)(6246003)(3846002)(5660300002)(102836004)(71190400001)(6436002)(71200400001)(97736004)(6916009)(93886005);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3797;
	H:AM6PR08MB4421.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kJtrNU8nhTEIBBNWXMF+gIYJ9Z/gU+D16XThj9fJK25PgJ+tXV+hnRpRb9+bjvQGKKvxz9HJlC9fxIjDlnnII7FSm2IcXktI4G5szFi57ooSRQrxYntPrq6HZ/4i5h6DwZGLUmAmHtAsKEWUoD+Y4sant+ojH75Jk6JPmwKcXTegzgQisd/fx9O/c/9KQZopGVB9mw9yOGoor100LRiqJtl+MW1BhDRYN+wBc6esv1so7/Tq/bQb86srZeP2yMMdWTG2/cXgC8coKGRMvJ/Me/xlyVfayzU3LNGOGTBAiH4Ug8g85ib/3LQtFPj0zb1lUqgxHObhpLZnZVmxQp2cKrfMAV4fDx6ALfgX1a1W8/VFcnWp7rV/xltgtK27glGdRZoqJoWCdIVKKS4o9zcSm9iKgGwMZXEpDGUYyKz8Ojg=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <AE3DC5E2154FBA4FA757FD6D7D4DE823@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f323f271-5fc2-4fdd-4760-08d6bc191d79
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 11:55:37.6747 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3797
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.126
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
Cc: "fam@euphon.net" <fam@euphon.net>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	Denis Lunev <den@virtuozzo.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408115537.t1A9TXqzg-F1oEbksUukWqq5_TKdYZ5Y5sXmrhkztbo@z>

DQoNCk9uIDA4LzA0LzIwMTkgMTM6MDQsIEtldmluIFdvbGYgd3JvdGU6DQo+IEFtIDA4LjA0LjIw
MTkgdW0gMTE6NDQgaGF0IEFuZHJleSBTaGlua2V2aWNoIGdlc2NocmllYmVuOg0KPj4NCj4+DQo+
PiBPbiAwNi8wNC8yMDE5IDAxOjUwLCBKb2huIFNub3cgd3JvdGU6DQo+Pj4NCj4+Pg0KPj4+IE9u
IDQvNS8xOSAxMDoyNCBBTSwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+Pj4+IE9uIGEgZmls
ZSBzeXN0ZW0gdXNlZCBieSB0aGUgY3VzdG9tZXIsIGZhbGxvY2F0ZSgpIHJldHVybnMgYW4gZXJy
b3INCj4+Pj4gaWYgdGhlIGJsb2NrIGlzIG5vdCBwcm9wZXJseSBhbGlnbmVkLiBTbywgYmRydl9j
b19wd3JpdGVfemVyb2VzKCkNCj4+Pj4gZmFpbHMuIFdlIGNhbiBoYW5kbGUgdGhhdCBjYXNlIHRo
ZSBzYW1lIHdheSBhcyBpdCBpcyBkb25lIGZvciB0aGUNCj4+Pj4gdW5zdXBwb3J0ZWQgY2FzZXMs
IG5hbWVseSwgY2FsbCB0byBiZHJ2X2RyaXZlcl9wd3JpdGV2KCkgdGhhdCB3cml0ZXMNCj4+Pj4g
emVyb2VzIHRvIGFuIGltYWdlIGZvciB0aGUgdW5hbGlnbmVkIGNodW5rIG9mIHRoZSBibG9jay4N
Cj4+Pj4NCj4+Pj4gU3VnZ2VzdGVkLWJ5OiBEZW5pcyBWLiBMdW5ldiA8ZGVuQG9wZW52ei5vcmc+
DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBTaGlua2V2aWNoIDxhbmRyZXkuc2hpbmtldmlj
aEB2aXJ0dW96em8uY29tPg0KPj4+PiAtLS0NCj4+Pj4gICAgYmxvY2svaW8uYyB8IDIgKy0NCj4+
Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4+
DQo+Pj4+IGRpZmYgLS1naXQgYS9ibG9jay9pby5jIGIvYmxvY2svaW8uYw0KPj4+PiBpbmRleCBk
ZmMxNTNiLi4wNDEyYTUxIDEwMDY0NA0KPj4+PiAtLS0gYS9ibG9jay9pby5jDQo+Pj4+ICsrKyBi
L2Jsb2NrL2lvLmMNCj4+Pj4gQEAgLTE1MTYsNyArMTUxNiw3IEBAIHN0YXRpYyBpbnQgY29yb3V0
aW5lX2ZuIGJkcnZfY29fZG9fcHdyaXRlX3plcm9lcyhCbG9ja0RyaXZlclN0YXRlICpicywNCj4+
Pj4gICAgICAgICAgICAgICAgYXNzZXJ0KCFicy0+c3VwcG9ydGVkX3plcm9fZmxhZ3MpOw0KPj4+
PiAgICAgICAgICAgIH0NCj4+Pj4gICAgDQo+Pj4+IC0gICAgICAgIGlmIChyZXQgPT0gLUVOT1RT
VVAgJiYgIShmbGFncyAmIEJEUlZfUkVRX05PX0ZBTExCQUNLKSkgew0KPj4+PiArICAgICAgICBp
ZiAocmV0IDwgMCAmJiAhKGZsYWdzICYgQkRSVl9SRVFfTk9fRkFMTEJBQ0spKSB7DQo+Pj4+ICAg
ICAgICAgICAgICAgIC8qIEZhbGwgYmFjayB0byBib3VuY2UgYnVmZmVyIGlmIHdyaXRlIHplcm9l
cyBpcyB1bnN1cHBvcnRlZCAqLw0KPj4+PiAgICAgICAgICAgICAgICBCZHJ2UmVxdWVzdEZsYWdz
IHdyaXRlX2ZsYWdzID0gZmxhZ3MgJiB+QkRSVl9SRVFfWkVST19XUklURTsNCj4+Pj4gICAgDQo+
Pj4+DQo+Pj4NCj4+PiBJIHN1cHBvc2UgdGhhdCBpZiBmYWxsb2NhdGUgZmFpbHMgZm9yIGFueSBy
ZWFzb24gYW5kIHdlJ3JlIGFsbG93aW5nDQo+Pj4gZmFsbGJhY2ssIHdlJ3JlIGVpdGhlciBnb2lu
ZyB0byBzdWNjZWVkIC4uLiBvciBmYWlsIGFnYWluIHZlcnkgc29vbg0KPj4+IHRoZXJlYWZ0ZXIu
DQo+Pj4NCj4+PiBBcmUgdGhlcmUgYW55IGNhc2VzIHdoZXJlIGl0IGlzIHZpdGFsIHRvIG5vdCBp
Z25vcmUgdGhlIGZpcnN0IGZhbGxvY2F0ZQ0KPj4+IGZhaWx1cmU/IEknbSBhIGxpdHRsZSB3YXJ5
IG9mIGlnbm9yaW5nIHRoZSByZXR1cm4gY29kZSBmcm9tDQo+Pj4gYmRydl9jb19wd3JpdGVfemVy
b2VzLCBidXQgSSBhbSBhc3N1bWluZyB0aGF0IGlmIHRoZXJlIGlzIGEgInJlYWwiDQo+Pj4gZmFp
bHVyZSBoZXJlIHRoYXQgdGhlIGZvbGxvd2luZyBib3VuY2Ugd3JpdGVzIHdpbGwgYWxzbyBmYWls
ICJzYWZlbHkuIg0KPj4+DQo+Pj4gSSdtIG5vdCBjb21wbGV0ZWx5IGNvbmZpZGVudCwgYnV0IEkg
aGF2ZSBubyB0YW5naWJsZSBvYmplY3Rpb25zOg0KPj4+IFJldmlld2VkLWJ5OiBKb2huIFNub3cg
PGpzbm93QHJlZGhhdC5jb20+DQo+Pj4NCj4+DQo+PiBUaGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3
LCBKb2huIQ0KPj4NCj4+IExldCBtZSBjbGFyaWZ5IHRoZSBjaXJjdW1zdGFuY2VzIGFuZCBxdW90
ZSB0aGUgYnVnIHJlcG9ydDoNCj4+ICJDdXN0b21lciBoYWQgV2luLTIwMTIgVk0gd2l0aCA1MEdC
IHN5c3RlbSBkaXNrIHdoaWNoIHdhcyBsYXRlciByZXNpemVkDQo+PiB0byAyNTZHQiB3aXRob3V0
IHJlc2l6aW5nIHRoZSBwYXJ0aXRpb24gaW5zaWRlIFZNLg0KPj4gTm93LCB3aGlsZSB0cnlpbmcg
dG8gcmVzaXplIHRvIDUwRywgdGhlIGZvbGxvd2luZyBlcnJvciB3aWxsIGFwcGVhcg0KPj4gJ0Zh
aWxlZCB0byByZWR1Y2UgdGhlIG51bWJlciBvZiBMMiB0YWJsZXM6IEludmFsaWQgYXJndW1lbnQn
DQo+PiBJdCB3YXMgZm91bmQgdGhhdCBpdCBpcyBwb3NzaWJsZSB0byBzaHJpbmsgdGhlIGRpc2sg
dG8gMTI4RyBhbmQgYW55IHNpemUNCj4+IGFib3ZlIHRoYXQgbnVtYmVyLCBidXQgc2l6ZSBiZWxv
dyAxMjhHIHdpbGwgYnJpbmcgdGhlIG1lbnRpb25lZCBlcnJvci4iDQo+Pg0KPj4gVGhlIGZhbGxv
Y2F0ZSgpIHJldHVybnMgbm8gZXJyb3Igb24gdGhhdCBmaWxlIHN5c3RlbSBpZiB0aGUgb2Zmc2V0
IGFuZA0KPj4gdGhlIChvZmZzZXQgKyBieXRlcykgcGFyYW1ldGVycyBvZiB0aGUgYmRydl9jb19k
b19wd3JpdGVfemVyb2VzKCkgYm90aA0KPj4gYXJlIGFsaWduZWQgdG8gNEsuDQo+IA0KPiBXaGF0
IGlzIHRoZSByZXR1cm4gdmFsdWUgeW91IGdldCBmcm9tIHRoaXMgZmlsZSBzeXN0ZW0/DQo+IA0K
PiBNYXliZSB0dXJuaW5nIHRoYXQgaW50byBFTk9UU1VQIGluIGZpbGUtcG9zaXggd291bGQgYmUg
bGVzcyBpbnZhc2l2ZS4NCj4gSnVzdCBmYWxsaW5nIGJhY2sgZm9yIGFueSBlcnJvciBnaXZlcyBt
ZSB0aGUgdmFndWUgZmVlbGluZyB0aGF0IGl0IGNvdWxkDQo+IGNhdXNlIHByb2JsZW1zIHNvb25l
ciBvciBsYXRlci4NCj4gDQo+IEtldmluDQo+IA0KDQpUaGUgcmV0dXJuIHZhbHVlIGZvciB0aGF0
IGN1c3RvbSBkaXN0cmlidXRlZCBmaWxlIHN5c3RlbSBpcw0KIkludmFsaWQgYXJndW1lbnQiLCB0
aGF0J3MNCiJFSU5WQUw6IG1vZGUgaXMgRkFMTE9DX0ZMX1pFUk9fUkFOR0UsIGJ1dCB0aGUgZmls
ZSByZWZlcnJlZCB0bw0KYnkgZmQgaXMgbm90IGEgcmVndWxhciBmaWxlIi4NCg0KV2hlbiBJIHJl
cHJvZHVjZWQgdGhlIGJ1ZywgSSBzYXcgdGhhdCB0aGUgYWxpZ25tZW50IGluIHRoZQ0KYmRydl9j
b19kb19wd3JpdGVfemVyb2VzKCkgd2FzIHNldCB0byAnMScgaW4gdGhhdCBjYXNlOg0KDQpNQVgo
YnMtPmJsLnB3cml0ZV96ZXJvZXNfYWxpZ25tZW50IC89MC8pLA0KICAgICBicy0+YmwucmVxdWVz
dF9hbGlnbm1lbnQgLz0xLyk7DQoNCldpdGggbXkgZmlyc3QgcGF0Y2ggSSBoYWQgbm90IHNlbnQg
YmVmb3JlLCBhIG5ldyBtZW1iZXIgb2YgdGhlIHN0cnVjdHVyZQ0KQmxvY2tMaW1pdHMsIHNheSBw
d3JpdGVfemVyb2VzX2FsaWdubWVudF9taW4sIHdhcyBzZXQgdG8gNEsgZm9yIGEgcmF3DQpmaWxl
IGFuZCB0aGUgYWxpZ25tZW50IHdhcyBtYWRlIGZvciB0aGUgYmxvY2suIFRoZW4gemVyb2VzIHdl
cmUgd3JpdHRlbg0KdG8gdGhlIGltYWdlIGZvciB0aGUgdW5hbGlnbmVkIGhlYWQgYW5kIHRhaWwg
YnkgaW52b2tpbmcgdGhlDQpiZHJ2X2RyaXZlcl9wd3JpdGV2KCkuIFRoYXQgYXBwcm9hY2ggaGFz
IGNvbnMgYWxzbzogd2Ugd291bGQgd3JpdGUgdG8NCnRoZSBkaXNrIGFsd2F5cy4NCg0KVGhlIGZp
bGUgc3lzdGVtIG1haW50YWluZXJzIHNheSB0aGF0IHRoZSBidWcgaXMgYSBwYXJ0aWN1bGFyIGNh
c2UgYW5kDQp0aGV5IG1heSBub3QgcmV0dXJuIHRoZSBnZW5lcmFsIGVycm9yIHN1Y2ggYXMgJ3Vu
c3VwcG9ydGVkJy4NCi0tIA0KQW5kcmV5DQo=

