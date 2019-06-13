Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CD7C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:19:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40E7F2054F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WgGQQdzI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E7F2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40814 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbRVW-0001xN-FV
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 11:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53750)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbPuo-0002QL-T1
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:37:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbPun-0003Lr-KJ
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:37:18 -0400
Received: from mail-db5eur03on0731.outbound.protection.outlook.com
 ([2a01:111:f400:fe0a::731]:9742
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbPum-0003KI-TS; Thu, 13 Jun 2019 09:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4EX4ARsKA+PNlLmEueDJOddkmP8+SrBKRrlaMtti5o=;
 b=WgGQQdzIWymDiPwuNvBjZooTbulfRabxQvp628L53ROv/qjvTJfhPJTtXkR0et8yg9UTOS1/xot8hwxF1HEa94Zqfz2Qn5Vz4VI8NO4aEdI+I7TUQO3flF46IwczFY/z8ImQ112AbUWUgiQwraBW42PP+M49L518xOEAJ+7GqO8=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB4339.eurprd08.prod.outlook.com (20.179.34.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Thu, 13 Jun 2019 13:37:12 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 13:37:12 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 12/42] block: Use bdrv_filtered_rw* where obvious
Thread-Index: AQHVIWur2sjpcclQiEu4Bh0Vl7h7fqaZl1wA
Date: Thu, 13 Jun 2019 13:37:12 +0000
Message-ID: <a803703e-c1de-c3a6-733e-01086e128181@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-13-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-13-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P192CA0021.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::31)
 To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190613163710470
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2837574c-d3d6-485c-2840-08d6f0043d7d
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:AM0PR08MB4339; 
x-ms-traffictypediagnostic: AM0PR08MB4339:
x-microsoft-antispam-prvs: <AM0PR08MB4339BC38CF425510EDDC6AD9C1EF0@AM0PR08MB4339.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(136003)(366004)(396003)(39850400004)(199004)(189003)(478600001)(14454004)(102836004)(2501003)(71200400001)(256004)(26005)(71190400001)(229853002)(110136005)(2906002)(54906003)(53936002)(6486002)(316002)(186003)(6436002)(66066001)(6512007)(36756003)(86362001)(31696002)(2616005)(5660300002)(4744005)(31686004)(73956011)(305945005)(66476007)(66556008)(64756008)(66446008)(52116002)(66946007)(486006)(99286004)(25786009)(6246003)(11346002)(446003)(4326008)(476003)(386003)(68736007)(7736002)(6116002)(3846002)(6506007)(8936002)(76176011)(8676002)(81166006)(81156014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4339;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 05+tSMxvdWYdOUdFO+wP5W71NwBm2OSXHLsZi/NuArSD3xh9FQ+wLQccm+XeiWwPK3ytKJt/1uakFkSImqqBgYMcARmZmZesCyrZ8BMxaRDO/k+4kFnx1EQanfC6PlUOUmgSUKLUDs8SCQW5yYYVDvtd+5iZHzuh+TXPYKby1lpuN3S6fyQUV4ZsXuQijvnASRBOqeAptjFbEqHwcKblpu7Aj+Bgs6ewYsaazNLfjZbADGrrHwcwQqR2ceMh7yXia6DwGfLrTB673e+LO97wJTPeXKk6FIaBUM+MHxNbGCDXmxDd9J1j4NYNUMXiYqGO7DddmmbMCpOubKC9qsAC5p1tl4LvvSI7sDrt4ItanFnXCYvtOL+pS6ub6xmap+UjwfGNfafNRNH4euNI91m8n+G+RRSxMliDp6zzGdYUKI8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9403CF75A90FA341A8A733507B4D0EC5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2837574c-d3d6-485c-2840-08d6f0043d7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 13:37:12.4050 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4339
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0a::731
Subject: Re: [Qemu-devel] [PATCH v5 12/42] block: Use bdrv_filtered_rw*
 where obvious
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

MTMuMDYuMjAxOSAxOjA5LCBNYXggUmVpdHogd3JvdGU6DQo+IFBsYWNlcyB0aGF0IHVzZSBwYXR0
ZXJucyBsaWtlDQo+IA0KPiAgICAgIGlmIChicy0+ZHJ2LT5pc19maWx0ZXIgJiYgYnMtPmZpbGUp
IHsNCj4gICAgICAgICAgLi4uIHNvbWV0aGluZyBhYm91dCBicy0+ZmlsZS0+YnMgLi4uDQo+ICAg
ICAgfQ0KPiANCj4gc2hvdWxkIGJlDQo+IA0KPiAgICAgIEJsb2NrRHJpdmVyU3RhdGUgKmZpbHRl
cmVkID0gYmRydl9maWx0ZXJlZF9yd19icyhicyk7DQo+ICAgICAgaWYgKGZpbHRlcmVkKSB7DQo+
ICAgICAgICAgIC4uLiBzb21ldGhpbmcgYWJvdXQgQGZpbHRlcmVkIC4uLg0KPiAgICAgIH0NCj4g
DQo+IGluc3RlYWQuDQoNCkhtbSwgaW4gb3RoZXIgd29yZHMsIHN1cHBvcnQgZmlsdGVycyB3aXRo
IGJhY2tpbmcgY2hpbGQgaW4gYWxsIHBsYWNlcywgd2hlcmUgb25seSBmaWxlLWJhc2VkDQpmaWx0
ZXJzIGFyZSBzdXBwb3J0ZWQsIGFzIHdlIGRvbid0IHdhbnQgbWFrZSBhbnkgc2VtYW50aWMgZGlm
ZmVyZW5jZSBiZXR3ZWVuIHRoZXNlIHR3bw0KdHlwZXMgb2YgZmlsdGVycy4NCg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogTWF4IFJlaXR6IDxtcmVpdHpAcmVkaGF0LmNvbT4NCg0KUmV2aWV3ZWQtYnk6
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4N
Cg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

