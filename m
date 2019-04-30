Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B6EC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 09:47:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E3F5205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 09:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OxZgyVY9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E3F5205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42320 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLPM7-0001NJ-Jz
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 05:47:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hLPJa-00081c-VS
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:44:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hLPJa-00064T-0C
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:44:42 -0400
Received: from mail-eopbgr90139.outbound.protection.outlook.com
	([40.107.9.139]:48307
	helo=FRA01-MR2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hLPJX-00062I-3e; Tue, 30 Apr 2019 05:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Y2XyQESjUFoqhoBVu2FvyB3Ku8bI4oXmt9EmvtqckTs=;
	b=OxZgyVY9aSRhotJqveRM23NFcWcYMeRWIi6vKfXxgbwcBcXXeD75iRBIqXYuPVzK55f6nANS8j3/chMnFO58TojqIUC1nRDGwIii9Jc6Av+5pg4is2FFMrUo4NtNah4TqpeNMyp552j20P/+5npNq6//IK+n5+9OE2ZxbvkLED8=
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com (52.133.109.209) by
	PR2PR08MB4778.eurprd08.prod.outlook.com (52.133.109.144) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.15; Tue, 30 Apr 2019 09:44:35 +0000
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::88d7:ecf0:1120:f1a1]) by
	PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::88d7:ecf0:1120:f1a1%3]) with mapi id 15.20.1835.018;
	Tue, 30 Apr 2019 09:44:35 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 07/10] qcow2: qcow2_co_preadv: improve locking
Thread-Index: AQHU6WoBm3ZqDVOSG0aQpHzt+uoXFqZTgO4AgAE+lAD//+BLgA==
Date: Tue, 30 Apr 2019 09:44:35 +0000
Message-ID: <35da9a3a-32e2-5db2-1342-ce8d48531709@virtuozzo.com>
References: <20190402153730.54145-1-vsementsov@virtuozzo.com>
	<20190402153730.54145-8-vsementsov@virtuozzo.com>
	<44be7ef0-9a4f-4c44-44eb-81f341ca7ea6@redhat.com>
	<66de1a9a-e9fd-b853-377d-f5acfe51737a@virtuozzo.com>
In-Reply-To: <66de1a9a-e9fd-b853-377d-f5acfe51737a@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0345.eurprd05.prod.outlook.com
	(2603:10a6:7:92::40) To PR2PR08MB4684.eurprd08.prod.outlook.com
	(2603:10a6:101:22::17)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190430124433266
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a81eb9e-e426-4e4f-87ae-08d6cd507457
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:PR2PR08MB4778; 
x-ms-traffictypediagnostic: PR2PR08MB4778:
x-microsoft-antispam-prvs: <PR2PR08MB4778F4C469DC2B50E72B51CCC13A0@PR2PR08MB4778.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(396003)(39850400004)(136003)(346002)(376002)(189003)(199004)(64756008)(229853002)(68736007)(66446008)(3846002)(66946007)(36756003)(97736004)(66556008)(7736002)(73956011)(6116002)(2501003)(81166006)(71190400001)(305945005)(486006)(66476007)(71200400001)(8936002)(81156014)(2906002)(6436002)(6486002)(5660300002)(93886005)(8676002)(53936002)(66066001)(31696002)(14454004)(476003)(110136005)(11346002)(14444005)(186003)(4326008)(2201001)(478600001)(316002)(2616005)(446003)(86362001)(52116002)(386003)(53546011)(31686004)(6512007)(6506007)(25786009)(99286004)(102836004)(76176011)(6246003)(54906003)(26005)(256004);
	DIR:OUT; SFP:1102; SCL:1; SRVR:PR2PR08MB4778;
	H:PR2PR08MB4684.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nZXGUSwkXoySwQf+z7a4R8hqL/HLmOJJscRFVMSaLQxSLJyfnvZmiKlZKd2yGSm45Tk5dCtwikd2cjLsdkgclCofVNvu26AB41rgD+Cur7UYswDDNo5SGMvcgex31TvsRPShH6xSrzKszzfDvYjpxUd913OxXiQH1ZdtSIC6IOMRu2k9qBrZmHXFLW9Y0B87Dcazcilr+OkeOFlfnN/WO5+zbG2c3bqEufn09TQ/XcdKBFW2P+DZKELyRYeQTvSe+zU4Vn7U0lL7CxYMbKfUjFhdc56oMSOrxxOi7c63zPN2+fdHWoK34kVagsDXjCfL5hkjdOqdfxmillPpPrNt63h1WnAe0X1YS1phNGpeLlB7aEpF9ERxNRuHk6sIDXSORRmLY0aN5sIhAiFLrOEy+6eqC7gx7AzHG6M6NNGOgxo=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <524FAF3FEF99434C9825C20C825D4170@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a81eb9e-e426-4e4f-87ae-08d6cd507457
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 09:44:35.4606 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4778
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.9.139
Subject: Re: [Qemu-devel] [PATCH v5 07/10] qcow2: qcow2_co_preadv: improve
 locking
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430094435.b6WjHPeF1U0KD6AI3g2Uznt1SBHoh5C9MTpHGabvTX4@z>

MzAuMDQuMjAxOSAxMTozOCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MjkuMDQuMjAxOSAxOTozNywgTWF4IFJlaXR6IHdyb3RlOg0KPj4gT24gMDIuMDQuMTkgMTc6Mzcs
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4gQmFja2dyb3VuZDogZGVj
cnlwdGlvbiB3aWxsIGJlIGRvbmUgaW4gdGhyZWFkcywgdG8gdGFrZSBiZW5lZml0IG9mIGl0LA0K
Pj4+IHdlIHNob3VsZCBtb3ZlIGl0IG91dCBvZiB0aGUgbG9jayBmaXJzdC4NCj4+DQo+PiAuLi53
aGljaCBpcyBzYWZlIGFmdGVyIHlvdXIgY29tbWl0IGM5NzJmYTEyM2M3MzUwMWI0LCBJIHByZXN1
bWUuDQo+Pg0KPj4gKEF0IGZpcnN0IGdsYW5jZSwgdGhlIHBhdGNoZWQgbG9va2VkIGEgYml0IHdl
aXJkIHRvIG1lIGJlY2F1c2UgaXQNCj4+IGRvZXNuJ3QgZ2l2ZSBhIHJlYXNvbiB3aHkgZHJvcHBp
bmcgdGhlIGxvY2sgYXJvdW5kDQo+PiBxY3J5cHRvX2Jsb2NrX2RlY3J5cHQoKSB3b3VsZCBiZSBP
Sy4pDQo+Pg0KPj4+IEJ1dCBsZXQncyBnbyBmdXJ0aGVyOiBpdCB0dXJucyBvdXQsIHRoYXQgZm9y
IGxvY2tpbmcgYXJvdW5kIHN3aXRjaA0KPj4+IGNhc2VzIHdlIGhhdmUgb25seSB0d28gdmFyaWFu
dHM6IHdoZW4gd2UganVzdCBkbyBtZW1zZXQoMCkgbm90DQo+Pj4gcmVsZWFzaW5nIHRoZSBsb2Nr
IChpdCBpcyB1c2VsZXNzKSBhbmQgd2hlbiB3ZSBhY3R1YWxseSBjYW4gaGFuZGxlIHRoZQ0KPj4+
IHdob2xlIGNhc2Ugb3V0IG9mIHRoZSBsb2NrLiBTbywgcmVmYWN0b3IgdGhlIHdob2xlIHRoaW5n
IHRvIHJlZHVjZQ0KPj4+IGxvY2tlZCBjb2RlIHJlZ2lvbiBhbmQgbWFrZSBpdCBjbGVhbi4NCj4+
Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1l
bnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+PiBSZXZpZXdlZC1ieTogQWxiZXJ0byBHYXJjaWEgPGJl
cnRvQGlnYWxpYS5jb20+DQo+Pj4gLS0tDQo+Pj4gwqAgYmxvY2svcWNvdzIuYyB8IDQ2ICsrKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+PiDCoCAxIGZpbGUg
Y2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMjQgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZm
IC0tZ2l0IGEvYmxvY2svcWNvdzIuYyBiL2Jsb2NrL3Fjb3cyLmMNCj4+PiBpbmRleCA0NmU4ZTM5
ZGE1Li5mY2Y5MmE3ZWI2IDEwMDY0NA0KPj4+IC0tLSBhL2Jsb2NrL3Fjb3cyLmMNCj4+PiArKysg
Yi9ibG9jay9xY293Mi5jDQo+Pj4gQEAgLTE5ODMsNiArMTk4Myw3IEBAIHN0YXRpYyBjb3JvdXRp
bmVfZm4gaW50IHFjb3cyX2NvX3ByZWFkdihCbG9ja0RyaXZlclN0YXRlICpicywgdWludDY0X3Qg
b2Zmc2V0LA0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBxY293Ml9nZXRfY2x1c3Rlcl9v
ZmZzZXQoYnMsIG9mZnNldCwgJmN1cl9ieXRlcywgJmNsdXN0ZXJfb2Zmc2V0KTsNCj4+DQo+PiBJ
c24ndCB0aGlzIHRoZSBvbmx5IGZ1bmN0aW9uIGluIHRoZSBsb29wIHRoYXQgYWN0dWFsbHkgbmVl
ZHMgdGhlIGxvY2s/DQo+PiBXb3VsZG4ndCBpdCBtYWtlIG1vcmUgc2Vuc2UgdG8ganVzdCB0YWtl
IGl0IGFyb3VuZCB0aGlzIGNhbGw/DQo+Pg0KPiANCj4gSG1tLCBsb29rcyBjb3JyZWN0LCBJJ2xs
IHJlc2VuZC4NCj4gDQo+IA0KDQpPciBub3QsIGFjdHVhbGx5LCB3ZSBtYXkgaGF2ZSBzZXZlcmFs
IHFjb3cyX2dldF9kYXRhX29mZnNldCBjYWxscyB1bmRlciBvbmUgbG9jaywNCmlmIGNsdXN0ZXJz
IGFyZSBkaWZmZXJlbnQga2luZHMgb2YgWkVSTy4gU28sIEkgdGhpbmsgYmV0dGVyIHRvIGtlZXAg
aXQgYXMgaXMgZm9yIG5vdy4NCg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

