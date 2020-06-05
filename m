Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2ACCC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 07:16:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9750D206E6
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 07:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="GeVZYIec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9750D206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh6aX-0008Ss-T5
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 03:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jh6ZH-0007l0-8H
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 03:15:07 -0400
Received: from mga14.intel.com ([192.55.52.115]:51618)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jh6ZE-000899-IV
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 03:15:06 -0400
IronPort-SDR: Pv99ryNOY4cbG3B7ygDCOO2U9lMC+yPDLG9BYmO907kO7zEfKnpJjllNfRrqPFENd3AdoDFVBI
 EOlDzpqmWhPw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2020 00:15:01 -0700
IronPort-SDR: 6nwFjtDUZMiuXOVoFxaTHiZDss2XQLAJMHReD8b7NP/JLkrPeZShlsRubp5ACcwqKCttWbSaK2
 +Dxo171xGYsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,475,1583222400"; d="scan'208";a="445802145"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
 by orsmga005.jf.intel.com with ESMTP; 05 Jun 2020 00:15:01 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 5 Jun 2020 00:15:00 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 5 Jun 2020 00:15:00 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 5 Jun 2020 00:15:00 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.58) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Fri, 5 Jun 2020 00:15:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wu9waLowPGmt+lL90y0AvpTcLIB+394zSfkdYZ4N1JPUwWNxKJUeV6qclxItBczZ+qR6icsS2nFLfDiolB/o9WWeQhWALGMeghtRQv5mQwN6vX1p+bngzsdfRdsZk+DNWPksUODqAdMcey1yJnfSbS7Oj61LtPZDzUsu8PvdyI6rlEeu9ZyE7Jyi66encAjbj3bTcHuojf6mTDiPNMlYyilndOcZTk4unsCefRkIVYxAGFySofL+lVjxxKUrOizToAL5hqsBEv/V6RvyUcZ7Gggo1unU2rm80CKYSO9hHqzlPMWXkZNp0RdObMBgtq4+C0W4dkrFA6QiMkBUlFfdzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8vZBFn3Gm4nQ1Io2UWbBVn2uau4rlKkTqseMZP4gDU=;
 b=gniLvrydCkJUMUTAOrOYwFKpAutQ+FakNl4Za8+wigIIHPTWgMvMwqM/KzZlYOFe+gR1Z8Dmsgmjt5IuPspUBApwTwrcjDesfm1VznbqIUiYt4WeUlqSnuFXsvpnePW9ZpF3ME7oi/9XZ66ikyEWRJBMRBShrKAawUf1c+oyEw6cBe/jpajXyWy1466OVjF9bs5YmkTK0hHbIeBh3qTEwZYkODrD8TEOcl6mXN+JxUoBjibqhJRN+FZsTiYxqUxu5FR74rsaG0ZqqTT0ihmHDSwpbQrngwcqP6IJWp8h/5anLCXrOUF8mW6bNve5VkUkds6TTGzS4QImd8/JbB0+cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8vZBFn3Gm4nQ1Io2UWbBVn2uau4rlKkTqseMZP4gDU=;
 b=GeVZYIec4z4KTMi58x+s5u/8YuoZQid5IUmx93AGxoF3Vqk03Ee8bLyHMi2s5n2ubQbNBLhMyxe4LM/ut3AWxHVLCdUUm8Z4E/SUnSkRj8IrgSD1LBDRnn0NKgyXdYfbvyvNdU8Sj91yLDdRUry4wkvrNo/tBy09FnGFZ5OldO4=
Received: from DM5PR11MB1833.namprd11.prod.outlook.com (2603:10b6:3:110::12)
 by DM5PR11MB1436.namprd11.prod.outlook.com (2603:10b6:4:8::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18; Fri, 5 Jun 2020 07:14:59 +0000
Received: from DM5PR11MB1833.namprd11.prod.outlook.com
 ([fe80::3c09:1393:f7b8:1f51]) by DM5PR11MB1833.namprd11.prod.outlook.com
 ([fe80::3c09:1393:f7b8:1f51%9]) with mapi id 15.20.3066.022; Fri, 5 Jun 2020
 07:14:58 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC] hw: nios2: update interrupt_request when STATUS_PIE disabled
