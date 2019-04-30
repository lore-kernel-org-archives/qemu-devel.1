Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08348C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 10:36:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADA5A2080C
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 10:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="h9HSTU3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA5A2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42950 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLQ7w-0005uS-Mc
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 06:36:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hLQ6v-00050d-Lj
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:35:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hLQ6u-00065I-09
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:35:41 -0400
Received: from mail-eopbgr90115.outbound.protection.outlook.com
	([40.107.9.115]:64573
	helo=FRA01-MR2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hLQ6s-00063G-CR; Tue, 30 Apr 2019 06:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=SopRek9u2AVWvelPy3ltr2RGXeJvWtLaD65nU7MXRv8=;
	b=h9HSTU3wi8/lQsiP6+TOp0p1XyU419l7+/wQDnu5fgfRzUMO6VJ8ftgu7FZhPT6sxGqcyXjJHTmmNqe8N+35btRc7M4uLPSji+S/lL1GBMnVa6ok+ufK+8z5RAUA5GcltMzLqaZFwDtRhckmGcLyA2ZMyF8f/y8O8Gib57SuHvE=
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com (52.133.109.209) by
	PR2PR08MB4795.eurprd08.prod.outlook.com (52.133.111.79) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.18; Tue, 30 Apr 2019 10:35:32 +0000
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::88d7:ecf0:1120:f1a1]) by
	PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::88d7:ecf0:1120:f1a1%3]) with mapi id 15.20.1835.018;
	Tue, 30 Apr 2019 10:35:32 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>, Kevin Wolf
	<kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Wen Congyang
	<wencongyang2@huawei.com>, Xie Changlong <xiechanglong.d@gmail.com>, Markus
	Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Fam Zheng
	<fam@euphon.net>
Thread-Topic: [Qemu-devel] [PATCH 0/2] buffer and delay backup COW write
	operation
