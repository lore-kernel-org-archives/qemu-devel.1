Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589D0C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 01:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FD192067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 01:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="M0GuLvtF";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wcNuB5as"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD192067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jumwu-0006Ln-Cb
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 21:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=456505283=Dmitry.Fomichev@wdc.com>)
 id 1jumw2-0005IS-Cc; Sun, 12 Jul 2020 21:07:10 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:2425)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=456505283=Dmitry.Fomichev@wdc.com>)
 id 1jumw0-0000K9-HV; Sun, 12 Jul 2020 21:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594602428; x=1626138428;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=V/T+qMenAQl957qi+pKiqs035vSEYDk9uvp5+MJ5d1w=;
 b=M0GuLvtFDsuMcLPVROEFTiFc+GQK8VsrIeeQ56BoTg58BWGLmeg8irEh
 geIm9wn8o5G0EAW7+Hz6cJHyb4eopbZDkqAh6n6deo0r1KBuVVraRJgMY
 plA2BIdUfEnC9JQPBcUvSsp2UdOx3vAnFBW7olHTenUJCdT9jF9plv27K
 VqPm+EJVqAxzL2qG3Tinb8VtsmW2HFYtCLV6bJ7kFKvZDW0LfLCPu43I9
 VKoI9zfgtO5HXeiIhtOkYYpaehVtElmQlAuewQRQdgO9PE43CtW4tExBs
 70heGlCJsHM6xIvMd7ADononQv4+l0CNGjC0BcxB0cSNIvSzf28/G5Ng+ A==;
IronPort-SDR: 8uXO2RrO6/SZOfjwSeQiLRoHsRpZbpUpwPKD2MoV7wPokfknATGehJPaA0xBcUf2IAoESczaqu
 fqOs2M5DLIX7ktJ/sICaeRn1qOYFcbL1shSmxzwFmp5xmuCWqeVfsWcMgP+uWrsfGQTsiqpkmd
 jn9BgVXYjsZGGIDgcznWqsiGxQfObONc4uhZ265ZvAsTcK5QPEdpD4pvfKvxCPE7OnbJG2ZXfy
 v5gcLbqjUBPKLTPAEpoyPJy4UeIruj2UqemKL/X92TaU/J+zVQZ/KjHSgaQ9Ozkz8Ir8bULz9O
 cmA=
X-IronPort-AV: E=Sophos;i="5.75,345,1589212800"; d="scan'208";a="143586914"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
 by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2020 09:07:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gl2gxwntq1ebJBOQb676i93N/4jqdhnvf1IKNB0FXw8/VXPpy08MDPq/4wM4Hxrl6YHZwmhQb9YHYM9dlntVKQs+37/KrFl08mP+bzC4xKhj94aGkaTfPsGlGjxJt4TFE0gP+RqHNkEEDmLLxF3kteBvAAL4UXTWat9fw0Ar3gMxz3P2/KMHyFHSTIdZ7rMbT30TvQWJkqmaKjgHluBePA+pCdnl+BNkNGIP1P5Xz95FIAmrOdDF+zpdF58lV0EC0cF3SAbUVrPMgxmJnJoepi3h7yspvE6uDEeUR4SbvKF0yXskasIL6D6QZy1CPrY/nIZ0T0WC2y6cTFGD8FahGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/T+qMenAQl957qi+pKiqs035vSEYDk9uvp5+MJ5d1w=;
 b=b+ZAnEbA1DOZx+eSnOs18fsh3y/MmD2BvdTI8PHDGFH7U9FNN3wmxqCvUgVe4j4c2A6huCOt6kj3XCYJ9I5CM3lejLlS6PPiSw8vb4TokqTM8rM1xklbWIAJi51Km6SQnDyff7ByrbjWrARaunOcYpmoyZhZMgp9pD6WzPqQ4TvuBKZfR2g0qAYL4KrdPDwHjwQeBMWxG89kRc7+fU6HkOXbkwDss4B9P//PvFBIc565VsrA6Z4d8/A5wyfeizrr7ztR5p3mNGdSThzTIsAcbsT3553deoOtLJqnRejg1nQb/9ZeULxsQ1I35eMgoZrkHMM4Wl3drjj1Vzs/oDadhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/T+qMenAQl957qi+pKiqs035vSEYDk9uvp5+MJ5d1w=;
 b=wcNuB5asV1vwIEbb8YRHYYejxRJ2nbVkcb/jgqYOhPWTz7KnmXqJF2HRylAQw4QHPcMWwlbSauJHC19MPSIL44rpXJXVn8RZxQXl6MtXUsXSdsXhg3rmL1pDg/x3IBgDM/Ao9/VlSqjhYatCDm1ZljGlXqlTb10qYPGCSd5BM4k=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5680.namprd04.prod.outlook.com (2603:10b6:208:3a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.24; Mon, 13 Jul
 2020 01:07:05 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9%5]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 01:07:05 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: "philmd@redhat.com" <philmd@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 4/4] hw/block/nvme: Align I/O BAR to 4 KiB
