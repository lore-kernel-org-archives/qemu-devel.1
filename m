Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BE9C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 10:58:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C50FD20656
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 10:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZOPHrzjk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C50FD20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46362 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRaZa-00079f-20
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 06:58:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hRa6q-0006TZ-WD
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hRa0E-0004CO-0y
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:22:15 -0400
Received: from mail-eopbgr130130.outbound.protection.outlook.com
	([40.107.13.130]:58082
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hRa0B-00048a-CI; Fri, 17 May 2019 06:22:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=VExSX58g5YscgO+lb1nQPCbT4nB9Smqbs0v+NvpUbdA=;
	b=ZOPHrzjka5P0u1G5c12vPO8Wie4zZU4EogTmT5HQWXbYVdqGTYbxwCAOpCHEtO3O3+YMn3AyO7KWF2CVoRk/JsVkm+0soPjg0RJba+sR4NeHymfrL0V9gGGgOhPZCFndDagHaZQK5PxbpOTirdgHw8LjApaE7Y0FMEQSCyxrgRg=
Received: from AM6PR08MB4675.eurprd08.prod.outlook.com (10.255.96.78) by
	AM6PR08MB4643.eurprd08.prod.outlook.com (10.255.22.82) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1878.24; Fri, 17 May 2019 10:22:06 +0000
Received: from AM6PR08MB4675.eurprd08.prod.outlook.com
	([fe80::9051:3c85:28c6:a0c1]) by
	AM6PR08MB4675.eurprd08.prod.outlook.com
	([fe80::9051:3c85:28c6:a0c1%6]) with mapi id 15.20.1878.024;
	Fri, 17 May 2019 10:22:06 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v2] migration/dirty-bitmaps: change bitmap
	enumeration method
Thread-Index: AQHVCpJiO5csnRf0D0OxXxQO3Uu316ZtvN+AgABiIICAAQCaAA==
Date: Fri, 17 May 2019 10:22:06 +0000
Message-ID: <f68e1472-26be-aa15-b2e2-f96029c9ce97@virtuozzo.com>
References: <20190514201926.10407-1-jsnow@redhat.com>
	<72986b5d-0772-abfb-2c99-97470e8fd3da@virtuozzo.com>
	<ab26708f-9199-32da-29ac-3202ba2df0d5@redhat.com>
