Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A05C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 08:41:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB2E02078D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 08:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Vw8LfFqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB2E02078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiZod-0004Gu-3Y
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 04:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jiZnK-0003Mu-4M
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 04:39:42 -0400
Received: from mga02.intel.com ([134.134.136.20]:45938)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jiZnH-00026J-SN
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 04:39:41 -0400
IronPort-SDR: nzyBS3FDX9LPhHprxs6wd0Gg7Ou4y8iGj2Rn1M41VDyteO0UgO5T7ELJ664S/Fxx3PA1586ZlP
 dFsgYaHuZs0w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2020 01:39:32 -0700
IronPort-SDR: xLWJqoVHVZS9fx1+rDJBGGbkdKBc5BmKV8yt3H90bWjUkW8SPWuXxcCnG28hUh0HBkjqtUCk3c
 8GQ/Om996sLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,491,1583222400"; d="scan'208";a="295767586"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
 by fmsmga004.fm.intel.com with ESMTP; 09 Jun 2020 01:39:32 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 9 Jun 2020 01:39:31 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 9 Jun 2020 01:39:31 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 9 Jun 2020 01:39:31 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 9 Jun 2020 01:39:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFkbdSMEpsChEgxakn1UmOubYCSSi1jpK/felqnaTcj30C4WTjuqrrFfFOIkaJs6j5wTQ9ym+iWjKX0kvZ1KfmWFTdMWMqx+n01Db/shD3N68xgEEu6IotF5GmjrcfzLgy5PKGXCYc8QCUlXCfvzQHvn4gBlcUulW3FmQe3G5gnQ1TDrjpICuQ1qAXQ5LLyYZj5sUi1g1lJRTws5byf1cMg+KzvSZYqvNoaRDYgIXP15RTyeCfn5v7ueI9RWZq511aRD0ZTahS7f4wyfZfrUMkW0HXtjFdBzGKnqInGF42lF/Qswc4wr7EJXV5WTRw+LwFD7UbxFnV7dDRDxqzcI0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MywQEpb4GXPSquOwzsPqZucMDan7fh2ENLhPKtiVnTQ=;
 b=H4U23Rxt83VrUnd5P1g14Pu8ke08N9vENDBz097N2YinH7ZtYi2LBTvRsGQWzMCJNJdZX2KPRwoypFODw+jGOOe+n0QYRVbdvG2mLqwQowhqelB+wvlZI8X1bY7JAJe3j/0EO19hkoaml2XSAhPr1r7QtrOKStzjyDBa1ATrE7VFcQA0iqy5sMaYXnE/d40yDnLwhQIyzcz4nJGUVBjWSd1qmy6XQRJeXEmwjj8kNlmG2nPPYBngetL4rnaKq30y7od8updigqYfAY7sfMhwZtjajYIFDPKG+1pZ1XIdjjA615Hf8kXMFOfgHSUv3+1yapcfvHsLQZ2Vn3khcf44/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MywQEpb4GXPSquOwzsPqZucMDan7fh2ENLhPKtiVnTQ=;
 b=Vw8LfFqrU3lkMoK0aNTSuW6C/MryhhBDjC1wlpZzYsO46egqyxnYAozZChQF1+PCo3aWu6mTXX+XGKAqB4N6uGTX42PIlgARZcYe0dk+86g3h0ZJfrSTCwZh+8AuegFOddILHW9fESn7cKyHy+Br3A8aTn0ikydnZ0d5e8kgR5w=
