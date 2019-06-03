Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A58C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 10:15:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0A78254A5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 10:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="az8bHapo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0A78254A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60899 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXjzt-0006Xe-5I
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 06:15:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hXjyo-0005vU-Ex
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 06:14:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hXjym-0001a5-Ee
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 06:14:14 -0400
Received: from mail-eopbgr10129.outbound.protection.outlook.com
	([40.107.1.129]:51329
	helo=EUR02-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hXjyg-0001Nx-Pl; Mon, 03 Jun 2019 06:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=CmsEcI7M72VHyOOxPt5HULBsSFJUFNaKkdSFJEffRBM=;
	b=az8bHapoUQCedXCbkyD7t1YhDkuZzVTnao453k+hkeLnikuDKAcSeme/ANp7/oykijtFHr8s9GOGufCBKHqH7bWyg+S6q5ovRLPd99St3HWltTjwjoxdCUgJYbt6fQ2rKPXehmwxNPtCEdOkn3XqDG6vfhy+3pS2l0HaLNmCwoc=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
	AM0PR08MB3268.eurprd08.prod.outlook.com (52.134.125.154) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1943.22; Mon, 3 Jun 2019 10:14:02 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8]) by
	AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8%7]) with mapi id 15.20.1943.018;
	Mon, 3 Jun 2019 10:14:02 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v2 6/9] block/qcow2-bitmap: do not remove
	bitmaps on reopen-ro
Thread-Index: AQHVF85osztyDSgPBUivffu7cD6tmaaF7DGAgAPOUIA=
Date: Mon, 3 Jun 2019 10:14:02 +0000
Message-ID: <cddfad9b-7bf0-8924-a07e-a2ca449e7722@virtuozzo.com>
References: <20190531163202.162543-1-vsementsov@virtuozzo.com>
	<20190531163202.162543-7-vsementsov@virtuozzo.com>
	<38975505-c3ed-982e-1875-5f6d650f01da@redhat.com>
