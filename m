Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEEBC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 22:24:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFE8221734
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 22:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aM6RCEtf";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wPBQSb/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE8221734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJOo0-0008Ob-2O
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 18:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=52301f24b=Dmitry.Fomichev@wdc.com>)
 id 1kJOmD-00075n-JO; Fri, 18 Sep 2020 18:22:45 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:44788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=52301f24b=Dmitry.Fomichev@wdc.com>)
 id 1kJOmA-0000aa-5a; Fri, 18 Sep 2020 18:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600467762; x=1632003762;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Lssk3aCUfTCeGLoRTmHeI8TpkdEyFN61pI+CQnZsF7E=;
 b=aM6RCEtf8n9Lv6DgM35aOGvMvNutD3jkz+O+xKdZiIFbn6QcFGbuhbxi
 VkmPN8p1qUbLmM2nO//CJjEejN21gE66exj5yKa17HUm5oFb1/CO4pzT1
 EmRjwxAlvRSQectEaYP06o/Q7Y8FvMrfRdRRHc0BagX5oM7g31C766YGU
 ZMOor9B73jxZoPVUvr8H/mSfUyHjaXcxSV5DfzKsTIMlqh6txS1o330dR
 RkyI/K/S1Nsu+gN/WPfy6GrBF4fGbWLQ/tifPmQlZTcg5ieWiiNlIZD1E
 /9GaXhOCnJxPjlkUPl9s6eSNu6q7N6PZ4JXIehmRrteEJ4wLwG6bXTZdt g==;
IronPort-SDR: 6sqbdbWfn4lV1JXfh+NsimXlERw3ZC/juKssSK6i7wFiwGjTnWXM8kbtG11tRStZpfkzcYEuJX
 Q9NZbOuVS0OMbWAPU/7KIT2g8SY9+fY6bfBCglAUZ48e8RnaC5lr/cR1gBPxir8XpcpZYtSjhv
 lHktjVYRyDPs2bkGGcSUOzjpJTQTqZ3nQeJlU7VZMuROF0FZgEewP6KyhqDHB1wKYP2wk30x37
 xGLXYxMDIU/0akn3jfVhJs7lJOQpxlbvi4qdSX6a6/0Iwraz9cl4Ilc/26FyEDt48Ewbo1dseF
 Uq4=
X-IronPort-AV: E=Sophos;i="5.77,276,1596470400"; d="scan'208";a="152126797"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
 by ob1.hgst.iphmx.com with ESMTP; 19 Sep 2020 06:22:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRSazVAOMpB4kzlfSA5lMZbt8oxS0tzp88cs5wlT9unLoPFnHdLkAeHuhxnuIiMuychQ4OeNGnATT/iFPVplYjNxIGZHxO2S3ibxLpKVH5ZhsrIc/V6BmoUncxUuqvronkN2/Y/aurofDR6AUtBTXNAN0/l5QIBXybP7RCxz8EV2JBNZY8oH3RUS9jk5kZPMFhYDhreHVDmWJvKebsKIO6n9iLCpHWelHkFLdcmG2RcQCS7pLSJ9KZzRSUjx3+0/iHx7ceEhYrEQOdXQq2BBQrf3UbryroozOFIYkfe/r+H5m2/jOy9q9A84Ib9E9gNmKanTAW353pLw/Zn44VH4ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lssk3aCUfTCeGLoRTmHeI8TpkdEyFN61pI+CQnZsF7E=;
 b=a0zdSixwuvkKiqziE68c6eElc3CasrIJD/d4xKsr4CNo834IcBJaPP974gxakT5pzFDUpJn5xpoNYq0V4cUzqcxo51o8u4PGSLL+XODJiR8l1Sk9BqKiWPXQGT/no+fH2thACvdQogDDMwTe48dKoPWbfFs/ETIyZeqsCZzF91Cq3mtNEcWqh0m94JYulMPDLnsydsDkyIFf9UMnZLqTcEP4S5Qs1pdzJDc53CEa7+IkXId48+zUuT4pIDBQrl+chs6Hb2/Zb8MiOkHMQLUeZC8kmteFRhdSnzrZD0zUts9omXsKtwdX+8g0MKVL2BlH8T7rzw8QKKlFUxqk9mt/SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lssk3aCUfTCeGLoRTmHeI8TpkdEyFN61pI+CQnZsF7E=;
 b=wPBQSb/aENMbTkVxk0xljJ3CRJyyvqZPK9Q7n/vBAOKDdiaQUrrKBUDafaKJF7899xZpKq1b7kzrOaQ4VgXIyMFqIs/L2eoeSOJhgPNdKgKtKCJoHqJyE8alj/LCoavP9CPegoRGWEqi/dSQpnjtBD36uVomRBRIYbhZlwh7PXQ=
