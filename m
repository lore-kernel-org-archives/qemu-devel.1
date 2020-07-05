Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73FEC433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 13:24:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8004E2073E
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 13:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="xpd5M9pY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8004E2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js4cm-0005BT-QE
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 09:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1js4bm-0004gM-Ev; Sun, 05 Jul 2020 09:23:02 -0400
Received: from mga07.intel.com ([134.134.136.100]:64174)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1js4bj-0000b7-Dq; Sun, 05 Jul 2020 09:23:02 -0400
IronPort-SDR: rHynL84GqN9K09ARcdc+hUp9lkWIbrwkI61AoA69I6GtnVYT5Yrk5O7mvnYs4TCh5H7RjwRozk
 pQHdUS1Tpqfg==
X-IronPort-AV: E=McAfee;i="6000,8403,9672"; a="212306097"
X-IronPort-AV: E=Sophos;i="5.75,316,1589266800"; d="scan'208";a="212306097"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2020 06:22:51 -0700
IronPort-SDR: jrTryjy3SV/xqPd2ZVy72qkRChJlx/8DF10psIW3s93R755gTlz3RLYbcSt2OA+/u0J/9QATqd
 VpHLrYETMR7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,316,1589266800"; d="scan'208";a="387975947"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by fmsmga001.fm.intel.com with ESMTP; 05 Jul 2020 06:22:51 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 5 Jul 2020 06:22:50 -0700
