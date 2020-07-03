Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CBFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 00:57:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC07E2073E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 00:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="n8MH87nQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CVRfs1pj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC07E2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrA0q-000340-4g
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 20:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=446c5dbe3=Dmitry.Fomichev@wdc.com>)
 id 1jr9rI-0004Hp-7V; Thu, 02 Jul 2020 20:47:16 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:55912)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=446c5dbe3=Dmitry.Fomichev@wdc.com>)
 id 1jr9rG-0006tB-Dq; Thu, 02 Jul 2020 20:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593737234; x=1625273234;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=TEFXSH0WnmJ7v/PMsOZrnIecp29sWZ3v3XUSrKWYSws=;
 b=n8MH87nQSOG9RrYqIDMHYl6jW3A9I1UnD4i89oFvMyTSFt4sNevp4bw9
 ai5CMvS90MyLSwak2yWlimBG2+XBIlAkOm5unomb/TCd/28sWnVUSb9dt
 x/9kSKHCU9+TihvjdARZl/LZLlsx9qm+EUXDHLf3oqKkSU239sKiM/LFh
 HUpBciMDLyNo+uRlOc3I5o1KYQXZ7d+wiWgjVZppTPzdw9fqNT6wF8avU
 WjTJ8XDUC37thBnHPTZqvhwN5JTqI2jBTk5JbgWE/3kFdVIzzNzAytPZ8
 7bAHAA2Mkom0q7SzXnx6HkERxp3oCoC1zT4l1fimLL+xMtwcjJb/JkVdT A==;
IronPort-SDR: uKlXQ9kG3mANWB0cSBxlMbCHbg2+hJbw6V+m+aNnQXhQhG0PDiyu66V4i7tTJ6+a25q8UuAW83
 pQGfL93CvF/8b7IqUPTEOQOoGxJg3tfRhd/GfDxB7g31rAXBcAMRhfWIMc8otN7HoTDLFDdNY/
 pi27gjz5AmPzIunDsUw4P1KVpw1Op/QEGLenFOypOnqDHqDbVpZhghv6eDxhhf2occ6yVBJxSE
 NrUZtO3BtYxOuWdiAe12/zZ/KqaZ13HuQZp5yMcuhbyLNxF3qGEZ8iaJ3BExdCyWwyeyFhQZgk
 Dk0=
X-IronPort-AV: E=Sophos;i="5.75,306,1589212800"; d="scan'208";a="141537448"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 08:47:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhU6m+JAwOPTOj5KpsR6HDOVJF2to4UnMuAiBRoT/fPwJixWRtutvCJDMs65Ew7oip7D3tqO4QIUwdVSjlhcPiikAkfLM+yMqGrJPMoJMGEaN8Yn1Vk1hcWy/dT76SK83SfiTQ6Zv9aV1VEcq0F8ERXj9ZUAKpnLs0dxpqVm57vQICEx08kk7bdxB2Jo0UbZHB0lyh8Teq79qIcNDbCOiVIZojP48UpbztBvLxLr2erJhpwYwfOPrNbWaTnujRsr6OF+JlFuGUPSW3rCnM+K+HEsNFNBzHhWWDUH8mIJCpTpyhjcFfHGx2BHUdlNOiEmSyTmu152UhzwGDC18xjTVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEFXSH0WnmJ7v/PMsOZrnIecp29sWZ3v3XUSrKWYSws=;
 b=BSEd6+Whjn3oRTlPqhI8BAy0kQa/bkfj5vzLgzzVT3Md6VxPOFkXaAf5TQ+t5ye6UsdNhp8H2h60S8qJQEB9RgERL7zENuNiYyyaYQG9fF6cGelhjbvhg3v5MTXImCw/625xMwQ+uLF+wNG868yY4zBL7Zr/eq7bJmP0PSi2OCg06sGxZunNkszYHDBOunhydhUa5/lgSaULR4HIvcHfKchFOZj2M839scFGv8LLjViq5/ccE8Dy2JiTV1VU5KEiYnnB5d2sdJ3Nl5WKlSAEnM9dUCNOyFVtUTIW6JomuuBy4mcMNbTNv4e7grnPm9K+FZnYueZxtPDk1fQd422D7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEFXSH0WnmJ7v/PMsOZrnIecp29sWZ3v3XUSrKWYSws=;
 b=CVRfs1pj+teO07ztvzXXbbHklieEZNuyCPnqn1V3tcqdwVy0mUMAQEhp4qWSi4K2BSGM5R+l9Vdd/Gn9C/PtBIVZl12zZcVer+czoRs/EEuKK4uuOSfCznNy2CTyHffpcwpG9+tW6mtOpnO/XNYOPOlJHWxdI4zzFm28fy0G6iM=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5552.namprd04.prod.outlook.com (2603:10b6:208:de::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Fri, 3 Jul
 2020 00:47:11 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9%5]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 00:47:11 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: "its@irrelevant.dk" <its@irrelevant.dk>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 16/17] hw/block/nvme: provide the mandatory subnqn field
Thread-Topic: [PATCH 16/17] hw/block/nvme: provide the mandatory subnqn field
Thread-Index: AQHWTkQC/CK1j4dOiEywJfR1yDeFgKj1Cm8A
Date: Fri, 3 Jul 2020 00:47:10 +0000
Message-ID: <f8b6f9d301452b77bfdd236ca28cac2516f97089.camel@wdc.com>
References: <20200629182642.1170387-1-its@irrelevant.dk>
 <20200629182642.1170387-17-its@irrelevant.dk>
