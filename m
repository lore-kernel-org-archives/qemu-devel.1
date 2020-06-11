Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29DFC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 06:07:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA9AC2075F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 06:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="yoRW6W81"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA9AC2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjGN0-0000dZ-VU
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 02:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jjGLP-0007Pw-2V
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 02:05:43 -0400
Received: from mga18.intel.com ([134.134.136.126]:25248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jjGLM-00045K-MF
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 02:05:42 -0400
IronPort-SDR: WRS7J9tJaZUuu7XL/brsGVyQoEu4g1yX7QlFcHW7lBM/4X+zO6tKBr0BFxuaMv4tUpjlXSTrF5
 EF0VsKgdIOsA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2020 23:05:35 -0700
IronPort-SDR: QhdRM/gWMTOgkS6QLLo36Vxs88EWowipM4LftJTtRdE4mUiAUlOH2l5rl3XUPvUXC01RZBRWnx
 n+gb6jMoUV/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,498,1583222400"; d="scan'208";a="473687364"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
 by fmsmga005.fm.intel.com with ESMTP; 10 Jun 2020 23:05:35 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 10 Jun 2020 23:05:35 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 10 Jun 2020 23:05:34 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 10 Jun 2020 23:05:34 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.57) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 10 Jun 2020 23:05:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABVSzoPq6x1UsiU4MZD4CKKnHqEM+3nlTlTNK4R+OJ6QPLXV3FxxMKUoL7+B6oxlS++CGy0JDTIhG/NwtwcKJ0MRYgkb7s7yauY5nIr+SMgPSsQ1XG6a5M1re9lY4zYS0gf/ihfHd3cVU03QjseixMmXLJPE3D8aEcC89Tekr5HYAWvemM4nZNhPQtRRA4uBaWjdTvODz8IJi5wSCx/rIVe2NITza+zSNKkVMloa5qxKfnDztZly6QuSwpkWZokZWhxhXsdh0ERyoMbhDptGa8dRnGpleOXgb+sZgSDfcy7m8DunUvfklwYK8Q3Lj+YzTYnq3Waxp30FFPi1lauIeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1DEYatiZLqjjAfyk144mDSGirtYZ7JKVwITluRcMjQ=;
 b=h6Xt8zwPbuMTL4gUYjqztSkf1SCrsqnpH47pVhizinn1YMUXQoaRSiNzUVmLFJrvvvHGgRZhPo1sJb15jjWSfsCZb+P8IGmZZTM6I7IcPs0MKIUnUUd6Lsi2N3sbE6s2phWNufW+R8pjrzcNT2AXNjswt/JA0nHeymjURmNpfE3l47gubCVHhbzyyHALWNFf+HQvNgjVzsdQ2agMIa5A1d6iXJbrMPCv7Nft7swa3OoAW+CoZYPl7TZx+CmLEXITuf1iNUmnsMEP6j38BKKzfTGhLW0DOGmwNl4raD8ZDUzZTWSyIRot543KSlY+ijeZUCgDxccQ361X9mlFd8RY6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1DEYatiZLqjjAfyk144mDSGirtYZ7JKVwITluRcMjQ=;
 b=yoRW6W81Nd2QChq0a7bci9gzESOj7oXSpnP8xDar5Rwhj+tnrMaAhB0rkWWe6Wt+tkg0lT4Xdn/qBjyizckv1kgnSzbufDa/Ts9WRaVChTfxOwdGmz96QlzqlhFfKybWFMDFEuYJHcJbVW2f0ySyy4H95c1bd/DKiyCgWsuvujs=
Received: from DM5PR11MB1833.namprd11.prod.outlook.com (2603:10b6:3:110::12)
 by DM5PR11MB1596.namprd11.prod.outlook.com (2603:10b6:4:b::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.21; Thu, 11 Jun 2020 06:05:28 +0000
Received: from DM5PR11MB1833.namprd11.prod.outlook.com
 ([fe80::3c09:1393:f7b8:1f51]) by DM5PR11MB1833.namprd11.prod.outlook.com
 ([fe80::3c09:1393:f7b8:1f51%9]) with mapi id 15.20.3088.021; Thu, 11 Jun 2020
 06:05:28 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC] hw: nios2: update interrupt_request when STATUS_PIE disabled