Thread-Topic: [PATCH v3 4/4] hw/block/nvme: Align I/O BAR to 4 KiB
Thread-Index: AQHWTs6EJWf5d2EVTkm4p+w4aw8ZnqkExjoA
Date: Mon, 13 Jul 2020 01:07:05 +0000
Message-ID: <f311fd5fb2ad583f2928f07c0fd7cd3e006baef1.camel@wdc.com>
References: <20200630110429.19972-1-philmd@redhat.com>
 <20200630110429.19972-5-philmd@redhat.com>
In-Reply-To: <20200630110429.19972-5-philmd@redhat.com>
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
x-ms-office365-filtering-correlation-id: 4c51fe85-b281-460c-8410-08d826c90ef3
x-ms-traffictypediagnostic: MN2PR04MB5680:
x-microsoft-antispam-prvs: <MN2PR04MB56802DEA16D648788FE93C4EE1600@MN2PR04MB5680.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lacka8zKuJbfISJ7JFqgqPeKjwXNCXJnyVjt48WWZomUP2cjzFdvuDWxQaWRsKu/rKi7CTpkl9mtjS8Z5wgIPrj4HNNirfKi6bqfntnHYnbYdJknZ6hmR1g1pm6TOhpZGBUnVhjRnReJhL9kWqxmErJF6W9+W2atnWSzjwAMP+6rtlcYvWfRew4ACedHnrNoIhYhZyABeH9n6iSx2ZeFzeMmpVJ+Q3Q1Lt8GdCeZaxczJ7wymPLVtC7Gzn3o9v5FCGO0fKGHralFobnAicT9GrluVlKt8eZFT0KPoCqKiUcDL7PszE2feRuVjhVTWpD2AjaWMv73FKVs0DCTzyT7nQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(4326008)(8936002)(83380400001)(5660300002)(478600001)(110136005)(2616005)(26005)(6486002)(186003)(54906003)(6512007)(36756003)(71200400001)(8676002)(2906002)(86362001)(66946007)(64756008)(66556008)(66476007)(316002)(76116006)(6506007)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: JmJZsLMflke9GZkKMRvISsc7+TEPc7W16PnXNYbaj9JQVE3xT930D5p/EC4f8QsnuldGJ9sMwKLUyEe5Tu1VaCfmuPVbUIJ0+0c3xSN8MNsUK/Te3G/+/QPf/dCP3Zthksnswk/bTwAUX4b1JBoEqIuXdOWIHeCvd9SmyfYF25Ms38i46VmJkQHUohZltseVtbBOfNv/9mUXVAMURnWZHhk3sys5TJOJW59YUDw+SbbjSyNVW8eFuGmzdqimNqBVcTV7MxRlx0Gd+Gv1QBYIt1BjybWLyoHLO3CPDWQEbWSnWMEilKtuyzUAkS9Glk9X2Ekb7hUTk13/SK2uBtdQA+K2AdGZL5yWEYBdJ0Ifx6jIl7rniACgkIo/08XyC8Ho1B8PacwpdXFXefvB/WjmZe27Rwbg+xx+DxydC3M0fcMsnl47nJXFgdX12sLFBc3XxSiwCI6SIxa+jjq5hHeoLV3lTxhVm8CtBoQ1BA20CFycf4TcnCaz/yKJvAXUyU6c
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7008865447C08340AFB869E1873D871A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c51fe85-b281-460c-8410-08d826c90ef3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 01:07:05.2708 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A1khJCyhUzniuqCM13StPmsOz+Rw38PIsIOWGIWONYP0rgB7fFjH3aQdgY6SLn87sJf8wOIP3O40QVthuUZbTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5680
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=456505283=Dmitry.Fomichev@wdc.com; helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/12 21:07:03
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

