Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF80C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 00:31:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2099A20737
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 00:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="bXlok8SA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2099A20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsF2r-0006D6-Bx
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 20:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jsF21-0004pg-PI; Sun, 05 Jul 2020 20:30:49 -0400
Received: from mga02.intel.com ([134.134.136.20]:11995)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jsF1y-0000GA-CA; Sun, 05 Jul 2020 20:30:49 -0400
IronPort-SDR: 5C4DTGqeEROekd+p3Zu7rtytobP26Hs7Yo4PYuX4RuY+pSCohZanvoBFOw7xYAtRMLL1AcCmMG
 I0zQWet57WIA==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="135598197"
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; d="scan'208";a="135598197"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2020 17:30:40 -0700
IronPort-SDR: bo6h3MDbQgFE1xwqz2olkI81hIcI/KWiIHfWTim/uo3coyXPKj7p2aOLiQXmIB/ipTT6KB/kz1
 kgWvmuttojlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; d="scan'208";a="426919901"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by orsmga004.jf.intel.com with ESMTP; 05 Jul 2020 17:30:40 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 5 Jul 2020 17:30:40 -0700
Received: from fmsmsx116.amr.corp.intel.com (10.18.116.20) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 5 Jul 2020 17:30:40 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx116.amr.corp.intel.com (10.18.116.20) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 5 Jul 2020 17:30:40 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.56) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Sun, 5 Jul 2020 17:30:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGErlUKuEs/eeK/lzmhUuAeho2Lg+NrMcI6OfAYVpO0kIuQMDKeghhK5cKegzHx6CONDpeHp/TXgHxeq02czFjHlICtHovgJISIeFvlHYiSPrR6Kz9DKWaLtEiGcEOCa+IhK4GrLY7iZS9kWRUsZ19DrsiDpE3sNAwRKVto6ze8WZfhH/DnS1T++5P9dVM6lNvjbHW1IapKNEy9vqR53EWK807jVAFZMRNmOvBtiSyJL6hiFg6xR5M99IA3XkMJXl0Ym4FPvEyUhIjXERt+kbi1GoXZvwJIEnCh29Pg/FsL3pKZKmuzBDR/LJMDpQiO1nOoFooq2DBGsfPaSUw3yeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaB76Hx4aKPy99647AZ2mg+64tOnAjzegjS3p7F4xUA=;
 b=VeyJTtZHwLkEyTzJ9QSbQ2iqY9A/4bNgfj+tUwjT92JUAaJotjnVvPg8xA2Zb9RrdjDkONUE6d5Vw/pfDJqRO23Z0iSOQcen85Hz7QWq1Rtl+5NhTULnduADMEdC60cvPwi53Q6RK9NGE6LzxnGcYRArFRvmDimGAQ/x37E/9YA8pWnxWyuUGuY+/JzkxVBEckcNmKsEuNlnU+wGsuZVoLjwEfAekIhM4hp42/YcSxcmXi1pvJ5fZZzh4C6HlR684Ouw0V5B1Cg2D2KEQ/HyTFNcPY+DdC4MU7jA3JsC14Sqj6P4JZVIO0VhY53pnWJf4NiErJpeJ/uF+tN90LgqkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaB76Hx4aKPy99647AZ2mg+64tOnAjzegjS3p7F4xUA=;
 b=bXlok8SA5pnrwA9aBeww164VnZ2tDVamGRMq7kLLxUTpa9NZGDzXAvIH8YEa3DV07i+JUATEduQLotVa5LdpcfXGhBRROoTXcS9eIhuMquE46XumFF4D7et1gcwZKQqpqq2Us3PA4PPx7glZo1gclfnH3qhFF1jSg36QFGB+/64=
