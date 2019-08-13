Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EECC32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 15:02:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DECAA205F4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 15:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EdEB31Ps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DECAA205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxYJS-0003HI-1f
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 11:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44679)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxYI4-0001er-Qe
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:00:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxYI1-0003oq-Gn
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:00:48 -0400
Received: from mail-eopbgr30130.outbound.protection.outlook.com
 ([40.107.3.130]:52034 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxYI1-0003oH-1T; Tue, 13 Aug 2019 11:00:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOkOkM6e27uG06sOTpBycHl9WRleFQ5Wh11dSL9PYvg4Wrb6OyBVTbY+kNantSjqw/0D+rnOFYwL2wbrVdHyI4+TEAnS3cKYS7K0D6ghwoCLA/BbOJZ/lacJjO4XeQ0j4nNBx0lVl83WnSsrMtXiVnh8l6sTh7q+0tiY38hnNCVe/SoGrtHl+aH5BiLGFjvqm9wx13C1wc9hgJzUbnH+fBuOiktulTQHQw3MU/fdTpzd/Xrm1Nba7EFbmZDBys0WG9MQMiZzuEvOM6pQwwJE4WE9ALKxlKEAXDY8SqfD/lR45QzU8KEoGU2ojiNnclHDd6LCIRBTefjaQ++bvSRFHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLA09pLYLeslizzpenTuEXVR/ZNb4k9w3wXTC+Gi3Lc=;
 b=DJbs+b54v7l5vZmI9OzASM9SawtFI2A1e3OyrCKiQbWqzt94uuYdr6zMtA8/ifgI+YXMQYB7vPyVBKrhogHRS9P62g0Cri/wc66309R5iepyAVYrcuWXe+uxo5bKTrND5NmQrPWQXlKV3NJIBZctgAbnW84dOe5vgEwtlVJjMU+D1V8Q3wvEyatNlJqMpE9DayNDeOH82JL+BVkTGvrJt47Wx5vfMZMfMrjOhxzUbyflOCxBFt4IxYRcjBS4m+1VRKEAw6oJUOFcmbhm54pkZQnYojwpBW1aKFEOVW6y6CDsqmZiVFBK3COZGnR2yz5E5z31kGXWinag7mCuq8U9hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLA09pLYLeslizzpenTuEXVR/ZNb4k9w3wXTC+Gi3Lc=;
 b=EdEB31Ps11JJDsYMKNm3iGYxix6MMDPyhS+QUrf0qje5xR3sJXxodwc4DyA7b1f3wh18NK2f0YnOgwOMXWQUBDxoCjL9xTqS2cqiQG5pLP/32x81HdNT+C2ydyc3+9oKKl9hlJR9uYduFyh6OjuCWZlVxcu2u/fDwU+scHLdBCA=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5083.eurprd08.prod.outlook.com (10.255.18.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Tue, 13 Aug 2019 15:00:42 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 15:00:42 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v3 6/7] block/backup: teach backup_cow_with_bounce_buffer
 to copy more at once
Thread-Index: AQHVT7JML2nk8Wsax0eUZCBvWTBktKb3oMEAgAAKYwCAAAavAIAABzYAgAFqYoCAAAKCAIAANuAA///SwQCAAADLAA==
Date: Tue, 13 Aug 2019 15:00:42 +0000
Message-ID: <9479f6b6-3cfe-8594-d8fc-9a66c8f799c1@virtuozzo.com>
References: <20190810193155.58637-1-vsementsov@virtuozzo.com>
 <20190810193155.58637-7-vsementsov@virtuozzo.com>
 <5102eac9-125b-0719-910f-4adb240732f1@redhat.com>
 <89c87c83-276a-7663-a239-57dbd9f91a30@virtuozzo.com>
 <ecff86a8-57d1-4c8a-d4b4-95524471d249@redhat.com>
 <e3fc5e07-33c6-1fe3-2042-35bdac0a03c3@virtuozzo.com>
 <4093762b-a1bc-d6b1-8358-4f9d1ab52557@virtuozzo.com>
 <e05af208-c7cb-31e6-bfab-62a44f5281e7@redhat.com>
 <cf9718b9-f36d-27f3-ad49-4f6fb1e1d7b3@virtuozzo.com>
 <9b7a3060-4880-9ef4-89f2-e8327ce655b8@redhat.com>
In-Reply-To: <9b7a3060-4880-9ef4-89f2-e8327ce655b8@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR08CA0057.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::28) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190813180040271
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82963336-8728-41a1-1e16-08d71fff031a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5083; 
x-ms-traffictypediagnostic: DB8PR08MB5083:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB5083DC086C0D0F3293E75905C1D20@DB8PR08MB5083.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(39840400004)(366004)(346002)(376002)(199004)(52314003)(51444003)(189003)(6436002)(31686004)(66476007)(64756008)(53546011)(66946007)(81166006)(386003)(99286004)(8676002)(66446008)(66556008)(186003)(71200400001)(81156014)(6506007)(478600001)(71190400001)(486006)(305945005)(102836004)(4326008)(6486002)(76176011)(52116002)(6116002)(3846002)(7736002)(2616005)(229853002)(6512007)(316002)(14454004)(476003)(86362001)(54906003)(446003)(110136005)(8936002)(11346002)(25786009)(14444005)(2501003)(5660300002)(2906002)(6246003)(256004)(107886003)(36756003)(31696002)(26005)(66066001)(53936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5083;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2h9pkdxPpg/ZPs+LKGlBER4SWMSxnwwrv/T4UNnXQhdZu1SESH40SCCPyxTYaFfQ61kQl6Mh0uEZ/7r+ZHQNgaWQXEJ+eMkhx4u7hr8s6auRUDAQKRCBehQyw2jsHIzGOCRkI6Y2QTRRku+QHsYYn6Ygf+5JfPu9ZbwIkv/G2UYPuc3kBJj5DMZzo8joZnNADLLui3bum2OWdKzjV7F417Jc9Ou+Ez8f7ilXCc0YX6Fhn3PZSOLsLK2GlkfpVS0gOlXy35VcjoluJ0k7wzu74HVqz97ZL6UqPr9Ukq1pgt/gEUeRVZkdWHkHbU82X5wec+rYlHeZW1tuNrbVk6ir9ui3zHggtc5W+D9MV3vQ+nvy7GnA24N36OE5GJKu/zD9wBRKl37O5NsL1W89veabOwoP5+xB7qlN5j13ssV4d0o=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AABA407AA3DF7478E356B49198F238E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82963336-8728-41a1-1e16-08d71fff031a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 15:00:42.7210 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 13174rJqywBklT6ULSBhCzzsBjGnbbjmquRjlXb4LSqR0OHv97ZsfQSmByb/kodo/wquTfoQmcALcqvRn1IyvMOJtAYBpvsuXPGM47YKWUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5083
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.130
Subject: Re: [Qemu-devel] [PATCH v3 6/7] block/backup: teach
 backup_cow_with_bounce_buffer to copy more at once
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTMuMDguMjAxOSAxNzo1NywgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxMy4wOC4xOSAxNjozOSwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDEzLjA4LjIwMTkgMTc6MjMs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAxMy4wOC4xOSAxNjoxNCwgVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gMTIuMDguMjAxOSAxOTozNywgVmxhZGltaXIgU2Vt
ZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4+IDEyLjA4LjIwMTkgMTk6MTEsIE1heCBSZWl0
eiB3cm90ZToNCj4+Pj4+PiBPbiAxMi4wOC4xOSAxNzo0NywgVmxhZGltaXIgU2VtZW50c292LU9n
aWV2c2tpeSB3cm90ZToNCj4+Pj4+Pj4gMTIuMDguMjAxOSAxODoxMCwgTWF4IFJlaXR6IHdyb3Rl
Og0KPj4+Pj4+Pj4gT24gMTAuMDguMTkgMjE6MzEsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNr
aXkgd3JvdGU6DQo+Pj4+Pj4+Pj4gYmFja3VwX2Nvd193aXRoX29mZmxvYWQgY2FuIHRyYW5zZmVy
IG1vcmUgdGhhbiBvbmUgY2x1c3Rlci4gTGV0DQo+Pj4+Pj4+Pj4gYmFja3VwX2Nvd193aXRoX2Jv
dW5jZV9idWZmZXIgYmVoYXZlIHNpbWlsYXJseS4gSXQgcmVkdWNlcyB0aGUgbnVtYmVyDQo+Pj4+
Pj4+Pj4gb2YgSU8gcmVxdWVzdHMsIHNpbmNlIHRoZXJlIGlzIG5vIG5lZWQgdG8gY29weSBjbHVz
dGVyIGJ5IGNsdXN0ZXIuDQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+PiBMb2dpYyBhcm91bmQgYm91bmNl
X2J1ZmZlciBhbGxvY2F0aW9uIGNoYW5nZWQ6IHdlIGNhbid0IGp1c3QgYWxsb2NhdGUNCj4+Pj4+
Pj4+PiBvbmUtY2x1c3Rlci1zaXplZCBidWZmZXIgdG8gc2hhcmUgZm9yIGFsbCBpdGVyYXRpb25z
LiBXZSBjYW4ndCBhbHNvDQo+Pj4+Pj4+Pj4gYWxsb2NhdGUgYnVmZmVyIG9mIGZ1bGwtcmVxdWVz
dCBsZW5ndGggaXQgbWF5IGJlIHRvbyBsYXJnZSwgc28NCj4+Pj4+Pj4+PiBCQUNLVVBfTUFYX0JP
VU5DRV9CVUZGRVIgaXMgaW50cm9kdWNlZC4gQW5kIGZpbmFsbHksIGFsbG9jYXRpb24gbG9naWMN
Cj4+Pj4+Pj4+PiBpcyB0byBhbGxvY2F0ZSBhIGJ1ZmZlciBzdWZmaWNpZW50IHRvIGhhbmRsZSBh
bGwgcmVtYWluaW5nIGl0ZXJhdGlvbnMNCj4+Pj4+Pj4+PiBhdCB0aGUgcG9pbnQgd2hlcmUgd2Ug
bmVlZCB0aGUgYnVmZmVyIGZvciB0aGUgZmlyc3QgdGltZS4NCj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+
IEJvbnVzOiBnZXQgcmlkIG9mIHBvaW50ZXItdG8tcG9pbnRlci4NCj4+Pj4+Pj4+Pg0KPj4+Pj4+
Pj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRz
b3ZAdmlydHVvenpvLmNvbT4NCj4+Pj4+Pj4+PiAtLS0NCj4+Pj4+Pj4+PiAgIMKgwqAgYmxvY2sv
YmFja3VwLmMgfCA2NSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KPj4+Pj4+Pj4+ICAgwqDCoCAxIGZpbGUgY2hhbmdlZCwgNDEgaW5zZXJ0aW9ucygr
KSwgMjQgZGVsZXRpb25zKC0pDQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvYmxv
Y2svYmFja3VwLmMgYi9ibG9jay9iYWNrdXAuYw0KPj4+Pj4+Pj4+IGluZGV4IGQ0ODJkOTM0NTgu
LjY1ZjcyMTJjODUgMTAwNjQ0DQo+Pj4+Pj4+Pj4gLS0tIGEvYmxvY2svYmFja3VwLmMNCj4+Pj4+
Pj4+PiArKysgYi9ibG9jay9iYWNrdXAuYw0KPj4+Pj4+Pj4+IEBAIC0yNyw2ICsyNyw3IEBADQo+
Pj4+Pj4+Pj4gICDCoMKgICNpbmNsdWRlICJxZW11L2Vycm9yLXJlcG9ydC5oIg0KPj4+Pj4+Pj4+
ICAgwqDCoCAjZGVmaW5lIEJBQ0tVUF9DTFVTVEVSX1NJWkVfREVGQVVMVCAoMSA8PCAxNikNCj4+
Pj4+Pj4+PiArI2RlZmluZSBCQUNLVVBfTUFYX0JPVU5DRV9CVUZGRVIgKDY0ICogMTAyNCAqIDEw
MjQpDQo+Pj4+Pj4+Pj4gICDCoMKgIHR5cGVkZWYgc3RydWN0IENvd1JlcXVlc3Qgew0KPj4+Pj4+
Pj4+ICAgwqDCoMKgwqDCoMKgIGludDY0X3Qgc3RhcnRfYnl0ZTsNCj4+Pj4+Pj4+PiBAQCAtOTgs
NDQgKzk5LDU1IEBAIHN0YXRpYyB2b2lkIGNvd19yZXF1ZXN0X2VuZChDb3dSZXF1ZXN0ICpyZXEp
DQo+Pj4+Pj4+Pj4gICDCoMKgwqDCoMKgwqAgcWVtdV9jb19xdWV1ZV9yZXN0YXJ0X2FsbCgmcmVx
LT53YWl0X3F1ZXVlKTsNCj4+Pj4+Pj4+PiAgIMKgwqAgfQ0KPj4+Pj4+Pj4+IC0vKiBDb3B5IHJh
bmdlIHRvIHRhcmdldCB3aXRoIGEgYm91bmNlIGJ1ZmZlciBhbmQgcmV0dXJuIHRoZSBieXRlcyBj
b3BpZWQuIElmDQo+Pj4+Pj4+Pj4gLSAqIGVycm9yIG9jY3VycmVkLCByZXR1cm4gYSBuZWdhdGl2
ZSBlcnJvciBudW1iZXIgKi8NCj4+Pj4+Pj4+PiArLyoNCj4+Pj4+Pj4+PiArICogQ29weSByYW5n
ZSB0byB0YXJnZXQgd2l0aCBhIGJvdW5jZSBidWZmZXIgYW5kIHJldHVybiB0aGUgYnl0ZXMgY29w
aWVkLiBJZg0KPj4+Pj4+Pj4+ICsgKiBlcnJvciBvY2N1cnJlZCwgcmV0dXJuIGEgbmVnYXRpdmUg
ZXJyb3IgbnVtYmVyDQo+Pj4+Pj4+Pj4gKyAqDQo+Pj4+Pj4+Pj4gKyAqIEBib3VuY2VfYnVmZmVy
IGlzIGFzc3VtZWQgdG8gZW5vdWdoIHRvIHN0b3JlDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gcy90by90
byBiZS8NCj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4gKyAqIE1JTihCQUNLVVBfTUFYX0JPVU5DRV9CVUZG
RVIsIEBlbmQgLSBAc3RhcnQpIGJ5dGVzDQo+Pj4+Pj4+Pj4gKyAqLw0KPj4+Pj4+Pj4+ICAgwqDC
oCBzdGF0aWMgaW50IGNvcm91dGluZV9mbiBiYWNrdXBfY293X3dpdGhfYm91bmNlX2J1ZmZlcihC
YWNrdXBCbG9ja0pvYiAqam9iLA0KPj4+Pj4+Pj4+ICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQ2NF90IHN0YXJ0LA0KPj4+Pj4+Pj4+
ICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpbnQ2NF90IGVuZCwNCj4+Pj4+Pj4+PiAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYm9vbCBpc193cml0ZV9ub3RpZmllciwNCj4+Pj4+
Pj4+PiAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgYm9vbCAqZXJyb3JfaXNfcmVhZCwNCj4+Pj4+Pj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2b2lkICoqYm91bmNlX2J1ZmZlcikNCj4+
Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB2b2lkICpib3VuY2VfYnVmZmVyKQ0KPj4+Pj4+Pj4+ICAgwqDCoCB7DQo+Pj4+Pj4+Pj4gICDC
oMKgwqDCoMKgwqAgaW50IHJldDsNCj4+Pj4+Pj4+PiAgIMKgwqDCoMKgwqDCoCBCbG9ja0JhY2tl
bmQgKmJsayA9IGpvYi0+Y29tbW9uLmJsazsNCj4+Pj4+Pj4+PiAtwqDCoMKgIGludCBuYnl0ZXM7
DQo+Pj4+Pj4+Pj4gK8KgwqDCoCBpbnQgbmJ5dGVzLCByZW1haW5pbmdfYnl0ZXM7DQo+Pj4+Pj4+
Pj4gICDCoMKgwqDCoMKgwqAgaW50IHJlYWRfZmxhZ3MgPSBpc193cml0ZV9ub3RpZmllciA/IEJE
UlZfUkVRX05PX1NFUklBTElTSU5HIDogMDsNCj4+Pj4+Pj4+PiAgIMKgwqDCoMKgwqDCoCBhc3Nl
cnQoUUVNVV9JU19BTElHTkVEKHN0YXJ0LCBqb2ItPmNsdXN0ZXJfc2l6ZSkpOw0KPj4+Pj4+Pj4+
IC3CoMKgwqAgYmRydl9yZXNldF9kaXJ0eV9iaXRtYXAoam9iLT5jb3B5X2JpdG1hcCwgc3RhcnQs
IGpvYi0+Y2x1c3Rlcl9zaXplKTsNCj4+Pj4+Pj4+PiAtwqDCoMKgIG5ieXRlcyA9IE1JTihqb2It
PmNsdXN0ZXJfc2l6ZSwgam9iLT5sZW4gLSBzdGFydCk7DQo+Pj4+Pj4+Pj4gLcKgwqDCoCBpZiAo
ISpib3VuY2VfYnVmZmVyKSB7DQo+Pj4+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgICpib3VuY2VfYnVm
ZmVyID0gYmxrX2Jsb2NrYWxpZ24oYmxrLCBqb2ItPmNsdXN0ZXJfc2l6ZSk7DQo+Pj4+Pj4+Pj4g
LcKgwqDCoCB9DQo+Pj4+Pj4+Pj4gK8KgwqDCoCBiZHJ2X3Jlc2V0X2RpcnR5X2JpdG1hcChqb2It
PmNvcHlfYml0bWFwLCBzdGFydCwgZW5kIC0gc3RhcnQpOw0KPj4+Pj4+Pj4+ICvCoMKgwqAgbmJ5
dGVzID0gTUlOKGVuZCAtIHN0YXJ0LCBqb2ItPmxlbiAtIHN0YXJ0KTsNCj4+Pj4+Pj4+PiAtwqDC
oMKgIHJldCA9IGJsa19jb19wcmVhZChibGssIHN0YXJ0LCBuYnl0ZXMsICpib3VuY2VfYnVmZmVy
LCByZWFkX2ZsYWdzKTsNCj4+Pj4+Pj4+PiAtwqDCoMKgIGlmIChyZXQgPCAwKSB7DQo+Pj4+Pj4+
Pj4gLcKgwqDCoMKgwqDCoMKgIHRyYWNlX2JhY2t1cF9kb19jb3dfcmVhZF9mYWlsKGpvYiwgc3Rh
cnQsIHJldCk7DQo+Pj4+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgIGlmIChlcnJvcl9pc19yZWFkKSB7
DQo+Pj4+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKmVycm9yX2lzX3JlYWQgPSB0cnVl
Ow0KPj4+Pj4+Pj4+ICsNCj4+Pj4+Pj4+PiArwqDCoMKgIHJlbWFpbmluZ19ieXRlcyA9IG5ieXRl
czsNCj4+Pj4+Pj4+PiArwqDCoMKgIHdoaWxlIChyZW1haW5pbmdfYnl0ZXMpIHsNCj4+Pj4+Pj4+
PiArwqDCoMKgwqDCoMKgwqAgaW50IGNodW5rID0gTUlOKEJBQ0tVUF9NQVhfQk9VTkNFX0JVRkZF
UiwgcmVtYWluaW5nX2J5dGVzKTsNCj4+Pj4+Pj4+PiArDQo+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDC
oMKgIHJldCA9IGJsa19jb19wcmVhZChibGssIHN0YXJ0LCBjaHVuaywgYm91bmNlX2J1ZmZlciwg
cmVhZF9mbGFncyk7DQo+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChyZXQgPCAwKSB7DQo+
Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdHJhY2VfYmFja3VwX2RvX2Nvd19yZWFk
X2ZhaWwoam9iLCBzdGFydCwgcmV0KTsNCj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpZiAoZXJyb3JfaXNfcmVhZCkgew0KPj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgKmVycm9yX2lzX3JlYWQgPSB0cnVlOw0KPj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIH0NCj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGZhaWw7
DQo+Pj4+Pj4+Pj4gICDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+Pj4+Pj4+Pj4gLcKgwqDCoMKg
wqDCoMKgIGdvdG8gZmFpbDsNCj4+Pj4+Pj4+PiAtwqDCoMKgIH0NCj4+Pj4+Pj4+PiAtwqDCoMKg
IHJldCA9IGJsa19jb19wd3JpdGUoam9iLT50YXJnZXQsIHN0YXJ0LCBuYnl0ZXMsICpib3VuY2Vf
YnVmZmVyLA0KPj4+Pj4+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGpvYi0+d3JpdGVfZmxhZ3MpOw0KPj4+Pj4+Pj4+IC3CoMKgwqAgaWYgKHJldCA8
IDApIHsNCj4+Pj4+Pj4+PiAtwqDCoMKgwqDCoMKgwqAgdHJhY2VfYmFja3VwX2RvX2Nvd193cml0
ZV9mYWlsKGpvYiwgc3RhcnQsIHJldCk7DQo+Pj4+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgIGlmIChl
cnJvcl9pc19yZWFkKSB7DQo+Pj4+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKmVycm9y
X2lzX3JlYWQgPSBmYWxzZTsNCj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0ID0gYmxrX2Nv
X3B3cml0ZShqb2ItPnRhcmdldCwgc3RhcnQsIGNodW5rLCBib3VuY2VfYnVmZmVyLA0KPj4+Pj4+
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgam9iLT53cml0ZV9mbGFncyk7DQo+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChyZXQg
PCAwKSB7DQo+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdHJhY2VfYmFja3VwX2Rv
X2Nvd193cml0ZV9mYWlsKGpvYiwgc3RhcnQsIHJldCk7DQo+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaWYgKGVycm9yX2lzX3JlYWQpIHsNCj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICplcnJvcl9pc19yZWFkID0gZmFsc2U7DQo+Pj4+Pj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGdvdG8gZmFpbDsNCj4+Pj4+Pj4+PiAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+Pj4+Pj4+
PiAtwqDCoMKgwqDCoMKgwqAgZ290byBmYWlsOw0KPj4+Pj4+Pj4+ICsNCj4+Pj4+Pj4+PiArwqDC
oMKgwqDCoMKgwqAgc3RhcnQgKz0gY2h1bms7DQo+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHJl
bWFpbmluZ19ieXRlcyAtPSBjaHVuazsNCj4+Pj4+Pj4+PiAgIMKgwqDCoMKgwqDCoCB9DQo+Pj4+
Pj4+Pj4gICDCoMKgwqDCoMKgwqAgcmV0dXJuIG5ieXRlczsNCj4+Pj4+Pj4+PiBAQCAtMzAxLDkg
KzMxMywxNCBAQCBzdGF0aWMgaW50IGNvcm91dGluZV9mbiBiYWNrdXBfZG9fY293KEJhY2t1cEJs
b2NrSm9iICpqb2IsDQo+Pj4+Pj4+Pj4gICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0N
Cj4+Pj4+Pj4+PiAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+Pj4+Pj4+PiAgIMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGlmICgham9iLT51c2VfY29weV9yYW5nZSkgew0KPj4+Pj4+Pj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGlmICghYm91bmNlX2J1ZmZlcikgew0KPj4+Pj4+Pj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2l6ZV90IGxlbiA9IE1JTihCQUNLVVBfTUFYX0JP
VU5DRV9CVUZGRVIsDQo+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTUFYKGRpcnR5X2VuZCAtIHN0YXJ0LCBl
bmQgLSBkaXJ0eV9lbmQpKTsNCj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGJvdW5jZV9idWZmZXIgPSBibGtfdHJ5X2Jsb2NrYWxpZ24oam9iLT5jb21tb24uYmxrLCBs
ZW4pOw0KPj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+Pj4+Pj4+DQo+Pj4+
Pj4+PiBJZiB5b3UgdXNlIF90cnlfLCB5b3Ugc2hvdWxkIHByb2JhYmx5IGFsc28gY2hlY2sgd2hl
dGhlciBpdCBzdWNjZWVkZWQuDQo+Pj4+Pj4+DQo+Pj4+Pj4+IE9vcHMsIHlvdSBhcmUgcmlnaHQs
IG9mIGNvdXJzZS4NCj4+Pj4+Pj4NCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBBbnl3YXksIEkgd29uZGVy
IHdoZXRoZXIgaXTigJlkIGJlIGJldHRlciB0byBqdXN0IGFsbG9jYXRlIHRoaXMgYnVmZmVyDQo+
Pj4+Pj4+PiBvbmNlIHBlciBqb2IgKHRoZSBmaXJzdCB0aW1lIHdlIGdldCBoZXJlLCBwcm9iYWJs
eSkgdG8gYmUgb2Ygc2l6ZQ0KPj4+Pj4+Pj4gQkFDS1VQX01BWF9CT1VOQ0VfQlVGRkVSIGFuZCBw
dXQgaXQgaW50byBCYWNrdXBCbG9ja0pvYi7CoCAoQW5kIG1heWJlIGFkZA0KPj4+Pj4+Pj4gYSBi
dWYtc2l6ZSBwYXJhbWV0ZXIgc2ltaWxhciB0byB3aGF0IHRoZSBtaXJyb3Igam9icyBoYXZlLikN
Cj4+Pj4+Pj4+DQo+Pj4+Pj4+DQo+Pj4+Pj4+IE9uY2UgcGVyIGpvYiB3aWxsIG5vdCB3b3JrLCBh
cyB3ZSBtYXkgaGF2ZSBzZXZlcmFsIGd1ZXN0IHdyaXRlcyBpbiBwYXJhbGxlbCBhbmQgdGhlcmVm
b3JlDQo+Pj4+Pj4+IHNldmVyYWwgcGFyYWxsZWwgY29weS1iZWZvcmUtd3JpdGUgb3BlcmF0aW9u
cy4NCj4+Pj4+Pg0KPj4+Pj4+IEhtLsKgIEnigJltIG5vdCBxdWl0ZSBoYXBweSB3aXRoIHRoYXQg
YmVjYXVzZSBpZiB0aGUgZ3Vlc3QganVzdCBpc3N1ZXMgbWFueQ0KPj4+Pj4+IGxhcmdlIGRpc2Nh
cmRzIGluIHBhcmFsbGVsLCB0aGlzIG1lYW5zIHRoYXQgcWVtdSB3aWxsIGFsbG9jYXRlIGEgbGFy
Z2UNCj4+Pj4+PiBhbW91bnQgb2YgbWVtb3J5Lg0KPj4+Pj4+DQo+Pj4+Pj4gSXQgd291bGQgYmUg
bmljZSBpZiB0aGVyZSB3YXMgYSBzaW1wbGUgd2F5IHRvIGtlZXAgdHJhY2sgb2YgdGhlIHRvdGFs
DQo+Pj4+Pj4gbWVtb3J5IHVzYWdlIGFuZCBsZXQgcmVxdWVzdHMgeWllbGQgaWYgdGhleSB3b3Vs
ZCBleGNlZWQgaXQuDQo+Pj4+Pg0KPj4+Pj4gQWdyZWUsIGl0IHNob3VsZCBiZSBmaXhlZCBhbnl3
YXkuDQo+Pj4+Pg0KPj4+Pg0KPj4+Pg0KPj4+PiBCdXQgc3RpbGwuLg0KPj4+Pg0KPj4+PiBTeW5j
aHJvbm91cyBtaXJyb3IgYWxsb2NhdGVzIGZ1bGwtcmVxdWVzdCBidWZmZXJzIG9uIGd1ZXN0IHdy
aXRlLiBJcyBpdCBjb3JyZWN0Pw0KPj4+Pg0KPj4+PiBJZiB3ZSBhc3N1bWUgdGhhdCBpdCBpcyBj
b3JyZWN0IHRvIGRvdWJsZSBtZW1vcnkgdXNhZ2Ugb2YgZ3Vlc3Qgb3BlcmF0aW9ucywgdGhhbiBm
b3IgYmFja3VwDQo+Pj4+IHRoZSBwcm9ibGVtIGlzIG9ubHkgaW4gd3JpdGVfemVybyBhbmQgZGlz
Y2FyZCB3aGVyZSBndWVzdC1hc3N1bWVkIG1lbW9yeSB1c2FnZSBzaG91bGQgYmUgemVyby4NCj4+
Pg0KPj4+IFdlbGwsIGJ1dCB0aGF0IGlzIHRoZSBwcm9ibGVtLiAgSSBkaWRu4oCZdCBzYXkgYW55
dGhpbmcgaW4gdjIsIGJlY2F1c2UgSQ0KPj4+IG9ubHkgdGhvdWdodCBvZiBub3JtYWwgd3JpdGVz
IGFuZCBJIGZvdW5kIGl0IGZpbmUgdG8gZG91YmxlIHRoZSBtZW1vcnkNCj4+PiB1c2FnZSB0aGVy
ZSAoYSBndWVzdCB3b27igJl0IGlzc3VlIGh1Z2Ugd3JpdGUgcmVxdWVzdHMgaW4gcGFyYWxsZWwp
LiAgQnV0DQo+Pj4gZGlzY2FyZC93cml0ZS16ZXJvZXMgYXJlIGEgZGlmZmVyZW50IG1hdHRlci4N
Cj4+Pg0KPj4+PiBBbmQgaWYgd2Ugc2hvdWxkIGRpc3Rpbmd1aXNoIHdyaXRlcyBmcm9tIHdyaXRl
X3plcm9lcyBhbmQgZGlzY2FyZCwgaXQncyBiZXR0ZXIgdG8gcG9zdHBvbmUgdGhpcw0KPj4+PiBp
bXByb3ZlbWVudCB0byBiZSBhZnRlciBiYWNrdXAtdG9wIGZpbHRlciBtZXJnZWQuDQo+Pj4NCj4+
PiBCdXQgZG8geW91IG5lZWQgdG8gZGlzdGluZ3Vpc2ggaXQ/ICBXaHkgbm90IGp1c3Qga2VlcCB0
cmFjayBvZiBtZW1vcnkNCj4+PiB1c2FnZSBhbmQgcHV0IHRoZSBjdXJyZW50IEkvTyBjb3JvdXRp
bmUgdG8gc2xlZXAgaW4gYSBDb1F1ZXVlIG9yDQo+Pj4gc29tZXRoaW5nLCBhbmQgd2FrZSB0aGF0
IHVwIGF0IHRoZSBlbmQgb2YgYmFja3VwX2RvX2NvdygpPw0KPj4+DQo+Pg0KPj4gMS4gQmVjYXVz
ZSBpZiB3ZSBfY2FuXyBhbGxvdyBkb3VibGluZyBvZiBtZW1vcnksIGl0J3MgbW9yZSBlZmZlY3Rp
dmUgdG8gbm90IHJlc3RyaWN0IGFsbG9jYXRpb25zIG9uDQo+PiBndWVzdCB3cml0ZXMuIEl0J3Mg
anVzdCBzZWVtcyB0byBiZSBtb3JlIGVmZmVjdGl2ZSB0ZWNobmlxdWUuDQo+IA0KPiBCdXQgdGhl
IHByb2JsZW0gd2l0aCBiYWNrdXAgYW5kIHplcm8gd3JpdGVzL2Rpc2NhcmRzIGlzIHRoYXQgdGhl
IG1lbW9yeQ0KPiBpcyBub3QgZG91YmxlZC4gIFRoZSByZXF1ZXN0IGRvZXNu4oCZdCBuZWVkIGFu
eSBtZW1vcnksIGJ1dCB0aGUgQ0JXDQo+IG9wZXJhdGlvbiBkb2VzLCBhbmQgbWF5YmUgbG90cyBv
ZiBpdC4NCj4gDQo+IFNvIHRoZSBndWVzdCBtYXkgaXNzdWUgbWFueSB6ZXJvIHdyaXRlcy9kaXNj
YXJkcyBpbiBwYXJhbGxlbCBhbmQgdGh1cw0KPiBleGhhdXN0IG1lbW9yeSBvbiB0aGUgaG9zdC4N
Cg0KU28gdGhpcyBpcyB0aGUgcmVhc29uIHRvIHNlcGFyYXRlIHdyaXRlcyBmcm9tIHdyaXRlLXpl
cm9zL2Rpc2NyYWRzLiBTbyBhdCBsZWFzdCB3cml0ZSB3aWxsIGJlIGhhcHB5LiBBbmQgSQ0KdGhp
bmsgdGhhdCB3cml0ZSBpcyBtb3JlIG9mdGVuIHJlcXVlc3QgdGhhbiB3cml0ZS16ZXJvL2Rpc2Nh
cmQNCg0KPiANCj4+IDIuIEFueXdheSwgSSdkIGFsbG93IHNvbWUgYWx3YXlzLWF2YWlsYWJsZSBz
aXplIHRvIGFsbG9jYXRlIC0gbGV0IGl0IGJlIG9uZSBjbHVzdGVyLCB3aGljaCB3aWxsIGNvcnJl
c3BvbmQNCj4+IHRvIGN1cnJlbnQgYmVoYXZpb3IgYW5kIHByZXZlbnQgZ3Vlc3QgaW8gaGFuZyBp
biB3b3JzdCBjYXNlLg0KPiANCj4gVGhlIGd1ZXN0IHdvdWxkIG9ubHkgaGFuZyBpZiBpdCB3ZSBo
YXZlIHRvIGNvcHkgbW9yZSB0aGFuIGUuZy4gNjQgTUIgYXQNCj4gYSB0aW1lLiAgQXQgd2hpY2gg
cG9pbnQgSSB0aGluayBpdOKAmXMgbm90IHVucmVhc29uYWJsZSB0byBzZXF1ZW50aWFsaXplDQo+
IHJlcXVlc3RzLg0KPiANCg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

