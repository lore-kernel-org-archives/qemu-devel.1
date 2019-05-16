Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8B6C04AB4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 07:51:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1166420862
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 07:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NrB9kS9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1166420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50267 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRBAg-0006KH-Dp
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 03:51:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1hRB9f-0005iR-LE
	for qemu-devel@nongnu.org; Thu, 16 May 2019 03:50:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1hRB9e-0000yy-8n
	for qemu-devel@nongnu.org; Thu, 16 May 2019 03:50:19 -0400
Received: from mail-vi1eur04on072c.outbound.protection.outlook.com
	([2a01:111:f400:fe0e::72c]:58497
	helo=EUR04-VI1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1hRB9d-0000tr-Ba; Thu, 16 May 2019 03:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=2qpUdmMYIZNgu0iXBIXy/2WH6UM+wFnZfqazkmEEHgw=;
	b=NrB9kS9OT1uTwFzL4k/Wl/yjcJzNToTCXbpDDSzRgdR58J518Un9HgQ1ViqhCkyYm9yu55v/bm805ehPYLanvG1njEXjgoZBQMcShk8bECVaDN+wgvwGsgdZEIGFDG9p/5XBFwJVmNMwUO3XJeuSiOncmLVo3kHDHLNamLLFUUU=
Received: from AM6PR08MB4899.eurprd08.prod.outlook.com (10.255.99.74) by
	AM6PR08MB3368.eurprd08.prod.outlook.com (20.177.112.217) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1878.22; Thu, 16 May 2019 07:50:12 +0000
Received: from AM6PR08MB4899.eurprd08.prod.outlook.com
	([fe80::998:b814:8925:8b7c]) by AM6PR08MB4899.eurprd08.prod.outlook.com
	([fe80::998:b814:8925:8b7c%7]) with mapi id 15.20.1878.024;
	Thu, 16 May 2019 07:50:12 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>
Thread-Topic: [PATCH] [RFC] qcow2: add compression type feature
Thread-Index: AQHU/hJLbBKDF0hyY0mlw0nisTBZV6Zte9QA
Date: Thu, 16 May 2019 07:50:11 +0000
Message-ID: <f441d52b-4124-7951-c715-a35127ca3a54@virtuozzo.com>
References: <20190205090825.14059-1-dplotnikov@virtuozzo.com>
	<cd22d738-d09c-4e2f-5ec6-8d3d34e2b341@redhat.com>
In-Reply-To: <cd22d738-d09c-4e2f-5ec6-8d3d34e2b341@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0213.eurprd05.prod.outlook.com
	(2603:10a6:3:fa::13) To AM6PR08MB4899.eurprd08.prod.outlook.com
	(2603:10a6:20b:ce::10)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3de2c007-2ecb-4678-fdae-08d6d9d31fe8
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:AM6PR08MB3368; 
x-ms-traffictypediagnostic: AM6PR08MB3368:
x-microsoft-antispam-prvs: <AM6PR08MB3368F5D9DD6C80CA0EFA10B3CF0A0@AM6PR08MB3368.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39850400004)(376002)(346002)(136003)(366004)(396003)(189003)(199004)(71190400001)(54906003)(305945005)(66946007)(64756008)(66446008)(66476007)(66556008)(81156014)(316002)(99286004)(6436002)(52116002)(76176011)(110136005)(256004)(5660300002)(71200400001)(73956011)(476003)(2616005)(446003)(11346002)(14454004)(486006)(31686004)(8676002)(81166006)(6512007)(7736002)(6506007)(26005)(386003)(53546011)(478600001)(102836004)(66066001)(36756003)(186003)(229853002)(6486002)(86362001)(2501003)(2906002)(3846002)(68736007)(25786009)(8936002)(6116002)(19627235002)(53936002)(6246003)(4326008)(31696002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3368;
	H:AM6PR08MB4899.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Eb5gIIqCWCtywiqXE348eLYvCEHAUdA4Ap/TFid7mTvQxxzbfPSjdsXRlc6A66kGeDPjzWARxlowriBzYwxg/7kn/ve0+Oin6f00S0mI4Cc4tMIScja1m+0+VtfEYx623esl/FLbBIVysnm82iB+gFiDiS7xHbUWZ5jGlr4EU1PHHHUdx8GFSVie+EeFD2ObfSVJ6crUChX6BduU1kiB6CNAKXDIEYCnMgRBHLWKO1aGpzYr6ZyPzxqQHK7KfhXgzKCtjAJnE3jdvTeCAu97BlqOydhLZpkl6owOaqkuMnjCpqa9ITBb8x7r/Zl+mG0QmgemyGwCvaHYyUfvWuP9Rj4zyUppfjo15bvZPSAgNmFOk6n1Z38j//Q06CEgz0jCF2G3MUrLBRXKOOPsoQdfA6YY9zquSTOzVYb9o6LJnt8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CC247038DEA2543B51408B4587F58DA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de2c007-2ecb-4678-fdae-08d6d9d31fe8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 07:50:12.0221 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3368
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0e::72c
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

DQoNCk9uIDI5LjA0LjIwMTkgMTozMiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAwNS4wMi4xOSAx
MDowOCwgRGVuaXMgUGxvdG5pa292IHdyb3RlOg0KPj4gVGhlIHBhdGNoIGFkZHMgc29tZSBwcmVw
YXJhdGlvbiBwYXJ0cyBmb3IgaW5jb21wYXRpYmxlIGNvbXByZXNzaW9uIHR5cGUNCj4+IGZlYXR1
cmUgaW50byBRQ09XMiBoZWFkZXIgdGhhdCBpbmRpY2F0ZXMgdGhhdCAqYWxsKiBjb21wcmVzc2Vk
IGNsdXN0ZXJzDQo+PiBtdXN0IGJlIChkZSljb21wcmVzc2VkIHVzaW5nIGEgY2VydGFpbiBjb21w
cmVzc2lvbiB0eXBlLg0KPj4NCj4+IEl0IGlzIGltcGxpZWQgdGhhdCB0aGUgY29tcHJlc3Npb24g
dHlwZSBpcyBzZXQgb24gdGhlIGltYWdlIGNyZWF0aW9uIGFuZA0KPj4gY2FuIGJlIGNoYW5nZWQg
b25seSBsYXRlciBieSBpbWFnZSBjb252ZXJ0aW9uLCB0aHVzIHRoZSBvbmx5IGNvbXByZXNzaW9u
DQo+PiBhbGdvcml0aG0gaXMgdXNlZCBmb3IgdGhlIGltYWdlLg0KPj4NCj4+IFRoZSBwbGFuIGlz
IHRvIGFkZCBzdXBwb3J0IGZvciBaU1REIGFuZCB0aGVuIG1heSBiZSBzb21ldGhpbmcgbW9yZSBl
ZmZlY3RpdmUNCj4+IGluIHRoZSBmdXR1cmUuDQo+Pg0KPj4gWlNEVCBjb21wcmVzc2lvbiBhbGdv
cml0aG0gY29uc3VtZXMgMy01IHRpbWVzIGxlc3MgQ1BVIHBvd2VyIHdpdGggYQ0KPj4gY29tcGFy
YWJsZSBjb21yZXNzaW9uIHJhdGlvIHdpdGggemxpYi4gSXQgd291bGQgYmUgd2lzZSB0byB1c2Ug
aXQgZm9yDQo+PiBkYXRhIGNvbXByZXNzaW9uIGYuZS4gZm9yIGJhY2t1cHMuDQo+Pg0KPj4gVGhl
IGRlZmF1bHQgY29tcHJlc3Npb24gaXMgWkxJQi4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBEZW5p
cyBQbG90bmlrb3YgPGRwbG90bmlrb3ZAdmlydHVvenpvLmNvbT4NCj4+IC0tLQ0KPj4gICBibG9j
ay9xY293Mi5jIHwgMjUgKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICBibG9jay9xY293
Mi5oIHwgMjYgKysrKysrKysrKysrKysrKysrKysrKy0tLS0NCj4+ICAgMiBmaWxlcyBjaGFuZ2Vk
LCA0NyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gQXJlIHRoZXJlIHBsYW5z
IHRvIHB1cnN1ZSB0aGlzIGZ1cnRoZXI/DQpZZXMsIEknbSBnb2luZyB0byBjb21lIHVwIHdpdGgg
dGhlIGZpcnN0IHZlcnNpb24gaW4gYSBmZXcgd2Vla3MNCj4gDQo+IFsuLi5dDQo+IA0KPj4gZGlm
ZiAtLWdpdCBhL2Jsb2NrL3Fjb3cyLmggYi9ibG9jay9xY293Mi5oDQo+PiBpbmRleCAzMmNjZTll
ZWUyLi5mZGRlNWJiZWZkIDEwMDY0NA0KPj4gLS0tIGEvYmxvY2svcWNvdzIuaA0KPj4gKysrIGIv
YmxvY2svcWNvdzIuaA0KPj4gQEAgLTExMiw2ICsxMTIsMTAgQEANCj4+ICAgI2RlZmluZSBRQ09X
Ml9PUFRfUkVGQ09VTlRfQ0FDSEVfU0laRSAicmVmY291bnQtY2FjaGUtc2l6ZSINCj4+ICAgI2Rl
ZmluZSBRQ09XMl9PUFRfQ0FDSEVfQ0xFQU5fSU5URVJWQUwgImNhY2hlLWNsZWFuLWludGVydmFs
Ig0KPj4gICANCj4+ICsvKiBDb21wcmVzc2lvbiB0eXBlcyAqLw0KPj4gKyNkZWZpbmUgUUNPVzJf
Q09NUFJFU1NJT05fVFlQRV9aTElCICAgIDANCj4+ICsjZGVmaW5lIFFDT1cyX0NPTVBSRVNTSU9O
X1RZUEVfWlNURCAgICAxDQo+IA0KPiBXZSBwcm9iYWJseSB3YW50IFFBUEkgdHlwZXMgYW55d2F5
IChxZW11LWltZyBpbmZvIHNob3VsZCByZXBvcnQgdGhlDQo+IGNvbXByZXNzaW9uIHR5cGUpLCBz
byBJIHRoaW5rIHdlIGNvdWxkIHVzZSB0aGVtIGluc3RlYWQuDQpJJ20gbm90IHN1cmUgdGhhdCBJ
IHVuZGVyc3Rvb2QgdGhlIGlkZWEuIENvdWxkIHlvdSBwbGVhc2UgZXhwbGFpbiB3aGF0IA0KaXMg
bWVhbnQgaGVyZT8gV2UgZG9uJ3QgbmVlZCB0aG9zZSBjb25zdGFudHMgYW5kIHNob3VsZCB1c2Ug
dGhlIA0KY29uc3RhbnRzIGRlZmluZWQgc29tZXdoZXJlIGVsc2UgKHdoZXJlKT8NCg0KRGVuaXMN
Cg0KDQo+IA0KPj4gICB0eXBlZGVmIHN0cnVjdCBRQ293SGVhZGVyIHsNCj4+ICAgICAgIHVpbnQz
Ml90IG1hZ2ljOw0KPj4gICAgICAgdWludDMyX3QgdmVyc2lvbjsNCj4+IEBAIC0xOTcsMTAgKzIw
MSwxMyBAQCBlbnVtIHsNCj4+ICAgDQo+PiAgIC8qIEluY29tcGF0aWJsZSBmZWF0dXJlIGJpdHMg
Ki8NCj4+ICAgZW51bSB7DQo+PiAtICAgIFFDT1cyX0lOQ09NUEFUX0RJUlRZX0JJVE5SICAgPSAw
LA0KPj4gLSAgICBRQ09XMl9JTkNPTVBBVF9DT1JSVVBUX0JJVE5SID0gMSwNCj4+IC0gICAgUUNP
VzJfSU5DT01QQVRfRElSVFkgICAgICAgICA9IDEgPDwgUUNPVzJfSU5DT01QQVRfRElSVFlfQklU
TlIsDQo+PiAtICAgIFFDT1cyX0lOQ09NUEFUX0NPUlJVUFQgICAgICAgPSAxIDw8IFFDT1cyX0lO
Q09NUEFUX0NPUlJVUFRfQklUTlIsDQo+PiArICAgIFFDT1cyX0lOQ09NUEFUX0RJUlRZX0JJVE5S
ICAgICAgICAgICAgPSAwLA0KPj4gKyAgICBRQ09XMl9JTkNPTVBBVF9DT1JSVVBUX0JJVE5SICAg
ICAgICAgID0gMSwNCj4+ICsgICAgUUNPVzJfSU5DT01QQVRfQ09NUFJFU1NJT05fVFlQRV9CSVRO
UiA9IDIsDQo+PiArICAgIFFDT1cyX0lOQ09NUEFUX0RJUlRZICAgICAgICAgICAgICAgICAgPSAx
IDw8IFFDT1cyX0lOQ09NUEFUX0RJUlRZX0JJVE5SLA0KPj4gKyAgICBRQ09XMl9JTkNPTVBBVF9D
T1JSVVBUICAgICAgICAgICAgICAgID0gMSA8PCBRQ09XMl9JTkNPTVBBVF9DT1JSVVBUX0JJVE5S
LA0KPj4gKyAgICBRQ09XMl9JTkNPTVBBVF9DT01QUkVTU0lPTl9UWVBFICAgICAgID0NCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAxIDw8IFFDT1cyX0lOQ09NUEFUX0NP
TVBSRVNTSU9OX1RZUEVfQklUTlIsDQo+PiAgIA0KPj4gICAgICAgUUNPVzJfSU5DT01QQVRfTUFT
SyAgICAgICAgICA9IFFDT1cyX0lOQ09NUEFUX0RJUlRZDQo+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgUUNPVzJfSU5DT01QQVRfQ09SUlVQVCwNCj4gDQo+IFRoaXMgbWFz
ayBuZWVkcyB0byBiZSBleHBhbmRlZCBieSBRQ09XMl9JTkNPTVBBVF9DT01QUkVTU0lPTl9UWVBF
Lg0KPiANCj4+IEBAIC0yNTYsNiArMjYzLDEwIEBAIHR5cGVkZWYgc3RydWN0IFFjb3cyQml0bWFw
SGVhZGVyRXh0IHsNCj4+ICAgICAgIHVpbnQ2NF90IGJpdG1hcF9kaXJlY3Rvcnlfb2Zmc2V0Ow0K
Pj4gICB9IFFFTVVfUEFDS0VEIFFjb3cyQml0bWFwSGVhZGVyRXh0Ow0KPj4gICANCj4+ICt0eXBl
ZGVmIHN0cnVjdCBRY293MkNvbXByZXNzaW9uVHlwZUV4dCB7DQo+PiArICAgIHVpbnQzMl90IGNv
bXByZXNzaW9uX3R5cGU7DQo+PiArfSBRRU1VX1BBQ0tFRCBRY293MkNvbXByZXNzaW9uVHlwZUV4
dDsNCj4+ICsNCj4+ICAgdHlwZWRlZiBzdHJ1Y3QgQkRSVlFjb3cyU3RhdGUgew0KPj4gICAgICAg
aW50IGNsdXN0ZXJfYml0czsNCj4+ICAgICAgIGludCBjbHVzdGVyX3NpemU7DQo+PiBAQCAtMzQw
LDYgKzM1MSwxMyBAQCB0eXBlZGVmIHN0cnVjdCBCRFJWUWNvdzJTdGF0ZSB7DQo+PiAgIA0KPj4g
ICAgICAgQ29RdWV1ZSBjb21wcmVzc193YWl0X3F1ZXVlOw0KPj4gICAgICAgaW50IG5iX2NvbXBy
ZXNzX3RocmVhZHM7DQo+PiArICAgIC8qKg0KPj4gKyAgICAgKiBDb21wcmVzc2lvbiB0eXBlIHVz
ZWQgZm9yIHRoZSBpbWFnZS4gRGVmYXVsdDogMCAtIFpMSUINCj4+ICsgICAgICogVGhlIGltYWdl
IGNvbXByZXNzaW9uIHR5cGUgaXMgc2V0IG9uIGltYWdlIGNyZWF0aW9uLg0KPj4gKyAgICAgKiBU
aGUgb25seSB3YXkgdG8gY2hhbmdlIHRoZSBjb21wcmVzc2lvbiB0eXBlIGlzIHRvIGNvbnZlcnQg
dGhlIGltYWdlDQo+PiArICAgICAqIHdpdGggdGhlIGRlc2lyZWQgY29tcHJlc2lvbiB0eXBlIHNl
dA0KPiANCj4gKmNvbXByZXNzaW9uDQo+IA0KPiBBbmQsIHdlbGwsIGlkZWFsbHkgcWVtdS1pbWcg
YW1lbmQgY291bGQgcGVyZm9ybSB0aGlzIG9wZXJhdGlvbiwgdG9vLg0KPiANCj4gTWF4DQo+IA0K
Pj4gKyAgICAgKi8NCj4+ICsgICAgdWludDMyX3QgY29tcHJlc3Npb25fdHlwZTsNCj4+ICAgfSBC
RFJWUWNvdzJTdGF0ZTsNCj4+ICAgDQo+PiAgIHR5cGVkZWYgc3RydWN0IFFjb3cyQ09XUmVnaW9u
IHsNCj4+DQo+IA0KPiANCg0KLS0gDQpCZXN0LA0KRGVuaXMNCg==

