Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675D0C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 11:02:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39DF121473
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 11:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="E6Wd9lf8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39DF121473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38468 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbNUd-00072b-Ed
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 07:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40325)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbNRV-0004Yf-Oh
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 06:58:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbNIt-0006xn-IH
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 06:50:00 -0400
Received: from mail-eopbgr20091.outbound.protection.outlook.com
 ([40.107.2.91]:53199 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbNIt-0006wb-At; Thu, 13 Jun 2019 06:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HurbAEzvgTaFhN4nbkXkodyJSegrPzbCFH9Ka9gW8mo=;
 b=E6Wd9lf8sCBLeJb2olrmbdmWz7DXMXRDHj18+QHDS4On6tqXHpegkVmKAVAIsz+WicCM4vC/hqqBFCtDgMjFG6tRz96WFTjGa7gUZAmaRWUH798Lj3P6epu6Aqm0/hjLKFWWNT/1SyfmUOYk7nQDDAzjITUt6R2MFmtXMU9YCc4=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB4241.eurprd08.prod.outlook.com (20.179.32.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Thu, 13 Jun 2019 10:49:56 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 10:49:56 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 02/42] copy-on-read: Support compressed writes
Thread-Index: AQHVIWudX4hM59glqESSlp4wCWaaAqaZaKGA
Date: Thu, 13 Jun 2019 10:49:56 +0000
Message-ID: <cc9a6947-eb08-4fc2-27e5-e10bfcab84e8@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-3-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-3-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0275.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::27) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190613134955065
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f22f7407-f41e-4fe5-621a-08d6efecdfcd
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB4241; 
x-ms-traffictypediagnostic: AM0PR08MB4241:
x-microsoft-antispam-prvs: <AM0PR08MB4241010EB0BE94D8125A41C5C1EF0@AM0PR08MB4241.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:332;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39850400004)(136003)(346002)(376002)(366004)(199004)(189003)(52116002)(476003)(110136005)(99286004)(54906003)(486006)(86362001)(6486002)(386003)(6506007)(6436002)(8676002)(81166006)(81156014)(229853002)(8936002)(31696002)(76176011)(186003)(6116002)(71200400001)(2906002)(71190400001)(3846002)(26005)(316002)(102836004)(66066001)(66476007)(66556008)(256004)(2616005)(446003)(14444005)(2501003)(7736002)(305945005)(14454004)(53936002)(6512007)(66446008)(66946007)(73956011)(4326008)(64756008)(478600001)(5660300002)(25786009)(11346002)(6246003)(31686004)(36756003)(68736007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4241;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ziZGfzTPYmmsj9kDgqW/1mT904W4OdqI1RWYrn9YZZ+3mIwYAbWp4vNZLxKu/LgiNmOWiEG6dhBR7nUbGP6GBVUBDc/Iwb/KP52U8WOtZcfKk3Yiiy8yzTI3l8WQrjU7cLcN6KtKsYXVlhvITW6b97oz0f8XdXT8LB9+rlkFfD9byMw8g5Dwz9LE3sWjbRR+AygEZiG57SXHV0S+OMnxU4cf6W294VmLf8umgCLzLDoXnKxHACPvoTLV9ToP9FOsXuYNbIrn6Z5H+tKQEJvrANcmpO+pypd5sjduCXloR1rt9Pl6QbDkiMIfv638UQJsRJbF+JxErPtekOKBZqrf27O9ZxQOk0a362TPCGZUyIogOU50n9zSnBsvMJkjbVOcXEQzpVC85Qypm/f4pfQECWKctSWRcdYIyQRHc1Da+cE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C76BE68D3D23DB4E88E308411292BCC7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f22f7407-f41e-4fe5-621a-08d6efecdfcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 10:49:56.7742 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4241
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.91
Subject: Re: [Qemu-devel] [PATCH v5 02/42] copy-on-read: Support compressed
 writes
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

MTMuMDYuMjAxOSAxOjA5LCBNYXggUmVpdHogd3JvdGU6DQo+IFNpZ25lZC1vZmYtYnk6IE1heCBS
ZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRz
b3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQoNCj4gLS0tDQo+ICAgYmxv
Y2svY29weS1vbi1yZWFkLmMgfCAxMSArKysrKysrKysrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAx
MSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYmxvY2svY29weS1vbi1yZWFkLmMg
Yi9ibG9jay9jb3B5LW9uLXJlYWQuYw0KPiBpbmRleCA1Mzk3MmIxZGEzLi44OGUxYzFmNTM4IDEw
MDY0NA0KPiAtLS0gYS9ibG9jay9jb3B5LW9uLXJlYWQuYw0KPiArKysgYi9ibG9jay9jb3B5LW9u
LXJlYWQuYw0KPiBAQCAtMTE0LDYgKzExNCwxNiBAQCBzdGF0aWMgaW50IGNvcm91dGluZV9mbiBj
b3JfY29fcGRpc2NhcmQoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+ICAgfQ0KPiAgIA0KPiAgIA0K
PiArc3RhdGljIGludCBjb3JvdXRpbmVfZm4gY29yX2NvX3B3cml0ZXZfY29tcHJlc3NlZChCbG9j
a0RyaXZlclN0YXRlICpicywNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdWludDY0X3Qgb2Zmc2V0LA0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCBieXRlcywNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUUVNVUlPVmVjdG9yICpx
aW92KQ0KPiArew0KPiArICAgIHJldHVybiBiZHJ2X2NvX3B3cml0ZXYoYnMtPmZpbGUsIG9mZnNl
dCwgYnl0ZXMsIHFpb3YsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBCRFJWX1JFUV9X
UklURV9DT01QUkVTU0VEKTsNCj4gK30NCg0KSG1tLCBwb3NzaWJseSBpdCdzIGJldHRlciB0byBo
YW5kbGUgc3VwcG9ydCBvZiBjb21wcmVzc2lvbiBieSBjaGVja2luZyBzdXBwb3J0ZWQNCmZsYWdz
DQoNCj4gKw0KPiArDQo+ICAgc3RhdGljIHZvaWQgY29yX2VqZWN0KEJsb2NrRHJpdmVyU3RhdGUg
KmJzLCBib29sIGVqZWN0X2ZsYWcpDQo+ICAgew0KPiAgICAgICBiZHJ2X2VqZWN0KGJzLT5maWxl
LT5icywgZWplY3RfZmxhZyk7DQo+IEBAIC0xNDYsNiArMTU2LDcgQEAgc3RhdGljIEJsb2NrRHJp
dmVyIGJkcnZfY29weV9vbl9yZWFkID0gew0KPiAgICAgICAuYmRydl9jb19wd3JpdGV2ICAgICAg
ICAgICAgICAgICAgICA9IGNvcl9jb19wd3JpdGV2LA0KPiAgICAgICAuYmRydl9jb19wd3JpdGVf
emVyb2VzICAgICAgICAgICAgICA9IGNvcl9jb19wd3JpdGVfemVyb2VzLA0KPiAgICAgICAuYmRy
dl9jb19wZGlzY2FyZCAgICAgICAgICAgICAgICAgICA9IGNvcl9jb19wZGlzY2FyZCwNCj4gKyAg
ICAuYmRydl9jb19wd3JpdGV2X2NvbXByZXNzZWQgICAgICAgICA9IGNvcl9jb19wd3JpdGV2X2Nv
bXByZXNzZWQsDQo+ICAgDQo+ICAgICAgIC5iZHJ2X2VqZWN0ICAgICAgICAgICAgICAgICAgICAg
ICAgID0gY29yX2VqZWN0LA0KPiAgICAgICAuYmRydl9sb2NrX21lZGl1bSAgICAgICAgICAgICAg
ICAgICA9IGNvcl9sb2NrX21lZGl1bSwNCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFk
aW1pcg0K

