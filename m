Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D368EC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 14:09:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9113F24F58
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 14:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="C32pbJ9S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9113F24F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35647 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXnem-0002y3-LU
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 10:09:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hXnc0-0008W3-3F
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 10:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hXnNu-000235-Ej
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 09:52:23 -0400
Received: from mail-eopbgr20137.outbound.protection.outlook.com
	([40.107.2.137]:28028
	helo=EUR02-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hXnNs-0001x5-F2; Mon, 03 Jun 2019 09:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=OWosmA4LUk9ofuoCMl1lUnaaXO6HaaGsP4+mUtIPMew=;
	b=C32pbJ9SX5ZIdjoqXZle1PUfLbMkZH6vR+CejnPtG0mIKIEgtjSpS5TCZB6WKB6qRKsKOJegTQbDzuObUXlTHPtPwL6TVS/WUyWSlDFapDilaA+0SC4Ar7++v0RLmEoewzxJkJ03yrkouG9BxSD44mhg+kPEKXb/an8g/Zmt0KU=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
	AM0PR08MB3138.eurprd08.prod.outlook.com (52.134.126.14) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1943.22; Mon, 3 Jun 2019 13:52:17 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8]) by
	AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8%7]) with mapi id 15.20.1943.018;
	Mon, 3 Jun 2019 13:52:17 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH v5 0/3] Fix overflow bug in qcow2 discard
Thread-Index: AQHU+dQTIRtQy84OJ0+wrrxOKT4l3aaKMEYAgAADKgA=
Date: Mon, 3 Jun 2019 13:52:17 +0000
Message-ID: <cf96dd79-14a2-7dcd-62b8-c735c4e055cf@virtuozzo.com>
References: <20190423125706.26989-1-vsementsov@virtuozzo.com>
	<20190603134054.GF6523@linux.fritz.box>
