Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14305C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 15:37:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D20FC21726
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 15:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="H3x/+8Xb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D20FC21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43589 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCQu8-0007y2-5b
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 11:37:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hCQrj-00060w-6v
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:34:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hCQrf-0003sr-MU
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:34:49 -0400
Received: from mail-eopbgr60129.outbound.protection.outlook.com
	([40.107.6.129]:8362
	helo=EUR04-DB3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hCQra-0003l5-Ha; Fri, 05 Apr 2019 11:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=simSbriSZ7Met2+SGoMewaVPHga2rnb7ZIB+SJI2E58=;
	b=H3x/+8XbWmsvW23Ylq5WPfc5/kQ6s0uHfjW+oNiR91OEeKk0FT1u7zmAej12RceFJdpr042RycHakNAltuBcLerSJUU8yx4lTgAgWg6XpGQMEzIL1ob57FskU4RIKP30w5twFVWmxCHIoJweKS0QJ+VrwLpCWn0LYPGThi+W2H0=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3370.eurprd08.prod.outlook.com (20.176.238.87) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.13; Fri, 5 Apr 2019 15:34:32 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%2]) with mapi id 15.20.1750.017;
	Fri, 5 Apr 2019 15:34:32 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
Thread-Topic: [PATCH 3/7] nbd/server: Don't fail NBD_OPT_INFO for byte-aligned
	sources
Thread-Index: AQHU6codQ1q2fp8/lUieBb1rvl2DtaYttomA
Date: Fri, 5 Apr 2019 15:34:32 +0000
Message-ID: <57ff4a6d-36ed-3126-6de0-aa708828693d@virtuozzo.com>
References: <20190403030526.12258-1-eblake@redhat.com>
	<20190403030526.12258-4-eblake@redhat.com>
In-Reply-To: <20190403030526.12258-4-eblake@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0052.eurprd09.prod.outlook.com
	(2603:10a6:7:3c::20) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190405183429591
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f55ff7e5-9941-4a6e-a990-08d6b9dc32fd
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
	SRVR:DB7PR08MB3370; 
x-ms-traffictypediagnostic: DB7PR08MB3370:
x-microsoft-antispam-prvs: <DB7PR08MB3370879893236D20E2EA385CC1510@DB7PR08MB3370.eurprd08.prod.outlook.com>
x-forefront-prvs: 0998671D02
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(39850400004)(366004)(346002)(376002)(396003)(199004)(189003)(102836004)(5660300002)(7736002)(14444005)(476003)(26005)(11346002)(14454004)(256004)(446003)(186003)(2616005)(486006)(99286004)(52116002)(6506007)(478600001)(386003)(305945005)(2501003)(3846002)(6116002)(36756003)(76176011)(316002)(66066001)(2906002)(97736004)(54906003)(31686004)(71190400001)(229853002)(6246003)(6512007)(81166006)(106356001)(105586002)(81156014)(8676002)(4326008)(71200400001)(86362001)(6436002)(8936002)(6486002)(4744005)(110136005)(25786009)(31696002)(53936002)(68736007);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3370;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: a91lXbfueOzbXA1RC9N0uXDKzQY7710UeLS3hB91SMoLt9zkl219CN30qStZqX8deaRwgitNR3+BZDwzxcSvd68kdIwI7O48Nl4+tc/GTHCzutaB554qSSLl7FzBndf6NHCgS+7uM/HnOJJkMc0VvbkvSjCU3QHGjXTMwQ92OSU5cz6HrUVWuw6SCVEr0QKM1Cmmq5JPR0rCnXTvCOLbK/0tk9SmH5GBefhqJO7A/tEgQtMbM1UrCbOLAFnrUUWhQn8MtKknvIe1nW7UM4YUBFIZCUZeojOrF7hzFF3GLs45nOxyNyU0mVqqW6Czui1QIRdEcv5UoHv/sFEhLCf31ARrVv5dej+8eDg9MjRU7AHax6OuGelriZWHFTYz5F/YjgwSxQQ4Xsvmj2o5YGWtjInLDmOhjqvMtj0Xo2SWPrk=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <F2205CE0757DA54681CCE2D0A93617C3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f55ff7e5-9941-4a6e-a990-08d6b9dc32fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2019 15:34:32.3625 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3370
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.129
Subject: Re: [Qemu-devel] [PATCH 3/7] nbd/server: Don't fail NBD_OPT_INFO
 for byte-aligned sources
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
Message-ID: <20190405153432.3Os-zoLf_W5soC9mE1yWmLkLuLjdoOIc3kd-OWTw4ZU@z>

MDMuMDQuMjAxOSA2OjA1LCBFcmljIEJsYWtlIHdyb3RlOg0KPiBJbiBjb21taXQgMGMxZDUwYmQs
IEkgYWRkZWQgYSBjb3VwbGUgb2YgVE9ETyBjb21tZW50cyBhYm91dCB3aGV0aGVyIHdlDQo+IGNv
bnN1bHQgYmwucmVxdWVzdF9hbGlnbm1lbnQgd2hlbiByZXNwb25kaW5nIHRvIE5CRF9PUFRfSU5G
Ty4gQXQgdGhlDQo+IHRpbWUsIHFlbXUgYXMgc2VydmVyIHdhcyBoYXJkLWNvZGluZyBhbiBhZHZl
cnRpc2VkIGFsaWdubWVudCBvZiA1MTIgdG8NCj4gY2xpZW50cyB0aGF0IHByb21pc2VkIHRvIG9i
ZXkgY29uc3RyYWludHMsIGFuZCB0aGVyZSB3YXMgbm8gZnVuY3Rpb24NCj4gZm9yIGdldHRpbmcg
YXQgYSBkZXZpY2UncyBwcmVmZXJyZWQgYWxpZ25tZW50LiBCdXQgaW4gaGluZHNpZ2h0LA0KPiBh
ZHZlcnRpc2luZyA1MTIgd2hlbiB0aGUgYmxvY2sgZGV2aWNlIHByZWZlcnMgMSBjYXVzZWQgb3Ro
ZXINCj4gY29tcGxpYW5jZSBwcm9ibGVtcywgYW5kIGNvbW1pdCBiMDI0NWQ2NCBjaGFuZ2VkIG9u
ZSBvZiB0aGUgdHdvIFRPRE8NCj4gY29tbWVudHMgdG8gYWR2ZXJ0aXNlIGEgbW9yZSBhY2N1cmF0
ZSBhbGlnbm1lbnQuIFRpbWUgdG8gZml4IHRoZSBvdGhlcg0KPiBUT0RPLiAgRG9lc24ndCByZWFs
bHkgaW1wYWN0IHFlbXUgYXMgY2xpZW50IChvdXIgbm9ybWFsIGNsaWVudCBkb2Vzbid0DQo+IHVz
ZSBOQkRfT1BUX0lORk8sIGFuZCBxZW11LW5iZCAtLWxpc3QgcHJvbWlzZXMgdG8gb2JleSBibG9j
ayBzaXplcyksDQo+IGJ1dCBpdCBtaWdodCBwcm92ZSB1c2VmdWwgdG8gb3RoZXIgY2xpZW50cy4N
Cj4gDQo+IEZpeGVzOiBiMDI0NWQ2NA0KPiBTaWduZWQtb2ZmLWJ5OiBFcmljIEJsYWtlIDxlYmxh
a2VAcmVkaGF0LmNvbT4NCg0KDQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2
c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0K
VmxhZGltaXINCg==

