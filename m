Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949FFC468BD
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:08:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25DA2208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VwKoCCyZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25DA2208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49186 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZHPS-0007JK-6p
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 12:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42533)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hZGNR-0002FJ-7u
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:01:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hZGNK-0007Ar-9A
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:01:52 -0400
Received: from mail-ve1eur01on0714.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::714]:35715
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hZGND-0006vF-UQ; Fri, 07 Jun 2019 11:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuI+NCcdszTfd3Ok9GNDWh48QE8W5QHukOa6TftWIeQ=;
 b=VwKoCCyZWnOBYFNxCRf4yVqc75Ah0RIAvTMA14Qd/r8SAeZfFeX60m3fzH7nOA71oJKKA4QNz8XmoqCYwj+qzp8BeADo0OscZBFefGS5O6tce5SeQGFvEgiFZpsKUkv6ba40UUvCtnZigcerdLWpvRq9uF1Gv449MUgVVMFjecs=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
 AM0PR08MB4611.eurprd08.prod.outlook.com (20.178.83.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Fri, 7 Jun 2019 15:01:31 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
 ([fe80::8d90:32ae:bdd6:48e8]) by AM0PR08MB2961.eurprd08.prod.outlook.com
 ([fe80::8d90:32ae:bdd6:48e8%7]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 15:01:31 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH v6 5/7] qemu-coroutine-sleep: introduce qemu_co_sleep_wake
Thread-Index: AQHU8IvPncRKmUnNFESi2c9mvKXDwqaQLEMAgAA4CACAAB0MAIAAIVaA
Date: Fri, 7 Jun 2019 15:01:31 +0000
Message-ID: <2b4f9d8b-c29e-ca82-20c9-c8e73e6013be@virtuozzo.com>
References: <20190411172709.205032-1-vsementsov@virtuozzo.com>
 <20190411172709.205032-6-vsementsov@virtuozzo.com>
 <20190607075740.GA5055@dhcp-200-226.str.redhat.com>
 <16b7ad42-611c-fc3e-2029-d491882b0750@virtuozzo.com>
 <20190607130210.GC5055@dhcp-200-226.str.redhat.com>
In-Reply-To: <20190607130210.GC5055@dhcp-200-226.str.redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0273.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::25) To AM0PR08MB2961.eurprd08.prod.outlook.com
 (2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190607180129324
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9112fb4f-6d3d-41ab-2bf4-08d6eb590685
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB4611; 
x-ms-traffictypediagnostic: AM0PR08MB4611:
x-microsoft-antispam-prvs: <AM0PR08MB4611718090CF49100B2BF5B4C1100@AM0PR08MB4611.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(136003)(376002)(346002)(366004)(396003)(39850400004)(199004)(189003)(102836004)(6506007)(386003)(5660300002)(68736007)(305945005)(31686004)(316002)(99286004)(54906003)(76176011)(7736002)(3846002)(6116002)(478600001)(2906002)(81166006)(81156014)(8676002)(52116002)(8936002)(86362001)(66066001)(6436002)(6512007)(6486002)(229853002)(476003)(2616005)(446003)(486006)(11346002)(64756008)(66446008)(66946007)(6916009)(73956011)(66476007)(14454004)(31696002)(66556008)(71200400001)(107886003)(71190400001)(25786009)(6246003)(26005)(256004)(53936002)(4326008)(186003)(36756003)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4611;
 H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Yn7Lcz4tiOreybM5kSIFGqKtASjJXr5m26/doFsNNJGv+kdKKmS72UcUFO/G3cVMzBVyosdKrkVhXGlvcuiZKfS10hclwRETn48InmuntK41XdJG7+1BGf4tLJ3kikCmn15tM0q8QAgNIkju6/vaLk2T4veNKkvqgKisPzPY+aWCqeAitrP4gDfZsvkrzL4t5X1m9U/LkFUrjpE4fTN61NUtn+Iaz4BizzhaGS19S546FaiC8fcoG2yFVCaodgt+8TBHWM4FGMtn0S0QunW+glSwB06eeZeRqfMTH+RXrglyn5Xt0NR1IpXw+dUUGxptl2NwGO92Ro9GXDopbXNynLEiOcmJJpLvTxsUW0yOMVdgAZ8mZwuQFUd6IcJIsccU9+9T+KJZcBA7MAmkUfV1P1e7E99Kh++VONoeHzcc9X8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DAD06D1E8950EF4C924B4A0AA3BCD7FD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9112fb4f-6d3d-41ab-2bf4-08d6eb590685
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 15:01:31.8208 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4611
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe1f::714
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

MDcuMDYuMjAxOSAxNjowMiwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMDcuMDYuMjAxOSB1bSAx
MzoxOCBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IDA3
LjA2LjIwMTkgMTA6NTcsIEtldmluIFdvbGYgd3JvdGU6DQo+Pj4gQW0gMTEuMDQuMjAxOSB1bSAx
OToyNyBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+Pj4g
SW50cm9kdWNlIGEgZnVuY3Rpb24gdG8gZ3JhY2VmdWxseSB3YWtlLXVwIGEgY29yb3V0aW5lLCBz
bGVlcGluZyBpbg0KPj4+PiBxZW11X2NvX3NsZWVwX25zKCkgc2xlZXAuDQo+Pj4+DQo+Pj4+IFNp
Z25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmly
dHVvenpvLmNvbT4NCj4+Pg0KPj4+IFlvdSBjYW4gc2ltcGx5IHJlZW50ZXIgdGhlIGNvcm91dGlu
ZSB3aGlsZSBpdCBoYXMgeWllbGRlZCBpbg0KPj4+IHFlbXVfY29fc2xlZXBfbnMoKS4gVGhpcyBp
cyBzdXBwb3J0ZWQuDQo+Pg0KPj4gTm8gaXQgZG9lc24ndC4gcWVtdV9haW9fY29yb3V0aW5lX2Vu
dGVyIGNoZWNrcyBmb3Igc2NoZWR1bGVkIGZpZWxkLA0KPj4gYW5kIGFib3J0cyBpZiBpdCBpcyBz
ZXQuDQo+IA0KPiBBaCwgeWVzLCBpdCBoYXMgYmVlbiBicm9rZW4gc2luY2UgY29tbWl0DQo+IA0K
PiBJIGFjdHVhbGx5IHRyaWVkIHRvIGZpeCBpdCBvbmNlLCBidXQgaXQgdHVybmVkIG91dCBtb3Jl
IGNvbXBsaWNhdGVkIGFuZA0KPiBJIHRoaW5rIHdlIGZvdW5kIGEgZGlmZmVyZW50IHNvbHV0aW9u
IGZvciB0aGUgcHJvYmxlbSBhdCBoYW5kOg0KPiANCj4gICAgICBTdWJqZWN0OiBbUEFUQ0ggZm9y
LTIuMTEgMC80XSBGaXggcWVtdS1pb3Rlc3RzIGZhaWx1cmVzDQo+ICAgICAgTWVzc2FnZS1JZDog
PDIwMTcxMTI4MTU0MzUwLjIxNTA0LTEta3dvbGZAcmVkaGF0LmNvbT4NCj4gDQo+IEluIHRoaXMg
Y2FzZSwgSSBndWVzcyB5b3VyIGFwcHJvYWNoIHdpdGggYSBuZXcgZnVuY3Rpb24gdG8gaW50ZXJy
dXB0DQo+IHFlbXVfY29fc2xlZXBfbnMoKSBpcyBva2F5Lg0KPiANCj4gRG8gd2UgbmVlZCB0byB0
aW1lcl9kZWwoKSB3aGVuIHRha2luZyB0aGUgc2hvcnRjdXQ/IFdlIGRvbid0IG5lY2Vzc2FyaWx5
DQo+IHJlZW50ZXIgdGhlIGNvcm91dGluZSBpbW1lZGlhdGVseSwgYnV0IG1pZ2h0IG9ubHkgYmUg
c2NoZWR1bGluZyBpdC4gSW4NCj4gdGhpcyBjYXNlLCB0aGUgdGltZXIgY291bGQgZmlyZSBiZWZv
cmUgcWVtdV9jb19zbGVlcF9ucygpIGhhcyBydW4gYW5kDQo+IHNjaGVkdWxlIHRoZSBjb3JvdXRp
bmUgYSBzZWNvbmQgdGltZSAoaWdub3JpbmcgY28tPnNjaGVkdWxlZCBhZ2FpbiAtDQo+IG1heWJl
IHdlIHNob3VsZCBhY3R1YWxseSBub3QgZG8gdGhhdCBpbiB0aGUgdGltZXIgY2FsbGJhY2sgcGF0
aCwgYnV0DQo+IGluc3RlYWQgbGV0IGl0IHJ1biBpbnRvIHRoZSBhc3NlcnRpb24gYmVjYXVzZSBp
dCB3b3VsZCBiZSBhIGJ1ZyBmb3IgdGhlDQo+IHRpbWVyIGNhbGxiYWNrIHRvIGVuZCB1cCBpbiB0
aGlzIHNpdHVhdGlvbikuDQo+IA0KDQpPaywgdGhhbmtzLCB3aWxsIHRyeSB0byBpbXByb3ZlIGl0
DQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

