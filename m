Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D2BC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 14:53:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4709B21479
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 14:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MGafUgpu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4709B21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiK9d-0006xX-Cu
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 10:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53753)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hiK5P-0004Cp-5D
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:48:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hiK5N-0004U6-FY
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:48:46 -0400
Received: from mail-eopbgr00114.outbound.protection.outlook.com
 ([40.107.0.114]:22549 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1hiK5K-0004Nd-Gu; Tue, 02 Jul 2019 10:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/5APs9uWNYA7lZEYfycrMBs6mXMf4zJsLyutL7xwo4=;
 b=MGafUgpu5H2IFP4cu0Jv4gkmngRdmpoEB7PO1MLc5yEifdLRHG0J+4MdyDLac61Jqp2IA8IwAkyxzMv600xMMVjIr77p40Tmt6qWHhP4dLp1QOwsth7mp3q2s9Z57fXl78YfsddCGKtmS/UKRxHps6XjlinSGiESpJQuCRoMrHU=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB5508.eurprd08.prod.outlook.com (52.132.215.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 14:48:36 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::44eb:4518:e1f2:144c]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::44eb:4518:e1f2:144c%7]) with mapi id 15.20.2032.019; Tue, 2 Jul 2019
 14:48:36 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH v0 3/3] qcow2: add zstd cluster compression
Thread-Index: AQHVLaioai27iNioI0K2r5xEI7flD6a3gB8A///r0YCAAAMvgA==
Date: Tue, 2 Jul 2019 14:48:36 +0000
Message-ID: <8d66cefa-b892-1cf7-3124-c69b82297f39@virtuozzo.com>
References: <20190528143727.10529-1-dplotnikov@virtuozzo.com>
 <20190528143727.10529-4-dplotnikov@virtuozzo.com>
 <20190628115720.GH5179@dhcp-200-226.str.redhat.com>
 <5a970b37-ef08-3d53-3d53-3abb9c3e97e0@virtuozzo.com>
 <20190702143709.GB7894@localhost.localdomain>
