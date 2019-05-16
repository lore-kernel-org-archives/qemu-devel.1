Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E220C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 10:58:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE51C2070D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 10:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hneSLRh1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE51C2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52040 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRE5K-0001eb-U8
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 06:58:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1hRE4A-00011e-UX
	for qemu-devel@nongnu.org; Thu, 16 May 2019 06:56:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1hRE49-0007XR-Ts
	for qemu-devel@nongnu.org; Thu, 16 May 2019 06:56:50 -0400
Received: from mail-eopbgr10097.outbound.protection.outlook.com
	([40.107.1.97]:5972
	helo=EUR02-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1hRE48-0007UC-Uj; Thu, 16 May 2019 06:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=ts2F8eAyDrLNYi6M4sCJvFp8NdqX3GNIpItXatYh4D8=;
	b=hneSLRh1wR3/ItLJkxMj7PUH1yi3bF/Q+KtYmaTfCw6r+puC0QsYmbi71qhLmiOD1+MdpGcNAzw+0t3LGTJBTyOtAt6RMEOPcHiz1s7NAjBuEtvx7DOk2pcwHaYD++Ggt2BD1l7LUhaBjhMXAZrVKQxlSkYai7FspgLEv398pcQ=
Received: from AM6PR08MB4899.eurprd08.prod.outlook.com (10.255.99.74) by
	AM6PR08MB4643.eurprd08.prod.outlook.com (10.255.22.82) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1878.24; Thu, 16 May 2019 10:56:46 +0000
Received: from AM6PR08MB4899.eurprd08.prod.outlook.com
	([fe80::998:b814:8925:8b7c]) by AM6PR08MB4899.eurprd08.prod.outlook.com
	([fe80::998:b814:8925:8b7c%7]) with mapi id 15.20.1878.024;
	Thu, 16 May 2019 10:56:45 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>
Thread-Topic: [PATCH] [RFC] qcow2: add compression type feature
Thread-Index: AQHU/hJLbBKDF0hyY0mlw0nisTBZV6Ztrh4A///9YYCAAARzAA==
Date: Thu, 16 May 2019 10:56:45 +0000
Message-ID: <728ab5d4-0a35-1597-6487-b12ae037fddf@virtuozzo.com>
References: <20190205090825.14059-1-dplotnikov@virtuozzo.com>
	<cd22d738-d09c-4e2f-5ec6-8d3d34e2b341@redhat.com>
	<f441d52b-4124-7951-c715-a35127ca3a54@virtuozzo.com>
	<be26ed1d-ced3-4a26-24f5-ef26278d72a5@redhat.com>
In-Reply-To: <be26ed1d-ced3-4a26-24f5-ef26278d72a5@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0028.eurprd02.prod.outlook.com
	(2603:10a6:3:e4::14) To AM6PR08MB4899.eurprd08.prod.outlook.com
	(2603:10a6:20b:ce::10)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30f2963a-7f72-4b8c-6844-08d6d9ed3008
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:AM6PR08MB4643; 
x-ms-traffictypediagnostic: AM6PR08MB4643:
x-microsoft-antispam-prvs: <AM6PR08MB46434F01CAE194D98DFD865ECF0A0@AM6PR08MB4643.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(376002)(136003)(39850400004)(346002)(396003)(199004)(189003)(256004)(2616005)(446003)(7736002)(53936002)(19627235002)(476003)(53546011)(11346002)(305945005)(14454004)(64756008)(73956011)(66946007)(478600001)(71190400001)(6506007)(66446008)(486006)(66556008)(66476007)(5660300002)(386003)(186003)(71200400001)(66066001)(36756003)(6512007)(2906002)(31686004)(52116002)(4326008)(3846002)(2501003)(110136005)(54906003)(68736007)(6486002)(76176011)(229853002)(26005)(6436002)(99286004)(86362001)(102836004)(8936002)(316002)(31696002)(6246003)(8676002)(81166006)(6116002)(25786009)(81156014);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4643;
	H:AM6PR08MB4899.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CNkAzv/YfDI3CnIQgku03POYha3Kd0ASGc9cSPB1BsnNzleejHvcpjK7pCvx9rslmZC2bb+++/tehuwuxwwn7V7brKBeYOAzx4Y42ilbTAymU0AwQRa6t/g7geCpsOwY762zOZGMhm6dTNI6utCcp7tq7JoEcjCrbZHfvvR8R8xmQNS5FUBjrLFgvcMS7OSiZhrG2J7yC+WHl/sfYK8o9SGRUN4iQiZIACxMWwS9nQc0ECq1W42DRgoFoHN9qYer7TH83YmSGf3p0+LMZmVQgDyDL/EeS3OatV5bHrpQDcf69goyFz17O0E5LESbU7GWf3ijmDR/3ATVNS2OCXfl0QICHsbMzxaz0Y885r+8CC1ft2fJsNDQ2CLUo6WOJawIJqP+FXtAgQ+ggZU6YrErbQZNjSRzFKuBaHZRXo4ySJ4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <30A4BCA76A15DC4FBFC57C10F42D0CE5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f2963a-7f72-4b8c-6844-08d6d9ed3008
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 10:56:45.8206 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4643
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.97
Subject: Re: [Qemu-devel] [PATCH] [RFC] qcow2: add compression type feature
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDE2LjA1LjIwMTkgMTM6NDAsIE1heCBSZWl0eiB3cm90ZToNCj4gT24gMTYuMDUuMTkg
MDk6NTAsIERlbmlzIFBsb3RuaWtvdiB3cm90ZToNCj4+DQo+Pg0KPj4gT24gMjkuMDQuMjAxOSAx
OjMyLCBNYXggUmVpdHogd3JvdGU6DQo+Pj4gT24gMDUuMDIuMTkgMTA6MDgsIERlbmlzIFBsb3Ru
aWtvdiB3cm90ZToNCj4+Pj4gVGhlIHBhdGNoIGFkZHMgc29tZSBwcmVwYXJhdGlvbiBwYXJ0cyBm
b3IgaW5jb21wYXRpYmxlIGNvbXByZXNzaW9uIHR5cGUNCj4+Pj4gZmVhdHVyZSBpbnRvIFFDT1cy
IGhlYWRlciB0aGF0IGluZGljYXRlcyB0aGF0ICphbGwqIGNvbXByZXNzZWQgY2x1c3RlcnMNCj4+
Pj4gbXVzdCBiZSAoZGUpY29tcHJlc3NlZCB1c2luZyBhIGNlcnRhaW4gY29tcHJlc3Npb24gdHlw
ZS4NCj4+Pj4NCj4+Pj4gSXQgaXMgaW1wbGllZCB0aGF0IHRoZSBjb21wcmVzc2lvbiB0eXBlIGlz
IHNldCBvbiB0aGUgaW1hZ2UgY3JlYXRpb24gYW5kDQo+Pj4+IGNhbiBiZSBjaGFuZ2VkIG9ubHkg
bGF0ZXIgYnkgaW1hZ2UgY29udmVydGlvbiwgdGh1cyB0aGUgb25seSBjb21wcmVzc2lvbg0KPj4+
PiBhbGdvcml0aG0gaXMgdXNlZCBmb3IgdGhlIGltYWdlLg0KPj4+Pg0KPj4+PiBUaGUgcGxhbiBp
cyB0byBhZGQgc3VwcG9ydCBmb3IgWlNURCBhbmQgdGhlbiBtYXkgYmUgc29tZXRoaW5nIG1vcmUg
ZWZmZWN0aXZlDQo+Pj4+IGluIHRoZSBmdXR1cmUuDQo+Pj4+DQo+Pj4+IFpTRFQgY29tcHJlc3Np
b24gYWxnb3JpdGhtIGNvbnN1bWVzIDMtNSB0aW1lcyBsZXNzIENQVSBwb3dlciB3aXRoIGENCj4+
Pj4gY29tcGFyYWJsZSBjb21yZXNzaW9uIHJhdGlvIHdpdGggemxpYi4gSXQgd291bGQgYmUgd2lz
ZSB0byB1c2UgaXQgZm9yDQo+Pj4+IGRhdGEgY29tcHJlc3Npb24gZi5lLiBmb3IgYmFja3Vwcy4N
Cj4+Pj4NCj4+Pj4gVGhlIGRlZmF1bHQgY29tcHJlc3Npb24gaXMgWkxJQi4NCj4+Pj4NCj4+Pj4g
U2lnbmVkLW9mZi1ieTogRGVuaXMgUGxvdG5pa292IDxkcGxvdG5pa292QHZpcnR1b3p6by5jb20+
DQo+Pj4+IC0tLQ0KPj4+PiAgICBibG9jay9xY293Mi5jIHwgMjUgKysrKysrKysrKysrKysrKysr
KysrKysrKw0KPj4+PiAgICBibG9jay9xY293Mi5oIHwgMjYgKysrKysrKysrKysrKysrKysrKysr
Ky0tLS0NCj4+Pj4gICAgMiBmaWxlcyBjaGFuZ2VkLCA0NyBpbnNlcnRpb25zKCspLCA0IGRlbGV0
aW9ucygtKQ0KPj4+DQo+Pj4gQXJlIHRoZXJlIHBsYW5zIHRvIHB1cnN1ZSB0aGlzIGZ1cnRoZXI/
DQo+PiBZZXMsIEknbSBnb2luZyB0byBjb21lIHVwIHdpdGggdGhlIGZpcnN0IHZlcnNpb24gaW4g
YSBmZXcgd2Vla3MNCj4gDQo+IE9LLg0KPiANCj4+PiBbLi4uXQ0KPj4+DQo+Pj4+IGRpZmYgLS1n
aXQgYS9ibG9jay9xY293Mi5oIGIvYmxvY2svcWNvdzIuaA0KPj4+PiBpbmRleCAzMmNjZTllZWUy
Li5mZGRlNWJiZWZkIDEwMDY0NA0KPj4+PiAtLS0gYS9ibG9jay9xY293Mi5oDQo+Pj4+ICsrKyBi
L2Jsb2NrL3Fjb3cyLmgNCj4+Pj4gQEAgLTExMiw2ICsxMTIsMTAgQEANCj4+Pj4gICAgI2RlZmlu
ZSBRQ09XMl9PUFRfUkVGQ09VTlRfQ0FDSEVfU0laRSAicmVmY291bnQtY2FjaGUtc2l6ZSINCj4+
Pj4gICAgI2RlZmluZSBRQ09XMl9PUFRfQ0FDSEVfQ0xFQU5fSU5URVJWQUwgImNhY2hlLWNsZWFu
LWludGVydmFsIg0KPj4+PiAgICANCj4+Pj4gKy8qIENvbXByZXNzaW9uIHR5cGVzICovDQo+Pj4+
ICsjZGVmaW5lIFFDT1cyX0NPTVBSRVNTSU9OX1RZUEVfWkxJQiAgICAwDQo+Pj4+ICsjZGVmaW5l
IFFDT1cyX0NPTVBSRVNTSU9OX1RZUEVfWlNURCAgICAxDQo+Pj4NCj4+PiBXZSBwcm9iYWJseSB3
YW50IFFBUEkgdHlwZXMgYW55d2F5IChxZW11LWltZyBpbmZvIHNob3VsZCByZXBvcnQgdGhlDQo+
Pj4gY29tcHJlc3Npb24gdHlwZSksIHNvIEkgdGhpbmsgd2UgY291bGQgdXNlIHRoZW0gaW5zdGVh
ZC4NCj4+IEknbSBub3Qgc3VyZSB0aGF0IEkgdW5kZXJzdG9vZCB0aGUgaWRlYS4gQ291bGQgeW91
IHBsZWFzZSBleHBsYWluIHdoYXQNCj4+IGlzIG1lYW50IGhlcmU/IFdlIGRvbid0IG5lZWQgdGhv
c2UgY29uc3RhbnRzIGFuZCBzaG91bGQgdXNlIHRoZQ0KPj4gY29uc3RhbnRzIGRlZmluZWQgc29t
ZXdoZXJlIGVsc2UgKHdoZXJlKT8NCj4gDQo+IHFlbXUtaW1nIGluZm8gY2FuIHJlcG9ydCBmb3Jt
YXQtc3BlY2lmaWMgaW5mb3JtYXRpb24uICBJIHRoaW5rIHRoZQ0KPiBjb21wcmVzc2lvbiB0eXBl
IHNob3VsZCBiZSBsaXN0ZWQgdGhlcmUgYXMgd2VsbCwgb25jZSB0aGVyZSBpcyBtb3JlIHRoYW4N
Cj4gb25lLg0KPiANCj4gRm9ybWF0LXNwZWNpZmljIGluZm9ybWF0aW9uIGlzIGEgUUFQSSB0eXBl
LCBuYW1lbHkNCj4gSW1hZ2VJbmZvU3BlY2lmaWNRQ293Mi4gIFRoZXJlZm9yZSwgZXZlcnl0aGlu
ZyBpdCBjb250YWlucyBuZWVkcyB0byBiZSBhDQo+IFFBUEkgb2JqZWN0LCBhbmQgdGhpcyBpbmNs
dWRlcyBwb3RlbnRpYWwgY29tcHJlc3Npb24gaW5mb3JtYXRpb24uICBXZQ0KPiB0aHVzIG5lZWQg
YSBRQVBJIGVudW0gbGlrZSBRY293MkNvbXByZXNzaW9uVHlwZSwgYW5kIHRoYXQgd291bGQNCj4g
YXV0b21hdGljYWxseSBnaXZlIHVzIHRoZXNlIHZhbHVlcy4NCg0KVGhhbmtzIGZvciBjbGFyaWZp
Y2F0aW9uLiBXaWxsIGRvIHRoYXQgd2F5Lg0KDQpEZW5pcw0KPiANCj4gTWF4DQo+IA0KDQotLSAN
CkJlc3QsDQpEZW5pcw0K

