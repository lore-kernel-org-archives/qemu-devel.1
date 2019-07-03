Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E766FC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:40:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B390D20828
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VyD+Bhc4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B390D20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hihMt-0003dK-TD
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 11:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43020)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hihKF-0001fm-UA
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:37:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hihKE-0004tM-Ia
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:37:39 -0400
Received: from mail-vi1eur04on071a.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::71a]:63561
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1hihKD-0004q1-M0; Wed, 03 Jul 2019 11:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cn9auNFsaDo2QB1DQo/wCdBLumqgvKeNvAz4yVHk8/E=;
 b=VyD+Bhc4btDpbKBKY50fCCoV8LipE+vGZOSdX+1Sc5Ay0OEfuYCLDXltznE5LQ2A/Utuw/3Vur+uonRwbJVB3rlUrr3rG695gcNaJqmTCqHvfplrL0fEacKMCuIUlgB1THCDYlXsIZcee4KMx7pVgMIhsIfP22XEufiv/W91/qM=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB3315.eurprd08.prod.outlook.com (52.134.93.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Wed, 3 Jul 2019 15:37:33 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::44eb:4518:e1f2:144c]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::44eb:4518:e1f2:144c%7]) with mapi id 15.20.2032.019; Wed, 3 Jul 2019
 15:37:33 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "armbru@redhat.com"
 <armbru@redhat.com>
Thread-Topic: [PATCH v1 1/3] qcow2: introduce compression type feature
Thread-Index: AQHVMamvx3PKdvEOBEyeVcySVzRBFqa4/RiAgAADQ4CAAAbFgA==
Date: Wed, 3 Jul 2019 15:37:33 +0000
Message-ID: <ab8f2343-4534-0ada-812d-fb597c461f63@virtuozzo.com>
References: <20190703110044.25610-1-dplotnikov@virtuozzo.com>
 <20190703110044.25610-2-dplotnikov@virtuozzo.com>
 <f41f5552-a625-3306-ba3b-50d60dbefe22@redhat.com>
 <030cb268-263d-580b-bd75-ec3bc973799b@virtuozzo.com>
 <7c3620c5-039b-41e5-0b5e-cb80e60120ef@redhat.com>
