Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112AEC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 00:54:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE7A42070B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 00:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZKAUa5tf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PxCYlYXT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE7A42070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60630 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMMTP-0005v9-Lf
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 20:54:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0191b4fb4=Alistair.Francis@wdc.com>)
	id 1hMMHN-00046r-ED
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0191b4fb4=Alistair.Francis@wdc.com>)
	id 1hMMHJ-0006zo-LI
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:19 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:56396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=0191b4fb4=Alistair.Francis@wdc.com>)
	id 1hMMHE-0006v5-Ms; Thu, 02 May 2019 20:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1556844132; x=1588380132;
	h=from:to:cc:subject:date:message-id:content-id:
	content-transfer-encoding:mime-version;
	bh=ZKhTSOijUnR6VmyutTErzCTtb7/LzYl8Qi8s2fDKzrU=;
	b=ZKAUa5tfYNUxB94A+1Um/Kb2PtxxRZavpQvsJe8kT9GBn63wmXscqs2e
	hElShHuspHeYKYwdAzLSB74JtGmiypNk4SC304/XOh2ViZQV751xCoRp9
	m9lsHiSqmnUw0D0DfsHj3wLpUAcvWgjgbnef/EiMfIwsZrQo0y/U4Bt+u
	JWB3FVkPkQRNxn0Lt2ZUpHTLWHvcSuIzleDoDGvu1aTL4D01f0z+Wh2qm
	FRTFk2T8n/81QIuPoyh6wl/Rbx6QUBqy/Or/PxgclGNtZcnYIy6vXNQ/J
	v4cl2C3zheaXz4d0KfhSyfwOk25JBDxF7X+gzOu+EYzye53+fUvjqMr0a g==;
X-IronPort-AV: E=Sophos;i="5.60,423,1549900800"; d="scan'208";a="213338661"
Received: from mail-dm3nam03lp2057.outbound.protection.outlook.com (HELO
	NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.57])
	by ob1.hgst.iphmx.com with ESMTP; 03 May 2019 08:42:06 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=ZKhTSOijUnR6VmyutTErzCTtb7/LzYl8Qi8s2fDKzrU=;
	b=PxCYlYXTMUeL1QpPZG9oLoFeNW8XGpQ19jVS0j1ojkGLAp2IS+iqCacCknvTO5TH1eWmG8P3K86GWNb8wyB1ldDecnjRdWY9SxVyM4i2Wv/1uYg1C+ZWUzsaRGjjVZVpS06Wh88w/x7MYv6W6iA95aX7F0CNuV3G1O3ouUka1F8=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB5576.namprd04.prod.outlook.com (20.178.232.203) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1856.10; Fri, 3 May 2019 00:42:04 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::4d89:bbf8:952c:3d66]) by
	BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::4d89:bbf8:952c:3d66%5]) with mapi id 15.20.1856.008;
	Fri, 3 May 2019 00:42:04 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3] hw/usb/hcd-xhci: Fix GCC 9 build warning
