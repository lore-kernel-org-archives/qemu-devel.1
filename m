Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC2FC10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 15:10:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDD8D2173C
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 15:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Oh0AWxdZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD8D2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50450 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEbL6-0000Py-71
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 11:10:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEbKG-0008Tw-Gp
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:09:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEbKE-0003N9-M0
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:09:16 -0400
Received: from mail-eopbgr40123.outbound.protection.outlook.com
	([40.107.4.123]:37057
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hEbK7-00036d-60; Thu, 11 Apr 2019 11:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=0w0016dSZxZYOIdC9wRWr3I1QT0P0ocFVElp55wjJMs=;
	b=Oh0AWxdZcNozvcFrxxu1ddCiJNAgcttIIF6ZgkcWTi91A5TqyZpn+ThhDO8ygOrDwA+rlLB284W+sOHbhyU313z4z18muI5OONd20ZOYkbFuqOZa6EJ67cv/qW+nvmDO0y5DNBl/i4nn5dwcEGotcLQt1t22aOD6xqBcMj4J5UU=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3017.eurprd08.prod.outlook.com (52.134.109.159) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1792.14; Thu, 11 Apr 2019 15:09:03 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1771.021;
	Thu, 11 Apr 2019 15:09:03 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
Thread-Topic: [PATCH for-4.0?] iotest: Fix 241 to run in generic directory
Thread-Index: AQHU794br5Dm4Z3L90Owhq8BvbeODqY2yt+AgABAYwCAAAX+gA==
Date: Thu, 11 Apr 2019 15:09:03 +0000
Message-ID: <22d74d69-931b-cb52-1338-fe825bd098f8@virtuozzo.com>
References: <20190410204215.5963-1-eblake@redhat.com>
	<61e3b78b-4daf-eebc-7e8b-860c57658933@virtuozzo.com>
	<111374f2-ad0c-3f81-9c51-33201c63b6c5@redhat.com>
In-Reply-To: <111374f2-ad0c-3f81-9c51-33201c63b6c5@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0323.eurprd05.prod.outlook.com
	(2603:10a6:7:92::18) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190411180901080
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4fe7cd4-1a1f-4c5d-f867-08d6be8fa281
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3017; 
x-ms-traffictypediagnostic: DB7PR08MB3017:
x-microsoft-antispam-prvs: <DB7PR08MB30171FF5B95D1BA53A455E9FC12F0@DB7PR08MB3017.eurprd08.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(346002)(376002)(366004)(396003)(39850400004)(189003)(199004)(2906002)(53936002)(68736007)(6512007)(316002)(256004)(66066001)(4326008)(110136005)(14444005)(478600001)(102836004)(53546011)(486006)(186003)(54906003)(14454004)(5660300002)(229853002)(52116002)(386003)(305945005)(36756003)(6116002)(6506007)(26005)(7736002)(71200400001)(25786009)(99286004)(31696002)(6436002)(2501003)(3846002)(6486002)(71190400001)(8936002)(6246003)(76176011)(446003)(476003)(81166006)(86362001)(8676002)(2616005)(31686004)(97736004)(105586002)(81156014)(11346002)(106356001)(41533002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3017;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sl9bEM8dVvWQpqiCDoCIiQS3j783EjqwHadFr5w0TGGOR8W3v9+M2kwL+5ds2ORcIf4TNuW2Qp7ENBK2L7UC+tyBctXK94M4UCysOO38KgYdjW7fTyX9N3kZ8F4igkOQrV97uKni2uQvefpFB19gY890xZWaBJNDAXX6BKXxzYWVfDZLsxhdl/4VP1MkkN9UqRYpTlT/qkE/RZNFTyOL17krnMJ9WhpvN0ErQYii9c0oBJI5NoJdLJFjgBA0LV9+VZkGcJsG4/ACL66ttqmYbFHUWy4nAW0jCwbsy2Rgex8Ux6W0rXn1JfhXHln3Q5aQupfImV+ozYXFxzLr1qxsOt7o4Syzqy2mqukdauiJM6D13AQ18SYY+AdCeQC5Vay5KF6IF4J3oS/KRri3/tPcM3f1W+39NVSyfgGx/0sYsXY=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <93DBA4F4E77E604F98A66BD6219CFBE2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4fe7cd4-1a1f-4c5d-f867-08d6be8fa281
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 15:09:03.7572 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3017
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.123
Subject: Re: [Qemu-devel] [PATCH for-4.0?] iotest: Fix 241 to run in generic
 directory
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411150903.T1tl8Mfy6v0hU4gpRyOERYwNjpTYY8c8FqgNwq_XLUE@z>

MTEuMDQuMjAxOSAxNzo0NywgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gNC8xMS8xOSAyOjU3IEFN
LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gMTAuMDQuMjAxOSAyMzo0
MiwgRXJpYyBCbGFrZSB3cm90ZToNCj4+PiBGaWx0ZXIgdGhlIHFlbXUtbmJkIHNlcnZlciBvdXRw
dXQgdG8gZ2V0IHJpZCBvZiBhIGRpcmVjdCByZWZlcmVuY2UNCj4+PiB0byBteSBidWlsZCBkaXJl
Y3RvcnkuDQo+Pj4NCj4+PiBGaXhlczogZTlkY2U5Y2INCj4+PiBSZXBvcnRlZC1ieTogTWF4IFJl
aXR6IDxtcmVpdHpAcmVkaGF0LmNvbT4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBFcmljIEJsYWtlIDxl
Ymxha2VAcmVkaGF0LmNvbT4NCj4+PiAtLS0NCj4+Pg0KPj4+IE5vdCB3b3J0aCAtcmM0IG9uIGl0
cyBvd24sIGJ1dCBpZiBzb21ldGhpbmcgZWxzZSBwb3BzIHVwIHRoYXQgcmVxdWlyZXMNCj4+PiBh
bm90aGVyIHNwaW4sIEkgcGxhbiBvbiBhIHB1bGwgcmVxdWVzdCBmb3IgdGhpcyBvbmUuIE90aGVy
d2lzZSBpdA0KPj4+IHNsaXBzIHRvIDQuMSwgYW5kIDQuMCBqdXN0IGhhcyBhIGJyb2tlbiBpb3Rl
c3QuDQo+Pj4NCj4gDQo+Pj4gQEAgLTY5LDEyICs3MCwxMyBAQCBlY2hvDQo+Pj4NCj4+PiAgICAj
IEludGVudGlvbmFsbHkgb21pdCAnLWYnIHRvIGZvcmNlIGltYWdlIHByb2JpbmcsIHdoaWNoIGlu
IHR1cm4gZm9yY2VzDQo+Pj4gICAgIyBzZWN0b3IgYWxpZ25tZW50LCBoZXJlIGF0IHRoZSBzZXJ2
ZXIuDQo+Pj4gLW5iZF9zZXJ2ZXJfc3RhcnRfdW5peF9zb2NrZXQgIiRURVNUX0lNR19GSUxFIg0K
Pj4+ICtuYmRfc2VydmVyX3N0YXJ0X3VuaXhfc29ja2V0ICIkVEVTVF9JTUdfRklMRSIgMj4gIiRU
RVNUX0RJUi9zZXJ2ZXIubG9nIg0KPj4+DQo+IA0KPj4+ICAgIDEgS2lCICgweDQwMCkgYnl0ZXMg
ICAgIGFsbG9jYXRlZCBhdCBvZmZzZXQgMCBieXRlcyAoMHgwKQ0KPj4+ICtXQVJOSU5HOiBJbWFn
ZSBmb3JtYXQgd2FzIG5vdCBzcGVjaWZpZWQgZm9yICdURVNUX0RJUi90LnJhdycgYW5kIHByb2Jp
bmcgZ3Vlc3NlZCByYXcuDQo+Pj4gKyAgICAgICAgIEF1dG9tYXRpY2FsbHkgZGV0ZWN0aW5nIHRo
ZSBmb3JtYXQgaXMgZGFuZ2Vyb3VzIGZvciByYXcgaW1hZ2VzLCB3cml0ZSBvcGVyYXRpb25zIG9u
IGJsb2NrIDAgd2lsbCBiZSByZXN0cmljdGVkLg0KPj4+ICsgICAgICAgICBTcGVjaWZ5IHRoZSAn
cmF3JyBmb3JtYXQgZXhwbGljaXRseSB0byByZW1vdmUgdGhlIHJlc3RyaWN0aW9ucy4NCj4+DQo+
PiBNYXkgYmUsIGp1c3QgYWRkIC1mIHJhdyB0byBuYmQgc2VydmVyLCB0byBtYWtlIHRoaXMgbWVz
c2FnZSBkaXNhcHBlYXI/IEFuZCB0aGFuLCBkb24ndCBkbyBhbnkgcmVkaXJlY3Rpb25zLCBhcyBp
ZiB0aGVyZQ0KPj4gd2lsbCBiZSBmYWlsZWQgdW5maWx0ZXJlZCBvdXRwdXQgaXQgaXMgT0s/DQo+
IA0KPiBOby4gU2VlIHRoZSBjb21tZW50IGluIHRoZSB0ZXN0IC0gaXQgaXMgaW50ZW50aW9uYWwg
dGhhdCB3ZSBhcmUgb21pdHRpbmcNCj4gLWYsIGluIHR3byBkaWZmZXJlbnQgcGxhY2VzLCBpbiBv
cmRlciB0byBnZXQgdGhyZWUgdGVzdCBzY2VuYXJpb3M6DQo+IA0KPiBub3JtYWw6IHNlcnZlciAn
LWYgcmF3JyAxLWJ5dGUgYWxpZ24sIGNsaWVudCAnLWYgcmF3JyAxLWJ5dGUgYWxpZ24NCj4gc2Vy
dmVyLWNvbnN0cmFpbmVkOiBzZXJ2ZXIgb21pdCBmb3IgNTEyLWJ5dGUgYWxpZ24sIGNsaWVudCAn
LWYgcmF3Jw0KPiBvYmV5cyBzZXJ2ZXIgYWxpZ24NCj4gY2xpZW50LWNvbnN0cmFpbmVkOiBzZXJ2
ZXIgJy1mIHJhdycgMS1ieXRlIGFsaWduLCBjbGllbnQgb21pdCBmb3INCj4gaW50ZW50aW9uYWwg
NTEyLWJ5dGUgYWxpZ24NCj4gDQo+IGluIG9yZGVyIHRvIHNob3cgYm90aCB0aGF0IHRoZSBzZXJ2
ZXIgd2l0aCBmb3JjZWQgYWxpZ25tZW50IGlzIGFibGUgdG8NCj4gcm91bmQgcmVxdWVzdHMgY29y
cmVjdGx5IGJlZm9yZSBzZW5kaW5nIHRvIHRoZSBjbGllbnQsIGFuZCB0byBzaG93IHRoYXQNCj4g
dGhlIGNsaWVudCB3aXRoIGZvcmNlZCBhbGlnbm1lbnQgaXMgYWJsZSB0byByb3VuZCByZXF1ZXN0
cyBjb3JyZWN0bHkgaW4NCj4gc3BpdGUgb2YgdGhlIHNlcnZlciBzZW5kaW5nIGFuc3dlcnMgbmFy
cm93ZXIgdGhhbiB0aGUgY2xpZW50IHdhbnRzLg0KPiANCj4gSW4gNC4xLCB3aGVuIE1heCdzIGZp
bHRlciBoYW5kbGluZyBwYXRjaGVzIGxhbmQsIGl0IHdpbGwgYmUgcG9zc2libGUgdG8NCj4gdXNl
IHRoZSBibGtkZWJ1ZyBkcml2ZXIgdG8gZm9yY2UgYWxpZ25tZW50IGluc3RlYWQgb2Ygb21pdHRp
bmcgJy1mIHJhdyc7DQo+IGF0IHdoaWNoIHBvaW50IHdlIGNhbiB0YWtlIGF3YXkgdGhlIHNlcnZl
ci5sb2cgZmlsZS4gQnV0IHVudGlsIHRoZQ0KPiBmaWx0ZXIgaGFuZGxpbmcgcGF0Y2hlcyBsYW5k
LCBhbnkgdXNlIG9mIGJsa2RlYnVnIGNhdXNlcyBvZGQgdGVzdA0KPiBtaXNiZWhhdmlvcnMgYmVj
YXVzZSBub3QgZXZlcnl0aGluZyBpbiB0aGUgYmxvY2sgbGF5ZXIgcHJvcGVybHkgc2Vlcw0KPiB0
aHJvdWdoIGZpbHRlciBub2Rlcy4NCj4gDQoNClVuZGVyc3RhbmQgbm93LCB0aGFua3MuDQoNClJl
dmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1
b3p6by5jb20+DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

