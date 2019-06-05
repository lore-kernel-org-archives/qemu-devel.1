Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FF6C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 14:55:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 741F4206B8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 14:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KxxVY7IP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741F4206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43977 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYXJb-0005am-LY
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 10:54:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1hYX9C-0005uh-50
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:44:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1hYX99-00087c-GB
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:44:13 -0400
Received: from mail-eopbgr00128.outbound.protection.outlook.com
	([40.107.0.128]:1812
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>)
	id 1hYX94-0007Yh-FE; Wed, 05 Jun 2019 10:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=7t04TrhbiCwTZh3BkSOtoIh2z/Cw5CNnQ9fcBHgBXx8=;
	b=KxxVY7IPGP3qVXZF4NXZs9Vxt6WpVzKEwZfdc7Afc4DFdFkg1ZZNBckDQpDGs2kfk+T7hJWdCZLFRL3MPkytDHlzNpJm7cmWh//gJ1OQ+/D0xJ2EbI9CPtFi8Z4PRyWCwSm+5/tSJy3praorcLGBieNeauW9ndaA5p+NBoqWz/4=
Received: from DBBPR08MB4250.eurprd08.prod.outlook.com (20.179.40.149) by
	DBBPR08MB4332.eurprd08.prod.outlook.com (20.179.41.206) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1965.13; Wed, 5 Jun 2019 14:43:59 +0000
Received: from DBBPR08MB4250.eurprd08.prod.outlook.com
	([fe80::fcca:9f3e:dbc6:5a1f]) by
	DBBPR08MB4250.eurprd08.prod.outlook.com
	([fe80::fcca:9f3e:dbc6:5a1f%4]) with mapi id 15.20.1943.018;
	Wed, 5 Jun 2019 14:43:59 +0000
From: "Denis V. Lunev" <den@openvz.org>
To: Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy
	<vsementsov@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH 2/2] nbd-client: enable TCP keepalive
Thread-Index: AQHVG4a/lcghbcFVAUyMliejkoc596aNIdEAgAABV4A=
Date: Wed, 5 Jun 2019 14:43:59 +0000
Message-ID: <9f2d9816-3539-666e-8ed7-5e4d95e9ba56@openvz.org>
References: <20190605100913.34972-1-vsementsov@virtuozzo.com>
	<20190605100913.34972-3-vsementsov@virtuozzo.com>
	<cd780b66-ab31-1feb-0cce-0b6525df7d79@redhat.com>
