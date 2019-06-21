Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B351AC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 09:03:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75BEA20673
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 09:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fS7LZjZx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75BEA20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55692 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heFSP-0002xk-Kk
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 05:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59817)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1heF71-0001Br-1M
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 04:41:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1heF6z-0005Q3-QE
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 04:41:34 -0400
Received: from mail-vi1eur04on0724.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::724]:50817
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1heF6p-0005Fn-94; Fri, 21 Jun 2019 04:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxMPS5PecmJNuVEtxxCLxflvi8G5pi3RFjYr5j+z6/8=;
 b=fS7LZjZxVP1r+gLXeUSyJ5l1vgwirqK44yALUkGBxmnsBbT+S8NbkwZk/xFU064wIkTqSI0DcCax+xRrNYrKSyUwhql6t6NSSTTSH4RUTpuXtslMGBAFzZejwHypBBzZVGc8xNeKCGilSEqzE0Ti5ZaAgA7joYp9w/OH4ymTpck=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB4282.eurprd08.prod.outlook.com (20.179.41.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Fri, 21 Jun 2019 08:41:19 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 08:41:18 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH] blockjob: drain all job nodes in block_job_drain
Thread-Index: AQHVJq2Qv1l+IE09A0SjYLbDaaMnV6ajLTGAgAKfoQA=
Date: Fri, 21 Jun 2019 08:41:18 +0000
Message-ID: <3316404f-cfc7-6fdc-4427-1bb06d559f01@virtuozzo.com>
References: <20190619144447.215894-1-vsementsov@virtuozzo.com>
 <94df77c0-c44a-49c8-ab16-6a637c55088c@redhat.com>
