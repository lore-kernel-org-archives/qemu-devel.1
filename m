Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EEEC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 02:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75A3E207EA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 02:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="SE3u2ymc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A3E207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI15t-0007mL-Gd
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 22:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jin.yu@intel.com>) id 1kI153-0007Lm-ON
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 22:52:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:60632)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jin.yu@intel.com>) id 1kI150-0003FC-Le
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 22:52:29 -0400
IronPort-SDR: 7OETJ0r8oAbxBuUjcb+ZzsrPlmrc398Lg5OwhQMdwymMMGNvXFZx2mwulnkg+mzg1dRtYOgRX3
 kRxsD8outLvA==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="244023137"
X-IronPort-AV: E=Sophos;i="5.76,428,1592895600"; d="scan'208";a="244023137"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2020 19:52:19 -0700
IronPort-SDR: b9Vj2NO72ZKPhO+Srfe85td66WaH5VF19k+Rrxo1IFCWk7Gyq25WEH146bPjVq4cNIEeHgtJOT
 ZCrlmMgIGvkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,428,1592895600"; d="scan'208";a="343332818"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by FMSMGA003.fm.intel.com with ESMTP; 14 Sep 2020 19:52:19 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 14 Sep 2020 19:52:18 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 14 Sep 2020 19:52:18 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 14 Sep 2020 19:52:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrXY9WJLuHSyuGnqrlcPphZjqdflTD3VjH3+2NzVUiP5daB4o4Vtk4T5860tWs5NiPbSCzohobmBw/TMZX2/VPgukUgaiOPT3iJhsooMGEn5cgprFYvptImTCo9Zl1sJvL9qDiCnnCPbPS11uvz7W/tGLk2xMDtDQp1cKLoFd+EKJr2TVUwg/OmCl9/0fvv92T3bM+AWuRnRDQycWpDbWoap0jeQa1aSzJTE/x8eO+gBaV7Jk+yxCJnprgxBidWHqlD1WCYdnCXiY+slh+iksdsLu1bGoj1X2+jMPupm5ySewY/oKJsWISTRSzteqOeHlcTiIN30Y75D3b6ZArX+Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntRpBPklAscf7j8CLHtRlFkpuY6QrxttGIDyz6h5p7Y=;
 b=V79kXQm2VQzRmAhYpM2a0aQ8zgkYz/IABi9jpXcY/+BaS5g0xa2whoZ7xiRn5Oa1uycN7BTCol/qEBlhPbx02SnPO4JpaTvIbEtgAfvXU0ZJQiRCuXwUnnIOcNZbtsBCFLFyN3b5pnnZSJOJsIOaL9bx6C/tT+hcCSlpKzlmFpytlKHByqihNU+PH0BFzZTKItP4IopbuWfMzhYoB/L2k9sp/g/9NQ8gWad8GrnO9cu/Q+eA6DHVEBMvD4D+Q2RKglkmMz2ZGbqYxxfhBe5aNbllIa4N1ghiRK6QUuHzz9YVTJZcVroZuemowgjZTXpkxX3tUGraChOzLwIQnEalMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntRpBPklAscf7j8CLHtRlFkpuY6QrxttGIDyz6h5p7Y=;
 b=SE3u2ymcRITdFxEn1lIIlO21doj9BZfjKsO+8wfhAPWYH2rtIz3gvPjhqPGjCGBGyUs0WMpyua1+uQkiJS6e7ECUw+zuHpho4YyoTTnM+mRgp8ofdmUI+3kr0z5+vxnmaf05Lf9NV7PRv0aGvfzSeiQd9DEUX8CAg74S3kdPghE=
