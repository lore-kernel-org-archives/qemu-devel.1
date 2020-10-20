Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C46C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 23:03:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1593722240
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 23:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AA0/Jzj8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hrBUBWb7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1593722240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV0f5-0001ij-W5
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 19:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=55587455e=Dmitry.Fomichev@wdc.com>)
 id 1kV0dn-00018e-93; Tue, 20 Oct 2020 19:02:04 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:10288)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=55587455e=Dmitry.Fomichev@wdc.com>)
 id 1kV0dh-0008Qc-VX; Tue, 20 Oct 2020 19:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603234918; x=1634770918;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=pH9FuHFTXkmgr+nbQtNKyAAPM5648TjLwC8JmQdtYXE=;
 b=AA0/Jzj8mJoOXNg34qGcmJcrACBIeqG+bWo8f+Ce+fgfRkiORJK7NleN
 oAiCp/AOHB8L/4Y9yxH8ayjCVe/RCAod9wE1/sVNZUlOl1Al7mCzQBU0+
 NBBTf6DAjMVFocL20N+IkzSzJLXVQziLbc9dJ6d1dkx5bbqCxo08YWxYH
 vLHRTSgeeULY+Drjv4vVfxk/Re2v2ufSMWmkoCpC0aM/CjoW+BE65v99l
 xQCQwtBR3q8jOmV3ud2ZtoHeV10RX7BWG5Vh8J1n5WcTtdCY+9co2ZxKZ
 X95RkwRdAuOb8YC85s0TSP99MLVIWjBjqqmPpV9v5IBkWx5BixddPP7NS Q==;
IronPort-SDR: OKTTS8P8jBpNWUz0gCdTDFi354VLAFnI7oIaKqIhxkUu3mqK63Mqkau4xn+UdisKmreyUJfBJO
 mNky7Gd51942ZZukhprTREygbtsE2HTmtEf763jDbc1QKV3ik8BtonovsQuaJtLM1wVovjDmQP
 5H/5qlGpaTbHgQAzQVawKyDBbKlsNWP6mKzVnHkwOHXgJRiiIy8cEiHd6PqCNegn/GAsRWa+zJ
 OiSRph929EPbaRMDD7lvporF+LvkvgFDxJ/2VZEBKG2oWUYJTrhj7MtGZDtTjkNm6fE6qPtrD9
 b1I=
X-IronPort-AV: E=Sophos;i="5.77,399,1596470400"; d="scan'208";a="154895782"
Received: from mail-sn1nam02lp2052.outbound.protection.outlook.com (HELO
 NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.52])
 by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2020 07:01:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fuiaU+emqSXEhb2mUrGisnRdslBUM4qVlRMYzmvT6gxVDj5o4gesVAenvt8x7gjt6klxd/Nur2cOJMEKSP+FpNip/8CVXwbqHBKFh6psBGT/f7+Xfv7ZBajrejJnAQi8e4Mtamh9q++eByqnUxa9B4cGg6KzenGVY1u0JKkywUZ59ljaxSX5sm9J3+MuUky9v8puz4t48DdwxeY5YJBWfd55Z+nWP3Sjn6HLqcUzeeGNyem0z2d4yGN6rB4YaA5NY0caIK4jMPqlWpAoACSlaveVTlI5H1IMXhXGInBM++lX5a3Q+shxXK0R/aWfyAUFBZKfAqNc4m7eyxEmbslcMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pH9FuHFTXkmgr+nbQtNKyAAPM5648TjLwC8JmQdtYXE=;
 b=ffNYJPhdacGX/2ji6NPbZd4NJhRvI27n3uWsv1jYSjCqqoaWmCryjXGTcZz2HZoUlou4Y66BHI3dPr0m5x6t/wrzvE4JYoVf6ywyScGpetgc9VG2mgDCVc0CgVW9AQRf7nPVFdboWD+6VsS8K/r9n2F4yBGAk99DgAHhy6ELkd2OEc1m6n6xIb+mafmSxtqwWDbMXGSIv1xGSDz/EvvrGO5yAsUWGkmvlVkizzN0rBIc5ccEJhNEmUXtLBCeT/fZymJ/tr5JVjQEjjMPH0ti9BYgHwO1lRzRYH/rRyf2DcR/mcYbq/jwOxHccI5WuGSq3my7VDGL7QHeu44qKwMfqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pH9FuHFTXkmgr+nbQtNKyAAPM5648TjLwC8JmQdtYXE=;
 b=hrBUBWb7aIfzjMVMNl8aQ6wvzpvnM3kte1e0rApv58+OqaAJz5hjz8VOIvfiEqFMB56tHkWCisFyriXNEkqurYysKO3GZUF9rrUUtopDl99+KWJbaOf9yxvrhbMMbR3gvftvcIBY0L7Fp0umcaJFbQW73ExH9ARfVAF4q+HB7pg=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB6206.namprd04.prod.outlook.com (2603:10b6:208:e0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 20 Oct
 2020 23:01:47 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44c9:85df:4910:44d8]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44c9:85df:4910:44d8%4]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 23:01:47 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: RE: [PATCH v7 08/11] hw/block/nvme: Add injection of
 Offline/Read-Only zones
