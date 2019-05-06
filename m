Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9B1C04AAD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 16:53:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CD6B205ED
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 16:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ErkMgVOX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CD6B205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59387 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNgsI-0005N9-5X
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 12:53:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hNgr4-0004p9-96
	for qemu-devel@nongnu.org; Mon, 06 May 2019 12:52:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hNgr2-0004Vt-5N
	for qemu-devel@nongnu.org; Mon, 06 May 2019 12:52:42 -0400
Received: from mail-eopbgr120129.outbound.protection.outlook.com
	([40.107.12.129]:6123
	helo=FRA01-PR2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hNgqy-0004Sp-Bq; Mon, 06 May 2019 12:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=uarGaMVNgrTIuyATSPG+/o5RNnzpaGULALVfdjbMPhI=;
	b=ErkMgVOXlRK0G1SXgRD5xHDTwgpeaCRmGq8Y4gMwDoCeF4kgA9+pIEJ0errs3xlNzVye+0/SX/1kpnmMI+i3dpcDSWnQcE63GhOhzPNjOSmd+NjfeydfrsCII3FeWsZzZa1gSKFDkc4fwmHhjEUX6bUszjjvps3aHUd7vdyo/nI=
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com (52.133.109.209) by
	PR2PR08MB4923.eurprd08.prod.outlook.com (52.133.110.83) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1856.11; Mon, 6 May 2019 16:52:34 +0000
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::9c35:2e89:30c4:5cc4]) by
	PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::9c35:2e89:30c4:5cc4%3]) with mapi id 15.20.1856.012;
	Mon, 6 May 2019 16:52:34 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v2 4/5] block: Remove bdrv_read() and
	bdrv_write()
Thread-Index: AQHVAEn2p6Cuq7Sev0umn1aw75xM+qZeV5yA
Date: Mon, 6 May 2019 16:52:34 +0000
Message-ID: <9a0b51c5-ed6d-cc83-2198-91f3548f1c5e@virtuozzo.com>
References: <cover.1556732434.git.berto@igalia.com>
	<39b2f01f936e47e24a28657c00a1110b5df6111e.1556732434.git.berto@igalia.com>
