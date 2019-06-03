Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E9AC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 10:04:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87E9628071
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 10:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bjeMfvwt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E9628071
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60775 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXjpe-0002Lr-Te
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 06:04:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hXjoe-0001zy-1D
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 06:03:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hXjoc-0002Qi-CX
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 06:03:43 -0400
Received: from mail-eopbgr20101.outbound.protection.outlook.com
	([40.107.2.101]:27875
	helo=EUR02-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hXjoY-0002J3-Gt; Mon, 03 Jun 2019 06:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=LPqZDe5poPPt1OQFIBiDDHOPX9UE1b8EiMK+35F940Y=;
	b=bjeMfvwtGTRBoYm/rR00yc1vAmrGylGdGNK9dHvi83C7JErnnb4oYJ07PjjdqNEDnP1jg+z7L98u3Bb66vP8eTiCexnA2aZbMviEDSo2FUSFla0KWArbpS1/6isC1+zBQyXsoXdZ1V/qC3hyjITjpUVbLXwCuleqq/cZ33qd9co=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
	AM0PR08MB3906.eurprd08.prod.outlook.com (20.178.22.82) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1943.22; Mon, 3 Jun 2019 10:03:27 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8]) by
	AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8%7]) with mapi id 15.20.1943.018;
	Mon, 3 Jun 2019 10:03:27 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v2 3/9] iotests: add test 255 to check
	bitmap life after snapshot + commit
Thread-Index: AQHVF85q1ljc57E42E+gWchgSDZZLqaF5W6AgAPSH4A=
Date: Mon, 3 Jun 2019 10:03:27 +0000
Message-ID: <a9cc698c-f8d6-2209-d82f-c4a2510084f9@virtuozzo.com>
References: <20190531163202.162543-1-vsementsov@virtuozzo.com>
	<20190531163202.162543-4-vsementsov@virtuozzo.com>
	<fb8e1383-99f2-6a15-918d-81bd0309beeb@redhat.com>