Received: from fmsmsx161.amr.corp.intel.com (10.18.125.9) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 5 Jul 2020 06:22:50 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX161.amr.corp.intel.com (10.18.125.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 5 Jul 2020 06:22:50 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Sun, 5 Jul 2020 06:22:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvRkzUvcA7fefVnb2IegoyvyzdYQA7sRgxb+zJD3vPtZ0rRcUPRh3FNwL2jgZXRYlh1qYv/3JTO0xuGr3PlAk8l+oGkiLXayJ2asgp0ypBeFYS/99XUOUChl8HtPcbw3Th/G5/f6eKwOStTx9NvVYMDswCWtGD0FZ77lCG5DNNs93z+j747tnaxzjftj+H+sxMJkwFKAAiNC6tsZvDbV1KNPbQSZMECzADJaGZcvFMBg47mvujTqzdGRI2xEqSWt1gKwspPbPQQY1URCnDqOsRecmkSplBh+jjGjVqlvnLjPrejrBUP35l2ZWNyLNIVixv4PRGwsc/RJRzfy1F6LTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AyjrwO2un2IE/mXYiLklZvUkjUHqdxwkIAemL1d4NQ=;
 b=YWsCwTjtB//1enAtFvse5ymy/zcddMa6qvFTDm19YoDjN4+RgUWsxr50ZldGXedIVQPMpPIh7GbJt+e22q04LP4SSGF9btvfk14BmUu0OXnPt0MIuX17eDMQIMPNLrp6m+b/tpR9eP+OpEOTTeB4mB34EXchWOih5C3A4j4NqWCKc1+skyW8cFYkzVP+oxCkzaiQfLMns1TXctob4fjk+BtXDzQ9vwZMMb5RoCxSkJOoVx5yJvuW2jvDUHS99iMYU587QvO6VzRpY7dmK0lfKZm5NsfcoVcwrqDjVhi9wx/ypOnQOjw5rdMBpWF8LJDqXO/ibamoQxrK6nkQRcLslg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AyjrwO2un2IE/mXYiLklZvUkjUHqdxwkIAemL1d4NQ=;
 b=xpd5M9pYCpkWkWRm/Ot9/CT8tiTUpsmVOZ0Jo6U0F8aUeJE2dwO/6URQ9siNj8S4STckPGBYIC2RdGUIQL+OXskwHelOHd2i4e3GvPH3sw+9fAWqRLeaNtzXkhr4mFn7mYnK2q7Zqzmgzi/12QTWfLIvP7Ikv5x48MQDyZFEmLg=
Received: from DM5PR11MB1833.namprd11.prod.outlook.com (2603:10b6:3:110::12)
 by DM6PR11MB4345.namprd11.prod.outlook.com (2603:10b6:5:202::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Sun, 5 Jul
 2020 13:22:48 +0000
Received: from DM5PR11MB1833.namprd11.prod.outlook.com
 ([fe80::4ce3:6680:7257:7c74]) by DM5PR11MB1833.namprd11.prod.outlook.com
 ([fe80::4ce3:6680:7257:7c74%6]) with mapi id 15.20.3153.029; Sun, 5 Jul 2020
 13:22:48 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH 3/3] target/nios2: Use gen_io_start around wrctl
 instruction
Thread-Topic: [PATCH 3/3] target/nios2: Use gen_io_start around wrctl
 instruction
Thread-Index: AQHWTe3BOsAD/7AE8EK8jau5tLLWZaj0qFAAgARZioA=
Date: Sun, 5 Jul 2020 13:22:48 +0000
Message-ID: <DM5PR11MB18336CF01B902AD32C2310C68D680@DM5PR11MB1833.namprd11.prod.outlook.com>
References: <20200629160535.3910-1-wentong.wu@intel.com>
 <20200629160535.3910-3-wentong.wu@intel.com>
 <3260735e-05ab-2d42-f7e4-914ad804f543@linaro.org>
In-Reply-To: <3260735e-05ab-2d42-f7e4-914ad804f543@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a52f560-fb12-456b-0406-08d820e68310
x-ms-traffictypediagnostic: DM6PR11MB4345:
x-microsoft-antispam-prvs: <DM6PR11MB434521AEC8C536859F153AF48D680@DM6PR11MB4345.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 045584D28C
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: splvSlp3WeflRWqmN65chd0rahT051xsyeToITpbldRVGYEnfIBCEcSP/hXn3c4p2rNoJq357nDrXzAdOWm4usCMsPm2tzEuXNh2d73HEc8i4poJ2kHeeK4MmF6IrldAM78hjyuMSfFxQXuaQThZLBe1JDNbm4bA/B3Yr/VojIsQL/uZWW+cvDGcIB5XlNpKynmShHdk7VLHrn0cefD9uLMj15rmDixgxaiZ1RygaKkbmr+s2/v7LG3W3PwzBh/iqcZfDhqAvK9M6D8yG9tKXbJL7vWnzwp268gxFcjWbTKWhHgQPhdOkoE5pQMhKJDgxNo/to+u0h5abTnbY0jJeA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1833.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(54906003)(316002)(110136005)(8936002)(8676002)(9686003)(4326008)(186003)(66946007)(66556008)(53546011)(6506007)(55016002)(7696005)(66446008)(66476007)(64756008)(76116006)(2906002)(26005)(71200400001)(86362001)(52536014)(33656002)(5660300002)(83380400001)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Y+/Et29cqO73RCymPyp0ExoFYZMSRdKTSCTsb67FIBtzCtsXFsi4tqnoT/Eg5vcMnw6sjZD1/MAcAcVdoq4G5Kte4OqOTr4AGU4qH1T1FR4I1UYzuETNtlSq+4nkzz3PZqNDTj7Om+qJPZO7DwX5zcgjUreTeiNaGRWzSXkblJxF9D/yhRKqWfrO+69n43o9isRbtMf9HWVbtk/GuRnwXu/EX2032k4qvjjeSlIrdtvfPuH7nYNkwPjmi5rDIYKz+llvpY/6ffZv7irgawRH+81eJZ8iTPXRm5IsaWFvfP8P44e5gJhREAQ3ecVLzP6IPVAQWDuDvlJh4ZFwD8DBEed7mqmGySHV0AOZsBncSCz7uSt+tTKq8O1TJ+juhbcEjhssEhZJ6uhQNrWFsBATK/vwCqkLSeYYYL7KwYCV94WOF3bp4NXHuD+Bc1PS6eBOZYY6ZKOl+X5g9WHzfYHJsfYx/wtTVbW2J7hEwf7ROhDkhsRIBDEnEGszs7ZLqhSm
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1833.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a52f560-fb12-456b-0406-08d820e68310
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2020 13:22:48.5277 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v3XfW/R7TyROzWdPJidjDuWkJctIS2rMmcVeAa/aDQJo7c74Kf8T5sKHaMr46kGvn0RRd8Ubbdgg4TAr4AdE6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4345
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=wentong.wu@intel.com; helo=mga07.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 09:22:51
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "marex@denx.de" <marex@denx.de>, "crwulff@gmail.com" <crwulff@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Q29ycmVjdCB0aGUgZm9ybWF0DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+IA0KPiBT
ZW50OiBGcmlkYXksIEp1bHkgMywgMjAyMCAyOjU0IEFNDQo+IFRvOiBXdSwgV2VudG9uZyA8d2Vu
dG9uZy53dUBpbnRlbC5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHFlbXUtdHJp
dmlhbEBub25nbnUub3JnOyBtYXJleEBkZW54LmRlOyBjcnd1bGZmQGdtYWlsLmNvbTsgcGV0ZXIu
bWF5ZGVsbEBsaW5hcm8ub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy8zXSB0YXJnZXQvbmlv
czI6IFVzZSBnZW5faW9fc3RhcnQgYXJvdW5kIHdyY3RsIGluc3RydWN0aW9uDQo+IA0KPiBPbiA2
LzI5LzIwIDk6MDUgQU0sIFdlbnRvbmcgV3Ugd3JvdGU6DQo+ID4gd3JjdGwgaW5zdHJ1Y3Rpb24g
b24gbmlvczIgdGFyZ2V0IHdpbGwgY2F1c2UgY2hlY2tpbmcgY3B1IGludGVycnVwdCANCj4gPiBi
dXQgdGNnX2hhbmRsZV9pbnRlcnJ1cHQoKSB3aWxsIGNhbGwgY3B1X2Fib3J0KCkgaWYgdGhlIENQ
VSBnZXRzIGFuIA0KPiA+IGludGVycnVwdCB3aGlsZSBpdCdzIG5vdCBpbiAnY2FuIGRvIElPJw0K
PiA+IHN0YXRlLCBzbyBhZGQgZ2VuX2lvX3N0YXJ0IGFyb3VuZCB3cmN0bCBpbnN0cnVjdGlvbi4g
QWxzbyBhdCB0aGUgc2FtZSANCj4gPiB0aW1lLCBlbmQgdGhlIG9uZ2luZyBUQiB3aXRoIERJU0FT
X1VQREFURS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBXZW50b25nIFd1IDx3ZW50b25nLnd1
QGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgdGFyZ2V0L25pb3MyL3RyYW5zbGF0ZS5jIHwgNSAr
KysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlm
ZiAtLWdpdCBhL3RhcmdldC9uaW9zMi90cmFuc2xhdGUuYyBiL3RhcmdldC9uaW9zMi90cmFuc2xh
dGUuYyBpbmRleCANCj4gPiA4M2MxMGViMi4uNTEzNDdhZGEgMTAwNjQ0DQo+ID4gLS0tIGEvdGFy
Z2V0L25pb3MyL3RyYW5zbGF0ZS5jDQo+ID4gKysrIGIvdGFyZ2V0L25pb3MyL3RyYW5zbGF0ZS5j
DQo+ID4gQEAgLTMyLDYgKzMyLDcgQEANCj4gPiAgI2luY2x1ZGUgImV4ZWMvY3B1X2xkc3QuaCIN
Cj4gPiAgI2luY2x1ZGUgImV4ZWMvdHJhbnNsYXRvci5oIg0KPiA+ICAjaW5jbHVkZSAicWVtdS9x
ZW11LXByaW50LmgiDQo+ID4gKyNpbmNsdWRlICJleGVjL2dlbi1pY291bnQuaCINCj4gPiAgDQo+
ID4gIC8qIGlzX2ptcCBmaWVsZCB2YWx1ZXMgKi8NCj4gPiAgI2RlZmluZSBESVNBU19KVU1QICAg
IERJU0FTX1RBUkdFVF8wIC8qIG9ubHkgcGMgd2FzIG1vZGlmaWVkIGR5bmFtaWNhbGx5ICovDQo+
ID4gQEAgLTUxOCw3ICs1MTksMTEgQEAgc3RhdGljIHZvaWQgd3JjdGwoRGlzYXNDb250ZXh0ICpk
YywgdWludDMyX3QgY29kZSwgdWludDMyX3QgZmxhZ3MpDQo+ID4gICAgICAvKiBJZiBpbnRlcnJ1
cHRzIHdlcmUgZW5hYmxlZCB1c2luZyBXUkNUTCwgdHJpZ2dlciB0aGVtLiAqLyAgI2lmIA0KPiA+
ICFkZWZpbmVkKENPTkZJR19VU0VSX09OTFkpDQo+ID4gICAgICBpZiAoKGluc3RyLmltbTUgKyBD
Ul9CQVNFKSA9PSBDUl9TVEFUVVMpIHsNCj4gPiArICAgICAgICBpZiAodGJfY2ZsYWdzKGRjLT50
YikgJiBDRl9VU0VfSUNPVU5UKSB7DQo+ID4gKyAgICAgICAgICAgIGdlbl9pb19zdGFydCgpOw0K
PiA+ICsgICAgICAgIH0NCj4gPiAgICAgICAgICBnZW5faGVscGVyX2NoZWNrX2ludGVycnVwdHMo
ZGMtPmNwdV9lbnYpOw0KPiA+ICsgICAgICAgIGRjLT5pc19qbXAgPSBESVNBU19VUERBVEU7DQo+
ID4gICAgICB9DQo+ID4gICNlbmRpZg0KPiANCj4gVGhpcyBpc24ndCByaWdodC4gIE5vdCBzbyBt
dWNoIHRoZSBnZW5faW9fc3RhcnQgcG9ydGlvbiwgYnV0IHRoZSBlbnRpcmUgZXhpc3RlbmNlIG9m
IGhlbHBlcl9jaGVja19pbnRlcnJ1cHQuDQo+IA0KPiBUaGUgY29ycmVjdCB3YXkgdG8gYWNrbm93
bGVkZ2UgaW50ZXJydXB0cyBhZnRlciBjaGFuZ2luZyBhbiBpbnRlcnJ1cHQgbWFzayBiaXQgaXMg
dG8gZXhpdCB0aGUgVEIgYmFjayB0byB0aGUgY3B1IG1haW4gbG9vcC4NCj4gV2hpY2ggeW91IGFy
ZSBkb2luZyBoZXJlIHdpdGggRElTQVNfVVBEQVRFLCBzbyB0aGF0IHBhcnQgaXMgZmluZS4gIChB
bHRob3VnaCB5b3UgY291bGQgbWVyZ2UgdGhhdCBpbnRvIHRoZSBzd2l0Y2ggc3RhdGVtZW50IGFi
b3ZlLikNCj4gDQo+IExvb2tpbmcgYXQgbmlvc19waWNfY3B1X2hhbmRsZXIsIHRoZXJlIGFyZSB0
d28gb3RoZXIgYnVnczoNCj4gDQo+IDEpIEdldCByaWQgb2YgZW52LT5pcnFfcGVuZGluZyBhbmQg
dXNlIGNwdV9pbnRlcnJ1cHQvY3B1X3Jlc2V0X2ludGVycnVwdCBpbnN0ZWFkLg0KDQpJTUhPLCB3
ZSBuZWVkIGVudi0+aXJxX3BlbmRpbmcsIGJlY2F1c2UgaWYgKChlbnYtPnJlZ3NbQ1JfU1RBVFVT
XSAmIENSX1NUQVRVU19QSUUpID09IEZhbHNlKSwgaXQgY2FuIGluZGljYXRlIHRoZXJlIGlzIGlu
dGVycnVwdCBwZW5kaW5nLCB3ZSBjYW4gZXhpdCB0byBtYWluIGxvb3AgdG8gaGFuZGxlIHRoZSBp
bnRlcnJ1cHQgYXQgb25jZSBpZiBndWVzdCBjb2RlIGVuYWJsZSBpcnEgbGF0ZXIuDQoNCj4gMikg
RG8gbm90IGNoZWNrIGVudi0+cmVnc1tDUl9TVEFUVVNdICYgQ1JfU1RBVFVTX1BJRS4gIFRoYXQg
dmFyaWFibGUgZG9lcyBub3QgYmVsb25nIHRvIHRoZSBwaWMgYW5kIHNob3VsZCBub3QgYmUgY2hl
Y2tlZCB0aGVyZS4gIFRoZSBjaGVjayBiZWxvbmdzIGluIG5pb3MyX2NwdV9leGVjX2ludGVycnVw
dCwgYW5kIGlzIGluIGZhY3QgYWxyZWFkeSB0aGVyZS4NCg0KQnV0IHRoYXQgd2lsbCBjYXVzZSBz
b21lIGFzc2VydCBoYXBwZW4gaWYgZGV2aWNlIHRyaWdnZXIgaXJxIHdpdGggZW52LT5yZWdzW0NS
X1NUQVRVU10gJiBDUl9TVEFUVVNfUElFID0gRmFsc2UNCg0KQlINCg==

