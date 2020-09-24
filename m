Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF36C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 12:48:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C35D020708
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 12:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Yv0hnujt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C35D020708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLQfg-0003AH-C3
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 08:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luwei.kang@intel.com>)
 id 1kLQed-0002WN-0T
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 08:47:19 -0400
Received: from mga03.intel.com ([134.134.136.65]:8294)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luwei.kang@intel.com>)
 id 1kLQeX-0006pb-VV
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 08:47:18 -0400
IronPort-SDR: +0wdOaJCrrxENv4lV5vZNtakypswYJxIw32/FEj6VOiZ7xC//JvlMEBv0/+4CD1hSYrW6sfY/M
 fUP2oobDWdAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="161252726"
X-IronPort-AV: E=Sophos;i="5.77,297,1596524400"; d="scan'208";a="161252726"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2020 05:47:08 -0700
IronPort-SDR: lUgeJjRj1m9jh6fvYogBBEzo6e4OUuh/+WrrTm5n5z6TboYJfNn/818wTRpbITzTDfQotPvOzf
 IME0tiWQp0BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,297,1596524400"; d="scan'208";a="335962385"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
 by fmsmga004.fm.intel.com with ESMTP; 24 Sep 2020 05:47:08 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 24 Sep 2020 05:47:08 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 24 Sep 2020 05:47:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 24 Sep 2020 05:47:07 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.53) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 24 Sep 2020 05:47:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgQy7wIA8cLVTQxl8/WDsxhrK5ZkxMs+a78qBj6UkPYHeOlBXfjcladxcuGNNonSgj+b2/Ut5XglT7lJZyppJrHGduIc8KrcOxHU+7/HhX0i6qMYNwm4RhNk3TricS6xAikSSyOsY/mypfGHspnHZaZsUmvTvi8ZSQiEbmEhtthwczLNpisz4zhEYV1nMSJOYkGoAK1I/W7wegLgDfbaQwz8tfOfC4s27fbb+v4HDMZMgFIR360olxJXKQSMIyZ3AFXLgKIHWX/WtT17+Hqn/nYslVRmlU1W+RJzVwfeh71sFBeeiSFWWcRk0nxdwz1cE01ve4SIWMqlUU6crmFO4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVl/I0NTr83061O4gVTmxWdkLNej7I09X0t/5UC0F3Q=;
 b=HtSgn5JDi81x4Yngk7iuugJX7rCbJvhrCPjTs88Kcr7XHGqLyFvAA5BAPYRuUtVaLkS9tdxFtiqMIzAbRHbo2XtFujKFamAoNrH9nzoVT74Y/TPqYYqpfXfrQO8wfHwrbCItTkhmnyJe/iz8PiU4sWU+DRG3CpGuC+r32y4acKTQqpdpYiZvJOR5B3HWERzO2xspGWs0NNvCMhvwQ7H8DYzyQiIfI9ZSWvEWt3m0feHU/Y9QxxO0Zb+kX87pyQut+wrvuIWh/nDWwKvwTI3UfCa8rHtQfmFJ5EkQZNkEgKCIeJnkdgOGtMtxkv4DlmMnkFb/J4YxGGL/XUs/M/9z7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVl/I0NTr83061O4gVTmxWdkLNej7I09X0t/5UC0F3Q=;
 b=Yv0hnujtGXC5gBFxQwPOov4hXhjz/j4gH9T/m/k6Pb4f9rgkSBwm8rzRv9e6l2o76o3Jz93ivXZiZ/O2OUSy7bCPwY5IoGKQPvXoth4UYIdCYnOBIZuR+axJMewILJo/FMJ9/12I1+YF6XRshlMCY+qTtoAAb4lJL7fQrvtsy4E=
