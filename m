Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED90C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 09:49:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 735BF20674
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 09:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cffzuvj5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 735BF20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49328 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfLb6-0006Nx-Cx
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 05:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32845)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hfLYv-0005co-NO
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 05:47:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hfLYt-0000FA-Pf
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 05:46:57 -0400
Received: from mail-eopbgr40090.outbound.protection.outlook.com
 ([40.107.4.90]:37101 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1hfLYs-00009B-E7; Mon, 24 Jun 2019 05:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=veFVnEKjU/hmoLm4MchrcllYnYo3+sSNPgNuOnhbMLU=;
 b=cffzuvj5LBgUQoT5ATfOm8CpPc9NfXJFgrcBD0nTjeQopqY0zM89sNAXCtJoLAZWgG5an+bncNJx1g3wLxUYf/fTCCNmocQ+crtFvSUvExHfl6xPNRJ/iN+mPfpnjpevjHH8AvK32HZ1Rt71dUaeOZVtLGQdB6PQ4+hjBLF61/I=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB3746.eurprd08.prod.outlook.com (20.178.83.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Mon, 24 Jun 2019 09:46:50 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::44eb:4518:e1f2:144c]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::44eb:4518:e1f2:144c%7]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 09:46:50 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf
 <kwolf@redhat.com>
Thread-Topic: [Qemu-devel] [Qemu-block] [PATCH] blk: postpone request
 execution on a context protected with "drained section"
Thread-Index: AQHUjignkofN8gw/f0Gq8XBVqGcZF6V5+nkAgAEUmYCAAa8WAP//4guAgAG9WoCAi/MFgIAfI2CAgArmNACAcq2uAIAAC++AgASzZoA=
Date: Mon, 24 Jun 2019 09:46:50 +0000
Message-ID: <ce694324-a2fd-2f03-351a-e54bc05973f1@virtuozzo.com>
References: <20181205122326.26625-1-dplotnikov@virtuozzo.com>
 <20181207122647.GE5119@linux.fritz.box>
 <bb51b8f9-a3a4-90e6-2f69-57e90ccd623a@virtuozzo.com>
 <20181212122457.GB5415@linux.fritz.box>
 <d0d2cab4-2157-1f9f-3bc9-a70f28a211b0@virtuozzo.com>
 <20181213122039.GC5427@linux.fritz.box>
 <f2fcbcc2-5e0f-053d-f4c7-fe0f5f6092f0@virtuozzo.com>
 <20190313160412.GF5167@linux.fritz.box>
 <101bbf98-0456-5022-e117-fd6f693a8786@virtuozzo.com>
 <20190409100142.GC6610@localhost.localdomain>
 <20190621091656.GA9744@localhost.localdomain>
 <d2ad5561-1806-d885-350a-b43dd0fe4339@virtuozzo.com>
