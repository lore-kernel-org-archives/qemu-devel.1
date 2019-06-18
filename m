Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F90C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 06:53:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A40E420665
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 06:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="beukqylf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40E420665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54198 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd805-00022v-Ou
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 02:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45139)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hd7zQ-0001WY-Nt
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 02:53:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hd7zP-0008AP-Kv
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 02:53:08 -0400
Received: from mail-eopbgr60090.outbound.protection.outlook.com
 ([40.107.6.90]:17544 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hd7zM-00085p-Ri; Tue, 18 Jun 2019 02:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SGYiHVmIJo2dwUgqZEGTnxJ5ei8Xr2hVsRtB6QH8l0=;
 b=beukqylfou41H/fUUPwk1DyFOf9dGMeYyuLCh08zE14PWLFIs/gwUSV7XR/svORlg2NNFsV9NwPCq5dADWU8txyu3TMojuYlx7KEsFR8JaW+ByrtHJ9EIPzJgswe2+K5dVtcE5gZTdRdcVSZaTj1oxru8IkK2hfQr4aV9yrvYhM=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB4505.eurprd08.prod.outlook.com (20.179.44.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Tue, 18 Jun 2019 06:53:01 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 06:53:01 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH 4/4] block: drop bs->job
Thread-Index: AQHVHH5ckZE5QwptpUK7M+YPdbmIM6agItQAgADpG4A=
Date: Tue, 18 Jun 2019 06:53:01 +0000
Message-ID: <4c333fd6-35c1-d1b1-9c3f-63b6fca24bc2@virtuozzo.com>
References: <20190606154132.153330-1-vsementsov@virtuozzo.com>
 <20190606154132.153330-5-vsementsov@virtuozzo.com>
 <20190617165838.GN7397@linux.fritz.box>
In-Reply-To: <20190617165838.GN7397@linux.fritz.box>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0081.eurprd07.prod.outlook.com
 (2603:10a6:3:64::25) To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190618095257602
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2efcd5c3-9880-4b69-f905-08d6f3b99a79
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4505; 
x-ms-traffictypediagnostic: DBBPR08MB4505:
x-microsoft-antispam-prvs: <DBBPR08MB4505694B2289B0A1864AEC5BC1EA0@DBBPR08MB4505.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(376002)(346002)(396003)(366004)(136003)(39850400004)(189003)(199004)(66446008)(66556008)(64756008)(73956011)(14454004)(4326008)(186003)(107886003)(68736007)(7736002)(6246003)(305945005)(26005)(8936002)(86362001)(5660300002)(8676002)(66066001)(66946007)(66476007)(81156014)(81166006)(53936002)(31696002)(476003)(99286004)(102836004)(54906003)(14444005)(11346002)(486006)(478600001)(256004)(76176011)(316002)(52116002)(2616005)(6512007)(25786009)(229853002)(386003)(6506007)(3846002)(6116002)(6916009)(31686004)(6436002)(71200400001)(446003)(71190400001)(6486002)(36756003)(2906002)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4505;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QMd36YE5xsE8ZegVUQqzSu/+dD/zO3wZarfzFQ6XGP0syZGmFAXSzLLox486jTy5+C4Nk2RkwlFEWfxhV4QB/CCgJKkuT9gQlStgj02b3FKrpueSpzd55orl7jYkV33Wx5LAHvEYuAA8xQJQWnai6iYqC96MYA8tgyBQyT1/QT7xN3uLVO/Zq+1LvKNc9WHmnAczrhl9wNqw+zX1x9CJTx1qIuawlxTn2XoUUh3G/+GROwgz8VNv6T6NJunc6tVOwMoQm3/EiU8eqiQ6+VrrqQ3wAbT6ofHimu9r8QWeT/bh0RD626Yz+zIiHhdJNW8WeLC1jhv4godlZIzY4SpalbMbeYC00HM8+jWTP6EMiT+khbrVJSZLGiGLh7/2F88/7Esus+N1/srFyOX6CTuSWTLNuM9+cJLzsz8vx0rUP7M=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37919EF80640D6498638EFF6F32F02ED@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efcd5c3-9880-4b69-f905-08d6f3b99a79
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 06:53:01.3523 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4505
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.90
Subject: Re: [Qemu-devel] [PATCH 4/4] block: drop bs->job
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
Cc: Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "wencongyang2@huawei.com" <wencongyang2@huawei.com>,
 "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTcuMDYuMjAxOSAxOTo1OCwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMDYuMDYuMjAxOSB1bSAx
Nzo0MSBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IERy
b3AgcmVtYWluaW5nIHVzZXJzIG9mIGJzLT5qb2I6DQo+PiAxLiBhc3NlcnRpb25zIGFjdHVhbGx5
IGR1cGxpY2F0ZWQgYnkgYXNzZXJ0KCFicy0+cmVmY250KQ0KPj4gMi4gdHJhY2UtcG9pbnQgc2Vl
bXMgbm90IGVub3VnaCByZWFzb24gdG8gY2hhbmdlIHN0cmVhbV9zdGFydCB0byByZXR1cm4NCj4+
ICAgICBCbG9ja0pvYiBwb2ludGVyDQo+PiAzLiBSZXN0cmljdGluZyBjcmVhdGlvbiBvZiB0d28g
am9icyBiYXNlZCBvbiBzYW1lIGJzIGlzIGJhZCBpZGVhLCBhcw0KPj4gICAgIDMuMSBTb21lIGpv
YnMgY3JlYXRlcyBmaWx0ZXJzIHRvIGJlIHRoZWlyIG1haW4gbm9kZSwgc28sIHRoaXMgY2hlY2sN
Cj4+ICAgICBkb24ndCBhY3R1YWxseSBwcmV2ZW50IGNyZWF0aW5nIHNlY29uZCBqb2Igb24gc2Ft
ZSByZWFsIG5vZGUgKHdoaWNoDQo+PiAgICAgd2lsbCBjcmVhdGUgYW5vdGhlciBmaWx0ZXIgbm9k
ZSkgKGJ1dCBJIGhvcGUgaXQgaXMgcmVzdHJpY3RlZCBieQ0KPj4gICAgIG90aGVyIG1lY2hhbmlz
bXMpDQo+PiAgICAgMy4yIEV2ZW4gd2l0aG91dCBicy0+am9iIHdlIGhhdmUgdHdvIHN5c3RlbXMg
b2YgcGVybWlzc2lvbnM6DQo+PiAgICAgb3AtYmxvY2tlcnMgYW5kIEJMS19QRVJNDQo+PiAgICAg
My4zIFdlIG1heSB3YW50IHRvIHJ1biBzZXZlcmFsIGpvYnMgb24gb25lIG5vZGUgb25lIGRheQ0K
PiANCj4gVGhpcyBtYWRlIG1ha2UgY2hlY2sgYnJlYWsgKHRlc3QtYmxvY2tqb2IgdGVzdHMgdGhh
dCB5b3UgY2FuJ3QgY3JlYXRlDQo+IHR3byBibG9jayBqb2JzIG9uIHRoZSBzYW1lIG5vZGUpLiBT
byBJIG5lZWQgdG8gc3F1YXNoIGluIHRoZSBmb2xsb3dpbmcsDQo+IGlmIHlvdSBhZ3JlZS4NCj4g
DQo+IEtldmluDQo+IA0KPiANCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3Rlc3QtYmxvY2tqb2IuYyBi
L3Rlc3RzL3Rlc3QtYmxvY2tqb2IuYw0KPiBpbmRleCA4YzkxOTgwYzcwLi5iMzNmODk5ODczIDEw
MDY0NA0KPiAtLS0gYS90ZXN0cy90ZXN0LWJsb2Nram9iLmMNCj4gKysrIGIvdGVzdHMvdGVzdC1i
bG9ja2pvYi5jDQo+IEBAIC0xMjIsOCArMTIyLDkgQEAgc3RhdGljIHZvaWQgdGVzdF9qb2JfaWRz
KHZvaWQpDQo+ICAgICAgIC8qIFRoaXMgb25lIGlzIHZhbGlkICovDQo+ICAgICAgIGpvYlswXSA9
IGRvX3Rlc3RfaWQoYmxrWzBdLCAiaWQwIiwgdHJ1ZSk7DQo+IA0KPiAtICAgIC8qIFdlIGNhbm5v
dCBoYXZlIHR3byBqb2JzIGluIHRoZSBzYW1lIEJEUyAqLw0KPiAtICAgIGRvX3Rlc3RfaWQoYmxr
WzBdLCAiaWQxIiwgZmFsc2UpOw0KPiArICAgIC8qIFdlIGNhbiBoYXZlIHR3byBqb2JzIGluIHRo
ZSBzYW1lIEJEUyAqLw0KPiArICAgIGpvYlsxXSA9IGRvX3Rlc3RfaWQoYmxrWzBdLCAiaWQxIiwg
dHJ1ZSk7DQo+ICsgICAgam9iX2Vhcmx5X2ZhaWwoJmpvYlsxXS0+am9iKTsNCj4gDQo+ICAgICAg
IC8qIER1cGxpY2F0ZSBqb2IgSURzIGFyZSBub3QgYWxsb3dlZCAqLw0KPiAgICAgICBqb2JbMV0g
PSBkb190ZXN0X2lkKGJsa1sxXSwgImlkMCIsIGZhbHNlKTsNCj4gDQoNCkkgYWdyZWUsIHRoYW5r
cy4gU29ycnkgZm9yIG1lIGFsd2F5cyBydW5uaW5nIG9ubHkgaW90ZXN0cyBhbmQgaWdub3Jpbmcg
bWFrZSBjaGVjayA6KA0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

