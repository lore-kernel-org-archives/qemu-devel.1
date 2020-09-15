Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF68BC2D0E3
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 20:46:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3011220809
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 20:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VfwjvwaN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UWnZwgL7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3011220809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIHqZ-0006ja-VW
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 16:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=520035bb9=Dmitry.Fomichev@wdc.com>)
 id 1kIHoT-00050S-PI; Tue, 15 Sep 2020 16:44:29 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:21737)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=520035bb9=Dmitry.Fomichev@wdc.com>)
 id 1kIHoR-0005JM-H6; Tue, 15 Sep 2020 16:44:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600202667; x=1631738667;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=62iy0FClXpS5m7IbRGjqwGdS8/c3YcUFBp5a71kJEEE=;
 b=VfwjvwaNz2LWdKtmb6WrKXZK4KrjnlleAAa5uExmZPCGOma+kMP/2fdI
 0ETp2wjrlfYItInK88yzq0zcCKC5NjledJjBPDVwPZBq+K7kRv1/NYtGS
 d3mbd+srj8OUPUIvgrDWw1KTxdatGXUCK+g33ILrxW/3X7sdpZJ0mE3/N
 ouNkEFNJJpnwvRVLvYCVY0jgMtBQmWKUdYZKEoWTyL4I9nqIiKs0rETNc
 VtH2O6ujVc6b4azcjehW5MiHro0s7+fQnq7+lZ8CRWldi1/vFvvFsp8tr
 8X92Tnbsf7a6upmSFLVPRXrfXQ9gXD9Iy0RlT4oyCR4d/PPLeX5rwSVU6 Q==;
IronPort-SDR: 2mJl5SukQzP9C12uS3voeBxI+o4hL0I+cWXfZ1qgogywj0YcjIswFR24WDNclkf/itYzCbLRqH
 oC2zmZEXGD8k/dNwbwDBbGbda9jJUtH3m5j7Z1i6wOnZVXGbBaUmXzrisfwHJ0vrSIWuF3AC47
 UQ7tvlgiiQVWlmeIg5SfxfdvktSIKgJiXTzCabVUBa98Fe1S8vJ/LYWDmu6w5xM2KP+7vZpR5z
 IJkKQ5fCAVhIL0xwFOBaOi5TpVUW85ra5WZ67myFGFTzb2zCn8/QEsHT8ZNHDjyvfCPJynHb/x
 6p8=
X-IronPort-AV: E=Sophos;i="5.76,430,1592841600"; d="scan'208";a="147379722"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
 by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2020 04:44:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaEY1xpGkDjjgu/6cFhs46s6yTo4vwp8p557YN9dtKyp8vAu7lRKaSyDQ/a4cfaZGhMGpQtBbp+TO1OFQmigNkrNvlC5fVewN0TZLp2ctPWgtj7oLbUVwVBUjWQYKbC1rbSz0FSFNDCa1Ss4AfCChLo1PjGuGX8Mt3pR/tLERFGu9IJPwpHaP13mF5aFoxjLrSVenj4yftiks/dtc0wV0GB1IWeDTLR75U64Lp2spLJ8C7D4ahy7aOEMTLkVJCd1kB7pQlOnp+sQY1Z/iC0lDFaP3Db2fs4YRtvb81vIlqiYGCkvRYzRXbcgMSnsVmLRYFljw4dA/ywpJrNN5akWGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62iy0FClXpS5m7IbRGjqwGdS8/c3YcUFBp5a71kJEEE=;
 b=lD6Evr+5+92ZCPFyPyvhgdSae/eDcehoxptG8rwkHN8D8JIQtHXUBjkDPwLmp23xmApY2DkE9GVko+2dflBMvQr4NnZdu7PCeKgtNkKWJN9yfzcahZTe0zfSe6gPkPTmOOVhw3y2e5zdtXCdO1+uDXcOPLhYDPZfv5abMAzqHLmAPSudGIS3TkaXG2HKf8FyWd4UOkWjwVCW1P8JVlTcU8XzRHKNTwgzmurPt6eTfsd54NlIBgI5/pRFj29/vwy/vof9gdCbdU2oSNiUvgtfoIsNAgcpeKv5W4lJOf62e2kqmkx34IUBn5zW8tz1JNA0x6bdau4TDA7wapb+gYbR/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62iy0FClXpS5m7IbRGjqwGdS8/c3YcUFBp5a71kJEEE=;
 b=UWnZwgL7PMC6rHqt1uJahYzPZSysTT+owvs7Mh8bDpBUTFJcy2HAEVH/YEp2CGoTS3rIg/0RHajeltUE8s/COjZmLDipzXXeiIRm/fPSp0VmNAG16BZw6BXZve0wPWEb4pcS7d5NIJ/Z4wmARy3paZmCFvlgsgjN7VQIvoRTx2c=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5854.namprd04.prod.outlook.com (2603:10b6:208:3c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Tue, 15 Sep
 2020 20:44:23 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94%6]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 20:44:23 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: RE: [PATCH v3 14/15] hw/block/nvme: Use zone metadata file for
 persistence