In-Reply-To: <cd780b66-ab31-1feb-0cce-0b6525df7d79@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P192CA0010.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::20)
	To DBBPR08MB4250.eurprd08.prod.outlook.com
	(2603:10a6:10:c2::21)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=den@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40d2b227-5437-4ac1-0471-08d6e9c43ebc
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:DBBPR08MB4332; 
x-ms-traffictypediagnostic: DBBPR08MB4332:
x-microsoft-antispam-prvs: <DBBPR08MB433257ED2DDA7BFA5E6E58A0B6160@DBBPR08MB4332.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:107;
x-forefront-prvs: 00594E8DBA
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(136003)(39850400004)(346002)(376002)(396003)(199004)(189003)(99286004)(102836004)(316002)(31686004)(3846002)(6116002)(386003)(53546011)(42882007)(6506007)(6246003)(256004)(26005)(14444005)(54906003)(110136005)(186003)(2501003)(52116002)(53936002)(76176011)(25786009)(4326008)(2616005)(66066001)(64756008)(66446008)(73956011)(66946007)(14454004)(6436002)(68736007)(229853002)(66556008)(478600001)(66476007)(2201001)(6512007)(31696002)(6486002)(5660300002)(8936002)(71190400001)(71200400001)(305945005)(7736002)(81156014)(81166006)(446003)(8676002)(11346002)(476003)(36756003)(486006)(2906002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4332;
	H:DBBPR08MB4250.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TPTXyrOW+BWWMOXTjgRF+kdzyByv7MLJc0rnxtuMF6b46lG1w+wKtkLxgdCmDFCYqyA9LnN1u3KQU8PuRm8ndEE2M1FXvZLxMpc57RNFWBHtEYYHwRgDV0+NeqKGObPSf2cHXFXEDjfDFg9KEMoGig3ZM7qKwe5nC8lcLaTc8B7H88uxceMybgK+aVKUIno3vscghARk2MTAOWMzHU1wn7b05OIoRpbDmKwUA/7cJLsy0+j0zT+Atk/RVJzO+xj7+3L1UNz9/C34BOFuL8tciWJr2gBMWVsxE0hruipEkXPw0pYUB8XR0DqbUCGRIL5eqoL3aMDEnzXX5FSb+q6B/ZegSRoCfIE/9j4JJW6gixxFSUI40YBlKV5xxkVwrA99RE+pQQU414go0Jvcq2ZBL4VoBScT81d6ut6Bfww/BX8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82941F5A934CC140A0B60B3FA62C41F9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d2b227-5437-4ac1-0471-08d6e9c43ebc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2019 14:43:59.7143 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: den@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4332
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.128
Subject: Re: [Qemu-devel] [PATCH 2/2] nbd-client: enable TCP keepalive
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
	"berrange@redhat.com" <berrange@redhat.com>,
	"mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gNi81LzE5IDU6MzkgUE0sIEVyaWMgQmxha2Ugd3JvdGU6DQo+IE9uIDYvNS8xOSA1OjA5IEFN
LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gRW5hYmxlIGtlZXBhbGl2
ZSBvcHRpb24gdG8gdHJhY2sgc2VydmVyIGF2YWlsYWJsaXR5Lg0KPiBzL2F2YWlsYWJsaXR5L2F2
YWlsYWJpbGl0eS8NCj4NCj4gRG8gd2Ugd2FudCB0aGlzIHVuY29uZGl0aW9uYWxseSwgb3Igc2hv
dWxkIGl0IGJlIGFuIG9wdGlvbiAoYW5kIGhlbmNlDQo+IGV4cG9zZWQgb3ZlciBRTVApPw0KVGhh
dCBpcyBnb29kIHF1ZXN0aW9uLCBpZiB3ZSB3b3VsZCBleHBvc2UgaXQsIHdlIHNob3VsZCBzcGVj
aWZ5DQp0aW1lb3V0IGR1cmF0aW9uIGFzIGFuIG9wdGlvbi4gVGhvdWdoIElNSE8gaXQgd291bGQg
YmUgc2FmZQ0KdG8gZ2V0IHRoaXMgdW5jb25kaXRpb25hbC4NCg0KDQo+PiBSZXF1ZXN0ZWQtYnk6
IERlbmlzIFYuIEx1bmV2IDxkZW5Ab3BlbnZ6Lm9yZz4NCj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRp
bWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+IC0t
LQ0KPj4gIGJsb2NrL25iZC1jbGllbnQuYyB8IDEgKw0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ibG9jay9uYmQtY2xpZW50LmMgYi9ibG9j
ay9uYmQtY2xpZW50LmMNCj4+IGluZGV4IDc5MGVjYzFlZTEuLmI1N2NlYTg0ODIgMTAwNjQ0DQo+
PiAtLS0gYS9ibG9jay9uYmQtY2xpZW50LmMNCj4+ICsrKyBiL2Jsb2NrL25iZC1jbGllbnQuYw0K
Pj4gQEAgLTExMzcsNiArMTEzNyw3IEBAIHN0YXRpYyBpbnQgbmJkX2NsaWVudF9jb25uZWN0KEJs
b2NrRHJpdmVyU3RhdGUgKmJzLA0KPj4gIA0KPj4gICAgICAvKiBOQkQgaGFuZHNoYWtlICovDQo+
PiAgICAgIGxvZ291dCgic2Vzc2lvbiBpbml0ICVzXG4iLCBleHBvcnQpOw0KPj4gKyAgICBxaW9f
Y2hhbm5lbF9zZXRfa2VlcGFsaXZlKFFJT19DSEFOTkVMKHNpb2MpLCB0cnVlLCBOVUxMKTsNCj4+
ICAgICAgcWlvX2NoYW5uZWxfc2V0X2Jsb2NraW5nKFFJT19DSEFOTkVMKHNpb2MpLCB0cnVlLCBO
VUxMKTsNCj4+ICANCj4+ICAgICAgY2xpZW50LT5pbmZvLnJlcXVlc3Rfc2l6ZXMgPSB0cnVlOw0K
Pj4NCg0K

