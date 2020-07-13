Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61127C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 00:57:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15467206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 00:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ofpp+v7M";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FWXYK9k4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15467206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jummF-00046P-D3
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 20:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=456505283=Dmitry.Fomichev@wdc.com>)
 id 1jumlc-0003c6-CR; Sun, 12 Jul 2020 20:56:24 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:29760)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=456505283=Dmitry.Fomichev@wdc.com>)
 id 1jumlZ-0007f9-Fq; Sun, 12 Jul 2020 20:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594601816; x=1626137816;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=0rNQizfTKn0gDnPodZlVAsuZGcrcmrBCpZKPow4C70I=;
 b=ofpp+v7M1aWhvf+VeITlED5eL45lgBAkH7w7jmzpQOxBJBZdY+ObQaGg
 GXY8zXuqVKS1f0eVXOac6Lgiqc7hjdYYBvtT+MQck89kQeJP9Oizxm0fv
 vSTfCgmM+A48CwC7adXAc+YX/0ujRUV2x1WFDiTFCh6z3HiHh64N/NEc0
 jvclSeWD4OgjstKiY777gptouTCXEcznbMG0rO7kidG0WjyAL1VI82pA5
 UdTQreKS6DiPuiAgwdhyhwEEaXji4MR9JFUG/Qtz26iBmEbFMySJynUWd
 T9HHUBh9HQY58XvzcR03t+/5v1G1KgeAU1KKG5z3pt8J6lVtLWe+IfnGZ Q==;
IronPort-SDR: orOKU9V9iVNwhN0Rf7J5dN1iHY2NwdJMnTkDK9gAME+a6scszkR/ropHAk9kfzMeWpiRjZ35De
 /GcwQfYj3G5l4wD/YNjXgfuJr6nIoh82MnPK/v/eauv4Faz03IIS5IB4PbXeHEwTADO99XV1G+
 gGYXP6C6ZdgPLcCvoTQE43zAr1bHlJ9T9g5ewChSdbdJUrShkWjyBavch9b0fE7APydlmLVyyi
 ugl7Cmk9EKwmIJ+qSMFRo5jT/BVJf3PamxgBpLiGp2rvl/U1DqjjgJGzziv4FywxeLzvgm4q2D
 eIA=
X-IronPort-AV: E=Sophos;i="5.75,345,1589212800"; d="scan'208";a="245301206"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
 by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2020 08:56:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGLdNCI29Qz5Faw3Ro6e2UV5KIWIx8LIYL6EAgjl2gxs2LjHAE236cxsvHVe2YvLe4R/vMPENSc7/nW0zM33Nh65C7TzEifnlFg47GtSN+LbuQmrq/JkYueyhgEb85pdMWPq0fwRhk0AK/Q1ULyb+wppQTjJhx35EknaVh0MDctLrDfdc3gSJNDN9H9fhvcsWrTMJO9Npr2szjbdYWy0XtznxJNTVK2yf9io8U76nQdqtvcgD1qs2nkCxGF03+KG88wSejXZz2/pLYU4ZECm8mtsTGRyXzpD2PaWNJrFJ6BSL+wAS8HZyMouH9l2ExbhDpEJZL2MuMgLC7KVQrehiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rNQizfTKn0gDnPodZlVAsuZGcrcmrBCpZKPow4C70I=;
 b=H/pk/WM00Xu/oA9LtxJOmPmNRvmguCWI56Pc4dVNPmTUfSwphe1cupdmG7Vt2snd/mwllEvobryf7T9eevc8bFHI/cRlY2zPn/b0XI5+3AFapGe8XSM8K4RklzcUkTgNbdJWGCoGiTpHA4Jrog+Pz1kM0c+hDqVKGiC5kCTnLYlNZAjdSET5wFSdVEllgBZo3yUS5OfFNjG2ulChGJLiRe7BTJ5thxEFyMyDsPAtuWuKSpiPzsYDI8hWwA5rlxOhjBw0M6ixgpUhcO3ppJ3uOkSv30Y9wvQ/SayHDsIZjuoxAfB1DfhcFoUQBWYeW08Zzimsye+tqgYPqr0TSzGrQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rNQizfTKn0gDnPodZlVAsuZGcrcmrBCpZKPow4C70I=;
 b=FWXYK9k4fwnvC3E4d4gPGmq2B3AUMmzNROaIG6eq7scPes9pSGCznrUQuKwBRIzY3C+u75mjOjH9XY3ici0BIdIb8ODrgsg/wpkh1uTfCAgIZPuym+y5KOsJrkB+/2c4aCsKuUXt6b6/pQbLiIt7Vg4GqoArHzmlnDv31+mpOqE=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB6048.namprd04.prod.outlook.com (2603:10b6:208:e5::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Mon, 13 Jul
 2020 00:56:13 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9%5]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 00:56:12 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: "philmd@redhat.com" <philmd@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 2/4] hw/block/nvme: Use QEMU_PACKED on hardware/packet
 structures