In-Reply-To: <39b2f01f936e47e24a28657c00a1110b5df6111e.1556732434.git.berto@igalia.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0089.eurprd09.prod.outlook.com
	(2603:10a6:7:3d::33) To PR2PR08MB4684.eurprd08.prod.outlook.com
	(2603:10a6:101:22::17)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190506195231823
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad39a098-8303-4114-3c27-08d6d2433c7b
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:PR2PR08MB4923; 
x-ms-traffictypediagnostic: PR2PR08MB4923:
x-microsoft-antispam-prvs: <PR2PR08MB4923797326CF3364D3DC2A77C1300@PR2PR08MB4923.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:409;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(396003)(346002)(366004)(39840400004)(376002)(199004)(189003)(2906002)(102836004)(99286004)(6506007)(386003)(5660300002)(66066001)(86362001)(486006)(2501003)(305945005)(52116002)(31696002)(6116002)(76176011)(3846002)(68736007)(14454004)(31686004)(6436002)(53936002)(7736002)(6486002)(25786009)(6246003)(66946007)(66476007)(66556008)(64756008)(66446008)(73956011)(229853002)(478600001)(4326008)(186003)(316002)(14444005)(256004)(36756003)(26005)(446003)(476003)(2616005)(54906003)(6512007)(71190400001)(110136005)(8936002)(11346002)(71200400001)(8676002)(81156014)(81166006);
	DIR:OUT; SFP:1102; SCL:1; SRVR:PR2PR08MB4923;
	H:PR2PR08MB4684.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LVp7Nl+8SjiYpMGUeUTbceYm9cxvgvPVUBVdpVfIsjDkQImNmCU99jP3RMb6St61PvdAwvhGc3m+acHabBvyavvGMGHqlO9vLmn7Ci143zeiF1Ed28qtJCw8vmzV8fGFDjdpZaExp3RDC6MaP9Cn3tpKp80CM26cE4Q03KWaChAUJvlSvSZOPdYu8KMAhrKjWiNDW4mYLYGKTnceSOnDRZ0S+eZQXY9GVD9BeMt4i2bvYSI9Vfl/2ooym2kxLGsxUkUPVTw6nMn2iSeXY2z1WPZf0gAMH5Ff8o/tfh8JHw83kmZrdz42qlzoyLNDbvE1az+2KqdgJjiEuHD8Od5JRUXeJlheLEhZR0D6o4ywxgO1EhLlka9hQmrRazQ0FwRSabkmQKXl0zy+PjKq5rWYrge6apLi5lAMyBzfKHn5RjA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3672AE1199BAC428FD3CED9032123A9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad39a098-8303-4114-3c27-08d6d2433c7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 16:52:34.2197 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4923
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.12.129
Subject: Re: [Qemu-devel] [PATCH v2 4/5] block: Remove bdrv_read() and
 bdrv_write()
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
Cc: Kevin Wolf <kwolf@redhat.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMDUuMjAxOSAyMToxMywgQWxiZXJ0byBHYXJjaWEgd3JvdGU6DQo+IE5vIG9uZSBpcyB1c2lu
ZyB0aGVzZSBmdW5jdGlvbnMgYW55bW9yZSwgYWxsIGNhbGxlcnMgaGF2ZSBzd2l0Y2hlZCB0bw0K
PiB0aGUgYnl0ZS1iYXNlZCBiZHJ2X3ByZWFkKCkgYW5kIGJkcnZfcHdyaXRlKCkNCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IEFsYmVydG8gR2FyY2lhIDxiZXJ0b0BpZ2FsaWEuY29tPg0KDQpSZXZpZXdl
ZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8u
Y29tPg0KDQpIb3dldmVyLCBJIGRvdWJ0IHRoYXQgd2Ugd2FudCB0byBzYXZlIGVycm9yIGNvZGVz
IGRlc2NyaXB0aW9ucy4gT24NCnRoZSBvdGhlciBoYW5kLCAiUmV0dXJuIG5vLiBvZiBieXRlcyBv
biBzdWNjZXNzIG9yIDwgMCBvbiBlcnJvci4iIGlzIGdvb2QNCmFkZGl0aW9uLCBidXQgaXQgYmVj
b21lcyB1bnJlbGF0ZWQgdG8gdGhpcyBwYXRjaCBpZiBkcm9wIGVycm9yIGNvZGVzDQpkZXNjcmlw
dGlvbi4NCg0KPiAtLS0NCj4gICBibG9jay9pby5jICAgICAgICAgICAgfCA0MyArKysrKysrLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgaW5jbHVkZS9ibG9jay9ibG9j
ay5oIHwgIDQgLS0tLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA0MCBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ibG9jay9pby5jIGIvYmxvY2svaW8uYw0K
PiBpbmRleCBkZmMxNTNiOGQ4Li4zOTZkNTM2NGJhIDEwMDY0NA0KPiAtLS0gYS9ibG9jay9pby5j
DQo+ICsrKyBiL2Jsb2NrL2lvLmMNCj4gQEAgLTgzNyw0MiArODM3LDYgQEAgc3RhdGljIGludCBi
ZHJ2X3Byd3ZfY28oQmRydkNoaWxkICpjaGlsZCwgaW50NjRfdCBvZmZzZXQsDQo+ICAgICAgIHJl
dHVybiByd2NvLnJldDsNCj4gICB9DQo+ICAgDQo+IC0vKg0KPiAtICogUHJvY2VzcyBhIHN5bmNo
cm9ub3VzIHJlcXVlc3QgdXNpbmcgY29yb3V0aW5lcw0KPiAtICovDQo+IC1zdGF0aWMgaW50IGJk
cnZfcndfY28oQmRydkNoaWxkICpjaGlsZCwgaW50NjRfdCBzZWN0b3JfbnVtLCB1aW50OF90ICpi
dWYsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgaW50IG5iX3NlY3RvcnMsIGJvb2wgaXNfd3Jp
dGUsIEJkcnZSZXF1ZXN0RmxhZ3MgZmxhZ3MpDQo+IC17DQo+IC0gICAgUUVNVUlPVmVjdG9yIHFp
b3YgPSBRRU1VX0lPVkVDX0lOSVRfQlVGKHFpb3YsIGJ1ZiwNCj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgbmJfc2VjdG9ycyAqIEJEUlZfU0VDVE9SX1NJWkUp
Ow0KPiAtDQo+IC0gICAgaWYgKG5iX3NlY3RvcnMgPCAwIHx8IG5iX3NlY3RvcnMgPiBCRFJWX1JF
UVVFU1RfTUFYX1NFQ1RPUlMpIHsNCj4gLSAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+IC0gICAg
fQ0KPiAtDQo+IC0gICAgcmV0dXJuIGJkcnZfcHJ3dl9jbyhjaGlsZCwgc2VjdG9yX251bSA8PCBC
RFJWX1NFQ1RPUl9CSVRTLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgJnFpb3YsIGlzX3dy
aXRlLCBmbGFncyk7DQo+IC19DQo+IC0NCj4gLS8qIHJldHVybiA8IDAgaWYgZXJyb3IuIFNlZSBi
ZHJ2X3dyaXRlKCkgZm9yIHRoZSByZXR1cm4gY29kZXMgKi8NCj4gLWludCBiZHJ2X3JlYWQoQmRy
dkNoaWxkICpjaGlsZCwgaW50NjRfdCBzZWN0b3JfbnVtLA0KPiAtICAgICAgICAgICAgICB1aW50
OF90ICpidWYsIGludCBuYl9zZWN0b3JzKQ0KPiAtew0KPiAtICAgIHJldHVybiBiZHJ2X3J3X2Nv
KGNoaWxkLCBzZWN0b3JfbnVtLCBidWYsIG5iX3NlY3RvcnMsIGZhbHNlLCAwKTsNCj4gLX0NCj4g
LQ0KPiAtLyogUmV0dXJuIDwgMCBpZiBlcnJvci4gSW1wb3J0YW50IGVycm9ycyBhcmU6DQo+IC0g
IC1FSU8gICAgICAgICBnZW5lcmljIEkvTyBlcnJvciAobWF5IGhhcHBlbiBmb3IgYWxsIGVycm9y
cykNCj4gLSAgLUVOT01FRElVTSAgIE5vIG1lZGlhIGluc2VydGVkLg0KPiAtICAtRUlOVkFMICAg
ICAgSW52YWxpZCBzZWN0b3IgbnVtYmVyIG9yIG5iX3NlY3RvcnMNCj4gLSAgLUVBQ0NFUyAgICAg
IFRyeWluZyB0byB3cml0ZSBhIHJlYWQtb25seSBkZXZpY2UNCj4gLSovDQo+IC1pbnQgYmRydl93
cml0ZShCZHJ2Q2hpbGQgKmNoaWxkLCBpbnQ2NF90IHNlY3Rvcl9udW0sDQo+IC0gICAgICAgICAg
ICAgICBjb25zdCB1aW50OF90ICpidWYsIGludCBuYl9zZWN0b3JzKQ0KPiAtew0KPiAtICAgIHJl
dHVybiBiZHJ2X3J3X2NvKGNoaWxkLCBzZWN0b3JfbnVtLCAodWludDhfdCAqKWJ1ZiwgbmJfc2Vj
dG9ycywgdHJ1ZSwgMCk7DQo+IC19DQo+IC0NCj4gICBpbnQgYmRydl9wd3JpdGVfemVyb2VzKEJk
cnZDaGlsZCAqY2hpbGQsIGludDY0X3Qgb2Zmc2V0LA0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgaW50IGJ5dGVzLCBCZHJ2UmVxdWVzdEZsYWdzIGZsYWdzKQ0KPiAgIHsNCj4gQEAgLTkzNSw2
ICs4OTksNyBAQCBpbnQgYmRydl9wcmVhZHYoQmRydkNoaWxkICpjaGlsZCwgaW50NjRfdCBvZmZz
ZXQsIFFFTVVJT1ZlY3RvciAqcWlvdikNCj4gICAgICAgcmV0dXJuIHFpb3YtPnNpemU7DQo+ICAg
fQ0KPiAgIA0KPiArLyogU2VlIGJkcnZfcHdyaXRlKCkgZm9yIHRoZSByZXR1cm4gY29kZXMgKi8N
Cj4gICBpbnQgYmRydl9wcmVhZChCZHJ2Q2hpbGQgKmNoaWxkLCBpbnQ2NF90IG9mZnNldCwgdm9p
ZCAqYnVmLCBpbnQgYnl0ZXMpDQo+ICAgew0KPiAgICAgICBRRU1VSU9WZWN0b3IgcWlvdiA9IFFF
TVVfSU9WRUNfSU5JVF9CVUYocWlvdiwgYnVmLCBieXRlcyk7DQo+IEBAIC05NTgsNiArOTIzLDEy
IEBAIGludCBiZHJ2X3B3cml0ZXYoQmRydkNoaWxkICpjaGlsZCwgaW50NjRfdCBvZmZzZXQsIFFF
TVVJT1ZlY3RvciAqcWlvdikNCj4gICAgICAgcmV0dXJuIHFpb3YtPnNpemU7DQo+ICAgfQ0KPiAg
IA0KPiArLyogUmV0dXJuIG5vLiBvZiBieXRlcyBvbiBzdWNjZXNzIG9yIDwgMCBvbiBlcnJvci4g
SW1wb3J0YW50IGVycm9ycyBhcmU6DQo+ICsgIC1FSU8gICAgICAgICBnZW5lcmljIEkvTyBlcnJv
ciAobWF5IGhhcHBlbiBmb3IgYWxsIGVycm9ycykNCj4gKyAgLUVOT01FRElVTSAgIE5vIG1lZGlh
IGluc2VydGVkLg0KPiArICAtRUlOVkFMICAgICAgSW52YWxpZCBvZmZzZXQgb3IgbnVtYmVyIG9m
IGJ5dGVzDQo+ICsgIC1FQUNDRVMgICAgICBUcnlpbmcgdG8gd3JpdGUgYSByZWFkLW9ubHkgZGV2
aWNlDQo+ICsqLw0KPiAgIGludCBiZHJ2X3B3cml0ZShCZHJ2Q2hpbGQgKmNoaWxkLCBpbnQ2NF90
IG9mZnNldCwgY29uc3Qgdm9pZCAqYnVmLCBpbnQgYnl0ZXMpDQo+ICAgew0KPiAgICAgICBRRU1V
SU9WZWN0b3IgcWlvdiA9IFFFTVVfSU9WRUNfSU5JVF9CVUYocWlvdiwgYnVmLCBieXRlcyk7DQo+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2Jsb2NrL2Jsb2NrLmggYi9pbmNsdWRlL2Jsb2NrL2Jsb2Nr
LmgNCj4gaW5kZXggYzdhMjYxOTlhYS4uNWUyYjk4YjBlZSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVk
ZS9ibG9jay9ibG9jay5oDQo+ICsrKyBiL2luY2x1ZGUvYmxvY2svYmxvY2suaA0KPiBAQCAtMzE2
LDEwICszMTYsNiBAQCBpbnQgYmRydl9yZW9wZW5fcHJlcGFyZShCRFJWUmVvcGVuU3RhdGUgKnJl
b3Blbl9zdGF0ZSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICBCbG9ja1Jlb3BlblF1ZXVl
ICpxdWV1ZSwgRXJyb3IgKiplcnJwKTsNCj4gICB2b2lkIGJkcnZfcmVvcGVuX2NvbW1pdChCRFJW
UmVvcGVuU3RhdGUgKnJlb3Blbl9zdGF0ZSk7DQo+ICAgdm9pZCBiZHJ2X3Jlb3Blbl9hYm9ydChC
RFJWUmVvcGVuU3RhdGUgKnJlb3Blbl9zdGF0ZSk7DQo+IC1pbnQgYmRydl9yZWFkKEJkcnZDaGls
ZCAqY2hpbGQsIGludDY0X3Qgc2VjdG9yX251bSwNCj4gLSAgICAgICAgICAgICAgdWludDhfdCAq
YnVmLCBpbnQgbmJfc2VjdG9ycyk7DQo+IC1pbnQgYmRydl93cml0ZShCZHJ2Q2hpbGQgKmNoaWxk
LCBpbnQ2NF90IHNlY3Rvcl9udW0sDQo+IC0gICAgICAgICAgICAgICBjb25zdCB1aW50OF90ICpi
dWYsIGludCBuYl9zZWN0b3JzKTsNCj4gICBpbnQgYmRydl9wd3JpdGVfemVyb2VzKEJkcnZDaGls
ZCAqY2hpbGQsIGludDY0X3Qgb2Zmc2V0LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgaW50
IGJ5dGVzLCBCZHJ2UmVxdWVzdEZsYWdzIGZsYWdzKTsNCj4gICBpbnQgYmRydl9tYWtlX3plcm8o
QmRydkNoaWxkICpjaGlsZCwgQmRydlJlcXVlc3RGbGFncyBmbGFncyk7DQo+IA0KDQoNCi0tIA0K
QmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

