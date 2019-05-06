Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC117C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 11:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85F1720675
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 11:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KQQqSOAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F1720675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55002 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNc6l-0004Rt-QQ
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 07:48:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hNc5h-00043l-Gq
	for qemu-devel@nongnu.org; Mon, 06 May 2019 07:47:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hNc5e-0005rE-NN
	for qemu-devel@nongnu.org; Mon, 06 May 2019 07:47:28 -0400
Received: from mail-eopbgr90092.outbound.protection.outlook.com
	([40.107.9.92]:14400
	helo=FRA01-MR2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hNc5c-0005o3-TT; Mon, 06 May 2019 07:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=IwulMnicOvwS9/6umMkTJAgYZN4N6pMc8lU+rUgPxXk=;
	b=KQQqSOAWkexL1zBNuJXuT4GXxzZXsV2tTXB2uZzUZOHeYobhtetvrpICANDUQtZjfzAgogITBi5+Kj7WGVDulCQj+Fb0Bu36WYQdTUrU46Rnu88d6vSWF/nx0YP2ifK5CzFbzTHdveUgnKc3lCOMjybK9IRCpInPoKh5tRxvs7o=
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com (52.133.109.209) by
	PR2PR08MB4716.eurprd08.prod.outlook.com (52.133.111.82) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1856.11; Mon, 6 May 2019 11:47:17 +0000
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::9c35:2e89:30c4:5cc4]) by
	PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::9c35:2e89:30c4:5cc4%3]) with mapi id 15.20.1856.012;
	Mon, 6 May 2019 11:47:17 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Eric Blake <eblake@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH v5 2/3] block/io: bdrv_pdiscard: support
	int64_t bytes parameter
Thread-Index: AQHU+dQTJjmZ8S/hNEmSdHPIyBb8w6ZUeWeAgAAKwACAABJ/AIAAS+wAgAK38QCABnS5AA==
Date: Mon, 6 May 2019 11:47:17 +0000
Message-ID: <91794835-af65-73cf-d02c-1f7d82afb0d9@virtuozzo.com>
References: <20190423125706.26989-1-vsementsov@virtuozzo.com>
	<20190423125706.26989-3-vsementsov@virtuozzo.com>
	<20190430092437.jbecehdkqa4zdavd@steredhat>
	<4dabb261-f2d1-b6e0-8d97-ace159b87a54@virtuozzo.com>
	<20190430110918.GF5607@linux.fritz.box>
	<2c8b3197-316d-7215-9284-6f1e986a0803@redhat.com>
	<20190502091154.y34h7qvm6ubta632@steredhat>
