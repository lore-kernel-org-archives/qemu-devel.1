Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FA7C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 15:25:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FFAF2080C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 15:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="g/7zv8LC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FFAF2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33060 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfnJg-0001cX-QC
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 11:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55512)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hfn2r-0001A3-Cp
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hfn2p-0005Pw-FO
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:07:41 -0400
Received: from mail-eopbgr80117.outbound.protection.outlook.com
 ([40.107.8.117]:27916 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hfn2j-00051o-Pp; Tue, 25 Jun 2019 11:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jo+sV8kpg1FeHKLp3d8WAL4aFMw6HqigHetz/HGIkLY=;
 b=g/7zv8LCthD9mo/HWkJbVC1W7dcUkfE6DE0lLQWjvNcUg8K5G0sMtFMnvFLPXehEmJQPcHPJty4CzuQJJD7rS0F1r0/+uJIIjWIFFzQNjjJ6/VY1A+yXmMhDFB+cl20RfSn5GjunqIl4K+fKq3yyTAULsQI/67ZxU4CDm3QCsLk=
Received: from VI1PR08MB3677.eurprd08.prod.outlook.com (20.177.61.92) by
 VI1PR08MB2878.eurprd08.prod.outlook.com (10.170.239.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 15:07:17 +0000
Received: from VI1PR08MB3677.eurprd08.prod.outlook.com
 ([fe80::4c71:9c23:235b:fbed]) by VI1PR08MB3677.eurprd08.prod.outlook.com
 ([fe80::4c71:9c23:235b:fbed%3]) with mapi id 15.20.2008.014; Tue, 25 Jun 2019
 15:07:17 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v7 0/3] block/stream: get rid of the base
Thread-Index: AQHVJtVTk86p5LXvIUyhwnd3Wk/TrKasrG4A///UFYCAAAEogA==
Date: Tue, 25 Jun 2019 15:07:17 +0000
Message-ID: <60312237-b69e-6248-f2ea-8f260018e3af@virtuozzo.com>
References: <1559152576-281803-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <87a5ec62-6274-77c6-60a3-b4ad7b4ec822@redhat.com>
 <3362e8ef-d698-e860-9830-45a3f924ef48@virtuozzo.com>
 <a63c700d-8206-06c5-ee5e-70d0534dd147@redhat.com>
In-Reply-To: <a63c700d-8206-06c5-ee5e-70d0534dd147@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0069.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::13) To VI1PR08MB3677.eurprd08.prod.outlook.com
 (2603:10a6:803:85::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3edd0139-5a8b-4023-f1d4-08d6f97ed001
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB2878; 
x-ms-traffictypediagnostic: VI1PR08MB2878:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR08MB28786491A2D4B876CA253169F4E30@VI1PR08MB2878.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(396003)(136003)(346002)(39850400004)(189003)(199004)(71190400001)(8676002)(5660300002)(6486002)(53936002)(6512007)(86362001)(229853002)(6306002)(256004)(486006)(6436002)(14444005)(36756003)(44832011)(476003)(107886003)(2501003)(2906002)(99286004)(6246003)(76176011)(6506007)(2616005)(53546011)(386003)(14454004)(966005)(26005)(71200400001)(3846002)(25786009)(6116002)(446003)(4326008)(52116002)(11346002)(66066001)(31686004)(102836004)(7416002)(66946007)(186003)(2201001)(81156014)(64756008)(81166006)(66476007)(66446008)(31696002)(316002)(7736002)(66556008)(68736007)(8936002)(110136005)(54906003)(305945005)(73956011)(478600001)(26583001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB2878;
 H:VI1PR08MB3677.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Fig/c1FytIxiYTWvIvRJTaG27dl9ck4x3+cj+SU8CZyV5auexURTuutCVe670hxXD43RLB9W/itVtEh8nNlRtsrcei2erR6JPfAvtj6pMn8ex2W3e4xva4CPXAttJxLrr+ppjAcldua4d1Xz2RFEE01XNtSlAMzldlTCdtLMFSUwBpak5qC8RM3i8sxiuXlKYd8ep+HSJhvBY1kxxj055H+otAAaNMmJpyrerznoVb1cRif2Os/uqdj9hNRlLRqm0iJU+Y75Mm/F1JLGt3kh4ySk8tHcnLexCsEcShvySWcnYIRP1PjGpGgGJ9A4VlkFZLMM3zEIJ30N1BaEkNG1nQbUMoJzE/QPV47kxrXWximRTzVtNQB0bjmdapZCBP8ra1Ql0aga2YaJd/fs0t1vo4RN7XgisI4wi9RSg0xiiJw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F41D26E843BF34AAFA9E8D9206B4427@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3edd0139-5a8b-4023-f1d4-08d6f97ed001
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 15:07:17.3695 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andrey.shinkevich@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2878
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.117
Subject: Re: [Qemu-devel] [PATCH v7 0/3] block/stream: get rid of the base
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>,
 "wencongyang2@huawei.com" <wencongyang2@huawei.com>,
 "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDI1LzA2LzIwMTkgMTg6MDMsIE1heCBSZWl0eiB3cm90ZToNCj4gT24gMjUuMDYuMTkg
MTY6NDAsIEFuZHJleSBTaGlua2V2aWNoIHdyb3RlOg0KPj4NCj4+DQo+PiBPbiAxOS8wNi8yMDE5
IDIyOjI5LCBNYXggUmVpdHogd3JvdGU6DQo+Pj4gT24gMjkuMDUuMTkgMTk6NTYsIEFuZHJleSBT
aGlua2V2aWNoIHdyb3RlOg0KPj4+PiBUaGlzIHNlcmllcyBpbnRyb2R1Y2VzIGEgYm90dG9tIGlu
dGVybWVkaWF0ZSBub2RlIHRoYXQgZWxpbWluYXRlcyB0aGUNCj4+Pj4gZGVwZW5kZW5jeSBvbiB0
aGUgYmFzZSB0aGF0IG1heSBjaGFuZ2Ugd2hpbGUgc3RyZWFtIGpvYiBpcyBydW5uaW5nLg0KPj4+
PiBJdCBoYXBwZW5zIHdoZW4gc3RyZWFtL2NvbW1pdCBwYXJhbGxlbCBqb2JzIGFyZSBydW5uaW5n
IG9uIHRoZSBzYW1lDQo+Pj4+IGJhY2tpbmcgY2hhaW4uIFRoZSBiYXNlIG5vZGUgb2YgdGhlIHN0
cmVhbSBqb2IgbWF5IGJlIGEgdG9wIG5vZGUgb2YNCj4+Pj4gdGhlIHBhcmFsbGVsIGNvbW1pdCBq
b2IgYW5kIGNhbiBjaGFuZ2UgYmVmb3JlIHRoZSBzdHJlYW0gam9iIGlzDQo+Pj4+IGNvbXBsZXRl
ZC4gV2UgYXZvaWQgdGhhdCBkZXBlbmRlbmN5IGJ5IGludHJvZHVjaW5nIHRoZSBib3R0b20gbm9k
ZS4NCj4+Pj4NCj4+Pj4gdjc6IFtyZXNlbmQgYnkgQW5kcmV5XQ0KPj4+PiAgICAgMDE6IGFzc2Vy
dChpbnRlcm1lZGlhdGUpIHdhcyBpbnNlcnRlZCBiZWZvcmUgdGhlIGNhbGwgdG8NCj4+Pj4gICAg
ICAgICBiZHJ2X2lzX2FsbG9jYXRlZCgpIGluIHRoZSBpbnRlcm1lZGlhdGUgbm9kZSBsb29wIG9m
IHRoZQ0KPj4+PiAgICAgICAgIGJkcnZfaXNfYWxsb2NhdGVkX2Fib3ZlKCkgYXMgc3VnZ2VzdGVk
IGJ5IE1heC4NCj4+Pj4gICAgIDAyOiBUaGUgY2hhbmdlIG9mIHRoZSBpbnRlcm1lZGlhdGUgbm9k
ZSBsb29wIGluIHRoZSBzdHJlYW1fc3RhcnQoKSB3YXMNCj4+Pj4gICAgICAgICByb2xsZWQgYmFj
ayB0byBpdHMgb3JpZ2luYWwgZGVzaWduIGFuZCB0aGUgcmVhc3NpZ25tZW50IG9mIHRoZSBiYXNl
DQo+Pj4+ICAgICAgICAgbm9kZSBwb2ludGVyIHdhcyBhZGRlZCBhcyBWbGFkaW1pciBhbmQgTWF4
IHN1Z2dlc3RlZC4gVGhlIHJlbGV2YW50DQo+Pj4+ICAgICAgICAgY29tbWVudCB3YXMgYW1lbmRl
ZC4NCj4+Pj4NCj4+Pj4gdjY6IFtyZXNlbmQgYnkgVmxhZGltaXJdDQo+Pj4+ICAgICAwMTogaW1w
cm92ZSBjb21tZW50IGluIGJsb2NrL2lvLmMsIHN1Z2dlc3RlZCBieSBBbGJlcnRvDQo+Pj4+DQo+
Pj4+IHY1OiBbcmVzZW5kIGJ5IFZsYWRpbWlyXQ0KPj4+PiAgICAgMDE6IHVzZSBjb21tZW50IHdv
cmRpbmcgaW4gYmxvY2svaW8uYyBzdWdnZXN0ZWQgYnkgQWxiZXJ0bw0KPj4+Pg0KPj4+PiB2NDoN
Cj4+Pj4gdHJhY2Vfc3RyZWFtX3N0YXJ0IHJldmVydGVkIHRvIHRoZSBiYXNlLg0KPj4+PiBiZHJ2
X2lzX2FsbG9jYXRlZF9hYm92ZV9pbmNsdXNpdmUoKSBkZWxldGVkIGFuZCB0aGUgbmV3IHBhcmFt
ZXRlcg0KPj4+PiAnYm9vbCBpbmNsdWRlX2Jhc2UnIHdhcyBhZGRlZCB0byB0aGUgYmRydl9pc19h
bGxvY2F0ZWRfYWJvdmUoKS4NCj4+Pj4NCj4+Pj4gQW5kcmV5IFNoaW5rZXZpY2ggKDMpOg0KPj4+
PiAgICAgYmxvY2s6IGluY2x1ZGUgYmFzZSB3aGVuIGNoZWNraW5nIGltYWdlIGNoYWluIGZvciBi
bG9jayBhbGxvY2F0aW9uDQo+Pj4+ICAgICBibG9jay9zdHJlYW06IHJlZmFjdG9yIHN0cmVhbV9y
dW46IGRyb3AgZ290bw0KPj4+PiAgICAgYmxvY2svc3RyZWFtOiBpbnRyb2R1Y2UgYSBib3R0b20g
bm9kZQ0KPj4+Pg0KPj4+PiAgICBibG9jay9jb21taXQuYyAgICAgICAgIHwgIDIgKy0NCj4+Pj4g
ICAgYmxvY2svaW8uYyAgICAgICAgICAgICB8IDIxICsrKysrKysrKysrKystLS0tLS0NCj4+Pj4g
ICAgYmxvY2svbWlycm9yLmMgICAgICAgICB8ICAyICstDQo+Pj4+ICAgIGJsb2NrL3JlcGxpY2F0
aW9uLmMgICAgfCAgMiArLQ0KPj4+PiAgICBibG9jay9zdHJlYW0uYyAgICAgICAgIHwgNTYgKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+Pj4gICAg
aW5jbHVkZS9ibG9jay9ibG9jay5oICB8ICAzICsrLQ0KPj4+PiAgICB0ZXN0cy9xZW11LWlvdGVz
dHMvMjQ1IHwgIDQgKystLQ0KPj4+PiAgICA3IGZpbGVzIGNoYW5nZWQsIDQ5IGluc2VydGlvbnMo
KyksIDQxIGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gUmV2aWV3ZWQtYnk6IE1heCBSZWl0eiA8bXJl
aXR6QHJlZGhhdC5jb20+DQo+Pj4NCj4+PiBKdXN0IG5lZWRzIHNvbWUgc2ltcGxlIGNoYW5nZXMg
dG8gcGF0Y2ggMSB0byByZWJhc2UgaXQgb24gODYzY2M3OGYxYjMNCj4+PiBhbmQgYzhiYjIzY2Jk
YmUuDQo+Pj4NCj4+PiBNYXgNCj4+Pg0KPj4NCj4+IFBsZWFzZSBsZXQgdXMga25vdyB3aG8gd291
bGQgdGFrZSB0aGlzIHNlcmllcyBmb3IgcHVsbCByZXF1ZXN0Pw0KPiANCj4gTm90aGluZywgSSB3
YXMganVzdCB3YWl0aW5nIGZvciBteSBjdXJyZW50IHB1bGwgcmVxdWVzdCAobGluZ2VyaW5nIGZy
b20NCj4gbGFzdCB3ZWVrIGR1ZSB0byBhIGJ1aWxkIGZhaWx1cmUgYmVjYXVzZSBvZiBvbmUgb2Yg
dGhlIHBhdGNoZXMpIHRvIGJlDQo+IHByb2Nlc3NlZC4NCj4gDQo+IEkgc3VwcG9zZSBJIHdvbuKA
mXQgd2FpdCBsb25nZXIgYW5kIGp1c3QgdGFrZSB0aGlzIHNlcmllcyBub3cgYW5kIGRlYWwNCj4g
d2l0aCB0aGUgZmFsbG91dCBsYXRlciBpZiB0aGVyZeKAmXMgc29tZXRoaW5nIGVsc2UgaW4gbXkg
bGFzdCB3ZWVr4oCZcyBwdWxsDQo+IHJlcXVlc3QgdGhhdCBuZWVkcyBmaXhpbmcuLi4NCj4gDQo+
IFNvOiBUaGFua3MsIGFwcGxpZWQgdG8gbXkgYmxvY2sgYnJhbmNoOg0KPiANCj4gaHR0cHM6Ly9n
aXQueGFuY2xpYy5tb2UvWGFuQ2xpYy9xZW11L2NvbW1pdHMvYnJhbmNoL2Jsb2NrDQo+IA0KPiBN
YXgNCj4gDQoNClRoYW5rcyBhIGxvdCwgTWF4Lg0KDQpBbmRyZXkNCi0tIA0KV2l0aCB0aGUgYmVz
dCByZWdhcmRzLA0KQW5kcmV5IFNoaW5rZXZpY2gNCg0K

