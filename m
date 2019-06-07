Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D4CC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 12:39:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A10D2089E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 12:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gBk93iRu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A10D2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50590 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZE9k-0000Nb-Lm
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 08:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49701)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hZE6w-0007G9-Uq
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 08:36:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hZE6w-0004bb-2d
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 08:36:46 -0400
Received: from mail-eopbgr150092.outbound.protection.outlook.com
 ([40.107.15.92]:58800 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hZE6v-0004ZP-9D; Fri, 07 Jun 2019 08:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwIlpYNGEIoNCzQ57RSyacdXxHZKNS0MN56b+Mz6WLs=;
 b=gBk93iRulmv+astB1hvJnuw3f+atutAEmVIYebQYI+bUwK6BxHEk92XV0aB8fiILP8vO+0meIliQH88yzUoxFf4XCvmaKIQleU12Xj2MFy0KMg295cAtyAJmILHHJcAOO2PjT360bl+YOS5W11z6vZ/Sy8JaI6MYE7cpOmKIIrM=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
 AM0PR08MB4436.eurprd08.prod.outlook.com (20.179.32.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.13; Fri, 7 Jun 2019 12:36:41 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
 ([fe80::8d90:32ae:bdd6:48e8]) by AM0PR08MB2961.eurprd08.prod.outlook.com
 ([fe80::8d90:32ae:bdd6:48e8%7]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 12:36:41 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH 1/5] block/qcow2-bitmap: allow bitmap_list_load to return
 an error code
Thread-Index: AQHVHJeMYu+XPvwpb0unwqOx4AyWCqaQIh6A
Date: Fri, 7 Jun 2019 12:36:41 +0000
Message-ID: <517a2513-7b08-dcc5-34c7-750be9872c93@virtuozzo.com>
References: <20190606184159.979-1-jsnow@redhat.com>
 <20190606184159.979-2-jsnow@redhat.com>
In-Reply-To: <20190606184159.979-2-jsnow@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0043.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::11) To AM0PR08MB2961.eurprd08.prod.outlook.com
 (2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190607153639151
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 397f51d2-4cf8-4a6a-e01d-08d6eb44caaf
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB4436; 
x-ms-traffictypediagnostic: AM0PR08MB4436:
x-microsoft-antispam-prvs: <AM0PR08MB44365138061F8FF070C6C0FCC1100@AM0PR08MB4436.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(396003)(39850400004)(136003)(366004)(199004)(189003)(81156014)(36756003)(5660300002)(110136005)(4326008)(478600001)(14454004)(52116002)(446003)(2616005)(8676002)(66066001)(8936002)(6486002)(316002)(6246003)(71190400001)(71200400001)(6512007)(186003)(2906002)(6436002)(54906003)(486006)(11346002)(26005)(81166006)(102836004)(53936002)(229853002)(476003)(256004)(31686004)(99286004)(76176011)(31696002)(86362001)(7736002)(305945005)(25786009)(2201001)(68736007)(66946007)(64756008)(66556008)(73956011)(66476007)(386003)(66446008)(6506007)(4744005)(2501003)(6116002)(3846002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4436;
 H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aXYbpKSiLRNOadkLnnaqf4U6QPItyFcYilq+7aY0+HoOmUHRifIedcOce6QIvg1STF7mQm5x8k904Hy5NOE+7V3juFfTWJjMiwEi7uZ+D6NEYHmVUQ5VHVW4Yufp07865WzxI8pSe6DjPkua5XA9saOonaQ+QCL/vWjKXCXSvWlj9WlgwFFdPvOR4I1kK6PWGDnyZl6xjJl/7zBg1eZjXGHhY7FDfQGotEwIsmPU094QGIJg23Xh9izq/ogG5u5J9iqSejZucLMmA2MyN5asGvDGVDgCPr5NdpApvYHamnifvEvC2c/KXXauqiH5U3hLI+RvA4YT2KfUH8XP9I8nB+5gEnibdMDIr9HFiYG+63mboqwQQgMTY/20RFYyIJ60ZSVS28I123tvUa0p3lU/VEyQ5kyfyVpw6ABm0mn/EN0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D9EC0653C0F434686667FB78D0470E4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 397f51d2-4cf8-4a6a-e01d-08d6eb44caaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 12:36:41.5088 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4436
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.92
Subject: Re: [Qemu-devel] [PATCH 1/5] block/qcow2-bitmap: allow
 bitmap_list_load to return an error code
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDYuMDYuMjAxOSAyMTo0MSwgSm9obiBTbm93IHdyb3RlOg0KPiBUaGlzIHNpbXBseSBtYWtlcyB0
aGlzIGZ1bmN0aW9uIGEgbGl0dGxlIG1vcmUgY29udmVuaWVudCB0byBjYWxsLCBhbmQgaW4NCj4g
YSBmb3J0aGNvbWluZyBwYXRjaCBnaXZlcyB1cyBhIHJldHVybiBjb2RlIHdlIGNhbiByZXBvcnQg
dG8gdGhlDQo+IGNhbGxlci4gKFdoaWNoIGluIHR1cm4gbWFrZXMgVEhPU0UgZnVuY3Rpb25zIGVh
c2llciB0byBjYWxsLikNCj4gDQo+IFdoaWxlIHdlJ3JlIGhlcmUsIHJlbW92ZSB0aGUgb2Zmc2V0
K3NpemUgYXJndW1lbnRzIHdoaWNoIGFyZSBvbmx5IGV2ZXINCj4gY2FsbGVkIHdpdGggdGhlIHNh
bWUgdmFsdWVzIHRoYXQgY2FuIGJlIGRldGVybWluZWQgaW5zaWRlIHRoaXMgaGVscGVyLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogSm9obiBTbm93PGpzbm93QHJlZGhhdC5jb20+DQoNCg0KUmV2aWV3
ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpv
LmNvbT4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