In-Reply-To: <20190502091154.y34h7qvm6ubta632@steredhat>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0025.eurprd05.prod.outlook.com
	(2603:10a6:3:1a::35) To PR2PR08MB4684.eurprd08.prod.outlook.com
	(2603:10a6:101:22::17)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190506144714895
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca98b6fb-0cf8-413e-7044-08d6d21896d6
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:PR2PR08MB4716; 
x-ms-traffictypediagnostic: PR2PR08MB4716:
x-microsoft-antispam-prvs: <PR2PR08MB47168D83F5D23B1253F2956CC1300@PR2PR08MB4716.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(39840400004)(396003)(366004)(136003)(376002)(199004)(189003)(2906002)(66066001)(4326008)(52116002)(26005)(99286004)(76176011)(36756003)(102836004)(7736002)(71190400001)(305945005)(6116002)(71200400001)(3846002)(68736007)(6512007)(53936002)(5660300002)(186003)(54906003)(66446008)(81166006)(6246003)(11346002)(476003)(14444005)(86362001)(66946007)(256004)(8676002)(6486002)(486006)(31696002)(31686004)(73956011)(66476007)(478600001)(2616005)(316002)(66556008)(64756008)(81156014)(110136005)(8936002)(386003)(6506007)(229853002)(53546011)(14454004)(6436002)(25786009)(446003)(561944003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:PR2PR08MB4716;
	H:PR2PR08MB4684.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: l9TD2LDH/PELkdQ9b4uYiU9i5w5Jspz4yt9c5604fckjXtiR9CV88Pfx3abiTmcLGcghg/AAVjm0WFJjTCrMpCdhiIFi4T7bm7+NjCjTcMkVMeNKUQy3yFBuz5QoPFx8NkzdpeF1eb1aCRcIuACDPx9HwTpjej7Fx2+wTLOeRO4nEiNc6LK3Nrxzv4Aa3WX7bQ/Esa3cCp6SN3txzQ7hGzZ8wtuz1k1oRiCf2X7Nzsw/tdEJ53sOxNis5SV90vfU3mACZGMmfN+U1AKrQmwvqYD2HFCwzgDHxXEIjrNyIPIukQbFDHi194uOy04bY18QyMjvKdi6zuGspIvryNmVwUVwdUAtMXvwx5cygTu7INF79IXAKhb8IS52VE+1raYQPA9tXwHx013odkNuTxW3ZoaWNne1lRKAqKCQZYBatIY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBEF466D96DDB74A843EEE5432A7D7F4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca98b6fb-0cf8-413e-7044-08d6d21896d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 11:47:17.3759 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4716
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.9.92
Subject: Re: [Qemu-devel] [PATCH v5 2/3] block/io: bdrv_pdiscard: support
 int64_t bytes parameter
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
Cc: Kevin Wolf <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
	Denis Lunev <den@virtuozzo.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDIuMDUuMjAxOSAxMjoxMSwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOg0KPiBPbiBUdWUsIEFw
ciAzMCwgMjAxOSBhdCAxMDo0MTowMkFNIC0wNTAwLCBFcmljIEJsYWtlIHdyb3RlOg0KPj4gT24g
NC8zMC8xOSA2OjA5IEFNLCBLZXZpbiBXb2xmIHdyb3RlOg0KPj4+IEFtIDMwLjA0LjIwMTkgdW0g
MTI6MDMgaGF0IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgZ2VzY2hyaWViZW46DQo+Pj4+
IDMwLjA0LjIwMTkgMTI6MjQsIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToNCj4+Pj4+IE9uIFR1
ZSwgQXByIDIzLCAyMDE5IGF0IDAzOjU3OjA1UE0gKzAzMDAsIFZsYWRpbWlyIFNlbWVudHNvdi1P
Z2lldnNraXkgd3JvdGU6DQo+Pj4+Pj4gVGhpcyBmaXhlcyBhdCBsZWFzdCBvbmUgb3ZlcmZsb3cg
aW4gcWNvdzJfcHJvY2Vzc19kaXNjYXJkcywgd2hpY2gNCj4+Pj4+PiBwYXNzZXMgNjRiaXQgcmVn
aW9uIGxlbmd0aCB0byBiZHJ2X3BkaXNjYXJkIHdoZXJlIGJ5dGVzIChvciBzZWN0b3JzIGluDQo+
Pj4+Pj4gdGhlIHBhc3QpIHBhcmFtZXRlciBpcyBpbnQgc2luY2UgaXRzIGludHJvZHVjdGlvbiBp
biAwYjkxOWZhZS4NCj4+Pj4+Pg0KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVu
dHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+DQo+Pj4+Pj4gLSAg
ICBpZiAoIWJzIHx8ICFicy0+ZHJ2KSB7DQo+Pj4+Pj4gKyAgICBpZiAoIWJzIHx8ICFicy0+ZHJ2
IHx8ICFiZHJ2X2lzX2luc2VydGVkKGJzKSkgew0KPj4+Pj4NCj4+Pj4+IFNob3VsZCB3ZSBkZXNj
cmliZSB0aGlzIGNoYW5nZSBpbiB0aGUgY29tbWl0IG1lc3NhZ2U/DQo+Pj4+DQo+Pj4+IEhvbmVz
dGx5LCBkb24ndCB3YW50IHRvIHJlc2VuZCB0aGUgc2VyaWVzIGZvciB0aGlzLg0KPj4+DQo+Pj4g
SSBoYXZlbid0IHJldmlld2VkIHRoZSBwYXRjaGVzIHlldCwgYnV0IGlmIHRoaXMgcmVtYWlucyB0
aGUgb25seSB0aGluZw0KPj4+IHRvIGNoYW5nZSwgaXQgY2FuIGJlIHVwZGF0ZWQgd2hpbGUgYXBw
bHlpbmcgdGhlIHNlcmllcyBpZiB3ZSBoYXZlIGENCj4+PiBzcGVjaWZpYyBwcm9wb3NhbCBmb3Ig
YSBuZXcgY29tbWl0IG1lc3NhZ2UuDQo+Pg0KPj4gSG93IGFib3V0Og0KPj4NCj4+IFRoaXMgZml4
ZXMgYXQgbGVhc3Qgb25lIG92ZXJmbG93IGluIHFjb3cyX3Byb2Nlc3NfZGlzY2FyZHMsIHdoaWNo
IHdhcw0KPj4gaW5hZHZlcnRlbnRseSB0cnVuY2F0aW5nIGEgNjQtYml0IHJlZ2lvbiBsZW5ndGgg
dG8gdGhlIGJkcnZfcGRpc2NhcmQNCj4+ICdpbnQgYnl0ZXMnIHBhcmFtZXRlciAocHJldmlvdXNs
eSBiZHJ2X2Rpc2NhcmQncyAnaW50IHNlY3RvcnMnKSBzaW5jZQ0KPj4gaXRzIGludHJvZHVjdGlv
biBpbiAwYjkxOWZhZS4NCj4+DQo+PiBCeSBpbmxpbmluZyB0aGUgcmVtYWluaW5nIHBvcnRpb25z
IG9mIGJkcnZfY2hlY2tfYnl0ZV9yZXF1ZXN0KCkgdGhhdCBhcmUNCj4+IHN0aWxsIGluZGVwZW5k
ZW50IGZyb20gdGhlIGNvZGUgcHJldmlvdXNseSB2YWxpZGF0aW5nIGEgMzItYml0IHJlcXVlc3Qs
DQo+PiB3ZSBjYW4gZHJvcCB0aGUgY2FsbCB0byB0aGF0IGZ1bmN0aW9uLiBBIHJlcXVlc3QgbGFy
Z2VyIHRoYW4gMzEgYml0cyAob3INCj4+IHRoZSBkcml2ZXIncyBtYXggZGlzY2FyZCBsaW1pdCwg
aWYgc3BlY2lmaWVkKSBpcyBzdGlsbCBzcGxpdCBpbnRvDQo+PiBzbWFsbGVyIGNodW5rcyBieSB0
aGUgYmxvY2sgbGF5ZXIgYmVmb3JlIHJlYWNoaW5nIHRoZSBkcml2ZXIuDQo+Pg0KPiANCj4gVGhh
dCBzb3VuZHMgZ29vZCB0byBtZSENCj4gDQoNCkFuZCBmb3IgbWUuIFRoYW5rIHlvdSwgRXJpYyEN
Cg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

