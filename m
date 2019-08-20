Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF53C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 17:03:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF0722087E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 17:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Kn7HD7mU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0722087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i07XE-0006WJ-Pa
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 13:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i07WC-00064O-Kw
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 13:02:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i07WA-0000hv-Mi
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 13:02:00 -0400
Received: from mail-eopbgr50123.outbound.protection.outlook.com
 ([40.107.5.123]:3205 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1i07WA-0000gD-1A
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 13:01:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ex5+aBwnHR0OOeEh2toPqhYfgkgqff/F3tuSBpETSLQ3us2OLADXSeDxfBRCg4qLkuk3aD7PI48Ip8ABAyefVknj8gapKgJkgXj5+KfHHv9IWNqSEUdqkpqz2QiCX7nwz5GXnig5/4ZskPnjpefjv8FrF70Ucm60PligL85HVtIdZnNvK2Ml9eab0TKl7GWVzp0Ac6cj83re+Dd3NFEO/vCwKFIpWXGMg3NN4rNASgrc+UJmQJ4GBlGDAgmiHj03O++TeXxVm0GhG/JYEF3nQX6WQm8juidpMxhxe4gesHamnPYwgsLvWi9hYHipqhfGouFOY7nMODlZxmJmz+Ih1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/3StduAZcG4YdOSmgQEyT2LWuLo8eLylyaMEZU0RIo=;
 b=mFMoAf66aQqxumZE2rp7NSExkEibz7NPYo0e3leI2jkYDZaeeUvRSNZhgOPGuAg/Wl89J/aqe8kNfA5QeLT/Ctw0R7nbq80wi5Yu3Vo55bR5JSvPqeLjNStRpxNA/8B70OOjAPiEQAiYu/sNil3nMWJFK8sivz8FaJVuxTNmvBgHja7kRxxE60vGqc3VTBjbHUDejQnqnfdPs4lPGnA1OUzyqcKbsoB+EPsZ8xFe/HAVky5yzH1oqa3XIG10ejPjUSvgeg3QLMsYfxs4SdiwXLaRJYqKnzMgJ+hTi+Md3xj+8DvlSdef/TlE0TRkaFyWXvyZHsrz87Ez8v5OLwW+jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/3StduAZcG4YdOSmgQEyT2LWuLo8eLylyaMEZU0RIo=;
 b=Kn7HD7mUN9dM/88yDDEMdR4Z/7PP+vFSWxlu8HZx6trOft384q3R2rwe3ktgRakZA1z02y6iToYBkubMCKOpdtuQsNQo9eKQNMYIU7qTG2Chr+qO3TnOq10+e49ogXz9IKJ/GKosiFeVKGUyCruaACE8lIJyz7lAN6e+7+NPkqA=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB4061.eurprd08.prod.outlook.com (20.178.127.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Tue, 20 Aug 2019 17:01:54 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::303d:1bb9:76b2:99d7]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::303d:1bb9:76b2:99d7%6]) with mapi id 15.20.2157.022; Tue, 20 Aug 2019
 17:01:54 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Thread-Topic: [Qemu-devel] [PATCH] Fix: fp-test uninitialized member
 floatX::exp
Thread-Index: AQHVRr9xspCki27n+kGlF3NZYO6Lkab5QwaA///S3QCAC06JgA==
Date: Tue, 20 Aug 2019 17:01:54 +0000
Message-ID: <af72d680-f169-bdba-3b6e-d2da6b820aea@virtuozzo.com>
References: <1564481593-776647-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <573f907d-5016-60c1-c727-c5444a418e1b@virtuozzo.com>
 <8736i5ntlp.fsf@linaro.org>