In-Reply-To: <fb8e1383-99f2-6a15-918d-81bd0309beeb@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0024.eurprd09.prod.outlook.com
	(2603:10a6:3:e5::34) To AM0PR08MB2961.eurprd08.prod.outlook.com
	(2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190603130325158
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f08b3478-505c-4d8f-5a1d-08d6e80ab8e6
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:AM0PR08MB3906; 
x-ms-traffictypediagnostic: AM0PR08MB3906:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR08MB3906877091649E75CFE9DEA8C1140@AM0PR08MB3906.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39850400004)(366004)(376002)(396003)(346002)(136003)(189003)(199004)(305945005)(7736002)(52116002)(76176011)(102836004)(99286004)(386003)(6506007)(53546011)(229853002)(478600001)(14454004)(2906002)(6116002)(8936002)(3846002)(8676002)(81156014)(81166006)(446003)(11346002)(476003)(486006)(256004)(26005)(186003)(2616005)(14444005)(25786009)(54906003)(110136005)(316002)(68736007)(36756003)(2501003)(86362001)(31686004)(31696002)(2201001)(66066001)(4326008)(107886003)(6246003)(5660300002)(53936002)(71200400001)(71190400001)(6486002)(6306002)(66446008)(64756008)(66556008)(66476007)(6512007)(66946007)(73956011)(6436002)(2004002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3906;
	H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: m+vsvNCfK6mP7x9oR/bXIhJaZ9A+BK2Ck4n7hYvgxoEJh1Ec7J4p1ko3IjokXQfmjeUBBzsYUOsgyv8xXTQ2AFi9649klA2ze77sj93//Ua9C3PH0U5ahh+uRgyShg6RPnwbPto7dwE4+qivijjr88WChvFX3wWIvZYQd+lVcpETqWkArA6riyWMTKEGJ4XzvPwoB1IFSVuB17Qmh/GmZ08nkSMazHq5xNEoKtA8nUnJgB94Y4SKrhRcwvxwyF20x6M2GXrakvJgUMLFOsfza1bc8Ee9BkFK2oJCXbv2VDaK8j/ZeCynvEIPe0j+/bUdWMp6qcNtyFRha73jve58umo6fdO9QaakWsHJ3rqez06WchMgQSPv5BjZWPcaDNjMOKkB/GDpYE9Pi+gauvv3iuYGxPS5+NX1DfD8pMwNcBs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2783C180F3007498DAF1CCA1F7029D8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f08b3478-505c-4d8f-5a1d-08d6e80ab8e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 10:03:27.1683 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3906
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.101
Subject: Re: [Qemu-devel] [PATCH v2 3/9] iotests: add test 255 to check
 bitmap life after snapshot + commit
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

MDEuMDYuMjAxOSAyOjQyLCBKb2huIFNub3cgd3JvdGU6DQo+IA0KPiANCj4gT24gNS8zMS8xOSAx
MjozMSBQTSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IFR3byB0ZXN0
Y2FzZXMgd2l0aCBwZXJzaXN0ZW50IGJpdG1hcHMgYXJlIG5vdCBhZGRlZCBoZXJlLCBhcyB0aGVy
ZSBhcmUNCj4+IGJ1Z3MgdG8gYmUgZml4ZWQgc29vbi4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBW
bGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+
PiAtLS0NCj4+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzI1NSAgICAgfCA4NCArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMjU1Lm91
dCB8IDE3ICsrKysrKysrDQo+PiAgIHRlc3RzL3FlbXUtaW90ZXN0cy9ncm91cCAgIHwgIDEgKw0K
Pj4gICAzIGZpbGVzIGNoYW5nZWQsIDEwMiBpbnNlcnRpb25zKCspDQo+PiAgIGNyZWF0ZSBtb2Rl
IDEwMDc1NSB0ZXN0cy9xZW11LWlvdGVzdHMvMjU1DQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0
ZXN0cy9xZW11LWlvdGVzdHMvMjU1Lm91dA0KPj4NCj4+IGRpZmYgLS1naXQgYS90ZXN0cy9xZW11
LWlvdGVzdHMvMjU1IGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzI1NQ0KPj4gbmV3IGZpbGUgbW9kZSAx
MDA3NTUNCj4+IGluZGV4IDAwMDAwMDAwMDAuLjFiM2MwODFhNjgNCj4+IC0tLSAvZGV2L251bGwN
Cj4+ICsrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8yNTUNCj4+IEBAIC0wLDAgKzEsODQgQEANCj4+
ICsjIS91c3IvYmluL2VudiBweXRob24NCj4+ICsjDQo+PiArIyBUZXN0cyBmb3IgdGVtcG9yYXJ5
IGV4dGVybmFsIHNuYXBzaG90IHdoZW4gd2UgaGF2ZSBiaXRtYXBzLg0KPj4gKyMNCj4+ICsjIENv
cHlyaWdodCAoYykgMjAxOSBWaXJ0dW96em8gSW50ZXJuYXRpb25hbCBHbWJILiBBbGwgcmlnaHRz
IHJlc2VydmVkLg0KPj4gKyMNCj4+ICsjIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5
b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5DQo+PiArIyBpdCB1bmRlciB0aGUg
dGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQ0K
Pj4gKyMgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0
aGUgTGljZW5zZSwgb3INCj4+ICsjIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24u
DQo+PiArIw0KPj4gKyMgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRo
YXQgaXQgd2lsbCBiZSB1c2VmdWwsDQo+PiArIyBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdp
dGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZg0KPj4gKyMgTUVSQ0hBTlRBQklMSVRZ
IG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZQ0KPj4gKyMgR05V
IEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4NCj4+ICsjDQo+PiArIyBZ
b3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMg
TGljZW5zZQ0KPj4gKyMgYWxvbmcgd2l0aCB0aGlzIHByb2dyYW0uICBJZiBub3QsIHNlZSA8aHR0
cDovL3d3dy5nbnUub3JnL2xpY2Vuc2VzLz4uDQo+PiArIw0KPj4gKw0KPj4gK2ltcG9ydCBpb3Rl
c3RzDQo+PiArZnJvbSBpb3Rlc3RzIGltcG9ydCBxZW11X2ltZ19jcmVhdGUsIGZpbGVfcGF0aCwg
bG9nDQo+PiArDQo+PiAraW90ZXN0cy52ZXJpZnlfaW1hZ2VfZm9ybWF0KHN1cHBvcnRlZF9mbXRz
PVsncWNvdzInXSkNCj4+ICsNCj4+ICtiYXNlLCB0b3AgPSBmaWxlX3BhdGgoJ2Jhc2UnLCAndG9w
JykNCj4+ICtzaXplID0gNjQgKiAxMDI0ICogMw0KPj4gKw0KPj4gKw0KPj4gK2RlZiBwcmludF9i
aXRtYXAobXNnLCB2bSk6DQo+PiArICAgIHJlc3VsdCA9IHZtLnFtcCgncXVlcnktYmxvY2snKVsn
cmV0dXJuJ11bMF0NCj4+ICsgICAgaWYgJ2RpcnR5LWJpdG1hcHMnIGluIHJlc3VsdDoNCj4+ICsg
ICAgICAgIGJpdG1hcCA9IHJlc3VsdFsnZGlydHktYml0bWFwcyddWzBdDQo+PiArICAgICAgICBs
b2coJ3t9OiBuYW1lPXt9IGRpcnR5LWNsdXN0ZXJzPXt9Jy5mb3JtYXQobXNnLCBiaXRtYXBbJ25h
bWUnXSwNCj4+ICsgICAgICAgICAgICBiaXRtYXBbJ2NvdW50J10gLy8gNjQgLy8gMTAyNCkpDQo+
PiArICAgIGVsc2U6DQo+PiArICAgICAgICBsb2cobXNnICsgJzogbm90IGZvdW5kJykNCj4+ICsN
Cj4+ICsNCj4+ICtkZWYgdGVzdChwZXJzaXN0ZW50LCByZXN0YXJ0KToNCj4+ICsgICAgYXNzZXJ0
IHBlcnNpc3RlbnQgb3Igbm90IHJlc3RhcnQNCj4+ICsgICAgbG9nKCJcblRlc3RjYXNlIHt9cGVy
c2lzdGVudCB7fSByZXN0YXJ0XG4iLmZvcm1hdCgNCj4+ICsgICAgICAgICAgICAnJyBpZiBwZXJz
aXN0ZW50IGVsc2UgJ25vbi0nLCAnd2l0aCcgaWYgcmVzdGFydCBlbHNlICd3aXRob3V0JykpDQo+
PiArDQo+PiArICAgIHFlbXVfaW1nX2NyZWF0ZSgnLWYnLCBpb3Rlc3RzLmltZ2ZtdCwgYmFzZSwg
c3RyKHNpemUpKQ0KPj4gKw0KPj4gKyAgICB2bSA9IGlvdGVzdHMuVk0oKS5hZGRfZHJpdmUoYmFz
ZSkNCj4+ICsgICAgdm0ubGF1bmNoKCkNCj4+ICsNCj4+ICsgICAgdm0ucW1wX2xvZygnYmxvY2st
ZGlydHktYml0bWFwLWFkZCcsIG5vZGU9J2RyaXZlMCcsIG5hbWU9J2JpdG1hcDAnLA0KPj4gKyAg
ICAgICAgICAgICAgIHBlcnNpc3RlbnQ9cGVyc2lzdGVudCkNCj4+ICsgICAgdm0uaG1wX3FlbXVf
aW8oJ2RyaXZlMCcsICd3cml0ZSAwIDY0SycpDQo+PiArICAgIHByaW50X2JpdG1hcCgnaW5pdGlh
bCBiaXRtYXAnLCB2bSkNCj4+ICsNCj4+ICsgICAgdm0ucW1wX2xvZygnYmxvY2tkZXYtc25hcHNo
b3Qtc3luYycsIGRldmljZT0nZHJpdmUwJywgc25hcHNob3RfZmlsZT10b3AsDQo+PiArICAgICAg
ICAgICAgICAgZm9ybWF0PWlvdGVzdHMuaW1nZm10LCBmaWx0ZXJzPVtpb3Rlc3RzLmZpbHRlcl9x
bXBfdGVzdGZpbGVzXSkNCj4+ICsgICAgdm0uaG1wX3FlbXVfaW8oJ2RyaXZlMCcsICd3cml0ZSA2
NEsgNTEyJykNCj4+ICsgICAgcHJpbnRfYml0bWFwKCdjaGVjayB0aGF0IG5vIGJpdG1hcHMgYXJl
IGluIHNuYXBzaG90Jywgdm0pDQo+PiArDQo+PiArICAgIGlmIHJlc3RhcnQ6DQo+PiArICAgICAg
ICBsb2coIi4uLiBSZXN0YXJ0IC4uLiIpDQo+PiArICAgICAgICB2bS5zaHV0ZG93bigpDQo+PiAr
ICAgICAgICB2bSA9IGlvdGVzdHMuVk0oKS5hZGRfZHJpdmUodG9wKQ0KPj4gKyAgICAgICAgdm0u
bGF1bmNoKCkNCj4+ICsNCj4+ICsgICAgdm0ucW1wX2xvZygnYmxvY2stY29tbWl0JywgZGV2aWNl
PSdkcml2ZTAnLCB0b3A9dG9wLA0KPj4gKyAgICAgICAgICAgICAgIGZpbHRlcnM9W2lvdGVzdHMu
ZmlsdGVyX3FtcF90ZXN0ZmlsZXNdKQ0KPj4gKyAgICBldiA9IHZtLmV2ZW50X3dhaXRfbG9nKFsn
QkxPQ0tfSk9CX1JFQURZJywgJ0JMT0NLX0pPQl9DT01QTEVURUQnXSkNCj4+ICsgICAgaWYgKGV2
WydldmVudCddID09ICdCTE9DS19KT0JfQ09NUExFVEVEJyk6DQo+PiArICAgICAgICB2bS5zaHV0
ZG93bigpDQo+PiArICAgICAgICBsb2codm0uZ2V0X2xvZygpKQ0KPj4gKyAgICAgICAgZXhpdCgp
DQo+PiArDQo+IA0KPiBXaGF0J3MgdGhlIHB1cnBvc2Ugb2YgdGhpcyBjb25kaXRpb25hbD8gd2hh
dCBjYXVzZXMgdGhlIGRpZmZlcmVuY2UgaW4NCj4gYmVoYXZpb3IgdGhhdCB3ZSBuZWVkIHRvIGhh
bmRsZSBpdD8NCg0KQ09NUExFVEVEIGhlcmUgbWVhbnMgZXJyb3IuIHdpdGhvdXQgdGhpcyBjb25k
aXRpb25hbCwgd2UnbGwgd2FpdCA2MHMgaW4gbmV4dA0KZXZlbnRfd2FpdCwgd2hpY2ggaXMgdmVy
eSB1bmNvbWZvcnRhYmxlIGZvciBkZWJ1Z2dpbmcuIENvbnRyYXJpd2lzZSwgc3RvcCBpbg0KdGhp
cyBjYXNlIGlzIGEgbG90IGJldHRlci4uLiBPZiBjb3Vyc2UsIGl0IG1heSBiZSBzYWZlbHkgZHJv
cHBlZCwgYXMgdGVzdA0KcGFzc2VzIG5vdy4NCg0KPiANCj4+ICsgICAgdm0ucW1wX2xvZygnYmxv
Y2stam9iLWNvbXBsZXRlJywgZGV2aWNlPSdkcml2ZTAnKQ0KPj4gKyAgICB2bS5ldmVudF93YWl0
X2xvZygnQkxPQ0tfSk9CX0NPTVBMRVRFRCcpDQo+PiArICAgIHByaW50X2JpdG1hcCgnY2hlY2sg
Yml0bWFwIGFmdGVyIGNvbW1pdCcsIHZtKQ0KPj4gKw0KPj4gKyAgICB2bS5obXBfcWVtdV9pbygn
ZHJpdmUwJywgJ3dyaXRlIDEyOEsgNjRLJykNCj4+ICsgICAgcHJpbnRfYml0bWFwKCdjaGVjayB1
cGRhdGVkIGJpdG1hcCcsIHZtKQ0KPj4gKw0KPj4gKyAgICB2bS5zaHV0ZG93bigpDQo+PiArDQo+
PiArDQo+PiArdGVzdChwZXJzaXN0ZW50PUZhbHNlLCByZXN0YXJ0PUZhbHNlKQ0KPj4gZGlmZiAt
LWdpdCBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8yNTUub3V0IGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzI1
NS5vdXQNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwLi41MjM5
ZDI3YzQ2DQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi90ZXN0cy9xZW11LWlvdGVzdHMvMjU1
Lm91dA0KPj4gQEAgLTAsMCArMSwxNyBAQA0KPj4gKw0KPj4gK1Rlc3RjYXNlIG5vbi1wZXJzaXN0
ZW50IHdpdGhvdXQgcmVzdGFydA0KPj4gKw0KPj4gK3siZXhlY3V0ZSI6ICJibG9jay1kaXJ0eS1i
aXRtYXAtYWRkIiwgImFyZ3VtZW50cyI6IHsibmFtZSI6ICJiaXRtYXAwIiwgIm5vZGUiOiAiZHJp
dmUwIiwgInBlcnNpc3RlbnQiOiBmYWxzZX19DQo+PiAreyJyZXR1cm4iOiB7fX0NCj4+ICtpbml0
aWFsIGJpdG1hcDogbmFtZT1iaXRtYXAwIGRpcnR5LWNsdXN0ZXJzPTENCj4+ICt7ImV4ZWN1dGUi
OiAiYmxvY2tkZXYtc25hcHNob3Qtc3luYyIsICJhcmd1bWVudHMiOiB7ImRldmljZSI6ICJkcml2
ZTAiLCAiZm9ybWF0IjogInFjb3cyIiwgInNuYXBzaG90LWZpbGUiOiAiVEVTVF9ESVIvUElELXRv
cCJ9fQ0KPj4gK3sicmV0dXJuIjoge319DQo+PiArY2hlY2sgdGhhdCBubyBiaXRtYXBzIGFyZSBp
biBzbmFwc2hvdDogbm90IGZvdW5kDQo+PiAreyJleGVjdXRlIjogImJsb2NrLWNvbW1pdCIsICJh
cmd1bWVudHMiOiB7ImRldmljZSI6ICJkcml2ZTAiLCAidG9wIjogIlRFU1RfRElSL1BJRC10b3Ai
fX0NCj4+ICt7InJldHVybiI6IHt9fQ0KPj4gK3siZGF0YSI6IHsiZGV2aWNlIjogImRyaXZlMCIs
ICJsZW4iOiA2NTUzNiwgIm9mZnNldCI6IDY1NTM2LCAic3BlZWQiOiAwLCAidHlwZSI6ICJjb21t
aXQifSwgImV2ZW50IjogIkJMT0NLX0pPQl9SRUFEWSIsICJ0aW1lc3RhbXAiOiB7Im1pY3Jvc2Vj
b25kcyI6ICJVU0VDUyIsICJzZWNvbmRzIjogIlNFQ1MifX0NCj4+ICt7ImV4ZWN1dGUiOiAiYmxv
Y2stam9iLWNvbXBsZXRlIiwgImFyZ3VtZW50cyI6IHsiZGV2aWNlIjogImRyaXZlMCJ9fQ0KPj4g
K3sicmV0dXJuIjoge319DQo+PiAreyJkYXRhIjogeyJkZXZpY2UiOiAiZHJpdmUwIiwgImxlbiI6
IDY1NTM2LCAib2Zmc2V0IjogNjU1MzYsICJzcGVlZCI6IDAsICJ0eXBlIjogImNvbW1pdCJ9LCAi
ZXZlbnQiOiAiQkxPQ0tfSk9CX0NPTVBMRVRFRCIsICJ0aW1lc3RhbXAiOiB7Im1pY3Jvc2Vjb25k
cyI6ICJVU0VDUyIsICJzZWNvbmRzIjogIlNFQ1MifX0NCj4+ICtjaGVjayBiaXRtYXAgYWZ0ZXIg
Y29tbWl0OiBuYW1lPWJpdG1hcDAgZGlydHktY2x1c3RlcnM9Mg0KPj4gK2NoZWNrIHVwZGF0ZWQg
Yml0bWFwOiBuYW1lPWJpdG1hcDAgZGlydHktY2x1c3RlcnM9Mw0KPj4gZGlmZiAtLWdpdCBhL3Rl
c3RzL3FlbXUtaW90ZXN0cy9ncm91cCBiL3Rlc3RzL3FlbXUtaW90ZXN0cy9ncm91cA0KPj4gaW5k
ZXggODU5YzRiNWU5Zi4uODgwNDlhZDQ2YyAxMDA2NDQNCj4+IC0tLSBhL3Rlc3RzL3FlbXUtaW90
ZXN0cy9ncm91cA0KPj4gKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzL2dyb3VwDQo+PiBAQCAtMjY1
LDMgKzI2NSw0IEBADQo+PiAgIDI1MiBydyBhdXRvIGJhY2tpbmcgcXVpY2sNCj4+ICAgMjUzIHJ3
IGF1dG8gcXVpY2sNCj4+ICAgMjU0IHJ3IGF1dG8gYmFja2luZyBxdWljaw0KPj4gKzI1NSBydyBh
dXRvIHF1aWNrDQo+Pg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

