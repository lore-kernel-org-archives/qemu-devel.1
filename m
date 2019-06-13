Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7B7C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:46:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FE0F2173C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gY1HiFno"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE0F2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39824 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbQ43-00084h-HC
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 09:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37141)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbOvx-0002Sd-75
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:34:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbOvw-0003fl-5t
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:34:25 -0400
Received: from mail-eopbgr130110.outbound.protection.outlook.com
 ([40.107.13.110]:50759 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbOvt-0003d7-VS; Thu, 13 Jun 2019 08:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFhksAP42AOOMzLyhqQlsvV/zgLRPE9HxD8c4XOvxYc=;
 b=gY1HiFnoFkWUU8IA3ynPQIjq0QkzcttkVNJzrAGa5wlgWQqD34oNn4W8LV1cVI9eBO83fL01XC55zt0at1sfFteX87pkSSYWfNqrBdSzKjGwFilzickgohR3+cvOse+onLgprvtSgF31S3/slZmFdR+vg4RHRqJJjx/bVCiPxIg=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB2993.eurprd08.prod.outlook.com (52.134.93.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Thu, 13 Jun 2019 12:34:18 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 12:34:18 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 07/42] block: *filtered_cow_child() for
 *has_zero_init()
Thread-Index: AQHVIWukwmJujP4kzkuWB6iZnHixvKaZhckA
Date: Thu, 13 Jun 2019 12:34:18 +0000
Message-ID: <e8485e27-3dfd-7275-11a9-b356b9ca2219@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-8-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-8-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0029.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::18) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190613153415949
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74b9bbb0-c01c-4cd6-232c-08d6effb73ea
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB2993; 
x-ms-traffictypediagnostic: AM0PR08MB2993:
x-microsoft-antispam-prvs: <AM0PR08MB29930AFDEAE97B53759CFEDCC1EF0@AM0PR08MB2993.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(376002)(346002)(39850400004)(366004)(189003)(199004)(486006)(6506007)(2501003)(386003)(99286004)(8936002)(31686004)(71200400001)(64756008)(11346002)(478600001)(66946007)(66476007)(76176011)(305945005)(7736002)(68736007)(52116002)(2616005)(229853002)(6246003)(73956011)(66446008)(66556008)(446003)(476003)(31696002)(4326008)(6512007)(36756003)(256004)(3846002)(54906003)(5660300002)(71190400001)(66066001)(86362001)(6486002)(53936002)(6436002)(81156014)(26005)(110136005)(25786009)(6116002)(102836004)(14454004)(316002)(2906002)(8676002)(186003)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB2993;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6pNSURZdzyrezhtntFF2h7Ns0Idy4gUL0AGGJdS+8xxBzLB9+qF4C0mYKfkJcjkHaIHwdu+pAG2+Wx9obZFcbkz6D1X0Yc3mAGGgUbDCNPZi6pXMxCnQVRN4Sj+C0lgk4V3nITsxmql3I2mwG661KKMZNniFBcqmnHCKg+Z4zW2yyueAwiTSyp5TySjQ3MdAAXYsbIrif8lUBUc/xVHn3YEByH/8QhgGZYQoztTWmMxy0tOSBgX7Sw0/BhSHuwq8lgpP2JFOEfFT2L5Uu7I4bETOp9fbtGu5RwyJGzXC6XaMY44tVUdUrSWdm5vCX4mkyhAU27bqVX47Z2+teybZTephYbhLOra6/iMq5XknGdijvyoMgrggC6xqlmaNSR+3+AfPxsmSWJu/4L2tcKRKHVL7Ce7VxUdrQf/aeN7rAUk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <90CC682A4D7D8C4FB3B6678A6231D692@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b9bbb0-c01c-4cd6-232c-08d6effb73ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 12:34:18.2446 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB2993
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.110
Subject: Re: [Qemu-devel] [PATCH v5 07/42] block: *filtered_cow_child() for
 *has_zero_init()
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