In-Reply-To: <20190702143709.GB7894@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0245.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::21) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3bed524f-7260-4080-844f-08d6fefc5c83
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB5508; 
x-ms-traffictypediagnostic: AM0PR08MB5508:
x-microsoft-antispam-prvs: <AM0PR08MB5508D3EE6D8AE2E0D989CCECCFF80@AM0PR08MB5508.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(136003)(346002)(396003)(39850400004)(366004)(52314003)(51914003)(199004)(189003)(7736002)(14454004)(316002)(2906002)(68736007)(305945005)(64756008)(66446008)(66556008)(54906003)(73956011)(71200400001)(71190400001)(81156014)(2616005)(8936002)(6116002)(66946007)(229853002)(3846002)(66476007)(52116002)(76176011)(107886003)(31686004)(86362001)(8676002)(36756003)(53546011)(4326008)(102836004)(386003)(6506007)(5660300002)(25786009)(31696002)(6246003)(66066001)(256004)(14444005)(11346002)(6512007)(186003)(6436002)(486006)(26005)(53936002)(476003)(446003)(6486002)(478600001)(99286004)(6916009)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5508;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6OvkeaKBEomMMCh3t4CHUwtjCQ8I86dIgjaO6X2IQiOQcEAz1oIydVaMK+EbnJ4ycqvuhdEyaeAr+t/L8qJpumWzGULMwOPAIc9BOBEihzdkt21NT0JZHuvjqKqe4jhd07brQRWrWut8hjyYXdwOlMKHEvaBfgGQ8r393aKKMJ5NtbwKM0YoqHnHiJvw8KrJ1g/rCOjlxY4WXtSIP8Vqeect/7Wo9/vvcFIedrvw+78sPOWZObqH6kcAQnbTB+5fZEmNIulAmuMZZE9iSbUidSdNeoKmgXGKdgt2qBWJxfb5nbwQF+XbPQCXqhojxUFE/qeSkdahF9iQL0ajHrjrKmvlxG65nUcYvXap1YqYxWQkZx8tIKVvVGsvXF2ri1PcuKnqKRTHStGaTATrxpuBd1RJ3Ce1GTuRwyqOOPCKNJI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5301E22A3FF7C846A29E8FE947EC5256@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bed524f-7260-4080-844f-08d6fefc5c83
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 14:48:36.5085 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dplotnikov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5508
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.114
Subject: Re: [Qemu-devel] [PATCH v0 3/3] qcow2: add zstd cluster compression
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDAyLjA3LjIwMTkgMTc6MzcsIEtldmluIFdvbGYgd3JvdGU6DQo+IEFtIDAyLjA3LjIw
MTkgdW0gMTQ6NDkgaGF0IERlbmlzIFBsb3RuaWtvdiBnZXNjaHJpZWJlbjoNCj4+IE9uIDI4LjA2
LjIwMTkgMTQ6NTcsIEtldmluIFdvbGYgd3JvdGU6DQo+Pj4gQW0gMjguMDUuMjAxOSB1bSAxNjoz
NyBoYXQgRGVuaXMgUGxvdG5pa292IGdlc2NocmllYmVuOg0KPj4+PiBkaWZmIC0tZ2l0IGEvY29u
ZmlndXJlIGIvY29uZmlndXJlDQo+Pj4+IGluZGV4IDFjNTYzYTcwMjcuLmM5MDcxNjE4OWMgMTAw
NzU1DQo+Pj4+IC0tLSBhL2NvbmZpZ3VyZQ0KPj4+PiArKysgYi9jb25maWd1cmUNCj4+Pj4gQEAg
LTQzMyw2ICs0MzMsNyBAQCBvcGVuZ2xfZG1hYnVmPSJubyINCj4+Pj4gICAgY3B1aWRfaD0ibm8i
DQo+Pj4+ICAgIGF2eDJfb3B0PSIiDQo+Pj4+ICAgIHpsaWI9InllcyINCj4+Pj4gK3pzdGQ9Inll
cyINCj4+Pg0KPj4+IFRoaXMgc2hvdWxkIGJlIHpzdGQ9IiIgc28gdGhhdCBhIG1pc3NpbmcgbGli
cmFyeSB3aWxsIGF1dG9tYXRpY2FsbHkNCj4+PiBkaXNhYmxlIGl0IGluc3RlYWQgb2YgcHJvZHVj
aW5nIGFuIGVycm9yLiAoQnVpbGRpbmcgUUVNVSB3aXRob3V0IHpsaWIgaXMNCj4+PiBpbXBvc3Np
YmxlLCBidXQgYnVpbGRpbmcgaXQgd2l0aG91dCBaU1REIHNob3VsZCB3b3JrLikNCj4+IEJ1dCBp
ZiB3ZSBhZGQgenN0ZCBmb3IgY2x1c3RlcnMgY29tcHJlc3Npb24gd2UgaGF2ZSB0byBidWlsZCB3
aXRoIHpzdGQNCj4+IGVhY2ggdGltZS4gSWYgd2Ugd2FudCB0byBjaG9zZSB3aGV0aGVyIHdlIHdh
bnQgdG8gYnVpbGQgenN0ZCB3ZSBuZWVkIHRvDQo+PiBlbmNsb3NlIGFsbCB6c3RkIHJlbGF0ZWQg
Y29kZSB3aXRoICJpZmRlZiItcy4NCj4+IEkgZG9uJ3QgdGhpbmsgaXQncyBnb29kIGJlY2F1c2Ug
d2UgY2FuIGVuZCB1cCB3aXRoIG1lc3Mgb2YgdmVyc2lvbg0KPj4gc3VwcG9ydGluZyBhbmQgbm90
IHN1cHBvcnRpbmcgenN0ZCBjb21wcmVzc2lvbi4NCj4gDQo+IFllcywgd2UnbGwgbmVlZCBpZmRl
ZnMuIE9yIHdlIGNvdWxkIGRvIGl0IGxpa2UgdGhlIGRtZyBjb21wcmVzc2lvbg0KPiBmb3JtYXRz
LCBhIHNwZWFyYXRlIHNvdXJjZSBmaWxlIGZvciB6c3RkIHRoYXQgaXMgY29tcGlsZWQgY29uZGl0
aW9uYWxseS4NCj4gDQo+IEFueXdheSwgSSBkb24ndCB0aGluayBtYWtpbmcgenN0ZCBhIGhhcmQg
ZGVwZW5kZW5jeSBmb3IgcWVtdSBpcw0KPiBhY2NlcHRhYmxlLg0KPiANCj4+IEFub3RoZXIgcG9p
bnQgaXMgd2hhdCB0aGUgYmVuZWZpdCBvZiBidWlsZGluZyBxZW11IHdpdGhvdXQgenN0ZCBzdXBw
b3J0DQo+PiBpcyBzaW5jZSBpdCdzIGF2YWlsYWJsZSBhbmQgcHJvdmlkZXMgYmV0dGVyIHBlcmZv
cm1hbmNlIHRoYW4gemxpYiAoaS5lLg0KPj4gdGhlIHJlcGxhY2VtZW50IGZvciB6bGliKSA/DQo+
IA0KPiBJcyBpdCBhdmFpbGFibGUgaW4gYWxsIHJlbGV2YW50IGRpc3Ryb3MgYW5kIGV2ZW4gbm9u
LUxpbnV4IHBsYXRmb3Jtcw0KPiB0aGF0IHdlIHN1cHBvcnQ/DQo+IA0KPiBBbm90aGVyIHJlYXNv
biBmb3Igd2FudGluZyB0byBjb21waWxlIGl0IG91dCBldmVuIHdoZW4gaXQgaXMgYXZhaWxhYmxl
DQo+IGlzIHN0YXJ0dXAgdGltZS4gRWFjaCBzaGFyZWQgbGlicmFyeSB0byBiZSBsb2FkZWQgdGFr
ZXMgc29tZSB0aW1lLCBhbmQNCj4gdGhlcmUgYXJlIHVzZSBjYXNlcyB3aGVyZSB5b3Ugd2FudCBh
IG1pbmltYWwgZ3Vlc3QgdG8gYm9vdCB1cCByZWFsbHkNCj4gZmFzdC4NCj4gDQo+IEtldmluDQoN
ClNvdW5kcyBsaWtlIGltcG9ydGFudCBwb2ludHMuIFRoYW5rcyBmb3IgdGhlIGV4cGxhbmF0aW9u
IQ0KDQo+IA0KDQotLSANCkJlc3QsDQpEZW5pcw0K

