Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514C4C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 08:22:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D13021848
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 08:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="tPoOYG/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D13021848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iArhX-0006cy-09
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 04:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iArgF-0005pj-Mx
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iArgD-0002wg-Vh
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:20:47 -0400
Received: from mail-eopbgr40121.outbound.protection.outlook.com
 ([40.107.4.121]:29402 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iArfy-0002qz-Cq; Thu, 19 Sep 2019 04:20:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUy9Bpn4DHUIKP1g/4HXbwccJve7WtGzIVnyXFz9DGTgYQsyFvwYHv0YFeBNajLaxWG14dNRo06dkRwIH18iMwMbeHrDcfyZbIvRWN02zQ+CiuyuB+6H6ysEIPWtb8ZdaXJSPFkYeHx1z1WdTGvnbBM1fLAbpXb9GIyoKtrDfK/wtRdLHD0IuVzS0ozkz0tL5XsBocDc+/Blwy9i7td4hi9j0VKPz/ViauoASlawwOvxY08t0Jnlx+FAsy0wIKpatohi0Ix37Nlqkr93KhwgztZXOqs8d3qE8MXDiIyKIMrwvtcUe8+smoJ5KCN+/z/wUszMqczBlVQ7KX9wbF5cKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DElDUBwcFb0MQtkKFgnTRMitsyAHPehzynEuK+hFxOE=;
 b=XE7eVt1hrT+JayAqKv+wZELl9AxQbjCkM7GAdVT2lOK3sp2HvU2J7DlNP7Euwt4PvUfqc7JB8hmZIzbQ7M5OaKe+XETJRX+0be4ZpO95qpjPtsHAzkhpPln74wxy+Lq3DSO116Qqr9ZerReiw0sjrpFD3LRh/jxXxixxMBjDuYt1NDOwAK91KF2G2pY1HjnGIbGKwXR/VMH2YpS/EKwJAFTJgk389NMdN49IzC4MDoICitdjrvXeXbrlJub3a+XnLWJ6amRvN1FCWW/6z6HuT5Zt7cOKuuLPM0SObZt+7cw8fjnfu+tT1e71Fsm28LqlUOGgHBA8QbOgaoKbRU73ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DElDUBwcFb0MQtkKFgnTRMitsyAHPehzynEuK+hFxOE=;
 b=tPoOYG/g3/2aZafvXEIvG44Ok26vk6ox2a6F9qD5eZj7Em/RaWswW8pBJhSPKXxLUfIv71RHFeV+0mSq3XdfNUVFmYA3XXAC8tJr0kvfO9CbodNBvQILZPOgsIDDuA/+E6hSk4fyQ9+ut3LL3mZkzHfohnn4imVxNcM2N6Negh4=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4105.eurprd08.prod.outlook.com (20.179.12.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 19 Sep 2019 08:20:26 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 08:20:26 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: David Hildenbrand <david@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [RFC] error: auto propagated local_err
Thread-Index: AQHVbiFyZhBrSsOpYEOTsgc7Le+SIKcynIsAgAACmwCAAAM3AIAAB4kA
Date: Thu, 19 Sep 2019 08:20:26 +0000
Message-ID: <a4357e52-723c-3829-769b-1dde1c49698a@virtuozzo.com>
References: <20190918130244.24257-1-vsementsov@virtuozzo.com>
 <c4a95138-3c08-0563-d567-aa1828de7e39@redhat.com>
 <9d7ae167-c77c-4d8a-bbbc-c33a03a115e5@virtuozzo.com>
 <0764e9fc-b0ff-12c7-fffb-adf68706383b@redhat.com>
In-Reply-To: <0764e9fc-b0ff-12c7-fffb-adf68706383b@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P192CA0015.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::25)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190919112022100
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c11cdc0-6173-4367-05f4-08d73cda39a6
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4105; 
x-ms-traffictypediagnostic: DB8PR08MB4105:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB8PR08MB41058C72A243A4D793DCAAC3C1890@DB8PR08MB4105.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(346002)(39850400004)(396003)(376002)(53754006)(199004)(189003)(81156014)(31696002)(186003)(6506007)(102836004)(6512007)(86362001)(5660300002)(476003)(2616005)(8936002)(2501003)(52116002)(11346002)(66446008)(66476007)(66556008)(446003)(66946007)(81166006)(8676002)(64756008)(3846002)(2906002)(486006)(110136005)(54906003)(76176011)(99286004)(561944003)(6116002)(316002)(25786009)(7736002)(966005)(6306002)(26005)(14454004)(53546011)(6436002)(6486002)(256004)(229853002)(478600001)(66066001)(4326008)(386003)(6246003)(305945005)(71200400001)(71190400001)(7416002)(36756003)(31686004)(7406005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4105;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Qy2c8B0QFxzLqMLEMcF0YumkUDQER0TlXt1kVVeleY+qetyRBuQglEXajVYvOVKvw3FH7dgr+sGM2zVIBi5aR3Cl6vhT2citPCTNcOh7/G/3XKxWIm+MoLJ/eeb8o8U6BO8x4jHm5gCgJD+iZ5wDIvbkKbomo9MTdKoykrJ842bkUQntBR8De7qLf/2u2mXRmuh7CEUblOviFr4hWlE3hJfz/RAllrdhYdgmfEFQRvfg3YI9UouGquQuHnnpZmZlzY9ghckbdhVXiohDYyDh2Wr+a59RWzqQkAobUf7spsJNnwi2XUqbC3+wo2Wp1xK4fKx4G8B5/u1cVbB2vlz59OsrmsRSVETUhSVutrQT89JfpWEDUZgRo6Ynx2mImhH2lsJxOHLC91XyMu7tx/nvUGA/tJV7UzAPsm0kfbYNR9I=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DE642ED1BD9D54DA267032E0B9BFD26@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c11cdc0-6173-4367-05f4-08d73cda39a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 08:20:26.7335 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qrpz2k4wV2GmUVWj805gwMONJq9Qj3SBBPw6P+GM5Z9qDW7C7OKBsF+j8Pwyh1UFA6KElkEwzvKKwjcjBCIqSwIV+OPFfB3tDjROhdNUtJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4105
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.121
Subject: Re: [Qemu-devel] [RFC] error: auto propagated local_err
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
Cc: "fam@euphon.net" <fam@euphon.net>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "mst@redhat.com" <mst@redhat.com>, "codyprime@gmail.com" <codyprime@gmail.com>,
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "farman@linux.ibm.com" <farman@linux.ibm.com>,
 "groug@kaod.org" <groug@kaod.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "kwolf@redhat.com" <kwolf@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 "sundeep.lkml@gmail.com" <sundeep.lkml@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTkuMDkuMjAxOSAxMDo1MywgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6DQo+IE9uIDE5LjA5LjE5
IDA5OjQxLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gMTkuMDkuMjAx
OSAxMDozMiwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6DQo+Pj4gT24gMTguMDkuMTkgMTU6MDIs
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4+IEhpIGFsbCENCj4+Pj4N
Cj4+Pj4gSGVyZSBpcyBhIHByb3Bvc2FsICh0aHJlZSBvZiB0aGVtLCBhY3R1YWxseSkgb2YgYXV0
byBwcm9wYWdhdGlvbiBmb3INCj4+Pj4gbG9jYWxfZXJyLCB0byBub3QgY2FsbCBlcnJvcl9wcm9w
YWdhdGUgb24gZXZlcnkgZXhpdCBwb2ludCwgd2hlbiB3ZQ0KPj4+PiBkZWFsIHdpdGggbG9jYWxf
ZXJyLg0KPj4+Pg0KPj4+PiBJdCBhbHNvIG1heSBoZWxwIG1ha2UgR3JlZydzIHNlcmllc1sxXSBh
Ym91dCBlcnJvcl9hcHBlbmRfaGludCBzbWFsbGVyLg0KPj4+Pg0KPj4+PiBTZWUgZGVmaW5pdGlv
bnMgYW5kIGV4YW1wbGVzIGJlbG93Lg0KPj4+Pg0KPj4+PiBJJ20gY2MtaW5nIHRvIHRoaXMgUkZD
IGV2ZXJ5b25lIGZyb20gc2VyaWVzWzFdIENDIGxpc3QsIGFzIGlmIHdlIGxpa2UNCj4+Pj4gaXQs
IHRoZSBpZGVhIHdpbGwgdG91Y2ggc2FtZSBjb2RlIChhbmQgbWF5IGJlIG1vcmUpLg0KPj4+Pg0K
Pj4+PiBbMV06IGh0dHBzOi8vbGlzdHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8y
MDE5LTA5L21zZzAzNDQ5Lmh0bWwNCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIg
U2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4+PiAtLS0N
Cj4+Pj4gICAgaW5jbHVkZS9xYXBpL2Vycm9yLmggfCAxMDIgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KPj4+PiAgICBibG9jay5jICAgICAgICAgICAgICB8ICA2
MyArKysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KPj4+PiAgICBibG9jay9iYWNrdXAuYyAgICAg
ICB8ICAgOCArKystDQo+Pj4+ICAgIGJsb2NrL2dsdXN0ZXIuYyAgICAgIHwgICA3ICsrKw0KPj4+
PiAgICA0IGZpbGVzIGNoYW5nZWQsIDE0NCBpbnNlcnRpb25zKCspLCAzNiBkZWxldGlvbnMoLSkN
Cj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvcWFwaS9lcnJvci5oIGIvaW5jbHVkZS9x
YXBpL2Vycm9yLmgNCj4+Pj4gaW5kZXggM2Y5NTE0MWEwMS4uMDgzZTA2MTAxNCAxMDA2NDQNCj4+
Pj4gLS0tIGEvaW5jbHVkZS9xYXBpL2Vycm9yLmgNCj4+Pj4gKysrIGIvaW5jbHVkZS9xYXBpL2Vy
cm9yLmgNCj4+Pj4gQEAgLTMyMiw2ICszMjIsMTA4IEBAIHZvaWQgZXJyb3Jfc2V0X2ludGVybmFs
KEVycm9yICoqZXJycCwNCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3JDbGFz
cyBlcnJfY2xhc3MsIGNvbnN0IGNoYXIgKmZtdCwgLi4uKQ0KPj4+PiAgICAgICAgR0NDX0ZNVF9B
VFRSKDYsIDcpOw0KPj4+PiAgICANCj4+Pj4gK3R5cGVkZWYgc3RydWN0IEVycm9yUHJvcGFnYXRv
ciB7DQo+Pj4+ICsgICAgRXJyb3IgKiplcnJwOw0KPj4+PiArICAgIEVycm9yICpsb2NhbF9lcnI7
DQo+Pj4+ICt9IEVycm9yUHJvcGFnYXRvcjsNCj4+Pj4gKw0KPj4+PiArc3RhdGljIGlubGluZSB2
b2lkIGVycm9yX3Byb3BhZ2F0b3JfY2xlYW51cChFcnJvclByb3BhZ2F0b3IgKnByb3ApDQo+Pj4+
ICt7DQo+Pj4+ICsgICAgaWYgKHByb3AtPmxvY2FsX2Vycikgew0KPj4+PiArICAgICAgICBlcnJv
cl9wcm9wYWdhdGUocHJvcC0+ZXJycCwgcHJvcC0+bG9jYWxfZXJyKTsNCj4+Pj4gKyAgICB9DQo+
Pj4+ICt9DQo+Pj4+ICsNCj4+Pj4gK0dfREVGSU5FX0FVVE9fQ0xFQU5VUF9DTEVBUl9GVU5DKEVy
cm9yUHJvcGFnYXRvciwgZXJyb3JfcHJvcGFnYXRvcl9jbGVhbnVwKTsNCj4+Pj4gKw0KPj4+PiAr
LyoNCj4+Pj4gKyAqIEVycm9yUHJvcGFnYXRpb25QYWlyDQo+Pj4+ICsgKg0KPj4+PiArICogW0Vy
cm9yICpsb2NhbF9lcnIsIEVycm9yICoqZXJycF0NCj4+Pj4gKyAqDQo+Pj4+ICsgKiBGaXJzdCBl
bGVtZW50IGlzIGxvY2FsX2Vyciwgc2Vjb25kIGlzIG9yaWdpbmFsIGVycnAsIHdoaWNoIGlzIHBy
b3BhZ2F0aW9uDQo+Pj4+ICsgKiB0YXJnZXQuIFllcywgZXJycCBoYXMgYSBiaXQgYW5vdGhlciB0
eXBlLCBzbyBpdCBzaG91bGQgYmUgY29udmVydGVkLg0KPj4+PiArICoNCj4+Pj4gKyAqIEVycm9y
UHJvcGFnYXRpb25QYWlyIG1heSBiZSB1c2VkIGFzIGVycnAsIHdoaWNoIHBvaW50cyB0byBsb2Nh
bF9lcnIsDQo+Pj4+ICsgKiBhcyBpdCdzIHR5cGUgaXMgY29tcGF0aWJsZS4NCj4+Pj4gKyAqLw0K
Pj4+PiArdHlwZWRlZiBFcnJvciAqRXJyb3JQcm9wYWdhdGlvblBhaXJbMl07DQo+Pj4+ICsNCj4+
Pj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBlcnJvcl9wcm9wYWdhdGlvbl9wYWlyX2NsZWFudXAoRXJy
b3JQcm9wYWdhdGlvblBhaXIgKmFycikNCj4+Pj4gK3sNCj4+Pj4gKyAgICBFcnJvciAqbG9jYWxf
ZXJyID0gKCphcnIpWzBdOw0KPj4+PiArICAgIEVycm9yICoqZXJycCA9IChFcnJvciAqKikoKmFy
cilbMV07DQo+Pj4+ICsNCj4+Pj4gKyAgICBpZiAobG9jYWxfZXJyKSB7DQo+Pj4+ICsgICAgICAg
IGVycm9yX3Byb3BhZ2F0ZShlcnJwLCBsb2NhbF9lcnIpOw0KPj4+PiArICAgIH0NCj4+Pj4gK30N
Cj4+Pj4gKw0KPj4+PiArR19ERUZJTkVfQVVUT19DTEVBTlVQX0NMRUFSX0ZVTkMoRXJyb3JQcm9w
YWdhdGlvblBhaXIsDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlcnJv
cl9wcm9wYWdhdGlvbl9wYWlyX2NsZWFudXApOw0KPj4+PiArDQo+Pj4+ICsvKg0KPj4+PiArICog
REVGX0FVVE9fRVJSUA0KPj4+PiArICoNCj4+Pj4gKyAqIERlZmluZSBhdXRvX2VycnAgdmFyaWFi
bGUsIHdoaWNoIG1heSBiZSB1c2VkIGluc3RlYWQgb2YgZXJycCwgYW5kDQo+Pj4+ICsgKiAqYXV0
b19lcnJwIG1heSBiZSBzYWZlbHkgY2hlY2tlZCB0byBiZSB6ZXJvIG9yIG5vdCwgYW5kIG1heSBi
ZSBzYWZlbHkNCj4+Pj4gKyAqIHVzZWQgZm9yIGVycm9yX2FwcGVuZF9oaW50KCkuIGF1dG9fZXJy
cCBpcyBhdXRvbWF0aWNhbGx5IHByb3BhZ2F0ZWQNCj4+Pj4gKyAqIHRvIGVycnAgYXQgZnVuY3Rp
b24gZXhpdC4NCj4+Pj4gKyAqLw0KPj4+PiArI2RlZmluZSBERUZfQVVUT19FUlJQKGF1dG9fZXJy
cCwgZXJycCkgXA0KPj4+PiArICAgIGdfYXV0byhFcnJvclByb3BhZ2F0aW9uUGFpcikgKGF1dG9f
ZXJycCkgPSB7TlVMTCwgKEVycm9yICopKGVycnApfQ0KPj4+PiArDQo+Pj4+ICsNCj4+Pj4gKy8q
DQo+Pj4+ICsgKiBBbm90aGVyIHZhcmlhbnQ6DQo+Pj4+ICsgKiAgIFByb3M6DQo+Pj4+ICsgKiAg
ICAgLSBub3JtYWwgc3RydWN0dXJlIGluc3RlYWQgb2YgY2hlYXRpbmcgd2l0aCBhcnJheQ0KPj4+
PiArICogICAgIC0gd2UgY2FuIGRpcmVjdGx5IHVzZSBlcnJwLCBpZiBpdCdzIG5vdCBOVUxMIGFu
ZCBkb24ndCBwb2ludCB0bw0KPj4+PiArICogICAgICAgZXJyb3JfYWJvcnQgb3IgZXJyb3JfZmF0
YWwNCj4+Pj4gKyAqICAgQ29uczoNCj4+Pj4gKyAqICAgICAtIHdlIG5lZWQgdG8gZGVmaW5lIHR3
byB2YXJpYWJsZXMgaW5zdGVhZCBvZiBvbmUNCj4+Pj4gKyAqLw0KPj4+PiArdHlwZWRlZiBzdHJ1
Y3QgRXJyb3JQcm9wYWdhdGlvblN0cnVjdCB7DQo+Pj4+ICsgICAgRXJyb3IgKmxvY2FsX2VycjsN
Cj4+Pj4gKyAgICBFcnJvciAqKmVycnA7DQo+Pj4+ICt9IEVycm9yUHJvcGFnYXRpb25TdHJ1Y3Q7
DQo+Pj4+ICsNCj4+Pj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBlcnJvcl9wcm9wYWdhdGlvbl9zdHJ1
Y3RfY2xlYW51cChFcnJvclByb3BhZ2F0aW9uU3RydWN0ICpwcm9wKQ0KPj4+PiArew0KPj4+PiAr
ICAgIGlmIChwcm9wLT5sb2NhbF9lcnIpIHsNCj4+Pj4gKyAgICAgICAgZXJyb3JfcHJvcGFnYXRl
KHByb3AtPmVycnAsIHByb3AtPmxvY2FsX2Vycik7DQo+Pj4+ICsgICAgfQ0KPj4+PiArfQ0KPj4+
PiArDQo+Pj4+ICtHX0RFRklORV9BVVRPX0NMRUFOVVBfQ0xFQVJfRlVOQyhFcnJvclByb3BhZ2F0
aW9uU3RydWN0LA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZXJyb3Jf
cHJvcGFnYXRpb25fc3RydWN0X2NsZWFudXApOw0KPj4+PiArDQo+Pj4+ICsjZGVmaW5lIERFRl9B
VVRPX0VSUlBfVjIoYXV0b19lcnJwLCBlcnJwKSBcDQo+Pj4+ICsgICAgZ19hdXRvKEVycm9yUHJv
cGFnYXRpb25TdHJ1Y3QpIChfX2F1dG9fZXJycF9wcm9wKSA9IHsuZXJycCA9IChlcnJwKX07IFwN
Cj4+Pj4gKyAgICBFcnJvciAqKmF1dG9fZXJycCA9IFwNCj4+Pj4gKyAgICAgICAgKChlcnJwKSA9
PSBOVUxMIHx8ICooZXJycCkgPT0gZXJyb3JfYWJvcnQgfHwgKihlcnJwKSA9PSBlcnJvcl9mYXRh
bCkgPyBcDQo+Pj4+ICsgICAgICAgICZfX2F1dG9fZXJycF9wcm9wLmxvY2FsX2VyciA6IFwNCj4+
Pj4gKyAgICAgICAgKGVycnApOw0KPj4+PiArDQo+Pj4+ICsvKg0KPj4+PiArICogVGhpcmQgdmFy
aWFudDoNCj4+Pj4gKyAqICAgUHJvczoNCj4+Pj4gKyAqICAgICAtIHNpbXBsZXIgbW92ZW1lbnQg
Zm9yIGZ1bmN0aW9ucyB3aGljaCBkb24ndCBoYXZlIGxvY2FsX2VyciB5ZXQNCj4+Pj4gKyAqICAg
ICAgIHRoZSBvbmx5IHRoaW5nIHRvIGRvIGlzIHRvIGNhbGwgb25lIG1hY3JvIGF0IGZ1bmN0aW9u
IHN0YXJ0Lg0KPj4+PiArICogICAgICAgVGhpcyBleHRyZW1lbHkgc2ltcGxpZmllcyBHcmVnJ3Mg
c2VyaWVzDQo+Pj4+ICsgKiAgIENvbnM6DQo+Pj4+ICsgKiAgICAgLSBsb29rcyBsaWtlIGVycnAg
c2hhZG93aW5nLi4gU3RpbGwgc2VlbXMgc2FmZS4NCj4+Pj4gKyAqICAgICAtIG11c3QgYmUgYWZ0
ZXIgYWxsIGRlZmluaXRpb25zIG9mIGxvY2FsIHZhcmlhYmxlcyBhbmQgYmVmb3JlIGFueQ0KPj4+
PiArICogICAgICAgY29kZS4NCj4+Pj4gKyAqICAgICAtIGxpa2UgdjIsIHNldmVyYWwgc3RhdGVt
ZW50cyBpbiBvbmUgb3BlbiBtYWNybw0KPj4+PiArICovDQo+Pj4+ICsjZGVmaW5lIE1BS0VfRVJS
UF9TQUZFKGVycnApIFwNCj4+Pj4gK2dfYXV0byhFcnJvclByb3BhZ2F0aW9uU3RydWN0KSAoX19h
dXRvX2VycnBfcHJvcCkgPSB7LmVycnAgPSAoZXJycCl9OyBcDQo+Pj4+ICtpZiAoKGVycnApID09
IE5VTEwgfHwgKihlcnJwKSA9PSBlcnJvcl9hYm9ydCB8fCAqKGVycnApID09IGVycm9yX2ZhdGFs
KSB7IFwNCj4+Pj4gKyAgICAoZXJycCkgPSAmX19hdXRvX2VycnBfcHJvcC5sb2NhbF9lcnI7IFwN
Cj4+Pj4gK30NCj4+Pg0KPj4+DQo+Pj4gVXNpbmcgdGhhdCBpZGVhLCB3aGF0IGFib3V0IHNvbWV0
aGluZyBsaWtlIHRoaXM6DQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvaHcvczM5MHgvczM5MC12aXJ0
aW8tY2N3LmMgYi9ody9zMzkweC9zMzkwLXZpcnRpby1jY3cuYw0KPj4+IGluZGV4IDhiZmI2Njg0
Y2IuLjA0M2FkNjlmOGIgMTAwNjQ0DQo+Pj4gLS0tIGEvaHcvczM5MHgvczM5MC12aXJ0aW8tY2N3
LmMNCj4+PiArKysgYi9ody9zMzkweC9zMzkwLXZpcnRpby1jY3cuYw0KPj4+IEBAIC01OCwyMiAr
NTgsNDIgQEAgUzM5MENQVSAqczM5MF9jcHVfYWRkcjJzdGF0ZSh1aW50MTZfdCBjcHVfYWRkcikN
Cj4+PiAgICAgICAgcmV0dXJuIFMzOTBfQ1BVKG1zLT5wb3NzaWJsZV9jcHVzLT5jcHVzW2NwdV9h
ZGRyXS5jcHUpOw0KPj4+ICAgIH0NCj4+PiAgICANCj4+PiArdHlwZWRlZiBzdHJ1Y3QgRXJyb3JQ
cm9wYWdhdG9yIHsNCj4+PiArICAgIEVycm9yICoqZXJycDsNCj4+PiArICAgIEVycm9yICpsb2Nh
bF9lcnI7DQo+Pj4gK30gRXJyb3JQcm9wYWdhdG9yOw0KPj4+ICsNCj4+PiArc3RhdGljIGlubGlu
ZSB2b2lkIGVycm9yX3Byb3BhZ2F0b3JfY2xlYW51cChFcnJvclByb3BhZ2F0b3IgKnByb3ApDQo+
Pj4gK3sNCj4+PiArICAgIGlmIChwcm9wLT5sb2NhbF9lcnIpIHsNCj4+PiArICAgICAgICBlcnJv
cl9wcm9wYWdhdGUocHJvcC0+ZXJycCwgcHJvcC0+bG9jYWxfZXJyKTsNCj4+PiArICAgIH0NCj4+
PiArfQ0KPj4+ICsNCj4+PiArR19ERUZJTkVfQVVUT19DTEVBTlVQX0NMRUFSX0ZVTkMoRXJyb3JQ
cm9wYWdhdG9yLCBlcnJvcl9wcm9wYWdhdG9yX2NsZWFudXApOw0KPj4+ICsNCj4+PiArI2RlZmlu
ZSBERUZJTkVfTE9DQUxfRVJSUChfZXJycCkgXA0KPj4+ICtnX2F1dG8oRXJyb3JQcm9wYWdhdG9y
KSAoX19hdXRvX2VycnBfcHJvcCkgPSB7LmVycnAgPSAoX2VycnApfTsgXA0KPj4+ICtFcnJvciAq
KmxvY2FsX2VycnAgPSAmX19hdXRvX2VycnBfcHJvcC5sb2NhbF9lcnINCj4+PiArDQo+Pj4gICAg
c3RhdGljIFMzOTBDUFUgKnMzOTB4X25ld19jcHUoY29uc3QgY2hhciAqdHlwZW5hbWUsIHVpbnQz
Ml90IGNvcmVfaWQsDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3Ig
KiplcnJwKQ0KPj4+ICAgIHsNCj4+PiArICAgIERFRklORV9MT0NBTF9FUlJQKGVycnApOw0KPj4+
ICAgICAgICBTMzkwQ1BVICpjcHUgPSBTMzkwX0NQVShvYmplY3RfbmV3KHR5cGVuYW1lKSk7DQo+
Pj4gLSAgICBFcnJvciAqZXJyID0gTlVMTDsNCj4+PiAgICANCj4+PiAtICAgIG9iamVjdF9wcm9w
ZXJ0eV9zZXRfaW50KE9CSkVDVChjcHUpLCBjb3JlX2lkLCAiY29yZS1pZCIsICZlcnIpOw0KPj4+
IC0gICAgaWYgKGVyciAhPSBOVUxMKSB7DQo+Pj4gKyAgICBvYmplY3RfcHJvcGVydHlfc2V0X2lu
dChPQkpFQ1QoY3B1KSwgY29yZV9pZCwgImNvcmUtaWQiLCBsb2NhbF9lcnJwKTsNCj4+PiArICAg
IGlmICgqbG9jYWxfZXJycCAhPSBOVUxMKSB7DQo+Pj4gICAgICAgICAgICBnb3RvIG91dDsNCj4+
PiAgICAgICAgfQ0KPj4+IC0gICAgb2JqZWN0X3Byb3BlcnR5X3NldF9ib29sKE9CSkVDVChjcHUp
LCB0cnVlLCAicmVhbGl6ZWQiLCAmZXJyKTsNCj4+PiArICAgIG9iamVjdF9wcm9wZXJ0eV9zZXRf
Ym9vbChPQkpFQ1QoY3B1KSwgdHJ1ZSwgInJlYWxpemVkIiwgbG9jYWxfZXJycCk7DQo+Pj4gICAg
DQo+Pj4gICAgb3V0Og0KPj4+ICAgICAgICBvYmplY3RfdW5yZWYoT0JKRUNUKGNwdSkpOw0KPj4+
IC0gICAgaWYgKGVycikgew0KPj4+IC0gICAgICAgIGVycm9yX3Byb3BhZ2F0ZShlcnJwLCBlcnIp
Ow0KPj4+ICsgICAgaWYgKCpsb2NhbF9lcnJwKSB7DQo+Pj4gICAgICAgICAgICBjcHUgPSBOVUxM
Ow0KPj4+ICAgICAgICB9DQo+Pj4gICAgICAgIHJldHVybiBjcHU7DQo+Pj4NCj4+Pg0KPj4NCj4+
IFNvIGl0J3MgREVGX0FVVE9fRVJSUF9WMiB3aXRoIGZpcnN0IHBhcmFtZXRlciBoYXJkY29kZWQg
dG8gYmUgbG9jYWxfZXJycC4NCj4+IEkgc3RpbGwgcHJlZmVyIE1BS0VfRVJSUF9TQUZFKCksIHRv
IG5vdCBpbnRyb2R1Y2UgZXh0cmEgdmFyaWFibGVzLg0KPj4NCj4gDQo+IEkgbG9zdCB0cmFjayBv
ZiB0aGUgZGlmZmVyZW50IGFwcHJvYWNoZXMgOykNCj4gDQo+IFRoZSBsb2NhbCB2YXJpYWJsZSB3
aWxsIG1vc3QgcHJvYmFibHkgb3B0aW1pemVkIG91dCBieSB0aGUgY29tcGlsZXIuIEkNCj4gZGlz
bGlrZSBNQUtFX0VSUlBfU0FGRSgpLCBhcyBpdCBtaXhlcyBkZWZpbmluZyBhIG5ldyB2YXJpYWJs
ZSB3aXRoIGNvZGUuDQo+IA0KDQpCdXQgaXQgbWFrZXMgR3JlZydzIHNlcmllcyBleHRyZW1lbHkg
c2ltcGxlOiBqdXN0IGFkZCBNQUtFX0VSUlBfU0FGRSgpIHRvIHNvbWUNCmZ1bmN0aW9ucy4gQW5k
IGFzIEVyaWMgZXhwbGFpbnMsIG1peGluZyBjb2RlIGFuZCBkZWZpbml0aW9ucyBpcyBub3QgYSBw
cm9ibGVtLg0KDQpTdGlsbCwgd2UgY2FuIGRvIGxpa2UgdGhpczoNCg0KI2RlZmluZSBNQUtFX0VS
UlBfU0FGRSgpIFwNCmdfYXV0byhFcnJvclByb3BhZ2F0b3IpIChfX2F1dG9fZXJycF9wcm9wKSA9
IHsuZXJycCA9IGVycnB9OyBcDQpFcnJvciAqKl9fbG9jYWxfZXJycF91bnVzZWQgX19hdHRyaWJ1
dGVfXyAoKHVudXNlZCkpID0gKGVycnAgPSAmX19hdXRvX2VycnBfcHJvcC5sb2NhbF9lcnIpDQoN
CldoaWNoIGFyZSB0d28gdmFsaWQgZGVmaW5pdGlvbnMuDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0K
VmxhZGltaXINCg==

