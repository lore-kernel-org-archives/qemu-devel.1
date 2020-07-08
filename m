Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA356C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 19:27:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCF632065D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 19:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="L9+O6jTM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KU8C+kMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF632065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtFjG-0003cA-2b
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 15:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=45148fd95=Dmitry.Fomichev@wdc.com>)
 id 1jtFiK-0002kd-Gr; Wed, 08 Jul 2020 15:26:41 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:32359)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=45148fd95=Dmitry.Fomichev@wdc.com>)
 id 1jtFiH-0002u8-TV; Wed, 08 Jul 2020 15:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594236397; x=1625772397;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=5VoDmX1/zjSw4sLuCdw1TngEVS6GOe3YK20sbGTom+c=;
 b=L9+O6jTMts1nbAqMTnkcyG0airc+jlR4CrNgOvQMqA40OvCk9Vuvg+FX
 OdMgMW7cfrX1yqk58HtZCKUvy2vzdUrwS15v1y4lrpNOmMmWANTWa7QtE
 ZCtlzkuNhqVgRKucrjB2PpieKMexuajMxtePJyMikOIvaTPKtlph6F/gP
 grvada3VtnsXF/3tvVXjqglUBPkfrc40XHx6MzGicPEomF4L8M5Jihfd+
 J3DMLU4GLVKVsAM/z5mDztvisfBFjDrdHC1iqfm98QjaiDDwPeeVYeuaf
 OjaMHBBB+wpoQjfLYC3iww/M9KQQgz97ShB5dZtukqlh78JTcnIrjPow+ g==;
IronPort-SDR: GBHZw4DFGc3OScoxKTAGnOqhMiRc4EyGynIuoWTV0cuhsLUheVwHQjTIkntNxnpTJEyDcrVHHe
 VFF0nG6NddaLI268FHFmh1/f3fGNNxgzwJ8Q9XDv6Air4sswq6MW9btYsCgR2ooFeSu+vomA6Z
 RE785ICnaJGWnrBkMcgrjWpQ8KwzZzkDgCy8kCzl3Yuyz8ojg6fBkMJ2oxhIfYFpcELipw3O7C
 3cPIM8h/ZlJr2qRXxZYkGgEFiHDwe09yxvMHyck3/bPdsN2rfe/CQcMVYW4y8sE6IMPCf9OuA0
 HS0=
X-IronPort-AV: E=Sophos;i="5.75,328,1589212800"; d="scan'208";a="251195587"
Received: from mail-sn1nam02lp2057.outbound.protection.outlook.com (HELO
 NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.57])
 by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2020 03:26:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzVZOC0hY/Mn0IZHHGCU1egMM/AwCSkqFul2p2bnoOyDlEk7GidMQlcmNrGvIpDF0Cxm3rCrcQQpGg+tk1g83yoHMsfIhNI91rrFY6LebO+icSmIeAX9xYuvmujdfljW8UrlWLrqbyqLDfFJhDh/L4IvlAHOFVGExnBA7MKfSEc34gHLpqQLJMRqhEKnuBdd7pR1g/RNFTu1kro5zJA9fS/3EKlnCPpKLJkGCNwB2Q7HFAxwZWXokShKW79GaAk76iNs7FKiRhQTYDYLKyT4y2gXaTbxZRfUFG8ZaupZIFMT2e90m2VrCGxiS4Dfgaf9ecJLTG5He6RpNxxI3SSqxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VoDmX1/zjSw4sLuCdw1TngEVS6GOe3YK20sbGTom+c=;
 b=e9/qac6gm2dH5+kqOPQaEc7bSNEhm7wqgls2Uh6q9O/vnWjLFsY6M5kb+9PPqq6YBiDNwOMPU1+J4tsT/wmdiNWXkLC7iSs89TmfmKSP3UPdeq/78ZFkJTPvnj4oqUCwPb0zxVB4yn8LdCuzVw1K8yHvoUKOgPF0P81mBsgrpa6cDZYhhLYojIZfmSFKN+f2as7soMA3nzW4f9X1DvJzfr5NawraasC65QLhJF9o8XtLRI1pjHj/UGFOaykmumPOydOq+VA1lfe5UsA6YJo9XbssRahdF7fVlcxL/UeZc7a/x2+xr09k1tSvUh9pme/S7yhS0ay8oKAArzlgO6sjnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VoDmX1/zjSw4sLuCdw1TngEVS6GOe3YK20sbGTom+c=;
 b=KU8C+kMGRF7+h7StfmqLDEoTGquAykE3P/l49aTv5GFnYoYRmcCd5wakRtKMy2kg+P+eAuUVgjC+7B/NSP9ujq9rqRpy5z5JSYxCOv6m4J514/1CqnwOEGlGnmmvhQWNVNf3g4PM4o2C1GIhOtStaXmZleMGEw0KrESBot9BtHo=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5998.namprd04.prod.outlook.com (2603:10b6:208:dc::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Wed, 8 Jul
 2020 19:26:33 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9%5]) with mapi id 15.20.3153.029; Wed, 8 Jul 2020
 19:26:33 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: "its@irrelevant.dk" <its@irrelevant.dk>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v3 17/18] hw/block/nvme: provide the mandatory subnqn field
