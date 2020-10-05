Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4650DC4363C
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 00:55:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2D02206B6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 00:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="ApimOfi+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vWyKRBM2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D02206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPEmQ-00048Z-G4
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 20:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=540393388=Dmitry.Fomichev@wdc.com>)
 id 1kPEkv-0003bf-8h; Sun, 04 Oct 2020 20:53:33 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:34500)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=540393388=Dmitry.Fomichev@wdc.com>)
 id 1kPEkr-0001s7-OG; Sun, 04 Oct 2020 20:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601859942; x=1633395942;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=q03wzWDTCiuGGQ+7pVJVKL0CmCzpey264d+7J2Hmjm0=;
 b=ApimOfi+/smoGZuR1/wx5eD41DIZunbhtU/7FZgLKEpLj+9G+RnyZkEJ
 jyMSx+qODTBotRGKohlcxQGxS7D440tmKSa1evx/Wq3A/a4hdZIm9ow/r
 fLY42vYyQLaFxRQkq4w4vXcIce9SsIYQYJ54EydW+uvstigtx2vPNR1Y/
 tvWuJGf2zbgeOWt0DkiwHSZ15nZxcMOj4SbQbCDI+xxoI69trkFvhpCnr
 0J9CwVfRw2eGOdgpTUhLvF9HudFzn6lqpZKSvf3EPt2E6DMsDhBPqkaWV
 XXd9pYuzZ5ga3o6tTrSzUeGI8jf5aak4DUmk3xSWO15ETHckNW2GhmblV w==;
IronPort-SDR: kJ2Hqw27411X7MHd+cz83DwWmqNDxc94TFSJi/CrQAE7GMv0lYMQ/H9WS+FLn6UiYQueTY9NaY
 wVEtylJVf86Yi/Ax8j3DWa5jKSbD/8n+JHH+ehfwO9zgVVP81MK7yQ8dvGTBxhst6hUlv9Si1U
 LlvlfrtDbNGLf02AVe7eSVAqOnkNbxhfuUExEWsgEr5J+UdN0EeCiI0PkwM79jhutfDaoV3Las
 x7WE2Z5POW50f5L7bTXespy7KWXCiS1wpTRwld4fHPorZwmM3faOBpAEq0OqVXUPgyu3FD6bts
 k8c=
X-IronPort-AV: E=Sophos;i="5.77,337,1596470400"; d="scan'208";a="252462583"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
 by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2020 09:05:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Au43ye+F5kyrANtu85lqR1g/ybaSYZtmDKhiYveLy/2GyDsT+tyJwjS2pEeh6z5l75lOAIFmOT2V9whoXUMlLbNRU1enOUvHbshpY3rKzVSKXnHwav+u7+j5ccx0YapJoo3TIMsG8wW41WDZ9sabuzB8nXjzOoxjIx4WKO4sIpGG8lA1qQit6/8Q76OoHHSVNQVokKSCMEXPtJRaLTvslxj/BwjKxOKh4I09Yk8xOWFT92p7+nWiwPinWxt5XI+YcKSZrUINbC9W5xeXpoYXSHf/6kVB3A2mdSDB6OPJQl8wZCDTHtj3/dT+NFNPxfiOubqlCewd6KkBOEdOjntvXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q03wzWDTCiuGGQ+7pVJVKL0CmCzpey264d+7J2Hmjm0=;
 b=AqtSA05KAQS4cpVpp+8qyNHMVg+Kyt0w1z21Bupo0HzZw33EjYWrIh8oQ/fKh3J8Es4MKweI2u67qH5QUFL6sNKMbQ9OjS7i0EwF98dLgIrSQoU/jMT0HsjRzDN9xUinaGmWyKQoThAJ8JcMD3BG/nG/2mi1fyaKerb3oo4ZvBbzQ6Gf0cIAzjNC3etgadsgCgJIXoWiXSgGHWHHpwVzoLpnmBWwKkdgYDpPRUTKbF+6hzHLdRP4nGYqXqKIrOieYAeoopBhCGRh2AzqC9swkxpJKIFQ8qnTNnyncSLsq5dxDKvkUfAMOfGT8CDGJXbX7C6bhs0ANFJwi0pSBMWCqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q03wzWDTCiuGGQ+7pVJVKL0CmCzpey264d+7J2Hmjm0=;
 b=vWyKRBM2N5s0GpzmvCy4rIxkew57dAFOwa80zO5Q7jiQhyl+k804GcL3SOzHj/qQHPTEGX3X1qPzpGaSKN9kJ9kEGXYS1ed0vOax0N0igvT/iJwCKcXiyfnuvCvb6zx1zwnv9SAHDfBZ6TDJVhVGcOdpI2EEGVl9XjhEJgZXazs=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5584.namprd04.prod.outlook.com (2603:10b6:208:e6::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Mon, 5 Oct
 2020 00:53:22 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94%6]) with mapi id 15.20.3433.044; Mon, 5 Oct 2020
 00:53:22 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: RE: [PATCH v5 09/14] hw/block/nvme: Support Zoned Namespace Command
 Set
