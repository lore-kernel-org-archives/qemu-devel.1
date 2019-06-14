Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620FEC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 15:53:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C5452168B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 15:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QiTSBuiQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C5452168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52912 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hboWF-0004Ry-8R
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 11:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52921)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbo2i-0000tm-7U
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:23:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbo2f-0003u5-47
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:23:04 -0400
Received: from mail-eopbgr130127.outbound.protection.outlook.com
 ([40.107.13.127]:40005 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbo2e-0003sy-QX; Fri, 14 Jun 2019 11:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KrWaNb8PxEm6x+12KvNMerJncwznE+zsgekyoZuso0=;
 b=QiTSBuiQByi3qEruyWQ6v2Rmjmu4qW6vZyU73/6wBzU5/jXrXm304zZb2lLW59mJXWYAMHQS+c2FGn5Hnx3/S3ZSOqUgAAzgP+Qjqx+HMxkripqFRu14g/0nDCuaeh6Ob3yVx3qcTHqRiP0/6lKAhtzDZYjI8FhBcwfQobdTGyc=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB4034.eurprd08.prod.outlook.com (20.178.119.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Fri, 14 Jun 2019 15:22:57 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Fri, 14 Jun 2019
 15:22:57 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 20/42] block/snapshot: Fall back to storage child
Thread-Index: AQHVIWu4l6UN/Up3D0WYM48oNvM85KabRzyA
Date: Fri, 14 Jun 2019 15:22:57 +0000
Message-ID: <ceef507e-16d0-0edf-0e2d-64c5b4d613ef@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-21-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-21-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P191CA0021.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::31)
 To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190614182255056
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 954de2fd-5298-49cb-72da-08d6f0dc2daa
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB4034; 
x-ms-traffictypediagnostic: AM0PR08MB4034:
x-microsoft-antispam-prvs: <AM0PR08MB4034830EBDB07929A6E54BFFC1EE0@AM0PR08MB4034.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(346002)(396003)(39850400004)(136003)(189003)(199004)(2501003)(73956011)(66556008)(8936002)(31686004)(64756008)(31696002)(8676002)(86362001)(68736007)(66446008)(36756003)(186003)(14454004)(4326008)(305945005)(478600001)(7736002)(5660300002)(99286004)(71200400001)(71190400001)(66476007)(66066001)(11346002)(446003)(66946007)(2616005)(229853002)(486006)(476003)(81166006)(81156014)(6512007)(26005)(102836004)(386003)(6246003)(14444005)(6506007)(6486002)(2906002)(316002)(54906003)(256004)(110136005)(76176011)(25786009)(52116002)(6116002)(3846002)(6436002)(53936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4034;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zjz/Qh/tIIMaoPdKUJ9/e5/zwt1GPCV27x2pheBlHpdcd1wd9A/skHZ70JBY6YaQWCiNSr6F5oleunAjP73Ae1ThCi7hmffjbYHLeIe1lc5vPm8qtvxj/urUdpzXt95A8BIlPVmiZdU8X51D/N/dK8DPJsuun6/ndLqq1+qbPGT/01eJ/zdSv5NlXBbH3LU4gRUAHrPpIoiqEFc0ipOVEfE94BJA8UPRdO1EnmI3qyrtXrDo28hhb6nhGcqBNpmIIUJU8sABpHUCegA/4qiW64g/nDEwtURCnMaXnlyhWEL4mbqEuFk65WHFoDZHPA58Iz30wcSlEaN81+S/erXZ4a/QmTafl0MM8mjBNNBfE9KRPbtJGiB8yl4NWI+URG06lUA3lUzYjU7WA+udchMPhxqF30+uUG1z4HVejxhdDo0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8878C2170910754987957EBAD52B3AFD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 954de2fd-5298-49cb-72da-08d6f0dc2daa
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 15:22:57.1579 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4034
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.127
Subject: Re: [Qemu-devel] [PATCH v5 20/42] block/snapshot: Fall back to
 storage child
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

MTMuMDYuMjAxOSAxOjA5LCBNYXggUmVpdHogd3JvdGU6DQo+IElmIHRoZSB0b3Agbm9kZSdzIGRy
aXZlciBkb2VzIG5vdCBwcm92aWRlIHNuYXBzaG90IGZ1bmN0aW9uYWxpdHkgYW5kIHdlDQo+IHdh
bnQgdG8gZ28gZG93biB0aGUgY2hhaW4sIHdlIHNob3VsZCBnbyB0b3dhcmRzIHRoZSBjaGlsZCB3
aGljaCBzdG9yZXMNCj4gdGhlIGRhdGEsIGkuZS4gdGhlIHN0b3JhZ2UgY2hpbGQuDQo+IA0KPiBi
ZHJ2X3NuYXBzaG90X2dvdG8oKSBiZWNvbWVzIGEgYml0IHdlaXJkIGJlY2F1c2Ugd2UgbWF5IGhh
dmUgdG8gcmVkaXJlY3QNCj4gdGhlIGFjdHVhbCBjaGlsZCBwb2ludGVyLCBzbyBpdCBvbmx5IHdv
cmtzIGlmIHRoZSBzdG9yYWdlIGNoaWxkIGlzDQo+IGJzLT5maWxlIG9yIGJzLT5iYWNraW5nIChh
bmQgdGhlbiB3ZSBoYXZlIHRvIGZpbmQgb3V0IHdoaWNoIGl0IGlzKS4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IE1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgIGJsb2NrL3Nu
YXBzaG90LmMgfCA3NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0t
LS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNTMgaW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYmxvY2svc25hcHNob3QuYyBiL2Jsb2NrL3NuYXBzaG90
LmMNCj4gaW5kZXggZjJmNDhmOTI2YS4uNThjZDY2N2YzYSAxMDA2NDQNCj4gLS0tIGEvYmxvY2sv
c25hcHNob3QuYw0KPiArKysgYi9ibG9jay9zbmFwc2hvdC5jDQo+IEBAIC0xNTQsOCArMTU0LDkg
QEAgaW50IGJkcnZfY2FuX3NuYXBzaG90KEJsb2NrRHJpdmVyU3RhdGUgKmJzKQ0KPiAgICAgICB9
DQo+ICAgDQo+ICAgICAgIGlmICghZHJ2LT5iZHJ2X3NuYXBzaG90X2NyZWF0ZSkgew0KPiAtICAg
ICAgICBpZiAoYnMtPmZpbGUgIT0gTlVMTCkgew0KPiAtICAgICAgICAgICAgcmV0dXJuIGJkcnZf
Y2FuX3NuYXBzaG90KGJzLT5maWxlLT5icyk7DQo+ICsgICAgICAgIEJsb2NrRHJpdmVyU3RhdGUg
KnN0b3JhZ2VfYnMgPSBiZHJ2X3N0b3JhZ2VfYnMoYnMpOw0KPiArICAgICAgICBpZiAoc3RvcmFn
ZV9icykgew0KPiArICAgICAgICAgICAgcmV0dXJuIGJkcnZfY2FuX3NuYXBzaG90KHN0b3JhZ2Vf
YnMpOw0KPiAgICAgICAgICAgfQ0KPiAgICAgICAgICAgcmV0dXJuIDA7DQo+ICAgICAgIH0NCg0K
SG1tIGlzIGl0IGNvcnJlY3QgYXQgYWxsIGRvaW5nIGEgc25hcHNob3QsIHdoZW4gdG9wIGZvcm1h
dCBub2RlIGRvZXNuJ3Qgc3VwcG9ydCBpdCwNCm1ldGFkYXRhIGNoaWxkIGRvZXNuJ3Qgc3VwcG9y
dCBpdCBhbmQgc3RvcmFnZSBjaGlsZCBzdXBwb3J0cz8gRG9pbmcgc25hcHNob3RzIG9mDQpzdG9y
YWdlIGNoaWxkIHNlZW1zIHVzZWxlc3MsIGFzIGRhdGEgZmlsZSBtdXN0IGJlIGluIHN5bmMgd2l0
aCBtZXRhZGF0YS4NCg0KDQo+IEBAIC0xNjcsMTQgKzE2OCwxNSBAQCBpbnQgYmRydl9zbmFwc2hv
dF9jcmVhdGUoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFFFTVVTbmFwc2hvdEluZm8gKnNuX2luZm8pDQo+ICAgew0KPiAgICAgICBCbG9ja0RyaXZl
ciAqZHJ2ID0gYnMtPmRydjsNCj4gKyAgICBCbG9ja0RyaXZlclN0YXRlICpzdG9yYWdlX2JzID0g
YmRydl9zdG9yYWdlX2JzKGJzKTsNCj4gICAgICAgaWYgKCFkcnYpIHsNCj4gICAgICAgICAgIHJl
dHVybiAtRU5PTUVESVVNOw0KPiAgICAgICB9DQo+ICAgICAgIGlmIChkcnYtPmJkcnZfc25hcHNo
b3RfY3JlYXRlKSB7DQo+ICAgICAgICAgICByZXR1cm4gZHJ2LT5iZHJ2X3NuYXBzaG90X2NyZWF0
ZShicywgc25faW5mbyk7DQo+ICAgICAgIH0NCj4gLSAgICBpZiAoYnMtPmZpbGUpIHsNCj4gLSAg
ICAgICAgcmV0dXJuIGJkcnZfc25hcHNob3RfY3JlYXRlKGJzLT5maWxlLT5icywgc25faW5mbyk7
DQo+ICsgICAgaWYgKHN0b3JhZ2VfYnMpIHsNCj4gKyAgICAgICAgcmV0dXJuIGJkcnZfc25hcHNo
b3RfY3JlYXRlKHN0b3JhZ2VfYnMsIHNuX2luZm8pOw0KPiAgICAgICB9DQo+ICAgICAgIHJldHVy
biAtRU5PVFNVUDsNCj4gICB9DQo+IEBAIC0xODQsNiArMTg2LDcgQEAgaW50IGJkcnZfc25hcHNo
b3RfZ290byhCbG9ja0RyaXZlclN0YXRlICpicywNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
IEVycm9yICoqZXJycCkNCj4gICB7DQo+ICAgICAgIEJsb2NrRHJpdmVyICpkcnYgPSBicy0+ZHJ2
Ow0KPiArICAgIEJsb2NrRHJpdmVyU3RhdGUgKnN0b3JhZ2VfYnM7DQo+ICAgICAgIGludCByZXQs
IG9wZW5fcmV0Ow0KPiAgIA0KPiAgICAgICBpZiAoIWRydikgew0KPiBAQCAtMjA0LDM5ICsyMDcs
NjYgQEAgaW50IGJkcnZfc25hcHNob3RfZ290byhCbG9ja0RyaXZlclN0YXRlICpicywNCj4gICAg
ICAgICAgIHJldHVybiByZXQ7DQo+ICAgICAgIH0NCj4gICANCj4gLSAgICBpZiAoYnMtPmZpbGUp
IHsNCj4gLSAgICAgICAgQmxvY2tEcml2ZXJTdGF0ZSAqZmlsZTsNCj4gLSAgICAgICAgUURpY3Qg
Km9wdGlvbnMgPSBxZGljdF9jbG9uZV9zaGFsbG93KGJzLT5vcHRpb25zKTsNCj4gKyAgICBzdG9y
YWdlX2JzID0gYmRydl9zdG9yYWdlX2JzKGJzKTsNCj4gKyAgICBpZiAoc3RvcmFnZV9icykgew0K
PiArICAgICAgICBRRGljdCAqb3B0aW9uczsNCj4gICAgICAgICAgIFFEaWN0ICpmaWxlX29wdGlv
bnM7DQo+ICAgICAgICAgICBFcnJvciAqbG9jYWxfZXJyID0gTlVMTDsNCj4gKyAgICAgICAgYm9v
bCBpc19iYWNraW5nX2NoaWxkOw0KPiArICAgICAgICBCZHJ2Q2hpbGQgKipjaGlsZF9wb2ludGVy
Ow0KPiArDQo+ICsgICAgICAgIC8qDQo+ICsgICAgICAgICAqIEZpbHRlcnMgbWF5IHJlZmVyZW5j
ZSB0aGUgc3RvcmFnZSBjaGlsZCB0aHJvdWdoDQo+ICsgICAgICAgICAqIGJzLT5iYWNraW5nLiAg
V2UgbmVlZCB0byBrbm93IHdoZXRoZXIgd2UgYXJlIGRlYWxpbmcgd2l0aA0KPiArICAgICAgICAg
KiBicy0+YmFja2luZyBvciBicy0+ZmlsZSwgc28gd2UgY2hlY2sgaXQgaGVyZS4NCj4gKyAgICAg
ICAgICovDQo+ICsgICAgICAgIGlmIChzdG9yYWdlX2JzID09IGJzLT5maWxlLT5icykgew0KPiAr
ICAgICAgICAgICAgaXNfYmFja2luZ19jaGlsZCA9IGZhbHNlOw0KPiArICAgICAgICAgICAgY2hp
bGRfcG9pbnRlciA9ICZicy0+ZmlsZTsNCj4gKyAgICAgICAgfSBlbHNlIGlmIChzdG9yYWdlX2Jz
ID09IGJzLT5iYWNraW5nLT5icykgew0KPiArICAgICAgICAgICAgaXNfYmFja2luZ19jaGlsZCA9
IHRydWU7DQo+ICsgICAgICAgICAgICBjaGlsZF9wb2ludGVyID0gJmJzLT5iYWNraW5nOw0KPiAr
ICAgICAgICB9IGVsc2Ugew0KPiArICAgICAgICAgICAgLyoNCj4gKyAgICAgICAgICAgICAqIFRo
ZSBzdG9yYWdlIGNoaWxkIGlzIG5vdCByZWZlcmVuY2VkIGJ5IGEgZmllbGQgaW4gdGhlDQo+ICsg
ICAgICAgICAgICAgKiBCRFMgb2JqZWN0LiAgV2UgY2Fubm90IGdvIG9uIHRoZW4uDQo+ICsgICAg
ICAgICAgICAgKi8NCj4gKyAgICAgICAgICAgIGVycm9yX3NldGcoZXJycCwgIkJsb2NrIGRyaXZl
ciBkb2VzIG5vdCBzdXBwb3J0IHNuYXBzaG90cyIpOw0KPiArICAgICAgICAgICAgcmV0dXJuIC1F
Tk9UU1VQOw0KPiArICAgICAgICB9DQo+ICsNCj4gKyAgICAgICAgb3B0aW9ucyA9IHFkaWN0X2Ns
b25lX3NoYWxsb3coYnMtPm9wdGlvbnMpOw0KPiAgIA0KPiAtICAgICAgICBmaWxlID0gYnMtPmZp
bGUtPmJzOw0KPiAgICAgICAgICAgLyogUHJldmVudCBpdCBmcm9tIGdldHRpbmcgZGVsZXRlZCB3
aGVuIGRldGFjaGVkIGZyb20gYnMgKi8NCj4gLSAgICAgICAgYmRydl9yZWYoZmlsZSk7DQo+ICsg
ICAgICAgIGJkcnZfcmVmKHN0b3JhZ2VfYnMpOw0KPiAgIA0KPiAtICAgICAgICBxZGljdF9leHRy
YWN0X3N1YnFkaWN0KG9wdGlvbnMsICZmaWxlX29wdGlvbnMsICJmaWxlLiIpOw0KPiArICAgICAg
ICBxZGljdF9leHRyYWN0X3N1YnFkaWN0KG9wdGlvbnMsICZmaWxlX29wdGlvbnMsDQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaXNfYmFja2luZ19jaGlsZCA/ICJiYWNraW5nLiIg
OiAiZmlsZS4iKTsNCj4gICAgICAgICAgIHFvYmplY3RfdW5yZWYoZmlsZV9vcHRpb25zKTsNCj4g
LSAgICAgICAgcWRpY3RfcHV0X3N0cihvcHRpb25zLCAiZmlsZSIsIGJkcnZfZ2V0X25vZGVfbmFt
ZShmaWxlKSk7DQo+ICsgICAgICAgIHFkaWN0X3B1dF9zdHIob3B0aW9ucywgaXNfYmFja2luZ19j
aGlsZCA/ICJiYWNraW5nIiA6ICJmaWxlIiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICBiZHJ2
X2dldF9ub2RlX25hbWUoc3RvcmFnZV9icykpOw0KPiAgIA0KPiAgICAgICAgICAgaWYgKGRydi0+
YmRydl9jbG9zZSkgew0KPiAgICAgICAgICAgICAgIGRydi0+YmRydl9jbG9zZShicyk7DQo+ICAg
ICAgICAgICB9DQo+IC0gICAgICAgIGJkcnZfdW5yZWZfY2hpbGQoYnMsIGJzLT5maWxlKTsNCj4g
LSAgICAgICAgYnMtPmZpbGUgPSBOVUxMOw0KPiAgIA0KPiAtICAgICAgICByZXQgPSBiZHJ2X3Nu
YXBzaG90X2dvdG8oZmlsZSwgc25hcHNob3RfaWQsIGVycnApOw0KPiArICAgICAgICBhc3NlcnQo
c3RvcmFnZV9icyA9PSAoKmNoaWxkX3BvaW50ZXIpLT5icyk7DQo+ICsgICAgICAgIGJkcnZfdW5y
ZWZfY2hpbGQoYnMsICpjaGlsZF9wb2ludGVyKTsNCj4gKyAgICAgICAgKmNoaWxkX3BvaW50ZXIg
PSBOVUxMOw0KPiArDQo+ICsgICAgICAgIHJldCA9IGJkcnZfc25hcHNob3RfZ290byhzdG9yYWdl
X2JzLCBzbmFwc2hvdF9pZCwgZXJycCk7DQo+ICAgICAgICAgICBvcGVuX3JldCA9IGRydi0+YmRy
dl9vcGVuKGJzLCBvcHRpb25zLCBicy0+b3Blbl9mbGFncywgJmxvY2FsX2Vycik7DQo+ICAgICAg
ICAgICBxb2JqZWN0X3VucmVmKG9wdGlvbnMpOw0KPiAgICAgICAgICAgaWYgKG9wZW5fcmV0IDwg
MCkgew0KPiAtICAgICAgICAgICAgYmRydl91bnJlZihmaWxlKTsNCj4gKyAgICAgICAgICAgIGJk
cnZfdW5yZWYoc3RvcmFnZV9icyk7DQo+ICAgICAgICAgICAgICAgYnMtPmRydiA9IE5VTEw7DQo+
ICAgICAgICAgICAgICAgLyogQSBiZHJ2X3NuYXBzaG90X2dvdG8oKSBlcnJvciB0YWtlcyBwcmVj
ZWRlbmNlICovDQo+ICAgICAgICAgICAgICAgZXJyb3JfcHJvcGFnYXRlKGVycnAsIGxvY2FsX2Vy
cik7DQo+ICAgICAgICAgICAgICAgcmV0dXJuIHJldCA8IDAgPyByZXQgOiBvcGVuX3JldDsNCj4g
ICAgICAgICAgIH0NCj4gICANCj4gLSAgICAgICAgYXNzZXJ0KGJzLT5maWxlLT5icyA9PSBmaWxl
KTsNCj4gLSAgICAgICAgYmRydl91bnJlZihmaWxlKTsNCj4gKyAgICAgICAgYXNzZXJ0KHN0b3Jh
Z2VfYnMgPT0gKCpjaGlsZF9wb2ludGVyKS0+YnMpOw0KPiArICAgICAgICBiZHJ2X3VucmVmKHN0
b3JhZ2VfYnMpOw0KPiAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gICAgICAgfQ0KPiAgIA0KPiBA
QCAtMjcyLDYgKzMwMiw3IEBAIGludCBiZHJ2X3NuYXBzaG90X2RlbGV0ZShCbG9ja0RyaXZlclN0
YXRlICpicywNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0KPiAg
IHsNCj4gICAgICAgQmxvY2tEcml2ZXIgKmRydiA9IGJzLT5kcnY7DQo+ICsgICAgQmxvY2tEcml2
ZXJTdGF0ZSAqc3RvcmFnZV9icyA9IGJkcnZfc3RvcmFnZV9icyhicyk7DQo+ICAgICAgIGludCBy
ZXQ7DQo+ICAgDQo+ICAgICAgIGlmICghZHJ2KSB7DQo+IEBAIC0yODgsOCArMzE5LDggQEAgaW50
IGJkcnZfc25hcHNob3RfZGVsZXRlKEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0KPiAgIA0KPiAgICAg
ICBpZiAoZHJ2LT5iZHJ2X3NuYXBzaG90X2RlbGV0ZSkgew0KPiAgICAgICAgICAgcmV0ID0gZHJ2
LT5iZHJ2X3NuYXBzaG90X2RlbGV0ZShicywgc25hcHNob3RfaWQsIG5hbWUsIGVycnApOw0KPiAt
ICAgIH0gZWxzZSBpZiAoYnMtPmZpbGUpIHsNCj4gLSAgICAgICAgcmV0ID0gYmRydl9zbmFwc2hv
dF9kZWxldGUoYnMtPmZpbGUtPmJzLCBzbmFwc2hvdF9pZCwgbmFtZSwgZXJycCk7DQo+ICsgICAg
fSBlbHNlIGlmIChzdG9yYWdlX2JzKSB7DQo+ICsgICAgICAgIHJldCA9IGJkcnZfc25hcHNob3Rf
ZGVsZXRlKHN0b3JhZ2VfYnMsIHNuYXBzaG90X2lkLCBuYW1lLCBlcnJwKTsNCj4gICAgICAgfSBl
bHNlIHsNCj4gICAgICAgICAgIGVycm9yX3NldGcoZXJycCwgIkJsb2NrIGZvcm1hdCAnJXMnIHVz
ZWQgYnkgZGV2aWNlICclcycgIg0KPiAgICAgICAgICAgICAgICAgICAgICAiZG9lcyBub3Qgc3Vw
cG9ydCBpbnRlcm5hbCBzbmFwc2hvdCBkZWxldGlvbiIsDQo+IEBAIC0zMDUsMTQgKzMzNiwxNSBA
QCBpbnQgYmRydl9zbmFwc2hvdF9saXN0KEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgUUVNVVNuYXBzaG90SW5mbyAqKnBzbl9pbmZvKQ0KPiAgIHsNCj4g
ICAgICAgQmxvY2tEcml2ZXIgKmRydiA9IGJzLT5kcnY7DQo+ICsgICAgQmxvY2tEcml2ZXJTdGF0
ZSAqc3RvcmFnZV9icyA9IGJkcnZfc3RvcmFnZV9icyhicyk7DQo+ICAgICAgIGlmICghZHJ2KSB7
DQo+ICAgICAgICAgICByZXR1cm4gLUVOT01FRElVTTsNCj4gICAgICAgfQ0KPiAgICAgICBpZiAo
ZHJ2LT5iZHJ2X3NuYXBzaG90X2xpc3QpIHsNCj4gICAgICAgICAgIHJldHVybiBkcnYtPmJkcnZf
c25hcHNob3RfbGlzdChicywgcHNuX2luZm8pOw0KPiAgICAgICB9DQo+IC0gICAgaWYgKGJzLT5m
aWxlKSB7DQo+IC0gICAgICAgIHJldHVybiBiZHJ2X3NuYXBzaG90X2xpc3QoYnMtPmZpbGUtPmJz
LCBwc25faW5mbyk7DQo+ICsgICAgaWYgKHN0b3JhZ2VfYnMpIHsNCj4gKyAgICAgICAgcmV0dXJu
IGJkcnZfc25hcHNob3RfbGlzdChzdG9yYWdlX2JzLCBwc25faW5mbyk7DQo+ICAgICAgIH0NCj4g
ICAgICAgcmV0dXJuIC1FTk9UU1VQOw0KPiAgIH0NCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMs
DQpWbGFkaW1pcg0K

