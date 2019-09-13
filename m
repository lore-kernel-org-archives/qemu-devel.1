Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FDEC4CEC9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 18:38:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4846206A5
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 18:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="msYEJ41c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4846206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8qSv-0001GI-Ts
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 14:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52679)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i8qRy-0000fC-Cc
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 14:37:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i8qRx-0000C3-5K
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 14:37:42 -0400
Received: from mail-eopbgr80139.outbound.protection.outlook.com
 ([40.107.8.139]:59346 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i8qRq-00008g-Mn; Fri, 13 Sep 2019 14:37:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0M3xLOhpWfASi9GOS//zYRsxzhMuRA7a/H6gvUgi9ixaSbTYNcS33aXiDFHT0A1boy8Mtblso/czuFCLUx5LVWRefi9ScSQwPOJrjptwcqD4rZDw7kpLGpVnS7wsGfIlmPYeXO6rpkRR3TK9yoAkfqsBS27QXjiA5aaWClGvdwEHB8ZcKTVsmdaA8cLmCU/fP9Y3VXxgw8QyMZmtPGFuNI3EJNsSJLstx2SkiMZGA5s6tSNFXfPD+CKll7XXcbPKtnxagj6jLQdjsHNef+0hHtN+/WVrStxMgr2P+rGZmov7JMvLFfAkhVu0+PVnqmUyxQDJyGPcy9XyLl1a2opaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dggizyshoZDwM66x29sYDOKpjRVsDehxzbvAgI3k6q8=;
 b=nUcD6p/zWA+svKPcwFb4YiX3PWColfvncWtf22yYtvtchhgbORn+twjXbMCyUPlB8HVgc5s3I7DACXM9RnGbKKJCUsthW4FrmyIFCs90p/n+WcGSmCgs2A+ciS01gJ09LXZfdPDmxcRFzzVUpjc12MR8VKaS2PdHHXA8GcfPnpuJxYnzNYDcptqiUYCARZodtvAP8713Odm8NGFfp9/UgHTidjjZwrCb9wYL/TikRh4fX70Ow2K4ZOhI28yPs/22IpM+/SjzlSq6xIYTUgX5vz/OW063DhBfGFWqjlObqsrUyeGn/HBkfgAGo3shtStTYsEAmKxtwEFDnTLs1em2gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dggizyshoZDwM66x29sYDOKpjRVsDehxzbvAgI3k6q8=;
 b=msYEJ41cZp1FRNG7aSLMDlQCUykoyfjE3tGM+DVWWQrrtpMu9muBioZxDuUUx5I8YQ7/l3MJ4qWgJpvBrc+AKXuXeMPLZpyU7vmcPgERYai6BaStFv/biPIvEXw6jEbSCCXJF8srzUtI1k+4jBbiH3KUfSMDiOMNB5Zpbv/ZABE=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5212.eurprd08.prod.outlook.com (20.179.15.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Fri, 13 Sep 2019 18:37:31 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2263.016; Fri, 13 Sep 2019
 18:37:31 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v6 2/3] block/qcow2: refactor threaded encryption code
Thread-Index: AQHValiT6Enm2z7pu0ezR4YLLxhDZacp7+UA
Date: Fri, 13 Sep 2019 18:37:31 +0000
Message-ID: <eb28e4f6-2cbb-e803-96aa-088a3df52288@virtuozzo.com>
References: <20190913172741.5662-1-mlevitsk@redhat.com>
 <20190913172741.5662-3-mlevitsk@redhat.com>
In-Reply-To: <20190913172741.5662-3-mlevitsk@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P191CA0020.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::30)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190913213728912
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ded142ea-8b60-4437-2a4d-08d738796fa6
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5212; 
x-ms-traffictypediagnostic: DB8PR08MB5212:
x-microsoft-antispam-prvs: <DB8PR08MB5212DC68B3C9293E15B79F7BC1B30@DB8PR08MB5212.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(136003)(346002)(396003)(376002)(366004)(39840400004)(189003)(199004)(14444005)(76176011)(486006)(25786009)(386003)(6506007)(99286004)(66066001)(305945005)(6246003)(53936002)(8936002)(6512007)(2906002)(86362001)(81166006)(7736002)(2616005)(31696002)(102836004)(81156014)(4326008)(54906003)(8676002)(476003)(31686004)(478600001)(229853002)(6486002)(14454004)(110136005)(2501003)(3846002)(6116002)(5660300002)(186003)(71190400001)(446003)(11346002)(71200400001)(52116002)(6436002)(256004)(26005)(66556008)(66476007)(64756008)(66946007)(66446008)(36756003)(316002)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5212;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: O+YySY/9hTMwpluvf5L1xET9W2z2Yk1oixW9nx2RUr16xQDrExRbt+/lqN8rngw7qHMeNihMO4IqLatBEU8b6OZXLWX6JRWeHysopFwXDUiA8GQ/MVcShLgtu/BK9fll5gvi7uJZ9GquwMkMqlxaIUTeOBtu/qKaKAk3pfv9X/h6C213ncOLT6Qv+b9fvPqBC86o7bdJBlz5U5AbIDBmwmFMUASpwwScuGucdUdA2ZCtOa/sydremgM0n1UD1AZs0krjrWf69dOAW0ta6N1kvzxW7YSs/IWp7iKpitbiiWj5pwT8P5rDRTHfODH1oUVwwsgPg24IdhLkkCRO4UP8E9rx6D6zwB1K4Mf4dgqK7j1hKvKZWbERcFPKc6bZfmo22sqn3kxnVN8iivnEyolWjSZcBh5VOSBAS51Mwx5WNBs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <468993D0F69A63439E287F5EEA00D63E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ded142ea-8b60-4437-2a4d-08d738796fa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 18:37:31.4325 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q9EriSf+UZ05E92fhLCJRbkgIRLqE2cHp7DeaF/g8B+bs+73vtSrmvHhNWEgTxRjP18BHjZH4wXKhv7fNpKrpJEUNVdSIpAXc55kcdGj4tI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5212
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.139
Subject: Re: [Qemu-devel] [PATCH v6 2/3] block/qcow2: refactor threaded
 encryption code
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
 =?utf-8?B?RGFuaWVsIFAgLiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

