Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46305C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 09:37:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 126D42089F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 09:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eG7malwU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 126D42089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49230 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfLPH-0000rc-D8
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 05:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57391)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hfLKi-0005wg-Ex
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 05:32:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hfLKb-0000v6-DD
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 05:32:12 -0400
Received: from mail-eopbgr40134.outbound.protection.outlook.com
 ([40.107.4.134]:28398 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hfLKT-0000ev-LH; Mon, 24 Jun 2019 05:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQ1Q2bKZEdcirwCizEIqn9I0R/O7rQqGvIVG0ugu+So=;
 b=eG7malwUDNub5dwndgwRzct8V0T7AAEFXatgSb3UzhZ15Sctp5StOIy+q1qisfPeVZ3u8cYRR+m9mYuw2FLwIQ2DNlS6qqF1bUnMTznJFf+G1tx0DwI2dHA+vo1lKnXQzTDzhGvsFuscezPtPZ6TRJR61GDruXfLvC+WxwC/HVY=
Received: from VI1PR08MB3677.eurprd08.prod.outlook.com (20.177.61.92) by
 VI1PR08MB3312.eurprd08.prod.outlook.com (52.134.31.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 09:31:57 +0000
Received: from VI1PR08MB3677.eurprd08.prod.outlook.com
 ([fe80::4c71:9c23:235b:fbed]) by VI1PR08MB3677.eurprd08.prod.outlook.com
 ([fe80::4c71:9c23:235b:fbed%3]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 09:31:57 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v7 1/3] block: include base when checking image chain for
 block allocation
Thread-Index: AQHVFkfpZprNaltKyk2LZHGpYGsZSqajfZmAgAc1KAA=
Date: Mon, 24 Jun 2019 09:31:57 +0000
Message-ID: <50e6ccce-16e2-8313-fe36-36e7a4cb5be0@virtuozzo.com>
References: <1559152576-281803-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1559152576-281803-2-git-send-email-andrey.shinkevich@virtuozzo.com>
 <e3cf99ae-62e9-8b6e-5a06-d3c8b9363b85@redhat.com>
In-Reply-To: <e3cf99ae-62e9-8b6e-5a06-d3c8b9363b85@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0019.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::29) To VI1PR08MB3677.eurprd08.prod.outlook.com
 (2603:10a6:803:85::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a253e2f2-1bbe-4945-be2d-08d6f886cd28
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:VI1PR08MB3312; 
x-ms-traffictypediagnostic: VI1PR08MB3312:
x-microsoft-antispam-prvs: <VI1PR08MB331274ACCAC3F0F5DC20294DF4E00@VI1PR08MB3312.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(376002)(39840400004)(366004)(346002)(199004)(189003)(7736002)(86362001)(229853002)(386003)(99286004)(6506007)(14454004)(2501003)(8676002)(31686004)(81156014)(81166006)(2201001)(31696002)(2906002)(305945005)(36756003)(66066001)(66446008)(64756008)(53936002)(7416002)(4326008)(66476007)(66556008)(186003)(73956011)(66946007)(25786009)(26005)(53546011)(102836004)(6486002)(68736007)(6436002)(6512007)(2616005)(478600001)(107886003)(6246003)(8936002)(52116002)(76176011)(5660300002)(71200400001)(44832011)(71190400001)(256004)(11346002)(6116002)(3846002)(110136005)(446003)(54906003)(316002)(486006)(476003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3312;
 H:VI1PR08MB3677.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KjXPOe3JQsc1v2/vI52DnAjA5s0BUuC0Ca5F//f3eUz5dKDAeIpBDMkOhtRt4kqkR20mz7UplIeRigF1zwnF85gkty0rAhD/cfuOUVySMC4w9rkonDswstpBkwnPZyARki5huhII7i9pvoqd85+uieNwW+XgQAntYCvz8NzYvyI+k4HUEAJZAWT0aHi/6Eqai+N3S0702Ie2sHDd1Upqhjcl84R7D6DtrXQDQIHWxg+dYMh5rmJIgtkbXwnMypiH4vHPBnE6jfXy6zfokd7G2tyXQ2I90UGUmxacizpaRo6uMU9tNjrLSiR+huYDtWeNYJdSlFICjffAHSGHD60ayt23m/uihvXkghAOTEIGi8VuwuPVhPyUlkLn8qBkfFvU+gE8Ag+/mbco5Ys9eQLwRi2VTicrHjbJVleWPxSlyTY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <95BF371B2D0A3A4C8EB68101009B2D69@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a253e2f2-1bbe-4945-be2d-08d6f886cd28
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 09:31:57.3347 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andrey.shinkevich@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3312
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.134
Subject: Re: [Qemu-devel] [PATCH v7 1/3] block: include base when checking
 image chain for block allocation
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>,
 "wencongyang2@huawei.com" <wencongyang2@huawei.com>,
 "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDE5LzA2LzIwMTkgMjI6MjcsIE1heCBSZWl0eiB3cm90ZToNCj4gT24gMjkuMDUuMTkg
MTk6NTYsIEFuZHJleSBTaGlua2V2aWNoIHdyb3RlOg0KPj4gVGhpcyBwYXRjaCBpcyB1c2VkIGlu
IHRoZSAnYmxvY2svc3RyZWFtOiBpbnRyb2R1Y2UgYSBib3R0b20gbm9kZScNCj4+IHRoYXQgaXMg
Zm9sbG93aW5nLiBJbnN0ZWFkIG9mIHRoZSBiYXNlIG5vZGUsIHRoZSBjYWxsZXIgbWF5IHBhc3MN
Cj4+IHRoZSBub2RlIHRoYXQgaGFzIHRoZSBiYXNlIGFzIGl0cyBiYWNraW5nIGltYWdlIHRvIHRo
ZSBmdW5jdGlvbg0KPj4gYmRydl9pc19hbGxvY2F0ZWRfYWJvdmUoKSB3aXRoIGEgbmV3IHBhcmFt
ZXRlciBpbmNsdWRlX2Jhc2UgPSB0cnVlDQo+PiBhbmQgZ2V0IHJpZCBvZiB0aGUgZGVwZW5kZW5j
eSBvbiB0aGUgYmFzZSB0aGF0IG1heSBjaGFuZ2UgZHVyaW5nDQo+PiBjb21taXQvc3RyZWFtIHBh
cmFsbGVsIGpvYnMuIE5vdywgaWYgdGhlIHNwZWNpZmllZCBiYXNlIGlzIG5vdA0KPj4gZm91bmQg
aW4gdGhlIGJhY2tpbmcgaW1hZ2UgY2hhaW4sIHRoZSBRRU1VIHdpbGwgYWJvcnQuDQo+Pg0KPj4g
U3VnZ2VzdGVkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZp
cnR1b3p6by5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgU2hpbmtldmljaCA8YW5kcmV5
LnNoaW5rZXZpY2hAdmlydHVvenpvLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1l
bnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+PiBSZXZpZXdlZC1i
eTogQWxiZXJ0byBHYXJjaWEgPGJlcnRvQGlnYWxpYS5jb20+DQo+PiAtLS0NCj4+ICAgYmxvY2sv
Y29tbWl0LmMgICAgICAgIHwgIDIgKy0NCj4+ICAgYmxvY2svaW8uYyAgICAgICAgICAgIHwgMjEg
KysrKysrKysrKysrKysrLS0tLS0tDQo+PiAgIGJsb2NrL21pcnJvci5jICAgICAgICB8ICAyICst
DQo+PiAgIGJsb2NrL3JlcGxpY2F0aW9uLmMgICB8ICAyICstDQo+PiAgIGJsb2NrL3N0cmVhbS5j
ICAgICAgICB8ICAyICstDQo+PiAgIGluY2x1ZGUvYmxvY2svYmxvY2suaCB8ICAzICsrLQ0KPj4g
ICA2IGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiAN
Cj4gVGhpcyBuZWVkcyB0aGUgZm9sbG93aW5nIGh1bmsgc3F1YXNoZWQgaW4gc28gaXQgc3RpbGwg
Y29tcGlsZXM6DQo+IA0KPiAoSSBjYW4gZG8gdGhhdCwgaWYgeW91IGFncmVlLikNCg0KWWVzLCBw
bGVhc2UhDQpBbmRyZXkNCg0KPiANCj4gZGlmZiAtLWdpdCBhL2Jsb2NrL3Fjb3cyLmMgYi9ibG9j
ay9xY293Mi5jDQo+IGluZGV4IDkzOTZkNDkwZDUuLjJhNTllYjI3ZmUgMTAwNjQ0DQo+IC0tLSBh
L2Jsb2NrL3Fjb3cyLmMNCj4gKysrIGIvYmxvY2svcWNvdzIuYw0KPiBAQCAtMjE0OCw3ICsyMTQ4
LDggQEAgc3RhdGljIGJvb2wgaXNfdW5hbGxvY2F0ZWQoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+
IGludDY0X3Qgb2Zmc2V0LCBpbnQ2NF90IGJ5dGVzKQ0KPiAgIHsNCj4gICAgICAgaW50NjRfdCBu
cjsNCj4gICAgICAgcmV0dXJuICFieXRlcyB8fA0KPiAtICAgICAgICAoIWJkcnZfaXNfYWxsb2Nh
dGVkX2Fib3ZlKGJzLCBOVUxMLCBvZmZzZXQsIGJ5dGVzLCAmbnIpICYmIG5yDQo+ID09IGJ5dGVz
KTsNCj4gKyAgICAgICAgKCFiZHJ2X2lzX2FsbG9jYXRlZF9hYm92ZShicywgTlVMTCwgZmFsc2Us
IG9mZnNldCwgYnl0ZXMsICZucikgJiYNCj4gKyAgICAgICAgIG5yID09IGJ5dGVzKTsNCj4gICB9
DQo+IA0KPiAgIHN0YXRpYyBib29sIGlzX3plcm9fY293KEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBR
Q293TDJNZXRhICptKQ0KPiBkaWZmIC0tZ2l0IGEvcWVtdS1pbWcuYyBiL3FlbXUtaW1nLmMNCj4g
aW5kZXggMTU4YjNhNTA1Zi4uNzk5ODM3NzJkZSAxMDA2NDQNCj4gLS0tIGEvcWVtdS1pbWcuYw0K
PiArKysgYi9xZW11LWltZy5jDQo+IEBAIC0zNTE4LDcgKzM1MTgsNyBAQCBzdGF0aWMgaW50IGlt
Z19yZWJhc2UoaW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0KPiAgICAgICAgICAgICAgICAgICAgKiB0
byB0YWtlIGFjdGlvbg0KPiAgICAgICAgICAgICAgICAgICAgKi8NCj4gICAgICAgICAgICAgICAg
ICAgcmV0ID0gYmRydl9pc19hbGxvY2F0ZWRfYWJvdmUoYmFja2luZ19icyhicyksDQo+IHByZWZp
eF9jaGFpbl9icywNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBvZmZzZXQsIG4sICZuKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBmYWxzZSwgb2Zmc2V0LCBuLCAmbik7DQo+ICAgICAgICAgICAgICAgICAg
IGlmIChyZXQgPCAwKSB7DQo+ICAgICAgICAgICAgICAgICAgICAgICBlcnJvcl9yZXBvcnQoImVy
cm9yIHdoaWxlIHJlYWRpbmcgaW1hZ2UgbWV0YWRhdGE6ICVzIiwNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzdHJlcnJvcigtcmV0KSk7DQo+IA0KDQotLSANCldpdGggdGhl
IGJlc3QgcmVnYXJkcywNCkFuZHJleSBTaGlua2V2aWNoDQo=

