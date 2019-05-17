Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9262C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 21:35:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66E342087E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 21:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="K2TQSvU0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jicHFCdO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E342087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53990 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRkVn-0000KI-HL
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 17:35:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=033a92d29=Alistair.Francis@wdc.com>)
	id 1hRkUw-0008DV-P3
	for qemu-devel@nongnu.org; Fri, 17 May 2019 17:34:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=033a92d29=Alistair.Francis@wdc.com>)
	id 1hRkUs-00067n-H9
	for qemu-devel@nongnu.org; Fri, 17 May 2019 17:34:36 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:43307)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=033a92d29=Alistair.Francis@wdc.com>)
	id 1hRkUk-00063u-Dm; Fri, 17 May 2019 17:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1558128930; x=1589664930;
	h=from:to:subject:date:message-id:references:in-reply-to:
	content-id:content-transfer-encoding:mime-version;
	bh=uvtCUctXFtmYKqfoG5+YCquGNJcYaE4g/d8xGwgNC8E=;
	b=K2TQSvU0KmVHZjGBDdQHTK54T5bkr7fu2Rj0dejCF/iI1GL/gAruiV+d
	woqxSKKCc1zLQ3WxZjzoFNWlk3FlQEiDZrtYBd9EEh8J45/nQ49YvCaM/
	QoqaaI7Oyu1sTnwdcJOQ8XL9fFqaMyz2/xbzledfQPXpiQV4goikyVOhw
	Hu2d1bpW00HmgsdvhT7u6ASmdhAwGI3BRTQck5SxHcFczS2hgxSYvtZpD
	mH6t1FQaNCkM1yMjv30jw5ipH1Q+xZoUFugs3EGEKhvAEK+2G2zVZzvDF
	UXgiErXiWrOFODLQNrEGtQ4k51oMwjB/SNMUm06zgYyIi+NKEFhQJOcyq A==;
X-IronPort-AV: E=Sophos;i="5.60,481,1549900800"; d="scan'208";a="207985197"
Received: from mail-dm3nam03lp2056.outbound.protection.outlook.com (HELO
	NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.56])
	by ob1.hgst.iphmx.com with ESMTP; 18 May 2019 05:35:20 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com; 
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=uvtCUctXFtmYKqfoG5+YCquGNJcYaE4g/d8xGwgNC8E=;
	b=jicHFCdOBHVShI05f1IcUQxrMVEEW5lWri8M8gnEDoQ+OMGhm0CXaGjLy0ThKWbDCaOo9IPlbej+4UoQneqz3XF5OINt9B97LOC3XFG7dI6445EARYR8Sn/TqVKLcJU9OJEgh1QyoEKtJ6x/F2zsCn9Vv0dlIBAxHaC8GOQZaM0=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB4983.namprd04.prod.outlook.com (52.135.233.12) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1900.16; Fri, 17 May 2019 21:34:18 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::9583:df9e:7ef5:44b7]) by
	BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::9583:df9e:7ef5:44b7%4]) with mapi id 15.20.1900.010;
	Fri, 17 May 2019 21:34:18 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "bmeng.cn@gmail.com"
	<bmeng.cn@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
	"palmer@sifive.com" <palmer@sifive.com>
Thread-Topic: [PATCH 1/2] riscv: sifive_u: Do not create hard-coded phandles
	in DT