In-Reply-To: <94df77c0-c44a-49c8-ab16-6a637c55088c@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0502CA0010.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::20) To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190621114116655
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 859af60a-e847-41f2-5db6-08d6f6243ae9
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4282; 
x-ms-traffictypediagnostic: DBBPR08MB4282:
x-microsoft-antispam-prvs: <DBBPR08MB4282FFFF1E5F76F23F52E9A7C1E70@DBBPR08MB4282.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(346002)(39840400004)(376002)(396003)(189003)(199004)(53754006)(229853002)(81156014)(53936002)(66066001)(6246003)(26005)(36756003)(6486002)(316002)(5024004)(71200400001)(66946007)(53546011)(11346002)(2201001)(14454004)(478600001)(446003)(6506007)(99286004)(66556008)(6436002)(2616005)(64756008)(486006)(386003)(52116002)(476003)(66476007)(71190400001)(76176011)(5660300002)(6116002)(186003)(102836004)(25786009)(86362001)(6512007)(66446008)(73956011)(2501003)(68736007)(3846002)(81166006)(54906003)(8676002)(31686004)(2906002)(110136005)(305945005)(256004)(8936002)(7736002)(4326008)(31696002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4282;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: G/rRWFo5lHUjBr2j5uz2B1Ob/r+Aby3QiS5pQyHLPf1PhDPzsXV90Tvjy1M8n30/nJe3AyDbs/+m0iG87WG0+z2jGX40OKbvJVmZ0teGsz02XiwVggEvRS0ynmFOdh25JjB+ivHslOO+tl6Y5J3irWigaqX6F+9o5NUtOBplIFgG47fJX/Di7oG0CSjAtXC2YrurtS7ndKwdwhwulGv9XMcLypK9kwLkrSn1Kek0REnF65GbNmRrPeV6M4HH6jCCVNiNUQMg7Y0mJN9Q6e2dTRHjblfqqdy1fa27e6XJkVNRXLd5HkCBF0AruGH/oMGIOh7wnkwUWbrsw1870upbMO8FJ3rhK3+e2fOZ8pzcZOk1rT3Veknfwy2DcN75uSTJlTHjwNbCD963Uwql17DbA2EqYWCsP1BfFut2/7vjCuQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44B3F8ECA0B2CC4D8340D176E4D19CBC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 859af60a-e847-41f2-5db6-08d6f6243ae9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 08:41:18.9110 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4282
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0e::724
Subject: Re: [Qemu-devel] [PATCH] blockjob: drain all job nodes in
 block_job_drain
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTkuMDYuMjAxOSAxOTozNywgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxOS4wNi4xOSAxNjo0NCwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IEluc3RlYWQgb2YgZHJhaW5p
bmcgYWRkaXRpb25hbCBub2RlcyBpbiBlYWNoIGpvYiBjb2RlLCBsZXQncyBkbyBpdCBpbg0KPj4g
Y29tbW9uIGJsb2NrX2pvYl9kcmFpbiwgZHJhaW5pbmcganVzdCBhbGwgam9iJ3MgY2hpbGRyZW4u
DQo+Pg0KPj4gSXQncyBhbHNvIGEgZmlyc3Qgc3RlcCB0byBmaW5hbGx5IGdldCByaWQgb2YgYmxv
Y2tqb2ItPmJsay4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dp
ZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+PiAtLS0NCj4+DQo+PiBIaSBhbGwh
DQo+Pg0KPj4gQXMgYSBmb2xsb3ctdXAgZm9yICJibG9jazogZHJvcCBicy0+am9iIiByZWNlbnRs
eSBtZXJnZWQsIEknbSBub3cgdHJ5aW5nDQo+PiB0byBkcm9wIEJsb2NrSm9iLmJsayBwb2ludGVy
LCBqb2JzIHJlYWxseSB3b3JrcyB3aXRoIHNldmVyYWwgbm9kZXMgYW5kDQo+PiBub3cgcmVhc29u
IHRvIGtlZXAgc3BlY2lhbCBibGsgZm9yIG9uZSBvZiB0aGUgY2hpbGRyZW4sIGFuZCBubyByZWFz
b24gdG8NCj4+IGhhbmRsZSBub2RlcyBkaWZmZXJlbnRseSBpbiwgZm9yIGV4YW1wbGUsIGJhY2t1
cCBjb2RlLi4NCj4+DQo+PiBBbmQgYXMgYSBmaXJzdCBzdGVwIEkgbmVlZCB0byBzb3J0IG91dCBi
bG9ja19qb2JfZHJhaW4sIGFuZCBoZXJlIGlzIG15DQo+PiBzdWdnZXN0aW9uIG9uIGl0Lg0KPj4N
Cj4+ICAgYmxvY2svYmFja3VwLmMgfCAxOCArLS0tLS0tLS0tLS0tLS0tLS0NCj4+ICAgYmxvY2sv
bWlycm9yLmMgfCAyNiArKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gICBibG9ja2pvYi5j
ICAgICB8ICA3ICsrKysrKy0NCj4+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCsp
LCA0MSBkZWxldGlvbnMoLSkNCj4gDQo+IExvb2tzIGdvb2QgdG8gbWUuICBUd28gcXVlc3Rpb25z
IHRob3VnaDoNCj4gDQo+IFdvdWxkIGl0IG1ha2Ugc2Vuc2UgdG8gcmVtb3ZlIEJsb2NrSm9iRHJp
dmVyLmRyYWluKCkgbm93PyAgSSB0aGluaw0KPiBldmVyeXRoaW5nIHRoYXQgaXNu4oCZdCDigJxk
cmFpbiB0aGUgYXR0YWNoZWQgbm9kZXPigJ0gc2hvdWxkIGJlIGhhbmRsZWQgYnkNCj4gSm9iRHJp
dmVyLnBhdXNlKCksIG5vPw0KDQpIbW0sIGFueXdheSBpdCBiZWNvbWVzIHVudXNlZCwgYW5kIGl0
J3MgdXN1YWxseSBiZXR0ZXIgdG8gbm90IGxlYXZlIHVudXNlZCB0aGluZ3MsDQp3aGljaCB3ZSBj
YW4gcmVwYWlyIGluIGZ1dHVyZSBpZiBuZWVkZWQuIFdpbGwgZG8uDQoNCj4gDQo+PiBkaWZmIC0t
Z2l0IGEvYmxvY2tqb2IuYyBiL2Jsb2Nram9iLmMNCj4+IGluZGV4IDQ1OGFlNzZmNTEuLjBjYWJk
Yzg2N2QgMTAwNjQ0DQo+PiAtLS0gYS9ibG9ja2pvYi5jDQo+PiArKysgYi9ibG9ja2pvYi5jDQo+
PiBAQCAtOTQsOCArOTQsMTMgQEAgdm9pZCBibG9ja19qb2JfZHJhaW4oSm9iICpqb2IpDQo+PiAg
ICAgICBCbG9ja0pvYiAqYmpvYiA9IGNvbnRhaW5lcl9vZihqb2IsIEJsb2NrSm9iLCBqb2IpOw0K
Pj4gICAgICAgY29uc3QgSm9iRHJpdmVyICpkcnYgPSBqb2ItPmRyaXZlcjsNCj4+ICAgICAgIEJs
b2NrSm9iRHJpdmVyICpiamRydiA9IGNvbnRhaW5lcl9vZihkcnYsIEJsb2NrSm9iRHJpdmVyLCBq
b2JfZHJpdmVyKTsNCj4+ICsgICAgR1NMaXN0ICpsOw0KPj4gKw0KPj4gKyAgICBmb3IgKGwgPSBi
am9iLT5ub2RlczsgbDsgbCA9IGwtPm5leHQpIHsNCj4+ICsgICAgICAgIEJkcnZDaGlsZCAqYyA9
IGwtPmRhdGE7DQo+PiArICAgICAgICBiZHJ2X2RyYWluKGMtPmJzKTsNCj4+ICsgICAgfQ0KPiAN
Cj4gQ291bGQgaXQgYmUgbW9yZSBlZmZpY2llbnQgdG8gYmRydl9kcmFpbmVkX2JlZ2luKCkgYWxs
IG5vZGVzIGluIG9uZSBsb29wDQo+IGFuZCB0aGVuIGJkcnZfZHJhaW5lZF9lbmQoKSB0aGVtIGFs
bCBpbiBhIHNlY29uZCBvbmU/DQo+IA0KPiAoRHJhaW5pbmcgYSBub2RlIG1lYW5zIGRyYWluaW5n
IGl0cyBwYXJlbnRzLCBhbmQgdGhhdCBpcyBxdWlja2VyIGlmDQo+IHRoZXnigJlyZSBkcmFpbmVk
IGFscmVhZHkuICBJZiB0aGUgbm9kZXMgYXJlIGluIGEgY2hhaW4sIGp1c3QgdXNpbmcNCj4gYmRy
dl9kcmFpbigpIG1heSBtZWFuIHNvbWUgbm9kZXMgYXJlIGRyYWluZWQgYW5kIHVuZHJhaW5lZCBh
IGNvdXBsZSBvZg0KPiB0aW1lcy4pDQo+IA0KDQpVbmRlcnN0YW5kLCBPSywgd2lsbCBkbyBhbmQg
cmVzZW5kIHRvZGF5LiBUaGFua3MgZm9yIHJldmlld2luZyENCg0KDQo+PiAgIA0KPj4gLSAgICBi
bGtfZHJhaW4oYmpvYi0+YmxrKTsNCj4+ICAgICAgIGlmIChiamRydi0+ZHJhaW4pIHsNCj4+ICAg
ICAgICAgICBiamRydi0+ZHJhaW4oYmpvYik7DQo+PiAgICAgICB9DQo+Pg0KPiANCj4gDQoNCg0K
LS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

