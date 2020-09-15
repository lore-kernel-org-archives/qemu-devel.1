Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C238AC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 20:46:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A8A620771
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 20:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="W5lTMlhr";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CGpx7Bsp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8A620771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIHq2-0006Kz-Vf
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 16:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=520035bb9=Dmitry.Fomichev@wdc.com>)
 id 1kIHoK-0004re-PX; Tue, 15 Sep 2020 16:44:21 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:12066)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=520035bb9=Dmitry.Fomichev@wdc.com>)
 id 1kIHoH-0005Id-EZ; Tue, 15 Sep 2020 16:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600202672; x=1631738672;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6GHTpYXzzXjFhyfTGCxkYzMEQbTb0CY4eaDPdePkw08=;
 b=W5lTMlhrZNUrFTPicoOt30eX9xrXHm9TYjx6mPNeTCg6gLDd0W923WZe
 afkcDRx/d33ylfdq18O5pRDbZ7A04UcdmbpcwlFLNttSoyA7tVJRqHI05
 DNhBeZLuQvCj1DxXuM8gYaIIaF3Cn2VskYDzlgMhHlA3bl4WWpSF1KnDH
 nJtRXlk2ghxtc8vBJ/doN52kP02ov+bfxGUNUlRIaEDSKJ8+dOajuufHF
 FLz4ocabuIZykTcv6zJne19A+spMPRiV4vQHUHxaMP8z6G5m7xJqKmZsH
 c6IcSvAzNks7+B8csY6ZqFfM24j1xTMkJwJfxqpM8H2KNQ6net7SZ5qX6 A==;
IronPort-SDR: o4WjSv1j54cWE1k1I1MZAIwPxLD5v/gxBTl9AL8ZlKBGJWtdr8xuIgdFrs8tJJoNk5IcHLrWO/
 JvRbQPR+6hEflkaBd3+2BOjcmxIMuSjW5IY3R9rHT0iD/5uGzDG+Fnifpw7rZKLvh/Z/zCeZ9W
 M22YqEV3J10zTz4oWGurfkmjjybaJljhgK8LoDgzQsOACjzuZs8DC9+yZ3h3lfGwHXOpbN9tHy
 pPpkR/O6UFg7z08BWSoLHBi8R7DJr3VlEPN7n49fJf+k4nOVd+b+V0/cA4NvGNEfGNXYTiD8ti
 w0k=
X-IronPort-AV: E=Sophos;i="5.76,430,1592841600"; d="scan'208";a="250787589"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
 by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2020 04:44:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMslqIJn8Pein+poEGMRoyWZ9WM/MgFKTLX2v0Snawq9LECP4ElOXrdmDtgL9qwSH+aIsve5yN6Q5NUxdkDgqhnrmuui4zbWYzbVpG6EBnlDNnO5Xo64vj0N8H83reoIVdot+twRvTmvIz7KAPhb+nOyTGf8lXVax7CWD2GvNhW69WaKU7LHKahH6lquo9Hz4pobPfApoXnILSe5ATODopIx9EtRLEAmg7VmA2xwkWnwV09ojDCRplKzNBzzzoiMyJu5b2qYZs0tRq74JhIMG46pilr1SSGJ5NYJnJc1ZOwEcpVORt38YrBvav6z60N+aSc2Mu6DROIMPgQrS0W44g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GHTpYXzzXjFhyfTGCxkYzMEQbTb0CY4eaDPdePkw08=;
 b=JeK28rgKU1dJP36d/cUHlPOiOzkfjtR9bZjr4jCuI61Ux8kt+SEs1p6dzI4hmxj1dFZxgwCTzn32zHV/hcBaKffH9l1uBWJlC8QdsB6D9RvrTSEPbX3pRRu5i8+SWK5bT1mvvTQFZQ6tmc41DFE4jpLyhaA2e/qP5/a3wmVIKBQkI/BwTs+w5MlunYB+/3KLXvkEFAcSK7QPc5rEATnk6T+3nIR13ZQusZcv2U+T6fUcTzzfn2qAAKF4yXL7nm/r0mFSyRQ9KnOqivDCfxCEhbE51vdMBJeM0wDAQy50DPS0t6JkqLvP5/CShKChGWYiw0bYhypmWIdoVFJ2XyvNvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GHTpYXzzXjFhyfTGCxkYzMEQbTb0CY4eaDPdePkw08=;
 b=CGpx7BspUHFizx2kzfwa1H5BJquhyNSxaHS9INXKGBGZRox1uGINiDuG6hi31vDY+5A8xutiW8pvkCFJ58Fdfv4wgrTnCIwt39cMhvKcoo8QLAHCSOxk8dSz4qzYOZRpnQap8WPbbOK9jECJme+p45l3YnKupAcU5S/Z6HfQkc4=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5854.namprd04.prod.outlook.com (2603:10b6:208:3c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Tue, 15 Sep
 2020 20:44:11 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94%6]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 20:44:10 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: RE: [PATCH v3 01/15] hw/block/nvme: Define 64 bit cqe.result
