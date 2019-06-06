Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9A2C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 12:36:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9139420684
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 12:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="h1x31GTS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9139420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59885 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYrdQ-0006yK-JM
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 08:36:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYrWe-0001ux-Dq
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 08:29:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYrWd-00068u-4F
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 08:29:48 -0400
Received: from mail-eopbgr150110.outbound.protection.outlook.com
	([40.107.15.110]:46403
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hYrWZ-0005ny-NO; Thu, 06 Jun 2019 08:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=8DjB9HJFsB/tTlLXXqwP/66avXNYVrENvJJzcWhQCQg=;
	b=h1x31GTSIb0JMkfOHWiOA3wUQM3ZnfiTx8pK5gKlYMOuGCIC+3Vet1M8QeltWX0PeDwCO0/HG3/xaUvaRZFrVMax6cVNqPyvMJ7gQh2F81jyKBk7vYwvKkYZr2KkqTZVU1b6G7MMZ9beICD/Wz4ZhjgyDxREqcmWUlh8AzPHXtE=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
	AM0PR08MB4018.eurprd08.prod.outlook.com (20.178.119.15) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1965.14; Thu, 6 Jun 2019 12:29:40 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8]) by
	AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8%7]) with mapi id 15.20.1965.011;
	Thu, 6 Jun 2019 12:29:40 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH v2 2/2] blockjob: use blk_new_pinned in block_job_create
Thread-Index: AQHVG8HBVdfqD7RC9UWdIT2PxMi18aaNTVYAgAEZzACAAChdAA==
Date: Thu, 6 Jun 2019 12:29:40 +0000
Message-ID: <e7711782-004e-e27d-7ecf-afc04bd1a697@virtuozzo.com>
References: <20190605123229.92848-1-vsementsov@virtuozzo.com>
	<20190605123229.92848-3-vsementsov@virtuozzo.com>
	<20190605171137.GC5491@linux.fritz.box>
	<1b1a0ec6-88c7-d7a5-3d95-bde310693580@virtuozzo.com>
	<20190606100510.GA9241@localhost.localdomain>
