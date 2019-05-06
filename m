Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918BBC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 11:56:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF6320830
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 11:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EoKjzsVc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF6320830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55200 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNcEA-00082j-JH
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 07:56:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hNcDH-0007Eb-N8
	for qemu-devel@nongnu.org; Mon, 06 May 2019 07:55:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hNcDD-0000gt-SK
	for qemu-devel@nongnu.org; Mon, 06 May 2019 07:55:17 -0400
Received: from mail-eopbgr120111.outbound.protection.outlook.com
	([40.107.12.111]:57255
	helo=FRA01-PR2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hNcDA-0000dp-2j; Mon, 06 May 2019 07:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=gHPkEGuQfYDbAL7BtdIGObEnakniB32E7CdmSi+b8Vo=;
	b=EoKjzsVclImA1zbdahIXM2cM6quBWQl/ULqcOr6IplAkrcjWidKKKMpM7AMQwRax/jAIMfhBHzOXCN09uqF67nV0q22v11b5c+pEmw02IQCnx7vaSBMpEqG83ixw3MXf93DC8RMLEmlq9/DvcSIYtVlkT2jw4I4MyBnp+hk8slY=
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com (52.133.109.209) by
	PR2PR08MB4873.eurprd08.prod.outlook.com (52.133.108.86) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1856.12; Mon, 6 May 2019 11:55:07 +0000
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::9c35:2e89:30c4:5cc4]) by
	PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::9c35:2e89:30c4:5cc4%3]) with mapi id 15.20.1856.012;
	Mon, 6 May 2019 11:55:07 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Liang Li <liliang.opensource@gmail.com>
Thread-Topic: [Qemu-devel] [PATCH 0/2] buffer and delay backup COW write
	operation
Thread-Index: AQHU/amIApH5/SSBIki0K31+mJG6TKZUt9QAgAjUJQCAAH3JAA==
Date: Mon, 6 May 2019 11:55:07 +0000
Message-ID: <e0085758-6b99-c246-0416-3323b8b90864@virtuozzo.com>
References: <20190428100052.GA63525@localhost>
	<b9adec87-7818-02e0-518f-50d25130c093@virtuozzo.com>
	<20190506042448.GA10991@liangdeMacBook-Pro.local>