In-Reply-To: <7c3620c5-039b-41e5-0b5e-cb80e60120ef@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0901CA0061.eurprd09.prod.outlook.com
 (2603:10a6:3:45::29) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 285a3111-7070-4e46-d3ab-08d6ffcc5de4
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB3315; 
x-ms-traffictypediagnostic: AM0PR08MB3315:
x-microsoft-antispam-prvs: <AM0PR08MB331595453498E9EC5D3E643FCFFB0@AM0PR08MB3315.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(396003)(346002)(136003)(376002)(366004)(189003)(199004)(81156014)(316002)(81166006)(8676002)(54906003)(2906002)(8936002)(229853002)(6486002)(305945005)(11346002)(31686004)(446003)(53936002)(66446008)(6436002)(478600001)(71190400001)(71200400001)(7736002)(6246003)(486006)(476003)(2616005)(2501003)(110136005)(6512007)(6506007)(52116002)(66066001)(31696002)(5660300002)(66556008)(4326008)(14444005)(256004)(26005)(2201001)(66476007)(66946007)(25786009)(36756003)(102836004)(186003)(14454004)(6116002)(3846002)(386003)(53546011)(86362001)(64756008)(99286004)(76176011)(73956011)(68736007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3315;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: h7HKyJD3KjCMjSxKBlLA6kNhefLPPm7WMZbkun0e85e6+pTboMcj2H1DPHZ73ucKAslcfKg/EKy3pvdrEAXFQiBecT8wIE38HGvutgYf2cDjc05Md05HvGbFeI5P/6mu6/3z8gLV1e6ifW6MhdRGnJGOUoaCxlZor8XKqMziMge7DxkbaYfGQ/BXeBOemJ1vSG3xcciVLTa8WOsgsnlbntXGER8RArxxloXW67M14RcyWLA/ZOE4lmCFTZKDDAhe2r7C6+2d3N8EOLm/CFpbBnpDddHYm6ofo0i3W7ILDipMdyOq3NN4OTdRwcvHJKOUEYpiqrfZXWQp8kKVV8KN7ebiHcO/zuuWxLSeW5nTvi/f4YlgnTtOjbaOOBd0E4HwZECLEnhfFXYwftjUmM3dfuX/Ne5Q1XN9uW0+3cTdMdg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C13F46E85C7444198F799931CE331E0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 285a3111-7070-4e46-d3ab-08d6ffcc5de4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 15:37:33.6720 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dplotnikov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3315
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0e::71a
Subject: Re: [Qemu-devel] [PATCH v1 1/3] qcow2: introduce compression type
 feature
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

DQoNCk9uIDAzLjA3LjIwMTkgMTg6MTMsIEVyaWMgQmxha2Ugd3JvdGU6DQo+IE9uIDcvMy8xOSAx
MDowMSBBTSwgRGVuaXMgUGxvdG5pa292IHdyb3RlOg0KPiANCj4+Pj4gKyAgICAgKiB3aXRoIFFD
T1cyX0NPTVBSRVNTSU9OX1RZUEVfWkxJQiB0aGUgY29ycmVzcG9uZGluZyBpbmNvbXBhdGlibGUN
Cj4+Pj4gKyAgICAgKiBmZWF0dXJlIGZsYWcgbXVzdCBiZSBhYnNlbnQsIHdpdGggb3RoZXIgY29t
cHJlc3Npb24gdHlwZXMgdGhlDQo+Pj4+ICsgICAgICogaW5jb21wYXRpYmxlIGZlYXR1cmUgZmxh
ZyBtdXN0IGJlIHNldA0KPj4+IElzIHRoZXJlIGEgc3Ryb25nIHJlYXNvbiBmb3IgZm9yYmlkIHRo
ZSBpbmNvbXBhdGlibGUgZmVhdHVyZSBmbGFnIHdpdGgNCj4+PiBaTElCPw0KPj4gVGhlIG1haW4g
cmVhc29uIGlzIHRvIGd1YXJhbnRlZSBpbWFnZSBvcGVuaW5nIGZvciBvbGRlciBxZW11IGlmDQo+
PiBjb21wcmVzc2lvbiB0eXBlIGlzIHpsaWIuDQo+Pj4gU3VyZSwgaXQgbWFrZXMgdGhlIGltYWdl
IGltcG9zc2libGUgdG8gb3BlbiB3aXRoIG9sZGVyIHFlbXUsIGJ1dA0KPj4+IGl0IGRvZXNuJ3Qg
Z2V0IGluIHRoZSB3YXkgb2YgbmV3ZXIgcWVtdSBvcGVuaW5nIGl0LiBJJ2xsIGhhdmUgdG8gc2Vl
IGhvdw0KPj4+IHlvdXIgc3BlYyBjaGFuZ2VzIGRvY3VtZW50ZWQgdGhpcywgdG8gc2VlIGlmIHlv
dSBjb3VsZCBpbnN0ZWFkIHdvcmQgaXQNCj4+PiBhcyAnZm9yIFpMSUIsIHRoZSBpbmNvbXBhdGli
bGUgZmVhdHVyZSBmbGFnIG1heSBiZSBhYnNlbnQnLg0KPj4gSSBqdXN0IGNhbid0IGltYWdpbmUg
d2hlbiBhbmQgd2h5IHdlIHdvdWxkIHdhbnQgdG8gc2V0IGluY29tcGF0aWJsZQ0KPj4gZmVhdHVy
ZSBmbGFnIHdpdGggemxpYi4gU3VwcG9zZSB3ZSBoYXZlIHpsaWIgd2l0aCB0aGUgZmxhZyBzZXQs
IHRoZW4NCj4+IG9sZGVyIHFlbXUgY2FuJ3Qgb3BlbiB0aGUgaW1hZ2UgYWx0aG91Z2ggaXQgaXMg
YWJsZSB0byB3b3JrIHdpdGggdGhlDQo+PiB6bGliIGNvbXByZXNzaW9uIHR5cGUuIEZvciBub3cs
IEkgZG9uJ3QgdW5kZXJzdGFuZCB3aHkgd2Ugc2hvdWxkIG1ha2UNCj4+IHN1Y2ggYW4gYXJ0aWZp
Y2lhbCByZXN0cmljdGlvbi4NCj4gDQo+IFdlIGhhdmUgYW4gYXJ0aWZpY2lhbCByZXN0cmljdGlv
biBvbmUgd2F5IG9yIHRoZSBvdGhlci4NCj4gDQo+IE1ldGhvZCAxIC0gYXJ0aWZpY2lhbCByZXN0
cmljdGlvbiB0aGF0IGluY29tcGF0aWJsZSBiaXQgbXVzdCBOT1QgYmUgc2V0DQo+IHdoZW4gY29t
cHJlc3Npb24gdHlwZSBpcyB6bGliDQo+IA0KPiBNZXRob2QgMiAtIGFydGlmaWNpYWwgcmVzdHJp
Y3Rpb24gdGhhdCBvbGRlciBxY293MiBwcm9ncmFtcyBjYW4ndCBvcGVuIGENCj4gemxpYiBpbWFn
ZSB3aXRoIGluY29tcGF0aWJsZSBiaXQgc2V0LCBldmVuIHRob3VnaCByZW1vdmluZyB0aGUgYml0
IG1ha2VzDQo+IHRoZSBpbWFnZSBtb3JlIHBvcnRhYmxlLg0KPiANCj4gSXQncyBkZXNpcmFibGUg
dGhhdCBxZW11IHNob3VsZCBOT1Qgc2V0IHRoZSBpbmNvbXBhdGlibGUgYml0IHdoZW4gaXQNCj4g
ZG9lcyBub3QgbmVlZCB0byAoZm9yIHRoZSBzYWtlIG9mIHBvcnRhYmlsaXR5IHRvIG1vcmUgYXBw
cyksIGJ1dA0KPiBNQU5EQVRJTkcgdGhhdCBpdCBtdXN0IG5vdCBzZXQgdGhlIGJpdCBmb3Igemxp
YiBpcyBhIHN0cm9uZ2VyIHNwZWMNCj4gcmVzdHJpY3Rpb24uDQo+IA0KPiBJIHRlbmQgdG8gbGVh
biBmb3IgdGhlIHNwZWMgYmVpbmcgbG9vc2VyIHVubGVzcyB0aGVyZSBpcyBhIHN0cm9uZyByZWFz
b24NCj4gZm9yIHdoeSBpdCBtdXN0IGJlIHN0cmljdDsganVzdCBiZWNhdXNlIHFlbXUgd29uJ3Qg
YmUgc2V0dGluZyB0aGUNCj4gaW5jb21wYXRpYmxlIGJpdCBkb2VzIG5vdCBuZWNlc3NhcmlseSBt
ZWFuIHRoYXQgYWxsIG90aGVyDQo+IGltcGxlbWVudGF0aW9ucyB3aWxsIHRyeSB0byBiZSB0aGF0
IGNhcmVmdWw7IHRoZXkgbWF5IGhhdmUgdmFsaWQgcmVhc29ucw0KPiBmb3Igc2V0dGluZyB0aGUg
Yml0IGV2ZW4gd2hlbiB1c2luZyB6bGliLCBidXQgb25seSBpZiB0aGUgc3BlYyBwZXJtaXRzDQo+
IHRoZW0gdG8gZG8gc28uDQpTbywgaG93IEkgc2hvdWxkIGltcGxlbWVudCB0aGF0PyBNZXRob2Qg
MSBvciBNZXRob2QgMj8NCkhvdyB3ZSBjYW4gZGVjaWRlPyBBc2sgd2hhdCBvdGhlciBtYWludGFp
bmVycyB0aGluayBhYm91dCB0aGF0Pw0KPiANCj4gDQo+Pj4+IEBAIC0yNDM0LDYgKzI0OTMsMTMg
QEAgaW50IHFjb3cyX3VwZGF0ZV9oZWFkZXIoQmxvY2tEcml2ZXJTdGF0ZSAqYnMpDQo+Pj4+ICAg
ICAgICB0b3RhbF9zaXplID0gYnMtPnRvdGFsX3NlY3RvcnMgKiBCRFJWX1NFQ1RPUl9TSVpFOw0K
Pj4+PiAgICAgICAgcmVmY291bnRfdGFibGVfY2x1c3RlcnMgPSBzLT5yZWZjb3VudF90YWJsZV9z
aXplID4+IChzLT5jbHVzdGVyX2JpdHMgLSAzKTsNCj4+Pj4gICAgDQo+Pj4+ICsgICAgcmV0ID0g
Y2hlY2tfY29tcHJlc3Npb25fdHlwZShzLCBOVUxMKTsNCj4+PiBXaHkgYXJlIHlvdSBpZ25vcmlu
ZyB0aGUgZXJyb3IgaGVyZT8NCj4+IHFjb3cyX3VwZGF0ZV9oZWFkZXIoKSBkb2Vzbid0IHVzZSB0
aGUgZXJyb3IgYW5kIGp1c3QgcmV0dXJucyBhbiBlcnJvcg0KPj4gY29kZSBvciAwDQo+IA0KPiBB
cmUgd2UgcG90ZW50aWFsbHkgbG9zaW5nIGEgdmFsdWFibGUgZXJyb3IgbWVzc2FnZSAoaW4gd2hp
Y2ggY2FzZQ0KPiBxY293Ml91cGRhdGVfaGVhZGVyIHNob3VsZCBtYXliZSBiZSBmaXJzdCBwYXRj
aGVkIHRvIHRha2UgYW4gZXJycA0KPiBwYXJhbWV0ZXIpLCBvciBpcyBpdCBhbHdheXMgZ29pbmcg
dG8gc3VjY2VlZCAoaW4gd2hpY2ggY2FzZSAmZXJyb3JfYWJvcnQNCj4gd291bGQgZG9jdW1lbnQg
b3VyIGludGVudGlvbiB0aGF0IHdlIGtub3cgaXQgY2FuJ3QgZmFpbCksIG9yIGlzIGl0DQo+IHJl
YWxseSBhIGNhc2Ugd2hlcmUgaXQgbWF5IGZhaWwsIGJ1dCB3ZSBkb24ndCBjYXJlIGFib3V0IGxv
c2luZyB0aGUNCj4gbWVzc2FnZT8gIFBhc3NpbmcgTlVMTCBpcyBub3Qgd3JvbmcgKGFzIHlvdSBz
YXksIHdlIGFyZW4ndCBwbHVtYmVkIHRvDQo+IHBhc3MgdGhlIG1lc3NhZ2UgYmFjayB1cCB0byB0
aGUgY2FsbGVyKSwgYnV0IGRvZXMgcmFpc2UgZW5vdWdoDQo+IHN1c3BpY2lvbnMgYXMgdG8gYmUg
d29ydGggYXVkaXRpbmcgdGhlIGNvZGUgd2hpbGUgaW4gdGhlIGFyZWEuDQoNCkNvdWxkIHdlIGRv
IGl0IGFmdGVyIGFkZGluZyB0aGlzIHNlcmllcyBzaW5jZSBpdCBhbHJlYWR5IGltcGxlbWVudGVk
IA0Kd2l0aG91dCB0aGUgZXJyb3I/DQo+IA0KPiANCj4+Pj4gKyAgICAgICAgMTA0IC0gMTA3OiAg
Y29tcHJlc3Npb25fdHlwZQ0KPj4+PiArICAgICAgICAgICAgICAgICAgICBEZWZpbmVzIHRoZSBj
b21wcmVzc2lvbiBtZXRob2QgdXNlZCBmb3IgY29tcHJlc3NlZCBjbHVzdGVycy4NCj4+Pj4gKyAg
ICAgICAgICAgICAgICAgICAgQSBzaW5nbGUgY29tcHJlc3Npb24gdHlwZSBpcyBhcHBsaWVkIHRv
IGFsbCBjb21wcmVzc2VkIGltYWdlDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgIGNsdXN0ZXJz
Lg0KPj4+PiArICAgICAgICAgICAgICAgICAgICBUaGUgY29tcHJlc3Npb24gdHlwZSBpcyBzZXQg
b24gaW1hZ2UgY3JlYXRpb24gb25seS4NCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgVGhlIGRl
ZmF1bHQgY29tcHJlc3Npb24gdHlwZSBpcyB6bGliLg0KPj4+IFdoZXJlIGlzIHRoZSBkb2N1bWVu
dGF0aW9uIHRoYXQgYSB2YWx1ZSBvZiAwIGNvcnJlc3BvbmRzIHRvIHpsaWI/DQo+PiBTaG91bGQg
SSBkbyBpdCByaWdodCBoZXJlIG9yIGl0J3MgYmV0dGVyIHRvIGFkZCBhIHNlcGFyYXRlIGNoYXB0
ZXIgaW4NCj4+IHRoZSAgZG9jcy9pbnRlcm9wL3Fjb3cyLnR4dCA/DQo+IA0KPiBSaWdodCBoZXJl
Lg0Kb2sNCj4gDQo+IA0KPj4+PiArKysgYi9xYXBpL2Jsb2NrLWNvcmUuanNvbg0KPj4+PiBAQCAt
NzgsNiArNzgsOCBAQA0KPj4+PiAgICAjDQo+Pj4+ICAgICMgQGJpdG1hcHM6IEEgbGlzdCBvZiBx
Y293MiBiaXRtYXAgZGV0YWlscyAoc2luY2UgNC4wKQ0KPj4+PiAgICAjDQo+Pj4+ICsjIEBjb21w
cmVzc2lvbi10eXBlOiB0aGUgaW1hZ2UgY2x1c3RlciBjb21wcmVzc2lvbiBtZXRob2QgKHNpbmNl
IDQuMSkNCj4+Pj4gKyMNCj4+Pj4gICAgIyBTaW5jZTogMS43DQo+Pj4+ICAgICMjDQo+Pj4+ICAg
IHsgJ3N0cnVjdCc6ICdJbWFnZUluZm9TcGVjaWZpY1FDb3cyJywNCj4+Pj4gQEAgLTg5LDcgKzkx
LDggQEANCj4+Pj4gICAgICAgICAgJypjb3JydXB0JzogJ2Jvb2wnLA0KPj4+PiAgICAgICAgICAn
cmVmY291bnQtYml0cyc6ICdpbnQnLA0KPj4+PiAgICAgICAgICAnKmVuY3J5cHQnOiAnSW1hZ2VJ
bmZvU3BlY2lmaWNRQ293MkVuY3J5cHRpb24nLA0KPj4+PiAtICAgICAgJypiaXRtYXBzJzogWydR
Y293MkJpdG1hcEluZm8nXQ0KPj4+PiArICAgICAgJypiaXRtYXBzJzogWydRY293MkJpdG1hcElu
Zm8nXSwNCj4+Pj4gKyAgICAgICcqY29tcHJlc3Npb24tdHlwZSc6ICdRY293MkNvbXByZXNzaW9u
VHlwZScNCj4+PiBXaHkgaXMgdGhpcyBmaWVsZCBvcHRpb25hbD8gQ2FuJ3Qgd2UgYWx3YXlzIHBv
cHVsYXRlIGl0LCBldmVuIGZvciBvbGRlcg0KPj4+IGltYWdlcz8NCj4+IFdoeSB3ZSBzaG91bGQg
aWYgd2UgZG9uJ3QgY2FyZSA/DQo+IA0KPiBCZWNhdXNlIGl0IHNob3dzIHRoYXQgd2UgYXJlIHJ1
bm5pbmcgYSBuZXcgZW5vdWdoIHFlbXUgdGhhdCBrbm93cyBhYm91dA0KPiB0aGUgY29tcHJlc3Np
b24gZmllbGQgKGV2ZW4gd2hlbiBpdCBpcyBhYnNlbnQpLg0Kb2ssIGlmIGV2ZXJ5Ym9keSBhZ3Jl
ZSB3aXRoIHRoYXQgSSdsbCBpbXBsZW1lbnQgd2hhdGV2ZXIgaXMgYmV0dGVyDQo+IA0KDQotLSAN
CkJlc3QsDQpEZW5pcw0K

