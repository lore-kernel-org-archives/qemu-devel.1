Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA828C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 00:49:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74AD0207D4
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 00:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="W0Mq27PZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jK9pElKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74AD0207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr9tT-0000Id-24
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 20:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=446c5dbe3=Dmitry.Fomichev@wdc.com>)
 id 1jr9pe-0001DL-RU; Thu, 02 Jul 2020 20:45:34 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:34929)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=446c5dbe3=Dmitry.Fomichev@wdc.com>)
 id 1jr9pc-0006dX-Sh; Thu, 02 Jul 2020 20:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593737133; x=1625273133;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=+BZ1+VrPjYOuN1VBelQzhGUiJ59RgU+SLW3uCKkk6EM=;
 b=W0Mq27PZ0Jl569EnmvEXuilCxjfpEGTNA++ZXDx3igtUQltHDEh63Pkv
 NvyOhePj+6j8Ik93K9hDQvBgq75+vwVzybYJWq7o4g9fvrx1ZzJ3dBWA+
 5LA8dfsL6Zvt/wfnqOXtQf5oeenkAX1WJYwIwk2OVcQ0L1AFUntVH9t5R
 hRZ9pbjTfKoNajzOoEcQx/pnGcBSHiX+K2uRi+NX5neiGGOgFvDPQouZg
 uuc6vPBqb7AXownLYtQBGOTWTY0mxeQsI4dfEwk7NqM3RHgM0f8b+9q44
 jTcnxF5Acg3gKwxKZ7RoQZQbVxTVjuNP7JuoclrWQ76B+mepdfWyu9D49 w==;
IronPort-SDR: jgDFxx1MFeVdnnmC2noizI+VpJvVYa9Y5p3qWLi8fUZ1qGdTfXPBAbZfHqjgq1dqJRQ3jAjl4a
 voY7IPKvuZaMlY0PlfPTdeEbT3U6vnp1LJuohACrzjb+XWX3u8zOmTw2sOc5HVX1fOf8Au5Vwq
 wJDZq7ErCae8Fu3RP+9QhD74tU0DQlm3nOB30+596lZtBUEZh2kaesXyQeG2pThm36Xn/ntkZg
 WN+Q5jaALZ4vvF+h/eTFO0D3RKly/aosd/O3Tek4xcP2BfDgJ6vVSUIruScAzDd6aRnHf00cti
 Yzg=
X-IronPort-AV: E=Sophos;i="5.75,306,1589212800"; d="scan'208";a="145864612"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 08:45:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+M3R9xzr2SuWnmES9s3+XU7lbj0xfeSLpTADum9iM1HICFpnxYVI23cwubOk+KZNP1gc+fgAnBT2UMIguF+T/+vo06p8ANQrPPRTUAt6DlmFgRYwtEF0HIoF/McV0q9QMcaMVGiIynNs7B9akAJKhmYsiKijkQi5n7lVGOtr6cKt+CPf49aYvk8V+AUbjxbC59VtE5GYhV/0MdEMgIi1p+S91sMAJgadVmr/tVhEx9LebQRYY9IbRM1vdOdvDwlcxPRhqs0L39gl5dP81TRKpDngHBOFgR332zYewOowRA+nNc7Txfsu4T+BLaOcBZtabuy80dBSS9s9si/RVK0wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BZ1+VrPjYOuN1VBelQzhGUiJ59RgU+SLW3uCKkk6EM=;
 b=LL/lNS96t4qaPIJPXFf6ftHpk8cjYQbPr8lLVLCcPY3JfDVpuv4qS4+ioHlCXsS1wBXIQrr6enCVBPpQjbUwYbs0tu1Pd3/7oECuAq2upkEYvqbnA5oS0sRUIKkyYtbyN7UDmhkl18v53tN6vV7eeLEs/CLo7GXb1yL7Vey3Q0mwCbaZmpSr9eIs/5TUFM3UD85sNoQXhEI932n0SQ56ZnKkmL7tXf3E4TNft78MGwH8FQQxxcty/PzBx5e0Eg7l4QmD7lzLGs6/O6HlZcrtgTjdfJtDZJDu003hgDItkyeuI8XQKEF6cPj6m07sTrQFZ/8FTDZmdYXHGfT+QD0b6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BZ1+VrPjYOuN1VBelQzhGUiJ59RgU+SLW3uCKkk6EM=;
 b=jK9pElKH/aN3Q5+TDlZZgVZcQAv8eKw8yxxcaF1AtJthQKBJ+XKU6zN5ane16Lc5M6YDLTppFnXE4LxvHg8HN1ObHZndykpKhRMgWpEYd018f6ud/E4KjHBkNWUiGsOESpIZRIh5Tf0r0721dTYwD7ywtUfCZ/h2Ts8jwBCQFl4=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5552.namprd04.prod.outlook.com (2603:10b6:208:de::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Fri, 3 Jul
 2020 00:45:29 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9%5]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 00:45:29 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: "its@irrelevant.dk" <its@irrelevant.dk>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 08/17] hw/block/nvme: move NvmeFeatureVal into
 hw/block/nvme.h