Received: from MN2PR11MB3725.namprd11.prod.outlook.com (2603:10b6:208:f9::23)
 by MN2PR11MB3854.namprd11.prod.outlook.com (2603:10b6:208:f0::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 02:52:17 +0000
Received: from MN2PR11MB3725.namprd11.prod.outlook.com
 ([fe80::e830:5836:737:efd1]) by MN2PR11MB3725.namprd11.prod.outlook.com
 ([fe80::e830:5836:737:efd1%7]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 02:52:17 +0000
From: "Yu, Jin" <jin.yu@intel.com>
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: RE: [PATCH] vhost-blk: set features before setting inflight feature
Thread-Topic: [PATCH] vhost-blk: set features before setting inflight feature
Thread-Index: AQHWhzmxu3AuAYfiT0CbojVZUvZTNalo762AgAAUMxA=
Date: Tue, 15 Sep 2020 02:52:16 +0000
Message-ID: <MN2PR11MB372522EE6FFC2CD0ECF2ADE680200@MN2PR11MB3725.namprd11.prod.outlook.com>
References: <20200910134851.7817-1-jin.yu@intel.com>
 <CAFubqFuBY9-KpxUfb7HorV-q960Ns4EiCLCzq-TRFciDuaUiUQ@mail.gmail.com>
In-Reply-To: <CAFubqFuBY9-KpxUfb7HorV-q960Ns4EiCLCzq-TRFciDuaUiUQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0acfb8b6-9b69-4a22-c550-08d859225b76
x-ms-traffictypediagnostic: MN2PR11MB3854:
x-microsoft-antispam-prvs: <MN2PR11MB385469540594C69685EAC17F80200@MN2PR11MB3854.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:359;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OOKsdbuTQ8DjyBMWaHcbpFt0HefFU5qYtUQzA4p3wJiTmsXad/CVGcSQcw2yfvVKzDBbknzWGB70aI9UH3rC0O/88lnYvyrXl79ANOAWHPSEChgxlc0suW5WVKu6t/AWDmMk2AL5Z2Amo1xNILrDxkSrGQRX9lREVM8/xnCpDlGIUB7d9FddBtwx489PzkxAzJ/Hnq9+iX88J4Mttv45+TehOrv/x5xGwXbi0Zk126iYr8RDVN3sRq1cGlTgxYv8KRSoJaboYnmQaEzvbOX1289S/CbcoaNsPbILXerjekrxCHa8PpjniMmS6PDWDbcmzKnrqlM4j+JwjQKEnqcftA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR11MB3725.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(26005)(53546011)(8676002)(6506007)(8936002)(6916009)(7696005)(83380400001)(33656002)(186003)(478600001)(316002)(76116006)(54906003)(4326008)(66476007)(66446008)(66556008)(52536014)(55016002)(86362001)(2906002)(9686003)(71200400001)(66946007)(64756008)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: o+bemKexv1eTpRYMTcEhRQegYuRDKaT29+XYQM3MZO9jI6gtPs8kg1gmHEcF5Xz7osLD6/6Epye8SoqE2fi9P1EO2RyHhXukm2DMfaxtrtR8k0ZgLxWMCFhYS6y301DWDt32siS9LzDTaCYnJMcJILUSA1JkGWhh46D0XoZMoK7vklFaqytzMbKkhB1h3yH/dQE6mi0bYldVIp9cLOSRTeZhQYXWfPHwaHT1c6YsCP7W/2ZTaW+KkA0yxhmRtoX6coT9Ask7g29J01/7Yb699vivKJPKGelPSk5LrMIs8s5YO/Lf+GTYn4FVPEiWJDKhCLu02R1Xf1xdNkciItIpSzWYUX2Tz+JRc49t9xeUBs5YuRaxF6fHfv28yGIFTST3KJARmKKmimmOSKRXwQmDBocbMtfRJ6WpaydFVKQAxSUfJPOA70Opipl0zytTj6zrl9dCQb0CVgRR370mbvPr5SIBzwZhzrSTJpouWnMGs0Pd3f3LqE/70kGSc7vC6nl15gzzRB4BQhVHjvGJh9eAkM2V3r5wVOdb1jDmr6wO4t6o0xQK+VhMpz0ss7p/ZEtUeFvWTnxiFAuPYtePsBKPi2KyDhdMhKW6P1TBcG+0ZNawo2v4x+fmCmI9EH6qF5wXwLTeEBQNrBc2HVFHzRD9Vw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3725.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0acfb8b6-9b69-4a22-c550-08d859225b76
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 02:52:16.9326 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T+sS0DuRqEFHwOIQpBpUDRWZuHbEz+kaJPJpPM+C6re2fYgpc4NtBMsnmyuUd3IwuGmnZHrX5sPr4UD74x/cog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3854
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.43; envelope-from=jin.yu@intel.com;
 helo=mga05.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 22:52:19
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, Max Reitz <mreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYXBoYWVsIE5vcndpdHogPHJh
cGhhZWwucy5ub3J3aXR6QGdtYWlsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDE1
LCAyMDIwIDk6MjUgQU0NCj4gVG86IFl1LCBKaW4gPGppbi55dUBpbnRlbC5jb20+DQo+IENjOiBN
aWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPjsgUmFwaGFlbCBOb3J3aXR6DQo+IDxy
YXBoYWVsLm5vcndpdHpAbnV0YW5peC5jb20+OyBLZXZpbiBXb2xmIDxrd29sZkByZWRoYXQuY29t
PjsgTWF4DQo+IFJlaXR6IDxtcmVpdHpAcmVkaGF0LmNvbT47IFFFTVUgPHFlbXUtZGV2ZWxAbm9u
Z251Lm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gdmhvc3QtYmxrOiBzZXQgZmVhdHVyZXMg
YmVmb3JlIHNldHRpbmcgaW5mbGlnaHQgZmVhdHVyZQ0KPiANCj4gQmFja2VuZHMgYWxyZWFkeSBy
ZWNlaXZlIHRoZSBmb3JtYXQgaW4gdmhvc3RfZGV2X3N0YXJ0IGJlZm9yZSB0aGUgbWVtb3J5DQo+
IHRhYmxlcyBhcmUgc2V0IG9yIGFueSBvZiB0aGUgdmlydHF1ZXVlcyBhcmUgc3RhcnRlZC4gQ2Fu
IHlvdSBlbGFib3JhdGUgb24gd2h5DQo+IHlvdSBuZWVkIHRvIGtub3cgdGhlIHZpcnRxdWV1ZSBm
b3JtYXQgYmVmb3JlIHNldHRpbmcgdGhlIGluZmxpZ2h0IEZEPw0KPiANCkZpcnN0LCB3aGVuIHRo
ZSBiYWNrZW5kIHJlY2VpdmVzIHRoZSBnZXRfaW5mbGlnaHRfZmQgc2VudCBieSBRRU1VLCBpdCBu
ZWVkcyB0byBhbGxvY2F0ZSB2cSdzIGluZmxpZ2h0IG1lbW9yeSwNCmFuZCBpdCBuZWVkcyB0byBr
bm93IHRoZSBmb3JtYXQgb2YgdnEuDQpTZWNvbmQsIHdoZW4gdGhlIGJhY2tlbmQgcmVjb25uZWN0
cyB0byBRRU1VLCBRRU1VIHNlbmRzIHNldF9pbmZsaWdodF9mZCwgYW5kIHRoZSBiYWNrZW5kIHJl
c3RvcmVzIHRoZSBpbmZsaWdodCBtZW1vcnkgb2YgdnEuIA0KSXQgYWxzbyBuZWVkcyB0byBrbm93
IHRoZSBmb3JtYXQgb2YgdnEuIA0KVGhhbmtzLg0KPiBPbiBUaHUsIFNlcCAxMCwgMjAyMCBhdCAy
OjE1IEFNIEppbiBZdSA8amluLnl1QGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBWaXJ0cXVl
dWUgaGFzIHNwbGl0IGFuZCBwYWNrZWQsIHNvIGJlZm9yZSBzZXR0aW5nIGluZmxpZ2h0LCB5b3Ug
bmVlZA0KPiA+IHRvIGluZm9ybSB0aGUgYmFjay1lbmQgdmlydHF1ZXVlIGZvcm1hdC4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEppbiBZdSA8amluLnl1QGludGVsLmNvbT4NCj4gPiAtLS0NCj4g
PiAgaHcvYmxvY2svdmhvc3QtdXNlci1ibGsuYyB8ICA2ICsrKysrKw0KPiA+ICBody92aXJ0aW8v
dmhvc3QuYyAgICAgICAgIHwgMTggKysrKysrKysrKysrKysrKysrDQo+ID4gIGluY2x1ZGUvaHcv
dmlydGlvL3Zob3N0LmggfCAgMSArDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9u
cygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L2Jsb2NrL3Zob3N0LXVzZXItYmxrLmMgYi9o
dy9ibG9jay92aG9zdC11c2VyLWJsay5jDQo+ID4gaW5kZXggMzlhZWM0MmRhZS4uOWUwZTllYmVj
MCAxMDA2NDQNCj4gPiAtLS0gYS9ody9ibG9jay92aG9zdC11c2VyLWJsay5jDQo+ID4gKysrIGIv
aHcvYmxvY2svdmhvc3QtdXNlci1ibGsuYw0KPiA+IEBAIC0xMzEsNiArMTMxLDEyIEBAIHN0YXRp
YyBpbnQgdmhvc3RfdXNlcl9ibGtfc3RhcnQoVmlydElPRGV2aWNlDQo+ID4gKnZkZXYpDQo+ID4N
Cj4gPiAgICAgIHMtPmRldi5hY2tlZF9mZWF0dXJlcyA9IHZkZXYtPmd1ZXN0X2ZlYXR1cmVzOw0K
PiA+DQo+ID4gKyAgICByZXQgPSB2aG9zdF9kZXZfcHJlcGFyZV9pbmZsaWdodCgmcy0+ZGV2KTsN
Cj4gPiArICAgIGlmIChyZXQgPCAwKSB7DQo+ID4gKyAgICAgICAgZXJyb3JfcmVwb3J0KCJFcnJv
ciBzZXQgaW5mbGlnaHQgZm9ybWF0OiAlZCIsIC1yZXQpOw0KPiA+ICsgICAgICAgIGdvdG8gZXJy
X2d1ZXN0X25vdGlmaWVyczsNCj4gPiArICAgIH0NCj4gPiArDQo+ID4gICAgICBpZiAoIXMtPmlu
ZmxpZ2h0LT5hZGRyKSB7DQo+ID4gICAgICAgICAgcmV0ID0gdmhvc3RfZGV2X2dldF9pbmZsaWdo
dCgmcy0+ZGV2LCBzLT5xdWV1ZV9zaXplLCBzLT5pbmZsaWdodCk7DQo+ID4gICAgICAgICAgaWYg
KHJldCA8IDApIHsNCj4gPiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3Zob3N0LmMgYi9ody92aXJ0
aW8vdmhvc3QuYyBpbmRleA0KPiA+IDFhMTM4NGU3YTYuLjQwMjdjMTE4ODYgMTAwNjQ0DQo+ID4g
LS0tIGEvaHcvdmlydGlvL3Zob3N0LmMNCj4gPiArKysgYi9ody92aXJ0aW8vdmhvc3QuYw0KPiA+
IEBAIC0xNjE2LDYgKzE2MTYsMjQgQEAgaW50IHZob3N0X2Rldl9sb2FkX2luZmxpZ2h0KHN0cnVj
dCB2aG9zdF9pbmZsaWdodA0KPiAqaW5mbGlnaHQsIFFFTVVGaWxlICpmKQ0KPiA+ICAgICAgcmV0
dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+ICtpbnQgdmhvc3RfZGV2X3ByZXBhcmVfaW5mbGlnaHQo
c3RydWN0IHZob3N0X2RldiAqaGRldikgew0KPiA+ICsgICAgaW50IHI7DQo+ID4gKw0KPiA+ICsg
ICAgaWYgKGhkZXYtPnZob3N0X29wcy0+dmhvc3RfZ2V0X2luZmxpZ2h0X2ZkID09IE5VTEwgfHwN
Cj4gPiArICAgICAgICBoZGV2LT52aG9zdF9vcHMtPnZob3N0X3NldF9pbmZsaWdodF9mZCA9PSBO
VUxMKSB7DQo+ID4gKyAgICAgICAgcmV0dXJuIDA7DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICsg
ICAgciA9IHZob3N0X2Rldl9zZXRfZmVhdHVyZXMoaGRldiwgaGRldi0+bG9nX2VuYWJsZWQpOw0K
PiA+ICsgICAgaWYgKHIgPCAwKSB7DQo+ID4gKyAgICAgICAgVkhPU1RfT1BTX0RFQlVHKCJ2aG9z
dF9kZXZfcHJlcGFyZV9pbmZsaWdodCBmYWlsZWQiKTsNCj4gPiArICAgICAgICByZXR1cm4gcjsN
Cj4gPiArICAgIH0NCj4gPiArDQo+ID4gKyAgICByZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4g
PiAgaW50IHZob3N0X2Rldl9zZXRfaW5mbGlnaHQoc3RydWN0IHZob3N0X2RldiAqZGV2LA0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgdmhvc3RfaW5mbGlnaHQgKmluZmxp
Z2h0KSAgeyBkaWZmDQo+ID4gLS1naXQgYS9pbmNsdWRlL2h3L3ZpcnRpby92aG9zdC5oIGIvaW5j
bHVkZS9ody92aXJ0aW8vdmhvc3QuaCBpbmRleA0KPiA+IDc2N2E5NWVjMGIuLjRlMmZjNzU1Mjgg
MTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9ody92aXJ0aW8vdmhvc3QuaA0KPiA+ICsrKyBiL2lu
Y2x1ZGUvaHcvdmlydGlvL3Zob3N0LmgNCj4gPiBAQCAtMTQwLDYgKzE0MCw3IEBAIHZvaWQgdmhv
c3RfZGV2X3Jlc2V0X2luZmxpZ2h0KHN0cnVjdA0KPiA+IHZob3N0X2luZmxpZ2h0ICppbmZsaWdo
dCk7ICB2b2lkIHZob3N0X2Rldl9mcmVlX2luZmxpZ2h0KHN0cnVjdA0KPiA+IHZob3N0X2luZmxp
Z2h0ICppbmZsaWdodCk7ICB2b2lkIHZob3N0X2Rldl9zYXZlX2luZmxpZ2h0KHN0cnVjdA0KPiA+
IHZob3N0X2luZmxpZ2h0ICppbmZsaWdodCwgUUVNVUZpbGUgKmYpOyAgaW50DQo+ID4gdmhvc3Rf
ZGV2X2xvYWRfaW5mbGlnaHQoc3RydWN0IHZob3N0X2luZmxpZ2h0ICppbmZsaWdodCwgUUVNVUZp
bGUgKmYpOw0KPiA+ICtpbnQgdmhvc3RfZGV2X3ByZXBhcmVfaW5mbGlnaHQoc3RydWN0IHZob3N0
X2RldiAqaGRldik7DQo+ID4gIGludCB2aG9zdF9kZXZfc2V0X2luZmxpZ2h0KHN0cnVjdCB2aG9z
dF9kZXYgKmRldiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZob3N0
X2luZmxpZ2h0ICppbmZsaWdodCk7ICBpbnQNCj4gPiB2aG9zdF9kZXZfZ2V0X2luZmxpZ2h0KHN0
cnVjdCB2aG9zdF9kZXYgKmRldiwgdWludDE2X3QgcXVldWVfc2l6ZSwNCj4gPiAtLQ0KPiA+IDIu
MTcuMg0KPiA+DQo+ID4NCg==

