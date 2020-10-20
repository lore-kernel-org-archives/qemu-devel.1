Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2D1C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 23:11:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E84A6223C6
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 23:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pxNsh6+c";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="G+tnrvjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84A6223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV0mj-0006Hi-VZ
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 19:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=55587455e=Dmitry.Fomichev@wdc.com>)
 id 1kV0lN-0005Wi-8d; Tue, 20 Oct 2020 19:09:53 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:24603)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=55587455e=Dmitry.Fomichev@wdc.com>)
 id 1kV0lL-0000hd-25; Tue, 20 Oct 2020 19:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603235390; x=1634771390;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ad5EFS/rdV2fYvBSx9I/FW7J3644HDWLSnrrIFd6VlY=;
 b=pxNsh6+cxB6f4NUQS+s7Te8muB/+/d2Qq5PBHkVEIkjgH1FbDwlc4BHZ
 j3DdEQqy1JmGzgByUcTI1XhG5ZFpESQfEu7RGK35QZZv/eJ196L9m/V3l
 bUZHC8mp6/tIFdvQrZbwGlI2bvY2jeR8ADqAiEsh6qO2hiodecgIg0uDI
 YHOysZtMfs4J0eRUkJ4jj8xdpZ4b4fxV+ukLV7MHMeDjdIP5mXiLSNL17
 1Q0ziHy7u0f8hDeDEaHf/pO20gvIvdcP9nD+/pXxcZe2OjZAmunRNedkH
 WOmDQK81Wy9T5nNtTF17x6dfXcwApGcc5naKex6UgsWqUZNeDttNCSF6r A==;
IronPort-SDR: r+ZZUHbTisbssJ7G+DyZfTW/5rxcqqsXrCsaRRiOSihDbuo7lZ9jRBt2DMQw8k4vmOHO26ah5I
 uYAjWpBHBGw8bnKrGDCwO5IPRYSdrS57XbhADyMad9iCh5owK9W0Qcx7sTO59d+bfRpn8BL0wl
 w8FIh3GUVwYczbWkWBTcijPX0m5RrlO43M0O/wvKToLIcY+IUwGjlLLh2ICnRP38RepBlLYY1x
 345ghi0DlxLvblwqk/ghiuRrk8sZrG1BqnWzXbWSmKGtNLdJdcWynlVw/c+gDhwQB926RNDfA1
 qw0=
X-IronPort-AV: E=Sophos;i="5.77,399,1596470400"; d="scan'208";a="150384876"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
 by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2020 07:09:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJWAnAEUrOzQGaux0Ix9hb5NFnIV5NvnsAO0D0zUXJ5n8hoZ/aXgWs3FHcYvtFEekmau0a/E0d5jW1ChPiefqa+NILD1Z9nMIA/wnAF3/KM0r5DjtM+rVtONDTNcm7DeTOhejbg/moSMgCJ0IFfEjOJLxZIwiZmecHuDTa1OjZOhBqXfikEah3rTjvRlIVHYKlCQ+Rr3wFxSy15tm5wewIGXBB2RT0k2AqsiWW+ewsKsoPWMyeVbiqYyjxDr0OAgGBD4p7UvrmVF3Ukju/bi8MP6pwawULhRZX1D68ztfcVQHtAt+ZsdcPr/niT+4ofxFK2bY0mHlF6WNgBu7RyoOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ad5EFS/rdV2fYvBSx9I/FW7J3644HDWLSnrrIFd6VlY=;
 b=Xq3vDbtITgZ4ovtAKZk9a5eK1mDbSqka/sVUHJlEXlzRzF3DUgTazKoTdNflx2PVY4/r6H9IKw6EC1D/Opo3Km4LC29uY11Y4uxoxsR576ah7GA+epIqr3pPbK37WmNro6XTE/UbU+MmAtIrfNmmk10K1yI2OBcq3kHYQbsTo5GXERnF3HnJlUUzAF3fdfsM6D1ghC+JPKbCCE/gviaCulug4yOP4YGBLSK7IYqagtWocLADYfmam8++LSivrm8nhludoVVGbTLcxx4pZTvICKHB/AkZwwOHD6xpVY9AgxU1qya1srRp5QVvQMOxfESlQ19H6KU/1RvHXWpBFmT80w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ad5EFS/rdV2fYvBSx9I/FW7J3644HDWLSnrrIFd6VlY=;
 b=G+tnrvjc9QBKG/oMJ1c3OSNBxvFHtSt6OoBhE2F3kGmuP1NP6CY2QABMpC0SzzWBARhnfs1Gv6KFx/PzV94NZZWxwNG1TaKzlXu39ZO94Eil8uMQMFw1YR0qNGM2NGid/wRbn4h0vZAKKRnAaRtzIbqEUOgauDmNI9pL/44UODM=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5551.namprd04.prod.outlook.com (2603:10b6:208:e3::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Tue, 20 Oct
 2020 23:09:46 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44c9:85df:4910:44d8]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44c9:85df:4910:44d8%4]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 23:09:45 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: RE: [PATCH v7 04/11] hw/block/nvme: Support allocated CNS command
 variants
