Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD32CC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 11:36:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C260208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 11:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HNTpvYaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C260208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59868 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heHq1-0004Mo-PE
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 07:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48855)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1heHkI-0000Rk-IA
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1heHk9-0004se-A8
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:15 -0400
Received: from mail-eopbgr30109.outbound.protection.outlook.com
 ([40.107.3.109]:1511 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1heHju-0004ZQ-1m; Fri, 21 Jun 2019 07:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eKPQi2k/GkzdEP+OPrRE50TYaNe0Tp1CdouPHjJ1Ug=;
 b=HNTpvYaXhbimfOblXjmqGFZDhLdZ3b9kUMFypDKzmbBjDjdFUflWLix4TJQs0lTciqK4SXhxGh/S5HkOeBYQbGFLoezyaGCwgBi8NoVRs4w3KmXjte69ZTBJ/NyDm7q4VwkYr8nZonA8uy0j/LPuB7nyBc+53/2wjHEH0m8yoic=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB4839.eurprd08.prod.outlook.com (20.179.46.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.15; Fri, 21 Jun 2019 11:29:51 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 11:29:51 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH 02/12] block/backup: Add mirror sync mode 'bitmap'
Thread-Index: AQHVJwQQfgfUJEb/J0qbIg0NUKBsqqal+zsA
Date: Fri, 21 Jun 2019 11:29:50 +0000
Message-ID: <cb178623-e7a3-2d20-f193-9630257d9c3c@virtuozzo.com>
References: <20190620010356.19164-1-jsnow@redhat.com>
 <20190620010356.19164-3-jsnow@redhat.com>
In-Reply-To: <20190620010356.19164-3-jsnow@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR02CA0109.eurprd02.prod.outlook.com
 (2603:10a6:7:29::38) To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190621142948061
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25906e33-1718-49ca-2136-08d6f63bc609
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4839; 
x-ms-traffictypediagnostic: DBBPR08MB4839:
x-microsoft-antispam-prvs: <DBBPR08MB48398AC78CB71F6DF9A0B782C1E70@DBBPR08MB4839.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(376002)(39850400004)(346002)(136003)(199004)(189003)(2201001)(4326008)(6506007)(71190400001)(52116002)(386003)(99286004)(2501003)(71200400001)(102836004)(25786009)(486006)(14454004)(305945005)(6116002)(86362001)(186003)(31696002)(256004)(476003)(66446008)(7416002)(110136005)(64756008)(316002)(11346002)(68736007)(7736002)(2616005)(446003)(3846002)(76176011)(6246003)(66556008)(5660300002)(66946007)(8936002)(73956011)(66476007)(8676002)(478600001)(81156014)(81166006)(26005)(36756003)(2906002)(54906003)(6486002)(66066001)(53936002)(6436002)(31686004)(229853002)(6512007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4839;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5opPeT387Vn0sWx3dibOg7s867MGvTyrdlqKK4CEOW2HuS9IvIuLboToPxZiYRM5Aubq9DzRWDQrMWVJ5cmjXNV3JXzcph0tEYQVdscUsw6cJ6PJ4nikWHSehFRwvY9qdFPMC+C1OuvcUpCy65ulAdbFtp3zJoJqBoFNJjNhjWIUgoUk1pO6JcS1x3I/O7IznZqnljaUBVjsm/wvRTLJmQFzxCRIRTUgzwlkigNIvrFBP1w2Xvo8U7WV7BlxbOPFBFqDxn5Qbp7X/YAL/nSZUwr+2bGPHLh3fvH7Z6O6qpSFTI5tlD9T9BxvzMI82URbhcoPdAq0Yj8+RzEIh+LszRO4WpoiUanszV1xQ78i+VWYTst8VFtwbHsUn4+0uek352h564ogVtQZjdATwF4J+aQjqmYiZzhMS6Q5AEbaa6E=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20678CF4507ECE4C97BA73872AF40232@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25906e33-1718-49ca-2136-08d6f63bc609
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 11:29:50.9871 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4839
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.109
Subject: Re: [Qemu-devel] [PATCH 02/12] block/backup: Add mirror sync mode
 'bitmap'
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjAuMDYuMjAxOSA0OjAzLCBKb2huIFNub3cgd3JvdGU6DQo+IFdlIGRvbid0IG5lZWQgb3Igd2Fu
dCBhIG5ldyBzeW5jIG1vZGUgZm9yIHNpbXBsZSBkaWZmZXJlbmNlcyBpbg0KPiBzZW1hbnRpY3Mu
ICBDcmVhdGUgYSBuZXcgbW9kZSBzaW1wbHkgbmFtZWQgIkJJVE1BUCIgdGhhdCBpcyBkZXNpZ25l
ZCB0bw0KPiBtYWtlIHVzZSBvZiB0aGUgbmV3IEJpdG1hcCBTeW5jIE1vZGUgZmllbGQuDQo+IA0K
PiBCZWNhdXNlIHRoZSBvbmx5IGJpdG1hcCBtb2RlIGlzICdjb25kaXRpb25hbCcsIHRoaXMgYWRk
cyBubyBuZXcNCj4gZnVuY3Rpb25hbGl0eSB0byB0aGUgYmFja3VwIGpvYiAoeWV0KS4gVGhlIG9s
ZCBpbmNyZW1lbnRhbCBiYWNrdXAgbW9kZQ0KPiBpcyBtYWludGFpbmVkIGFzIGEgc3ludGFjdGlj
IHN1Z2FyIGZvciBzeW5jPWJpdG1hcCwgbW9kZT1jb25kaXRpb25hbC4NCj4gDQo+IEFkZCBhbGwg
b2YgdGhlIHBsdW1iaW5nIG5lY2Vzc2FyeSB0byBzdXBwb3J0IHRoaXMgbmV3IGluc3RydWN0aW9u
Lg0KDQpJIGRvbid0IGZvbGxvdywgd2h5IHlvdSBkb24ndCB3YW50IHRvIGp1c3QgYWRkIGJpdG1h
cC1tb2RlIG9wdGlvbmFsIHBhcmFtZXRlcg0KZm9yIGluY3JlbWVudGFsIG1vZGU/DQoNCkZvciB0
aGlzIGFsbCBsb29rcyBzaW1pbGFyIHRvIGp1c3QgdHdvIHNlcGFyYXRlIHRoaW5nczoNCjEuIGFk
ZCBiaXRtYXAtbW9kZSBwYXJhbWV0ZXINCjIuIHJlbmFtZSBpbmNyZW1lbnRhbCB0byBiaXRtYXAN
Cg0KV2h5IGRvIHdlIG5lZWQgWzIuXSA/DQpJZiB3ZSBkbyBvbmx5IFsxLl0sIHdlJ2xsIGF2b2lk
IGNyZWF0aW5nIHR3byBzaW1pbGFyIG1vZGVzLCBzeW50YXggc3VnYXIsIGEgYml0DQpvZiBtZXNz
IGFzIGl0IHNlZW1zIHRvIG1lLi4NCg0KSG1tLCBhYm91dCBkaWZmZXJlbnRpYWwgYmFja3Vwcywg
YXMgSSB1bmRlcnN0b29kLCB3ZSBjYWxsICdkaWZmZXJlbnRpYWwnIGFuIGluY3JlbWVudGFsDQpi
YWNrdXAsIGJ1dCB3aGljaCBjb25zaWRlcnMgZGlmZmVyZW5jZSBub3QgZnJvbSBsYXRlc3QgaW5j
cmVtZW50YWwgYmFja3VwIGJ1dCBmcm9tIHNvbWUNCmluIHRoZSBwYXN0Li4gSXMgaXQgaW5jb3Jy
ZWN0Pw0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