In-Reply-To: <20200629182642.1170387-17-its@irrelevant.dk>
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
x-ms-office365-filtering-correlation-id: c24ed4fa-883f-48b3-f9be-08d81eea9efa
x-ms-traffictypediagnostic: MN2PR04MB5552:
x-microsoft-antispam-prvs: <MN2PR04MB55527190EE8C9E7973A9CDB7E16A0@MN2PR04MB5552.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lwt6sw31ItSY19tOBYXR/iKjwejK5DHMnbAD5GwP6ux5U6JCf47MTAXsIf24pr0hbq00lGEEMDYXQIOnVz9/s6JmJt9viZfGFOhqm2AUenV1bw4aBwjAWalfB/rE5sGsaqvqocEewxaHXetlIVwobK0DkOGMWysW8rnUc18FAY7cmdQFEkqck5QQHvSFTuTetpmdbiLL57MOUUvcTlIKhep0gMAdy+qP7WxBkne4VyLT4+QsEi6+SuR/HWkKcp48T+z5cy9gVStG98jwNjZT2HBmNBt13Xqfq7eanvNWHBxWXOzA7T+hLkR0DHPm7UBUgEFHePIveQgOQVejnjNjTw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(4326008)(4744005)(186003)(76116006)(2616005)(83380400001)(6486002)(6512007)(110136005)(66946007)(66476007)(66446008)(54906003)(64756008)(66556008)(36756003)(71200400001)(8936002)(26005)(86362001)(316002)(5660300002)(2906002)(8676002)(478600001)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: kSW3x90MRMUgZz0UaKOAHpuhVTnSq0b3h+rdVRLpsC//zBZbkIO8IsQqHYUzOEEXgWUdwdxFK1Z3iUE5D4eysOWbzLF59peK6bQyDdgea03SX/V9jhxS/cr5/H5YIPBJAQ2GA6qgAZK1RThpFbl21AwSCbkuToTI7YVeq4m2gGzAQa4PBggsyItrqovh8wzkOW4Tb9MTtLvSk6gl+S8644kgaBr8M1JJRcVFyFDT2/JgxSaAHxqgnpZJzHaoFiSa1D5io5daTpCyc+ypDwO8GIboGw8AC0U7MHumWk3+ioJXFOIsKn5Za69S9Js7PPLFXH8A56cxpPS0Yi4u8R1kMjCEOgSyXHvRTaqmWsxFJTvjqr/iaXVDWufwA/D5pYzyZfTDIt10vXmjRVu0hsx6sheq2gBFP1Sb/NKd5kj23QRRGacdow+x3r33QC7R3oyIFZqFtkQA+hpc4RHDgmW5QevAxov/18hKp7gJfftot4gOYnFXP8RxjzWZ4EkaFxqw
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC648344239898409522E9430747BBCD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c24ed4fa-883f-48b3-f9be-08d81eea9efa
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 00:47:10.9884 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UMQ9kesyBfNX1CUL+lfwPMZ4rb7P78MylooXgwVHJKqCh0ZVtB/TWiWfBKSlkZqFS7fgnnGmNvFT7dvFbhVIlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5552
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=446c5dbe3=Dmitry.Fomichev@wdc.com; helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 20:44:23
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
Pg0KPiANCj4gVGhlIFNVQk5RTiBmaWVsZCBpcyBtYW5kYXRvcnkgaW4gTlZNIEV4cHJlc3MgMS4z
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS2xhdXMgSmVuc2VuIDxrLmplbnNlbkBzYW1zdW5nLmNv
bT4NCj4gUmV2aWV3ZWQtYnk6IE1heGltIExldml0c2t5IDxtbGV2aXRza0ByZWRoYXQuY29tPg0K
PiAtLS0NCj4gIGh3L2Jsb2NrL252bWUuYyB8IDMgKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvYmxvY2svbnZtZS5jIGIvaHcvYmxv
Y2svbnZtZS5jDQo+IGluZGV4IDc5OGY2ZjMwZTdkYS4uOWYwYjlkZTczMzA3IDEwMDY0NA0KPiAt
LS0gYS9ody9ibG9jay9udm1lLmMNCj4gKysrIGIvaHcvYmxvY2svbnZtZS5jDQo+IEBAIC0yMTMx
LDYgKzIxMzEsOSBAQCBzdGF0aWMgdm9pZCBudm1lX2luaXRfY3RybChOdm1lQ3RybCAqbiwgUENJ
RGV2aWNlICpwY2lfZGV2KQ0KPiAgICAgIGlkLT5vbmNzID0gY3B1X3RvX2xlMTYoTlZNRV9PTkNT
X1dSSVRFX1pFUk9TIHwgTlZNRV9PTkNTX1RJTUVTVEFNUCB8DQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBOVk1FX09OQ1NfRkVBVFVSRVMpOw0KPiAgDQo+ICsgICAgcHN0cmNweSgoY2hh
ciAqKSBpZC0+c3VibnFuLCBzaXplb2YoaWQtPnN1Ym5xbiksICJucW4uMjAxOS0wOC5vcmcucWVt
dToiKTsNCj4gKyAgICBwc3RyY2F0KChjaGFyICopIGlkLT5zdWJucW4sIHNpemVvZihpZC0+c3Vi
bnFuKSwgbi0+cGFyYW1zLnNlcmlhbCk7DQo+ICsNCj4gICAgICBpZC0+cHNkWzBdLm1wID0gY3B1
X3RvX2xlMTYoMHg5YzQpOw0KPiAgICAgIGlkLT5wc2RbMF0uZW5sYXQgPSBjcHVfdG9fbGUzMigw
eDEwKTsNCj4gICAgICBpZC0+cHNkWzBdLmV4bGF0ID0gY3B1X3RvX2xlMzIoMHg0KTsNCg==

