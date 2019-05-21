Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9782C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 07:53:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 952902173C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 07:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fVn+Ab8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 952902173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48405 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSzaA-00045X-Sw
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 03:53:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hSzZ3-0003Wi-9c
	for qemu-devel@nongnu.org; Tue, 21 May 2019 03:52:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hSzZ1-00051x-BF
	for qemu-devel@nongnu.org; Tue, 21 May 2019 03:52:01 -0400
Received: from mail-eopbgr140120.outbound.protection.outlook.com
	([40.107.14.120]:8318
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hSzYx-0004zh-NV; Tue, 21 May 2019 03:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=OlsD/+Uxqxwv6NH728euTUYoVyuOC43n1/wLfHO9jz4=;
	b=fVn+Ab8/doRaabBkC6wzWjtoz5seWnOQt5+3iyMHU3wjkcFQWTN52f6/Hz5a7C2X3qOUryLscMGbQGJLk9nI2OW2W0Ct4r7chnIGxrVY+oxTONiuhH53qxr0w3dxUyk+zMYcDLWcuyXkIyB5jRBqRdkk1SjCv7jVYGWLOcF27Ug=
Received: from AM6PR08MB4675.eurprd08.prod.outlook.com (10.255.96.78) by
	AM6PR08MB4487.eurprd08.prod.outlook.com (20.179.18.20) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1900.16; Tue, 21 May 2019 07:51:51 +0000
Received: from AM6PR08MB4675.eurprd08.prod.outlook.com
	([fe80::9051:3c85:28c6:a0c1]) by
	AM6PR08MB4675.eurprd08.prod.outlook.com
	([fe80::9051:3c85:28c6:a0c1%6]) with mapi id 15.20.1878.024;
	Tue, 21 May 2019 07:51:51 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>
Thread-Topic: [PATCH v6 0/3] block/stream: get rid of the base
Thread-Index: AQHVBCE8/V/XOU2VJU++8IoKKmQQnKZ1S9SA
Date: Tue, 21 May 2019 07:51:51 +0000
Message-ID: <e04dd957-4b8f-eed4-f865-74fe2ccf45fd@virtuozzo.com>
References: <20190506153429.52737-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190506153429.52737-1-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0047.eurprd01.prod.exchangelabs.com
	(2603:10a6:7:7d::24) To AM6PR08MB4675.eurprd08.prod.outlook.com
	(2603:10a6:20b:c2::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190521105148982
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06a22ee5-9d43-4c3e-e2e1-08d6ddc12f8c
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:AM6PR08MB4487; 
x-ms-traffictypediagnostic: AM6PR08MB4487:
x-microsoft-antispam-prvs: <AM6PR08MB4487E854FAD9358C58442CE9C1070@AM6PR08MB4487.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:849;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(366004)(39850400004)(346002)(396003)(376002)(199004)(189003)(66946007)(71200400001)(71190400001)(76176011)(52116002)(73956011)(99286004)(102836004)(36756003)(229853002)(7736002)(66556008)(478600001)(7416002)(68736007)(6486002)(256004)(6506007)(386003)(66446008)(64756008)(66476007)(31686004)(305945005)(54906003)(8676002)(31696002)(81166006)(5660300002)(110136005)(81156014)(2616005)(6246003)(53936002)(476003)(11346002)(86362001)(4326008)(446003)(8936002)(6116002)(3846002)(486006)(316002)(6436002)(2906002)(2501003)(6512007)(14454004)(66066001)(25786009)(186003)(26005)(26583001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4487;
	H:AM6PR08MB4675.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Gb201vej7qYwtrRRlEh/cGiKKRR18lM8zhfg+Be8g0bt31RJwRf3t2VdtNqXsU6y9Iwqc6G7ZNuqlwbfc2NdraJ/2yz7oDI0U5YEPFjpMzTbRfXtKldMK5JKn8BgxmJqPVgG1FvOYRD0Du5erS8dl/k8jPLGZHl9tLkaIHCxL3Dpg7zhYu/0WecyTFaa0Im7eEa4SevW0BS2DQ3+OgyVzYwMvaBbFheuVMHAL24kt9Ym7ADTxyMjbztWewGaGFPynYFI7F59VvvtFgvfFgMGEsPyA2QKdMXMDtr9mdLT+v99K+s9ARW6msTXhXi3/6++85tAPEUWwPk/ylQdBw2OOEOM43pR9oRdYFlg6vmjcyYMGQl3bX+6IaxGaevyhds9qNnXRx/6Pa5L8yOqUPe4TB8OtOkeIOSA5o4KdUGIBPw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D4CCD398356AC4D96A4AC2388B7946D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a22ee5-9d43-4c3e-e2e1-08d6ddc12f8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 07:51:51.8331 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4487
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.120
Subject: Re: [Qemu-devel] [PATCH v6 0/3] block/stream: get rid of the base
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
	"berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>,
	"wencongyang2@huawei.com" <wencongyang2@huawei.com>,
	"xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
	"mreitz@redhat.com" <mreitz@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
	"jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cGluZw0KDQowNi4wNS4yMDE5IDE4OjM0LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdy
b3RlOg0KPiBUaGlzIHNlcmllcyBpbnRyb2R1Y2VzIGEgYm90dG9tIGludGVybWVkaWF0ZSBub2Rl
IHRoYXQgZWxpbWluYXRlcyB0aGUNCj4gZGVwZW5kZW5jeSBvbiB0aGUgYmFzZSB0aGF0IG1heSBj
aGFuZ2Ugd2hpbGUgc3RyZWFtIGpvYiBpcyBydW5uaW5nLg0KPiBJdCBoYXBwZW5zIHdoZW4gc3Ry
ZWFtL2NvbW1pdCBwYXJhbGxlbCBqb2JzIGFyZSBydW5uaW5nIG9uIHRoZSBzYW1lDQo+IGJhY2tp
bmcgY2hhaW4uIFRoZSBiYXNlIG5vZGUgb2YgdGhlIHN0cmVhbSBqb2IgbWF5IGJlIGEgdG9wIG5v
ZGUgb2YNCj4gdGhlIHBhcmFsbGVsIGNvbW1pdCBqb2IgYW5kIGNhbiBjaGFuZ2UgYmVmb3JlIHRo
ZSBzdHJlYW0gam9iIGlzDQo+IGNvbXBsZXRlZC4gV2UgYXZvaWQgdGhhdCBkZXBlbmRlbmN5IGJ5
IGludHJvZHVjaW5nIHRoZSBib3R0b20gbm9kZS4NCj4gDQo+IHY2OiBbcmVzZW5kIGJ5IFZsYWRp
bWlyXQ0KPiAgICAwMTogaW1wcm92ZSBjb21tZW50IGluIGJsb2NrL2lvLmMsIHN1Z2dlc3RlZCBi
eSBBbGJlcnRvDQo+IA0KPiB2NTogW3Jlc2VuZCBieSBWbGFkaW1pcl0NCj4gICAgMDE6IHVzZSBj
b21tZW50IHdvcmRpbmcgaW4gYmxvY2svaW8uYyBzdWdnZXN0ZWQgYnkgQWxiZXJ0bw0KPiAgICBO
b3cgdGhlIHdob2xlIHNlcmllcyBhcmUgcmV2aWV3ZWQtYnkgQWxiZXJ0byBhbmQgbWUuDQo+IA0K
PiB2NDoNCj4gdHJhY2Vfc3RyZWFtX3N0YXJ0IHJldmVydGVkIHRvIHRoZSBiYXNlLg0KPiBiZHJ2
X2lzX2FsbG9jYXRlZF9hYm92ZV9pbmNsdXNpdmUoKSBkZWxldGVkIGFuZCB0aGUgbmV3IHBhcmFt
ZXRlcg0KPiAnYm9vbCBpbmNsdWRlX2Jhc2UnIHdhcyBhZGRlZCB0byB0aGUgYmRydl9pc19hbGxv
Y2F0ZWRfYWJvdmUoKS4NCj4gDQo+IEFuZHJleSBTaGlua2V2aWNoICgyKToNCj4gICAgYmxvY2s6
IGluY2x1ZGUgYmFzZSB3aGVuIGNoZWNraW5nIGltYWdlIGNoYWluIGZvciBibG9jayBhbGxvY2F0
aW9uDQo+ICAgIGJsb2NrL3N0cmVhbTogaW50cm9kdWNlIGEgYm90dG9tIG5vZGUNCj4gDQo+IFZs
YWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgKDEpOg0KPiAgICBibG9jay9zdHJlYW06IHJlZmFj
dG9yIHN0cmVhbV9ydW46IGRyb3AgZ290bw0KPiANCj4gICBpbmNsdWRlL2Jsb2NrL2Jsb2NrLmgg
IHwgIDMgKy0NCj4gICBibG9jay9jb21taXQuYyAgICAgICAgIHwgIDIgKy0NCj4gICBibG9jay9p
by5jICAgICAgICAgICAgIHwgMjAgKysrKysrKysrKy0tLS0NCj4gICBibG9jay9taXJyb3IuYyAg
ICAgICAgIHwgIDIgKy0NCj4gICBibG9jay9yZXBsaWNhdGlvbi5jICAgIHwgIDIgKy0NCj4gICBi
bG9jay9zdHJlYW0uYyAgICAgICAgIHwgNjIgKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzI0NSB8ICA0ICstLQ0KPiAgIDcg
ZmlsZXMgY2hhbmdlZCwgNTAgaW5zZXJ0aW9ucygrKSwgNDUgZGVsZXRpb25zKC0pDQo+IA0KDQoN
Ci0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

