Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19BFC31E41
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 15:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 615AB20859
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 15:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="It8olAtU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615AB20859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47542 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haLrv-0004Y7-Fu
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 11:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41952)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1haLop-0003Go-Sy
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 11:02:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1haLoo-0007Nt-TO
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 11:02:43 -0400
Received: from mail-eopbgr40096.outbound.protection.outlook.com
 ([40.107.4.96]:4459 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1haLol-0007J1-Kk; Mon, 10 Jun 2019 11:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sY5FPROVctMFmPk2DfdhuyPFelZ5qVHZuSAnxTaBdD0=;
 b=It8olAtUuh0pEQ17GvP5NYA0VEc8PGwVk/NWMcZ22/veF67Fbn8wK0z2g8UJh/j2XW2QWLdhfx8ZF0ZGVaN1T+P3uYEYydLhh/1mGnnzDLuKPvaV9RtJdW5/wfjBeUtX/L6723kkj/OyXqf8E8mcRkaGaTiflXPCgEVuXFi03VI=
Received: from VI1PR08MB3677.eurprd08.prod.outlook.com (20.177.61.92) by
 VI1PR08MB3133.eurprd08.prod.outlook.com (52.133.15.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Mon, 10 Jun 2019 15:02:36 +0000
Received: from VI1PR08MB3677.eurprd08.prod.outlook.com
 ([fe80::3826:4d4e:cf5f:81e5]) by VI1PR08MB3677.eurprd08.prod.outlook.com
 ([fe80::3826:4d4e:cf5f:81e5%7]) with mapi id 15.20.1965.017; Mon, 10 Jun 2019
 15:02:35 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 1/7] iotests: allow Valgrind checking all
 QEMU processes
Thread-Index: AQHVHvIvEMHPyV1qtEaivy+55tEanqaU8mmAgAAKwQA=
Date: Mon, 10 Jun 2019 15:02:35 +0000
Message-ID: <786c3499-9bb4-0fa6-a4f1-f7537be73712@virtuozzo.com>
References: <1560105348-459129-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1560105348-459129-2-git-send-email-andrey.shinkevich@virtuozzo.com>
 <96a6fd48-9e84-1285-1932-3ce1736cd08c@redhat.com>
In-Reply-To: <96a6fd48-9e84-1285-1932-3ce1736cd08c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0151.eurprd05.prod.outlook.com
 (2603:10a6:7:28::38) To VI1PR08MB3677.eurprd08.prod.outlook.com
 (2603:10a6:803:85::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25f0b93e-79a4-49e8-10e8-08d6edb4abc5
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB3133; 
x-ms-traffictypediagnostic: VI1PR08MB3133:
x-microsoft-antispam-prvs: <VI1PR08MB3133E582EE5AB2B1DE0F0641F4130@VI1PR08MB3133.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0064B3273C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39840400004)(366004)(396003)(376002)(346002)(189003)(199004)(6246003)(66066001)(14454004)(107886003)(66476007)(186003)(486006)(44832011)(4326008)(8936002)(2906002)(6436002)(11346002)(26005)(316002)(71200400001)(6486002)(476003)(2616005)(71190400001)(446003)(53546011)(386003)(6506007)(2501003)(31686004)(3846002)(6116002)(7736002)(76176011)(64756008)(5660300002)(110136005)(25786009)(2201001)(52116002)(66946007)(73956011)(256004)(68736007)(86362001)(6512007)(99286004)(81166006)(54906003)(81156014)(36756003)(53936002)(478600001)(229853002)(8676002)(31696002)(66556008)(66446008)(305945005)(102836004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3133;
 H:VI1PR08MB3677.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DJzTA1R+iRRjF0dVt05q4oKLbDGEbbkrKY4ZF9p0qNNZpaeGSa8m7gsXg8tkA/1QWj5lUr+VSXs4b5EKLEzswF4xgJ6AfhYbre5bHyl5zjBkAOyOIW97s67G7Gqa+bDCSO+0rMY+kXOznmHq64DfUAh25fOgFwSBy8z9Z02K2pRYIu/3lwrZEHk2QjQXdHCsyfcVCXaVf1iF8k8y/L96UN+eJ9z+U2W43luWU/J+bg5J8oKN5rzyhM1ZusjMLImb8kFJByOJkntModaBQOcgKr2NA3ZP9TI/Jpb9tK/Ht8OBkHaMDnm1w0WP7adSOvyaBNAKoN4kNziNhjkdhZbIZj7cIinTT1ydOlvbeD7xBkruA9FAuVrh4H8h4tk5KrYBDm3D9OL+kdACHfUXjWqTfbM+hQxCL/B1v5VTeWwi+04=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32B2BF6E8503F2458E2BB41DC0DD293E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f0b93e-79a4-49e8-10e8-08d6edb4abc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2019 15:02:35.5146 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andrey.shinkevich@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3133
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.96
Subject: Re: [Qemu-devel] [PATCH 1/7] iotests: allow Valgrind checking all
 QEMU processes
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Roman Kagan <rkagan@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDEwLzA2LzIwMTkgMTc6MjQsIEVyaWMgQmxha2Ugd3JvdGU6DQo+IE9uIDYvOS8xOSAx
OjM1IFBNLCBBbmRyZXkgU2hpbmtldmljaCB3cm90ZToNCj4+IFdpdGggdGhlICctdmFsZ3JpbmQn
IG9wdGlvbiwgbGV0IGFsbCB0aGUgUUVNVSBwcm9jZXNzZXMgYmUgcnVuIHVuZGVyDQo+PiB0aGUg
VmFsZ3JpbmQgdG9vbC4gVGhlIFZhbGdyaW5kIG93biBwYXJhbWV0ZXJzIG1heSBiZSBzZXQgd2l0
aCBpdHMNCj4+IGVudmlyb25tZW50IHZhcmlhYmxlIFZBTEdSSU5EX09QVFMsIGUuZy4NCj4+IFZB
TEdSSU5EX09QVFM9Ii0tbGVhay1jaGVjaz15ZXMiIC4vY2hlY2sgLXFjb3cyIC12YWxncmluZCA8
dGVzdCM+DQo+IA0KPiBMZXQncyBzcGVsbCB0aGlzIC0tdmFsZ3JpbmQ7IGxvbmcgb3B0aW9ucyBz
aG91bGQgcHJlZmVyIHRoZSB1c2Ugb2YgLS0NCj4gKGFzIGluIGdldG9wdF9sb25nKSwgd2hldGhl
ciBvciBub3Qgd2UgYWxzbyBoYXZlIGEgcmVhc29uIHRvIHN1cHBvcnQNCj4gLXZhbGdyaW5kIChh
cyBpbiBnZXRvcHRfbG9uZ19vbmx5KS4gWWVzLCBxZW11IGlzIGFuIG9kZGJhbGwgaW4gdGhpcw0K
PiByZWdhcmRzLCBidXQgbm8gbmVlZCB0byBtYWtlIGl0IHdvcnNlLg0KPiANCg0KVGhhbmsgeW91
LCBFcmljLiBUaGF0IHNvdW5kcyBnb29kIGJ1dCB0aGUgc2hvcnQgb3B0aW9uJy12YWxncmluZCcg
aXMNCnByZWV4aXN0aW5nIGluIFFFTVUuIFNob3VsZCBJIGNyZWF0ZSBhIG5ldyBwYXRjaCBmb3Ig
dGhlIGxvbmcgb3B0aW9uPw0KSWYgc28sIHdpbGwgd2UgaGF2ZSBib3RoIG9wdGlvbnMgc3VwcG9y
dGVkIGJ5IFFFTVU/DQpBbmRyZXkNCg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBTaGlu
a2V2aWNoIDxhbmRyZXkuc2hpbmtldmljaEB2aXJ0dW96em8uY29tPg0KPj4gLS0tDQo+PiAgIHRl
c3RzL3FlbXUtaW90ZXN0cy9jb21tb24ucmMgfCA2NSArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNDggaW5zZXJ0aW9ucygr
KSwgMTcgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3FlbXUtaW90ZXN0
cy9jb21tb24ucmMgYi90ZXN0cy9xZW11LWlvdGVzdHMvY29tbW9uLnJjDQo+PiBpbmRleCA5M2Y4
NzM4Li4zY2FhY2E0IDEwMDY0NA0KPiANCj4gDQoNCi0tIA0KV2l0aCB0aGUgYmVzdCByZWdhcmRz
LA0KQW5kcmV5IFNoaW5rZXZpY2gNCg==

