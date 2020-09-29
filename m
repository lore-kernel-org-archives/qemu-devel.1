Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52359C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 15:45:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E891206CD
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 15:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jKjWhGPA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="e5qrbewr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E891206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNHoO-0003rN-HF
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 11:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=534de8db0=Dmitry.Fomichev@wdc.com>)
 id 1kNHmI-000203-VT; Tue, 29 Sep 2020 11:42:55 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:61509)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=534de8db0=Dmitry.Fomichev@wdc.com>)
 id 1kNHmF-0004Ac-Kn; Tue, 29 Sep 2020 11:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601394172; x=1632930172;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VvjpOuMK32Bwh999r839FIQF+Vr7N7O+1xMXK1mZikI=;
 b=jKjWhGPAXnhmscHRnCRP8c77n1xdOxMLtY27soEJGsMzzS0klsO4k4Kq
 1/y/+Rv9+CL1VFymVrAHC9VRVGSqqCGqdFZ9Al+/lDdffepqZmHymdZJQ
 IBWqD26qQOqGU8NDnQ2ax2eL2dnruB8f4LN5hC8F58vwUY0yw/qlZAXG6
 GOYOh/kXEWcPjOC3sDSS7rE61gMHvKVeRbJUgNhUG6zG3CghB98oh5K5e
 O6SuHC8pCVk40LFXVERM/nYm6xaDy/lvpm0cFCSY2hepaVBskGT+8UGwQ
 RidQOISWTfmwHWmhkToTX+gyRPaLMfUXLosra+ck+E5TvCRcklaa6pLxG g==;
IronPort-SDR: EFYWietLKaNwB3gwEKLz7FBfcGV9I9NHGl4LbSJescyWbD6gb/gabJLlngfMoJ3dwKv5Lw8g5t
 9ImsGnQMkqEZrWQNmnLUBZn965k+80yPfSzmGi4hWdkGtQaDmBToMRnw5NiayrjjLFeL+ero7+
 RZ9kN5sS7W6D3BPpkiEkcrwJllJ6BredVXlb4tuhO3nTxv1y2zacG4AhFmu0ry0bm+HTDUu3bj
 cRdIdBIf2ryQzQfR6gYvLhz8vpgunXDrx8jf5bvdR8D9ezIUqSsTt9Uv53cIcdgfkjMIGf6nhs
 9EA=
X-IronPort-AV: E=Sophos;i="5.77,319,1596470400"; d="scan'208";a="148595716"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
 by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2020 23:42:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R49DSvzB0HJpef9BF5LYtcuonDzEJcQBflZSGEyMOTGUVTF28VZKAvRkwH3ECW/oC6lEs2CPhqoy1JQRadZtbZrCiPtjbvrdIYe/qAq5q1n/TGG1kzSoBEq6wd2Zvtds+B0lr0AAH963hkzrl139wCUjfXTHG9I5lJihuLfWtwy0uUmr8cUWmqSZFIMvlfoXUODbyt0eJEeFAAiVYD4XVtvf6xJCoRUJCO1y9qQadOhoQrOM8yng2nYSMkPYesU6c/eMNnaduXc6OLSaL7YHKDUjpQyWGvB8coElV1Y5y6wsBHlpcHwM8zUS88+wt8EGjEzpZAF56dNjyzER+0XoVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvjpOuMK32Bwh999r839FIQF+Vr7N7O+1xMXK1mZikI=;
 b=jHHZ2uj51MxVrtYqBLObcu86lBh1PDUGcfHpNizCtsY4F4F9Y+tvk/E71VqkO1o6bkxSpJgygP8aGFajinHpVKn6Ywfo6GQzLfoeMWDwnsDCA9WchVeNismdTQGyVt2BJPPkQwSo4dtKhoAgHybh5vE1Pwv1uFRklt2ddxK/UtcQ/jjxmJOAko5dIwp7PqpIBSH13CsIe2/jM0Y4S2XjWIkXkhVfp21+ofFipWRQdh4v483DNt2kR0P9vWlwTe+QduiEJRPbbIWo/1ya1EMlW2gJEQ/rs5L/YmdXOcgwIXnNnnaZ5gSopnKAYvWLSJ5afeLGyoxsS36ZLoA1aZoDUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvjpOuMK32Bwh999r839FIQF+Vr7N7O+1xMXK1mZikI=;
 b=e5qrbewrJcOU7LjuuJATW85FpaGlHnX8oiVDkzdTsbJQkFvPyUPK/rKtl9B16L5Jp6YQntMkLB0nnWOvzp25vE2/slh5mTyOC9PnXAvlR2cJ1012OeAApDniIXkngon8sGqiRo5LVH/CBHjKSItKocHa5HV+s2z7qBz5bQ/fknU=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5520.namprd04.prod.outlook.com (2603:10b6:208:d7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.26; Tue, 29 Sep
 2020 15:42:41 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94%6]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 15:42:41 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: RE: [PATCH v4 00/14] hw/block/nvme: Support Namespace Types and Zoned
 Namespace Command Set