Received: from CY4PR11MB1447.namprd11.prod.outlook.com (2603:10b6:910:10::16)
 by CY4PR11MB2055.namprd11.prod.outlook.com (2603:10b6:903:23::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Thu, 24 Sep
 2020 12:47:04 +0000
Received: from CY4PR11MB1447.namprd11.prod.outlook.com
 ([fe80::e973:a623:3d68:7669]) by CY4PR11MB1447.namprd11.prod.outlook.com
 ([fe80::e973:a623:3d68:7669%4]) with mapi id 15.20.3412.022; Thu, 24 Sep 2020
 12:47:04 +0000
From: "Kang, Luwei" <luwei.kang@intel.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: RE: [PATCH v1 0/3] Remove the limitation of Intel PT CPUID info
Thread-Topic: [PATCH v1 0/3] Remove the limitation of Intel PT CPUID info
Thread-Index: AQHV6xfqjs/57yfCb0eiFZpFzYKOh6hhHEKQgQ8ceoCAA8SvIIAAmwMAgAIsh2CAAMy1AIABdRaA
Date: Thu, 24 Sep 2020 12:47:04 +0000
Message-ID: <CY4PR11MB1447BE049AD2F43295C969D680390@CY4PR11MB1447.namprd11.prod.outlook.com>
References: <1582580312-19864-1-git-send-email-luwei.kang@intel.com>
 <82D7661F83C1A047AF7DC287873BF1E1738B07FF@SHSMSX104.ccr.corp.intel.com>
 <20200918220255.GB57321@habkost.net>
 <CY4PR11MB14473A594C244A5B403ADC26803A0@CY4PR11MB1447.namprd11.prod.outlook.com>
 <20200921165028.GP57321@habkost.net>
 <CY4PR11MB144737577341CF0A5E8BAD1C80380@CY4PR11MB1447.namprd11.prod.outlook.com>
 <20200923141502.GO2044576@habkost.net>
In-Reply-To: <20200923141502.GO2044576@habkost.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09a6ad1e-1e81-428d-11cf-08d86087f062
x-ms-traffictypediagnostic: CY4PR11MB2055:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB2055064DCF29FAA6FEAA1F6180390@CY4PR11MB2055.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cUbAC6xVh4hDI46X9TnV036OZZRvjHBJeptyyp4DGW8Qk64EzIyZe95J4ClmgooeVxDZCVC4ENTE8ysgkLAjXAUD+9DCfTFkrKgeeb/t9PWJ6174zaBGqIrYAiVXh3joua0I5TP7Do61QXf7hrioHbfvfoj+ZXwlvTuGVgVnEp4OzDZ5IM0wvzixOmssEzUQ4jbj5vvW8ACxYAiAuKnZjI5TXZxxMjkucbmgBd/ATspmHaW6NPxGiL2YQ2wq5lZ3ApjceYJiHcI1ryACXlUwH3d97dRvuGVE2CuX7hDkTxFU2Ra8BVBJRM94mu1medgcPNKWRcJkGt8A3Px0H5S7nw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR11MB1447.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(9686003)(66476007)(316002)(7696005)(52536014)(6506007)(5660300002)(4326008)(8676002)(478600001)(54906003)(26005)(64756008)(2906002)(66556008)(71200400001)(66446008)(76116006)(66946007)(6916009)(86362001)(83380400001)(33656002)(55016002)(8936002)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: H1lnz2YtaSR6IWyfrUCXbdI/0TaXzl/ojHn0atpcmORf+q32jGwN8kkhDDUYWYxrcl+N473vsjjRellTI0/biQnDCcsvGBckEetfAF1kJoZEcdLC9hsGM61/KrvsZq415PjvViiuB1YexJdG2yyFNE8+Wmydv0E9niqVCxCGiFDTnr2OX0wzJQbYYxzDQh5kjE+fsAvJ4+AVwLm1FHtKsXQTXSf5YyBlfm4EwWaBKPTvDh199QqgLrbCiBvrZNn5vnWGdcCdq8e2+PX8LkVRn3O/iam74vovhnYuiAWnvSCxbOcQ/fLNnoTDdQboKZn0hvlzg99Qbtu968MZiS8/3uzWqnDiegI/hssYyF6UomVmXgqK0eag66IA75BDYNU/1+lJ81kB5kPm57tGf7Vdbirh49utTBceuXxfRKQ9brYLywqmrw175VfPMsU8ckRfT1/GASoewzHrCv0JrbQeXSsNgxKIVp8kyLi10uaOCwt8XAu4/jqmGwjO9w4OaLil+4617wbyVJHBxHld9t5hO2HkkmHGjFUTRLvMV5eNs7tg0MZs8CnPdyJZA2HF9j+iUN+2L9wfHfEwvqVEvaXAr2cj/fUwr12MS6FlA0vbVPqQhfktLeufb6hP+6jYdQVYUHlnFxlj1wNJExISGCaqOg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1447.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a6ad1e-1e81-428d-11cf-08d86087f062
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2020 12:47:04.1596 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9P8gKwo+8LnZGX1bBL0AIN3ZI7Q560oaSmniFJM2lH0v/lkdHCevT36fR8Gv9hsyx8g5vX7bjFYPQ/44ZFxtRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB2055
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.65; envelope-from=luwei.kang@intel.com;
 helo=mga03.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 08:47:09
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Strong, Beeman" <beeman.strong@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Robert Hoo <robert.hu@linux.intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiA+ID4gPiBIaSBFZHVhcmRvLA0KPiA+ID4gPiAgICAgVGhpcyBwYXRjaCBzZXQgd2lsbCByZW1v
dmUgc29tZSBsaW1pdGF0aW9ucyBvZiBJbnRlbCBQVCBDUFVJRA0KPiBpbmZvcm1hdGlvbi4NCj4g
PiA+ID4gICAgIDEuIFRoZSAiSVAgcGF5bG9hZHMiIGZlYXR1cmUgd2lsbCBkaXNhYmxlIHRoZSBJ
bnRlbCBQVCBpbg0KPiA+ID4gPiBndWVzdHMgYW5kIGl0IHdpbGwgYmUNCj4gPiA+IGNvbWluZyBz
b29uLg0KPiA+ID4gPiAgICAgMi4gVG8gbWFrZSB0aGUgbGl2ZSBtaWdyYXRpb24gc2FmZSwgd2Ug
c2V0IHRoZSBJbnRlbCBQVCBDUFVJRA0KPiA+ID4gPiBhcyBhIGNvbnN0YW50DQo+ID4gPiB2YWx1
ZShJY2VsYWtlIHNlcnZlciBDUFVJRCkuIEl0IHdpbGwgbWFzayBvZmYgdGhlIG5ldyBmZWF0dXJl
IG9mIEludGVsIFBULg0KPiA+ID4NCj4gPiA+IElzbid0IHRoaXMgc2VyaWVzIGRvaW5nIHRoZSBv
cHBvc2l0ZSBvZiAyPyAgSXQgcmVwbGFjZXMgYWxsIGNvbnN0YW50DQo+ID4gPiBDUFVJRCB2YWx1
ZXMgd2l0aCBrdm1fYXJjaF9nZXRfc3VwcG9ydGVkX2NwdWlkKCksIG1ha2luZyB0aGUgZmVhdHVy
ZQ0KPiA+ID4gdW5hdmFpbGFibGUgaW4gbWlncmF0aW9uLXNhZmUgbW9kZS4NCj4gPg0KPiA+IFll
cywgVGhpcyBzZXJpZXMgd2lsbCBleHBvc2UgYWxsIHRoZSBIVyBjYXBhYmlsaXRpZXMgdG8gS1ZN
IGd1ZXN0IGlmDQo+ID4gdGhlIEludGVsIFBUIGlzIHN1cHBvcnRlZCBpbiB0aGUgZ3Vlc3QuDQo+
ID4NCj4gPiA+DQo+ID4gPiBEb2VzIGl0IG1lYW4gdGhlIHBsYW4gaXMgdG8gZHJvcCBpbnRlbC1w
dCBtaWdyYXRpb24gc3VwcG9ydCBlbnRpcmVseT8NCj4gPg0KPiA+IEkgZG9uJ3Qgd2FudCB0byBk
cm9wIGludGVsLXB0IGxpdmUgbWlncmF0aW9uIGZlYXR1cmUuIEFzIGRpc2N1c3NlZA0KPiA+IHdp
dGggeW91IGJlZm9yZSwgdGhlIEludGVsIFBUIGZlYXR1cmUgaW5jbHVkZXMgc29tZSBzdWItZmVh
dHVyZXMgYW5kDQo+ID4gbWF5IGJlIGRpZmZlcmVudCBvbiBlYWNoIEhXIHBsYXRmb3JtLiBFeHBv
c2UgYWxsIHRoZSBjYXBhYmlsaXRpZXMgdG8NCj4gPiB0aGUgZ3Vlc3QgY2FuJ3QgbWFrZSBsaXZl
IG1pZ3JhdGlvbiBzYWZlLiBEbyB5b3UgaGF2ZSBhbnkgbmV3DQo+ID4gcHJvcG9zYWxzPw0KPiAN
Cj4gVG8gc3VwcG9ydCBsaXZlIG1pZ3JhdGlvbiwgd2UgbmVlZCB0aGUgc2V0IG9mIGZlYXR1cmVz
IHNlZW4gYnkgdGhlIGd1ZXN0IGJlDQo+IGRldGVybWluZWQgb25seSBieSB0aGUgaW5wdXQgZ2l2
ZW4gdG8gUUVNVSwgbm90IGhvc3QgY2FwYWJpbGl0aWVzLiAgSXQgY2FuIGJlDQo+IHZpYToNCj4g
KDEpIGV4cGxpY2l0ICItY3B1IC4uLiwrZmVhdCxmZWF0PS4uLiIgZmxhZ3M7DQo+ICgyKSB0aHJv
dWdoIGRhdGEgaW4gdGhlIENQVSBtb2RlbCB0YWJsZTsgb3INCj4gKDMpIGJ5IGhhcmRjb2Rpbmcg
dGhlIHNhbWUgdmFsdWUgZm9yIGFsbCBjb25maWd1cmF0aW9ucy4NCj4gDQo+IFRoZSBjdXJyZW50
IHNvbHV0aW9uIGlzICgzKS4gICgyKSBpcyBwcm9iYWJseSB0aGUgYmVzdCBzb2x1dGlvbiwgd2l0
aCB0aGUNCj4gYXNzdW1wdGlvbiB0aGF0IHRoZSBob3N0IGNhbiBhbHdheXMgZW11bGF0ZSBmZWF0
dXJlcyBmcm9tIGFuIG9sZGVyIENQVSBpbiBhDQo+IG5ld2VyIENQVS4gIElmIHRoZXJlIGFyZSBm
ZWF0dXJlcyB0aGF0IGNhbid0IGJlIGVtdWxhdGVkIGlmIG1pZ3JhdGluZyB0byBhDQo+IG5ld2Vy
IENQVSwgYSBtb3JlIGV4cGxpY2l0IGNvbmZpZ3VyYXRpb24gbWVjaGFuaXNtICgxKSBtaWdodCBi
ZSBiZXR0ZXIsDQo+IGJlY2F1c2Ugbm90IGJlaW5nIGFibGUgdG8gbWlncmF0ZSBhIFZNIHRvIG5l
d2VyIGhhcmR3YXJlIGlzIGluY29udmVuaWVudC4NCj4gDQo+IE5vbmUgb2YgdGhvc2UgYXBwcm9h
Y2hlcyBwcmV2ZW50IHVzIGZyb20gaW1wbGVtZW50aW5nIHBhc3N0aHJvdWdoIG1vZGUNCj4gZm9y
ICItY3B1IGhvc3QiLiAgV291bGRuJ3QgdGhhdCBiZSBwcmVmZXJyZWQgaW5zdGVhZCBvZiByZW1v
dmluZyBzdXBwb3J0IGZvcg0KPiBsaXZlIG1pZ3JhdGlvbj8NCg0KVGhhbmtzIGZvciB0aGUgY29t
bWVudHMgYW5kIHN1Z2dlc3Rpb25zLiBJIHRoaW5rIHRoZSBuZXdlciBDUFUgaW5jbHVkZXMgYWxs
IHRoZSBmZWF0dXJlcyBvZiB0aGUgb2xkZXIgQ1BVLCBidXQgbm8gZG9jdW1lbnQgaGF2ZSBzdWNo
IHN0YXRlbWVudC4gVG8gbWFrZSBzdXJlIGl0IGNhbiB3b3JrIGluIGFsbCB0aGUgY2FzZXMsIHRo
ZSBzb2x1dGlvbiAoMSkgbWlnaHQgYmUgYmV0dGVyLg0KVGhlIEludGVsIFBUIHZpcnR1YWxpemF0
aW9uIGZpcnN0IHN1cHBvcnRlZCBvbiBJY2VsYWtlIGFuZCB3ZSBjYW4gdXNlIHRoaXMgQ1BVSUQg
YXMgYmFzaWMgQ1BVSUQgaW5mb3JtYXRpb24uIEFueSBuZXcgZmVhdHVyZSB3aGljaCBzdXBwb3J0
cyBvbiB0aGUgbmV3ZXIgQ1BVcyBjYW4gYmUgYWRkZWQgYnkgIi1jcHUgLi4uLCtmZWF0LGZlYXQ9
Li4uIi4gV2hhdCBpcyB5b3VyIG9waW5pb24/DQoNClRoYW5rcywNCkx1d2VpIEthbmcNCg==

