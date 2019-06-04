Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49558C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:54:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 090EB23CA1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iX/nLdwy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090EB23CA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55440 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYChd-0000iB-8e
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 12:54:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1hYCgi-0000M1-PJ
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:53:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1hYCgh-0002bC-M0
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:53:28 -0400
Received: from mail-eopbgr30109.outbound.protection.outlook.com
	([40.107.3.109]:42211
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1hYCgg-0002Y9-TH; Tue, 04 Jun 2019 12:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=9oo66hymP2YoNBPluexQGNtjHfLozIjDe2T8454uj1E=;
	b=iX/nLdwycmLqLyxISIrYTtwbh5pGpK5U0ttIn7MmjZ+Lm+FMIs0Pt/On9jEexe48/K757zMYYKGoxPjXBNRRrh/yxlvjf9C8TR+3pwb+amqI53CF7FPeWO7siAl0T7PfrCacHwbiEtz5HIBI3ryOjqvIZPkge71zYQTVGkGu8Y4=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
	VI1PR08MB4445.eurprd08.prod.outlook.com (20.179.24.203) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1943.17; Tue, 4 Jun 2019 16:53:23 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
	([fe80::48f:a107:e2ac:a28f]) by VI1PR08MB4078.eurprd08.prod.outlook.com
	([fe80::48f:a107:e2ac:a28f%7]) with mapi id 15.20.1943.018;
	Tue, 4 Jun 2019 16:53:23 +0000
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Thread-Topic: [Qemu-block] [PATCH v7 0/9] discard blockstats
Thread-Index: AQHVCk4LHMttZCqeQUeaJK/Q2TMYQKaJ1CAAgAIDTIA=
Date: Tue, 4 Jun 2019 16:53:23 +0000
Message-ID: <08293f58-121e-b26d-70b4-0c564fdbe095@virtuozzo.com>
References: <20190514121015.32190-1-anton.nefedov@virtuozzo.com>
	<20190603100902.hfk2qo3436kvbevw@steredhat.homenet.telecomitalia.it>
In-Reply-To: <20190603100902.hfk2qo3436kvbevw@steredhat.homenet.telecomitalia.it>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0066.eurprd09.prod.outlook.com
	(2603:10a6:7:3c::34) To VI1PR08MB4078.eurprd08.prod.outlook.com
	(2603:10a6:803:e5::28)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=anton.nefedov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7ab0525-9f58-4641-b0a4-08d6e90d27fb
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
	SRVR:VI1PR08MB4445; 
x-ms-traffictypediagnostic: VI1PR08MB4445:
x-ms-exchange-purlcount: 4
x-microsoft-antispam-prvs: <VI1PR08MB444522C60C4CA39043191E01F8150@VI1PR08MB4445.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0058ABBBC7
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(136003)(396003)(346002)(39850400004)(376002)(189003)(199004)(36756003)(25786009)(66446008)(66946007)(6246003)(8936002)(66066001)(4326008)(11346002)(316002)(54906003)(26005)(6916009)(186003)(966005)(68736007)(73956011)(5660300002)(229853002)(71200400001)(478600001)(14454004)(71190400001)(486006)(6116002)(6512007)(102836004)(81156014)(99286004)(81166006)(44832011)(3846002)(53546011)(66476007)(66556008)(64756008)(86362001)(6506007)(6436002)(476003)(2616005)(31696002)(6486002)(386003)(8676002)(76176011)(52116002)(446003)(6306002)(256004)(14444005)(31686004)(7736002)(2906002)(53936002)(305945005);
	DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB4445;
	H:VI1PR08MB4078.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6pNnTZxrr+B/UNATdqhNSE/WdfQAt+jHFxNs4U1jrpVfXsvxwtmZKZUboqxTpFplYpInCRm6O1/b5EhdwA1i1aWJnyz08i6xTKTke9hUQAwuSbUKReuZUdQQ8+o2JcGLfqBLwaXFsNV2H18UBfuMCIxojUzT49bu9sXzbtcOrIyMeWZu18+xW+ZkV2P2IBa/vFuDT6QlMGfNtqYzh9jldwMF3hM7EZ0nPdQ4II0QFwfu5wK1jEqgyfB8jk/U8GbWvKPvq2TesssJSh5uwht/3iQynt9D0p5UcYjiaF8j8c6tD4kJW4BrLnoULkp5w1hL8POERS+P1TyZLULCfjoR+ZLJUQtaTBfhFRYiFN9xZqxvdxICZNXLAF3CXRQpUxiAuns5K/vIqF8831dcLIvHTA8xAVqhai2Q2PwiI5izCSk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F886E16520DAE408C4B006C433CA09A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ab0525-9f58-4641-b0a4-08d6e90d27fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2019 16:53:23.6635 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anton.nefedov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4445
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.109
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v7 0/9] discard blockstats
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	Denis Lunev <den@virtuozzo.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMy82LzIwMTkgMTowOSBQTSwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOg0KPiBPbiBUdWUs
IE1heSAxNCwgMjAxOSBhdCAxMjoxMDo0MFBNICswMDAwLCBBbnRvbiBOZWZlZG92IHdyb3RlOg0K
Pj4gaGksDQo+Pg0KPj4geWV0IGFub3RoZXIgdGFrZSBmb3IgdGhpcyBwYXRjaCBzZXJpZXM7IHBs
ZWFzZSBraW5kbHkgY29uc2lkZXIgdGhlc2UgZm9yIDQuMQ0KPj4NCj4+IEp1c3QgYSBmZXcgY29z
bWV0aWMgY29tbWVudHMgd2VyZSByZWNlaXZlZCBmb3IgdjYgc28gdGhpcyBpcyBtb3N0bHkNCj4+
IGEgcmViYXNlK3BpbmcuDQo+Pg0KPj4gbmV3IGluIHY3Og0KPj4gICAgICAtIGdlbmVyYWwgcmVi
YXNlDQo+PiAgICAgIC0gc2luY2UgY2xhdXNlcyAtPiA0LjENCj4+ICAgICAgLSBwYXRjaCA4OiBu
b3QgY29tcGxldGVseSB0cml2aWFsIHJlYmFzZTogcmF3X2FjY291bnRfZGlzY2FyZCBtb3ZlZCB0
bw0KPj4gICAgICAgIGNvbW1vbiByYXdfZG9fcGRpc2NhcmQoKQ0KPj4gICAgICAtIHBhdGNoIDk6
IGNvbW1lbnQgd29yZGluZyBmaXhlZA0KPj4NCj4+IHY2OiBodHRwOi8vbGlzdHMubm9uZ251Lm9y
Zy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE4LTExL21zZzA2NjMzLmh0bWwNCj4+IHY1OiBo
dHRwOi8vbGlzdHMubm9uZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE4LTEwL21z
ZzA2ODI4Lmh0bWwNCj4+IHY0OiBodHRwOi8vbGlzdHMubm9uZ251Lm9yZy9hcmNoaXZlL2h0bWwv
cWVtdS1kZXZlbC8yMDE4LTA4L21zZzA0MzA4Lmh0bWwNCj4+IHYzOiBodHRwOi8vbGlzdHMubm9u
Z251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE4LTA2L21zZzAzNjg4Lmh0bWwNCj4+
DQo+IA0KPiBIaSBBbnRvbiwNCj4gc2luY2UgcWVtdSA0LjAgYWRkZWQgdGhlIGRpc2NhcmQgc3Vw
cG9ydCBvbiB2aXJ0aW8tYmxrLCBzaG91bGQgd2UgY29uc2lkZXIgaXQNCj4gaW4gdGhpcyBzZXJp
ZXM/DQo+IA0KPiBJZiB5b3UgcHJlZmVyIEkgY2FuIHdvcmsgb24gaXQgYW5kIHNlbmQgeW91IHRo
ZSBwYXRjaC4NCj4gDQoNCmhpIFN0ZWZhbm8sDQoNCmlmIHRoaXMgc2VyaWVzIGlzIGZpbmFsbHkg
Z2V0dGluZyBpbiwgaXQgaXMgcmVhbGx5IG5pY2UgaWYgeW91IGNhbiBhZGQNCnZpcnRpby1ibGsg
c3VwcG9ydCB0b28uDQoNCnRoYW5rcyENCg==