Thread-Topic: [PATCH v4 00/14] hw/block/nvme: Support Namespace Types and
 Zoned Namespace Command Set
Thread-Index: AQHWkdZJY2r+3+EgB0+n1uDhiCCmB6l4SdmAgAEvKJCABCbNAIACED4g
Date: Tue, 29 Sep 2020 15:42:40 +0000
Message-ID: <MN2PR04MB5951A1DAC6A607732A35B968E1320@MN2PR04MB5951.namprd04.prod.outlook.com>
References: <20200923182021.3724-1-dmitry.fomichev@wdc.com>
 <20200924210751.GD1738917@apples.localdomain>
 <MN2PR04MB59515B1EA1238861DFF3236AE1350@MN2PR04MB5951.namprd04.prod.outlook.com>
 <20200928063648.GA1967@apples.localdomain>
In-Reply-To: <20200928063648.GA1967@apples.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a4fe0841-a063-4be9-02e1-08d8648e4cf7
x-ms-traffictypediagnostic: MN2PR04MB5520:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB55201CD06A7F62479DF6C259E1320@MN2PR04MB5520.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nF7fZNUdSBoBjnf61e4EU5BXYJmDhFbXjPe54d5KknKE80mWP+rf/U3Nsmj38EUNDh1W4DOUpcpjeWQfEIGq2MD0ACVIqXl+gpjnMG8boQ2chLf1rICrsAxI2qL7WnjnY/r3ifeCBNvt+myoQMJanlZ7BN1LMqHqupNkCAKOP6LbbHXe1Se7k70T6gPfvT8V4M9fbd+nx8/nChYFQYGE0LRMQ73qWnrN1U5pUGE9i7PGgR6HkAq8E/nEiaEu+D9Vv2xoTTRzMW0z71kg/9ck3CEgeDBTgD3BpCx373DnIkSAlBdFZKxLrelRKG2lyPnkuGyz/5WtzMaufLCQkm8nXPrHIuq0KFdpV3aW2awKZGKtpk5nMNvCA/BA/5ZCvMU23CiH4tp4jrAcny/27/+nff4O9dtLGeyFe1yF20RdvFw4F52o1Dje/lpnRhBDaRXD67ZFEIZAFhZxxQDC/z4xfA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(6916009)(4326008)(83380400001)(966005)(7696005)(66476007)(64756008)(66556008)(66446008)(76116006)(52536014)(6506007)(53546011)(33656002)(2906002)(26005)(66946007)(8676002)(5660300002)(8936002)(9686003)(55016002)(71200400001)(186003)(54906003)(478600001)(86362001)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 4zWIXcZUtUT8eXG6/vauW80HFccnJy9G9j43dyzfKj1ufF52cDVOxp9FpPvWRO3Dqm/8oaBgc8xO6+5OJW4aOVmipeO5dp5w1iVSJO6GHUNMtLNPNW/SK3IeMezdM09wXv3B2A4a8LYjIvtSZtsCdJtk5xFaheqXCPmPYDx6z047fGcl7BGFTFZXXLH4UKIv87UXVMhi/0EDj+fiV6PbwUambvMwIzLJJFrkynIeNno1NMynwSpO7Hj2NmZNG20wpBI7UGyvilgwpFIVt1uGFhoya3e5kvPy/zobYlCB4DqhiddHEccgqS2Doud1ED3iZQBri+b1q/Gtwi7es5hriEaKK3rUQBbEJT61n7dXGvw36ADZf+8hKMbbEDUh/bzrq4FxDstBZn1FprCstw5vYUg6CX5xANdME5qnZBj/2zuDBGCfjPKv5JCzbPKvqjxEy5I/zJywA/NL5JHbXArF0aMW3f4lId0zdMKudUv2+dTwD9Kl9EUL7Ja0tNcbLSpK8gSY3YlVKJtvdY26xPV0ZLToy9F1GemGPXiRbeosLfrSR9dHlhaZRm29zOwnmGnl2jOL2A/08j1wvNJnogVOGcfoJnM97BI9cd2YDiIiZ2UPeBNRajqJJj+VStdzQxDaDGc/aaOYZSpJ3rxFeI7wLw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4fe0841-a063-4be9-02e1-08d8648e4cf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 15:42:41.0346 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nDXZ5Yh9AC/9I3Xlm78tRLp9ZdtapvvGKrFYhoT+Com66oEbkJtzPB0Vn+xYaYYAlGSuiTgOPb8yVdAWVEeQIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5520
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=534de8db0=Dmitry.Fomichev@wdc.com; helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 11:42:46
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
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
cnJlbGV2YW50LmRrPg0KPiBTZW50OiBNb25kYXksIFNlcHRlbWJlciAyOCwgMjAyMCAyOjM3IEFN
DQo+IFRvOiBEbWl0cnkgRm9taWNoZXYgPERtaXRyeS5Gb21pY2hldkB3ZGMuY29tPg0KPiBDYzog
S2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPjsgRGFtaWVuIExlIE1vYWwNCj4gPERhbWll
bi5MZU1vYWxAd2RjLmNvbT47IEtsYXVzIEplbnNlbiA8ay5qZW5zZW5Ac2Ftc3VuZy5jb20+OyBL
ZXZpbg0KPiBXb2xmIDxrd29sZkByZWRoYXQuY29tPjsgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kg
PHBoaWxtZEByZWRoYXQuY29tPjsNCj4gTWF4aW0gTGV2aXRza3kgPG1sZXZpdHNrQHJlZGhhdC5j
b20+OyBGYW0gWmhlbmcgPGZhbUBldXBob24ubmV0PjsNCj4gTmlrbGFzIENhc3NlbCA8TmlrbGFz
LkNhc3NlbEB3ZGMuY29tPjsgcWVtdS1ibG9ja0Bub25nbnUub3JnOyBxZW11LQ0KPiBkZXZlbEBu
b25nbnUub3JnOyBBbGlzdGFpciBGcmFuY2lzIDxBbGlzdGFpci5GcmFuY2lzQHdkYy5jb20+OyBN
YXRpYXMNCj4gQmpvcmxpbmcgPE1hdGlhcy5Cam9ybGluZ0B3ZGMuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHY0IDAwLzE0XSBody9ibG9jay9udm1lOiBTdXBwb3J0IE5hbWVzcGFjZSBUeXBl
cw0KPiBhbmQgWm9uZWQgTmFtZXNwYWNlIENvbW1hbmQgU2V0DQo+IA0KPiBPbiBTZXAgMjggMDI6
MzMsIERtaXRyeSBGb21pY2hldiB3cm90ZToNCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4gPiBGcm9tOiBLbGF1cyBKZW5zZW4gPGl0c0BpcnJlbGV2YW50LmRrPg0KPiA+ID4N
Cj4gPiA+IElmIGl0IHJlYWxseSBuZWVkcyB0byBiZSBtZW1vcnkgbWFwcGVkLCB0aGVuIEkgdGhp
bmsgYSBob3N0bWVtLWJhc2VkDQo+ID4gPiBhcHByb2FjaCBzaW1pbGFyIHRvIHdoYXQgQW5kcnpl
aiBkaWQgZm9yIFBNUiBpcyBuZWVkZWQgKEkgdGhpbmsgdGhhdA0KPiA+ID4gd2lsbCBnZXQgcmlk
IG9mIHRoZSBDT05GSUdfUE9TSVggaWZkZWYgYXQgbGVhc3QsIGJ1dCBzdGlsbCBsZWF2ZSBpdA0K
PiA+ID4gc2xpZ2h0bHkgdHJpY2t5IHRvIGdldCBpdCB0byB3b3JrIG9uIGFsbCBwbGF0Zm9ybXMg
QUZBSUspLg0KPiA+DQo+ID4gT2ssIGl0IGxvb2tzIHRoYXQgdXNpbmcgdGhlIEhvc3RNZW1vcnlC
YWNrZW5kRmlsZSBiYWNrZW5kIHdpbGwgYmUNCj4gPiBtb3JlIGFwcHJvcHJpYXRlLiBUaGlzIHdp
bGwgcmVtb3ZlIHRoZSBuZWVkIGZvciBjb25kaXRpb25hbCBjb21waWxlLg0KPiA+DQo+ID4gVGhl
IG1tYXAoKSBwb3J0YWJpbGl0eSBpcyBwcmV0dHkgZGVjZW50IGFjcm9zcyBzb2Z0d2FyZSBwbGF0
Zm9ybXMuDQo+ID4gQW55IHBvb3IgV2luZG93cyB1c2VyIHdobyBpcyBmb3JjZWQgdG8gZW11bGF0
ZSBaTlMgb24gbWluZ3cgd2lsbCBiZQ0KPiA+IGFibGUgdG8gZG8gc28sIGp1c3Qgd2l0aG91dCBo
YXZpbmcgem9uZSBzdGF0ZSBwZXJzaXN0ZW5jeS4gQ29uc2lkZXJpbmcNCj4gPiBob3cgc3BlY2lh
bGl6ZWQgdGhpcyBzdHVmZiBpcyBpbiBmaXJzdCBwbGFjZSwgSSBlc3RpbWF0ZSB0aGUgbnVtYmVy
IG9mIHVzZXJzDQo+ID4gYWZmZWN0ZWQgYnkgdGhpcyAibGltaXRhdGlvbiIgdG8gYmUgZXhhY3Rs
eSB6ZXJvLg0KPiA+DQo+IA0KPiBRRU1VIGlzIGEgY3Jvc3MgcGxhdGZvcm0gcHJvamVjdCAtIHdl
IHNob3VsZCBzdHJpdmUgZm9yIHBvcnRhYmlsaXR5Lg0KPiANCj4gQWxpZW5hdGluZyBkZXZlbG9w
ZXJzIHRoYXQgdXNlIGEgV2luZG93cyBwbGF0Zm9ybSBhbmQgY2FsbGluZyB0aGVtIG91dA0KPiBh
cyAicG9vciIgaXMgbm90IGV4YWN0bHkgZ29vZCBmb3IgdGhlIHpvbmVkIGVjb3N5c3RlbS4NCj4g
DQoNCldvdy4gQnkgYnJpbmdpbmcgdXAgcG9saXRpY2FsIGNvcnJlY3RuZXNzIGhlcmUgeW91IGFy
ZSBiYXNpY2FsbHkgYWRtaXR0aW5nDQp0aGUgZmFjdCB0aGF0IHlvdSBoYXZlIG5vIHJlYWwgdGVj
aG5pY2FsIGFyZ3VtZW50IGhlcmUuIFRoZSB3aG9sZSBXaW5kb3dzDQppc3N1ZSBpcyByZWQgaGVy
cmluZyB0aGF0IHlvdSBhcmUgdXNpbmcgdG8gYXR0YWNrIHRoZSBjb2RlIHRoYXQgaXMgYWJzb2x1
dGVseQ0KbGVnaXQsIGJ1dCBjb21lcyBmcm9tIGEgY29tcGV0aXRvci4gWW91ciBpbml0aWFsIGNv
bXBsYWludCB3YXMgdGhhdCBpdA0KZG9lc24ndCBjb21waWxlIGluIG1pbmd3IGFuZCB0aGF0IGl0
IHVzZXMgIndyb25nIiBBUEkuIFlvdSBoYXZlIGV2ZW4NCnN1Z2dlc3RlZCB0aGUgQVBJIHRvIHVz
ZS4gTm93LCB0aGUgY29kZSB1c2VzIHRoYXQgQVBJIGFuZCBidWlsZHMgZmluZSwgYnV0DQpub3cg
aXQncyBzdGlsbCBub3QgZ29vZCBzaW1wbHkgYmVjYXVzZSB5b3UgImRvIG5vdCBsaWtlIGl0Ii4g
SXQncyBhIGRpc2dyYWNlLg0KDQo+ID4gPiBCdXQgcmVhbGx5LA0KPiA+ID4gc2luY2Ugd2UgZG8g
bm90IHJlcXVpcmUgbWVtb3J5IHNlbWFudGljcyBmb3IgdGhpcywgdGhlbiBJIHRoaW5rIHRoZQ0K
PiA+ID4gYWJzdHJhY3Rpb24gaXMgZnVuZGFtZW50YWxseSB3cm9uZy4NCj4gPiA+DQo+ID4NCj4g
PiBTZXJpb3VzbHksIHdoYXQgaXMgd3Jvbmcgd2l0aCB1c2luZyBtbWFwIDopID8gSXQgaXMgdXNl
ZCBzdWNjZXNzZnVsbHkgZm9yDQo+ID4gc2ltaWxhciBhcHBsaWNhdGlvbnMsIGZvciBleGFtcGxl
IC0NCj4gPiBodHRwczovL2dpdGh1Yi5jb20vb3Blbi1pc2NzaS90Y211LXJ1bm5lci9ibG9iL21h
c3Rlci9maWxlX3piYy5jDQo+ID4NCj4gDQo+IFRoZXJlIGlzIG5vdGhpbmcgZnVuZGFtZW50YWxs
eSB3cm9uZyB3aXRoIG1tYXAuIEkganVzdCB0aGluayBpdCBpcyB0aGUNCj4gd3JvbmcgYWJzdHJh
Y3Rpb24gaGVyZSAoYW5kIGl0IGxpbWl0cyBwb3J0YWJpbGl0eSBmb3Igbm8gZ29vZCByZWFzb24p
Lg0KPiBGb3IgUE1SIHRoZXJlIGlzIGEgZ29vZCByZWFzb24gLSBpdCByZXF1aXJlcyBtZW1vcnkg
c2VtYW50aWNzLg0KPiANCg0KV2UgYXJlIHRyeWluZyB0byBlbXVsYXRlIE5WTUVlIGNvbnRyb2xs
ZXIgTlZSQU0uICBUaGUgYmVzdCBhYnN0cmFjdGlvbg0KZm9yIGVtdWxhdGluZyBOVlJBTSB3b3Vs
ZCBiZS4uLiBOVlJBTSENCg0KPiA+ID4gSSBhbSwgb2YgY291cnNlLCBibG93aW5nIG15IG93biBo
b3JuLCBzaW5jZSBteSBpbXBsZW1lbnRhdGlvbiB1c2VzIGENCj4gPiA+IHBvcnRhYmxlIGJsb2Nr
ZGV2IGZvciB0aGlzLg0KPiA+ID4NCj4gPg0KPiA+IFlvdSBhcmUgbWFraW5nIGl0IHNvdW5kIGxp
a2UgdGhlIGVudGlyZSBXREMgc2VyaWVzIHJlbGllcyBvbiB0aGlzIGFwcHJvYWNoLg0KPiA+IEFj
dHVhbGx5LCB0aGUgcGVyc2lzdGVuY3kgaXMgaW50cm9kdWNlZCBpbiB0aGUgc2Vjb25kIHRvIGxh
c3QgcGF0Y2ggaW4gdGhlDQo+ID4gc2VyaWVzIGFuZCBpdCBvbmx5IGFkZHMgYSBjb3VwbGUgb2Yg
bGluZXMgb2YgY29kZSBpbiB0aGUgaS9vIHBhdGggdG8gbWFyaw0KPiA+IHpvbmVzIGRpcnR5LiBU
aGlzIGlzIHBvc3NpYmxlIGJlY2F1c2Ugb2YgdXNpbmcgbW1hcCgpIGFuZCBJIGZpbmQgdGhlIHdh
eQ0KPiA+IGl0IGlzIGRvbmUgdG8gYmUgcXVpdGUgZWxlZ2FudCwgbm90IHVnbHkgOikNCj4gPg0K
PiANCj4gTm8sIEkgdW5kZXJzdGFuZCB0aGF0IHlvdXIgaW1wbGVtZW50YXRpb24gd29ya3MgZmlu
ZSB3aXRob3V0DQo+IHBlcnNpc3RhbmNlLCBidXQgcGVyc2lzdGFuY2UgaXMga2V5LiBUaGF0IGlz
IHdoeSBteSBzZXJpZXMgYWRkcyBpdCBpbg0KPiB0aGUgZmlyc3QgcGF0Y2guIFdpdGhvdXQgcGVy
c2lzdGVuY2UgaXQgaXMganVzdCBhIHRveS4gQW5kIHRoZSBRRU1VDQo+IGRldmljZSBpcyBub3Qg
anVzdCBhbiAiTlZNZS12ZXJzaW9uIiBvZiBudWxsX2Jsay4NCj4gDQo+IEFuZCBJIGRvbid0IHRo
aW5rIEkgZXZlciBjYWxsZWQgdGhlIHVzZSBvZiBtbWFwIHVnbHkuIEkgY2FsbGVkIG91dCB0aGUN
Cj4gcGh5c2ljYWwgbWVtb3J5IEFQSSBzaGVuYW5pZ2FucyBhcyBhIGhhY2suDQo+IA0KPiA+ID4g
QW5vdGhlciBpc3N1ZSBpcyB0aGUgY29tcGxldGUgbGFjayBvZiBlbmRpYW4gY29udmVyc2lvbnMu
IERvZXMgaXQNCj4gPiA+IG1hdHRlcj8gSXQgZGVwZW5kcy4gV2lsbCBhbnlvbmUgZXZlciB1c2Ug
dGhpcyBvbiBhIGJpZyBlbmRpYW4gaG9zdCBhbmQNCj4gPiA+IG1vdmUgdGhlIG1ldGEgZGF0YSBi
YWNraW5nIGZpbGUgdG8gYSBsaXR0bGUgZW5kaWFuIGhvc3Q/IFByb2JhYmx5IG5vdC4NCj4gPiA+
IFNvIGRvZXMgaXQgcmVhbGx5IG1hdHRlcj8gUHJvYmFibHkgbm90LCBidXQgaXQgaXMgY3V0dGlu
ZyBjb3JuZXJzLg0KPiA+ID4NCj4gDQo+IEFmdGVyIEkgaGFkIHJlcGxpZWQgdGhpcywgSSBjb25z
aWRlcmVkIGEgZm9sbG93LXVwLCBiZWNhdXNlIHRoZXJlIGFyZQ0KPiBwcm9iYWJseSBRRU1VIGRl
dmVsb3BlcnMgdGhhdCB3b3VsZCBjYWxsIG1lIG91dCBvbiB0aGlzLg0KPiANCj4gVGhpcyBkZWZp
bml0ZWx5IERPRVMgbWF0dGVyIHRvIFFFTVUuDQo+IA0KPiA+DQo+ID4gR3JlYXQgcG9pbnQgb24g
ZW5kaWFubmVzcyEgTmF0dXJhbGx5LCBhbGwgZmlsZSBiYWNrZWQgdmFsdWVzIGFyZSBzdG9yZWQg
aW4NCj4gPiB0aGVpciBuYXRpdmUgZW5kaWFubmVzcy4gVGhpcyB3YXksIHRoZXJlIGlzIG5vIGV4
dHJhIG92ZXJoZWFkIG9uIGJpZyBlbmRpYW4NCj4gPiBoYXJkd2FyZSBhcmNoaXRlY3R1cmVzLiBQ
b3J0YWJpbGl0eSBjb25jZXJucyBjYW4gYmUgZWFzaWx5IGFkZHJlc3NlZCBieQ0KPiA+IHN0b3Jp
bmcgbWV0YWRhdGEgZW5kaWFubmVzcyBhcyBhIGJ5dGUgZmxhZyBpbiBpdHMgaGVhZGVyLiBUaGVu
LCBkdXJpbmcNCj4gPiBpbml0aWFsaXphdGlvbiwgdGhlIG1ldGFkYXRhIHZhbGlkYXRpb24gY29k
ZSBjYW4gZGV0ZWN0IHRoZSBwb3NzaWJsZQ0KPiA+IGRpc2NyZXBhbmN5IGluIGVuZGlhbm5lc3Mg
YW5kIGF1dG9tYXRpY2FsbHkgY29udmVydCB0aGUgbWV0YWRhdGEgdG8gdGhlDQo+ID4gZW5kaWFu
bmVzcyBvZiB0aGUgaG9zdC4gVGhpcyBwYXJ0IGlzIG91dCBvZiBzY29wZSBvZiB0aGlzIHNlcmll
cywgYnV0IEkgd291bGQNCj4gPiBiZSBhYmxlIHRvIGNvbnRyaWJ1dGUgc3VjaCBhIHNvbHV0aW9u
IGFzIGFuIGVuaGFuY2VtZW50IGluIHRoZSBmdXR1cmUuDQo+ID4NCj4gDQo+IEl0IGlzIG5vdCBv
dXQgb2Ygc2NvcGUuIEkgZG9uJ3Qgc2VlIHdoeSB3ZSBzaG91bGQgbWVyZ2Ugc29tZXRoaW5nIHRo
YXQNCj4gaXMgYXJndWFibHkgYnVnZ3kuDQoNCkFnYWluLCB3b3chIE5vdyB5b3UgdHVybmVkIGFy
b3VuZCBhbmQgYXJiaXRyYXJpbHkgZWxldmF0ZWQgdGhpcyBpc3N1ZSBmcm9tDQptb2RlcmF0ZSAo
IkRvZXMgaXQgbWF0dGVyPywgY3V0dGluZyBjb3JuZXJzIikgdG8gc2V2ZXJlICgiYnVnZ3kiKS4g
TGlrZWx5DQpiZWNhdXNlIHY1IG9mIFdEQyBwYXRjaHNldCBoYXMgYmVlbiBwb3N0ZWQuIFRoaXMs
IGFnYWluLCBqdXN0IHNob3dzIHlvdXINCmxhY2sgb2YgaW50ZWdyaXR5IGFzIGEgbWFpbnRhaW5l
ci4NCg0KVGhpcyAiaXNzdWUiIGlzIGEgcmVhbCB0cml2aWFsIG9uZSB0byBmaXggYXMgSSBkZXNj
cmliZWQgYWJvdmUgYW5kIHlvdSBhcmUNCmJsb3dpbmcgaXQgdXAgd2F5IG91dCBvZiBwcm9wb3J0
aW9uLCBtYWtpbmcgaXQgbG9vayBsaWtlIGl0IGlzIGEgZnVuZGFtZW50YWwNCnByb2JsZW0gdGhh
dCBjYW4gbm90IGJlIHJlc29sdmVkLiBJdCdzIG5vdC4NCg0KPiANCj4gQm90dG9tbGluZSBpcyB0
aGF0IEkganVzdCBkb24ndCBzZWUgd2h5IHdlIHNob3VsZCBhY2NlcHQgYW4NCj4gaW1wbGVtZW50
YXRpb24gdGhhdA0KPiANCj4gICBhKSBleGNsdWRlcyBzb21lIHBsYXRmb3JtcyAoV2luZG93cykg
ZnJvbSB1c2luZyBwZXJzaXN0ZW5jZTsgYW5kDQo+ICAgYikgY29udGFpbnMgZW5kaWFubmVzcyBj
b252ZXJzaW9uIGlzc3Vlcw0KPiANCj4gd2hlbiB0aGVyZSBpcyBhIHBvcnRhYmxlIGltcGxlbWVu
dGF0aW9uIHBvc3RlZCB0aGF0IGF0IGxlYXN0IHRyaWVzIHRvDQo+IGNvbnZlcnQgZW5kaWFubmVz
cyBhcyBuZWVkZWQuDQoNCkRvZXNuJ3QgdGhhdCBpbXBsZW1lbnRhdGlvbiBkaXNjcmltaW5hdGUg
YWdhaW5zdCBiaWcgZW5kaWFuIGFyY2hpdGVjdHVyZXM/IDopDQpPaywgaXQgaXMgYSBqb2tlIC0g
d2l0aCBzb21lIGZvbGtzIEkgbmVlZCB0byBjbGFyaWZ5IHRoaXMuDQoNCg==

