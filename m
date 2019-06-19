Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E3CC31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 14:59:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26FAD2183F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 14:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SV6u5ly+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26FAD2183F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39036 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdc3G-0000K6-EP
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 10:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34448)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hdc0d-0005fm-Ae
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 10:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hdbrD-0007ee-PI
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 10:46:40 -0400
Received: from mail-eopbgr40093.outbound.protection.outlook.com
 ([40.107.4.93]:6139 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hdbrC-0007dJ-7W; Wed, 19 Jun 2019 10:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRvrU3LZiZw3tVPsdr6moX8b2gcFhusOeTz5VkNaX1o=;
 b=SV6u5ly+LYvkLRqHfjBYrflQ+1tbFV7J84KbL6EmdA41sTXkokf4CQNHDKAXwQSkJA4BRyP92Q+X/AcdpA88MJEdr5hgJ4dgi2LBDz8xSObtAO+3oIYwFUL5XYovsIEb8Q9LeWfFZED7rwYfrXspB0kSx7cnymvY+ZJ6bmsIK5Q=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB4693.eurprd08.prod.outlook.com (10.255.79.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Wed, 19 Jun 2019 14:46:34 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Wed, 19 Jun 2019
 14:46:34 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH] blockjob: drain all job nodes in block_job_drain
Thread-Index: AQHVJq2QOzg+1AC+HUSzTbd1CqQZBaajDjYA
Date: Wed, 19 Jun 2019 14:46:34 +0000
Message-ID: <945ff3d7-fdb5-64ee-7af3-e45ce5e713e7@virtuozzo.com>
References: <20190619144447.215894-1-vsementsov@virtuozzo.com>
 <20190619144447.215894-2-vsementsov@virtuozzo.com>
In-Reply-To: <20190619144447.215894-2-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0401CA0056.eurprd04.prod.outlook.com
 (2603:10a6:3:19::24) To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190619174632295
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2a34a4b-a1b4-47f6-4743-08d6f4c4ecda
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4693; 
x-ms-traffictypediagnostic: DBBPR08MB4693:
x-microsoft-antispam-prvs: <DBBPR08MB4693182823C26A1ADFAEF485C1E50@DBBPR08MB4693.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0073BFEF03
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(39850400004)(376002)(366004)(346002)(199004)(189003)(8936002)(31696002)(71200400001)(71190400001)(6486002)(446003)(6116002)(4744005)(26005)(73956011)(6246003)(53936002)(66946007)(6436002)(486006)(2616005)(229853002)(11346002)(64756008)(476003)(14454004)(3846002)(81166006)(76176011)(4326008)(2501003)(305945005)(81156014)(5660300002)(6512007)(66556008)(36756003)(478600001)(86362001)(8676002)(66446008)(66066001)(256004)(66476007)(2906002)(7736002)(6506007)(52116002)(25786009)(386003)(99286004)(110136005)(186003)(68736007)(31686004)(54906003)(316002)(102836004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4693;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MZxI2E+RubiQQuoG5bQmp4xed3qn5kwNrGn7rrhfOaLuPckzXt4t5QKmwUDVciQP8t5WXPDXkyps8hal6MUIum0Rat6Fwbh+VtXDji2xCwEtNAOjrkE4hiHHRR6pkl0bYHKi4a2mRs9ehsUIJt0HLCLQUiTNWf40HgKgL05obZAcf4rYdy3o2HHkL5rvoidnVMjKA/HUzAUNMg0bjRdO2Jqh82uRglqGuW9QrbjZOkDkOXzRN2zqAIWbpBa1i/gfeiRV3K/Ojg3b/Oe6pudTAwZj+k9MsPIEBYFMbu1yoqUpDC1pklBtm4Gd85U0HWjopaKX6PYjRM+9Pm69YE7e9/2XF915bxWUDxE0dDqGx4k6316Gzw4BiCHz4Laq1K0k6STN+g0aP0dgo8+ZY5utSzdV5QDVCbiwipVEtc7IsMs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <42C91C70C8AA274ABA64DF111B22A02F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a34a4b-a1b4-47f6-4743-08d6f4c4ecda
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2019 14:46:34.7517 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4693
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.93
Subject: Re: [Qemu-devel] [PATCH] blockjob: drain all job nodes in
 block_job_drain
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
 "jsnow@redhat.com" <jsnow@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTkuMDYuMjAxOSAxNzo0NCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
SW5zdGVhZCBvZiBkcmFpbmluZyBhZGRpdGlvbmFsIG5vZGVzIGluIGVhY2ggam9iIGNvZGUsIGxl
dCdzIGRvIGl0IGluDQo+IGNvbW1vbiBibG9ja19qb2JfZHJhaW4sIGRyYWluaW5nIGp1c3QgYWxs
IGpvYidzIGNoaWxkcmVuLg0KPiANCj4gSXQncyBhbHNvIGEgZmlyc3Qgc3RlcCB0byBmaW5hbGx5
IGdldCByaWQgb2YgYmxvY2tqb2ItPmJsay4NCg0KT29wcywgc29ycnkgZm9yIGRvdWJsZS1zZW5k
aW5nLg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