Thread-Topic: [PATCH v3 01/15] hw/block/nvme: Define 64 bit cqe.result
Thread-Index: AQHWihtL9tNHpqz1v0eii/7TyAZucKlpUd8AgAC3oNCAABaxAIAACKzw
Date: Tue, 15 Sep 2020 20:44:09 +0000
Message-ID: <MN2PR04MB5951E0BA1D9E217C37B82ED3E1200@MN2PR04MB5951.namprd04.prod.outlook.com>
References: <20200913221436.22844-1-dmitry.fomichev@wdc.com>
 <20200913221436.22844-2-dmitry.fomichev@wdc.com>
 <20200915073720.GB499689@apples.localdomain>
 <MN2PR04MB5951ED0FD5633E8144459A28E1200@MN2PR04MB5951.namprd04.prod.outlook.com>
 <20200915195546.GA14485@apples.localdomain>
In-Reply-To: <20200915195546.GA14485@apples.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e46329c9-05f4-4587-3f18-08d859b818f8
x-ms-traffictypediagnostic: MN2PR04MB5854:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB5854E39EEB0BC1E639099603E1200@MN2PR04MB5854.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EE3zqQVkfzyg9zW9e02rhCmG6i0cIWa0UoXWKDLUmTYJfhLyoQhi//9K8HtYCOqhk2T2vFc05aQzncfY6amdqhJhzGvKnAwqLRNhaf19yMqFGQxpbKjxSd3dhO/cN/YDiLn4G7LoBnWbtX5QuW1rieeOxNaaGfJzJvT0RY9k44gFf2NzxCLU5WwxKPE0pzIc05vYXO1sCZkR8VrQIx2YcAO5hvWb1pUpzUWvR7S8O5bAQzENIWuMkBZNAWvl/pfeNheRDil6Qx0YsiR2ESUeTjMiWQs7JsDeXLb8W/2Tcll3fnCNLQWWyFqy/AsCQP0vQNlgh88eEy8l2UwWJrpSeFcJO2OdfYpZ+TlnBJ89T5wu0SV0RXEWY+fCYABlH7Yt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(66946007)(83380400001)(86362001)(5660300002)(52536014)(8676002)(9686003)(71200400001)(53546011)(6506007)(55016002)(2906002)(33656002)(316002)(66446008)(64756008)(66556008)(66476007)(76116006)(26005)(7696005)(6916009)(4326008)(478600001)(54906003)(186003)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 9lTlipSrQN6gdI7plsjBZkUnWmoimwI7jZwK+pNgUhfWVhUnbocDi+nmH0GibtY+1R9NNr7L2o2S/HG5kjMjtxW+x9uxHulHwG4tg745Uhrgn7S2JhCvfVGZ9oLguGpKQLqnl5xEvWesK+hy8rgaaRefRPHRNlIt8a7bEryhplnZm3ZfEfj+yCWoQ+DJgyK3F7AuJNr4SX3RCUz0bFMyYkOxqCaCM2OFXxFiKXNYyYVw+SaIROGio4OSGFWLg+pyRO1fbU4Qm4RnhVYhD93TyJN31AmkfzYPWy9+4x/pLJZSV7heqsr8NnbPMdqg8YDCiEqgFKUNern/v9FMbiprJ7andlRmXUivBpIx5NavUSbXiVmLVQ6FODYOmxuqGdzd7U6jPC2TPjxAtTrRSod31sjb58vrRFDXo6UY3Of60SOa31y3X5waDRonkx+3UTE6lzO48EO5L7RKSiZvGCYjX6hFfksYhjZhjW8bmeRTd2Ydj+khNG+I1BgknQ8okJ2eoKdNV27688dUfZ9ccChF9g345HN+CnZhjkniodNGMievCpeR/vOGnHn04LNTq66lxqUw/uErNXy5+yk0dRRHvnwScXvYfs1VBmZiOGw2Npi31SQLpYovtnLm+ea7NRCxMZLrq9SlHcv2foQoTU3+9w==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e46329c9-05f4-4587-3f18-08d859b818f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 20:44:09.7843 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E44RyxN7meJSmscer/riVGAc6r0CVDmtuZTyGDKDlXeNqBlXo1Bwpzko3eX3ITGlSznglqXP6Yt7Dby+GG0W2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5854
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=520035bb9=Dmitry.Fomichev@wdc.com; helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 14:57:52
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
 Alistair Francis <Alistair.Francis@wdc.com>, Keith Busch <kbusch@kernel.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLbGF1cyBKZW5zZW4gPGl0c0Bp
