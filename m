Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19681C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 13:27:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8DDF20866
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 13:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Tans2oe0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DDF20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60576 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYsQ6-0003nW-VC
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 09:27:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYsOr-0002vj-6i
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:25:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYsOp-0005Pr-Ak
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:25:49 -0400
Received: from mail-eopbgr140099.outbound.protection.outlook.com
	([40.107.14.99]:61807
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hYsOl-0004IG-8R; Thu, 06 Jun 2019 09:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=mA4rsQuYFHMq/7+ZrUDbGOKUwFk88HvlbWzTrRPfBIk=;
	b=Tans2oe0IhauMD9GJkSh1m2DoCjSx5mPrL+f/9jjpfC8JbgpVRR1UmYuBuHjDJ/h36R0xsNBwUfYtl/UN+ez890thhunNANMmiQSuNUx6VbNJSo/laVA/ts10VEZ6iE6zHNW5aduhRNF0aRUqxttmeRJDsafJI6VZKIuRjyA6Bo=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
	AM0PR08MB4498.eurprd08.prod.outlook.com (20.179.33.74) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1965.14; Thu, 6 Jun 2019 13:25:31 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8]) by
	AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8%7]) with mapi id 15.20.1965.011;
	Thu, 6 Jun 2019 13:25:31 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH v2 2/2] blockjob: use blk_new_pinned in block_job_create
Thread-Index: AQHVG8HBVdfqD7RC9UWdIT2PxMi18aaNTVYAgAEZzACAAChdAIAACmGAgAAFOoA=
Date: Thu, 6 Jun 2019 13:25:31 +0000
Message-ID: <f659c0aa-5ae8-f43d-aa48-6d9f5700b919@virtuozzo.com>
References: <20190605123229.92848-1-vsementsov@virtuozzo.com>
	<20190605123229.92848-3-vsementsov@virtuozzo.com>
	<20190605171137.GC5491@linux.fritz.box>
	<1b1a0ec6-88c7-d7a5-3d95-bde310693580@virtuozzo.com>
	<20190606100510.GA9241@localhost.localdomain>
	<e7711782-004e-e27d-7ecf-afc04bd1a697@virtuozzo.com>
	<20190606130647.GB9241@localhost.localdomain>
