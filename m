Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCA1C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 02:44:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBF4720672
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 02:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="gz3BvrGz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBF4720672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0c5Q-0008By-5k
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 22:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1k0c4i-0007n2-25
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 22:44:12 -0400
Received: from mga07.intel.com ([134.134.136.100]:1515)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1k0c4e-00020Y-HA
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 22:44:11 -0400
IronPort-SDR: fwsOhY13U5yIIgX7kgDDQpuIboT2bIiNvuhiC1eZ6Uy916dGApJakoTvAvhsoAp3aNqFA3H9Iw
 qqyh1zPmFFRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="215852882"
X-IronPort-AV: E=Sophos;i="5.75,408,1589266800"; d="scan'208";a="215852882"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2020 19:44:02 -0700
IronPort-SDR: s56YSMCqWXF/uYZTBnIuLVVrB39lsuwP7YfYscd3GEQxedv/ALIeeVBtxCZJGcN9fxEGvODbWe
 W5ZSN819ZGHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,408,1589266800"; d="scan'208";a="272496879"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga007.fm.intel.com with ESMTP; 28 Jul 2020 19:44:02 -0700
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 28 Jul 2020 19:44:01 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 28 Jul 2020 19:44:01 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.51) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Tue, 28 Jul 2020 19:44:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdVWVEv86CM65wh7zNpMz4z92BxU3IXZRZ+VG2FBVn3dVn+FLQTGRk6myFEuVK3qATtlcjooKNDFp420e98kGRw4RuBzYawyL19c63Vejonv/VNUWInHeg7dbG6LBYrzIhc9+oU4cJv/500A0GHWtqQ/hlEWp0s89WpsU3P8+H67D99GxQc1wDLkM1k7CLzuuevxH5jyyVFBrTz1lrWYW/2NE7KxXM8ZbmsLjPIHtrk+RcPtEV7LtO8V0B354TLvEHs5ngwvHIqbWyEmkkmTbZjWxXcLljy64k8/kL9LBjzG/SftmmiUWOdAWWqyBhfhBeVnDuCpCb8Nv4imrEX/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQnO2aUvL6rbQ6tcogbesuJqNi1Nrv1XhPLe0s/xdgg=;
 b=cb1z4ZtmVlYW4G9JedgJzXV9Bh3sGNjQXrEK9A6QkA4jmQeChVVNpdZpR4h6pnIb8OL1VJ6+oGJSSU5ip2PbcckTdX3Y/5HLfnpYl1sMUPZSVGXqhbC1Ceo9Vdjg7+Kb89M0nGAlJ03nbX55vFzlga4XLJDltFTeV9WOBVpJj0WDz/0tS0ZqnxKWKVFs1aP7cypJ5G1DCNkgZmJJp9gC+YoV6s5H9PU3Y7JENidGghcC/zNqgeNd2WxBfnZrxER39O3zoXExcCkIX3y0wfDK3TTGPiBnBoln6K+p/GD1LUjavJyNMFJ0fOw/Vuwd6rq2hCAFZxYWLuQk7LUjTksVjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQnO2aUvL6rbQ6tcogbesuJqNi1Nrv1XhPLe0s/xdgg=;
 b=gz3BvrGzc3IWt1w557OlfymSzywu8jH1vYiFITjFs3b2oHLJxqm7k7NM0SQ7PA+1pPynpO2pvSSzhiqvwvNziKkN8jkyjsHc9XSksNV9RIj///ESN8oiWDA9KhOReQBi+drO19KuXIkW3Uc/AzyrkDLQkr2lbKYSL6sUm11L/zk=
Received: from DM6PR11MB4316.namprd11.prod.outlook.com (2603:10b6:5:205::16)
 by DM6PR11MB2555.namprd11.prod.outlook.com (2603:10b6:5:c5::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Wed, 29 Jul
 2020 02:44:00 +0000
Received: from DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::29db:26c0:5600:9a71]) by DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::29db:26c0:5600:9a71%7]) with mapi id 15.20.3239.016; Wed, 29 Jul 2020
 02:44:00 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: RE: qemu icount to run guest SMP code
Thread-Topic: qemu icount to run guest SMP code
Thread-Index: AdZk2xio5SGW7n3vThCQMVLBcVs0iQACPgSAABpn5TA=
Date: Wed, 29 Jul 2020 02:43:59 +0000
Message-ID: <DM6PR11MB4316E09EAF6B27C62C7274298D700@DM6PR11MB4316.namprd11.prod.outlook.com>
References: <MN2PR11MB4318AB4E0101B3D312277D978D730@MN2PR11MB4318.namprd11.prod.outlook.com>
 <CAFEAcA_c68Ern29dzoWLG4nC1SDOrKK-LVwSexxPNeKGF0b+fA@mail.gmail.com>
