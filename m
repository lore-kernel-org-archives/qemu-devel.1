Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01B7C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 13:40:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 545FA2070B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 13:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="s+oD/9cs";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="s+oD/9cs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 545FA2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iblwP-0004zx-8S
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 08:40:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Alan.Hayward@arm.com>) id 1ibiaf-000791-Mo
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:06:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Alan.Hayward@arm.com>) id 1ibiad-0003DD-1G
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:06:00 -0500
Received: from mail-eopbgr60083.outbound.protection.outlook.com
 ([40.107.6.83]:16118 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Alan.Hayward@arm.com>)
 id 1ibiac-0003CP-JF; Mon, 02 Dec 2019 05:05:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbpXiavto7WlF+PW20qrrUoF0nbKX5dh+9AB32r0UNU=;
 b=s+oD/9cssuc/hfm2m/B6O3TBM7+rIP46mMD15PZzeWKYR5HmRTRucuOPgDQZbi7DD3hp48ywTR8YItfv+O4xOVm4NTafKJjqMgKyRZNGDA6sAYVU0xYC4uatS/5akjk2NxBJFfywxbpdxGlJJwbr0iMaSdEr6WhWQ2C02x36pxY=
Received: from VI1PR08CA0214.eurprd08.prod.outlook.com (2603:10a6:802:15::23)
 by DB8PR08MB5017.eurprd08.prod.outlook.com (2603:10a6:10:ef::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.17; Mon, 2 Dec
 2019 10:05:54 +0000
Received: from VE1EUR03FT034.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::203) by VI1PR08CA0214.outlook.office365.com
 (2603:10a6:802:15::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.20 via Frontend
 Transport; Mon, 2 Dec 2019 10:05:54 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; nongnu.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;nongnu.org; dmarc=bestguesspass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT034.mail.protection.outlook.com (10.152.18.85) with
 Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Mon, 2 Dec 2019 10:05:54 +0000
Received: ("Tessian outbound 54081306375c:v37");
 Mon, 02 Dec 2019 10:05:52 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 489143afd3908e66
X-CR-MTA-TID: 64aa7808
Received: from 705f231e3107.1
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 65C77B36-9D6A-44D4-98D2-359C7D694CFE.1; 
 Mon, 02 Dec 2019 10:05:46 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 705f231e3107.1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Mon, 02 Dec 2019 10:05:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlV3xwoV7L+wXv/rH3jucTz+kBTY5vWpAWQHEC6gbMOLNK5HsSx+mwohMvP+CZrVA4nC1Z2IG38rw3gHo3bNT4HddxEBafcIH1aN2GaJn7lIExAwQw+x59WoNUw5S0X8pe2G/k8KXgTlw2GrXewBFjzq8RaG1IWcmh4NcSTUpe5ikybbQWr8Qb27bCzV48WhBsjTk3bv/1gHqjAn9cR7dvVYoKHI6KVJEirgTUNswTSYxkZy4dz5fdHEti6K/Sljsy2Gx//1fPRFx6eZX02XGu3LnFwnjPRoFGJwMjONI9XHYtvg4bbg/oJWiDtWok4IsV8HGqHKiI7we0faGpzYtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbpXiavto7WlF+PW20qrrUoF0nbKX5dh+9AB32r0UNU=;
 b=Lfh4PwXClU+CS1Yy+ZQDpDEuJAI08xzfKTdYG1jnACkC+IGgZkCbraQHNe6w1sy8Y9mCbajk5uhiDas5H8yRGL02978BtfYywLOhW961NWeFcYgGFOr689tXX3sFky2bfbdU77i1sxDq/quwcF7Tn8PdCjgai2V38gLjtyUHmx8Kn6Ru+f/ogywCHuRNte4WDay7A2fx4cUJI9d/nEKPz8nD79lKXfeHKhWZoRwZyGCfD1Je+S4ZDOFqYZcLtyVUxGFlDfhy1ZHZaOjJym5sNlMcYtxW1OSTxSNb7icHisgp+IS/uee7cKJdPL3fA95hjF0ahdZt/2Y6R8cjIxnlFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbpXiavto7WlF+PW20qrrUoF0nbKX5dh+9AB32r0UNU=;
 b=s+oD/9cssuc/hfm2m/B6O3TBM7+rIP46mMD15PZzeWKYR5HmRTRucuOPgDQZbi7DD3hp48ywTR8YItfv+O4xOVm4NTafKJjqMgKyRZNGDA6sAYVU0xYC4uatS/5akjk2NxBJFfywxbpdxGlJJwbr0iMaSdEr6WhWQ2C02x36pxY=
Received: from DB8PR08MB5004.eurprd08.prod.outlook.com (10.255.19.224) by
 DB8PR08MB4025.eurprd08.prod.outlook.com (20.179.10.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Mon, 2 Dec 2019 10:05:44 +0000
Received: from DB8PR08MB5004.eurprd08.prod.outlook.com
 ([fe80::ad17:d322:720e:3ac0]) by DB8PR08MB5004.eurprd08.prod.outlook.com
 ([fe80::ad17:d322:720e:3ac0%4]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 10:05:44 +0000
From: Alan Hayward <Alan.Hayward@arm.com>
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 06/14] target/arm: use gdb_get_reg helpers
Thread-Topic: [PATCH v2 06/14] target/arm: use gdb_get_reg helpers
Thread-Index: AQHVqIKv65Q7cbxEuk+QAo74emkk/6emnxkA
Date: Mon, 2 Dec 2019 10:05:44 +0000
Message-ID: <42017B4E-E961-494C-A505-FCDA74EFB265@arm.com>
References: <20191130084602.10818-1-alex.bennee@linaro.org>
 <20191130084602.10818-7-alex.bennee@linaro.org>
 <987465d3-3b13-e675-9622-c13e2d5205c2@redhat.com>
In-Reply-To: <987465d3-3b13-e675-9622-c13e2d5205c2@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3601.0.10)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Alan.Hayward@arm.com; 
x-originating-ip: [213.86.15.71]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1759ba6b-3b06-4151-e4db-08d7770f37fe
X-MS-TrafficTypeDiagnostic: DB8PR08MB4025:|DB8PR08MB5017:
X-Microsoft-Antispam-PRVS: <DB8PR08MB50179DE7AA397F7EC765BC4D97430@DB8PR08MB5017.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:5516;OLM:5516;
x-forefront-prvs: 0239D46DB6
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(199004)(189003)(14444005)(14454004)(66574012)(8936002)(256004)(6486002)(305945005)(33656002)(50226002)(7736002)(966005)(6916009)(6436002)(478600001)(25786009)(99286004)(3846002)(6116002)(6246003)(316002)(8676002)(71190400001)(6512007)(6306002)(54906003)(186003)(5660300002)(66066001)(4326008)(2906002)(66946007)(229853002)(66446008)(71200400001)(66556008)(64756008)(2616005)(26005)(91956017)(76116006)(11346002)(446003)(76176011)(102836004)(66476007)(36756003)(6506007)(55236004)(53546011)(86362001)(81166006)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB8PR08MB4025;
 H:DB8PR08MB5004.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: wgYeFrYpxdOMj6rmPMWBMWKJLV/xf4HhpD/XMWPuxWywW04YYbVB6L3dwELW7LMTK+TaIqTw5xXdxIyO5rnmvQx5WWkL0zodGmjz0Rst7Gh+Ch9NWhLoow7oxEeeDzEJkyeV/yhGgUqwxLb3n4esF6Ff8jrE3xn39Eyzce+eK6qQQJRPt7nb+vjl1kWcrMKztGc6SxLepewnuNfOTUZIAD8b6cBs4BID9xyiLoK4o/fEdrMeMntYKshhB6NFFrZrMhyt+CCVvRQH+QqxqP5No8+1y1JNMDyPoEfaMvtiOh6TFLb/R9b3Q5qpSSHbHQfTxiu0JPAPNZAAFpSM5Eqp8IGcOlRhHCa8X1DvkdGBsqBIHnpvbmJNi84fu7cA36Inn+mYWHXTDmYWyFzi3Unw4kxfQfLRrpU3FzG3sYLkBxxkgFMkoUztVKnD6liowkhGZoh2+JSl9SjvUy/R26EKXi70Bk9AoE16Mxybmh3jdbk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A5533DF681C394798C0330437CA4B49@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4025
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alan.Hayward@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT034.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123; IPV:CAL; SCL:-1; CTRY:IE;
 EFV:NLI; SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(396003)(199004)(189003)(6862004)(2906002)(25786009)(70586007)(6116002)(86362001)(47776003)(70206006)(5660300002)(3846002)(50466002)(450100002)(7736002)(26005)(36756003)(186003)(4326008)(478600001)(6246003)(14454004)(356004)(966005)(305945005)(26826003)(33656002)(336012)(2616005)(229853002)(6512007)(6306002)(14444005)(36906005)(106002)(6486002)(99286004)(316002)(54906003)(11346002)(446003)(22756006)(81166006)(66574012)(102836004)(2486003)(6506007)(66066001)(76130400001)(8936002)(81156014)(8676002)(76176011)(53546011)(23676004)(50226002)(436003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB8PR08MB5017;
 H:64aa7808-outbound-1.mta.getcheckrecipient.com; FPR:; SPF:Pass; LANG:en;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; A:1; MX:1; 
X-MS-Office365-Filtering-Correlation-Id-Prvs: f878f1cf-acd0-4e42-caf2-08d7770f3246
NoDisclaimer: True
X-Forefront-PRVS: 0239D46DB6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E5ex586ftKmNs09hIeV0oqAwomntLTZ6IXcNLfkU2XPQlzuVmO+sGcsU9/EHWx++2LP1Oh1oRxpCTcF/U2Ub6/WKGpGMcYl3dj6VpTCQwhOQXsZFfmfwgKbCL4s3OsjRTtMLUj/EBnfJ1zqQcZwZaQxVbspQ2kIfmkoVM+l/KfF/Q2pgzcXlcqR6lP8KvWyPobvwu4xpjiH20Xta+BVuSqFMXZWpFm6gI8DoyoPhbiYwbmh/2xQxJVZ3OOBt3pL5S3/eNL8/0hcXzu0BfiR887Lyvm664hylaaSc3zsc0iyacqVWAxG2sWEvXnZTKX3RBZ5fUw/KfxHQH9jYfxL9HUP0lxnVZSgOwCdZPXLq/wcDFm9C8Dedi+OlyeZCI199o5UiJs59tga6FezvQTnLcYXKz9Patug71K5JbjQqOAPjsfKCktxHWu8GkU99AWxJ1FzycN5pd1F2WfL97ZI/IKjnZKJGmXw1EYdQjtEPVD4=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 10:05:54.2348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1759ba6b-3b06-4151-e4db-08d7770f37fe
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5017
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.83
X-Mailman-Approved-At: Mon, 02 Dec 2019 08:36:39 -0500
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
Cc: "damien.hedde@greensocs.com" <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Luis Machado <luis.machado@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "open list:ARM
 TCG CPUs" <qemu-arm@nongnu.org>, nd <nd@arm.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gT24gMSBEZWMgMjAxOSwgYXQgMjA6MDUsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxw
aGlsbWRAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiBPbiAxMS8zMC8xOSA5OjQ1IEFNLCBBbGV4
IEJlbm7DqWUgd3JvdGU6DQo+PiBUaGlzIGlzIGNsZWFuZXIgdGhhbiBwb2tpbmcgbWVtb3J5IGRp
cmVjdGx5IGFuZCB3aWxsIG1ha2UgbGF0ZXINCj4+IGNsZWFuLXVwcyBlYXNpZXIuDQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+DQo+PiAtLS0N
Cj4+IHYyDQo+PiAgIC0gbWFrZSBzdXJlIHdlIHBhc3MgaGkvbG8gY29ycmVjdGx5IGFzIHF1YWRz
IGFyZSBzdG9yZWQgaW4gTEUgb3JkZXINCj4+IC0tLQ0KPj4gIHRhcmdldC9hcm0vaGVscGVyLmMg
fCAxOCArKysrKysrLS0tLS0tLS0tLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25z
KCspLCAxMSBkZWxldGlvbnMoLSkNCj4+IGRpZmYgLS1naXQgYS90YXJnZXQvYXJtL2hlbHBlci5j
IGIvdGFyZ2V0L2FybS9oZWxwZXIuYw0KPj4gaW5kZXggMGJmOGY1M2Q0YjguLjBhYzk1MGQ2Yzcx
IDEwMDY0NA0KPj4gLS0tIGEvdGFyZ2V0L2FybS9oZWxwZXIuYw0KPj4gKysrIGIvdGFyZ2V0L2Fy
bS9oZWxwZXIuYw0KPj4gQEAgLTEwNSwyMSArMTA1LDE3IEBAIHN0YXRpYyBpbnQgYWFyY2g2NF9m
cHVfZ2RiX2dldF9yZWcoQ1BVQVJNU3RhdGUgKmVudiwgdWludDhfdCAqYnVmLCBpbnQgcmVnKQ0K
Pj4gIHsNCj4+ICAgICAgc3dpdGNoIChyZWcpIHsNCj4+ICAgICAgY2FzZSAwIC4uLiAzMToNCj4+
IC0gICAgICAgIC8qIDEyOCBiaXQgRlAgcmVnaXN0ZXIgKi8NCj4+IC0gICAgICAgIHsNCj4+IC0g
ICAgICAgICAgICB1aW50NjRfdCAqcSA9IGFhNjRfdmZwX3FyZWcoZW52LCByZWcpOw0KPj4gLSAg
ICAgICAgICAgIHN0cV9sZV9wKGJ1ZiwgcVswXSk7DQo+PiAtICAgICAgICAgICAgc3RxX2xlX3Ao
YnVmICsgOCwgcVsxXSk7DQo+PiAtICAgICAgICAgICAgcmV0dXJuIDE2Ow0KPj4gLSAgICAgICAg
fQ0KPj4gKyAgICB7DQo+PiArICAgICAgICAvKiAxMjggYml0IEZQIHJlZ2lzdGVyIC0gcXVhZHMg
YXJlIGluIExFIG9yZGVyICovDQo+IA0KPiBPaCwgdGhpcyB3YXMgYWx3YXlzIHdyb25nIG9uIEJF
IDooDQoNCkFtIEkgcmlnaHQgaW4gdGhpbmtpbmcgdGhpcyBwYXRjaCBjb3JyZWN0bHkgbWF0Y2hl
cyB0aGUgU1ZFIEJFIGNoYW5nZXMgZnJvbSBKdW5lPw0KDQpTcGVjaWZpY2FsbHksIHRoaXMgcGF0
Y2g6DQpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwvbGludXgtYXJtLWtlcm5l
bC8yMDE5LUp1bmUvNjU3ODI2Lmh0bWwNCg0KDQpBbGFuLg0KDQo+IA0KPiBSZXZpZXdlZC1ieTog
UGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPg0KPiANCj4+ICsgICAg
ICAgIHVpbnQ2NF90ICpxID0gYWE2NF92ZnBfcXJlZyhlbnYsIHJlZyk7DQo+PiArICAgICAgICBy
ZXR1cm4gZ2RiX2dldF9yZWcxMjgoYnVmLCBxWzFdLCBxWzBdKTsNCj4+ICsgICAgfQ0KPj4gICAg
ICBjYXNlIDMyOg0KPj4gICAgICAgICAgLyogRlBTUiAqLw0KPj4gLSAgICAgICAgc3RsX3AoYnVm
LCB2ZnBfZ2V0X2Zwc3IoZW52KSk7DQo+PiAtICAgICAgICByZXR1cm4gNDsNCj4+ICsgICAgICAg
IHJldHVybiBnZGJfZ2V0X3JlZzMyKGJ1ZiwgdmZwX2dldF9mcHNyKGVudikpOw0KPj4gICAgICBj
YXNlIDMzOg0KPj4gICAgICAgICAgLyogRlBDUiAqLw0KPj4gLSAgICAgICAgc3RsX3AoYnVmLCB2
ZnBfZ2V0X2ZwY3IoZW52KSk7DQo+PiAtICAgICAgICByZXR1cm4gNDsNCj4+ICsgICAgICAgIHJl
dHVybiBnZGJfZ2V0X3JlZzMyKGJ1Zix2ZnBfZ2V0X2ZwY3IoZW52KSk7DQo+PiAgICAgIGRlZmF1
bHQ6DQo+PiAgICAgICAgICByZXR1cm4gMDsNCj4+ICAgICAgfQ0KDQo=

