Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0C7C31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 09:52:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED19F208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 09:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YnFTYJRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED19F208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49700 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbit2-0001JT-6f
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 05:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40980)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbiew-00053R-2Z
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:38:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbiPx-0004nb-3R
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:22:46 -0400
Received: from mail-eopbgr130102.outbound.protection.outlook.com
 ([40.107.13.102]:63507 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbiPq-0004hU-NJ; Fri, 14 Jun 2019 05:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6N8uQ68l5Mo1PS+nzdxF7ysOfg99/opU9oklD2k85w=;
 b=YnFTYJRcz8zj4WVzwkT/C8+BNX0BZk0YwaBBnqIV5lIW+JTRT5fUXV+d5biO51EY/CoLZaHuCzPu874V4iSMoLIIeMVDSojnN0rPwzJQ8Io4sUDQ2q2Kg49mM8/IwuhhBlcDHkaHmfZCEUGaRUCCRl5EnKkKssUH8K/fQ2Y4Ui0=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB4196.eurprd08.prod.outlook.com (20.178.118.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Fri, 14 Jun 2019 09:22:21 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Fri, 14 Jun 2019
 09:22:21 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH 1/2] vl: Drain before (block) job cancel
 when quitting
Thread-Index: AQHVIWxBONzjUIyHrUmkQBSrnSPBsaaZ1WeA///OVACAADSugP//57UAgAEiXAA=
Date: Fri, 14 Jun 2019 09:22:20 +0000
Message-ID: <32adc55c-c71d-59bf-963b-48d2ae5b3e30@virtuozzo.com>
References: <20190612220839.1374-1-mreitz@redhat.com>
 <20190612220839.1374-2-mreitz@redhat.com>
 <b110b753-8546-0d34-f6ef-06c5726766ce@virtuozzo.com>
 <c1fbf12a-77af-d939-4266-67b822e5a923@redhat.com>
 <57ae7f82-ae02-a382-74f6-cb96672b2058@virtuozzo.com>
 <00cce102-a1f1-9205-6eb7-1e48d8991b00@redhat.com>
In-Reply-To: <00cce102-a1f1-9205-6eb7-1e48d8991b00@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0035.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::48) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190614122218517
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9ad6265-c65b-4d5f-7fef-08d6f0a9cd5a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB4196; 
x-ms-traffictypediagnostic: AM0PR08MB4196:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR08MB419650CA8356BC1EC1794D2FC1EE0@AM0PR08MB4196.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(396003)(376002)(366004)(39850400004)(189003)(199004)(486006)(446003)(476003)(86362001)(11346002)(2616005)(2906002)(966005)(6306002)(68736007)(6246003)(478600001)(6512007)(52116002)(14454004)(53936002)(31686004)(54906003)(31696002)(186003)(25786009)(66066001)(4326008)(229853002)(107886003)(26005)(102836004)(81156014)(316002)(99286004)(6506007)(386003)(6116002)(6436002)(53546011)(3846002)(7736002)(305945005)(76176011)(36756003)(6486002)(8676002)(66946007)(6916009)(64756008)(66446008)(73956011)(5660300002)(66556008)(71190400001)(81166006)(8936002)(71200400001)(66476007)(256004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4196;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: femXu71A73pM8d8CWCN/0qfk+AgSZHhBnJ3m1/pRC3t396nKqrROI8lWtKA8dYBdpSEqN3TDvyQh4S6Yljzg9sg1gEUXoajeCogjarnI+YC5V5wG1zvHaKmQ2awg7Lgq64QrOAVyxsAkZSaV+4cphe8lUXyA1ldno1rC5zt3WXhebPEqqfAp5Lc1wcVlNQoPnSJuBVRcxfHAa+Erl3P0s0mDJKJc3l1r8m8u9roeR/3ZRfsuz9rbkwE3B7MfTZ0AtzY364ibV46PbojuxgCz+csYshR+f+UAqwMvy5FVNfmkZp2pmysRki3msAvSH9OYcC4EevwGdOFoV8BKzdy+UEgiCNtAyy/EzsqZDHEZaYAmXNL1uU1gry6KWWBWv3+8Uy59fDuaI/JNpjPtGVFgnsX6kKRvgNEMlxyRBm158U0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <448C27B2C17D9A44BF1C675F1A96EC14@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ad6265-c65b-4d5f-7fef-08d6f0a9cd5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 09:22:20.8631 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4196
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.102
Subject: Re: [Qemu-devel] [PATCH 1/2] vl: Drain before (block) job cancel
 when quitting
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTMuMDYuMjAxOSAxOTowMywgTWF4IFJlaXR6IHdyb3RlOg0KPiBbcmUtYWRkaW5nIHRoZSBvcmln
aW5hbCBDQ3MsIHdoeSBub3RdDQo+IA0KPiBPbiAxMy4wNi4xOSAxNjozMCwgVmxhZGltaXIgU2Vt
ZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDEzLjA2LjIwMTkgMTc6MjEsIE1heCBSZWl0eiB3
cm90ZToNCj4+PiBPbiAxMy4wNi4xOSAxNjoxOSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tp
eSB3cm90ZToNCj4+Pj4gMTMuMDYuMjAxOSAxOjA4LCBNYXggUmVpdHogd3JvdGU6DQo+Pj4+PiBJ
ZiB0aGUgbWFpbiBsb29wIGNhbmNlbHMgYWxsIGJsb2NrIGpvYnMgd2hpbGUgdGhlIGJsb2NrIGxh
eWVyIGlzIG5vdA0KPj4+Pj4gZHJhaW5lZCwgdGhpcyBjYW5jZWxsaW5nIG1heSBub3QgaGFwcGVu
IGluc3RhbnRhbmVvdXNseS4gIFdlIGNhbiBzdGFydCBhDQo+Pj4+PiBkcmFpbmVkIHNlY3Rpb24g
YmVmb3JlIHZtX3NodXRkb3duKCksIHdoaWNoIGVudGFpbHMgYW5vdGhlcg0KPj4+Pj4gYmRydl9k
cmFpbl9hbGwoKTsgdGhpcyBuZXN0ZWQgYmRydl9kcmFpbl9hbGwoKSB3aWxsIHRodXMgYmUgYSBu
by1vcCwNCj4+Pj4+IGJhc2ljYWxseS4NCj4+Pj4+DQo+Pj4+PiBXZSBkbyBub3QgaGF2ZSB0byBl
bmQgdGhlIGRyYWluZWQgc2VjdGlvbiwgYmVjYXVzZSB3ZSBhY3R1YWxseSBkbyBub3QNCj4+Pj4+
IHdhbnQgYW55IHJlcXVlc3RzIHRvIGhhcHBlbiBmcm9tIHRoaXMgcG9pbnQgb24uDQo+Pj4+Pg0K
Pj4+Pj4gU2lnbmVkLW9mZi1ieTogTWF4IFJlaXR6IDxtcmVpdHpAcmVkaGF0LmNvbT4NCj4+Pj4+
IC0tLQ0KPj4+Pj4gSSBkb24ndCBrbm93IHdoZXRoZXIgaXQgYWN0dWFsbHkgbWFrZXMgc2Vuc2Ug
dG8gbmV2ZXIgZW5kIHRoaXMgZHJhaW5lZA0KPj4+Pj4gc2VjdGlvbi4gIEl0IG1ha2VzIHNlbnNl
IHRvIG1lLiAgUGxlYXNlIGNvcnJlY3QgbWUgaWYgSSdtIHdyb25nLg0KPj4+Pj4gLS0tDQo+Pj4+
PiAgICAgdmwuYyB8IDExICsrKysrKysrKysrDQo+Pj4+PiAgICAgMSBmaWxlIGNoYW5nZWQsIDEx
IGluc2VydGlvbnMoKykNCj4+Pj4+DQo+Pj4+PiBkaWZmIC0tZ2l0IGEvdmwuYyBiL3ZsLmMNCj4+
Pj4+IGluZGV4IGNkMWZiYzRjZGMuLjNmOGIzZjc0ZjUgMTAwNjQ0DQo+Pj4+PiAtLS0gYS92bC5j
DQo+Pj4+PiArKysgYi92bC5jDQo+Pj4+PiBAQCAtNDUzOCw2ICs0NTM4LDE3IEBAIGludCBtYWlu
KGludCBhcmdjLCBjaGFyICoqYXJndiwgY2hhciAqKmVudnApDQo+Pj4+PiAgICAgICAgICAqLw0K
Pj4+Pj4gICAgICAgICBtaWdyYXRpb25fc2h1dGRvd24oKTsNCj4+Pj4+ICAgICANCj4+Pj4+ICsg
ICAgLyoNCj4+Pj4+ICsgICAgICogV2UgbXVzdCBjYW5jZWwgYWxsIGJsb2NrIGpvYnMgd2hpbGUg
dGhlIGJsb2NrIGxheWVyIGlzIGRyYWluZWQsDQo+Pj4+PiArICAgICAqIG9yIGNhbmNlbGxpbmcg
d2lsbCBiZSBhZmZlY3RlZCBieSB0aHJvdHRsaW5nIGFuZCB0aHVzIG1heSBibG9jaw0KPj4+Pj4g
KyAgICAgKiBmb3IgYW4gZXh0ZW5kZWQgcGVyaW9kIG9mIHRpbWUuDQo+Pj4+PiArICAgICAqIHZt
X3NodXRkb3duKCkgd2lsbCBiZHJ2X2RyYWluX2FsbCgpLCBzbyB3ZSBtYXkgYXMgd2VsbCBpbmNs
dWRlDQo+Pj4+PiArICAgICAqIGl0IGluIHRoZSBkcmFpbmVkIHNlY3Rpb24uDQo+Pj4+PiArICAg
ICAqIFdlIGRvIG5vdCBuZWVkIHRvIGVuZCB0aGlzIHNlY3Rpb24sIGJlY2F1c2Ugd2UgZG8gbm90
IHdhbnQgYW55DQo+Pj4+PiArICAgICAqIHJlcXVlc3RzIGhhcHBlbmluZyBmcm9tIGhlcmUgb24g
YW55d2F5Lg0KPj4+Pj4gKyAgICAgKi8NCj4+Pj4+ICsgICAgYmRydl9kcmFpbl9hbGxfYmVnaW4o
KTsNCj4+Pj4+ICsNCj4+Pj4+ICAgICAgICAgLyogTm8gbW9yZSB2Y3B1IG9yIGRldmljZSBlbXVs
YXRpb24gYWN0aXZpdHkgYmV5b25kIHRoaXMgcG9pbnQgKi8NCj4+Pj4+ICAgICAgICAgdm1fc2h1
dGRvd24oKTsNCj4+Pj4+ICAgICANCj4+Pj4+DQo+Pj4+DQo+Pj4+IFNvLCBhY3R1YWxseSwgdGhl
IHByb2JsZW0gaXMgdGhhdCB3ZSBtYXkgd2FpdCBmb3Igam9iIHJlcXVlc3RzIHR3aWNlOg0KPj4+
PiBvbiBkcmFpbiBhbmQgdGhlbiBvbiBjYW5jZWwuDQo+Pj4NCj4+PiBXZSBkb27igJl0IHdhaXQg
b24gZHJhaW4uICBXaGVuIHRoZSB0aHJvdHRsZSBub2RlIGlzIGRyYWluZWQsIGl0IHdpbGwNCj4+
PiBpZ25vcmUgdGhyb3R0bGluZyAoYXMgbm90ZWQgaW4gdGhlIGNvdmVyIGxldHRlcikuDQo+Pj4N
Cj4+PiBXZSBkbyB3YWl0IHdoZW4gY2FuY2VsbGluZyBhIGpvYiB3aGlsZSB0aGUgdGhyb3R0bGUg
bm9kZSBpc27igJl0IGRyYWluZWQsDQo+Pj4gdGhvdWdoLiAgVGhhdOKAmXMgdGhlIHByb2JsZW0u
DQo+Pg0KPj4gQWgsIHVuZGVyc3RhbmQgbm93Lg0KPj4NCj4+IElzIGl0IHNhZmUgdG8gZHJhaW5f
YmVnaW4gYmVmb3JlIHN0b3BwaW5nIGNwdXM/IFdlIG1heSBmaW5pc2ggdXAgdGhlbiB3aXRoIHNv
bWUgcXVldWVkDQo+PiBzb21ld2hlcmUgSU8gcmVxdWVzdHMuLg0KPiANCj4gSG0uLi4gIEFyZW7i
gJl0IGd1ZXN0IGRldmljZXMgcHJvaGliaXRlZCBmcm9tIGlzc3VpbmcgcmVxdWVzdHMgdG8gdGhl
DQo+IGJsb2NrIGxheWVyIHdoaWxlIHRoZWlyIHJlc3BlY3RpdmUgYmxvY2sgZGV2aWNlIGlzIGRy
YWluZWQ/DQoNCkl0J3MgYXQgbGVhc3QgYSBidWdneSBwbGFjZSwgSSByZW1lbWJlciBEZW5pcyBQ
bG90bmlrb3Ygc2VudCBwYXRjaCB0byBmaXggaXQgYW5kIGhhZCBhIGh1Z2UNCmRpc2N1c3Npb24g
d2l0aCBLZXZpbi4NCkFuZCBoZXJlIGl0IGlzOg0KaHR0cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hp
dmUvaHRtbC9xZW11LWRldmVsLzIwMTgtMTIvbXNnMDA3MzIuaHRtbA0KDQo+IA0KPiBPdGhlcndp
c2UsIEkgc3VwcG9zZSBJ4oCZbGwgaGF2ZSB0byBtb3ZlIHRoZSBiZHJ2X2RyYWluX2FsbF9iZWdp
bigpIGJlbG93DQo+IHRoZSB2bV9zaHV0ZG93bigpLiAgVGhhdCB3b3VsZG7igJl0IGJlIHRvbyBi
aWcgb2YgYSBwcm9ibGVtLg0KPiANCj4gTWF4DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0K
VmxhZGltaXINCg==