Thread-Topic: [PATCH v3 14/15] hw/block/nvme: Use zone metadata file for
 persistence
Thread-Index: AQHWihtdGRurZ+K5tkGARQz73/+iLqlqE0mAgAAWzYA=
Date: Tue, 15 Sep 2020 20:44:22 +0000
Message-ID: <MN2PR04MB5951BE02EAFDCDEF2DEF9AFBE1200@MN2PR04MB5951.namprd04.prod.outlook.com>
References: <20200913221436.22844-1-dmitry.fomichev@wdc.com>
 <20200913221436.22844-15-dmitry.fomichev@wdc.com>
 <20200915190935.GD499689@apples.localdomain>
In-Reply-To: <20200915190935.GD499689@apples.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 811d245a-5fcd-4c1e-7054-08d859b820ad
x-ms-traffictypediagnostic: MN2PR04MB5854:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB5854645FC447806DB29226E6E1200@MN2PR04MB5854.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OKwJ1TOPZK4lWBeNF+qqHTFvLJ8YT0DTwzGKC1T7WQxAe4WLWPUrP9iOSGQWaI7waBhBEiAYUyJMGHUaPdLlLP4493xhvfDNyB4iVBr+KdPZKIoHPTa55j+G0aJtKRorUuyrI6DC+4ElLoOdgYe3wAchVcDkMqCrKS1WRtQEkuvBX4idpCxehqoF/kc9RNxQGD2w1GnYqypjS25Y/z8xKM2G/p8o2sV6cC90qM04i3S9R02XofQB0r3o5EnjEt3mhFeYxRPMEFpWTIazqvXFNpWbP0CYJEh24emxpBuMmVPPjJi3QxRoYQ3inpktO4m4+v/X1VuibjGIaUlgfL0Oao4YbywAtjFkaFO1oGIIlSwvrNtdMgMnj7jPifhIWU6u
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(66946007)(83380400001)(86362001)(5660300002)(52536014)(8676002)(9686003)(71200400001)(53546011)(6506007)(55016002)(2906002)(33656002)(316002)(66446008)(64756008)(66556008)(66476007)(76116006)(26005)(7696005)(6916009)(4326008)(478600001)(54906003)(186003)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 9myhY38pavh9K0NGn+8Nh7zs053Ia6RXxgsK405HL4TDyGpfGPSJFjPlX/6oCPcSJYw5DVgJpXPwoMZzujFWDBPaKbekC4qJ5pb3dUpMvSuLteDnAeIh5oJB0r9WPtjh+6sAtmf9M4aiHZLE9DZICyFEktvqK6Vy7HyBdJ/rhkSNg4f+/U9F70ThIZa59IFuQ4XaDaYGL41lEuxWp8tmFqjRxO+EGCFDg7n3FECtlhnlgHDJ+nvSX694aRL/Ep9/4JMVJX5333IqtKEn6LEQKPHg03/Oca/U+/ZX+LbwG+nSMl+LbanWacR0SLxPrFx9P7M898DwGk9JMkLqOgfxxu6EEzhCEbxMDUQzy1TiXSDPcVWiiC4hqtLNo7bSKh7pGQpmG1nvlGgOOwq2Hd9xXOSq7lhfNThp4KS7uuK8XICJDZ1biSJo+ajWn1R7ju/bCJbDxPz8ovOTrcqHnca7MIBMR/pqyfYxe1LiQrqVgAyqMvxmgk/3AGJmzjSFsx7H7MPCy0fg2MnwcihNfQ/8CumzxD2cMAPGxebNzL76T7e2db0pp9bww2a1glTy8OADnN7TwLFgDyohiBWBvEjAw9/sjQ9hHIZtTOtc2CgT2S0UwXtBGGTxJ0H9ZTKe5cnNAxtiT5rvEnRNFRNvdyI0YQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 811d245a-5fcd-4c1e-7054-08d859b820ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 20:44:22.7348 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S6TC4Y/yIuhqFJLcOX3YB5fQ5OKPSGfjL84nxm8I/nihUa8bfaQw5CLaKLRhKLqDd0FFFSUoTdZc92/v7Fj7Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5854
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=520035bb9=Dmitry.Fomichev@wdc.com; helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 16:44:25
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
cnJlbGV2YW50LmRrPg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMTUsIDIwMjAgMzoxMCBQ
TQ0KPiBUbzogRG1pdHJ5IEZvbWljaGV2IDxEbWl0cnkuRm9taWNoZXZAd2RjLmNvbT4NCj4gQ2M6
IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz47IEtsYXVzIEplbnNlbg0KPiA8ay5qZW5z
ZW5Ac2Ftc3VuZy5jb20+OyBLZXZpbiBXb2xmIDxrd29sZkByZWRoYXQuY29tPjsgUGhpbGlwcGUN
Cj4gTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPjsgTWF4aW0gTGV2aXRza3kNCj4g
PG1sZXZpdHNrQHJlZGhhdC5jb20+OyBGYW0gWmhlbmcgPGZhbUBldXBob24ubmV0PjsgTmlrbGFz
IENhc3NlbA0KPiA8TmlrbGFzLkNhc3NlbEB3ZGMuY29tPjsgRGFtaWVuIExlIE1vYWwgPERhbWll
bi5MZU1vYWxAd2RjLmNvbT47DQo+IHFlbXUtYmxvY2tAbm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBu
b25nbnUub3JnOyBBbGlzdGFpciBGcmFuY2lzDQo+IDxBbGlzdGFpci5GcmFuY2lzQHdkYy5jb20+
OyBNYXRpYXMgQmpvcmxpbmcgPE1hdGlhcy5Cam9ybGluZ0B3ZGMuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYzIDE0LzE1XSBody9ibG9jay9udm1lOiBVc2Ugem9uZSBtZXRhZGF0YSBmaWxl
IGZvcg0KPiBwZXJzaXN0ZW5jZQ0KPiANCj4gT24gU2VwIDE0IDA3OjE0LCBEbWl0cnkgRm9taWNo
ZXYgd3JvdGU6DQo+ID4gQSBaTlMgZHJpdmUgdGhhdCBpcyBlbXVsYXRlZCBieSB0aGlzIG1vZHVs
ZSBpcyBjdXJyZW50bHkgaW5pdGlhbGl6ZWQNCj4gPiB3aXRoIGFsbCB6b25lcyBFbXB0eSB1cG9u
IHN0YXJ0dXAuIEhvd2V2ZXIsIGFjdHVhbCBaTlMgU1NEcyBzYXZlIHRoZQ0KPiA+IHN0YXRlIGFu
ZCBjb25kaXRpb24gb2YgYWxsIHpvbmVzIGluIHRoZWlyIGludGVybmFsIE5WUkFNIGluIHRoZSBl
dmVudA0KPiA+IG9mIHBvd2VyIGxvc3MuIFdoZW4gc3VjaCBhIGRyaXZlIGlzIHBvd2VyZWQgdXAg
YWdhaW4sIGl0IGNsb3NlcyBvcg0KPiA+IGZpbmlzaGVzIGFsbCB6b25lcyB0aGF0IHdlcmUgb3Bl
biBhdCB0aGUgbW9tZW50IG9mIHNodXRkb3duLiBCZXNpZGVzDQo+ID4gdGhhdCwgdGhlIHdyaXRl
IHBvaW50ZXIgcG9zaXRpb24gYXMgd2VsbCBhcyB0aGUgc3RhdGUgYW5kIGNvbmRpdGlvbg0KPiA+
IG9mIGFsbCB6b25lcyBpcyBwcmVzZXJ2ZWQgYWNyb3NzIHBvd2VyLWRvd25zLg0KPiA+DQo+ID4g
VGhpcyBjb21taXQgYWRkcyB0aGUgY2FwYWJpbGl0eSB0byBoYXZlIGEgcGVyc2lzdGVudCB6b25l
IG1ldGFkYXRhDQo+ID4gdG8gdGhlIGRldmljZS4gVGhlIG5ldyBvcHRpb25hbCBtb2R1bGUgcHJv
cGVydHksICJ6b25lX2ZpbGUiLA0KPiA+IGlzIGludHJvZHVjZWQuIElmIGFkZGVkIHRvIHRoZSBj
b21tYW5kIGxpbmUsIHRoaXMgcHJvcGVydHkgc3BlY2lmaWVzDQo+ID4gdGhlIG5hbWUgb2YgdGhl
IGZpbGUgdGhhdCBzdG9yZXMgdGhlIHpvbmUgbWV0YWRhdGEuIElmICJ6b25lX2ZpbGUiIGlzDQo+
ID4gb21pdHRlZCwgdGhlIGRldmljZSB3aWxsIGJlIGluaXRpYWxpemVkIHdpdGggYWxsIHpvbmVz
IGVtcHR5LCB0aGUgc2FtZQ0KPiA+IGFzIGJlZm9yZS4NCj4gPg0KPiA+IElmIHpvbmUgbWV0YWRh
dGEgaXMgY29uZmlndXJlZCB0byBiZSBwZXJzaXN0ZW50LCB0aGVuIHpvbmUgZGVzY3JpcHRvcg0K
PiA+IGV4dGVuc2lvbnMgYWxzbyBwZXJzaXN0IGFjcm9zcyBjb250cm9sbGVyIHNodXRkb3ducy4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IERtaXRyeSBGb21pY2hldiA8ZG1pdHJ5LmZvbWljaGV2
QHdkYy5jb20+DQo+IA0KPiBUaGlzIGRvZXNuJ3QgYnVpbGQgb24gbWluZ3cuDQoNClRoYW5rcyBm
b3IgbGV0dGluZyBtZSBrbm93LiBJJ2xsIHRyeSB0byBsb29rIGludG8gdGhpcy4gRG8geW91IGNy
b3NzLWNvbXBpbGUNCndpdGggbWluZ3c2ND8NCg0KPiANCj4gPiAtLS0NCj4gPiAgaHcvYmxvY2sv
bnZtZS5jIHwgMzcwDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tLQ0KPiA+ICBody9ibG9jay9udm1lLmggfCAgMzcgKysrKysNCj4gPiAgMiBmaWxlcyBj
aGFuZ2VkLCAzODYgaW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvaHcvYmxvY2svbnZtZS5jIGIvaHcvYmxvY2svbnZtZS5jDQo+ID4gaW5kZXggYjQ5
YWU4M2RkNS4uNDFmNGMwZGFjZCAxMDA2NDQNCj4gPiAtLS0gYS9ody9ibG9jay9udm1lLmMNCj4g
PiArKysgYi9ody9ibG9jay9udm1lLmMNCj4gPiBAQCAtMzQyOSw3ICszNTU3LDE4OCBAQCBzdGF0
aWMgaW50IG52bWVfaW5pdF96b25lX21ldGEoTnZtZUN0cmwgKm4sDQo+IE52bWVOYW1lc3BhY2Ug
Km5zLA0KPiA+ICAgICAgcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+IC1zdGF0aWMgdm9pZCBu
dm1lX3pvbmVkX2luaXRfY3RybChOdm1lQ3RybCAqbiwgRXJyb3IgKiplcnJwKQ0KPiA+ICtzdGF0
aWMgaW50IG52bWVfb3Blbl96b25lX2ZpbGUoTnZtZUN0cmwgKm4sIGJvb2wgKmluaXRfbWV0YSkN
Cj4gPiArew0KPiA+ICsgICAgc3RydWN0IHN0YXQgc3RhdGJ1ZjsNCj4gPiArICAgIHNpemVfdCBm
c2l6ZTsNCj4gPiArICAgIGludCByZXQ7DQo+ID4gKw0KPiA+ICsgICAgcmV0ID0gc3RhdChuLT5w
YXJhbXMuem9uZV9maWxlLCAmc3RhdGJ1Zik7DQo+ID4gKyAgICBpZiAocmV0ICYmIGVycm5vID09
IEVOT0VOVCkgew0KPiA+ICsgICAgICAgICppbml0X21ldGEgPSB0cnVlOw0KPiA+ICsgICAgfSBl
bHNlIGlmICghU19JU1JFRyhzdGF0YnVmLnN0X21vZGUpKSB7DQo+ID4gKyAgICAgICAgZnByaW50
ZihzdGRlcnIsICIlcyBpcyBub3QgYSByZWd1bGFyIGZpbGVcbiIsIHN0cmVycm9yKGVycm5vKSk7
DQo+ID4gKyAgICAgICAgcmV0dXJuIC0xOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIG4t
PnpvbmVfZmlsZV9mZCA9IG9wZW4obi0+cGFyYW1zLnpvbmVfZmlsZSwNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgT19SRFdSIHwgT19MQVJHRUZJTEUgfCBPX0JJTkFSWSB8IE9fQ1JF
QVQsIDY0NCk7DQo+IA0KPiBtb2RlIGlzIHdyb25nIC0gSSB0aGluayB5b3UgbWVhbnQgZm9yIGl0
IHRvIGJlIG9jdGFsLg0KDQpOaWNlIGNhdGNoLCBuZWVkcyB0byBiZSAwNjQ0Li4uDQo=

