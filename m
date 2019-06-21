Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30B9C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 15:23:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B110B2075E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 15:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Kq0dZ0Im"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B110B2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36086 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heLON-0001SK-OX
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 11:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54884)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1heLJJ-0005WN-Ce
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 11:18:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1heLJI-0000pP-7z
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 11:18:41 -0400
Received: from mail-eopbgr30106.outbound.protection.outlook.com
 ([40.107.3.106]:23168 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1heLJC-0000aP-GP; Fri, 21 Jun 2019 11:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hctVxOzZwtuqioRjCAbvTM42v+4efhc5p6Qic41cDNs=;
 b=Kq0dZ0ImOk6AcAa7bAVwFik8PsBVMRV1Csq2my628TR1zA420vf3/h4qZt98W+IXPk4FSQJWn8/SpM+c0LIQ3vN+BONnam220vhcGulMCJnZf6MRiNvT+W/tOHJBdc6EZZpch4H/uUAET4brd10Gvqiw9JTKDKLMs0qAzJLde2U=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB4789.eurprd08.prod.outlook.com (20.179.45.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Fri, 21 Jun 2019 15:18:31 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 15:18:31 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v2] blockjob: drain all job nodes in block_job_drain
Thread-Index: AQHVKEQzLXk/WgU960uWEd/4266Yq6amOKCA
Date: Fri, 21 Jun 2019 15:18:31 +0000
Message-ID: <c0b5683c-98d4-5ca6-667a-67e5506968fe@virtuozzo.com>
References: <20190621151538.30384-1-vsementsov@virtuozzo.com>
 <20190621151538.30384-2-vsementsov@virtuozzo.com>
In-Reply-To: <20190621151538.30384-2-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0230.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::30) To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190621181829011
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c77044e4-ed6d-4d31-f158-08d6f65bb833
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4789; 
x-ms-traffictypediagnostic: DBBPR08MB4789:
x-microsoft-antispam-prvs: <DBBPR08MB478984997445A8D4DCB79642C1E70@DBBPR08MB4789.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:83;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(346002)(136003)(366004)(376002)(39850400004)(396003)(199004)(189003)(6116002)(99286004)(446003)(2906002)(6246003)(54906003)(26005)(2616005)(305945005)(25786009)(86362001)(68736007)(6436002)(6486002)(102836004)(6506007)(486006)(7736002)(4326008)(256004)(76176011)(11346002)(4744005)(2501003)(53936002)(386003)(31696002)(66066001)(52116002)(8936002)(81156014)(81166006)(110136005)(3846002)(71190400001)(66556008)(316002)(5660300002)(64756008)(478600001)(66946007)(186003)(229853002)(31686004)(66476007)(14454004)(71200400001)(36756003)(8676002)(476003)(66446008)(73956011)(6512007)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4789;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bgq4nFoMqeDikeaRnXskpb58EUbe6+TCa+kkHs4gzor3FJqHixwv19Hb6tqclppvAuKNRRlppwnneqHMgy2OOfUNdhvHg8t1a97gSuv9CLxn1DHv3Rw+/+xFOFff6sW4CJA4c/xTeH2UunvmxooWwag/bhWrv64/BA5P89deuvG9j3I23rnxxJZ1eJia5dFku7xkfOWm3gG5Ll0d/55WXrnOhQlRDHo5EHgtJiuI84NGYITTwhclXumzxU6IOQgAmZ/7iBUeylK6mAJBMOTwTO8oGOWuTE1cavQQg8GdBDp82twCLdqJXubLd1Ml0zXY8Xzf34q9RXY0NUECP/LzbpF2TZTGnJYU6uT+anMY+OYlmXo6ynepb+ue+Ugy3PXdUcnPUWobY3haBsasQo+L/eAaTTvDXD3nfbJlf4NyRyE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1442ACDA94AE545A0766E34985D76EB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c77044e4-ed6d-4d31-f158-08d6f65bb833
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 15:18:31.5710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4789
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.106
Subject: Re: [Qemu-devel] [PATCH v2] blockjob: drain all job nodes in
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

MjEuMDYuMjAxOSAxODoxNSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
SW5zdGVhZCBvZiBkcmFpbmluZyBhZGRpdGlvbmFsIG5vZGVzIGluIGVhY2ggam9iIGNvZGUsIGxl
dCdzIGRvIGl0IGluDQo+IGNvbW1vbiBibG9ja19qb2JfZHJhaW4sIGRyYWluaW5nIGp1c3QgYWxs
IGpvYidzIGNoaWxkcmVuLg0KPiBCbG9ja0pvYkRyaXZlci5kcmFpbiBiZWNvbWVzIHVudXNlZCwg
c28sIGRyb3AgaXQgYXQgYWxsLg0KPiANCj4gSXQncyBhbHNvIGEgZmlyc3Qgc3RlcCB0byBmaW5h
bGx5IGdldCByaWQgb2YgYmxvY2tqb2ItPmJsay4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFZsYWRp
bWlyIFNlbWVudHNvdi1PZ2lldnNraXk8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQpPZ2gs
IGRvdWJsZSBzZW5kaW5nIGFnYWluLCBJIGZlZWwgbGlrZSBhbiBpZGlvdCA6KA0KDQpDZXJ0YWlu
bHksIEkndmUganVzdCBwcmVzc2VkIEN0cmwrUiwgYW5kIGZpeGVkIGxhc3QgYXJndW1lbnQgdG8g
djIsIHNvcnJ5Lg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

