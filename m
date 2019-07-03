Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19816C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:08:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDBB32189E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Bn7d4w5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDBB32189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1higs0-0000ix-5H
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 11:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36058)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1higpx-0007PF-Oz
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:06:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1higpw-0005lx-J2
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:06:21 -0400
Received: from mail-eopbgr40119.outbound.protection.outlook.com
 ([40.107.4.119]:58115 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1higpv-0005l5-Da; Wed, 03 Jul 2019 11:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tY3yMX91IyfB+UxJXq8DIBzNXoOtub6Ws0iQAHXoYQ=;
 b=Bn7d4w5s/6Bl3EyF/kpyY5UU4DINNK312g5//F/GmKILOJ1yCSUG8LAjDzF1gp5pQTneFCMV7UJzaUnuYMJmzHefl0Q1kQV0rObsUVKMRKPwZDcepnpOwfzZQ4sE7DnH6vdWCUvcCQB8AYrhBPb8UDjKe4fY25dsYsKQlpnNH+c=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB3010.eurprd08.prod.outlook.com (52.134.90.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Wed, 3 Jul 2019 15:06:15 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::44eb:4518:e1f2:144c]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::44eb:4518:e1f2:144c%7]) with mapi id 15.20.2032.019; Wed, 3 Jul 2019
 15:06:15 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "armbru@redhat.com"
 <armbru@redhat.com>
Thread-Topic: [PATCH v1 3/3] qcow2: add zstd cluster compression
Thread-Index: AQHVMazHdyNTg7I0DEqt6tYavVYIsKa4/luA
Date: Wed, 3 Jul 2019 15:06:15 +0000
Message-ID: <2339a856-8c54-7d27-3632-592b46a76b0f@virtuozzo.com>
References: <20190703110044.25610-1-dplotnikov@virtuozzo.com>
 <20190703110044.25610-4-dplotnikov@virtuozzo.com>
 <e61d7afc-09ce-d52d-3987-df1d5ba6977f@redhat.com>
In-Reply-To: <e61d7afc-09ce-d52d-3987-df1d5ba6977f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0101CA0003.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::13) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d90da77-cb35-4025-2cd9-08d6ffc7fe5c
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB3010; 
x-ms-traffictypediagnostic: AM0PR08MB3010:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <AM0PR08MB301095FB9B62A68835AE6439CFFB0@AM0PR08MB3010.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(39850400004)(366004)(346002)(396003)(136003)(199004)(189003)(52116002)(386003)(66066001)(53936002)(6116002)(102836004)(76176011)(6506007)(256004)(8936002)(66446008)(26005)(66946007)(36756003)(6246003)(53376002)(71190400001)(71200400001)(186003)(64756008)(66556008)(66476007)(73956011)(6436002)(6306002)(6512007)(6486002)(99286004)(53546011)(54906003)(3846002)(316002)(110136005)(5660300002)(229853002)(478600001)(2501003)(81156014)(4326008)(8676002)(81166006)(19273905006)(14454004)(31696002)(86362001)(31686004)(68736007)(2201001)(2906002)(7736002)(14444005)(305945005)(25786009)(11346002)(446003)(476003)(2616005)(486006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3010;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Vfv+ZHLsyjHae92aE43zwaZikH3WdTx/s4sGJwCps6tElCdAjyekxo76mQ0a9YBDusRmbOVRgFKXDLDlUDR3LS+bSJL6KEDXJ3pJvoj6p8zi6rV7yeusZruzWJOF6KFmYvttk/4tWrwijPBwCf6GWoZVzO0EX2ZOdSH6McXTkgmOdViv/E1vf7kpC77umNAFEIUdsyY0S1tLrPrhDN8e3QfEQCuyMUjkJJm5xK7xOAVwhgWbp6LJ+ZoGK1eBrhE9A/O4mJqzVlmCdCq0BFJBw/bFG/iFPv84D8O946RWzSKBtI8OxrqXhpX+L0iq8GkiD48C1dhVRWY/EPlgATHpRL4FpUGqtVIrPPleggAwzBXI98MxYG7+hx2HoYG1tXBoz4r5pAihTDBcnr0T/pujMwYpKNt1O7YZbA09p7MhiD8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EEEB45A0F0867428A0AA64F18726E42@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d90da77-cb35-4025-2cd9-08d6ffc7fe5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 15:06:15.2950 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dplotnikov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3010
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.119
Subject: Re: [Qemu-devel] [PATCH v1 3/3] qcow2: add zstd cluster compression
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDAzLjA3LjIwMTkgMTc6MzYsIEVyaWMgQmxha2Ugd3JvdGU6DQo+IE9uIDcvMy8xOSA2
OjAwIEFNLCBEZW5pcyBQbG90bmlrb3Ygd3JvdGU6DQo+PiB6c3RkIHNpZ25pZmljYW50bHkgcmVk
dWNlcyBjbHVzdGVyIGNvbXByZXNzaW9uIHRpbWUuDQo+PiBJdCBwcm92aWRlcyBiZXR0ZXIgY29t
cHJlc3Npb24gcGVyZm9ybWFuY2UgbWFpbnRhaW5pbmcNCj4+IHRoZSBzYW1lIGxldmVsIG9mIGNv
bXByZXNzaW9uIHJhdGlvIGluIGNvbXBhcmlzb24gd2l0aA0KPj4gemxpYiwgd2hpY2gsIGJ5IHRo
ZSBtb21lbnQsIGhhcyBiZWVuIHRoZSBvbmx5IGNvbXByZXNzaW9uDQo+PiBtZXRob2QgYXZhaWxh
YmxlLg0KPj4NCj4gDQo+PiAtLS0NCj4+ICAgYmxvY2svcWNvdzIuYyAgICAgICAgfCA5NiArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICBjb25maWd1cmUg
ICAgICAgICAgICB8IDMyICsrKysrKysrKysrKysrKw0KPj4gICBxYXBpL2Jsb2NrLWNvcmUuanNv
biB8ICAzICstDQo+PiAgIDMgZmlsZXMgY2hhbmdlZCwgMTMwIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gDQo+IFdoZXJlIGlzIHRoZSBjaGFuZ2UgdG8gZG9jcy9pbnRlcm9wL3Fjb3cy
LnR4dCB0byBkZXNjcmliZSB0aGlzIG5ldw0KPiBjb21wcmVzc2lvbiBmb3JtYXQ/DQo+IA0Kb2sN
Cj4+DQo+PiBkaWZmIC0tZ2l0IGEvYmxvY2svcWNvdzIuYyBiL2Jsb2NrL3Fjb3cyLmMNCj4+IGlu
ZGV4IDM3YTU2M2E2NzEuLmNhYTA0YjBiZWIgMTAwNjQ0DQo+PiAtLS0gYS9ibG9jay9xY293Mi5j
DQo+PiArKysgYi9ibG9jay9xY293Mi5jDQo+PiBAQCAtMjcsNiArMjcsMTEgQEANCj4+ICAgI2Rl
ZmluZSBaTElCX0NPTlNUDQo+PiAgICNpbmNsdWRlIDx6bGliLmg+DQo+PiAgIA0KPiANCj4+ICtz
dGF0aWMgc3NpemVfdCBxY293Ml96c3RkX2NvbXByZXNzKHZvaWQgKmRlc3QsIHNpemVfdCBkZXN0
X3NpemUsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCB2b2lk
ICpzcmMsIHNpemVfdCBzcmNfc2l6ZSkNCj4+ICt7DQo+PiArICAgIHNzaXplX3QgcmV0Ow0KPj4g
KyAgICB1aW50MzJfdCAqY19zaXplID0gZGVzdDsNCj4+ICsgICAgLyogc3RlYWwgc29tZSBieXRl
cyB0byBzdG9yZSBjb21wcmVzc2VkIGNodW5rIHNpemUgKi8NCj4+ICsgICAgY2hhciAqZF9idWYg
PSAoKGNoYXIgKikgZGVzdCkgKyBzaXplb2YoKmNfc2l6ZSk7DQo+PiArDQo+IA0KPiBEbyB5b3Ug
YWx3YXlzIHdhbnQgZXhhY3RseSA0IGJ5dGVzIGZvciB0aGUgY29tcHJlc3NlZCBzaXplPyBPciBp
cyBpdA0KPiB3b3J0aCBzb21lIHNvcnQgb2YgdmFyaWFibGUtbGVuZ3RoIGVuY29kaW5nLCBzaW5j
ZSB3ZSdyZSBhbHJlYWR5IGRlYWxpbmcNCj4gd2l0aCBub24tY2FjaGVsaW5lLWFsaWduZWQgZGF0
YT8gWW91IGNhbiByZXByZXNlbnQgYWxsIHNpemVzIHVwIHRvIDRNDQo+IHVzaW5nIGEgbWF4aW11
bSBvZiAzIGJ5dGVzIChzZXQgdGhlIGhpZ2ggYml0IGlmIHRoZSBpbnRlZ2VyIGNvbnRpbnVlcywN
Cj4gdGhlbiBzaXplcyAwLTEyNyB0YWtlIDEgYnl0ZSBbNyBiaXRzXSwgMTI4LTMyNzY3IHRha2Ug
MiBieXRlcyBbMTUgYml0c10sDQo+IGFuZCAzMjc2OC00MTk0MzAzIHRha2UgMyBieXRlcyBbMjIg
Yml0c10pLg0KSXMgaXQgcmVhbGx5IHdvcnRoIHRvIGRvIHRoYXQ/IEkgbGlrZWQgS2V2aW4ncyBj
b21tZW50IHRoYXQgdGhlIHNpemUgDQpzaG91bGQgY29tcGxhaW4gd2l0aCBzb21lIHZhcmlhYmxl
IHNpemUNCj4gDQo+PiArICAgIGlmIChkZXN0X3NpemUgPCBzaXplb2YoKmNfc2l6ZSkpIHsNCj4+
ICsgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIGRlc3Rf
c2l6ZSAtPSBzaXplb2YoKmNfc2l6ZSk7DQo+PiArDQo+PiArICAgIHJldCA9IFpTVERfY29tcHJl
c3MoZF9idWYsIGRlc3Rfc2l6ZSwgc3JjLCBzcmNfc2l6ZSwgNSk7DQo+IA0KPiBUaGUgZmFjdCB0
aGF0IHlvdSBhcmUgc3RvcmluZyB0aGUgc2l6ZSBzZXBhcmF0ZSBmcm9tIHRoZSBkYXRhIHBhc3Nl
ZCB0bw0KPiB6c3RkIE1VU1QgYmUgZG9jdW1lbnRlZCBpbiB0aGUgcWNvdzIgc3BlYywgZm9yIHRo
ZSBuZXh0IHBlcnNvbiB0bw0KPiBwcm9kdWNlL2NvbnN1bWUgdGhlIHNhbWUgZGF0YS4NClNob3Vs
ZCBJIGFkZCBhIHNlcGFyYXRlIGNoYXB0ZXIgdGhlcmU/DQo+IA0KPiANCj4+ICsrKyBiL3FhcGkv
YmxvY2stY29yZS5qc29uDQo+PiBAQCAtNDIxNSwxMSArNDIxNSwxMiBAQA0KPj4gICAjIENvbXBy
ZXNzaW9uIHR5cGUgdXNlZCBpbiBxY293MiBpbWFnZSBmaWxlDQo+PiAgICMNCj4+ICAgIyBAemxp
YjogIHpsaWIgY29tcHJlc3Npb24sIHNlZSA8aHR0cDovL3psaWIubmV0Lz4NCj4+ICsjIEB6c3Rk
OiAgenN0ZCBjb21wcmVzc2lvbiwgc2VlIDxodHRwOi8vZ2l0aHViLmNvbS9mYWNlYm9vay96c3Rk
Pg0KPj4gICAjDQo+PiAgICMgU2luY2U6IDQuMQ0KPj4gICAjIw0KPj4gICB7ICdlbnVtJzogJ1Fj
b3cyQ29tcHJlc3Npb25UeXBlJywNCj4+IC0gICdkYXRhJzogWyAnemxpYicgXSB9DQo+PiArICAn
ZGF0YSc6IFsgJ3psaWInLCAnenN0ZCcgXSB9DQo+IA0KPiBTaW5jZSB5b3UgcGF0Y2hlZCBjb25m
aWd1cmUgc28gdGhhdCBsaW5raW5nIGFnYWluc3QgenN0ZCBpcyBvcHRpb25hbCwNCj4gdGhpcyBz
aG91bGQgdXNlIHsgJ25hbWUnOid6c3RkJywgJ2lmJzonQ09ORElUSU9OQUwnIH0gc28gdGhhdCBk
dXJpbmcNCj4gaW50cm9zcGVjdGlvbiwgdGhlIGVudW0gb25seSBhZHZlcnRpc2VzIHpzdGQgb24g
YSBidWlsZCB0aGF0IGxpbmtlZA0KPiBhZ2FpbnN0IHRoZSBsaWJyYXJ5Lg0KU3VyZSwgd2lsbCBj
aGFuZ2UgaXQNCj4gDQoNCi0tIA0KQmVzdCwNCkRlbmlzDQo=