In-Reply-To: <CAFEAcA_c68Ern29dzoWLG4nC1SDOrKK-LVwSexxPNeKGF0b+fA@mail.gmail.com>
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
x-ms-office365-filtering-correlation-id: 40c287fa-5260-4d45-7c3a-08d833693f69
x-ms-traffictypediagnostic: DM6PR11MB2555:
x-microsoft-antispam-prvs: <DM6PR11MB25554044FC2CF8A67478254F8D700@DM6PR11MB2555.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: utQJUCIQta1aT4ZO+tQ1kiXGgQ8Abf7nAuau3FPYMnaGBDjVyJ/DA/bsD86FsJzZBlS60K83wDDX5UTja9hcNGRX37Afk9/E4YmrM5hZifUY9tW1hvFGq3CFP4yzZz4Up48Kx9pIvR3XueZEk5JvmT0L7VXUdvgq2Nl1yeZHKjH4iwj9X/Ry5kPCuOjpGbTggrkWV67oug8RJl7iawehG9wsh+5gURpF3WB1rzFdY6uwMdT7RTWRyA8vE50sp9kzCp3OLlfTAWorKEzNCwSNbrKCaahrTPchIs3Yj9xG8klec0uUDygLiLy/CiMq9GKlq1Li8cgJMyZqBiIssqWaIw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR11MB4316.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(4326008)(8676002)(9686003)(55016002)(498600001)(2906002)(5660300002)(6916009)(83380400001)(52536014)(64756008)(26005)(6506007)(66446008)(66556008)(66476007)(186003)(71200400001)(86362001)(76116006)(8936002)(33656002)(66946007)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 0u78uZdGXJ3EFjS/4LIxoJsFS0VtiCaNSCGs/GExENUnEaVutXrHvJrr88t0qln6qRxZ4q+pIcBdmW/Z0hArnxqv3qrqHj0SD3cEXo2TyF3Pe/bmzcGQnNWS13wjKKSBfWJlLbdbg+xwMXhne3WNHttfEtfzKp3jUbfDDP3CBL0cWrjtGHqIl0qs6ogNsahK8v427qz0xNqD57uZ43eRd1UiMduPzK+tPQGrZZyrBZH9pRFcRcvrgxnJ40C+UPRukGd0jEKu62WqEoTjnI+/CrvAP+9G1yE6JaDiv6fNfxjcFBlwl2WsYpsH9MlaMlC6EPCimw1IZuOZhs3KaRCBDKedNsEBByw8fvETN3bbdCFeuRA7p1bFL+TNSTlhoVX6Gi5aLJAECZu/GI1DIDiRDaaiMfKSB40jl/aDD3WcE4X+neEQBQ+z8ZZPqUNC10Ab7IVYBItEpreh/EbnyJS+bvytii0DWl+N5fmmqsJNehXF1jSPtYlWCATyvXk89lFI
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4316.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c287fa-5260-4d45-7c3a-08d833693f69
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2020 02:44:00.0336 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2723lrpvqllm6WHnDB8NOLVDEfK9K/I7xSOc6wuWNYuou0LxfnyzfOcQPz692D/Y2Kc9ghW5odYB0f4NvlcKDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2555
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=wentong.wu@intel.com; helo=mga07.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 22:44:02
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQpUaGFua3MgZm9yIHRoZSByZXBseS4NCg0KPiA+IFdlIGFyZSB0cnlpbmcgdG8gcnVuIGd1ZXN0
IFNNUCBjb2RlIHdpdGggcWVtdSBpY291bnQgbW9kZSwgYnV0IGJhc2VkIG9uIG15IGN1cnJlbnQg
dW5kZXJzdGFuZGluZyBJIGRvbuKAmXQgdGhpbmsgd2UgY2FuIGRvIHRoYXQsIGJlY2F1c2Ugd2l0
aCBpY291bnQgZW5hYmxlZCwgdGhlIG11bHRpIGNwdXMgd2lsbCBiZSBzaW11bGF0ZWQgaW4gcm91
bmQtcm9iaW4gd2F5KHRjZyBraWNrIHZjcHUgdGltZXIsIG9yIGN1cnJlbnQgY3B1IGV4aXQgaW4g
b3JkZXIgdG8gaGFuZGxlIGludGVycnVwdCBvciB0aGUgZW5kaW5nIG9mIHRoZSBjdXJyZW50IGV4
ZWN1dGlvbiB0cmFuc2xhdGlvbmJsb2NrKSB3aXRoIHRoZSBzaW5nbGUgdkNQVSB0aHJlYWQsIHNv
IHFlbXUgaXMgbm90IHJ1bm5pbmcgZ3Vlc3QgY29kZSBpbiBwYXJhbGxlbCBhcyByZWFsIGhhcmR3
YXJlIGRvZXMsIGlmIGd1ZXN0IGNvZGUgaGFzIHRoZSBhc3N1bXB0aW9uIGNvcmVzIHJ1biBpbiBw
YXJhbGxlbCBpdCB3aWxsIGNhdXNlIHVuZXhwZWN0ZWQgYmVoYXZpb3IuDQo+DQo+IFRpbWluZyBv
ZiB0aGUgZW11bGF0ZWQgQ1BVcyB3aWxsIGFsd2F5cyB2YXJ5IGZyb20gdGhhdCBvZiByZWFsIGhh
cmR3YXJlIHRvIHNvbWUgZXh0ZW50Lg0KDQpJIHVuZGVyc3RhbmQgdGhhdCwgYnV0IGF0IGxlYXN0
IHdlIGNhbiBnZXQgdGhlIGRldGVybWluaXN0aWMgcmVzdWx0IG9uIGxvYWQgaGVhdmlseSBQQyBm
b3IgZW11bGF0ZWQgc2luZ2xlIGNvcmUgc3lzdGVtIGlmIHdlIGNhbiBhZGp1c3QgdGhlIHNoaWZ0
IHZhbHVlIHRvIHRoZSBsZXZlbCBvZiBoYXJkd2FyZSBmcmVxdWVuY3kuIEFuZCBpdCB3aWxsIG5v
dCB3b3JrIGlmIGljb3VudCBxZW11IG5lZWQgIGNvbW11bmljYXRlIHdpdGggb3RoZXIgcmVhbCBo
YXJkd2FyZSwgZm9yIGV4YW1wbGUgdmlhIFRDUCBwcm90b2NvbC4gDQoNCj4gSW4gZ2VuZXJhbCB5
b3UgY2FuJ3QgZXhwZWN0IFFFTVUncyBzaW11bGF0aW9uIHRvIGJlIGFjY3VyYXRlIHRvIHRoZSBs
ZXZlbCB0aGF0IGl0IHdpbGwgY29ycmVjdGx5IHJ1biBndWVzdCBjb2RlIHRoYXQncyBsb29raW5n
IGNhcmVmdWxseSBhdCB0aGUgbGV2ZWwgb2YgcGFyYWxsZWxpc20gYmV0d2VlbiBtdWx0aXBsZSBj
b3JlcyAod2hldGhlciB1c2luZyAtaWNvdW50IG9yIG5vdC4pDQoNCk5vdCBzdXJlIHdpdGhvdXQg
aWNvdW50KG1heWJlIGl0IHdpbGwgYmUgYWNjdXJhdGUgaWYgb25seSBRRU1VIGlzIHJ1bm5pbmcg
b24gYSBwb3dlcmZ1bCBQQyksIGJ1dCBJIGNhbiB1bmRlcnN0YW5kIGl0J3Mgbm90IGFjY3VyYXRl
IHdpdGggaWNvdW50IGVuYWJsZWQsIHRoZSByZWFzb24gaXMgYXMgeW91IG1lbnRpb25lZCBiZWxv
dywgdGhlcmUgaXMgdGhlIHBvc3NpYmlsaXR5IHRoYXQgd2UgaGF2ZSB0byBzcGluIHRvIHdhaXQg
YW5vdGhlciBjb3JlLCBzbyB0aGUgaWNvdW50IHRpbWVyIHdpbGwgYmUgbm90IGFjY3VyYXRlLg0K
DQo+DQo+IFNNUCBtb2RlIHdpdGggaWNvdW50IChpZSB3aXRob3V0IE1UVENHKSB3aWxsIHJ1biBh
bGwgdkNQVXMgb24gb25lIHRocmVhZCwgYnV0IHNpbmNlIHdlIGFsd2F5cyByb3VuZC1yb2JpbiBi
ZXR3ZWVuIHRoZW0gd2VsbC1iZWhhdmVkIGd1ZXN0IGNvZGUgd2lsbCBtYWtlIGZvcndhcmQgcHJv
Z3Jlc3MgYW5kIHdpbGwgbm90IG5vdGljZSBhbnkgbWFqb3IgZGlmZmVyZW5jZXMgYmV0d2VlbiB0
aGlzIGFuZCByZWFsIHBhcmFsbGVsIGV4ZWN1dGlvbi4gKFNvbWV0aW1lcyBpdCBtaWdodCBzcGlu
IGEgbGl0dGxlIG1vcmUgaWYgaXQgaGFzIGEgYnVzeS1sb29wIHdhaXRpbmcgZm9yIGFub3RoZXIg
Y29yZSwgYnV0IG9ubHkgdW50aWwgdGhlIHJvdW5kLXJvYmluIGtpY2tzIGluIGFuZCBydW5zIHRo
ZSBvdGhlciBjb3JlLikNCg0KWWVzLCBhZ3JlZSB3aXRoICJ3ZWxsLWJlaGF2ZWQgZ3Vlc3QgY29k
ZSB3aWxsIG1ha2UgZm9yd2FyZCBwcm9ncmVzcyIsIA0KDQpwbGVhc2UgY29ycmVjdCBtZSBpZiBh
bnl0aGluZyB3cm9uZy4NCg0KQlINCg==

