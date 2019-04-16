Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B04C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 06:41:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B439B2073F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 06:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="aKecNnBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B439B2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60212 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGHmp-0004gm-0C
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 02:41:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hGHly-0004Me-3R
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 02:40:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hGHlx-0003PS-8S
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 02:40:50 -0400
Received: from mail-vi1eur04on0700.outbound.protection.outlook.com
	([2a01:111:f400:fe0e::700]:27970
	helo=EUR04-VI1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hGHlw-0003Nr-Vn; Tue, 16 Apr 2019 02:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=TIbT2RPdWKbJ1XQ8mOVMJj/zmSQCuBmtVrPO+hvrvGM=;
	b=aKecNnBNIZq/TWME3xgK+FlKgn088MJreRXNq1uVsvCyVL3I+abLsi8e1hTOT2aJVz7X9OQdd3zta96gFGweaD/QDMtzbbycA9lBSsfRKWN5c9ZCvE/c4mK5VIqb6F4yIQ8thnN+uZyZ/Y+lo6xj+siC2rPG4Av3t2geym4Df/M=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3291.eurprd08.prod.outlook.com (52.134.111.29) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1792.17; Tue, 16 Apr 2019 06:40:46 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1792.018;
	Tue, 16 Apr 2019 06:40:46 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>
Thread-Topic: [PATCH v3 2/7] qemu-img: Add salvaging mode to convert
Thread-Index: AQHU8hl6+/MfRHz0vkKjIW849FbbwqY+Wm2A
Date: Tue, 16 Apr 2019 06:40:45 +0000
Message-ID: <b40c4ff2-d5ad-12ae-39ce-eef61dadffb5@virtuozzo.com>
References: <20190413165343.9018-1-mreitz@redhat.com>
	<20190413165343.9018-3-mreitz@redhat.com>
In-Reply-To: <20190413165343.9018-3-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0003.eurprd04.prod.outlook.com
	(2603:10a6:3:d0::13) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190416094043667
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce071750-0f75-460c-bcc1-08d6c2367466
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
	SRVR:DB7PR08MB3291; 
x-ms-traffictypediagnostic: DB7PR08MB3291:
x-microsoft-antispam-prvs: <DB7PR08MB32912AB05FC1AAF3E6CA9330C1240@DB7PR08MB3291.eurprd08.prod.outlook.com>
x-forefront-prvs: 000947967F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(39850400004)(366004)(396003)(376002)(136003)(189003)(199004)(105586002)(86362001)(68736007)(106356001)(76176011)(31696002)(14454004)(52116002)(81156014)(31686004)(6512007)(4326008)(97736004)(478600001)(7736002)(8676002)(305945005)(3846002)(81166006)(6116002)(2906002)(53936002)(6246003)(8936002)(54906003)(102836004)(2616005)(6486002)(26005)(229853002)(256004)(6436002)(36756003)(6506007)(386003)(107886003)(5660300002)(71200400001)(11346002)(4744005)(71190400001)(25786009)(99286004)(66066001)(446003)(486006)(2501003)(110136005)(316002)(186003)(476003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3291;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NzXdrhfkbWYTCculY37A1d3yfJeqko+7tazMBZkUTYIsQlqOJDxpplrRIg30qTNJhiP7TfH9nm/dVvilxVdYRaCDQynqBIX4DvagCRm9HsFko3PA1keikZrVWLQm7j/5885Jy2Xr+P960n3bzSPF3XYX/FN58ciepoe2/C4RKrgHZoF2uaJFzOVhf8QTupvOjvbrdLvp/zVIIIw2SduiID/7h4t7XgF3lYnpgV0Q4omCAd1zGEaym5j3rJ0H6BX48DEHD42dC3a4B0IF33TeGAngbQ9qKI88VHb93GzVXI6davnxmo/XMHOsHUgNZOV7a4+FyAG8E548WliWlC2ltYkrtQoJwNWCgDMXiUwbnXhoSv8xPeh2DydgvjziQr2AsUXT9/snkBl9gAVrc5l/BiMfG/Y0zYwx5f8a+7SO1lY=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <B230078AB146D14FBF708BA0AA2A9FC1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce071750-0f75-460c-bcc1-08d6c2367466
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2019 06:40:45.9108 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3291
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0e::700
Subject: Re: [Qemu-devel] [PATCH v3 2/7] qemu-img: Add salvaging mode to
 convert
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
Cc: Kevin Wolf <kwolf@redhat.com>,
	Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416064045.GTAaRwUJxszBjnI5WUktM9_HFeMaEF2sEbqZ45z-8Ng@z>

MTMuMDQuMjAxOSAxOTo1MywgTWF4IFJlaXR6IHdyb3RlOg0KPiBUaGlzIGFkZHMgYSBzYWx2YWdp
bmcgbW9kZSAoLS1zYWx2YWdlKSB0byBxZW11LWltZyBjb252ZXJ0IHdoaWNoIGlnbm9yZXMNCj4g
cmVhZCBlcnJvcnMgYW5kIHRyZWF0cyB0aGUgcmVzcGVjdGl2ZSBhcmVhcyBhcyBjb250YWluaW5n
IG9ubHkgemVyb2VzLg0KPiBUaGlzIGNhbiBiZSB1c2VkIGZvciBpbnN0YW5jZSB0byBhdCBsZWFz
dCBwYXJ0aWFsbHkgcmVjb3ZlciB0aGUgZGF0YQ0KPiBmcm9tIHRlcm1pbmFsbHkgY29ycnVwdGVk
IHFjb3cyIGltYWdlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1heCBSZWl0ejxtcmVpdHpAcmVk
aGF0LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZz
ZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

