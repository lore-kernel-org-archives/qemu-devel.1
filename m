Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC33C4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 23:49:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F41206C3
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 23:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jK4cQoyj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CX1Oqtk5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F41206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPDkj-0007oA-0U
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 19:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=539968827=Dmitry.Fomichev@wdc.com>)
 id 1kPDjk-0006ss-UH; Sun, 04 Oct 2020 19:48:17 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:50195)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=539968827=Dmitry.Fomichev@wdc.com>)
 id 1kPDjg-0003bB-G5; Sun, 04 Oct 2020 19:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601855292; x=1633391292;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=BhkeZ2ZGaqEy5T+BrNWa1w/nqZWXOpV5kk9IBK159/M=;
 b=jK4cQoyjyeQiubBQtfsaKDuhw51FTa8clFcUjbg2P5Fils0L0XrX3a15
 NwNs58C2NH4WIL7Vw8shvb1ZGMsvSB7/HQYuhlKs7eOfob36DE1On6oOo
 XR+51KumyezGWN8/qFqX6fouLtW7xq+eeM2khFVuzQiNtP+WrgMgBqxMF
 aaWGqa/thgErx9IWkw3BBdsESjcFb0ZMb9Xh9OkqcKEm1d1BbL67p7CWr
 yruGDdewwU7F/epZ09zim3qsffzhyq99yA0n4bCk4XA5L6zRbkWb3lkiG
 KpzEVoMMlZ806qe3xOR45lLJwK7SUeTyJC4bLc2lSw3ltpB8XSobHVMcw g==;
IronPort-SDR: c9sYGD8QaCKUybPdA7ImEIEkZH2/AWac6iOUy8vU8CV8HBWFVm8A4I5/ARIbD7o2RTFghE2wHM
 3q3RZsXz0B2L0GfRukmz1cd/CL54A41azOIeCQeOsYO+AP9tTj1eRbW+6dQHN4PRydot/7q+XQ
 3DrXPRYlF1LCTvWlknjpWmC/RbnVGT2Dv0PofCYLTO8lVTY3D8nRtxmPhbjHr1LDhHMHpLWO2y
 KNZdYL/60iwTjd1G6q0n2BHrqfC+yEX8JcUbAke0XIBsRg93SSl9NWwgSFJdIaZpTYDHvn3j+0
 47I=
X-IronPort-AV: E=Sophos;i="5.77,337,1596470400"; d="scan'208";a="258821361"
Received: from mail-cys01nam02lp2056.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.56])
 by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2020 07:48:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knFmsXdVADlQcCxzB0j8M+gORfh9m3Tafou0tAkhXBFctwUom/4TkBrzutqhkDU03ZagSyfPaHyUPgXE/hwSnUIJRLEFVR77C8Urk06o+YSJlkzIyZj3SJGRMoBchYAuN3GCxB0+GRjI4Ir+50pgKT0yKHyLjxCV6VKV1z2U0QFndj714OxBORuH0zbBmKt1K+OM8e44EVlnEEXgkBrWXxU4ujZqr70pT4F/esp3vs4ObhEr9m3WGFIB+biNNBgP72yzyeDOohJYbbipTAh4V4gVeWXobCRM2Pq1c+jlnw1FY7QqzVaXFDeB8JgMXKJbdnIMoRL5cUb8jjLlfdaPHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhkeZ2ZGaqEy5T+BrNWa1w/nqZWXOpV5kk9IBK159/M=;
 b=aQ1aa27l2xbr9P+wynjQZm12uekHXx+V7dg7Behv+oGCwx7yFpaTKgNcr4KcboET+Ae4QyOlQgATmanyobN+oI548iKyBiYIaL/o53XvCymtbPAjsQl0vYlt8Zp8Ez/y0enosPjsy1964t0uQASDYJciJm63KGT1NbqP41lfmCKldcUK8C+SOcwJKf322EOf3xCYLB270PI1AaYBqaNc6verVcDg5b6rcCeerutwrCH3sovFDKbxcchxD4vszhdqlWe+2bb7TX01Yvf+okU/2kwqLEhriGE/2ZxIN6LZ6Z0upaQZ/Y985PoPWAoShl4XYoJeGAru5e9If7nj+Wf9UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhkeZ2ZGaqEy5T+BrNWa1w/nqZWXOpV5kk9IBK159/M=;
 b=CX1Oqtk5UB0RX+J1vReg3BiMyO6hd8qKA0LklAUY7KHhpQ28mY1PNoVU/ruHKrK6R8rLnf6UlKgsZYfVtYg/fQVeysrLnqYuuE3Iz5FunOAQkxceOw5HyOTGmdnz6eSH1KWPcsHxtwZXUl0xMgpCnCl1yZ4TXd4bFu0XPl1jgjQ=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5710.namprd04.prod.outlook.com (2603:10b6:208:a2::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.39; Sun, 4 Oct
 2020 23:48:05 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94%6]) with mapi id 15.20.3433.044; Sun, 4 Oct 2020
 23:48:04 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: "its@irrelevant.dk" <its@irrelevant.dk>
