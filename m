Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99658C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 18:40:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13E372080C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 18:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KCVlApmG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E372080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htG0J-00088Q-7n
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 14:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60120)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1htFtd-0001Jl-IM
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1htFtZ-0004OO-Lq
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:33:49 -0400
Received: from mail-ve1eur01on0725.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::725]:43138
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1htFtX-0004MP-QO
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:33:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVjrIgHg/hL274sJVc/NCAsntWEolg5D9rS2afIvOEqN8nuq1HGys348QkPkq5j9Q14u8YSPWmtX4fWN7r5O2efwAxjDZugNFKFN1GOU59MXztMi+w9yD0faU0NmedgsfH6EfR1iFHE2v8IhTNnrqoc1AZvj2gzuzNp5eZIabaxkhm+FVAY18BtZ/EHdQSYCquUMqm3YoMOiPBvfA05VGC5lGxiFUjHJau59XtFyzHRXAMD0MkQ1jYdhVsZolOh1T08tQxuPJI8ty3oRVjLuJxKGr3w44IwOCdsiunzh9cf8FvxuMsdMdEYMh7E+xmRv5qjYkqQqvH6Sm+9O+kllsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZN3/0m5eZSIhrDYoNJjG+vI0YWS9GeisEUNbuejIgc=;
 b=RrjaIYvnnOR3Za7Ds31Z/umgcO6sW9HeMpZdlPjjIzTGpSb9qs10dW2/SOrJjawOQl87yQe1JX63ip/6X9QV8q1/OWHArOQMBAyf02Y7TRMW3JRQINmWBe9FFTpGQm5emh593uXhfCZ66j9Xb9nCqSFXGxTDPT9G/lXSHFK585tZwm93Kc1IJFmc2BEH0yC9ihujim3HHJGyvMSV5uuT0hZAdmgrQkCY+Qgnn3IgJGKodc3pMbZwDf//dgujlvx7cSq/Qgb9rqCLB8LXbFXopNcY1zgik7GMErp7kh2LvgFN9LNkgplIkiKmVkk85QYb1NO9gnY1YqcP+LroV3Pnxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZN3/0m5eZSIhrDYoNJjG+vI0YWS9GeisEUNbuejIgc=;
 b=KCVlApmGb4EVDNstvJ9SAm1it5redtZG2qKqPRXsjAvC6EVUHKedTuunerQHY9Pn5dDGEhJot+rOGl74ppDnzK6ujrx3l0HTeBPiMKwzHMUjFLkJGgLOCFooNrI9YrMxde+Lo6C6E8fRym2cLuxjRxlzE4J2XLm3kBpdifRW27Y=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB2928.eurprd08.prod.outlook.com (10.170.239.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Thu, 1 Aug 2019 18:33:36 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::303d:1bb9:76b2:99d7]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::303d:1bb9:76b2:99d7%6]) with mapi id 15.20.2136.010; Thu, 1 Aug 2019
 18:33:36 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH] make check-unit: use after free in
 test-opts-visitor