Thread-Index: AQHU/amIApH5/SSBIki0K31+mJG6TKZUhYoA
Date: Tue, 30 Apr 2019 10:35:32 +0000
Message-ID: <b9adec87-7818-02e0-518f-50d25130c093@virtuozzo.com>
References: <20190428100052.GA63525@localhost>
In-Reply-To: <20190428100052.GA63525@localhost>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P192CA0009.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::19)
	To PR2PR08MB4684.eurprd08.prod.outlook.com
	(2603:10a6:101:22::17)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190430133530289
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a63b39aa-1bf6-4ee5-fe84-08d6cd5792a0
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:PR2PR08MB4795; 
x-ms-traffictypediagnostic: PR2PR08MB4795:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <PR2PR08MB4795AF5CFB0DFD5153596F0FC13A0@PR2PR08MB4795.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39850400004)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(25786009)(11346002)(71200400001)(6436002)(2501003)(6246003)(66446008)(64756008)(486006)(97736004)(446003)(66946007)(73956011)(8676002)(2616005)(66556008)(476003)(86362001)(186003)(8936002)(66476007)(81166006)(81156014)(256004)(6506007)(386003)(71190400001)(31696002)(26005)(2906002)(14444005)(6512007)(36756003)(102836004)(68736007)(53936002)(5660300002)(6306002)(6486002)(229853002)(66066001)(6116002)(3846002)(31686004)(7416002)(52116002)(99286004)(7736002)(966005)(478600001)(316002)(76176011)(14454004)(110136005)(305945005)(921003)(1121003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:PR2PR08MB4795;
	H:PR2PR08MB4684.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SmtqozAFFvrlzvB5ToVMHTbt+2t7B8eSThTKVGejOPV4t7YH0PKMsnChewb6bkXNWh/DKT6Xh5lSY4vpcp/BucDPKvPySPW9Z6rX8DPHcLstVyypvXpByVz5+si9TKEofB3BYcYpuX9D9NYPZLw2aUvDgyqI3RLcfLfwQuIhSB6nNUIupO8V9GEOPEU36FORU04itADNgUT4P8QNf0mCEVfiVbtswJRztzERa0ERD0GiD/CE3q21n3Xe1lIcR3J96fYHZojFwZViVtAwcq0LnZFhmqd8lWb7dZvBEbw9PJ979uPlAhshnfK52hNH4Ajzw7zUEgUBJ6D7rtiQnAzZzerXooLOtslIHzaBg20A5+MHXdvkuPlfetnlbxoUyo6UVo86hldlD83b+GZS3VJ6mh5Iis5J8zkJXiRr3KvoDeM=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <8E37B85F717D1346BAFA2716C14CD9B2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a63b39aa-1bf6-4ee5-fe84-08d6cd5792a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 10:35:32.7959 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4795
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.9.115
Subject: Re: [Qemu-devel] [PATCH 0/2] buffer and delay backup COW write
 operation
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430103532.KQ5JbCdFbvLdop-bXnZsrfDiTCh7wPMRbVz2hG418gg@z>

MjguMDQuMjAxOSAxMzowMSwgTGlhbmcgTGkgd3JvdGU6DQo+IElmIHRoZSBiYWNrdXAgdGFyZ2V0
IGlzIGEgc2xvdyBkZXZpY2UgbGlrZSBjZXBoIHJiZCwgdGhlIGJhY2t1cA0KPiBwcm9jZXNzIHdp
bGwgYWZmZWN0IGd1ZXN0IEJMSyB3cml0ZSBJTyBwZXJmb3JtYW5jZSBzZXJpb3VzbHksDQo+IGl0
J3MgY2F1c2UgYnkgdGhlIGRyYXdiYWNrIG9mIENPVyBtZWNoYW5pc20sIGlmIGd1ZXN0IG92ZXJ3
cml0ZSB0aGUNCj4gYmFja3VwIEJMSyBhcmVhLCB0aGUgSU8gY2FuIG9ubHkgYmUgcHJvY2Vzc2Vk
IGFmdGVyIHRoZSBkYXRhIGhhcw0KPiBiZWVuIHdyaXR0ZW4gdG8gYmFja3VwIHRhcmdldC4NCj4g
VGhlIGltcGFjdCBjYW4gYmUgcmVsaWV2ZWQgYnkgYnVmZmVyaW5nIGRhdGEgcmVhZCBmcm9tIGJh
Y2t1cA0KPiBzb3VyY2UgYW5kIHdyaXRpbmcgdG8gYmFja3VwIHRhcmdldCBsYXRlciwgc28gdGhl
IGd1ZXN0IEJMSyB3cml0ZQ0KPiBJTyBjYW4gYmUgcHJvY2Vzc2VkIGluIHRpbWUuDQo+IERhdGEg
YXJlYSB3aXRoIG5vIG92ZXJ3cml0ZSB3aWxsIGJlIHByb2Nlc3MgbGlrZSBiZWZvcmUgd2l0aG91
dA0KPiBidWZmZXJpbmcsIGluIG1vc3QgY2FzZSwgd2UgZG9uJ3QgbmVlZCBhIHZlcnkgbGFyZ2Ug
YnVmZmVyLg0KPiANCj4gQW4gZmlvIHRlc3Qgd2FzIGRvbmUgd2hlbiB0aGUgYmFja3VwIHdhcyBn
b2luZyBvbiwgdGhlIHRlc3QgcmVzdXQNCj4gc2hvdyBhIG9idmlvdXMgcGVyZm9ybWFuY2UgaW1w
cm92ZW1lbnQgYnkgYnVmZmVyaW5nLg0KDQpIaSBMaWFuZyENCg0KR29vZCB0aGluZy4gU29tZXRo
aW5nIGxpa2UgdGhpcyBJJ3ZlIGJyaWVmbHkgbWVudGlvbmVkIGluIG15IEtWTSBGb3J1bSAyMDE4
DQpyZXBvcnQgYXMgIlJBTSBDYWNoZSIsIGFuZCBJJ2QgcmVhbGx5IHByZWZlciB0aGlzIGZ1bmN0
aW9uYWxpdHkgdG8gYmUgYSBzZXBhcmF0ZQ0KZmlsdGVyLCBpbnN0ZWFkIG9mIGNvbXBsaWNhdGlv
biBvZiBiYWNrdXAgY29kZS4gRnVydGhlciBtb3JlLCB3cml0ZSBub3RpZmllcnMNCndpbGwgZ28g
YXdheSBmcm9tIGJhY2t1cCBjb2RlLCBhZnRlciBteSBiYWNrdXAtdG9wIHNlcmllcyBtZXJnZWQu
DQoNCnY1OiBodHRwczovL2xpc3RzLmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAx
OC0xMi9tc2cwNjIxMS5odG1sDQphbmQgc2VwYXJhdGVkIHByZXBhcmluZyByZWZhY3RvcmluZyB2
NzogaHR0cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMTktMDQv
bXNnMDQ4MTMuaHRtbA0KDQpSQU0gQ2FjaGUgc2hvdWxkIGJlIGEgZmlsdGVyIGRyaXZlciwgd2l0
aCBhbiBpbi1tZW1vcnkgYnVmZmVyKHMpIGZvciBkYXRhIHdyaXR0ZW4gdG8gaXQNCmFuZCB3aXRo
IGFiaWxpdHkgdG8gZmx1c2ggZGF0YSB0byB1bmRlcmx5aW5nIGJhY2tpbmcgZmlsZS4NCg0KQWxz
bywgaGVyZSBpcyBhbm90aGVyIGFwcHJvYWNoIGZvciB0aGUgcHJvYmxlbSwgd2hpY2ggaGVscHMg
aWYgZ3Vlc3Qgd3JpdGluZyBhY3Rpdml0eQ0KaXMgcmVhbGx5IGhpZ2ggYW5kIGxvbmcgYW5kIGJ1
ZmZlciB3aWxsIGJlIGZpbGxlZCBhbmQgcGVyZm9ybWFuY2Ugd2lsbCBkZWNyZWFzZSBhbnl3YXk6
DQoNCjEuIENyZWF0ZSBsb2NhbCB0ZW1wb3JhcnkgaW1hZ2UsIGFuZCBDT1dzIHdpbGwgZ28gdG8g
aXQuIChwcmV2aW91c2x5IGNvbnNpZGVyZWQgb24gbGlzdCwgdGhhdCB3ZSBzaG91bGQgY2FsbA0K
dGhlc2UgYmFja3VwIG9wZXJhdGlvbnMgaXNzdWVkIGJ5IGd1ZXN0IHdyaXRlcyBDQlcgPSBjb3B5
LWJlZm9yZS13cml0ZSwgYXMgY29weS1vbi13cml0ZQ0KaXMgZ2VuZXJhbGx5IGFub3RoZXIgdGhp
bmcsIGFuZCB1c2luZyB0aGlzIHRlcm0gaW4gYmFja3VwIGlzIGNvbmZ1c2luZykuDQoNCjIuIFdl
IGFsc28gc2V0IG9yaWdpbmFsIGRpc2sgYXMgYSBiYWNraW5nIGZvciB0ZW1wb3JhcnkgaW1hZ2Us
IGFuZCBzdGFydCBhbm90aGVyIGJhY2t1cCBmcm9tDQp0ZW1wb3JhcnkgdG8gcmVhbCB0YXJnZXQu
DQoNClRoaXMgc2NoZW1lIGlzIGFsbW9zdCBwb3NzaWJsZSBub3csIHlvdSBuZWVkIHRvIHN0YXJ0
IGJhY2t1cChzeW5jPW5vbmUpIGZyb20gc291cmNlIHRvIHRlbXAsDQp0byBkbyBbMV0uIFNvbWUg
cGF0Y2hlcyBhcmUgc3RpbGwgbmVlZGVkIHRvIGFsbG93IHN1Y2ggc2NoZW1lLiBJIGRpZG4ndCBz
ZW5kIHRoZW0sIGFzIEkgd2FudA0KbXkgb3RoZXIgYmFja3VwIHBhdGNoZXMgZ28gZmlyc3QgYW55
d2F5LiBCdXQgSSBjYW4uIE9uIHRoZSBvdGhlciBoYW5kIGlmIGFwcHJvYWNoIHdpdGggaW4tbWVt
b3J5DQpidWZmZXIgd29ya3MgZm9yIHlvdSBpdCBtYXkgYmUgYmV0dGVyLg0KDQpBbHNvLCBJJ20g
bm90IHN1cmUgZm9yIG5vdywgc2hvdWxkIHdlIHJlYWxseSBkbyB0aGlzIHRoaW5nIHRocm91Z2gg
dHdvIGJhY2t1cCBqb2JzLCBvciB3ZSBqdXN0DQpuZWVkIG9uZSBzZXBhcmF0ZSBiYWNrdXAtdG9w
IGZpbHRlciBhbmQgb25lIGJhY2t1cCBqb2Igd2l0aG91dCBmaWx0ZXIsIG9yIHdlIG5lZWQgYW4g
YWRkaXRpb25hbA0KcGFyYW1ldGVyIGZvciBiYWNrdXAgam9iIHRvIHNldCBjYWNoZS1ibG9jay1u
b2RlLg0KDQo+IA0KPiBUZXN0IHJlc3VsdCgxR0IgYnVmZmVyKToNCj4gPT09PT09PT09PT09PT09
PT09PT09PT09DQo+IGZpbyBzZXR0aW5nOg0KPiBbcmFuZG9tLXdyaXRlcnNdDQo+IGlvZW5naW5l
PWxpYmFpbw0KPiBpb2RlcHRoPTgNCj4gcnc9cmFuZHdyaXRlDQo+IGJzPTMyaw0KPiBkaXJlY3Q9
MQ0KPiBzaXplPTFHDQo+IG51bWpvYnM9MQ0KPiANCj4gcmVzdWx0Og0KPiAgICAgICAgICAgICAg
ICAgICAgICAgIElPUFMgICAgICAgIEFWRyBsYXRlbmN5DQo+ICAgICAgICAgbm8gYmFja3VwOiAg
ICAgMTkzODkgICAgICAgICA0MTAgdXMNCj4gICAgICAgICAgICBiYWNrdXA6ICAgICAgMTQwMiAg
ICAgICAgNTcwMiB1cw0KPiBiYWNrdXAgdy8gYnVmZmVyOiAgICAgIDg2ODQgICAgICAgICA5MTgg
dXMNCj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiAN
Cj4gQ2M6IEpvaG4gU25vdyA8anNub3dAcmVkaGF0LmNvbT4NCj4gQ2M6IEtldmluIFdvbGYgPGt3
b2xmQHJlZGhhdC5jb20+DQo+IENjOiBNYXggUmVpdHogPG1yZWl0ekByZWRoYXQuY29tPg0KPiBD
YzogV2VuIENvbmd5YW5nIDx3ZW5jb25neWFuZzJAaHVhd2VpLmNvbT4NCj4gQ2M6IFhpZSBDaGFu
Z2xvbmcgPHhpZWNoYW5nbG9uZy5kQGdtYWlsLmNvbT4NCj4gQ2M6IE1hcmt1cyBBcm1icnVzdGVy
IDxhcm1icnVAcmVkaGF0LmNvbT4NCj4gQ2M6IEVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29t
Pg0KPiBDYzogRmFtIFpoZW5nIDxmYW1AZXVwaG9uLm5ldD4NCj4gDQo+IExpYW5nIExpICgyKToN
Cj4gICAgYmFja3VwOiBidWZmZXIgQ09XIHJlcXVlc3QgYW5kIGRlbGF5IHRoZSB3cml0ZSBvcGVy
YXRpb24NCj4gICAgcWFwaTogYWRkIGludGVyZmFjZSBmb3Igc2V0dGluZyBiYWNrdXAgY293IGJ1
ZmZlciBzaXplDQo+IA0KPiAgIGJsb2NrL2JhY2t1cC5jICAgICAgICAgICAgfCAxMTggKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLQ0KPiAgIGJsb2NrL3JlcGxp
Y2F0aW9uLmMgICAgICAgfCAgIDIgKy0NCj4gICBibG9ja2Rldi5jICAgICAgICAgICAgICAgIHwg
ICA1ICsrDQo+ICAgaW5jbHVkZS9ibG9jay9ibG9ja19pbnQuaCB8ICAgMiArDQo+ICAgcWFwaS9i
bG9jay1jb3JlLmpzb24gICAgICB8ICAgNSArKw0KPiAgIDUgZmlsZXMgY2hhbmdlZCwgMTE4IGlu
c2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQ0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywN
ClZsYWRpbWlyDQo=