Subject: Re: [PATCH v5 09/14] hw/block/nvme: Support Zoned Namespace Command
 Set
Thread-Topic: [PATCH v5 09/14] hw/block/nvme: Support Zoned Namespace Command
 Set
Thread-Index: AQHWlUAbR7szI/vjI0exN9wB2mxOtqmAsz6AgAdz2oA=
Date: Sun, 4 Oct 2020 23:48:04 +0000
Message-ID: <2f864a8f274f7e4838d4930efc4ee2b8b05a1c2f.camel@wdc.com>
References: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
 <20200928023528.15260-10-dmitry.fomichev@wdc.com>
 <20200930055935.GB436843@apples.localdomain>
In-Reply-To: <20200930055935.GB436843@apples.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [173.70.90.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 17657567-d842-470e-e8bd-08d868bff01f
x-ms-traffictypediagnostic: MN2PR04MB5710:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB5710644A48DBA824B0BBFEB9E10F0@MN2PR04MB5710.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3fjTBxy5oQQQfXJiIT/bqVTJ6TsDzJoilGYqyrsWmszBMQchIApcxjgWJgI2wdzjyw4kY5zYVGXJzDrYYbs2WdRAPCbdTuNV2yXDnCvfLfvEjTpWu1D4F+nmoemf8eZZHenIi7BlB0VSgCUF97XwMPlgg+my72PF8APisqvnXSEtezw4WnDc7tO/k4A0dVr/D7FfiUPulztnGkTT1Q2Rhkqe9zCGLeZbI6+onUtXa6cWzUi1RJ0S4h0uW77FjRYMozJITjW52psFgnR2RMTwWzt1LazGGubsl3bAZk9NR5y6NFAuw4+a+KwuU06AM8zrIarBRhl2JqSS3EtBAMjoUA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(376002)(136003)(39850400004)(8936002)(66556008)(66446008)(6916009)(478600001)(64756008)(66476007)(2616005)(8676002)(5660300002)(76116006)(86362001)(6486002)(2906002)(71200400001)(66946007)(36756003)(6512007)(54906003)(6506007)(83380400001)(316002)(26005)(4326008)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: TVWb+F88SwZOmDtPpriP8P2lnQHf3bZBWeDgOw00yhDAfKQWbGAaH0Fnioq/67axexBlnz9few1J72QXKaJi6RZJyuw+23iC8H6cg10auRme6YNyHIQEv+y/uCC2ytyTp4Z9XFN++KqUjipdN6VJS1NfnkNN8i2gbSXAajQAhUzMr8BD41JVBZpzA7ckDHXtMCvK9D5u5U7EJTjsXtcpkXDj/wWbJkGAsVwQtLgLE/McLa6uS0CC8hZAF9Ksm0Lsse3OxFGzsWgJpXi7Gcj1fGbBl8qOI/K8PC2gK+MjY/bdkZIKlBoXkRl9jrDBd7AWdjC6CqY7NFrPGk0r0qm0JV/AoeDn3GEm5jgfmbZMVFMp/WUACekDMAFbANLZ9QjR31vTYdlorn4ikxKAAwE+QNCSO2yBPSYqS8Ac02+AfTYvN+5YsKxIa4aCL+jMWGQCCRVYRtcUnuK/sj5hvZSffbSR9V51Il4oZ1QD9ip2hj5s3YDxQ+iSPXK+XY8WKtsziqqNVzc4HB1pVFfdQf044Ggm80Qz47lHBoVSZZ4eUYgSXyU2nz5enk6v96OUeC0BCtoIyFT8Mk2xBBKLZZ5s4hR7W5+RCWwiSdjf3kyPOryk4/YCL1mUECG46F8SzWBFZ7YVrwqL7AIlaIoVL1qI5g==
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9147BFD3410274CA93871AD7D58FE29@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17657567-d842-470e-e8bd-08d868bff01f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2020 23:48:04.6562 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2cfl2tvHnydzw1drB3wkUVQ78cRugkkYJS5QIN4knIgAh2khMrR3ZsmVkNRZ0Chu9Jgi40xj1Cstg5xfEU0vig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5710
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=539968827=Dmitry.Fomichev@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/04 19:48:07
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: "fam@euphon.net" <fam@euphon.net>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "k.jensen@samsung.com" <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gV2VkLCAyMDIwLTA5LTMwIGF0IDA3OjU5ICswMjAwLCBLbGF1cyBKZW5zZW4gd3JvdGU6DQo+
IE9uIFNlcCAyOCAxMTozNSwgRG1pdHJ5IEZvbWljaGV2IHdyb3RlOg0KPiA+IFRoZSBlbXVsYXRp
b24gY29kZSBoYXMgYmVlbiBjaGFuZ2VkIHRvIGFkdmVydGlzZSBOVk0gQ29tbWFuZCBTZXQgd2hl
bg0KPiA+ICJ6b25lZCIgZGV2aWNlIHByb3BlcnR5IGlzIG5vdCBzZXQgKGRlZmF1bHQpIGFuZCBa
b25lZCBOYW1lc3BhY2UNCj4gPiBDb21tYW5kIFNldCBvdGhlcndpc2UuDQo+ID4gDQo+ID4gSGFu
ZGxlcnMgZm9yIHRocmVlIG5ldyBOVk1lIGNvbW1hbmRzIGludHJvZHVjZWQgaW4gWm9uZWQgTmFt
ZXNwYWNlDQo+ID4gQ29tbWFuZCBTZXQgc3BlY2lmaWNhdGlvbiBhcmUgYWRkZWQsIG5hbWVseSBm
b3IgWm9uZSBNYW5hZ2VtZW50DQo+ID4gUmVjZWl2ZSwgWm9uZSBNYW5hZ2VtZW50IFNlbmQgYW5k
IFpvbmUgQXBwZW5kLg0KPiA+IA0KPiA+IERldmljZSBpbml0aWFsaXphdGlvbiBjb2RlIGhhcyBi
ZWVuIGV4dGVuZGVkIHRvIGNyZWF0ZSBhIHByb3Blcg0KPiA+IGNvbmZpZ3VyYXRpb24gZm9yIHpv
bmVkIG9wZXJhdGlvbiB1c2luZyBkZXZpY2UgcHJvcGVydGllcy4NCj4gPiANCj4gPiBSZWFkL1dy
aXRlIGNvbW1hbmQgaGFuZGxlciBpcyBtb2RpZmllZCB0byBvbmx5IGFsbG93IHdyaXRlcyBhdCB0
aGUNCj4gPiB3cml0ZSBwb2ludGVyIGlmIHRoZSBuYW1lc3BhY2UgaXMgem9uZWQuIEZvciBab25l
IEFwcGVuZCBjb21tYW5kLA0KPiA+IHdyaXRlcyBpbXBsaWNpdGx5IGhhcHBlbiBhdCB0aGUgd3Jp
dGUgcG9pbnRlciBhbmQgdGhlIHN0YXJ0aW5nIHdyaXRlDQo+ID4gcG9pbnRlciB2YWx1ZSBpcyBy
ZXR1cm5lZCBhcyB0aGUgcmVzdWx0IG9mIHRoZSBjb21tYW5kLiBXcml0ZSBaZXJvZXMNCj4gPiBo
YW5kbGVyIGlzIG1vZGlmaWVkIHRvIGFkZCB6b25lZCBjaGVja3MgdGhhdCBhcmUgaWRlbnRpY2Fs
IHRvIHRob3NlDQo+ID4gZG9uZSBhcyBhIHBhcnQgb2YgV3JpdGUgZmxvdy4NCj4gPiANCj4gPiBU
aGUgY29kZSB0byBzdXBwb3J0IGZvciBab25lIERlc2NyaXB0b3IgRXh0ZW5zaW9ucyBpcyBub3Qg
aW5jbHVkZWQgaW4NCj4gPiB0aGlzIGNvbW1pdCBhbmQgWkRFUyAwIGlzIGFsd2F5cyByZXBvcnRl
ZC4gQSBsYXRlciBjb21taXQgaW4gdGhpcw0KPiA+IHNlcmllcyB3aWxsIGFkZCBaREUgc3VwcG9y
dC4NCj4gPiANCj4gPiBUaGlzIGNvbW1pdCBkb2Vzbid0IHlldCBpbmNsdWRlIGNoZWNrcyBmb3Ig
YWN0aXZlIGFuZCBvcGVuIHpvbmUNCj4gPiBsaW1pdHMuIEl0IGlzIGFzc3VtZWQgdGhhdCB0aGVy
ZSBhcmUgbm8gbGltaXRzIG9uIGVpdGhlciBhY3RpdmUgb3INCj4gPiBvcGVuIHpvbmVzLg0KPiA+
IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE5pa2xhcyBDYXNzZWwgPG5pa2xhcy5jYXNzZWxAd2RjLmNv
bT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIYW5zIEhvbG1iZXJnIDxoYW5zLmhvbG1iZXJnQHdkYy5j
b20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWpheSBKb3NoaSA8YWpheS5qb3NoaUB3ZGMuY29tPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8Y2hhaXRhbnlhLmt1bGthcm5p
QHdkYy5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWF0aWFzIEJqb3JsaW5nIDxtYXRpYXMuYmpv
cmxpbmdAd2RjLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBcmF2aW5kIFJhbWVzaCA8YXJhdmlu
ZC5yYW1lc2hAd2RjLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGluJ2ljaGlybyBLYXdhc2Fr
aSA8c2hpbmljaGlyby5rYXdhc2FraUB3ZGMuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFkYW0g
TWFuemFuYXJlcyA8YWRhbS5tYW56YW5hcmVzQHdkYy5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTog
RG1pdHJ5IEZvbWljaGV2IDxkbWl0cnkuZm9taWNoZXZAd2RjLmNvbT4NCj4gPiAtLS0NCj4gPiAg
YmxvY2svbnZtZS5jICAgICAgICAgfCAgIDIgKy0NCj4gPiAgaHcvYmxvY2svbnZtZS1ucy5jICAg
fCAxODUgKysrKysrKystDQo+ID4gIGh3L2Jsb2NrL252bWUtbnMuaCAgIHwgICA2ICstDQo+ID4g
IGh3L2Jsb2NrL252bWUuYyAgICAgIHwgODcyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0NCj4gPiAgaW5jbHVkZS9ibG9jay9udm1lLmggfCAgIDYgKy0NCj4gPiAg
NSBmaWxlcyBjaGFuZ2VkLCAxMDMzIGluc2VydGlvbnMoKyksIDM4IGRlbGV0aW9ucygtKQ0KPiA+
IA0KPiA+IGRpZmYgLS1naXQgYS9ibG9jay9udm1lLmMgYi9ibG9jay9udm1lLmMNCj4gPiBpbmRl
eCAwNTQ4NWZkZDExLi43YTUxM2M5YTE3IDEwMDY0NA0KPiA+IC0tLSBhL2Jsb2NrL252bWUuYw0K
PiA+ICsrKyBiL2Jsb2NrL252bWUuYw0KPiA+ICtzdGF0aWMgaW50IG52bWVfY2FsY196b25lX2dl
b21ldHJ5KE52bWVOYW1lc3BhY2UgKm5zLCBFcnJvciAqKmVycnApDQo+ID4gK3sNCj4gPiArICAg
IHVpbnQ2NF90IHpvbmVfc2l6ZSwgem9uZV9jYXA7DQo+ID4gKyAgICB1aW50MzJfdCBueiwgbGJh
c3ogPSBucy0+YmxrY29uZi5sb2dpY2FsX2Jsb2NrX3NpemU7DQo+ID4gKw0KPiA+ICsgICAgaWYg
KG5zLT5wYXJhbXMuem9uZV9zaXplX21iKSB7DQo+ID4gKyAgICAgICAgem9uZV9zaXplID0gbnMt
PnBhcmFtcy56b25lX3NpemVfbWI7DQo+ID4gKyAgICB9IGVsc2Ugew0KPiA+ICsgICAgICAgIHpv
bmVfc2l6ZSA9IE5WTUVfREVGQVVMVF9aT05FX1NJWkU7DQo+ID4gKyAgICB9DQo+ID4gKyAgICBp
ZiAobnMtPnBhcmFtcy56b25lX2NhcGFjaXR5X21iKSB7DQo+ID4gKyAgICAgICAgem9uZV9jYXAg
PSBucy0+cGFyYW1zLnpvbmVfY2FwYWNpdHlfbWI7DQo+ID4gKyAgICB9IGVsc2Ugew0KPiA+ICsg
ICAgICAgIHpvbmVfY2FwID0gem9uZV9zaXplOw0KPiA+ICsgICAgfQ0KPiANCj4gSSB0aGluayBh
IGNoZWNrIHRoYXQgem9uZV9jYXBhY2l0eV9tYiBpcyBsZXNzIHRoYW4gb3IgZXF1YWwgdG8NCj4g
em9uZV9zaXplX21iIGlzIG1pc3NpbmcgZWFybGllcj8NCg0KVGhlIGNoZWNrIGlzIHJpZ2h0IGJl
bG93LCBidXQgSSBub3cgdGhpbmsgaXQgaXMgYmV0dGVyIHRvDQpjb21wYXJlIGJ5dGUgc2l6ZXMg
cmF0aGVyIHRoYW4gbnVtYmVycyBvZiBMQkFzLiBUaGVyZSBhcmUgYWxzbw0KY2hlY2tzIG1pc3Np
bmcgZm9yIHpvbmVfc2l6ZSA+PSBsYmFzeiBhbmQgem9uZV9jYXAgPj0gbGJhc3ogdGhhdA0KSSBh
bSBhZGRpbmcuDQoNCj4gDQo+ID4gK3N0YXRpYyBpbnQgbnZtZV96b25lZF9pbml0X25zKE52bWVD
dHJsICpuLCBOdm1lTmFtZXNwYWNlICpucywgaW50IGxiYV9pbmRleCwNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0KPiA+ICt7DQo+ID4gKyAgICBOdm1l
SWROc1pvbmVkICppZF9uc196Ow0KPiA+ICsNCj4gPiArICAgIGlmIChuLT5wYXJhbXMuZmlsbF9w
YXR0ZXJuID09IDApIHsNCj4gPiArICAgICAgICBucy0+aWRfbnMuZGxmZWF0IHw9IDB4MDE7DQo+
ID4gKyAgICB9IGVsc2UgaWYgKG4tPnBhcmFtcy5maWxsX3BhdHRlcm4gPT0gMHhmZikgew0KPiA+
ICsgICAgICAgIG5zLT5pZF9ucy5kbGZlYXQgfD0gMHgwMjsNCj4gPiArICAgIH0NCj4gPiArDQo+
ID4gKyAgICBpZiAobnZtZV9jYWxjX3pvbmVfZ2VvbWV0cnkobnMsIGVycnApICE9IDApIHsNCj4g
PiArICAgICAgICByZXR1cm4gLTE7DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICsgICAgbnZtZV9p
bml0X3pvbmVfbWV0YShucyk7DQo+ID4gKw0KPiA+ICsgICAgaWRfbnNfeiA9IGdfbWFsbG9jMChz
aXplb2YoTnZtZUlkTnNab25lZCkpOw0KPiA+ICsNCj4gPiArICAgIC8qIE1BUi9NT1IgYXJlIHpl
cm9lcy1iYXNlZCwgMHhmZmZmZmZmZiBtZWFucyBubyBsaW1pdCAqLw0KPiA+ICsgICAgaWRfbnNf
ei0+bWFyID0gMHhmZmZmZmZmZjsNCj4gPiArICAgIGlkX25zX3otPm1vciA9IDB4ZmZmZmZmZmY7
DQo+ID4gKyAgICBpZF9uc196LT56b2MgPSAwOw0KPiA+ICsgICAgaWRfbnNfei0+b3pjcyA9IG5z
LT5wYXJhbXMuY3Jvc3Nfem9uZV9yZWFkID8gMHgwMSA6IDB4MDA7DQo+ID4gKw0KPiA+ICsgICAg
aWRfbnNfei0+bGJhZmVbbGJhX2luZGV4XS56c3plID0gY3B1X3RvX2xlNjQobnMtPnpvbmVfc2l6
ZSk7DQo+ID4gKyAgICBpZF9uc196LT5sYmFmZVtsYmFfaW5kZXhdLnpkZXMgPSAwOyAvKiBGSVhN
RSBtYWtlIGhlbHBlciAqLw0KPiA+ICsNCj4gPiArICAgIG5zLT5jc2kgPSBOVk1FX0NTSV9aT05F
RDsNCj4gPiArICAgIG5zLT5pZF9ucy5uY2FwID0gY3B1X3RvX2xlNjQobnMtPnpvbmVfY2FwYWNp
dHkgKiBucy0+bnVtX3pvbmVzKTsNCj4gPiArICAgIG5zLT5pZF9ucy5udXNlID0gbnMtPmlkX25z
Lm5jYXA7DQo+ID4gKyAgICBucy0+aWRfbnMubnN6ZSA9IG5zLT5pZF9ucy5uY2FwOw0KPiA+ICsN
Cj4gDQo+IE5TWkUgc2hvdWxkIGJlIGluIHRlcm1zIG9mIFpTWkUuIFdlICpjYW4qIHJlcG9ydCBO
Q0FQIDwgTlNaRSBpZiB6Y2FwICE9DQo+IHpzemUsIGJ1dCB0aGF0IHJlcXVpcmVzIGJpdCAxIHNl
dCBpbiBOU0ZFQVQgYW5kIHByb3BlciByZXBvcnRpbmcgb2YNCj4gTlVTRS4NCg0KT2ssIHdpbGwg
Y29ycmVjdC4gSSB0aGluayBpdCB1c2VkIHRvIGJlIHRoaXMgd2F5LCBidXQgZ290IG1lc3NlZCB1
cA0KZHVyaW5nIG11bHRpcGxlIHRyYW5zZm9ybWF0aW9ucyBvZiB0aGlzIGNvZGUuDQoNCj4gDQo+
ID4gQEAgLTEzMyw2ICszMDQsMTQgQEAgc3RhdGljIHZvaWQgbnZtZV9uc19yZWFsaXplKERldmlj
ZVN0YXRlICpkZXYsIEVycm9yICoqZXJycCkNCj4gPiAgc3RhdGljIFByb3BlcnR5IG52bWVfbnNf
cHJvcHNbXSA9IHsNCj4gPiAgICAgIERFRklORV9CTE9DS19QUk9QRVJUSUVTKE52bWVOYW1lc3Bh
Y2UsIGJsa2NvbmYpLA0KPiA+ICAgICAgREVGSU5FX1BST1BfVUlOVDMyKCJuc2lkIiwgTnZtZU5h
bWVzcGFjZSwgcGFyYW1zLm5zaWQsIDApLA0KPiA+ICsNCj4gPiArICAgIERFRklORV9QUk9QX0JP
T0woInpvbmVkIiwgTnZtZU5hbWVzcGFjZSwgcGFyYW1zLnpvbmVkLCBmYWxzZSksDQo+ID4gKyAg
ICBERUZJTkVfUFJPUF9VSU5UNjQoInpvbmVfc2l6ZSIsIE52bWVOYW1lc3BhY2UsIHBhcmFtcy56
b25lX3NpemVfbWIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgTlZNRV9ERUZBVUxUX1pP
TkVfU0laRSksDQo+ID4gKyAgICBERUZJTkVfUFJPUF9VSU5UNjQoInpvbmVfY2FwYWNpdHkiLCBO
dm1lTmFtZXNwYWNlLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHBhcmFtcy56b25lX2Nh
cGFjaXR5X21iLCAwKSwNCj4gDQo+IFRoZXJlIGlzIGEgbmljZSBERUZJTkVfUFJPUF9TSVpFIHRo
YXQgaGFuZGxlcyBzaXplcyBpbiBhIG5pY2Ugd2F5IChpLmUuDQo+IDFHLCAxTSkuDQoNCkl0IHNo
b3VsZCBiZSBuaWNlIHRvIHVzZSB0aGVzZSB0eXBlcywgd2lsbCBhZGQgdGhlbS4gX1NJWkUzMiBz
b3VuZHMgbGlrZQ0KYSBnb29kIGNhbmRpZGF0ZSB0byB1c2UgZm9yIFpBU0wuDQoNClRoYW5rIHlv
dSBmb3IgeW91ciB2YWx1YWJsZSBmZWVkYmFjayENCj4gDQo=

