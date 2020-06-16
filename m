Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06429C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:06:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE66820786
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="RgrtsFyZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE66820786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlDAt-0007OH-QY
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 11:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jlD9q-0005bd-B1; Tue, 16 Jun 2020 11:05:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:12881)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jlD9n-00079U-3O; Tue, 16 Jun 2020 11:05:49 -0400
IronPort-SDR: oGOoWQjs+D893fpQPWaR8u5dVCVL6jb5ACy3vhsUAfgrbckouhJNFfoaDyjFxjyAv9iNVk18Jw
 vET8xq8tMZIA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2020 08:05:28 -0700
IronPort-SDR: NPMAHFl4PeYZbN9z7iMtiGMThE1kApK3R44etvWMfHbcPi64PeetDGqf8SyRXKANKlgbn6GdIW
 cT6kUTcxbB4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,518,1583222400"; d="scan'208";a="309139533"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
 by fmsmga002.fm.intel.com with ESMTP; 16 Jun 2020 08:05:27 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 16 Jun 2020 08:05:26 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 16 Jun 2020 08:05:26 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 16 Jun 2020 08:05:25 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 16 Jun 2020 08:05:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1bb0SQ+OYhnQLLOLc42K7JQx3r5GAlW4hhM/NXE3PGDXcrqWayWpWjj+Qou+GizJ4fx0veF5DSs+AvHFD8bGGtLmB/QYNROLpiS/2i70LZnOQuI2pT4Z48V+xq7/2+GUcABo/6a7oxSDG7+Yh9BnzjdXG3US24F3H55sotoCTgS9coPC2eJSSjOpxcKYHGn6iy5w4T6pkZxP7cMy73gIMmKYKxAVtAsWlbr20/Enb4hWMA7ADmiGcjWQy4VyebVhxmqFBR5/nNDZvtb8AaJ6R2fOI+l1a7Jg4CmRGS/WtIkD2tuWFe5ao4mkJbiRAWPvQaoo2z1h4d3fVvvC2V2iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAjg7AAmuBqCeGtpFxh5q+0aNv1+9Y/Z/1zMutgfKRc=;
 b=TSpBiINA6Kih1x+cYYGrwSWL4+EyXf62XbH+LY53gs8MXwdPmMnolJWo4Nk5S9giMbr5dTYCdD0w22s3rAWnVBtvbgqV5bpueEP0gWFg+TfYbgHvO+3rs8hLThzaYMFbIjjlQqQBXv3EAic1+HHUpgJZ0s2cual4zae2ppnl4OYu1NKeiJM5zwWKB7fCzDRxIkWzEBqji06TPwsh4b+tsJI5LgNBAik7SZ0lAvQYbjzil8pS/TsX9jN7REHA1ko51fJ0CA/nciObLyn9y+oAXT3xOzOMBnRf+/3wreTFtwtqLsYlmVkT5M+XNPzlJ1WgPyCTKcdVjA+0+cgakTkuvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAjg7AAmuBqCeGtpFxh5q+0aNv1+9Y/Z/1zMutgfKRc=;
 b=RgrtsFyZpB0nlSh5h2U0OwsPo6ZQ4Je4eBou52mCzzWUIPdvp9PbDf0EV199sSBfyQafLFW20KRYQZ89ZYY3sRHIUxSpGO35LEsCg26ltFDuMs8rVQf5GrNZ8qUQOmkmw2emew6MSZnwgxIz8L6dKpperdZ1ogFyjVGnSn7etwU=
Received: from DM5PR11MB1833.namprd11.prod.outlook.com (2603:10b6:3:110::12)
 by DM6PR11MB3052.namprd11.prod.outlook.com (2603:10b6:5:69::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Tue, 16 Jun
 2020 15:05:24 +0000
Received: from DM5PR11MB1833.namprd11.prod.outlook.com
 ([fe80::3c09:1393:f7b8:1f51]) by DM5PR11MB1833.namprd11.prod.outlook.com
 ([fe80::3c09:1393:f7b8:1f51%9]) with mapi id 15.20.3088.028; Tue, 16 Jun 2020
 15:05:24 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH] hw/nios2: Update interrupt request when CR_STATUS_PIE
 disabled