In-Reply-To: <8736i5ntlp.fsf@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0401CA0066.eurprd04.prod.outlook.com
 (2603:10a6:3:19::34) To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: edd164f0-cf91-4fee-8ff3-08d725901a39
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB4061; 
x-ms-traffictypediagnostic: VI1PR08MB4061:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR08MB4061EF3CE7307B8554A9B495F4AB0@VI1PR08MB4061.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(136003)(376002)(39850400004)(396003)(199004)(189003)(44832011)(8676002)(305945005)(81156014)(446003)(66446008)(64756008)(66946007)(5660300002)(81166006)(66476007)(66556008)(86362001)(66574012)(53936002)(229853002)(71200400001)(71190400001)(6246003)(256004)(8936002)(36756003)(99286004)(19627235002)(66066001)(107886003)(6512007)(6486002)(11346002)(186003)(6116002)(3846002)(6506007)(54906003)(6436002)(386003)(316002)(102836004)(2616005)(4326008)(476003)(53546011)(486006)(14454004)(31696002)(76176011)(52116002)(7736002)(6916009)(2906002)(478600001)(25786009)(26005)(31686004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB4061;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ntPbJdKtZTQ5St2J1yp6Wn1VfogbhL1zHDmvE6kuD/nm4jyQxdlwt7lhpgp5kC0v2kHpy7oAugkKK9okdTElFdU5VWjbVd6qqtLZPkkPhEghJMJL7IWKCSPNNso5/VGk3dUvY2yfLuDuwFbjmrOeggOJ33d+hI1l2uawTdqD1+9tptcFzuwfNdn94vfC3V4pVJRMEujp/7qXVNJuXifz8qt0kNwfVRQWNjNC9xq+s8Q2thrL/mfuDsCyH6SPY9dUViEDfRXt4nR2UzTMMfR4MIkKdpgHghNZPz2sQz8cEJ4IDbUWvdwYlsCYuzdqNpCckqy2rZNNTs3PLE4WEn3E7AEj1ONcS3thLuVWYPGgCFsh2WdaZGASsVvtdScGcNknRyIeR1oVAziuMKKsvyo9uO7g3j4VBPAFrTGAaiv6Cq4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFD7060932B788479ABE79587FCF596B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd164f0-cf91-4fee-8ff3-08d725901a39
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 17:01:54.3391 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kvklyEDh89V0JbaYOjWckBmLKikSvHGyZ2AuRwJbpIztBNIrFaYAZTCTy1CBNZq9v9X5WURXUt67YOs9oTOkffD2BcOxaPnE5dxZqll2u90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4061
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.123
Subject: Re: [Qemu-devel] [PATCH] Fix: fp-test uninitialized member
 floatX::exp
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
Cc: Denis Lunev <den@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "jhauser@eecs.berkeley.edu" <jhauser@eecs.berkeley.edu>,
 "cota@braap.org" <cota@braap.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMTMvMDgvMjAxOSAxNToyMSwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiANCj4gQW5kcmV5IFNo
aW5rZXZpY2ggPGFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20+IHdyaXRlczoNCj4gDQo+
PiBQSU5HSU5HLi4uDQo+IA0KPiBTb3JyeSBhYm91dCB0aGUgZGVsYXkuIEkgZGlkIGF0dGVtcHQg
c2VlIGlmIHRoZSBleGlzdGluZyBjb2RlIHRocmV3IHVwDQo+IGFueSBlcnJvcnMgd2hlbiBidWls
dCB3aXRoIGNsYW5nJ3MgdW5kZWZpbmVkIHNhbml0aXplci4gSSB0aGluayB0aGlzIGlzDQo+IGJl
Y2F1c2UgeFB0ci0+ZXhwIHdpbGwgb25seSBnZXQgcmVhZCBpZiBub25lIG9mIHRoZSB4UHRyLT5p
c0ZPTyByZXR1cm5zDQo+IGZhbHNlLiBJbiBhbGwgdGhvc2UgY2FzZXMgeFB0ci0+ZXhwIGlzIHNl
dC4NCj4gDQo+IFdoYXQgcG9pbnRlZCB5b3UgdG93YXJkcyB0aGlzIG1pc3NpbmcgaW5pdGlhbGlz
YXRpb25zPw0KPiANCg0KSSBhbSBzb3JyeSBhYm91dCBtaXNzaW5nIHRoZSBtZXNzYWdlLiBJdCBh
cHBlYXJlZCBpbiBvdGhlciBlbWFpbCB0aHJlYWQgDQp3aGVyZSBJIGRpZG4ndCBleHBlY3QuIFNv
LCBJIG1pc3NlZCB0aGUgcmVzcG9uc2UuDQpXaGVuIEkgcmFuIHRoZSBmcC10ZXN0cyB1bmRlciB0
aGUgVmFsZ3JpbmQsIEkgZ290IGxvdHMgb2YgcmVwb3J0cyBhYm91dCANCnVzaW5nIHVuaW5pdGlh
bGl6ZWQgbWVtb3J5LiBUaGV5IGFsbCBkaXNhcHBlYXJlZCBhZnRlciBhcHBseWluZyB0aGlzIA0K
cGF0Y2guIEkgY29uY2x1ZGVkIHRoYXQgdGhlcmUgYXJlIHBhdGhzIHRoYXQgdXNlIHhQdHItPmV4
cCB1bmluaXRpYWxpemVkLg0KDQokIC91c3IvYmluL3ZhbGdyaW5kIC0tbGVhay1jaGVjaz1ubyAt
LXRyYWNlLWNoaWxkcmVuPXllcyANCi0ta2VlcC1zdGFja3RyYWNlcz1hbGxvYy1hbmQtZnJlZSAt
LXRyYWNrLW9yaWdpbnM9eWVzIA0KLS1sb2ctZmlsZT1teXFlbXUtJXAubG9nIG1ha2UgY2hlY2st
c29mdGZsb2F0DQoNCj09NzIwMjY4PT0gQ29uZGl0aW9uYWwganVtcCBvciBtb3ZlIGRlcGVuZHMg
b24gdW5pbml0aWFsaXNlZCB2YWx1ZShzKQ0KPT03MjAyNjg9PSAgICBhdCAweDExMkM3MjogZmxv
YXRYUm91bmRUb0ludCAoc2xvd2Zsb2F0LmM6MTM3MSkNCj09NzIwMjY4PT0gICAgYnkgMHgxMTU5
MjA6IHNsb3dfZjE2X3JvdW5kVG9JbnQgKHNsb3dmbG9hdC5jOjI0MDgpDQo9PTcyMDI2OD09ICAg
IGJ5IDB4MTMzQTg3OiB0ZXN0X2F6X2YxNl9yeCAodGVzdF9hel9mMTZfcnguYzo3MykNCj09NzIw
MjY4PT0gICAgYnkgMHgxMEU2MzU6IGRvX3Rlc3RmbG9hdCAoZnAtdGVzdC5jOjMwNCkNCj09NzIw
MjY4PT0gICAgYnkgMHgxMEZEMDI6IHJ1bl90ZXN0IChmcC10ZXN0LmM6MTAwMykNCj09NzIwMjY4
PT0gICAgYnkgMHgxMEZEQTQ6IG1haW4gKGZwLXRlc3QuYzoxMDE3KQ0KPT03MjAyNjg9PSAgVW5p
bml0aWFsaXNlZCB2YWx1ZSB3YXMgY3JlYXRlZCBieSBhIHN0YWNrIGFsbG9jYXRpb24NCj09NzIw
MjY4PT0gICAgYXQgMHgxMTU4RDM6IHNsb3dfZjE2X3JvdW5kVG9JbnQgKHNsb3dmbG9hdC5jOjI0
MDQpDQoNCj09NzIwMzExPT0gQ29uZGl0aW9uYWwganVtcCBvciBtb3ZlIGRlcGVuZHMgb24gdW5p
bml0aWFsaXNlZCB2YWx1ZShzKQ0KPT03MjAzMTE9PSAgICBhdCAweDExMkU1NDogZmxvYXRYQWRk
IChzbG93ZmxvYXQuYzoxNDExKQ0KPT03MjAzMTE9PSAgICBieSAweDExNUEyRDogc2xvd19mMTZf
c3ViIChzbG93ZmxvYXQuYzoyNDMxKQ0KPT03MjAzMTE9PSAgICBieSAweDEzM0NFQzogdGVzdF9h
YnpfZjE2ICh0ZXN0X2Fiel9mMTYuYzo3MCkNCj09NzIwMzExPT0gICAgYnkgMHgxMEU2RDU6IGRv
X3Rlc3RmbG9hdCAoZnAtdGVzdC5jOjMyNikNCj09NzIwMzExPT0gICAgYnkgMHgxMEZEMDI6IHJ1
bl90ZXN0IChmcC10ZXN0LmM6MTAwMykNCj09NzIwMzExPT0gICAgYnkgMHgxMEZEQTQ6IG1haW4g
KGZwLXRlc3QuYzoxMDE3KQ0KPT03MjAzMTE9PSAgVW5pbml0aWFsaXNlZCB2YWx1ZSB3YXMgY3Jl
YXRlZCBieSBhIHN0YWNrIGFsbG9jYXRpb24NCj09NzIwMzExPT0gICAgYXQgMHgxMTU5QzA6IHNs
b3dfZjE2X3N1YiAoc2xvd2Zsb2F0LmM6MjQyNSkNCg0KPT03MjAyNzM9PSBDb25kaXRpb25hbCBq
dW1wIG9yIG1vdmUgZGVwZW5kcyBvbiB1bmluaXRpYWxpc2VkIHZhbHVlKHMpDQo9PTcyMDI3Mz09
ICAgIGF0IDB4MTEzRDU0OiBmbG9hdFhFcSAoc2xvd2Zsb2F0LmM6MTY2MSkNCj09NzIwMjczPT0g
ICAgYnkgMHgxMTVFQUQ6IHNsb3dfZjE2X2VxX3NpZ25hbGluZyAoc2xvd2Zsb2F0LmM6MjUzOCkN
Cj09NzIwMjczPT0gICAgYnkgMHgxMzQxRDM6IHRlc3RfYWJfZjE2X3pfYm9vbCAodGVzdF9hYl9m
MTZfel9ib29sLmM6NzEpDQo9PTcyMDI3Mz09ICAgIGJ5IDB4MTBFN0RFOiBkb190ZXN0ZmxvYXQg
KGZwLXRlc3QuYzozNTgpDQo9PTcyMDI3Mz09ICAgIGJ5IDB4MTBGRDAyOiBydW5fdGVzdCAoZnAt
dGVzdC5jOjEwMDMpDQo9PTcyMDI3Mz09ICAgIGJ5IDB4MTBGREE0OiBtYWluIChmcC10ZXN0LmM6
MTAxNykNCj09NzIwMjczPT0gIFVuaW5pdGlhbGlzZWQgdmFsdWUgd2FzIGNyZWF0ZWQgYnkgYSBz
dGFjayBhbGxvY2F0aW9uDQo9PTcyMDI3Mz09ICAgIGF0IDB4MTE1RTM4OiBzbG93X2YxNl9lcV9z
aWduYWxpbmcgKHNsb3dmbG9hdC5jOjI1MzApDQoNCkV2ZW4gaWYgVmFsZ3JpbmQgaXMgd3Jvbmcs
IHRoZSBwdXJwb3NlIG9mIHRoZSBwYXRjaCBpcyB0byByZWR1Y2UgdGhlIA0KbnVtYmVyIG9mIGVy
cm9yIHJlcG9ydHMgZnJvbSB0aGUgVmFsZ3JpbmQgdG8gbG9jYXRlIG90aGVyIG1lbW9yeSBzZXJp
b3VzIA0KaXNzdWVzLCBpZiBhbnkuDQoNCkFuZHJleQ0KDQo+Pg0KPj4gT24gMzAvMDcvMjAxOSAx
MzoxMywgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+Pj4gTm90IGFsbCB0aGUgcGF0aHMgaW4g
dGhlIGZ1bmN0aW9ucywgc3VjaCBhcyBmMTZUb0Zsb2F0WCgpLCBpbml0aWFsaXplDQo+Pj4gdGhl
IG1lbWJlciAnZXhwJyBvZiB0aGUgc3RydWN0dXJlIGZsb2F0WC4NCj4+Pg0KPj4+IFNpZ25lZC1v
ZmYtYnk6IEFuZHJleSBTaGlua2V2aWNoIDxhbmRyZXkuc2hpbmtldmljaEB2aXJ0dW96em8uY29t
Pg0KPj4+IC0tLQ0KPj4+ICAgIHNvdXJjZS9zbG93ZmxvYXQuYyB8IDQgKysrKw0KPj4+ICAgIDEg
ZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS90ZXN0
cy9mcC9iZXJrZWxleS10ZXN0ZmxvYXQtMy9zb3VyY2Uvc2xvd2Zsb2F0LmMgYi90ZXN0cy9mcC9i
ZXJrZWxleS10ZXN0ZmxvYXQtMy9zb3VyY2Uvc2xvd2Zsb2F0LmMNCj4+PiBpbmRleCA0ZTg0NjU2
Li42ZTBmMGE2IDEwMDY0NA0KPj4+IC0tLSBhL3Rlc3RzL2ZwL2JlcmtlbGV5LXRlc3RmbG9hdC0z
L3NvdXJjZS9zbG93ZmxvYXQuYw0KPj4+ICsrKyBiL3Rlc3RzL2ZwL2JlcmtlbGV5LXRlc3RmbG9h
dC0zL3NvdXJjZS9zbG93ZmxvYXQuYw0KPj4+IEBAIC02MjMsNiArNjIzLDcgQEAgc3RhdGljIHZv
aWQgZjE2VG9GbG9hdFgoIGZsb2F0MTZfdCBhLCBzdHJ1Y3QgZmxvYXRYICp4UHRyICkNCj4+PiAg
ICAgICAgeFB0ci0+aXNJbmYgPSBmYWxzZTsNCj4+PiAgICAgICAgeFB0ci0+aXNaZXJvID0gZmFs
c2U7DQo+Pj4gICAgICAgIHhQdHItPnNpZ24gPSAoKHVpQSAmIDB4ODAwMCkgIT0gMCk7DQo+Pj4g
KyAgICB4UHRyLT5leHAgPSAwOw0KPj4+ICAgICAgICBleHAgPSB1aUE+PjEwICYgMHgxRjsNCj4+
PiAgICAgICAgc2lnNjQgPSB1aUEgJiAweDAzRkY7DQo+Pj4gICAgICAgIHNpZzY0IDw8PSA0NTsN
Cj4+PiBAQCAtNzU5LDYgKzc2MCw3IEBAIHN0YXRpYyB2b2lkIGYzMlRvRmxvYXRYKCBmbG9hdDMy
X3QgYSwgc3RydWN0IGZsb2F0WCAqeFB0ciApDQo+Pj4gICAgICAgIHhQdHItPmlzSW5mID0gZmFs
c2U7DQo+Pj4gICAgICAgIHhQdHItPmlzWmVybyA9IGZhbHNlOw0KPj4+ICAgICAgICB4UHRyLT5z
aWduID0gKCh1aUEgJiAweDgwMDAwMDAwKSAhPSAwKTsNCj4+PiArICAgIHhQdHItPmV4cCA9IDA7
DQo+Pj4gICAgICAgIGV4cCA9IHVpQT4+MjMgJiAweEZGOw0KPj4+ICAgICAgICBzaWc2NCA9IHVp
QSAmIDB4MDA3RkZGRkY7DQo+Pj4gICAgICAgIHNpZzY0IDw8PSAzMjsNCj4+PiBAQCAtODk1LDYg
Kzg5Nyw3IEBAIHN0YXRpYyB2b2lkIGY2NFRvRmxvYXRYKCBmbG9hdDY0X3QgYSwgc3RydWN0IGZs
b2F0WCAqeFB0ciApDQo+Pj4gICAgICAgIHhQdHItPmlzSW5mID0gZmFsc2U7DQo+Pj4gICAgICAg
IHhQdHItPmlzWmVybyA9IGZhbHNlOw0KPj4+ICAgICAgICB4UHRyLT5zaWduID0gKCh1aUEgJiBV
SU5UNjRfQyggMHg4MDAwMDAwMDAwMDAwMDAwICkpICE9IDApOw0KPj4+ICsgICAgeFB0ci0+ZXhw
ID0gMDsNCj4+PiAgICAgICAgZXhwID0gdWlBPj41MiAmIDB4N0ZGOw0KPj4+ICAgICAgICBzaWc2
NCA9IHVpQSAmIFVJTlQ2NF9DKCAweDAwMEZGRkZGRkZGRkZGRkYgKTsNCj4+PiAgICAgICAgaWYg
KCBleHAgPT0gMHg3RkYgKSB7DQo+Pj4gQEAgLTEyMjAsNiArMTIyMyw3IEBAIHN0YXRpYyB2b2lk
IGYxMjhNVG9GbG9hdFgoIGNvbnN0IGZsb2F0MTI4X3QgKmFQdHIsIHN0cnVjdCBmbG9hdFggKnhQ
dHIgKQ0KPj4+ICAgICAgICB4UHRyLT5pc1plcm8gPSBmYWxzZTsNCj4+PiAgICAgICAgdWlBNjQg
PSB1aUFQdHItPnY2NDsNCj4+PiAgICAgICAgeFB0ci0+c2lnbiA9ICgodWlBNjQgJiBVSU5UNjRf
QyggMHg4MDAwMDAwMDAwMDAwMDAwICkpICE9IDApOw0KPj4+ICsgICAgeFB0ci0+ZXhwID0gMDsN
Cj4+PiAgICAgICAgZXhwID0gdWlBNjQ+PjQ4ICYgMHg3RkZGOw0KPj4+ICAgICAgICBzaWcudjY0
ID0gdWlBNjQgJiBVSU5UNjRfQyggMHgwMDAwRkZGRkZGRkZGRkZGICk7DQo+Pj4gICAgICAgIHNp
Zy52MCAgPSB1aUFQdHItPnYwOw0KPj4+DQo+IA0KPiANCj4gLS0NCj4gQWxleCBCZW5uw6llDQo+
IA0KDQotLSANCldpdGggdGhlIGJlc3QgcmVnYXJkcywNCkFuZHJleSBTaGlua2V2aWNoDQoNCg==

