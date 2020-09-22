Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E68C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 07:04:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4E1123A1E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 07:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="PQfhVxRN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E1123A1E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKcLu-0000wD-Nv
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 03:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jin.yu@intel.com>) id 1kKcKV-0007V7-2m
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 03:03:11 -0400
Received: from mga02.intel.com ([134.134.136.20]:25814)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jin.yu@intel.com>) id 1kKcKR-0004on-Ez
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 03:03:10 -0400
IronPort-SDR: 4Zd3V3nQm9taNCKt+nLnJLdSz/JvFr8zna1oNfs0iLPUF5jcM+I3k1cFmFnJVwqm7i00axKiCw
 Z9rrUokJi/4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="148211667"
X-IronPort-AV: E=Sophos;i="5.77,289,1596524400"; d="scan'208";a="148211667"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2020 00:02:57 -0700
IronPort-SDR: DizZADTn32Ozs6q1IbwquJwrU5++jZh21GeAC6g5IyhgbRHUMg5P2XXNNXOajmC4WH+LF6iBXd
 PsNo2pyeswnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,289,1596524400"; d="scan'208";a="412565274"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga001.fm.intel.com with ESMTP; 22 Sep 2020 00:02:57 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 22 Sep 2020 00:02:57 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 22 Sep 2020 00:02:57 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 22 Sep 2020 00:02:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVoxT/0jri1BiUWnZ2qTUTrJ4PMoQZCfjdtK/7iwxASFJGuZ4T0abihsj2B2YI+9kf+22jdzC4y12fOcrZI/O+Q3LC+CGSwR25uSI2ocZhfW4Mdk4CtJ9JiS/atocx9STwKvviUXB2I9ZmrdCIHrgyeA10Fb1QYDHL6am2C3WowjlhOE+9C//rmgvlVP9lqrQx3+nAbGd03OPqtPpORDZ7R1o8Z9aGKrKq2b7hdyLFBNRwxChJvG1tjtpoG+yENMPWrOoETvNALBuOO8K/g2ZbQ1MbQLX+93cjhQ0H2mpnRnwZffPYIiPci4WrEJ6nU2q8Xn/WapqXlvRPIHKyUmGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPCPUcpCeWKFu0P/wwAb6FqdZu9IZJPga1Wvhy03ujA=;
 b=klTNJ5PdMcH8XDnkBRkCi2NbEXOtC6MzXhuTlmJsCPz7Q2YrTMx39Dn02HfkM42QyH/BsiNY4KYaPX2BeI5Wv4q8J7nALAyk/pQd4TCs6kCO7qo2vmkzYTv3ESSSsQMN1t8Z2y1vXRvRirBj/mIehhpt598GVfzgI1M2wZudExrDHW/1SbbSbsLN0Kc7ysNQKGKA2A7iGe0FFvx3Cx1NUwLWCOBFR/8kPBC0EXxZZuRXKzOWTPF6rRKzDjKPOG4xuMpGNS2Gi6HnYhgmTkDh8GysFs/z64gHb6LnylY1nCt87uwnemHUd+TurLG5T7+i2crx04wPTtF5wHBnYz4Ekw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPCPUcpCeWKFu0P/wwAb6FqdZu9IZJPga1Wvhy03ujA=;
 b=PQfhVxRNAt6Q35dxUjcOZGANxBdDR9mQojnGFo/86ZOGi7B5qmyWY/3AbSprcr+wgN9pvGF/Eoi0gOPlxBTAnjMuh1Uq1r1HBEJFpuG72oCBxXYfXjkBJaIr59Myrv09kcpxqFqxI5LklCPV5nPl2XdWji0I1nVMlRICmnPaUUs=