Thread-Topic: [PATCH 08/17] hw/block/nvme: move NvmeFeatureVal into
 hw/block/nvme.h
Thread-Index: AQHWTkM9SpfJTqxCVE2FDr6b1rfrdKj1CfcA
Date: Fri, 3 Jul 2020 00:45:29 +0000
Message-ID: <86c8668e89703820801b841f6036bc723b364f9e.camel@wdc.com>
References: <20200629182642.1170387-1-its@irrelevant.dk>
 <20200629182642.1170387-9-its@irrelevant.dk>
In-Reply-To: <20200629182642.1170387-9-its@irrelevant.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [173.70.233.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f25a083f-8540-4978-c63a-08d81eea6268
x-ms-traffictypediagnostic: MN2PR04MB5552:
x-microsoft-antispam-prvs: <MN2PR04MB55526081E7A4227CBA3FABC8E16A0@MN2PR04MB5552.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KWHq5ECqIkvldq0ZeX8eVo9ANA/d6jrmyZCHMJK5Hc+xmImsvhtmqooKA/Rf2ajN/aRMBd25NTiwu93xhfqQvG0qsQz9vJ/yzGRH8vELpB8oLkfp25wmJdx/JIFCmSouT/b62TZYqwKhrlsSOuVvRtDHC/xLBhckWBKn9ZHJxTgmkas+RfF40e+Bh7/5A8GuTEXlbWe2i8pmQbMKqpZki9IOluLqv+Dj80LJqd3SlUU6WFalb9RWTAw/YoljOWvpOpGRQdcN0gNNhgueFijrsd3+dhDMyfrW2g8o5Sif8BAfYzLE+9AoUpbDr9nO82X5q2KY0jV6c/VC3eAU4VZoVw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(4326008)(186003)(76116006)(2616005)(83380400001)(6486002)(6512007)(110136005)(66946007)(66476007)(66446008)(54906003)(64756008)(66556008)(36756003)(71200400001)(8936002)(26005)(86362001)(316002)(5660300002)(2906002)(8676002)(478600001)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: reAmCv9gOJXmqvEVExKNaNcxD9W5v/gle44GbK0Zea+aDJomF87ELNYRswErdh0jb+lZaUQY19r71uFjLMSlL519Ag2Cio3R2lPrEzsaKJGnvLnEx29qPuvdWmAvJaIQcEQaL70y7iiksyhs/2M25iHQ+x/NDndZoy+M9mesRjryrANal0tsOtiStNCogWedRVEpPVwXIcvlklyyvzdPGlvCbwlTREdXg4ah+DXDkyZ+/4XDaowRSnG8T08rzk9fC0C19NzoNVkHvMsEjsOwi+XMA/zBbhmUva+ImeG+Jieclu9XjP8TWsa6jnl1Svz47Z78Cq4+0d90k7V6RGPmR9XRZrKwrFXGB3KStxwqaNkAxc5zQLhLs+5N8Jrsie09LHiiA0L0UPxcJnguZDwOG/T05upzlNTb+bDtqBtZNPojZXSVZLaU8W0nkX9+atstKFAaIyP1P1Wy+MrsTXTG576T7m2rW+TMJAe0Atqtdn8wKbBgJNF9yth1neJS7J1L
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFFADAA8550151499F4E391069F33F13@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f25a083f-8540-4978-c63a-08d81eea6268
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 00:45:29.3810 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vA97aK0JBP0gbEPrGRF/rHq+Z3LFnPE4l+RNzRZAi0p5Syo0/zt0kTuheTl1EEjixfCv0z4Hkzfy4dhQKAXBnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5552
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=446c5dbe3=Dmitry.Fomichev@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 20:44:57
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "k.jensen@samsung.com" <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IERtaXRyeSBGb21pY2hldiA8ZG1pdHJ5LmZvbWlj
aGV2QHdkYy5jb20+DQoNCk9uIE1vbiwgMjAyMC0wNi0yOSBhdCAyMDoyNiArMDIwMCwgS2xhdXMg
SmVuc2VuIHdyb3RlOg0KPiBGcm9tOiBLbGF1cyBKZW5zZW4gPGsuamVuc2VuQHNhbXN1bmcuY29t
Pg0KPiANCj4gVGhlIE52bWVGZWF0dXJlVmFsIGRvZXMgbm90IGJlbG9uZyB3aXRoIHRoZSBzcGVj
LXJlbGF0ZWQgZGF0YSBzdHJ1Y3R1cmVzDQo+IGluIGluY2x1ZGUvYmxvY2svbnZtZS5oIHRoYXQg
aXMgc2hhcmVkIGJldHdlZW4gdGhlIGJsb2NrLWxldmVsIG52bWUNCj4gZHJpdmVyIGFuZCB0aGUg
ZW11bGF0ZWQgbnZtZSBkZXZpY2UuDQo+IA0KPiBNb3ZlIGl0IGludG8gdGhlIG52bWUgZGV2aWNl
IHNwZWNpZmljIGhlYWRlciBmaWxlIGFzIGl0IGlzIHRoZSBvbmx5DQo+IHVzZXIgb2YgdGhlIHN0
cnVjdHVyZS4gQWxzbywgcmVtb3ZlIHRoZSB1bnVzZWQgbWVtYmVycy4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEtsYXVzIEplbnNlbiA8ay5qZW5zZW5Ac2Ftc3VuZy5jb20+DQo+IC0tLQ0KPiAgaHcv
YmxvY2svbnZtZS5oICAgICAgfCAxMSArKysrKysrKysrKw0KPiAgaW5jbHVkZS9ibG9jay9udm1l
LmggfCAyMCAtLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNl
cnRpb25zKCspLCAyMCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9ibG9jay9u
dm1lLmggYi9ody9ibG9jay9udm1lLmgNCj4gaW5kZXggMWY2NGEwZTk0MDM1Li4xNmEyNTRkMzBi
NGUgMTAwNjQ0DQo+IC0tLSBhL2h3L2Jsb2NrL252bWUuaA0KPiArKysgYi9ody9ibG9jay9udm1l
LmgNCj4gQEAgLTc5LDYgKzc5LDE3IEBAIHN0YXRpYyBpbmxpbmUgdWludDhfdCBudm1lX25zX2xi
YWRzKE52bWVOYW1lc3BhY2UgKm5zKQ0KPiAgI2RlZmluZSBOVk1FKG9iaikgXA0KPiAgICAgICAg
ICBPQkpFQ1RfQ0hFQ0soTnZtZUN0cmwsIChvYmopLCBUWVBFX05WTUUpDQo+ICANCj4gK3R5cGVk
ZWYgc3RydWN0IE52bWVGZWF0dXJlVmFsIHsNCj4gKyAgICB1bmlvbiB7DQo+ICsgICAgICAgIHN0
cnVjdCB7DQo+ICsgICAgICAgICAgICB1aW50MTZfdCB0ZW1wX3RocmVzaF9oaTsNCj4gKyAgICAg
ICAgICAgIHVpbnQxNl90IHRlbXBfdGhyZXNoX2xvdzsNCj4gKyAgICAgICAgfTsNCj4gKyAgICAg
ICAgdWludDMyX3QgdGVtcF90aHJlc2g7DQo+ICsgICAgfTsNCj4gKyAgICB1aW50MzJfdCAgICBh
c3luY19jb25maWc7DQo+ICt9IE52bWVGZWF0dXJlVmFsOw0KPiArDQo+ICB0eXBlZGVmIHN0cnVj
dCBOdm1lQ3RybCB7DQo+ICAgICAgUENJRGV2aWNlICAgIHBhcmVudF9vYmo7DQo+ICAgICAgTWVt
b3J5UmVnaW9uIGlvbWVtOw0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ibG9jay9udm1lLmggYi9p
bmNsdWRlL2Jsb2NrL252bWUuaA0KPiBpbmRleCBlOTg1ODRlMzgxMzQuLmM5ZjIzMmE3MGU5OCAx
MDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9ibG9jay9udm1lLmgNCj4gKysrIGIvaW5jbHVkZS9ibG9j
ay9udm1lLmgNCj4gQEAgLTg2NSwyNiArODY1LDYgQEAgZW51bSBOdm1lSWRDdHJsTHBhIHsNCj4g
ICNkZWZpbmUgTlZNRV9DVFJMX1NHTFNfTVBUUl9TR0wgICAgICAgICAgICAgICAgICAoMHgxIDw8
IDE5KQ0KPiAgI2RlZmluZSBOVk1FX0NUUkxfU0dMU19BRERSX09GRlNFVCAgICAgICAgICAgICAg
ICgweDEgPDwgMjApDQo+ICANCj4gLXR5cGVkZWYgc3RydWN0IE52bWVGZWF0dXJlVmFsIHsNCj4g
LSAgICB1aW50MzJfdCAgICBhcmJpdHJhdGlvbjsNCj4gLSAgICB1aW50MzJfdCAgICBwb3dlcl9t
Z210Ow0KPiAtICAgIHVuaW9uIHsNCj4gLSAgICAgICAgc3RydWN0IHsNCj4gLSAgICAgICAgICAg
IHVpbnQxNl90IHRlbXBfdGhyZXNoX2hpOw0KPiAtICAgICAgICAgICAgdWludDE2X3QgdGVtcF90
aHJlc2hfbG93Ow0KPiAtICAgICAgICB9Ow0KPiAtICAgICAgICB1aW50MzJfdCB0ZW1wX3RocmVz
aDsNCj4gLSAgICB9Ow0KPiAtICAgIHVpbnQzMl90ICAgIGVycl9yZWM7DQo+IC0gICAgdWludDMy
X3QgICAgdm9sYXRpbGVfd2M7DQo+IC0gICAgdWludDMyX3QgICAgbnVtX3F1ZXVlczsNCj4gLSAg
ICB1aW50MzJfdCAgICBpbnRfY29hbGVzY2luZzsNCj4gLSAgICB1aW50MzJfdCAgICAqaW50X3Zl
Y3Rvcl9jb25maWc7DQo+IC0gICAgdWludDMyX3QgICAgd3JpdGVfYXRvbWljaXR5Ow0KPiAtICAg
IHVpbnQzMl90ICAgIGFzeW5jX2NvbmZpZzsNCj4gLSAgICB1aW50MzJfdCAgICBzd19wcm9nX21h
cmtlcjsNCj4gLX0gTnZtZUZlYXR1cmVWYWw7DQo+IC0NCj4gICNkZWZpbmUgTlZNRV9BUkJfQUIo
YXJiKSAgICAoYXJiICYgMHg3KQ0KPiAgI2RlZmluZSBOVk1FX0FSQl9MUFcoYXJiKSAgICgoYXJi
ID4+IDgpICYgMHhmZikNCj4gICNkZWZpbmUgTlZNRV9BUkJfTVBXKGFyYikgICAoKGFyYiA+PiAx
NikgJiAweGZmKQ0K

