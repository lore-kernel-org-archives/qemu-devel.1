Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC23C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 08:15:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1357520715
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 08:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="KBgH2xtu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1357520715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijIs2-00079y-Vu
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 03:15:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1ijIrB-0006iH-5K
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 03:14:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ani.sinha@nutanix.com>) id 1ijIr9-0005i8-8Q
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 03:14:24 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:59830)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ani.sinha@nutanix.com>)
 id 1ijIr8-0005bJ-Ts
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 03:14:23 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBN86Wre000885; Mon, 23 Dec 2019 00:14:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=h0Ep6kU92nk1byV05KXHGEspsHoftkHa9+kD/tJvHMw=;
 b=KBgH2xtuzIACaUrwME6B+X4Xuxim9wGgJ4NO6YVhukyciyjVpX5PtJaeqJH62zkg8Pp6
 MP96AKoyvp/QiAwiwv9rWVpTz0f2MEmkege8qn4OZ2TvfXiD/1io4FrPC2Zfghukus6q
 XdYA6k53g5rGzuC7rgdzPYAi32RjmFeO9NWZynt4RrSS3HLwQ21OtHDd0WDMkaFHBche
 bGyFxQ1CvNtRE+9mVfrhUT9UqGQM/39bdgJosnYNnXd6Las1TTe59iPpI3UIkotf1b1b
 bVQVhC+Z4N66vu+mMDkHNK5YRSxGUqsCLrsEUA1Rxrk7fxNpygSeGVE9IPYeyrxlrYYq cQ== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam04lp2055.outbound.protection.outlook.com [104.47.44.55])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2x1gkyjv0c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Dec 2019 00:14:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPJ8mvOsE86WdUUDZVAjRPu9vRpCB8RxaEHI1DVjCVmS7H69m3Pu+peNd/BtDGzaH/HEcIL10XvTVkYnbX18geQv/dQJL5qruZVaNDdTpdTScYZWLvMuGP8aYw73c5OCwDqz7jyTSvo2B7B2pBcGyH6/xDj6lcIboU0v0V9/JuZV9byUrQ3CkrbHbF/ZisidHXY2scn8MqXmWqfHcorUZ+j7QpCL1N1KCBTNjCp5wenC5m7WnAfRMMXxgdzgl0fF61zGWbkJmBgT44/BMnHZNXxiD2/m6B76FvCpAPUk6h3vVXQ/5DChiTJFLvp5kXN1JjKQlX381mKfcrR1Xbj66w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0Ep6kU92nk1byV05KXHGEspsHoftkHa9+kD/tJvHMw=;
 b=DiHqOyot8rm/tUzN93dlYMoFAqE0n3wsMblgvnOyRGA9wLDQX3OPrFa7pNyg4AeC04iLn2NXq1DGre06vzB9Br20tEkPPjR+XDWmnTbApA8lP32jEO+s2yiLbGqkQKIRHGREyRE72DZ6R7rHGK2MFnjuKKBmziw2SgJSfN2VtysqHnv/dhFNKoHs8tISiKVurcuPwRKgrAC920j8Dg9OEyqpUFffSdkWhvkypSphLC3WfGBczpng0BOhoUzacAu1VZ0ReHJ0lhraraxF5N2QpaOlgxiEEPl8O11lBW7c5/thpuUxbmX861mH3jDU7Dp6WjLTkDWFV3Kd/HZOmE+qPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB6303.namprd02.prod.outlook.com (52.132.175.28) by
 MN2PR02MB6126.namprd02.prod.outlook.com (52.132.174.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Mon, 23 Dec 2019 08:14:18 +0000
Received: from MN2PR02MB6303.namprd02.prod.outlook.com
 ([fe80::e506:4fa8:c846:e53c]) by MN2PR02MB6303.namprd02.prod.outlook.com
 ([fe80::e506:4fa8:c846:e53c%3]) with mapi id 15.20.2559.017; Mon, 23 Dec 2019
 08:14:18 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] i386: pass CLZERO to guests with EPYC CPU model on AMD
 ZEN platform
Thread-Topic: [PATCH] i386: pass CLZERO to guests with EPYC CPU model on AMD
 ZEN platform