Thread-Topic: [RFC] hw: nios2: update interrupt_request when STATUS_PIE
 disabled
Thread-Index: AdY6/PXgVuA0d+URRVuwGSXTrmqxegACu/oAAAA5VaA=
Date: Fri, 5 Jun 2020 07:14:58 +0000
Message-ID: <DM5PR11MB1833D449129C07CB86F5B6498D860@DM5PR11MB1833.namprd11.prod.outlook.com>
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
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fbf93fe8-8850-42f7-0cea-08d809202819
x-ms-traffictypediagnostic: DM5PR11MB1436:
x-microsoft-antispam-prvs: <DM5PR11MB1436A52AE149C44493C9B3E08D860@DM5PR11MB1436.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0425A67DEF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BTiTiCVL5S6i+Ej5GfTXWswuUsstHORXw9+pt0x+YKQunUOXH5dqwCVI4kpMvdmNnvJeSIsvHWenX0ruAJh5crDAXPE+tbuGWwNmdNQr7Y9QVJN4IXSvl0589CIXD/lK4NO6iLKKx/pycKIqxyovCQVUgGU77Xk92NsYxevk99InpWAwsnuGO4IZ/TpkxmlyRRvu7wfT1tk+2TmYjKmZ6U1iOK9mfiX732fqaGkMTsnzAeKAuNeeJExAlJhoU+kRgvZd/SOF42jz/qrXR5s+qcd4pIUxjABfhqnjuwGVr+YaSWlwWZf2iSRiE7D3IXUbdK3y5lVoAyvRJaksYXykXA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1833.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(346002)(366004)(376002)(396003)(39860400002)(26005)(66446008)(76116006)(66476007)(53546011)(86362001)(52536014)(8676002)(6506007)(9686003)(55016002)(66556008)(83380400001)(71200400001)(66946007)(8936002)(316002)(64756008)(2906002)(478600001)(54906003)(186003)(33656002)(15650500001)(110136005)(7696005)(5660300002)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: R+TLhKqt0PGCm9rPSd2tBl4vaHg3IgnYjArza+7D7m1sJz1XJEHxf/nmoA98VXOKujxzHrm448VDboIjGwP4io1WrIIm5kGethpCVG8SXXtzDK4O/uau1rQqKqkiBfIFXzHasGoKYoi+I3DKG+UZLcMQI62EOVELAe7iHxZOx4QZiy0OECOf+OqvY1/qlp9/QrgljTs0cQuTYVwVMCAIOTLk+4hKdrQZKMn73gsScY4Li/ms7BpVyD52rZqYlWQt8eYm92sHJXLQgCLhIqid9Sona28O4ONtK2CHRj4vJDzIaANZTIyhN5vNveaUkjoxOnpeOzzO3QwES0036AK4YErvlqBNdFcbgAy3oWetHs7oe8jkELhpgU0IfsBwrEXvHarowGc8L88ySStkrWLxD+zPY/+miT6VyCaJPqFfOXaiAgnCPztMCwEpgs/0nuMLz4gNF13LL6TLZHpsruj57LUWIO+tmN4EAL4TOxT1R4o=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf93fe8-8850-42f7-0cea-08d809202819
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2020 07:14:58.5870 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qXfAiethgzEOI4phN/cVIMkRqWwhXg9kdV9O50atKDYWfIYgEvHuNLqDMPWHhK/jiACShnVI6I1YV18bdezI9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1436
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.115; envelope-from=wentong.wu@intel.com;
 helo=mga14.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:15:02
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, RCVD_IN_DNSWL_HI=-5, SPF_PASS=-0.001,
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

