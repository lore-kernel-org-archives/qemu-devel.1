Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16C6C4646B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 23:43:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE98520663
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 23:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FW5KoXIP";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NyamZeeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE98520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55492 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfYcv-0000WX-4e
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 19:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51339)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0714f841a=Atish.Patra@wdc.com>)
 id 1hfYbp-00082K-0P
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 19:42:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0714f841a=Atish.Patra@wdc.com>)
 id 1hfYbn-0007Bm-LV
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 19:42:48 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:63431)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0714f841a=Atish.Patra@wdc.com>)
 id 1hfYbk-0006rw-Iw; Mon, 24 Jun 2019 19:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1561419856; x=1592955856;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=KyJ5/rTRraT6vIyb7XaqgCigdjxtZzag+/EHppwufEE=;
 b=FW5KoXIPUHWHn7TA+mzFKjipLKFzWlwsLsMCplbR5TgClri5RuBS6/r1
 y1zVT9BXEw/DAt5gYGwuE2dJPChIvMeSuH0zLQpQyXKki85nYWuebMtrv
 h6pEsJIHhzqjruexT02PfLTE3ND6QDCCW8qO/4A2RC0xKdVvmaonpONuT
 G2vK67S9Ld3F5pAOcp6Zrz+uqx8YEU64WO6EaO1KFRVBoCY/QpuudZXtV
 gTqhLsC4gz8188+zZe/RMJsXSaDe1WrkILC0wN5fNJKt29vT72aRwX4AW
 QtakqPOoWJa+vF0vQkGC9lk12VK2bquZ4FsNZVAbsIpPs8r60HPtA/9YL A==;
X-IronPort-AV: E=Sophos;i="5.63,413,1557158400"; d="scan'208";a="211216635"
Received: from mail-dm3nam03lp2058.outbound.protection.outlook.com (HELO
 NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.58])
 by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2019 07:44:08 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KyJ5/rTRraT6vIyb7XaqgCigdjxtZzag+/EHppwufEE=;
 b=NyamZeeAAKzxc7b0zfLupfZEDBrMdGYSIV8T7HRWHSKZkEOUZQ9Ygy6IqDTNv7dLrRpSKEf1/4q52zP+Pf8fGwyeGW1Y58xbjl+u+NED3KPWaiQMR6cHRDTnx96ylNcfeu/QPOd2xMuc6AuGk2XMVsmacQOkElVTLCpzAnX1YR0=
Received: from BYAPR04MB3782.namprd04.prod.outlook.com (52.135.214.142) by
 BYAPR04MB6261.namprd04.prod.outlook.com (20.178.235.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 23:42:38 +0000
Received: from BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::65e3:6069:d7d5:90a2]) by BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::65e3:6069:d7d5:90a2%5]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 23:42:37 +0000
From: Atish Patra <Atish.Patra@wdc.com>
To: "alistair23@gmail.com" <alistair23@gmail.com>
Thread-Topic: [Qemu-devel] [PATCH] riscv: virt: Add cpu-topology DT node.
Thread-Index: AQHVKuANDrUUqXhjtE+s2j3z1WClTKarcg4AgAAFMgA=
Date: Mon, 24 Jun 2019 23:42:37 +0000
Message-ID: <775843eacbe56613db95b547c6477311b212815b.camel@wdc.com>
References: <20190624225446.22597-1-atish.patra@wdc.com>
 <CAKmqyKO28WO3QzQOOzJnFOA5J2Wjeg-MF5+BcoWWF+qO=+UTNA@mail.gmail.com>
