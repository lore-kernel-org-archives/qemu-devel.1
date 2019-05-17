Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE22C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 21:36:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 646D92087E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 21:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oqHKjOnk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UsSbynDu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646D92087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54001 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRkXC-0001Ig-Od
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 17:36:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=033a92d29=Alistair.Francis@wdc.com>)
	id 1hRkWK-0000yb-Qe
	for qemu-devel@nongnu.org; Fri, 17 May 2019 17:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=033a92d29=Alistair.Francis@wdc.com>)
	id 1hRkWJ-0006jA-SM
	for qemu-devel@nongnu.org; Fri, 17 May 2019 17:36:04 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:6538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=033a92d29=Alistair.Francis@wdc.com>)
	id 1hRkWH-0006gv-EZ; Fri, 17 May 2019 17:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1558128962; x=1589664962;
	h=from:to:subject:date:message-id:references:in-reply-to:
	content-id:content-transfer-encoding:mime-version;
	bh=JPglmIWi2HF+668Q4cZWf9t4mzHGBbCtvjYss+qbImU=;
	b=oqHKjOnk8ywQSdiKo7cbBoyar7MAzlzLupfYCFytq6Mu7qualDc3sPST
	RgWYM6Tcn9nxmomD57+yG/m36TO80daIwQgmHSGJ6Ak8B+FTWt6G0Dqe9
	x8bO84EipkJTlZlCVEHNhN3dVHgU7+12388qHRjqE1dNYhavBEFkkTCF/
	aPu4gwu20QK0uSW8hhwyXGvEANX3jfzhhSt72rKd+mwJsRyE8NYt0rJXr
	eikDhpwn9w0poaHQtZT+sktlUlWjfSmMZ09O+nx9sqOnIaTeaFRxh8Wjf
	SIXr7hROOppiSYyJy6/yvwFTa5CszObYxXh3hYJbZ42BvTIh43TQDXsJU w==;
X-IronPort-AV: E=Sophos;i="5.60,481,1549900800"; d="scan'208";a="109788430"
Received: from mail-dm3nam03lp2056.outbound.protection.outlook.com (HELO
	NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.56])
	by ob1.hgst.iphmx.com with ESMTP; 18 May 2019 05:35:59 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com; 
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=JPglmIWi2HF+668Q4cZWf9t4mzHGBbCtvjYss+qbImU=;
	b=UsSbynDuh1//86j/SbOpClFUYasCjmUPGLJ/iAdLCHYORXQpZBjWsOAgFm/tKuYnuz7BnfTa4IHY5FUCJy8BBbHsJFX9veHV0quw8WiAylPJUudknKjbw4tsGdBNUpTcMMnCOhpEbkzExZhj2WOfiNlPxkjgOLTugfYHXMuuLVE=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB4983.namprd04.prod.outlook.com (52.135.233.12) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1900.16; Fri, 17 May 2019 21:35:56 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::9583:df9e:7ef5:44b7]) by
	BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::9583:df9e:7ef5:44b7%4]) with mapi id 15.20.1900.010;
	Fri, 17 May 2019 21:35:56 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "bmeng.cn@gmail.com"
	<bmeng.cn@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
	"palmer@sifive.com" <palmer@sifive.com>
Thread-Topic: [PATCH 2/2] riscv: sifive_u: Update the plic hart config to
	support multicore