Thread-Index: AQHVtYKm5uylcpuSJ0uEmLmhvuRW56e/yJSAgAYAW4CAAAvdAIABkhyA
Date: Mon, 23 Dec 2019 08:14:18 +0000
Message-ID: <1E885A11-2534-4801-B54E-F8E68A514ACA@nutanix.com>
References: <1576659933-37123-1-git-send-email-ani.sinha@nutanix.com>
 <2883fd0e-191a-c5a4-be1c-04442c8de1c9@redhat.com>
 <7452FAE9-ACDF-495E-AE5A-8A8ED9488B03@nutanix.com>
 <CABgObfaNtUsDiQ8SrwzsTmJEkqa14RiDyUmxeeAgNwYHUm2F7w@mail.gmail.com>
In-Reply-To: <CABgObfaNtUsDiQ8SrwzsTmJEkqa14RiDyUmxeeAgNwYHUm2F7w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [115.96.107.217]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72f2f908-6d14-47e2-5993-08d787801b73
x-ms-traffictypediagnostic: MN2PR02MB6126:
x-microsoft-antispam-prvs: <MN2PR02MB61265B7C59A3AE8C1D800F44F12E0@MN2PR02MB6126.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0260457E99
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(346002)(136003)(366004)(39860400002)(199004)(189003)(66556008)(64756008)(66446008)(53546011)(2906002)(66476007)(6506007)(6512007)(36756003)(5660300002)(66946007)(26005)(91956017)(86362001)(76116006)(2616005)(44832011)(71200400001)(316002)(33656002)(81166006)(81156014)(8676002)(6916009)(186003)(4326008)(54906003)(8936002)(6486002)(478600001)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR02MB6126;
 H:MN2PR02MB6303.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xSpWXqimx66KefiJI25PWlpSGraBabhS9zb31rRZExdfMv/qUTMC+OdfBAytGQUK5y0ozrUNcGwc4JEvtkaUx6+y7U7/kjI/oRuO/G94wLolxGbuWd+U81LMKCOj6SGEWjMZA+YXEHeTwIAEEBSEa1twZaSmCSrM/pz9ELv17Ju50VSNfg0W7Dd4QA5HdLhZ5OOhhQ8Du8nXMkP8XBXCeLs3YmLqgwKGQalAIMtuWpjNJu339UBjA4SmBD+b+XN1O+4YfPWyfug9BBuYArWnoX+aAGJ3lQ3LTmeYU0h5wuvmPsZ3qPQw/gz8KBhbHjEKH4Ok/9iwLDzM+h6hWQCkEuyGGt6mta2J5mhxz60vgeZQCFEJ+Dl9ejKPrw85fka2WUZKBioxRyGbEB8wYdc8HtmQX3LxQOMv7fWfQiNfe/ZvnELVsBNQQDCo1wl9/M7RibrunNc0Lda6/eB+5XnrByUQjb59LGvTNkD0T55mEyRhSuCsvy1k9ddC2+WtYPdd
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2801AD762A56140861AB388E4DD9CF8@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f2f908-6d14-47e2-5993-08d787801b73
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2019 08:14:18.0893 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UVd2xyxgaRI1Tev5ExQIKeaym5obBY3GcW/yTyKyY9sCIOGP6zxoTQdfITj3T+3PYeic+qXuUfOPLgHjaXinqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6126
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-23_03:2019-12-17,2019-12-23 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.151.68
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Habkost,
 Eduardo" <ehabkost@redhat.com>, rth <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gT24gRGVjIDIyLCAyMDE5LCBhdCAxOjQ1IFBNLCBQYW9sbyBCb256aW5pIDxwYm9uemlu
aUByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IA0KPiANCj4gSWwgZG9tIDIyIGRpYyAyMDE5LCAw
ODo0OSBBbmkgU2luaGEgPGFuaS5zaW5oYUBudXRhbml4LmNvbT4gaGEgc2NyaXR0bzoNCj4gDQo+
IFBpbmcg4oCmDQo+IA0KPiBXaHkgcGluZz8gWW91IGdvdCBxdWVzdGlvbnMgZnJvbSBFZHVhcmRv
LCBzbyB5b3UgbmVlZCB0byBhbnN3ZXIgdGhlbSBhbmQvb3Igc2VuZCBhIGZpeGVkIHZlcnNpb24g
b2YgdGhlIHBhdGNoLg0KPiANCg0KDQpNYXliZSBoZSByZXNwb25kZWQgcHJpdmF0ZWx5IGJ1dCBJ
IGRpZCBub3QgZ2V0IGFueSBxdWVzdGlvbnMgZnJvbSBFZHVhcmRvLg0KDQpBbmkNCg0KDQo+IFRo
YW5rcywNCj4gDQo+IFBhb2xvDQo+IA0KPiANCj4gPiBPbiBEZWMgMTgsIDIwMTksIGF0IDU6MjMg
UE0sIFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+IHdyb3RlOg0KPiA+IA0KPiA+
IE9uIDE4LzEyLzE5IDEwOjA1LCBBbmkgU2luaGEgd3JvdGU6DQo+ID4+IENMWkVSTyBDUFVJRCBz
aG91bGQgYmUgcGFzc2VkIG9uIHRvIHRoZSBndWVzdHMgdGhhdCB1c2UgRVBZQyBvciBFUFlDLUlC
UEIgQ1BVDQo+ID4+IG1vZGVsIHdoZW4gdGhlIEFNRCBaRU4gYmFzZWQgaG9zdCBzdXBwb3J0cyBp
dC4gVGhpcyBjaGFuZ2UgbWFrZXMgaXQgcmVjb2duaXplDQo+ID4+IHRoaXMgQ1BVSUQgZm9yIGd1
ZXN0cyB3aGljaCB1c2UgRVBZQyBvciBFUFlDLUlCUEIgQ1BVIG1vZGVsLg0KPiA+PiANCj4gPj4g
U2lnbmVkLW9mZi1ieTogQW5pIFNpbmhhIDxhbmkuc2luaGFAbnV0YW5peC5jb20+DQo+ID4+IC0t
LQ0KPiA+PiB0YXJnZXQvaTM4Ni9jcHUuYyB8IDIgKysNCj4gPj4gMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKQ0KPiA+PiANCj4gPj4gZGlmZiAtLWdpdCBhL3RhcmdldC9pMzg2L2NwdS5j
IGIvdGFyZ2V0L2kzODYvY3B1LmMNCj4gPj4gaW5kZXggNjlmNTE4YS4uNTVmMDY5MSAxMDA2NDQN
Cj4gPj4gLS0tIGEvdGFyZ2V0L2kzODYvY3B1LmMNCj4gPj4gKysrIGIvdGFyZ2V0L2kzODYvY3B1
LmMNCj4gPj4gQEAgLTM4MTMsNiArMzgxMyw4IEBAIHN0YXRpYyBYODZDUFVEZWZpbml0aW9uIGJ1
aWx0aW5feDg2X2RlZnNbXSA9IHsNCj4gPj4gICAgICAgICAgICAgQ1BVSURfRVhUM19NSVNBTElH
TlNTRSB8IENQVUlEX0VYVDNfU1NFNEEgfCBDUFVJRF9FWFQzX0FCTSB8DQo+ID4+ICAgICAgICAg
ICAgIENQVUlEX0VYVDNfQ1I4TEVHIHwgQ1BVSURfRVhUM19TVk0gfCBDUFVJRF9FWFQzX0xBSEZf
TE0gfA0KPiA+PiAgICAgICAgICAgICBDUFVJRF9FWFQzX1RPUE9FWFQsDQo+ID4+ICsgICAgICAg
IC5mZWF0dXJlc1tGRUFUXzgwMDBfMDAwOF9FQlhdID0NCj4gPj4gKyAgICAgICAgICAgIENQVUlE
XzgwMDBfMDAwOF9FQlhfQ0xaRVJPLA0KPiA+PiAgICAgICAgIC5mZWF0dXJlc1tGRUFUXzdfMF9F
QlhdID0NCj4gPj4gICAgICAgICAgICAgQ1BVSURfN18wX0VCWF9GU0dTQkFTRSB8IENQVUlEXzdf
MF9FQlhfQk1JMSB8IENQVUlEXzdfMF9FQlhfQVZYMiB8DQo+ID4+ICAgICAgICAgICAgIENQVUlE
XzdfMF9FQlhfU01FUCB8IENQVUlEXzdfMF9FQlhfQk1JMiB8IENQVUlEXzdfMF9FQlhfUkRTRUVE
IHwNCj4gPj4gDQo+ID4gDQo+ID4gVGhpcyBuZWVkcyB0byBiZSBkb25lIG9ubHkgZm9yIG5ld2Vy
IG1hY2hpbmUgdHlwZSAob3IgaXMgaXQgQ1BVIG1vZGVsDQo+ID4gdmVyc2lvbnMgbm93PyBuZWVk
IEVkdWFyZG8gdG8gcmVzcG9uZCkuDQo+ID4gDQo+ID4gUGFvbG8NCj4gDQoNCg==

