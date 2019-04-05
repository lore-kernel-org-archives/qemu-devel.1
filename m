Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7CAC4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 14:45:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D90CC21726
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 14:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="D2yKqAWu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90CC21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42975 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCQ5o-0002jY-J0
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 10:45:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hCQ3y-0000at-V8
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 10:43:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hCQ0T-0000oY-0y
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 10:39:50 -0400
Received: from mail-eopbgr60136.outbound.protection.outlook.com
	([40.107.6.136]:18049
	helo=EUR04-DB3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hCQ0Q-0000l0-PD; Fri, 05 Apr 2019 10:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=R04XMNYNToUk7+Sqr7Yx+55Jrrsa5QeQXLtCGS3q3SU=;
	b=D2yKqAWu7n9P2iB2hZSEz2NjHunnaAb/3IFTX7GkA+iBKk8qlbvUVCCsWiNicior7wVetEtXrQ42I47J8redmG9qBBl0hwsoj/YF21Oqm21xO4vl+21UZG5Ch3nk3NA/eT5FfkucB0qdarx9KNRXrQoRT0JI53NBu+YegR33GXY=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3402.eurprd08.prod.outlook.com (20.176.238.95) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.13; Fri, 5 Apr 2019 14:39:44 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%2]) with mapi id 15.20.1750.017;
	Fri, 5 Apr 2019 14:39:44 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
Thread-Topic: [PATCH 2/7] nbd/server: Trace server noncompliance on unaligned
	requests
Thread-Index: AQHU6cocegMEUkn+302xS4dmtchABqYtpzmA
Date: Fri, 5 Apr 2019 14:39:43 +0000
Message-ID: <ae484c62-04f9-5b4e-03d0-bf368ed7714a@virtuozzo.com>
References: <20190403030526.12258-1-eblake@redhat.com>
	<20190403030526.12258-3-eblake@redhat.com>
In-Reply-To: <20190403030526.12258-3-eblake@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR02CA0103.eurprd02.prod.outlook.com
	(2603:10a6:7:29::32) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190405173941590
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56e3fbe6-44b2-4047-1f6c-08d6b9d48b14
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3402; 
x-ms-traffictypediagnostic: DB7PR08MB3402:
x-microsoft-antispam-prvs: <DB7PR08MB340241E1BDC2CE6ED1740B5CC1510@DB7PR08MB3402.eurprd08.prod.outlook.com>
x-forefront-prvs: 0998671D02
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39850400004)(396003)(366004)(346002)(136003)(376002)(189003)(52314003)(199004)(2616005)(54906003)(6436002)(316002)(110136005)(68736007)(8936002)(81166006)(36756003)(6116002)(3846002)(66066001)(8676002)(6486002)(2906002)(71190400001)(71200400001)(102836004)(5660300002)(229853002)(81156014)(25786009)(31686004)(106356001)(14444005)(99286004)(256004)(105586002)(186003)(4326008)(7736002)(14454004)(6506007)(305945005)(386003)(97736004)(2501003)(31696002)(486006)(86362001)(476003)(6512007)(52116002)(26005)(11346002)(478600001)(6246003)(446003)(53936002)(76176011);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3402;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: catUouWMdkId3cynTO5VbOIAwT0HT0FcQzFR9JvDPnGoluLKXwYxgQs0Gnx3t7MVQukV//VXE5l+5lZoSoTrl46k356hQdy7Tr0CicAB84lrxAITEEVoUDya2daJRC2Vyr9sQPSrqZLkOZctvteJz1lZaC2i43rUNU5YE3PeF76DV85nxUAbFDgVeqxtV5jrtVxVCaupxaKFr+47Av22S1L2o7zC3Gy3T6B+cNT2aoT6wRdJ0TAgD2LzI+VbiJ0DjAN1kJPcav8QvLQznO7kSxxc4x3Bn5vCn0q1qTAUGKp6pfzjT/6VS6Z/KmEta3ad2csByTd6xuPeIm1UuprD4sVXczKFRfIK21uV1gSDUHaajghbQ+m+HZcLm0atby7SC2P7GJCcVprVbEQi4rPXZnT4L3GXShV3j66xckGityk=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <B984F6CDB7A1DF4F87B43CEEC859CA71@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e3fbe6-44b2-4047-1f6c-08d6b9d48b14
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2019 14:39:44.0843 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3402
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.136
Subject: Re: [Qemu-devel] [PATCH 2/7] nbd/server: Trace server noncompliance
 on unaligned requests
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
Cc: "jsnow@redhat.com" <jsnow@redhat.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405143943.UNF7cQ9_kLJe4V8HKkmWHgmNLgqNzfluPnom22ONpxs@z>

