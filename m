Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BBAC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 00:47:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FEBB207D4
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 00:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MyVHWJro";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nIndXk6w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FEBB207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr9r5-0003C8-J4
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 20:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=446c5dbe3=Dmitry.Fomichev@wdc.com>)
 id 1jr9p7-0000DG-Gi; Thu, 02 Jul 2020 20:45:01 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:34876)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=446c5dbe3=Dmitry.Fomichev@wdc.com>)
 id 1jr9p5-0006VP-8V; Thu, 02 Jul 2020 20:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593737100; x=1625273100;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=vYp0ddwRR5Vk8K8am6bxb7PQEA32RliZN2/gzEtMRKo=;
 b=MyVHWJro1ZOEzh69GGP6+qavJMBK/FVTkZUwefORBPuGGtM0LzqIOF2d
 wsYislq/N63GfMEmDsoWmpf8AugdiLmxhHRJrh8eXG41pOEo4kMcopi1u
 0o5d24RCPe0oi0TZKfWf8BsXgPhMvNvLvV87QXpT/JuTZd4VuUIHUNdGZ
 AU5zogBvg753N3Izvfzo++0PbHKcuq4Df65t9cgpfzq1mhhLgh3ZOUath
 kidw21JjfnlzJWXOCJQVgKUJjhbxIt9pOJ3lHySxtI43jJwVNYjaIpIoL
 v+qcgkTyqD5bNHZdD6KoxzcOjvDnPG59Zupr0XIOg9lRlyCHAxN4tgxLp w==;
IronPort-SDR: YhsWzPSA8tG05heA3LLR8ODdVuLHt57KqCXGfxkUrFk91M+lwvhFUVsJOMueyUnK7+w9v7cOLj
 xwxAOPc28hbKIYXA8ErYpC4nliiYAu0mrTvWPSRm1ekj04xaLeGZ1J8dqFhXwLHwjGIgXqtoaZ
 xIxdvhTm8qsGaSU4xAr8BNxt8cnCJVrEigN3Wqo4Uueh1gLpHHxabMIDPLk+tOc7jqeSByV3Cq
 ZDeoi/Sslyof9Qv6L+DSEPAOm6ZtS62poNtIqlmopxKDm33prmJMOYIpSmGRS7qTSai5E3x6Ba
 0cU=
X-IronPort-AV: E=Sophos;i="5.75,306,1589212800"; d="scan'208";a="145864584"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 08:44:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngfQh6738D/URQkq1WWUTKGT1ZREIjMYmlDTtjqT5v+xrvsk+5+gb+Ka55OEoERppwk+y0DX8kuh996HpXDYUgA7UrnBPMZ1IpBb4JVP3kQ7jQ2N4cPAVy4wX2tW16ZnR/ej6wN0NP+XonIwb4G2OO2G1lcUOmojDPZ86CfzS+nbjuf0bk01J8+sAl5MSXzBDN+VIZYW7hXajSuBsoCj3sbhHmNtXdWZWCIMZhthan8+LihzQ7lsu76LW4HCo8S/vvnYG77G5n4P5+aCne8XhvalbdJUuQelk6BJ3bDHdY0zKaJRKWOOFzWcUKHxJ6u3xaWg4IU6q00qlO5q8mghhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYp0ddwRR5Vk8K8am6bxb7PQEA32RliZN2/gzEtMRKo=;
 b=N2qSjoO1/qN/BLRjU0VrYuLGdd/QeWUkRy+wu9XGSeaj2XRqkuuiPB2d9EK5J3ibjtog/tiX0nrPhj0iUJivDmUM+4s20lJq4roMEYHO9ooC3ytKGqN3V/5nHna3G87RnzpWNMoo9cR80T+7i1EUpYBAJIO6oDr86iWVZXU2ghIRRMDeD/JTpLofzGmP6Xdz2l3SdQKyMM2ngD6Fb93No8w0NJa69VgGZDmp4RmLpxSROS8m23ADpxGkSfqgB9/aTXCB6reyxlXBaBdgv4tams2qh34087YyFYktsYvsQXUtdJSoUz/L++D5w8Jal4qkj+bLV6vd1qIfY2mJo8lr5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYp0ddwRR5Vk8K8am6bxb7PQEA32RliZN2/gzEtMRKo=;
 b=nIndXk6wIBA+HgviYatppdYvheKEh+1e3xL9Y2ONduI7MjCSYCYjHfZKEm9AVXYByohlMNFyIScKYxNMDNw+EFsiqjFaORcaqiNLjsOldU6mRD6pjP+F9EH78c3g4QkAyce6kiG2tkS5LdM8tVWkLRl9bbaazkT2f/jIiS/GCiI=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5552.namprd04.prod.outlook.com (2603:10b6:208:de::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Fri, 3 Jul
 2020 00:44:55 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9%5]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 00:44:55 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: "its@irrelevant.dk" <its@irrelevant.dk>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 05/17] hw/block/nvme: mark fw slot 1 as read-only