Thread-Topic: [PATCH v7 08/11] hw/block/nvme: Add injection of
 Offline/Read-Only zones
Thread-Index: AQHWpb4O4MyAJYtY3kqE6eY+o0U9I6mezl0AgAHrdBA=
Date: Tue, 20 Oct 2020 23:01:46 +0000
Message-ID: <MN2PR04MB5951884401C5BDF23174A1B7E11F0@MN2PR04MB5951.namprd04.prod.outlook.com>
References: <20201019021726.12048-1-dmitry.fomichev@wdc.com>
 <20201019021726.12048-9-dmitry.fomichev@wdc.com>
 <20201019114230.GB10549@apples.localdomain>
In-Reply-To: <20201019114230.GB10549@apples.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3d7d46fc-7c87-40f3-2a38-08d8754c1f0f
x-ms-traffictypediagnostic: MN2PR04MB6206:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB62061C82136A56C06051953AE11F0@MN2PR04MB6206.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:416;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KDta53WV1dbXj2fdrXDimwleoVPqOnRRSdNYj0n8NlyHWiblcpG5FbpxhCIaulT6dIbSb17VoTI6MaXSo0Eeka4e8T2T2yg6yaRZUpmzkMhECVOB4VLtNZXCYJkjDCd08CkrmDMoCrn2USri41xkQ7x94WQI7a6+V3XbYrEDwFETNLvCGK0ynBYHLrhXEkxtMq6IIs4M6MRjJV9U04UCqvHopno0OPlHxgIAIhlu5/6b9P95iGQyuCzmMnFqpwMaLSxDduCKPJt5u/GULUVokUie8zsvZ1wynovKin6ossZhLYLNUezNSyYJaPvUoKtlnVNZGXnruGFRl0BTvb4kuQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39850400004)(366004)(346002)(376002)(2906002)(478600001)(83380400001)(8936002)(8676002)(33656002)(55016002)(76116006)(54906003)(186003)(316002)(66556008)(66476007)(6506007)(53546011)(66946007)(64756008)(66446008)(71200400001)(6916009)(26005)(86362001)(7696005)(4326008)(9686003)(52536014)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: IZK9TAXa7ZoYeH5nFHGCXHX4noE2W15JleambFMSHu/n1wyu0nYLDdMAPucPd7BK8xJqR/HkQ1HpHaswBM+2uOv0e9Xt4MNWBl/IGGRjUG5Hl7f5xJu4h/desRHpCOKI+R+LLEU/A5RC5bwPmlb1YJRRboZamAnOAFVxxXMdyulrZcok33GxcbaqwdbQMbpr+mGm7RfiSdEn9o+UwFGP6b2OVUqg9t9PYkVVG9yaI83UVWulkjcOtwSmWuFTe1WR1h8X1QnPpBiqKP8qinPVkQdI5X5K1BseftOw9yF7hfzvWBMMjeJXABQSS4XOJP6xfxHxXyaVuhAMpr78rC1HNsoYmdhQE7AibmLJgEbUcUPXeEe+Nyu/wHgV8ul2odYsQWGZnXMKITYtYUF/wf59mpyYeyQZTaPvxMt6ZWUUAk3QNUZ7Iuwpuk9EYxqCRUgD+p500nNcJouqThTKS0y7bgi1k9tWAw2FuP6zRMAQQgXxy/2T0sdansJdbhkKWkJwQUpatLgxdcCIaYNG8wJ5vsdSHYgwUCBOGICiQOwtlh9RFMuf+/JhN5yj2XjjcWkAjx7VLP8wJmDyBCRjbqp79dhCsQw+3gNa2J40J1vFlvM6dmPRAlliwtfAFOgb8ngKhgbTUtA6G+mozASlgoxiLw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7d46fc-7c87-40f3-2a38-08d8754c1f0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2020 23:01:47.0397 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3nSWkZQYU7VcVUQGM7hIN49y2ySjrSZzX3Y3sCkFdKBGTrIRfj8wXO2Q6gmDlZr/Pbt7ulQJWDagO2+hxR27Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6206
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=55587455e=Dmitry.Fomichev@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 19:01:52
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
cnJlbGV2YW50LmRrPg0KPiBTZW50OiBNb25kYXksIE9jdG9iZXIgMTksIDIwMjAgNzo0MyBBTQ0K
PiBUbzogRG1pdHJ5IEZvbWljaGV2IDxEbWl0cnkuRm9taWNoZXZAd2RjLmNvbT4NCj4gQ2M6IEtl
aXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz47IEtsYXVzIEplbnNlbg0KPiA8ay5qZW5zZW5A
c2Ftc3VuZy5jb20+OyBLZXZpbiBXb2xmIDxrd29sZkByZWRoYXQuY29tPjsgUGhpbGlwcGUNCj4g
TWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPjsgTWF4aW0gTGV2aXRza3kNCj4gPG1s
ZXZpdHNrQHJlZGhhdC5jb20+OyBGYW0gWmhlbmcgPGZhbUBldXBob24ubmV0PjsgTmlrbGFzIENh
c3NlbA0KPiA8TmlrbGFzLkNhc3NlbEB3ZGMuY29tPjsgRGFtaWVuIExlIE1vYWwgPERhbWllbi5M
ZU1vYWxAd2RjLmNvbT47DQo+IHFlbXUtYmxvY2tAbm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25n
bnUub3JnOyBBbGlzdGFpciBGcmFuY2lzDQo+IDxBbGlzdGFpci5GcmFuY2lzQHdkYy5jb20+OyBN
YXRpYXMgQmpvcmxpbmcgPE1hdGlhcy5Cam9ybGluZ0B3ZGMuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHY3IDA4LzExXSBody9ibG9jay9udm1lOiBBZGQgaW5qZWN0aW9uIG9mIE9mZmxpbmUv
UmVhZC0NCj4gT25seSB6b25lcw0KPiANCj4gT24gT2N0IDE5IDExOjE3LCBEbWl0cnkgRm9taWNo
ZXYgd3JvdGU6DQo+ID4gWk5TIHNwZWNpZmljYXRpb24gZGVmaW5lcyB0d28gem9uZSBjb25kaXRp
b25zIGZvciB0aGUgem9uZXMgdGhhdCBubw0KPiA+IGxvbmdlciBjYW4gZnVuY3Rpb24gcHJvcGVy
bHksIHBvc3NpYmx5IGJlY2F1c2Ugb2YgZmxhc2ggd2VhciBvciBvdGhlcg0KPiA+IGludGVybmFs
IGZhdWx0LiBJdCBpcyB1c2VmdWwgdG8gYmUgYWJsZSB0byAiaW5qZWN0IiBhIHNtYWxsIG51bWJl
ciBvZg0KPiA+IHN1Y2ggem9uZXMgZm9yIHRlc3RpbmcgcHVycG9zZXMuDQo+ID4NCj4gPiBUaGlz
IGNvbW1pdCBkZWZpbmVzIHR3byBvcHRpb25hbCBkZXZpY2UgcHJvcGVydGllcywgIm9mZmxpbmVf
em9uZXMiDQo+ID4gYW5kICJyZG9ubHlfem9uZXMiLiBVc2VycyBjYW4gYXNzaWduIG5vbi16ZXJv
IHZhbHVlcyB0byB0aGVzZSB2YXJpYWJsZXMNCj4gPiB0byBzcGVjaWZ5IHRoZSBudW1iZXIgb2Yg
em9uZXMgdG8gYmUgaW5pdGlhbGl6ZWQgYXMgT2ZmbGluZSBvcg0KPiA+IFJlYWQtT25seS4gVGhl
IGFjdHVhbCBudW1iZXIgb2YgaW5qZWN0ZWQgem9uZXMgbWF5IGJlIHNtYWxsZXIgdGhhbiB0aGUN
Cj4gPiByZXF1ZXN0ZWQgYW1vdW50IC0gUmVhZC1Pbmx5IGFuZCBPZmZsaW5lIGNvdW50cyBhcmUg
ZXhwZWN0ZWQgdG8gYmUgbXVjaA0KPiA+IHNtYWxsZXIgdGhhbiB0aGUgdG90YWwgbnVtYmVyIG9m
IHpvbmVzIG9uIGEgZHJpdmUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBEbWl0cnkgRm9taWNo
ZXYgPGRtaXRyeS5mb21pY2hldkB3ZGMuY29tPg0KPiA+IC0tLQ0KPiA+ICBody9ibG9jay9udm1l
LW5zLmMgfCA2NA0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ID4gIGh3L2Jsb2NrL252bWUtbnMuaCB8ICAyICsrDQo+ID4gIDIgZmlsZXMgY2hhbmdl
ZCwgNjYgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L2Jsb2NrL252bWUt
bnMuYyBiL2h3L2Jsb2NrL252bWUtbnMuYw0KPiA+IGluZGV4IDI1NWRlZDJiNDMuLmQwNTBmOTc5
MDkgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYmxvY2svbnZtZS1ucy5jDQo+ID4gKysrIGIvaHcvYmxv
Y2svbnZtZS1ucy5jDQo+ID4gQEAgLTIxLDYgKzIxLDcgQEANCj4gPiAgI2luY2x1ZGUgInN5c2Vt
dS9zeXNlbXUuaCINCj4gPiAgI2luY2x1ZGUgInN5c2VtdS9ibG9jay1iYWNrZW5kLmgiDQo+ID4g
ICNpbmNsdWRlICJxYXBpL2Vycm9yLmgiDQo+ID4gKyNpbmNsdWRlICJjcnlwdG8vcmFuZG9tLmgi
DQo+ID4NCj4gPiAgI2luY2x1ZGUgImh3L3FkZXYtcHJvcGVydGllcy5oIg0KPiA+ICAjaW5jbHVk
ZSAiaHcvcWRldi1jb3JlLmgiDQo+ID4gQEAgLTEzMiw2ICsxMzMsMzIgQEAgc3RhdGljIGludA0K
PiBudm1lX2NhbGNfem9uZV9nZW9tZXRyeShOdm1lTmFtZXNwYWNlICpucywgRXJyb3IgKiplcnJw
KQ0KPiA+ICAgICAgICAgIHJldHVybiAtMTsNCj4gPiAgICAgIH0NCj4gPg0KPiA+ICsgICAgaWYg
KG5zLT5wYXJhbXMuemRfZXh0ZW5zaW9uX3NpemUpIHsNCj4gPiArICAgICAgICBpZiAobnMtPnBh
cmFtcy56ZF9leHRlbnNpb25fc2l6ZSAmIDB4M2YpIHsNCj4gPiArICAgICAgICAgICAgZXJyb3Jf
c2V0ZyhlcnJwLA0KPiA+ICsgICAgICAgICAgICAgICAgInpvbmUgZGVzY3JpcHRvciBleHRlbnNp
b24gc2l6ZSBtdXN0IGJlIGEgbXVsdGlwbGUgb2YgNjRCIik7DQo+ID4gKyAgICAgICAgICAgIHJl
dHVybiAtMTsNCj4gPiArICAgICAgICB9DQo+ID4gKyAgICAgICAgaWYgKChucy0+cGFyYW1zLnpk
X2V4dGVuc2lvbl9zaXplID4+IDYpID4gMHhmZikgew0KPiA+ICsgICAgICAgICAgICBlcnJvcl9z
ZXRnKGVycnAsICJ6b25lIGRlc2NyaXB0b3IgZXh0ZW5zaW9uIHNpemUgaXMgdG9vIGxhcmdlIik7
DQo+ID4gKyAgICAgICAgICAgIHJldHVybiAtMTsNCj4gPiArICAgICAgICB9DQo+ID4gKyAgICB9
DQo+IA0KPiBMb29rcyBsaWtlIHRoaXMgc2hvdWxkIGhhdmUgYmVlbiBhZGRlZCBpbiB0aGUgcHJl
dmlvdXMgcGF0Y2guDQoNClJpZ2h0LCB0aGlzIGJlbG9uZ3MgdG8gWkRFIHBhdGNoLiANCg==

