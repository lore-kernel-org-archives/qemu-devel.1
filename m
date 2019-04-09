Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB4BC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 13:20:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 138282084C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 13:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="J1tfn4FT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 138282084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41726 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDqfk-0007zs-9l
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 09:20:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDqeJ-0007Lh-8E
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDqeI-0008Jc-7y
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:18:51 -0400
Received: from mail-eopbgr150092.outbound.protection.outlook.com
	([40.107.15.92]:51632
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
	id 1hDqeE-0008Db-TU; Tue, 09 Apr 2019 09:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=GyoHBUQI8HoTqEH6iRq3vcakYHEKGpxsSgYUJqYvVVg=;
	b=J1tfn4FTswKcSzvrseAEgcrt5D7zyJEqHk4zIRihUwHy+5b81YFCw7zAJEaddzt0lOsDC91igh64iyCGhYb3iMnb2WKclbQ+T/7wM70F5QeCTWhJxO1XdqHTtLXJuVCBXCY+KVXeNtWLGp9lhUmbMVYqdzYibwFyHBbFkX+Y5Hs=
Received: from AM6PR08MB4421.eurprd08.prod.outlook.com (20.179.18.23) by
	AM6PR08MB3767.eurprd08.prod.outlook.com (20.178.88.220) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.13; Tue, 9 Apr 2019 13:18:43 +0000
Received: from AM6PR08MB4421.eurprd08.prod.outlook.com
	([fe80::d15a:3eaa:44bc:2644]) by
	AM6PR08MB4421.eurprd08.prod.outlook.com
	([fe80::d15a:3eaa:44bc:2644%4]) with mapi id 15.20.1771.019;
	Tue, 9 Apr 2019 13:18:43 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v2] qcow2: discard bitmap when removed
