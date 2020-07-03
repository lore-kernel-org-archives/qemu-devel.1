Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3C9C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 00:52:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 660C62073E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 00:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ty8HdWZT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wtoZ6KTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660C62073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr9vw-0003mi-Ju
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 20:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=446c5dbe3=Dmitry.Fomichev@wdc.com>)
 id 1jr9pq-0001Yg-TB; Thu, 02 Jul 2020 20:45:46 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:34958)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=446c5dbe3=Dmitry.Fomichev@wdc.com>)
 id 1jr9po-0006fO-MK; Thu, 02 Jul 2020 20:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593737145; x=1625273145;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=3qUwepk+kgDN9k9KLu+BdYWYa9Z205sjmBqgrpinNNM=;
 b=Ty8HdWZT1D1Jy03iFMXA/X0otFMGDI0EWL6QqKECMFR/VSIY2bgC53pq
 tmodFK+2c+q5KhEPwxV9HG1SK3lylPOw4qoD1tr7EDwwzownekCvqoqjo
 jzXrdvIXxtPfprN7C0ezkGiF5PJwmJgCOIlty2Ro2eEd7x70kxQ5U0g0Q
 AEgIbxnafxGNgSHcc3rqVnygoGmVGV/K4wGKckJIAsjW/nBoM8EGwXZPV
 sGyUXO/V24PP1qeBcN5az1PHg73EUK13ysCbgmGfKZfKWdKsFuIfz/A0h
 eeNuF01qFQOkwgSO12IZtMgrUixXnWLS8ASuGDzumod7VQEtL3O0PxXZj g==;
IronPort-SDR: ksCoqNEUFzECATifXn8IkEnlvkEw30NvrCnDyiGR3Evc3gbfpx4hCC0gPXHoBdeXy/4LkQvVws
 S1Z5ABoE8yx/ZbdBOPcXDrGn+RdEFkrokH8M3dTl/4AfjKlp9Di/p0jY0J11HjC94C6nZd+poI
 Zu1clXYx3mLVctu1t+BWUTJxbE20IrC8fvWfHjcK2X/l61vtjaaHlt30Qp2oN9S/AQkbMkG91/
 7XIlCWNCcV8qBE1lHmECCXSA7rG+Eq4euJqCG5zUkeaxKWkUBCrRT1sIDoNokqLpQJd1btflCV
 QYQ=
X-IronPort-AV: E=Sophos;i="5.75,306,1589212800"; d="scan'208";a="145864629"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 08:45:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJe8Q+mDyPthDyCQAambZZyoXzhfkX+7A1diUzBxUa7zbI8FmorTrpGuQXF6si2P0ERZ/JnhZ2U/dDiCvDTncvV7Dyvs23rHOm87A4PixYcQMBG1ZzEa6XxydcHHw2pFF62mViu8M+EiSfH7Z02uws1mTxAPPqfjeno71zll/aDb9Mn+WM50RwpOO9hKrjJXXAowfsBRU12oKkJDg7NgrALkM3/k21Tf5IsG4DzU3CQVOCT/nh4mYwYQYAFTZXjLwliUwUhagTGnuGLfp8KqgYUrTZN9IhXkhCO3QBsf+5ctQ1PQsXT32YVN4nz9AcSWAYm1G0CDkJadSpWhEBpNew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qUwepk+kgDN9k9KLu+BdYWYa9Z205sjmBqgrpinNNM=;
 b=oYCNAq0MPd2j2kJTPgLPc09L7WGmQ0op6cueHnvjesO+r3Qbf+b3Qjb7zmUbGzyualoSfub2jdbBVzMBm0yd11D2UT4CkpTXfz8KX7ryTMHha2uOuKYR43yhX041DDQz072OsPKxDsPFMqxjscYIzgy7ildRNGnt3pcMp/2OlHGBQdCfyzuceRsEIoKqIKto6XiTlF7SviDwJN/c5gszdJlir1E6Z2t/IGl1LkJlIPP8pODaKoT1CTYo4IHFYCFmtTW7UyMME0Hr1dRuXwVOIMjBuDzJzAZ3Eq0ND7bbDnGuH68iaRqP30Y8yoyGgWiHY0AblmLEvELKwNtQihkDNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qUwepk+kgDN9k9KLu+BdYWYa9Z205sjmBqgrpinNNM=;
 b=wtoZ6KTGGOEMnghI7k8Lwf9yMcOSFvjYrPrwqMax2Q8kUrlzix4yFA2xjylquWZeOj0/A2oXgE0q5FaItbVHjxt0eiYElqSssWOmUuQuVW0DgKhImmxgVm6LpVjVgbPGzmfCPJLt6ZTHycHoiKqrfxrhaZYTY4BdNEGD+zGg+tU=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5552.namprd04.prod.outlook.com (2603:10b6:208:de::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Fri, 3 Jul
 2020 00:45:41 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9%5]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 00:45:41 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: "its@irrelevant.dk" <its@irrelevant.dk>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 09/17] hw/block/nvme: flush write cache when disabled
Thread-Topic: [PATCH 09/17] hw/block/nvme: flush write cache when disabled
Thread-Index: AQHWTkNKPA/qas0JeUOexdk5cMu/caj1CgUA
Date: Fri, 3 Jul 2020 00:45:41 +0000
Message-ID: <7351ad419783cc3e0fbec8db8fd39bfee9f6aa17.camel@wdc.com>
References: <20200629182642.1170387-1-its@irrelevant.dk>
 <20200629182642.1170387-10-its@irrelevant.dk>