cnJlbGV2YW50LmRrPg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMTUsIDIwMjAgMzo1NiBQ
TQ0KPiBUbzogRG1pdHJ5IEZvbWljaGV2IDxEbWl0cnkuRm9taWNoZXZAd2RjLmNvbT4NCj4gQ2M6
IEZhbSBaaGVuZyA8ZmFtQGV1cGhvbi5uZXQ+OyBLZXZpbiBXb2xmIDxrd29sZkByZWRoYXQuY29t
PjsNCj4gRGFtaWVuIExlIE1vYWwgPERhbWllbi5MZU1vYWxAd2RjLmNvbT47IHFlbXUtYmxvY2tA
bm9uZ251Lm9yZzsNCj4gTmlrbGFzIENhc3NlbCA8TmlrbGFzLkNhc3NlbEB3ZGMuY29tPjsgS2xh
dXMgSmVuc2VuDQo+IDxrLmplbnNlbkBzYW1zdW5nLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9y
ZzsgQWxpc3RhaXIgRnJhbmNpcw0KPiA8QWxpc3RhaXIuRnJhbmNpc0B3ZGMuY29tPjsgS2VpdGgg
QnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPjsgUGhpbGlwcGUNCj4gTWF0aGlldS1EYXVkw6kgPHBo
aWxtZEByZWRoYXQuY29tPjsgTWF0aWFzIEJqb3JsaW5nDQo+IDxNYXRpYXMuQmpvcmxpbmdAd2Rj
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAwMS8xNV0gaHcvYmxvY2svbnZtZTogRGVm
aW5lIDY0IGJpdCBjcWUucmVzdWx0DQo+IA0KPiBPbiBTZXAgMTUgMTg6NTYsIERtaXRyeSBGb21p
Y2hldiB3cm90ZToNCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9t
OiBLbGF1cyBKZW5zZW4gPGl0c0BpcnJlbGV2YW50LmRrPg0KPiA+ID4gU2VudDogVHVlc2RheSwg
U2VwdGVtYmVyIDE1LCAyMDIwIDM6MzcgQU0NCj4gPiA+IFRvOiBEbWl0cnkgRm9taWNoZXYgPERt
aXRyeS5Gb21pY2hldkB3ZGMuY29tPg0KPiA+ID4gQ2M6IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2Vy
bmVsLm9yZz47IEtsYXVzIEplbnNlbg0KPiA+ID4gPGsuamVuc2VuQHNhbXN1bmcuY29tPjsgS2V2
aW4gV29sZiA8a3dvbGZAcmVkaGF0LmNvbT47IFBoaWxpcHBlDQo+ID4gPiBNYXRoaWV1LURhdWTD
qSA8cGhpbG1kQHJlZGhhdC5jb20+OyBNYXhpbSBMZXZpdHNreQ0KPiA+ID4gPG1sZXZpdHNrQHJl
ZGhhdC5jb20+OyBGYW0gWmhlbmcgPGZhbUBldXBob24ubmV0PjsgTmlrbGFzIENhc3NlbA0KPiA+
ID4gPE5pa2xhcy5DYXNzZWxAd2RjLmNvbT47IERhbWllbiBMZSBNb2FsDQo+IDxEYW1pZW4uTGVN
b2FsQHdkYy5jb20+Ow0KPiA+ID4gcWVtdS1ibG9ja0Bub25nbnUub3JnOyBxZW11LWRldmVsQG5v
bmdudS5vcmc7IEFsaXN0YWlyIEZyYW5jaXMNCj4gPiA+IDxBbGlzdGFpci5GcmFuY2lzQHdkYy5j
b20+OyBNYXRpYXMgQmpvcmxpbmcgPE1hdGlhcy5Cam9ybGluZ0B3ZGMuY29tPg0KPiA+ID4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MyAwMS8xNV0gaHcvYmxvY2svbnZtZTogRGVmaW5lIDY0IGJpdCBj
cWUucmVzdWx0DQo+ID4gPg0KPiA+ID4gT24gU2VwIDE0IDA3OjE0LCBEbWl0cnkgRm9taWNoZXYg
d3JvdGU6DQo+ID4gPiA+IEZyb206IEFqYXkgSm9zaGkgPGFqYXkuam9zaGlAd2RjLmNvbT4NCj4g
PiA+ID4NCj4gPiA+ID4gQSBuZXcgd3JpdGUgY29tbWFuZCwgWm9uZSBBcHBlbmQsIGlzIGFkZGVk
IGFzIGEgcGFydCBvZiBab25lZA0KPiA+ID4gPiBOYW1lc3BhY2UgQ29tbWFuZCBTZXQuIFVwb24g
c3VjY2Vzc2Z1bCBjb21wbGV0aW9uIG9mIHRoaXMNCj4gY29tbWFuZCwNCj4gPiA+ID4gdGhlIGNv
bnRyb2xsZXIgcmV0dXJucyB0aGUgc3RhcnQgTEJBIG9mIHRoZSBwZXJmb3JtZWQgd3JpdGUgb3Bl
cmF0aW9uDQo+ID4gPiA+IGluIGNxZS5yZXN1bHQgZmllbGQuIFRoZXJlZm9yZSwgdGhlIG1heGlt
dW0gc2l6ZSBvZiB0aGlzIHZhcmlhYmxlDQo+ID4gPiA+IG5lZWRzIHRvIGJlIGNoYW5nZWQgZnJv
bSAzMiB0byA2NCBiaXQsIGNvbnN1bWluZyB0aGUgcmVzZXJ2ZWQgMzIgYml0DQo+ID4gPiA+IGZp
ZWxkIHRoYXQgZm9sbG93cyB0aGUgcmVzdWx0IGluIENRRSBzdHJ1Y3QuIFNpbmNlIHRoZSBleGlz
dGluZw0KPiA+ID4gPiBjb21tYW5kcyBhcmUgZXhwZWN0ZWQgdG8gcmV0dXJuIGEgMzIgYml0IExF
IHZhbHVlLCB0d28gc2VwYXJhdGUNCj4gPiA+ID4gdmFyaWFibGVzLCByZXN1bHQzMiBhbmQgcmVz
dWx0NjQsIGFyZSBub3cga2VwdCBpbiBhIHVuaW9uLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBBamF5IEpvc2hpIDxhamF5Lmpvc2hpQHdkYy5jb20+DQo+ID4gPiA+IFNpZ25lZC1v
ZmYtYnk6IERtaXRyeSBGb21pY2hldiA8ZG1pdHJ5LmZvbWljaGV2QHdkYy5jb20+DQo+ID4gPiA+
IFJldmlld2VkLWJ5OiBLbGF1cyBKZW5zZW4gPGsuamVuc2VuQHNhbXN1bmcuY29tPg0KPiA+ID4N
Cj4gPiA+IEkga25vdyB0aGF0IEkgUi1iJ2VkIHRoaXMsIGJ1dCBjYW4gdGhpcyBiZSBtb3ZlZCB0
byB0aGUgbmFtZXNwYWNlIHR5cGVzDQo+ID4gPiBwYXRjaCwgc2luY2UgdGhhdCBpcyB0aGUgVFAg
dGhhdCBjaGFuZ2VzIHRoaXMuDQo+ID4NCj4gPiBZb3UgcHJvYmFibHkgbWVhbnQgdGhlIFpOUyBw
YXRjaCBzaW5jZSByZXN1bHQ2NCBpcyBmaXJzdCB1c2VkIHRoZXJlIHRvDQo+IHJldHVybg0KPiA+
IFpBIHN0YXJ0aW5nIGRhdGEgTEJBLiBTdXJlLCBJIGNhbiBtb3ZlIHRoaXMgc3R1ZmYgdG8gdGhh
dCBwYXRjaC4NCj4gPg0KPiANCj4gTm8sIEkgYWN0dWFsbHkgZGlkIG1lYW4gdGhlIE5TVCBwYXRj
aCBzaW5jZSBUUCA0MDU2IGlzIHRoZSBUUCB0aGF0DQo+ICJ1bnJlc2VydmVzIiBkdzEgaW4gdGhl
IENRRS4NCg0KSXQgaXMgbm90IG5lY2Vzc2FyeSB0byBjaGFuZ2UgaXQgaW4gTlNUIHBhdGNoIHNp
bmNlIHJlc3VsdDY0IGZpZWxkIGlzIG5vdCB1c2VkDQppbiB0aGF0IHBhdGNoLiBCdXQgaWYgeW91
IGluc2lzdCwgSSBjYW4gbW92ZSBpdCB0byBOU1QgcGF0Y2ggOikNCg==