In-Reply-To: <d2ad5561-1806-d885-350a-b43dd0fe4339@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0042.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::28) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a20f2e7b-8091-4dd2-b334-08d6f888e14a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB3746; 
x-ms-traffictypediagnostic: AM0PR08MB3746:
x-microsoft-antispam-prvs: <AM0PR08MB37467D1C49F2A96343EAA450CFE00@AM0PR08MB3746.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(346002)(366004)(39840400004)(396003)(199004)(189003)(3846002)(66946007)(68736007)(76176011)(14444005)(86362001)(186003)(386003)(6506007)(31696002)(53546011)(305945005)(26005)(2616005)(81156014)(5660300002)(8936002)(81166006)(6512007)(8676002)(478600001)(476003)(66446008)(66556008)(66476007)(64756008)(486006)(14454004)(99286004)(25786009)(6116002)(4326008)(316002)(36756003)(6246003)(6436002)(71190400001)(256004)(110136005)(7736002)(2906002)(71200400001)(54906003)(229853002)(66066001)(53936002)(446003)(11346002)(102836004)(31686004)(52116002)(6486002)(73956011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3746;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KZBNO+1h/zoapzArKZQLlqoCOIYQuwbHFnm1WNCYId0JD4MFTgY8B1keOP5I4Qo+6elUI0w153Lm1cvkG6TeFHATVn0PJLYv5zN93jvPUiXUeBeJv+ETd1IZClg5F1Z/zmX2fDwWxhNUy/IN6q1txBFWsSoeY9m5WWhzNt9NuhQxnBx9rYb2uHw1fiI4kt3nD9VRp2WdX2F5UZ8ahVVn2joFRm9I50NfZPqYTOw23hRiRf5MRSrgFSUsK6NrpATdgMbKiLL/oVqG8dY0Y4x9mLNVd+QAIEqPVvO0MATF07h/pi2o12JMGzW7On7tIybGpkuO+z13JjNZvX/PZlfn/b4gx2262r+arVQyN/8nDlKUJb30ZGq+3oNZOJPC+oOmoYPS+C+pvkvxd0PdZUtPERP3iOooWMEX2BKm47rKN7A=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D9ADC81584AA8459572244DB7BA1836@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a20f2e7b-8091-4dd2-b334-08d6f888e14a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 09:46:50.2691 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dplotnikov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3746
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.90
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] blk: postpone request
 execution on a context protected with "drained section"
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "keith.busch@intel.com" <keith.busch@intel.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDIxLjA2LjIwMTkgMTI6NTksIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3Jv
dGU6DQo+IDIxLjA2LjIwMTkgMTI6MTYsIEtldmluIFdvbGYgd3JvdGU6DQo+PiBBbSAwOS4wNC4y
MDE5IHVtIDEyOjAxIGhhdCBLZXZpbiBXb2xmIGdlc2NocmllYmVuOg0KPj4+IEFtIDAyLjA0LjIw
MTkgdW0gMTA6MzUgaGF0IERlbmlzIFBsb3RuaWtvdiBnZXNjaHJpZWJlbjoNCj4+Pj4gT24gMTMu
MDMuMjAxOSAxOTowNCwgS2V2aW4gV29sZiB3cm90ZToNCj4+Pj4+IEFtIDE0LjEyLjIwMTggdW0g
MTI6NTQgaGF0IERlbmlzIFBsb3RuaWtvdiBnZXNjaHJpZWJlbjoNCj4+Pj4+PiBPbiAxMy4xMi4y
MDE4IDE1OjIwLCBLZXZpbiBXb2xmIHdyb3RlOg0KPj4+Pj4+PiBBbSAxMy4xMi4yMDE4IHVtIDEy
OjA3IGhhdCBEZW5pcyBQbG90bmlrb3YgZ2VzY2hyaWViZW46DQo+Pj4+Pj4+PiBTb3VuZHMgaXQg
c2hvdWxkIGJlIHNvLCBidXQgaXQgZG9lc24ndCB3b3JrIHRoYXQgd2F5IGFuZCB0aGF0J3Mgd2h5
Og0KPj4+Pj4+Pj4gd2hlbiBkb2luZyBtaXJyb3Igd2UgbWF5IHJlc3VtZSBwb3N0cG9uZWQgY29y
b3V0aW5lcyB0b28gZWFybHkgd2hlbiB0aGUNCj4+Pj4+Pj4+IHVuZGVybHlpbmcgYnMgaXMgcHJv
dGVjdGVkIGZyb20gd3JpdGluZyBhdCBhbmQgdGh1cyB3ZSBlbmNvdW50ZXIgdGhlDQo+Pj4+Pj4+
PiBhc3NlcnQgb24gYSB3cml0ZSByZXF1ZXN0IGV4ZWN1dGlvbiBhdCBiZHJ2X2NvX3dyaXRlX3Jl
cV9wcmVwYXJlIHdoZW4NCj4+Pj4+Pj4+IHJlc3VtaW5nIHRoZSBwb3N0cG9uZWQgY29yb3V0aW5l
cy4NCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBUaGUgdGhpbmcgaXMgdGhhdCB0aGUgYnMgaXMgcHJvdGVj
dGVkIGZvciB3cml0aW5nIGJlZm9yZSBleGVjdXRpb24gb2YNCj4+Pj4+Pj4+IGJkcnZfcmVwbGFj
ZV9ub2RlIGF0IG1pcnJvcl9leGl0X2NvbW1vbiBhbmQgYmRydl9yZXBsYWNlX25vZGUgY2FsbHMN
Cj4+Pj4+Pj4+IGJkcnZfcmVwbGFjZV9jaGlsZF9ub3Blcm0gd2hpY2gsIGluIHR1cm4sIGNhbGxz
IGNoaWxkLT5yb2xlLT5kcmFpbmVkX2VuZA0KPj4+Pj4+Pj4gd2hlcmUgb25lIG9mIHRoZSBjYWxs
YmFja3MgaXMgYmxrX3Jvb3RfZHJhaW5lZF9lbmQgd2hpY2ggY2hlY2sNCj4+Pj4+Pj4+IGlmKC0t
YmxrLT5xdWllc2NlX2NvdW50ZXIgPT0gMCkgYW5kIHJ1bnMgdGhlIHBvc3Rwb25lZCByZXF1ZXN0
cw0KPj4+Pj4+Pj4gKGNvcm91dGluZXMpIGlmIHRoZSBjb3VuZGl0aW9uIGlzIHRydWUuDQo+Pj4+
Pj4+DQo+Pj4+Pj4+IEhtLCBzbyBzb21ldGhpbmcgaXMgbWVzc2VkIHVwIHdpdGggdGhlIGRyYWlu
IHNlY3Rpb25zIGluIHRoZSBtaXJyb3INCj4+Pj4+Pj4gZHJpdmVyLiBXZSBoYXZlOg0KPj4+Pj4+
Pg0KPj4+Pj4+PiAgICAgICAgIGJkcnZfZHJhaW5lZF9iZWdpbih0YXJnZXRfYnMpOw0KPj4+Pj4+
PiAgICAgICAgIGJkcnZfcmVwbGFjZV9ub2RlKHRvX3JlcGxhY2UsIHRhcmdldF9icywgJmxvY2Fs
X2Vycik7DQo+Pj4+Pj4+ICAgICAgICAgYmRydl9kcmFpbmVkX2VuZCh0YXJnZXRfYnMpOw0KPj4+
Pj4+Pg0KPj4+Pj4+PiBPYnZpb3VzbHksIHRoZSBpbnRlbnRpb24gd2FzIHRvIGtlZXAgdGhlIEJs
b2NrQmFja2VuZCBkcmFpbmVkIGR1cmluZw0KPj4+Pj4+PiBiZHJ2X3JlcGxhY2Vfbm9kZSgpLiBT
byBob3cgY291bGQgYmxrLT5xdWllc2NlX2NvdW50ZXIgZXZlciBnZXQgdG8gMA0KPj4+Pj4+PiBp
bnNpZGUgYmRydl9yZXBsYWNlX25vZGUoKSB3aGVuIHRhcmdldF9icyBpcyBkcmFpbmVkPw0KPj4+
Pj4+Pg0KPj4+Pj4+PiBMb29raW5nIGF0IGJkcnZfcmVwbGFjZV9jaGlsZF9ub3Blcm0oKSwgaXQg
c2VlbXMgdGhhdCB0aGUgZnVuY3Rpb24gaGFzDQo+Pj4+Pj4+IGEgYnVnOiBFdmVuIGlmIG9sZF9i
cyBhbmQgbmV3X2JzIGFyZSBib3RoIGRyYWluZWQsIHRoZSBxdWllc2NlX2NvdW50ZXINCj4+Pj4+
Pj4gZm9yIHRoZSBwYXJlbnQgcmVhY2hlcyAwIGZvciBhIG1vbWVudCBiZWNhdXNlIHdlIGNhbGwg
LmRyYWluZWRfZW5kIGZvcg0KPj4+Pj4+PiB0aGUgb2xkIGNoaWxkIGZpcnN0IGFuZCAuZHJhaW5l
ZF9iZWdpbiBmb3IgdGhlIG5ldyBvbmUgbGF0ZXIuDQo+Pj4+Pj4+DQo+Pj4+Pj4+IFNvIGl0IHNl
ZW1zIHRoZSBmaXggd291bGQgYmUgdG8gcmV2ZXJzZSB0aGUgb3JkZXIgYW5kIGZpcnN0IGNhbGwN
Cj4+Pj4+Pj4gLmRyYWluZWRfYmVnaW4gZm9yIHRoZSBuZXcgY2hpbGQgYW5kIHRoZW4gLmRyYWlu
ZWRfZW5kIGZvciB0aGUgb2xkDQo+Pj4+Pj4+IGNoaWxkLiBTb3VuZHMgbGlrZSBhIGdvb2QgbmV3
IHRlc3RjYXNlIGZvciB0ZXN0cy90ZXN0LWJkcnYtZHJhaW4uYywgdG9vLg0KPj4+Pj4+IFllcywg
aXQncyB0cnVlLCBidXQgaXQncyBub3QgZW5vdWdoLi4uDQo+Pj4+Pg0KPj4+Pj4gRGlkIHlvdSBl
dmVyIGltcGxlbWVudCB0aGUgY2hhbmdlcyBzdWdnZXN0ZWQgc28gZmFyLCBzbyB0aGF0IHdlIGNv
dWxkDQo+Pj4+PiBjb250aW51ZSBmcm9tIHRoZXJlPyBPciBzaG91bGQgSSB0cnkgYW5kIGNvbWUg
dXAgd2l0aCBzb21ldGhpbmcgbXlzZWxmPw0KPj4+Pg0KPj4+PiBTb3JyeSBmb3IgdGhlIGxhdGUg
cmVwbHkuLi4NCj4+Pj4gWWVzLCBJIGRpZCAuLi4NCj4+Pg0KPj4+IElmIHRoZXJlIGFyZSBtb3Jl
IHF1ZXN0aW9uIG9yIHByb2JsZW1zLCBjYW4geW91IHBvc3QgdGhlIHBhdGNoZXMgaW4NCj4+PiB0
aGVpciBjdXJyZW50IHNoYXBlIChhcyBhbiBSRkMpIG9yIGEgZ2l0IFVSTCBzbyBJIGNhbiBwbGF5
IHdpdGggaXQgYQ0KPj4+IGJpdD8gSWYgeW91IGNvdWxkIGluY2x1ZGUgYSBmYWlsaW5nIHRlc3Qg
Y2FzZSwgdG9vLCB0aGF0IHdvdWxkIGJlIGlkZWFsLg0KPj4NCj4+IERlbmlzPyBQbGVhc2U/DQo+
Pg0KPj4gV2UgcmVhbGx5IHNob3VsZCBnZXQgdGhpcyBmaXhlZCBhbmQgSSB3b3VsZCBiZSB3aWxs
aW5nIHRvIGxlbmQgYSBoYW5kLA0KPj4gYnV0IGlmIHlvdSBrZWVwIHlvdXIgcGF0Y2hlcyBzZWNy
ZXQsIEkgY2FuJ3QgcmVhbGx5IGRvIHNvIGFuZCB3b3VsZCBoYXZlDQo+PiB0byBkdXBsaWNhdGUg
eW91ciB3b3JrLg0KPj4NCj4+IEFsc28sIHBsZWFzZSBzZWUgbXkgb2xkIGFuc3dlciBmcm9tIEFw
cmlsIGJlbG93IGZvciB0aGUgbGFzdCBwcm9ibGVtIHlvdQ0KPj4gaGFkIHdpdGggaW1wbGVtZW50
aW5nIHRoZSBjb3JyZWN0IGFwcHJvYWNoLg0KPj4NCj4+IEtldmluDQoNCkhpIEtldmluLA0KSSdt
IHNvcnJ5IGZvciBub3QgcmVwbHlpbmcgZm9yIHNvIGxvbmcuIFBsZWFzZSwgZ2l2ZSBtZSBzb21l
IHRpbWUgKGEgZGF5IA0Kb3IgdHdvKSBzbyBJIGNvdWxkIHJlZnJlc2ggZXZlcnl0aGluZyBhbmQg
c2VuZCB0aGUgY3VycmVudCBzdGF0ZSBvZiB0aGUgDQpwYXRjaGVzIGFzIHdlbGwgYXMgdGhlIHRl
c3QgY2FzZSBjaGVja2luZyB0aGUgaXNzdWUNCg0KRGVuaXMNCj4gDQo+IEhlIGlzIG5vdCBhdCB3
b3JrIHRvZGF5LCBJIHRoaW5rIGhlJ2xsIGJlIGFibGUgdG8gYW5zd2VyIG9uIE1vbmRheS4NCj4g
DQo+IA0KDQotLSANCkJlc3QsDQpEZW5pcw0K