Received: from DM6PR11MB3723.namprd11.prod.outlook.com (2603:10b6:5:13f::25)
 by DM6PR11MB4707.namprd11.prod.outlook.com (2603:10b6:5:2a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Tue, 22 Sep
 2020 07:02:54 +0000
Received: from DM6PR11MB3723.namprd11.prod.outlook.com
 ([fe80::bcf4:8f24:f17b:541e]) by DM6PR11MB3723.namprd11.prod.outlook.com
 ([fe80::bcf4:8f24:f17b:541e%5]) with mapi id 15.20.3391.011; Tue, 22 Sep 2020
 07:02:54 +0000
From: "Yu, Jin" <jin.yu@intel.com>
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: RE: [PATCH] vhost-blk: set features before setting inflight feature
Thread-Topic: [PATCH] vhost-blk: set features before setting inflight feature
Thread-Index: AQHWhzmxu3AuAYfiT0CbojVZUvZTNalo762AgAAUMxCACsRxAIAAg1Iw
Date: Tue, 22 Sep 2020 07:02:54 +0000
Message-ID: <DM6PR11MB3723ADFFE72C294947BE95AF803B0@DM6PR11MB3723.namprd11.prod.outlook.com>
References: <20200910134851.7817-1-jin.yu@intel.com>
 <CAFubqFuBY9-KpxUfb7HorV-q960Ns4EiCLCzq-TRFciDuaUiUQ@mail.gmail.com>
 <MN2PR11MB372522EE6FFC2CD0ECF2ADE680200@MN2PR11MB3725.namprd11.prod.outlook.com>
 <CAFubqFtpkNUVq5ZYa2LK96LF0CRcBGx7PtkxNGb8L++nhZOUHA@mail.gmail.com>
In-Reply-To: <CAFubqFtpkNUVq5ZYa2LK96LF0CRcBGx7PtkxNGb8L++nhZOUHA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2f8b416-f934-46c3-bd69-08d85ec5879b
x-ms-traffictypediagnostic: DM6PR11MB4707:
x-microsoft-antispam-prvs: <DM6PR11MB47078DE2B511F822F96D1062803B0@DM6PR11MB4707.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tPyVENRVu0wPTgbJRf32oaJT2/WxaA9REx2LbDRwVhSgZIL39waCzmwx8BgJKV4OzXQWe84Mwu62IaJpuzlP1Gwh+IK8wkZ2/luaWOAATxRxP6A/azBhTIN/SEItPbRmW15iglKzVMYBhh37PXcRHTIwiScZyjYgubcJyyHW1yU77BHXF/R99GesAusI9vU7jUD7DxJLhhVenZF+PI8hEOFs675kxvlchUYQcH0vDX5J1gexYI+16FXt5M857TSTxUl5OfbvGZSGfxVVVvAwrhtUKfho7G7PrlGUB1A4kgTw/tR9Za+LPbdIusrsjt85waGFpzcNM0fa5TrQCruSSJL3z1YUhcOqwY5i6iGcEWdWw+gN5z3kaGkCYI/DFe9ic3BGh44sC+bFrUVY6ab1eQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR11MB3723.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(33656002)(83380400001)(8676002)(316002)(8936002)(52536014)(7696005)(6916009)(2906002)(5660300002)(9686003)(55016002)(478600001)(76116006)(66556008)(66476007)(64756008)(66446008)(966005)(26005)(54906003)(53546011)(6506007)(4326008)(86362001)(71200400001)(66946007)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: WoWrHcsSgBwCe7dBCAnrFnVoijVGX4H6gab5kF04bU3Uxdt8LewbKKzOZAvDCBA0cW6c8XgURE739K4XbwLSgpTgq8cFDfA0B5piwQ4HTLbnWrIa6gmeZ2/xGuRh/edI2+QMV2qu4Ug6KiLouXqH/8saZQgAPrXZwJq314D/6hHi6rC62P7jK4G3nOCG4ie2tPqbp9f/MmSzZU6XE/2pQakeFmCUKcPQ+9l+/5EdPP0DMmGCCAoCdaEAN7gzpTOwG1sdb7TWh+5vlTv2qQ6wmHzSpzWuTQ98E26CS/lyAigRa5i6qzbN+YDqIsr1TArLFXAc5gQ1DKuEhRXgOj0kNhKVLxvX0zwDlnSD9rodNsQZIzh0pjsrhF3bRBYypfu5EG6kqIHqyF96eRALSnpvjV3H3gZPXMbs3eAOuRtUk52YgbzEGXyzhNYGFD5niLhg8MpFlTY0AjezyfAVPHnWM/sObe8dDSXQfnPfXvlE6LP8ky/jjVl8ZK8DoMzb78qYOYUiR1RS2S0w3e+h6cEoTxWCrEGm/Wapx/PAwsYX5YOzy5v6Z8wyZL1O9pM6wsCevAqPLch1znlt1nMttIUsKVUbArPfyTiIEb8cIvkW4HqiBiRE4zsjycbMfshvsxdB41MXl1gFp4iAxGUoh+pKQA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3723.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f8b416-f934-46c3-bd69-08d85ec5879b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2020 07:02:54.7415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fOTX3apBIV0XdYe+onGxEfJ/ohn/+Md2Yf/IAwujF2e5/H/xmGazEVwsCWxblnrMhuUBYe7J7H4HMgsiOZiVQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4707
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20; envelope-from=jin.yu@intel.com;
 helo=mga02.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 01:04:45
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
cGhhZWwucy5ub3J3aXR6QGdtYWlsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDIy
LCAyMDIwIDc6MDMgQU0NCj4gVG86IFl1LCBKaW4gPGppbi55dUBpbnRlbC5jb20+DQo+IENjOiBN
aWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPjsgUmFwaGFlbCBOb3J3aXR6DQo+IDxy
YXBoYWVsLm5vcndpdHpAbnV0YW5peC5jb20+OyBLZXZpbiBXb2xmIDxrd29sZkByZWRoYXQuY29t
PjsgTWF4DQo+IFJlaXR6IDxtcmVpdHpAcmVkaGF0LmNvbT47IFFFTVUgPHFlbXUtZGV2ZWxAbm9u
Z251Lm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gdmhvc3QtYmxrOiBzZXQgZmVhdHVyZXMg
YmVmb3JlIHNldHRpbmcgaW5mbGlnaHQgZmVhdHVyZQ0KPiANCj4gSSBzZWUgeW91ciBwb2ludCAt
IGFsbCB0aGUgb3BlbiBzb3VyY2UgYmFja2VuZHMgSSBjb3VsZCBmaW5kIHdoaWNoIHN1cHBvcnQN
Cj4gVkhPU1RfVVNFUl9QUk9UT0NPTF9GX0lORkxJR0hUX1NITUZEIHJlbHkgb24ga25vd2luZyB0
aGUgdnEgdHlwZQ0KPiB0byBhbGxvY2F0ZSB0aGUgZmQuDQo+IA0KPiBUaGF0IHNhaWQsIGl0IGxv
b2tzIGxpa2UgZHBkayBzdXBwb3J0cyBib3RoDQo+IFZIT1NUX1VTRVJfUFJPVE9DT0xfRl9JTkZM
SUdIVF9TSE1GRCBhbmQgcGFja2VkIHZxcyB3aXRob3V0DQo+IG5lZWRpbmcgc3VjaCBhbiBBUEkN
Cj4gaHR0cHM6Ly9naXRodWIuY29tL0RQREsvZHBkay9ibG9iL21haW4vbGliL2xpYnJ0ZV92aG9z
dC92aG9zdF91c2VyLmMjTDENCj4gNTA5Lg0KPiBJJ20gbm90IHN1cmUgZXhhY3RseSBob3cgdGhl
IFZRIHN0YXRlIGlzIHNlbnQgdG8gRFBESyBiZWZvcmUgdGhlIGluZmxpZ2h0IGZkDQo+IG5lZ290
aWF0aW9uLCBidXQgaWRlYWxseSB2aG9zdC11c2VyLWJsayBjb3VsZCBiZSBtYWRlIHRvIHdvcmsg
dGhlIHNhbWUgd2F5Lg0KPiBNYXliZSBzb21lb25lIHdpdGggbW9yZSB2aG9zdC1uZXQgYW5kIGRw
ZGsga25vd2xlZGdlIGNvdWxkIGNoaW1lIGluIG9uDQo+IGhvdyB2aG9zdC1uZXQgYmFja2VuZHMg
ZG8gaXQ/DQo+DQpJIGNoZWNrZWQgdGhlIGNvZGUgb2Ygdmhvc3QtbmV0IGluIFFFTVUsIGl0IGRp
ZCBub3QgdXNlIHRoZSBpbmZsaWdodCBmZWF0dXJlLCANCndoaWNoIHNob3VsZCBiZSBkaWZmZXJl
bnQgZnJvbSBzdG9yYWdlLCBhZnRlciBhbGwsIHRoZSBuZXR3b3JrIGNhbiBsb3NlIHBhY2tldHMN
CmFuZCByZXRyYW5zbWl0Lg0KDQpPZiBjb3Vyc2UsIGFzIHlvdSBzYWlkLCB3ZSBuZWVkIGFuIGV4
cGVydCBmYW1pbGlhciB3aXRoIHZob3N0LW5ldCBhbmQgZHBkay4NCg0KVGhhbmtzDQo+IE9uIE1v
biwgU2VwIDE0LCAyMDIwIGF0IDEwOjUyIFBNIFl1LCBKaW4gPGppbi55dUBpbnRlbC5jb20+IHdy
b3RlOg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTog
UmFwaGFlbCBOb3J3aXR6IDxyYXBoYWVsLnMubm9yd2l0ekBnbWFpbC5jb20+DQo+ID4gPiBTZW50
OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMTUsIDIwMjAgOToyNSBBTQ0KPiA+ID4gVG86IFl1LCBKaW4g
PGppbi55dUBpbnRlbC5jb20+DQo+ID4gPiBDYzogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVk
aGF0LmNvbT47IFJhcGhhZWwgTm9yd2l0eg0KPiA+ID4gPHJhcGhhZWwubm9yd2l0ekBudXRhbml4
LmNvbT47IEtldmluIFdvbGYgPGt3b2xmQHJlZGhhdC5jb20+OyBNYXgNCj4gPiA+IFJlaXR6IDxt
cmVpdHpAcmVkaGF0LmNvbT47IFFFTVUgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gPiA+IFN1
YmplY3Q6IFJlOiBbUEFUQ0hdIHZob3N0LWJsazogc2V0IGZlYXR1cmVzIGJlZm9yZSBzZXR0aW5n
IGluZmxpZ2h0DQo+ID4gPiBmZWF0dXJlDQo+ID4gPg0KPiA+ID4gQmFja2VuZHMgYWxyZWFkeSBy
ZWNlaXZlIHRoZSBmb3JtYXQgaW4gdmhvc3RfZGV2X3N0YXJ0IGJlZm9yZSB0aGUNCj4gPiA+IG1l
bW9yeSB0YWJsZXMgYXJlIHNldCBvciBhbnkgb2YgdGhlIHZpcnRxdWV1ZXMgYXJlIHN0YXJ0ZWQu
IENhbiB5b3UNCj4gPiA+IGVsYWJvcmF0ZSBvbiB3aHkgeW91IG5lZWQgdG8ga25vdyB0aGUgdmly
dHF1ZXVlIGZvcm1hdCBiZWZvcmUgc2V0dGluZw0KPiB0aGUgaW5mbGlnaHQgRkQ/DQo+ID4gPg0K
PiA+IEZpcnN0LCB3aGVuIHRoZSBiYWNrZW5kIHJlY2VpdmVzIHRoZSBnZXRfaW5mbGlnaHRfZmQg
c2VudCBieSBRRU1VLCBpdA0KPiA+IG5lZWRzIHRvIGFsbG9jYXRlIHZxJ3MgaW5mbGlnaHQgbWVt
b3J5LCBhbmQgaXQgbmVlZHMgdG8ga25vdyB0aGUgZm9ybWF0IG9mDQo+IHZxLg0KPiA+IFNlY29u
ZCwgd2hlbiB0aGUgYmFja2VuZCByZWNvbm5lY3RzIHRvIFFFTVUsIFFFTVUgc2VuZHMNCj4gc2V0
X2luZmxpZ2h0X2ZkLCBhbmQgdGhlIGJhY2tlbmQgcmVzdG9yZXMgdGhlIGluZmxpZ2h0IG1lbW9y
eSBvZiB2cS4NCj4gPiBJdCBhbHNvIG5lZWRzIHRvIGtub3cgdGhlIGZvcm1hdCBvZiB2cS4NCj4g
PiBUaGFua3MuDQo+ID4gPiBPbiBUaHUsIFNlcCAxMCwgMjAyMCBhdCAyOjE1IEFNIEppbiBZdSA8
amluLnl1QGludGVsLmNvbT4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IFZpcnRxdWV1ZSBoYXMg
c3BsaXQgYW5kIHBhY2tlZCwgc28gYmVmb3JlIHNldHRpbmcgaW5mbGlnaHQsIHlvdQ0KPiA+ID4g
PiBuZWVkIHRvIGluZm9ybSB0aGUgYmFjay1lbmQgdmlydHF1ZXVlIGZvcm1hdC4NCj4gPiA+ID4N
Cj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSmluIFl1IDxqaW4ueXVAaW50ZWwuY29tPg0KPiA+ID4g
PiAtLS0NCj4gPiA+ID4gIGh3L2Jsb2NrL3Zob3N0LXVzZXItYmxrLmMgfCAgNiArKysrKysNCj4g
PiA+ID4gIGh3L3ZpcnRpby92aG9zdC5jICAgICAgICAgfCAxOCArKysrKysrKysrKysrKysrKysN
Cj4gPiA+ID4gIGluY2x1ZGUvaHcvdmlydGlvL3Zob3N0LmggfCAgMSArDQo+ID4gPiA+ICAzIGZp
bGVzIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKykNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdp
dCBhL2h3L2Jsb2NrL3Zob3N0LXVzZXItYmxrLmMgYi9ody9ibG9jay92aG9zdC11c2VyLWJsay5j
DQo+ID4gPiA+IGluZGV4IDM5YWVjNDJkYWUuLjllMGU5ZWJlYzAgMTAwNjQ0DQo+ID4gPiA+IC0t
LSBhL2h3L2Jsb2NrL3Zob3N0LXVzZXItYmxrLmMNCj4gPiA+ID4gKysrIGIvaHcvYmxvY2svdmhv
c3QtdXNlci1ibGsuYw0KPiA+ID4gPiBAQCAtMTMxLDYgKzEzMSwxMiBAQCBzdGF0aWMgaW50IHZo
b3N0X3VzZXJfYmxrX3N0YXJ0KFZpcnRJT0RldmljZQ0KPiA+ID4gPiAqdmRldikNCj4gPiA+ID4N
Cj4gPiA+ID4gICAgICBzLT5kZXYuYWNrZWRfZmVhdHVyZXMgPSB2ZGV2LT5ndWVzdF9mZWF0dXJl
czsNCj4gPiA+ID4NCj4gPiA+ID4gKyAgICByZXQgPSB2aG9zdF9kZXZfcHJlcGFyZV9pbmZsaWdo
dCgmcy0+ZGV2KTsNCj4gPiA+ID4gKyAgICBpZiAocmV0IDwgMCkgew0KPiA+ID4gPiArICAgICAg
ICBlcnJvcl9yZXBvcnQoIkVycm9yIHNldCBpbmZsaWdodCBmb3JtYXQ6ICVkIiwgLXJldCk7DQo+
ID4gPiA+ICsgICAgICAgIGdvdG8gZXJyX2d1ZXN0X25vdGlmaWVyczsNCj4gPiA+ID4gKyAgICB9
DQo+ID4gPiA+ICsNCj4gPiA+ID4gICAgICBpZiAoIXMtPmluZmxpZ2h0LT5hZGRyKSB7DQo+ID4g
PiA+ICAgICAgICAgIHJldCA9IHZob3N0X2Rldl9nZXRfaW5mbGlnaHQoJnMtPmRldiwgcy0+cXVl
dWVfc2l6ZSwgcy0+aW5mbGlnaHQpOw0KPiA+ID4gPiAgICAgICAgICBpZiAocmV0IDwgMCkgew0K
PiA+ID4gPiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3Zob3N0LmMgYi9ody92aXJ0aW8vdmhvc3Qu
YyBpbmRleA0KPiA+ID4gPiAxYTEzODRlN2E2Li40MDI3YzExODg2IDEwMDY0NA0KPiA+ID4gPiAt
LS0gYS9ody92aXJ0aW8vdmhvc3QuYw0KPiA+ID4gPiArKysgYi9ody92aXJ0aW8vdmhvc3QuYw0K
PiA+ID4gPiBAQCAtMTYxNiw2ICsxNjE2LDI0IEBAIGludCB2aG9zdF9kZXZfbG9hZF9pbmZsaWdo
dChzdHJ1Y3QNCj4gPiA+ID4gdmhvc3RfaW5mbGlnaHQNCj4gPiA+ICppbmZsaWdodCwgUUVNVUZp
bGUgKmYpDQo+ID4gPiA+ICAgICAgcmV0dXJuIDA7DQo+ID4gPiA+ICB9DQo+ID4gPiA+DQo+ID4g
PiA+ICtpbnQgdmhvc3RfZGV2X3ByZXBhcmVfaW5mbGlnaHQoc3RydWN0IHZob3N0X2RldiAqaGRl
dikgew0KPiA+ID4gPiArICAgIGludCByOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgaWYgKGhk
ZXYtPnZob3N0X29wcy0+dmhvc3RfZ2V0X2luZmxpZ2h0X2ZkID09IE5VTEwgfHwNCj4gPiA+ID4g
KyAgICAgICAgaGRldi0+dmhvc3Rfb3BzLT52aG9zdF9zZXRfaW5mbGlnaHRfZmQgPT0gTlVMTCkg
ew0KPiA+ID4gPiArICAgICAgICByZXR1cm4gMDsNCj4gPiA+ID4gKyAgICB9DQo+ID4gPiA+ICsN
Cj4gPiA+ID4gKyAgICByID0gdmhvc3RfZGV2X3NldF9mZWF0dXJlcyhoZGV2LCBoZGV2LT5sb2df
ZW5hYmxlZCk7DQo+ID4gPiA+ICsgICAgaWYgKHIgPCAwKSB7DQo+ID4gPiA+ICsgICAgICAgIFZI
T1NUX09QU19ERUJVRygidmhvc3RfZGV2X3ByZXBhcmVfaW5mbGlnaHQgZmFpbGVkIik7DQo+ID4g
PiA+ICsgICAgICAgIHJldHVybiByOw0KPiA+ID4gPiArICAgIH0NCj4gPiA+ID4gKw0KPiA+ID4g
PiArICAgIHJldHVybiAwOw0KPiA+ID4gPiArfQ0KPiA+ID4gPiArDQo+ID4gPiA+ICBpbnQgdmhv
c3RfZGV2X3NldF9pbmZsaWdodChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsDQo+ID4gPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgdmhvc3RfaW5mbGlnaHQgKmluZmxpZ2h0KSAg
ew0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92aXJ0aW8vdmhvc3QuaCBiL2luY2x1
ZGUvaHcvdmlydGlvL3Zob3N0LmgNCj4gPiA+ID4gaW5kZXgNCj4gPiA+ID4gNzY3YTk1ZWMwYi4u
NGUyZmM3NTUyOCAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvaW5jbHVkZS9ody92aXJ0aW8vdmhvc3Qu
aA0KPiA+ID4gPiArKysgYi9pbmNsdWRlL2h3L3ZpcnRpby92aG9zdC5oDQo+ID4gPiA+IEBAIC0x
NDAsNiArMTQwLDcgQEAgdm9pZCB2aG9zdF9kZXZfcmVzZXRfaW5mbGlnaHQoc3RydWN0DQo+ID4g
PiA+IHZob3N0X2luZmxpZ2h0ICppbmZsaWdodCk7ICB2b2lkIHZob3N0X2Rldl9mcmVlX2luZmxp
Z2h0KHN0cnVjdA0KPiA+ID4gPiB2aG9zdF9pbmZsaWdodCAqaW5mbGlnaHQpOyAgdm9pZCB2aG9z
dF9kZXZfc2F2ZV9pbmZsaWdodChzdHJ1Y3QNCj4gPiA+ID4gdmhvc3RfaW5mbGlnaHQgKmluZmxp
Z2h0LCBRRU1VRmlsZSAqZik7ICBpbnQNCj4gPiA+ID4gdmhvc3RfZGV2X2xvYWRfaW5mbGlnaHQo
c3RydWN0IHZob3N0X2luZmxpZ2h0ICppbmZsaWdodCwgUUVNVUZpbGUNCj4gPiA+ID4gKmYpOw0K
PiA+ID4gPiAraW50IHZob3N0X2Rldl9wcmVwYXJlX2luZmxpZ2h0KHN0cnVjdCB2aG9zdF9kZXYg
KmhkZXYpOw0KPiA+ID4gPiAgaW50IHZob3N0X2Rldl9zZXRfaW5mbGlnaHQoc3RydWN0IHZob3N0
X2RldiAqZGV2LA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZo
b3N0X2luZmxpZ2h0ICppbmZsaWdodCk7ICBpbnQNCj4gPiA+ID4gdmhvc3RfZGV2X2dldF9pbmZs
aWdodChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIHVpbnQxNl90IHF1ZXVlX3NpemUsDQo+ID4gPiA+
IC0tDQo+ID4gPiA+IDIuMTcuMg0KPiA+ID4gPg0KPiA+ID4gPg0K

