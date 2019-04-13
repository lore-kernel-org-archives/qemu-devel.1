Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EB2C10F11
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 16:09:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 782C92084D
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 16:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="D3PdD52b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 782C92084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53364 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFLDv-0000Wr-Mf
	for qemu-devel@archiver.kernel.org; Sat, 13 Apr 2019 12:09:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hFLCR-00082N-K0
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 12:08:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hFLCQ-00030N-Jo
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 12:08:15 -0400
Received: from mail-eopbgr80090.outbound.protection.outlook.com
	([40.107.8.90]:49998
	helo=EUR04-VI1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hFLCP-0002yA-N7; Sat, 13 Apr 2019 12:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=50Qxq/7glJ08Gn0D6V6oiNsqu4D1c2fW3o+7DM7BU2M=;
	b=D3PdD52bsCMu4rEnbH7eXXJxtmTai2CLscK1mceK6PiOWlgouZcsSomGNj4sSiaVc+lsNjErkne+XCNLtcQhSslAcz6WWFEA2Te4Xe70rBq6ZZEzrEEJIDEBVahVLfSCInlZVAVtqH5BMOK90Cqsd+DqaHASsq1Sp5rabciU3hI=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3051.eurprd08.prod.outlook.com (52.134.110.17) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1792.19; Sat, 13 Apr 2019 16:08:09 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1792.018;
	Sat, 13 Apr 2019 16:08:09 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v5 07/11] block: introduce backup-top filter driver
Thread-Index: AQHUn3DtttLClJyosUme7EOuRR/bF6WyKsaAgIi8gAA=
Date: Sat, 13 Apr 2019 16:08:09 +0000
Message-ID: <2e0ab90c-7f62-4660-1eff-c9d8a2b6dd57@virtuozzo.com>
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
	<20181229122027.42245-8-vsementsov@virtuozzo.com>
	<5a822e18-6967-5059-bf21-6891aa701af4@redhat.com>
