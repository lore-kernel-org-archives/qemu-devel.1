Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF87C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 10:04:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59BEB2175B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 10:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VuuH1bVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59BEB2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38154 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbMaa-00010r-M9
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 06:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56421)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbMWa-0007Vn-Lu
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 06:00:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbMWZ-0006Bs-8p
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 06:00:04 -0400
Received: from mail-eopbgr70130.outbound.protection.outlook.com
 ([40.107.7.130]:55879 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbMWV-00065U-CP; Thu, 13 Jun 2019 06:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufenk5qxlq5vHxYWyzICacPAnyqTikGfq/EQ4sn3MxY=;
 b=VuuH1bVlwAzxMR6RFpQWPDZjB/FV8/ucx7H/PSFOrc6NkA1lNn6WE9rqtSHF5QjV9ZjlSffIkqvbanHMRVz8wYFbs9DEJqOJYAdWSGY5YMTkzJSIUdZYQAE8ea45Nk4Cwt4J6iBAcbj/L2Eh7VD1Onf0CwRIs1P4aF6ucVJ8Zq0=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB4563.eurprd08.prod.outlook.com (20.178.202.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Thu, 13 Jun 2019 09:59:54 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 09:59:54 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v2 6/7] iotests: amend QEMU NBD process synchronization
Thread-Index: AQHVIH/WmxX093B3xkSl5DPCw9WcJaaZXHyA
Date: Thu, 13 Jun 2019 09:59:53 +0000
Message-ID: <98074e5c-028f-8cd0-f2ae-5b869ec18f70@virtuozzo.com>
References: <1560276131-683243-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1560276131-683243-7-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1560276131-683243-7-git-send-email-andrey.shinkevich@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0502CA0010.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::20) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190613125951650
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6fef4055-512b-405d-cba8-08d6efe5e1e6
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB4563; 
x-ms-traffictypediagnostic: AM0PR08MB4563:
x-microsoft-antispam-prvs: <AM0PR08MB45639610CD9960F70E41FD04C1EF0@AM0PR08MB4563.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(136003)(39850400004)(376002)(346002)(189003)(199004)(6436002)(68736007)(6486002)(478600001)(54906003)(14454004)(110136005)(2616005)(476003)(11346002)(229853002)(316002)(71190400001)(71200400001)(486006)(4326008)(446003)(6246003)(36756003)(256004)(107886003)(53936002)(5660300002)(25786009)(31686004)(6512007)(31696002)(2201001)(3846002)(6116002)(99286004)(66946007)(66446008)(73956011)(66476007)(66556008)(64756008)(2501003)(86362001)(76176011)(52116002)(81166006)(8676002)(81156014)(7736002)(305945005)(26005)(386003)(6506007)(102836004)(8936002)(66066001)(2906002)(186003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4563;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2/VsREi0hu2Ah881bYZBpxtgNecIYtolLb78KTvXQwneoIKJt81VoQD1tiUDgMNSGlrZwLoXYXnw1LqKR0NCeM5rZ0ENR2GWsuKFgM34LfIFNqMZNvawx3gbcjkSCF1ws49jOHqZSSkT8LUa8QEKk3sDRNu5HDJFMJh/4mVbvcFyYyqPMqlX0/PG1rfhyNeu9BSVr1BL2pA5uLok6ZGxS1b/X6xAbVn3xWpxKTwMEkNyqmi0cQJvAUUm9Ycdi4uNtnMfOPuLgZqIk3tL2SbYtLrN7b9kD/e/zZSlP9R3k4ObvMuIMH0wWqdIbIazkcyH3SU8jSnIFhVU9sU+0ClESidHFfVAh+cOKqlTooPl+96zxM0f/6m1SBTZzqRGQ+iVgD4/mLXZ/sZQrN4kyc8HO11CIV1LwSg9zXpip6rcqrE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DFA32ED1D5757149AD41D0C267BBE310@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fef4055-512b-405d-cba8-08d6efe5e1e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 09:59:53.8650 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4563
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.130
Subject: Re: [Qemu-devel] [PATCH v2 6/7] iotests: amend QEMU NBD process
 synchronization
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTEuMDYuMjAxOSAyMTowMiwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+IFByb2Nlc3NlcyBh
cmUgZHlpbmcgaGFyZGVyIHVuZGVyIHRoZSBWYWxncmluZy4gSXQgcmVzdWx0cyBpbiBjb3VudGlu
Zw0KPiB0aGUgZHlpbmcgcHJvY2VzcyBhcyBhIG5ld2Jvcm4gb25lLiBNYWtlIGl0IHN1cmUgdGhh
dCBvbGQgTkJEIGpvYiBnZXQNCj4gZmluaXNoZWQgYmVmb3JlIHN0YXJ0aW5nIGEgbmV3IG9uZS4N
Cj4gDQo+IFN1Z2dlc3RlZC1ieTogUm9tYW4gS2FnYW4gPHJrYWdhbkB2aXJ0dW96em8uY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgU2hpbmtldmljaCA8YW5kcmV5LnNoaW5rZXZpY2hAdmly
dHVvenpvLmNvbT4NCj4gLS0tDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzL2NvbW1vbi5uYmQgfCA2
ICsrKysrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYg
LS1naXQgYS90ZXN0cy9xZW11LWlvdGVzdHMvY29tbW9uLm5iZCBiL3Rlc3RzL3FlbXUtaW90ZXN0
cy9jb21tb24ubmJkDQo+IGluZGV4IDI1ZmM5ZmYuLmUzZGNjNjAgMTAwNjQ0DQo+IC0tLSBhL3Rl
c3RzL3FlbXUtaW90ZXN0cy9jb21tb24ubmJkDQo+ICsrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy9j
b21tb24ubmJkDQo+IEBAIC0yMiw2ICsyMiw3IEBADQo+ICAgbmJkX3VuaXhfc29ja2V0PSIke1RF
U1RfRElSfS9xZW11LW5iZC5zb2NrIg0KPiAgIG5iZF90Y3BfYWRkcj0iMTI3LjAuMC4xIg0KPiAg
IG5iZF9waWRfZmlsZT0iJHtURVNUX0RJUn0vcWVtdS1uYmQucGlkIg0KPiArbmJkX2pvYl9waWQ9
IiINCj4gICANCj4gICBuYmRfc2VydmVyX3N0b3AoKQ0KPiAgIHsNCj4gQEAgLTMzLDYgKzM0LDkg
QEAgbmJkX3NlcnZlcl9zdG9wKCkNCj4gICAgICAgICAgICAgICBraWxsICIkTkJEX1BJRCINCj4g
ICAgICAgICAgIGZpDQo+ICAgICAgIGZpDQoNCkhvbmVzdGx5LCBJIGRvbid0IHVuZGVyc3RhbmQg
dGhlIHByb2JsZW0gZnJvbSBjb21taXQgbWVzc2FnZSwgYnV0IGFueXdheSBjb21tZW50DQpzaG91
bGQgYmUgYWRkZWQgaGVyZSwgdG8gbWFyayB0aGF0IHRoaXMgaXMgZm9yIHZhbGdyaW5kLi4uIEJ1
dCB5b3UgZG9uJ3QgY2hlY2sgZm9yDQpWQUxHUklORCBlbmFibGVkLi4gSSBpdCBpbnRlbnRpb25h
bD8NCg0KPiArICAgIGlmIFsgLW4gIiRuYmRfam9iX3BpZCIgXSAmJiBraWxsIC1zIDAgIiRuYmRf
am9iX3BpZCIgMj4vZGV2L251bGw7IHRoZW4NCj4gKyAgICAgICAgd2FpdCAiJG5iZF9qb2JfcGlk
Ig0KPiArICAgIGZpDQo+ICAgICAgIHJtIC1mICIkbmJkX3VuaXhfc29ja2V0Ig0KPiAgIH0NCj4g
ICANCj4gQEAgLTYxLDYgKzY1LDcgQEAgbmJkX3NlcnZlcl9zdGFydF91bml4X3NvY2tldCgpDQo+
ICAgew0KPiAgICAgICBuYmRfc2VydmVyX3N0b3ANCj4gICAgICAgJFFFTVVfTkJEIC12IC10IC1r
ICIkbmJkX3VuaXhfc29ja2V0IiAiJEAiICYNCj4gKyAgICBuYmRfam9iX3BpZD0kIQ0KPiAgICAg
ICBuYmRfc2VydmVyX3dhaXRfZm9yX3VuaXhfc29ja2V0ICQhDQo+ICAgfQ0KPiAgIA0KPiBAQCAt
MTA1LDUgKzExMCw2IEBAIG5iZF9zZXJ2ZXJfc3RhcnRfdGNwX3NvY2tldCgpDQo+ICAgew0KPiAg
ICAgICBuYmRfc2VydmVyX3N0b3ANCj4gICAgICAgJFFFTVVfTkJEIC12IC10IC1iICRuYmRfdGNw
X2FkZHIgLXAgJG5iZF90Y3BfcG9ydCAiJEAiICYNCj4gKyAgICBuYmRfam9iX3BpZD0kIQ0KPiAg
ICAgICBuYmRfc2VydmVyX3dhaXRfZm9yX3RjcF9zb2NrZXQgJCENCj4gICB9DQo+IA0KDQoNCi0t
IA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

