Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0946C10F11
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 17:04:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BE7C2082E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 17:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="W6nvXW65"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE7C2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53947 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFM58-0006KV-D4
	for qemu-devel@archiver.kernel.org; Sat, 13 Apr 2019 13:04:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hFM4I-00062g-Ps
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 13:03:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hFM4H-0003s1-Jj
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 13:03:54 -0400
Received: from mail-eopbgr130134.outbound.protection.outlook.com
	([40.107.13.134]:45670
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hFM4G-0003qd-N5; Sat, 13 Apr 2019 13:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=UiuWHik7paGB5Bce2dvEVQ75bvzuqOPxx7D7Z7k2vmk=;
	b=W6nvXW65YpgKLMOR232A7F4lKLiuqF60D/s9ZVR8hrCNaIyth00KCT3m71KEV5DFOkQrUTHix/ogQGlJDMyB3hsfjBFBPWNJYJXog7JzmwYETrB6z28Cvr38qjnBFEGww7GHMMmtCGiaXOrAuT3LP1O3yjFMAMcZpzT40d13OJo=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3243.eurprd08.prod.outlook.com (52.134.111.17) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1792.17; Sat, 13 Apr 2019 17:03:49 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1792.018;
	Sat, 13 Apr 2019 17:03:49 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v5 07/11] block: introduce backup-top filter driver
Thread-Index: AQHUn3DtttLClJyosUme7EOuRR/bF6WyKsaAgIjuywD//91DAA==
Date: Sat, 13 Apr 2019 17:03:49 +0000
Message-ID: <4a64d8dd-34ad-5a6c-7249-0c2fb202777f@virtuozzo.com>
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
	<20181229122027.42245-8-vsementsov@virtuozzo.com>
	<5a822e18-6967-5059-bf21-6891aa701af4@redhat.com>
	<2e0ab90c-7f62-4660-1eff-c9d8a2b6dd57@virtuozzo.com>
In-Reply-To: <2e0ab90c-7f62-4660-1eff-c9d8a2b6dd57@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P189CA0001.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::14)
	To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190413200346579
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8a8e5ca-0299-40c8-4a30-08d6c031ff4f
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3243; 
x-ms-traffictypediagnostic: DB7PR08MB3243:
x-microsoft-antispam-prvs: <DB7PR08MB324367C9AFA6363C9A689190C1290@DB7PR08MB3243.eurprd08.prod.outlook.com>
x-forefront-prvs: 00064751B6
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(396003)(366004)(376002)(346002)(136003)(39840400004)(189003)(199004)(8676002)(6512007)(71190400001)(105586002)(31696002)(106356001)(71200400001)(256004)(14444005)(229853002)(81156014)(5660300002)(81166006)(4326008)(6246003)(3846002)(2201001)(2501003)(6116002)(110136005)(86362001)(53936002)(93886005)(36756003)(68736007)(66066001)(5024004)(186003)(2906002)(31686004)(54906003)(476003)(486006)(2616005)(11346002)(52116002)(76176011)(14454004)(6486002)(97736004)(478600001)(7736002)(305945005)(316002)(99286004)(102836004)(8936002)(26005)(53546011)(386003)(446003)(6436002)(6506007)(25786009);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3243;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jz6e+nESn9adt12ECf0fua2yxjM6s9m/J3y0K1M6hLtYirOwSGNkd85V7+nPJ8Ootrgi5ojmomWRzVSAh+NtDdfnRz8SZgDaRAiGKZhXAUJpXbmVBYTpmvoTZNuKK+ah6/qxaPYcQZEcMHnPc5FQMJFc1+GXCJ5/gfdulbV82cDyQYUJI0acdljUIvS7rMMegOeoEbHf8YXsO177RVQ3WeWfArziIbgudX8hu355qsuUdFDITmSqph4uz0UvxK1fcrEoNiay1zE8ZG134CvkQIhdw/hgLk6UEcMnXzp71EEJXn10uYxikxIe77VxRXFa5trBTfmFFX0u/eTEBSLLVxSPW5GF4+/PiVZaEq/MAHxxpof8qoWMaInpyc2QILnxvyyTcxfUG5JwYMaTYI9JS/7V3KTz5jH3pybNWnQcFzc=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <924C1E5E16C85E4FB0B6B8CE67A9C73F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a8e5ca-0299-40c8-4a30-08d6c031ff4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2019 17:03:49.1722 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3243
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.134
Subject: Re: [Qemu-devel] [PATCH v5 07/11] block: introduce backup-top
 filter driver
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
	Denis Lunev <den@virtuozzo.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
	"jcody@redhat.com" <jcody@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190413170349.vn4SugGUTPWCaO2d8SAmhc_NAW9VmxeAteAPZad0HZk@z>

MTMuMDQuMjAxOSAxOTowOCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MTYuMDEuMjAxOSAxOTowMiwgTWF4IFJlaXR6IHdyb3RlOg0KPj4gT24gMjkuMTIuMTggMTM6MjAs
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4gQmFja3VwLXRvcCBmaWx0
ZXIgZG9lcyBjb3B5LWJlZm9yZS13cml0ZSBvcGVyYXRpb24uIEl0IHNob3VsZCBiZQ0KPj4+IGlu
c2VydGVkIGFib3ZlIGFjdGl2ZSBkaXNrIGFuZCBoYXMgYSB0YXJnZXQgbm9kZSBmb3IgQ0JXLCBs
aWtlIHRoZQ0KPj4+IGZvbGxvd2luZzoNCj4+Pg0KPj4+IMKgwqDCoMKgICstLS0tLS0tKw0KPj4+
IMKgwqDCoMKgIHwgR3Vlc3QgfA0KPj4+IMKgwqDCoMKgICstLS0rLS0tKw0KPj4+IMKgwqDCoMKg
wqDCoMKgwqAgfHIsdw0KPj4+IMKgwqDCoMKgwqDCoMKgwqAgdg0KPj4+IMKgwqDCoMKgICstLS0r
LS0tLS0tLS0tLS0rwqAgdGFyZ2V0wqDCoCArLS0tLS0tLS0tLS0tLS0tKw0KPj4+IMKgwqDCoMKg
IHwgYmFja3VwX3RvcMKgwqDCoCB8LS0tLS0tLS0tLT58IHRhcmdldChxY293MikgfA0KPj4+IMKg
wqDCoMKgICstLS0rLS0tLS0tLS0tLS0rwqDCoCBDQlfCoMKgwqDCoCArLS0tKy0tLS0tLS0tLS0t
Kw0KPj4+IMKgwqDCoMKgwqDCoMKgwqAgfA0KPj4+IGJhY2tpbmcgfHIsdw0KPj4+IMKgwqDCoMKg
wqDCoMKgwqAgdg0KPj4+IMKgwqDCoMKgICstLS0rLS0tLS0tLS0tKw0KPj4+IMKgwqDCoMKgIHwg
QWN0aXZlIGRpc2sgfA0KPj4+IMKgwqDCoMKgICstLS0tLS0tLS0tLS0tKw0KPj4+DQo+Pj4gVGhl
IGRyaXZlciB3aWxsIGJlIHVzZWQgaW4gYmFja3VwIGluc3RlYWQgb2Ygd3JpdGUtbm90aWZpZXJz
Lg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8
dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4+IC0tLQ0KPj4+IMKgIGJsb2NrL2JhY2t1cC10
b3AuaMKgIHzCoCA0MyArKysrKysrDQo+Pj4gwqAgYmxvY2svYmFja3VwLXRvcC5jwqAgfCAzMDYg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+PiDCoCBibG9j
ay9NYWtlZmlsZS5vYmpzIHzCoMKgIDIgKw0KPj4+IMKgIDMgZmlsZXMgY2hhbmdlZCwgMzUxIGlu
c2VydGlvbnMoKykNCj4+PiDCoCBjcmVhdGUgbW9kZSAxMDA2NDQgYmxvY2svYmFja3VwLXRvcC5o
DQo+Pj4gwqAgY3JlYXRlIG1vZGUgMTAwNjQ0IGJsb2NrL2JhY2t1cC10b3AuYw0KPj4NCj4gDQo+
IFsuLl0NCj4gDQo+Pj4gK0Jsb2NrRHJpdmVyU3RhdGUgKmJkcnZfYmFja3VwX3RvcF9hcHBlbmQo
QmxvY2tEcml2ZXJTdGF0ZSAqc291cmNlLA0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBC
bG9ja0RyaXZlclN0YXRlICp0YXJnZXQsDQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhC
aXRtYXAgKmNvcHlfYml0bWFwLA0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBFcnJvciAq
KmVycnApDQo+Pj4gK3sNCj4+PiArwqDCoMKgIEVycm9yICpsb2NhbF9lcnIgPSBOVUxMOw0KPj4+
ICvCoMKgwqAgQkRSVkJhY2t1cFRvcFN0YXRlICpzdGF0ZTsNCj4+PiArwqDCoMKgIEJsb2NrRHJp
dmVyU3RhdGUgKnRvcCA9IGJkcnZfbmV3X29wZW5fZHJpdmVyKCZiZHJ2X2JhY2t1cF90b3BfZmls
dGVyLA0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTlVMTCwg
QkRSVl9PX1JEV1IsIGVycnApOw0KPj4+ICsNCj4+PiArwqDCoMKgIGlmICghdG9wKSB7DQo+Pj4g
K8KgwqDCoMKgwqDCoMKgIHJldHVybiBOVUxMOw0KPj4+ICvCoMKgwqAgfQ0KPj4+ICsNCj4+PiAr
wqDCoMKgIHRvcC0+aW1wbGljaXQgPSB0cnVlOw0KPj4+ICvCoMKgwqAgdG9wLT50b3RhbF9zZWN0
b3JzID0gc291cmNlLT50b3RhbF9zZWN0b3JzOw0KPj4+ICvCoMKgwqAgdG9wLT5vcGFxdWUgPSBz
dGF0ZSA9IGdfbmV3MChCRFJWQmFja3VwVG9wU3RhdGUsIDEpOw0KPj4+ICvCoMKgwqAgc3RhdGUt
PmNvcHlfYml0bWFwID0gY29weV9iaXRtYXA7DQo+Pj4gKw0KPj4+ICvCoMKgwqAgYmRydl9yZWYo
dGFyZ2V0KTsNCj4+PiArwqDCoMKgIHN0YXRlLT50YXJnZXQgPSBiZHJ2X2F0dGFjaF9jaGlsZCh0
b3AsIHRhcmdldCwgInRhcmdldCIsICZjaGlsZF9maWxlLCBlcnJwKTsNCj4+PiArwqDCoMKgIGlm
ICghc3RhdGUtPnRhcmdldCkgew0KPj4+ICvCoMKgwqDCoMKgwqDCoCBiZHJ2X3VucmVmKHRhcmdl
dCk7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGJkcnZfdW5yZWYodG9wKTsNCj4+PiArwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIE5VTEw7DQo+Pj4gK8KgwqDCoCB9DQo+Pj4gKw0KPj4+ICvCoMKgwqAgYmRy
dl9zZXRfYWlvX2NvbnRleHQodG9wLCBiZHJ2X2dldF9haW9fY29udGV4dChzb3VyY2UpKTsNCj4+
PiArwqDCoMKgIGJkcnZfc2V0X2Fpb19jb250ZXh0KHRhcmdldCwgYmRydl9nZXRfYWlvX2NvbnRl
eHQoc291cmNlKSk7DQo+Pj4gKw0KPj4+ICvCoMKgwqAgYmRydl9kcmFpbmVkX2JlZ2luKHNvdXJj
ZSk7DQo+Pj4gKw0KPj4+ICvCoMKgwqAgYmRydl9yZWYodG9wKTsNCj4+PiArwqDCoMKgIGJkcnZf
YXBwZW5kKHRvcCwgc291cmNlLCAmbG9jYWxfZXJyKTsNCj4+PiArDQo+Pj4gK8KgwqDCoCBpZiAo
bG9jYWxfZXJyKSB7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGJkcnZfdW5yZWYodG9wKTsNCj4+DQo+
PiBUaGlzIGlzIGRvbmUgYXV0b21hdGljYWxseSBieSBiZHJ2X2FwcGVuZCgpLg0KPj4NCj4+PiAr
wqDCoMKgIH0NCj4+PiArDQo+Pj4gK8KgwqDCoCBiZHJ2X2RyYWluZWRfZW5kKHNvdXJjZSk7DQo+
Pj4gKw0KPj4+ICvCoMKgwqAgaWYgKGxvY2FsX2Vycikgew0KPj4+ICvCoMKgwqDCoMKgwqDCoCBi
ZHJ2X3VucmVmX2NoaWxkKHRvcCwgc3RhdGUtPnRhcmdldCk7DQo+Pj4gK8KgwqDCoMKgwqDCoMKg
IGJkcnZfdW5yZWYodG9wKTsNCj4+PiArwqDCoMKgwqDCoMKgwqAgZXJyb3JfcHJvcGFnYXRlKGVy
cnAsIGxvY2FsX2Vycik7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiBOVUxMOw0KPj4+ICvC
oMKgwqAgfQ0KPj4+ICsNCj4+PiArwqDCoMKgIHJldHVybiB0b3A7DQo+Pj4gK30NCj4+PiArDQo+
Pj4gK3ZvaWQgYmRydl9iYWNrdXBfdG9wX2Ryb3AoQmxvY2tEcml2ZXJTdGF0ZSAqYnMpDQo+Pj4g
K3sNCj4+PiArwqDCoMKgIEJEUlZCYWNrdXBUb3BTdGF0ZSAqcyA9IGJzLT5vcGFxdWU7DQo+Pj4g
Kw0KPj4+ICvCoMKgwqAgQWlvQ29udGV4dCAqYWlvX2NvbnRleHQgPSBiZHJ2X2dldF9haW9fY29u
dGV4dChicyk7DQo+Pj4gKw0KPj4+ICvCoMKgwqAgYWlvX2NvbnRleHRfYWNxdWlyZShhaW9fY29u
dGV4dCk7DQo+Pj4gKw0KPj4+ICvCoMKgwqAgYmRydl9kcmFpbmVkX2JlZ2luKGJzKTsNCj4+PiAr
DQo+Pj4gK8KgwqDCoCBiZHJ2X2NoaWxkX3RyeV9zZXRfcGVybShicy0+YmFja2luZywgMCwgQkxL
X1BFUk1fQUxMLCAmZXJyb3JfYWJvcnQpOw0KPj4+ICvCoMKgwqAgYmRydl9yZXBsYWNlX25vZGUo
YnMsIGJhY2tpbmdfYnMoYnMpLCAmZXJyb3JfYWJvcnQpOw0KPj4+ICvCoMKgwqAgYmRydl9zZXRf
YmFja2luZ19oZChicywgTlVMTCwgJmVycm9yX2Fib3J0KTsNCj4+DQo+PiBUaGlzIGlzIGRvbmUg
YXV0b21hdGljYWxseSBpbiBiZHJ2X2Nsb3NlKCksIGFuZCBhZnRlciBicyBoYXMgYmVlbg0KPj4g
cmVwbGFjZWQgYnkgYmFja2luZ19icyhicyksIEkgZG9uJ3QgdGhpbmsgbmV3IHJlcXVlc3RzIHNo
b3VsZCBjb21lIGluLA0KPj4gc28gSSBkb24ndCB0aGluayB0aGlzIG5lZWRzIHRvIGJlIGRvbmUg
aGVyZS4NCj4gDQo+IEZvbGxvd2luZyBtb3ZlbWVudCBvZiBiYWNrdXBfdG9wIGJhY2sgdG8gam9i
LT5ibGsgYmVjb21lcyBpbXBvc3NpYmxlIHRoZW4sDQo+IGlmIHdlIGRvbid0IHNoYXJlIFdSSVRF
IG9uIHNvdXJjZSBpbiBiYWNrdXBfdG9wX2NoaWxkX3Blcm0uDQo+IA0KPiBBbmQgSSB0aGluaywg
dGhpcyBmdW5jdGlvbiBzaG91bGQgZHJvcCBhbGwgcmVsYXRpb25zIGNyZWF0ZWQgYnkNCj4gYmRy
dl9iYWNrdXBfdG9wX2FwcGVuZC4NCj4gDQo+Pg0KPj4+ICsNCj4+PiArwqDCoMKgIGJkcnZfZHJh
aW5lZF9lbmQoYnMpOw0KPj4+ICsNCj4+PiArwqDCoMKgIGlmIChzLT50YXJnZXQpIHsNCj4+PiAr
wqDCoMKgwqDCoMKgwqAgYmRydl91bnJlZl9jaGlsZChicywgcy0+dGFyZ2V0KTsNCj4+PiArwqDC
oMKgIH0NCj4+DQo+PiBBbmQgdGhpcyBzaG91bGQgYmUgZG9uZSBpbiBhIC5iZHJ2X2Nsb3NlKCkg
aW1wbGVtZW50YXRpb24sIEkgdGhpbmsuDQo+Pg0KDQphbmQgdGhlcmVmb3JlIHRoaXMgb25lIHRv
by4gV2UgZG9uJ3QgaGF2ZSAuYmRydl9vcGVuLCBzbyBJJ2QgcHJlZmVyIG5vdA0KaGF2ZSBiZHJ2
X2Nsb3NlLiBXZSBjcmVhdGUgdGhpcyBjaGlsZCBpbiBfdG9wX2FwcGVuZCwgc2VlbXMgbG9naWNh
bCB0bw0KdW5yZWYgaXQgaW4gX3RvcF9kcm9wLg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxh
ZGltaXINCg==