Thread-Topic: [PATCH v7 04/11] hw/block/nvme: Support allocated CNS command
 variants
Thread-Index: AQHWpb4K2kbgJdpEEkuKDDYHHB6jr6mgKHsAgACf1JA=
Date: Tue, 20 Oct 2020 23:09:45 +0000
Message-ID: <MN2PR04MB5951F890FA3046A4E91B2005E11F0@MN2PR04MB5951.namprd04.prod.outlook.com>
References: <20201019021726.12048-1-dmitry.fomichev@wdc.com>
 <20201019021726.12048-5-dmitry.fomichev@wdc.com>
 <20201020082118.GA178548@apples.localdomain>
In-Reply-To: <20201020082118.GA178548@apples.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0065194a-6946-4f7f-d929-08d8754d3bfd
x-ms-traffictypediagnostic: MN2PR04MB5551:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB55512E65424222C1570CDA24E11F0@MN2PR04MB5551.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r7WwcHHL+iRBU9FDF4KgdSttYdkfhHOlJSTTdDbne0K0OfQhMYyv25+HmFWnL1lKxQPgqalIfILURQFn78fT902VSFZasW4Hp5woi3xB7EKe8P36QyMiYqupWcU3vt/qTjXLq2HvaG5V/aVRo+ag9hW4cd4s3bkpBeQHBoY+kwMmH1AHqOzhj9mTy4ikj5cj5/SpS4qiqQZYMLCdBjsSrYrl4svebUjk1EHG2k2JoVusDFWgBqMQf+/WgHlO0+WwuiEQOF+cyctCT8RuuzjSiEPW0VD95ezMZvxMuNAb+cHKubTiXCZ0P8PwC77r3GO61dmATSjAkBgzibmqLndLQQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(346002)(376002)(39850400004)(26005)(33656002)(2906002)(55016002)(478600001)(83380400001)(8676002)(4326008)(6506007)(64756008)(8936002)(66946007)(9686003)(76116006)(5660300002)(7696005)(86362001)(53546011)(66446008)(71200400001)(6916009)(316002)(186003)(52536014)(66476007)(54906003)(66556008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: L8Ow9EPgiPw0ji0Awj8pxpM9CgJS3wNnQCN9cFVZgUJJ8GA+jJ6TfhAIJrX8NgqO7DqS3UxO9SqLF/7S2Q6Bntm7a4GhnDAZlD1mYl51j9gvWD20XN10K1iW99T23Dc6jTr2eJfswpbvbWPQOpzzwHx2s+kHgnstQTrBFS+GwL5VCzUxq3DzfPPV55BhmpYpgipPo/UidGYLvPFRMbDYs/NCQeCVF8GwN98gZX/Xk05UXsvB2jYDz5sv7Tz/eFwpqp8MKjYTA6/Xx9ZIvc5efNTg4gwO6BD5E3inOfgYYuJmqjLxdNXEi/KxIPPEJEqhkk9jzBrkv1IudUe/tevw/Kfj7ogbjmJUFnIivo2c10W7RJFQOJqhJK6KCWIz6h70Mg4F15mYWWLUkkjldZpS1vZ1RNjqxPtFh4tpVxD9m5ytM9M/Y0mLzCRjQ+z68FWPItOf+y2S3abdhCuM95U+7L/abslUWQ+1sj4iesmbyKTE8uFPzHYE11csmJbMGoo/Sj+ADFxVmeDIS3Rp6eYkZlug+h//yPJbK8sR7BPSajPRqXw8fq8jDgzaS6qhVGSiaNVaynJuKgodTu9axX4II6UjnYW6EtoU5hV2NKP3OFuWFtG5RDrRQiGGsqCAYFBKIQJUg3KKKYYI6PnVFKLuOQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0065194a-6946-4f7f-d929-08d8754d3bfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2020 23:09:45.0799 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BTlMmUGE6y8q7TByPT4qpBlSSEtqnzYOnsuXG93pXtfj05Y7CCiIB63a0PHqi0T11haRNdLF8gckeJ8VEtu+rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5551
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=55587455e=Dmitry.Fomichev@wdc.com; helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 19:09:48
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
cnJlbGV2YW50LmRrPg0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDIwLCAyMDIwIDQ6MjEgQU0N
Cj4gVG86IERtaXRyeSBGb21pY2hldiA8RG1pdHJ5LkZvbWljaGV2QHdkYy5jb20+DQo+IENjOiBL
ZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+OyBLbGF1cyBKZW5zZW4NCj4gPGsuamVuc2Vu
QHNhbXN1bmcuY29tPjsgS2V2aW4gV29sZiA8a3dvbGZAcmVkaGF0LmNvbT47IFBoaWxpcHBlDQo+
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT47IE1heGltIExldml0c2t5DQo+IDxt
bGV2aXRza0ByZWRoYXQuY29tPjsgRmFtIFpoZW5nIDxmYW1AZXVwaG9uLm5ldD47IE5pa2xhcyBD
YXNzZWwNCj4gPE5pa2xhcy5DYXNzZWxAd2RjLmNvbT47IERhbWllbiBMZSBNb2FsIDxEYW1pZW4u
TGVNb2FsQHdkYy5jb20+Ow0KPiBxZW11LWJsb2NrQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9u
Z251Lm9yZzsgQWxpc3RhaXIgRnJhbmNpcw0KPiA8QWxpc3RhaXIuRnJhbmNpc0B3ZGMuY29tPjsg
TWF0aWFzIEJqb3JsaW5nIDxNYXRpYXMuQmpvcmxpbmdAd2RjLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2NyAwNC8xMV0gaHcvYmxvY2svbnZtZTogU3VwcG9ydCBhbGxvY2F0ZWQgQ05TDQo+
IGNvbW1hbmQgdmFyaWFudHMNCj4gDQo+IE9uIE9jdCAxOSAxMToxNywgRG1pdHJ5IEZvbWljaGV2
IHdyb3RlOg0KPiANCj4gKHNuaXApDQo+IA0KPiA+IENBUC5DU1MgKHRvZ2V0aGVyIHdpdGggdGhl
IEkvTyBDb21tYW5kIFNldCBkYXRhIHN0cnVjdHVyZSkgZGVmaW5lcw0KPiA+IHdoYXQgY29tbWFu
ZCBzZXRzIGFyZSBzdXBwb3J0ZWQgYnkgdGhlIGNvbnRyb2xsZXIuDQo+ID4NCj4gPiBDQy5DU1Mg
KHRvZ2V0aGVyIHdpdGggU2V0IFByb2ZpbGUpIGNhbiBiZSBzZXQgdG8gZW5hYmxlIGEgc3Vic2V0
IG9mDQo+ID4gdGhlIGF2YWlsYWJsZSBjb21tYW5kIHNldHMuDQo+ID4NCj4gPiBFdmVuIGlmIGEg
dXNlciBjb25maWd1cmVzIENDLkNTUyB0byBlLmcuIEFkbWluIG9ubHksIE5WTSBuYW1lc3BhY2Vz
DQo+ID4gd2lsbCBzdGlsbCBiZSBhdHRhY2hlZCAoYW5kIHRodXMgbWFya2VkIGFzIGFjdGl2ZSku
DQo+ID4gU2ltaWxhcmx5LCBpZiBhIHVzZXIgY29uZmlndXJlcyBDQy5DU1MgdG8gZS5nLiBOVk0s
IFpOUyBuYW1lc3BhY2VzDQo+ID4gd2lsbCBzdGlsbCBiZSBhdHRhY2hlZCAoYW5kIHRodXMgbWFy
a2VkIGFzIGFjdGl2ZSkuDQo+ID4NCj4gPiBIb3dldmVyLCBhbnkgb3BlcmF0aW9uIGZyb20gYSBk
aXNhYmxlZCBjb21tYW5kIHNldCB3aWxsIHJlc3VsdCBpbiBhDQo+ID4gSW52YWxpZCBDb21tYW5k
IE9wY29kZS4NCj4gPg0KPiANCj4gVGhpcyBwYXJ0IG9mIHRoZSBjb21taXQgbWVzc2FnZSBzZWVt
cyBpcnJlbGV2YW50IHRvIHRoZSBwYXRjaC4NCj4gDQo+ID4gQWRkIGEgbmV3IEJvb2xlYW4gbmFt
ZXNwYWNlIHByb3BlcnR5LCAiYXR0YWNoZWQiLCB0byBwcm92aWRlIHRoZSBtb3N0DQo+ID4gYmFz
aWMgbmFtZXNwYWNlIGF0dGFjaG1lbnQgc3VwcG9ydC4gVGhlIGRlZmF1bHQgdmFsdWUgZm9yIHRo
aXMgbmV3DQo+ID4gcHJvcGVydHkgaXMgdHJ1ZS4gQWxzbywgaW1wbGVtZW50IHRoZSBsb2dpYyBp
biB0aGUgbmV3IENOUyB2YWx1ZXMgdG8NCj4gPiBpbmNsdWRlL2V4Y2x1ZGUgbmFtZXNwYWNlcyBi
YXNlZCBvbiB0aGlzIG5ldyBwcm9wZXJ0eS4gVGhlIG9ubHkgdGhpbmcNCj4gPiBtaXNzaW5nIGlz
IGhvb2tpbmcgdXAgdGhlIGFjdHVhbCBOYW1lc3BhY2UgQXR0YWNobWVudCBjb21tYW5kIG9wY29k
ZSwNCj4gPiB3aGljaCB3aWxsIGFsbG93IGEgdXNlciB0byB0b2dnbGUgdGhlICJhdHRhY2hlZCIg
ZmxhZyBwZXIgbmFtZXNwYWNlLg0KPiA+DQo+IA0KPiBXaXRob3V0IE5hbWVzcGFjZSBBdHRhY2ht
ZW50IHN1cHBvcnQsIHRoZSBzb2xlIHB1cnBvc2Ugb2YgdGhpcw0KPiBwYXJhbWV0ZXINCj4gaXMg
dG8gYWxsb3cgdW51c2FibGUgbmFtZXNwYWNlIElEcyB0byBiZSByZXBvcnRlZC4gSSBoYXZlIG5v
IHByb2JsZW1zDQo+IHdpdGggYWRkaW5nIHN1cHBvcnQgZm9yIHRoZSBhZGRpdGlvbmFsIENOUyB2
YWx1ZXMuIFRoZXkgd2lsbCByZXR1cm4NCj4gaWRlbnRpY2FsIHJlc3BvbnNlcywgYnV0IEkgdGhp
bmsgdGhhdCBpcyBnb29kIGVub3VnaCBmb3Igbm93Lg0KPiANCj4gV2hlbiBpdCBpcyBub3QgcmVh
bGx5IG5lZWRlZCwgd2Ugc2hvdWxkIGJlIHdhcnkgb2YgYWRkaW5nIGEgcGFyYW1ldGVyDQo+IHRo
YXQgaXMgcmVhbGx5IGhhcmQgdG8gZ2V0IHJpZCBvZiBhZ2Fpbi4NCj4gDQo+ID4gVGhlIHJlYXNv
biBmb3Igbm90IGhvb2tpbmcgdXAgdGhpcyBjb21tYW5kIGNvbXBsZXRlbHkgaXMgYmVjYXVzZSB0
aGUNCj4gPiBOVk1lIHNwZWNpZmljYXRpb24gcmVxdWlyZXMgdGhlIG5hbWVzcGFjZSBtYW5hZ2Vt
ZW50IGNvbW1hbmQgdG8gYmUNCj4gPiBzdXBwb3J0ZWQgaWYgdGhlIG5hbWVzcGFjZSBhdHRhY2ht
ZW50IGNvbW1hbmQgaXMgc3VwcG9ydGVkLg0KPiA+DQo+IA0KPiBUaGVyZSBhcmUgbWFueSB3YXlz
IHRvIHN1cHBvcnQgTmFtZXNwYWNlIE1hbmFnZW1lbnQsIGFuZCB0aGVyZSBhcmUgYQ0KPiBsb3QN
Cj4gb2YgcXVpcmtzIHdpdGggZWFjaCBvZiB0aGVtLiBEbyB3ZSB1c2UgYSBiaWcgYmxvY2tkZXYg
YW5kIGNhcnZlIG91dA0KPiBuYW1lc3BhY2VzPyBUaGVuLCB3aGF0IGFyZSB0aGUgc2VtYW50aWNz
IG9mIGFuIGltYWdlIHJlc2l6ZSBvcGVyYXRpb24/DQo+IA0KPiBEbyB3ZSBkeW5hbWljYWxseSBj
cmVhdGUgYmxvY2tkZXYgZGV2aWNlcyAtIHRoYXRzIHNvdW5kcyBwcmV0dHkgbmljZSwNCj4gYnV0
IG1pZ2h0IGhhdmUgb3RoZXIgcXVpcmtzIGFuZCB0aGUgYXR0YWNobWVudCBpcyBub3QgcmVhbGx5
IHBlcnNpc3RlbnQuDQo+IA0KPiBJIHRoaW5rIGF0IGxlYXN0IHRoZSAiYXR0YWNoZWQiIHBhcmFt
ZXRlciBzaG91bGQgYmUgeC1wcmVmaXhlZCwgYnV0DQo+IGJldHRlciwgbGVhdmUgaXQgb3V0IGZv
ciBub3cgdW50aWwgd2Uga25vdyBob3cgd2Ugd2FudCBOYW1lc3BhY2UNCj4gQXR0YWNobWVudCBh
bmQgTWFuYWdlbWVudCB0byBiZSBpbXBsZW1lbnRlZC4NCg0KSSBkb24ndCBtaW5kIGxlYXZpbmcg
dGhpcyBwcm9wZXJ0eSBvdXQuIEkgdXNlZCBpdCBmb3IgdGVzdGluZyB0aGUgcGF0Y2ggYW5kIGl0
DQpjb3VsZCwgaW4gdGhlb3J5LCBiZSBtYW5pcHVsYXRlZCBieSBhbiBleHRlcm5hbCBwcm9jZXNz
IGRvaW5nIE5TDQpNYW5hZ2VtZW50LCBidXQsIGFzIHlvdSBzYWlkLCB0aGVyZSBpcyBubyBjZXJ0
YWludHkgYWJvdXQgbm93IE5TDQpNYW5hZ2VtZW50IHdpbGwgYmUgaW1wbGVtZW50ZWQgYW5kIGFu
eSByZWxhdGVkIENMSSBpbnRlcmZhY2Ugc2hvdWxkDQpiZXR0ZXIgYmUgYWRkZWQgYXMgYSBwYXJ0
IG9mIHRoaXMgZnV0dXJlIHdvcmssIG5vdCBub3cuDQoNCg0K

