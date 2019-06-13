Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693B6C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 14:01:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39A7D20673
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 14:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DsUMqBUy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A7D20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39906 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbQIB-00024K-9u
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 10:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38781)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbP2H-0007IJ-K4
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:40:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbP2F-0007sW-33
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:40:56 -0400
Received: from mail-ve1eur01on0712.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::712]:13617
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbP2C-0007Wj-PZ; Thu, 13 Jun 2019 08:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XGuD1dbjyoc/KeWdOOkjBXISb0lwv8tnaEzqf8Sz9M=;
 b=DsUMqBUyT3xiTKALqjFZlMtybJz5J/5/VDIYr2G2GQuhBITNSeJaN7hsHza+Fjfh8O2fohBWk/rJoSZUSwp7Fh9FO0gUsAwuXZTErKSPtCrmTEz06fGFu2xz9DYynNRYfYRs26otmZgVcKGOCT18B/4DpzgadKgqdke0WFJZsZo=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB3587.eurprd08.prod.outlook.com (20.177.110.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Thu, 13 Jun 2019 12:40:27 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 12:40:27 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 08/42] block: bdrv_set_backing_hd() is about
 bs->backing
Thread-Index: AQHVIWumRlnj8bMx80aJvb+VOpZU46aZh4GA
Date: Thu, 13 Jun 2019 12:40:26 +0000
Message-ID: <70449f38-aeff-dc19-a9c3-e110f7e996cb@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-9-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-9-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0901CA0043.eurprd09.prod.outlook.com
 (2603:10a6:3:45::11) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190613154025359
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ea3140a-0d37-4dbd-cd14-08d6effc4fb5
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB3587; 
x-ms-traffictypediagnostic: AM0PR08MB3587:
x-microsoft-antispam-prvs: <AM0PR08MB3587300C356A2AF1BDB88276C1EF0@AM0PR08MB3587.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(396003)(136003)(39850400004)(366004)(189003)(199004)(186003)(31686004)(36756003)(229853002)(486006)(5660300002)(6512007)(6436002)(8936002)(81156014)(81166006)(6486002)(7736002)(2616005)(476003)(305945005)(8676002)(25786009)(446003)(11346002)(53936002)(76176011)(52116002)(2501003)(102836004)(478600001)(66946007)(6506007)(73956011)(386003)(64756008)(86362001)(54906003)(66476007)(66446008)(31696002)(68736007)(26005)(66066001)(110136005)(316002)(14454004)(99286004)(14444005)(256004)(71200400001)(71190400001)(3846002)(4326008)(66556008)(6116002)(2906002)(6246003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3587;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 42IdtHVUtHSQFex+48a/V4H3ul28glwKhofczfi4anHRiO8s5GZZ+g2biP8HeLsjywfMAriw/v6c6o6PA7Nv7KJFcknu5LlU7xUxTX/bQDLaF7ZvDlYW+nDKCqvUIjKN6d+OCDASkmSGj+D/kGABAQfdq/EXfskdbUIGGnNX5qCQzf7W7LgxfPXrOwuVKHE2h+8LkSFtKpLBrdB9I8NZcBwYQ9YTVtnmisbiXGt99aQ9GiD2Oc5PX4minNrY5ADb3yuugioO7mNdUvNVrab0sjqWyS26k+EgQiuVDO2N1rtZDGQ3IhsKEZFP/NUwsmhLiYqexD6AtskuKl49zT8mlYo62gAKlbhiBbqlZc+6SyFpS34Z3pRAeaEbClDhzAqqU5U7/sMHMe3ZxuUpNCB13jw1PAMizC0rc4ljY2WqxM4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44F137E2D41CF743BFCE441EDE8F5F31@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea3140a-0d37-4dbd-cd14-08d6effc4fb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 12:40:27.0034 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3587
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe1f::712
Subject: Re: [Qemu-devel] [PATCH v5 08/42] block: bdrv_set_backing_hd() is
 about bs->backing
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

MTMuMDYuMjAxOSAxOjA5LCBNYXggUmVpdHogd3JvdGU6DQo+IGJkcnZfc2V0X2JhY2tpbmdfaGQo
KSBpcyBhIGZ1bmN0aW9uIHRoYXQgZXhwbGljaXRseSBjYXJlcyBhYm91dCB0aGUNCj4gYnMtPmJh
Y2tpbmcgY2hpbGQuICBIaWdobGlnaHQgdGhhdCBpbiBpdHMgZGVzY3JpcHRpb24gYW5kIHVzZQ0K
PiBjaGlsZF9icyhicy0+YmFja2luZykgaW5zdGVhZCBvZiBiYWNraW5nX2JzKGJzKSB0byBtYWtl
IGl0IG1vcmUgb2J2aW91cy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1heCBSZWl0eiA8bXJlaXR6
QHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5
IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+XQ0KDQo+IC0tLQ0KPiAgIGJsb2NrLmMgfCA0ICsr
LS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2Jsb2NrLmMgYi9ibG9jay5jDQo+IGluZGV4IDY0ZDYxOTA5ODQu
Ljg0MzhiMDY5OWUgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrLmMNCj4gKysrIGIvYmxvY2suYw0KPiBA
QCAtMjQxNyw3ICsyNDE3LDcgQEAgc3RhdGljIGJvb2wgYmRydl9pbmhlcml0c19mcm9tX3JlY3Vy
c2l2ZShCbG9ja0RyaXZlclN0YXRlICpjaGlsZCwNCj4gICB9DQo+ICAgDQo+ICAgLyoNCj4gLSAq
IFNldHMgdGhlIGJhY2tpbmcgZmlsZSBsaW5rIG9mIGEgQkRTLiBBIG5ldyByZWZlcmVuY2UgaXMg
Y3JlYXRlZDsgY2FsbGVycw0KPiArICogU2V0cyB0aGUgYnMtPmJhY2tpbmcgbGluayBvZiBhIEJE
Uy4gQSBuZXcgcmVmZXJlbmNlIGlzIGNyZWF0ZWQ7IGNhbGxlcnMNCj4gICAgKiB3aGljaCBkb24n
dCBuZWVkIHRoZWlyIG93biByZWZlcmVuY2UgYW55IG1vcmUgbXVzdCBjYWxsIGJkcnZfdW5yZWYo
KS4NCj4gICAgKi8NCj4gICB2b2lkIGJkcnZfc2V0X2JhY2tpbmdfaGQoQmxvY2tEcml2ZXJTdGF0
ZSAqYnMsIEJsb2NrRHJpdmVyU3RhdGUgKmJhY2tpbmdfaGQsDQo+IEBAIC0yNDI2LDcgKzI0MjYs
NyBAQCB2b2lkIGJkcnZfc2V0X2JhY2tpbmdfaGQoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIEJsb2Nr
RHJpdmVyU3RhdGUgKmJhY2tpbmdfaGQsDQo+ICAgICAgIGJvb2wgdXBkYXRlX2luaGVyaXRzX2Zy
b20gPSBiZHJ2X2NoYWluX2NvbnRhaW5zKGJzLCBiYWNraW5nX2hkKSAmJg0KPiAgICAgICAgICAg
YmRydl9pbmhlcml0c19mcm9tX3JlY3Vyc2l2ZShiYWNraW5nX2hkLCBicyk7DQo+ICAgDQo+IC0g
ICAgaWYgKGJkcnZfaXNfYmFja2luZ19jaGFpbl9mcm96ZW4oYnMsIGJhY2tpbmdfYnMoYnMpLCBl
cnJwKSkgew0KPiArICAgIGlmIChiZHJ2X2lzX2JhY2tpbmdfY2hhaW5fZnJvemVuKGJzLCBjaGls
ZF9icyhicy0+YmFja2luZyksIGVycnApKSB7DQo+ICAgICAgICAgICByZXR1cm47DQo+ICAgICAg
IH0NCj4gICANCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

