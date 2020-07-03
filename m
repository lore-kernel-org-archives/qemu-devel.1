Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E67C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 00:53:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70FC72073E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 00:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oGEzceLu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SibKHKgi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70FC72073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr9x6-0006XF-O5
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 20:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=446c5dbe3=Dmitry.Fomichev@wdc.com>)
 id 1jr9rQ-0004it-E3; Thu, 02 Jul 2020 20:47:24 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:55925)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=446c5dbe3=Dmitry.Fomichev@wdc.com>)
 id 1jr9rO-0006u7-Fq; Thu, 02 Jul 2020 20:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593737242; x=1625273242;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Z+9jFuwWeNze43hX5/vfgdwIXi1xvPMsad4zZVZHCxQ=;
 b=oGEzceLuYZYLj0SOvakV0TgpecsPCT2Yc+6y+SRUESYSTyWrkhzUXl8l
 lDlH7JjW5cyEJ/vVZZjdZAJ0yp3ZEbfBEjqhgbngf7voY3rW5JJt6Djzn
 SiPKNOExcV22KhIPyH0UIJMer4iEQU6XEvYMTRNF8Dt6fSC9ngJKDYJIu
 56/YsJtLR3reUbxT0Fc9EMhNlP7ytQudXD1vIRVj7Q5zlItg7nnb/jcUs
 1ewEYPBDOy1la7MuniwbDRYCkK4G/8i3uPD+wTH/Xz6fSNXy53EaJZxsc
 Pw6398Bn7EKeV33p86EKvUACmcl4IBbXQGcbFxHtXweRfVkzySMZv3mUT g==;
IronPort-SDR: SDbhkOpjViafk7vWwJqcxIFfQ1Z8P2CVG2brmjL4ycVGZDGJHtlq8LOCG64GSGNQSxJPGLhx5R
 8xEAgf8s91hJWRlVGX25OtExQeplsE4zwURdu/UjfGxn8+VroieAAe8SaEVCZLHSvFk3VQRTxZ
 JaOq3/XJ94GJ9A006AELydHreTxQ/HgBgobS3XSD1IE/TC/4A1tAQUye+jV4x2pS5BjqORU8YQ
 JlJZcQFBYTauAWSRhqUlsvJ9L2ecVPLRtNfGwfGEnYGr7etOhX95BgdPMec93S1vL6Whf56Vm1
 q9A=
X-IronPort-AV: E=Sophos;i="5.75,306,1589212800"; d="scan'208";a="141537457"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 08:47:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReHmAdPm3JXzbtuuN7GBVZTlovOHQmoKiIGEJOp/yxmTgVaqXjU7r1YzfITGhZQTnM8y39JkOvO1NpAQdKIA1TyYAS+3btxWWQwFF79o62tDXC2BfIuZEVnUBDQZPjIX1z0GRA0CSrhMZm3ZnJqZ2dRrvPvtetRFmM2y6BzoN5s/Fb++1KcM0JBvgXR8NqoZycXMI5+D8YljxaoMxg2mTqPQa2Ft7eFt4Icly4anz2Mi4J4VE38+UKx24Z1DgENGtYUErujrjHIpQkDichjpDLiklUdZGW1yRjQThv67/IhIjPIPDU7ObAIvjzkTx2lWFngsElh7HvuD5fWb0G7MIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+9jFuwWeNze43hX5/vfgdwIXi1xvPMsad4zZVZHCxQ=;
 b=SqMzmmnUv2k1NwRRez3ap62Ml6CLAUrqQxYEUNMuixj6v9zcKmhyav1pz7ZOyPu9tuf/22oe0JZEncXTz/IBVU69YtYQFGlZak/y9sEONkEFyKnWEkoDJRelRJwTKIvvzdgK/f6BFrAMg9skYPlVlr8gHpgAGIYpKcIGwR7DfragHmf1Bk4zC2B3KQZB+qxZO+M+Ngz+ibYabWmcHhs5RFg/chxBHLhXgviYns4n/2nY4FbAHlJsZ7WAI6jPidTgAIwXRmJnG3zGklGM7WT7Wl1ayCIiyZBfQAN7o6q09tr3aoLBpIUyj0MFNm95BJ3RZheF32sRsUMhYKLetTmU1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+9jFuwWeNze43hX5/vfgdwIXi1xvPMsad4zZVZHCxQ=;
 b=SibKHKgioA/iyeHTAooiOk9l5Vz3kg9fYCzDcEaSeQrbcKrMMs1gN2R0z9oukFzz0QlZQuby4zoh61o4vpbHPhCPSSq6q8EsS12En/l4bnOCjLymEKdhfJXGI0q2BWj+Zb1nvE6AVFE/vqZOr6OK/NG+owD/p3OLs6x1PbZHUzs=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5552.namprd04.prod.outlook.com (2603:10b6:208:de::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Fri, 3 Jul
 2020 00:47:19 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9%5]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 00:47:19 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: "its@irrelevant.dk" <its@irrelevant.dk>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 17/17] hw/block/nvme: bump supported version to v1.3
