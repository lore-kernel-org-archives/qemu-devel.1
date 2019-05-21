Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B966C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 08:50:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D88CD2173C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 08:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="J1ysiFv2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88CD2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49051 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT0TT-0006q3-3U
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 04:50:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hT0RY-0005md-Vq
	for qemu-devel@nongnu.org; Tue, 21 May 2019 04:48:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hT0RX-0005mc-8Q
	for qemu-devel@nongnu.org; Tue, 21 May 2019 04:48:20 -0400
Received: from mail-eopbgr10114.outbound.protection.outlook.com
	([40.107.1.114]:18029
	helo=EUR02-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hT0RW-0005l4-F5; Tue, 21 May 2019 04:48:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=c76zG7pn+A/O+/z4Td/LmxdFRDmhOBYWMB7KlRPnGoU=;
	b=J1ysiFv2FDbfNpevIuMsk6s51DMqQxSrbAxLT7vHCnl0RnMMuWGV3/ALRRCbKHImeWYyNQsh1lLRDZ8u2OJF5u6T2AiYMQJDAt+OF0OhezynR5VucjXwtpdZidZ4fV6t9uHJDU3ftRTudWcDvCLw8UK2UczpPZpTv1npztRHa4Y=
Received: from AM6PR08MB4675.eurprd08.prod.outlook.com (10.255.96.78) by
	AM6PR08MB5126.eurprd08.prod.outlook.com (10.255.120.94) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1900.17; Tue, 21 May 2019 08:48:15 +0000
Received: from AM6PR08MB4675.eurprd08.prod.outlook.com
	([fe80::9051:3c85:28c6:a0c1]) by
	AM6PR08MB4675.eurprd08.prod.outlook.com
	([fe80::9051:3c85:28c6:a0c1%6]) with mapi id 15.20.1878.024;
	Tue, 21 May 2019 08:48:15 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
Thread-Topic: [RFC PATCH 0/3] block: qiov_offset parameter for io
Thread-Index: AQHVD7GMSMNoEUo/GEaCxI4Fn6OKPKZ1RHQA
Date: Tue, 21 May 2019 08:48:14 +0000
Message-ID: <5af4eb2c-e893-fc37-aa83-c253b6d090da@virtuozzo.com>
References: <20190521084522.15050-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190521084522.15050-1-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0023.eurprd01.prod.exchangelabs.com
	(2603:10a6:7:14::36) To AM6PR08MB4675.eurprd08.prod.outlook.com
	(2603:10a6:20b:c2::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190521114812756
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 105a4559-94c5-4861-a964-08d6ddc91014
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:AM6PR08MB5126; 
x-ms-traffictypediagnostic: AM6PR08MB5126:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM6PR08MB5126D2ACDC915B6F1E15E619C1070@AM6PR08MB5126.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(346002)(396003)(366004)(39850400004)(136003)(53754006)(199004)(189003)(25786009)(8676002)(6246003)(478600001)(14454004)(2906002)(8936002)(107886003)(36756003)(2501003)(81166006)(81156014)(53936002)(186003)(229853002)(316002)(6486002)(73956011)(6436002)(26005)(446003)(966005)(4326008)(68736007)(305945005)(66946007)(7736002)(66476007)(64756008)(66446008)(66556008)(66066001)(31696002)(11346002)(86362001)(71190400001)(71200400001)(2616005)(110136005)(476003)(54906003)(31686004)(486006)(256004)(99286004)(386003)(6506007)(6306002)(6116002)(3846002)(52116002)(102836004)(76176011)(4744005)(5660300002)(6512007);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5126;
	H:AM6PR08MB4675.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MCGPUiauLj5h2DvGt9FUM/MzrvuLhohlVKzXaY8W1MGmCQNqC+YMuWeeYTNFNFzjv3b1PCxzv6bNNKz0SBbL5xzUOy4ZkqYbi97jXypogahdaAhIw52xZkSTYCWSHEIPy5bHk9dX3qnmMwOAzgIm7/tgJF1PtzfjLmwKVsYB5ss4fcqqkxjibYouXn7CMgOe6dtJWF0DUgdsOJs/kTBQiVasQ+BXsX+gV7x3qYNGIxpmNRKiiTfAsxlIWIKegvMGFgUphFdF34L4JwbTZ2qT1FiiHyuFcPGHM4viNNSTNQIPUe5cgs6R5cgVQlrG5Np2HtUdIdOvLmng7u4UvRsP9GAFhBCIQ/gWONN2T/1VeZPQoEkBkIwfR7rVhcE1O++sieINxFaCIC88gDdrkTcy3KioXdSjeaaKBh3/qqqqjaM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9F2633D9BC9C6488195525058D90B59@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 105a4559-94c5-4861-a964-08d6ddc91014
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 08:48:14.9787 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5126
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.114
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] block: qiov_offset parameter for io
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
	Denis Lunev <den@virtuozzo.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjEuMDUuMjAxOSAxMTo0NSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
SGkgYWxsIQ0KPiANCj4gSGVyZSBpcyBpZGVhIG9mIGFkZGluZyBxaW92X29mZnNldCBwYXJhbWV0
ZXIgdG8gaW8gcGF0aCwgdG8gYXZvaWQNCj4gYSBsb3Qgb2YgcGxhY2VzIHdpdGggc2FtZSBwYXR0
ZXJuIG9mIGNyZWF0aW5nIGxvY2FsX3Fpb3Ygb3IgaGRfcWlvdg0KPiB2YXJpYWJsZXMuIEhlcmUg
aXMgb25seSByZWFkIHBhdGggZm9yIHFjb3cyLCBpZiB3ZSBsaWtlIGl0LCBJJ2xsDQo+IG1ha2Ug
djIgd2l0aCBib3RoIHJlYWQgYW5kIHdyaXRlIHBhdGhzIGZvciBxY293Mi4NCj4gDQoNCkJhc2Vk
IG9uIE1heCdzIGJsb2NrIHRyZWUNCkJhc2VkLW9uOiBodHRwczovL2dpdGh1Yi5jb20vWGFuQ2xp
Yy9xZW11IGJsb2NrDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