In-Reply-To: <5a822e18-6967-5059-bf21-6891aa701af4@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P191CA0021.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::31)
	To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190413190806804
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb98b345-32c1-4d36-13fd-08d6c02a3893
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3051; 
x-ms-traffictypediagnostic: DB7PR08MB3051:
x-microsoft-antispam-prvs: <DB7PR08MB305157431179BA8A9C0C4221C1290@DB7PR08MB3051.eurprd08.prod.outlook.com>
x-forefront-prvs: 00064751B6
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(366004)(346002)(396003)(39840400004)(136003)(199004)(189003)(14454004)(2616005)(446003)(11346002)(53936002)(99286004)(97736004)(31686004)(476003)(6436002)(6246003)(2501003)(68736007)(76176011)(66066001)(478600001)(2201001)(86362001)(54906003)(31696002)(106356001)(5660300002)(8936002)(316002)(110136005)(81156014)(81166006)(5024004)(256004)(14444005)(36756003)(229853002)(8676002)(6486002)(105586002)(6506007)(386003)(102836004)(71190400001)(71200400001)(53546011)(486006)(7736002)(305945005)(26005)(25786009)(6512007)(6116002)(2906002)(3846002)(4326008)(186003)(52116002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3051;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4mQDdyr3NCT87EPVE4YnNuWNRvIgVX/6Pvm6dAYH088QBpdUOsOTUM42GSZvRV8yJICDO2k/ukaJkm4S5cOtjhD03dqwJNpprB6l20w0ZmD6KNMuhXQmoMC73sK0LOThOK1PouaQEEBvKecQuveK1CcGZJ50BHojR0Jo9CDK3BEb9ae8YQPZgN5kRgGkricPoYhB8Kz6bAGILHo1xWqJm+YnN7x6KCC+hLQmxsgwP0b/4BOC8ln3XQ+ge53y4frfS2EZMlYGySGpATFft2vFdxxtFgVobsxVME0LoE4gJrKr6AxqYJFXgKzQ/n5va9MNFw1tV1a58fVWul+AGgXEWgnNeHHlKMjSDiNd0/4Apiiyun7Ft8+Lh3QJecmB+rwfsJFLMElBPYuqqQZCai8d8KR1LaWttLGNYXvXc2Uzd74=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <9A6443B0D937D74FA7ED1C44307DBA43@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb98b345-32c1-4d36-13fd-08d6c02a3893
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2019 16:08:09.3248 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3051
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.90
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
Message-ID: <20190413160809.Y5hq4w7f8W5d33RtCFtB6XJrjTvIJO4m3uXdkmm1CrY@z>

MTYuMDEuMjAxOSAxOTowMiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyOS4xMi4xOCAxMzoyMCwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IEJhY2t1cC10b3AgZmlsdGVy
IGRvZXMgY29weS1iZWZvcmUtd3JpdGUgb3BlcmF0aW9uLiBJdCBzaG91bGQgYmUNCj4+IGluc2Vy
dGVkIGFib3ZlIGFjdGl2ZSBkaXNrIGFuZCBoYXMgYSB0YXJnZXQgbm9kZSBmb3IgQ0JXLCBsaWtl
IHRoZQ0KPj4gZm9sbG93aW5nOg0KPj4NCj4+ICAgICAgKy0tLS0tLS0rDQo+PiAgICAgIHwgR3Vl
c3QgfA0KPj4gICAgICArLS0tKy0tLSsNCj4+ICAgICAgICAgIHxyLHcNCj4+ICAgICAgICAgIHYN
Cj4+ICAgICAgKy0tLSstLS0tLS0tLS0tLSsgIHRhcmdldCAgICstLS0tLS0tLS0tLS0tLS0rDQo+
PiAgICAgIHwgYmFja3VwX3RvcCAgICB8LS0tLS0tLS0tLT58IHRhcmdldChxY293MikgfA0KPj4g
ICAgICArLS0tKy0tLS0tLS0tLS0tKyAgIENCVyAgICAgKy0tLSstLS0tLS0tLS0tLSsNCj4+ICAg
ICAgICAgIHwNCj4+IGJhY2tpbmcgfHIsdw0KPj4gICAgICAgICAgdg0KPj4gICAgICArLS0tKy0t
LS0tLS0tLSsNCj4+ICAgICAgfCBBY3RpdmUgZGlzayB8DQo+PiAgICAgICstLS0tLS0tLS0tLS0t
Kw0KPj4NCj4+IFRoZSBkcml2ZXIgd2lsbCBiZSB1c2VkIGluIGJhY2t1cCBpbnN0ZWFkIG9mIHdy
aXRlLW5vdGlmaWVycy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3Yt
T2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+PiAtLS0NCj4+ICAgYmxvY2sv
YmFja3VwLXRvcC5oICB8ICA0MyArKysrKysrDQo+PiAgIGJsb2NrL2JhY2t1cC10b3AuYyAgfCAz
MDYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICAgYmxv
Y2svTWFrZWZpbGUub2JqcyB8ICAgMiArDQo+PiAgIDMgZmlsZXMgY2hhbmdlZCwgMzUxIGluc2Vy
dGlvbnMoKykNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGJsb2NrL2JhY2t1cC10b3AuaA0KPj4g
ICBjcmVhdGUgbW9kZSAxMDA2NDQgYmxvY2svYmFja3VwLXRvcC5jDQo+IA0KDQpbLi5dDQoNCj4+
ICtCbG9ja0RyaXZlclN0YXRlICpiZHJ2X2JhY2t1cF90b3BfYXBwZW5kKEJsb2NrRHJpdmVyU3Rh
dGUgKnNvdXJjZSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IEJsb2NrRHJpdmVyU3RhdGUgKnRhcmdldCwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEhCaXRtYXAgKmNvcHlfYml0bWFwLA0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0KPj4gK3sNCj4+ICsgICAg
RXJyb3IgKmxvY2FsX2VyciA9IE5VTEw7DQo+PiArICAgIEJEUlZCYWNrdXBUb3BTdGF0ZSAqc3Rh
dGU7DQo+PiArICAgIEJsb2NrRHJpdmVyU3RhdGUgKnRvcCA9IGJkcnZfbmV3X29wZW5fZHJpdmVy
KCZiZHJ2X2JhY2t1cF90b3BfZmlsdGVyLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBOVUxMLCBCRFJWX09fUkRXUiwgZXJycCk7DQo+PiArDQo+
PiArICAgIGlmICghdG9wKSB7DQo+PiArICAgICAgICByZXR1cm4gTlVMTDsNCj4+ICsgICAgfQ0K
Pj4gKw0KPj4gKyAgICB0b3AtPmltcGxpY2l0ID0gdHJ1ZTsNCj4+ICsgICAgdG9wLT50b3RhbF9z
ZWN0b3JzID0gc291cmNlLT50b3RhbF9zZWN0b3JzOw0KPj4gKyAgICB0b3AtPm9wYXF1ZSA9IHN0
YXRlID0gZ19uZXcwKEJEUlZCYWNrdXBUb3BTdGF0ZSwgMSk7DQo+PiArICAgIHN0YXRlLT5jb3B5
X2JpdG1hcCA9IGNvcHlfYml0bWFwOw0KPj4gKw0KPj4gKyAgICBiZHJ2X3JlZih0YXJnZXQpOw0K
Pj4gKyAgICBzdGF0ZS0+dGFyZ2V0ID0gYmRydl9hdHRhY2hfY2hpbGQodG9wLCB0YXJnZXQsICJ0
YXJnZXQiLCAmY2hpbGRfZmlsZSwgZXJycCk7DQo+PiArICAgIGlmICghc3RhdGUtPnRhcmdldCkg
ew0KPj4gKyAgICAgICAgYmRydl91bnJlZih0YXJnZXQpOw0KPj4gKyAgICAgICAgYmRydl91bnJl
Zih0b3ApOw0KPj4gKyAgICAgICAgcmV0dXJuIE5VTEw7DQo+PiArICAgIH0NCj4+ICsNCj4+ICsg
ICAgYmRydl9zZXRfYWlvX2NvbnRleHQodG9wLCBiZHJ2X2dldF9haW9fY29udGV4dChzb3VyY2Up
KTsNCj4+ICsgICAgYmRydl9zZXRfYWlvX2NvbnRleHQodGFyZ2V0LCBiZHJ2X2dldF9haW9fY29u
dGV4dChzb3VyY2UpKTsNCj4+ICsNCj4+ICsgICAgYmRydl9kcmFpbmVkX2JlZ2luKHNvdXJjZSk7
DQo+PiArDQo+PiArICAgIGJkcnZfcmVmKHRvcCk7DQo+PiArICAgIGJkcnZfYXBwZW5kKHRvcCwg
c291cmNlLCAmbG9jYWxfZXJyKTsNCj4+ICsNCj4+ICsgICAgaWYgKGxvY2FsX2Vycikgew0KPj4g
KyAgICAgICAgYmRydl91bnJlZih0b3ApOw0KPiANCj4gVGhpcyBpcyBkb25lIGF1dG9tYXRpY2Fs
bHkgYnkgYmRydl9hcHBlbmQoKS4NCj4gDQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgYmRydl9k
cmFpbmVkX2VuZChzb3VyY2UpOw0KPj4gKw0KPj4gKyAgICBpZiAobG9jYWxfZXJyKSB7DQo+PiAr
ICAgICAgICBiZHJ2X3VucmVmX2NoaWxkKHRvcCwgc3RhdGUtPnRhcmdldCk7DQo+PiArICAgICAg
ICBiZHJ2X3VucmVmKHRvcCk7DQo+PiArICAgICAgICBlcnJvcl9wcm9wYWdhdGUoZXJycCwgbG9j
YWxfZXJyKTsNCj4+ICsgICAgICAgIHJldHVybiBOVUxMOw0KPj4gKyAgICB9DQo+PiArDQo+PiAr
ICAgIHJldHVybiB0b3A7DQo+PiArfQ0KPj4gKw0KPj4gK3ZvaWQgYmRydl9iYWNrdXBfdG9wX2Ry
b3AoQmxvY2tEcml2ZXJTdGF0ZSAqYnMpDQo+PiArew0KPj4gKyAgICBCRFJWQmFja3VwVG9wU3Rh
dGUgKnMgPSBicy0+b3BhcXVlOw0KPj4gKw0KPj4gKyAgICBBaW9Db250ZXh0ICphaW9fY29udGV4
dCA9IGJkcnZfZ2V0X2Fpb19jb250ZXh0KGJzKTsNCj4+ICsNCj4+ICsgICAgYWlvX2NvbnRleHRf
YWNxdWlyZShhaW9fY29udGV4dCk7DQo+PiArDQo+PiArICAgIGJkcnZfZHJhaW5lZF9iZWdpbihi
cyk7DQo+PiArDQo+PiArICAgIGJkcnZfY2hpbGRfdHJ5X3NldF9wZXJtKGJzLT5iYWNraW5nLCAw
LCBCTEtfUEVSTV9BTEwsICZlcnJvcl9hYm9ydCk7DQo+PiArICAgIGJkcnZfcmVwbGFjZV9ub2Rl
KGJzLCBiYWNraW5nX2JzKGJzKSwgJmVycm9yX2Fib3J0KTsNCj4+ICsgICAgYmRydl9zZXRfYmFj
a2luZ19oZChicywgTlVMTCwgJmVycm9yX2Fib3J0KTsNCj4gDQo+IFRoaXMgaXMgZG9uZSBhdXRv
bWF0aWNhbGx5IGluIGJkcnZfY2xvc2UoKSwgYW5kIGFmdGVyIGJzIGhhcyBiZWVuDQo+IHJlcGxh
Y2VkIGJ5IGJhY2tpbmdfYnMoYnMpLCBJIGRvbid0IHRoaW5rIG5ldyByZXF1ZXN0cyBzaG91bGQg
Y29tZSBpbiwNCj4gc28gSSBkb24ndCB0aGluayB0aGlzIG5lZWRzIHRvIGJlIGRvbmUgaGVyZS4N
Cg0KRm9sbG93aW5nIG1vdmVtZW50IG9mIGJhY2t1cF90b3AgYmFjayB0byBqb2ItPmJsayBiZWNv
bWVzIGltcG9zc2libGUgdGhlbiwNCmlmIHdlIGRvbid0IHNoYXJlIFdSSVRFIG9uIHNvdXJjZSBp
biBiYWNrdXBfdG9wX2NoaWxkX3Blcm0uDQoNCkFuZCBJIHRoaW5rLCB0aGlzIGZ1bmN0aW9uIHNo
b3VsZCBkcm9wIGFsbCByZWxhdGlvbnMgY3JlYXRlZCBieQ0KYmRydl9iYWNrdXBfdG9wX2FwcGVu
ZC4NCg0KPiANCj4+ICsNCj4+ICsgICAgYmRydl9kcmFpbmVkX2VuZChicyk7DQo+PiArDQo+PiAr
ICAgIGlmIChzLT50YXJnZXQpIHsNCj4+ICsgICAgICAgIGJkcnZfdW5yZWZfY2hpbGQoYnMsIHMt
PnRhcmdldCk7DQo+PiArICAgIH0NCj4gDQo+IEFuZCB0aGlzIHNob3VsZCBiZSBkb25lIGluIGEg
LmJkcnZfY2xvc2UoKSBpbXBsZW1lbnRhdGlvbiwgSSB0aGluay4NCj4gDQo+IE1heA0KPiANCj4+
ICsgICAgYmRydl91bnJlZihicyk7DQo+PiArDQo+PiArICAgIGFpb19jb250ZXh0X3JlbGVhc2Uo
YWlvX2NvbnRleHQpOw0KPj4gK30NCj4+ICsNCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRp
bWlyDQo=