In-Reply-To: <20190603134054.GF6523@linux.fritz.box>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0901CA0064.eurprd09.prod.outlook.com
	(2603:10a6:3:45::32) To AM0PR08MB2961.eurprd08.prod.outlook.com
	(2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190603165214890
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63341083-9eb1-468a-4019-08d6e82ab09c
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:AM0PR08MB3138; 
x-ms-traffictypediagnostic: AM0PR08MB3138:
x-microsoft-antispam-prvs: <AM0PR08MB31385AF97C82CCEF75E4FC30C1140@AM0PR08MB3138.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39850400004)(136003)(376002)(396003)(366004)(346002)(199004)(189003)(86362001)(2906002)(316002)(6916009)(71190400001)(71200400001)(66066001)(256004)(31696002)(8676002)(486006)(99286004)(11346002)(102836004)(8936002)(2616005)(81166006)(81156014)(476003)(68736007)(386003)(26005)(6116002)(3846002)(446003)(6506007)(186003)(54906003)(76176011)(305945005)(7736002)(52116002)(36756003)(6436002)(66946007)(25786009)(6246003)(31686004)(478600001)(66446008)(14454004)(5660300002)(6486002)(4326008)(66476007)(229853002)(6512007)(53936002)(66556008)(73956011)(64756008);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3138;
	H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Tsm6laICwKyRsRm6yolhRmyR23AOUhsINQM/tOsNNsz5gUPTn8i8AcCyvc8r9iJVu3tY8z4s9joQcq29w80sZ6tT1922fikLFL7APbs+LnSNpbFe3wUBglbGTP/ay5zXRG2tL4wVV6Cp2rJIJGCU39B2hP1SFrLj0K/xk4Dn2PlDsPMRbr/XMYBT9zc9tMXIlufzaifkpx4SblLm8FaiwFTlIbFXvBZRZPpSU/tjqRLawYk1/xpn4s215rnv130W5+roJW1s2xK1mh3+GrpTVPlIJE+2nlmwlJpudUPMJF0j0TVYsuO3imrc3+8Eoud8t8HYfoP4mrywqamtFHrnHJkzn+sRRk97qo8/Vrenanh2jApd2cojE+/ngBuA1jX2Cdu9PllHg3wpO0bnNudzgWgd+0tRWMQ6pjV6KITKR5c=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D92751AADEC4F6468F687DCCABDA9B03@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63341083-9eb1-468a-4019-08d6e82ab09c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 13:52:17.2422 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3138
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.137
Subject: Re: [Qemu-devel] [PATCH v5 0/3] Fix overflow bug in qcow2 discard
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
Cc: "fam@euphon.net" <fam@euphon.net>, Denis Lunev <den@virtuozzo.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDMuMDYuMjAxOSAxNjo0MCwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMjMuMDQuMjAxOSB1bSAx
NDo1NyBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IHY1
OiBieSBLZXZpbidzIGNvbW1lbnRzDQo+PiAwMjogYWRkIGNoZWNrIGZvciBpbnZhbGlkIEBieXRl
cyBwYXJhbWV0ZXIsIGRyb3Agci1iDQo+PiAwMzogbW92ZSBmcm9tIHFlbXUtaW1nIGluZm8gdG8g
cWVtdS1pbWcgbWFwIC1mIHJhdywgZHJvcCByLWIgYW5kIHQtYg0KPiANCj4gVGhlIHBhdGNoZXMg
bG9vayBnb29kIHRvIG1lLCBidXQgdGhlIHRlc3QgY2FzZSBmYWlscyAodGhpcyBpcyBvbiBYRlM7
IGl0DQo+IGRvZXMgd29yayBvbiB0bXBmcyk6DQo+IA0KPiAtLS0gL2hvbWUva3dvbGYvc291cmNl
L3FlbXUvdGVzdHMvcWVtdS1pb3Rlc3RzLzI1MC5vdXQgIDIwMTktMDYtMDMgMTU6MjI6NTEuMjEy
OTYxMTIzICswMjAwDQo+ICsrKyAvaG9tZS9rd29sZi9zb3VyY2UvcWVtdS90ZXN0cy9xZW11LWlv
dGVzdHMvMjUwLm91dC5iYWQgICAgICAyMDE5LTA2LTAzIDE1OjM3OjM3LjIwMjk1OTEwMSArMDIw
MA0KPiBAQCAtMTIsMTIgKzEyLDEwIEBADQo+ICAgMCAgICAgICAgICAgICAgIDB4YTAwMDAwICAg
ICAgICAweDgyZjAwMDAwICAgICAgVEVTVF9ESVIvdC5xY293Mg0KPiAgIDB4ODJhMDAwMDAgICAg
ICAweGEwMDAwMCAgICAgICAgMHg1MDAwMDAgICAgICAgIFRFU1RfRElSL3QucWNvdzINCj4gICBP
ZmZzZXQgICAgICAgICAgTGVuZ3RoICAgICAgICAgIE1hcHBlZCB0byAgICAgICBGaWxlDQo+IC0w
ICAgICAgICAgICAgICAgMHgzMDEwMDAgICAgICAgIDAgICAgICAgICAgICAgICBURVNUX0RJUi90
LnFjb3cyDQo+IC0weDQwMDAwMCAgICAgICAgMHhiMDAwMDAgICAgICAgIDB4NDAwMDAwICAgICAg
ICBURVNUX0RJUi90LnFjb3cyDQo+ICswICAgICAgICAgICAgICAgMHhmMDAwMDAgICAgICAgIDAg
ICAgICAgICAgICAgICBURVNUX0RJUi90LnFjb3cyDQo+ICAgMHg4MmYwMDAwMCAgICAgIDB4YTAw
MDAwICAgICAgICAweDgyZjAwMDAwICAgICAgVEVTVF9ESVIvdC5xY293Mg0KPiAgIEltYWdlIHJl
c2l6ZWQuDQo+ICAgT2Zmc2V0ICAgICAgICAgIExlbmd0aCAgICAgICAgICBNYXBwZWQgdG8gICAg
ICAgRmlsZQ0KPiAtMCAgICAgICAgICAgICAgIDB4MzAxMDAwICAgICAgICAwICAgICAgICAgICAg
ICAgVEVTVF9ESVIvdC5xY293Mg0KPiAtMHg0MDAwMDAgICAgICAgIDB4MTAwMDAwICAgICAgICAw
eDQwMDAwMCAgICAgICAgVEVTVF9ESVIvdC5xY293Mg0KPiArMCAgICAgICAgICAgICAgIDB4NTAw
MDAwICAgICAgICAwICAgICAgICAgICAgICAgVEVTVF9ESVIvdC5xY293Mg0KPiAgIDB4ODJmMDAw
MDAgICAgICAweDUwMDAwMCAgICAgICAgMHg4MmYwMDAwMCAgICAgIFRFU1RfRElSL3QucWNvdzIN
Cj4gICAqKiogZG9uZQ0KPiANCj4gSSdsbCBhcHBseSB0aGUgZmlyc3QgdHdvIHBhdGNoZXMgd2l0
aG91dCB0aGUgdGVzdCBmb3Igbm93LCBidXQgcGxlYXNlDQo+IHRyeSBpZiB5b3UgY2FuIHR3ZWFr
IHRoZSB0ZXN0IGNhc2UgdG8gd29yayBvbiBhbGwgY29tbW9uIGZpbGVzeXN0ZW1zLg0KPiANCj4g
S2V2aW4NCj4gDQoNClRoYW5rIHlvdSEgT0ssIEknbGwgdHJ5DQoNCi0tIA0KQmVzdCByZWdhcmRz
LA0KVmxhZGltaXINCg==