Thread-Topic: [PATCH] hw/nios2: Update interrupt request when CR_STATUS_PIE
 disabled
Thread-Index: AQHWP4ZsWxBTOO2K8UOOQsF38ZGk3KjU/8ewgAAeYICABjzw0A==
Date: Tue, 16 Jun 2020 15:05:24 +0000
Message-ID: <DM5PR11MB1833F9AA5ACF3D1CDC4E32CE8D9D0@DM5PR11MB1833.namprd11.prod.outlook.com>
References: <20200611081319.1864-1-wentong.wu@intel.com>
 <DM5PR11MB1833DA1D82CD4DEAF8DE514F8D810@DM5PR11MB1833.namprd11.prod.outlook.com>
 <b1396e1a-ed01-2ea4-1ad1-359911d28a31@redhat.com>
In-Reply-To: <b1396e1a-ed01-2ea4-1ad1-359911d28a31@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5756e9c4-a140-4f06-b10a-08d81206b246
x-ms-traffictypediagnostic: DM6PR11MB3052:
x-microsoft-antispam-prvs: <DM6PR11MB30520134C3642B779F08A23D8D9D0@DM6PR11MB3052.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wkaOhSl19oELU/eqeYhfnNdMQxN2r3PlXi1NRlenj4nR77lgD2cegHHwksAslO48yNX1A2c4lrx8E7G+p0LYo3ZQ4psfORLQn7Ksr5K3krmwKcD6SQehYeQWC0cYI+hwzxhsqe4jTlAQ6D5w2T2QUOA5Ae4hB7P7HKVJWLNGNdMUoPnBYHPCaEaWbQeFVOkS+aaQzD9BI6oCtY52Cd1CE6+E5FFhw8uh97Zc6/h+IyoTmw9fxT5M40FsCn4W0uTLlUUGVCaX4eu2mex2N1t+5u3SQsqQw9IuPmvGFGHJDWbv98HlGVdZUFB7h9wMDkvFWK9lETw+NbNK+bj8c+sdGYr/hiS0jHJ7QsHMNG+ZHSQmdiPFSK+tbYfX++ZGq226tYeg/WwRq+VFiaAwJcRPTA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1833.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(86362001)(33656002)(26005)(966005)(478600001)(53546011)(7696005)(52536014)(316002)(5660300002)(54906003)(6506007)(110136005)(83380400001)(66476007)(4326008)(9686003)(8676002)(71200400001)(186003)(8936002)(15650500001)(55016002)(76116006)(66946007)(66446008)(66556008)(64756008)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 055lhhh28nwXUrcskClg88nOJi0yyACVcepP0W9zylJ5bRnfFfSSvweYrDDphHW2fxbOVj915pz9I95L3HeNmLXZP4XfVuG7HL6NqS3BU7os+URXiSfBOD845ua2Lp4UbCqVlKMfDp/WL0B/C82o3HWxNRXQs21Xdk5jNnmQ90DVWjwsntnoTNZWz258NAuKi0/vjTQ5W1F01zVUujbVaUi4IsjWEbRx7xCCXHANIQ0IoaBYEfMKQ0SIKswSZKndpAeZuCu6EQj+APRLQnXNT0u1ScGFOTPfryZLQwz8nYMtfHJsvzsmabdNjrPAxiSEG1oqKVEK6Is9DaLtSwKyDoo/Ag5Un3g2egEUXkWU6O9+zhNQ/y7eZIn6+mfRsBCgJx34YD4T8A+FY2yTmgTDHwoCEhzKGvBurV0PJnEv7X8UrgNWjxTFlemoxsTvn5MIrdzkhTfpoDT2DbR21cpDC6OQ1WB4D3XbNny3BsVNszx2azvM9effeb5rEsDoajwi
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5756e9c4-a140-4f06-b10a-08d81206b246
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 15:05:24.1596 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KjxN0ml++IKExTUUA5TvwCFAUmnjlgSQ7qo6gUqNSYbwYWi1QsTZ3JKkTxkqZ6cF8gtWG2Bid1DdBXWmqAk74g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3052
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.136; envelope-from=wentong.wu@intel.com;
 helo=mga12.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 11:05:28
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
 "marex@denx.de" <marex@denx.de>, "thuth@redhat.com" <thuth@redhat.com>,
 "crwulff@gmail.com" <crwulff@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQo+SGksDQoNCj5PbiA2LzEyLzIwIDM6NDMgUE0sIFd1LCBXZW50b25nIHdyb3RlOg0KPiA+IEhp