Thread-Topic: [PATCH 05/17] hw/block/nvme: mark fw slot 1 as read-only
Thread-Index: AQHWTkLoUje92wtxNUaNIlCvKnxKF6j1Cc8A
Date: Fri, 3 Jul 2020 00:44:55 +0000
Message-ID: <1312a66f16bf30f35680a9e3660025e522068e1f.camel@wdc.com>
References: <20200629182642.1170387-1-its@irrelevant.dk>
 <20200629182642.1170387-6-its@irrelevant.dk>
In-Reply-To: <20200629182642.1170387-6-its@irrelevant.dk>
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
x-ms-office365-filtering-correlation-id: b2e01271-15e3-4325-bdd0-08d81eea4e22
x-ms-traffictypediagnostic: MN2PR04MB5552:
x-microsoft-antispam-prvs: <MN2PR04MB55522900827F24EAF22C9B7DE16A0@MN2PR04MB5552.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:350;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PbIn/XmIJ/KpHejv2evuFRPt2vAa21vNpKSg9PASDp6P/iuanFtgJnqRFDsehWZuNOOwS7TSicSg0ghwtXtB0HRZmcd9L/U0Lye9ejnhtmADeTc0w7i23ttckKOWIjW40nqA56uPxEAx03OF+nUG4kPugLk72vAim+YMJ1zuYRv9NbLiuFzbLvu+KlQsnhH13XEcg15KMGawFxvyFR6ehKW02RfEat/LJ9TKjbW0Pf00pSmWD+MATnelmn6uuaLngDpXfq8v7yAvoLCAYftYJ7EqJnYQZIrGNgu9zvUNy1TiYAZ8Vz6cYAWFSchf3+0iXAPRnazAptRr/OtRXVVzfQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(4326008)(186003)(76116006)(2616005)(83380400001)(6486002)(6512007)(110136005)(66946007)(66476007)(66446008)(54906003)(64756008)(66556008)(36756003)(71200400001)(8936002)(26005)(86362001)(316002)(5660300002)(2906002)(8676002)(478600001)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Zdh2uIM69Eypg6Z4pjeb3MN1GrWXKIjIcxyga2rJ3A+C6unFKwVheLwBeNFUffQWg81vJR1hPpH8XckjZxlVJIHmAeK/K8HXg+jhdyvedlffPMtw+CroCNQ4C9gp3VWqZf2/RcNuD5Ng2Nn7b6eolwdFdiPweJxHqyohY/oaj0p1iqE5x8CLXngGjgCtJ/i1TSgLuDGGV7vNOkAJTinm30QAm+QrMFmKvlQS3WqCFAOGBRCQysRLa3HdzFN0t7fjCNjBfUVSIjsPKyl8i720O9yGcIvoMev43N9PqPUYL7esWbzT+U1RC+mBNoiud4crdIeBm1OkBVwTQFTQQ05Ww1FRZXJzydC9MBj4Zp/89uIah7KGBlR2MuQ3KotQoWpdQ0vD7d7uumSY9sVTu65OLVId518CChmCKvXHguWz96aLN4ad2cyhZ//ug74XvUNjW3oW1ru7JKmyCneOMxp+gPvoz/xUSXEISXDOyioKo1vixih3TZnM3Y6h4rbzfhs3
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <41638D6876C6C74897982428B16FA7B0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e01271-15e3-4325-bdd0-08d81eea4e22
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 00:44:55.3166 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8T7IDzm0XRwCSwSr2/C1C74tdLd+3Rt1CqzwR+m6BwKdhrZTFYRIhumleUkOJMz95JoYwD7r28mUTvMqJy2CBQ==
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
Pg0KPiANCj4gTWFyayBmaXJtd2FyZSBzbG90IDEgYXMgcmVhZC1vbmx5IGFuZCBvbmx5IHN1cHBv
cnQgdGhhdCBzbG90Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS2xhdXMgSmVuc2VuIDxrLmplbnNl
bkBzYW1zdW5nLmNvbT4NCj4gLS0tDQo+ICBody9ibG9jay9udm1lLmMgICAgICB8IDMgKystDQo+
ICBpbmNsdWRlL2Jsb2NrL252bWUuaCB8IDQgKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA2IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9ibG9jay9u
dm1lLmMgYi9ody9ibG9jay9udm1lLmMNCj4gaW5kZXggNWNhNTA2NDYzNjllLi5mOGU5MWE2OTY1
ZWQgMTAwNjQ0DQo+IC0tLSBhL2h3L2Jsb2NrL252bWUuYw0KPiArKysgYi9ody9ibG9jay9udm1l
LmMNCj4gQEAgLTYyLDYgKzYyLDcgQEANCj4gICNkZWZpbmUgTlZNRV9URU1QRVJBVFVSRSAweDE0
Mw0KPiAgI2RlZmluZSBOVk1FX1RFTVBFUkFUVVJFX1dBUk5JTkcgMHgxNTcNCj4gICNkZWZpbmUg
TlZNRV9URU1QRVJBVFVSRV9DUklUSUNBTCAweDE3NQ0KPiArI2RlZmluZSBOVk1FX05VTV9GV19T
TE9UUyAxDQo+ICANCj4gICNkZWZpbmUgTlZNRV9HVUVTVF9FUlIodHJhY2UsIGZtdCwgLi4uKSBc
DQo+ICAgICAgZG8geyBcDQo+IEBAIC0xNjUyLDcgKzE2NTMsNyBAQCBzdGF0aWMgdm9pZCBudm1l
X2luaXRfY3RybChOdm1lQ3RybCAqbiwgUENJRGV2aWNlICpwY2lfZGV2KQ0KPiAgICAgICAqIGlu
Y29uc2VxdWVudGlhbC4NCj4gICAgICAgKi8NCj4gICAgICBpZC0+YWNsID0gMzsNCj4gLSAgICBp
ZC0+ZnJtdyA9IDcgPDwgMTsNCj4gKyAgICBpZC0+ZnJtdyA9IChOVk1FX05VTV9GV19TTE9UUyA8
PCAxKSB8IE5WTUVfRlJNV19TTE9UMV9STzsNCj4gICAgICBpZC0+bHBhID0gMSA8PCAwOw0KPiAg
DQo+ICAgICAgLyogcmVjb21tZW5kZWQgZGVmYXVsdCB2YWx1ZSAofjcwIEMpICovDQo+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2Jsb2NrL252bWUuaCBiL2luY2x1ZGUvYmxvY2svbnZtZS5oDQo+IGlu
ZGV4IGJiNjUxZDBjYmY1YS4uMDAzYjE1YWY5Y2Q5IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2Js
b2NrL252bWUuaA0KPiArKysgYi9pbmNsdWRlL2Jsb2NrL252bWUuaA0KPiBAQCAtODQyLDYgKzg0
MiwxMCBAQCBlbnVtIE52bWVJZEN0cmxPbmNzIHsNCj4gICAgICBOVk1FX09OQ1NfVElNRVNUQU1Q
ICAgICA9IDEgPDwgNiwNCj4gIH07DQo+ICANCj4gK2VudW0gTnZtZUlkQ3RybEZybXcgew0KPiAr
ICAgIE5WTUVfRlJNV19TTE9UMV9STyA9IDEgPDwgMCwNCj4gK307DQo+ICsNCj4gICNkZWZpbmUg
TlZNRV9DVFJMX1NRRVNfTUlOKHNxZXMpICgoc3FlcykgJiAweGYpDQo+ICAjZGVmaW5lIE5WTUVf
Q1RSTF9TUUVTX01BWChzcWVzKSAoKChzcWVzKSA+PiA0KSAmIDB4ZikNCj4gICNkZWZpbmUgTlZN
RV9DVFJMX0NRRVNfTUlOKGNxZXMpICgoY3FlcykgJiAweGYpDQo=