Thread-Topic: [PATCH 17/17] hw/block/nvme: bump supported version to v1.3
Thread-Index: AQHWTkR6co3TuT6nXkaJmQLq7HWoHqj1CngA
Date: Fri, 3 Jul 2020 00:47:19 +0000
Message-ID: <e18ff9d98019e16b98df68fe7e8df81c8a6d4a2d.camel@wdc.com>
References: <20200629182642.1170387-1-its@irrelevant.dk>
 <20200629182642.1170387-18-its@irrelevant.dk>
In-Reply-To: <20200629182642.1170387-18-its@irrelevant.dk>
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
x-ms-office365-filtering-correlation-id: 0b5678f8-3abe-4d07-f7e0-08d81eeaa3d9
x-ms-traffictypediagnostic: MN2PR04MB5552:
x-microsoft-antispam-prvs: <MN2PR04MB5552C1C18155AD49F58BDE5CE16A0@MN2PR04MB5552.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B4qEcE3dEZJ9juk3zUB3Bl9W0WKel2BPjlr9roZ0+//TEwFyHUojQubfbQqGVvLefZn/UEhkYCx0oJZmLAsOl8ljYqjJUN8RpQ/r0aM+QoO02/7qdpTUp8Jz+B9L+l+sbhFZAIP6OHaYzhTTgOT2NM0VXpFOPYHpiQ9HnwsDEne75Spy96ZJCAcvJbqxEORgiWBeS8eCWu6czN41e+sKeNPElaRv1ePEXt8G/opRF6VraLpsKuIOlCQrbx+GFXjlfts3zkGTI/ZNPDlNgSd1pZpHUAnQ1XsqQLxFAza7aYW79ycDuuCZKFtgcVC6oP1B1XIH43tVCfD+k2dg2G7dQA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(4326008)(186003)(76116006)(2616005)(83380400001)(6486002)(6512007)(110136005)(66946007)(66476007)(66446008)(54906003)(64756008)(66556008)(36756003)(71200400001)(8936002)(26005)(86362001)(316002)(5660300002)(2906002)(8676002)(478600001)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: q2COgdbncfAdulr5z+dVZ4ph+I8rL2K6lPD92Kp0/Oj/s4o0VckUy2lfyMR3IsiipZON2TKxiHCnGQXGC9lMviutJiGvtz6RE8MGE2xt+dBUOhjYpQDTH8BeCNohQke0cM8VMtBLWdivHKF9K+NkrSW3w/BnHom2KqxoQu4cFlWC0ScDaoEGV3yheEg7kXfOOoCBJL/klamhae2U9izUf/nnzpJOtuZb3MyoV/xGv8ztxCua+Jpj1ntlSg37TMb66iPVJPGCUq2Am/lhwDrpVnFGQGWb7bzH3N/CW7gwiCEh4hxYZgSYtxf8l8JyOWED/k5Pr/sZjKnDcoGNoTmTsS28Tjv5+NJ4d5fHf/U2zKH6rVZVIR0ryiQ9ah2Kndw9+mZMo+M4rcDRPy/zGqkzJ8EbzYd0hhUzDRUM4M7j2s773cc4mnzLwCLqJ9G+m79Cm7WdTfh8J1xb8uGV0c26rZ/jnDheCZxKxLG9amxLDbl9VD6q8rmYjFHgkKR3r6YA
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DD0C6F07161874BAAF9904B4F7FD77E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5678f8-3abe-4d07-f7e0-08d81eeaa3d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 00:47:19.1187 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mt+RQC1cRsLt7krS/sTCAJgG2wF8vdDIwZEu+rHZqtPkPd/YD0rTyaDQngiDsyMLazdccLGFvbmGAKO5GuUhDA==
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
 "k.jensen@samsung.com" <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IERtaXRyeSBGb21pY2hldiA8ZG1pdHJ5LmZvbWlj
