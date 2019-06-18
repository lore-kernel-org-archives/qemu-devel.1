Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1A1C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 15:06:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADE5F20873
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 15:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XzgQDPYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE5F20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58798 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdFhC-0000iE-5C
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 11:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39391)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hdFGB-0002Ta-Q6
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 10:38:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hdFGA-00009H-9T
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 10:38:55 -0400
Received: from mail-eopbgr130099.outbound.protection.outlook.com
 ([40.107.13.99]:30371 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hdFG6-0008Vq-I3; Tue, 18 Jun 2019 10:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dza+pq5gdv68Phl1W7wNgJ+t/IKGNBkSjdCsJVQuOjk=;
 b=XzgQDPYq93T+iUD0YFGVCMQ9ZFZzFr/FKeZB0HBLP/ImcC0Y6rDYfmX9c0Vc3oYTafr7IxBtmw0v2YmriYZKkda9euFHIC+zKaWh3nOrlcMhWvJtqn7mJ/B9wtj2I1WsNf35/OEA9XHP87z7je8HBNH9ktuRAo4yC+qq0qSZUus=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB4377.eurprd08.prod.outlook.com (20.179.42.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Tue, 18 Jun 2019 14:38:48 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 14:38:48 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v2 6/9] block/qcow2-bitmap: do not remove
 bitmaps on reopen-ro
Thread-Index: AQHVF85osztyDSgPBUivffu7cD6tmaaF7DGAgAPOUICAF9qQgIAAAmCA
Date: Tue, 18 Jun 2019 14:38:48 +0000
Message-ID: <d1c64c60-5152-c23b-dcbd-475b8442c93c@virtuozzo.com>
References: <20190531163202.162543-1-vsementsov@virtuozzo.com>
 <20190531163202.162543-7-vsementsov@virtuozzo.com>
 <38975505-c3ed-982e-1875-5f6d650f01da@redhat.com>
 <cddfad9b-7bf0-8924-a07e-a2ca449e7722@virtuozzo.com>
 <ba9fe8ee-f96a-9bab-9337-ec8937e0542b@redhat.com>
In-Reply-To: <ba9fe8ee-f96a-9bab-9337-ec8937e0542b@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0298.eurprd05.prod.outlook.com
 (2603:10a6:7:93::29) To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190618173843164
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b66510d-fef8-4a98-c029-08d6f3faaada
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4377; 
x-ms-traffictypediagnostic: DBBPR08MB4377:
x-microsoft-antispam-prvs: <DBBPR08MB43774A40E39BCAB6B30A041DC1EA0@DBBPR08MB4377.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(136003)(366004)(39850400004)(396003)(189003)(199004)(52314003)(446003)(8936002)(6246003)(5660300002)(478600001)(31686004)(76176011)(305945005)(6512007)(52116002)(25786009)(102836004)(3846002)(6116002)(68736007)(186003)(71190400001)(36756003)(53546011)(6506007)(6436002)(107886003)(81166006)(71200400001)(386003)(7736002)(26005)(53936002)(6486002)(14454004)(2501003)(256004)(2906002)(14444005)(86362001)(476003)(11346002)(486006)(19627235002)(54906003)(2201001)(2616005)(229853002)(66066001)(316002)(110136005)(66446008)(4326008)(31696002)(66556008)(99286004)(66476007)(8676002)(64756008)(81156014)(73956011)(66946007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4377;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FCpEEKV5MhKf91kstb/+Q1645twRCp5Z8TU9A41h4XUm8yT0r0SxgFqo6pEc4slUFbYicJrwSSulhP1uQ423cRD6Ja5AYULHpSzZce9WMXgO+WxZjdHmkImxpPq9eIip5VU4chhMRQ9EmYK4WgORyjD2TSgQdq+kcvEbVBTiGjAvJFMe0XbOBP1NFQtR9eeoBWr49UVv8IZkEge9o4og2xPWuCNf5UmersJAN6ahYCkgWMgpnzFi6QYErxYUbkNOzC/ZBwhmxRJcW/Ckv+m0jR+tb8JrbWEdYzvuVkHf0QjiAzcm5eqRYl5/Od5L23EnCSuMmV0UPfntMiwuDOJI/Wt6oFEUEzwqxu+pd7IDt3GyP0yaz175gOc8ZNOv/FYLXKwcYe92PCz6EPMhVaBvmgrjh1f64u9prAJRP0OBWNI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEC7309ADD591146AC3D6BF4747B2962@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b66510d-fef8-4a98-c029-08d6f3faaada
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 14:38:48.1034 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4377
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.99
Subject: Re: [Qemu-devel] [PATCH v2 6/9] block/qcow2-bitmap: do not remove
 bitmaps on reopen-ro
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
 Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTguMDYuMjAxOSAxNzozMCwgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDYvMy8xOSA2
OjE0IEFNLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gMDEuMDYuMjAx
OSAzOjA2LCBKb2huIFNub3cgd3JvdGU6DQo+Pj4NCj4+Pg0KPj4+IE9uIDUvMzEvMTkgMTI6MzEg
UE0sIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4+IHFjb3cyX3Jlb3Bl
bl9iaXRtYXBzX3JvIHdhbnRzIHRvIHN0b3JlIGJpdG1hcHMgYW5kIHRoZW4gbWFyayB0aGVtIGFs
bA0KPj4+PiByZWFkb25seS4gQnV0IHRoZSBsYXR0ZXIgZG9uJ3Qgd29yaywgYXMNCj4+Pj4gcWNv
dzJfc3RvcmVfcGVyc2lzdGVudF9kaXJ0eV9iaXRtYXBzIHJlbW92ZXMgYml0bWFwcyBhZnRlciBz
dG9yaW5nLg0KPj4+PiBJdCdzIE9LIGZvciBpbmFjdGl2YXRpb24gYnV0IGJhZCBpZGVhIGZvciBy
ZW9wZW4tcm8uIEFuZCB0aGlzIGxlYWRzIHRvDQo+Pj4+IHRoZSBmb2xsb3dpbmcgYnVnOg0KPj4+
Pg0KPj4+PiBBc3N1bWUgd2UgaGF2ZSBwZXJzaXN0ZW50IGJpdG1hcCAnYml0bWFwMCcuDQo+Pj4+
IENyZWF0ZSBleHRlcm5hbCBzbmFwc2hvdA0KPj4+PiAgICAgYml0bWFwMCBpcyBzdG9yZWQgYW5k
IHRoZXJlZm9yZSByZW1vdmVkDQo+Pj4+IENvbW1pdCBzbmFwc2hvdA0KPj4+PiAgICAgbm93IHdl
IGhhdmUgbm8gYml0bWFwcw0KPj4+PiBEbyBzb21lIHdyaXRlcyBmcm9tIGd1ZXN0ICgqKQ0KPj4+
PiAgICAgdGhleSBhcmUgbm90IG1hcmtlZCBpbiBiaXRtYXANCj4+Pj4gU2h1dGRvd24NCj4+Pj4g
U3RhcnQNCj4+Pj4gICAgIGJpdG1hcDAgaXMgbG9hZGVkIGFzIHZhbGlkLCBidXQgaXQgaXMgYWN0
dWFsbHkgYnJva2VuISBJdCBtaXNzZXMNCj4+Pj4gICAgIHdyaXRlcyAoKikNCj4+Pj4gSW5jcmVt
ZW50YWwgYmFja3VwDQo+Pj4+ICAgICBpdCB3aWxsIGJlIGluY29uc2lzdGVudA0KPj4+Pg0KPj4+
PiBTbywgbGV0J3Mgc3RvcCByZW1vdmluZyBiaXRtYXBzIG9uIHJlb3Blbi1yby4gQnV0IGRvbid0
IHJlam9pY2U6DQo+Pj4+IHJlb3BlbmluZyBiaXRtYXBzIHRvIHJ3IGlzIGJyb2tlbiB0b28sIHNv
IHRoZSB3aG9sZSBzY2VuYXJpbyB3aWxsIG5vdA0KPj4+PiB3b3JrIGFmdGVyIHRoaXMgcGF0Y2gg
YW5kIHdlIGNhbid0IGVuYWJsZSBjb3JyZXNwb25kaW5nIHRlc3QgY2FzZXMgaW4NCj4+Pj4gMjU1
IGlvdGVzdHMgc3RpbGwuIFJlb3BlbmluZyBiaXRtYXBzIHJ3IHdpbGwgYmUgZml4ZWQgaW4gdGhl
IGZvbGxvd2luZw0KPj4+PiBwYXRjaGVzLg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBWbGFk
aW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+Pj4+
IC0tLQ0KPj4+PiAgICBibG9jay9xY293Mi5oICAgICAgICB8ICAzICsrLQ0KPj4+PiAgICBibG9j
ay9xY293Mi1iaXRtYXAuYyB8IDQ2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLS0tDQo+Pj4+ICAgIGJsb2NrL3Fjb3cyLmMgICAgICAgIHwgIDIgKy0NCj4+Pj4gICAg
MyBmaWxlcyBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkNCj4+Pj4N
Cj4+Pj4gZGlmZiAtLWdpdCBhL2Jsb2NrL3Fjb3cyLmggYi9ibG9jay9xY293Mi5oDQo+Pj4+IGlu
ZGV4IDg4YTIwMzBmNTQuLjRjODQzNTE0MWIgMTAwNjQ0DQo+Pj4+IC0tLSBhL2Jsb2NrL3Fjb3cy
LmgNCj4+Pj4gKysrIGIvYmxvY2svcWNvdzIuaA0KPj4+PiBAQCAtNzM0LDcgKzczNCw4IEBAIFFj
b3cyQml0bWFwSW5mb0xpc3QgKnFjb3cyX2dldF9iaXRtYXBfaW5mb19saXN0KEJsb2NrRHJpdmVy
U3RhdGUgKmJzLA0KPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBFcnJvciAqKmVycnApOw0KPj4+PiAgICBpbnQgcWNvdzJfcmVvcGVuX2JpdG1h
cHNfcncoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIEVycm9yICoqZXJycCk7DQo+Pj4+ICAgIGludCBx
Y293Ml90cnVuY2F0ZV9iaXRtYXBzX2NoZWNrKEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBFcnJvciAq
KmVycnApOw0KPj4+PiAtdm9pZCBxY293Ml9zdG9yZV9wZXJzaXN0ZW50X2RpcnR5X2JpdG1hcHMo
QmxvY2tEcml2ZXJTdGF0ZSAqYnMsIEVycm9yICoqZXJycCk7DQo+Pj4+ICt2b2lkIHFjb3cyX3N0
b3JlX3BlcnNpc3RlbnRfZGlydHlfYml0bWFwcyhCbG9ja0RyaXZlclN0YXRlICpicywNCj4+Pj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgcmVsZWFzZV9z
dG9yZWQsIEVycm9yICoqZXJycCk7DQo+Pj4+ICAgIGludCBxY293Ml9yZW9wZW5fYml0bWFwc19y
byhCbG9ja0RyaXZlclN0YXRlICpicywgRXJyb3IgKiplcnJwKTsNCj4+Pj4gICAgYm9vbCBxY293
Ml9jYW5fc3RvcmVfbmV3X2RpcnR5X2JpdG1hcChCbG9ja0RyaXZlclN0YXRlICpicywNCj4+Pj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpuYW1l
LA0KPj4+PiBkaWZmIC0tZ2l0IGEvYmxvY2svcWNvdzItYml0bWFwLmMgYi9ibG9jay9xY293Mi1i
aXRtYXAuYw0KPj4+PiBpbmRleCBmYmVlZTM3MjQzLi4yNWIxZTA2OWE3IDEwMDY0NA0KPj4+PiAt
LS0gYS9ibG9jay9xY293Mi1iaXRtYXAuYw0KPj4+PiArKysgYi9ibG9jay9xY293Mi1iaXRtYXAu
Yw0KPj4+PiBAQCAtMTQzMiw3ICsxNDMyLDI5IEBAIGZhaWw6DQo+Pj4+ICAgICAgICBiaXRtYXBf
bGlzdF9mcmVlKGJtX2xpc3QpOw0KPj4+PiAgICB9DQo+Pj4+ICAgIA0KPj4+PiAtdm9pZCBxY293
Ml9zdG9yZV9wZXJzaXN0ZW50X2RpcnR5X2JpdG1hcHMoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIEVy
cm9yICoqZXJycCkNCj4+Pj4gKy8qDQo+Pj4+ICsgKiBxY293Ml9zdG9yZV9wZXJzaXN0ZW50X2Rp
cnR5X2JpdG1hcHMNCj4+Pj4gKyAqDQo+Pj4+ICsgKiBTdG9yZXMgcGVyc2lzdGVudCBCZHJ2RGly
dHlCaXRtYXAncy4NCj4+Pj4gKyAqDQo+Pj4NCj4+PiBObyBhcG9zdHJvcGhlIGZvciBwbHVyYWwn
cw0KPj4NCj4+IEkgYWx3YXlzIGRvIHNvLCBhcyBpdCBzZWVtcyBzdHJhbmdlIHRvIG1lIHRvIGFw
cGVuZCAncycgdG8gaWRlbnRpZmllcnMuLg0KPj4gU2hvdWxkIEkgd3JpdGUgaXQgQmRydkRpcnR5
Qml0bWFwcz8gSXQgc291bmRzIGFzIHNvbWUgb3RoZXIgaWRlbnRpZmllci4uLg0KPj4NCj4gDQo+
IFRoaXMgaXMgYSByZWN1cnJpbmcgcHJvYmxlbSB3aXRoIEVuZ2xpc2guIFRoZSB0ZXJtICJDRCdz
IiBpcyBpbiBjb21tb24NCj4gdXNhZ2UgZm9yIHRoaXMgcmVhc29uLCBldmVuIHRob3VnaCBpdCdz
IGdyYW1tYXRpY2FsbHkgaW5jb3JyZWN0Lg0KPiBIb25lc3RseSwgSSBkb24ndCBoYXZlIGFuIGFu
c3dlciBmb3IgeW91LCBidXQgeW91IGNvdWxkIHRyeSB0byBhdm9pZCBpdDoNCj4gDQo+ICJTdG9y
ZXMgcGVyc2lzdGVudCBCZHJ2RGlydHlCaXRtYXAgb2JqZWN0cyINCj4gDQo+IEl0J3MgY2x1bmtp
ZXIsIGJ1dCBpdCBhdm9pZHMgYWRkaW5nIGEgcGx1cmFsIHRvIGFuIGlkZW50aWZpZXIuIEluIG1h
cmtlZA0KPiB1cCB0ZXh0LCBpdCdzIG5vdCB1bmNvbW1vbiB0byBzZWUgYEJkcnZEaXJ0eUJpdG1h
cGBzLCBidXQgdGhhdCB3b3VsZA0KPiBsb29rIHNpbGx5IGhlcmUuDQo+IA0KPj4+DQo+Pj4+ICsg
KiBAcmVsZWFzZV9zdG9yZWQ6IGlmIHRydWUsIHJlbGVhc2UgQmRydkRpcnR5Qml0bWFwJ3MgYWZ0
ZXIgc3RvcmluZyB0byB0aGUNCj4+Pj4gKyAqIGltYWdlLiBUaGlzIGlzIHVzZWQgaW4gdHdvIGNh
c2VzLCBib3RoIHZpYSBxY293Ml9pbmFjdGl2YXRlOg0KPj4+PiArICogMS4gYmRydl9jbG9zZTog
SXQncyBjb3JyZWN0IHRvIHJlbW92ZSBiaXRtYXBzIG9uIGNsb3NlLg0KPj4+PiArICogMi4gbWln
cmF0aW9uOiBJZiBiaXRtYXBzIGFyZSBtaWdyYXRlZCB0aHJvdWdoIG1pZ3JhdGlvbiBjaGFubmVs
IHZpYQ0KPj4+PiArICogICAgJ2RpcnR5LWJpdG1hcHMnIG1pZ3JhdGlvbiBjYXBhYmlsaXR5IHRo
ZXkgYXJlIG5vdCBoYW5kbGVkIGJ5IHRoaXMgY29kZS4NCj4+Pj4gKyAqICAgIE90aGVyd2lzZSwg
aXQncyBPSyB0byBkcm9wIEJkcnZEaXJ0eUJpdG1hcCdzIGFuZCByZWxvYWQgdGhlbSBvbg0KPj4+
PiArICogICAgaW52YWxpZGF0aW9uLg0KPj4+PiArICoNCj4+Pj4gKyAqIEFueXdheSwgaXQncyBj
b3JyZWN0IHRvIHJlbW92ZSBCZHJ2RGlydHlCaXRtYXAncyBvbiBpbmFjdGl2YXRpb24sIGFzDQo+
Pj4+ICsgKiBpbmFjdGl2YXRpb24gbWVhbnMgdGhhdCB3ZSBsb3NlIGNvbnRyb2wgb24gZGlzaywg
YW5kIHRoZXJlZm9yZSBvbiBiaXRtYXBzLA0KPj4+PiArICogd2Ugc2hvdWxkIHN5bmMgdGhlbSBh
bmQgZG8gbm90IHRvdWNoIG1vcmUuDQo+Pj4+ICsgKg0KPj4+PiArICogQ29udHJhcml3aXNlLCB3
ZSBkb24ndCB3YW50IHRvIHJlbGVhc2UgYW55IGJpdG1hcHMgb24ganVzdCByZW9wZW4tdG8tcm8s
DQo+Pj4+ICsgKiB3aGVuIHdlIG5lZWQgdG8gc3RvcmUgdGhlbSwgYXMgaW1hZ2UgaXMgc3RpbGwg
dW5kZXIgb3VyIGNvbnRyb2wsIGFuZCBpdCdzDQo+Pj4+ICsgKiBnb29kIHRvIGtlZXAgYWxsIHRo
ZSBiaXRtYXBzIGluIHJlYWQtb25seSBtb2RlLg0KPj4+PiArICovDQo+Pj4NCj4+PiBJIGhhdmUg
dG8gYWRtaXQgdGhhdCAnQ29udHJhcml3aXNlJyBpcyBub3QgYW4gZXZlcnlkYXkgdGVybSBmb3Ig
bWUuIFlvdQ0KPj4+IHNob3VsZCBrZWVwIGl0IGluIGhlcmUganVzdCBmb3IgZnVuLCBpbiBteSBv
cGluaW9uLg0KPj4NCj4+IEFoYWhhLCBJJ3ZlIGp1c3QgdXNlZCBpdCBpbiBteSBwcmV2aW91cyBy
ZXBseS4NCj4+DQo+Pj4NCj4+PiBSZWdhcmRpbmcgIml0J3MgZ29vZCB0byBrZWVwIGFsbCB0aGUg
Yml0bWFwcyBpbiByZWFkLW9ubHkgbW9kZSI6DQo+Pj4gTW9yZSBkaXJlY3RseSwga2VlcGluZyB0
aGVtIHJlYWQtb25seSBpcyBjb3JyZWN0IGJlY2F1c2UgdGhpcyBpcyB3aGF0DQo+Pj4gd291bGQg
aGFwcGVuIGlmIHdlIG9wZW5lZCB0aGUgbm9kZSByZWFkb25seSB0byBiZWdpbiB3aXRoLCBhbmQg
d2hldGhlcg0KPj4+IHdlIG9wZW5lZCBkaXJlY3RseSBvciByZW9wZW5lZCB0byB0aGF0IHN0YXRl
IHNob3VsZG4ndCBtYXR0ZXIgZm9yIHRoZQ0KPj4+IHN0YXRlIHdlIGdldCBhZnRlcndhcmQuDQo+
Pg0KPj4gQWdyZWUsIHRoaXMgaXMgYmV0dGVyIHJlYXNvbmluZy4NCj4+DQo+Pj4NCj4+Pj4gK3Zv
aWQgcWNvdzJfc3RvcmVfcGVyc2lzdGVudF9kaXJ0eV9iaXRtYXBzKEJsb2NrRHJpdmVyU3RhdGUg
KmJzLA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9v
bCByZWxlYXNlX3N0b3JlZCwgRXJyb3IgKiplcnJwKQ0KPj4+PiAgICB7DQo+Pj4+ICAgICAgICBC
ZHJ2RGlydHlCaXRtYXAgKmJpdG1hcDsNCj4+Pj4gICAgICAgIEJEUlZRY293MlN0YXRlICpzID0g
YnMtPm9wYXF1ZTsNCj4+Pj4gQEAgLTE1NDUsMjAgKzE1NjcsMTQgQEAgdm9pZCBxY293Ml9zdG9y
ZV9wZXJzaXN0ZW50X2RpcnR5X2JpdG1hcHMoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIEVycm9yICoq
ZXJycCkNCj4+Pj4gICAgICAgICAgICBnX2ZyZWUodGIpOw0KPj4+PiAgICAgICAgfQ0KPj4+PiAg
ICANCj4+Pj4gLSAgICBRU0lNUExFUV9GT1JFQUNIKGJtLCBibV9saXN0LCBlbnRyeSkgew0KPj4+
PiAtICAgICAgICAvKiBGb3Igc2FmZXR5LCB3ZSByZW1vdmUgYml0bWFwIGFmdGVyIHN0b3Jpbmcu
DQo+Pj4+IC0gICAgICAgICAqIFdlIG1heSBiZSBoZXJlIGluIHR3byBjYXNlczoNCj4+Pj4gLSAg
ICAgICAgICogMS4gYmRydl9jbG9zZS4gSXQncyBvayB0byBkcm9wIGJpdG1hcC4NCj4+Pj4gLSAg
ICAgICAgICogMi4gaW5hY3RpdmF0aW9uLiBJdCBtZWFucyBtaWdyYXRpb24gd2l0aG91dCAnZGly
dHktYml0bWFwcycNCj4+Pj4gLSAgICAgICAgICogICAgY2FwYWJpbGl0eSwgc28gYml0bWFwcyBh
cmUgbm90IG1hcmtlZCB3aXRoDQo+Pj4+IC0gICAgICAgICAqICAgIEJkcnZEaXJ0eUJpdG1hcC5t
aWdyYXRpb24gZmxhZ3MuIEl0J3Mgbm90IGJhZCB0byBkcm9wIHRoZW0gdG9vLA0KPj4+PiAtICAg
ICAgICAgKiAgICBhbmQgcmVsb2FkIG9uIGludmFsaWRhdGlvbi4NCj4+Pj4gLSAgICAgICAgICov
DQo+Pj4+IC0gICAgICAgIGlmIChibS0+ZGlydHlfYml0bWFwID09IE5VTEwpIHsNCj4+Pj4gLSAg
ICAgICAgICAgIGNvbnRpbnVlOw0KPj4+PiAtICAgICAgICB9DQo+Pj4+ICsgICAgaWYgKHJlbGVh
c2Vfc3RvcmVkKSB7DQo+Pj4+ICsgICAgICAgIFFTSU1QTEVRX0ZPUkVBQ0goYm0sIGJtX2xpc3Qs
IGVudHJ5KSB7DQo+Pj4+ICsgICAgICAgICAgICBpZiAoYm0tPmRpcnR5X2JpdG1hcCA9PSBOVUxM
KSB7DQo+Pj4+ICsgICAgICAgICAgICAgICAgY29udGludWU7DQo+Pj4+ICsgICAgICAgICAgICB9
DQo+Pj4+ICAgIA0KPj4+PiAtICAgICAgICBiZHJ2X3JlbGVhc2VfZGlydHlfYml0bWFwKGJzLCBi
bS0+ZGlydHlfYml0bWFwKTsNCj4+Pj4gKyAgICAgICAgICAgIGJkcnZfcmVsZWFzZV9kaXJ0eV9i
aXRtYXAoYnMsIGJtLT5kaXJ0eV9iaXRtYXApOw0KPj4+PiArICAgICAgICB9DQo+Pj4+ICAgICAg
ICB9DQo+Pj4+ICAgIA0KPj4+PiAgICBzdWNjZXNzOg0KPj4+PiBAQCAtMTU4Niw3ICsxNjAyLDcg
QEAgaW50IHFjb3cyX3Jlb3Blbl9iaXRtYXBzX3JvKEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBFcnJv
ciAqKmVycnApDQo+Pj4+ICAgICAgICBCZHJ2RGlydHlCaXRtYXAgKmJpdG1hcDsNCj4+Pj4gICAg
ICAgIEVycm9yICpsb2NhbF9lcnIgPSBOVUxMOw0KPj4+PiAgICANCj4+Pj4gLSAgICBxY293Ml9z
dG9yZV9wZXJzaXN0ZW50X2RpcnR5X2JpdG1hcHMoYnMsICZsb2NhbF9lcnIpOw0KPj4+PiArICAg
IHFjb3cyX3N0b3JlX3BlcnNpc3RlbnRfZGlydHlfYml0bWFwcyhicywgZmFsc2UsICZsb2NhbF9l
cnIpOw0KPj4+PiAgICAgICAgaWYgKGxvY2FsX2VyciAhPSBOVUxMKSB7DQo+Pj4+ICAgICAgICAg
ICAgZXJyb3JfcHJvcGFnYXRlKGVycnAsIGxvY2FsX2Vycik7DQo+Pj4+ICAgICAgICAgICAgcmV0
dXJuIC1FSU5WQUw7DQo+Pj4+IGRpZmYgLS1naXQgYS9ibG9jay9xY293Mi5jIGIvYmxvY2svcWNv
dzIuYw0KPj4+PiBpbmRleCBmMmNiMTMxMDQ4Li4wMmQ4Y2U3NTM0IDEwMDY0NA0KPj4+PiAtLS0g
YS9ibG9jay9xY293Mi5jDQo+Pj4+ICsrKyBiL2Jsb2NrL3Fjb3cyLmMNCj4+Pj4gQEAgLTIzNDQs
NyArMjM0NCw3IEBAIHN0YXRpYyBpbnQgcWNvdzJfaW5hY3RpdmF0ZShCbG9ja0RyaXZlclN0YXRl
ICpicykNCj4+Pj4gICAgICAgIGludCByZXQsIHJlc3VsdCA9IDA7DQo+Pj4+ICAgICAgICBFcnJv
ciAqbG9jYWxfZXJyID0gTlVMTDsNCj4+Pj4gICAgDQo+Pj4+IC0gICAgcWNvdzJfc3RvcmVfcGVy
c2lzdGVudF9kaXJ0eV9iaXRtYXBzKGJzLCAmbG9jYWxfZXJyKTsNCj4+Pj4gKyAgICBxY293Ml9z
dG9yZV9wZXJzaXN0ZW50X2RpcnR5X2JpdG1hcHMoYnMsIHRydWUsICZsb2NhbF9lcnIpOw0KPj4+
PiAgICAgICAgaWYgKGxvY2FsX2VyciAhPSBOVUxMKSB7DQo+Pj4+ICAgICAgICAgICAgcmVzdWx0
ID0gLUVJTlZBTDsNCj4+Pj4gICAgICAgICAgICBlcnJvcl9yZXBvcnRmX2Vycihsb2NhbF9lcnIs
ICJMb3N0IHBlcnNpc3RlbnQgYml0bWFwcyBkdXJpbmcgIg0KPj4+Pg0KPj4+DQo+Pj4gY29kZToN
Cj4+PiBSZXZpZXdlZC1ieTogSm9obiBTbm93IDxqc25vd0ByZWRoYXQuY29tPg0KPj4+DQo+Pj4g
KFlvdSBjYW4gYWRqdXN0IHRoZSBkb2NzIGFzIHlvdSBuZWVkIHRvIG9uIGZ1cnRoZXIgcmV2aWV3
LCBpZiBhbnksIGFuZA0KPj4+IGtlZXAgdGhhdCBSQi4gLS1qcykNCj4+Pg0KPj4NCj4+IE9LLCB0
aGFuayB5b3UhDQo+Pg0KPiANCj4gSSdsbCBnZXQgYmFjayB0byB0aGUgcmVzdCBvZiB0aGlzIHNv
b24sIGl0IGxvb2tzIGxpa2UgeW91IGhhdmVuJ3QgZ290dGVuDQo+IHJldmlldyBvbiB0aGUgY29y
ZSBibG9jayBsYXllciBwaWVjZXMsIG9yIG1heWJlIEkndmUgbWlzc2VkIGl0IGlmIHlvdSBoYXZl
Pw0KPiANCg0KSG1tLCBubywgSSBoYXZlbid0Li4gU2VlbXMgSSBmb3JnZXQgYWJvdXQgdGhlc2Ug
c2VyaWVzLCBpdCBzaG91bGQgaGF2ZSBiZWVuIHBpbmdlZA0Kc2V2ZXJhbCBkYXlzIGFnby4NCg0K
LS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