In-Reply-To: <20190606130647.GB9241@localhost.localdomain>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0062.eurprd09.prod.outlook.com
	(2603:10a6:7:3c::30) To AM0PR08MB2961.eurprd08.prod.outlook.com
	(2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190606162529579
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9649d5c-8dec-4393-10aa-08d6ea8272d9
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:AM0PR08MB4498; 
x-ms-traffictypediagnostic: AM0PR08MB4498:
x-microsoft-antispam-prvs: <AM0PR08MB449896E6056590B5DC4FA013C1170@AM0PR08MB4498.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(979002)(396003)(39850400004)(366004)(136003)(346002)(376002)(199004)(189003)(36756003)(68736007)(14454004)(6436002)(31696002)(64756008)(66556008)(6512007)(5660300002)(386003)(66446008)(6506007)(66946007)(102836004)(66476007)(73956011)(186003)(26005)(86362001)(52116002)(99286004)(76176011)(6246003)(5024004)(256004)(6116002)(31686004)(71200400001)(71190400001)(305945005)(6916009)(478600001)(25786009)(2906002)(8936002)(446003)(316002)(476003)(8676002)(2616005)(486006)(53936002)(66066001)(229853002)(3846002)(54906003)(7736002)(4326008)(81156014)(81166006)(11346002)(6486002)(969003)(989001)(999001)(1009001)(1019001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4498;
	H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LIQtinZoy2IhciMjQ69+6smBH+UhtCjpSfuByN1Z4Lv5+62uqVaUEjCH2tNRodY3bMzHMkgMGad9fMNHURsfxJ27aqBR+Q70XCAKtDI8zUgbHUZ9WOa/TADEbkRMOaBh+NnOczCT78pC6OESzBzsWt00tFXFRJONbabFYWfTtjILaGzOo3vQ5hsPUcXF1iFy5Ri78syRqPBncnmtHwVdj58dIUbgAJ2r0OwNz0oKLG0o59q5V9E6MqC1SPJTqijG2JwEluj+HEQNSVD39i+EeVUEe9tzFpN4Gne8aP1K0bLpiht0W8GlXOjpjGu+pw7SqDON3O8HM4+ULXGZ5BZLm/eBau2M8vQu2rDGtCC5V2Y8CSvNOoGHDRL9SI4KLVoJQcCsx1EZo4sx1oX7qQl5oe4K8BzBVKy7w0df0/yxHHE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99D1DCAE1BA1CF4DBA4392EE751B71EF@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9649d5c-8dec-4393-10aa-08d6ea8272d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 13:25:31.5598 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4498
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.99
Subject: Re: [Qemu-devel] [PATCH v2 2/2] blockjob: use blk_new_pinned in
 block_job_create
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDYuMDYuMjAxOSAxNjowNiwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMDYuMDYuMjAxOSB1bSAx
NDoyOSBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IDA2
LjA2LjIwMTkgMTM6MDUsIEtldmluIFdvbGYgd3JvdGU6DQo+Pj4gQW0gMDUuMDYuMjAxOSB1bSAx
OToxNiBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+Pj4g
MDUuMDYuMjAxOSAyMDoxMSwgS2V2aW4gV29sZiB3cm90ZToNCj4+Pj4+IEFtIDA1LjA2LjIwMTkg
dW0gMTQ6MzIgaGF0IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgZ2VzY2hyaWViZW46DQo+
Pj4+Pj4gY2hpbGRfcm9sZSBqb2IgYWxyZWFkeSBoYXMgLnN0YXlfYXRfbm9kZT10cnVlLCBzbyBv
biBiZHJ2X3JlcGxhY2Vfbm9kZQ0KPj4+Pj4+IG9wZXJhdGlvbiB0aGVzZSBjaGlsZCBhcmUgdW5j
aGFuZ2VkLiBNYWtlIGJsb2NrIGpvYiBibGsgYmVoYXZlIGluIHNhbWUNCj4+Pj4+PiBtYW5uZXIs
IHRvIGF2b2lkIGluY29uc2lzdGVudCBpbnRlcm1lZGlhdGUgZ3JhcGggc3RhdGVzIGFuZCB3b3Jr
YXJvdW5kcw0KPj4+Pj4+IGxpa2UgaW4gbWlycm9yLg0KPj4+Pj4+DQo+Pj4+Pj4gU2lnbmVkLW9m
Zi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8u
Y29tPg0KPj4+Pj4NCj4+Pj4+IFRoaXMgZmVlbHMgZGFuZ2Vyb3VzLiBJdCBkb2VzIHdoYXQgeW91
IHdhbnQgaXQgdG8gZG8gaWYgdGhlIG9ubHkgZ3JhcGgNCj4+Pj4+IGNoYW5nZSBiZWxvdyB0aGUg
QmxvY2tCYWNrZW5kIGlzIHRoZSBvbmUgaW4gbWlycm9yX2V4aXRfY29tbW9uLiBCdXQgdGhlDQo+
Pj4+PiB1c2VyIGNvdWxkIGFsc28gdGFrZSBhIHNuYXBzaG90LCBvciBpbiB0aGUgZnV0dXJlIGhv
cGVmdWxseSBpbnNlcnQgYQ0KPj4+Pj4gZmlsdGVyIG5vZGUsIGFuZCB5b3Ugd291bGQgdGhlbiB3
YW50IHRoZSBCbG9ja0JhY2tlbmQgdG8gbW92ZS4NCj4+Pj4+DQo+Pj4+PiBUbyBiZSBob25lc3Qs
IGV2ZW4gQmRydkNoaWxkUm9sZS5zdGF5X2F0X25vZGUgaXMgYSBiaXQgb2YgYSBoYWNrLiBCdXQg
YXQNCj4+Pj4+IGxlYXN0IGl0J3Mgb25seSB1c2VkIGZvciBwZXJtaXNzaW9ucyBhbmQgbm90IGZv
ciB0aGUgYWN0dWFsIGRhdGEgZmxvdy4NCj4+Pj4NCj4+Pj4gSG1tLiBUaGFuLCBtYXkgYmUganVz
dCBhZGQgYSBwYXJhbWV0ZXIgdG8gYmRydl9yZXBsYWNlX25vZGUsIHdoaWNoIHBhcmVudHMNCj4+
Pj4gdG8gaWdub3JlPyBXb3VsZCBpdCB3b3JrPw0KPj4+DQo+Pj4gSSB3b3VsZCBoYXZlIHRvIHRo
aW5rIGEgYml0IG1vcmUgYWJvdXQgaXQsIGJ1dCBpdCBkb2VzIHNvdW5kIHNhZmVyLg0KPj4+DQo+
Pj4gT3Igd2UgdGFrZSBhIHN0ZXAgYmFjayBhbmQgYXNrIHdoeSBpdCdzIGV2ZW4gYSBwcm9ibGVt
IGZvciB0aGUgbWlycm9yDQo+Pj4gYmxvY2sgam9iIGlmIHRoZSBCbG9ja0JhY2tlbmQgaXMgbW92
ZWQgdG8gYSBkaWZmZXJlbnQgbm9kZS4gVGhlIG1haW4NCj4+PiByZWFzb24gSSBzZWUgaXMgYmVj
YXVzZSBvZiBicy0+am9iIHRoYXQgaXMgc2V0IGZvciB0aGUgcm9vdCBub2RlIG9mIHRoZQ0KPj4+
IEJsb2NrQmFja2VuZCBhbmQgbmVlZHMgdG8gYmUgdW5zZXQgZm9yIHRoZSBzYW1lIG5vZGUuDQo+
Pj4NCj4+PiBNYXliZSB3ZSBjYW4ganVzdCBmaW5hbGx5IGdldCByaWQgb2YgYnMtPmpvYj8gSXQg
ZG9lc24ndCBoYXZlIG1hbnkgdXNlcnMNCj4+PiBhbnkgbW9yZS4NCj4+Pg0KPj4NCj4+IEhtbSwg
bG9va2VkIGF0IGl0LiBOb3Qgc3VyZSB3aGF0IHNob3VsZCBiZSByZWZhY3RvcmVkIGFyb3VuZCBq
b2IgdG8gZ2V0IHJpZA0KPj4gb2YgIm1haW4gbm9kZSIgY29uY2VwdC4uIFdoaWNoIHNlZW1zIHRv
IGJlIGluIGEgYmFkIHJlbGF0aW9uIHdpdGggc3RhcnRpbmcNCj4+IGpvYiBvbiBpbXBsaWNpdCBm
aWx0ZXJzIGFzIGEgbWFpbiBub2RlLi4NCj4+DQo+PiBCdXQgYWJvdXQganVzdCByZW1vdmluZyBi
cy0+am9iIHBvaW50ZXIsIEkgZG9uJ3Qga25vdyBhdCBsZWFzdCB3aGF0IHRvIGRvIHdpdGgNCj4+
IGJsa19pb3N0YXR1c19yZXNldCBhbmQgYmxvY2tkZXZfbWFya19hdXRvX2RlbC4uDQo+IA0KPiBi
bGtfaW9zdGF0dXNfcmVzZXQoKSBsb29rcyBlYXN5LiBJdCBoYXMgb25seSB0d28gY2FsbGVyczoN
Cj4gDQo+IDEuIGJsa19hdHRhY2hfZGV2KCkuIFRoaXMgZG9lc24ndCBoYXZlIGFueXRoaW5nIHRv
IGRvIHdpdGggam9icyBhbmQNCj4gICAgIGF0dGFjaGluZyBhIG5ldyBndWVzdCBkZXZpY2Ugd29u
J3Qgc29sdmUgYW55IHByb2JsZW0gdGhlIGpvYg0KPiAgICAgZW5jb3VudGVyZWQsIHNvIG5vIHJl
YXNvbiB0byByZXNldCB0aGUgaW9zdGF0dXMgZm9yIHRoZSBqb2IuDQo+IA0KPiAyLiBxbXBfY29u
dCgpLiBUaGlzIHJlc2V0cyB0aGUgaW9zdGF0dXMgZm9yIGV2ZXJ5dGhpbmcuIFdlIGNhbiBqdXN0
DQo+ICAgICBjYWxsIGJsb2NrX2pvYl9pb3N0YXR1c19yZXNldCgpIGZvciBhbGwgYmxvY2sgam9i
cyBpbnN0ZWFkIG9mIGdvaW5nDQo+ICAgICB0aHJvdWdoIEJsb2NrQmFja2VuZC4NCj4gDQo+IGJs
b2NrZGV2X21hcmtfYXV0b19kZWwoKSBtaWdodCBiZSBhIGJpdCB0cmlja2llci4gVGhlIHdob2xl
IGlkZWEgb2YgdGhlDQo+IGZ1bmN0aW9uIGlzOiBXaGVuIGEgZ3Vlc3QgZGV2aWNlIGdldHMgdW5w
bHVnZ2VkLCBhdXRvbWF0aWNhbGx5IHJlbW92ZQ0KPiBpdHMgcm9vdCBibG9jayBub2RlLCB0b28u
IENvbW1pdCAxMmJkZTBlZWQ2YiBtYWRlIGl0IGNhbmNlbCBhIGJsb2NrIGpvYg0KPiBiZWNhdXNl
IHRoYXQgc2hvdWxkIGhhcHBlbiBpbW1lZGlhdGVseSB3aGVuIHRoZSBkZXZpY2UgaXMgYWN0dWFs
bHkNCj4gcmVsZWFzZWQgYnkgdGhlIGd1ZXN0IGFuZCBub3Qgb25seSBhZnRlciB0aGUgam9iIGZp
bmlzaGVzIGFuZCBnaXZlcyB1cA0KPiBpdHMgcmVmZXJlbmNlLiBJIHdvdWxkIGxpa2UgdG8ganVz
dCBjaGFuZ2UgdGhlIGJlaGF2aW91ciwgYnV0IEknbSBhZnJhaWQNCj4gd2UgY2FuJ3QgZG8gdGhp
cyBiZWNhdXNlIG9mIGNvbXBhdGliaWxpdHkuDQo+IA0KPiBIb3dldmVyLCBqdXN0IGNoZWNraW5n
IGJzLT5qb2IgaXMgcmVhbGx5IG9ubHkgb25lIHNwZWNpYWwgY2FzZSBvZg0KPiBhbm90aGVyIHVz
ZXIgb2YgdGhlIG5vZGUgdG8gYmUgZGVsZXRlZC4gTWF5YmUgd2UgY2FuIGV4dGVuZCBpdCBhIGxp
dHRsZQ0KPiBzbyB0aGF0IGFueSBibG9jayBqb2JzIHRoYXQgY29udGFpbiB0aGUgbm9kZSBpbiBq
b2ItPm5vZGVzIGFyZQ0KPiBjYW5jZWxsZWQuDQo+IA0KDQpPSywgdGhhbmtzLiBJJ2xsIHRyeSB0
aGlzIHdheQ0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

