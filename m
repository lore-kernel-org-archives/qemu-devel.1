Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88810C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 18:52:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DA36208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 18:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QTnbyaT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA36208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50890 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZJy8-0004QD-5F
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 14:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55712)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hZINc-0006yz-NA
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 13:10:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hZINb-0000Lq-DB
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 13:10:16 -0400
Received: from mail-eopbgr10134.outbound.protection.outlook.com
 ([40.107.1.134]:52966 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hZINW-0008E5-DX; Fri, 07 Jun 2019 13:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+BgjoR6nNaiyMkXMCvrIH8igKvN/G5W8XXaN4rVMKk=;
 b=QTnbyaT0E8+h7Gma6AJ3MK8l7n5ji6Fhwa1agH201bkSnCSudeTALKq0wYd+q2QC6owdsldZlCVMe2paTaoSqSWEH/8809jrWHHRyc3wuBmgF/1xO+jR4EgcZqzxk1xos2qY3vm3b0dAKBLFFClaIaul4UW5HtazLnYwbV8C/Oo=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
 AM0PR08MB3442.eurprd08.prod.outlook.com (20.177.108.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Fri, 7 Jun 2019 17:10:02 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
 ([fe80::8d90:32ae:bdd6:48e8]) by AM0PR08MB2961.eurprd08.prod.outlook.com
 ([fe80::8d90:32ae:bdd6:48e8%7]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 17:10:02 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH v6 5/7] qemu-coroutine-sleep: introduce qemu_co_sleep_wake
Thread-Index: AQHU8IvPncRKmUnNFESi2c9mvKXDwqaQLEMAgAA4CACAAB0MAIAAL54AgAAVoAA=
Date: Fri, 7 Jun 2019 17:10:02 +0000
Message-ID: <974c3f2d-e353-795a-8ca9-134447a311ec@virtuozzo.com>
References: <20190411172709.205032-1-vsementsov@virtuozzo.com>
 <20190411172709.205032-6-vsementsov@virtuozzo.com>
 <20190607075740.GA5055@dhcp-200-226.str.redhat.com>
 <16b7ad42-611c-fc3e-2029-d491882b0750@virtuozzo.com>
 <20190607130210.GC5055@dhcp-200-226.str.redhat.com>
 <4e970256-1eb1-2d12-5d40-13341fd0890b@virtuozzo.com>
In-Reply-To: <4e970256-1eb1-2d12-5d40-13341fd0890b@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0060.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::28) To AM0PR08MB2961.eurprd08.prod.outlook.com
 (2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190607200959939
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 261f5d27-cf3d-47e2-807b-08d6eb6afa6c
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB3442; 
x-ms-traffictypediagnostic: AM0PR08MB3442:
x-microsoft-antispam-prvs: <AM0PR08MB34421C7773618559C72A4812C1100@AM0PR08MB3442.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(346002)(366004)(39850400004)(376002)(189003)(199004)(107886003)(3846002)(68736007)(476003)(6116002)(66946007)(229853002)(6246003)(52116002)(73956011)(66446008)(64756008)(66556008)(66476007)(305945005)(7736002)(6436002)(36756003)(66066001)(2906002)(53936002)(4326008)(99286004)(25786009)(6486002)(486006)(478600001)(6512007)(71200400001)(71190400001)(8676002)(102836004)(81166006)(256004)(54906003)(316002)(8936002)(26005)(11346002)(446003)(76176011)(2616005)(6916009)(31686004)(31696002)(86362001)(386003)(6506007)(14454004)(5660300002)(186003)(81156014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3442;
 H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fElKtFvxkaa8ssoacrvWEzJFOxX7N0uaD20N1jPwkomgxxFgsAlFd0kLfHe1JkDUGgTgE+jylrZw65cknm2pXVW7ZbpkC4ymfFu360YCpW/qVosqlwcaAI/qiaH8zqtfoxqwsbVc78dWtQPpUGdO1FClLzOcSaNQD7HER5CQGwU68Lm4HeYNgXt5ieSwZDjlCJZlOQxIDSFzECeClpsIQNFx5OGRIk6sstp+vc5F0lxG14VwGsoUy56LvE2NI6QpY1HDSlH3M7P+Xvm3NJOfh5Z3Wfce0A50+4hc0hWc6f4REyajLvi1mgeQWOZP+KvdcqsLV5ORDGJJhn13a8oGJ6iAZFFjPnCuv/J/qTllRwBI0/v0SGr802iqZgsckBbPWtdZfg5aL58vFM+XlyAPcYqjXyjZ/NzrKSdSH/rwFfs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5FE1845EE60A14F91E69945BD221633@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 261f5d27-cf3d-47e2-807b-08d6eb6afa6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 17:10:02.3587 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3442
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.134
Subject: Re: [Qemu-devel] [PATCH v6 5/7] qemu-coroutine-sleep: introduce
 qemu_co_sleep_wake
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
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDcuMDYuMjAxOSAxODo1MiwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MDcuMDYuMjAxOSAxNjowMiwgS2V2aW4gV29sZiB3cm90ZToNCj4+IEFtIDA3LjA2LjIwMTkgdW0g
MTM6MTggaGF0IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgZ2VzY2hyaWViZW46DQo+Pj4g
MDcuMDYuMjAxOSAxMDo1NywgS2V2aW4gV29sZiB3cm90ZToNCj4+Pj4gQW0gMTEuMDQuMjAxOSB1
bSAxOToyNyBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+
Pj4+IEludHJvZHVjZSBhIGZ1bmN0aW9uIHRvIGdyYWNlZnVsbHkgd2FrZS11cCBhIGNvcm91dGlu
ZSwgc2xlZXBpbmcgaW4NCj4+Pj4+IHFlbXVfY29fc2xlZXBfbnMoKSBzbGVlcC4NCj4+Pj4+DQo+
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50
c292QHZpcnR1b3p6by5jb20+DQo+Pj4+DQo+Pj4+IFlvdSBjYW4gc2ltcGx5IHJlZW50ZXIgdGhl
IGNvcm91dGluZSB3aGlsZSBpdCBoYXMgeWllbGRlZCBpbg0KPj4+PiBxZW11X2NvX3NsZWVwX25z
KCkuIFRoaXMgaXMgc3VwcG9ydGVkLg0KPj4+DQo+Pj4gTm8gaXQgZG9lc24ndC4gcWVtdV9haW9f
Y29yb3V0aW5lX2VudGVyIGNoZWNrcyBmb3Igc2NoZWR1bGVkIGZpZWxkLA0KPj4+IGFuZCBhYm9y
dHMgaWYgaXQgaXMgc2V0Lg0KPj4NCj4+IEFoLCB5ZXMsIGl0IGhhcyBiZWVuIGJyb2tlbiBzaW5j
ZSBjb21taXQNCj4+DQo+PiBJIGFjdHVhbGx5IHRyaWVkIHRvIGZpeCBpdCBvbmNlLCBidXQgaXQg
dHVybmVkIG91dCBtb3JlIGNvbXBsaWNhdGVkIGFuZA0KPj4gSSB0aGluayB3ZSBmb3VuZCBhIGRp
ZmZlcmVudCBzb2x1dGlvbiBmb3IgdGhlIHByb2JsZW0gYXQgaGFuZDoNCj4+DQo+PiDCoMKgwqDC
oCBTdWJqZWN0OiBbUEFUQ0ggZm9yLTIuMTEgMC80XSBGaXggcWVtdS1pb3Rlc3RzIGZhaWx1cmVz
DQo+PiDCoMKgwqDCoCBNZXNzYWdlLUlkOiA8MjAxNzExMjgxNTQzNTAuMjE1MDQtMS1rd29sZkBy
ZWRoYXQuY29tPg0KPj4NCj4+IEluIHRoaXMgY2FzZSwgSSBndWVzcyB5b3VyIGFwcHJvYWNoIHdp
dGggYSBuZXcgZnVuY3Rpb24gdG8gaW50ZXJydXB0DQo+PiBxZW11X2NvX3NsZWVwX25zKCkgaXMg
b2theS4NCj4+DQo+PiBEbyB3ZSBuZWVkIHRvIHRpbWVyX2RlbCgpIHdoZW4gdGFraW5nIHRoZSBz
aG9ydGN1dD8gV2UgZG9uJ3QgbmVjZXNzYXJpbHkNCj4+IHJlZW50ZXIgdGhlIGNvcm91dGluZSBp
bW1lZGlhdGVseSwgYnV0IG1pZ2h0IG9ubHkgYmUgc2NoZWR1bGluZyBpdC4gSW4NCj4+IHRoaXMg
Y2FzZSwgdGhlIHRpbWVyIGNvdWxkIGZpcmUgYmVmb3JlIHFlbXVfY29fc2xlZXBfbnMoKSBoYXMg
cnVuIGFuZA0KPj4gc2NoZWR1bGUgdGhlIGNvcm91dGluZSBhIHNlY29uZCB0aW1lDQo+IA0KPiBO
byBpdCB3aWxsIG5vdCwgYXMgd2UgZG8gY21weGNoZywgc2NoZWR1bGVkIHRvIE5VTEwsIHNvIHNl
Y29uZCBjYWxsIHdpbGwgZG8NCj4gbm90aGluZy4uDQo+IA0KPiBCdXQgaXQgc2VlbXMgdW5zYWZl
LCBhcyBldmVuIGNvcm91dGluZSBwb2ludGVyIG1heSBiZSBzdGFsZSB3aGVuIHdlIGNhbGwNCj4g
cWVtdV9jb19zbGVlcF93YWtlIHNlY29uZCB0aW1lLiBTbywgd2UgcG9zc2libHkgc2hvdWxkIHJl
bW92ZSB0aW1lciwgYnV0IC4uDQo+IA0KPiAgwqAoaWdub3JpbmcgY28tPnNjaGVkdWxlZCBhZ2Fp
biAtDQo+PiBtYXliZSB3ZSBzaG91bGQgYWN0dWFsbHkgbm90IGRvIHRoYXQgaW4gdGhlIHRpbWVy
IGNhbGxiYWNrIHBhdGgsIGJ1dA0KPj4gaW5zdGVhZCBsZXQgaXQgcnVuIGludG8gdGhlIGFzc2Vy
dGlvbiBiZWNhdXNlIGl0IHdvdWxkIGJlIGEgYnVnIGZvciB0aGUNCj4+IHRpbWVyIGNhbGxiYWNr
IHRvIGVuZCB1cCBpbiB0aGlzIHNpdHVhdGlvbikuDQo+Pg0KPj4gS2V2aW4NCj4+DQo+IA0KPiBJ
bnRlcmVzdGluZywgY291bGQgdGhlcmUgYmUgYSByYWNlIGNvbmRpdGlvbiwgd2hlbiB3ZSBjYWxs
IHFlbXVfY29fc2xlZXBfd2FrZSwNCj4gYnV0IGNvX3NsZWVwX2NiIGFscmVhZHkgc2NoZWR1bGVk
IGluIHNvbWUgcXVldWUgYW5kIHdpbGwgcnVuIHNvb24/IFRoZW4gcmVtb3ZpbmcNCj4gdGhlIHRp
bWVyIHdpbGwgbm90IGhlbHAuDQo+IA0KPiANCg0KSG1tLCBpdCdzIGNvbW1lbnRlZCB0aGF0IHRp
bWVyX2RlbCBpcyB0aHJlYWQtc2FmZS4uDQoNCkhtbSwgc28sIGlmIGFueXdheSB3YW50IHRvIHJl
dHVybiBUaW1lciBwb2ludGVyIGZyb20gcWVtdV9jb19zbGVlcF9ucywgbWF5IGJlIGl0J3MgYmV0
dGVyDQp0byBqdXN0IGNhbGwgdGltZXJfbW9kKHRzLCAwKSB0byBzaG9ydGVuIHdhaXRpbmcgaW5z
dGVhZCBvZiBjaGVhdGluZyB3aXRoIC5zY2hlZHVsZWQ/DQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMs
DQpWbGFkaW1pcg0K

