Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6D4C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 00:57:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1813A20739
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 00:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="cNJhHMDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1813A20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsFRU-00041H-6U
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 20:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jsFQi-00034w-FG; Sun, 05 Jul 2020 20:56:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:30785)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jsFQf-0003qQ-DL; Sun, 05 Jul 2020 20:56:20 -0400
IronPort-SDR: eqJzH2KqzMuULgTNvTFnUrE5P6eGpgXZyM5WKT+bTKenXaHai3SWn0W8h+icEpHxiV0YbvvwrG
 i6LtewfL6sDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="147348987"
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; d="scan'208";a="147348987"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2020 17:56:10 -0700
IronPort-SDR: JoldZK2zp9uXjCrgVX3VhTNnBUnFDNWl+cWT2fq0HR3hdfke7kSd9QkL01lF3UXiBP876QAfVA
 hz0JVWHPYJhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; d="scan'208";a="482537481"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
 by fmsmga006.fm.intel.com with ESMTP; 05 Jul 2020 17:56:10 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 5 Jul 2020 17:56:09 -0700
Received: from orsmsx162.amr.corp.intel.com (10.22.240.85) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 5 Jul 2020 17:56:09 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX162.amr.corp.intel.com (10.22.240.85) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 5 Jul 2020 17:56:09 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 5 Jul 2020 17:56:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJawphIOCWfGu9vMnU+rmOwN+alxmGt4sQQ6Z/ZXE3gARedlcKqJ9A+TRav/9QOP/9e65nDIRRcw91RJ53Vaj1LZxsSAlXm891fwFqyioPwmyW9+hsHH5tX4tY0pHn5UNkeD+KO8Uw4tjHvR9IIa5bBp5Qw0/qTW0U/3fJ/pUIU6FRqbYqKm6F35i+cbMfXEo6Ok7beZ2J0xXm26vFZEix8gu/td8bfoyuLgIUjgQvqiofETgB6MDmxfVAzU/fq1Qy8Q30fSs17FIrTgwUaaidEL+viu9IVrKfMFtVoRX22gwYH6AeZFHXKkHGJwfrH9X5slZ6KRknYMUFquamVDZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYfDzcGtT/0XhcX6+34V2JrVxgq64ZOOjgmfsGrZ0To=;
 b=CvADYxqSLA+Wr6MxJDQR0g318XhsL+Q7+7aFzzfneEYi4BFWr+fdChdeJwmrgOq0YxLSHsyBlr2VIefvVXmCzxb5oHZMIw42eBtYpt8vInVMzXiYUWeFgUAdOApfZ7mg76lPC2d0g2x0zxxajf/3WSwBWY+q6Tq4oftVc78ym67B6IA8mTGxZp6lnpsPm8xiXBqdRwnKLpo0O81rm2IsuKGjHVDu/n81v5Q2dq43pJATuZvT+RN38adBaYTadpD5dAKhemmQR13SptdXjZPP3lw9F2YOWckVyCUqNcaURur3A/w9iMRjWxoW11PP2JHq/pvVFdoVJsD1WpYbkS5i7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYfDzcGtT/0XhcX6+34V2JrVxgq64ZOOjgmfsGrZ0To=;
 b=cNJhHMDqM1LcmpzdN1Q8vLO60u2KR8OtqL3n4Cs2LxHe1GXj/I7IjKHDgQNJKwJNwALlbGUx8nM3p8OwGSh0fm9ZGsTIcOf/U51DtrPB0urJ8k+cgqCY0fGHPo6EodN41ko851Xtu5J8+Wk3ufbJovo8eyPMt5ryGY/ZiaYRdWg=