Received: from DM5PR11MB1833.namprd11.prod.outlook.com (2603:10b6:3:110::12)
 by DM5PR11MB1658.namprd11.prod.outlook.com (2603:10b6:4:8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.28; Mon, 6 Jul 2020 00:30:38 +0000
Received: from DM5PR11MB1833.namprd11.prod.outlook.com
 ([fe80::4ce3:6680:7257:7c74]) by DM5PR11MB1833.namprd11.prod.outlook.com
 ([fe80::4ce3:6680:7257:7c74%6]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 00:30:38 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Trivial
 <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Subject: RE: [PATCH 3/3] target/nios2: Use gen_io_start around wrctl
 instruction
Thread-Topic: [PATCH 3/3] target/nios2: Use gen_io_start around wrctl
 instruction
Thread-Index: AQHWTe3BOsAD/7AE8EK8jau5tLLWZaj5QmYAgAB6hBA=
Date: Mon, 6 Jul 2020 00:30:38 +0000
Message-ID: <DM5PR11MB18335E5565CA35E53998784D8D690@DM5PR11MB1833.namprd11.prod.outlook.com>
References: <20200629160535.3910-1-wentong.wu@intel.com>
 <20200629160535.3910-3-wentong.wu@intel.com>
 <CAFEAcA-1eFyMNkqg-c3dTZv7HjVRUPbwcbZht5HV1mwgzrMcBQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-1eFyMNkqg-c3dTZv7HjVRUPbwcbZht5HV1mwgzrMcBQ@mail.gmail.com>
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
x-ms-office365-filtering-correlation-id: 507d5962-16fd-4e95-1c77-08d82143ce7b
x-ms-traffictypediagnostic: DM5PR11MB1658:
x-microsoft-antispam-prvs: <DM5PR11MB165876E75A2CBCB240E31D7D8D690@DM5PR11MB1658.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 04569283F9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /xiddF0GJMB09zKm7Y/IRxjkcrERdApVF4b7AkB37WvZjeauI+99NITJFTdgUJh5IjJ5filuELwG7SG6B4nUaDBpGYRo0XF6xJE2mHiimEoHsPk1sMfBAfzQ9vx6O2R40d0z0kd/xfcQspUhZqttak9wU4+22K/YkbJ78b1Sf7Utojz1Nn9l4Eoh2TiqAe/D3SZaxwrEoZj11NiN0TZFK2jAKHX9szU6hq67nP7teOF7NsHYe2kUXw1J4/mV43zfzNyzdRoLK0rfAdUMpQS+YniYah3OD878m8auB0vEBDos9NbfZMkcBbdtDpEXuGG9qyZRLjZ0l3Ne0Kr4Ar9oXA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1833.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(55016002)(478600001)(8936002)(186003)(66446008)(64756008)(66556008)(66476007)(66946007)(110136005)(54906003)(316002)(76116006)(5660300002)(83380400001)(4326008)(52536014)(71200400001)(9686003)(33656002)(53546011)(6506007)(26005)(86362001)(7696005)(2906002)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: s3ILv2kkxtarABpj2xFEaMtHc43RmwkJIOh9kA0ucPx9cdevdP5/zXAxFeysJWybzHKFjOvzK2iA3bZ++g916F8qFi3G+Cb5CkW5UKNAJBOHRfdaEsR2MKF9NsRiH2fj4PpCT+NAK7LzJHDIo2Jz2g6EebCJqa/C2j2OUgYlthu8Fd74zlVihW0Gy2n82shMUjM3yMV4TwMFeoWdO3S5eWEu9kPAuxeZ2Dj1OTlyoMPsJgnh43rJSrfw5xCerMeg457e8sVk682ZDXvzLOwsIDT7/ShvwIAM2P0T19dwq1YUeGV+TFIfc81g8xvJzAwWSUU6p4Obbr49i5IcygUgqHpLpJpxD67e2c/9PYXhMVAmu460rvt6ZYlyoAH6SvBmUK3LEmfDOv1QpNRWChxZqxCopec7mXGKJZWqaaTFR+8ZA1up9dDs3FfbBvFZv0khFF2U9BlhCZ4dd0PafIquApVTijxZs/lGqsbV5C2gdIXn8rW8UCnFiLLbH7D6/g+Z
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1833.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 507d5962-16fd-4e95-1c77-08d82143ce7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2020 00:30:38.2615 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UkfSfFqlVkHWnyW/fbEUzHLPGQQi3mFN5OvFr7yUPV6AYQXjP9bA+MCE9JnObNMKSsuHQKHOkt+2fGm21RDm7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1658
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20; envelope-from=wentong.wu@intel.com;
 helo=mga02.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 20:30:41
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhhbmtzLCBJIHRoaW5rIHdlIGNhbiBnZXQgdGhpcyBzZXJpZXMgbWVyZ2VkIGN1cnJlbnRseS4N
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFBldGVyIE1heWRlbGwgPHBldGVy
Lm1heWRlbGxAbGluYXJvLm9yZz4gDQpTZW50OiBNb25kYXksIEp1bHkgNiwgMjAyMCAxOjEwIEFN
DQpUbzogV3UsIFdlbnRvbmcgPHdlbnRvbmcud3VAaW50ZWwuY29tPg0KQ2M6IFFFTVUgRGV2ZWxv
cGVycyA8cWVtdS1kZXZlbEBub25nbnUub3JnPjsgUUVNVSBUcml2aWFsIDxxZW11LXRyaXZpYWxA
bm9uZ251Lm9yZz47IENocmlzIFd1bGZmIDxjcnd1bGZmQGdtYWlsLmNvbT47IE1hcmVrIFZhc3V0
IDxtYXJleEBkZW54LmRlPg0KU3ViamVjdDogUmU6IFtQQVRDSCAzLzNdIHRhcmdldC9uaW9zMjog
VXNlIGdlbl9pb19zdGFydCBhcm91bmQgd3JjdGwgaW5zdHJ1Y3Rpb24NCg0KT24gTW9uLCAyOSBK
dW4gMjAyMCBhdCAwOToxNywgV2VudG9uZyBXdSA8d2VudG9uZy53dUBpbnRlbC5jb20+IHdyb3Rl
Og0KPg0KPiB3cmN0bCBpbnN0cnVjdGlvbiBvbiBuaW9zMiB0YXJnZXQgd2lsbCBjYXVzZSBjaGVj
a2luZyBjcHUgaW50ZXJydXB0IA0KPiBidXQgdGNnX2hhbmRsZV9pbnRlcnJ1cHQoKSB3aWxsIGNh
bGwgY3B1X2Fib3J0KCkgaWYgdGhlIENQVSBnZXRzIGFuIA0KPiBpbnRlcnJ1cHQgd2hpbGUgaXQn
cyBub3QgaW4gJ2NhbiBkbyBJTycNCj4gc3RhdGUsIHNvIGFkZCBnZW5faW9fc3RhcnQgYXJvdW5k
IHdyY3RsIGluc3RydWN0aW9uLiBBbHNvIGF0IHRoZSBzYW1lIA0KPiB0aW1lLCBlbmQgdGhlIG9u
Z2luZyBUQiB3aXRoIERJU0FTX1VQREFURS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogV2VudG9uZyBX
dSA8d2VudG9uZy53dUBpbnRlbC5jb20+DQo+IC0tLQ0KPiAgdGFyZ2V0L25pb3MyL3RyYW5zbGF0
ZS5jIHwgNSArKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPg0KPiBk
aWZmIC0tZ2l0IGEvdGFyZ2V0L25pb3MyL3RyYW5zbGF0ZS5jIGIvdGFyZ2V0L25pb3MyL3RyYW5z
bGF0ZS5jIGluZGV4IA0KPiA4M2MxMGViMi4uNTEzNDdhZGEgMTAwNjQ0DQo+IC0tLSBhL3Rhcmdl
dC9uaW9zMi90cmFuc2xhdGUuYw0KPiArKysgYi90YXJnZXQvbmlvczIvdHJhbnNsYXRlLmMNCj4g
QEAgLTMyLDYgKzMyLDcgQEANCj4gICNpbmNsdWRlICJleGVjL2NwdV9sZHN0LmgiDQo+ICAjaW5j
bHVkZSAiZXhlYy90cmFuc2xhdG9yLmgiDQo+ICAjaW5jbHVkZSAicWVtdS9xZW11LXByaW50Lmgi
DQo+ICsjaW5jbHVkZSAiZXhlYy9nZW4taWNvdW50LmgiDQo+DQo+ICAvKiBpc19qbXAgZmllbGQg
dmFsdWVzICovDQo+ICAjZGVmaW5lIERJU0FTX0pVTVAgICAgRElTQVNfVEFSR0VUXzAgLyogb25s
eSBwYyB3YXMgbW9kaWZpZWQgZHluYW1pY2FsbHkgKi8NCj4gQEAgLTUxOCw3ICs1MTksMTEgQEAg
c3RhdGljIHZvaWQgd3JjdGwoRGlzYXNDb250ZXh0ICpkYywgdWludDMyX3QgY29kZSwgdWludDMy
X3QgZmxhZ3MpDQo+ICAgICAgLyogSWYgaW50ZXJydXB0cyB3ZXJlIGVuYWJsZWQgdXNpbmcgV1JD
VEwsIHRyaWdnZXIgdGhlbS4gKi8gICNpZiANCj4gIWRlZmluZWQoQ09ORklHX1VTRVJfT05MWSkN
Cj4gICAgICBpZiAoKGluc3RyLmltbTUgKyBDUl9CQVNFKSA9PSBDUl9TVEFUVVMpIHsNCj4gKyAg
ICAgICAgaWYgKHRiX2NmbGFncyhkYy0+dGIpICYgQ0ZfVVNFX0lDT1VOVCkgew0KPiArICAgICAg
ICAgICAgZ2VuX2lvX3N0YXJ0KCk7DQo+ICsgICAgICAgIH0NCj4gICAgICAgICAgZ2VuX2hlbHBl
cl9jaGVja19pbnRlcnJ1cHRzKGRjLT5jcHVfZW52KTsNCj4gKyAgICAgICAgZGMtPmlzX2ptcCA9
IERJU0FTX1VQREFURTsNCj4gICAgICB9DQo+ICAjZW5kaWYNCj4gIH0NCg0KUmV2aWV3ZWQtYnk6
IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4NCg0KdGhvdWdoIGFzIFJp
Y2hhcmQgbm90ZXMgaWRlYWxseSB0aGUgaW50ZXJydXB0IGhhbmRsaW5nIGNvZGUgaGVyZSBzaG91
bGQgYmUgcmV3cml0dGVuIGJlY2F1c2UgdGhlIGNoZWNrX2ludGVycnVwdHMgaGVscGVyIGlzIGEg
dmVyeSB3ZWlyZCB3YXkgdG8gaW1wbGVtZW50IHRoaW5ncy4NCg0KdGhhbmtzDQotLSBQTU0NCg==

