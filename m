Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBFDC46470
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:55:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A4532173B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DBjMgPZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4532173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54399 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ7gT-0003k9-OP
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 05:55:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hQ7ey-0002hh-5I
	for qemu-devel@nongnu.org; Mon, 13 May 2019 05:54:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hQ7ex-0002Po-4s
	for qemu-devel@nongnu.org; Mon, 13 May 2019 05:54:16 -0400
Received: from mail-eopbgr90107.outbound.protection.outlook.com
	([40.107.9.107]:32096
	helo=FRA01-MR2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hQ7eu-0002OJ-Dh; Mon, 13 May 2019 05:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=pZT5Y868FzIDLFc1NE7Nyp5A2TtWv42v9mdIpa6ODbQ=;
	b=DBjMgPZOB7uWC7Mq5422UY7+JNHJaXsU9OW1qq+hI+P+9VQSO/J3Oimwx301Lf0i/I5WXbAzKpdpoiy6Ump+9U1RIf++VIPaJVCLTdRYXf4/dhco5RecvS5jPMYHtA1+aSC1Zp0Rz+XuvuGeP0zFgIFz1tL0UE8bq9zI+yMbe/k=
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com (52.133.109.209) by
	PR2PR08MB4747.eurprd08.prod.outlook.com (52.133.111.74) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1878.20; Mon, 13 May 2019 09:54:09 +0000
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::9c35:2e89:30c4:5cc4]) by
	PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::9c35:2e89:30c4:5cc4%3]) with mapi id 15.20.1878.024;
	Mon, 13 May 2019 09:54:09 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v7 5/5] block/backup: refactor: split out
	backup_calculate_cluster_size
Thread-Index: AQHU/mspfBUyWvOWD0q2CKRjL9XE26ZjBzWAgAXfjwA=
Date: Mon, 13 May 2019 09:54:08 +0000
Message-ID: <e2d76438-1454-97a2-91b6-47f95941a022@virtuozzo.com>
References: <20190429090842.57910-1-vsementsov@virtuozzo.com>
	<20190429090842.57910-6-vsementsov@virtuozzo.com>
	<b0604566-ec0d-a072-ce5d-713369af6c4c@redhat.com>
In-Reply-To: <b0604566-ec0d-a072-ce5d-713369af6c4c@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0301CA0011.eurprd03.prod.outlook.com
	(2603:10a6:3:76::21) To PR2PR08MB4684.eurprd08.prod.outlook.com
	(2603:10a6:101:22::17)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190513125406168
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2374dcd7-38fe-40c0-6ad1-08d6d788f15f
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:PR2PR08MB4747; 
x-ms-traffictypediagnostic: PR2PR08MB4747:
x-microsoft-antispam-prvs: <PR2PR08MB474743246234D4C93B3BA1CAC10F0@PR2PR08MB4747.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(39840400004)(376002)(396003)(346002)(136003)(189003)(199004)(99286004)(2616005)(31696002)(53936002)(2906002)(76176011)(52116002)(2201001)(2501003)(476003)(4744005)(486006)(66066001)(478600001)(305945005)(7736002)(8676002)(81156014)(8936002)(81166006)(6116002)(86362001)(3846002)(5660300002)(53546011)(386003)(66446008)(4326008)(68736007)(25786009)(446003)(6512007)(102836004)(186003)(71190400001)(26005)(6436002)(6506007)(71200400001)(6486002)(64756008)(66556008)(66476007)(73956011)(66946007)(31686004)(6246003)(229853002)(316002)(107886003)(54906003)(36756003)(11346002)(110136005)(256004)(14454004);
	DIR:OUT; SFP:1102; SCL:1; SRVR:PR2PR08MB4747;
	H:PR2PR08MB4684.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ydKqha6QdA7+2Wylmxk5+GE3YvciTI+/IKSMrA1OHd3BsbKEgUF3kfa+l4r67pxa1sDTGb0Wh4QU180d/o97wFvjh/a1/D7/ujWAX10Rr0MbT27ynq9pGzUM7Y05pIaw34wy90aoogYZat53bbhRZQ1ILsv89eijXRQeA6C0t7ScHkjjA9rus/tdkfd3Q7OwNHt8QQwwomLvuEs4h/HQBFKle3mtPWQxu7TtMOY9i2xqXDml0z3rMtxF8DcSgaSe0UE+9XeSTRQ2RNn1pC8JsgU3WJRtAjsWpNEGtOfyxYRqUeH9bBVDdYgItP/ENiBLgir5mSOGs4bPRhi5Uu2lcy3mIIn9BACif603cZknLgxHT3lnPej0x8gRcRIXn+nzFkq4c/S28hg/E8x2sv1hK82WQPwjVNIJdOLY2sk5ogw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB1696D3CFAD3D49B4EC9F45B525E424@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2374dcd7-38fe-40c0-6ad1-08d6d788f15f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 09:54:08.9683 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4747
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.9.107
Subject: Re: [Qemu-devel] [PATCH v7 5/5] block/backup: refactor: split out
 backup_calculate_cluster_size
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
	"jsnow@redhat.com" <jsnow@redhat.com>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDkuMDUuMjAxOSAxOToxMiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyOS4wNC4xOSAxMTowOCwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IFNwbGl0IG91dCBjbHVzdGVy
X3NpemUgY2FsY3VsYXRpb24uIE1vdmUgY29weS1iaXRtYXAgY3JlYXRpb24gYWJvdmUNCj4+IGJs
b2NrLWpvYiBjcmVhdGlvbiwgYXMgd2UgYXJlIGdvaW5nIHRvIHNoYXJlIGl0IHdpdGggdXBjb21p
bmcNCj4+IGJhY2t1cC10b3AgZmlsdGVyLCB3aGljaCBhbHNvIHNob3VsZCBiZSBjcmVhdGVkIGJl
Zm9yZSBhY3R1YWwgYmxvY2sgam9iDQo+PiBjcmVhdGlvbi4NCj4+DQo+PiBBbHNvLCB3aGlsZSBi
ZWluZyBoZXJlLCBkcm9wIHVubmVjZXNzYXJ5ICJnb3RvIGVycm9yIiBmcm9tDQo+PiBiZHJ2X2dl
dGxlbmd0aCBlcnJvciBwYXRoLg0KPiANCj4gVGhpcyBwYXJhZ3JhcGggc2hvdWxkIGJlIGRyb3Bw
ZWQgbm93LiAgRG8geW91IG1pbmQgbWUgZG9pbmcgaXQ/DQo+IA0KDQpPZiBjb3Vyc2UsIGRvbid0
IG1pbmQpDQoNCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