MTMuMDYuMjAxOSAxOjA5LCBNYXggUmVpdHogd3JvdGU6DQo+IGJkcnZfaGFzX3plcm9faW5pdCgp
IGFuZCB0aGUgcmVsYXRlZCBiZHJ2X3VuYWxsb2NhdGVkX2Jsb2Nrc19hcmVfemVybygpDQo+IHNo
b3VsZCB1c2UgYmRydl9maWx0ZXJlZF9jb3dfY2hpbGQoKSBpZiB0aGV5IHdhbnQgdG8gY2hlY2sg
d2hldGhlciB0aGUNCj4gZ2l2ZW4gQkRTIGhhcyBhIENPVyBiYWNraW5nIGZpbGUuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBNYXggUmVpdHogPG1yZWl0ekByZWRoYXQuY29tPg0KPiAtLS0NCj4gICBi
bG9jay5jIHwgNCArKy0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ibG9jay5jIGIvYmxvY2suYw0KPiBpbmRl
eCBiZTE4MTMwOTQ0Li42NGQ2MTkwOTg0IDEwMDY0NA0KPiAtLS0gYS9ibG9jay5jDQo+ICsrKyBi
L2Jsb2NrLmMNCj4gQEAgLTQ5MzMsNyArNDkzMyw3IEBAIGludCBiZHJ2X2hhc196ZXJvX2luaXQo
QmxvY2tEcml2ZXJTdGF0ZSAqYnMpDQo+ICAgDQo+ICAgICAgIC8qIElmIEJTIGlzIGEgY29weSBv
biB3cml0ZSBpbWFnZSwgaXQgaXMgaW5pdGlhbGl6ZWQgdG8NCj4gICAgICAgICAgdGhlIGNvbnRl
bnRzIG9mIHRoZSBiYXNlIGltYWdlLCB3aGljaCBtYXkgbm90IGJlIHplcm9lcy4gICovDQo+IC0g
ICAgaWYgKGJzLT5iYWNraW5nKSB7DQo+ICsgICAgaWYgKGJkcnZfZmlsdGVyZWRfY293X2NoaWxk
KGJzKSkgew0KPiAgICAgICAgICAgcmV0dXJuIDA7DQo+ICAgICAgIH0NCg0KSG1tLCBpZiB5b3Ug
YXJlIGZpeGluZyBiZHJ2X2hhc196ZXJvX2luaXQgYXJvdW5kIGZpbHRlcnMsIEknZCBwcmVmZXJl
IHRvIGZpeCB0aGUgd2hvbGUNCmZ1bmN0aW9uLCBjb252ZXJ0aW5nIHRoZSBmb2xsb3dpbmcgaGVy
ZSB0b286DQogICAgIGlmIChicy0+ZmlsZSAmJiBicy0+ZHJ2LT5pc19maWx0ZXIpIHsNCiAgICAg
ICAgIHJldHVybiBiZHJ2X2hhc196ZXJvX2luaXQoYnMtPmZpbGUtPmJzKTsNCiAgICAgfQ0KDQoN
CkJ1dCBpdCdzIG5vdCBhIHJlYWwgcHJvYmxlbToNCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNl
bWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KPiAgICAgICBp
ZiAoYnMtPmRydi0+YmRydl9oYXNfemVyb19pbml0KSB7DQo+IEBAIC00OTUxLDcgKzQ5NTEsNyBA
QCBib29sIGJkcnZfdW5hbGxvY2F0ZWRfYmxvY2tzX2FyZV96ZXJvKEJsb2NrRHJpdmVyU3RhdGUg
KmJzKQ0KPiAgIHsNCj4gICAgICAgQmxvY2tEcml2ZXJJbmZvIGJkaTsNCj4gICANCj4gLSAgICBp
ZiAoYnMtPmJhY2tpbmcpIHsNCj4gKyAgICBpZiAoYmRydl9maWx0ZXJlZF9jb3dfY2hpbGQoYnMp
KSB7DQo+ICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ICAgICAgIH0NCj4gICANCj4gDQoNCg0K
LS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