T24gVHVlLCAyMDIwLTA2LTMwIGF0IDEzOjA0ICswMjAwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSB3cm90ZToNCj4gU2ltcGxpZnkgdGhlIE5WTWUgZW11bGF0ZWQgZGV2aWNlIGJ5IGFsaWduaW5n
IHRoZSBJL08gQkFSIHRvIDQgS2lCLg0KPiANCj4gUmV2aWV3ZWQtYnk6IEtsYXVzIEplbnNlbiA8
ay5qZW5zZW5Ac2Ftc3VuZy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUt
RGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICBpbmNsdWRlL2Jsb2NrL252bWUu
aCB8IDIgKysNCj4gIGh3L2Jsb2NrL252bWUuYyAgICAgIHwgNSArKy0tLQ0KPiAgMiBmaWxlcyBj
aGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9ibG9jay9udm1lLmggYi9pbmNsdWRlL2Jsb2NrL252bWUuaA0KPiBpbmRleCA4
MmMzODQ2MTRhLi40ZTFjZWE1NzZhIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2Jsb2NrL252bWUu
aA0KPiArKysgYi9pbmNsdWRlL2Jsb2NrL252bWUuaA0KPiBAQCAtMjIsNiArMjIsNyBAQCB0eXBl
ZGVmIHN0cnVjdCBRRU1VX1BBQ0tFRCBOdm1lQmFyIHsNCj4gICAgICB1aW50MzJfdCAgICBwbXJl
YnM7DQo+ICAgICAgdWludDMyX3QgICAgcG1yc3d0cDsNCj4gICAgICB1aW50NjRfdCAgICBwbXJt
c2M7DQo+ICsgICAgdWludDhfdCAgICAgcmVzZXJ2ZWRbNDg0XTsNCj4gIH0gTnZtZUJhcjsNCj4g
IA0KPiAgZW51bSBOdm1lQ2FwU2hpZnQgew0KPiBAQCAtODc5LDYgKzg4MCw3IEBAIGVudW0gTnZt
ZUlkTnNEcHMgew0KPiAgDQo+ICBzdGF0aWMgaW5saW5lIHZvaWQgX252bWVfY2hlY2tfc2l6ZSh2
b2lkKQ0KPiAgew0KPiArICAgIFFFTVVfQlVJTERfQlVHX09OKHNpemVvZihOdm1lQmFyKSAhPSA0
MDk2KTsNCj4gICAgICBRRU1VX0JVSUxEX0JVR19PTihzaXplb2YoTnZtZUFlclJlc3VsdCkgIT0g
NCk7DQo+ICAgICAgUUVNVV9CVUlMRF9CVUdfT04oc2l6ZW9mKE52bWVDcWUpICE9IDE2KTsNCj4g
ICAgICBRRU1VX0JVSUxEX0JVR19PTihzaXplb2YoTnZtZURzbVJhbmdlKSAhPSAxNik7DQo+IGRp
ZmYgLS1naXQgYS9ody9ibG9jay9udm1lLmMgYi9ody9ibG9jay9udm1lLmMNCj4gaW5kZXggNjYy
OGQwYTRiYS4uMmFhNTRiYzIwZSAxMDA2NDQNCj4gLS0tIGEvaHcvYmxvY2svbnZtZS5jDQo+ICsr
KyBiL2h3L2Jsb2NrL252bWUuYw0KPiBAQCAtNTUsNyArNTUsNiBAQA0KPiAgI2luY2x1ZGUgIm52
bWUuaCINCj4gIA0KPiAgI2RlZmluZSBOVk1FX01BWF9JT1FQQUlSUyAweGZmZmYNCj4gLSNkZWZp
bmUgTlZNRV9SRUdfU0laRSAweDEwMDANCj4gICNkZWZpbmUgTlZNRV9EQl9TSVpFICA0DQo+ICAj
ZGVmaW5lIE5WTUVfQ01CX0JJUiAyDQo+ICAjZGVmaW5lIE5WTUVfUE1SX0JJUiAyDQo+IEBAIC0x
MzIyLDcgKzEzMjEsNyBAQCBzdGF0aWMgdm9pZCBudm1lX21taW9fd3JpdGUodm9pZCAqb3BhcXVl
LCBod2FkZHIgYWRkciwgdWludDY0X3QgZGF0YSwNCj4gICAgICBOdm1lQ3RybCAqbiA9IChOdm1l
Q3RybCAqKW9wYXF1ZTsNCj4gICAgICBpZiAoYWRkciA8IHNpemVvZihuLT5iYXIpKSB7DQo+ICAg
ICAgICAgIG52bWVfd3JpdGVfYmFyKG4sIGFkZHIsIGRhdGEsIHNpemUpOw0KPiAtICAgIH0gZWxz
ZSBpZiAoYWRkciA+PSAweDEwMDApIHsNCj4gKyAgICB9IGVsc2Ugew0KPiAgICAgICAgICBudm1l
X3Byb2Nlc3NfZGIobiwgYWRkciwgZGF0YSk7DQo+ICAgICAgfQ0KPiAgfQ0KPiBAQCAtMTQxNiw3
ICsxNDE1LDcgQEAgc3RhdGljIHZvaWQgbnZtZV9pbml0X3N0YXRlKE52bWVDdHJsICpuKQ0KPiAg
ew0KPiAgICAgIG4tPm51bV9uYW1lc3BhY2VzID0gMTsNCj4gICAgICAvKiBhZGQgb25lIHRvIG1h
eF9pb3FwYWlycyB0byBhY2NvdW50IGZvciB0aGUgYWRtaW4gcXVldWUgcGFpciAqLw0KPiAtICAg
IG4tPnJlZ19zaXplID0gcG93MmNlaWwoTlZNRV9SRUdfU0laRSArDQo+ICsgICAgbi0+cmVnX3Np
emUgPSBwb3cyY2VpbChzaXplb2YoTnZtZUJhcikgKw0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgMiAqIChuLT5wYXJhbXMubWF4X2lvcXBhaXJzICsgMSkgKiBOVk1FX0RCX1NJWkUpOw0K
PiAgICAgIG4tPm5hbWVzcGFjZXMgPSBnX25ldzAoTnZtZU5hbWVzcGFjZSwgbi0+bnVtX25hbWVz
cGFjZXMpOw0KPiAgICAgIG4tPnNxID0gZ19uZXcwKE52bWVTUXVldWUgKiwgbi0+cGFyYW1zLm1h
eF9pb3FwYWlycyArIDEpOw0KPiAtLSANCj4gMi4yMS4zDQo+IA0KPiANCg0KUmV2aWV3ZWQtYnk6
IERtaXRyeSBGb21pY2hldiA8ZG1pdHJ5LmZvbWljaGV2QHdkYy5jb20+DQoNCg==