Thread-Index: AQHVDMhpdohKXux0TUGNPIPiFBhGV6Zv1oCA
Date: Fri, 17 May 2019 21:34:18 +0000
Message-ID: <d5299afa569640c91c4206e38e7098320a4d00b2.camel@wdc.com>
References: <1558108285-19571-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1558108285-19571-1-git-send-email-bmeng.cn@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da8af316-0a2c-4caa-2fa6-08d6db0f6b26
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB4983; 
x-ms-traffictypediagnostic: BYAPR04MB4983:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB4983F44CA691832F9F1809C1900B0@BYAPR04MB4983.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:549;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(376002)(396003)(39860400002)(136003)(346002)(189003)(199004)(6246003)(86362001)(118296001)(53936002)(81166006)(25786009)(71200400001)(72206003)(8676002)(478600001)(99286004)(11346002)(102836004)(446003)(68736007)(186003)(110136005)(486006)(71190400001)(8936002)(81156014)(2201001)(2616005)(26005)(6506007)(36756003)(76176011)(476003)(66066001)(73956011)(66946007)(66446008)(64756008)(66556008)(66476007)(229853002)(316002)(7736002)(76116006)(5660300002)(6512007)(3846002)(6486002)(256004)(6116002)(305945005)(6436002)(2906002)(2501003)(14454004);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4983;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VbAgUm7mEo5EYN0uQBueccA8aS8SDPzRv6+9xDO2BEN0Ipmd0Bi2UDFddQ8sbdaPUO2RFmeYiK9EJ/XDz3hTxEGOL9DBdV2jGY2iCBBJsvOUyHRtGK1kj4jjfjngy0gFnqhN5xA+8G320nu19neA7GEB2EKteuNAsKyUjsbRowm8FJkSKWe6St1JPqvG3WoIxEpQg/FoYxUC4TvziqnlioBkNqbxw8ztQWVqzlKWiJkai+iCa0RkKumc0Rzbje0kAHsw/yDBC2yW4ruQEyVcJHEhFQ0jE6wXlNsvf5/fUzJZOToW5abLQAd8A1BD0N7QC3SjuQv6P9IaH3YH6y1mZfEE/LzQiPJMprZl+fnY8dhlpDJF55B/UCIF8k/ln9eqgGH8KyISFMDDA8X2HRxHMahXWKjb2tmRDaW2D57sjtA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A554AA7A60E5C343960D4D3CCF4767B4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da8af316-0a2c-4caa-2fa6-08d6db0f6b26
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 21:34:18.5772 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4983
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 68.232.143.124
Subject: Re: [Qemu-devel] [PATCH 1/2] riscv: sifive_u: Do not create
 hard-coded phandles in DT
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gRnJpLCAyMDE5LTA1LTE3IGF0IDA4OjUxIC0wNzAwLCBCaW4gTWVuZyB3cm90ZToNCj4gQXQg
cHJlc2VudCB0aGUgY3B1LCBwbGljIGFuZCBldGhjbGsgbm9kZXMnIHBoYW5kbGVzIGFyZSBoYXJk
LWNvZGVkDQo+IHRvIDEvMi8zIGluIERULiBJZiB3ZSBjb25maWd1cmUgbW9yZSB0aGFuIDEgY3B1
IGZvciB0aGUgbWFjaGluZSwNCj4gYWxsIGNwdSBub2RlcycgcGhhbmRsZXMgY29uZmxpY3Qgd2l0
aCBlYWNoIG90aGVyIGFzIHRoZXkgYXJlIGFsbCAxLg0KPiBGaXggaXQgYnkgcmVtb3ZpbmcgdGhl
IGhhcmRjb2RlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQmluIE1lbmcgPGJtZW5nLmNuQGdtYWls
LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNA
d2RjLmNvbT4NCg0KQWxpc3RhaXINCg0KPiAtLS0NCj4gDQo+ICBody9yaXNjdi9zaWZpdmVfdS5j
IHwgMTcgKysrKysrKysrKy0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25z
KCspLCA3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L3Jpc2N2L3NpZml2ZV91
LmMgYi9ody9yaXNjdi9zaWZpdmVfdS5jDQo+IGluZGV4IDVlY2M0N2MuLmUyMTIwYWMgMTAwNjQ0
DQo+IC0tLSBhL2h3L3Jpc2N2L3NpZml2ZV91LmMNCj4gKysrIGIvaHcvcmlzY3Yvc2lmaXZlX3Uu
Yw0KPiBAQCAtODYsNyArODYsNyBAQCBzdGF0aWMgdm9pZCBjcmVhdGVfZmR0KFNpRml2ZVVTdGF0
ZSAqcywgY29uc3QNCj4gc3RydWN0IE1lbW1hcEVudHJ5ICptZW1tYXAsDQo+ICAgICAgdWludDMy
X3QgKmNlbGxzOw0KPiAgICAgIGNoYXIgKm5vZGVuYW1lOw0KPiAgICAgIGNoYXIgZXRoY2xrX25h
bWVzW10gPSAicGNsa1wwaGNsa1wwdHhfY2xrIjsNCj4gLSAgICB1aW50MzJfdCBwbGljX3BoYW5k
bGUsIGV0aGNsa19waGFuZGxlOw0KPiArICAgIHVpbnQzMl90IHBsaWNfcGhhbmRsZSwgZXRoY2xr
X3BoYW5kbGUsIHBoYW5kbGUgPSAxOw0KPiAgDQo+ICAgICAgZmR0ID0gcy0+ZmR0ID0gY3JlYXRl
X2RldmljZV90cmVlKCZzLT5mZHRfc2l6ZSk7DQo+ICAgICAgaWYgKCFmZHQpIHsNCj4gQEAgLTEy
MSw2ICsxMjEsNyBAQCBzdGF0aWMgdm9pZCBjcmVhdGVfZmR0KFNpRml2ZVVTdGF0ZSAqcywgY29u
c3QNCj4gc3RydWN0IE1lbW1hcEVudHJ5ICptZW1tYXAsDQo+ICAgICAgcWVtdV9mZHRfc2V0cHJv
cF9jZWxsKGZkdCwgIi9jcHVzIiwgIiNhZGRyZXNzLWNlbGxzIiwgMHgxKTsNCj4gIA0KPiAgICAg
IGZvciAoY3B1ID0gcy0+c29jLmNwdXMubnVtX2hhcnRzIC0gMTsgY3B1ID49IDA7IGNwdS0tKSB7
DQo+ICsgICAgICAgIGludCBjcHVfcGhhbmRsZSA9IHBoYW5kbGUrKzsNCj4gICAgICAgICAgbm9k
ZW5hbWUgPSBnX3N0cmR1cF9wcmludGYoIi9jcHVzL2NwdUAlZCIsIGNwdSk7DQo+ICAgICAgICAg
IGNoYXIgKmludGMgPSBnX3N0cmR1cF9wcmludGYoIi9jcHVzL2NwdUAlZC9pbnRlcnJ1cHQtDQo+
IGNvbnRyb2xsZXIiLCBjcHUpOw0KPiAgICAgICAgICBjaGFyICppc2EgPSByaXNjdl9pc2Ffc3Ry
aW5nKCZzLT5zb2MuY3B1cy5oYXJ0c1tjcHVdKTsNCj4gQEAgLTEzNCw4ICsxMzUsOCBAQCBzdGF0
aWMgdm9pZCBjcmVhdGVfZmR0KFNpRml2ZVVTdGF0ZSAqcywgY29uc3QNCj4gc3RydWN0IE1lbW1h
cEVudHJ5ICptZW1tYXAsDQo+ICAgICAgICAgIHFlbXVfZmR0X3NldHByb3BfY2VsbChmZHQsIG5v
ZGVuYW1lLCAicmVnIiwgY3B1KTsNCj4gICAgICAgICAgcWVtdV9mZHRfc2V0cHJvcF9zdHJpbmco
ZmR0LCBub2RlbmFtZSwgImRldmljZV90eXBlIiwNCj4gImNwdSIpOw0KPiAgICAgICAgICBxZW11
X2ZkdF9hZGRfc3Vibm9kZShmZHQsIGludGMpOw0KPiAtICAgICAgICBxZW11X2ZkdF9zZXRwcm9w
X2NlbGwoZmR0LCBpbnRjLCAicGhhbmRsZSIsIDEpOw0KPiAtICAgICAgICBxZW11X2ZkdF9zZXRw
cm9wX2NlbGwoZmR0LCBpbnRjLCAibGludXgscGhhbmRsZSIsIDEpOw0KPiArICAgICAgICBxZW11
X2ZkdF9zZXRwcm9wX2NlbGwoZmR0LCBpbnRjLCAicGhhbmRsZSIsIGNwdV9waGFuZGxlKTsNCj4g
KyAgICAgICAgcWVtdV9mZHRfc2V0cHJvcF9jZWxsKGZkdCwgaW50YywgImxpbnV4LHBoYW5kbGUi
LA0KPiBjcHVfcGhhbmRsZSk7DQo+ICAgICAgICAgIHFlbXVfZmR0X3NldHByb3Bfc3RyaW5nKGZk
dCwgaW50YywgImNvbXBhdGlibGUiLCAicmlzY3YsY3B1LQ0KPiBpbnRjIik7DQo+ICAgICAgICAg
IHFlbXVfZmR0X3NldHByb3AoZmR0LCBpbnRjLCAiaW50ZXJydXB0LWNvbnRyb2xsZXIiLCBOVUxM
LA0KPiAwKTsNCj4gICAgICAgICAgcWVtdV9mZHRfc2V0cHJvcF9jZWxsKGZkdCwgaW50YywgIiNp
bnRlcnJ1cHQtY2VsbHMiLCAxKTsNCj4gQEAgLTE2Nyw2ICsxNjgsNyBAQCBzdGF0aWMgdm9pZCBj
cmVhdGVfZmR0KFNpRml2ZVVTdGF0ZSAqcywgY29uc3QNCj4gc3RydWN0IE1lbW1hcEVudHJ5ICpt
ZW1tYXAsDQo+ICAgICAgZ19mcmVlKGNlbGxzKTsNCj4gICAgICBnX2ZyZWUobm9kZW5hbWUpOw0K
PiAgDQo+ICsgICAgcGxpY19waGFuZGxlID0gcGhhbmRsZSsrOw0KPiAgICAgIGNlbGxzID0gIGdf
bmV3MCh1aW50MzJfdCwgcy0+c29jLmNwdXMubnVtX2hhcnRzICogNCk7DQo+ICAgICAgZm9yIChj
cHUgPSAwOyBjcHUgPCBzLT5zb2MuY3B1cy5udW1faGFydHM7IGNwdSsrKSB7DQo+ICAgICAgICAg
IG5vZGVuYW1lID0NCj4gQEAgLTE5MiwyMCArMTk0LDIxIEBAIHN0YXRpYyB2b2lkIGNyZWF0ZV9m
ZHQoU2lGaXZlVVN0YXRlICpzLCBjb25zdA0KPiBzdHJ1Y3QgTWVtbWFwRW50cnkgKm1lbW1hcCwN
Cj4gICAgICBxZW11X2ZkdF9zZXRwcm9wX3N0cmluZyhmZHQsIG5vZGVuYW1lLCAicmVnLW5hbWVz
IiwgImNvbnRyb2wiKTsNCj4gICAgICBxZW11X2ZkdF9zZXRwcm9wX2NlbGwoZmR0LCBub2RlbmFt
ZSwgInJpc2N2LG1heC1wcmlvcml0eSIsIDcpOw0KPiAgICAgIHFlbXVfZmR0X3NldHByb3BfY2Vs
bChmZHQsIG5vZGVuYW1lLCAicmlzY3YsbmRldiIsIDB4MzUpOw0KPiAtICAgIHFlbXVfZmR0X3Nl
dHByb3BfY2VsbHMoZmR0LCBub2RlbmFtZSwgInBoYW5kbGUiLCAyKTsNCj4gLSAgICBxZW11X2Zk
dF9zZXRwcm9wX2NlbGxzKGZkdCwgbm9kZW5hbWUsICJsaW51eCxwaGFuZGxlIiwgMik7DQo+ICsg
ICAgcWVtdV9mZHRfc2V0cHJvcF9jZWxscyhmZHQsIG5vZGVuYW1lLCAicGhhbmRsZSIsIHBsaWNf
cGhhbmRsZSk7DQo+ICsgICAgcWVtdV9mZHRfc2V0cHJvcF9jZWxscyhmZHQsIG5vZGVuYW1lLCAi
bGludXgscGhhbmRsZSIsDQo+IHBsaWNfcGhhbmRsZSk7DQo+ICAgICAgcGxpY19waGFuZGxlID0g
cWVtdV9mZHRfZ2V0X3BoYW5kbGUoZmR0LCBub2RlbmFtZSk7DQo+ICAgICAgZ19mcmVlKGNlbGxz
KTsNCj4gICAgICBnX2ZyZWUobm9kZW5hbWUpOw0KPiAgDQo+ICsgICAgZXRoY2xrX3BoYW5kbGUg
PSBwaGFuZGxlKys7DQo+ICAgICAgbm9kZW5hbWUgPSBnX3N0cmR1cF9wcmludGYoIi9zb2MvZXRo
Y2xrIik7DQo+ICAgICAgcWVtdV9mZHRfYWRkX3N1Ym5vZGUoZmR0LCBub2RlbmFtZSk7DQo+ICAg
ICAgcWVtdV9mZHRfc2V0cHJvcF9zdHJpbmcoZmR0LCBub2RlbmFtZSwgImNvbXBhdGlibGUiLCAi
Zml4ZWQtDQo+IGNsb2NrIik7DQo+ICAgICAgcWVtdV9mZHRfc2V0cHJvcF9jZWxsKGZkdCwgbm9k
ZW5hbWUsICIjY2xvY2stY2VsbHMiLCAweDApOw0KPiAgICAgIHFlbXVfZmR0X3NldHByb3BfY2Vs
bChmZHQsIG5vZGVuYW1lLCAiY2xvY2stZnJlcXVlbmN5IiwNCj4gICAgICAgICAgU0lGSVZFX1Vf
R0VNX0NMT0NLX0ZSRVEpOw0KPiAtICAgIHFlbXVfZmR0X3NldHByb3BfY2VsbChmZHQsIG5vZGVu
YW1lLCAicGhhbmRsZSIsIDMpOw0KPiAtICAgIHFlbXVfZmR0X3NldHByb3BfY2VsbChmZHQsIG5v
ZGVuYW1lLCAibGludXgscGhhbmRsZSIsIDMpOw0KPiArICAgIHFlbXVfZmR0X3NldHByb3BfY2Vs
bChmZHQsIG5vZGVuYW1lLCAicGhhbmRsZSIsIGV0aGNsa19waGFuZGxlKTsNCj4gKyAgICBxZW11
X2ZkdF9zZXRwcm9wX2NlbGwoZmR0LCBub2RlbmFtZSwgImxpbnV4LHBoYW5kbGUiLA0KPiBldGhj
bGtfcGhhbmRsZSk7DQo+ICAgICAgZXRoY2xrX3BoYW5kbGUgPSBxZW11X2ZkdF9nZXRfcGhhbmRs
ZShmZHQsIG5vZGVuYW1lKTsNCj4gICAgICBnX2ZyZWUobm9kZW5hbWUpOw0KPiAgDQo=