MDMuMDQuMjAxOSA2OjA1LCBFcmljIEJsYWtlIHdyb3RlOg0KPiBXZSd2ZSByZWNlbnRseSBhZGRl
ZCB0cmFjZXMgZm9yIGNsaWVudHMgdG8gZmxhZyBzZXJ2ZXIgbm9uLWNvbXBsaWFuY2U7DQo+IGxl
dCdzIGRvIHRoZSBzYW1lIGZvciBzZXJ2ZXJzIHRvIGZsYWcgY2xpZW50IG5vbi1jb21wbGlhbmNl
LiBBY2NvcmRpbmcNCj4gdG8gdGhlIHNwZWMsIGlmIHRoZSBjbGllbnQgcmVxdWVzdHMgTkJEX0lO
Rk9fQkxPQ0tfU0laRSwgaXQgaXMNCj4gcHJvbWlzaW5nIHRvIHNlbmQgYWxsIHJlcXVlc3RzIGFs
aWduZWQgdG8gdGhvc2UgYm91bmRhcmllcy4gIE9mDQo+IGNvdXJzZSwgaWYgdGhlIGNsaWVudCBk
b2VzIG5vdCByZXF1ZXN0IE5CRF9JTkZPX0JMT0NLX1NJWkUsIHRoZW4gaXQNCj4gbWFkZSBubyBw
cm9taXNlcyBzbyB3ZSBzaG91bGRuJ3QgZmxhZyBhbnl0aGluZzsgYW5kIGJlY2F1c2Ugd2UgYXJl
DQo+IHdpbGxpbmcgdG8gaGFuZGxlIGNsaWVudHMgdGhhdCBtYWRlIG5vIHByb21pc2VzICh0aGUg
c3BlYyBhbGxvd3MgdXMgdG8NCj4gdXNlIE5CRF9SRVBfRVJSX0JMT0NLX1NJWkVfUkVRRCBpZiB3
ZSBoYWQgYmVlbiB1bndpbGxpbmcpLCB3ZSBhbHJlYWR5DQo+IGhhdmUgdG8gaGFuZGxlIHVuYWxp
Z25lZCByZXF1ZXN0cyAod2hpY2ggdGhlIGJsb2NrIGxheWVyIGFscmVhZHkgZG9lcw0KPiBvbiBv
dXIgYmVoYWxmKS4gIFNvIGV2ZW4gdGhvdWdoIHRoZSBzcGVjIGFsbG93cyB1cyB0byByZXR1cm4g
RUlOVkFMDQo+IGZvciBjbGllbnRzIHRoYXQgcHJvbWlzZWQgdG8gYmVoYXZlLCBpdCdzIGVhc2ll
ciB0byBhbHdheXMgYW5zd2VyDQo+IHVuYWxpZ25lZCByZXF1ZXN0cy4gIFN0aWxsLCBmbGFnZ2lu
ZyBub24tY29tcGxpYW5jZSBjYW4gYmUgdXNlZnVsIGluDQo+IGRlYnVnZ2luZyBhIGNsaWVudCB0
aGF0IGlzIHRyeWluZyB0byBiZSBtYXhpbWFsbHkgcG9ydGFibGUuDQo+IA0KPiBRZW11IGFzIGNs
aWVudCB1c2VkIHRvIGhhdmUgb25lIHNwb3Qgd2hlcmUgaXQgc2VudCBub24tY29tcGxpYW50DQo+
IHJlcXVlc3RzOiBpZiB0aGUgc2VydmVyIHNlbmRzIGFuIHVuYWxpZ25lZCByZXBseSB0bw0KPiBO
QkRfQ01EX0JMT0NLX1NUQVRVUywgYW5kIHRoZSBjbGllbnQgd2FzIGl0ZXJhdGluZyBvdmVyIHRo
ZSBlbnRpcmUNCj4gZGlzaywgdGhlIG5leHQgcmVxdWVzdCB3b3VsZCBzdGFydCBhdCB0aGF0IHVu
YWxpZ25lZCBwb2ludDsgdGhpcyB3YXMNCj4gZml4ZWQgaW4gY29tbWl0IGEzOTI4NmRkIHdoZW4g
dGhlIGNsaWVudCB3YXMgdGF1Z2h0IHRvIHdvcmsgYXJvdW5kDQo+IHNlcnZlciBub24tY29tcGxp
YW5jZTsgYnV0IGlzIGVxdWFsbHkgZml4ZWQgaWYgdGhlIHNlcnZlciBpcyBwYXRjaGVkDQo+IHRv
IG5vdCBzZW5kIHVuYWxpZ25lZCByZXBsaWVzIGluIHRoZSBmaXJzdCBwbGFjZSAodGhlIG5leHQg
ZmV3IHBhdGNoZXMNCj4gd2lsbCBhZGRyZXNzIHRoYXQpLiBGb3J0dW5hdGVseSwgSSBkaWQgbm90
IGZpbmQgYW55IG1vcmUgc3BvdHMgd2hlcmUNCj4gcWVtdSBhcyBjbGllbnQgd2FzIG5vbi1jb21w
bGlhbnQuIEkgd2FzIGFibGUgdG8gdGVzdCB0aGUgcGF0Y2ggYnkNCj4gdXNpbmcgdGhlIGZvbGxv
d2luZyBoYWNrIHRvIGNvbnZpbmNlIHFlbXUtaW8gdG8gcnVuIHZhcmlvdXMgdW5hbGlnbmVkDQo+
IGNvbW1hbmRzLCBjb3VwbGVkIHdpdGggc2VydmluZyA1MTItYnl0ZSBhbGlnbm1lbnQgYnkgaW50
ZW50aW9uYWxseQ0KPiBvbWl0dGluZyAnLWYgcmF3JyBvbiB0aGUgc2VydmVyIHdoaWxlIHZpZXdp
bmcgc2VydmVyIHRyYWNlcy4NCj4gDQo+IHwgZGlmZiAtLWdpdCBpL25iZC9jbGllbnQuYyB3L25i
ZC9jbGllbnQuYw0KPiB8IGluZGV4IDQyNzk4MGJkZDIyLi4xODU4YjJhYWMzNSAxMDA2NDQNCj4g
fCAtLS0gaS9uYmQvY2xpZW50LmMNCj4gfCArKysgdy9uYmQvY2xpZW50LmMNCj4gfCBAQCAtNDQ5
LDYgKzQ0OSw3IEBAIHN0YXRpYyBpbnQgbmJkX29wdF9pbmZvX29yX2dvKFFJT0NoYW5uZWwgKmlv
YywgdWludDMyX3Qgb3B0LA0KPiB8ICAgICAgICAgICAgICAgICAgbmJkX3NlbmRfb3B0X2Fib3J0
KGlvYyk7DQo+IHwgICAgICAgICAgICAgICAgICByZXR1cm4gLTE7DQo+IHwgICAgICAgICAgICAg
IH0NCj4gfCArICAgICAgICAgICAgaW5mby0+bWluX2Jsb2NrID0gMTsvL2hhY2sNCj4gfCAgICAg
ICAgICAgICAgaWYgKCFpc19wb3dlcl9vZl8yKGluZm8tPm1pbl9ibG9jaykpIHsNCj4gfCAgICAg
ICAgICAgICAgICAgIGVycm9yX3NldGcoZXJycCwgInNlcnZlciBtaW5pbXVtIGJsb2NrIHNpemUg
JSIgUFJJdTMyDQo+IHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICIgaXMgbm90IGEgcG93
ZXIgb2YgdHdvIiwgaW5mby0+bWluX2Jsb2NrKTsNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEVyaWMg
Qmxha2UgPGVibGFrZUByZWRoYXQuY29tPg0KPiAtLS0NCj4gICBuYmQvc2VydmVyLmMgICAgIHwg
MTIgKysrKysrKysrKysrDQo+ICAgbmJkL3RyYWNlLWV2ZW50cyB8ICAxICsNCj4gICAyIGZpbGVz
IGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9uYmQvc2VydmVy
LmMgYi9uYmQvc2VydmVyLmMNCj4gaW5kZXggMWI4Yzg2MTk4OTYuLjMwNDBjZWI1NjA2IDEwMDY0
NA0KPiAtLS0gYS9uYmQvc2VydmVyLmMNCj4gKysrIGIvbmJkL3NlcnZlci5jDQo+IEBAIC0xMjQs
NiArMTI0LDggQEAgc3RydWN0IE5CRENsaWVudCB7DQo+ICAgICAgIGludCBuYl9yZXF1ZXN0czsN
Cj4gICAgICAgYm9vbCBjbG9zaW5nOw0KPiANCj4gKyAgICB1aW50MzJfdCBjaGVja19hbGlnbjsg
LyogSWYgbm9uLXplcm8sIGNoZWNrIGZvciBhbGlnbmVkIGNsaWVudCByZXF1ZXN0cyAqLw0KPiAr
DQo+ICAgICAgIGJvb2wgc3RydWN0dXJlZF9yZXBseTsNCj4gICAgICAgTkJERXhwb3J0TWV0YUNv
bnRleHRzIGV4cG9ydF9tZXRhOw0KPiANCj4gQEAgLTY2MCw2ICs2NjIsOCBAQCBzdGF0aWMgaW50
IG5iZF9uZWdvdGlhdGVfaGFuZGxlX2luZm8oTkJEQ2xpZW50ICpjbGllbnQsIHVpbnQxNl90IG15
ZmxhZ3MsDQo+IA0KPiAgICAgICBpZiAoY2xpZW50LT5vcHQgPT0gTkJEX09QVF9HTykgew0KPiAg
ICAgICAgICAgY2xpZW50LT5leHAgPSBleHA7DQo+ICsgICAgICAgIGNsaWVudC0+Y2hlY2tfYWxp
Z24gPSBibG9ja3NpemUgPw0KPiArICAgICAgICAgICAgYmxrX2dldF9yZXF1ZXN0X2FsaWdubWVu
dChleHAtPmJsaykgOiAwOw0KDQpJIHRoaW5rIGJldHRlciBzZXQgaW4gc2FtZSBwbGFjZSwgd2hl
cmUgc2l6ZXNbMF0gc2V0LCBvciB1c2Ugc2l6ZXNbMF0gaGVyZSBvciBhZGQgc2VwYXJhdGUgbG9j
YWwNCnZhcmliYWxlIGZvciBpdCwgc28gdGhhdCwgaWYgInNpemVzWzBdID0iIGNoYW5nZXMgc29t
ZWhvdywgd2Ugd2lsbCBub3QgZm9yZ2V0IHRvIGZpeCB0aGlzIHBsYWNlIHRvby4NCg0KPiAgICAg
ICAgICAgUVRBSUxRX0lOU0VSVF9UQUlMKCZjbGllbnQtPmV4cC0+Y2xpZW50cywgY2xpZW50LCBu
ZXh0KTsNCj4gICAgICAgICAgIG5iZF9leHBvcnRfZ2V0KGNsaWVudC0+ZXhwKTsNCj4gICAgICAg
ICAgIG5iZF9jaGVja19tZXRhX2V4cG9ydChjbGllbnQpOw0KPiBAQCAtMjEyNiw2ICsyMTMwLDE0
IEBAIHN0YXRpYyBpbnQgbmJkX2NvX3JlY2VpdmVfcmVxdWVzdChOQkRSZXF1ZXN0RGF0YSAqcmVx
LCBOQkRSZXF1ZXN0ICpyZXF1ZXN0LA0KPiAgICAgICAgICAgcmV0dXJuIChyZXF1ZXN0LT50eXBl
ID09IE5CRF9DTURfV1JJVEUgfHwNCj4gICAgICAgICAgICAgICAgICAgcmVxdWVzdC0+dHlwZSA9
PSBOQkRfQ01EX1dSSVRFX1pFUk9FUykgPyAtRU5PU1BDIDogLUVJTlZBTDsNCj4gICAgICAgfQ0K
PiArICAgIGlmIChjbGllbnQtPmNoZWNrX2FsaWduICYmICFRRU1VX0lTX0FMSUdORUQocmVxdWVz
dC0+ZnJvbSB8IHJlcXVlc3QtPmxlbiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGNsaWVudC0+Y2hlY2tfYWxpZ24pKSB7DQo+ICsgICAgICAgIC8q
DQo+ICsgICAgICAgICAqIFRoZSBibG9jayBsYXllciBncmFjZWZ1bGx5IGhhbmRsZXMgdW5hbGln
bmVkIHJlcXVlc3RzLCBidXQNCj4gKyAgICAgICAgICogaXQncyBzdGlsbCB3b3J0aCB0cmFjaW5n
IGNsaWVudCBub24tY29tcGxpYW5jZQ0KPiArICAgICAgICAgKi8NCj4gKyAgICAgICAgdHJhY2Vf
bmJkX2NvX3JlY2VpdmVfYWxpZ25fY29tcGxpYW5jZShuYmRfY21kX2xvb2t1cChyZXF1ZXN0LT50
eXBlKSk7DQo+ICsgICAgfQ0KPiAgICAgICB2YWxpZF9mbGFncyA9IE5CRF9DTURfRkxBR19GVUE7
DQo+ICAgICAgIGlmIChyZXF1ZXN0LT50eXBlID09IE5CRF9DTURfUkVBRCAmJiBjbGllbnQtPnN0
cnVjdHVyZWRfcmVwbHkpIHsNCj4gICAgICAgICAgIHZhbGlkX2ZsYWdzIHw9IE5CRF9DTURfRkxB
R19ERjsNCj4gZGlmZiAtLWdpdCBhL25iZC90cmFjZS1ldmVudHMgYi9uYmQvdHJhY2UtZXZlbnRz
DQo+IGluZGV4IGE2Y2NhOGZkZjgzLi44N2EyYjg5NmMzNSAxMDA2NDQNCj4gLS0tIGEvbmJkL3Ry
YWNlLWV2ZW50cw0KPiArKysgYi9uYmQvdHJhY2UtZXZlbnRzDQo+IEBAIC03MSw0ICs3MSw1IEBA
IG5iZF9jb19zZW5kX2V4dGVudHModWludDY0X3QgaGFuZGxlLCB1bnNpZ25lZCBpbnQgZXh0ZW50
cywgdWludDMyX3QgaWQsIHVpbnQ2NF90DQo+ICAgbmJkX2NvX3NlbmRfc3RydWN0dXJlZF9lcnJv
cih1aW50NjRfdCBoYW5kbGUsIGludCBlcnIsIGNvbnN0IGNoYXIgKmVycm5hbWUsIGNvbnN0IGNo
YXIgKm1zZykgIlNlbmQgc3RydWN0dXJlZCBlcnJvciByZXBseTogaGFuZGxlID0gJSIgUFJJdTY0
ICIsIGVycm9yID0gJWQgKCVzKSwgbXNnID0gJyVzJyINCj4gICBuYmRfY29fcmVjZWl2ZV9yZXF1
ZXN0X2RlY29kZV90eXBlKHVpbnQ2NF90IGhhbmRsZSwgdWludDE2X3QgdHlwZSwgY29uc3QgY2hh
ciAqbmFtZSkgIkRlY29kaW5nIHR5cGU6IGhhbmRsZSA9ICUiIFBSSXU2NCAiLCB0eXBlID0gJSIg
UFJJdTE2ICIgKCVzKSINCj4gICBuYmRfY29fcmVjZWl2ZV9yZXF1ZXN0X3BheWxvYWRfcmVjZWl2
ZWQodWludDY0X3QgaGFuZGxlLCB1aW50MzJfdCBsZW4pICJQYXlsb2FkIHJlY2VpdmVkOiBoYW5k
bGUgPSAlIiBQUkl1NjQgIiwgbGVuID0gJSIgUFJJdTMyDQo+ICtuYmRfY29fcmVjZWl2ZV9hbGln
bl9jb21wbGlhbmNlKGNvbnN0IGNoYXIgKm9wKSAiY2xpZW50IHNlbnQgbm9uLWNvbXBsaWFudCB1
bmFsaWduZWQgJXMgcmVxdWVzdCINCg0KRG9uJ3QgeW91IHdhbnQgcHJpbnQgcmVxdWVzdC0+ZnJv
bSwgcmVxdWVzdC0+bGVuIGFuZCBjbGllbnQtPmNoZWNrX2FsaWduIGFzIHdlbGw/DQoNCj4gICBu
YmRfdHJpcCh2b2lkKSAiUmVhZGluZyByZXF1ZXN0Ig0KPiANCg0KUGF0Y2ggc2VlbXMgY29ycmVj
dCBhbnl3YXksIHNvIGlmIHlvdSBhcmUgaW4gYSBodXJyeSwgaXQncyBPSyBhcyBpczoNCg0KUmV2
aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVv
enpvLmNvbT4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

