Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32450C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 00:48:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2D69207D4
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 00:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MkvvExK4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JSjED/cz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D69207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr9sU-00068z-4f
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 20:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=446c5dbe3=Dmitry.Fomichev@wdc.com>)
 id 1jr9oy-0008Mb-Bj; Thu, 02 Jul 2020 20:44:52 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:55703)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=446c5dbe3=Dmitry.Fomichev@wdc.com>)
 id 1jr9ov-0006V1-Na; Thu, 02 Jul 2020 20:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593737089; x=1625273089;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=dK6X1Z0AToHheGySh+YdLkmcjO6jQdlRU5n5TkLa32Y=;
 b=MkvvExK4vVe95fq4wNQkieWP3EkOQgqQZp/+Vp7rS+NJCQCcBUqDASXy
 RDYuWTNiCMF4fCDfjyzTbVehwn5C/0TgzyLKi2U5pZUwbmVj1yMkhB5Kv
 Y2RNGTKxSbsgQ0OlqscvAApoNlf8S/QuyfzcnrZvE/OesV5RU1Dx9K8Tu
 7jHdIvQscKtp1S4/yYh7Mwt6LdaDKZqZRnuBK1FTK4ngZ/gXch5RWGxqY
 v54eiFASv+29/C++mwCUM+jxlR6NchVV4JtMn8oIXm53JVrVL2yhv1Yrs
 dp+SMC4kj0pYpK3menzgBH76qLAMPYAACTRaK64gd2DAGPL6CuHTqPymt w==;
IronPort-SDR: ZXh3JFsv+LyTJtyDnbwS5UOXIdP623wUYap1/GknleyplqHSd7uoA3LOrXx7DVTejYO/0r36L5
 /klY0hqeBiMcTJo7VtOPrAIHfB8Xap35Q7nDMEC60TA7FobjHBrgXTdmdTcuG7NKbr/keDEYJ8
 UWjtlW7p3gYD/4C7CG+Xaj+q9iu5lsS8DZX5TUdsvN/mGpvuqdA9lKzwK8nnFaREg7qWd4Yxyd
 ct5KXqD5PHcs0yL5WqrHy77Iq2O54U6MZ1c4Nw5UlXBeYPB1BwaerqCrlgGopYSTCQm1jZZnVQ
 Sqk=
X-IronPort-AV: E=Sophos;i="5.75,306,1589212800"; d="scan'208";a="141537356"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 08:44:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXoFJU+vOyt1eoHObkmKx4iyoRdIwDQpMvBIoOs3/1j5TnEBEn4jfG0mMlYQOmVJ/Xm/4InhlVyDm8h0b+nuH1LwcvjPsXMm2Ys5PgDLHAWXotGTi+yxmRAscoYonCFG5YTya5HQqExGr59TPXi4KpLnIRYfJbZb+QjE05o2qyGT/XU47ak6MKigSFnAjF4E6ALoCWka52NjckLR4guOK1SeGbtBy/QYAx/dzanGkzwiySRmdpWALEQLCLNx8KIqa5RRHV6rkoG2ClOzTjFZ2XNOl1At9XW3rMXvBNyNNaGFTQRBK4RdP5wHzMHaAEzxJHPkjw9WH5uG2aUpgQCfNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dK6X1Z0AToHheGySh+YdLkmcjO6jQdlRU5n5TkLa32Y=;
 b=hCC0uNrTNkQ8nWfPthHPlSNO2zWVimW4E2AzNZPrSIYW8TgqmRzNCDUgtFq7IE0tkZ18MoTOy1aAeuKUR4SqroPw3v65TLDjeSr1R1TyuLhMlj8nvWu7aHgjUQyRW7RcoSY0eMvO3HuPZYksalvdSGeWZ6T1BSUrHn/TutrDFGl6FhwcAmxcp3TfOhJNpgzAkfciBgACl1gWYfXqfWP0WsqnVAEar5Fs10FzVCzyb0rmO34UFNLu1Ymz06EPIyEW4VhreI90N7iFjYQz4onLMCXCP9Gl4e71AE4ziJX6U7EK/EVOmtnMlFyah+38NptWTFJP78cyrIgtUCdq5rn9NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dK6X1Z0AToHheGySh+YdLkmcjO6jQdlRU5n5TkLa32Y=;
 b=JSjED/czLH00Xm1uQvTFyHJzebjrskhYY+ph81NQoCr6HRJd6TslOHdcmSJ7xWr6qDiTDsSt9/KOsJqerLiXo42ivxJ05IaFyflA9ce2lj0xydBmp8UheBFLp8fo48Xc34U5lp6dN0gB/iDmDWeX6qHxesgB3Q0rTrGj7WCWxUk=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5552.namprd04.prod.outlook.com (2603:10b6:208:de::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Fri, 3 Jul
 2020 00:44:45 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9%5]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 00:44:45 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: "its@irrelevant.dk" <its@irrelevant.dk>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 04/17] hw/block/nvme: add temperature threshold feature
