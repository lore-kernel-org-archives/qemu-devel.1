Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199C1C2D0E0
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 18:59:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7E820720
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 18:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bBdqm9LT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="t87+RE2r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7E820720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIGAn-00023X-LO
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 14:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=520035bb9=Dmitry.Fomichev@wdc.com>)
 id 1kIG9N-00013y-7S; Tue, 15 Sep 2020 14:57:57 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:52118)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=520035bb9=Dmitry.Fomichev@wdc.com>)
 id 1kIG9K-0008Eu-3C; Tue, 15 Sep 2020 14:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600196288; x=1631732288;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mOuZHmdXyrdCYMjJPZbKf3J3i/8NBCPiXgc4bER6P/w=;
 b=bBdqm9LTseafooUS0riGMlw3I2Wx03F02pVARFnc8Uxmcs76dx8yCbCF
 Gq8XenEqqWZxhWYX70TbPQj2MUfN3jmoQSqKaTDidNpUqU7HZWU2f8oVL
 zG2mDmtxnZWq3OHq5SAs6q1Kqx9aw6fp4XaJbXJAT+xrYUi49l1Y0x2xa
 oRdWjLAa6OvLNKQnWW72KmBbxIEclzKDypGnAxpuMQhHFfOxaEPdJ+NQ1
 Q8KN9MhiYt4rcVlRU6rUvkyN3oNCFNwKvE3qzR2lO+eHEjto0DN4lmSs2
 L5vcKwyr/cyOtj3NkmrTxUTZD9VQ5AJHeJz6wdLJhuT2jyul28pRa2UFO w==;
IronPort-SDR: gzrkzocw8QwYTqTAAQN5Oo6awCh21PW0DaQ8F18EjeekY4yguF8KJpHnGlbsCWsejdI03gCvm/
 daop1tpTmUoT72/EccYttrZzdr9RqR+gw1mj4cjfkQltL3T40XSbrdwpA3fCiVC3Xob1/bjci9
 kzKN/rHIiKXVVAX7pxGTfpljuGL7w7TvaPMzz9U6nw8sBCP6TLvjrK8GGmr8xju1HfnhXhWmmS
 3iHY42/1LWJT1uhnh82fJnF1BhZF89yfEszEp/x/zzB0mrw6jb8GgK0aATRxpp6MZABCd+2cMT
 dZM=
X-IronPort-AV: E=Sophos;i="5.76,430,1592841600"; d="scan'208";a="250781120"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
 by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2020 02:58:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWhzopddr9wctA4gf3LhIuJrEmn4mUlYmxxaZwHM5Aen2GwLNPfuxVdQlrjjLtLlJiZRhf/3ePmh9xeL+gaRKOMHNTlI5TiWXzkF5aEN9cbmHSCenutt/nba1SubSO2BTwr5bevRbYRu67EVkxRg5mI9ZkUN1oYHXtSf2ZJdXPwmLmur/Q5tzM1Bn8deWSSyR2+DQvzhaX0j2OqXJKfUz6mtRk8FHfP9uHb7M07XE+NS1ivayEq/eOQpEmLn3aK3whvmbddJfWbfkIGMuBFUg0PzxZrk0AxE/XsHrnXo7XArXC1Jkdv+MwbO+DOnXHzL/U0CazdikKu/OV2abXITOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOuZHmdXyrdCYMjJPZbKf3J3i/8NBCPiXgc4bER6P/w=;
 b=MJ+BB7nAxjUTieVcdOaKUvk0cIHmezdonxe4KZCueINDtkujr0rrRbIGKGuacjLTWqEIA/RhDNGMsrIqg+LvbIQqOhPgMqwXUu0HiEFN8dMigUmwT4HtWCS7wF0lGkgoNWxZ7S+YRDb6Gre0khqfERmyoU8io0cY8/bDieNB1hcRnM8JAXDi2FWO3AgFdgiIV+vWvKu9RKtqj5dRPN1tRPwSNVvswrIa1amHtnRW2q2ofrFLbnesYq8dxcBdmNb3JJUbktMXr1Hkpc/E4bGOpaEe2d/zZPtMUX7r7HdsxBAQJDJS2AUyZb1LQUqNPz5TeZjv6xx8L2KrUJ7JKXSsNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOuZHmdXyrdCYMjJPZbKf3J3i/8NBCPiXgc4bER6P/w=;
 b=t87+RE2r0I/hmgv19OujGgtvRRJXGqAXsMqQlrEyaOlTFq49wNvmYzLuPj+WNYvXckV784bKexldLP8K18tqnxlbiDb7Cbh6EgOG3X2+cMCKvWF+efl48ZbxsKWD2THZNvnB6XV3QD80oVFOa8XR490JWwkRIfUXvPVaQ9R4CA0=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB6253.namprd04.prod.outlook.com (2603:10b6:208:d9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Tue, 15 Sep
 2020 18:57:49 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94%6]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 18:57:49 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: RE: [PATCH v3 02/15] hw/block/nvme: Report actual LBA data shift in
 LBAF
