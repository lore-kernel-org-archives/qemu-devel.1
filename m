Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF92EC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:10:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A52021721
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="C03h/TMu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A52021721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39604 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbPUR-0005RA-SC
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 09:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60654)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbOfB-0000dE-8p
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:17:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbOeu-00064r-5U
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:16:57 -0400
Received: from mail-eopbgr00108.outbound.protection.outlook.com
 ([40.107.0.108]:43230 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbOer-0005Bh-Pw; Thu, 13 Jun 2019 08:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZtZ6aHY1vSLlYfII9DDgIU5cQLEvb2XPQbTNZP/OMk=;
 b=C03h/TMuAGaZSxhfKPzQxUvb7mHwpwniBXROoJFhGcjdrmFRESGLdvfUP61gYvnNzodWcGobSPgJEKW57yLsZhlp8bfcmfLm9XEVl5xLOxj9rZquXs9cT7iqLiqkKGa3EMvmu1Gvq5eWkHarl9Q4Dr1rlEfOFpvU3CG2iqpO0Pg=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB3603.eurprd08.prod.outlook.com (20.177.110.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.15; Thu, 13 Jun 2019 12:15:47 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 12:15:47 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 04/42] block: Add child access functions
Thread-Index: AQHVIWugG29CXMAlvEKCKo/fgntRwaaZgJyA
Date: Thu, 13 Jun 2019 12:15:47 +0000
Message-ID: <9a439527-d651-7638-1b80-c75f5ba69592@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-5-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-5-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0306.eurprd05.prod.outlook.com
 (2603:10a6:7:93::37) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190613151545634
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b899b8b-2000-4621-2fc9-08d6eff8dde5
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB3603; 
x-ms-traffictypediagnostic: AM0PR08MB3603:
x-microsoft-antispam-prvs: <AM0PR08MB360341B7ACBAB89C056DB0C6C1EF0@AM0PR08MB3603.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(366004)(376002)(39850400004)(346002)(189003)(199004)(486006)(3846002)(26005)(71200400001)(316002)(6436002)(11346002)(110136005)(36756003)(102836004)(71190400001)(305945005)(99286004)(7736002)(446003)(54906003)(186003)(5660300002)(86362001)(476003)(2616005)(14454004)(6506007)(386003)(2906002)(25786009)(6116002)(4326008)(31696002)(66556008)(73956011)(81156014)(66446008)(76176011)(52116002)(66946007)(64756008)(6512007)(229853002)(66066001)(8676002)(31686004)(66476007)(478600001)(14444005)(53936002)(6486002)(256004)(8936002)(2501003)(81166006)(6246003)(68736007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3603;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KanvNl3oEsdHzW5baWOn4Ie60vkSDYHSJsm38+9UTvHOyMEQPbqHajqFFg0aUilbIG74c1UX8LF9KQekLsXW4yaecz30OInQib0Ag5b3ErWbrIMCgFnTF/95r9I1G3tzDIS1jhdU9SYdExGUM9IXugB2SZb8mRWZ9EpEIWNAJtCGGpLFXwGlZ91mVvoO+wxsxwYnbfeDqHmMep+nNH6ce4QueQh+QVvoCTBNfmc3Q+y82KoBM+Cjvaiht1t+n665fBlwEANtmKHHfZyvDdt3IdNws8PrrTNvcL2x4idNPJ1xfiooPorI7elcR4ysMzHCQwvuc4zn9obl7jeXd3mNrcFNujcKUuXMTnYrjXczSXdY4pjgtUAGAM6VDjDBplDBvKnw6osFZAXy6QWUuPNzEgyUVBYRq/b4WH1o6KFjlUg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A977858470C845458187CB4C748AC2EF@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b899b8b-2000-4621-2fc9-08d6eff8dde5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 12:15:47.6134 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3603
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.108
Subject: Re: [Qemu-devel] [PATCH v5 04/42] block: Add child access functions
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

MTMuMDYuMjAxOSAxOjA5LCBNYXggUmVpdHogd3JvdGU6DQo+IFRoZXJlIGFyZSBCRFMgY2hpbGRy
ZW4gdGhhdCB0aGUgZ2VuZXJhbCBibG9jayBsYXllciBjb2RlIGNhbiBhY2Nlc3MsDQo+IG5hbWVs
eSBicy0+ZmlsZSBhbmQgYnMtPmJhY2tpbmcuICBTaW5jZSB0aGUgaW50cm9kdWN0aW9uIG9mIGZp
bHRlcnMgYW5kDQo+IGV4dGVybmFsIGRhdGEgZmlsZXMsIHRoZWlyIG1lYW5pbmcgaXMgbm90IHF1
aXRlIGNsZWFyLiAgYnMtPmJhY2tpbmcgY2FuDQo+IGJlIGEgQ09XIHNvdXJjZSwgb3IgaXQgY2Fu
IGJlIGFuIFIvVy1maWx0ZXJlZCBjaGlsZDsgYnMtPmZpbGUgY2FuIGJlIGFuDQo+IFIvVy1maWx0
ZXJlZCBjaGlsZCwgaXQgY2FuIGJlIGRhdGEgYW5kIG1ldGFkYXRhIHN0b3JhZ2UsIG9yIGl0IGNh
biBiZQ0KPiBqdXN0IG1ldGFkYXRhIHN0b3JhZ2UuDQo+IA0KPiBUaGlzIG92ZXJsb2FkaW5nIHJl
YWxseSBpcyBub3QgaGVscGZ1bC4gIFRoaXMgcGF0Y2ggYWRkcyBmdW5jdGlvbiB0aGF0DQo+IHJl
dHJpZXZlIHRoZSBjb3JyZWN0IGNoaWxkIGZvciBlYWNoIGV4YWN0IHB1cnBvc2UuICBMYXRlciBw
YXRjaGVzIGluDQo+IHRoaXMgc2VyaWVzIHdpbGwgbWFrZSB1c2Ugb2YgdGhlbS4gIERvaW5nIHNv
IHdpbGwgYWxsb3cgdXMgdG8gaGFuZGxlDQo+IGZpbHRlciBub2RlcyBhbmQgZXh0ZXJuYWwgZGF0
YSBmaWxlcyBpbiBhIG1lYW5pbmdmdWwgd2F5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWF4IFJl
aXR6IDxtcmVpdHpAcmVkaGF0LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNv
di1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KPiAtLS0NCj4gICBpbmNs
dWRlL2Jsb2NrL2Jsb2NrX2ludC5oIHwgNTcgKysrKysrKysrKysrKysrKysrKystLQ0KPiAgIGJs
b2NrLmMgICAgICAgICAgICAgICAgICAgfCA5OSArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4gICAyIGZpbGVzIGNoYW5nZWQsIDE1MyBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvYmxvY2svYmxvY2tfaW50Lmgg
Yi9pbmNsdWRlL2Jsb2NrL2Jsb2NrX2ludC5oDQo+IGluZGV4IDU4ZmNhMzdiYTMuLjdjZTcxNjIz
ZjggMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvYmxvY2svYmxvY2tfaW50LmgNCj4gKysrIGIvaW5j
bHVkZS9ibG9jay9ibG9ja19pbnQuaA0KDQpbLi5dDQoNCj4gICANCj4gICB0eXBlZGVmIHN0cnVj
dCBCbG9ja0xpbWl0cyB7DQo+IEBAIC0xMjQ5LDQgKzEyNTgsNDYgQEAgaW50IGNvcm91dGluZV9m
biBiZHJ2X2NvX2NvcHlfcmFuZ2VfdG8oQmRydkNoaWxkICpzcmMsIHVpbnQ2NF90IHNyY19vZmZz
ZXQsDQo+ICAgDQo+ICAgaW50IHJlZnJlc2hfdG90YWxfc2VjdG9ycyhCbG9ja0RyaXZlclN0YXRl
ICpicywgaW50NjRfdCBoaW50KTsNCj4gICANCj4gK0JkcnZDaGlsZCAqYmRydl9maWx0ZXJlZF9j
b3dfY2hpbGQoQmxvY2tEcml2ZXJTdGF0ZSAqYnMpOw0KPiArQmRydkNoaWxkICpiZHJ2X2ZpbHRl
cmVkX3J3X2NoaWxkKEJsb2NrRHJpdmVyU3RhdGUgKmJzKTsNCj4gK0JkcnZDaGlsZCAqYmRydl9m
aWx0ZXJlZF9jaGlsZChCbG9ja0RyaXZlclN0YXRlICpicyk7DQo+ICtCZHJ2Q2hpbGQgKmJkcnZf
bWV0YWRhdGFfY2hpbGQoQmxvY2tEcml2ZXJTdGF0ZSAqYnMpOw0KPiArQmRydkNoaWxkICpiZHJ2
X3N0b3JhZ2VfY2hpbGQoQmxvY2tEcml2ZXJTdGF0ZSAqYnMpOw0KPiArQmRydkNoaWxkICpiZHJ2
X3ByaW1hcnlfY2hpbGQoQmxvY2tEcml2ZXJTdGF0ZSAqYnMpOw0KPiArDQoNCldvdyEgU3VjaCBh
IGJpZyBmYW1pbHkgOikNCg0KSSdkIGxpa2UgdG8gcHV0IHRoZW0gaW50byBhIHRhYmxlLCBqdXN0
IGZvciBtZSB0byBtYWtlIGl0IGVhc2llciB0byBrZWVwIGl0IGFsbCBpbiBtaW5kLg0KQnV0IGlm
IHlvdSB3YW50LCB5b3UgbWF5IGluY2x1ZGUgaXQgaGVyZSBhcyBhIGNvbW1lbnQuLiBCdXQgaXQn
cyBkaWZmaWN1bHQgdG8ga2VlcCBpdCBsZXNzIHRoYW4gODAgY29sdW1ucy4NCkkgdGhpbmssIEkn
bGwgbW9kaWZ5IGl0IGFmdGVyIHJldmlld2luZyBmb2xsb3dpbmcgcGF0Y2hlcy4NCg0KKy0tLS0t
LS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKw0KfCBj
aGlsZCAgICAgICAgICAgICAgfCBkZXNjcmlwdGlvbiAgICAgICAgICAgICAgICB8IGZpbHRlciBu
b2RlICAgICAgICAgICAgICAgICAgIHwgZm9ybWF0IG5vZGUgICAgICAgICAgICAgICAgICAgfA0K
Ky0tLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
Kw0KfCBmaWx0ZXJlZF9jb3dfY2hpbGQgfCBmb3IgQ09XL0NPUiAgICAgICAgICAgICAgICB8IE5V
TEwgICAgICAgICAgICAgICAgICAgICAgICAgIHwgYnMtPmJhY2tpbmcgICAgICAgICAgICAgICAg
ICAgfA0KKy0tLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0r
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tKw0KfCBmaWx0ZXJlZF9yd19jaGlsZCAgfCBmb3IgSU8gcGFzcy10aHJvdWdoICAgICAg
ICB8IGJzLT5iYWNraW5nIG9yIGJzLT5maWxlICAgICAgIHwgTlVMTCAgICAgICAgICAgICAgICAg
ICAgICAgICAgfA0KfCAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8IChvbmx5IG9uZSBtYXkgZXhpc3QpICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfA0KKy0tLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tKw0KfCBmaWx0ZXJlZF9jaGlsZCAgICAgfCBvbmUgb2YgdGhlIHByZXZp
b3VzICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfA0KfCAgICAgICAgICAgICAgICAgICAgfCBmb3IgZXh0ZW5kZWQg
YmFja2luZyAgICAgICB8IGZpbHRlcmVkX3J3X2NoaWxkICAgICAgICAgICAgIHwgZmlsdGVyZWRf
Y293X2NoaWxkICAgICAgICAgICAgfA0KfCAgICAgICAgICAgICAgICAgICAgfCBjaGFpbiAgICAg
ICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfA0KKy0tLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSstLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKw0KfCBtZXRhZGF0YV9jaGlsZCAgICAgfCB3aGVy
ZSBtZXRhZGF0YSBpcyBzdG9yZWQgICB8IE5VTEwgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
YnMtPmZpbGUgICAgICAgICAgICAgICAgICAgICAgfA0KKy0tLS0tLS0tLS0tLS0tLS0tLS0tKy0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKw0KfCBzdG9yYWdlX2NoaWxkICAgICAg
fCB3aGVyZSBhY3R1YWwgZ3Vlc3QgdmlzaWJsZSB8IGJzLT5kcnYtPmJkcnZfc3RvcmFnZV9jaGls
ZCgpIHwgYnMtPmRydi0+YmRydl9zdG9yYWdlX2NoaWxkKCkgfA0KfCAgICAgICAgICAgICAgICAg
ICAgfCBkYXRhIGlzIHN0b3JlZCAgICAgICAgICAgICB8IG9yIGZpbHRlcmVkX3J3X2NoaWxkICAg
ICAgICAgIHwgb3IgYnMtPmZpbGUgICAgICAgICAgICAgICAgICAgfA0KKy0tLS0tLS0tLS0tLS0t
LS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKw0KfCBwcmltYXJ5X2No
aWxkICAgICAgfCBkb24ndCBrbm93IHlldCAgICAgICAgICAgICB8IGZpbHRlcmVkX3J3X2NoaWxk
ICAgICAgICAgICAgIHwgYnMtPmZpbGUgICAgICAgICAgICAgICAgICAgICAgfA0KKy0tLS0tLS0t
LS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKw0KDQoNCg0K
DQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

