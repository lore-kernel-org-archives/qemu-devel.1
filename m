Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12BBC28CC6
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 17:17:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B590E206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 17:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="R4wmT4EG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B590E206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47467 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYZXs-0000wW-Sf
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 13:17:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYZWq-0000b4-EC
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 13:16:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYZWo-0003Sr-Ie
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 13:16:48 -0400
Received: from mail-vi1eur04on0725.outbound.protection.outlook.com
	([2a01:111:f400:fe0e::725]:65253
	helo=EUR04-VI1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hYZWj-0003IX-39; Wed, 05 Jun 2019 13:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=/f2wC4uDHcSIyb8V7B/Uzz/p0qlM3wbrx2GJEndrAUk=;
	b=R4wmT4EGcCDAg2B2tOD6AvfxIOT1fNcJNHg93gk1zm1YLF9sTEIghE8v0KB3UstUMaGYROYIZcP9BMptjBGj2lmv0vR7wpX7IGnCiCep+mycuH8Vf5Sm8/Ljs3cNumDyfZ9DMhwW18BimYPOd/KKl86EqH/cLVn4g2UCaHdkwmg=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
	AM0PR08MB3763.eurprd08.prod.outlook.com (20.178.82.152) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1943.22; Wed, 5 Jun 2019 17:16:36 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8]) by
	AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8%7]) with mapi id 15.20.1965.011;
	Wed, 5 Jun 2019 17:16:36 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH v2 2/2] blockjob: use blk_new_pinned in block_job_create
Thread-Index: AQHVG8HBVdfqD7RC9UWdIT2PxMi18aaNTVYA
Date: Wed, 5 Jun 2019 17:16:36 +0000
Message-ID: <1b1a0ec6-88c7-d7a5-3d95-bde310693580@virtuozzo.com>
References: <20190605123229.92848-1-vsementsov@virtuozzo.com>
	<20190605123229.92848-3-vsementsov@virtuozzo.com>
	<20190605171137.GC5491@linux.fritz.box>
In-Reply-To: <20190605171137.GC5491@linux.fritz.box>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0040.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::29)
	To AM0PR08MB2961.eurprd08.prod.outlook.com
	(2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190605201634392
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f98a7ebd-23f2-4c5f-2db3-08d6e9d990b3
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:AM0PR08MB3763; 
x-ms-traffictypediagnostic: AM0PR08MB3763:
x-microsoft-antispam-prvs: <AM0PR08MB376362123C506D91E4110AA0C1160@AM0PR08MB3763.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00594E8DBA
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(366004)(136003)(39850400004)(346002)(396003)(189003)(199004)(6486002)(305945005)(6916009)(7736002)(6512007)(36756003)(25786009)(6436002)(26005)(316002)(4326008)(66066001)(229853002)(256004)(478600001)(6116002)(86362001)(68736007)(386003)(6506007)(486006)(186003)(31686004)(3846002)(31696002)(2616005)(4744005)(11346002)(14454004)(102836004)(5660300002)(446003)(54906003)(476003)(2906002)(73956011)(71190400001)(6246003)(66476007)(71200400001)(66556008)(66446008)(64756008)(52116002)(76176011)(99286004)(81166006)(53936002)(8676002)(66946007)(8936002)(81156014);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3763;
	H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AQK254dK2LCx3/vJ4en6+dhFA/O872G0xc4Rcigqk5UM1m+oiojhxflf1oHpTz8Iw2252EbsCzd9VfLtgFdG2b/+6kpnqXHIpZVXYmYGP1kwmHWgFJF5+QQ8OXXx8lX/dT0mS99mkJ5bT6dYwPzQr48P3+vHQwCcp5BmZ7fGa15VGEfozj8YFk9ALZ6Un8+wJYDYEOeXX0bOs5B7DVWyT6j0byyz/pXa/+LMIbCqjloOD6MItm4l8ll3imTTuOPVKXvbn3T+p8a7oKuQDjMOiVoQAtMBB7/nk1bcYo/tV0h4dMj//EKSOCK2iF2YBj5znvDJfh82hUFiuOTQ6sDQ2chWsLfTKXjDOe9KARpSTwW9sdq6i13E/nzorcd+Wu13j/26ebLDmMMkBIUS9Sl1xYeBsD52EFtrvQYV8SyhDJI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23F435FF066DE44C8E092AFDC87100F1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f98a7ebd-23f2-4c5f-2db3-08d6e9d990b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2019 17:16:36.6419 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3763
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0e::725
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

MDUuMDYuMjAxOSAyMDoxMSwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMDUuMDYuMjAxOSB1bSAx
NDozMiBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IGNo
aWxkX3JvbGUgam9iIGFscmVhZHkgaGFzIC5zdGF5X2F0X25vZGU9dHJ1ZSwgc28gb24gYmRydl9y
ZXBsYWNlX25vZGUNCj4+IG9wZXJhdGlvbiB0aGVzZSBjaGlsZCBhcmUgdW5jaGFuZ2VkLiBNYWtl
IGJsb2NrIGpvYiBibGsgYmVoYXZlIGluIHNhbWUNCj4+IG1hbm5lciwgdG8gYXZvaWQgaW5jb25z
aXN0ZW50IGludGVybWVkaWF0ZSBncmFwaCBzdGF0ZXMgYW5kIHdvcmthcm91bmRzDQo+PiBsaWtl
IGluIG1pcnJvci4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dp
ZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+IA0KPiBUaGlzIGZlZWxzIGRhbmdl
cm91cy4gSXQgZG9lcyB3aGF0IHlvdSB3YW50IGl0IHRvIGRvIGlmIHRoZSBvbmx5IGdyYXBoDQo+
IGNoYW5nZSBiZWxvdyB0aGUgQmxvY2tCYWNrZW5kIGlzIHRoZSBvbmUgaW4gbWlycm9yX2V4aXRf
Y29tbW9uLiBCdXQgdGhlDQo+IHVzZXIgY291bGQgYWxzbyB0YWtlIGEgc25hcHNob3QsIG9yIGlu
IHRoZSBmdXR1cmUgaG9wZWZ1bGx5IGluc2VydCBhDQo+IGZpbHRlciBub2RlLCBhbmQgeW91IHdv
dWxkIHRoZW4gd2FudCB0aGUgQmxvY2tCYWNrZW5kIHRvIG1vdmUuDQo+IA0KPiBUbyBiZSBob25l
c3QsIGV2ZW4gQmRydkNoaWxkUm9sZS5zdGF5X2F0X25vZGUgaXMgYSBiaXQgb2YgYSBoYWNrLiBC
dXQgYXQNCj4gbGVhc3QgaXQncyBvbmx5IHVzZWQgZm9yIHBlcm1pc3Npb25zIGFuZCBub3QgZm9y
IHRoZSBhY3R1YWwgZGF0YSBmbG93Lg0KPiANCg0KSG1tLiBUaGFuLCBtYXkgYmUganVzdCBhZGQg
YSBwYXJhbWV0ZXIgdG8gYmRydl9yZXBsYWNlX25vZGUsIHdoaWNoIHBhcmVudHMNCnRvIGlnbm9y
ZT8gV291bGQgaXQgd29yaz8NCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

