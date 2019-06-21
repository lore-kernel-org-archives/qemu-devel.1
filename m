Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F59C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 13:56:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 258E42083B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 13:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="h1b9yq74"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 258E42083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35214 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heK1O-0007oz-CY
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 09:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55175)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1heJlh-0004Pi-DI
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 09:39:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1heJlg-0004py-CH
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 09:39:53 -0400
Received: from mail-eopbgr10110.outbound.protection.outlook.com
 ([40.107.1.110]:16613 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1heJlf-0004hY-EJ; Fri, 21 Jun 2019 09:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jg9hLXnZgVTI1qSgeZmGP3VbWnusDAmBn0Jxa7mHbvg=;
 b=h1b9yq748mwKDy73Iq75pSYKJdhChS+JkFki2yUzVIZGPcm7EMu0qbzimCpYoHvqnJJeigxRdsO+I9vgXY25z2o+Nh0QSo1OAFavdVYo1yn/SPWdaCvFOT9DGYOOJNaiCmmtZWVkOqkZCiroo7HaIwSVbTbW9MK0zCVzLGo9YOo=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB4522.eurprd08.prod.outlook.com (20.179.44.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Fri, 21 Jun 2019 13:39:41 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 13:39:41 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 34/42] block: Inline bdrv_co_block_status_from_*()
Thread-Index: AQHVIWvNU3OcdFzxRk6Av7EEdf3CnKamKrAA
Date: Fri, 21 Jun 2019 13:39:40 +0000
Message-ID: <d0b25d0a-960a-7401-bc68-c155eb62e640@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-35-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-35-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0056.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::24) To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190621163936878
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73914106-ac14-4b75-10d0-08d6f64de8c0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4522; 
x-ms-traffictypediagnostic: DBBPR08MB4522:
x-microsoft-antispam-prvs: <DBBPR08MB452214FA4673547B3D793BA1C1E70@DBBPR08MB4522.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(39840400004)(376002)(346002)(136003)(199004)(189003)(66066001)(25786009)(54906003)(486006)(3846002)(110136005)(256004)(386003)(6506007)(186003)(71190400001)(71200400001)(6116002)(446003)(2501003)(4744005)(76176011)(2616005)(31696002)(476003)(316002)(26005)(86362001)(478600001)(11346002)(102836004)(8936002)(52116002)(6436002)(6486002)(8676002)(99286004)(6246003)(229853002)(66946007)(73956011)(66476007)(66556008)(64756008)(66446008)(14454004)(68736007)(36756003)(2906002)(81156014)(81166006)(305945005)(7736002)(31686004)(5660300002)(4326008)(6512007)(53936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4522;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7UTTDO7B9RPvT40ZoCu9doOcnXpIsPFSV+AO1je2RSjL+rQ0IdEHxWTB9iSCdUCJIxyyEkncgmlznWnccZ0QzHSYFKyY5zvShiL+lOm4VK9iIkP9JrSba6ue8uuepR1d8jNnqn5KrkcG6QY+0zYzLQEL5IFfQNXT2T92kheHw2SHOgcbOlMyk8Z9FVBJJRB1/CsRqKDSLjv3ziP5l8R3Q8Ar0mO6UMVgMCPr2jJ2am5Be/Z17Aqc4dRL+1zMYp087ToBmJzbdI90iE3nQMpmEsgMY/DSGsAabj4RLB9cT8dNmHX2qhBSFMHfA2PHb4b/H6Er2NByLYish1sFODxZl6AJdAcB/1Kmw9vhAbXhqCKslr03kqncuShIRdGu/1ma5hsiZzAphVsnnbyqnCPzTpylW8x4VDRIkahh3mYplHw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DED673F2FE1A840A65621E0A48CF341@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73914106-ac14-4b75-10d0-08d6f64de8c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 13:39:40.9632 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4522
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.110
Subject: Re: [Qemu-devel] [PATCH v5 34/42] block: Inline
 bdrv_co_block_status_from_*()
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

MTMuMDYuMjAxOSAxOjA5LCBNYXggUmVpdHogd3JvdGU6DQo+IFdpdGggYmRydl9maWx0ZXJlZF9y
d19icygpLCB3ZSBjYW4gZWFzaWx5IGhhbmRsZSB0aGlzIGRlZmF1bHQgZmlsdGVyDQo+IGJlaGF2
aW9yIGluIGJkcnZfY29fYmxvY2tfc3RhdHVzKCkuDQo+IA0KPiBibGtkZWJ1ZyB3YW50cyB0byBo
YXZlIGFuIGFkZGl0aW9uYWwgYXNzZXJ0aW9uLCBzbyBpdCBrZWVwcyBpdHMgb3duDQo+IGltcGxl
bWVudGF0aW9uLCBleGNlcHQgYmRydl9jb19ibG9ja19zdGF0dXNfZnJvbV9maWxlKCkgbmVlZHMg
dG8gYmUNCj4gaW5saW5lZCB0aGVyZS4NCj4gDQo+IFN1Z2dlc3RlZC1ieTogRXJpYyBCbGFrZTxl
Ymxha2VAcmVkaGF0LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTWF4IFJlaXR6PG1yZWl0ekByZWRo
YXQuY29tPg0KDQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNl
bWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

