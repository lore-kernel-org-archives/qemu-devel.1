Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825F6C4740C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 13:52:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 427C221A4C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 13:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="F1idXa3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 427C221A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7K61-00076C-D7
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 09:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i7K4h-0005p2-FD
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 09:51:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i7K4f-0001US-Eq
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 09:51:22 -0400
Received: from mail-eopbgr130134.outbound.protection.outlook.com
 ([40.107.13.134]:36678 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i7K3R-0005Gx-9I; Mon, 09 Sep 2019 09:51:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YM8PSvSB5GzzkcehB+gd02r5YQyHF56iuv6QcPZ4XRReVqeX+O/H9UGUqzJmRbTw+W1KVqLZ48I9fHw2YGBCaycnC8Z/leMJu/TGcPq4d8uyCulmZHgxmZpxqL160pYdijrOhJ/Y/424s7+U3RAdbeGXAOFPVub5mrruwIjlr/3FqLzHPSFpB7Zxycz2RrxlOta63njDav+oyqcz77Ha+KNejBJseZpPd9Gtki4JIEt0OocMp08xu5MwK0A+OCb/Laqfq1Bo0Lq2gCz56NDH0aWQHEpCUs7zsc95eJruubzAsyfrk3i9kAz3AEk373WJLhpwF+wU+eeH3xmEPhNRBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eULBHu6NNXwXmz2m0jNjRRDfmqK4cpI1dC1fmIXOMq0=;
 b=SSSWBnDrYMU2gFP9suVB9wy7vscSeCByDCNdgPXrLXywdGiXLNhrV9uXuZx1jp5SQub3I7W5XI8zpz1AyqQtBSLqJkW1t8uVxjs4E2o+bLKJM6pJ33u6HCaKfzu7V2S6YnobfD5OWDniknIqmhXuYwO65f5Zf2K+RjDrBHDC9avbHyARiB/Kvm0UATypo8MJCIixFgDON/ZsJQjgYqjRI/Yq1/5Ixw7gnMAqa3fVXMwxscpDqxeKOkgp8JZQmj5dchOxxxm4vI69X/OfRk3g1ZDKXVxEeFLfSs8Au5kY2aNH00JGQWxWFgTt/eBhsbbrjKwkaZbXvLoR/MSmoDL4OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eULBHu6NNXwXmz2m0jNjRRDfmqK4cpI1dC1fmIXOMq0=;
 b=F1idXa3Wl7ZM+frRmJUIO23BrwwXEGUSbK86bxe+qnrlImfvTtDAuNYelMj5GACRTzSXd8GoYoBVvkbIOR8NmM28To7p/U3KtMp8E3C5VKSDGTCOPOoLgJToYOyNJOANqROiVSRmxkTeDKwCOM8UEtF/fPRBAkW9Fp4ACP8wFyQ=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5034.eurprd08.prod.outlook.com (10.255.16.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Mon, 9 Sep 2019 13:49:56 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2241.018; Mon, 9 Sep 2019
 13:49:56 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v10 08/14] iotests: prepare 124 and 257 bitmap querying
 for backup-top filter
Thread-Index: AQHVX03IUd/WlwXGP0aefLHYiKxPqqcjZaCAgAAGrwA=
Date: Mon, 9 Sep 2019 13:49:56 +0000
Message-ID: <19a3e738-795f-50a8-27a1-548c9ec5fbdc@virtuozzo.com>
References: <20190830161228.54238-1-vsementsov@virtuozzo.com>
 <20190830161228.54238-9-vsementsov@virtuozzo.com>
 <75066c81-04f5-b849-51a8-c663fea5b60b@redhat.com>
In-Reply-To: <75066c81-04f5-b849-51a8-c663fea5b60b@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0005.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::15) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190909164953970
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52912406-f0ff-450a-6298-08d7352c9983
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5034; 
x-ms-traffictypediagnostic: DB8PR08MB5034:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB50340BF79278CEF66C81714EC1B70@DB8PR08MB5034.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(39840400004)(346002)(136003)(376002)(199004)(189003)(102836004)(186003)(86362001)(6116002)(31696002)(99286004)(316002)(966005)(54906003)(36756003)(81166006)(8936002)(6246003)(6306002)(52116002)(7736002)(7416002)(446003)(4326008)(478600001)(14454004)(256004)(25786009)(107886003)(305945005)(66066001)(66476007)(66946007)(66556008)(66446008)(229853002)(6506007)(6486002)(64756008)(6436002)(386003)(53546011)(53936002)(3846002)(2501003)(81156014)(71190400001)(6512007)(110136005)(486006)(476003)(11346002)(5660300002)(2906002)(26005)(31686004)(2616005)(76176011)(8676002)(71200400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5034;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ueAqZUCVB2AAcIdxFPAVU1746AyuvNyv5A8S9KaDdeZxUDW3GeXiKZUnQNa2JmKDhSaVK+vAUT5QHzXBajpLgaFICRvHbJ6zK6kmlmNVhqngK9wMlWRuRdd4kYRn/tIT66JUr+1VEJTA8m5quw8TJl1V0KeD9C3+TThuu2ZmHhYpOV6NQFFQYL3oInzqvju/Bm/0Cnp15ZElaatBLl4KDKyL7DlHU+YAxlL1nj6tEUUcpdi3bPEEKqEcglTuY2dLT//3d0sKL0PxQbg/3kA2OPEeHpey4ALoe8Zs7JmZWaNI331qN6F0Y5d9WcN8+o7/V3KKRvyyzg2xhoElJDqipC5QctYSonpOZ/em/mqzzIvDWH58fYUrsjog30j9ZatNXySW578ohjchMq7VJt/Say1AYGHAqeFulXf0oQI3roc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12BB43EDFB363C40939CD4625A720577@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52912406-f0ff-450a-6298-08d7352c9983
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 13:49:56.8143 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4tGi8sG2aM6MxJ/sUm1WbFSp/3rMTvE7gMUhcPf289RPB3rieaag/uy4UOnwMacRBkRHw/xYsF3vjes+a6q84T7cKiizW1MWdkti6qp9v0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5034
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.134
Subject: Re: [Qemu-devel] [PATCH v10 08/14] iotests: prepare 124 and 257
 bitmap querying for backup-top filter
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
 "wencongyang2@huawei.com" <wencongyang2@huawei.com>,
 "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDkuMDkuMjAxOSAxNjoyNSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAzMC4wOC4xOSAxODoxMiwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IEFmdGVyIGJhY2t1cC10b3Ag
ZmlsdGVyIGFwcGVhcmluZyBpdCdzIG5vdCBwb3NzaWJsZSB0byBzZWUgZGlydHkNCj4+IGJpdG1h
cHMgaW4gdG9wIG5vZGUsIHNvIHVzZSBub2RlLW5hbWUgaW5zdGVhZC4NCj4+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6
by5jb20+DQo+PiAtLS0NCj4+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzEyNCAgICAgICAgfCAgODMg
KysrKy0tLS0NCj4+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzI1NyAgICAgICAgfCAgNDkgKystLS0N
Cj4+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzI1Ny5vdXQgICAgfCAzNjQgKysrKysrKysrKysrKy0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvaW90ZXN0cy5weSB8
ICAyNyArKysNCj4+ICAgNCBmaWxlcyBjaGFuZ2VkLCAyMTkgaW5zZXJ0aW9ucygrKSwgMzA0IGRl
bGV0aW9ucygtKQ0KPiANCj4gWy4uLl0NCj4gDQo+PiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1p
b3Rlc3RzL2lvdGVzdHMucHkgYi90ZXN0cy9xZW11LWlvdGVzdHMvaW90ZXN0cy5weQ0KPj4gaW5k
ZXggODQ0MzhlODM3Yy4uMTkwNmViNzJmMyAxMDA2NDQNCj4+IC0tLSBhL3Rlc3RzL3FlbXUtaW90
ZXN0cy9pb3Rlc3RzLnB5DQo+PiArKysgYi90ZXN0cy9xZW11LWlvdGVzdHMvaW90ZXN0cy5weQ0K
Pj4gQEAgLTY0Myw2ICs2NDMsMzMgQEAgY2xhc3MgVk0ocXRlc3QuUUVNVVF0ZXN0TWFjaGluZSk6
DQo+IA0KPiBbLi4uXQ0KPiANCj4+ICsgICAgZGVmIGNoZWNrX2JpdG1hcF9zdGF0dXMoc2VsZiwg
bm9kZV9uYW1lLCBiaXRtYXBfbmFtZSwgZmllbGRzKToNCj4+ICsgICAgICAgIHJldCA9IHNlbGYu
Z2V0X2JpdG1hcChub2RlX25hbWUsIGJpdG1hcF9uYW1lKQ0KPj4gKw0KPj4gKyAgICAgICAgcmV0
dXJuIGZpZWxkcy5pdGVtcygpIDw9IHJldC5pdGVtcygpDQo+IA0KPiBXaHkgdGhlIDw9PyAgQUZB
SVUsIGl0IHdpbGwgY29tcGFyZSBlYWNoIG9mIHRoZSBhcnJheXPigJkgZWxlbWVudHMgb25lIGJ5
DQo+IG9uZSBhbmQgcmV0dXJuIHRydWUgaWYgYWxsIG9mIHRoZSBvbmVzIGluIEBmaWVsZHMgYXJl
IGxlc3MgdGhhbiBvciBlcXVhbA0KPiB0byB0aGUgb25lcyBpbiBAcmV0Lg0KDQpObywgaXQncyBh
IHZhbGlkIHdheSB0byBjaGVjayB0aGF0IG9uZSBkaWN0IGlzIHN1YmRpY3Qgb2YgYW5vdGhlciwN
CmFzIGRpY3RfdmlldyB3b3JrcyBsaWtlIFNldCBjbGFzczoNCg0KJCBweXRob24zDQpQeXRob24g
My41LjIgKGRlZmF1bHQsIE5vdiAyMyAyMDE3LCAxNjozNzowMSkNCltHQ0MgNS40LjAgMjAxNjA2
MDldIG9uIGxpbnV4DQpUeXBlICJoZWxwIiwgImNvcHlyaWdodCIsICJjcmVkaXRzIiBvciAibGlj
ZW5zZSIgZm9yIG1vcmUgaW5mb3JtYXRpb24uDQogPj4+IHsxLDIsM30gPD0gezQsNSw2fQ0KRmFs
c2UNCiA+Pj4gezEsMiwzfSA8PSB7MCwzLDIsMX0NClRydWUNCiA+Pj4geydjJzoxLCAnYic6Mn0u
aXRlbXMoKSA8PSB7J2EnOjQsICdiJzoyLCAnYyc6MX0uaXRlbXMoKQ0KVHJ1ZQ0KID4+PiB7J2Mn
OjEsICdiJzoyfS5pdGVtcygpIDw9IHsnYSc6NCwgJ2InOjIsICdjJzoyfS5pdGVtcygpDQpGYWxz
ZQ0KID4+PiB7J2MnOjEsICdiJzoyfS5pdGVtcygpIDw9IHsnYSc6NCwgJ2InOjIsICdjJzowfS5p
dGVtcygpDQpGYWxzZQ0KID4+PiB7J2MnOjEsICdiJzoyfS5pdGVtcygpIDw9IHsnZCc6NCwgJ2In
OjJ9Lml0ZW1zKCkNCkZhbHNlDQogPj4+IHsnYyc6MSwgJ2InOjJ9Lml0ZW1zKCkgPD0geydjJzox
LCAnYic6M30uaXRlbXMoKQ0KRmFsc2UNCg0KQmFkIHRoaW5nIGlzIHRoYXQgaXQncyBub3Qgc28g
Zm9yIHB5dGhvbjIsIGluIHdoaWNoIHdlIG5lZWQgdG8gdXNlIC52aWV3aXRlbXMoKSBpbnN0ZWFk
Li4NCg0KJCBweXRob24yDQpQeXRob24gMi43LjEyIChkZWZhdWx0LCBEZWMgIDQgMjAxNywgMTQ6
NTA6MTgpDQpbR0NDIDUuNC4wIDIwMTYwNjA5XSBvbiBsaW51eDINClR5cGUgImhlbHAiLCAiY29w
eXJpZ2h0IiwgImNyZWRpdHMiIG9yICJsaWNlbnNlIiBmb3IgbW9yZSBpbmZvcm1hdGlvbi4NCiA+
Pj4gezEsMiwzfSA8PSB7MCwzLDIsMX0NClRydWUNCiA+Pj4geydjJzoxLCAnYic6Mn0uaXRlbXMo
KSA8PSB7J2EnOjQsICdiJzoyLCAnYyc6MX0uaXRlbXMoKQ0KRmFsc2UNCiA+Pj4geydjJzoxLCAn
Yic6Mn0uaXRlbXMoKSA8PSB7J2QnOjQsICdiJzoyfS5pdGVtcygpDQpGYWxzZQ0KID4+Pg0KID4+
PiB7J2MnOjEsICdiJzoyfS5pdGVtcygpIDw9IHsnYyc6MSwgJ2InOjJ9Lml0ZW1zKCkNClRydWUN
CiA+Pj4geydjJzoxLCAnYic6Mn0uaXRlbXMoKSA8PSB7J2MnOjEsICdiJzozfS5pdGVtcygpDQpU
cnVlDQogPj4+IHsnYyc6MSwgJ2InOjJ9Lml0ZW1zKCkgPD0geydjJzoxLCAnYic6M30uaXRlbXMo
KQ0KVHJ1ZQ0KDQpTaG91bGQgSSBjYXJlIGFib3V0IHB5dGhvbjIgbm93LCBvciB3ZSBhbHJlYWR5
IGRyb3BwZWQgaXRzIHN1cHBvcnQgaW4gaW90ZXN0cz8NCg0KW2FuZCwgaG9uZXN0bHksIEkgbGVh
cm5lZCBpdCBhbGwgbW9zdGx5IGZyb20gaGVyZSBodHRwczovL3N0YWNrb3ZlcmZsb3cuY29tL3F1
ZXN0aW9ucy8zMDgxODY5NC90ZXN0LWlmLWRpY3QtY29udGFpbmVkLWluLWRpY3RdDQoNCj4gDQo+
IEJ1dCB0aGF0IHdvdWxkIG1lYW4gdGhhdCB0aGUgdmFsdWVzIGdpdmVuIGluIEBmaWVsZHMgbm8g
bG9uZ2VyIG5lZWQgdG8NCj4gYmUgZXF1YWwgdG8gdGhlIG9uZXMgaW4gQHJldC4gIE9uIHRvcCBv
ZiB0aGF0LCBJIHN1cHBvc2UgaWYNCj4gQGZpZWxkcy5pdGVtcygpIGF0IHNvbWUgaW5kZXggY29u
dGFpbnMgYSBrZXkgdGhhdCBpcyBub3QgZXF1YWwgdG8gdGhlDQo+IGtleSBpbiBAcmV0Lml0ZW1z
KCkgYXQgdGhlIHNhbWUgaW5kZXgsIGx1Y2sgd2lsbCBkZXRlcm1pbmUgd2hldGhlciB0aGUNCj4g
Y29tcGFyaXNvbiBwYXNzZXMgb3Igbm90Lg0KPiANCj4gV2h5IG5vdCBqdXN0IGxvb3AgdGhyb3Vn
aCBhbGwga2V5cyBvZiBAZmllbGRzIGFuZCBjaGVjayB0aGF0IEBmaWVsZHMgYW5kDQo+IEByZXQg
Y29udGFpbiB0aGUgc2FtZSB2YWx1ZSBmb3IgYWxsIG9mIHRoZW0/DQo+IA0KPiBNYXgNCj4gDQoN
Cg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