Thread-Topic: [PATCH 04/17] hw/block/nvme: add temperature threshold feature
Thread-Index: AQHWTkLqogt0EGzne0SK5si1HbP8F6j1CcSA
Date: Fri, 3 Jul 2020 00:44:45 +0000
Message-ID: <a9ae5248ffbc4154e24a03894e3c93876c4219a8.camel@wdc.com>
References: <20200629182642.1170387-1-its@irrelevant.dk>
 <20200629182642.1170387-5-its@irrelevant.dk>
In-Reply-To: <20200629182642.1170387-5-its@irrelevant.dk>
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
x-ms-office365-filtering-correlation-id: e3c20bb6-8edb-4fc4-1d1e-08d81eea486c
x-ms-traffictypediagnostic: MN2PR04MB5552:
x-microsoft-antispam-prvs: <MN2PR04MB5552DA4598536B6BB9301E6DE16A0@MN2PR04MB5552.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bGiCTTAxyUmFlMDQU2DynACDxDcvzMsZFnxIsWRO6YP8LsWJcz4y+p9OkOX+w52DiTvOrVHwmdDe6KB20RH6zhJP6CXKNOaWxEplDbMt29gTBn2suIqmkmMUnOj5FDOCnfFSBQ0BDB7RHVL1cR0jhR+jlus/q+1PNSgC9fss4x/CLkPi9YfcETrT9SYVcHUgDxZdek+iKNx6nXh1lsGVmGS4mICM+HyfzV8Jmt2yIuYRs9d8Zjoijp6qZE5U1tPBV26GF/DF6GnmcawDUhVXJnnSiP8FSw3KNfYRToBoEJBbQt1zZS/SY48d5xHeij92yXeEoewOwuJOWOKOJ/9R8g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(4326008)(186003)(76116006)(2616005)(83380400001)(6486002)(6512007)(110136005)(66946007)(66476007)(66446008)(54906003)(64756008)(66556008)(36756003)(71200400001)(8936002)(26005)(86362001)(316002)(5660300002)(2906002)(8676002)(478600001)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: kdlkbTAzvpTLBXmW4KR7O2w2tMolJgyg4C3PivUADdmytey1ZyZMaoTdr8mTlRhLwER2ICheaUhRYfhZsUyPWkhhAs/g0GThsVh3pOSSfRsb6axJvsQeTkV9kk2hy13GxSZq+ljgzO8ryERK1vi7AnsBdlm9sgE8SgcUZAYpInV/1SOWoW//WWHdJDsY0jBDLSPy9gVGZAMUTzXZkVKI1k5zen4n7PvKllqoDzzZGwSaTQVeFnwptibWwTa/yguwOCxrPa7iE+LhLd833ozBw1DeYp52XjSTk1f0zV1jgPfEFHRVcHmDXZNT9ni7Fsj+BspHSFHx5grCnGhVWbWjY7vOPAFd4zgW/e9A46hn15SSEBWLak8oUX2NhuZGtcYinBw1jpZYFjBxmGKHMWjTnHzMilBeznflLr8oEnxMTKoAqgwbjzkcY+K8sjXmtfkVMISRhEg5jLbWUS79VepRYtdaP7u0Or44uue6MUcsj2itsNgMYzb4nhvRnrPdTThL
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2808B9D0D01B094CACA3DF8FBFAAB2B2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c20bb6-8edb-4fc4-1d1e-08d81eea486c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 00:44:45.7941 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cmmj1P6LEwEoJfV2XWaLtLgbNW1HvgIiU6ftUHgwbbVZthv5btrIvJWLbTLgSFhb9pos8sq5iEkwK+snQSMkrg==
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