In-Reply-To: <20190506042448.GA10991@liangdeMacBook-Pro.local>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P18901CA0007.EURP189.PROD.OUTLOOK.COM
	(2603:10a6:3:8b::17) To PR2PR08MB4684.eurprd08.prod.outlook.com
	(2603:10a6:101:22::17)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190506145504707
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3785d90d-aeed-4bb0-1f33-08d6d219aef9
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:PR2PR08MB4873; 
x-ms-traffictypediagnostic: PR2PR08MB4873:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <PR2PR08MB48736C9CBC77E2E39A7D8D0BC1300@PR2PR08MB4873.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39840400004)(346002)(396003)(136003)(376002)(366004)(199004)(189003)(186003)(76176011)(86362001)(14444005)(256004)(486006)(99286004)(11346002)(5660300002)(73956011)(64756008)(2616005)(54906003)(6486002)(102836004)(6436002)(476003)(26005)(229853002)(71200400001)(71190400001)(478600001)(446003)(81166006)(25786009)(66446008)(66946007)(66556008)(66476007)(6506007)(386003)(31686004)(52116002)(68736007)(6916009)(81156014)(3846002)(14454004)(6246003)(31696002)(4326008)(966005)(7416002)(316002)(7736002)(53936002)(305945005)(6306002)(6512007)(66066001)(8676002)(8936002)(2906002)(36756003)(6116002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:PR2PR08MB4873;
	H:PR2PR08MB4684.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y+u5g0OKKV0ehqo215Jb/XEumFCQrMjemOAzGTd+gx/mk8sze94OQvYuBmD4Es8jvjJCIrYj1QpTa3gFoJbw7rjaMCnsEB19jiPTXdGKTI+EMyS88qtg/5DSBpUx001yu3HvPZylHqhUJlHJvU5wKSnmAtKpSRflIp+a3dPBDlvyOpKWqkSHyJDTO11CLht2lf/p+c8x8Cs5q9vUIkuP1OyD7RWKbvWU8cd1viTIrfpyVIBXW0FTiX0VBjsdqaDWvsA0Lz5nKM+VSljhhnTzyDloUsAESfAvj9v9lZppWl1yQyWGZz+DEpaJDrqGFbuiQfEDxgWp33Ot04MNWmPbJNlf9CE/Y7n36p79YnTpgQh2aKSq6HzJ3mit3v3hFupiImZeBwBPycermgBpZTVpBi9AvOXMRX5p3TJ1s/ZAkhY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7171DA0F5CC5BB4594EAF15D4CA0FD7A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3785d90d-aeed-4bb0-1f33-08d6d219aef9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 11:55:07.3082 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4873
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.12.111
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	Wen Congyang <wencongyang2@huawei.com>,
	Xie Changlong <xiechanglong.d@gmail.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Max Reitz <mreitz@redhat.com>, Liang Li <liliangleo@didiglobal.com>,
	John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDYuMDUuMjAxOSA3OjI0LCBMaWFuZyBMaSB3cm90ZToNCj4gT24gVHVlLCBBcHIgMzAsIDIwMTkg
YXQgMTA6MzU6MzJBTSArMDAwMCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToN
Cj4+IDI4LjA0LjIwMTkgMTM6MDEsIExpYW5nIExpIHdyb3RlOg0KPj4+IElmIHRoZSBiYWNrdXAg
dGFyZ2V0IGlzIGEgc2xvdyBkZXZpY2UgbGlrZSBjZXBoIHJiZCwgdGhlIGJhY2t1cA0KPj4+IHBy
b2Nlc3Mgd2lsbCBhZmZlY3QgZ3Vlc3QgQkxLIHdyaXRlIElPIHBlcmZvcm1hbmNlIHNlcmlvdXNs
eSwNCj4+PiBpdCdzIGNhdXNlIGJ5IHRoZSBkcmF3YmFjayBvZiBDT1cgbWVjaGFuaXNtLCBpZiBn
dWVzdCBvdmVyd3JpdGUgdGhlDQo+Pj4gYmFja3VwIEJMSyBhcmVhLCB0aGUgSU8gY2FuIG9ubHkg
YmUgcHJvY2Vzc2VkIGFmdGVyIHRoZSBkYXRhIGhhcw0KPj4+IGJlZW4gd3JpdHRlbiB0byBiYWNr
dXAgdGFyZ2V0Lg0KPj4+IFRoZSBpbXBhY3QgY2FuIGJlIHJlbGlldmVkIGJ5IGJ1ZmZlcmluZyBk
YXRhIHJlYWQgZnJvbSBiYWNrdXANCj4+PiBzb3VyY2UgYW5kIHdyaXRpbmcgdG8gYmFja3VwIHRh
cmdldCBsYXRlciwgc28gdGhlIGd1ZXN0IEJMSyB3cml0ZQ0KPj4+IElPIGNhbiBiZSBwcm9jZXNz
ZWQgaW4gdGltZS4NCj4+PiBEYXRhIGFyZWEgd2l0aCBubyBvdmVyd3JpdGUgd2lsbCBiZSBwcm9j
ZXNzIGxpa2UgYmVmb3JlIHdpdGhvdXQNCj4+PiBidWZmZXJpbmcsIGluIG1vc3QgY2FzZSwgd2Ug
ZG9uJ3QgbmVlZCBhIHZlcnkgbGFyZ2UgYnVmZmVyLg0KPj4+DQo+Pj4gQW4gZmlvIHRlc3Qgd2Fz
IGRvbmUgd2hlbiB0aGUgYmFja3VwIHdhcyBnb2luZyBvbiwgdGhlIHRlc3QgcmVzdXQNCj4+PiBz
aG93IGEgb2J2aW91cyBwZXJmb3JtYW5jZSBpbXByb3ZlbWVudCBieSBidWZmZXJpbmcuDQo+Pg0K
Pj4gSGkgTGlhbmchDQo+Pg0KPj4gR29vZCB0aGluZy4gU29tZXRoaW5nIGxpa2UgdGhpcyBJJ3Zl
IGJyaWVmbHkgbWVudGlvbmVkIGluIG15IEtWTSBGb3J1bSAyMDE4DQo+PiByZXBvcnQgYXMgIlJB
TSBDYWNoZSIsIGFuZCBJJ2QgcmVhbGx5IHByZWZlciB0aGlzIGZ1bmN0aW9uYWxpdHkgdG8gYmUg
YSBzZXBhcmF0ZQ0KPj4gZmlsdGVyLCBpbnN0ZWFkIG9mIGNvbXBsaWNhdGlvbiBvZiBiYWNrdXAg
Y29kZS4gRnVydGhlciBtb3JlLCB3cml0ZSBub3RpZmllcnMNCj4+IHdpbGwgZ28gYXdheSBmcm9t
IGJhY2t1cCBjb2RlLCBhZnRlciBteSBiYWNrdXAtdG9wIHNlcmllcyBtZXJnZWQuDQo+Pg0KPj4g
djU6IGh0dHBzOi8vbGlzdHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE4LTEy
L21zZzA2MjExLmh0bWwNCj4+IGFuZCBzZXBhcmF0ZWQgcHJlcGFyaW5nIHJlZmFjdG9yaW5nIHY3
OiBodHRwczovL2xpc3RzLmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAxOS0wNC9t
c2cwNDgxMy5odG1sDQo+Pg0KPj4gUkFNIENhY2hlIHNob3VsZCBiZSBhIGZpbHRlciBkcml2ZXIs
IHdpdGggYW4gaW4tbWVtb3J5IGJ1ZmZlcihzKSBmb3IgZGF0YSB3cml0dGVuIHRvIGl0DQo+PiBh
bmQgd2l0aCBhYmlsaXR5IHRvIGZsdXNoIGRhdGEgdG8gdW5kZXJseWluZyBiYWNraW5nIGZpbGUu
DQo+Pg0KPj4gQWxzbywgaGVyZSBpcyBhbm90aGVyIGFwcHJvYWNoIGZvciB0aGUgcHJvYmxlbSwg
d2hpY2ggaGVscHMgaWYgZ3Vlc3Qgd3JpdGluZyBhY3Rpdml0eQ0KPj4gaXMgcmVhbGx5IGhpZ2gg
YW5kIGxvbmcgYW5kIGJ1ZmZlciB3aWxsIGJlIGZpbGxlZCBhbmQgcGVyZm9ybWFuY2Ugd2lsbCBk
ZWNyZWFzZSBhbnl3YXk6DQo+Pg0KPj4gMS4gQ3JlYXRlIGxvY2FsIHRlbXBvcmFyeSBpbWFnZSwg
YW5kIENPV3Mgd2lsbCBnbyB0byBpdC4gKHByZXZpb3VzbHkgY29uc2lkZXJlZCBvbiBsaXN0LCB0
aGF0IHdlIHNob3VsZCBjYWxsDQo+PiB0aGVzZSBiYWNrdXAgb3BlcmF0aW9ucyBpc3N1ZWQgYnkg
Z3Vlc3Qgd3JpdGVzIENCVyA9IGNvcHktYmVmb3JlLXdyaXRlLCBhcyBjb3B5LW9uLXdyaXRlDQo+
PiBpcyBnZW5lcmFsbHkgYW5vdGhlciB0aGluZywgYW5kIHVzaW5nIHRoaXMgdGVybSBpbiBiYWNr
dXAgaXMgY29uZnVzaW5nKS4NCj4+DQo+PiAyLiBXZSBhbHNvIHNldCBvcmlnaW5hbCBkaXNrIGFz
IGEgYmFja2luZyBmb3IgdGVtcG9yYXJ5IGltYWdlLCBhbmQgc3RhcnQgYW5vdGhlciBiYWNrdXAg
ZnJvbQ0KPj4gdGVtcG9yYXJ5IHRvIHJlYWwgdGFyZ2V0Lg0KPj4NCj4+IFRoaXMgc2NoZW1lIGlz
IGFsbW9zdCBwb3NzaWJsZSBub3csIHlvdSBuZWVkIHRvIHN0YXJ0IGJhY2t1cChzeW5jPW5vbmUp
IGZyb20gc291cmNlIHRvIHRlbXAsDQo+PiB0byBkbyBbMV0uIFNvbWUgcGF0Y2hlcyBhcmUgc3Rp
bGwgbmVlZGVkIHRvIGFsbG93IHN1Y2ggc2NoZW1lLiBJIGRpZG4ndCBzZW5kIHRoZW0sIGFzIEkg
d2FudA0KPj4gbXkgb3RoZXIgYmFja3VwIHBhdGNoZXMgZ28gZmlyc3QgYW55d2F5LiBCdXQgSSBj
YW4uIE9uIHRoZSBvdGhlciBoYW5kIGlmIGFwcHJvYWNoIHdpdGggaW4tbWVtb3J5DQo+PiBidWZm
ZXIgd29ya3MgZm9yIHlvdSBpdCBtYXkgYmUgYmV0dGVyLg0KPj4NCj4+IEFsc28sIEknbSBub3Qg
c3VyZSBmb3Igbm93LCBzaG91bGQgd2UgcmVhbGx5IGRvIHRoaXMgdGhpbmcgdGhyb3VnaCB0d28g
YmFja3VwIGpvYnMsIG9yIHdlIGp1c3QNCj4+IG5lZWQgb25lIHNlcGFyYXRlIGJhY2t1cC10b3Ag
ZmlsdGVyIGFuZCBvbmUgYmFja3VwIGpvYiB3aXRob3V0IGZpbHRlciwgb3Igd2UgbmVlZCBhbiBh
ZGRpdGlvbmFsDQo+PiBwYXJhbWV0ZXIgZm9yIGJhY2t1cCBqb2IgdG8gc2V0IGNhY2hlLWJsb2Nr
LW5vZGUuDQo+Pg0KPiANCj4gSGkgVmxhZGltaXIsDQo+IA0KPiAgICAgVGhhbmtzIGZvciB5b3Vy
IHZhbHVhYmxlIGluZm9ybWF0aW9uLiBJIGRpZG4ndCBub3RpY2UgdGhhdCB5b3UgYXJlIGFscmVh
ZHkgd29ya2luZyBvbg0KPiB0aGlzLCAgc28gbXkgcGF0Y2ggd2lsbCBjb25mbGljdCB3aXRoIHlv
dXIgd29yay4gV2UgaGF2ZSB0aG91Z2h0IGFib3V0IHRoZSB3YXkgWzJdIGFuZA0KPiBnaXZlIGl0
IHVwIGJlY2F1c2UgaXQgd291bGQgYWZmZWN0IGxvY2FsIHN0b3JhZ2UgcGVyZm9ybWFuY2UuDQo+
ICAgICBJIGhhdmUgcmVhZCB5b3VyIHNsaWNlIGluIEtWTSBGb3J1bSAyMDE4IGFuZCB0aGUgcmVs
YXRlZCBwYXRjaGVzLCB5b3VyIHNvbHV0aW9uIGNhbg0KPiBoZWxwIHRvIHNvbHZlIHRoZSBpc3N1
ZXMgaW4gYmFja3VwLiBJIGFtIG5vdCBzdXJlIGlmIHRoZSAiUkFNIGNhY2hlIiBpcyBhIHFjb3cy
IGZpbGUgaW4NCj4gUkFNPyBpZiBzbywgeW91ciBpbXBsZW1lbnRhdGlvbiB3aWxsIGZyZWUgdGhl
IFJBTSBzcGFjZSBvY2N1cGllZCBieSBCTEsgZGF0YSBvbmNlIGl0J3MNCj4gd3JpdHRlbiB0byB0
aGUgZmFyIHRhcmdldCBpbiB0aW1lPyBvciB3ZSBtYXkgbmVlZCBhIGxhcmdlIGNhY2hlIHRvIG1h
a2UgdGhpbmdzIHdvcmsuDQo+ICAgICBUd28gYmFja3VwIGpvYnMgc2VlbXMgY29tcGxleCBhbmQg
bm90IHVzZXIgZnJpZW5kbHksIGlzIGl0IHBvc3NpYmxlIHRvIG1ha2UgbXkgcGF0Y2gNCj4gY293
b3JrIHdpdGggQ0JXPw0KDQpObywgSSBkb24ndCB0aGluayB0aGF0IFJBTSBjYWNoZSBzaG91bGQg
YmUgcWNvdzIgaW4gUkFNLi4gV2hhdCB5b3UgYXJlIGRvaW5nIGlzIGFjdHVhbGx5IGNhY2hpbmcN
CkNCVyBkYXRhIGluIFJBTS4gVG8gZG8gaXQgd2hlbiBDQlcgaXMgZG9uZSBpbiBiYWNrdXAtdG9w
IGZpbHRlciBkcml2ZXIsIHRoZXJlIGFyZSB0d28gd2F5czoNCg0KMS4gRG8gY2FjaGluZyBpbnNp
ZGVkIGJhY2t1cC10b3AgZmlsdGVyIC0gaXQgd291bGQgYmUgbGlrZSB5b3VyIGFwcHJvYWNoIG9m
IGNhY2hpbmcgaW5zaWRlIENCVw0Kb3BlcmF0aW9ucy4gSSB0aGluayB0aGlzIGlzIGJhZCB3YXku
DQoNCjIuIE1ha2Ugc2VwYXJhdGUgZmlsdGVyIGRyaXZlciBmb3IgY2FjaGluZyAtIFJBTSBDYWNo
ZS4gUHJvYmFibHksIGl0IHNob3VsZCBzdG9yZSBpbi1mbGlnaHQNCnJlcXVlc3RzIGFzIGlzLCBq
dXN0IGxpc3Qgb2YgYnVmZmVycyBhbmQgb2Zmc2V0cy4NCg0KDQoNCi0tIA0KQmVzdCByZWdhcmRz
LA0KVmxhZGltaXINCg==