Received: from BN8PR04MB5940.namprd04.prod.outlook.com (2603:10b6:408:a9::22)
 by BN8PR04MB5937.namprd04.prod.outlook.com (2603:10b6:408:a3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Fri, 18 Sep
 2020 22:22:36 +0000
Received: from BN8PR04MB5940.namprd04.prod.outlook.com
 ([fe80::5103:df08:301a:5699]) by BN8PR04MB5940.namprd04.prod.outlook.com
 ([fe80::5103:df08:301a:5699%5]) with mapi id 15.20.3391.014; Fri, 18 Sep 2020
 22:22:36 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: RE: [PATCH v3 06/15] hw/block/nvme: Add support for Namespace Types
Thread-Topic: [PATCH v3 06/15] hw/block/nvme: Add support for Namespace Types
Thread-Index: AQHWihtS0pzKOd84qEqguQgi2Pya36lu8YGAgAAODgA=
Date: Fri, 18 Sep 2020 22:22:35 +0000
Message-ID: <BN8PR04MB59402EB22F8141707E3780BBE13F0@BN8PR04MB5940.namprd04.prod.outlook.com>
References: <20200913221436.22844-1-dmitry.fomichev@wdc.com>
 <20200913221436.22844-7-dmitry.fomichev@wdc.com>
 <20200918212959.GB581752@apples.localdomain>
In-Reply-To: <20200918212959.GB581752@apples.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 18cfc839-782d-4a9a-7a95-08d85c215875
x-ms-traffictypediagnostic: BN8PR04MB5937:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR04MB59377D3DC97BF1D8A809E765E13F0@BN8PR04MB5937.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pl7o+O8rR81PmStVYfjx/pbKy/1Fvr9tp6Ykj9wALSTlCgWeFt85v57UI6qVJpMKOCSOzKbLDNaxzYt77rCs/qZFUZiPX/Mblqe95vjV3SWWDQq4Dg5ytv7F6daZwCsJByGBE4dZALeSHYu2Mfp969OBG6kXJ18Xjle+/bW4+yDM2OZj2k2lSeZV1M0Ij3Y9zbzfnl5xhJFGQIkSlCXenMMyIn6AXjMVjDEFUIcpB+sX0tF79TrQtVSRmMC6PW+W2QEk6qHg+ww70ccSPu4IZ61lq3wY+nuocsx6b/NQlCKDXbva7uL5bU7G7a4pV6KV11/AJ9ibLnIyiQhkW63JdOJJCTKHjwFweert4M+eNt+fbdSh1SYCcPEBrsv22ALm
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR04MB5940.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(71200400001)(8936002)(83380400001)(316002)(8676002)(86362001)(186003)(26005)(478600001)(55016002)(6916009)(33656002)(9686003)(4326008)(52536014)(54906003)(66476007)(5660300002)(64756008)(66446008)(76116006)(66946007)(66556008)(6506007)(53546011)(7696005)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: B/EgiJmSU/fxDgP//CnnIcwHwXrS1pDmR6N9exR6oD4qwyI2MVUqlIzel/kcvIbzOcjN+xK9K2hy+tJPFfGox9vSsCpG+n/BZaDB0Vx5gmZOfbKqNgrBK4QOWWmyD0PEquNCdJrVmJjqZOsx8RMwnMlz9uO1qeHJ5DRQHZ9hnvHiILZsD8EcLDCczBoOzKGC93lbbUWNY/G5JymAgguM3nUfsV4PFAKEGlBlvweh4cWaLrhX3D6xHLDNc7JhUmgIQ+oQ4pvqclL4+XXqCkxAmuh2+sIARj1mlRIR2Id7BsBvlsx/4pty9VUlSqnkrevlDlPbKfZ7CJhnl9ofy4mSd3G6otL6UnvvYOQPtVKXjoNA/zwi6CjIYPnjZ27DyrcMS3DVHmGJpDpAxKCd6UtQLvNKqegDEmydFfzuTKEovXPPSO7q8Y2+L7AKLGRl21fF/GLMf6SPMk6GoDUkq2ykSomp+zr632WudYFpHH9x0oUhW4vuRR42OWfhTvCJBOgDmQcUKjEf6iWIPjczkXXzGsJIR8lwuk1ZXcLMViPFetkqec2BDFQ0uZ6OqHfLE6J79cYcR/hAd2YSBCBRg4VEPaQXOEInUx5cYOqIEQL0a+GoaEi1Ek67ddWgGCx8MVaDrhVssKSWLnKzi64GP+qzuQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR04MB5940.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18cfc839-782d-4a9a-7a95-08d85c215875
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2020 22:22:35.8386 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aZWTk6op5b7xQxVN8YK4Zao5wTmyHQ+6a1rwo2BVs+IjfrRbzST2RGbct0NvGrBFYUZnkjBsQEPgTh3Be8P16Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5937
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=52301f24b=Dmitry.Fomichev@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 18:22:39
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
cnJlbGV2YW50LmRrPg0KPiBTZW50OiBGcmlkYXksIFNlcHRlbWJlciAxOCwgMjAyMCA1OjMwIFBN
DQo+IFRvOiBEbWl0cnkgRm9taWNoZXYgPERtaXRyeS5Gb21pY2hldkB3ZGMuY29tPg0KPiBDYzog
S2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPjsgS2xhdXMgSmVuc2VuDQo+IDxrLmplbnNl
bkBzYW1zdW5nLmNvbT47IEtldmluIFdvbGYgPGt3b2xmQHJlZGhhdC5jb20+OyBQaGlsaXBwZQ0K
PiBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQHJlZGhhdC5jb20+OyBNYXhpbSBMZXZpdHNreQ0KPiA8
bWxldml0c2tAcmVkaGF0LmNvbT47IEZhbSBaaGVuZyA8ZmFtQGV1cGhvbi5uZXQ+OyBOaWtsYXMg
Q2Fzc2VsDQo+IDxOaWtsYXMuQ2Fzc2VsQHdkYy5jb20+OyBEYW1pZW4gTGUgTW9hbCA8RGFtaWVu
LkxlTW9hbEB3ZGMuY29tPjsNCj4gcWVtdS1ibG9ja0Bub25nbnUub3JnOyBxZW11LWRldmVsQG5v
bmdudS5vcmc7IEFsaXN0YWlyIEZyYW5jaXMNCj4gPEFsaXN0YWlyLkZyYW5jaXNAd2RjLmNvbT47
IE1hdGlhcyBCam9ybGluZyA8TWF0aWFzLkJqb3JsaW5nQHdkYy5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjMgMDYvMTVdIGh3L2Jsb2NrL252bWU6IEFkZCBzdXBwb3J0IGZvciBOYW1lc3Bh
Y2UNCj4gVHlwZXMNCj4gDQo+IE9uIFNlcCAxNCAwNzoxNCwgRG1pdHJ5IEZvbWljaGV2IHdyb3Rl
Og0KPiA+IEZyb206IE5pa2xhcyBDYXNzZWwgPG5pa2xhcy5jYXNzZWxAd2RjLmNvbT4NCj4gPg0K
PiA+IE5hbWVzcGFjZSBUeXBlcyBpbnRyb2R1Y2UgYSBuZXcgY29tbWFuZCBzZXQsICJJL08gQ29t
bWFuZCBTZXRzIiwNCj4gPiB0aGF0IGFsbG93cyB0aGUgaG9zdCB0byByZXRyaWV2ZSB0aGUgY29t
bWFuZCBzZXRzIGFzc29jaWF0ZWQgd2l0aA0KPiA+IGEgbmFtZXNwYWNlLiBJbnRyb2R1Y2Ugc3Vw
cG9ydCBmb3IgdGhlIGNvbW1hbmQgc2V0IGFuZCBlbmFibGUNCj4gPiBkZXRlY3Rpb24gZm9yIHRo
ZSBOVk0gQ29tbWFuZCBTZXQuDQo+ID4NCj4gPiBUaGUgbmV3IHdvcmtmbG93cyBmb3IgaWRlbnRp
ZnkgY29tbWFuZHMgcmVseSBoZWF2aWx5IG9uIHplcm8tZmlsbGVkDQo+ID4gaWRlbnRpZnkgc3Ry
dWN0cy4gRS5nLiwgY2VydGFpbiBDTlMgY29tbWFuZHMgYXJlIGRlZmluZWQgdG8gcmV0dXJuDQo+
ID4gYSB6ZXJvLWZpbGxlZCBpZGVudGlmeSBzdHJ1Y3Qgd2hlbiBhbiBpbmFjdGl2ZSBuYW1lc3Bh
Y2UgTlNJRA0KPiA+IGlzIHN1cHBsaWVkLg0KPiA+DQo+ID4gQWRkIGEgaGVscGVyIGZ1bmN0aW9u
IGluIG9yZGVyIHRvIGF2b2lkIGNvZGUgZHVwbGljYXRpb24gd2hlbg0KPiA+IHJlcG9ydGluZyB6
ZXJvLWZpbGxlZCBpZGVudGlmeSBzdHJ1Y3R1cmVzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
TmlrbGFzIENhc3NlbCA8bmlrbGFzLmNhc3NlbEB3ZGMuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IERtaXRyeSBGb21pY2hldiA8ZG1pdHJ5LmZvbWljaGV2QHdkYy5jb20+DQo+ID4gLS0tDQo+ID4g
IGh3L2Jsb2NrL252bWUuYyB8IDIzNQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIxNSBpbnNlcnRpb25zKCsp
LCAyMCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9ibG9jay9udm1lLmMg
Yi9ody9ibG9jay9udm1lLmMNCj4gPiBpbmRleCA0YmQ4OGY0MDQ2Li5kMDFjMWMxZTA2IDEwMDY0
NA0KPiA+IC0tLSBhL2h3L2Jsb2NrL252bWUuYw0KPiA+ICsrKyBiL2h3L2Jsb2NrL252bWUuYw0K
PiA+IEBAIC01OTUsNiArNTk1LDMzIEBAIHN0YXRpYyBpbmxpbmUgdWludDE2X3QNCj4gbnZtZV9j
aGVja19ib3VuZHMoTnZtZUN0cmwgKm4sIE52bWVOYW1lc3BhY2UgKm5zLA0KPiA+ICAgICAgcmV0
dXJuIE5WTUVfU1VDQ0VTUzsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyB2b2lkIG52bWVfZmls
bF9kYXRhKFFFTVVTR0xpc3QgKnFzZywgUUVNVUlPVmVjdG9yICppb3YsDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90IG9mZnNldCwgdWludDhfdCBwYXR0ZXJuKQ0KPiA+
ICt7DQo+ID4gKyAgICBTY2F0dGVyR2F0aGVyRW50cnkgKmVudHJ5Ow0KPiA+ICsgICAgdWludDMy
X3QgbGVuLCBlbnRfbGVuOw0KPiA+ICsNCj4gPiArICAgIGlmIChxc2ctPm5zZyA+IDApIHsNCj4g
PiArICAgICAgICBlbnRyeSA9IHFzZy0+c2c7DQo+ID4gKyAgICAgICAgZm9yIChsZW4gPSBxc2ct
PnNpemU7IGxlbiA+IDA7IGxlbiAtPSBlbnRfbGVuKSB7DQo+ID4gKyAgICAgICAgICAgIGVudF9s
ZW4gPSBNSU4obGVuLCBlbnRyeS0+bGVuKTsNCj4gPiArICAgICAgICAgICAgaWYgKG9mZnNldCA+
IGVudF9sZW4pIHsNCj4gPiArICAgICAgICAgICAgICAgIG9mZnNldCAtPSBlbnRfbGVuOw0KPiA+
ICsgICAgICAgICAgICB9IGVsc2UgaWYgKG9mZnNldCAhPSAwKSB7DQo+ID4gKyAgICAgICAgICAg
ICAgICBkbWFfbWVtb3J5X3NldChxc2ctPmFzLCBlbnRyeS0+YmFzZSArIG9mZnNldCwNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBhdHRlcm4sIGVudF9sZW4gLSBvZmZzZXQp
Ow0KPiA+ICsgICAgICAgICAgICAgICAgb2Zmc2V0ID0gMDsNCj4gPiArICAgICAgICAgICAgfSBl
bHNlIHsNCj4gPiArICAgICAgICAgICAgICAgIGRtYV9tZW1vcnlfc2V0KHFzZy0+YXMsIGVudHJ5
LT5iYXNlLCBwYXR0ZXJuLCBlbnRfbGVuKTsNCj4gPiArICAgICAgICAgICAgfQ0KPiA+ICsgICAg
ICAgICAgICBlbnRyeSsrOw0KPiA+ICsgICAgICAgIH0NCj4gPiArICAgIH0gZWxzZSBpZiAoaW92
LT5pb3YpIHsNCj4gPiArICAgICAgICBxZW11X2lvdmVjX21lbXNldChpb3YsIG9mZnNldCwgcGF0
dGVybiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICBpb3Zfc2l6ZShpb3YtPmlvdiwg
aW92LT5uaW92KSAtIG9mZnNldCk7DQo+ID4gKyAgICB9DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0
YXRpYyB2b2lkIG52bWVfcndfY2Iodm9pZCAqb3BhcXVlLCBpbnQgcmV0KQ0KPiA+ICB7DQo+ID4g
ICAgICBOdm1lUmVxdWVzdCAqcmVxID0gb3BhcXVlOw0KPiA+IEBAIC0xMTUzLDYgKzExODAsMTkg
QEAgc3RhdGljIHVpbnQxNl90IG52bWVfY3JlYXRlX2NxKE52bWVDdHJsICpuLA0KPiBOdm1lUmVx
dWVzdCAqcmVxKQ0KPiA+ICAgICAgcmV0dXJuIE5WTUVfU1VDQ0VTUzsNCj4gPiAgfQ0KPiA+DQo+
ID4gK3N0YXRpYyB1aW50MTZfdCBudm1lX3JwdF9lbXB0eV9pZF9zdHJ1Y3QoTnZtZUN0cmwgKm4s
IHVpbnQ2NF90IHBycDEsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdWludDY0X3QgcHJwMiwgTnZtZVJlcXVlc3QgKnJlcSkNCj4gPiArew0KPiA+ICsgICAg
dWludDE2X3Qgc3RhdHVzOw0KPiA+ICsNCj4gPiArICAgIHN0YXR1cyA9IG52bWVfbWFwX3BycChu
LCBwcnAxLCBwcnAyLCBOVk1FX0lERU5USUZZX0RBVEFfU0laRSwNCj4gcmVxKTsNCj4gPiArICAg
IGlmIChzdGF0dXMpIHsNCj4gPiArICAgICAgICByZXR1cm4gc3RhdHVzOw0KPiA+ICsgICAgfQ0K
PiA+ICsgICAgbnZtZV9maWxsX2RhdGEoJnJlcS0+cXNnLCAmcmVxLT5pb3YsIDAsIDApOw0KPiA+
ICsgICAgcmV0dXJuIE5WTUVfU1VDQ0VTUzsNCj4gPiArfQ0KPiA+ICsNCj4gDQo+IEluc3RlYWQg
b2YgZG9pbmcgdGhlIGZpbGxpbmcsIHdoeSBub3QganVzdCBkaXJlY3RseSBjYWxsIG52bWVfZG1h
X3BycA0KPiB3aXRoIGFuIGVtcHR5IE52bWVJZEN0cmwvTnZtZUlkTnMgc3RhY2sgYWxsb2NhdGVk
IHZhcmlhYmxlPw0KDQpZZXMsIHRoaXMgc2hvdWxkIHdvcmsgdG9vLCBwZXJoYXBzIGl0IHdpbGwg
YmUgc2ltcGxlci4NCg==