LA0KPiA+Q2FuIGFueSBib2R5IGhlbHAgcmV2aWV3IHRoaXMgcGF0Y2ggPyBUaGFua3MgaW4gYWR2
YW5jZSENCg0KPiBZb3UganVzdCBzZW50IHRoaXMgcGF0Y2ggeWVzdGVyZGF5Li4uIFBsZWFzZSBn
aXZlIHJldmlld2VycyBtb3JlIHRpbWUuDQoNCj4gU2VlOg0KPiBodHRwczovL3dpa2kucWVtdS5v
cmcvQ29udHJpYnV0ZS9TdWJtaXRBUGF0Y2gjUGFydGljaXBhdGluZ19pbl9Db2RlX1Jldmlldw0K
PiBJbiBwYXJ0aWN1bGFyOg0KPiBodHRwczovL3dpa2kucWVtdS5vcmcvQ29udHJpYnV0ZS9TdWJt
aXRBUGF0Y2gjSWZfeW91cl9wYXRjaF9zZWVtc190b19oYXZlX2JlZW5faWdub3JlZA0KDQo+ID4g
DQo+ID4gQlINCj4gPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206
IFd1LCBXZW50b25nIDx3ZW50b25nLnd1QGludGVsLmNvbT4NCj4gPiBTZW50OiBUaHVyc2RheSwg
SnVuZSAxMSwgMjAyMCA0OjEzIFBNDQo+ID4gVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiA+
IENjOiBxZW11LXRyaXZpYWxAbm9uZ251Lm9yZzsgY3J3dWxmZkBnbWFpbC5jb207IG1hcmV4QGRl
bnguZGU7IA0KPiA+IHRodXRoQHJlZGhhdC5jb207IFd1LCBXZW50b25nIDx3ZW50b25nLnd1QGlu
dGVsLmNvbT4NCj4gPiBTdWJqZWN0OiBbUEFUQ0hdIGh3L25pb3MyOiBVcGRhdGUgaW50ZXJydXB0
IHJlcXVlc3Qgd2hlbiBDUl9TVEFUVVNfUElFIA0KPiA+IGRpc2FibGVkDQo+ID4NCj4gPiBVcGRh
dGUgaW50ZXJydXB0IHJlcXVlc3Qgd2hlbiBleHRlcm5hbCBpbnRlcnVwdCBwZW5kcyBmb3IgU1RB
VFVTX1BJRSBkaXNhYmxlZC4gT3RoZXJ3aXNlIG9uIGljb3VudCBlbmFibGVkIG5pb3MyIHRhcmdl
dCB0aGVyZSB3aWxsIGJlIGNwdSBhYm9ydCB3aGVuIGd1ZXN0IGNvZGUgY2hhbmdlcyBzdGF0ZSBy
ZWdpc3RlciB3aXRoIHdyY3RsIGluc3RydWN0aW9uLg0KDQo+IEl0J2QgaGVscCBpZiB5b3UgcHJv
dmlkZSBtb3JlIGluZm9ybWF0aW9uLCB3aGF0IGNvZGUgd2hlcmUgeW91IHRlc3RpbmcsIGhvdyB5
b3UgcmFuIFFFTVUsIGVub3VnaCBmb3IgcmV2aWV3ZXJzIHRvIHJlcHJvZHVjZSB0aGUgaXNzdWUg
eW91IGhhZCBhbmQgdGVzdCBpZiB5b3VyIHBhdGNoIGluZGVlZCByZXNvbHZlcyB0aGUgaXNzdWUg
eW91IGRlc2NyaWJlZC4NCg0KSGksDQpJ4oCZbSBydW5uaW5nIGljb3VudCBtb2RlIG9uIHFlbXVf
bmlvczIgd2l0aCBjdXN0b21pemVkIHBsYXRmb3JtKGh0dHBzOi8vZ2l0aHViLmNvbS96ZXBoeXJw
cm9qZWN0LXJ0b3Mvc2RrLW5nL2Jsb2IvbWFzdGVyL21ldGEtemVwaHlyLXNkay9yZWNpcGVzLWRl
dnRvb2xzL3FlbXUvZmlsZXMvMDAwMS1xZW11LW5pb3MyLUFkZC1BbHRlcmEtTUFYLTEwLWJvYXJk
LXN1cHBvcnQtZm9yLVplcGh5LnBhdGNoLCBhbG1vc3Qgc2FtZSB3aXRoIDEwbTUwX2RldmJvYXJk
KSBidXQgY3B1IGFib3J0IGhhcHBlbmVkKHFlbXU6IGZhdGFsOiBSYWlzZWQgaW50ZXJydXB0IHdo
aWxlIG5vdCBpbiBJL08gZnVuY3Rpb24pIHdoZW4gZ3Vlc3QgY29kZSBjaGFuZ2VzIHN0YXRlIHJl
Z2lzdGVyIHdpdGggd3JjdGwgaW5zdHJ1Y3Rpb24NCmFkZCBzb21lIGRlYnVnIGNvZGUgZmluZGlu
ZyB0aGF0IGl04oCZcyBjYXVzZWQgYnkgdGhlIGludGVycnVwdF9yZXF1ZXN0IG1pc21hdGNoLiBI
b3BlIHRoYXQgd2lsbCBiZSBoZWxwZnVsLg0KDQoNCj4gUmVnYXJkcywNCg0KPiBQaGlsLg0KDQo+
ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogV2VudG9uZyBXdSA8d2VudG9uZy53dUBpbnRlbC5jb20+
DQo+ID4gLS0tDQo+ID4gaHcvbmlvczIvY3B1X3BpYy5jIHwgMiArKw0KPiA+IDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9uaW9zMi9jcHVf
cGljLmMgYi9ody9uaW9zMi9jcHVfcGljLmMgaW5kZXggDQo+ID4gMWMxOTg5ZDUuLjJhYmM4ZmE4
IDEwMDY0NA0KPiA+IC0tLSBhL2h3L25pb3MyL2NwdV9waWMuYw0KPiA+ICsrKyBiL2h3L25pb3My
L2NwdV9waWMuYw0KPiA+IEBAIC00Miw2ICs0Miw4IEBAIHN0YXRpYyB2b2lkIG5pb3MyX3BpY19j
cHVfaGFuZGxlcih2b2lkICpvcGFxdWUsIGludCBpcnEsIGludCBsZXZlbCkNCj4gPiAgICAgICB9
IGVsc2UgaWYgKCFsZXZlbCkgew0KPiA+ICAgICAgICAgICAgIGVudi0+aXJxX3BlbmRpbmcgPSAw
Ow0KPiA+ICAgICAgICAgICAgY3B1X3Jlc2V0X2ludGVycnVwdChjcywgdHlwZSk7DQo+ID4gKyAg
ICAgICAgfSBlbHNlIHsNCj4gPiArICAgICAgICAgICAgY3MtPmludGVycnVwdF9yZXF1ZXN0IHw9
IHR5cGU7DQo+ID4gICAgICAgIH0NCj4gPiAgICAgfSBlbHNlIHsNCj4gPiAgICAgICAgaWYgKGxl
dmVsKSB7DQo+ID4gLS0NCj4gPiAyLjIxLjMNCj4gPg0KPiA+DQoNCg==