Thread-Index: AQHVDMhny0/zJwjyAUCXeYLvNSMWsqZv1vYA
Date: Fri, 17 May 2019 21:35:56 +0000
Message-ID: <f0e0ab118a46b81351cfa833c13d0791d203de2d.camel@wdc.com>
References: <1558108285-19571-1-git-send-email-bmeng.cn@gmail.com>
	<1558108285-19571-2-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1558108285-19571-2-git-send-email-bmeng.cn@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ff99028-0821-4ec4-6626-08d6db0fa598
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB4983; 
x-ms-traffictypediagnostic: BYAPR04MB4983:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB49839B324D95FCDF087F799D900B0@BYAPR04MB4983.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(376002)(396003)(39860400002)(136003)(346002)(189003)(199004)(6246003)(86362001)(118296001)(53936002)(81166006)(25786009)(71200400001)(72206003)(8676002)(478600001)(99286004)(11346002)(102836004)(446003)(68736007)(186003)(110136005)(486006)(71190400001)(8936002)(81156014)(2201001)(2616005)(26005)(6506007)(36756003)(76176011)(476003)(66066001)(73956011)(66946007)(66446008)(64756008)(66556008)(66476007)(229853002)(316002)(14444005)(7736002)(76116006)(5660300002)(6512007)(3846002)(6486002)(256004)(6116002)(305945005)(6436002)(2906002)(2501003)(14454004);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4983;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VUWvg0X5TWMNUNHVfO7tRfhoCEdzSHn09C7mT0dd4YXYbW96komEvSiacQ/Wp9MVdVn0jrBOYtZIR0HT6SINf8ndQ7C/csjXUaoKPFF8iGCwf9BBkvvI9AGEf11TmhOVSQZ3F++JJgbI89wh1fyXFoOscFMMEmG0noh5LZQ+HrQLGwCPMEXji+XPy7Ym4gmHTEYMBrJHBX/pI5mbFcHrGR8BkYcHqxlgT5g+NkA+Z3S/bbmDdJoBp1Hyr+KuCouDc+c6e4NsC4+O0TI+g6OQG7ZNGOunzNtP9/iIWfBbbVKVBFk79oiUOh7XUs5agqM8KYuQnjvCn2sixiTuiAh4J6cbS7u3AQijHBmCEQVq8qO1NaeQsC9xtu+5okV3AUMa7h7O1OS4SW5DETGUuOV63VzIbEnSuOnc0ykLgCv8ShM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80A825B71F0B3B42B68BFB9C9EEFC031@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff99028-0821-4ec4-6626-08d6db0fa598
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 21:35:56.7135 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4983
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.153.144
Subject: Re: [Qemu-devel] [PATCH 2/2] riscv: sifive_u: Update the plic hart
 config to support multicore
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
cHJlc2VudCB0aGUgUExJQyBpcyBpbnN0YW50aWF0ZWQgdG8gc3VwcG9ydCBvbmx5IG9uZSBoYXJ0
LCB3aGlsZQ0KPiB0aGUgbWFjaGluZSBhbGxvd3MgYXQgbW9zdCA0IGhhcnRzIHRvIGJlIGNyZWF0
ZWQuIFdoZW4gbW9yZSB0aGFuIDENCj4gaGFydCBpcyBjb25maWd1cmVkLCBQTElDIG5lZWRzIHRv
IGluc3RhbnRpYXRlZCB0byBzdXBwb3J0IG11bHRpY29yZSwNCj4gb3RoZXJ3aXNlIGFuIFNNUCBP
UyBkb2VzIG5vdCB3b3JrLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQmluIE1lbmcgPGJtZW5nLmNu
QGdtYWlsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZy
YW5jaXNAd2RjLmNvbT4NCg0KQWxpc3RhaXINCg0KPiAtLS0NCj4gDQo+ICBody9yaXNjdi9zaWZp
dmVfdS5jIHwgMTYgKysrKysrKysrKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9yaXNjdi9zaWZp
dmVfdS5jIGIvaHcvcmlzY3Yvc2lmaXZlX3UuYw0KPiBpbmRleCBlMjEyMGFjLi5hNDE2ZDVkIDEw
MDY0NA0KPiAtLS0gYS9ody9yaXNjdi9zaWZpdmVfdS5jDQo+ICsrKyBiL2h3L3Jpc2N2L3NpZml2
ZV91LmMNCj4gQEAgLTM0NCw2ICszNDQsOCBAQCBzdGF0aWMgdm9pZA0KPiByaXNjdl9zaWZpdmVf
dV9zb2NfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApDQo+ICAgICAgTWVt
b3J5UmVnaW9uICpzeXN0ZW1fbWVtb3J5ID0gZ2V0X3N5c3RlbV9tZW1vcnkoKTsNCj4gICAgICBN
ZW1vcnlSZWdpb24gKm1hc2tfcm9tID0gZ19uZXcoTWVtb3J5UmVnaW9uLCAxKTsNCj4gICAgICBx
ZW11X2lycSBwbGljX2dwaW9zW1NJRklWRV9VX1BMSUNfTlVNX1NPVVJDRVNdOw0KPiArICAgIGNo
YXIgKnBsaWNfaGFydF9jb25maWc7DQo+ICsgICAgc2l6ZV90IHBsaWNfaGFydF9jb25maWdfbGVu
Ow0KPiAgICAgIGludCBpOw0KPiAgICAgIEVycm9yICplcnIgPSBOVUxMOw0KPiAgICAgIE5JQ0lu
Zm8gKm5kID0gJm5kX3RhYmxlWzBdOw0KPiBAQCAtMzU3LDkgKzM1OSwyMSBAQCBzdGF0aWMgdm9p
ZA0KPiByaXNjdl9zaWZpdmVfdV9zb2NfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAq
KmVycnApDQo+ICAgICAgbWVtb3J5X3JlZ2lvbl9hZGRfc3VicmVnaW9uKHN5c3RlbV9tZW1vcnks
DQo+IG1lbW1hcFtTSUZJVkVfVV9NUk9NXS5iYXNlLA0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBtYXNrX3JvbSk7DQo+ICANCj4gKyAgICAvKiBjcmVhdGUgUExJQyBoYXJ0IHRv
cG9sb2d5IGNvbmZpZ3VyYXRpb24gc3RyaW5nICovDQo+ICsgICAgcGxpY19oYXJ0X2NvbmZpZ19s
ZW4gPSAoc3RybGVuKFNJRklWRV9VX1BMSUNfSEFSVF9DT05GSUcpICsgMSkgKg0KPiBzbXBfY3B1
czsNCj4gKyAgICBwbGljX2hhcnRfY29uZmlnID0gZ19tYWxsb2MwKHBsaWNfaGFydF9jb25maWdf
bGVuKTsNCj4gKyAgICBmb3IgKGkgPSAwOyBpIDwgc21wX2NwdXM7IGkrKykgew0KPiArICAgICAg
ICBpZiAoaSAhPSAwKSB7DQo+ICsgICAgICAgICAgICBzdHJuY2F0KHBsaWNfaGFydF9jb25maWcs
ICIsIiwgcGxpY19oYXJ0X2NvbmZpZ19sZW4pOw0KPiArICAgICAgICB9DQo+ICsgICAgICAgIHN0
cm5jYXQocGxpY19oYXJ0X2NvbmZpZywgU0lGSVZFX1VfUExJQ19IQVJUX0NPTkZJRywNCj4gKyAg
ICAgICAgICAgICAgICBwbGljX2hhcnRfY29uZmlnX2xlbik7DQo+ICsgICAgICAgIHBsaWNfaGFy
dF9jb25maWdfbGVuIC09IChzdHJsZW4oU0lGSVZFX1VfUExJQ19IQVJUX0NPTkZJRykgKw0KPiAx
KTsNCj4gKyAgICB9DQo+ICsNCj4gICAgICAvKiBNTUlPICovDQo+ICAgICAgcy0+cGxpYyA9IHNp
Zml2ZV9wbGljX2NyZWF0ZShtZW1tYXBbU0lGSVZFX1VfUExJQ10uYmFzZSwNCj4gLSAgICAgICAg
KGNoYXIgKilTSUZJVkVfVV9QTElDX0hBUlRfQ09ORklHLA0KPiArICAgICAgICBwbGljX2hhcnRf
Y29uZmlnLA0KPiAgICAgICAgICBTSUZJVkVfVV9QTElDX05VTV9TT1VSQ0VTLA0KPiAgICAgICAg
ICBTSUZJVkVfVV9QTElDX05VTV9QUklPUklUSUVTLA0KPiAgICAgICAgICBTSUZJVkVfVV9QTElD
X1BSSU9SSVRZX0JBU0UsDQo=