In-Reply-To: <38975505-c3ed-982e-1875-5f6d650f01da@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0101CA0006.eurprd01.prod.exchangelabs.com
	(2603:10a6:3:77::16) To AM0PR08MB2961.eurprd08.prod.outlook.com
	(2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190603131359661
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2129bf11-56dd-4755-f478-08d6e80c3375
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
	SRVR:AM0PR08MB3268; 
x-ms-traffictypediagnostic: AM0PR08MB3268:
x-microsoft-antispam-prvs: <AM0PR08MB326815AFDA7CACC02C589D2AC1140@AM0PR08MB3268.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(136003)(346002)(376002)(396003)(39850400004)(189003)(199004)(52314003)(86362001)(8676002)(7736002)(305945005)(2201001)(31696002)(2616005)(229853002)(6116002)(31686004)(478600001)(14454004)(53936002)(3846002)(68736007)(36756003)(4326008)(6486002)(25786009)(446003)(11346002)(6246003)(107886003)(66446008)(66946007)(71190400001)(64756008)(66556008)(66476007)(71200400001)(73956011)(6512007)(110136005)(102836004)(6436002)(19627235002)(54906003)(66066001)(486006)(2906002)(14444005)(76176011)(53546011)(386003)(6506007)(5660300002)(52116002)(476003)(26005)(2501003)(8936002)(256004)(81166006)(99286004)(186003)(81156014)(316002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3268;
	H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 04K7INQMEbGnrDbrTDo3AUwy4u0gCBLcyQMOGvFVAR1GsSZKMzEKD2tt2lhqUZ8TLc79AIqVsBeUqsm7LAZoHN8S5s6qGEQx+NRf/r0gWEPKmg0LYeLVai5YbvWTNs9UfsXdaDqxL7YMkbxpGvHW72L2M52GMwFWTvUbHofpHDXxmdiEDUZdRvjdTBd4RQi5rasgngftb0gWgWH0+bQ4WqHn6PMjXXvjaQmINGG06NQjD5jMqtbZ+3gUOeshob7mLMfzJqz9SF08VN6yTL/X8f+xewO6mApX4m6i3yfzNW8YT6V1nMjPQ+P2+rnHFpvbR0RBI4LF4CfekRzZHF7chAuWSAr9eG/aUdDCoX2ERpeYRvunFwujv487AlhRUX3yM5sdbSj6GUkQ/UTINZnvpWFuHJeBpqfQx0sXTBhU4fw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DD037A93902DD4E8A1E1A5EC7F7DE52@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2129bf11-56dd-4755-f478-08d6e80c3375
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 10:14:02.2412 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3268
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.129
Subject: Re: [Qemu-devel] [PATCH v2 6/9] block/qcow2-bitmap: do not remove
 bitmaps on reopen-ro
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
	Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMDYuMjAxOSAzOjA2LCBKb2huIFNub3cgd3JvdGU6DQo+IA0KPiANCj4gT24gNS8zMS8xOSAx
MjozMSBQTSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IHFjb3cyX3Jl
b3Blbl9iaXRtYXBzX3JvIHdhbnRzIHRvIHN0b3JlIGJpdG1hcHMgYW5kIHRoZW4gbWFyayB0aGVt
IGFsbA0KPj4gcmVhZG9ubHkuIEJ1dCB0aGUgbGF0dGVyIGRvbid0IHdvcmssIGFzDQo+PiBxY293
Ml9zdG9yZV9wZXJzaXN0ZW50X2RpcnR5X2JpdG1hcHMgcmVtb3ZlcyBiaXRtYXBzIGFmdGVyIHN0
b3JpbmcuDQo+PiBJdCdzIE9LIGZvciBpbmFjdGl2YXRpb24gYnV0IGJhZCBpZGVhIGZvciByZW9w
ZW4tcm8uIEFuZCB0aGlzIGxlYWRzIHRvDQo+PiB0aGUgZm9sbG93aW5nIGJ1ZzoNCj4+DQo+PiBB
c3N1bWUgd2UgaGF2ZSBwZXJzaXN0ZW50IGJpdG1hcCAnYml0bWFwMCcuDQo+PiBDcmVhdGUgZXh0
ZXJuYWwgc25hcHNob3QNCj4+ICAgIGJpdG1hcDAgaXMgc3RvcmVkIGFuZCB0aGVyZWZvcmUgcmVt
b3ZlZA0KPj4gQ29tbWl0IHNuYXBzaG90DQo+PiAgICBub3cgd2UgaGF2ZSBubyBiaXRtYXBzDQo+
PiBEbyBzb21lIHdyaXRlcyBmcm9tIGd1ZXN0ICgqKQ0KPj4gICAgdGhleSBhcmUgbm90IG1hcmtl
ZCBpbiBiaXRtYXANCj4+IFNodXRkb3duDQo+PiBTdGFydA0KPj4gICAgYml0bWFwMCBpcyBsb2Fk
ZWQgYXMgdmFsaWQsIGJ1dCBpdCBpcyBhY3R1YWxseSBicm9rZW4hIEl0IG1pc3Nlcw0KPj4gICAg
d3JpdGVzICgqKQ0KPj4gSW5jcmVtZW50YWwgYmFja3VwDQo+PiAgICBpdCB3aWxsIGJlIGluY29u
c2lzdGVudA0KPj4NCj4+IFNvLCBsZXQncyBzdG9wIHJlbW92aW5nIGJpdG1hcHMgb24gcmVvcGVu
LXJvLiBCdXQgZG9uJ3QgcmVqb2ljZToNCj4+IHJlb3BlbmluZyBiaXRtYXBzIHRvIHJ3IGlzIGJy
b2tlbiB0b28sIHNvIHRoZSB3aG9sZSBzY2VuYXJpbyB3aWxsIG5vdA0KPj4gd29yayBhZnRlciB0
aGlzIHBhdGNoIGFuZCB3ZSBjYW4ndCBlbmFibGUgY29ycmVzcG9uZGluZyB0ZXN0IGNhc2VzIGlu
DQo+PiAyNTUgaW90ZXN0cyBzdGlsbC4gUmVvcGVuaW5nIGJpdG1hcHMgcncgd2lsbCBiZSBmaXhl
ZCBpbiB0aGUgZm9sbG93aW5nDQo+PiBwYXRjaGVzLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFZs
YWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+
IC0tLQ0KPj4gICBibG9jay9xY293Mi5oICAgICAgICB8ICAzICsrLQ0KPj4gICBibG9jay9xY293
Mi1iaXRtYXAuYyB8IDQ2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LS0tDQo+PiAgIGJsb2NrL3Fjb3cyLmMgICAgICAgIHwgIDIgKy0NCj4+ICAgMyBmaWxlcyBjaGFu
Z2VkLCAzNCBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0
IGEvYmxvY2svcWNvdzIuaCBiL2Jsb2NrL3Fjb3cyLmgNCj4+IGluZGV4IDg4YTIwMzBmNTQuLjRj
ODQzNTE0MWIgMTAwNjQ0DQo+PiAtLS0gYS9ibG9jay9xY293Mi5oDQo+PiArKysgYi9ibG9jay9x
Y293Mi5oDQo+PiBAQCAtNzM0LDcgKzczNCw4IEBAIFFjb3cyQml0bWFwSW5mb0xpc3QgKnFjb3cy
X2dldF9iaXRtYXBfaW5mb19saXN0KEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0KPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApOw0K
Pj4gICBpbnQgcWNvdzJfcmVvcGVuX2JpdG1hcHNfcncoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIEVy
cm9yICoqZXJycCk7DQo+PiAgIGludCBxY293Ml90cnVuY2F0ZV9iaXRtYXBzX2NoZWNrKEJsb2Nr
RHJpdmVyU3RhdGUgKmJzLCBFcnJvciAqKmVycnApOw0KPj4gLXZvaWQgcWNvdzJfc3RvcmVfcGVy
c2lzdGVudF9kaXJ0eV9iaXRtYXBzKEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBFcnJvciAqKmVycnAp
Ow0KPj4gK3ZvaWQgcWNvdzJfc3RvcmVfcGVyc2lzdGVudF9kaXJ0eV9iaXRtYXBzKEJsb2NrRHJp
dmVyU3RhdGUgKmJzLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGJvb2wgcmVsZWFzZV9zdG9yZWQsIEVycm9yICoqZXJycCk7DQo+PiAgIGludCBxY293Ml9y
ZW9wZW5fYml0bWFwc19ybyhCbG9ja0RyaXZlclN0YXRlICpicywgRXJyb3IgKiplcnJwKTsNCj4+
ICAgYm9vbCBxY293Ml9jYW5fc3RvcmVfbmV3X2RpcnR5X2JpdG1hcChCbG9ja0RyaXZlclN0YXRl
ICpicywNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBj
aGFyICpuYW1lLA0KPj4gZGlmZiAtLWdpdCBhL2Jsb2NrL3Fjb3cyLWJpdG1hcC5jIGIvYmxvY2sv
cWNvdzItYml0bWFwLmMNCj4+IGluZGV4IGZiZWVlMzcyNDMuLjI1YjFlMDY5YTcgMTAwNjQ0DQo+
PiAtLS0gYS9ibG9jay9xY293Mi1iaXRtYXAuYw0KPj4gKysrIGIvYmxvY2svcWNvdzItYml0bWFw
LmMNCj4+IEBAIC0xNDMyLDcgKzE0MzIsMjkgQEAgZmFpbDoNCj4+ICAgICAgIGJpdG1hcF9saXN0
X2ZyZWUoYm1fbGlzdCk7DQo+PiAgIH0NCj4+ICAgDQo+PiAtdm9pZCBxY293Ml9zdG9yZV9wZXJz
aXN0ZW50X2RpcnR5X2JpdG1hcHMoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIEVycm9yICoqZXJycCkN
Cj4+ICsvKg0KPj4gKyAqIHFjb3cyX3N0b3JlX3BlcnNpc3RlbnRfZGlydHlfYml0bWFwcw0KPj4g
KyAqDQo+PiArICogU3RvcmVzIHBlcnNpc3RlbnQgQmRydkRpcnR5Qml0bWFwJ3MuDQo+PiArICoN
Cj4gDQo+IE5vIGFwb3N0cm9waGUgZm9yIHBsdXJhbCdzDQoNCkkgYWx3YXlzIGRvIHNvLCBhcyBp
dCBzZWVtcyBzdHJhbmdlIHRvIG1lIHRvIGFwcGVuZCAncycgdG8gaWRlbnRpZmllcnMuLg0KU2hv
dWxkIEkgd3JpdGUgaXQgQmRydkRpcnR5Qml0bWFwcz8gSXQgc291bmRzIGFzIHNvbWUgb3RoZXIg
aWRlbnRpZmllci4uLg0KDQo+IA0KPj4gKyAqIEByZWxlYXNlX3N0b3JlZDogaWYgdHJ1ZSwgcmVs
ZWFzZSBCZHJ2RGlydHlCaXRtYXAncyBhZnRlciBzdG9yaW5nIHRvIHRoZQ0KPj4gKyAqIGltYWdl
LiBUaGlzIGlzIHVzZWQgaW4gdHdvIGNhc2VzLCBib3RoIHZpYSBxY293Ml9pbmFjdGl2YXRlOg0K
Pj4gKyAqIDEuIGJkcnZfY2xvc2U6IEl0J3MgY29ycmVjdCB0byByZW1vdmUgYml0bWFwcyBvbiBj
bG9zZS4NCj4+ICsgKiAyLiBtaWdyYXRpb246IElmIGJpdG1hcHMgYXJlIG1pZ3JhdGVkIHRocm91
Z2ggbWlncmF0aW9uIGNoYW5uZWwgdmlhDQo+PiArICogICAgJ2RpcnR5LWJpdG1hcHMnIG1pZ3Jh
dGlvbiBjYXBhYmlsaXR5IHRoZXkgYXJlIG5vdCBoYW5kbGVkIGJ5IHRoaXMgY29kZS4NCj4+ICsg
KiAgICBPdGhlcndpc2UsIGl0J3MgT0sgdG8gZHJvcCBCZHJ2RGlydHlCaXRtYXAncyBhbmQgcmVs
b2FkIHRoZW0gb24NCj4+ICsgKiAgICBpbnZhbGlkYXRpb24uDQo+PiArICoNCj4+ICsgKiBBbnl3
YXksIGl0J3MgY29ycmVjdCB0byByZW1vdmUgQmRydkRpcnR5Qml0bWFwJ3Mgb24gaW5hY3RpdmF0
aW9uLCBhcw0KPj4gKyAqIGluYWN0aXZhdGlvbiBtZWFucyB0aGF0IHdlIGxvc2UgY29udHJvbCBv
biBkaXNrLCBhbmQgdGhlcmVmb3JlIG9uIGJpdG1hcHMsDQo+PiArICogd2Ugc2hvdWxkIHN5bmMg
dGhlbSBhbmQgZG8gbm90IHRvdWNoIG1vcmUuDQo+PiArICoNCj4+ICsgKiBDb250cmFyaXdpc2Us
IHdlIGRvbid0IHdhbnQgdG8gcmVsZWFzZSBhbnkgYml0bWFwcyBvbiBqdXN0IHJlb3Blbi10by1y
bywNCj4+ICsgKiB3aGVuIHdlIG5lZWQgdG8gc3RvcmUgdGhlbSwgYXMgaW1hZ2UgaXMgc3RpbGwg
dW5kZXIgb3VyIGNvbnRyb2wsIGFuZCBpdCdzDQo+PiArICogZ29vZCB0byBrZWVwIGFsbCB0aGUg
Yml0bWFwcyBpbiByZWFkLW9ubHkgbW9kZS4NCj4+ICsgKi8NCj4gDQo+IEkgaGF2ZSB0byBhZG1p
dCB0aGF0ICdDb250cmFyaXdpc2UnIGlzIG5vdCBhbiBldmVyeWRheSB0ZXJtIGZvciBtZS4gWW91
DQo+IHNob3VsZCBrZWVwIGl0IGluIGhlcmUganVzdCBmb3IgZnVuLCBpbiBteSBvcGluaW9uLg0K
DQpBaGFoYSwgSSd2ZSBqdXN0IHVzZWQgaXQgaW4gbXkgcHJldmlvdXMgcmVwbHkuDQoNCj4gDQo+
IFJlZ2FyZGluZyAiaXQncyBnb29kIHRvIGtlZXAgYWxsIHRoZSBiaXRtYXBzIGluIHJlYWQtb25s
eSBtb2RlIjoNCj4gTW9yZSBkaXJlY3RseSwga2VlcGluZyB0aGVtIHJlYWQtb25seSBpcyBjb3Jy
ZWN0IGJlY2F1c2UgdGhpcyBpcyB3aGF0DQo+IHdvdWxkIGhhcHBlbiBpZiB3ZSBvcGVuZWQgdGhl
IG5vZGUgcmVhZG9ubHkgdG8gYmVnaW4gd2l0aCwgYW5kIHdoZXRoZXINCj4gd2Ugb3BlbmVkIGRp
cmVjdGx5IG9yIHJlb3BlbmVkIHRvIHRoYXQgc3RhdGUgc2hvdWxkbid0IG1hdHRlciBmb3IgdGhl
DQo+IHN0YXRlIHdlIGdldCBhZnRlcndhcmQuDQoNCkFncmVlLCB0aGlzIGlzIGJldHRlciByZWFz
b25pbmcuDQoNCj4gDQo+PiArdm9pZCBxY293Ml9zdG9yZV9wZXJzaXN0ZW50X2RpcnR5X2JpdG1h
cHMoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgYm9vbCByZWxlYXNlX3N0b3JlZCwgRXJyb3IgKiplcnJwKQ0KPj4gICB7
DQo+PiAgICAgICBCZHJ2RGlydHlCaXRtYXAgKmJpdG1hcDsNCj4+ICAgICAgIEJEUlZRY293MlN0
YXRlICpzID0gYnMtPm9wYXF1ZTsNCj4+IEBAIC0xNTQ1LDIwICsxNTY3LDE0IEBAIHZvaWQgcWNv
dzJfc3RvcmVfcGVyc2lzdGVudF9kaXJ0eV9iaXRtYXBzKEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBF
cnJvciAqKmVycnApDQo+PiAgICAgICAgICAgZ19mcmVlKHRiKTsNCj4+ICAgICAgIH0NCj4+ICAg
DQo+PiAtICAgIFFTSU1QTEVRX0ZPUkVBQ0goYm0sIGJtX2xpc3QsIGVudHJ5KSB7DQo+PiAtICAg
ICAgICAvKiBGb3Igc2FmZXR5LCB3ZSByZW1vdmUgYml0bWFwIGFmdGVyIHN0b3JpbmcuDQo+PiAt
ICAgICAgICAgKiBXZSBtYXkgYmUgaGVyZSBpbiB0d28gY2FzZXM6DQo+PiAtICAgICAgICAgKiAx
LiBiZHJ2X2Nsb3NlLiBJdCdzIG9rIHRvIGRyb3AgYml0bWFwLg0KPj4gLSAgICAgICAgICogMi4g
aW5hY3RpdmF0aW9uLiBJdCBtZWFucyBtaWdyYXRpb24gd2l0aG91dCAnZGlydHktYml0bWFwcycN
Cj4+IC0gICAgICAgICAqICAgIGNhcGFiaWxpdHksIHNvIGJpdG1hcHMgYXJlIG5vdCBtYXJrZWQg
d2l0aA0KPj4gLSAgICAgICAgICogICAgQmRydkRpcnR5Qml0bWFwLm1pZ3JhdGlvbiBmbGFncy4g
SXQncyBub3QgYmFkIHRvIGRyb3AgdGhlbSB0b28sDQo+PiAtICAgICAgICAgKiAgICBhbmQgcmVs
b2FkIG9uIGludmFsaWRhdGlvbi4NCj4+IC0gICAgICAgICAqLw0KPj4gLSAgICAgICAgaWYgKGJt
LT5kaXJ0eV9iaXRtYXAgPT0gTlVMTCkgew0KPj4gLSAgICAgICAgICAgIGNvbnRpbnVlOw0KPj4g
LSAgICAgICAgfQ0KPj4gKyAgICBpZiAocmVsZWFzZV9zdG9yZWQpIHsNCj4+ICsgICAgICAgIFFT
SU1QTEVRX0ZPUkVBQ0goYm0sIGJtX2xpc3QsIGVudHJ5KSB7DQo+PiArICAgICAgICAgICAgaWYg
KGJtLT5kaXJ0eV9iaXRtYXAgPT0gTlVMTCkgew0KPj4gKyAgICAgICAgICAgICAgICBjb250aW51
ZTsNCj4+ICsgICAgICAgICAgICB9DQo+PiAgIA0KPj4gLSAgICAgICAgYmRydl9yZWxlYXNlX2Rp
cnR5X2JpdG1hcChicywgYm0tPmRpcnR5X2JpdG1hcCk7DQo+PiArICAgICAgICAgICAgYmRydl9y
ZWxlYXNlX2RpcnR5X2JpdG1hcChicywgYm0tPmRpcnR5X2JpdG1hcCk7DQo+PiArICAgICAgICB9
DQo+PiAgICAgICB9DQo+PiAgIA0KPj4gICBzdWNjZXNzOg0KPj4gQEAgLTE1ODYsNyArMTYwMiw3
IEBAIGludCBxY293Ml9yZW9wZW5fYml0bWFwc19ybyhCbG9ja0RyaXZlclN0YXRlICpicywgRXJy
b3IgKiplcnJwKQ0KPj4gICAgICAgQmRydkRpcnR5Qml0bWFwICpiaXRtYXA7DQo+PiAgICAgICBF
cnJvciAqbG9jYWxfZXJyID0gTlVMTDsNCj4+ICAgDQo+PiAtICAgIHFjb3cyX3N0b3JlX3BlcnNp
c3RlbnRfZGlydHlfYml0bWFwcyhicywgJmxvY2FsX2Vycik7DQo+PiArICAgIHFjb3cyX3N0b3Jl
X3BlcnNpc3RlbnRfZGlydHlfYml0bWFwcyhicywgZmFsc2UsICZsb2NhbF9lcnIpOw0KPj4gICAg
ICAgaWYgKGxvY2FsX2VyciAhPSBOVUxMKSB7DQo+PiAgICAgICAgICAgZXJyb3JfcHJvcGFnYXRl
KGVycnAsIGxvY2FsX2Vycik7DQo+PiAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+PiBkaWZm
IC0tZ2l0IGEvYmxvY2svcWNvdzIuYyBiL2Jsb2NrL3Fjb3cyLmMNCj4+IGluZGV4IGYyY2IxMzEw
NDguLjAyZDhjZTc1MzQgMTAwNjQ0DQo+PiAtLS0gYS9ibG9jay9xY293Mi5jDQo+PiArKysgYi9i
bG9jay9xY293Mi5jDQo+PiBAQCAtMjM0NCw3ICsyMzQ0LDcgQEAgc3RhdGljIGludCBxY293Ml9p
bmFjdGl2YXRlKEJsb2NrRHJpdmVyU3RhdGUgKmJzKQ0KPj4gICAgICAgaW50IHJldCwgcmVzdWx0
ID0gMDsNCj4+ICAgICAgIEVycm9yICpsb2NhbF9lcnIgPSBOVUxMOw0KPj4gICANCj4+IC0gICAg
cWNvdzJfc3RvcmVfcGVyc2lzdGVudF9kaXJ0eV9iaXRtYXBzKGJzLCAmbG9jYWxfZXJyKTsNCj4+
ICsgICAgcWNvdzJfc3RvcmVfcGVyc2lzdGVudF9kaXJ0eV9iaXRtYXBzKGJzLCB0cnVlLCAmbG9j
YWxfZXJyKTsNCj4+ICAgICAgIGlmIChsb2NhbF9lcnIgIT0gTlVMTCkgew0KPj4gICAgICAgICAg
IHJlc3VsdCA9IC1FSU5WQUw7DQo+PiAgICAgICAgICAgZXJyb3JfcmVwb3J0Zl9lcnIobG9jYWxf
ZXJyLCAiTG9zdCBwZXJzaXN0ZW50IGJpdG1hcHMgZHVyaW5nICINCj4+DQo+IA0KPiBjb2RlOg0K
PiBSZXZpZXdlZC1ieTogSm9obiBTbm93IDxqc25vd0ByZWRoYXQuY29tPg0KPiANCj4gKFlvdSBj
YW4gYWRqdXN0IHRoZSBkb2NzIGFzIHlvdSBuZWVkIHRvIG9uIGZ1cnRoZXIgcmV2aWV3LCBpZiBh
bnksIGFuZA0KPiBrZWVwIHRoYXQgUkIuIC0tanMpDQo+IA0KDQpPSywgdGhhbmsgeW91IQ0KDQot
LSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