aGV2QHdkYy5jb20+DQoNCk9uIE1vbiwgMjAyMC0wNi0yOSBhdCAyMDoyNiArMDIwMCwgS2xhdXMg
SmVuc2VuIHdyb3RlOg0KPiBGcm9tOiBLbGF1cyBKZW5zZW4gPGsuamVuc2VuQHNhbXN1bmcuY29t
Pg0KPiANCj4gQnVtcCB0aGUgc3VwcG9ydGVkIE5WTSBFeHByZXNzIHZlcnNpb24gdG8gdjEuMy4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtsYXVzIEplbnNlbiA8ay5qZW5zZW5Ac2Ftc3VuZy5jb20+
DQo+IFJldmlld2VkLWJ5OiBNYXhpbSBMZXZpdHNreSA8bWxldml0c2tAcmVkaGF0LmNvbT4NCj4g
LS0tDQo+ICBody9ibG9jay9udm1lLmMgfCA0ICsrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9ibG9jay9u
dm1lLmMgYi9ody9ibG9jay9udm1lLmMNCj4gaW5kZXggOWYwYjlkZTczMzA3Li5mYmU5YjJkNTA4
OTUgMTAwNjQ0DQo+IC0tLSBhL2h3L2Jsb2NrL252bWUuYw0KPiArKysgYi9ody9ibG9jay9udm1l
LmMNCj4gQEAgLTU3LDYgKzU3LDcgQEANCj4gICNkZWZpbmUgTlZNRV9NQVhfSU9RUEFJUlMgMHhm
ZmZmDQo+ICAjZGVmaW5lIE5WTUVfUkVHX1NJWkUgMHgxMDAwDQo+ICAjZGVmaW5lIE5WTUVfREJf
U0laRSAgNA0KPiArI2RlZmluZSBOVk1FX1NQRUNfVkVSIDB4MDAwMTAzMDANCj4gICNkZWZpbmUg
TlZNRV9DTUJfQklSIDINCj4gICNkZWZpbmUgTlZNRV9QTVJfQklSIDINCj4gICNkZWZpbmUgTlZN
RV9URU1QRVJBVFVSRSAweDE0Mw0KPiBAQCAtMjEwMyw2ICsyMTA0LDcgQEAgc3RhdGljIHZvaWQg
bnZtZV9pbml0X2N0cmwoTnZtZUN0cmwgKm4sIFBDSURldmljZSAqcGNpX2RldikNCj4gICAgICBp
ZC0+aWVlZVswXSA9IDB4MDA7DQo+ICAgICAgaWQtPmllZWVbMV0gPSAweDAyOw0KPiAgICAgIGlk
LT5pZWVlWzJdID0gMHhiMzsNCj4gKyAgICBpZC0+dmVyID0gY3B1X3RvX2xlMzIoTlZNRV9TUEVD
X1ZFUik7DQo+ICAgICAgaWQtPm9hY3MgPSBjcHVfdG9fbGUxNigwKTsNCj4gIA0KPiAgICAgIC8q
DQo+IEBAIC0yMTQ4LDcgKzIxNTAsNyBAQCBzdGF0aWMgdm9pZCBudm1lX2luaXRfY3RybChOdm1l
Q3RybCAqbiwgUENJRGV2aWNlICpwY2lfZGV2KQ0KPiAgICAgIE5WTUVfQ0FQX1NFVF9DU1Mobi0+
YmFyLmNhcCwgMSk7DQo+ICAgICAgTlZNRV9DQVBfU0VUX01QU01BWChuLT5iYXIuY2FwLCA0KTsN
Cj4gIA0KPiAtICAgIG4tPmJhci52cyA9IDB4MDAwMTAyMDA7DQo+ICsgICAgbi0+YmFyLnZzID0g
TlZNRV9TUEVDX1ZFUjsNCj4gICAgICBuLT5iYXIuaW50bWMgPSBuLT5iYXIuaW50bXMgPSAwOw0K
PiAgfQ0KPiAgDQo=