Thread-Topic: [PATCH v3 2/4] hw/block/nvme: Use QEMU_PACKED on hardware/packet
 structures
Thread-Index: AQHWTs6Gu6Cf1/K7T06RUzVF8fhvAKkEwy+A
Date: Mon, 13 Jul 2020 00:56:12 +0000
Message-ID: <19f7e8a845047684e39f5087753f8f290638f15d.camel@wdc.com>
References: <20200630110429.19972-1-philmd@redhat.com>
 <20200630110429.19972-3-philmd@redhat.com>
In-Reply-To: <20200630110429.19972-3-philmd@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [100.35.204.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 78bacdc0-011d-4146-687a-08d826c78a03
x-ms-traffictypediagnostic: MN2PR04MB6048:
x-microsoft-antispam-prvs: <MN2PR04MB60485402FDF54E25CE20BD6AE1600@MN2PR04MB6048.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aHLhAY8oBVjDR/VwVznRdN2AjvExOr+VMDU5fusg2cxBdKf5Dq0LiEB+6eNdGwQVGXo2CpYQSyZCsuiJYtPGP/Gkdoa3DDKLeco66loBEC3hKNA1VddBw6AHnnPohxU5IPzM8p7x5BzORnjc4FQNlP3y1mduHm5QHUJmYMLfdHDkCr98N44g2nl3o3h0jPtTG4N/GQWIP9/LXfYzpSG8WsMnB5qfUmOoy74DyeZ2WBx97X/AFGgYbtOYWbSdFxhxuYMXaheztzqMugvZFRnUcPTU7hI3Lne2DEOBTgyNZ5jxLNuGgruPPT+Mfm13kFZ3mlKqRy/3dfKZ3a0OmYN00Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39850400004)(346002)(376002)(366004)(71200400001)(5660300002)(316002)(83380400001)(8936002)(8676002)(4326008)(2616005)(36756003)(478600001)(54906003)(86362001)(76116006)(26005)(66946007)(6486002)(64756008)(186003)(110136005)(2906002)(6512007)(6506007)(66556008)(66446008)(66476007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: /Bj6kd51JgLWACikEs2hx9iv3kyR3+bwMUP2UHUwP23BSeHOwRGzRMmDlx3RGUPsDsXScq4X0ua43N+lyQyfj9KXZxJPYQyNgOzqnOP/Vg7jNz9XdcgYZMf75RveK19DTrrKFWOS+wxWMl2SNFNd6f+9RfxLgCJk2QvdnxAPnsMBE1rp+68+dlF6XUDH7Nu3odoLKSUYuEiwVT8epx4LCtbpU780ykWCVQWe5gJF92JWVM3xADhXsFgn/JAhLTsBI2vwpfa1NWL9igV9HTczW18iQE+aiDpVuz6pU6XZwSDlkAPaPwLbqUwGeyeL2a9JMIOCw9S2AmdQBuSfGvk59fYAWlzl/A5oGNY9uClLqyd5YNywrMnnLTI0roR2gabvNX49PCvFaNyryYpBQ6lGFtVb0Gicwd4TxpfZ7HqjGe0x5VHwwcSPus3J3GACyPgUIVVrWDGAnnO5ahF7/ye90XBGB4zOtHkhS9crdCjEyaSNpiVbsEZfvb7FXhDM5nsX
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FE46B9827DB59409B4FEB9DE79ADFCC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78bacdc0-011d-4146-687a-08d826c78a03
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 00:56:12.7472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pEbLvEJhV73C1FbKrSoese5amhy7IeOrJmW1UC9d0teAYX5BiaunY6QCpBTkQQPE1bsnm/NwgNPs2zdkVoeeRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6048
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=456505283=Dmitry.Fomichev@wdc.com; helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/12 20:56:17
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "k.jensen@samsung.com" <k.jensen@samsung.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQpPbiBUdWUsIDIwMjAtMDYtMzAgYXQgMTM6MDQgKzAyMDAsIFBoaWxpcHBlIE1hdGhpZXUtRGF1
ZMOpIHdyb3RlOg0KPiBUaGVzZSBzdHJ1Y3R1cmVzIGVpdGhlciBkZXNjcmliZSBoYXJkd2FyZSBy
ZWdpc3RlcnMsIG9yDQo+IGNvbW1hbmRzICgncGFja2V0cycpIHRvIHNlbmQgdG8gdGhlIGhhcmR3
YXJlLiBUbyBmb3JiaWQNCj4gdGhlIGNvbXBpbGVyIHRvIG9wdGltaXplIGFuZCBjaGFuZ2UgZmll
bGRzIGFsaWdubWVudCwNCj4gbWFyayB0aGUgc3RydWN0dXJlcyBhcyBwYWNrZWQuDQo+IA0KPiBS
ZXZpZXdlZC1ieTogS2xhdXMgSmVuc2VuIDxrLmplbnNlbkBzYW1zdW5nLmNvbT4NCj4gU2lnbmVk
LW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPg0KPiAt
LS0NCj4gIGluY2x1ZGUvYmxvY2svbnZtZS5oIHwgMzggKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAxOSBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2Jsb2NrL252bWUuaCBiL2lu
Y2x1ZGUvYmxvY2svbnZtZS5oDQo+IGluZGV4IDE3MjBlZTFkNTEuLjcxYzU2ODE5MTIgMTAwNjQ0
DQo+IC0tLSBhL2luY2x1ZGUvYmxvY2svbnZtZS5oDQo+ICsrKyBiL2luY2x1ZGUvYmxvY2svbnZt
ZS5oDQo+IEBAIC0xLDcgKzEsNyBAQA0KPiAgI2lmbmRlZiBCTE9DS19OVk1FX0gNCj4gICNkZWZp
bmUgQkxPQ0tfTlZNRV9IDQo+ICANCj4gLXR5cGVkZWYgc3RydWN0IE52bWVCYXIgew0KPiArdHlw
ZWRlZiBzdHJ1Y3QgUUVNVV9QQUNLRUQgTnZtZUJhciB7DQo+ICAgICAgdWludDY0X3QgICAgY2Fw
Ow0KPiAgICAgIHVpbnQzMl90ICAgIHZzOw0KPiAgICAgIHVpbnQzMl90ICAgIGludG1zOw0KPiBA
QCAtMzc3LDcgKzM3Nyw3IEBAIGVudW0gTnZtZVBtcm1zY01hc2sgew0KPiAgI2RlZmluZSBOVk1F
X1BNUk1TQ19TRVRfQ0JBKHBtcm1zYywgdmFsKSAgIFwNCj4gICAgICAocG1ybXNjIHw9ICh1aW50
NjRfdCkodmFsICYgUE1STVNDX0NCQV9NQVNLKSA8PCBQTVJNU0NfQ0JBX1NISUZUKQ0KPiAgDQo+
IC10eXBlZGVmIHN0cnVjdCBOdm1lQ21kIHsNCj4gK3R5cGVkZWYgc3RydWN0IFFFTVVfUEFDS0VE
IE52bWVDbWQgew0KPiAgICAgIHVpbnQ4X3QgICAgIG9wY29kZTsNCj4gICAgICB1aW50OF90ICAg
ICBmdXNlOw0KPiAgICAgIHVpbnQxNl90ICAgIGNpZDsNCj4gQEAgLTQyMiw3ICs0MjIsNyBAQCBl
bnVtIE52bWVJb0NvbW1hbmRzIHsNCj4gICAgICBOVk1FX0NNRF9EU00gICAgICAgICAgICAgICAg
PSAweDA5LA0KPiAgfTsNCj4gIA0KPiAtdHlwZWRlZiBzdHJ1Y3QgTnZtZURlbGV0ZVEgew0KPiAr
dHlwZWRlZiBzdHJ1Y3QgUUVNVV9QQUNLRUQgTnZtZURlbGV0ZVEgew0KPiAgICAgIHVpbnQ4X3Qg
ICAgIG9wY29kZTsNCj4gICAgICB1aW50OF90ICAgICBmbGFnczsNCj4gICAgICB1aW50MTZfdCAg
ICBjaWQ7DQo+IEBAIC00MzIsNyArNDMyLDcgQEAgdHlwZWRlZiBzdHJ1Y3QgTnZtZURlbGV0ZVEg
ew0KPiAgICAgIHVpbnQzMl90ICAgIHJzdmQxMVs1XTsNCj4gIH0gTnZtZURlbGV0ZVE7DQo+ICAN
Cj4gLXR5cGVkZWYgc3RydWN0IE52bWVDcmVhdGVDcSB7DQo+ICt0eXBlZGVmIHN0cnVjdCBRRU1V
X1BBQ0tFRCBOdm1lQ3JlYXRlQ3Egew0KPiAgICAgIHVpbnQ4X3QgICAgIG9wY29kZTsNCj4gICAg
ICB1aW50OF90ICAgICBmbGFnczsNCj4gICAgICB1aW50MTZfdCAgICBjaWQ7DQo+IEBAIC00NDks
NyArNDQ5LDcgQEAgdHlwZWRlZiBzdHJ1Y3QgTnZtZUNyZWF0ZUNxIHsNCj4gICNkZWZpbmUgTlZN
RV9DUV9GTEFHU19QQyhjcV9mbGFncykgIChjcV9mbGFncyAmIDB4MSkNCj4gICNkZWZpbmUgTlZN
RV9DUV9GTEFHU19JRU4oY3FfZmxhZ3MpICgoY3FfZmxhZ3MgPj4gMSkgJiAweDEpDQo+ICANCj4g
LXR5cGVkZWYgc3RydWN0IE52bWVDcmVhdGVTcSB7DQo+ICt0eXBlZGVmIHN0cnVjdCBRRU1VX1BB
Q0tFRCBOdm1lQ3JlYXRlU3Egew0KPiAgICAgIHVpbnQ4X3QgICAgIG9wY29kZTsNCj4gICAgICB1
aW50OF90ICAgICBmbGFnczsNCj4gICAgICB1aW50MTZfdCAgICBjaWQ7DQo+IEBAIC00NzQsNyAr
NDc0LDcgQEAgZW51bSBOdm1lUXVldWVGbGFncyB7DQo+ICAgICAgTlZNRV9RX1BSSU9fTE9XICAg
ICA9IDMsDQo+ICB9Ow0KPiAgDQo+IC10eXBlZGVmIHN0cnVjdCBOdm1lSWRlbnRpZnkgew0KPiAr
dHlwZWRlZiBzdHJ1Y3QgUUVNVV9QQUNLRUQgTnZtZUlkZW50aWZ5IHsNCj4gICAgICB1aW50OF90
ICAgICBvcGNvZGU7DQo+ICAgICAgdWludDhfdCAgICAgZmxhZ3M7DQo+ICAgICAgdWludDE2X3Qg
ICAgY2lkOw0KPiBAQCAtNDg2LDcgKzQ4Niw3IEBAIHR5cGVkZWYgc3RydWN0IE52bWVJZGVudGlm
eSB7DQo+ICAgICAgdWludDMyX3QgICAgcnN2ZDExWzVdOw0KPiAgfSBOdm1lSWRlbnRpZnk7DQo+
ICANCj4gLXR5cGVkZWYgc3RydWN0IE52bWVSd0NtZCB7DQo+ICt0eXBlZGVmIHN0cnVjdCBRRU1V
X1BBQ0tFRCBOdm1lUndDbWQgew0KPiAgICAgIHVpbnQ4X3QgICAgIG9wY29kZTsNCj4gICAgICB1
aW50OF90ICAgICBmbGFnczsNCj4gICAgICB1aW50MTZfdCAgICBjaWQ7DQo+IEBAIC01MjgsNyAr
NTI4LDcgQEAgZW51bSB7DQo+ICAgICAgTlZNRV9SV19QUklORk9fUFJDSEtfUkVGICAgID0gMSA8
PCAxMCwNCj4gIH07DQo+ICANCj4gLXR5cGVkZWYgc3RydWN0IE52bWVEc21DbWQgew0KPiArdHlw
ZWRlZiBzdHJ1Y3QgUUVNVV9QQUNLRUQgTnZtZURzbUNtZCB7DQo+ICAgICAgdWludDhfdCAgICAg
b3Bjb2RlOw0KPiAgICAgIHVpbnQ4X3QgICAgIGZsYWdzOw0KPiAgICAgIHVpbnQxNl90ICAgIGNp
ZDsNCj4gQEAgLTU0Nyw3ICs1NDcsNyBAQCBlbnVtIHsNCj4gICAgICBOVk1FX0RTTUdNVF9BRCAg
PSAxIDw8IDIsDQo+ICB9Ow0KPiAgDQo+IC10eXBlZGVmIHN0cnVjdCBOdm1lRHNtUmFuZ2Ugew0K
PiArdHlwZWRlZiBzdHJ1Y3QgUUVNVV9QQUNLRUQgTnZtZURzbVJhbmdlIHsNCj4gICAgICB1aW50
MzJfdCAgICBjYXR0cjsNCj4gICAgICB1aW50MzJfdCAgICBubGI7DQo+ICAgICAgdWludDY0X3Qg
ICAgc2xiYTsNCj4gQEAgLTU2OSwxNCArNTY5LDE0IEBAIGVudW0gTnZtZUFzeW5jRXZlbnRSZXF1
ZXN0IHsNCj4gICAgICBOVk1FX0FFUl9JTkZPX1NNQVJUX1NQQVJFX1RIUkVTSCAgICAgICAgPSAy
LA0KPiAgfTsNCj4gIA0KPiAtdHlwZWRlZiBzdHJ1Y3QgTnZtZUFlclJlc3VsdCB7DQo+ICt0eXBl
ZGVmIHN0cnVjdCBRRU1VX1BBQ0tFRCBOdm1lQWVyUmVzdWx0IHsNCj4gICAgICB1aW50OF90IGV2
ZW50X3R5cGU7DQo+ICAgICAgdWludDhfdCBldmVudF9pbmZvOw0KPiAgICAgIHVpbnQ4X3QgbG9n
X3BhZ2U7DQo+ICAgICAgdWludDhfdCByZXN2Ow0KPiAgfSBOdm1lQWVyUmVzdWx0Ow0KPiAgDQo+
IC10eXBlZGVmIHN0cnVjdCBOdm1lQ3FlIHsNCj4gK3R5cGVkZWYgc3RydWN0IFFFTVVfUEFDS0VE
IE52bWVDcWUgew0KPiAgICAgIHVpbnQzMl90ICAgIHJlc3VsdDsNCj4gICAgICB1aW50MzJfdCAg
ICByc3ZkOw0KPiAgICAgIHVpbnQxNl90ICAgIHNxX2hlYWQ7DQo+IEBAIC02MzQsNyArNjM0LDcg
QEAgZW51bSBOdm1lU3RhdHVzQ29kZXMgew0KPiAgICAgIE5WTUVfTk9fQ09NUExFVEUgICAgICAg
ICAgICA9IDB4ZmZmZiwNCj4gIH07DQo+ICANCj4gLXR5cGVkZWYgc3RydWN0IE52bWVGd1Nsb3RJ
bmZvTG9nIHsNCj4gK3R5cGVkZWYgc3RydWN0IFFFTVVfUEFDS0VEIE52bWVGd1Nsb3RJbmZvTG9n
IHsNCj4gICAgICB1aW50OF90ICAgICBhZmk7DQo+ICAgICAgdWludDhfdCAgICAgcmVzZXJ2ZWQx
WzddOw0KPiAgICAgIHVpbnQ4X3QgICAgIGZyczFbOF07DQo+IEBAIC02NDcsNyArNjQ3LDcgQEAg
dHlwZWRlZiBzdHJ1Y3QgTnZtZUZ3U2xvdEluZm9Mb2cgew0KPiAgICAgIHVpbnQ4X3QgICAgIHJl
c2VydmVkMls0NDhdOw0KPiAgfSBOdm1lRndTbG90SW5mb0xvZzsNCj4gIA0KPiAtdHlwZWRlZiBz
dHJ1Y3QgTnZtZUVycm9yTG9nIHsNCj4gK3R5cGVkZWYgc3RydWN0IFFFTVVfUEFDS0VEIE52bWVF
cnJvckxvZyB7DQo+ICAgICAgdWludDY0X3QgICAgZXJyb3JfY291bnQ7DQo+ICAgICAgdWludDE2
X3QgICAgc3FpZDsNCj4gICAgICB1aW50MTZfdCAgICBjaWQ7DQo+IEBAIC02NTksNyArNjU5LDcg
QEAgdHlwZWRlZiBzdHJ1Y3QgTnZtZUVycm9yTG9nIHsNCj4gICAgICB1aW50OF90ICAgICByZXN2
WzM1XTsNCj4gIH0gTnZtZUVycm9yTG9nOw0KPiAgDQo+IC10eXBlZGVmIHN0cnVjdCBOdm1lU21h
cnRMb2cgew0KPiArdHlwZWRlZiBzdHJ1Y3QgUUVNVV9QQUNLRUQgTnZtZVNtYXJ0TG9nIHsNCj4g
ICAgICB1aW50OF90ICAgICBjcml0aWNhbF93YXJuaW5nOw0KPiAgICAgIHVpbnQ4X3QgICAgIHRl
bXBlcmF0dXJlWzJdOw0KPiAgICAgIHVpbnQ4X3QgICAgIGF2YWlsYWJsZV9zcGFyZTsNCj4gQEAg
LTY5Myw3ICs2OTMsNyBAQCBlbnVtIExvZ0lkZW50aWZpZXIgew0KPiAgICAgIE5WTUVfTE9HX0ZX
X1NMT1RfSU5GTyAgID0gMHgwMywNCj4gIH07DQo+ICANCj4gLXR5cGVkZWYgc3RydWN0IE52bWVQ
U0Qgew0KPiArdHlwZWRlZiBzdHJ1Y3QgUUVNVV9QQUNLRUQgTnZtZVBTRCB7DQo+ICAgICAgdWlu
dDE2X3QgICAgbXA7DQo+ICAgICAgdWludDE2X3QgICAgcmVzZXJ2ZWQ7DQo+ICAgICAgdWludDMy
X3QgICAgZW5sYXQ7DQo+IEBAIC03MTMsNyArNzEzLDcgQEAgZW51bSB7DQo+ICAgICAgTlZNRV9J
RF9DTlNfTlNfQUNUSVZFX0xJU1QgPSAweDIsDQo+ICB9Ow0KPiAgDQo+IC10eXBlZGVmIHN0cnVj
dCBOdm1lSWRDdHJsIHsNCj4gK3R5cGVkZWYgc3RydWN0IFFFTVVfUEFDS0VEIE52bWVJZEN0cmwg
ew0KPiAgICAgIHVpbnQxNl90ICAgIHZpZDsNCj4gICAgICB1aW50MTZfdCAgICBzc3ZpZDsNCj4g
ICAgICB1aW50OF90ICAgICBzblsyMF07DQo+IEBAIC04MDcsNyArODA3LDcgQEAgZW51bSBOdm1l
RmVhdHVyZUlkcyB7DQo+ICAgICAgTlZNRV9TT0ZUV0FSRV9QUk9HUkVTU19NQVJLRVIgICA9IDB4
ODANCj4gIH07DQo+ICANCj4gLXR5cGVkZWYgc3RydWN0IE52bWVSYW5nZVR5cGUgew0KPiArdHlw
ZWRlZiBzdHJ1Y3QgUUVNVV9QQUNLRUQgTnZtZVJhbmdlVHlwZSB7DQo+ICAgICAgdWludDhfdCAg
ICAgdHlwZTsNCj4gICAgICB1aW50OF90ICAgICBhdHRyaWJ1dGVzOw0KPiAgICAgIHVpbnQ4X3Qg
ICAgIHJzdmQyWzE0XTsNCj4gQEAgLTgxNywxMyArODE3LDEzIEBAIHR5cGVkZWYgc3RydWN0IE52
bWVSYW5nZVR5cGUgew0KPiAgICAgIHVpbnQ4X3QgICAgIHJzdmQ0OFsxNl07DQo+ICB9IE52bWVS
YW5nZVR5cGU7DQo+ICANCj4gLXR5cGVkZWYgc3RydWN0IE52bWVMQkFGIHsNCj4gK3R5cGVkZWYg
c3RydWN0IFFFTVVfUEFDS0VEIE52bWVMQkFGIHsNCj4gICAgICB1aW50MTZfdCAgICBtczsNCj4g
ICAgICB1aW50OF90ICAgICBkczsNCj4gICAgICB1aW50OF90ICAgICBycDsNCj4gIH0gTnZtZUxC
QUY7DQo+ICANCj4gLXR5cGVkZWYgc3RydWN0IE52bWVJZE5zIHsNCj4gK3R5cGVkZWYgc3RydWN0
IFFFTVVfUEFDS0VEIE52bWVJZE5zIHsNCj4gICAgICB1aW50NjRfdCAgICBuc3plOw0KPiAgICAg
IHVpbnQ2NF90ICAgIG5jYXA7DQo+ICAgICAgdWludDY0X3QgICAgbnVzZTsNCj4gLS0gDQo+IDIu
MjEuMw0KPiANCj4gDQoNClJldmlld2VkLWJ5OiBEbWl0cnkgRm9taWNoZXYgPGRtaXRyeS5mb21p
Y2hldkB3ZGMuY29tPg0KDQo=

