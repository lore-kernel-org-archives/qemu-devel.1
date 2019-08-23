Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27B0C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 06:01:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BA8F22CEC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 06:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AEzGqF4D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA8F22CEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i12dS-0007cD-9W
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 02:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i12bk-000705-T9
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 01:59:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i12bj-0002V3-Am
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 01:59:32 -0400
Received: from mail-eopbgr80132.outbound.protection.outlook.com
 ([40.107.8.132]:58500 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i12bi-0002Ue-ID; Fri, 23 Aug 2019 01:59:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEehz6b1C5fWwbOkp8ZdRKb3CkWbHnWwmUTJ9xLRKkx7BqB/wiLVUAa0lP2MAfqIHh066uAjgahahZBU7Vkx9SedrwgHsEemXPuvBQSZ08P6nMdfGwJLs51dZUoRRWpOXlRvaFbqYgEHjU045k2PuukPJ2wSSCfNKeJexf9HGKrzYvEVmRBwV9vmXgVlmgaFfsXMwEgHsQYhC+43wF5KU21raLiMIKsdKfFvWUlDdE+bDHsNf9+GI8GzXGny/YNPdNw5okRmMdb5TQoWCDlBq1ojJ99GB+7aN90ysfhEDLg9Up82MASC/d6gbhtjqgle+ydQ5lx3/00S0rpgfViFTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ileh0Hn4ziGa56iZV32a0CKsb5yXrkHG0xQTpnv1NiM=;
 b=aH/EX1/dS37YE1OguR429/CX93Ta2ZIbB9NB2KFo0KfUWTNGhqw+iM6cJxeV9v0KKVOemtEbaplbrOSIs2YuA/q+wLfSJ+MkfJ0d/owK65Tmj6PHVou2Yr6Esff8NBNIOu3wJ9oi5ExT0SIf4JH4UJKuvcm9Cmwf+i0mjyUTmJWDMJljRAR1Ces5gZnKtQ2Gk3XPKKvJN3oNmIJG9uTxvfk+t26k2BH4jLNhQllJfzt46+2tqVvqqif2cW1uS2s7D6LrultILXrK1mBT7qLdBL9+dUP0T33p851yLmvwdnPU+RUWk3KFy/FXk1yE3AYa1hNZuRvZ2skqd3tULI+xfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ileh0Hn4ziGa56iZV32a0CKsb5yXrkHG0xQTpnv1NiM=;
 b=AEzGqF4DRUYz9klubi0yHJYJLRDsrwk1+cj9l6Rb0WgaGGKZ4hAHqnV6yHPDNZLuRvX66YBJwAHZXjoBjgHPPmPrJyPZ3BzYr0DOfhsSOGGrKo/DsoYGB2r4j9Tay2YautE328qrm2U5tUQaAFJKuddm+HD6jXRNBi/677qLK7k=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB3980.eurprd08.prod.outlook.com (20.179.12.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Fri, 23 Aug 2019 05:59:26 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2178.020; Fri, 23 Aug 2019
 05:59:26 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v6 38/42] iotests: Let complete_and_wait() work with
 commit
Thread-Index: AQHVTs2zYjc8L2kpC0midtvA3+khqacIUjeA
Date: Fri, 23 Aug 2019 05:59:25 +0000
Message-ID: <9d630252-3681-2740-04ce-09cd4b428421@virtuozzo.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-39-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-39-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0024.eurprd07.prod.outlook.com
 (2603:10a6:7:67::34) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190823085923736
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85434981-3c3f-434a-b797-08d7278f0d8b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB3980; 
x-ms-traffictypediagnostic: DB8PR08MB3980:
x-microsoft-antispam-prvs: <DB8PR08MB3980B2BE7FB45D1279957120C1A40@DB8PR08MB3980.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:134;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(396003)(39850400004)(376002)(346002)(189003)(199004)(14454004)(6246003)(7736002)(66066001)(316002)(54906003)(102836004)(6506007)(6512007)(5660300002)(86362001)(66476007)(52116002)(71200400001)(71190400001)(256004)(99286004)(478600001)(4326008)(81156014)(81166006)(2501003)(8676002)(53936002)(305945005)(31696002)(6486002)(8936002)(486006)(25786009)(66446008)(66556008)(64756008)(66946007)(36756003)(2616005)(11346002)(476003)(6436002)(446003)(31686004)(186003)(26005)(386003)(76176011)(110136005)(2906002)(6116002)(3846002)(229853002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB3980;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: p5Y9GqtIrLWD0Y4PUO3uoCIUWjBCk6AZv/t2Sqwmqy21qg2oD83t4fURt9QLxYBij9UYLzK+/bPqsiDoxMk6vKMdkjNmnGhl3jhxnIT/rP/asqhQoIEXSj59bZg4k6DVnaRtz8Jun8fCuEveE6u8Bkx7RrTScgShjl9A0Rf0+9zV+pju6Rw0NwZiJg4PSRzOzPpJRJzqfNyrENPfku6wbp3knIpWrxBxrkVAC3Fqvk0ENS8rU5YMskRXOxlnYfXElKD8/OkbK6Gi5Vl+LAvuusk3C75+iO7ViVvC98z3lXEDl+gH7lvDab2VlEPTLkGCuT8cjGkvPvJUQn3bcVLThewzHQedpDyiA7ux+wYoI9mDXcXzUqLnehnmkRnqrZvAgL2P43PaF1AuvI5p5cdO9j/MtKV3pmqEd3h5Hq4kBnc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA41337421849949A72748315427CF49@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85434981-3c3f-434a-b797-08d7278f0d8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 05:59:26.0884 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cU6lYoljgKJENlralzZy6xZELkUnLmMea+JxYYAo0ksAWQunobw2Y2B5f5XGl6cD0Vu6nCE4/otVNrJakp7ftF2gcGNe7YWQOkz4spx8wd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3980
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.132
Subject: Re: [Qemu-devel] [PATCH v6 38/42] iotests: Let complete_and_wait()
 work with commit
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

MDkuMDguMjAxOSAxOToxNCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBjb21wbGV0ZV9hbmRfd2FpdCgp
IGFuZCB3YWl0X3JlYWR5KCkgY3VycmVudGx5IG9ubHkgd29yayBmb3IgbWlycm9yDQo+IGpvYnMu
ICBMZXQgdGhlbSB3b3JrIGZvciBhY3RpdmUgY29tbWl0IGpvYnMsIHRvby4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IE1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgIHRlc3Rz
L3FlbXUtaW90ZXN0cy9pb3Rlc3RzLnB5IHwgMTAgKysrKysrKy0tLQ0KPiAgIDEgZmlsZSBjaGFu
Z2VkLCA3IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
dGVzdHMvcWVtdS1pb3Rlc3RzL2lvdGVzdHMucHkgYi90ZXN0cy9xZW11LWlvdGVzdHMvaW90ZXN0
cy5weQ0KPiBpbmRleCA4NDQzOGU4MzdjLi4zZWY4NDZkMWRjIDEwMDY0NA0KPiAtLS0gYS90ZXN0
cy9xZW11LWlvdGVzdHMvaW90ZXN0cy5weQ0KPiArKysgYi90ZXN0cy9xZW11LWlvdGVzdHMvaW90
ZXN0cy5weQ0KPiBAQCAtNzYxLDggKzc2MSwxMiBAQCBjbGFzcyBRTVBUZXN0Q2FzZSh1bml0dGVz
dC5UZXN0Q2FzZSk6DQo+ICAgDQo+ICAgICAgIGRlZiB3YWl0X3JlYWR5KHNlbGYsIGRyaXZlPSdk
cml2ZTAnKToNCj4gICAgICAgICAgICcnJ1dhaXQgdW50aWwgYSBibG9jayBqb2IgQkxPQ0tfSk9C
X1JFQURZIGV2ZW50JycnDQo+IC0gICAgICAgIGYgPSB7J2RhdGEnOiB7J3R5cGUnOiAnbWlycm9y
JywgJ2RldmljZSc6IGRyaXZlIH0gfQ0KPiAtICAgICAgICBldmVudCA9IHNlbGYudm0uZXZlbnRf
d2FpdChuYW1lPSdCTE9DS19KT0JfUkVBRFknLCBtYXRjaD1mKQ0KPiArICAgICAgICBldmVudCA9
IHNlbGYudm0uZXZlbnRzX3dhaXQoWw0KPiArICAgICAgICAgICAgICAgICgnQkxPQ0tfSk9CX1JF
QURZJywNCj4gKyAgICAgICAgICAgICAgICAgeydkYXRhJzogeyd0eXBlJzogJ21pcnJvcicsICdk
ZXZpY2UnOiBkcml2ZSB9IH0pLA0KPiArICAgICAgICAgICAgICAgICgnQkxPQ0tfSk9CX1JFQURZ
JywNCj4gKyAgICAgICAgICAgICAgICAgeydkYXRhJzogeyd0eXBlJzogJ2NvbW1pdCcsICdkZXZp
Y2UnOiBkcml2ZSB9IH0pDQo+ICsgICAgICAgICAgICBdKQ0KPiAgIA0KPiAgICAgICBkZWYgd2Fp
dF9yZWFkeV9hbmRfY2FuY2VsKHNlbGYsIGRyaXZlPSdkcml2ZTAnKToNCj4gICAgICAgICAgIHNl
bGYud2FpdF9yZWFkeShkcml2ZT1kcml2ZSkNCj4gQEAgLTc4MCw3ICs3ODQsNyBAQCBjbGFzcyBR
TVBUZXN0Q2FzZSh1bml0dGVzdC5UZXN0Q2FzZSk6DQo+ICAgICAgICAgICBzZWxmLmFzc2VydF9x
bXAocmVzdWx0LCAncmV0dXJuJywge30pDQo+ICAgDQo+ICAgICAgICAgICBldmVudCA9IHNlbGYu
d2FpdF91bnRpbF9jb21wbGV0ZWQoZHJpdmU9ZHJpdmUpDQo+IC0gICAgICAgIHNlbGYuYXNzZXJ0
X3FtcChldmVudCwgJ2RhdGEvdHlwZScsICdtaXJyb3InKQ0KPiArICAgICAgICBzZWxmLmFzc2Vy
dFRydWUoZXZlbnRbJ2RhdGEnXVsndHlwZSddIGluIFsnbWlycm9yJywgJ2NvbW1pdCddKQ0KPiAg
IA0KPiAgICAgICBkZWYgcGF1c2Vfd2FpdChzZWxmLCBqb2JfaWQ9J2pvYjAnKToNCj4gICAgICAg
ICAgIHdpdGggVGltZW91dCgxLCAiVGltZW91dCB3YWl0aW5nIGZvciBqb2IgdG8gcGF1c2UiKToN
Cj4gDQoNCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1l
bnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

