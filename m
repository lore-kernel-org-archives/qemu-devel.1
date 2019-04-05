Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCF8C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 14:16:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4033721850
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 14:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="euyXXxEA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4033721850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42706 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCPda-00022i-EM
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 10:16:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hCPbg-0000l2-BF
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 10:14:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hCPbf-0004fw-DZ
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 10:14:12 -0400
Received: from mail-eopbgr150107.outbound.protection.outlook.com
	([40.107.15.107]:22336
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hCPbX-0004PT-KT; Fri, 05 Apr 2019 10:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=LGU0hKeWN8JypddQBDZEW1Cvi8lrqqFd9Ryn9Zy3xVw=;
	b=euyXXxEASGPqjuffK30oXybEhJGLigEtphAEqyU/rwtdK0ncaRBVnIkFN110JE4wEsxge0ZZBZ18V/m49Zy96mJTWr1sIPylg9RCMmM8SSxnaaYUSymQ0NECLEE2etavWBF3+yPblMHf4HLEM7eA6q1vV/Amk8gGN7dhwXHeY74=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3243.eurprd08.prod.outlook.com (52.134.111.17) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1750.19; Fri, 5 Apr 2019 14:13:58 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%2]) with mapi id 15.20.1750.017;
	Fri, 5 Apr 2019 14:13:58 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
Thread-Topic: [PATCH 1/7] nbd/server: Fix blockstatus trace
Thread-Index: AQHU6cocK8jWkrSt70+VETZEbFqarKYtoAaA
Date: Fri, 5 Apr 2019 14:13:58 +0000
Message-ID: <0fbd8e9e-c168-9f04-3982-b5d9b3088cb1@virtuozzo.com>
References: <20190403030526.12258-1-eblake@redhat.com>
	<20190403030526.12258-2-eblake@redhat.com>
In-Reply-To: <20190403030526.12258-2-eblake@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P192CA0021.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::31)
	To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190405171355229
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72db1c89-b774-4a3f-924f-08d6b9d0f217
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
	SRVR:DB7PR08MB3243; 
x-ms-traffictypediagnostic: DB7PR08MB3243:
x-microsoft-antispam-prvs: <DB7PR08MB324322C4CB038B9C3AA012D8C1510@DB7PR08MB3243.eurprd08.prod.outlook.com>
x-forefront-prvs: 0998671D02
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(376002)(396003)(39850400004)(346002)(366004)(189003)(199004)(5660300002)(86362001)(102836004)(71200400001)(476003)(2501003)(81166006)(106356001)(25786009)(11346002)(6506007)(8676002)(66066001)(105586002)(256004)(486006)(7736002)(8936002)(2616005)(6246003)(3846002)(186003)(446003)(81156014)(2906002)(31696002)(26005)(305945005)(4744005)(97736004)(4326008)(31686004)(316002)(52116002)(71190400001)(6486002)(76176011)(229853002)(53936002)(6116002)(68736007)(478600001)(386003)(6436002)(14454004)(36756003)(110136005)(54906003)(99286004)(6512007);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3243;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dJmSF/MzRC6zb5mSKRxyGlWpMfW3poKFnsK5CYkH+0J6qUwbJI3pu7Ljfb+2GCk+1eieW4k+lS6830fnJyS4aLxzjOUzzsVSlQo5HnnD/reqlCGft+VzqXmB1Jaif1Ks1dnnUAK2y2WZpjqWJQHtJlmjzt7U32qTJ20Eco8JVOOyDo1AZW51OYipnLWVVAS519txClG1e4c1qgBJiNcipRUgiWAhx1Bt6LlDMiubXcydGZp1C2j6ERzORuwdAlFFdktCtRXZipMh+1yBva2HhYdQ7n1eyrdj5uXA6YVF87t6PmNhBx7os7KkttfCGcmygJ+KjG4M1OsaJZAjljZIrqOt38Hk9/rsGKW50PdlwyBiOP1kV/UFtNIkYgwsGW1D/9rgGIUbEzLSbCNPYCR4JBGmdcON5BzkhwiC+xa77A4=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <DFE96042C696CB47B3ED10B9F0D0ED4F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72db1c89-b774-4a3f-924f-08d6b9d0f217
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2019 14:13:58.8713 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3243
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.107
Subject: Re: [Qemu-devel] [PATCH 1/7] nbd/server: Fix blockstatus trace
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
Cc: "jsnow@redhat.com" <jsnow@redhat.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405141358.41NJvTaQHHT9xm7oy-HsD9xpTQm_hfgEPRpR6nyLTyo@z>

MDMuMDQuMjAxOSA2OjA1LCBFcmljIEJsYWtlIHdyb3RlOg0KPiBEb24ndCBpbmNyZW1lbnQgcmVt
YWluaW5nX2J5dGVzIHVudGlsIHdlIGtub3cgdGhhdCB3ZSB3aWxsIGFjdHVhbGx5IGJlDQo+IGlu
Y2x1ZGluZyB0aGUgY3VycmVudCBibG9jayBzdGF0dXMgZXh0ZW50IGluIHRoZSByZXBseTsgb3Ro
ZXJ3aXNlLCB0aGUNCj4gdmFsdWUgdHJhY2VkIHdpbGwgaW5jbHVkZSBhIGJ5dGVzIHZhbHVlIHRo
YXQgaXMgb3ZlcnNpemVkIGJ5IHRoZQ0KPiBsZW5ndGggb2YgdGhlIG5leHQgYmxvY2sgc3RhdHVz
IGV4dGVudCB3aGljaCBkaWQgbm90IGdldCBzZW50IGJlY2F1c2UNCj4gaXQgaW5zdGVhZCBlbmRl
ZCB0aGUgbG9vcC4NCj4gDQo+IEZpeGVzOiBmYjdhZmM3OQ0KPiBTaWduZWQtb2ZmLWJ5OiBFcmlj
IEJsYWtlIDxlYmxha2VAcmVkaGF0LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVu
dHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KDQotLSANCkJlc3Qg
cmVnYXJkcywNClZsYWRpbWlyDQo=