T24gTW9uLCAyMDIwLTA2LTI5IGF0IDIwOjI2ICswMjAwLCBLbGF1cyBKZW5zZW4gd3JvdGU6DQo+
IEZyb206IEtsYXVzIEplbnNlbiA8ay5qZW5zZW5Ac2Ftc3VuZy5jb20+DQo+IA0KPiBJdCBtaWdo
dCBzZWVtIHdlaXJkIHRvIGltcGxlbWVudCB0aGlzIGZlYXR1cmUgZm9yIGFuIGVtdWxhdGVkIGRl
dmljZSwNCj4gYnV0IGl0IGlzIG1hbmRhdG9yeSB0byBzdXBwb3J0IGFuZCB0aGUgZmVhdHVyZSBp
cyB1c2VmdWwgZm9yIHRlc3RpbmcNCj4gYXN5bmNocm9ub3VzIGV2ZW50IHJlcXVlc3Qgc3VwcG9y
dCwgd2hpY2ggd2lsbCBiZSBhZGRlZCBpbiBhIGxhdGVyDQo+IHBhdGNoLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogS2xhdXMgSmVuc2VuIDxrLmplbnNlbkBzYW1zdW5nLmNvbT4NCj4gQWNrZWQtYnk6
IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4NCj4gUmV2aWV3ZWQtYnk6IE1heGltIExl
dml0c2t5IDxtbGV2aXRza0ByZWRoYXQuY29tPg0KPiAtLS0NCj4gIGh3L2Jsb2NrL252bWUuYyAg
ICAgIHwgNDggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4g
IGh3L2Jsb2NrL252bWUuaCAgICAgIHwgIDEgKw0KPiAgaW5jbHVkZS9ibG9jay9udm1lLmggfCAg
OCArKysrKysrLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA1NiBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvYmxvY2svbnZtZS5jIGIvaHcvYmxvY2svbnZt
ZS5jDQo+IGluZGV4IGI3MDM3YTdkMzUwNC4uNWNhNTA2NDYzNjllIDEwMDY0NA0KPiAtLS0gYS9o
dy9ibG9jay9udm1lLmMNCj4gKysrIGIvaHcvYmxvY2svbnZtZS5jDQo+IEBAIC01OSw2ICs1OSw5
IEBADQo+ICAjZGVmaW5lIE5WTUVfREJfU0laRSAgNA0KPiAgI2RlZmluZSBOVk1FX0NNQl9CSVIg
Mg0KPiAgI2RlZmluZSBOVk1FX1BNUl9CSVIgMg0KPiArI2RlZmluZSBOVk1FX1RFTVBFUkFUVVJF
IDB4MTQzDQo+ICsjZGVmaW5lIE5WTUVfVEVNUEVSQVRVUkVfV0FSTklORyAweDE1Nw0KPiArI2Rl
ZmluZSBOVk1FX1RFTVBFUkFUVVJFX0NSSVRJQ0FMIDB4MTc1DQo+ICANCj4gICNkZWZpbmUgTlZN
RV9HVUVTVF9FUlIodHJhY2UsIGZtdCwgLi4uKSBcDQo+ICAgICAgZG8geyBcDQo+IEBAIC04Mjcs
OSArODMwLDMxIEBAIHN0YXRpYyB1aW50MTZfdCBudm1lX2dldF9mZWF0dXJlX3RpbWVzdGFtcChO
dm1lQ3RybCAqbiwgTnZtZUNtZCAqY21kKQ0KPiAgc3RhdGljIHVpbnQxNl90IG52bWVfZ2V0X2Zl
YXR1cmUoTnZtZUN0cmwgKm4sIE52bWVDbWQgKmNtZCwgTnZtZVJlcXVlc3QgKnJlcSkNCj4gIHsN
Cj4gICAgICB1aW50MzJfdCBkdzEwID0gbGUzMl90b19jcHUoY21kLT5jZHcxMCk7DQo+ICsgICAg
dWludDMyX3QgZHcxMSA9IGxlMzJfdG9fY3B1KGNtZC0+Y2R3MTEpOw0KPiAgICAgIHVpbnQzMl90
IHJlc3VsdDsNCj4gIA0KPiAgICAgIHN3aXRjaCAoZHcxMCkgew0KPiArICAgIGNhc2UgTlZNRV9U
RU1QRVJBVFVSRV9USFJFU0hPTEQ6DQo+ICsgICAgICAgIHJlc3VsdCA9IDA7DQo+ICsNCj4gKyAg
ICAgICAgLyoNCj4gKyAgICAgICAgICogVGhlIGNvbnRyb2xsZXIgb25seSBpbXBsZW1lbnRzIHRo
ZSBDb21wb3NpdGUgVGVtcGVyYXR1cmUgc2Vuc29yLCBzbw0KPiArICAgICAgICAgKiByZXR1cm4g
MCBmb3IgYWxsIG90aGVyIHNlbnNvcnMuDQo+ICsgICAgICAgICAqLw0KPiArICAgICAgICBpZiAo
TlZNRV9URU1QX1RNUFNFTChkdzExKSAhPSBOVk1FX1RFTVBfVE1QU0VMX0NPTVBPU0lURSkgew0K
PiArICAgICAgICAgICAgYnJlYWs7DQo+ICsgICAgICAgIH0NCj4gKw0KPiArICAgICAgICBzd2l0
Y2ggKE5WTUVfVEVNUF9USFNFTChkdzExKSkgew0KPiArICAgICAgICBjYXNlIE5WTUVfVEVNUF9U
SFNFTF9PVkVSOg0KPiArICAgICAgICAgICAgcmVzdWx0ID0gY3B1X3RvX2xlMTYobi0+ZmVhdHVy
ZXMudGVtcF90aHJlc2hfaGkpOw0KPiArICAgICAgICAgICAgYnJlYWs7DQo+ICsgICAgICAgIGNh
c2UgTlZNRV9URU1QX1RIU0VMX1VOREVSOg0KPiArICAgICAgICAgICAgcmVzdWx0ID0gY3B1X3Rv
X2xlMTYobi0+ZmVhdHVyZXMudGVtcF90aHJlc2hfbG93KTsNCj4gKyAgICAgICAgICAgIGJyZWFr
Ow0KPiArICAgICAgICB9DQo+ICsNCj4gKyAgICAgICAgYnJlYWs7DQo+IA0KPiA+ICAgICAgY2Fz
ZSBOVk1FX1ZPTEFUSUxFX1dSSVRFX0NBQ0hFOg0KPiAgICAgICAgICByZXN1bHQgPSBibGtfZW5h
YmxlX3dyaXRlX2NhY2hlKG4tPmNvbmYuYmxrKTsNCj4gICAgICAgICAgdHJhY2VfcGNpX252bWVf
Z2V0ZmVhdF92d2NhY2hlKHJlc3VsdCA/ICJlbmFibGVkIiA6ICJkaXNhYmxlZCIpOw0KPiBAQCAt
ODc0LDYgKzg5OSwyMyBAQCBzdGF0aWMgdWludDE2X3QgbnZtZV9zZXRfZmVhdHVyZShOdm1lQ3Ry
bCAqbiwgTnZtZUNtZCAqY21kLCBOdm1lUmVxdWVzdCAqcmVxKQ0KPiAgICAgIHVpbnQzMl90IGR3
MTEgPSBsZTMyX3RvX2NwdShjbWQtPmNkdzExKTsNCj4gIA0KPiAgICAgIHN3aXRjaCAoZHcxMCkg
ew0KPiArICAgIGNhc2UgTlZNRV9URU1QRVJBVFVSRV9USFJFU0hPTEQ6DQo+ICsgICAgICAgIGlm
IChOVk1FX1RFTVBfVE1QU0VMKGR3MTEpICE9IE5WTUVfVEVNUF9UTVBTRUxfQ09NUE9TSVRFKSB7
DQo+ICsgICAgICAgICAgICBicmVhazsNCj4gKyAgICAgICAgfQ0KPiArDQo+ICsgICAgICAgIHN3
aXRjaCAoTlZNRV9URU1QX1RIU0VMKGR3MTEpKSB7DQo+ICsgICAgICAgIGNhc2UgTlZNRV9URU1Q
X1RIU0VMX09WRVI6DQo+ICsgICAgICAgICAgICBuLT5mZWF0dXJlcy50ZW1wX3RocmVzaF9oaSA9
IE5WTUVfVEVNUF9UTVBUSChkdzExKTsNCj4gKyAgICAgICAgICAgIGJyZWFrOw0KPiArICAgICAg
ICBjYXNlIE5WTUVfVEVNUF9USFNFTF9VTkRFUjoNCj4gKyAgICAgICAgICAgIG4tPmZlYXR1cmVz
LnRlbXBfdGhyZXNoX2xvdyA9IE5WTUVfVEVNUF9UTVBUSChkdzExKTsNCj4gKyAgICAgICAgICAg
IGJyZWFrOw0KPiArICAgICAgICBkZWZhdWx0Og0KPiArICAgICAgICAgICAgcmV0dXJuIE5WTUVf
SU5WQUxJRF9GSUVMRCB8IE5WTUVfRE5SOw0KPiArICAgICAgICB9DQo+ICsNCj4gKyAgICAgICAg
YnJlYWs7DQo+ICAgICAgY2FzZSBOVk1FX1ZPTEFUSUxFX1dSSVRFX0NBQ0hFOg0KPiAgICAgICAg
ICBibGtfc2V0X2VuYWJsZV93cml0ZV9jYWNoZShuLT5jb25mLmJsaywgZHcxMSAmIDEpOw0KPiAg
ICAgICAgICBicmVhazsNCj4gQEAgLTE0NTQsNiArMTQ5Niw3IEBAIHN0YXRpYyB2b2lkIG52bWVf
aW5pdF9zdGF0ZShOdm1lQ3RybCAqbikNCj4gICAgICBuLT5uYW1lc3BhY2VzID0gZ19uZXcwKE52
bWVOYW1lc3BhY2UsIG4tPm51bV9uYW1lc3BhY2VzKTsNCj4gICAgICBuLT5zcSA9IGdfbmV3MChO
dm1lU1F1ZXVlICosIG4tPnBhcmFtcy5tYXhfaW9xcGFpcnMgKyAxKTsNCj4gICAgICBuLT5jcSA9
IGdfbmV3MChOdm1lQ1F1ZXVlICosIG4tPnBhcmFtcy5tYXhfaW9xcGFpcnMgKyAxKTsNCj4gKyAg
ICBuLT5mZWF0dXJlcy50ZW1wX3RocmVzaF9oaSA9IE5WTUVfVEVNUEVSQVRVUkVfV0FSTklORzsN
Cj4gIH0NCj4gIA0KPiAgc3RhdGljIHZvaWQgbnZtZV9pbml0X2JsayhOdm1lQ3RybCAqbiwgRXJy
b3IgKiplcnJwKQ0KPiBAQCAtMTYxMSw2ICsxNjU0LDExIEBAIHN0YXRpYyB2b2lkIG52bWVfaW5p
dF9jdHJsKE52bWVDdHJsICpuLCBQQ0lEZXZpY2UgKnBjaV9kZXYpDQo+ICAgICAgaWQtPmFjbCA9
IDM7DQo+ICAgICAgaWQtPmZybXcgPSA3IDw8IDE7DQo+ICAgICAgaWQtPmxwYSA9IDEgPDwgMDsN
Cj4gKw0KPiArICAgIC8qIHJlY29tbWVuZGVkIGRlZmF1bHQgdmFsdWUgKH43MCBDKSAqLw0KPiAr
ICAgIGlkLT53Y3RlbXAgPSBjcHVfdG9fbGUxNihOVk1FX1RFTVBFUkFUVVJFX1dBUk5JTkcpOw0K
PiArICAgIGlkLT5jY3RlbXAgPSBjcHVfdG9fbGUxNihOVk1FX1RFTVBFUkFUVVJFX0NSSVRJQ0FM
KTsNCj4gKw0KPiAgICAgIGlkLT5zcWVzID0gKDB4NiA8PCA0KSB8IDB4NjsNCj4gICAgICBpZC0+
Y3FlcyA9ICgweDQgPDwgNCkgfCAweDQ7DQo+ICAgICAgaWQtPm5uID0gY3B1X3RvX2xlMzIobi0+
bnVtX25hbWVzcGFjZXMpOw0KPiBkaWZmIC0tZ2l0IGEvaHcvYmxvY2svbnZtZS5oIGIvaHcvYmxv
Y2svbnZtZS5oDQo+IGluZGV4IDFiZjVjODBlZDg0My4uM2FjZGUxMGUxZDJhIDEwMDY0NA0KPiAt
LS0gYS9ody9ibG9jay9udm1lLmgNCj4gKysrIGIvaHcvYmxvY2svbnZtZS5oDQo+IEBAIC0xMDcs
NiArMTA3LDcgQEAgdHlwZWRlZiBzdHJ1Y3QgTnZtZUN0cmwgew0KPiAgICAgIE52bWVTUXVldWUg
ICAgICBhZG1pbl9zcTsNCj4gICAgICBOdm1lQ1F1ZXVlICAgICAgYWRtaW5fY3E7DQo+ICAgICAg
TnZtZUlkQ3RybCAgICAgIGlkX2N0cmw7DQo+ICsgICAgTnZtZUZlYXR1cmVWYWwgIGZlYXR1cmVz
Ow0KPiAgfSBOdm1lQ3RybDsNCj4gIA0KPiAgLyogY2FsY3VsYXRlIHRoZSBudW1iZXIgb2YgTEJB
cyB0aGF0IHRoZSBuYW1lc3BhY2UgY2FuIGFjY29tb2RhdGUgKi8NCj4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvYmxvY2svbnZtZS5oIGIvaW5jbHVkZS9ibG9jay9udm1lLmgNCj4gaW5kZXggNmQxZmE2
ZmYyMjI4Li5iYjY1MWQwY2JmNWEgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvYmxvY2svbnZtZS5o
DQo+ICsrKyBiL2luY2x1ZGUvYmxvY2svbnZtZS5oDQo+IEBAIC04NjAsNyArODYwLDEzIEBAIGVu
dW0gTnZtZUlkQ3RybE9uY3Mgew0KPiAgdHlwZWRlZiBzdHJ1Y3QgTnZtZUZlYXR1cmVWYWwgew0K
PiAgICAgIHVpbnQzMl90ICAgIGFyYml0cmF0aW9uOw0KPiAgICAgIHVpbnQzMl90ICAgIHBvd2Vy
X21nbXQ7DQo+IC0gICAgdWludDMyX3QgICAgdGVtcF90aHJlc2g7DQo+ICsgICAgdW5pb24gew0K
PiArICAgICAgICBzdHJ1Y3Qgew0KPiArICAgICAgICAgICAgdWludDE2X3QgdGVtcF90aHJlc2hf
aGk7DQo+ICsgICAgICAgICAgICB1aW50MTZfdCB0ZW1wX3RocmVzaF9sb3c7DQo+ICsgICAgICAg
IH07DQo+ICsgICAgICAgIHVpbnQzMl90IHRlbXBfdGhyZXNoOw0KDQp0ZW1wX3RocmVzaCBzZWVt
cyB1bnVzZWQsIGlzIHRoaXMgdW5pb24gcmVhbGx5IG5lZWRlZD8NCg0KPiArICAgIH07DQo+ICAg
ICAgdWludDMyX3QgICAgZXJyX3JlYzsNCj4gICAgICB1aW50MzJfdCAgICB2b2xhdGlsZV93YzsN
Cj4gICAgICB1aW50MzJfdCAgICBudW1fcXVldWVzOw0K

