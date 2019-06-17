Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93A2C31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 11:22:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1AE32084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 11:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YIUHE0+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1AE32084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46158 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcpiD-0003NQ-8G
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 07:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51094)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hcphD-0002rv-I6
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:21:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hcphC-0005L4-CB
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:21:07 -0400
Received: from mail-eopbgr140130.outbound.protection.outlook.com
 ([40.107.14.130]:23687 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hcph9-0005Eq-4E; Mon, 17 Jun 2019 07:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjYM64s46YNUc8URN4YF9XDQUBUad2q/cFsC3ipqqfE=;
 b=YIUHE0+O28qIV6OQ/KTV4Qg5HHu3qiLLKNHlRKPbiBx1ZuBJ171q9D0o1GD87Zl4Ve8SU6yvvWbqXCd7coem3c3hZQ78LFmt3KAwLUDbYt77ghAaOGydRhlC3khAXaJFX57q0GQ8GFiUngIxnVO5NH7x6O1cDTg97/9mD1xIqi4=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB4473.eurprd08.prod.outlook.com (20.179.43.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Mon, 17 Jun 2019 11:20:43 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Mon, 17 Jun 2019
 11:20:43 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH 0/3] block: blk_co_pcache
Thread-Index: AQHVHG6Gw8f3OdFEe0GxA9A7ku3zhaaOpkUAgAADMICAERsRAA==
Date: Mon, 17 Jun 2019 11:20:42 +0000
Message-ID: <4ec35629-0c64-9727-780f-31e4e494f376@virtuozzo.com>
References: <20190606134814.123689-1-vsementsov@virtuozzo.com>
 <f92b274d-1949-3afa-7353-d3e3d67ae705@redhat.com>
 <dbacab33-ccb4-0c1e-5ce3-7214bd405701@virtuozzo.com>
In-Reply-To: <dbacab33-ccb4-0c1e-5ce3-7214bd405701@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0401CA0063.eurprd04.prod.outlook.com
 (2603:10a6:3:19::31) To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190617142040354
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6de147fc-97fb-44f1-2cdd-08d6f315d5d9
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4473; 
x-ms-traffictypediagnostic: DBBPR08MB4473:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DBBPR08MB44734E34CD5D30FFB692D5AAC1EB0@DBBPR08MB4473.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0071BFA85B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(346002)(39840400004)(136003)(366004)(53754006)(199004)(189003)(66066001)(476003)(66946007)(66446008)(64756008)(6306002)(66556008)(66476007)(4326008)(6512007)(36756003)(316002)(71200400001)(71190400001)(25786009)(6246003)(6436002)(73956011)(2906002)(107886003)(26005)(53936002)(31686004)(186003)(6486002)(305945005)(2616005)(3846002)(99286004)(8676002)(2201001)(6506007)(68736007)(76176011)(102836004)(5660300002)(6116002)(386003)(53546011)(478600001)(229853002)(81166006)(81156014)(486006)(2501003)(14444005)(256004)(54906003)(8936002)(110136005)(7736002)(11346002)(86362001)(31696002)(446003)(14454004)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4473;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oC9gpoyJXJhUW9hGlDv19H2ebc9/WUY316zKQRkClztVKsRXaxqlpHgzg0KNm3QI8qvobs8UwNIriSnp3lE4+3nzV2MRilv5V+OSbENsqRzmE+1BiDAUPxdLPT8nVa0NYSGZb00b6qoRPVuc2NXKQ9yeuy7fPiUwpzVJRupjhkNuoS/toGN6goutsXRq5MDsFEyBHIoXEJ15d2C1rADJv3o8oBRTEnXJCpKpd9KGNYY5gE3ozV+YexiNE6cKo2zcSO1IrFEA97E6V7kxnkemj/3WkiuJUpOlrpNjjLiGVWzUf/+Hg7EpYlDsUyGWlRz6kWPY6gZcySioXVVttCuHKNyTCQMbZ5ZUpviUDiOU8xjUR5ntgxfrF5qWimiXWxPIH6gigd2zsw4DbLdURrMhwDQ99u318Pz+5iLeEV9oNxo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9385F9CB469E224CB0B1AC38CE742ACB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de147fc-97fb-44f1-2cdd-08d6f315d5d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2019 11:20:42.8825 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4473
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.130
Subject: Re: [Qemu-devel] [PATCH 0/3] block: blk_co_pcache
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDYuMDYuMjAxOSAxNzowNywgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MDYuMDYuMjAxOSAxNjo1NSwgRXJpYyBCbGFrZSB3cm90ZToNCj4+IE9uIDYvNi8xOSA4OjQ4IEFN
LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4+IEhpIGFsbCENCj4+Pg0K
Pj4+IEhlcmUgaXMgc21hbGwgbmV3IGlvIEFQSTogYmxrX2NvX3BjYWNoZSwgd2hpY2ggZG9lcyBj
b3B5LW9uLXJlYWQgd2l0aG91dA0KPj4+IGV4dHJhIGJ1ZmZlciBmb3IgcmVhZCBkYXRhLiBUaGlz
IG1lYW5zIHRoYXQgb25seSBwYXJ0cyB0aGF0IG5lZWRzIENPUg0KPj4+IHdpbGwgYmUgYWN0dWFs
bHkgcmVhZCBhbmQgb25seSBjb3JyZXNwb25kaW5nIGJ1ZmZlcnMgYWxsb2NhdGVkLCBubyBtb3Jl
Lg0KPj4+DQo+Pj4gVGhpcyBhbGxvd3MgdG8gaW1wcm92ZSBhIGJpdCBibG9jay1zdHJlYW0gYW5k
IE5CRF9DTURfQ0FDSEUNCj4+DQo+PiBJJ2QgcmVhbGx5IGxpa2UgdG8gc2VlIHFlbXUtaW8gZ2Fp
biBhY2Nlc3MgdG8gY2FsbGluZyB0aGlzIGNvbW1hbmQsIHNvDQo+PiB0aGF0IHdlIGNhbiBhZGQg
aW90ZXN0cyBjb3ZlcmFnZSBvZiB0aGlzIG5ldyBmZWF0dXJlLiBOb3RlIHRoYXQgdGhlDQo+PiBp
bi1kZXZlbG9wbWVudCBsaWJuYmQNCj4+IChodHRwczovL2dpdGh1Yi5jb20vbGliZ3Vlc3Rmcy9s
aWJuYmQvY29tbWl0cy9tYXN0ZXIpIGlzIGFsc28gdXNhYmxlIGFzDQo+PiBhbiBOQkQgY2xpZW50
IHRoYXQgY2FuIGRyaXZlIE5CRF9DTURfQ0FDSEUsIGFsdGhvdWdoIGl0J3Mgc3RpbGwgbmV3DQo+
PiBlbm91Z2ggdGhhdCB3ZSBwcm9iYWJseSBkb24ndCB3YW50IHRvIHJlbHkgb24gaXQgYmVpbmcg
YXZhaWxhYmxlIHlldC4NCj4+DQo+IA0KPiBIbW0sIGRvbid0IHlvdSB0aGluayB0aGF0IGJsa19j
b19wY2FjaGUgc2VuZHMgTkJEX0NNRF9DQUNIRSBpZiBjYWxsZWQgb24gbmJkIGRyaXZlcj8NCj4g
SSBkaWRuJ3QgaW1wbGVtZW50IGl0LiBCdXQgbWF5IGJlIEkgc2hvdWxkLi4NCj4gDQo+IE1heSBh
aW0gd2FzIG9ubHkgdG8gYXZvaWQgZXh0cmEgYWxsb2NhdGlvbiBhbmQgdW5uZWNlc3NhcnkgcmVh
ZHMuIEJ1dCBpZiB3ZSBpbXBsZW1lbnQNCj4gZnVsbC1mZWF0dXJlZCBpbyByZXF1ZXN0LCB3aGF0
IHNob3VsZCBpdCBkbz8NCj4gDQo+IE9uIHFjb3cyIHdpdGggYmFja2luZyBpdCBzaG91bGQgcHVs
bCBkYXRhIGZyb20gYmFja2luZyB0byB0b3AsIGxpa2UgaW4gY29weS1vbi1yZWFkLg0KPiBBbmQg
Zm9yIG5iZCBpdCB3aWxsIHNlbmQgTkJEX0NNRF9DQUNIRT8NCj4gVGhlc2Ugc2VtYW50aWNzIHNl
ZW1zIGRpZmZlcmVudCwgYnV0IHdoeSBub3Q/DQo+IA0KDQpBbnkgb3BpbmlvbnMgaGVyZT8gU2hv
dWxkIEkgcmVzZW5kIG9yIGNvdWxkIHdlIHVzZSBpdCBhcyBhIGZpcnN0IHN0ZXAsIG5vdCB0b3Vj
aGluZw0KZXh0ZXJuYWwgQVBJIGJ1dCBpbXByb3ZpbmcgdGhpbmdzIGEgbGl0dGxlIGJpdD8NCg0K
DQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

