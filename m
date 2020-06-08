Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DD6C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 01:02:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8813C206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 01:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="stfUv0+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8813C206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ji6B4-000369-Nb
	for qemu-devel@archiver.kernel.org; Sun, 07 Jun 2020 21:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1ji6A0-0002dr-Og
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 21:01:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:42246)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1ji69y-00081f-6k
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 21:01:07 -0400
IronPort-SDR: lmIsCSxsFCRyMjVjvEvgmQUzbVYqzJoez5twv6neoxfkrgNu0R8gEsaaU7LDoGRNHu9wZEd/tv
 1tb2uqMVa2Jw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2020 18:00:58 -0700
IronPort-SDR: /Sz6O27Kgx+SOEZZ8UdMGo0oS26k8DXB4ISJbDuH5+HU+RKk4XiQs5h7ajXq2Nwt0cTrfK7J+4
 dDs9TnmlY7uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,486,1583222400"; d="scan'208";a="305664061"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
 by fmsmga002.fm.intel.com with ESMTP; 07 Jun 2020 18:00:57 -0700
Received: from orsmsx124.amr.corp.intel.com (10.22.240.120) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 7 Jun 2020 18:00:53 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX124.amr.corp.intel.com (10.22.240.120) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 7 Jun 2020 18:00:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 7 Jun 2020 18:00:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WILisXZPsSg6SuRID9djd+riH4kkAPnHf6FmJPtDJOmRsBDOYD68WIAzQO4nfL9o6K4B+ewLqluCrId97PQ0TCr+RHhKdvd7rn8Oah6a0QJ7g6bXjha0tPAzq2fHYRfWTbeisdvjyxaKUbnZRORVLybSohLYJ6bEUCys5ywuOTHpPTeJjgwRra3Ca1M6nm0ieUATyn2kJKKfuCY8NPXWRWidRRsOCMZxNf5pKOePBTcbUVqT1ZKMUjXA2vJB5RcK13YQMZ1CGOWrk805xbry6n6qfsu1v7ci57qDzFKLEEZ3NMbKRn0KKR6m9ceeaU468gMhaaPmSAp8ZlsmPRQHow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhp8/XBUBWIMNVF850fKTwBYq9ONHEDzyaPLmhIEo0w=;
 b=SMAie3Ir6DMLkdtysWKJrdmUowdywRADIBwBhHWdUdyJhLVnALoV498LFnPg3YALXKFxiLWAh+rhBToZ0/lMWwPuxBxCWOYYI8ZjC5mEcXRcKl2QSfZbFbhlKSehN0cVa0kqiGsgLYG6eUAXHIscnwVlh1z4V665Hcbai3j2JARSJ2F16Ht5TtEzsWUQLXjwpqG+VP9BnQbdV1RaDj8ZW/ZkZpdMMTZKypusZeyH1t3vd73NsZ7DSq5i70UPlv4B9H0cMXEl8wIEy5WYSnRgWigfVX2X/YUdEFZGBLzxORmlPISAQql3qtI23WKF9Q4ASET4dcMQgkKWfgSGMGcfAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhp8/XBUBWIMNVF850fKTwBYq9ONHEDzyaPLmhIEo0w=;
 b=stfUv0+bLrHwje0WwShlQ3VDn0f+zMTiXV5DompYC9p+McFa9bU/1dmL61WXVRSDt5fH9DOvR2/EEza/80OkUPLpyWYLZ6mb/Jcv9NNbwDCQmVeAbrRe8tDk0ip3tE1woSX6fZ7Bqi8LGjqeREICPvEvKUr/R1MxyZH5sIn19P0=