Thread-Index: AQHUz0fFuPhc95BDyUWuCjMQWLZPB6Yy3NUAgAEyEgA=
Date: Tue, 9 Apr 2019 13:18:43 +0000
Message-ID: <105c6869-c2a7-bb3c-3c73-b06fd5280813@virtuozzo.com>
References: <1551346019-293202-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1c64f75a-d379-980f-aab9-d4ce75c1144b@redhat.com>
In-Reply-To: <1c64f75a-d379-980f-aab9-d4ce75c1144b@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0057.eurprd04.prod.outlook.com
	(2603:10a6:7:7c::46) To AM6PR08MB4421.eurprd08.prod.outlook.com
	(2603:10a6:20b:71::23)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1bbb9b75-985d-4e13-b649-08d6bcede3ad
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:AM6PR08MB3767; 
x-ms-traffictypediagnostic: AM6PR08MB3767:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM6PR08MB3767C83677140B323FD252D7F42D0@AM6PR08MB3767.eurprd08.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(396003)(39850400004)(136003)(376002)(366004)(346002)(189003)(199004)(5660300002)(8676002)(446003)(6506007)(81156014)(53546011)(71190400001)(26005)(2616005)(11346002)(106356001)(486006)(99286004)(44832011)(105586002)(102836004)(68736007)(186003)(25786009)(97736004)(52116002)(966005)(71200400001)(561944003)(476003)(81166006)(66066001)(229853002)(6246003)(256004)(31686004)(6512007)(6486002)(478600001)(2201001)(386003)(14454004)(107886003)(14444005)(53936002)(4326008)(6436002)(2906002)(31696002)(6116002)(86362001)(6306002)(316002)(305945005)(7736002)(54906003)(36756003)(3846002)(2501003)(110136005)(76176011)(8936002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3767;
	H:AM6PR08MB4421.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dg7UFXwv9l+sP5Iog2lvpOnnbRB2zqmgWbTyYuHX+Heikg8i1Q64y6cEP4oZwZmPdcLzFzj1F72Pg4OFrnVzji+JDH23LXwNWgndHfzst8HFGQ7ps5x02mX6RPPuxWpqqJAH9CkJzTh7vqcxIxGFuL9Q1PWBQ/HNNGGQdRG9pqiMd6pZqaW56wma0L+7ZB3KvmO5T8kBlSud3pi2BAzcDu0zdMONpAsVV5gSoa6j99a8zJlELXc3owGI2+Lde51bfzVvtSCrIQUBVDEigtBx29C2OPKordUsixRdJfA85gIXlLZjve9hDcmuIgpFXux6SVfunFxTdQD80kvt4im6Xe4b3vxLRToQncVijw1HtesHSNEP2u2JtnSEG0VkdbkkGk68ZJH9WDVK17If4B0/BDzCyef+N5admUQ2DVvy79s=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <88720ACCE045634AAB0DBC73409A7B9F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bbb9b75-985d-4e13-b649-08d6bcede3ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 13:18:43.6009 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3767
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.92
Subject: Re: [Qemu-devel] [PATCH v2] qcow2: discard bitmap when removed
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
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409131843.9toHtRD3kd_vbYs3ICY27ffvAmTBS8hkX3JpSRA7Q5M@z>

DQoNCk9uIDA4LzA0LzIwMTkgMjI6MDMsIE1heCBSZWl0eiB3cm90ZToNCj4gT24gMjguMDIuMTkg
MTA6MjYsIEFuZHJleSBTaGlua2V2aWNoIHdyb3RlOg0KPj4gV2hlbiBhIGJpdG1hcCBpcyByZW1v
dmVkLCB3ZSBjYW4gY2xlYW4gc29tZSBzcGFjZSBvbiB0aGUgZGlzay4gVGhlIHNpemUNCj4+IG9m
IGEgY2x1c3RlciBtYXkgYmUgbGFyZ2VyLCBzbyBpcyB0aGUgc2l6ZSBvZiB0aGUgYml0bWFwIHRo
YXQgaW5jbHVkZXMNCj4+IG1hbnkgY2x1c3RlcnMuIFNvbWUgYml0bWFwcyBjYW4gYmUgYXMgbGFy
Z2UgYXMgdGVucyBvZiBtZWdhYnl0ZXMuDQo+PiBUaGUgZmxhZyBRQ09XMl9ESVNDQVJEX0FMV0FZ
UyBhbGxvd3MgYSBjYWxsIHRvIHRoZSByYXdfY29fcGRpc2NhcmQoKQ0KPj4gdGhhdCBkb2VzIHRo
ZSBhY3R1YWwgY2xlYW5pbmcgb2YgdGhlIGltYWdlIG9uIGRpc2ssIHdoaWxlIHdpdGggdGhlIGZs
YWcNCj4+IFFDT1cyX0RJU0NBUkRfT1RIRVIsIGEgcmVmZXJlbmNlIGNvdW50IG9mIHRoZSBjbHVz
dGVyIGlzIHVwZGF0ZWQgb25seS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgU2hpbmtl
dmljaCA8YW5kcmV5LnNoaW5rZXZpY2hAdmlydHVvenpvLmNvbT4NCj4+IC0tLQ0KPj4gdjE6IERp
c2NhcmQgb2xkIGJpdG1hcCBkaXJlY3RvcmllcyBpbiBRQ09XMiBpbWFnZQ0KPj4NCj4+IEluIHRo
ZSBmaXJzdCB2ZXJzaW9uIG9mIHRoZSBwYXRjaCwgYW55IGNhbGwgdG8gcWNvdzJfZnJlZV9jbHVz
dGVycygpIGluDQo+PiBibG9jay9xY293Mi1iaXRtYXAuYyB3YXMgd2l0aCB0aGUgZmxhZyBRQ09X
Ml9ESVNDQVJEX0FMV0FZUywgZXZlbiBpbiB0aGUNCj4+IGNhc2VzIHdoZW4gdGhlIGNsZWFuZWQg
c3BhY2UgaXMgaW5zaWduaWZpY2FudCwgcGFydGljdWxhcmx5LCBpbiBjYXNlIG9mDQo+PiBiaXRt
YXAgZGlyZWN0b3JpZXMuDQo+PiBEaXNjdXNzZWQgaW4gdGhlIGVtYWlsIHRocmVhZCB3aXRoIHRo
ZSBtZXNzYWdlIElEDQo+PiA8MTU0OTk3NDk1MS03MzEyODUtMS1naXQtc2VuZC1lbWFpbC1hbmRy
ZXkuc2hpbmtldmljaEB2aXJ0dW96em8uY29tPg0KPj4NCj4+ICAgYmxvY2svcWNvdzItYml0bWFw
LmMgfCAyICstDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQ0KPiANCj4gVGhhbmtzLCBjaGFuZ2VkIHRoZSBjb21taXQgbWVzc2FnZSB0byBWbGFkaW1p
cuKAmXMgcHJvcG9zYWwgYW5kIGFwcGxpZWQgdG8NCj4gbXkgYmxvY2stbmV4dCBicmFuY2g6DQo+
IA0KPiBodHRwczovL2dpdC54YW5jbGljLm1vZS9YYW5DbGljL3FlbXUvY29tbWl0cy9icmFuY2gv
YmxvY2stbmV4dA0KPiANCj4gTWF4DQo+IA0KDQpUaGFuayB5b3UsIE1heCENCi0tIA0KV2l0aCB0
aGUgYmVzdCByZWdhcmRzLA0KQW5kcmV5IFNoaW5rZXZpY2gNCg0K

