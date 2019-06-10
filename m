Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AA9C282DD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 09:35:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E58C207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 09:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NgKz/1rn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E58C207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42906 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haGiY-00051J-Ag
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 05:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45234)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1haGgs-0003KE-Cb
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1haGgp-00060A-BU
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:34:10 -0400
Received: from mail-eopbgr70120.outbound.protection.outlook.com
 ([40.107.7.120]:21634 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1haGgl-0005pg-UX; Mon, 10 Jun 2019 05:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5djQV5gIcqLBpJ4hidwwOLrCJI0MARRx4ghslJ/D6c4=;
 b=NgKz/1rnJb8v3Z5OC9WsGDVycPn07PJ1LjEMAE1+woeDRUhpFqMCb/WzuFugpquTnzQZ3g8mxiKdVRwLnkU/yiBNwaReb6MYegHfGjTEZ9G4p7422lg/G9RPQzBRKP8KiAkB7+Zga8wrTieWQSp6+UmOQqliJfvcjS5ZC5KlNzY=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB5106.eurprd08.prod.outlook.com (10.255.30.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Mon, 10 Jun 2019 09:33:49 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1965.017; Mon, 10 Jun 2019
 09:33:49 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 2/4] block/dirty-bitmap: add hide/unhide API
Thread-Index: AQHVGgPwBj3MFoZcyE+HgKuZ0A6+WqaQz8YAgAPbZQA=
Date: Mon, 10 Jun 2019 09:33:49 +0000
Message-ID: <f26f5edb-279e-8153-86bf-767cb04c4c74@virtuozzo.com>
References: <20190603120005.37394-1-vsementsov@virtuozzo.com>
 <20190603120005.37394-3-vsementsov@virtuozzo.com>
 <1e937a40-5ce2-467a-a50b-e8f822f2dcdc@redhat.com>
In-Reply-To: <1e937a40-5ce2-467a-a50b-e8f822f2dcdc@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0333.eurprd05.prod.outlook.com
 (2603:10a6:7:92::28) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190610123346452
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74b3f32d-3bbc-4498-635b-08d6ed86be0c
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB5106; 
x-ms-traffictypediagnostic: AM0PR08MB5106:
x-microsoft-antispam-prvs: <AM0PR08MB5106598C1927B3A6323265B2C1130@AM0PR08MB5106.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0064B3273C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(366004)(136003)(376002)(39840400004)(52314003)(199004)(189003)(25786009)(52116002)(110136005)(76176011)(102836004)(26005)(2201001)(6116002)(6512007)(3846002)(305945005)(7736002)(6436002)(31686004)(2906002)(53936002)(6486002)(4326008)(99286004)(2501003)(8936002)(71200400001)(478600001)(186003)(14454004)(31696002)(81156014)(107886003)(316002)(229853002)(68736007)(6246003)(8676002)(14444005)(86362001)(5660300002)(256004)(71190400001)(66066001)(54906003)(486006)(446003)(476003)(2616005)(66446008)(386003)(11346002)(64756008)(6506007)(53546011)(73956011)(36756003)(66946007)(81166006)(66556008)(66476007)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5106;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r6ZJj4hds05Rce4BcSPd+0idCNz0cuevQZyEJOUg7d+WAvmamfXmtEhnxFyibA7KR7i5977nwGNTKnEB6irjHjpKTRK4Uo5wYlr1HUyF8+Ewjnu0zmxei7TOkrw1cEKmRaquaqxaLZoCRrqGFYm+iXy/oUVfXQA4LY8gUEgsj9WPbx5+THfyVaFpHT1V59no6v9uSmugR/gwiAkkBEYQAM8LWmv+H0NeORYtxmmmK+MOWv2L/xaywvdlhDjNo7sNneXMh0DvZSnaU9fqhae30Fn8SoPVA5TVdlMqGHW5eXO2aWboJklhWGTor1SGqemcSJ0OesN3FgJiXPX+bJH46r0cfyU1BSYIC7hJcv7WigE+L6GdSz75zx35XOBjFzFxciUQtGmzsJJ0eCxK8GUlpH0srChmwexzlwFIdfdEPw0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80E35D5347AA194981D8B7858602C1BD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b3f32d-3bbc-4498-635b-08d6ed86be0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2019 09:33:49.1636 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5106
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.120
Subject: Re: [Qemu-devel] [PATCH 2/4] block/dirty-bitmap: add hide/unhide API
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
 Denis Lunev <den@virtuozzo.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDguMDYuMjAxOSAxOjM5LCBKb2huIFNub3cgd3JvdGU6DQo+IA0KPiANCj4gT24gNi8zLzE5IDg6
MDAgQU0sIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+PiBBZGQgZnVuY3Rp
b25hbGl0eSB0byBtYWtlIGJpdG1hcCB0ZW1wb3JhcnkgYW5vbnltb3VzLiBJdCB3aWxsIGJlIHVz
ZWQNCj4+IHRvIGltcGxlbWVudCBiaXRtYXAgcmVtb3ZlIHRyYW5zYWN0aW9uIGFjdGlvbi4gV2Ug
bmVlZCBoaWRlIGJpdG1hcA0KPj4gcGVyc2lzdGVuY2UgdG9vLCBhcyB0aGVyZSBhcmUgc2hvdWxk
IG5vdCBiZSB1bm5hbWVkIHBlcnNpc3RlbnQgYml0bWFwcy4NCj4+DQo+IA0KPiBBaCwgc28gdGhp
cyBlZmZlY3RpdmVseSAuLi4gImhpZGVzIiBhIGJpdG1hcCBmcm9tIGFueSBmdXJ0aGVyDQo+IHRy
YW5zYWN0aW9uIGFjdGlvbnMuIEl0IGFsc28gImhpZGVzIiBpdCBmcm9tIGdldHRpbmcgZmx1c2hl
ZCB0byBkaXNrLi4uDQo+IHNvcnQgb2Y/DQo+IA0KPiBUaGUgb3V0ZXIgbG9vcCBpbiBzdG9yZSB3
b3JrcyB3aXRoIGJkcnZfZGlydHlfYml0bWFwX25leHQsIGFuZCB3ZSdsbA0KPiBza2lwIHRoaXMg
Yml0bWFwIGJlY2F1c2UgaXQncyBhbm9ueW1vdXMvbm90IHBlcnNpc3RlbnQuDQo+IA0KPiBUaGVy
ZSdzIGEgc2Vjb25kIGxvb3Agd2hlcmUgd2UgaXRlcmF0ZSBibV9saXN0LCBhbmQgd2UnbGwgc2tp
cCBzdG9yaW5nDQo+IHRoaXMgYml0bWFwIGJlY2F1c2UgdGhhdCBlbnRyeSB3b24ndCBoYXZlIGFu
IGluLW1lbW9yeSBiaXRtYXAgYXNzb2NpYXRlZA0KPiB3aXRoIGl0IGluIGJtX2xpc3QuDQo+IA0K
PiAuLi5CdXQgdGhlbiB3ZSdsbCBjYWxsIHVwZGF0ZV9leHRfaGVhZGVyX2FuZF9kaXIgd2l0aCB0
aGUgc3RhbGUgZW50cmllcw0KPiBpbiBibV9saXN0Pw0KDQpIaWRkZW4gaXMgYSB0ZW1wcm9yeSBz
dGF0ZSwgc28sIHdlIHNob3VsZCBub3QgZ28gdG8gY2xvc2UoKSBpbiB0aGlzIHN0YXRlLg0KSXQn
cyBhIHN0YXRlIGluc2lkZSBhIHRyYW5zYWN0aW9uLg0KDQpTdGFsZSBlbnRyaWVzIGluIGxpc3Qg
d2lsbCBiZSBtYXJrZWQgSU5fVVNFIGFueXdheSwgc28gdGhlcmUgaXMgbm8gZGFtYWdlIGFueXdh
eS4NCg0KPiANCj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkg
PHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+IC0tLQ0KPj4gICBpbmNsdWRlL2Jsb2NrL2Rp
cnR5LWJpdG1hcC5oIHwgIDIgKysNCj4+ICAgYmxvY2svZGlydHktYml0bWFwLmMgICAgICAgICB8
IDI2ICsrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMjgg
aW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2Jsb2NrL2RpcnR5LWJp
dG1hcC5oIGIvaW5jbHVkZS9ibG9jay9kaXJ0eS1iaXRtYXAuaA0KPj4gaW5kZXggODA0NGFjZTYz
ZS4uNTQyZTQzNzEyMyAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvYmxvY2svZGlydHktYml0bWFw
LmgNCj4+ICsrKyBiL2luY2x1ZGUvYmxvY2svZGlydHktYml0bWFwLmgNCj4+IEBAIC0xMTYsNSAr
MTE2LDcgQEAgYm9vbCBiZHJ2X2RpcnR5X2JpdG1hcF9uZXh0X2RpcnR5X2FyZWEoQmRydkRpcnR5
Qml0bWFwICpiaXRtYXAsDQo+PiAgIEJkcnZEaXJ0eUJpdG1hcCAqYmRydl9yZWNsYWltX2RpcnR5
X2JpdG1hcF9sb2NrZWQoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQmRydkRpcnR5Qml0bWFwICpiaXRt
YXAsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgRXJyb3IgKiplcnJwKTsNCj4+ICt2b2lkIGJkcnZfZGlydHlfYml0bWFwX2hpZGUoQmRydkRp
cnR5Qml0bWFwICpiaXRtYXApOw0KPj4gK3ZvaWQgYmRydl9kaXJ0eV9iaXRtYXBfdW5oaWRlKEJk
cnZEaXJ0eUJpdG1hcCAqYml0bWFwKTsNCj4+ICAgDQo+PiAgICNlbmRpZg0KPj4gZGlmZiAtLWdp
dCBhL2Jsb2NrL2RpcnR5LWJpdG1hcC5jIGIvYmxvY2svZGlydHktYml0bWFwLmMNCj4+IGluZGV4
IDQ5NjQ2YTMwZTYuLjU5Mjk2NDYzNWUgMTAwNjQ0DQo+PiAtLS0gYS9ibG9jay9kaXJ0eS1iaXRt
YXAuYw0KPj4gKysrIGIvYmxvY2svZGlydHktYml0bWFwLmMNCj4+IEBAIC0zNSw2ICszNSwxMCBA
QCBzdHJ1Y3QgQmRydkRpcnR5Qml0bWFwIHsNCj4+ICAgICAgIGJvb2wgYnVzeTsgICAgICAgICAg
ICAgICAgICAvKiBCaXRtYXAgaXMgYnVzeSwgaXQgY2FuJ3QgYmUgdXNlZCB2aWEgUU1QICovDQo+
PiAgICAgICBCZHJ2RGlydHlCaXRtYXAgKnN1Y2Nlc3NvcjsgLyogQW5vbnltb3VzIGNoaWxkLCBp
ZiBhbnkuICovDQo+PiAgICAgICBjaGFyICpuYW1lOyAgICAgICAgICAgICAgICAgLyogT3B0aW9u
YWwgbm9uLWVtcHR5IHVuaXF1ZSBJRCAqLw0KPj4gKyAgICBjaGFyICpoaWRkZW5fbmFtZTsgICAg
ICAgICAgLyogQmFja3VwIG9mIEBuYW1lIGZvciByZW1vdmFsIHRyYW5zYWN0aW9uDQo+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhY3Rpb24uIFVzZWQgZm9yIGhpZGUvdW5o
aWRlIEFQSS4gKi8NCj4+ICsgICAgYm9vbCBoaWRkZW5fcGVyc2lzdGVudDsgICAgIC8qIEJhY2t1
cCBvZiBAcGVyc2lzdGVudCBmb3IgcmVtb3ZhbCB0cmFuc2FjdGlvbg0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgYWN0aW9uLiAqLw0KPj4gICAgICAgaW50NjRfdCBzaXpl
OyAgICAgICAgICAgICAgIC8qIFNpemUgb2YgdGhlIGJpdG1hcCwgaW4gYnl0ZXMgKi8NCj4+ICAg
ICAgIGJvb2wgZGlzYWJsZWQ7ICAgICAgICAgICAgICAvKiBCaXRtYXAgaXMgZGlzYWJsZWQuIEl0
IGlnbm9yZXMgYWxsIHdyaXRlcyB0bw0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHRoZSBkZXZpY2UgKi8NCj4+IEBAIC04NDksMyArODUzLDI1IEBAIG91dDoNCj4+ICAg
ICAgICAgICBxZW11X211dGV4X3VubG9jayhzcmMtPm11dGV4KTsNCj4+ICAgICAgIH0NCj4+ICAg
fQ0KPj4gKw0KPj4gK3ZvaWQgYmRydl9kaXJ0eV9iaXRtYXBfaGlkZShCZHJ2RGlydHlCaXRtYXAg
KmJpdG1hcCkNCj4+ICt7DQo+PiArICAgIHFlbXVfbXV0ZXhfbG9jayhiaXRtYXAtPm11dGV4KTsN
Cj4+ICsgICAgYXNzZXJ0KCFiaXRtYXAtPmhpZGRlbl9uYW1lKTsNCj4+ICsgICAgYml0bWFwLT5o
aWRkZW5fbmFtZSA9IGJpdG1hcC0+bmFtZTsNCj4+ICsgICAgYml0bWFwLT5oaWRkZW5fcGVyc2lz
dGVudCA9IGJpdG1hcC0+cGVyc2lzdGVudDsNCj4+ICsgICAgYml0bWFwLT5uYW1lID0gTlVMTDsN
Cj4+ICsgICAgYml0bWFwLT5wZXJzaXN0ZW50ID0gZmFsc2U7DQo+PiArICAgIHFlbXVfbXV0ZXhf
dW5sb2NrKGJpdG1hcC0+bXV0ZXgpOw0KPj4gK30NCj4+ICsNCj4+ICt2b2lkIGJkcnZfZGlydHlf
Yml0bWFwX3VuaGlkZShCZHJ2RGlydHlCaXRtYXAgKmJpdG1hcCkNCj4+ICt7DQo+PiArICAgIHFl
bXVfbXV0ZXhfbG9jayhiaXRtYXAtPm11dGV4KTsNCj4+ICsgICAgYXNzZXJ0KCFiaXRtYXAtPm5h
bWUpOw0KPj4gKyAgICBiaXRtYXAtPm5hbWUgPSBiaXRtYXAtPmhpZGRlbl9uYW1lOw0KPj4gKyAg
ICBiaXRtYXAtPnBlcnNpc3RlbnQgPSBiaXRtYXAtPmhpZGRlbl9wZXJzaXN0ZW50Ow0KPj4gKyAg
ICBiaXRtYXAtPmhpZGRlbl9uYW1lID0gTlVMTDsNCj4+ICsgICAgYml0bWFwLT5oaWRkZW5fcGVy
c2lzdGVudCA9IGZhbHNlOw0KPj4gKyAgICBxZW11X211dGV4X3VubG9jayhiaXRtYXAtPm11dGV4
KTsNCj4+ICt9DQo+Pg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