In-Reply-To: <ab26708f-9199-32da-29ac-3202ba2df0d5@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0221.eurprd05.prod.outlook.com
	(2603:10a6:3:fa::21) To AM6PR08MB4675.eurprd08.prod.outlook.com
	(2603:10a6:20b:c2::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190517132204290
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a333fb44-4839-45be-85f3-08d6dab1831f
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:AM6PR08MB4643; 
x-ms-traffictypediagnostic: AM6PR08MB4643:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM6PR08MB46433F09ABA41978681BFF47C10B0@AM6PR08MB4643.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(39850400004)(346002)(396003)(366004)(136003)(51444003)(189003)(199004)(52314003)(5024004)(14444005)(256004)(53936002)(53546011)(7736002)(11346002)(73956011)(14454004)(305945005)(478600001)(71190400001)(966005)(6506007)(64756008)(66946007)(476003)(446003)(66446008)(486006)(66556008)(66476007)(5660300002)(386003)(186003)(71200400001)(36756003)(66066001)(6512007)(2906002)(31686004)(3846002)(52116002)(81166006)(2501003)(76176011)(6486002)(110136005)(54906003)(4326008)(229853002)(68736007)(26005)(99286004)(6436002)(6306002)(102836004)(86362001)(8936002)(2201001)(316002)(31696002)(2616005)(6246003)(8676002)(6116002)(25786009)(81156014)(14143004);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4643;
	H:AM6PR08MB4675.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fkCokTChBS2BpK8Fc9tacNrIXhWRtKZHvcDp7WUrHf32NHo/sQy72awCBFlukR8VfNaq+/KSzWv8C2NKm3fw7psqSuL6c3W8MAQZgstXSSPDeyIxN5mBAfPgRDbGZ4qj8tSyFitGxACm4AUs4EbzUrdSO1XgL995KtEaM94+QHzCCplNoYSycqDRQ90jvNj8wrGow2UrfxUExDaHgV2Z+FrRTLIlQsYa4ZA8HsZqjl9MURMVZ9NQ/4iJZ30+6Ly3rlgz8rUfY4tLNLEMPfqLB4sp0TT+7pDcO3XePPqA5kVBTlsiOCpq9rl5b3xEQR7i5gbcgfZYAvVxc7NHWOSYiH3pw7lIXa+lOB/ojXry5gtUbo1qy8Jg5oPvW0ZdcGbocSeDtAhRpLsHPd8ONrhXj0Q9d7nL6pdSzI3wCWl96Dg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E26D8CA7271E414BA84134C3593C7911@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a333fb44-4839-45be-85f3-08d6dab1831f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 10:22:06.6549 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4643
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.130
Subject: Re: [Qemu-devel] [PATCH v2] migration/dirty-bitmaps: change bitmap
 enumeration method
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
	aihua liang <aliang@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr.
	David Alan Gilbert" <dgilbert@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTYuMDUuMjAxOSAyMjowMywgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDUvMTYvMTkg
NjoxMiBBTSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDE0LjA1LjIw
MTkgMjM6MTksIEpvaG4gU25vdyB3cm90ZToNCj4+PiBTaGlmdCBmcm9tIGxvb2tpbmcgYXQgZXZl
cnkgcm9vdCBCRFMgdG8gKmV2ZXJ5KiBCRFMuIFRoaXMgd2lsbCBtaWdyYXRlDQo+Pj4gYml0bWFw
cyB0aGF0IGFyZSBhdHRhY2hlZCB0byBibG9ja2RldiBjcmVhdGVkIG5vZGVzIGluc3RlYWQgb2Yg
anVzdCBvbmVzDQo+Pj4gYXR0YWNoZWQgdG8gZW11bGF0ZWQgc3RvcmFnZSBkZXZpY2VzLg0KPj4+
DQo+Pj4gTm90ZSB0aGF0IHRoaXMgd2lsbCBub3QgbWlncmF0ZSBhbm9ueW1vdXMgb3IgaW50ZXJu
YWwtdXNlIGJpdG1hcHMsIGFzDQo+Pj4gdGhvc2UgYXJlIGRlZmluZWQgYXMgaGF2aW5nIG5vIG5h
bWUuDQo+Pj4NCj4+PiBUaGlzIHdpbGwgYWxzbyBmaXggdGhlIENvdmVyaXR5IGlzc3VlcyBQZXRl
ciBNYXlkZWxsIGhhcyBiZWVuIGFza2luZw0KPj4+IGFib3V0IGZvciB0aGUgcGFzdCBzZXZlcmFs
IHJlbGVhc2VzLCBhcyB3ZWxsIGFzIGZpeGluZyBhIHJlYWwgYnVnLg0KPj4+DQo+Pj4gUmVwb3J0
ZWQtYnk6IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4NCj4+PiBSZXBv
cnRlZC1ieTogQ292ZXJpdHkg8J+YhQ0KPj4+IFJlcG9ydGVkLWJ5OiBhaWh1YSBsaWFuZyA8YWxp
YW5nQHJlZGhhdC5jb20+DQo+Pj4gRml4ZXM6IGh0dHBzOi8vYnVnemlsbGEucmVkaGF0LmNvbS9z
aG93X2J1Zy5jZ2k/aWQ9MTY1MjQ5MA0KPj4+IEZpeGVzOiBDb3Zlcml0eSBDSUQgMTM5MDYyNQ0K
Pj4+IENDOiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+DQo+Pj4gU2lnbmVk
LW9mZi1ieTogSm9obiBTbm93IDxqc25vd0ByZWRoYXQuY29tPg0KPj4+IC0tLQ0KPj4+ICAgIG1p
Z3JhdGlvbi9ibG9jay1kaXJ0eS1iaXRtYXAuYyB8IDE0ICsrKystLS0tLS0tLS0tDQo+Pj4gICAg
MSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+Pj4NCj4+
PiBkaWZmIC0tZ2l0IGEvbWlncmF0aW9uL2Jsb2NrLWRpcnR5LWJpdG1hcC5jIGIvbWlncmF0aW9u
L2Jsb2NrLWRpcnR5LWJpdG1hcC5jDQo+Pj4gaW5kZXggZDFiYjg2M2NiNi4uNGE4OTZhMDllYiAx
MDA2NDQNCj4+PiAtLS0gYS9taWdyYXRpb24vYmxvY2stZGlydHktYml0bWFwLmMNCj4+PiArKysg
Yi9taWdyYXRpb24vYmxvY2stZGlydHktYml0bWFwLmMNCj4+PiBAQCAtMjczLDcgKzI3Myw2IEBA
IHN0YXRpYyBpbnQgaW5pdF9kaXJ0eV9iaXRtYXBfbWlncmF0aW9uKHZvaWQpDQo+Pj4gICAgICAg
IEJsb2NrRHJpdmVyU3RhdGUgKmJzOw0KPj4+ICAgICAgICBCZHJ2RGlydHlCaXRtYXAgKmJpdG1h
cDsNCj4+PiAgICAgICAgRGlydHlCaXRtYXBNaWdCaXRtYXBTdGF0ZSAqZGJtczsNCj4+PiAtICAg
IEJkcnZOZXh0SXRlcmF0b3IgaXQ7DQo+Pj4gICAgICAgIEVycm9yICpsb2NhbF9lcnIgPSBOVUxM
Ow0KPj4+ICAgIA0KPj4+ICAgICAgICBkaXJ0eV9iaXRtYXBfbWlnX3N0YXRlLmJ1bGtfY29tcGxl
dGVkID0gZmFsc2U7DQo+Pj4gQEAgLTI4MSwxMyArMjgwLDggQEAgc3RhdGljIGludCBpbml0X2Rp
cnR5X2JpdG1hcF9taWdyYXRpb24odm9pZCkNCj4+PiAgICAgICAgZGlydHlfYml0bWFwX21pZ19z
dGF0ZS5wcmV2X2JpdG1hcCA9IE5VTEw7DQo+Pj4gICAgICAgIGRpcnR5X2JpdG1hcF9taWdfc3Rh
dGUubm9fYml0bWFwcyA9IGZhbHNlOw0KPj4+ICAgIA0KPj4+IC0gICAgZm9yIChicyA9IGJkcnZf
Zmlyc3QoJml0KTsgYnM7IGJzID0gYmRydl9uZXh0KCZpdCkpIHsNCj4+PiAtICAgICAgICBjb25z
dCBjaGFyICpkcml2ZV9uYW1lID0gYmRydl9nZXRfZGV2aWNlX29yX25vZGVfbmFtZShicyk7DQo+
Pj4gLQ0KPj4+IC0gICAgICAgIC8qIHNraXAgYXV0b21hdGljYWxseSBpbnNlcnRlZCBub2RlcyAq
Lw0KPj4+IC0gICAgICAgIHdoaWxlIChicyAmJiBicy0+ZHJ2ICYmIGJzLT5pbXBsaWNpdCkgew0K
Pj4+IC0gICAgICAgICAgICBicyA9IGJhY2tpbmdfYnMoYnMpOw0KPj4+IC0gICAgICAgIH0NCj4+
DQo+PiBobSwgc28sIGFmdGVyIHRoZSBwYXRjaCwgZm9yIGltcGxpY2l0bHktZmlsdGVyZWQgbm9k
ZXMgd2UnbGwgaGF2ZSBub2RlX25hbWUgaW5zdGVhZCBvZiBkZXZpY2UgbmFtZS4uDQo+Pg0KPiAN
Cj4gT2gsIEkgc2VlIC0tIHRoaXMgZG9lcyBjaGFuZ2Ugd2hhdCB3ZSBzZW5kIG92ZXIgdGhlIHdp
cmUgZm9yDQo+IGludGVyaW9yL2xlYWYgbm9kZXM7IHRoYXQgd2FzIHVuaW50ZW50aW9uYWwgb24g
bXkgcGFydC4NCj4gDQo+IEFmdGVyIG15IHBhdGNoLCB0aGlzIHJlcXVpcmVzIHRoYXQgaWYgeW91
IGhhdmUgYSBtYW51YWxseSBjb25zdHJ1Y3RlZA0KPiB0cmVlIHN1Y2ggdGhhdCB5b3UgaGF2ZSBh
dHRhY2hlZCBhIGJpdG1hcCB0byBhbiBpbnRlcmlvciBvciBsZWFmIG5vZGUsDQo+IHlvdSAqbmVl
ZCogdG8gbmFtZSB0aGF0IG5vZGUgc28gdGhhdCBpdCBjYW4gYmUgY29uc2lzdGVudGx5DQo+IHJl
Y29uc3RydWN0ZWQgYXQgdGhlIHRhcmdldC4NCj4gDQo+IEkgdGhpbmsgdGhhdCdzIGEgcmVhc29u
YWJsZSByZXF1aXJlbWVudCBhbmQgaXMgYWN0dWFsbHkgc3VwZXJpb3IgdG8NCj4gcmUtYXR0YWNo
aW5nIGFsbCBiaXRtYXBzIHRvIHRoZSByb290IG9uIG1pZ3JhdGlvbiAod2hpY2ggd291bGQgaGF2
ZQ0KPiBoYXBwZW5lZCBiZWZvcmUuKQ0KPiANCj4gQ29kZXdpc2UsIHdoYXQgd2UgaGF2ZSBjdXJy
ZW50bHkgKGJvdGggYmVmb3JlIGFuZCBhZnRlciB0aGlzIHBhdGNoKSBpczoNCj4gDQo+ICAgICAg
aWYgKGZsYWdzICYgRElSVFlfQklUTUFQX01JR19GTEFHX0RFVklDRV9OQU1FKSB7DQo+ICAgICAg
ICAgIHFlbXVfcHV0X2NvdW50ZWRfc3RyaW5nKGYsIGRibXMtPm5vZGVfbmFtZSk7DQo+ICAgICAg
fQ0KPiANCj4gU28gd2UgbmFtZWQgdGhlIGNvbnN0YW50ICJERVZJQ0VfTkFNRSIsIGJ1dCB0aGUg
ZmllbGQgd2FzIGFscmVhZHkgbmFtZWQNCj4gbm9kZV9uYW1lLCBzbyB0aGlzIHNlZW1zIGZpbmUg
b24gdGhlIHNlbmRpbmcgZW5kLiBJbiBwcmFjdGljZSwgcHJlLXBhdGNoDQo+IHdlIHNlbnQgYSBk
ZXZpY2VfbmFtZSBmb3IgYW55IG5vZGUgdGhhdCB3YXMgdGhlIHJvb3QgYXR0YWNoZWQgdG8gYQ0K
PiBkZXZpY2UuIFBvc3QtcGF0Y2gsIHRoYXQgZG9lc24ndCBjaGFuZ2UgYmVjYXVzZSBJIGFtIHVz
aW5nIHRoZSBzYW1lIEFQSQ0KPiBjYWxsIHRvIHJldHJpZXZlIHRoZSBuYW1lLg0KPiANCj4gRm9y
IGludGVyaW9yL2xlYWYgbm9kZXMsIHdlIG5vdyBzZW5kIHRoZSBub2RlLW5hbWUgc3BlY2lmaWNh
bGx5IGluc3RlYWQNCj4gb2YgdGhlIG5hbWUgb2YgdGhlIGRldmljZSByb290LiBUaGlzIHJlcXVp
cmVzIGlkZW50aWNhbGx5IGNvbnN0cnVjdGVkDQo+IChvciBhdCBsZWFzdCBjb21wYXRpYmx5IG5h
bWVkKSBncmFwaHMgb24gdGhlIHNvdXJjZSBhbmQgZGVzdGluYXRpb24sDQo+IHdoaWNoIGlzIGEg
cmVhc29uYWJsZSByZXF1aXJlbWVudCBmb3IgbWlncmF0aW9uLg0KPiANCj4gT24gdGhlIHJlY2Vp
dmluZyBlbmQsIHdlIGhhdmUgdGhpcyBjb2RlOg0KPiANCj4gICAgICBpZiAocy0+ZmxhZ3MgJiBE
SVJUWV9CSVRNQVBfTUlHX0ZMQUdfREVWSUNFX05BTUUpIHsNCj4gICAgICAgICAgaWYgKCFxZW11
X2dldF9jb3VudGVkX3N0cmluZyhmLCBzLT5ub2RlX25hbWUpKSB7DQo+ICAgICAgICAgICAgICBl
cnJvcl9yZXBvcnQoIlVuYWJsZSB0byByZWFkIG5vZGUgbmFtZSBzdHJpbmciKTsNCj4gICAgICAg
ICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiAJfQ0KPiAgICAgICAgICBzLT5icyA9IGJkcnZfbG9v
a3VwX2JzKHMtPm5vZGVfbmFtZSwgcy0+bm9kZV9uYW1lLCAmbG9jYWxfZXJyKTsNCj4gDQo+IHdo
aWNoIGxvb2tzIGxpa2UgYSBjb3JyZWN0IG1hcHBpbmcuIEkgdGhpbmsgdGhpcyBpcyBhIHNhZmUg
Y2hhbmdlLCBldmVuDQo+IHRob3VnaCBJIG1hZGUgaXQgc29tZXdoYXQgdW5pbnRlbnRpb25hbGx5
Lg0KPiANCj4+IEJ1dCwgb24gdGhlIG90aGVyLCBoYW5kLCBpZiB3ZSBoYXZlIGltcGxpY2l0bHkt
ZmlsdGVyZWQgbm9kZSBvbiB0YXJnZXQsIHdlIHdlcmUgZG9pbmcgd3JvbmcgdGhpbmcgYW55d2F5
LA0KPj4gYXMgZGlydHlfYml0bWFwX2xvYWRfaGVhZGVyIGRvbid0IHNraXAgaW1wbGljaXQgbm9k
ZXMuDQo+Pg0KPj4+ICsgICAgZm9yIChicyA9IGJkcnZfbmV4dF9hbGxfc3RhdGVzKE5VTEwpOyBi
czsgYnMgPSBiZHJ2X25leHRfYWxsX3N0YXRlcyhicykpIHsNCj4+DQo+PiBBcyBJIHVuZGVyc3Rh
bmQsIGRpZmZlcmVuY2Ugd2l0aCBiZHJ2X25leHRfbm9kZSBpcyB0aGF0IHdlIGRvbid0IHNraXAg
dW5uYW1lZCBub2RlcyBbLi4uXQ0KPj4NCj4gDQo+IFRoZSBkaWZmZXJlbmNlIGlzIHRoYXQgd2Ug
aXRlcmF0ZSBvdmVyIHN0YXRlcyB0aGF0IGFyZW4ndCByb290cyBvZg0KPiB0cmVlczsgc28gbm90
IGp1c3QgdW5uYW1lZCBub2RlcyBidXQgcmF0aGVyIGludGVybWVkaWF0ZSBub2RlcyBhcyB3ZWxs
DQo+IGFzIG5vZGVzIG5vdCBhdHRhY2hlZCB0byBhIHN0b3JhZ2UgZGV2aWNlLg0KPiANCj4gYmRy
dl9uZXh0IHNheXM6IGBJdGVyYXRlcyBvdmVyIGFsbCB0b3AtbGV2ZWwgQmxvY2tEcml2ZXJTdGF0
ZXMsIGkuZS4NCj4gQkRTcyB0aGF0IGFyZSBvd25lZCBieSB0aGUgbW9uaXRvciBvciBhdHRhY2hl
ZCB0byBhIEJsb2NrQmFja2VuZGANCj4gDQo+IFNvIHRoaXMgbG9vcCBpcyBnb2luZyB0byBpdGVy
YXRlIG92ZXIgKmV2ZXJ5dGhpbmcqLCBub3QganVzdCB0b3AtbGV2ZWwNCj4gbm9kZXMuIFRoaXMg
bGV0cyBtZSBza2lwIHRoZSB0cmVlLWNyYXdsaW5nIGxvb3AgdGhhdCBkaWRuJ3Qgd29yayBxdWl0
ZQ0KPiByaWdodC4NCg0KSSBtZWFudCBub3QgYmRydl9uZXh0IGJ1dCBiZHJ2X25leHRfbm9kZSwg
d2hpY2ggaXRlcmF0ZXMgdGhyb3VnaCBncmFwaCBub2Rlcy4uDQpXaGF0IGlzIHJlYWwgZGlmZmVy
ZW5jZSBiZXR3ZWVuIGdyYXBoX2JkcnZfc3RhdGVzIGFuZCBhbGxfYmRydl9zdGF0ZXMgPw0KDQpO
b2RlIGlzIGluc2VydGVkIHRvIGdyYXBoX2JkcnZfc3RhdGVzIGluIGJkcnZfYXNzaWduX25vZGVf
bmFtZSgpLCBhbmQgdG8NCmFsbF9iZHJ2X3N0YXRlcyBpbiBiZHJ2X25ldygpLg0KDQpUaHJlZSBj
YWxscyB0byBiZHJ2X25ldzoNCg0KYmRydl9uZXdfb3Blbl9kcml2ZXIsIGNhbGxzIGJkcnZfbmV3
IGFuZCB0aGVuIGJkcnZfb3Blbl9kcml2ZXIsIHdoaWNoIGNhbGxzIGJkcnZfYXNzaWduX25vZGVf
bmFtZSwNCmFuZCBpZiBpdCBmYWlscyBuZXcgY3JlYXRlZCBub2RlIGlzIHJlbGVhc2VkLg0KDQpi
ZHJ2X29wZW5faW5oZXJpdA0KICAgIGJkcnZfbmV3DQogICAgLi4NCiAgICBiZHJ2X29wZW5fY29t
bW9uDQogICAgICAgYmRydl9vcGVuX2RyaXZlcg0KICAgICAgICAgICBiZHJ2X2Fzc2lnbl9ub2Rl
X25hbWUNCg0KDQppc2NzaV9jb19jcmVhdGVfb3B0cw0KICAgIGJkcnZfbmV3DQoNCiAgICAuLi4g
aG1tLi4gbG9va3MgbGlrZSBpdCBhIGtpbmQgb2YgdGVtcG9yYXJ5IHVubmFtZWQgYnMNCg0KDQpT
bywgbm93LCBJJ20gbm90IHN1cmUuIFBvc3NpYmx5IHdlJ2QgYmV0dGVyIHVzZSBiZHJ2X25leHRf
bm9kZSgpLg0KDQpLZXZpbiBpbnRyb2R1Y2VkIGFsbF9iZHJ2X3N0YXRlcyBpbiAwZjEyMjY0ZTdh
NDE0NSAsIHRvIHVzZSBpbiBkcmFpbiBpbnN0ZWFkIG9mDQpiZHJ2X25leHQuLi4gQnV0IEkgZG9u
J3QgdW5kZXJzdGFuZCwgd2h5IGhlIGRpZG4ndCB1c2UgZ3JhcGhfYmRydl9zdGF0ZXMgYW5kDQpj
b3JyZXNwb25kaW5nIGJkcnZfbmV4dF9ub2RlKCksIHdoaWNoIGlzIG9ubHkgc2tpcHMgc29tZSB0
ZW1wb3Jhcnkgb3IgdW5kZXItY29uc3R1Y3Rpb24NCm5vZGVzLi4NCg0KPiANCj4+PiArICAgICAg
ICBjb25zdCBjaGFyICpuYW1lID0gYmRydl9nZXRfZGV2aWNlX29yX25vZGVfbmFtZShicyk7DQo+
Pj4gICAgDQo+Pj4gICAgICAgICAgICBmb3IgKGJpdG1hcCA9IGJkcnZfZGlydHlfYml0bWFwX25l
eHQoYnMsIE5VTEwpOyBiaXRtYXA7DQo+Pj4gICAgICAgICAgICAgICAgIGJpdG1hcCA9IGJkcnZf
ZGlydHlfYml0bWFwX25leHQoYnMsIGJpdG1hcCkpDQo+Pj4gQEAgLTI5Niw3ICsyOTAsNyBAQCBz
dGF0aWMgaW50IGluaXRfZGlydHlfYml0bWFwX21pZ3JhdGlvbih2b2lkKQ0KPj4+ICAgICAgICAg
ICAgICAgICAgICBjb250aW51ZTsNCj4+PiAgICAgICAgICAgICAgICB9DQo+Pj4gICAgDQo+Pj4g
LSAgICAgICAgICAgIGlmIChkcml2ZV9uYW1lID09IE5VTEwpIHsNCj4+PiArICAgICAgICAgICAg
aWYgKCFuYW1lIHx8IHN0cmNtcChuYW1lLCAiIikgPT0gMCkgew0KPj4NCj4+IFsuLi5dIHRvIGRv
IHRoaXMgKG1heSBiZSBwYXJhbm9pYWMsIGJ1dCB3aHkgbm90PykgY2hlY2sNCj4+DQo+IA0KPiBC
ZWNhdXNlIGJkcnZfZ2V0X2RldmljZV9vcl9ub2RlX25hbWUgdGVjaG5pY2FsbHkgaGFzIHRoZSBj
YXBhYmlsaXR5IHRvDQo+IHJldHVybiBhbiBlbXB0eSBzdHJpbmcsIHRob3VnaCBJIGJlbGlldmUg
aW4gY29udGVtcG9yYXJ5IGJsb2NrIGxheWVyDQo+IHRoYXQgd2UgYWx3YXlzIGdlbmVyYXRlIGEg
bm9kZS1uYW1lLiBTbyBpdCBtaWdodCBiZSBwYXJhbm9pZCwgYnV0IGl0DQo+IG1hdGNoZXMgdGhl
IEFQSSBJJ20gY2FsbGluZyBhcyBkb2N1bWVudGVkLg0KPiANCj4+PiAgICAgICAgICAgICAgICAg
ICAgZXJyb3JfcmVwb3J0KCJGb3VuZCBiaXRtYXAgJyVzJyBpbiB1bm5hbWVkIG5vZGUgJXAuIEl0
IGNhbid0ICINCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJiZSBtaWdyYXRl
ZCIsIGJkcnZfZGlydHlfYml0bWFwX25hbWUoYml0bWFwKSwgYnMpOw0KPj4+ICAgICAgICAgICAg
ICAgICAgICBnb3RvIGZhaWw7DQo+Pj4gQEAgLTMxMyw3ICszMDcsNyBAQCBzdGF0aWMgaW50IGlu
aXRfZGlydHlfYml0bWFwX21pZ3JhdGlvbih2b2lkKQ0KPj4+ICAgIA0KPj4+ICAgICAgICAgICAg
ICAgIGRibXMgPSBnX25ldzAoRGlydHlCaXRtYXBNaWdCaXRtYXBTdGF0ZSwgMSk7DQo+Pj4gICAg
ICAgICAgICAgICAgZGJtcy0+YnMgPSBiczsNCj4+PiAtICAgICAgICAgICAgZGJtcy0+bm9kZV9u
YW1lID0gZHJpdmVfbmFtZTsNCj4+PiArICAgICAgICAgICAgZGJtcy0+bm9kZV9uYW1lID0gbmFt
ZTsNCj4+PiAgICAgICAgICAgICAgICBkYm1zLT5iaXRtYXAgPSBiaXRtYXA7DQo+Pj4gICAgICAg
ICAgICAgICAgZGJtcy0+dG90YWxfc2VjdG9ycyA9IGJkcnZfbmJfc2VjdG9ycyhicyk7DQo+Pj4g
ICAgICAgICAgICAgICAgZGJtcy0+c2VjdG9yc19wZXJfY2h1bmsgPSBDSFVOS19TSVpFICogOCAq
DQo+Pj4NCj4+DQo+PiBUaGVyZSBpcyBzdGlsbCBzb21lIG1lc3MgYWJvdXQgZGV2aWNlIG5hbWUg
dnMgbm9kZSBuYW1lLCBhbmQgSSBkb24ndCBrbm93LCBjb3VsZCB3ZSBzb21laG93DQo+PiBzb2x2
ZSBpdCwgYnV0IHBhdGNoIGxvb2tzIE9LIGZvciBtZSBhbnl3YXk6DQo+Pg0KPiANCj4gWWVzLCB0
aGVyZSdzIG1vcmUgbWVzcywgYnV0IEkgdGhpbmsgdGhpcyBpcyBMZXNzIFdyb25n4oSi77iPLiBJ
IHdpbGwgdHJ5IHRvDQo+IGNvbWJhdCBzb21lIG9mIHRoaXMgY29uZnVzaW9uIHNvb247IGJ1dCBJ
J2xsIGxvb2sgYXQgeW91ciBjcm9zcy1ub2RlDQo+IG1lcmdlIHBhdGNoIGZpcnN0Lg0KPiANCj4+
IFJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZp
cnR1b3p6by5jb20+DQo+Pg0KPiANCj4gRG9lcyB0aGlzIHJldmlldyBzdGlsbCBzdGFuZCBhZnRl
ciBteSBjbGFyaWZpY2F0aW9ucz8NCj4gDQoNCkxldCdzIGZpZ3VyZSBvdXQgZ3JhcGhfYmRydl9z
dGF0ZXMgdnMgYWxsX2JkcnZfc3RhdGVzIGZpcnN0Lg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0K
VmxhZGltaXINCg==

