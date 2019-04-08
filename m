Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C50C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 15:30:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AE042147A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 15:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cwk5l/6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE042147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54896 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDWDj-0001CN-Jf
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 11:30:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDWCw-0000sC-Bp
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:29:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDWCv-0007gx-Dm
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:29:14 -0400
Received: from mail-eopbgr60116.outbound.protection.outlook.com
	([40.107.6.116]:38624
	helo=EUR04-DB3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
	id 1hDWCs-0007at-J5; Mon, 08 Apr 2019 11:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=LK+s6qMfCrTRqut9hj8Tun0PkisZGoLF3HxRfb7+Xqc=;
	b=cwk5l/6BAtb97JjTvSWqRkKTYD6V05XTkg9dNKKk2UZcV8jckk0iseVQHqQLZ8eUX3iGKTSmV3vlPYQ4TfBcN8A5WzuquEsS0L2xmq9ivT6vQZMfvOTG0O+QEjaR8nSM/mN5/iu36FkLAeQfY+jrmA4uDONexSpBh9R5SeKlakw=
Received: from AM6PR08MB4421.eurprd08.prod.outlook.com (20.179.18.23) by
	AM6PR08MB3896.eurprd08.prod.outlook.com (20.178.91.21) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.21; Mon, 8 Apr 2019 15:29:07 +0000
Received: from AM6PR08MB4421.eurprd08.prod.outlook.com
	([fe80::d15a:3eaa:44bc:2644]) by
	AM6PR08MB4421.eurprd08.prod.outlook.com
	([fe80::d15a:3eaa:44bc:2644%4]) with mapi id 15.20.1771.019;
	Mon, 8 Apr 2019 15:29:07 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v3 1/3] block: include base when checking image chain for
	block allocation
Thread-Index: AQHU69CGFpR0vRnjgEOtWNirAAI9w6YyYOMAgAA10AD//8+QAIAAAbQA
Date: Mon, 8 Apr 2019 15:29:07 +0000
Message-ID: <3fb2301b-dccf-178f-92fd-8ba4445642e3@virtuozzo.com>
References: <1554483379-682051-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1554483379-682051-2-git-send-email-andrey.shinkevich@virtuozzo.com>
	<w517ec4y1wv.fsf@maestria.local.igalia.com>
	<3e489e51-79c7-54ec-7018-e7424d2c6f40@virtuozzo.com>
	<w514l78y10t.fsf@maestria.local.igalia.com>