Thread-Topic: [PATCH v5 09/14] hw/block/nvme: Support Zoned Namespace Command
 Set
Thread-Index: AQHWlUAbR7szI/vjI0exN9wB2mxOtql93cIAgApWgxA=
Date: Mon, 5 Oct 2020 00:53:22 +0000
Message-ID: <MN2PR04MB595121FF05A5E22B027F962CE10C0@MN2PR04MB5951.namprd04.prod.outlook.com>
References: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
 <20200928023528.15260-10-dmitry.fomichev@wdc.com>
 <20200928104258.GB33043@apples.localdomain>
In-Reply-To: <20200928104258.GB33043@apples.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1c3d67d3-92f5-44bb-13ae-08d868c90f3e
x-ms-traffictypediagnostic: MN2PR04MB5584:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB5584EE15036AEF018ABAB484E10C0@MN2PR04MB5584.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bzj2cdqYqXYQs+x2psIBhu1F4iPtIt/Mb7Vly5DX8iLb4FXPngV5FNHkH/etlujB5nMF8YvlOTdacmuAgQb8VbUIMmz1/kJwPXwuFCu0eg6sXe5aGHcqefcNEG5Ybhr5cKfUScpZFU4Cmmga1tgtA8E5OTSpXOIQoh77IODFHYhBiuFaoMaKTFj8YcQ59YjmhoM4/pRPII3Ry1P022LG8VHcLAYRMs22BWoFIZ+as/wedaovUrYMTPo3DihuhD0FBelT46YbLv9GpkAU9U8+yCLjRISWtKGmHHtYlNI2lJeXk51YbGrvDJwCHSeWotBn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(71200400001)(26005)(55016002)(9686003)(6916009)(186003)(86362001)(52536014)(5660300002)(4326008)(66446008)(76116006)(64756008)(66556008)(66476007)(66946007)(7696005)(2906002)(33656002)(54906003)(6506007)(8936002)(8676002)(53546011)(478600001)(316002)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: rXa4VB9zsWkdvN69e4TLN4qvcP+Yj6afTIrtA6/MuvHhgagIKsH8EUth8NBy8+JopGgS8C4nZeD1SCiXhF4nLdQYz5c47nc1eN0iBdaX07EY0yd5QYt5D/jiT5cbiDqO4nN8C+RAGIqVfPJjcINOc0D6UEDmSa7SmX64PXeMDXeHcMEJsgIQWImiwh6twvA72lztKFwReT4zrsvFl5bBt4BsV1R5WsIL7hsV+baxvmAqJws31NW3/sx4Xvsew9ja5Tb2uW3Kex7Wp4auQP2zDnSstJzY1i8PR7M3Ke0EsG+2UlKUUYJShSQgJ5LVZBsNbmESbFxFrqGYdakPgChmCzTF8Mx1g/+ghA8HZ5MNZUdWOcDxuAlfCb2X0IkyMPU5v2c8hr685/kxytsV1G4Ab3qY+FZZ+s4IKWFyDFb0waj79QSjYBVVP9SMuPGSs+dMofzvOM0GrjMpn9N+QgAoavNfI09taQ4o5Uz1LRuaB44knhJsBjHEiG2yFd4mDjm3qwMofwe+r4rEhZGOGEXAX4Js7bcNmUdcFLd5CZKHF5ToTxmtCz3DBTkvRYDWmgwyhXVuYZrEOXnZmIrTQ/blGna7W8M2gREo5SknFMKwu+F4TnVIpNX+ENByK8v97i1tGF4MzfE/pOZXK7KmAL8pcg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3d67d3-92f5-44bb-13ae-08d868c90f3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2020 00:53:22.5277 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SgkKOeiH50tqITf9yhOqxFXwx8KjGQcVwbuJKHLt5eZMu9QDQ3Lki6RubhJbEGrRmcFDzscTFfH3ge9ECgQDkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5584
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=540393388=Dmitry.Fomichev@wdc.com; helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/04 20:53:26
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Niklas Cassel <Niklas.Cassel@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Keith Busch <kbusch@kernel.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLbGF1cyBKZW5zZW4gPGl0c0Bp
cnJlbGV2YW50LmRrPg0KPiBTZW50OiBNb25kYXksIFNlcHRlbWJlciAyOCwgMjAyMCA2OjQzIEFN
DQo+IFRvOiBEbWl0cnkgRm9taWNoZXYgPERtaXRyeS5Gb21pY2hldkB3ZGMuY29tPg0KPiBDYzog
S2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPjsgS2xhdXMgSmVuc2VuDQo+IDxrLmplbnNl
bkBzYW1zdW5nLmNvbT47IEtldmluIFdvbGYgPGt3b2xmQHJlZGhhdC5jb20+OyBQaGlsaXBwZQ0K
PiBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQHJlZGhhdC5jb20+OyBNYXhpbSBMZXZpdHNreQ0KPiA8
bWxldml0c2tAcmVkaGF0LmNvbT47IEZhbSBaaGVuZyA8ZmFtQGV1cGhvbi5uZXQ+OyBOaWtsYXMg
Q2Fzc2VsDQo+IDxOaWtsYXMuQ2Fzc2VsQHdkYy5jb20+OyBEYW1pZW4gTGUgTW9hbCA8RGFtaWVu
LkxlTW9hbEB3ZGMuY29tPjsNCj4gcWVtdS1ibG9ja0Bub25nbnUub3JnOyBxZW11LWRldmVsQG5v
bmdudS5vcmc7IEFsaXN0YWlyIEZyYW5jaXMNCj4gPEFsaXN0YWlyLkZyYW5jaXNAd2RjLmNvbT47
IE1hdGlhcyBCam9ybGluZyA8TWF0aWFzLkJqb3JsaW5nQHdkYy5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjUgMDkvMTRdIGh3L2Jsb2NrL252bWU6IFN1cHBvcnQgWm9uZWQgTmFtZXNwYWNl
DQo+IENvbW1hbmQgU2V0DQo+IA0KPiBPbiBTZXAgMjggMTE6MzUsIERtaXRyeSBGb21pY2hldiB3
cm90ZToNCj4gPiBUaGUgZW11bGF0aW9uIGNvZGUgaGFzIGJlZW4gY2hhbmdlZCB0byBhZHZlcnRp
c2UgTlZNIENvbW1hbmQgU2V0DQo+IHdoZW4NCj4gPiAiem9uZWQiIGRldmljZSBwcm9wZXJ0eSBp
cyBub3Qgc2V0IChkZWZhdWx0KSBhbmQgWm9uZWQgTmFtZXNwYWNlDQo+ID4gQ29tbWFuZCBTZXQg
b3RoZXJ3aXNlLg0KPiA+DQo+ID4gSGFuZGxlcnMgZm9yIHRocmVlIG5ldyBOVk1lIGNvbW1hbmRz
IGludHJvZHVjZWQgaW4gWm9uZWQgTmFtZXNwYWNlDQo+ID4gQ29tbWFuZCBTZXQgc3BlY2lmaWNh
dGlvbiBhcmUgYWRkZWQsIG5hbWVseSBmb3IgWm9uZSBNYW5hZ2VtZW50DQo+ID4gUmVjZWl2ZSwg
Wm9uZSBNYW5hZ2VtZW50IFNlbmQgYW5kIFpvbmUgQXBwZW5kLg0KPiA+DQo+ID4gRGV2aWNlIGlu
aXRpYWxpemF0aW9uIGNvZGUgaGFzIGJlZW4gZXh0ZW5kZWQgdG8gY3JlYXRlIGEgcHJvcGVyDQo+
ID4gY29uZmlndXJhdGlvbiBmb3Igem9uZWQgb3BlcmF0aW9uIHVzaW5nIGRldmljZSBwcm9wZXJ0
aWVzLg0KPiA+DQo+ID4gUmVhZC9Xcml0ZSBjb21tYW5kIGhhbmRsZXIgaXMgbW9kaWZpZWQgdG8g
b25seSBhbGxvdyB3cml0ZXMgYXQgdGhlDQo+ID4gd3JpdGUgcG9pbnRlciBpZiB0aGUgbmFtZXNw
YWNlIGlzIHpvbmVkLiBGb3IgWm9uZSBBcHBlbmQgY29tbWFuZCwNCj4gPiB3cml0ZXMgaW1wbGlj
aXRseSBoYXBwZW4gYXQgdGhlIHdyaXRlIHBvaW50ZXIgYW5kIHRoZSBzdGFydGluZyB3cml0ZQ0K
PiA+IHBvaW50ZXIgdmFsdWUgaXMgcmV0dXJuZWQgYXMgdGhlIHJlc3VsdCBvZiB0aGUgY29tbWFu
ZC4gV3JpdGUgWmVyb2VzDQo+ID4gaGFuZGxlciBpcyBtb2RpZmllZCB0byBhZGQgem9uZWQgY2hl
Y2tzIHRoYXQgYXJlIGlkZW50aWNhbCB0byB0aG9zZQ0KPiA+IGRvbmUgYXMgYSBwYXJ0IG9mIFdy
aXRlIGZsb3cuDQo+ID4NCj4gPiBUaGUgY29kZSB0byBzdXBwb3J0IGZvciBab25lIERlc2NyaXB0
b3IgRXh0ZW5zaW9ucyBpcyBub3QgaW5jbHVkZWQgaW4NCj4gPiB0aGlzIGNvbW1pdCBhbmQgWkRF
UyAwIGlzIGFsd2F5cyByZXBvcnRlZC4gQSBsYXRlciBjb21taXQgaW4gdGhpcw0KPiA+IHNlcmll
cyB3aWxsIGFkZCBaREUgc3VwcG9ydC4NCj4gPg0KPiA+IFRoaXMgY29tbWl0IGRvZXNuJ3QgeWV0
IGluY2x1ZGUgY2hlY2tzIGZvciBhY3RpdmUgYW5kIG9wZW4gem9uZQ0KPiA+IGxpbWl0cy4gSXQg
aXMgYXNzdW1lZCB0aGF0IHRoZXJlIGFyZSBubyBsaW1pdHMgb24gZWl0aGVyIGFjdGl2ZSBvcg0K
PiA+IG9wZW4gem9uZXMuDQo+ID4NCj4gDQo+IEkgdGhpbmsgdGhlIGZpbGxfcGF0dGVybiBmZWF0
dXJlIHN0YW5kcyBzZXBhcmF0ZSwgc28gaXQgd291bGQgYmUgbmljZSB0bw0KPiBleHRyYWN0IHRo
YXQgdG8gYSBwYXRjaCBvbiBpdHMgb3duLg0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBOaWtsYXMg
Q2Fzc2VsIDxuaWtsYXMuY2Fzc2VsQHdkYy5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogSGFucyBI
b2xtYmVyZyA8aGFucy5ob2xtYmVyZ0B3ZGMuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFqYXkg
Sm9zaGkgPGFqYXkuam9zaGlAd2RjLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaGFpdGFueWEg
S3Vsa2FybmkgPGNoYWl0YW55YS5rdWxrYXJuaUB3ZGMuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IE1hdGlhcyBCam9ybGluZyA8bWF0aWFzLmJqb3JsaW5nQHdkYy5jb20+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogQXJhdmluZCBSYW1lc2ggPGFyYXZpbmQucmFtZXNoQHdkYy5jb20+DQo+ID4gU2lnbmVk
LW9mZi1ieTogU2hpbidpY2hpcm8gS2F3YXNha2kgPHNoaW5pY2hpcm8ua2F3YXNha2lAd2RjLmNv
bT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBZGFtIE1hbnphbmFyZXMgPGFkYW0ubWFuemFuYXJlc0B3
ZGMuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IERtaXRyeSBGb21pY2hldiA8ZG1pdHJ5LmZvbWlj
aGV2QHdkYy5jb20+DQo+ID4gLS0tDQo+ID4gIGJsb2NrL252bWUuYyAgICAgICAgIHwgICAyICst
DQo+ID4gIGh3L2Jsb2NrL252bWUtbnMuYyAgIHwgMTg1ICsrKysrKysrLQ0KPiA+ICBody9ibG9j
ay9udm1lLW5zLmggICB8ICAgNiArLQ0KPiA+ICBody9ibG9jay9udm1lLmMgICAgICB8IDg3Mg0K
PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQo+ID4gIGluY2x1
ZGUvYmxvY2svbnZtZS5oIHwgICA2ICstDQo+ID4gIDUgZmlsZXMgY2hhbmdlZCwgMTAzMyBpbnNl
cnRpb25zKCspLCAzOCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9ibG9j
ay9udm1lLW5zLmggYi9ody9ibG9jay9udm1lLW5zLmgNCj4gPiBpbmRleCAwNDE3MmYwODNlLi5k
YWExMzU0NmM0IDEwMDY0NA0KPiA+IC0tLSBhL2h3L2Jsb2NrL252bWUtbnMuaA0KPiA+ICsrKyBi
L2h3L2Jsb2NrL252bWUtbnMuaA0KPiA+IEBAIC0zOCw3ICszOCw2IEBAIHR5cGVkZWYgc3RydWN0
IE52bWVab25lTGlzdCB7DQo+ID4NCj4gPiAgdHlwZWRlZiBzdHJ1Y3QgTnZtZU5hbWVzcGFjZVBh
cmFtcyB7DQo+ID4gICAgICB1aW50MzJfdCBuc2lkOw0KPiA+IC0gICAgdWludDhfdCAgY3NpOw0K
PiA+ICAgICAgYm9vbCAgICAgYXR0YWNoZWQ7DQo+ID4gICAgICBRZW11VVVJRCB1dWlkOw0KPiA+
DQo+ID4gQEAgLTUyLDYgKzUxLDcgQEAgdHlwZWRlZiBzdHJ1Y3QgTnZtZU5hbWVzcGFjZSB7DQo+
ID4gICAgICBEZXZpY2VTdGF0ZSAgcGFyZW50X29iajsNCj4gPiAgICAgIEJsb2NrQ29uZiAgICBi
bGtjb25mOw0KPiA+ICAgICAgaW50MzJfdCAgICAgIGJvb3RpbmRleDsNCj4gPiArICAgIHVpbnQ4
X3QgICAgICBjc2k7DQo+ID4gICAgICBpbnQ2NF90ICAgICAgc2l6ZTsNCj4gPiAgICAgIE52bWVJ
ZE5zICAgICBpZF9uczsNCj4gDQo+IFRoaXMgc2hvdWxkIGJlIHNxdWFzaGVkIGludG8gdGhlIG5h
bWVzcGFjZSB0eXBlcyBwYXRjaC4NCj4gDQoNClllcywgdGhhbmtzLg0KDQo+ID4gZGlmZiAtLWdp
dCBhL2h3L2Jsb2NrL252bWUuYyBiL2h3L2Jsb2NrL252bWUuYw0KPiA+IGluZGV4IDYzYWQwM2Q2
ZDYuLjM4ZTI1YTRkMWYgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYmxvY2svbnZtZS5jDQo+ID4gKysr
IGIvaHcvYmxvY2svbnZtZS5jDQo+ID4gQEAgLTU0LDYgKzU0LDcgQEANCj4gPiAgI2luY2x1ZGUg
InFlbXUvb3NkZXAuaCINCj4gPiAgI2luY2x1ZGUgInFlbXUvdW5pdHMuaCINCj4gPiAgI2luY2x1
ZGUgInFlbXUvZXJyb3ItcmVwb3J0LmgiDQo+ID4gKyNpbmNsdWRlICJjcnlwdG8vcmFuZG9tLmgi
DQo+IA0KPiBJIHRoaW5rIHRoaXMgaXMgbm90IHVzZWQgdW50aWwgdGhlIG9mZmxpbmUvcmVhZC1v
bmx5IHpvbmVzIGluamVjdGlvbg0KPiBwYXRjaCwgcmlnaHQ/DQo+IA0KDQpJbmRlZWQsIHdpbGwg
bW92ZS4NCg0KPiA+ICtzdGF0aWMgYm9vbCBudm1lX2ZpbmFsaXplX3pvbmVkX3dyaXRlKE52bWVO
YW1lc3BhY2UgKm5zLA0KPiBOdm1lUmVxdWVzdCAqcmVxLA0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGJvb2wgZmFpbGVkKQ0KPiA+ICt7DQo+ID4gKyAgICBOdm1l
UndDbWQgKnJ3ID0gKE52bWVSd0NtZCAqKSZyZXEtPmNtZDsNCj4gPiArICAgIE52bWVab25lICp6
b25lOw0KPiA+ICsgICAgdWludDY0X3Qgc2xiYSwgc3RhcnRfd3AgPSByZXEtPmNxZS5yZXN1bHQ2
NDsNCj4gPiArICAgIHVpbnQzMl90IG5sYiwgem9uZV9pZHg7DQo+ID4gKyAgICB1aW50OF90IHpz
Ow0KPiA+ICsNCj4gPiArICAgIGlmIChydy0+b3Bjb2RlICE9IE5WTUVfQ01EX1dSSVRFICYmDQo+
ID4gKyAgICAgICAgcnctPm9wY29kZSAhPSBOVk1FX0NNRF9aT05FX0FQUEVORCAmJg0KPiA+ICsg
ICAgICAgIHJ3LT5vcGNvZGUgIT0gTlZNRV9DTURfV1JJVEVfWkVST0VTKSB7DQo+ID4gKyAgICAg
ICAgcmV0dXJuIGZhbHNlOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIHNsYmEgPSBsZTY0
X3RvX2NwdShydy0+c2xiYSk7DQo+ID4gKyAgICBubGIgPSBsZTE2X3RvX2NwdShydy0+bmxiKSAr
IDE7DQo+ID4gKyAgICB6b25lX2lkeCA9IG52bWVfem9uZV9pZHgobnMsIHNsYmEpOw0KPiA+ICsg
ICAgYXNzZXJ0KHpvbmVfaWR4IDwgbnMtPm51bV96b25lcyk7DQo+ID4gKyAgICB6b25lID0gJm5z
LT56b25lX2FycmF5W3pvbmVfaWR4XTsNCj4gPiArDQo+ID4gKyAgICBpZiAoIWZhaWxlZCAmJiB6
b25lLT53X3B0ciA8IHN0YXJ0X3dwICsgbmxiKSB7DQo+ID4gKyAgICAgICAgLyoNCj4gPiArICAg
ICAgICAgKiBBIHByZWNlZGluZyBxdWV1ZWQgd3JpdGUgdG8gdGhlIHpvbmUgaGFzIGZhaWxlZCwN
Cj4gPiArICAgICAgICAgKiBub3cgdGhpcyB3cml0ZSBpcyBub3QgYXQgdGhlIFdQLCBmYWlsIGl0
IHRvby4NCj4gPiArICAgICAgICAgKi8NCj4gPiArICAgICAgICBmYWlsZWQgPSB0cnVlOw0KPiA+
ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIGlmIChmYWlsZWQpIHsNCj4gPiArICAgICAgICBpZiAo
em9uZS0+d19wdHIgPiBzdGFydF93cCkgew0KPiA+ICsgICAgICAgICAgICB6b25lLT53X3B0ciA9
IHN0YXJ0X3dwOw0KPiA+ICsgICAgICAgIH0NCj4gDQo+IEl0IGlzIHBvc3NpYmxlICh0aG91Z2gg
dW5saWtlbHkpIHRoYXQgeW91IGFscmVhZHkgcG9zdGVkIHRoZSBDUUUgZm9yIHRoZQ0KPiB3cml0
ZSB0aGF0IG1vdmVkIHRoZSBXUCB0byB3X3B0ciAtIGFuZCBub3cgeW91IGFyZSByZXZlcnRpbmcg
aXQuICBUaGlzDQo+IGxvb2tzIGxpa2UgYSByZWNpcGUgZm9yIGRhdGEgY29ycnVwdGlvbiB0byBt
ZS4NCj4gDQo+IFRha2UgdGhpcyBleGFtcGxlLiBJIHVzZSBhcHBlbmQsIGJlY2F1c2UgaWYgeW91
IGhhdmUgbXVsdGlwbGUgcmVndWxhcg0KPiB3cml0ZXMgaW4gcXVldWUgeW91J3JlIHNjcmV3ZWQg
YW55d2F5Lg0KPiANCj4gICB3X3B0ciA9IDAsIGQud3AgPSAwDQo+ICAgYXBwZW5kIDEgbGJhICAt
PiB3X3B0ciA9IDEsIHN0YXJ0X3dwID0gMCwgaXNzdWVzIGFpbyBBDQo+ICAgYXBwZW5kIDIgbGJh
cyAtPiB3X3B0ciA9IDMsIHN0YXJ0X3dwID0gMSwgaXNzdWVzIGFpbyBCDQo+IA0KPiAgIGFpbyBC
IHN1Y2Nlc3MgLT4gZC53cCA9IDIgKHNpbmNlIHlvdSBhcmUgYWRkaW5nIG5sYiksDQo+IA0KPiBO
b3csIEkgdG90YWxseSBkbyB0aGUgc2FtZS4gRXZlbiB0aG91Z2ggdGhlIHpvbmUgZGVzY3JpcHRv
ciB3cml0ZQ0KPiBwb2ludGVyIGdldHMgIm91dCBvZiBzeW5jIiwgaXQgd2lsbCBiZSByZWNvbmNp
bGVkIGluIHRoZSBhYnNlbmNlIG9mDQo+IGZhaWx1cmVzIGFuZCBpdHMgZmFpciB0byBkZWZpbmUg
dGhhdCB0aGUgaG9zdCBjYW5ub3QgZXhwZWN0IGEgY29uc2lzdGVudA0KPiB2aWV3IG9mIHRoZSB3
cml0ZSBwb2ludGVyIHdpdGhvdXQgcXVlc2NpbmcgSS9PLg0KPiANCj4gVGhlIHByb2JsZW0gaXMg
aWYgYSB3cml0ZSB0aGVuIGZhaWxzOg0KPiANCj4gICBhaW8gQSBmYWlscyAgIC0+IHdfcHRyID4g
c3RhcnRfd3AgKDMgPiAxKSwgc28geW91IHJldmVydCB0byB3X3B0ciA9IDENCj4gDQo+IFRoYXQg
bG9va3MgYmFkIHRvIG1lLiBJIGRvbnQgdGhpbmsgdGhpcyBpcyBldmVyIHJlY29uY2lsZWQ/IElm
IGFub3RoZXINCj4gYXBwZW5kIHRoZW4gY29tZXMgaW46DQo+IA0KPiAgIGFwcGVuZCAxIGxiYSAt
PiB3X3B0ciA9IDIsIHN0YXJ0X3dwID0gMSwgaXNzdWVzIGFpbyBDIGFuZCBvdmVyd3JpdGVzDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0aGUgc2Vjb25kIGFw
cGVuZCBmcm9tIGJlZm9yZS4NCj4gICBhaW8gQyBzdWNjZXNzIC0+IGQud3AgPSAzIChidXQgaXQg
c2hvdWxkIGJlIDIpDQo+IA0KDQpSaWdodCwgbmVlZCB0byBzeW5jIHdfcHRyIGFuZCBkLndwIGhl
cmUuIEdvb2QgZmluZCENCg0KPiA+IEBAIC0xNTEzLDExICsyMjY3LDE2IEBAIHN0YXRpYyB1aW50
MTZfdCBudm1lX2lkZW50aWZ5X2N0cmwoTnZtZUN0cmwNCj4gKm4sIE52bWVSZXF1ZXN0ICpyZXEp
DQo+ID4gIHN0YXRpYyB1aW50MTZfdCBudm1lX2lkZW50aWZ5X2N0cmxfY3NpKE52bWVDdHJsICpu
LCBOdm1lUmVxdWVzdCAqcmVxKQ0KPiA+ICB7DQo+ID4gICAgICBOdm1lSWRlbnRpZnkgKmMgPSAo
TnZtZUlkZW50aWZ5ICopJnJlcS0+Y21kOw0KPiA+ICsgICAgTnZtZUlkQ3RybFpvbmVkIGlkID0g
e307DQo+ID4NCj4gPiAgICAgIHRyYWNlX3BjaV9udm1lX2lkZW50aWZ5X2N0cmxfY3NpKGMtPmNz
aSk7DQo+ID4NCj4gPiAgICAgIGlmIChjLT5jc2kgPT0gTlZNRV9DU0lfTlZNKSB7DQo+ID4gICAg
ICAgICAgcmV0dXJuIG52bWVfcnB0X2VtcHR5X2lkX3N0cnVjdChuLCByZXEpOw0KPiA+ICsgICAg
fSBlbHNlIGlmIChjLT5jc2kgPT0gTlZNRV9DU0lfWk9ORUQpIHsNCj4gPiArICAgICAgICBpZC56
YXNsID0gbi0+emFzbDsNCj4gDQo+IEkgZG9udCB0aGluayBpdCBzaG91bGQgb3ZlcndyaXRlIHRo
ZSB6YXNsIHZhbHVlIHNwZWNpZmllZCBieSB0aGUgdXNlci4NCj4gSWYgdGhlIHVzZXIgc3BlY2lm
aWVkIDAsIHRoZW4gaXQgc2hvdWxkIHJldHVybiAwIGZvciB6YXNsIGhlcmUuDQoNCk5vdCBzdXJl
IGlmIEkgZ2V0IHRoaXMuIFRoZSB2YWx1ZSBvZiBuLT56YXNsIGlzIGNhbGN1bGF0ZWQgYmFzZWQg
b24gdGhlDQpzZXR0aW5nIGdpdmVuIGJ5IHRoZSB1c2VyIChvciBieSBkZWZhdWx0KS4NCg0KPiAN
Cj4gPiBAQCAtMjMxMCwxNiArMzA4NiwyOCBAQCBzdGF0aWMgaW50IG52bWVfc3RhcnRfY3RybChO
dm1lQ3RybCAqbikNCj4gPiAgICAgICAgICAgICAgY29udGludWU7DQo+ID4gICAgICAgICAgfQ0K
PiA+ICAgICAgICAgIG5zLT5wYXJhbXMuYXR0YWNoZWQgPSBmYWxzZTsNCj4gPiAtICAgICAgICBz
d2l0Y2ggKG5zLT5wYXJhbXMuY3NpKSB7DQo+ID4gKyAgICAgICAgc3dpdGNoIChucy0+Y3NpKSB7
DQo+ID4gICAgICAgICAgY2FzZSBOVk1FX0NTSV9OVk06DQo+ID4gICAgICAgICAgICAgIGlmIChO
Vk1FX0NDX0NTUyhuLT5iYXIuY2MpID09IENTU19OVk1fT05MWSB8fA0KPiA+ICAgICAgICAgICAg
ICAgICAgTlZNRV9DQ19DU1Mobi0+YmFyLmNjKSA9PSBDU1NfQ1NJKSB7DQo+ID4gICAgICAgICAg
ICAgICAgICBucy0+cGFyYW1zLmF0dGFjaGVkID0gdHJ1ZTsNCj4gPiAgICAgICAgICAgICAgfQ0K
PiA+ICAgICAgICAgICAgICBicmVhazsNCj4gPiArICAgICAgICBjYXNlIE5WTUVfQ1NJX1pPTkVE
Og0KPiA+ICsgICAgICAgICAgICBpZiAoTlZNRV9DQ19DU1Mobi0+YmFyLmNjKSA9PSBDU1NfQ1NJ
KSB7DQo+ID4gKyAgICAgICAgICAgICAgICBucy0+cGFyYW1zLmF0dGFjaGVkID0gdHJ1ZTsNCj4g
PiArICAgICAgICAgICAgfQ0KPiA+ICsgICAgICAgICAgICBicmVhazsNCj4gPiAgICAgICAgICB9
DQo+ID4gICAgICB9DQo+ID4NCj4gPiArICAgIGlmICghbi0+emFzbF9icykgew0KPiA+ICsgICAg
ICAgIGFzc2VydChuLT5wYXJhbXMubWR0cyk7DQo+IA0KPiBBIHZhbHVlIG9mIDAgZm9yIE1EVFMg
aXMgcGVyZmVjdGx5IHZhbGlkLg0KDQpPaywgbmVlZCB0byByZW1vdmUgdGhpcyBhc3NlcnQuDQog
DQo+IA0KPiA+IEBAIC0yMzgyLDEwICszMTcwLDExIEBAIHN0YXRpYyB2b2lkIG52bWVfd3JpdGVf
YmFyKE52bWVDdHJsICpuLA0KPiBod2FkZHIgb2Zmc2V0LCB1aW50NjRfdCBkYXRhLA0KPiA+ICAg
ICAgICAgICAgICAgICAgY2FzZSBDU1NfTlZNX09OTFk6DQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgdHJhY2VfcGNpX252bWVfY3NzX252bV9jc2V0X3NlbGVjdGVkX2J5X2hvc3QoZGF0YSAmDQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgMHhmZmZmZmZmZik7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgYnJlYWs7
DQo+ID4gKyAgICAgICAgICAgICAgICBicmVhazsNCj4gDQo+IFNwdXJpb3VzIG1pc2FsaWduZWQg
YnJlYWsgaGVyZS4NCg0KTmljZSBjYXRjaCEgSXQncyBtaXNhbGlnbmVkIGJ5IDQsIHNvIGNoZWNr
cGF0Y2ggZG9lc24ndCBjb21wbGFpbiBhYm91dCBpdCA6KQ0K