Thread-Topic: [RFC] hw: nios2: update interrupt_request when STATUS_PIE
 disabled
Thread-Index: AdY6/PXgVuA0d+URRVuwGSXTrmqxegACu/oAAMwzU9AAPJtGgAAiuGZw
Date: Thu, 11 Jun 2020 06:05:28 +0000
Message-ID: <DM5PR11MB18337D2B4EEDB4F7BEFCA4C28D800@DM5PR11MB1833.namprd11.prod.outlook.com>
References: <DM5PR11MB18339389B4BD1BB2B4B5AB7A8D860@DM5PR11MB1833.namprd11.prod.outlook.com>
 <e816a581-2bca-a1d3-a5d3-512200298623@redhat.com>
 <DM5PR11MB18332BBC3495C9D9DDC3D4218D820@DM5PR11MB1833.namprd11.prod.outlook.com>
 <f464a208-8403-3f4e-7239-5b9c8299d24d@redhat.com>
In-Reply-To: <f464a208-8403-3f4e-7239-5b9c8299d24d@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.52.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16d7235d-389a-4650-1adc-08d80dcd70d7
x-ms-traffictypediagnostic: DM5PR11MB1596:
x-microsoft-antispam-prvs: <DM5PR11MB1596C9550342862744AD1CC28D800@DM5PR11MB1596.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0431F981D8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OdWDwF+cHEAErS1NRV6RTLYMNundgatW82vNmu3v007l43vWYy268QNMs3Wh9YrP2B+Ty50c7KrRLA+qo93qoPwXs2wuo9WJkoBsJ+1UeHBNUPFNkRoBmUm+aqfn2fX13G2t5s5d+vpHQCzgphyd5Lk7JM82HK1flwaajJqX9B3hCvedSZdsNAunmsoYZ7JpUQpKRKVfASbP5/qN1H+H8Y7FMb/4mHEZCppkZcqTMM4Ox4JIryz6G01SGC/vy4GV/Mrqg33iTkCtUhK6vHSCs+tofGV4mXrnk8MkyeNAI6lVLxvdpJTpD2yqYknxDM9EeRrYokbcDXs3jv53ET82eoIRcFaMypxyy+cU5ISDFf4I2WLMc9OFBzwZdzsON/T5nCqtsiVobXflK5XX+GXMqg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1833.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(376002)(396003)(39860400002)(366004)(136003)(478600001)(966005)(26005)(66476007)(66446008)(8676002)(76116006)(9686003)(66946007)(64756008)(186003)(66556008)(52536014)(71200400001)(2906002)(53546011)(5660300002)(15650500001)(6506007)(7696005)(8936002)(110136005)(33656002)(55016002)(4326008)(54906003)(316002)(86362001)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: YN8VwfAeaMHuU2tlz2NGZYDWJCHXMJl+UxZFhDgcx0rVTlcaKQLRi4sUJEJFMoFRXCs/Y4mCRfiUrfR6o7LPDTWnk3hmXRhZKIwI9+GsqD41YQvYvS1Zy9M5aQNdxRQTl3RMw5KJqo9mGjW+J+CrXe3D0vLIC42AiTax6DP6sUXec7Y5QFACVWrSEGyzmOe+/RuZ8X19bICjO9K+ZFTc0DDhlZ07hhBV8gLMAA8fhoezU3pmH552RaQOapXaLEj7KrHM2X+O8uPuKFUQ2jRz49FGNUwv24uuvfeCyVYTc/tiTYSawxqJRdmCDl2prCIyZNxqVgi0Odx9zg6TpN+nTCnxQm24wdbZqTSRIo/jy63ogFvPkHgzInifXv41uMEgLR1DQY3JWprO5YjrARREk/O6fWP8cCOIMRTlokhAtw2wGsy6LIMMZUSjqSiUHRKtQPBFnkEnJSQQhf5/pcFpYuyZ7Xya3oZqTP9VRWGp99U=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d7235d-389a-4650-1adc-08d80dcd70d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2020 06:05:28.4917 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jmFoEos2F7QcoK1Onpao6BMB1gZ4qt88n712SF+4DQtKEby4sofv94VTwW1RM19CEEUnl+gdR0kric4CSWHhRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1596
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=wentong.wu@intel.com; helo=mga18.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 02:05:36
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
Cc: Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SEkgVGhvbWFzLA0KVGhhbmtzIGZvciB0aGUgaGVscCwgSSB1cGRhdGVkIHRoZSBwYXRjaCBpbiB0
aGUgbmV3IHRocmVhZCBodHRwczovL2xpc3RzLmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2
ZWwvMjAyMC0wNi9tc2cwMzEwMy5odG1sLCBob3BpbmcgdGhhdCBmb2xsb3dzIFFFTVUncyB3b3Jr
aW5nIHN0eWxlLCBUaGFua3MgYWdhaW4uDQoNCkJSLA0KV2VudG9uZw0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IFRob21hcyBIdXRoIDx0aHV0aEByZWRoYXQuY29tPiANClNlbnQ6
IFdlZG5lc2RheSwgSnVuZSAxMCwgMjAyMCA5OjI5IFBNDQpUbzogV3UsIFdlbnRvbmcgPHdlbnRv
bmcud3VAaW50ZWwuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnDQpDYzogQ2hyaXMgV3VsZmYg
PGNyd3VsZmZAZ21haWwuY29tPjsgTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+DQpTdWJqZWN0
OiBSZTogW1JGQ10gaHc6IG5pb3MyOiB1cGRhdGUgaW50ZXJydXB0X3JlcXVlc3Qgd2hlbiBTVEFU
VVNfUElFIGRpc2FibGVkDQoNCk9uIDA5LzA2LzIwMjAgMTAuMzksIFd1LCBXZW50b25nIHdyb3Rl
Og0KPiBIaSBAVGhvbWFzIEh1dGgsDQo+IEl0J3MgbXkgZmlyc3QgdGltZSB0byBzZW5kIHBhdGNo
IGluIHFlbXUgY29tbXVuaXR5LCBub3Qgc3VyZSBpZiB0aGVyZSBpcyBzb21ldGhpbmcgd3Jvbmcg
c2VuZGluZyBwYXRjaCBsaWtlIGJlbG93IGFuZCBJJ20gaGFwcHkgdG8gcmVjZWl2ZSBhbnkgc3Vn
Z2VzdGlvbnMuIEFuZCBieSB0aGUgd2F5LCBjb3VsZCB5b3UgcGxlYXNlIGhlbHAgcmV2aWV3IHRo
ZSBwYXRjaD8gDQoNCiBIaSwNCg0KaXQgd291bGQgYmUgZ29vZCBpZiB5b3UgY291bGQgc2VuZCB0
aGUgcGF0Y2ggYXMgcGxhaW4gdGV4dCBlLW1haWwsIG5vdCBhcyBIVE1MIG1haWwsIG90aGVyd2lz
ZSBpdCdzIGltcG9zc2libGUgdG8gYXBwbHkgaXQgd2l0aCAiZ2l0IGFtIiBvciAicGF0Y2giLiBJ
ZiB5b3UgY2FuLCB0cnkgdG8gdXNlICJnaXQgc2VuZC1lbWFpbCIgdG8gc2VuZCBvdXQgcGF0Y2hl
cy4NCkFsc28gc2VlIGh0dHBzOi8vd2lraS5xZW11Lm9yZy9Db250cmlidXRlL1N1Ym1pdEFQYXRj
aCBmb3Igc29tZSBtb3JlIGRldGFpbHMuDQoNClRlY2huaWNhbGx5LCBJIGRvbid0IGhhdmUgYSBj
bHVlIGFib3V0IG5pb3MyLCBzbyBzb3JyeSwgSSBjYW4ndCBoZWxwIHJldmlld2luZyBpdC4gQnV0
IGl0J3MgYSB2ZXJ5IHNtYWxsIHBhdGNoLCBzbyBtYXliZSBzZW5kIHRoZSBwbGFpbi10ZXh0IG1h
aWwgd2l0aCBDQzogdG8gcWVtdS10cml2aWFsQG5vbmdudS5vcmcgLSBpZiBDaHJpcyBvciBNYXJl
ayBwcm92aWRlIGFuIFJldmlld2VkLWJ5IG9yIEFja2VkLWJ5IHRoZW4sIGl0IHNob3VsZCBnZXQg
bWVyZ2VkIHdpdGggdGhlIG5leHQgdHJpdmlhbCBwdWxsIHJlcXVlc3QuDQoNCiBIVEgsDQogIFRo
b21hcw0KDQoNCj4gVGhhbmtzDQo+IA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBG
cm9tOiBUaG9tYXMgSHV0aCA8dGh1dGhAcmVkaGF0LmNvbT4NCj4gU2VudDogRnJpZGF5LCBKdW5l
IDUsIDIwMjAgMzowNyBQTQ0KPiBUbzogV3UsIFdlbnRvbmcgPHdlbnRvbmcud3VAaW50ZWwuY29t
PjsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBDaHJpcyBXdWxmZiA8Y3J3dWxmZkBnbWFp
bC5jb20+OyBNYXJlayBWYXN1dCA8bWFyZXhAZGVueC5kZT4NCj4gU3ViamVjdDogUmU6IFtSRkNd
IGh3OiBuaW9zMjogdXBkYXRlIGludGVycnVwdF9yZXF1ZXN0IHdoZW4gU1RBVFVTX1BJRSANCj4g
ZGlzYWJsZWQNCj4gDQo+IE9uIDA1LzA2LzIwMjAgMDcuNTksIFd1LCBXZW50b25nIHdyb3RlOg0K
Pj4gSGkgYWxsLA0KPj4NCj4+IEnigJltIHJ1bm5pbmcgaWNvdW50IG1vZGUgb24gcWVtdV9uaW9z
MiB3aXRoIGN1c3RvbWl6ZWQgwqANCj4+IHBsYXRmb3JtKGFsbW9zdCBzYW1lIHdpdGggMTBtNTBf
ZGV2Ym9hcmQpLA0KPj4NCj4+IGJ1dCBjcHUgYWJvcnQgaGFwcGVuZWQocWVtdTogZmF0YWw6IFJh
aXNlZCBpbnRlcnJ1cHQgd2hpbGUgbm90IGluIEkvTw0KPj4gZnVuY3Rpb24pIHdoZW4gZ3Vlc3Qg
Y29kZSBjaGFuZ2VzDQo+Pg0KPj4gc3RhdGUgcmVnaXN0ZXIgd2l0aCB3cmN0bCBpbnN0cnVjdGlv
biwgYWRkIHNvbWUgZGVidWcgY29kZSBmaW5kaW5nIA0KPj4gdGhhdCBpdOKAmXMgY2F1c2VkIGJ5
IHRoZSBpbnRlcnJ1cHRfcmVxdWVzdA0KPj4NCj4+IG1pc21hdGNoLCBzbyBJIG1hZGUgYSBwYXRj
aCBhcyBiZWxvdywgbm90IHN1cmUgaWYgaXTigJlzIHJpZ2h0LCBob3BlIEkgDQo+PiBjYW4gaGF2
ZSBzb21lIGRpc2N1c3Npb24gd2l0aCBtYWludGFpbmVycw0KPiANCj4gIEhpLA0KPiANCj4gcGxl
YXNlIGhhdmUgYSBsb29rIGF0IHRoZSBNQUlOVEFJTkVSUyBmaWxlIGluIHRoZSBtYWluIGRpcmVj
dG9yeSBvZiB0aGUgc291cmNlcywgeW91IGNhbiBmaW5kIHRoZSBjb3JyZXNwb25kaW5nIG1haW50
YWluZXJzIHRoZXJlLiBUaHVzIGlmIHlvdSBoYXZlIHF1ZXN0aW9ucyByZWxhdGVkIHRvIG5pb3My
LCBwbGVhc2UgbWFrZSBzdXJlIHRvIHB1dCBDaHJpcyBhbmQgTWFyZWsgaW50byBDQzogc28gdGhh
dCB5b3VyIHBhdGNoIGdldHMgdGhlIHJpZ2h0IGF0dGVudGlvbiENCj4gDQo+ICBUaGFua3MsDQo+
ICAgVGhvbWFzDQo+IA0KPiANCj4gDQo+PiBjb21taXQgZWZkYjNkYTRlMTQ1YTdhMzRiYThiM2Fi
MWNkY2ZjMzQ2YWUyMGExMSAoSEVBRCAtPiBtYXN0ZXIpDQo+Pg0KPj4gQXV0aG9yOiBXZW50b25n
IFd1IDx3ZW50b25nLnd1QGludGVsLmNvbT4NCj4+DQo+PiBEYXRlOsKgwqAgRnJpIEp1biA1IDA5
OjI5OjQzIDIwMjAgLTA0MDANCj4+DQo+PiDCoA0KPj4NCj4+IMKgwqDCoCBodzogbmlvczI6IHVw
ZGF0ZSBpbnRlcnJ1cHRfcmVxdWVzdCB3aGVuIENSX1NUQVRVU19QSUUgZGlzYWJsZWQNCj4+DQo+
PiDCoA0KPj4NCj4+IMKgwqDCoCBVcGRhdGUgaW50ZXJydXB0X3JlcXVlc3Qgd2hlbiBleHRlcm5h
bCBpbnRlcnVwdCBwZW5kcyBmb3IgDQo+PiBTVEFUVVNfUElFDQo+Pg0KPj4gwqDCoMKgIGRpc2Fi
bGVkLiBPdGhlcndpc2Ugb24gaWNvdW50IGVuYWJsZWQgbmlvczIgdGFyZ2V0IHRoZXJlIHdpbGwg
YmUgDQo+PiBjcHUNCj4+DQo+PiDCoMKgwqAgYWJvcnQgd2hlbiBndWVzdCBjb2RlIGNoYW5nZXMg
c3RhdGUgcmVnaXN0ZXIgd2l0aCB3cmN0bCBpbnN0cnVjdGlvbi4NCj4+DQo+PiDCoA0KPj4NCj4+
IMKgwqDCoCBTaWduZWQtb2ZmLWJ5OiBXZW50b25nIFd1IDx3ZW50b25nLnd1QGludGVsLmNvbT4N
Cj4+DQo+PiDCoA0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9uaW9zMi9jcHVfcGljLmMgYi9ody9u
aW9zMi9jcHVfcGljLmMNCj4+DQo+PiBpbmRleCAxYzE5ODlkNS4uYjA0ZGI0ZDcgMTAwNjQ0DQo+
Pg0KPj4gLS0tIGEvaHcvbmlvczIvY3B1X3BpYy5jDQo+Pg0KPj4gKysrIGIvaHcvbmlvczIvY3B1
X3BpYy5jDQo+Pg0KPj4gQEAgLTQyLDcgKzQyLDkgQEAgc3RhdGljIHZvaWQgbmlvczJfcGljX2Nw
dV9oYW5kbGVyKHZvaWQgKm9wYXF1ZSwgaW50IA0KPj4gaXJxLCBpbnQgbGV2ZWwpDQo+Pg0KPj4g
wqDCoMKgwqDCoMKgwqDCoCB9IGVsc2UgaWYgKCFsZXZlbCkgew0KPj4NCj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBlbnYtPmlycV9wZW5kaW5nID0gMDsNCj4+DQo+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgY3B1X3Jlc2V0X2ludGVycnVwdChjcywgdHlwZSk7DQo+Pg0KPj4gLcKgwqDC
oMKgwqDCoMKgIH0NCj4+DQo+PiArwqDCoMKgwqDCoMKgwqAgfSBlbHNlIHsNCj4+DQo+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBjcy0+aW50ZXJydXB0X3JlcXVlc3QgfD0gdHlwZTsNCj4+DQo+
PiArwqDCoMKgwqDCoMKgIH0NCj4+DQo+PiDCoMKgwqDCoCB9IGVsc2Ugew0KPj4NCj4+IMKgwqDC
oMKgwqDCoMKgwqAgaWYgKGxldmVsKSB7DQo+Pg0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGNwdV9pbnRlcnJ1cHQoY3MsIHR5cGUpOw0KPj4NCj4gDQoNCg==

