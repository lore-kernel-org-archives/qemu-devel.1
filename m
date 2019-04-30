Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC9FC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 18:10:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0CB820854
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 18:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MlU2d9DR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0CB820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51375 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLXDK-0007Us-Hq
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 14:10:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hLXAw-0005Aa-9O
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 14:08:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hLWtp-0001eD-T2
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:50:38 -0400
Received: from mail-eopbgr120108.outbound.protection.outlook.com
	([40.107.12.108]:45493
	helo=FRA01-PR2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hLWtp-0001ct-8v; Tue, 30 Apr 2019 13:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=RG60PN6eM8Z74Ui2eAMlkpKGmjXSTv0A8plLSCpAVK8=;
	b=MlU2d9DRtStL34taDfMwpLTEdNDhoomj1lE/9i8v5a8hYmLz3RGfLOHToOemRXHvEEgP0oXVff1OKqsFiVUF+PutrcFjdZYCAFHBfAYaGJ0pWfZrvM1FwYDq0v5I2v7hCNBW61unccBDZo6wUZfBf9Lk42XXf9+92KvWcm9zjyw=
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com (52.133.109.209) by
	PR2PR08MB4634.eurprd08.prod.outlook.com (52.133.109.14) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.15; Tue, 30 Apr 2019 17:50:33 +0000
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::88d7:ecf0:1120:f1a1]) by
	PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::88d7:ecf0:1120:f1a1%3]) with mapi id 15.20.1835.018;
	Tue, 30 Apr 2019 17:50:33 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>
Thread-Topic: [PATCH v6 0/7] NBD reconnect
Thread-Index: AQHU8IvOCpyInqV0y0qAbRG9faO+L6ZVGU6A
Date: Tue, 30 Apr 2019 17:50:33 +0000
Message-ID: <b723d58c-6b96-4848-a1b6-5fa1be852423@email.android.com>
In-Reply-To: <20190411172709.205032-1-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P18901CA0011.EURP189.PROD.OUTLOOK.COM
	(2603:10a6:3:8b::21) To PR2PR08MB4684.eurprd08.prod.outlook.com
	(2603:10a6:101:22::17)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-android-message-id: <b723d58c-6b96-4848-a1b6-5fa1be852423@email.android.com>
x-originating-ip: [31.173.82.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 864c0019-a3e4-4fc9-ab81-08d6cd9457cb
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:PR2PR08MB4634; 
x-ms-traffictypediagnostic: PR2PR08MB4634:
x-microsoft-antispam-prvs: <PR2PR08MB4634D9A2C876EB877BF6F833C13A0@PR2PR08MB4634.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(39850400004)(376002)(136003)(396003)(366004)(199004)(189003)(486006)(6486002)(73956011)(316002)(9686003)(66446008)(66946007)(305945005)(478600001)(558084003)(110136005)(6512007)(31696002)(6436002)(64756008)(66556008)(66476007)(476003)(54896002)(71190400001)(71200400001)(14454004)(6246003)(2501003)(53936002)(5660300002)(86362001)(25786009)(186003)(256004)(102836004)(4270600006)(8936002)(8676002)(81156014)(6116002)(26005)(450100002)(229853002)(31686004)(7736002)(81686011)(99286004)(2906002)(97736004)(3846002)(68736007)(81166006)(52116002)(66066001)(11346002)(6506007)(386003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:PR2PR08MB4634;
	H:PR2PR08MB4684.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U4UNAXpHAJ9c/PegTt409xpcjwBubdTsPNdF1VP/q2vMWkx0YQTtty2wVbKawOdil4bjeqnFMz9ux4BPfkUdHjYSpzW0B94VpUgVB+C4fWb7DM+oLLMkz4C7ElR138y3Ik4vkPxblY35SyEmlfwYDWCKn9Qwn6k4PYAwLwgHBE6oL5TA+ktNKIYaQYt9o0XSbjyy2IMq6H53RdNsSXnoBR3XiNc4aImc6s1iKQK9say5ZU+yePzMQe/rzWugv5+BGP12Hc233WMFFHkZ67lbzf8j+08+fu4BQDNfMd2KwNXNmZe6AvpwPsP9LKQc670U3vPAscVTAvWZ3+9wE17uyt3J6h2pejFId1OmfsD0gl9nkYO3UXDku2HGH2mDGBNhJyY//7stFKqg+TnqtvL077ot+xCbiEU4BsdnH02PTOk=
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 864c0019-a3e4-4fc9-ab81-08d6cd9457cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 17:50:33.6827 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4634
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.12.108
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v6 0/7] NBD reconnect
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430175033.Vsniib_vZ0B23mJS_xxKuPVszUsWm6QEbsI9waNEMrw@z>

UGluZw0KDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K