Received: from DM5PR11MB1833.namprd11.prod.outlook.com (10.175.90.12) by
 DM6PR11MB4754.namprd11.prod.outlook.com (20.180.255.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.20; Mon, 6 Jul 2020 00:56:02 +0000
Received: from DM5PR11MB1833.namprd11.prod.outlook.com
 ([fe80::4ce3:6680:7257:7c74]) by DM5PR11MB1833.namprd11.prod.outlook.com
 ([fe80::4ce3:6680:7257:7c74%6]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 00:56:02 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH 3/3] target/nios2: Use gen_io_start around wrctl
 instruction
Thread-Topic: [PATCH 3/3] target/nios2: Use gen_io_start around wrctl
 instruction
Thread-Index: AQHWTe3BOsAD/7AE8EK8jau5tLLWZaj0qFAAgAUar3A=
Date: Mon, 6 Jul 2020 00:56:02 +0000
Message-ID: <DM5PR11MB18332AAE7B95DD1709B19CC78D690@DM5PR11MB1833.namprd11.prod.outlook.com>
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
x-originating-ip: [192.102.204.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d22856de-6d54-481e-9332-08d821475acb
x-ms-traffictypediagnostic: DM6PR11MB4754:
x-microsoft-antispam-prvs: <DM6PR11MB47544326D73BC1B59E81259E8D690@DM6PR11MB4754.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 04569283F9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AtN5ghLHkbeGXbcCiRFFegJakdV+jzXU/Lnjf3DLR+zeJNtdUAqaf6F1Ej9RpuFSTN80a0jGRRb3ohioKpY4o7ABlK7XbmCg7jlnV/MGcBSa4aKXJ4D5RyWEC/cdR6x+wtkX8OZCPkGM0S+k+isTJtaIhuyvfwibry0zu43QiPphJe1S7YusdgK/A4tfC6ER89SLUh8l3JO4lzGtBTHzm9SZI5Np6651DiY/C9ByvwHaUwVKxxUOOwhEmKinXrQ0bVVfDdku7RZkISunIJg/MNJRm4IFGoVjL1orINZr8A6lNvAmD6Li5FndP4mkBFISCY5AUbLI6ZbPh1nhRkuDdg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1833.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(76116006)(4326008)(186003)(54906003)(86362001)(110136005)(8936002)(8676002)(2906002)(33656002)(55016002)(316002)(9686003)(6506007)(53546011)(26005)(83380400001)(478600001)(71200400001)(52536014)(66446008)(66946007)(5660300002)(66556008)(66476007)(64756008)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: TBguEfn5L8Kv78TJNhWuiVLUmuUEoluNgx0YxqrETqvrCKPjrRAV63XUtYjvIpMCM4WYh//8T54AJ4wwTsqrLhP0GHKuJSYABU8hF6LQ1RnL2iX4amrF7tbQHAk7Utq57eFSE6arLNhza7smfQFUaSC3f6czT77WZ/FVVpJcDDBEnDHjEywTmcG3XMm4g4iG37zfKOFezluBC+bIlw9fHdRC0Y65SvF8jFa9sBlrEvGrikwaIyX4DmxZx7btE4GHc/CV9La4i5wqXqLjUQrViKO7zLbau23PyTCBUTsvkD7GySPvm3elcN2HRWOddCPw18+hNUDLrpeLqp6MFzMH4J7ksEqrtdu27gcCGpqNLUPjSL10rcLhNeYBqOxdqJ0Rt4jIpXEo0lzY2EW+NAtI5ncQgfA9Sj6uk02A0Hva/v6+ModEFYNeb8ahUcQWDPdWCfAk91Xg+iGivycdhaCJJNr3CDOeVmTg51ZlIbW5MH7r38V3lbfRDCXXFEnejln+
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1833.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d22856de-6d54-481e-9332-08d821475acb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2020 00:56:02.1951 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0t8ndxvad7Mu5R6VATXuagY7qWp9s9JwsHh9xpzJX01JPS9oFuTBYiG4NtEi9wF7GWOiHBFCq0pZFhpdO+o6/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4754
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.65; envelope-from=wentong.wu@intel.com;
 helo=mga03.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 20:56:10
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

TWF5YmUgYmVsb3cgcGF0Y2ggd2lsbCByZWR1Y2Ugc29tZSBvdmVyaGVhZCwgYmVjYXVzZSBjdXJy
ZW50bHkgaXQgd2lsbCBleGl0IHRvIG1haW4gbG9vcCB0byBoYW5kbGUgaW50ZXJydXB0IGJ1dCBp
ZiB3aXRoIChlbnYtPnJlZ3NbQ1JfU1RBVFVTXSAmIENSX1NUQVRVU19QSUUpID0gRmFsc2UsIGl0
IGRvZXMgbm90aGluZyBleGNlcHQgc2V0IGVudi0+aXJxX3BlbmRpbmcgYWdhaW4uDQoNCmRpZmYg
LS1naXQgYS9ody9uaW9zMi9jcHVfcGljLmMgYi9ody9uaW9zMi9jcHVfcGljLmMNCmluZGV4IDFj
MTk4OWQ1Li41ZWE3ZTUyYSAxMDA2NDQNCi0tLSBhL2h3L25pb3MyL2NwdV9waWMuYw0KKysrIGIv
aHcvbmlvczIvY3B1X3BpYy5jDQpAQCAtNTQsNyArNTQsOCBAQCBzdGF0aWMgdm9pZCBuaW9zMl9w
aWNfY3B1X2hhbmRsZXIodm9pZCAqb3BhcXVlLCBpbnQgaXJxLCBpbnQgbGV2ZWwpDQoNCiB2b2lk
IG5pb3MyX2NoZWNrX2ludGVycnVwdHMoQ1BVTmlvczJTdGF0ZSAqZW52KQ0KIHsNCi0gICAgaWYg
KGVudi0+aXJxX3BlbmRpbmcpIHsNCisgICAgaWYgKGVudi0+aXJxX3BlbmRpbmcgJiYNCisgICAg
ICAgIChlbnYtPnJlZ3NbQ1JfU1RBVFVTXSAmIENSX1NUQVRVU19QSUUpKSB7DQogICAgICAgICBl
bnYtPmlycV9wZW5kaW5nID0gMDsNCiAgICAgICAgIGNwdV9pbnRlcnJ1cHQoZW52X2NwdShlbnYp
LCBDUFVfSU5URVJSVVBUX0hBUkQpOw0KICAgICB9DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQpGcm9tOiBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9y
Zz4gDQpTZW50OiBGcmlkYXksIEp1bHkgMywgMjAyMCAyOjU0IEFNDQpUbzogV3UsIFdlbnRvbmcg
PHdlbnRvbmcud3VAaW50ZWwuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnDQpDYzogcWVtdS10
cml2aWFsQG5vbmdudS5vcmc7IG1hcmV4QGRlbnguZGU7IGNyd3VsZmZAZ21haWwuY29tOyBwZXRl
ci5tYXlkZWxsQGxpbmFyby5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0ggMy8zXSB0YXJnZXQvbmlv
czI6IFVzZSBnZW5faW9fc3RhcnQgYXJvdW5kIHdyY3RsIGluc3RydWN0aW9uDQoNCk9uIDYvMjkv
MjAgOTowNSBBTSwgV2VudG9uZyBXdSB3cm90ZToNCj4gd3JjdGwgaW5zdHJ1Y3Rpb24gb24gbmlv
czIgdGFyZ2V0IHdpbGwgY2F1c2UgY2hlY2tpbmcgY3B1IGludGVycnVwdCANCj4gYnV0IHRjZ19o
YW5kbGVfaW50ZXJydXB0KCkgd2lsbCBjYWxsIGNwdV9hYm9ydCgpIGlmIHRoZSBDUFUgZ2V0cyBh
biANCj4gaW50ZXJydXB0IHdoaWxlIGl0J3Mgbm90IGluICdjYW4gZG8gSU8nDQo+IHN0YXRlLCBz
byBhZGQgZ2VuX2lvX3N0YXJ0IGFyb3VuZCB3cmN0bCBpbnN0cnVjdGlvbi4gQWxzbyBhdCB0aGUg
c2FtZSANCj4gdGltZSwgZW5kIHRoZSBvbmdpbmcgVEIgd2l0aCBESVNBU19VUERBVEUuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBXZW50b25nIFd1IDx3ZW50b25nLnd1QGludGVsLmNvbT4NCj4gLS0t
DQo+ICB0YXJnZXQvbmlvczIvdHJhbnNsYXRlLmMgfCA1ICsrKysrDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L25pb3MyL3RyYW5z
bGF0ZS5jIGIvdGFyZ2V0L25pb3MyL3RyYW5zbGF0ZS5jIGluZGV4IA0KPiA4M2MxMGViMi4uNTEz
NDdhZGEgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9uaW9zMi90cmFuc2xhdGUuYw0KPiArKysgYi90
YXJnZXQvbmlvczIvdHJhbnNsYXRlLmMNCj4gQEAgLTMyLDYgKzMyLDcgQEANCj4gICNpbmNsdWRl
ICJleGVjL2NwdV9sZHN0LmgiDQo+ICAjaW5jbHVkZSAiZXhlYy90cmFuc2xhdG9yLmgiDQo+ICAj
aW5jbHVkZSAicWVtdS9xZW11LXByaW50LmgiDQo+ICsjaW5jbHVkZSAiZXhlYy9nZW4taWNvdW50
LmgiDQo+ICANCj4gIC8qIGlzX2ptcCBmaWVsZCB2YWx1ZXMgKi8NCj4gICNkZWZpbmUgRElTQVNf
SlVNUCAgICBESVNBU19UQVJHRVRfMCAvKiBvbmx5IHBjIHdhcyBtb2RpZmllZCBkeW5hbWljYWxs
eSAqLw0KPiBAQCAtNTE4LDcgKzUxOSwxMSBAQCBzdGF0aWMgdm9pZCB3cmN0bChEaXNhc0NvbnRl
eHQgKmRjLCB1aW50MzJfdCBjb2RlLCB1aW50MzJfdCBmbGFncykNCj4gICAgICAvKiBJZiBpbnRl
cnJ1cHRzIHdlcmUgZW5hYmxlZCB1c2luZyBXUkNUTCwgdHJpZ2dlciB0aGVtLiAqLyAgI2lmIA0K
PiAhZGVmaW5lZChDT05GSUdfVVNFUl9PTkxZKQ0KPiAgICAgIGlmICgoaW5zdHIuaW1tNSArIENS
X0JBU0UpID09IENSX1NUQVRVUykgew0KPiArICAgICAgICBpZiAodGJfY2ZsYWdzKGRjLT50Yikg
JiBDRl9VU0VfSUNPVU5UKSB7DQo+ICsgICAgICAgICAgICBnZW5faW9fc3RhcnQoKTsNCj4gKyAg
ICAgICAgfQ0KPiAgICAgICAgICBnZW5faGVscGVyX2NoZWNrX2ludGVycnVwdHMoZGMtPmNwdV9l
bnYpOw0KPiArICAgICAgICBkYy0+aXNfam1wID0gRElTQVNfVVBEQVRFOw0KPiAgICAgIH0NCj4g
ICNlbmRpZg0KDQpUaGlzIGlzbid0IHJpZ2h0LiAgTm90IHNvIG11Y2ggdGhlIGdlbl9pb19zdGFy
dCBwb3J0aW9uLCBidXQgdGhlIGVudGlyZSBleGlzdGVuY2Ugb2YgaGVscGVyX2NoZWNrX2ludGVy
cnVwdC4NCg0KVGhlIGNvcnJlY3Qgd2F5IHRvIGFja25vd2xlZGdlIGludGVycnVwdHMgYWZ0ZXIg
Y2hhbmdpbmcgYW4gaW50ZXJydXB0IG1hc2sgYml0IGlzIHRvIGV4aXQgdGhlIFRCIGJhY2sgdG8g
dGhlIGNwdSBtYWluIGxvb3AuDQpXaGljaCB5b3UgYXJlIGRvaW5nIGhlcmUgd2l0aCBESVNBU19V
UERBVEUsIHNvIHRoYXQgcGFydCBpcyBmaW5lLiAgKEFsdGhvdWdoIHlvdSBjb3VsZCBtZXJnZSB0
aGF0IGludG8gdGhlIHN3aXRjaCBzdGF0ZW1lbnQgYWJvdmUuKQ0KDQpMb29raW5nIGF0IG5pb3Nf
cGljX2NwdV9oYW5kbGVyLCB0aGVyZSBhcmUgdHdvIG90aGVyIGJ1Z3M6DQoNCjEpIEdldCByaWQg
b2YgZW52LT5pcnFfcGVuZGluZyBhbmQgdXNlIGNwdV9pbnRlcnJ1cHQvY3B1X3Jlc2V0X2ludGVy
cnVwdCBpbnN0ZWFkLg0KDQoyKSBEbyBub3QgY2hlY2sgZW52LT5yZWdzW0NSX1NUQVRVU10gJiBD
Ul9TVEFUVVNfUElFLiAgVGhhdCB2YXJpYWJsZSBkb2VzIG5vdCBiZWxvbmcgdG8gdGhlIHBpYyBh
bmQgc2hvdWxkIG5vdCBiZSBjaGVja2VkIHRoZXJlLiAgVGhlIGNoZWNrIGJlbG9uZ3MgaW4gbmlv
czJfY3B1X2V4ZWNfaW50ZXJydXB0LCBhbmQgaXMgaW4gZmFjdCBhbHJlYWR5IHRoZXJlLg0KDQoN
CnJ+DQo=

