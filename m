Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E17C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 15:59:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3B842087F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 15:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="X4vyeJXF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B842087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58579 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNg1I-00073f-CU
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 11:59:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hNg0U-0006hr-Ve
	for qemu-devel@nongnu.org; Mon, 06 May 2019 11:58:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hNg0U-0004Zl-4x
	for qemu-devel@nongnu.org; Mon, 06 May 2019 11:58:22 -0400
Received: from mail-eopbgr90098.outbound.protection.outlook.com
	([40.107.9.98]:19296
	helo=FRA01-MR2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hNg0R-0004Wm-Il; Mon, 06 May 2019 11:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Tq9yS1/VkmjCFRczuB2p8+fzxUMOP7R6uALNxpuTAks=;
	b=X4vyeJXF8oBOvmtcxCb35PYy4xOFSHaF6XwoNmLtl47+p3FPlPbaAuRZVjrh6mWu8ax6XkUO+MvXAWNtz8Ht/nOhR1dI/QRdjRMTVoMsnW29H0EdRxHdgDWy2Yo6qY1dRZbkdmunymWT4L3XN4PgrnZBA0QJZulasR2b2/b4xmI=
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com (52.133.109.209) by
	PR2PR08MB4875.eurprd08.prod.outlook.com (52.133.111.15) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1856.12; Mon, 6 May 2019 15:58:16 +0000
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::9c35:2e89:30c4:5cc4]) by
	PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::9c35:2e89:30c4:5cc4%3]) with mapi id 15.20.1856.012;
	Mon, 6 May 2019 15:58:16 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v2 1/5] qcow2: Replace bdrv_write() with
	bdrv_pwrite()
Thread-Index: AQHVAEouSw0YvgTidU2fvE9s7j2/laZeSHCA
Date: Mon, 6 May 2019 15:58:16 +0000
Message-ID: <9a125485-a92a-9583-0491-495304dff31b@virtuozzo.com>
References: <cover.1556732434.git.berto@igalia.com>
	<09c6ad4af497136c11291257ee8bf10608e2b86e.1556732434.git.berto@igalia.com>
In-Reply-To: <09c6ad4af497136c11291257ee8bf10608e2b86e.1556732434.git.berto@igalia.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR02CA0086.eurprd02.prod.outlook.com
	(2603:10a6:7:29::15) To PR2PR08MB4684.eurprd08.prod.outlook.com
	(2603:10a6:101:22::17)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190506185813784
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29a48286-f586-419c-d0f7-08d6d23ba6af
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:PR2PR08MB4875; 
x-ms-traffictypediagnostic: PR2PR08MB4875:
x-microsoft-antispam-prvs: <PR2PR08MB4875FE37F010709485673E9CC1300@PR2PR08MB4875.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(376002)(346002)(39840400004)(136003)(396003)(199004)(189003)(76176011)(8936002)(81166006)(6506007)(36756003)(25786009)(5660300002)(386003)(446003)(8676002)(478600001)(2501003)(71200400001)(71190400001)(256004)(99286004)(52116002)(81156014)(68736007)(7736002)(66066001)(305945005)(31696002)(102836004)(4326008)(31686004)(186003)(229853002)(6512007)(2906002)(86362001)(6486002)(316002)(53936002)(6436002)(54906003)(110136005)(64756008)(66446008)(66556008)(3846002)(66476007)(6116002)(73956011)(486006)(66946007)(6246003)(476003)(2616005)(26005)(11346002)(14454004)(558084003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:PR2PR08MB4875;
	H:PR2PR08MB4684.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8w4CpDtwldlMPCTfN9mskLssoVYKsHZGxK+gYCXEzd4zU8+30vA9MuiGsmpfCVHCBtW21zdqQlzkJg5/DGSxnmEAkVXbvdoy6ygX2lpQXzdL3o+PLgDjMoqYmdL0K5f1r7RVEBpYF7pbxWsoDtWTwJQ/1nT+WS9Pln8Wk5cThdDVvISThRRL4z7nRX+6HpqDmYC9hr8VJscs861/FdEgMNV8giPKIxxyPBgd/aTd+4FQUK5TjuYIZRHqe8GEh03bpYja9eI9Rx6aMmoimd2lR8nSVlWfD2PDdq+h5fRZoWsqK9Y25q7fGf2s/1yZxwWfqSNtHAhqSr4QiBwNUuWUUhGan4wKYeKf3uBz+meHfm5U4eApPESQpzAQ6M4OiMHmTfOG77xtRNT19AOF/2XS/byYKmP/Sl6dkveGZaF6IYI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A7FCDAA8EE0F74FBC9B7850DFD5D7B2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a48286-f586-419c-d0f7-08d6d23ba6af
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 15:58:16.3639 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4875
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.9.98
Subject: Re: [Qemu-devel] [PATCH v2 1/5] qcow2: Replace bdrv_write() with
 bdrv_pwrite()
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
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMDUuMjAxOSAyMToxMywgQWxiZXJ0byBHYXJjaWEgd3JvdGU6DQo+IFRoZXJlJ3Mgb25seSBv
bmUgYmRydl93cml0ZSgpIGNhbGwgbGVmdCBpbiB0aGUgcWNvdzIgY29kZSwgYW5kIGl0IGNhbg0K
PiBiZSB0cml2aWFsbHkgcmVwbGFjZWQgd2l0aCB0aGUgYnl0ZS1iYXNlZCBiZHJ2X3B3cml0ZSgp
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxiZXJ0byBHYXJjaWEgPGJlcnRvQGlnYWxpYS5jb20+
DQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292
QHZpcnR1b3p6by5jb20+DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