Received: from DM5PR11MB1833.namprd11.prod.outlook.com (2603:10b6:3:110::12)
 by DM5PR11MB1787.namprd11.prod.outlook.com (2603:10b6:3:112::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Mon, 8 Jun
 2020 01:00:51 +0000
Received: from DM5PR11MB1833.namprd11.prod.outlook.com
 ([fe80::3c09:1393:f7b8:1f51]) by DM5PR11MB1833.namprd11.prod.outlook.com
 ([fe80::3c09:1393:f7b8:1f51%9]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 01:00:50 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Chris Wulff
 <crwulff@gmail.com>, Marek Vasut <marex@denx.de>
Subject: RE: [RFC] hw: nios2: update interrupt_request when STATUS_PIE disabled
Thread-Topic: [RFC] hw: nios2: update interrupt_request when STATUS_PIE
 disabled
Thread-Index: AdY6/PXgVuA0d+URRVuwGSXTrmqxegACu/oAAIn/B3A=
Date: Mon, 8 Jun 2020 01:00:50 +0000
Message-ID: <DM5PR11MB1833868AE79F66D266E26C7F8D850@DM5PR11MB1833.namprd11.prod.outlook.com>
References: <DM5PR11MB18339389B4BD1BB2B4B5AB7A8D860@DM5PR11MB1833.namprd11.prod.outlook.com>
 <e816a581-2bca-a1d3-a5d3-512200298623@redhat.com>
In-Reply-To: <e816a581-2bca-a1d3-a5d3-512200298623@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: crwulff@gmail.com,marex@denx.de
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14dd8c73-887a-48ce-c6d0-08d80b476348
x-ms-traffictypediagnostic: DM5PR11MB1787:
x-microsoft-antispam-prvs: <DM5PR11MB178771F23CA93B9895F1AD428D850@DM5PR11MB1787.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 042857DBB5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ims0UZBXr/mG2vKxeEnrrBpyuVYS1424S3UOmFeRm47muB9mwiPeqgxXNsRd5cFkiQJPZ9JNxVsrv7wpVLpMIgnCnjWZ32y2CQn4hX6USq5XAztYR/sWvb9M2mdkJ7T/OaqKjC59P5d4iFFnxa5WikDSlit9/RW/oiIVSrpQQPd4oj/ugb0fN36NJ5LiwdYvd7OUGIO2kJ0DnZ95/l6d6nYLW1QNefO4x+2yd3LnfzZ/9jCxyWpS8gBHzoibhy4f+z1egXYDeQKqihyBx1cjXNnKCvppNOciWfF7LVUzs0O/8x6fOzvPW7djncPPoko9w+cvr2LbgWdWwFIKsc6OlQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1833.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(396003)(346002)(366004)(136003)(39860400002)(4326008)(8676002)(8936002)(66556008)(64756008)(66446008)(76116006)(66476007)(5660300002)(52536014)(86362001)(66946007)(478600001)(26005)(316002)(15650500001)(2906002)(83380400001)(71200400001)(54906003)(110136005)(7696005)(186003)(53546011)(6506007)(33656002)(55016002)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: MFkvBGcWpoXOzAZ5gsQcAcilE2aptGfK8lxZeFtkX0LEDwakYKXWzORCL9Bu+LUaM5rTKbnNPz7k++dzTPzhWHfbjth3sqg8zvuvp121YkVKBONGG2aUoxxG4DGFmAzb+8inHB434KPc0qDcUWLjz06A9G4eEWLLWtMdGXJC1DsPhugE000JthbB9vGvtOrsRXYc/mfEdzEUNzu5U4btPSR7EWgR1l3PDmOoNoScON+FwPt8diCvtmc0hKAcJ+S3zy54ImEhfKvLDEsc9Fab8J8MZSLH1hzhmU3OFmqRgjgkgdf3kWF/AgeAOf/fPQNBzWcpINp60nsS6UvkXhQIMPmjMx/hb/G9sRujhkrnAHY02gqEO/seowQ9toSdcFqt1TS0D/wv7yUb3RdWEdBy7R+54iy8xsvPciMTMasYECLt7WjBbkK10rfu4hv64h+H96GH4QzMM7IVgaR+BWaYwT2eGNZmcWbRVVgQ+DaieRvY7fo2vwe8V4jOBcLzyhuG
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 14dd8c73-887a-48ce-c6d0-08d80b476348
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 01:00:50.6973 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KY+R3lMmWu4OTcGMQ0PbAbNcXiPUEEpYNsY+Kw6M4VJDfYL5JAuzJUIepdJcdSw4Q5x3yYu2Lu2p3mLY23pKTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1787
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.43; envelope-from=wentong.wu@intel.com;
 helo=mga05.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/07 21:00:59
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Marek Vasut <marex@denx.de>, Thomas Huth <thuth@redhat.com>,
 Chris Wulff <crwulff@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QENocmlzIFd1bGZmIEBNYXJlayBWYXN1dCBjb3VsZCB5b3UgcGxlYXNlIHRha2UgYSBsb29rIHRo
aXMgaXNzdWUgYW5kIHBhdGNoPyBUaGFua3MgaW4gYWR2YW5jZSENCg0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IFRob21hcyBIdXRoIDx0aHV0aEByZWRoYXQuY29tPiANClNlbnQ6
IEZyaWRheSwgSnVuZSA1LCAyMDIwIDM6MDcgUE0NClRvOiBXdSwgV2VudG9uZyA8d2VudG9uZy53
dUBpbnRlbC5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmcNCkNjOiBDaHJpcyBXdWxmZiA8Y3J3
dWxmZkBnbWFpbC5jb20+OyBNYXJlayBWYXN1dCA8bWFyZXhAZGVueC5kZT4NClN1YmplY3Q6IFJl
OiBbUkZDXSBodzogbmlvczI6IHVwZGF0ZSBpbnRlcnJ1cHRfcmVxdWVzdCB3aGVuIFNUQVRVU19Q
SUUgZGlzYWJsZWQNCg0KT24gMDUvMDYvMjAyMCAwNy41OSwgV3UsIFdlbnRvbmcgd3JvdGU6DQo+
IEhpIGFsbCwNCj4gDQo+IEnigJltIHJ1bm5pbmcgaWNvdW50IG1vZGUgb24gcWVtdV9uaW9zMiB3
aXRoIGN1c3RvbWl6ZWQgwqBwbGF0Zm9ybShhbG1vc3QgDQo+IHNhbWUgd2l0aCAxMG01MF9kZXZi
b2FyZCksDQo+IA0KPiBidXQgY3B1IGFib3J0IGhhcHBlbmVkKHFlbXU6IGZhdGFsOiBSYWlzZWQg
aW50ZXJydXB0IHdoaWxlIG5vdCBpbiBJL08NCj4gZnVuY3Rpb24pIHdoZW4gZ3Vlc3QgY29kZSBj
aGFuZ2VzDQo+IA0KPiBzdGF0ZSByZWdpc3RlciB3aXRoIHdyY3RsIGluc3RydWN0aW9uLCBhZGQg
c29tZSBkZWJ1ZyBjb2RlIGZpbmRpbmcgDQo+IHRoYXQgaXTigJlzIGNhdXNlZCBieSB0aGUgaW50
ZXJydXB0X3JlcXVlc3QNCj4gDQo+IG1pc21hdGNoLCBzbyBJIG1hZGUgYSBwYXRjaCBhcyBiZWxv
dywgbm90IHN1cmUgaWYgaXTigJlzIHJpZ2h0LCBob3BlIEkgDQo+IGNhbiBoYXZlIHNvbWUgZGlz
Y3Vzc2lvbiB3aXRoIG1haW50YWluZXJzDQoNCiBIaSwNCg0KcGxlYXNlIGhhdmUgYSBsb29rIGF0
IHRoZSBNQUlOVEFJTkVSUyBmaWxlIGluIHRoZSBtYWluIGRpcmVjdG9yeSBvZiB0aGUgc291cmNl
cywgeW91IGNhbiBmaW5kIHRoZSBjb3JyZXNwb25kaW5nIG1haW50YWluZXJzIHRoZXJlLiBUaHVz
IGlmIHlvdSBoYXZlIHF1ZXN0aW9ucyByZWxhdGVkIHRvIG5pb3MyLCBwbGVhc2UgbWFrZSBzdXJl
IHRvIHB1dCBDaHJpcyBhbmQgTWFyZWsgaW50byBDQzogc28gdGhhdCB5b3VyIHBhdGNoIGdldHMg
dGhlIHJpZ2h0IGF0dGVudGlvbiENCg0KIFRoYW5rcywNCiAgVGhvbWFzDQoNCg0KDQo+IGNvbW1p
dCBlZmRiM2RhNGUxNDVhN2EzNGJhOGIzYWIxY2RjZmMzNDZhZTIwYTExIChIRUFEIC0+IG1hc3Rl
cikNCj4gDQo+IEF1dGhvcjogV2VudG9uZyBXdSA8d2VudG9uZy53dUBpbnRlbC5jb20+DQo+IA0K
PiBEYXRlOsKgwqAgRnJpIEp1biA1IDA5OjI5OjQzIDIwMjAgLTA0MDANCj4gDQo+IMKgDQo+IA0K
PiDCoMKgwqAgaHc6IG5pb3MyOiB1cGRhdGUgaW50ZXJydXB0X3JlcXVlc3Qgd2hlbiBDUl9TVEFU
VVNfUElFIGRpc2FibGVkDQo+IA0KPiDCoA0KPiANCj4gwqDCoMKgIFVwZGF0ZSBpbnRlcnJ1cHRf
cmVxdWVzdCB3aGVuIGV4dGVybmFsIGludGVydXB0IHBlbmRzIGZvciANCj4gU1RBVFVTX1BJRQ0K
PiANCj4gwqDCoMKgIGRpc2FibGVkLiBPdGhlcndpc2Ugb24gaWNvdW50IGVuYWJsZWQgbmlvczIg
dGFyZ2V0IHRoZXJlIHdpbGwgYmUgDQo+IGNwdQ0KPiANCj4gwqDCoMKgIGFib3J0IHdoZW4gZ3Vl
c3QgY29kZSBjaGFuZ2VzIHN0YXRlIHJlZ2lzdGVyIHdpdGggd3JjdGwgaW5zdHJ1Y3Rpb24uDQo+
IA0KPiDCoA0KPiANCj4gwqDCoMKgIFNpZ25lZC1vZmYtYnk6IFdlbnRvbmcgV3UgPHdlbnRvbmcu
d3VAaW50ZWwuY29tPg0KPiANCj4gwqANCj4gDQo+IGRpZmYgLS1naXQgYS9ody9uaW9zMi9jcHVf
cGljLmMgYi9ody9uaW9zMi9jcHVfcGljLmMNCj4gDQo+IGluZGV4IDFjMTk4OWQ1Li5iMDRkYjRk
NyAxMDA2NDQNCj4gDQo+IC0tLSBhL2h3L25pb3MyL2NwdV9waWMuYw0KPiANCj4gKysrIGIvaHcv
bmlvczIvY3B1X3BpYy5jDQo+IA0KPiBAQCAtNDIsNyArNDIsOSBAQCBzdGF0aWMgdm9pZCBuaW9z
Ml9waWNfY3B1X2hhbmRsZXIodm9pZCAqb3BhcXVlLCBpbnQgDQo+IGlycSwgaW50IGxldmVsKQ0K
PiANCj4gwqDCoMKgwqDCoMKgwqDCoCB9IGVsc2UgaWYgKCFsZXZlbCkgew0KPiANCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGVudi0+aXJxX3BlbmRpbmcgPSAwOw0KPiANCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGNwdV9yZXNldF9pbnRlcnJ1cHQoY3MsIHR5cGUpOw0KPiANCj4gLcKg
wqDCoMKgwqDCoMKgIH0NCj4gDQo+ICvCoMKgwqDCoMKgwqDCoCB9IGVsc2Ugew0KPiANCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgY3MtPmludGVycnVwdF9yZXF1ZXN0IHw9IHR5cGU7DQo+IA0K
PiArwqDCoMKgwqDCoMKgIH0NCj4gDQo+IMKgwqDCoMKgIH0gZWxzZSB7DQo+IA0KPiDCoMKgwqDC
oMKgwqDCoMKgIGlmIChsZXZlbCkgew0KPiANCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNw
dV9pbnRlcnJ1cHQoY3MsIHR5cGUpOw0KPiANCg0K