Thread-Index: AQHVAUkHBtSRVK/UMUaNnzlPvPu/Iw==
Date: Fri, 3 May 2019 00:42:04 +0000
Message-ID: <20190503004021.13814-1-alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR06CA0043.namprd06.prod.outlook.com
	(2603:10b6:a03:14b::20) To BYAPR04MB4901.namprd04.prod.outlook.com
	(2603:10b6:a03:4f::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b57f55b4-cae1-4b2f-cf69-08d6cf602998
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB5576; 
x-ms-traffictypediagnostic: BYAPR04MB5576:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB557629B8F45D87F91EA8A59B90350@BYAPR04MB5576.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 0026334A56
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(396003)(39860400002)(366004)(136003)(376002)(346002)(199004)(189003)(7736002)(36756003)(3846002)(6436002)(6116002)(305945005)(72206003)(86362001)(52116002)(2501003)(68736007)(1076003)(66446008)(50226002)(2351001)(66556008)(66946007)(73956011)(6512007)(5660300002)(64756008)(66476007)(8676002)(81166006)(81156014)(14454004)(316002)(5640700003)(44832011)(8936002)(386003)(486006)(186003)(25786009)(6916009)(102836004)(6506007)(71200400001)(71190400001)(476003)(26005)(2616005)(66066001)(478600001)(2906002)(14444005)(256004)(53936002)(6486002)(4326008)(99286004)(54906003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5576;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1woYVFzKwHv7F4cozCOBT6ybcSxL4mCO8ANJw64XLn7rmLG/FgDn4ekn2AMusil9H2L3F13JSwc598lv2GcA0ILdovo6aEhVM5yqFBi9eM5f8MxXA+2VtSXrTbO2VlUv6wpmugsI6A6vb5cRgrhsqAjnOTFMWBZbqneva6vXICZHUpunyiNAlhkC/H/X7Im7MZ7nVqkpQ+vhWruMN54ApBA+cS/rn53tsJHA8LFuTHyBsFE0A5lkM9ruDgV6JDCBs9xvCIOB7ncA24bN8N/USbo6ejA9uDQNVutmoHhtFanYwHWzlg07O/toBzDZvgQkW5CGI7Agz76obkRU8mCvtmza6M1P70/9uaKshDhJFg6TBzbAoOVp9h3OCiNN+E0jJ0OghKXo/0jIx3WdBCy6+i7kLZbZBfgRLF0oKEpVq4w=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <75BE263937E2B44880102891AF9D9B29@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b57f55b4-cae1-4b2f-cf69-08d6cf602998
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2019 00:42:04.5537 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5576
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 68.232.141.245
Subject: [Qemu-devel] [PATCH v3] hw/usb/hcd-xhci: Fix GCC 9 build warning
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
	"riku.voipio@iki.fi" <riku.voipio@iki.fi>,
	"laurent@vivier.eu" <laurent@vivier.eu>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"kraxel@redhat.com" <kraxel@redhat.com>,
	"alistair23@gmail.com" <alistair23@gmail.com>,
	=?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503004204.63qRAKeBvjAbf1FMbWEgd3c6IEQjdeeIFY5XCdqH6zo@z>

Rml4IHRoaXMgYnVpbGQgd2FybmluZyB3aXRoIEdDQyA5IG9uIEZlZG9yYSAzMDoNCmh3L3VzYi9o
Y2QteGhjaS5jOjMzMzk6NjY6IGVycm9yOiDigJglZOKAmSBkaXJlY3RpdmUgb3V0cHV0IG1heSBi
ZSB0cnVuY2F0ZWQgd3JpdGluZyBiZXR3ZWVuIDEgYW5kIDEwIGJ5dGVzIGludG8gYSByZWdpb24g
b2Ygc2l6ZSA1IFstV2Vycm9yPWZvcm1hdC10cnVuY2F0aW9uPV0NCiAzMzM5IHwgICAgICAgICAg
ICAgc25wcmludGYocG9ydC0+bmFtZSwgc2l6ZW9mKHBvcnQtPm5hbWUpLCAidXNiMiBwb3J0ICMl
ZCIsIGkrMSk7DQogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXn4NCmh3L3VzYi9oY2QteGhjaS5jOjMzMzk6NTQ6
IG5vdGU6IGRpcmVjdGl2ZSBhcmd1bWVudCBpbiB0aGUgcmFuZ2UgWzEsIDIxNDc0ODM2NDddDQog
MzMzOSB8ICAgICAgICAgICAgIHNucHJpbnRmKHBvcnQtPm5hbWUsIHNpemVvZihwb3J0LT5uYW1l
KSwgInVzYjIgcG9ydCAjJWQiLCBpKzEpOw0KICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fg0KSW4gZmlsZSBp
bmNsdWRlZCBmcm9tIC91c3IvaW5jbHVkZS9zdGRpby5oOjg2NywNCiAgICAgICAgICAgICAgICAg
ZnJvbSAvaG9tZS9hbGlzdGFpci9xZW11L2luY2x1ZGUvcWVtdS9vc2RlcC5oOjk5LA0KICAgICAg
ICAgICAgICAgICBmcm9tIGh3L3VzYi9oY2QteGhjaS5jOjIxOg0KL3Vzci9pbmNsdWRlL2JpdHMv
c3RkaW8yLmg6Njc6MTA6IG5vdGU6IOKAmF9fYnVpbHRpbl9fX3NucHJpbnRmX2Noa+KAmSBvdXRw
dXQgYmV0d2VlbiAxMyBhbmQgMjIgYnl0ZXMgaW50byBhIGRlc3RpbmF0aW9uIG9mIHNpemUgMTYN
CiAgIDY3IHwgICByZXR1cm4gX19idWlsdGluX19fc25wcmludGZfY2hrIChfX3MsIF9fbiwgX19V
U0VfRk9SVElGWV9MRVZFTCAtIDEsDQogICAgICB8ICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KICAgNjggfCAgICAg
ICAgX19ib3MgKF9fcyksIF9fZm10LCBfX3ZhX2FyZ19wYWNrICgpKTsNCiAgICAgIHwgICAgICAg
IH5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCg0KU2lnbmVkLW9mZi1ieTog
QWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KUmV2aWV3ZWQtYnk6
IExhdXJlbnQgVml2aWVyIDxsYXVyZW50QHZpdmllci5ldT4NClJldmlld2VkLWJ5OiBEYW5pZWwg
UC4gQmVycmFuZ8OpIDxiZXJyYW5nZUByZWRoYXQuY29tPg0KUmV2aWV3ZWQtYnk6IFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4NCi0tLQ0KVGhpcyBpcyB0aGUgb25s
IHBhdGNoIGxlZnQgaWYgbXkgb3JpZ2luYWwgc2VyaWVzICJGaXggc29tZSBHQ0MgOSBidWlsZA0K
d2FybmluZ3MiIHRoYXQgaGFzbid0IGVpdGhlciBiZWVuIGFjY2VwZXRlZCBpbnRvIGEgbWFpbnRh
aW5lcnMgdHJlZSBvcg0KZml4ZWQgYnkgc29tZW9uZSBlbHNlLg0KDQogaHcvdXNiL2hjZC14aGNp
LmMgfCAyICsrDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0
IGEvaHcvdXNiL2hjZC14aGNpLmMgYi9ody91c2IvaGNkLXhoY2kuYw0KaW5kZXggZWMyOGJlZTMx
OS4uYTE1YjEwM2I2NSAxMDA2NDQNCi0tLSBhL2h3L3VzYi9oY2QteGhjaS5jDQorKysgYi9ody91
c2IvaGNkLXhoY2kuYw0KQEAgLTMzMjEsNiArMzMyMSw4IEBAIHN0YXRpYyB2b2lkIHVzYl94aGNp
X2luaXQoWEhDSVN0YXRlICp4aGNpKQ0KIA0KICAgICB1c2JfYnVzX25ldygmeGhjaS0+YnVzLCBz
aXplb2YoeGhjaS0+YnVzKSwgJnhoY2lfYnVzX29wcywgZGV2KTsNCiANCisgICAgZ19hc3NlcnQo
dXNicG9ydHMgPD0gTUFYKE1BWFBPUlRTXzIsIE1BWFBPUlRTXzMpKTsNCisNCiAgICAgZm9yIChp
ID0gMDsgaSA8IHVzYnBvcnRzOyBpKyspIHsNCiAgICAgICAgIHNwZWVkbWFzayA9IDA7DQogICAg
ICAgICBpZiAoaSA8IHhoY2ktPm51bXBvcnRzXzIpIHsNCi0tIA0KMi4yMS4wDQoNCg==