Received: from DM5PR11MB1833.namprd11.prod.outlook.com (2603:10b6:3:110::12)
 by DM5PR11MB1260.namprd11.prod.outlook.com (2603:10b6:3:10::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18; Tue, 9 Jun 2020 08:39:27 +0000
Received: from DM5PR11MB1833.namprd11.prod.outlook.com
 ([fe80::3c09:1393:f7b8:1f51]) by DM5PR11MB1833.namprd11.prod.outlook.com
 ([fe80::3c09:1393:f7b8:1f51%9]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 08:39:27 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC] hw: nios2: update interrupt_request when STATUS_PIE disabled
Thread-Topic: [RFC] hw: nios2: update interrupt_request when STATUS_PIE
 disabled
Thread-Index: AdY6/PXgVuA0d+URRVuwGSXTrmqxegACu/oAAMwzU9A=
Date: Tue, 9 Jun 2020 08:39:27 +0000
Message-ID: <DM5PR11MB18332BBC3495C9D9DDC3D4218D820@DM5PR11MB1833.namprd11.prod.outlook.com>
References: <DM5PR11MB18339389B4BD1BB2B4B5AB7A8D860@DM5PR11MB1833.namprd11.prod.outlook.com>
 <e816a581-2bca-a1d3-a5d3-512200298623@redhat.com>
In-Reply-To: <e816a581-2bca-a1d3-a5d3-512200298623@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: thuth@redhat.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dbddde39-75a2-42ef-9f2c-08d80c509ebd
x-ms-traffictypediagnostic: DM5PR11MB1260:
x-microsoft-antispam-prvs: <DM5PR11MB1260BC2624C1C66AE5CB1AC38D820@DM5PR11MB1260.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 042957ACD7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R6MlIeWb34rgKXrClqdAd8Blo153aNGzvyxo3Z+LAvWJPR5XCdIY2jLIlna20rkYUkPRAmlyi5ZtxUzGvFsulJp0erP00DkzIMH5t13Rduh3Hmth1Cl4gq7Pjo8PaufGI6yL8SRHi8jgZuIykGB7YfAyvzA/dCzckeQ1VYb5dgkO7nM1UhyzWbkP6PXdFXQf4QXO+Zad3WiUXcFfcmb5kuBXBC7ZhOQFdf8PI7911y56jE6vAlo+fM3JbVq7qQM2Uf8lUmDZV5BP7izLlLiCuMLE/zyM27EtcK8nhxST7LvozH3EXVOXOoR0KuwGj3R2+68BApdngU7F+60JJHJU+A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1833.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(39860400002)(136003)(396003)(366004)(346002)(6506007)(52536014)(7696005)(26005)(5660300002)(53546011)(86362001)(478600001)(4326008)(83380400001)(76116006)(9686003)(66946007)(66446008)(66556008)(66476007)(64756008)(8936002)(8676002)(55016002)(71200400001)(2906002)(15650500001)(33656002)(186003)(54906003)(316002)(110136005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: /vX1c/K3L+DzvNFWy1I1vMydkq/6EYeoUrrORx2xFg0Bwym5QRmuFxyHdy8+onkLJyasr0QD92NoXbhgiz24+SL23GwR4wE5qPtStmCa/Y+wtlr561SW3ZvjPnQ1e9W2vfh4vxAGu0hg0cGi9Cc7FnQim2bqwEnd0x6TmBAJVCx09y6T3JxQZt89F/h60VGB/1tB0remlnuOllInPMTOS0ATqMUttyYFSiBhsICevuX1h1UR6TZwitvFQa+zmMJMlbRXtgw6cGv/qEXUybcAvaFUuEUvRchQzvWoavOaJrSHnXIYgXlRwUxg0lvYlPVF3KeUYpEQfixxcDWa2II2KRXGc0O0cY4j/VTepJqyjFI6uTDiqWA+FJEzIuQ3vBQfHfW0Gwi2pIlensGCSEePNcJU8WX+3ZSok8FeuZSQpxEuAB9rIngCMIkpvnwbUoXUfWeqOcKPQQeM8AGVtOB5d8EVJ4YBYH11zNIjfx7rStk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dbddde39-75a2-42ef-9f2c-08d80c509ebd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2020 08:39:27.1470 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xnMmtK0vMLFjqx+9MdYXCqtrLScQG6PCg+JYDn88r3Nwyh47caQvMkRQjfvNvmN+mvYtJ2BuUc7+hrmvo5SJLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1260
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20; envelope-from=wentong.wu@intel.com;
 helo=mga02.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 04:39:32
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgQFRob21hcyBIdXRoLA0KSXQncyBteSBmaXJzdCB0aW1lIHRvIHNlbmQgcGF0Y2ggaW4gcWVt
dSBjb21tdW5pdHksIG5vdCBzdXJlIGlmIHRoZXJlIGlzIHNvbWV0aGluZyB3cm9uZyBzZW5kaW5n
IHBhdGNoIGxpa2UgYmVsb3cgYW5kIEknbSBoYXBweSB0byByZWNlaXZlIGFueSBzdWdnZXN0aW9u
cy4gQW5kIGJ5IHRoZSB3YXksIGNvdWxkIHlvdSBwbGVhc2UgaGVscCByZXZpZXcgdGhlIHBhdGNo
PyANCg0KVGhhbmtzDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBUaG9tYXMg
SHV0aCA8dGh1dGhAcmVkaGF0LmNvbT4gDQpTZW50OiBGcmlkYXksIEp1bmUgNSwgMjAyMCAzOjA3
IFBNDQpUbzogV3UsIFdlbnRvbmcgPHdlbnRvbmcud3VAaW50ZWwuY29tPjsgcWVtdS1kZXZlbEBu
b25nbnUub3JnDQpDYzogQ2hyaXMgV3VsZmYgPGNyd3VsZmZAZ21haWwuY29tPjsgTWFyZWsgVmFz
dXQgPG1hcmV4QGRlbnguZGU+DQpTdWJqZWN0OiBSZTogW1JGQ10gaHc6IG5pb3MyOiB1cGRhdGUg
aW50ZXJydXB0X3JlcXVlc3Qgd2hlbiBTVEFUVVNfUElFIGRpc2FibGVkDQoNCk9uIDA1LzA2LzIw
MjAgMDcuNTksIFd1LCBXZW50b25nIHdyb3RlOg0KPiBIaSBhbGwsDQo+IA0KPiBJ4oCZbSBydW5u
aW5nIGljb3VudCBtb2RlIG9uIHFlbXVfbmlvczIgd2l0aCBjdXN0b21pemVkIMKgcGxhdGZvcm0o
YWxtb3N0IA0KPiBzYW1lIHdpdGggMTBtNTBfZGV2Ym9hcmQpLA0KPiANCj4gYnV0IGNwdSBhYm9y
dCBoYXBwZW5lZChxZW11OiBmYXRhbDogUmFpc2VkIGludGVycnVwdCB3aGlsZSBub3QgaW4gSS9P
DQo+IGZ1bmN0aW9uKSB3aGVuIGd1ZXN0IGNvZGUgY2hhbmdlcw0KPiANCj4gc3RhdGUgcmVnaXN0
ZXIgd2l0aCB3cmN0bCBpbnN0cnVjdGlvbiwgYWRkIHNvbWUgZGVidWcgY29kZSBmaW5kaW5nIA0K
PiB0aGF0IGl04oCZcyBjYXVzZWQgYnkgdGhlIGludGVycnVwdF9yZXF1ZXN0DQo+IA0KPiBtaXNt
YXRjaCwgc28gSSBtYWRlIGEgcGF0Y2ggYXMgYmVsb3csIG5vdCBzdXJlIGlmIGl04oCZcyByaWdo
dCwgaG9wZSBJIA0KPiBjYW4gaGF2ZSBzb21lIGRpc2N1c3Npb24gd2l0aCBtYWludGFpbmVycw0K
DQogSGksDQoNCnBsZWFzZSBoYXZlIGEgbG9vayBhdCB0aGUgTUFJTlRBSU5FUlMgZmlsZSBpbiB0
aGUgbWFpbiBkaXJlY3Rvcnkgb2YgdGhlIHNvdXJjZXMsIHlvdSBjYW4gZmluZCB0aGUgY29ycmVz
cG9uZGluZyBtYWludGFpbmVycyB0aGVyZS4gVGh1cyBpZiB5b3UgaGF2ZSBxdWVzdGlvbnMgcmVs
YXRlZCB0byBuaW9zMiwgcGxlYXNlIG1ha2Ugc3VyZSB0byBwdXQgQ2hyaXMgYW5kIE1hcmVrIGlu
dG8gQ0M6IHNvIHRoYXQgeW91ciBwYXRjaCBnZXRzIHRoZSByaWdodCBhdHRlbnRpb24hDQoNCiBU
aGFua3MsDQogIFRob21hcw0KDQoNCg0KPiBjb21taXQgZWZkYjNkYTRlMTQ1YTdhMzRiYThiM2Fi
MWNkY2ZjMzQ2YWUyMGExMSAoSEVBRCAtPiBtYXN0ZXIpDQo+IA0KPiBBdXRob3I6IFdlbnRvbmcg
V3UgPHdlbnRvbmcud3VAaW50ZWwuY29tPg0KPiANCj4gRGF0ZTrCoMKgIEZyaSBKdW4gNSAwOToy
OTo0MyAyMDIwIC0wNDAwDQo+IA0KPiDCoA0KPiANCj4gwqDCoMKgIGh3OiBuaW9zMjogdXBkYXRl
IGludGVycnVwdF9yZXF1ZXN0IHdoZW4gQ1JfU1RBVFVTX1BJRSBkaXNhYmxlZA0KPiANCj4gwqAN
Cj4gDQo+IMKgwqDCoCBVcGRhdGUgaW50ZXJydXB0X3JlcXVlc3Qgd2hlbiBleHRlcm5hbCBpbnRl
cnVwdCBwZW5kcyBmb3IgDQo+IFNUQVRVU19QSUUNCj4gDQo+IMKgwqDCoCBkaXNhYmxlZC4gT3Ro
ZXJ3aXNlIG9uIGljb3VudCBlbmFibGVkIG5pb3MyIHRhcmdldCB0aGVyZSB3aWxsIGJlIA0KPiBj
cHUNCj4gDQo+IMKgwqDCoCBhYm9ydCB3aGVuIGd1ZXN0IGNvZGUgY2hhbmdlcyBzdGF0ZSByZWdp
c3RlciB3aXRoIHdyY3RsIGluc3RydWN0aW9uLg0KPiANCj4gwqANCj4gDQo+IMKgwqDCoCBTaWdu
ZWQtb2ZmLWJ5OiBXZW50b25nIFd1IDx3ZW50b25nLnd1QGludGVsLmNvbT4NCj4gDQo+IMKgDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvaHcvbmlvczIvY3B1X3BpYy5jIGIvaHcvbmlvczIvY3B1X3BpYy5j
DQo+IA0KPiBpbmRleCAxYzE5ODlkNS4uYjA0ZGI0ZDcgMTAwNjQ0DQo+IA0KPiAtLS0gYS9ody9u
aW9zMi9jcHVfcGljLmMNCj4gDQo+ICsrKyBiL2h3L25pb3MyL2NwdV9waWMuYw0KPiANCj4gQEAg
LTQyLDcgKzQyLDkgQEAgc3RhdGljIHZvaWQgbmlvczJfcGljX2NwdV9oYW5kbGVyKHZvaWQgKm9w
YXF1ZSwgaW50IA0KPiBpcnEsIGludCBsZXZlbCkNCj4gDQo+IMKgwqDCoMKgwqDCoMKgwqAgfSBl
bHNlIGlmICghbGV2ZWwpIHsNCj4gDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbnYtPmly
cV9wZW5kaW5nID0gMDsNCj4gDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjcHVfcmVzZXRf
aW50ZXJydXB0KGNzLCB0eXBlKTsNCj4gDQo+IC3CoMKgwqDCoMKgwqDCoCB9DQo+IA0KPiArwqDC
oMKgwqDCoMKgwqAgfSBlbHNlIHsNCj4gDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNzLT5p
bnRlcnJ1cHRfcmVxdWVzdCB8PSB0eXBlOw0KPiANCj4gK8KgwqDCoMKgwqDCoCB9DQo+IA0KPiDC
oMKgwqDCoCB9IGVsc2Ugew0KPiANCj4gwqDCoMKgwqDCoMKgwqDCoCBpZiAobGV2ZWwpIHsNCj4g
DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjcHVfaW50ZXJydXB0KGNzLCB0eXBlKTsNCj4g
DQoNCg==