Thread-Index: AQHVPNLZ0XoG36qCN0iED1VlzsbVT6bl95bMgAC+A4A=
Date: Thu, 1 Aug 2019 18:33:36 +0000
Message-ID: <afdcb66b-6236-b7fc-0bf2-7a2f333da06e@virtuozzo.com>
References: <1563390416-751339-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <87h871uzn2.fsf@dusky.pond.sub.org>
In-Reply-To: <87h871uzn2.fsf@dusky.pond.sub.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0035.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::24)
 To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb51cd18-5aef-4542-6830-08d716aec3cd
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB2928; 
x-ms-traffictypediagnostic: VI1PR08MB2928:
x-microsoft-antispam-prvs: <VI1PR08MB292844AED35732B35617A605F4DE0@VI1PR08MB2928.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(39850400004)(346002)(136003)(366004)(396003)(199004)(189003)(14454004)(54906003)(6512007)(99286004)(316002)(14444005)(256004)(2906002)(478600001)(31696002)(102836004)(6436002)(53936002)(53546011)(6486002)(6506007)(6916009)(386003)(3846002)(6116002)(66446008)(64756008)(66946007)(5660300002)(66556008)(66476007)(4326008)(229853002)(6246003)(25786009)(52116002)(76176011)(44832011)(66066001)(486006)(86362001)(26005)(305945005)(36756003)(31686004)(8676002)(81156014)(186003)(81166006)(2616005)(8936002)(71190400001)(71200400001)(68736007)(476003)(7736002)(11346002)(446003)(20703003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB2928;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BpD8GqlvoXHBfWT3vEzuMbv03LFDL7K2CbO6k2yCv0ZUis3y3RkbVntpa7q76O28iIYjvjD9Z82wgV7wNd4rlBqyplPjEKpLLlj+iu7rjh2io96E80gmJC/K9z1BI6RyexSagblMTqHlwAmGYDvo9TgHOaBEyV5DP0zNg7cxGDWfBsbYQfjgsjfgL/C5recrWqlAbRoyVRrEBqecbcUGm/PLhAgV5XIILVSp/BA5RtaOicyYln3QmNHTUVlS6ied69m+HhPkrZj8PRANBoELOIO0o/Gh8cOJJ24cws8h/VX64wbLfbj8xXUMnRu+PgScT9A+mMUx5CMFefxoRi+2et6gKoGWXVM8NuKpxWFK8nPswAXZfXndmF1fulA1G/KrKZkvP7/8vHUBVowq517tLqI220t24f0IpIXnG+wILVg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14BFEA61D6441142A5CDFBA9D32AE3E6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb51cd18-5aef-4542-6830-08d716aec3cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 18:33:36.3132 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andrey.shinkevich@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2928
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe1f::725
Subject: Re: [Qemu-devel] [PATCH] make check-unit: use after free in
 test-opts-visitor
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
Cc: "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDAxLzA4LzIwMTkgMTA6MTMsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBBbmRy
ZXkgU2hpbmtldmljaCA8YW5kcmV5LnNoaW5rZXZpY2hAdmlydHVvenpvLmNvbT4gd3JpdGVzOg0K
PiANCj4+IEluIHN0cnVjdCBPcHRzVmlzaXRvciwgcmVwZWF0ZWRfb3B0cyBtZW1iZXIgcG9pbnRz
IHRvIGEgbGlzdCBpbiB0aGUNCj4+IHVucHJvY2Vzc2VkX29wdHMgaGFzaCB0YWJsZSBhZnRlciB0
aGUgbGlzdCBoYXMgYmVlbiBkZXN0cm95ZWQuIEENCj4+IHN1YnNlcXVlbnQgY2FsbCB0byB2aXNp
dF90eXBlX2ludCgpIHJlZmVyZW5jZXMgdGhlIGRlbGV0ZWQgbGlzdC4gSXQNCj4+IHJlc3VsdHMg
aW4gdXNlLWFmdGVyLWZyZWUgaXNzdWUuIEFsc28sIHRoZSBWaXNpdG9yIG9iamVjdCBjYWxsIGJh
Y2sNCj4+IGZ1bmN0aW9ucyBhcmUgc3VwcG9zZWQgdG8gc2V0IHRoZSBFcnJvciBwYXJhbWV0ZXIg
aW4gY2FzZSBvZiBmYWlsdXJlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBTaGlua2V2
aWNoIDxhbmRyZXkuc2hpbmtldmljaEB2aXJ0dW96em8uY29tPg0KPj4gLS0tDQo+Pg0KPj4gVGhl
IGlzc3VlIHdhcyBkZXRlY3RlZCBhZnRlciBydW5uaW5nIHRlc3RzL3Rlc3Qtb3B0cy12aXNpdG9y
IHVuZGVyIHRoZSBWYWxncmluZCB0b29sOg0KPj4NCj4+ICAgSW52YWxpZCByZWFkIG9mIHNpemUg
OA0KPj4gICAgIGF0IDB4NTVBREI5NTogZ19xdWV1ZV9wZWVrX2hlYWQgKGluIC91c3IvbGliNjQv
bGliZ2xpYi0yLjAuc28uMC41NjAwLjEpDQo+PiAgICAgYnkgMHgxMkZEOTc6IGxvb2t1cF9zY2Fs
YXIgKG9wdHMtdmlzaXRvci5jOjMxMCkNCj4+ICAgICBieSAweDEzMDA4QTogb3B0c190eXBlX2lu
dDY0IChvcHRzLXZpc2l0b3IuYzozOTUpDQo+PiAgICAgYnkgMHgxMjk5Qzg6IHZpc2l0X3R5cGVf
aW50IChxYXBpLXZpc2l0LWNvcmUuYzoxNDkpDQo+PiAgICAgYnkgMHgxMTkzODk6IHRlc3Rfb3B0
c19yYW5nZV9iZXlvbmQgKHRlc3Qtb3B0cy12aXNpdG9yLmM6MjQwKQ0KPj4NCj4+IGFmdGVyDQo+
PiAgIEFkZHJlc3MgMHg5NTYzYjMwIGlzIDAgYnl0ZXMgaW5zaWRlIGEgYmxvY2sgb2Ygc2l6ZSAy
NCBmcmVlJ2QNCj4+ICAgICBhdCAweDRDMkFDQkQ6IGZyZWUgKHZnX3JlcGxhY2VfbWFsbG9jLmM6
NTMwKQ0KPj4gICAgIGJ5IDB4NTVBMTc5RDogZ19mcmVlIChpbiAvdXNyL2xpYjY0L2xpYmdsaWIt
Mi4wLnNvLjAuNTYwMC4xKQ0KPj4gICAgIGJ5IDB4NTVCOTJCRjogZ19zbGljZV9mcmVlMSAoaW4g
L3Vzci9saWI2NC9saWJnbGliLTIuMC5zby4wLjU2MDAuMSkNCj4+ICAgICBieSAweDEyRjYxNTog
ZGVzdHJveV9saXN0IChvcHRzLXZpc2l0b3IuYzoxMDIpDQo+PiAgICAgYnkgMHg1NThBODU5OiA/
Pz8gKGluIC91c3IvbGliNjQvbGliZ2xpYi0yLjAuc28uMC41NjAwLjEpDQo+PiAgICAgYnkgMHgx
MkZDMzc6IG9wdHNfbmV4dF9saXN0IChvcHRzLXZpc2l0b3IuYzoyNjApDQo+PiAgICAgYnkgMHgx
Mjk2QjE6IHZpc2l0X25leHRfbGlzdCAocWFwaS12aXNpdC1jb3JlLmM6ODgpDQo+PiAgICAgYnkg
MHgxMTkzNDE6IHRlc3Rfb3B0c19yYW5nZV9iZXlvbmQgKHRlc3Qtb3B0cy12aXNpdG9yLmM6MjM4
KQ0KPiANCj4gUmVwcm9kdWNlZC4NCj4gDQo+Pg0KPj4gICBxYXBpL29wdHMtdmlzaXRvci5jIHwg
MTAgKysrKysrKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9xYXBpL29wdHMtdmlzaXRvci5jIGIvcWFwaS9vcHRzLXZpc2l0b3Iu
Yw0KPj4gaW5kZXggMzI0YjE5Ny4uZTk1Zjc2NiAxMDA2NDQNCj4+IC0tLSBhL3FhcGkvb3B0cy12
aXNpdG9yLmMNCj4+ICsrKyBiL3FhcGkvb3B0cy12aXNpdG9yLmMNCj4+IEBAIC0yMjgsNiArMjI4
LDcgQEAgb3B0c19zdGFydF9saXN0KFZpc2l0b3IgKnYsIGNvbnN0IGNoYXIgKm5hbWUsIEdlbmVy
aWNMaXN0ICoqbGlzdCwgc2l6ZV90IHNpemUsDQo+ICAgICAgICAgb3YtPnJlcGVhdGVkX29wdHMg
PSBsb29rdXBfZGlzdGluY3Qob3YsIG5hbWUsIGVycnApOw0KPiAgICAgICAgIGlmIChvdi0+cmVw
ZWF0ZWRfb3B0cykgew0KPiAgICAgICAgICAgICBvdi0+bGlzdF9tb2RlID0gTE1fSU5fUFJPR1JF
U1M7DQo+PiAgICAgICAgICAgKmxpc3QgPSBnX21hbGxvYzAoc2l6ZSk7DQo+PiAgICAgICB9IGVs
c2Ugew0KPj4gICAgICAgICAgICpsaXN0ID0gTlVMTDsNCj4+ICsgICAgICAgIGVycm9yX3NldGco
ZXJycCwgUUVSUl9NSVNTSU5HX1BBUkFNRVRFUiwgbmFtZSk7DQo+IA0KPiBUbyBnZXQgaGVyZSwg
bG9va3VwX2Rpc3RpbmN0KCkgbXVzdCBoYXZlIHJldHVybmVkIG51bGwuICBJdCBzZXQgYW4gZXJy
b3INCj4gdGhlbi4gIFNldHRpbmcgaXQgYWdhaW4gd2lsbCBjcmFzaC4gIFN1cmUgeW91IHRlc3Rl
ZCB0aGlzPw0KPiANCg0KQWdyZWVkLCB0aGFuayB5b3UuIEkgd2lsbCByZW1vdmUgdGhhdCByZWR1
bmRhbnQgbGluZSBpbiB2Mi4NCg0KQW5kcmV5DQoNCj4+ICAgICAgIH0NCj4+ICAgfQ0KPj4gICAN
Cj4+IEBAIC0yNTUsOSArMjU2LDE0IEBAIG9wdHNfbmV4dF9saXN0KFZpc2l0b3IgKnYsIEdlbmVy
aWNMaXN0ICp0YWlsLCBzaXplX3Qgc2l6ZSkNCj4+ICAgICAgIGNhc2UgTE1fSU5fUFJPR1JFU1M6
IHsNCj4+ICAgICAgICAgICBjb25zdCBRZW11T3B0ICpvcHQ7DQo+PiAgIA0KPj4gKyAgICAgICAg
aWYgKCFvdi0+cmVwZWF0ZWRfb3B0cykgew0KPj4gKyAgICAgICAgICAgIHJldHVybiBOVUxMOw0K
Pj4gKyAgICAgICAgfQ0KPiANCj4gSG93IGNhbiBvdi0+cmVwZWF0ZWRfb3B0cyBiZSBudWxsIGlu
IHN0YXRlIExNX0lOX1BST0dSRVNTPw0KPiANCj4gb3YtPnJlcGVhdGVkX29wdHMgaXMgaW5pdGlh
bGx5IG51bGwgKHN0YXRlIExNX05PTkUpLiAgSXQgYmVjb21lcw0KPiBub24tbnVsbCBvbiB0cmFu
c2l0aW9uIHRvIHN0YXRlIExNX0lOX1BST0dSRVNTIGluIG9wdHNfc3RhcnRfbGlzdCgpLCBhbmQN
Cj4gbnVsbCBvbiB0cmFuc2l0aW9uIGJhY2sgdG8gTE1fTk9ORSBpbiBvcHRzX2VuZF9saXN0KCku
DQo+IA0KPj4gKw0KPj4gICAgICAgICAgIG9wdCA9IGdfcXVldWVfcG9wX2hlYWQob3YtPnJlcGVh
dGVkX29wdHMpOw0KPj4gICAgICAgICAgIGlmIChnX3F1ZXVlX2lzX2VtcHR5KG92LT5yZXBlYXRl
ZF9vcHRzKSkgew0KPj4gICAgICAgICAgICAgICBnX2hhc2hfdGFibGVfcmVtb3ZlKG92LT51bnBy
b2Nlc3NlZF9vcHRzLCBvcHQtPm5hbWUpOw0KPj4gKyAgICAgICAgICAgIG92LT5yZXBlYXRlZF9v
cHRzID0gTlVMTDsNCj4+ICAgICAgICAgICAgICAgcmV0dXJuIE5VTEw7DQo+PiAgICAgICAgICAg
fQ0KPiANCj4gVWgsIG5vdyB5b3UncmUgdmlvbGF0aW5nIHRoZSBpbnZhcmlhbnQgSSBqdXN0IGRl
c2NyaWJlZC4gIEkgc3VzcGVjdA0KPiB0aGF0J3MgaG93IG51bGwgY2FuIGhhcHBlbiBub3cuDQo+
IA0KPiBJZiB0aGUgZml4IHNob3VsZCBjaGFuZ2UgdGhlIGludmFyaWFudCwgd2UgbmVlZCB0byBy
ZXZpZXcgdGhlIGVudGlyZQ0KPiBmaWxlIHRvIG1ha2Ugc3VyZSBub3RoaW5nIHRoYXQgcmVsaWVz
IG9uIHRoZSBpbnZhcmlhbnQgcmVtYWlucy4gIFRoZQ0KPiAhb3YtPnJlcGVhdGVkX29wdHMgY2hl
Y2sgYWJvdmUgdGFrZXMgY2FyZSBvZiBvbmUgY2FzZS4gIFRoZXJlIG1heSBiZQ0KPiBtb3JlLiAg
QmVmb3JlIHdlIHNlYXJjaCBmb3IgdGhlbSwgbGV0J3MgaGF2ZSBhIGNsb3NlciBsb29rIGF0IHRo
ZSBidWcNCj4geW91IGZvdW5kLiAgSSdsbCBkbyB0aGF0IGJlbG93Lg0KPiANCj4+ICAgICAgICAg
ICBicmVhazsNCj4+IEBAIC0zMDcsNiArMzEzLDEwIEBAIGxvb2t1cF9zY2FsYXIoY29uc3QgT3B0
c1Zpc2l0b3IgKm92LCBjb25zdCBjaGFyICpuYW1lLCBFcnJvciAqKmVycnApDQo+PiAgICAgICAg
ICAgcmV0dXJuIGxpc3QgPyBnX3F1ZXVlX3BlZWtfdGFpbChsaXN0KSA6IE5VTEw7DQo+PiAgICAg
ICB9DQo+PiAgICAgICBhc3NlcnQob3YtPmxpc3RfbW9kZSA9PSBMTV9JTl9QUk9HUkVTUyk7DQo+
PiArICAgIGlmICghb3YtPnJlcGVhdGVkX29wdHMpIHsNCj4+ICsgICAgICAgIGVycm9yX3NldGco
ZXJycCwgUUVSUl9JTlZBTElEX1BBUkFNRVRFUiwgbmFtZSk7DQo+PiArICAgICAgICByZXR1cm4g
TlVMTDsNCj4+ICsgICAgfQ0KPiANCj4gVGhpcyBpcyBhbm90aGVyIGNhc2UuDQo+IA0KPj4gICAg
ICAgcmV0dXJuIGdfcXVldWVfcGVla19oZWFkKG92LT5yZXBlYXRlZF9vcHRzKTsNCj4+ICAgfQ0K
PiANCj4gTm93IGxldCdzIHN0ZXAgYmFjayBhbmQgcmV2aWV3IHdoYXQgdmFsZ3JpbmQgaXMgdGVs
bGluZyB1cy4NCj4gDQo+IFRoZSBpbnZhbGlkIHJlYWQgaXMgaW5kZWVkIGEgdXNlIGFmdGVyIGZy
ZWUuDQo+IA0KPiBUaGUgZnJlZSBpcyBvcHRzX25leHRfbGlzdCgpJ3MgZ19oYXNoX3RhYmxlX3Jl
bW92ZShvdi0+dW5wcm9jZXNzZWRfb3B0cywNCj4gb3B0LT5uYW1lKSwgd2hpY2ggaW4gdHVybiBj
YWxscyBkZXN0cm95X2xpc3QoKSB0byBkZXN0cm95IHRoZSB2YWx1ZQ0KPiBhc3NvY2lhdGVkIHdp
dGggb3B0LT5uYW1lLg0KPiANCj4gVGhlIHVzZSBpcyBsb29rdXBfc2NhbGFyKCkncyBnX3F1ZXVl
X3BlZWtfaGVhZChvdi0+cmVwZWF0ZWRfb3B0cykuDQo+IFdlJ3JlIGluIHN0YXRlIExNX0lOX1BS
T0dSRVNTLiAgb3YtPnJlcGVhdGVkX29wdHMgcG9pbnRzIHRvIGEgdmFsdWUNCj4gZnJlZWQgYnkg
b3B0c19uZXh0X2xpc3QoKS4NCj4gDQo+IEhhcHBlbnMgd2hlbiB0ZXN0X29wdHNfcmFuZ2VfYmV5
b25kKCkgdHJpZXMgdG8gdmlzaXQgbW9yZSBsaXN0IGVsZW1lbnRzDQo+IHRoYW4gYWN0dWFsbHkg
cHJlc2VudC4NCj4gDQo+IG92LT5yZXBlYXRlZF9vcHRzIGJlY29tZXMgZGFuZ2xpbmcgd2hlbiBv
cHRzX25leHRfbGlzdCgpIGRlc3Ryb3lzDQo+IG92LT51bnByb2Nlc3NlZF9vcHRzIG9uIHJlYWNo
aW5nIHRoZSBlbmQgb2YgdGhlIGxpc3QuICBZb3VyIHBhdGNoIHphcHMNCj4gaXQgcmlnaHQgYWZ0
ZXIgaXQgYmVjb21lcyBkYW5nbGluZy4gIEdvb2QuDQo+IA0KPiBCdXQgbm93IHRoZSBzdGF0ZSBt
YWNoaW5lIGhhcyBhIG5ldyBzdGF0ZSAidmlzaXRpbmcgYmV5b25kIGVuZCBvZiBsaXN0IjoNCj4g
bGlzdF9tb2RlID09IExNX0lOX1BST0dSRVNTLCByZXBlYXRlZF9vcHRzID09IE5VTEwuDQo+IA0K
PiBQZXJoYXBzIGdpdmluZyBpdCBpdHMgb3duIExpc3RNb2RlIG1lbWJlciB3b3VsZCBiZSBjbGVh
cmVyLg0KPiANCj4gUmVnYXJkbGVzcywgd2UgbmVlZCB0byBjb252aW5jZSBvdXJzZWx2ZXMgdGhh
dCB3ZSBoYW5kbGUgdGhlIG5ldyBzdGF0ZQ0KPiBjb3JyZWN0bHkgZXZlcnl3aGVyZS4gIEhhdmUg
eW91IGRvbmUgdGhhdD8NCj4gDQoNCkkgaGF2ZSBhbmFseXplZCB0aGUgY29kZSBpbiBxYXBpL29w
dHMtdmlzaXRvci5jIGFuZCBmZWVsIHNhZmVyIGp1c3QgDQphc3NpZ25pbmcgTlVMTCB0byB0aGUg
ZGFuZ2xpbmcgcG9pbnRlciBvdi0+cmVwZWF0ZWRfb3B0cyBhbmQgY2FuIHN0YXRlIA0KdGhhdCB0
aGUgdW5pdCB0ZXN0cyBhbmQgdGhlIGlvdGVzdHMgYXJlIHBhc3NlZC4gVG8ga2VlcCB0aGUgc3Rh
dGUgDQpjbGVhcmVyLCBhcyB5b3Ugc3VnZ2VzdGVkLCBJIGFtIGdvaW5nIHRvIGRlY2xhcmUgYSBu
ZXcgbW9kZSBMTV9UUkFWRVJTRUQgDQppbiB2Mi4NCg0KQW5kcmV5DQotLSANCldpdGggdGhlIGJl
c3QgcmVnYXJkcywNCkFuZHJleSBTaGlua2V2aWNoDQo=