In-Reply-To: <w514l78y10t.fsf@maestria.local.igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0180.eurprd05.prod.outlook.com
	(2603:10a6:3:f8::28) To AM6PR08MB4421.eurprd08.prod.outlook.com
	(2603:10a6:20b:71::23)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8cd04355-016c-497c-08fe-08d6bc36f092
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:AM6PR08MB3896; 
x-ms-traffictypediagnostic: AM6PR08MB3896:
x-microsoft-antispam-prvs: <AM6PR08MB38969222CEFD02D757B0DAAAF42C0@AM6PR08MB3896.eurprd08.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(396003)(346002)(376002)(39850400004)(366004)(136003)(189003)(43544003)(199004)(5660300002)(31686004)(486006)(36756003)(66066001)(105586002)(106356001)(8936002)(4326008)(107886003)(478600001)(68736007)(81166006)(8676002)(14454004)(25786009)(44832011)(53936002)(6246003)(6512007)(256004)(81156014)(6486002)(6436002)(2906002)(71190400001)(71200400001)(3846002)(6116002)(229853002)(99286004)(52116002)(54906003)(110136005)(93886005)(31696002)(97736004)(305945005)(7736002)(76176011)(6506007)(102836004)(53546011)(386003)(2201001)(26005)(2501003)(186003)(446003)(11346002)(476003)(2616005)(86362001)(316002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3896;
	H:AM6PR08MB4421.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r5+N8tYOFSjEOxZVLmcM/54NCH+n7eHielaxfQ9kHx2bv+I9Bp4ZAoecVgtxd0ASDGKTsMPeBxp2MY+V4qUhmRn9sQW4R2vnrHCMzOGNwNYc83pExBm3Zw4BbNaxMFUi7PR3vD46prBcYXgUnkCRJJEhOFHnMZ88k0n5H8Anxqnt7Gigx0Lzy8XNl7d2ePV3gOYKZK/6aK5HnqsLqLhe6BFPCe6icKr68+mu1lUFJEVDAcGPXtiPsNZbZfh+26AQ8IbJhBh9/vC+6by0CZfGHnTwMGl5DkkPDzlO0lF64iWlpbcnTRjSBGsYrjsb/0bmQoKkF2laCu6Mymbj6b7xdDm2+j0snsQmkh9edQaSB2U6q9MlY9RoCrJiZLZsDlJgha0su4urwViPDIoiQ+383+hohH3rMcyzvIY2Cv7yWsI=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <8AAEE3023D6CC747B746AC82D350DEFB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd04355-016c-497c-08fe-08d6bc36f092
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 15:29:07.1823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3896
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.116
Subject: Re: [Qemu-devel] [PATCH v3 1/3] block: include base when checking
 image chain for block allocation
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
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408152907.Lx4EuxCBm6XlgKvgHEr3jxgnIYiLP-LtvF3CFeejuEE@z>

DQoNCk9uIDA4LzA0LzIwMTkgMTg6MjIsIEFsYmVydG8gR2FyY2lhIHdyb3RlOg0KPiBPbiBNb24g
MDggQXByIDIwMTkgMDU6MTY6MjIgUE0gQ0VTVCwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+
PiBPbiAwOC8wNC8yMDE5IDE4OjAzLCBBbGJlcnRvIEdhcmNpYSB3cm90ZToNCj4+PiBPbiBGcmkg
MDUgQXByIDIwMTkgMDY6NTY6MTcgUE0gQ0VTVCwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+
Pj4+ICtpbnQgYmRydl9pc19hbGxvY2F0ZWRfYWJvdmUoQmxvY2tEcml2ZXJTdGF0ZSAqdG9wLA0K
Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJsb2NrRHJpdmVyU3RhdGUgKmJhc2Us
DQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50NjRfdCBvZmZzZXQsIGludDY0
X3QgYnl0ZXMsIGludDY0X3QgKnBudW0pDQo+Pj4+ICt7DQo+Pj4+ICsgICAgcmV0dXJuIGJkcnZf
ZG9faXNfYWxsb2NhdGVkX2Fib3ZlKHRvcCwgYmFzZSwgZmFsc2UsIG9mZnNldCwgYnl0ZXMsIHBu
dW0pOw0KPj4+PiArfQ0KPj4+PiArDQo+Pj4+ICtpbnQgYmRydl9pc19hbGxvY2F0ZWRfYWJvdmVf
aW5jbHVzaXZlKEJsb2NrRHJpdmVyU3RhdGUgKnRvcCwNCj4+Pj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgQmxvY2tEcml2ZXJTdGF0ZSAqYmFzZSwNCj4+Pj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50NjRfdCBvZmZzZXQsIGludDY0X3Qg
Ynl0ZXMsDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludDY0
X3QgKnBudW0pDQo+Pj4+ICt7DQo+Pj4+ICsgICAgcmV0dXJuIGJkcnZfZG9faXNfYWxsb2NhdGVk
X2Fib3ZlKHRvcCwgYmFzZSwgdHJ1ZSwgb2Zmc2V0LCBieXRlcywgcG51bSk7DQo+Pj4+ICt9DQo+
Pj4NCj4+PiBJbnN0ZWFkIG9mIGhhdmluZyB0aGVzZSB0d28sIGlzbid0IGl0IHNpbXBsZXIgdG8g
YWRkIGFuICdpbmNsdWRlX2Jhc2UnDQo+Pj4gcGFyYW1ldGVyIHRvIHRoZSBvcmlnaW5hbCBmdW5j
dGlvbj8NCj4+Pg0KPj4+IEFub3RoZXIgYWx0ZXJuYXRpdmUgKEkgaGF2ZW4ndCBjaGVja2VkIHRo
aXMgb25lIHNvIGl0IGNvdWxkIGJlIG1vcmUNCj4+PiBjdW1iZXJzb21lKTogY2hhbmdlIHRoZSBz
ZW1hbnRpY3Mgb2YgdGhlIGZ1bmN0aW9uIHRvIGFsd2F5cyBpbmNsdWRlIHRoZQ0KPj4+IGJhc2Ug
YW5kIG1vZGlmeSB0aGUgY2FsbGVycy4NCj4+DQo+PiBUaGUgaWRlYSBiZWhpbmQgdGhvc2UgdHdv
IGZ1bmN0aW9ucyB3YXMgdG8ga2VlcCB0aGUgcmVzdCBvZiB0aGUgY29kZQ0KPj4gdW5tb2RpZmll
ZC4gQ3VycmVudGx5LCB3ZSBoYXZlIHRoZSBpc3N1ZSB3aXRoIHRoZSBibG9jay1zdHJlYW0NCj4+
IHBhcmFsbGVsIGpvYnMuIFdoYXQgaWYgd2UgbWFuYWdlIHRoaXMgY2FzZSBmaXJzdCBhbmQgdGhl
biwgd2hlbiBwcm92ZWQNCj4+IHRvIGJlIHJvYnVzdCwgdGFrZSBjYXJlIG9mIHRoZSByZXN0Pw0K
PiANCj4gU3VyZSwgdGhhdCBtYWtlcyBzZW5zZSBpZiB5b3UgbmVlZCB0byBkbyBzaWduaWZpY2Fu
dCBjaGFuZ2VzIHRvIHRoZQ0KPiBvdGhlciBjYWxsZXJzLCBidXQgaWYgeW91IGp1c3QgbmVlZCB0
byBwYXNzIGFuIGV4dHJhICdmYWxzZScNCj4gcGFyYW1ldGVyLi4uDQo+IA0KPiBJdCdzIG5vdCBh
IGJpZyBkZWFsLCBJIGp1c3QgdGhpbmsgeW91J2QgaGF2ZSBhIHNpbXBsZXIgcGF0Y2guDQo+IA0K
PiBCZXJ0bw0KPiANCg0KT0ssIEknbGwgZG8gdGhhdCB3aXRoIHRoZSBuZXh0IHY0Lg0KLS0gDQpX
aXRoIHRoZSBiZXN0IHJlZ2FyZHMsDQpBbmRyZXkgU2hpbmtldmljaA0K

