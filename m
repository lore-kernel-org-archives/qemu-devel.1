Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC94FC10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 07:24:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83CF520693
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 07:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WyhXxJY2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83CF520693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60556 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGIS2-00041v-NW
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 03:24:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hGIRG-0003gA-Fp
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 03:23:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hGIRF-0004fg-KS
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 03:23:30 -0400
Received: from mail-eopbgr80112.outbound.protection.outlook.com
	([40.107.8.112]:60293
	helo=EUR04-VI1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hGIRF-0004eD-An; Tue, 16 Apr 2019 03:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=+bU2g9NwWmO8I+4Z1Be1RBTtxfWys+YUtYHTmcYiqmE=;
	b=WyhXxJY28tGnI4cpU6Zj5r17Dga13Z7B5OebZBfbdfYGn84Axtd6G1GFzUXWLVmuzJnyz42C5eg9DvrHsBv/TIZFwMnr7L/1eJVIdADopW2rzAXPcXIk4bYRXYoxQJ007xeMxGelzrm3afCU/Izhy6tyR/bwkYZV9pjrrrO1Zw8=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3434.eurprd08.prod.outlook.com (20.176.238.143) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1792.19; Tue, 16 Apr 2019 07:23:25 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1792.018;
	Tue, 16 Apr 2019 07:23:25 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>
Thread-Topic: [PATCH v3 5/7] blkdebug: Inject errors on .bdrv_co_block_status()
Thread-Index: AQHU8hl/61Bo3tM0C0K5UckZh5eG96Y+ZlmA
Date: Tue, 16 Apr 2019 07:23:25 +0000
Message-ID: <511c0daa-4094-08af-5a8b-ec86a8a3250f@virtuozzo.com>
References: <20190413165343.9018-1-mreitz@redhat.com>
	<20190413165343.9018-6-mreitz@redhat.com>
In-Reply-To: <20190413165343.9018-6-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0142.eurprd05.prod.outlook.com
	(2603:10a6:7:28::29) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190416102323286
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 363f2ea6-68b8-4ed7-cc3a-08d6c23c6a2d
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3434; 
x-ms-traffictypediagnostic: DB7PR08MB3434:
x-microsoft-antispam-prvs: <DB7PR08MB3434B0ED2C84A4C67E7A4615C1240@DB7PR08MB3434.eurprd08.prod.outlook.com>
x-forefront-prvs: 000947967F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(366004)(39840400004)(376002)(346002)(396003)(199004)(189003)(11346002)(31686004)(52116002)(8676002)(256004)(31696002)(66066001)(6246003)(86362001)(102836004)(81156014)(81166006)(8936002)(2501003)(54906003)(110136005)(386003)(6506007)(107886003)(478600001)(2906002)(68736007)(6116002)(26005)(76176011)(3846002)(36756003)(25786009)(558084003)(229853002)(6512007)(53936002)(99286004)(186003)(71190400001)(14454004)(6436002)(486006)(7736002)(4326008)(5660300002)(476003)(305945005)(2616005)(106356001)(6486002)(316002)(446003)(71200400001)(105586002)(97736004)(142923001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3434;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HrYx/CySOmX39SWeNzXNaWitffBnMwCPpikbxTn0wD1P/DekYagrMl2F9shCU3BB5yB5e8slaasDwDDHvL//Hu/jRh0q8avHiFJ4XRI6n5Um4SfUCG7rZYHwAY5yR7oWgq5ITDpDrjo37bciLDmx+jU41tuQyofe1XRgE7nfLC2U5deBW2WtJaNd/aPEs5vQnT6zBjiHnKQKq74BkDr1UMXfPH1k5buDhlWfq9WWvIRmxTu1J2MfIyxFmA9pM1CB5CJCQyYmGye/1jHP8stjC69iDIPSfoucS++olxigZ7YyTCuWirb/MM0YT7e8ytaNuP8HSh9TzHuyDugr1n/+g1Uv7AUjh+QqN8gOncc7Xw5cAXkhpA8sr7PMM+T9Gf7BplwKzvyYn54J3yqsBfUG8216WIdfcDN113796NAlOko=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <02B01EDD96207E47A8BBCB161C69E21A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 363f2ea6-68b8-4ed7-cc3a-08d6c23c6a2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2019 07:23:25.6797 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3434
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.112
Subject: Re: [Qemu-devel] [PATCH v3 5/7] blkdebug: Inject errors on
 .bdrv_co_block_status()
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
Message-ID: <20190416072325.pu4EE85gp3oKJA2BeZypbEhJ04nbgZ18JxC0h7dsIb4@z>

MTMuMDQuMjAxOSAxOTo1MywgTWF4IFJlaXR6IHdyb3RlOg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXgg
UmVpdHo8bXJlaXR6QHJlZGhhdC5jb20+DQo+IFJldmlld2VkLWJ5OiBFcmljIEJsYWtlPGVibGFr
ZUByZWRoYXQuY29tPg0KDQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZz
a2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxh
ZGltaXINCg==