Thread-Topic: [PATCH v3 02/15] hw/block/nvme: Report actual LBA data shift in
 LBAF
Thread-Index: AQHWihtOZT645M4IFUCMbhLpxZlonKlpUQqAgAC2XNA=
Date: Tue, 15 Sep 2020 18:57:49 +0000
Message-ID: <MN2PR04MB595149E6ED89CB2EBEBF33B7E1200@MN2PR04MB5951.namprd04.prod.outlook.com>
References: <20200913221436.22844-1-dmitry.fomichev@wdc.com>
 <20200913221436.22844-3-dmitry.fomichev@wdc.com>
 <20200915073421.GA499689@apples.localdomain>
In-Reply-To: <20200915073421.GA499689@apples.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 08dad005-ec04-4b00-ab1e-08d859a93df2
x-ms-traffictypediagnostic: MN2PR04MB6253:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6253471E5B84A51881E48D2DE1200@MN2PR04MB6253.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5MkHW8zoxBS1GHVrafMKc0aWOrztngq5ea0J/n9Oq6+BdS9hUxnuo7d5RnUHWGL6x0Lm1eyFCJlaedf94yZxGJE8RZGY4YBoWE3UGLDwce+nsDivd7qGND719NxcjnU8eYwy8QG0XGXbeZYd0dgeTv7RW7ZeT3MdTxWIRAga6c4Qly+so9YpAD4NlBjIp7l1FPPD6UJl9mC6uvwL+kARU9I/c4b88rgekikVVoCJsfwdd1Br6NFCvxXGQd+midaI9skRKEJo572aJd8qDeW3jMZpTx2Wpkj5zmO4eQx/Vjgq9k6TWFsiO7oOtsJtdVc6lNz45O919FhazC2BP/Vnsg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(54906003)(316002)(86362001)(7696005)(186003)(8676002)(33656002)(8936002)(83380400001)(55016002)(2906002)(52536014)(76116006)(5660300002)(9686003)(66946007)(6506007)(6916009)(66446008)(64756008)(26005)(71200400001)(53546011)(66556008)(4326008)(66476007)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 4aDucPRerUW1o1ZsHFhFyk7gnPEHgPzBqb1vtIharzm+uQPq3f0WIJXSUJrFHr8t0A6g+fhXUwUxVc1TQQEwHfR5x7LHWi7MQXCrFEFrx0v8krk1dfP6JcI+PjZSxtckwHXhnMhDL6R+eT1P+vlaT67K/VKnmYT9z6CCw9BA2zrD2upRje9BfykBhBnw7Ifgr/eNL+JN6hDKuAJViH/JodWRiw54pRKdJ1SxPVtdsNr66nlUz0jhc7Pq5HDfg7Ff6DRKvyIub0brDF/LlHbuYKYMKB+3F6y1LiZAqXRBoe3QieSOMYPwu9kxTklXi4iSbX/tAB0LC1xhZxjrq6cupkyaVEnC7mFOBr6995i3Pj/rZCPwHQNwl9MuWFodM6n/BjrSpdeRtBKaHfoCmyKoV25AkR48mRSpN95xwIEFIidM5UsAr+wesNm/bcgUIArvrVzzG2RAEzLS1YORVzLNhbvg6QWLhdddEs3pVs4+kdh0cVp418msxxWqVBMHDwKyb6eBVek5gi5XkHgxvw+aScgYO5sncw98imq5vecwqGU4gTo98E0OAYhEzgC95S/15cLtInA6w4madeWD+tDyxkUgYmvYM3RYEVLp0EopV2+2sNQd3h4EW+8ry9uKWKk6HhL5yGTF+z7B8eSqOdf2JQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08dad005-ec04-4b00-ab1e-08d859a93df2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 18:57:49.5634 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0N4ls4GbMiILD8TjrN9EE5aKCNEedQkQ4U0P52pnqxmEQ1xj557Z0EHoWc2DXY/qsAa8EFW0TSQcCok6r+pkUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6253
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=520035bb9=Dmitry.Fomichev@wdc.com; helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 14:57:52
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
cnJlbGV2YW50LmRrPg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMTUsIDIwMjAgMzozNCBB
TQ0KPiBUbzogRG1pdHJ5IEZvbWljaGV2IDxEbWl0cnkuRm9taWNoZXZAd2RjLmNvbT4NCj4gQ2M6
IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz47IEtsYXVzIEplbnNlbg0KPiA8ay5qZW5z
ZW5Ac2Ftc3VuZy5jb20+OyBLZXZpbiBXb2xmIDxrd29sZkByZWRoYXQuY29tPjsgUGhpbGlwcGUN
Cj4gTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPjsgTWF4aW0gTGV2aXRza3kNCj4g
PG1sZXZpdHNrQHJlZGhhdC5jb20+OyBGYW0gWmhlbmcgPGZhbUBldXBob24ubmV0PjsgTmlrbGFz
IENhc3NlbA0KPiA8TmlrbGFzLkNhc3NlbEB3ZGMuY29tPjsgRGFtaWVuIExlIE1vYWwgPERhbWll
bi5MZU1vYWxAd2RjLmNvbT47DQo+IHFlbXUtYmxvY2tAbm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBu
b25nbnUub3JnOyBBbGlzdGFpciBGcmFuY2lzDQo+IDxBbGlzdGFpci5GcmFuY2lzQHdkYy5jb20+
OyBNYXRpYXMgQmpvcmxpbmcgPE1hdGlhcy5Cam9ybGluZ0B3ZGMuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYzIDAyLzE1XSBody9ibG9jay9udm1lOiBSZXBvcnQgYWN0dWFsIExCQSBkYXRh
IHNoaWZ0IGluDQo+IExCQUYNCj4gDQo+IE9uIFNlcCAxNCAwNzoxNCwgRG1pdHJ5IEZvbWljaGV2
IHdyb3RlOg0KPiA+IENhbGN1bGF0ZSB0aGUgZGF0YSBzaGlmdCB2YWx1ZSB0byByZXBvcnQgYmFz
ZWQgb24gdGhlIHNldCB2YWx1ZSBvZg0KPiA+IGxvZ2ljYWxfYmxvY2tfc2l6ZSBkZXZpY2UgcHJv
cGVydHkuDQo+ID4NCj4gPiBJbiB0aGUgcHJvY2VzcywgdXNlIGEgbG9jYWwgdmFyaWFibGUgdG8g
Y2FsY3VsYXRlIHRoZSBMQkEgZm9ybWF0DQo+ID4gaW5kZXggaW5zdGVhZCBvZiB0aGUgaGFyZGNv
ZGVkIHZhbHVlIDAuIFRoaXMgbWFrZXMgdGhlIGNvZGUgbW9yZQ0KPiA+IHJlYWRhYmxlIGFuZCBp
dCB3aWxsIG1ha2UgaXQgZWFzaWVyIHRvIGFkZCBzdXBwb3J0IGZvciBtdWx0aXBsZSBMQkENCj4g
PiBmb3JtYXRzIGluIHRoZSBmdXR1cmUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBEbWl0cnkg
Rm9taWNoZXYgPGRtaXRyeS5mb21pY2hldkB3ZGMuY29tPg0KPiA+IC0tLQ0KPiA+ICBody9ibG9j
ay9udm1lLmMgfCAgNCArKystDQo+ID4gIGh3L2Jsb2NrL252bWUuaCB8IDExICsrKysrKysrKysr
DQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L2Jsb2NrL252bWUuYyBiL2h3L2Jsb2NrL252bWUuYw0K
PiA+IGluZGV4IDNhOTBkODA2OTQuLjFjZmMxMzYwNDIgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYmxv
Y2svbnZtZS5jDQo+ID4gKysrIGIvaHcvYmxvY2svbnZtZS5jDQo+ID4gQEAgLTIyMDMsNiArMjIw
Myw3IEBAIHN0YXRpYyB2b2lkIG52bWVfaW5pdF9uYW1lc3BhY2UoTnZtZUN0cmwgKm4sDQo+IE52
bWVOYW1lc3BhY2UgKm5zLCBFcnJvciAqKmVycnApDQo+ID4gIHsNCj4gPiAgICAgIGludDY0X3Qg
YnNfc2l6ZTsNCj4gPiAgICAgIE52bWVJZE5zICppZF9ucyA9ICZucy0+aWRfbnM7DQo+ID4gKyAg
ICBpbnQgbGJhX2luZGV4Ow0KPiA+DQo+ID4gICAgICBic19zaXplID0gYmxrX2dldGxlbmd0aChu
LT5jb25mLmJsayk7DQo+ID4gICAgICBpZiAoYnNfc2l6ZSA8IDApIHsNCj4gPiBAQCAtMjIxMiw3
ICsyMjEzLDggQEAgc3RhdGljIHZvaWQgbnZtZV9pbml0X25hbWVzcGFjZShOdm1lQ3RybCAqbiwN
Cj4gTnZtZU5hbWVzcGFjZSAqbnMsIEVycm9yICoqZXJycCkNCj4gPg0KPiA+ICAgICAgbi0+bnNf
c2l6ZSA9IGJzX3NpemU7DQo+ID4NCj4gPiAtICAgIGlkX25zLT5sYmFmWzBdLmRzID0gQkRSVl9T
RUNUT1JfQklUUzsNCj4gPiArICAgIGxiYV9pbmRleCA9IE5WTUVfSURfTlNfRkxCQVNfSU5ERVgo
bnMtPmlkX25zLmZsYmFzKTsNCj4gPiArICAgIGlkX25zLT5sYmFmW2xiYV9pbmRleF0uZHMgPSBu
dm1lX2lsb2cyKG4tPmNvbmYubG9naWNhbF9ibG9ja19zaXplKTsNCj4gDQo+IEluc3RlYWQgb2Yg
ZGVmaW5pbmcgYSBuZXcgZnVuY3Rpb24sIHdlIGNhbiBkaXJlY3RseSB1c2UgY2x6MzIoKS4NCj4g
DQo+ICAgMzEgLSBjbHozMihuLT5jb25mLmxvZ2ljYWxfYmxvY2tfc2l6ZSkNCg0KT2sgbmljZSEg
SSBsb29rZWQgdXAgd2hhdCBRRU1VIHVzZXMgZm9yIGJpbmFyeSBsb2csIGJ1dCBjb3VsZG4ndCBm
aW5kIGl0IHF1aWNrbHkNCnNvIEkgZGVjaWRlZCB0byBkZWZpbmUgYSBmdW5jdGlvbiBmb3IgdGhh
dCA6KSBXaWxsIHN3aXRjaCB0byBjbHpYWCBpbiB0aGUgcGF0Y2ggc2V0IC0NCkkgYmVsaWV2ZSB0
aGVyZSBhcmUgdGhyZWUgb2NjdXJyZW5jZXMgd2hlcmUgaWxvZzIgaXMgdXNlZCBpbiB0aGUgYWRk
ZWQgY29kZS4NCg0K