In-Reply-To: <20200629182642.1170387-10-its@irrelevant.dk>
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
x-ms-office365-filtering-correlation-id: f89dd97b-d51e-45fa-2315-08d81eea6977
x-ms-traffictypediagnostic: MN2PR04MB5552:
x-microsoft-antispam-prvs: <MN2PR04MB555252B87356F2AE0DDB378CE16A0@MN2PR04MB5552.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:419;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gPw5yDnHJHKu63IAo5Xn7fhfmufIPEZc7fhmEzYmMIra3VZMi3/8+dNqSc5ngfXfxXFb5dq5fV4xR7EZfta9x3GlnbtVkFSYtFHFeQLJusSCFIdwf+LUg1PE8+hWEo2Bfci+7HCdO92tzeeaHnn64VNT/PedHyXuzXI2ZJ7j6yoBeP/6+lmwh7xxFu/zIFpwmZWwE2bJstDCPV9huOK2FtodnXVDQPXY/Du+5iexz4qaC4mVxiCzLUmfB4Fk8dJb/Sz8x4vhQMclV3HAExgupXbvGH617imYofMUEN9gIAmKE3umGfUd8Eb3pX7cKsUPeIE3JgLgtsGD+J8Ite49nQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(4326008)(4744005)(186003)(76116006)(2616005)(83380400001)(6486002)(6512007)(110136005)(66946007)(66476007)(66446008)(54906003)(64756008)(66556008)(36756003)(71200400001)(8936002)(26005)(86362001)(316002)(5660300002)(2906002)(8676002)(478600001)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: CXOWWRrLa1rNGJTcsv5BwvMP8OpnCPHs1H0PMT+/JDfFnBPK1isZpjDe611kljaixZMY69a6rISVL/IZAbKfxZvPfs6VCe2j/B659QbI3iy0FZBpLzFcN1kLPYlFXm4mAj8Cnxc3yDpZd/AKkkSAlnrjble//G+U7uCgbzHO1p1AALKbsI0EZHpK0gqWTlCfMyxMj9PWET30IgLX2PPRhYqxQzA+UuCGGFOL3BXxp2/Ik1AhQHVnRV6+1Hwfo/MaIG7HesTK6NY7ggpE6mNkYhVU9KgnhNfdgQ8oX6w1Zoo0ktVNWXaRgiR4e1qq+uvu9SgX4GckulZzY6QRR4UEvDLggJmyRc0Tt+U6KBcNMyydjBCIG2dri4hvGDje5aPHodprbOY8mRCK8rZCAoFwskMmHS3BisYR99pjYoywKb06S0yXB+j7eyTRNzfmhh2vLXmBObfNpRmjsN35kOOjxSJ2wULPkGOJ3U1yzc3dtaXAPuex81veRw6r1AuKWWpS
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9762A44B273E754CBBA082DD84128FBE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f89dd97b-d51e-45fa-2315-08d81eea6977
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 00:45:41.1992 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6w1gOxS++tI9ylkJwbhofNHkydJd3Mnu7pNc4wVosItYY196SM9FPrijlZMk1IQ99cIsIi2xLyD4RL6/v4p5jQ==
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
Pg0KPiANCj4gSWYgdGhlIHdyaXRlIGNhY2hlIGlzIGRpc2FibGVkIHdpdGggYSBTZXQgRmVhdHVy
ZXMgY29tbWFuZCwgZmx1c2ggaXQgaWYNCj4gY3VycmVudGx5IGVuYWJsZWQuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBLbGF1cyBKZW5zZW4gPGsuamVuc2VuQHNhbXN1bmcuY29tPg0KPiAtLS0NCj4g
IGh3L2Jsb2NrL252bWUuYyB8IDQgKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L2Jsb2NrL252bWUuYyBiL2h3L2Jsb2NrL252bWUu
Yw0KPiBpbmRleCAzOWU2ODBhMTVjNTYuLmMyNTA3ZDg4MzZmZCAxMDA2NDQNCj4gLS0tIGEvaHcv
YmxvY2svbnZtZS5jDQo+ICsrKyBiL2h3L2Jsb2NrL252bWUuYw0KPiBAQCAtMTE1Myw2ICsxMTUz
LDEwIEBAIHN0YXRpYyB1aW50MTZfdCBudm1lX3NldF9mZWF0dXJlKE52bWVDdHJsICpuLCBOdm1l
Q21kICpjbWQsIE52bWVSZXF1ZXN0ICpyZXEpDQo+ICANCj4gICAgICAgICAgYnJlYWs7DQo+ICAg
ICAgY2FzZSBOVk1FX1ZPTEFUSUxFX1dSSVRFX0NBQ0hFOg0KPiArICAgICAgICBpZiAoIShkdzEx
ICYgMHgxKSAmJiBibGtfZW5hYmxlX3dyaXRlX2NhY2hlKG4tPmNvbmYuYmxrKSkgew0KPiArICAg
ICAgICAgICAgYmxrX2ZsdXNoKG4tPmNvbmYuYmxrKTsNCj4gKyAgICAgICAgfQ0KPiArDQo+ICAg
ICAgICAgIGJsa19zZXRfZW5hYmxlX3dyaXRlX2NhY2hlKG4tPmNvbmYuYmxrLCBkdzExICYgMSk7
DQo+ICAgICAgICAgIGJyZWFrOw0KPiAgICAgIGNhc2UgTlZNRV9OVU1CRVJfT0ZfUVVFVUVTOg0K