VGhhbmtzIFRob21hcyENCg0KQENocmlzIFd1bGZmIEBNYXJlayBWYXN1dCBjb3VsZCB5b3UgcGxl
YXNlIGdpdmUgc29tZSBzdWdnZXN0aW9ucz8gVGhhbmtzDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBUaG9tYXMgSHV0aCA8dGh1dGhAcmVkaGF0LmNvbT4gDQpTZW50OiBGcmlk
YXksIEp1bmUgNSwgMjAyMCAzOjA3IFBNDQpUbzogV3UsIFdlbnRvbmcgPHdlbnRvbmcud3VAaW50
ZWwuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnDQpDYzogQ2hyaXMgV3VsZmYgPGNyd3VsZmZA
Z21haWwuY29tPjsgTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+DQpTdWJqZWN0OiBSZTogW1JG
Q10gaHc6IG5pb3MyOiB1cGRhdGUgaW50ZXJydXB0X3JlcXVlc3Qgd2hlbiBTVEFUVVNfUElFIGRp
c2FibGVkDQoNCk9uIDA1LzA2LzIwMjAgMDcuNTksIFd1LCBXZW50b25nIHdyb3RlOg0KPiBIaSBh
bGwsDQo+IA0KPiBJ4oCZbSBydW5uaW5nIGljb3VudCBtb2RlIG9uIHFlbXVfbmlvczIgd2l0aCBj
dXN0b21pemVkIMKgcGxhdGZvcm0oYWxtb3N0IA0KPiBzYW1lIHdpdGggMTBtNTBfZGV2Ym9hcmQp
LA0KPiANCj4gYnV0IGNwdSBhYm9ydCBoYXBwZW5lZChxZW11OiBmYXRhbDogUmFpc2VkIGludGVy
cnVwdCB3aGlsZSBub3QgaW4gSS9PDQo+IGZ1bmN0aW9uKSB3aGVuIGd1ZXN0IGNvZGUgY2hhbmdl
cw0KPiANCj4gc3RhdGUgcmVnaXN0ZXIgd2l0aCB3cmN0bCBpbnN0cnVjdGlvbiwgYWRkIHNvbWUg
ZGVidWcgY29kZSBmaW5kaW5nIA0KPiB0aGF0IGl04oCZcyBjYXVzZWQgYnkgdGhlIGludGVycnVw
dF9yZXF1ZXN0DQo+IA0KPiBtaXNtYXRjaCwgc28gSSBtYWRlIGEgcGF0Y2ggYXMgYmVsb3csIG5v
dCBzdXJlIGlmIGl04oCZcyByaWdodCwgaG9wZSBJIA0KPiBjYW4gaGF2ZSBzb21lIGRpc2N1c3Np
b24gd2l0aCBtYWludGFpbmVycw0KDQogSGksDQoNCnBsZWFzZSBoYXZlIGEgbG9vayBhdCB0aGUg
TUFJTlRBSU5FUlMgZmlsZSBpbiB0aGUgbWFpbiBkaXJlY3Rvcnkgb2YgdGhlIHNvdXJjZXMsIHlv
dSBjYW4gZmluZCB0aGUgY29ycmVzcG9uZGluZyBtYWludGFpbmVycyB0aGVyZS4gVGh1cyBpZiB5
b3UgaGF2ZSBxdWVzdGlvbnMgcmVsYXRlZCB0byBuaW9zMiwgcGxlYXNlIG1ha2Ugc3VyZSB0byBw
dXQgQ2hyaXMgYW5kIE1hcmVrIGludG8gQ0M6IHNvIHRoYXQgeW91ciBwYXRjaCBnZXRzIHRoZSBy
aWdodCBhdHRlbnRpb24hDQoNCiBUaGFua3MsDQogIFRob21hcw0KDQoNCg0KPiBjb21taXQgZWZk
YjNkYTRlMTQ1YTdhMzRiYThiM2FiMWNkY2ZjMzQ2YWUyMGExMSAoSEVBRCAtPiBtYXN0ZXIpDQo+
IA0KPiBBdXRob3I6IFdlbnRvbmcgV3UgPHdlbnRvbmcud3VAaW50ZWwuY29tPg0KPiANCj4gRGF0
ZTrCoMKgIEZyaSBKdW4gNSAwOToyOTo0MyAyMDIwIC0wNDAwDQo+IA0KPiDCoA0KPiANCj4gwqDC
oMKgIGh3OiBuaW9zMjogdXBkYXRlIGludGVycnVwdF9yZXF1ZXN0IHdoZW4gQ1JfU1RBVFVTX1BJ
RSBkaXNhYmxlZA0KPiANCj4gwqANCj4gDQo+IMKgwqDCoCBVcGRhdGUgaW50ZXJydXB0X3JlcXVl
c3Qgd2hlbiBleHRlcm5hbCBpbnRlcnVwdCBwZW5kcyBmb3IgDQo+IFNUQVRVU19QSUUNCj4gDQo+
IMKgwqDCoCBkaXNhYmxlZC4gT3RoZXJ3aXNlIG9uIGljb3VudCBlbmFibGVkIG5pb3MyIHRhcmdl
dCB0aGVyZSB3aWxsIGJlIA0KPiBjcHUNCj4gDQo+IMKgwqDCoCBhYm9ydCB3aGVuIGd1ZXN0IGNv
ZGUgY2hhbmdlcyBzdGF0ZSByZWdpc3RlciB3aXRoIHdyY3RsIGluc3RydWN0aW9uLg0KPiANCj4g
wqANCj4gDQo+IMKgwqDCoCBTaWduZWQtb2ZmLWJ5OiBXZW50b25nIFd1IDx3ZW50b25nLnd1QGlu
dGVsLmNvbT4NCj4gDQo+IMKgDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvbmlvczIvY3B1X3BpYy5j
IGIvaHcvbmlvczIvY3B1X3BpYy5jDQo+IA0KPiBpbmRleCAxYzE5ODlkNS4uYjA0ZGI0ZDcgMTAw
NjQ0DQo+IA0KPiAtLS0gYS9ody9uaW9zMi9jcHVfcGljLmMNCj4gDQo+ICsrKyBiL2h3L25pb3My
L2NwdV9waWMuYw0KPiANCj4gQEAgLTQyLDcgKzQyLDkgQEAgc3RhdGljIHZvaWQgbmlvczJfcGlj
X2NwdV9oYW5kbGVyKHZvaWQgKm9wYXF1ZSwgaW50IA0KPiBpcnEsIGludCBsZXZlbCkNCj4gDQo+
IMKgwqDCoMKgwqDCoMKgwqAgfSBlbHNlIGlmICghbGV2ZWwpIHsNCj4gDQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBlbnYtPmlycV9wZW5kaW5nID0gMDsNCj4gDQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBjcHVfcmVzZXRfaW50ZXJydXB0KGNzLCB0eXBlKTsNCj4gDQo+IC3CoMKgwqDC
oMKgwqDCoCB9DQo+IA0KPiArwqDCoMKgwqDCoMKgwqAgfSBlbHNlIHsNCj4gDQo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGNzLT5pbnRlcnJ1cHRfcmVxdWVzdCB8PSB0eXBlOw0KPiANCj4gK8Kg
wqDCoMKgwqDCoCB9DQo+IA0KPiDCoMKgwqDCoCB9IGVsc2Ugew0KPiANCj4gwqDCoMKgwqDCoMKg
wqDCoCBpZiAobGV2ZWwpIHsNCj4gDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjcHVfaW50
ZXJydXB0KGNzLCB0eXBlKTsNCj4gDQoNCg==