Thread-Topic: [PATCH v3 17/18] hw/block/nvme: provide the mandatory subnqn
 field
Thread-Index: AQHWU1yN7Cm+hZKG00SB+ZYqOePApaj+FKYA
Date: Wed, 8 Jul 2020 19:26:33 +0000
Message-ID: <0e013c2bd8e362dab1353cba3d314e049ad1945d.camel@wdc.com>
References: <20200706061303.246057-1-its@irrelevant.dk>
 <20200706061303.246057-18-its@irrelevant.dk>
In-Reply-To: <20200706061303.246057-18-its@irrelevant.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [100.35.204.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fcc0dcb7-b282-4bdd-a215-08d82374d313
x-ms-traffictypediagnostic: MN2PR04MB5998:
x-microsoft-antispam-prvs: <MN2PR04MB5998C2746C284BC12943971EE1670@MN2PR04MB5998.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 04583CED1A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gdvCXeXWvqqqQ3EncWdFbZuS0OEucHNjkPsM8AMQHAfN2ngzfovwa7BSlOR/NKxWcr6o2L4p7k7ywkArimkvM2fzi6foT9xqY+mxyMet3rBNwoomhwpNL4Er0TAGUhcV/wV2xPGs7QmUc3IDT/bZp1HLt1VUdEI38uj0fIGMm+aDlpRpiMpRKWBJMgiPLmywLYV3ygLhyAbOD7RerO9nKyFiWlfdXudfqa2v56966tuc4CvnWuTMsXC1X5DbjfF08D22e46CCEGyI1B1X5/gmNXEfrpsnHknMdL5rktHHj83Na2S60lslMtvHy6DqkaflmalewCf7d4D+dH9E3Mtrw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(8676002)(4326008)(71200400001)(86362001)(5660300002)(83380400001)(6486002)(6512007)(7416002)(26005)(186003)(2906002)(6506007)(2616005)(478600001)(8936002)(66476007)(316002)(36756003)(66446008)(64756008)(76116006)(66556008)(110136005)(54906003)(66946007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: XP29ZfUlI2MyX/J4qbTCKsZ31IkmBmrfxK1bYEsj31E8DfWnCxM6PBozFbg0o4z9sK4jUjFiCFY0CUIjyZP0yaCVHfXGzt7I4uqHaIGPwgxULWSRPfq9fVthr9M229JDqR30QXhcdCwXuCt5ihzB6fu6XGVq/aG84AktxW85fkYqGX+Eowd0aptD/DXd7BWyf1v5fHHoeSiFg0TiExNd1cEbbWO+Fse49hw8fAJSCnGUZ9fK+qINq83ueyl4jj16OZ8c2QKKWggU2qfvjQVqwZeBgWgDSV4YIXt1I5UtGM8y2Qs0/JLdUPS/omxWNf38WONmjnxpHB0bTfOOIBcCxGvwlLh/HXWjDJXGLNRjwp6pyWt5c9ZWcUiZdsujIbKdnn136Ch8A2hEEqA4qxVm3gWkgEx6a5ueOSqbQ1Y/kgqYJjHS7leWTbCwwmParRxf75I7HCbJ5uVN+CL9WWFXsNzSYOomUZmkMitF2Jh8UXLglomXrheLLoJAkzGajwlu
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E55756441A80C48949EF9233029B743@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc0dcb7-b282-4bdd-a215-08d82374d313
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 19:26:33.5174 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wcgBfjimyIa0YRR04AY84nwLtXqhpaMpeE20VfJujl2DZHfG6scrH7Og/+fnrDwK+lkThS/LjErr6SkCmhrMKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5998
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=45148fd95=Dmitry.Fomichev@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 15:21:26
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "k.jensen@samsung.com" <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "javier.gonz@samsung.com" <javier.gonz@samsung.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IERtaXRyeSBGb21pY2hldiA8ZG1pdHJ5LmZvbWlj
aGV2QHdkYy5jb20+DQoNCk9uIE1vbiwgMjAyMC0wNy0wNiBhdCAwODoxMyArMDIwMCwgS2xhdXMg
SmVuc2VuIHdyb3RlOg0KPiBGcm9tOiBLbGF1cyBKZW5zZW4gPGsuamVuc2VuQHNhbXN1bmcuY29t
Pg0KPiANCj4gVGhlIFNVQk5RTiBmaWVsZCBpcyBtYW5kYXRvcnkgaW4gTlZNIEV4cHJlc3MgMS4z
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS2xhdXMgSmVuc2VuIDxrLmplbnNlbkBzYW1zdW5nLmNv
bT4NCj4gLS0tDQo+ICBody9ibG9jay9udm1lLmMgfCA1ICsrKysrDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvYmxvY2svbnZtZS5jIGIv
aHcvYmxvY2svbnZtZS5jDQo+IGluZGV4IDA3ZDU4YWE5NDVmMi4uZTM5ODQxNTc5MjZiIDEwMDY0
NA0KPiAtLS0gYS9ody9ibG9jay9udm1lLmMNCj4gKysrIGIvaHcvYmxvY2svbnZtZS5jDQo+IEBA
IC0yMTQxLDYgKzIxNDEsNyBAQCBzdGF0aWMgdm9pZCBudm1lX2luaXRfY3RybChOdm1lQ3RybCAq
biwgUENJRGV2aWNlICpwY2lfZGV2KQ0KPiAgew0KPiAgICAgIE52bWVJZEN0cmwgKmlkID0gJm4t
PmlkX2N0cmw7DQo+ICAgICAgdWludDhfdCAqcGNpX2NvbmYgPSBwY2lfZGV2LT5jb25maWc7DQo+
ICsgICAgY2hhciAqc3VibnFuOw0KPiAgDQo+ICAgICAgaWQtPnZpZCA9IGNwdV90b19sZTE2KHBj
aV9nZXRfd29yZChwY2lfY29uZiArIFBDSV9WRU5ET1JfSUQpKTsNCj4gICAgICBpZC0+c3N2aWQg
PSBjcHVfdG9fbGUxNihwY2lfZ2V0X3dvcmQocGNpX2NvbmYgKyBQQ0lfU1VCU1lTVEVNX1ZFTkRP
Ul9JRCkpOw0KPiBAQCAtMjE3OSw2ICsyMTgwLDEwIEBAIHN0YXRpYyB2b2lkIG52bWVfaW5pdF9j
dHJsKE52bWVDdHJsICpuLCBQQ0lEZXZpY2UgKnBjaV9kZXYpDQo+ICAgICAgaWQtPm9uY3MgPSBj
cHVfdG9fbGUxNihOVk1FX09OQ1NfV1JJVEVfWkVST1MgfCBOVk1FX09OQ1NfVElNRVNUQU1QIHwN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5WTUVfT05DU19GRUFUVVJFUyk7DQo+ICAN
Cj4gKyAgICBzdWJucW4gPSBnX3N0cmR1cF9wcmludGYoIm5xbi4yMDE5LTA4Lm9yZy5xZW11OiVz
Iiwgbi0+cGFyYW1zLnNlcmlhbCk7DQo+ICsgICAgc3RycGFkY3B5KChjaGFyICopaWQtPnN1Ym5x
biwgc2l6ZW9mKGlkLT5zdWJucW4pLCBzdWJucW4sICdcMCcpOw0KPiArICAgIGdfZnJlZShzdWJu
cW4pOw0KPiArDQo+ICAgICAgaWQtPnBzZFswXS5tcCA9IGNwdV90b19sZTE2KDB4OWM0KTsNCj4g
ICAgICBpZC0+cHNkWzBdLmVubGF0ID0gY3B1X3RvX2xlMzIoMHgxMCk7DQo+ICAgICAgaWQtPnBz
ZFswXS5leGxhdCA9IGNwdV90b19sZTMyKDB4NCk7DQo=

