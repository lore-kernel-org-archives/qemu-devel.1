Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEC6C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:07:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED52A2184C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="b1EufcHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED52A2184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hihnS-0003NI-73
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 12:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53781)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hihb0-0003Qb-LB
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:55:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hihaz-0008PW-Dk
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:54:58 -0400
Received: from mail-eopbgr50093.outbound.protection.outlook.com
 ([40.107.5.93]:35214 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1hihay-0008OT-19; Wed, 03 Jul 2019 11:54:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+YH+RUR2IwEH8k9yrO926NGe6aLEmURBa6Ak0Px1gQ=;
 b=b1EufcHpPDJWp5pB9u21+x0XZX3IOM9oEulYrJDKFtHn3Ptw+g5UvLX1ugsUPIRbJeIWqlL7votFLOL5b4+VK38yKlw2DmZZbVub8nhKW/CqubDdG74nJcqb+Elu/CguRjW3UNljpfFA7Xe30TSpxIxiHVpuzv0WkL1qrVwEpMc=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB3236.eurprd08.prod.outlook.com (52.134.91.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Wed, 3 Jul 2019 15:54:53 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::44eb:4518:e1f2:144c]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::44eb:4518:e1f2:144c%7]) with mapi id 15.20.2032.019; Wed, 3 Jul 2019
 15:54:53 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH v1 1/3] qcow2: introduce compression type feature
Thread-Index: AQHVMamvx3PKdvEOBEyeVcySVzRBFqa4/RiAgAAMoYCAAAI5AA==
Date: Wed, 3 Jul 2019 15:54:53 +0000
Message-ID: <a9efe61f-e544-7d5e-2864-6159c2d3cb18@virtuozzo.com>
References: <20190703110044.25610-1-dplotnikov@virtuozzo.com>
 <20190703110044.25610-2-dplotnikov@virtuozzo.com>
 <f41f5552-a625-3306-ba3b-50d60dbefe22@redhat.com>
 <030cb268-263d-580b-bd75-ec3bc973799b@virtuozzo.com>
 <20190703154649.GA7764@linux.fritz.box>