In-Reply-To: <20190606100510.GA9241@localhost.localdomain>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0254.eurprd05.prod.outlook.com
	(2603:10a6:3:fb::30) To AM0PR08MB2961.eurprd08.prod.outlook.com
	(2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190606152938759
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff2784bb-22b1-4907-0e21-08d6ea7aa58e
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:AM0PR08MB4018; 
x-ms-traffictypediagnostic: AM0PR08MB4018:
x-microsoft-antispam-prvs: <AM0PR08MB40189DB5FA0CCA2A8376EB61C1170@AM0PR08MB4018.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(396003)(376002)(136003)(366004)(39850400004)(189003)(199004)(99286004)(7736002)(305945005)(2906002)(186003)(476003)(26005)(316002)(11346002)(2616005)(446003)(52116002)(25786009)(31696002)(81166006)(81156014)(86362001)(36756003)(8676002)(68736007)(31686004)(4326008)(478600001)(14454004)(486006)(8936002)(54906003)(6506007)(386003)(64756008)(53936002)(229853002)(5660300002)(256004)(71200400001)(71190400001)(66556008)(66476007)(6246003)(66446008)(76176011)(73956011)(66946007)(66066001)(6916009)(6116002)(3846002)(102836004)(6436002)(6486002)(6512007);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4018;
	H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OHZPKPKat45r8b6gnrOqG42U/TKG+Qi7MTt3awfaH+mPrmFz2RfYcehbZk/7VBGbALo0+aAD5cvMxOh5eogq2lqH0+CFVDl9a2C/d6VjMDloRdbYx0fvgtbT+oJ+Hdmlr13RGD6hpmUrvaONlGuREp+7Hj99h2UxA5p3grw1eKSdyBscO/OnY0kUjXAjEBSCsPcA1Q64CBBett1klFCo7ppNPZjLOJOUaA0WPGD4NxhDp2+SjInbemxpvcW4ySEq1hIHyshNWamloMuNhgznxRR/jpqJZ9gDhNgB/vKjovq9EpaRxJSsbL4NnGv6Vi4j9s15E6ZriGmyc4IiomFyLokAZuxpj5aCjlMC6OHDcuCGintlYuFzJMnpIy32lOmpS1Q3Et0O7IL4oU0f+JJUOjQ2yMwmvmDgjcdVeoNoXAI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA30E7AD6C2B8340B9C80B9D4ADE7349@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2784bb-22b1-4907-0e21-08d6ea7aa58e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 12:29:40.6442 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4018
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.110
Subject: Re: [Qemu-devel] [PATCH v2 2/2] blockjob: use blk_new_pinned in
 block_job_create
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
Cc: "jsnow@redhat.com" <jsnow@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDYuMDYuMjAxOSAxMzowNSwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMDUuMDYuMjAxOSB1bSAx
OToxNiBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IDA1
LjA2LjIwMTkgMjA6MTEsIEtldmluIFdvbGYgd3JvdGU6DQo+Pj4gQW0gMDUuMDYuMjAxOSB1bSAx
NDozMiBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+Pj4g
Y2hpbGRfcm9sZSBqb2IgYWxyZWFkeSBoYXMgLnN0YXlfYXRfbm9kZT10cnVlLCBzbyBvbiBiZHJ2
X3JlcGxhY2Vfbm9kZQ0KPj4+PiBvcGVyYXRpb24gdGhlc2UgY2hpbGQgYXJlIHVuY2hhbmdlZC4g
TWFrZSBibG9jayBqb2IgYmxrIGJlaGF2ZSBpbiBzYW1lDQo+Pj4+IG1hbm5lciwgdG8gYXZvaWQg
aW5jb25zaXN0ZW50IGludGVybWVkaWF0ZSBncmFwaCBzdGF0ZXMgYW5kIHdvcmthcm91bmRzDQo+
Pj4+IGxpa2UgaW4gbWlycm9yLg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBT
ZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+Pj4NCj4+PiBU
aGlzIGZlZWxzIGRhbmdlcm91cy4gSXQgZG9lcyB3aGF0IHlvdSB3YW50IGl0IHRvIGRvIGlmIHRo
ZSBvbmx5IGdyYXBoDQo+Pj4gY2hhbmdlIGJlbG93IHRoZSBCbG9ja0JhY2tlbmQgaXMgdGhlIG9u
ZSBpbiBtaXJyb3JfZXhpdF9jb21tb24uIEJ1dCB0aGUNCj4+PiB1c2VyIGNvdWxkIGFsc28gdGFr
ZSBhIHNuYXBzaG90LCBvciBpbiB0aGUgZnV0dXJlIGhvcGVmdWxseSBpbnNlcnQgYQ0KPj4+IGZp
bHRlciBub2RlLCBhbmQgeW91IHdvdWxkIHRoZW4gd2FudCB0aGUgQmxvY2tCYWNrZW5kIHRvIG1v
dmUuDQo+Pj4NCj4+PiBUbyBiZSBob25lc3QsIGV2ZW4gQmRydkNoaWxkUm9sZS5zdGF5X2F0X25v
ZGUgaXMgYSBiaXQgb2YgYSBoYWNrLiBCdXQgYXQNCj4+PiBsZWFzdCBpdCdzIG9ubHkgdXNlZCBm
b3IgcGVybWlzc2lvbnMgYW5kIG5vdCBmb3IgdGhlIGFjdHVhbCBkYXRhIGZsb3cuDQo+Pg0KPj4g
SG1tLiBUaGFuLCBtYXkgYmUganVzdCBhZGQgYSBwYXJhbWV0ZXIgdG8gYmRydl9yZXBsYWNlX25v
ZGUsIHdoaWNoIHBhcmVudHMNCj4+IHRvIGlnbm9yZT8gV291bGQgaXQgd29yaz8NCj4gDQo+IEkg
d291bGQgaGF2ZSB0byB0aGluayBhIGJpdCBtb3JlIGFib3V0IGl0LCBidXQgaXQgZG9lcyBzb3Vu
ZCBzYWZlci4NCj4gDQo+IE9yIHdlIHRha2UgYSBzdGVwIGJhY2sgYW5kIGFzayB3aHkgaXQncyBl
dmVuIGEgcHJvYmxlbSBmb3IgdGhlIG1pcnJvcg0KPiBibG9jayBqb2IgaWYgdGhlIEJsb2NrQmFj
a2VuZCBpcyBtb3ZlZCB0byBhIGRpZmZlcmVudCBub2RlLiBUaGUgbWFpbg0KPiByZWFzb24gSSBz
ZWUgaXMgYmVjYXVzZSBvZiBicy0+am9iIHRoYXQgaXMgc2V0IGZvciB0aGUgcm9vdCBub2RlIG9m
IHRoZQ0KPiBCbG9ja0JhY2tlbmQgYW5kIG5lZWRzIHRvIGJlIHVuc2V0IGZvciB0aGUgc2FtZSBu
b2RlLg0KPiANCj4gTWF5YmUgd2UgY2FuIGp1c3QgZmluYWxseSBnZXQgcmlkIG9mIGJzLT5qb2I/
IEl0IGRvZXNuJ3QgaGF2ZSBtYW55IHVzZXJzDQo+IGFueSBtb3JlLg0KPiANCg0KSG1tLCBsb29r
ZWQgYXQgaXQuIE5vdCBzdXJlIHdoYXQgc2hvdWxkIGJlIHJlZmFjdG9yZWQgYXJvdW5kIGpvYiB0
byBnZXQgcmlkDQpvZiAibWFpbiBub2RlIiBjb25jZXB0Li4gV2hpY2ggc2VlbXMgdG8gYmUgaW4g
YSBiYWQgcmVsYXRpb24gd2l0aCBzdGFydGluZw0Kam9iIG9uIGltcGxpY2l0IGZpbHRlcnMgYXMg
YSBtYWluIG5vZGUuLg0KDQpCdXQgYWJvdXQganVzdCByZW1vdmluZyBicy0+am9iIHBvaW50ZXIs
IEkgZG9uJ3Qga25vdyBhdCBsZWFzdCB3aGF0IHRvIGRvIHdpdGgNCmJsa19pb3N0YXR1c19yZXNl
dCBhbmQgYmxvY2tkZXZfbWFya19hdXRvX2RlbC4uDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpW
bGFkaW1pcg0K

