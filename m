Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A49C31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 12:13:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8CBE208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 12:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QAQEzsQp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8CBE208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50810 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbl58-0005BD-Vg
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 08:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51143)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbkzY-0001sf-1m
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 08:07:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbkzR-0001Nt-Tz
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 08:07:32 -0400
Received: from mail-eopbgr30097.outbound.protection.outlook.com
 ([40.107.3.97]:13381 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbkzM-0001Fv-Ib; Fri, 14 Jun 2019 08:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kq2T06MZAlF7SvGhswhKFL2qzhUsOZ/JLIvBrwF7cRg=;
 b=QAQEzsQp/s0hASyd/3EQsEVA1Papp7NGgOEW4jlDZgGoqrgIRlSEH22uiCwRFZaWnsORyzvgFF3sKQNCOzcL8k7TMOehvtOZiMcIsfxC1OMfsc/EkWvKOYYsGDik6qtfO1BvpX8HBbd4bQvTDzx2LOs1k+bu83dRDnB3/W9I22s=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB4371.eurprd08.prod.outlook.com (20.179.34.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Fri, 14 Jun 2019 12:07:16 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Fri, 14 Jun 2019
 12:07:16 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 13/42] block: Use CAFs in block status functions
Thread-Index: AQHVIWutLhYTYoI3/kyFcZDFRaPoLKabEJAA
Date: Fri, 14 Jun 2019 12:07:16 +0000
Message-ID: <9313f632-58be-3830-9f47-2a381783bb74@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-14-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-14-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0502CA0018.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::28) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190614150714022
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31f98ed0-ab32-49d5-3aad-08d6f0c0d765
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB4371; 
x-ms-traffictypediagnostic: AM0PR08MB4371:
x-microsoft-antispam-prvs: <AM0PR08MB4371B9AE66DA72F34945B1FDC1EE0@AM0PR08MB4371.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:935;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(346002)(376002)(396003)(136003)(366004)(189003)(199004)(81156014)(81166006)(73956011)(66476007)(66946007)(386003)(6506007)(66446008)(64756008)(52116002)(99286004)(31686004)(66556008)(229853002)(76176011)(6486002)(102836004)(26005)(446003)(2616005)(2906002)(11346002)(6116002)(3846002)(476003)(6436002)(186003)(486006)(36756003)(305945005)(8936002)(25786009)(7736002)(8676002)(558084003)(478600001)(66066001)(14454004)(316002)(4326008)(14444005)(6246003)(54906003)(110136005)(5660300002)(256004)(53936002)(2501003)(68736007)(6512007)(31696002)(86362001)(71200400001)(71190400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4371;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KOWuDkexy4lMaz23qS6p8Oc0acYaiq1Wc+3HXywKaJ/4p6Jh/h5EO5q8RHWa4of3E2+McIvNNPR1/HUaZKsH0cwjt3QKMvoud38gWvkjuXByfW4IPJ/5gnffdI05NKBtudWbQihRN3twotCrq1zMC9TBM7SPEZ1fHH1/5f89MnY+bMKQLklxUwtNZWMUz5z/iLmjkx/FMyp2AillkkBJPwiAeKV6QgXc1QA+TCAcjAfQTpdIc5a9g9sR11xryuTPPCDKKqPCvnRslZclfwSidDgsc6s+gp147wEzChFUJ6LV5RAe3egb3fZlk2GDNwSX59/L1tjQw2aP9/Du7s0TwudS+mucpnfg7xXQLN0kPokVgBx5cgAEMxH0SuojbPAKDAdwBtZxpIZwPRzdwH0pHGfsT17Gi+VKvoF+mIyNrGo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0814C7E23B1EC24E81FE0E073A187E4F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f98ed0-ab32-49d5-3aad-08d6f0c0d765
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 12:07:16.3303 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4371
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.97
Subject: Re: [Qemu-devel] [PATCH v5 13/42] block: Use CAFs in block status
 functions
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTMuMDYuMjAxOSAxOjA5LCBNYXggUmVpdHogd3JvdGU6DQo+IFVzZSB0aGUgY2hpbGQgYWNjZXNz
IGZ1bmN0aW9ucyBpbiB0aGUgYmxvY2sgc3RhdHVzIGlucXVpcnkgZnVuY3Rpb25zIGFzDQo+IGFw
cHJvcHJpYXRlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWF4IFJlaXR6PG1yZWl0ekByZWRoYXQu
Y29tPg0KDQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2Vt
ZW50c292QHZpcnR1b3p6by5jb20+DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