In-Reply-To: <20190703154649.GA7764@linux.fritz.box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0090.eurprd07.prod.outlook.com
 (2603:10a6:3:64::34) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1250d91c-15b5-4c92-9055-08d6ffcec709
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB3236; 
x-ms-traffictypediagnostic: AM0PR08MB3236:
x-microsoft-antispam-prvs: <AM0PR08MB3236709E0CFBA6C46AE0D20BCFFB0@AM0PR08MB3236.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(136003)(376002)(39850400004)(396003)(189003)(199004)(14454004)(68736007)(4326008)(486006)(6246003)(66476007)(316002)(5660300002)(7736002)(25786009)(53936002)(6116002)(3846002)(31686004)(6512007)(478600001)(2906002)(6486002)(26005)(53546011)(6436002)(102836004)(386003)(36756003)(476003)(256004)(229853002)(76176011)(71190400001)(86362001)(81166006)(8936002)(6506007)(31696002)(6916009)(186003)(81156014)(14444005)(54906003)(446003)(64756008)(71200400001)(99286004)(2616005)(305945005)(73956011)(66556008)(8676002)(52116002)(11346002)(66066001)(66446008)(66946007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3236;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XpGcRiqhOmtoRzAIa27YJIDdqdrdCxqg7i4+oX9pdUzQKLBsozZbpUvMC0962zB61UgAWHjuW9ae5A++9DCP2jvbN/ZgV6uRMX1QhnDoM4nC72QNdDuzLxmjRT1AWH/yizvoUF8lPhyUbNsR7fibXgndV+Ix3g514g7dCKmI4UmFwL+sz//9GKpXCUIh8/EO8YYvMvEjoM/psYR4eXjmdDFPpHFM77xiSMkdxinjV485FhoeIgFmYp/d3o+lpD1zz+QcQ02IIgTYIHXOxc8Gx0QTfvWWd07myd+pqWCVkXzOx+tBek0n0fhspAlrY6kIkVJ6Eb3bV9/GsaKtMMtVi0IdUobg+Ccr8Dkzf7DnJUHBbGSNkHbnogsw4WcI7xx/sS7AAlWDu4jL6phyqQ0RtvlbqbrpFq/LclBcEQxtSns=
Content-Type: text/plain; charset="utf-8"
Content-ID: <244CC729F3AADF4DBF077106D7A1C5FB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1250d91c-15b5-4c92-9055-08d6ffcec709
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 15:54:53.4015 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dplotnikov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3236
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.93
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDAzLjA3LjIwMTkgMTg6NDYsIEtldmluIFdvbGYgd3JvdGU6DQo+IEFtIDAzLjA3LjIw
MTkgdW0gMTc6MDEgaGF0IERlbmlzIFBsb3RuaWtvdiBnZXNjaHJpZWJlbjoNCj4+IE9uIDAzLjA3
LjIwMTkgMTc6MTQsIEVyaWMgQmxha2Ugd3JvdGU6DQo+Pj4gT24gNy8zLzE5IDY6MDAgQU0sIERl
bmlzIFBsb3RuaWtvdiB3cm90ZToNCj4+Pj4gZGlmZiAtLWdpdCBhL2Jsb2NrL3Fjb3cyLmMgYi9i
bG9jay9xY293Mi5jDQo+Pj4+IGluZGV4IDNhY2UzYjIyMDkuLjkyMWViNjdiODAgMTAwNjQ0DQo+
Pj4+IC0tLSBhL2Jsb2NrL3Fjb3cyLmMNCj4+Pj4gKysrIGIvYmxvY2svcWNvdzIuYw0KPj4+PiBA
QCAtMTIwMiw2ICsxMjAyLDQ3IEBAIHN0YXRpYyBpbnQgcWNvdzJfdXBkYXRlX29wdGlvbnMoQmxv
Y2tEcml2ZXJTdGF0ZSAqYnMsIFFEaWN0ICpvcHRpb25zLA0KPj4+PiAgICAgICAgcmV0dXJuIHJl
dDsNCj4+Pj4gICAgfQ0KPj4+PiAgICANCj4+Pj4gK3N0YXRpYyBpbnQgY2hlY2tfY29tcHJlc3Np
b25fdHlwZShCRFJWUWNvdzJTdGF0ZSAqcywgRXJyb3IgKiplcnJwKQ0KPj4+PiArew0KPj4+PiAr
ICAgIGJvb2wgaXNfc2V0Ow0KPj4+PiArICAgIGludCByZXQgPSAwOw0KPj4+PiArDQo+Pj4+ICsg
ICAgc3dpdGNoIChzLT5jb21wcmVzc2lvbl90eXBlKSB7DQo+Pj4+ICsgICAgY2FzZSBRQ09XMl9D
T01QUkVTU0lPTl9UWVBFX1pMSUI6DQo+Pj4+ICsgICAgICAgIGJyZWFrOw0KPj4+PiArDQo+Pj4+
ICsgICAgZGVmYXVsdDoNCj4+Pj4gKyAgICAgICAgaWYgKGVycnApIHsNCj4+PiBVc2VsZXNzIGNo
ZWNrIGZvciBlcnJwIGJlaW5nIG5vbi1OVUxMLiAgV2hhdCdzIHdvcnNlLCBpZiB0aGUgY2FsbGVy
DQo+Pj4gcGFzc2VzIGluIE5VTEwgYmVjYXVzZSB0aGV5IGRvbid0IGNhcmUgYWJvdXQgdGhlIGVy
cm9yLCB0aGVuIHlvdXIgY29kZQ0KPj4+IGJlaGF2ZXMgZGlmZmVyZW50bHkuICBKdXN0IGNhbGwg
ZXJyb3Jfc2V0ZygpIGFuZCByZXR1cm4gLUVOT1RTVVANCj4+PiB1bmNvbmRpdGlvbmFsbHkuDQo+
PiBvaw0KPj4+DQo+Pj4+ICsgICAgICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJxY293MjogdW5r
bm93biBjb21wcmVzc2lvbiB0eXBlOiAldSIsDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAg
IHMtPmNvbXByZXNzaW9uX3R5cGUpOw0KPj4+PiArICAgICAgICAgICAgcmV0dXJuIC1FTk9UU1VQ
Ow0KPj4+PiArICAgICAgICB9DQo+Pj4+ICsgICAgfQ0KPj4+PiArDQo+Pj4+ICsgICAgLyoNCj4+
Pj4gKyAgICAgKiB3aXRoIFFDT1cyX0NPTVBSRVNTSU9OX1RZUEVfWkxJQiB0aGUgY29ycmVzcG9u
ZGluZyBpbmNvbXBhdGlibGUNCj4+Pj4gKyAgICAgKiBmZWF0dXJlIGZsYWcgbXVzdCBiZSBhYnNl
bnQsIHdpdGggb3RoZXIgY29tcHJlc3Npb24gdHlwZXMgdGhlDQo+Pj4+ICsgICAgICogaW5jb21w
YXRpYmxlIGZlYXR1cmUgZmxhZyBtdXN0IGJlIHNldA0KPj4+IElzIHRoZXJlIGEgc3Ryb25nIHJl
YXNvbiBmb3IgZm9yYmlkIHRoZSBpbmNvbXBhdGlibGUgZmVhdHVyZSBmbGFnIHdpdGgNCj4+PiBa
TElCPw0KPj4gVGhlIG1haW4gcmVhc29uIGlzIHRvIGd1YXJhbnRlZSBpbWFnZSBvcGVuaW5nIGZv
ciBvbGRlciBxZW11IGlmDQo+PiBjb21wcmVzc2lvbiB0eXBlIGlzIHpsaWIuDQo+Pj4gU3VyZSwg
aXQgbWFrZXMgdGhlIGltYWdlIGltcG9zc2libGUgdG8gb3BlbiB3aXRoIG9sZGVyIHFlbXUsIGJ1
dA0KPj4+IGl0IGRvZXNuJ3QgZ2V0IGluIHRoZSB3YXkgb2YgbmV3ZXIgcWVtdSBvcGVuaW5nIGl0
LiBJJ2xsIGhhdmUgdG8gc2VlIGhvdw0KPj4+IHlvdXIgc3BlYyBjaGFuZ2VzIGRvY3VtZW50ZWQg
dGhpcywgdG8gc2VlIGlmIHlvdSBjb3VsZCBpbnN0ZWFkIHdvcmQgaXQNCj4+PiBhcyAnZm9yIFpM
SUIsIHRoZSBpbmNvbXBhdGlibGUgZmVhdHVyZSBmbGFnIG1heSBiZSBhYnNlbnQnLg0KPj4gSSBq
dXN0IGNhbid0IGltYWdpbmUgd2hlbiBhbmQgd2h5IHdlIHdvdWxkIHdhbnQgdG8gc2V0IGluY29t
cGF0aWJsZQ0KPj4gZmVhdHVyZSBmbGFnIHdpdGggemxpYi4gU3VwcG9zZSB3ZSBoYXZlIHpsaWIg
d2l0aCB0aGUgZmxhZyBzZXQsIHRoZW4NCj4+IG9sZGVyIHFlbXUgY2FuJ3Qgb3BlbiB0aGUgaW1h
Z2UgYWx0aG91Z2ggaXQgaXMgYWJsZSB0byB3b3JrIHdpdGggdGhlDQo+PiB6bGliIGNvbXByZXNz
aW9uIHR5cGUuIEZvciBub3csIEkgZG9uJ3QgdW5kZXJzdGFuZCB3aHkgd2Ugc2hvdWxkIG1ha2UN
Cj4+IHN1Y2ggYW4gYXJ0aWZpY2lhbCByZXN0cmljdGlvbi4NCj4gDQo+IFdlIGRvbid0IHdhbnQg
dG8gY3JlYXRlIHN1Y2ggaW1hZ2VzLCBidXQgd2Ugd2FudCB0byBrZWVwIG91ciBjb2RlIGFzDQo+
IHNpbXBsZSBhcyBwb3NzaWJsZS4NCj4gDQo+IEFzIHlvdXIgcGF0Y2ggc2hvd3MsIGZvcmJpZGRp
bmcgdGhlIGNhc2UgaXMgbW9yZSB3b3JrIHRoYW4ganVzdCBhbGxvd2luZw0KPiBpdC4gU28gaWYg
ZXh0ZXJuYWwgc29mdHdhcmUgY2FuIGNyZWF0ZSBzdWNoIGltYWdlcywgYW5kIGl0IHdvdWxkIGp1
c3QNCj4gYXV0b21hdGljYWxseSB3b3JrIGluIFFFTVUsIHRoZW4gd2h5IGRvIHRoZSBleHRyYSB3
b3JrIHRvIGFydGljaWZpYWxseQ0KPiBmb3JiaWQgdGhpcz8NCj4gDQo+IChBY3R1YWxseSwgaXQn
cyBsaWtlbHkgdGhhdCBvbiB0aGUgZmlyc3QgaGVhZGVyIHVwZGF0ZSwgUUVNVSB3b3VsZCBqdXN0
DQo+IGVuZCB1cCBkcm9wcGluZyB0aGUgdXNlbGVzcyBmbGFnLCBzbyB3ZSBldmVuICJmaXgiIHN1
Y2ggaW1hZ2VzLikNCm9rLCByZW1vdmluZyB0aGUgcmVzdHJpY3Rpb24NCj4gDQo+Pj4+IGRpZmYg
LS1naXQgYS9xYXBpL2Jsb2NrLWNvcmUuanNvbiBiL3FhcGkvYmxvY2stY29yZS5qc29uDQo+Pj4+
IGluZGV4IDdjY2JmZmY5ZDAuLjZhYThiOTk5OTMgMTAwNjQ0DQo+Pj4+IC0tLSBhL3FhcGkvYmxv
Y2stY29yZS5qc29uDQo+Pj4+ICsrKyBiL3FhcGkvYmxvY2stY29yZS5qc29uDQo+Pj4+IEBAIC03
OCw2ICs3OCw4IEBADQo+Pj4+ICAgICMNCj4+Pj4gICAgIyBAYml0bWFwczogQSBsaXN0IG9mIHFj
b3cyIGJpdG1hcCBkZXRhaWxzIChzaW5jZSA0LjApDQo+Pj4+ICAgICMNCj4+Pj4gKyMgQGNvbXBy
ZXNzaW9uLXR5cGU6IHRoZSBpbWFnZSBjbHVzdGVyIGNvbXByZXNzaW9uIG1ldGhvZCAoc2luY2Ug
NC4xKQ0KPj4+PiArIw0KPj4+PiAgICAjIFNpbmNlOiAxLjcNCj4+Pj4gICAgIyMNCj4+Pj4gICAg
eyAnc3RydWN0JzogJ0ltYWdlSW5mb1NwZWNpZmljUUNvdzInLA0KPj4+PiBAQCAtODksNyArOTEs
OCBAQA0KPj4+PiAgICAgICAgICAnKmNvcnJ1cHQnOiAnYm9vbCcsDQo+Pj4+ICAgICAgICAgICdy
ZWZjb3VudC1iaXRzJzogJ2ludCcsDQo+Pj4+ICAgICAgICAgICcqZW5jcnlwdCc6ICdJbWFnZUlu
Zm9TcGVjaWZpY1FDb3cyRW5jcnlwdGlvbicsDQo+Pj4+IC0gICAgICAnKmJpdG1hcHMnOiBbJ1Fj
b3cyQml0bWFwSW5mbyddDQo+Pj4+ICsgICAgICAnKmJpdG1hcHMnOiBbJ1Fjb3cyQml0bWFwSW5m
byddLA0KPj4+PiArICAgICAgJypjb21wcmVzc2lvbi10eXBlJzogJ1Fjb3cyQ29tcHJlc3Npb25U
eXBlJw0KPj4+IFdoeSBpcyB0aGlzIGZpZWxkIG9wdGlvbmFsPyBDYW4ndCB3ZSBhbHdheXMgcG9w
dWxhdGUgaXQsIGV2ZW4gZm9yIG9sZGVyDQo+Pj4gaW1hZ2VzPw0KPj4gV2h5IHdlIHNob3VsZCBp
ZiB3ZSBkb24ndCBjYXJlID8NCj4gDQo+IEkgd2FzIHRyeWluZyB0b28gY2hlY2sgd2hhdCB0aGUg
Y29uZGl0aW9uIGlzIHVuZGVyIHdoaWNoIHRoZSBmaWVsZCB3aWxsDQo+IGJlIHByZXNlbnQgaW4g
dGhlIG91dHB1dCwgYnV0IEkgY291bGRuJ3QgZmluZCBhbnkgY29kZSBmb3IgaXQuDQo+IA0KPiBT
byBpdCBsb29rcyBsaWtlIHRoaXMgcGF0Y2ggbmV2ZXIgbWFrZXMgdXNlIG9mIHRoZSBmaWVsZCBh
bmQgaXQncyBkZWFkDQo+IGNvZGU/DQpvaw0KPiANCj4gS2V2aW4NCj4gDQoNCi0tIA0KQmVzdCwN
CkRlbmlzDQo=