YW5kIGEgYml0IGFib3V0IGVtcHR5IGxpbmVzDQoNCjEzLjA5LjIwMTkgMjA6MjcsIE1heGltIExl
dml0c2t5IHdyb3RlOg0KPiBDaGFuZ2UgdGhlIHFjb3cyX2NvX2VuY3J5cHQgdG8ganVzdCByZWNl
aXZlIGZ1bGwgaG9zdCBhbmQNCj4gZ3Vlc3Qgb2Zmc2V0cyBhbmQgaW4gcGFyaXRpY3VsYXIgcmVt
b3ZlIHRoZQ0KPiBvZmZzZXRfaW5fY2x1c3RlciBwYXJhbWV0ZXIgb2YgZG9fcGVyZm9ybV9jb3df
ZW5jcnlwdCwNCj4gc2luY2UgaXQgaXMgbWlzbGVhZGluZywgYmVjYXVzZSB0aGF0IG9mZnNldCBj
YW4gYmUgbGFyZ2VyIHRoYW4NCj4gY2x1c3RlciBzaXplIGN1cnJlbnRseS4NCj4gDQo+IFJlbW92
ZSB0aGUgZG9fcGVyZm9ybV9jb3dfZW5jcnlwdCBieSBtZXJnaW5nIGl0IHdpdGgNCj4gcWNvdzJf
Y29fZW5jcnlwdA0KPiANCj4gQWxzbyBkb2N1bWVudCB0aGUgcWNvdzJfY29fZW5jcnlwdCBhcmd1
bWVudHMgdG8gcHJldmVudA0KPiB0aGF0IGJ1ZyBmcm9tIGhhcHBlbmluZyBhZ2Fpbg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogTWF4aW0gTGV2aXRza3kgPG1sZXZpdHNrQHJlZGhhdC5jb20+DQo+IFJl
dmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1
b3p6by5jb20+DQo+IC0tLQ0KDQpbLi5dDQoNCj4gZGlmZiAtLWdpdCBhL2Jsb2NrL3Fjb3cyLXRo
cmVhZHMuYyBiL2Jsb2NrL3Fjb3cyLXRocmVhZHMuYw0KPiBpbmRleCAzYjFlNjNmZTQxLi5iMzFk
NDVmYjJiIDEwMDY0NA0KPiAtLS0gYS9ibG9jay9xY293Mi10aHJlYWRzLmMNCj4gKysrIGIvYmxv
Y2svcWNvdzItdGhyZWFkcy5jDQo+IEBAIC0yMzQsMTUgKzIzNCwxNSBAQCBzdGF0aWMgaW50IHFj
b3cyX2VuY2RlY19wb29sX2Z1bmModm9pZCAqb3BhcXVlKQ0KPiAgIH0NCj4gICANCj4gICBzdGF0
aWMgaW50IGNvcm91dGluZV9mbg0KPiAtcWNvdzJfY29fZW5jZGVjKEJsb2NrRHJpdmVyU3RhdGUg
KmJzLCB1aW50NjRfdCBmaWxlX2NsdXN0ZXJfb2Zmc2V0LA0KPiAtICAgICAgICAgICAgICAgICAg
dWludDY0X3Qgb2Zmc2V0LCB2b2lkICpidWYsIHNpemVfdCBsZW4sIFFjb3cyRW5jRGVjRnVuYyBm
dW5jKQ0KPiArcWNvdzJfY29fZW5jZGVjKEJsb2NrRHJpdmVyU3RhdGUgKmJzLCB1aW50NjRfdCBo
b3N0X29mZnNldCwNCj4gKyAgICAgICAgICAgICAgICB1aW50NjRfdCBndWVzdF9vZmZzZXQsIHZv
aWQgKmJ1Ziwgc2l6ZV90IGxlbiwNCj4gKyAgICAgICAgICAgICAgICBRY293MkVuY0RlY0Z1bmMg
ZnVuYykNCj4gICB7DQo+ICAgICAgIEJEUlZRY293MlN0YXRlICpzID0gYnMtPm9wYXF1ZTsNCj4g
Kw0KDQpEb24ndCBzZWUgcmVhbCBiZW5lZml0IGluIHNlcGFyYXRpbmcgb25lIHZhcmlhYmxlIGlu
aXRpYWxpemF0aW9uIGZyb20gYW5vdGhlciBvbmUgaGVyZSwNCmJ1dCBJIGRvbid0IG1pbmQsIGl0
J3MgT0sgb2YgY291cnNlLg0KDQo+ICAgICAgIFFjb3cyRW5jRGVjRGF0YSBhcmcgPSB7DQo+ICAg
ICAgICAgICAuYmxvY2sgPSBzLT5jcnlwdG8sDQo+IC0gICAgICAgIC5vZmZzZXQgPSBzLT5jcnlw
dF9waHlzaWNhbF9vZmZzZXQgPw0KPiAtICAgICAgICAgICAgICAgICAgICAgIGZpbGVfY2x1c3Rl
cl9vZmZzZXQgKyBvZmZzZXRfaW50b19jbHVzdGVyKHMsIG9mZnNldCkgOg0KPiAtICAgICAgICAg
ICAgICAgICAgICAgIG9mZnNldCwNCj4gKyAgICAgICAgLm9mZnNldCA9IHMtPmNyeXB0X3BoeXNp
Y2FsX29mZnNldCA/IGhvc3Rfb2Zmc2V0IDogZ3Vlc3Rfb2Zmc2V0LA0KPiAgICAgICAgICAgLmJ1
ZiA9IGJ1ZiwNCj4gICAgICAgICAgIC5sZW4gPSBsZW4sDQo+ICAgICAgICAgICAuZnVuYyA9IGZ1
bmMsDQo+IEBAIC0yNTEsMTggKzI1MSw3MyBAQCBxY293Ml9jb19lbmNkZWMoQmxvY2tEcml2ZXJT
dGF0ZSAqYnMsIHVpbnQ2NF90IGZpbGVfY2x1c3Rlcl9vZmZzZXQsDQo+ICAgICAgIHJldHVybiBx
Y293Ml9jb19wcm9jZXNzKGJzLCBxY293Ml9lbmNkZWNfcG9vbF9mdW5jLCAmYXJnKTsNCj4gICB9
DQo+ICAgDQo+ICsNCg0KSG1tLCBpbiB0aGlzIGZpbGUgZG91YmxlZCBlbXB0eSBsaW5lcw0KYXJl
IHVzZWQgdG8gc2VwYXJhdGUgIkNvbXByZXNzaW9uIiBhbmQgIkNyeXB0b2dyYXBoeSINCnNlY3Rp
b25zLiBBbmQgYWxsIG90aGVyIHNwbGl0cyBhcmUgb25lLWVtcHR5LWxpbmUuDQoNCj4gKy8qDQo+
ICsgKiBxY293Ml9jb19lbmNyeXB0KCkNCj4gKyAqDQo+ICsgKiBFbmNyeXB0cyBvbmUgb3IgbW9y
ZSBjb250aWd1b3VzIGFsaWduZWQgc2VjdG9ycw0KPiArICoNCj4gKyAqIEBob3N0X29mZnNldCAt
IHVuZGVybHlpbmcgc3RvcmFnZSBvZmZzZXQgb2YgdGhlIGZpcnN0IHNlY3RvciBvZiB0aGUNCj4g
KyAqIGRhdGEgdG8gYmUgZW5jcnlwdGVkDQo+ICsgKg0KPiArICogQGd1ZXN0X29mZnNldCAtIGd1
ZXN0ICh2aXJ0dWFsKSBvZmZzZXQgb2YgdGhlIGZpcnN0IHNlY3RvciBvZiB0aGUNCj4gKyAqIGRh
dGEgdG8gYmUgZW5jcnlwdGVkDQo+ICsgKg0KPiArICogQGJ1ZiAtIGJ1ZmZlciB3aXRoIHRoZSBk
YXRhIHRvIGVuY3J5cHQsIHRoYXQgYWZ0ZXIgZW5jcnlwdGlvbg0KPiArICogICAgICAgIHdpbGwg
YmUgd3JpdHRlbiB0byB0aGUgdW5kZXJseWluZyBzdG9yYWdlIGRldmljZSBhdA0KPiArICogICAg
ICAgIEBob3N0X29mZnNldA0KPiArICoNCj4gKyAqIEBsZW4gLSBsZW5ndGggb2YgdGhlIGJ1ZmZl
ciAobXVzdCBiZSBhIEJEUlZfU0VDVE9SX1NJWkUgbXVsdGlwbGUpDQo+ICsgKg0KPiArICogRGVw
ZW5kaW5nIG9uIHRoZSBlbmNyeXB0aW9uIG1ldGhvZCwgQGhvc3Rfb2Zmc2V0IGFuZC9vciBAZ3Vl
c3Rfb2Zmc2V0DQo+ICsgKiBtYXkgYmUgdXNlZCBmb3IgZ2VuZXJhdGluZyB0aGUgaW5pdGlhbGl6
YXRpb24gdmVjdG9yIGZvcg0KPiArICogZW5jcnlwdGlvbi4NCj4gKyAqDQo+ICsgKiBOb3RlIHRo
YXQgd2hpbGUgdGhlIHdob2xlIHJhbmdlIG11c3QgYmUgYWxpZ25lZCBvbiBzZWN0b3JzLCBpdA0K
PiArICogZG9lcyBub3QgaGF2ZSB0byBiZSBhbGlnbmVkIG9uIGNsdXN0ZXJzIGFuZCBjYW4gYWxz
byBjcm9zcyBjbHVzdGVyDQo+ICsgKiBib3VuZGFyaWVzDQo+ICsgKi8NCj4gICBpbnQgY29yb3V0
aW5lX2ZuDQo+IC1xY293Ml9jb19lbmNyeXB0KEJsb2NrRHJpdmVyU3RhdGUgKmJzLCB1aW50NjRf
dCBmaWxlX2NsdXN0ZXJfb2Zmc2V0LA0KPiAtICAgICAgICAgICAgICAgICB1aW50NjRfdCBvZmZz
ZXQsIHZvaWQgKmJ1Ziwgc2l6ZV90IGxlbikNCj4gK3Fjb3cyX2NvX2VuY3J5cHQoQmxvY2tEcml2
ZXJTdGF0ZSAqYnMsIHVpbnQ2NF90IGhvc3Rfb2Zmc2V0LA0KPiArICAgICAgICAgICAgICAgICB1
aW50NjRfdCBndWVzdF9vZmZzZXQsIHZvaWQgKmJ1Ziwgc2l6ZV90IGxlbikNCj4gICB7DQo+IC0g
ICAgcmV0dXJuIHFjb3cyX2NvX2VuY2RlYyhicywgZmlsZV9jbHVzdGVyX29mZnNldCwgb2Zmc2V0
LCBidWYsIGxlbiwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcWNyeXB0b19ibG9j
a19lbmNyeXB0KTsNCj4gKw0KDQpUaGlzIGVtcHR5IGxpbmUgaXMgbm90IG5lZWRlZCBmb3Igc3Vy
ZQ0KDQo+ICsgICAgQkRSVlFjb3cyU3RhdGUgKnMgPSBicy0+b3BhcXVlOw0KDQpCdXQgaXQncyBj
b21tb24gcHJhY3RpY2UgdG8gc3BsaXQgdmFyaWFibGVzIGRlZmluaXRpb24gZnJvbSBjb2RlIGJ5
IGVtcHR5IGxpbmUgaGVyZQ0KDQo+ICsgICAgYXNzZXJ0KFFFTVVfSVNfQUxJR05FRChndWVzdF9v
ZmZzZXQsIEJEUlZfU0VDVE9SX1NJWkUpKTsNCj4gKyAgICBhc3NlcnQoUUVNVV9JU19BTElHTkVE
KGhvc3Rfb2Zmc2V0LCBCRFJWX1NFQ1RPUl9TSVpFKSk7DQo+ICsgICAgYXNzZXJ0KFFFTVVfSVNf
QUxJR05FRChsZW4sIEJEUlZfU0VDVE9SX1NJWkUpKTsNCj4gKyAgICBhc3NlcnQocy0+Y3J5cHRv
KTsNCj4gKw0KPiArICAgIGlmICghbGVuKSB7DQo+ICsgICAgICAgIHJldHVybiAwOw0KPiArICAg
IH0NCj4gKw0KPiArICAgIHJldHVybiBxY293Ml9jb19lbmNkZWMoYnMsIGhvc3Rfb2Zmc2V0LCBn
dWVzdF9vZmZzZXQsIGJ1ZiwgbGVuLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgcWNy
eXB0b19ibG9ja19lbmNyeXB0KTsNCj4gICB9DQo+ICAgDQo+ICsNCg0KSU1ITyBleHRyYSBvbmUg
KHNlZSBhYm92ZSkNCg0KPiArLyoNCj4gKyAqIHFjb3cyX2NvX2RlY3J5cHQoKQ0KPiArICoNCj4g
KyAqIERlY3J5cHRzIG9uZSBvciBtb3JlIGNvbnRpZ3VvdXMgYWxpZ25lZCBzZWN0b3JzDQo+ICsg
KiBTaW1pbGFyIHRvIHFjb3cyX2NvX2VuY3J5cHQNCj4gKyAqLw0KPiArDQoNCkhlcmUgeW91IHJl
cGxhY2VkIG9uZSBleHRyYSBlbXB0eSBsaW5lIGJ5IGFub3RoZXINCg0KPiAgIGludCBjb3JvdXRp
bmVfZm4NCj4gLXFjb3cyX2NvX2RlY3J5cHQoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIHVpbnQ2NF90
IGZpbGVfY2x1c3Rlcl9vZmZzZXQsDQo+IC0gICAgICAgICAgICAgICAgIHVpbnQ2NF90IG9mZnNl
dCwgdm9pZCAqYnVmLCBzaXplX3QgbGVuKQ0KPiArcWNvdzJfY29fZGVjcnlwdChCbG9ja0RyaXZl
clN0YXRlICpicywgdWludDY0X3QgaG9zdF9vZmZzZXQsDQo+ICsgICAgICAgICAgICAgICAgIHVp
bnQ2NF90IGd1ZXN0X29mZnNldCwgdm9pZCAqYnVmLCBzaXplX3QgbGVuKQ0KPiAgIHsNCj4gLSAg
ICByZXR1cm4gcWNvdzJfY29fZW5jZGVjKGJzLCBmaWxlX2NsdXN0ZXJfb2Zmc2V0LCBvZmZzZXQs
IGJ1ZiwgbGVuLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICBxY3J5cHRvX2Jsb2Nr
X2RlY3J5cHQpOw0KDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

