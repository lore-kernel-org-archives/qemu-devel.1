Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E173C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 14:51:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBEF72080C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 14:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ejPVVWZ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBEF72080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32794 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfmmi-0007D5-65
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 10:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48483)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hfmcY-0001Dt-GY
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 10:40:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hfmcW-00016r-Bg
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 10:40:30 -0400
Received: from mail-eopbgr70124.outbound.protection.outlook.com
 ([40.107.7.124]:51906 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hfmcS-00010u-4z; Tue, 25 Jun 2019 10:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTye8CTR3cqaZ2cZ1JNq+qf7UlpSMs2VG3cZU5y8a8o=;
 b=ejPVVWZ+BQV+FQ41C+kHucEDHiq9xWoBEMB5zAetUCTU5Ha29Lai4t0IYhKTDUnKZ1zvV3F45LZTDTY1P4wmFQbPbWXrlahsK3690mJqGRIlCp/nuQNXs+ubKfUweqltRIAs5g6WZyPXmliqo929dOLFN3WTYoUUR7M0/UKIv5U=
Received: from VI1PR08MB3677.eurprd08.prod.outlook.com (20.177.61.92) by
 VI1PR08MB3199.eurprd08.prod.outlook.com (52.133.15.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Tue, 25 Jun 2019 14:40:19 +0000
Received: from VI1PR08MB3677.eurprd08.prod.outlook.com
 ([fe80::4c71:9c23:235b:fbed]) by VI1PR08MB3677.eurprd08.prod.outlook.com
 ([fe80::4c71:9c23:235b:fbed%3]) with mapi id 15.20.2008.014; Tue, 25 Jun 2019
 14:40:19 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v7 0/3] block/stream: get rid of the base
Thread-Index: AQHVJtVTk86p5LXvIUyhwnd3Wk/TrKaseiMA
Date: Tue, 25 Jun 2019 14:40:19 +0000
Message-ID: <3362e8ef-d698-e860-9830-45a3f924ef48@virtuozzo.com>
References: <1559152576-281803-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <87a5ec62-6274-77c6-60a3-b4ad7b4ec822@redhat.com>
In-Reply-To: <87a5ec62-6274-77c6-60a3-b4ad7b4ec822@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0802CA0022.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::32) To VI1PR08MB3677.eurprd08.prod.outlook.com
 (2603:10a6:803:85::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c131d2f0-00f9-45bc-8971-08d6f97b0b65
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB3199; 
x-ms-traffictypediagnostic: VI1PR08MB3199:
x-microsoft-antispam-prvs: <VI1PR08MB31997105011601FF04F74621F4E30@VI1PR08MB3199.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(39850400004)(396003)(366004)(346002)(136003)(189003)(199004)(6506007)(2616005)(476003)(36756003)(44832011)(66476007)(11346002)(7416002)(68736007)(6246003)(66946007)(6486002)(8676002)(229853002)(2906002)(81166006)(81156014)(305945005)(31686004)(53936002)(99286004)(73956011)(4326008)(6512007)(107886003)(5660300002)(7736002)(2501003)(31696002)(71200400001)(66556008)(25786009)(14444005)(54906003)(6116002)(53546011)(486006)(386003)(110136005)(14454004)(6436002)(186003)(66066001)(71190400001)(256004)(64756008)(3846002)(66446008)(316002)(86362001)(26005)(478600001)(52116002)(2201001)(76176011)(8936002)(102836004)(446003)(26583001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3199;
 H:VI1PR08MB3677.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MeandLdNz17IAJNfIUNFWCxx3SJPBWWJgp+EhyP5dyrUXZqngjyDhP/noNtQSzIDn9qOJ2p4MQTwE40hCE8PBTDQmZQhh0eAdy8vZrTP2vwgg4/QoSj6Kp3yzqwuH1i2bU3G5XZrEpevnPuzhi8kUE94Nmgdql+5CYCJKkLsTlCEsVekkqOmcwTC3XOQt1fFmrncGrA8XPb5OjA96QJANW4CJyE9XaRkMiuFtIieyC/vdhwX/ZlX65iUXS77OEvzzc6jOndU24ykq2rAb81kFI4U1UJAJMYR5P4FRlaZegzvgF2BdHudr5fLj+6nKnY/a9LLqGfS1fqcuCb4/DP5XZMU5LF7TEVJT0HMdh07lVGF1PFY9XSfysbj/X/dzHwHM6fDSNnjnojLogDqN9cRM8NKWseVgPMPdt6nq/PMymM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52C5AE91FFF83245979A7A19096FB4BF@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c131d2f0-00f9-45bc-8971-08d6f97b0b65
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 14:40:19.2647 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andrey.shinkevich@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3199
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.124
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

DQoNCk9uIDE5LzA2LzIwMTkgMjI6MjksIE1heCBSZWl0eiB3cm90ZToNCj4gT24gMjkuMDUuMTkg
MTk6NTYsIEFuZHJleSBTaGlua2V2aWNoIHdyb3RlOg0KPj4gVGhpcyBzZXJpZXMgaW50cm9kdWNl
cyBhIGJvdHRvbSBpbnRlcm1lZGlhdGUgbm9kZSB0aGF0IGVsaW1pbmF0ZXMgdGhlDQo+PiBkZXBl
bmRlbmN5IG9uIHRoZSBiYXNlIHRoYXQgbWF5IGNoYW5nZSB3aGlsZSBzdHJlYW0gam9iIGlzIHJ1
bm5pbmcuDQo+PiBJdCBoYXBwZW5zIHdoZW4gc3RyZWFtL2NvbW1pdCBwYXJhbGxlbCBqb2JzIGFy
ZSBydW5uaW5nIG9uIHRoZSBzYW1lDQo+PiBiYWNraW5nIGNoYWluLiBUaGUgYmFzZSBub2RlIG9m
IHRoZSBzdHJlYW0gam9iIG1heSBiZSBhIHRvcCBub2RlIG9mDQo+PiB0aGUgcGFyYWxsZWwgY29t
bWl0IGpvYiBhbmQgY2FuIGNoYW5nZSBiZWZvcmUgdGhlIHN0cmVhbSBqb2IgaXMNCj4+IGNvbXBs
ZXRlZC4gV2UgYXZvaWQgdGhhdCBkZXBlbmRlbmN5IGJ5IGludHJvZHVjaW5nIHRoZSBib3R0b20g
bm9kZS4NCj4+DQo+PiB2NzogW3Jlc2VuZCBieSBBbmRyZXldDQo+PiAgICAwMTogYXNzZXJ0KGlu
dGVybWVkaWF0ZSkgd2FzIGluc2VydGVkIGJlZm9yZSB0aGUgY2FsbCB0bw0KPj4gICAgICAgIGJk
cnZfaXNfYWxsb2NhdGVkKCkgaW4gdGhlIGludGVybWVkaWF0ZSBub2RlIGxvb3Agb2YgdGhlDQo+
PiAgICAgICAgYmRydl9pc19hbGxvY2F0ZWRfYWJvdmUoKSBhcyBzdWdnZXN0ZWQgYnkgTWF4Lg0K
Pj4gICAgMDI6IFRoZSBjaGFuZ2Ugb2YgdGhlIGludGVybWVkaWF0ZSBub2RlIGxvb3AgaW4gdGhl
IHN0cmVhbV9zdGFydCgpIHdhcw0KPj4gICAgICAgIHJvbGxlZCBiYWNrIHRvIGl0cyBvcmlnaW5h
bCBkZXNpZ24gYW5kIHRoZSByZWFzc2lnbm1lbnQgb2YgdGhlIGJhc2UNCj4+ICAgICAgICBub2Rl
IHBvaW50ZXIgd2FzIGFkZGVkIGFzIFZsYWRpbWlyIGFuZCBNYXggc3VnZ2VzdGVkLiBUaGUgcmVs
ZXZhbnQNCj4+ICAgICAgICBjb21tZW50IHdhcyBhbWVuZGVkLg0KPj4NCj4+IHY2OiBbcmVzZW5k
IGJ5IFZsYWRpbWlyXQ0KPj4gICAgMDE6IGltcHJvdmUgY29tbWVudCBpbiBibG9jay9pby5jLCBz
dWdnZXN0ZWQgYnkgQWxiZXJ0bw0KPj4NCj4+IHY1OiBbcmVzZW5kIGJ5IFZsYWRpbWlyXQ0KPj4g
ICAgMDE6IHVzZSBjb21tZW50IHdvcmRpbmcgaW4gYmxvY2svaW8uYyBzdWdnZXN0ZWQgYnkgQWxi
ZXJ0bw0KPj4NCj4+IHY0Og0KPj4gdHJhY2Vfc3RyZWFtX3N0YXJ0IHJldmVydGVkIHRvIHRoZSBi
YXNlLg0KPj4gYmRydl9pc19hbGxvY2F0ZWRfYWJvdmVfaW5jbHVzaXZlKCkgZGVsZXRlZCBhbmQg
dGhlIG5ldyBwYXJhbWV0ZXINCj4+ICdib29sIGluY2x1ZGVfYmFzZScgd2FzIGFkZGVkIHRvIHRo
ZSBiZHJ2X2lzX2FsbG9jYXRlZF9hYm92ZSgpLg0KPj4NCj4+IEFuZHJleSBTaGlua2V2aWNoICgz
KToNCj4+ICAgIGJsb2NrOiBpbmNsdWRlIGJhc2Ugd2hlbiBjaGVja2luZyBpbWFnZSBjaGFpbiBm
b3IgYmxvY2sgYWxsb2NhdGlvbg0KPj4gICAgYmxvY2svc3RyZWFtOiByZWZhY3RvciBzdHJlYW1f
cnVuOiBkcm9wIGdvdG8NCj4+ICAgIGJsb2NrL3N0cmVhbTogaW50cm9kdWNlIGEgYm90dG9tIG5v
ZGUNCj4+DQo+PiAgIGJsb2NrL2NvbW1pdC5jICAgICAgICAgfCAgMiArLQ0KPj4gICBibG9jay9p
by5jICAgICAgICAgICAgIHwgMjEgKysrKysrKysrKysrKy0tLS0tLQ0KPj4gICBibG9jay9taXJy
b3IuYyAgICAgICAgIHwgIDIgKy0NCj4+ICAgYmxvY2svcmVwbGljYXRpb24uYyAgICB8ICAyICst
DQo+PiAgIGJsb2NrL3N0cmVhbS5jICAgICAgICAgfCA1NiArKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gICBpbmNsdWRlL2Jsb2NrL2Jsb2NrLmgg
IHwgIDMgKystDQo+PiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8yNDUgfCAgNCArKy0tDQo+PiAgIDcg
ZmlsZXMgY2hhbmdlZCwgNDkgaW5zZXJ0aW9ucygrKSwgNDEgZGVsZXRpb25zKC0pDQo+IA0KPiBS
ZXZpZXdlZC1ieTogTWF4IFJlaXR6IDxtcmVpdHpAcmVkaGF0LmNvbT4NCj4gDQo+IEp1c3QgbmVl
ZHMgc29tZSBzaW1wbGUgY2hhbmdlcyB0byBwYXRjaCAxIHRvIHJlYmFzZSBpdCBvbiA4NjNjYzc4
ZjFiMw0KPiBhbmQgYzhiYjIzY2JkYmUuDQo+IA0KPiBNYXgNCj4gDQoNClBsZWFzZSBsZXQgdXMg
a25vdyB3aG8gd291bGQgdGFrZSB0aGlzIHNlcmllcyBmb3IgcHVsbCByZXF1ZXN0Pw0KDQpBbmRy
ZXkNCi0tIA0KV2l0aCB0aGUgYmVzdCByZWdhcmRzLA0KQW5kcmV5IFNoaW5rZXZpY2gNCg==