In-Reply-To: <CAKmqyKO28WO3QzQOOzJnFOA5J2Wjeg-MF5+BcoWWF+qO=+UTNA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f64d3de5-8dfb-4bda-6cc7-08d6f8fda3e9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:BYAPR04MB6261; 
x-ms-traffictypediagnostic: BYAPR04MB6261:
x-ms-exchange-purlcount: 1
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB6261D14559C1C565E4164E2EFAE00@BYAPR04MB6261.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:499;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39860400002)(366004)(396003)(376002)(346002)(189003)(199004)(36756003)(1411001)(102836004)(26005)(81156014)(76116006)(229853002)(66946007)(54906003)(71190400001)(11346002)(486006)(4326008)(316002)(6306002)(305945005)(3846002)(25786009)(8676002)(71200400001)(53936002)(81166006)(6246003)(256004)(2501003)(6512007)(8936002)(7736002)(478600001)(1361003)(66446008)(2351001)(186003)(64756008)(53546011)(86362001)(6436002)(5640700003)(6506007)(99286004)(6116002)(76176011)(66066001)(446003)(73956011)(72206003)(14454004)(6486002)(68736007)(476003)(2616005)(118296001)(5660300002)(66476007)(966005)(2906002)(6916009)(66556008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB6261;
 H:BYAPR04MB3782.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KHewWez8PBWkm23QRtMD4U83vPwHxifB52zYTYlj8nAE1Bdv8EBBn968TKRkGN4DVHqgb4R4nnNfaRs5DvEPqhJltjH5YRgP1pSAdw95XsN6W0AmOJueGBmFjqTsWSiG9jW7FJafzSGB7U0aPfrbug1VcDIA9Ttn+4YIw3wzZIyhuf2vc8/WHGGrW/NFHe/3b9ws5/jNE89x9K0GD0hqAHGlA1qHi+ECJDg+mKOJB8Ff1VHWtq/2CkJCrpTc47FIA44VWik99t0CCypgkQucCEj7oXG7rJfQEn1W2kiQD7DRW01rlFQ1uTXW9FWCbtQwixn3Y/NBIqKvJT2hwh2LQxKZroGcF7p6m5/QgTJWbhpKsAA4P4ga6/x8r2gC7w7Ad3AmncJqyJFHXCFmgD+ZC+zxeGDEcaEuDG8kvcHzFE4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CF26C644F6BE1448ABB3A33E8D447B3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f64d3de5-8dfb-4bda-6cc7-08d6f8fda3e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 23:42:37.7623 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Atish.Patra@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6261
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 68.232.143.124
Subject: Re: [Qemu-devel] [PATCH] riscv: virt: Add cpu-topology DT node.
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
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "sagark@eecs.berkeley.edu" <sagark@eecs.berkeley.edu>,
 "kbastian@mail.uni-paderborn.de" <kbastian@mail.uni-paderborn.de>,
 "palmer@sifive.com" <palmer@sifive.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gTW9uLCAyMDE5LTA2LTI0IGF0IDE2OjI0IC0wNzAwLCBBbGlzdGFpciBGcmFuY2lzIHdyb3Rl
Og0KPiBPbiBNb24sIEp1biAyNCwgMjAxOSBhdCAzOjU3IFBNIEF0aXNoIFBhdHJhIDxhdGlzaC5w
YXRyYUB3ZGMuY29tPg0KPiB3cm90ZToNCj4gPiBDdXJyZW50bHksIHRoZXJlIGlzIG5vIGNwdSB0
b3BvbG9neSBkZWZpbmVkIGluIFJJU0MtVi4NCj4gPiBEZWZpbmUgYSBkZXZpY2UgdHJlZSBub2Rl
IHRoYXQgY2xlYXJseSBkZXNjcmliZXMgdGhlDQo+ID4gZW50aXJlIHRvcG9sb2d5LiBUaGlzIHNh
dmVzIHRoZSB0cm91YmxlIG9mIHNjYW5uaW5nIGluZGl2aWR1YWwNCj4gPiBjYWNoZSB0byBmaWd1
cmUgb3V0IHRoZSB0b3BvbG9neS4NCj4gPiANCj4gPiBIZXJlIGlzIHRoZSBsaW51eCBrZXJuZWwg
cGF0Y2ggc2VyaWVzIHRoYXQgZW5hYmxlcyB0b3BvbG9neQ0KPiA+IGZvciBSSVNDLVYuDQo+ID4g
DQo+ID4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2xpbnV4LXJpc2N2LzIw
MTktSnVuZS8wMDUwNzIuaHRtbA0KPiA+IA0KPiA+IENQVSB0b3BvbG9neSBhZnRlciBhcHBseWlu
ZyB0aGlzIHBhdGNoIGluIFFFTVUgJiBhYm92ZSBzZXJpZXMgaW4NCj4gPiBrZXJuZWwNCj4gPiAN
Cj4gPiAvICMgY2F0IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdTIvdG9wb2xvZ3kvdGhyZWFk
X3NpYmxpbmdzX2xpc3QNCj4gPiAyDQo+ID4gLyAjIGNhdCAvc3lzL2RldmljZXMvc3lzdGVtL2Nw
dS9jcHUyL3RvcG9sb2d5L3BoeXNpY2FsX3BhY2thZ2VfaWQNCj4gPiAwDQo+ID4gLyAjIGNhdCAv
c3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHUyL3RvcG9sb2d5L2NvcmVfc2libGluZ3NfbGlzdA0K
PiA+IDAtNw0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEF0aXNoIFBhdHJhIDxhdGlzaC5wYXRy
YUB3ZGMuY29tPg0KPiA+IC0tLQ0KPiA+ICBody9yaXNjdi92aXJ0LmMgfCAyMSArKysrKysrKysr
KysrKysrKysrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2h3L3Jpc2N2L3ZpcnQuYyBiL2h3L3Jp
c2N2L3ZpcnQuYw0KPiA+IGluZGV4IDg0ZDk0ZDBjNDJkOC4uZGEwYjhhYTE4NzQ3IDEwMDY0NA0K
PiA+IC0tLSBhL2h3L3Jpc2N2L3ZpcnQuYw0KPiA+ICsrKyBiL2h3L3Jpc2N2L3ZpcnQuYw0KPiA+
IEBAIC0yMDMsOSArMjAzLDEyIEBAIHN0YXRpYyB2b2lkICpjcmVhdGVfZmR0KFJJU0NWVmlydFN0
YXRlICpzLA0KPiA+IGNvbnN0IHN0cnVjdCBNZW1tYXBFbnRyeSAqbWVtbWFwLA0KPiA+ICAgICAg
ICAgIHFlbXVfZmR0X3NldHByb3Bfc3RyaW5nKGZkdCwgbm9kZW5hbWUsICJzdGF0dXMiLCAib2th
eSIpOw0KPiA+ICAgICAgICAgIHFlbXVfZmR0X3NldHByb3BfY2VsbChmZHQsIG5vZGVuYW1lLCAi
cmVnIiwgY3B1KTsNCj4gPiAgICAgICAgICBxZW11X2ZkdF9zZXRwcm9wX3N0cmluZyhmZHQsIG5v
ZGVuYW1lLCAiZGV2aWNlX3R5cGUiLA0KPiA+ICJjcHUiKTsNCj4gPiArICAgICAgICBxZW11X2Zk
dF9zZXRwcm9wX2NlbGwoZmR0LCBub2RlbmFtZSwgInBoYW5kbGUiLA0KPiA+IGNwdV9waGFuZGxl
KTsNCj4gPiArICAgICAgICBxZW11X2ZkdF9zZXRwcm9wX2NlbGwoZmR0LCBub2RlbmFtZSwgImxp
bnV4LHBoYW5kbGUiLA0KPiA+IGNwdV9waGFuZGxlKTsNCj4gPiArICAgICAgICBpbnQgaW50Y19w
aGFuZGxlID0gcGhhbmRsZSsrOw0KPiANCj4gRG9uJ3QgZGVjbGFyZSB2YXJpYWJsZXMgaW4gdGhl
IG1pZGRsZSBvZiBjb2RlLiBUaGUgdmFyaWFibGUgbXVzdCBiZQ0KPiBkZWNsYXJlZCBhdCB0aGUg
c3RhcnQgb2YgYSBibG9jay4NCj4gDQpNeSBiYWQuIEZpeGVkIGluIHYyLg0KDQo+IFdpdGggdGhh
dCBmaXhlZDoNCj4gDQo+IFJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5m
cmFuY2lzQHdkYy5jb20+DQo+IA0KPiBBbGlzdGFpcg0KPiANCj4gPiAgICAgICAgICBxZW11X2Zk
dF9hZGRfc3Vibm9kZShmZHQsIGludGMpOw0KPiA+IC0gICAgICAgIHFlbXVfZmR0X3NldHByb3Bf
Y2VsbChmZHQsIGludGMsICJwaGFuZGxlIiwgY3B1X3BoYW5kbGUpOw0KPiA+IC0gICAgICAgIHFl
bXVfZmR0X3NldHByb3BfY2VsbChmZHQsIGludGMsICJsaW51eCxwaGFuZGxlIiwNCj4gPiBjcHVf
cGhhbmRsZSk7DQo+ID4gKyAgICAgICAgcWVtdV9mZHRfc2V0cHJvcF9jZWxsKGZkdCwgaW50Yywg
InBoYW5kbGUiLCBpbnRjX3BoYW5kbGUpOw0KPiA+ICsgICAgICAgIHFlbXVfZmR0X3NldHByb3Bf
Y2VsbChmZHQsIGludGMsICJsaW51eCxwaGFuZGxlIiwNCj4gPiBpbnRjX3BoYW5kbGUpOw0KPiA+
ICAgICAgICAgIHFlbXVfZmR0X3NldHByb3Bfc3RyaW5nKGZkdCwgaW50YywgImNvbXBhdGlibGUi
LA0KPiA+ICJyaXNjdixjcHUtaW50YyIpOw0KPiA+ICAgICAgICAgIHFlbXVfZmR0X3NldHByb3Ao
ZmR0LCBpbnRjLCAiaW50ZXJydXB0LWNvbnRyb2xsZXIiLCBOVUxMLA0KPiA+IDApOw0KPiA+ICAg
ICAgICAgIHFlbXVfZmR0X3NldHByb3BfY2VsbChmZHQsIGludGMsICIjaW50ZXJydXB0LWNlbGxz
IiwgMSk7DQo+ID4gQEAgLTIxNCw2ICsyMTcsMjAgQEAgc3RhdGljIHZvaWQgKmNyZWF0ZV9mZHQo
UklTQ1ZWaXJ0U3RhdGUgKnMsDQo+ID4gY29uc3Qgc3RydWN0IE1lbW1hcEVudHJ5ICptZW1tYXAs
DQo+ID4gICAgICAgICAgZ19mcmVlKG5vZGVuYW1lKTsNCj4gPiAgICAgIH0NCj4gPiANCj4gPiAr
ICAgIC8qIEFkZCBjcHUtdG9wb2xvZ3kgbm9kZSAqLw0KPiA+ICsgICAgcWVtdV9mZHRfYWRkX3N1
Ym5vZGUoZmR0LCAiL2NwdXMvY3B1LW1hcCIpOw0KPiA+ICsgICAgcWVtdV9mZHRfYWRkX3N1Ym5v
ZGUoZmR0LCAiL2NwdXMvY3B1LW1hcC9jbHVzdGVyMCIpOw0KPiA+ICsgICAgZm9yIChjcHUgPSBz
LT5zb2MubnVtX2hhcnRzIC0gMTsgY3B1ID49IDA7IGNwdS0tKSB7DQo+ID4gKyAgICAgICAgY2hh
ciAqY29yZV9ub2RlbmFtZSA9IGdfc3RyZHVwX3ByaW50ZigiL2NwdXMvY3B1LQ0KPiA+IG1hcC9j
bHVzdGVyMC9jb3JlJWQiLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgY3B1KTsNCj4gPiArICAgICAgICBjaGFyICpjcHVfbm9kZW5hbWUgPSBnX3N0
cmR1cF9wcmludGYoIi9jcHVzL2NwdUAlZCIsIGNwdSk7DQo+ID4gKyAgICAgICAgdWludDMyX3Qg
aW50Y19waGFuZGxlID0gcWVtdV9mZHRfZ2V0X3BoYW5kbGUoZmR0LA0KPiA+IGNwdV9ub2RlbmFt
ZSk7DQo+ID4gKyAgICAgICAgcWVtdV9mZHRfYWRkX3N1Ym5vZGUoZmR0LCBjb3JlX25vZGVuYW1l
KTsNCj4gPiArICAgICAgICBxZW11X2ZkdF9zZXRwcm9wX2NlbGwoZmR0LCBjb3JlX25vZGVuYW1l
LCAiY3B1IiwNCj4gPiBpbnRjX3BoYW5kbGUpOw0KPiA+ICsgICAgICAgIGdfZnJlZShjb3JlX25v
ZGVuYW1lKTsNCj4gPiArICAgICAgICBnX2ZyZWUoY3B1X25vZGVuYW1lKTsNCj4gPiArICAgIH0N
Cj4gPiArDQo+ID4gICAgICBjZWxscyA9ICBnX25ldzAodWludDMyX3QsIHMtPnNvYy5udW1faGFy
dHMgKiA0KTsNCj4gPiAgICAgIGZvciAoY3B1ID0gMDsgY3B1IDwgcy0+c29jLm51bV9oYXJ0czsg
Y3B1KyspIHsNCj4gPiAgICAgICAgICBub2RlbmFtZSA9DQo+ID4gLS0NCj4gPiAyLjIxLjANCj4g
PiANCj4gPiANCi0tIA0KUmVnYXJkcywNCkF0aXNoDQo=

