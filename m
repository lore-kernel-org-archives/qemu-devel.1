Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0391C31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 09:42:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A0D22070B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 09:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="CC49irNS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0D22070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36248 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdX73-0007c6-Jd
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 05:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37844)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hdWw1-0005dZ-Hd
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:31:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hdWw0-00019z-2y
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:31:17 -0400
Received: from mail-eopbgr130118.outbound.protection.outlook.com
 ([40.107.13.118]:24869 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hdWvy-00015B-Vk; Wed, 19 Jun 2019 05:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7qdUIh5X0mQw75A4GpuvxDXsp2EYAcjZRV1Qn1laBU=;
 b=CC49irNSOco654Amzy+zBawyP6FM++Byre+s4322Xe9oJxjuX8UizrdTT+6HSFXNmqwHLclA0Mafp4H/JoqQMSXu+TOsN2wlndkdzBK9/aUGBbFI4ntsX9HqzVfF2Tx4hLcWAzlinkea5ZXwmP6JnCE097UIJm/DYvhyN6azhQc=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB4631.eurprd08.prod.outlook.com (10.255.78.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Wed, 19 Jun 2019 09:31:10 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Wed, 19 Jun 2019
 09:31:10 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 33/42] blockdev: Fix active commit choice
Thread-Index: AQHVIWvMnB+nkUgz2kCIZe++5LqMP6aiwJeA
Date: Wed, 19 Jun 2019 09:31:10 +0000
Message-ID: <2670e61d-6c9b-9499-8e41-01c294379e47@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-34-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-34-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0014.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::24) To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190619123105408
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8d3db9c-c8e4-4ec0-3432-08d6f498dcf0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DBBPR08MB4631; 
x-ms-traffictypediagnostic: DBBPR08MB4631:
x-microsoft-antispam-prvs: <DBBPR08MB46313C11BEC22993A4B5F326C1E50@DBBPR08MB4631.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 0073BFEF03
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(136003)(366004)(396003)(376002)(346002)(199004)(189003)(76176011)(478600001)(476003)(5660300002)(486006)(6246003)(66946007)(64756008)(6506007)(66476007)(2616005)(73956011)(102836004)(66446008)(86362001)(386003)(6116002)(66556008)(52116002)(3846002)(229853002)(31696002)(11346002)(256004)(99286004)(53936002)(186003)(26005)(446003)(14444005)(2501003)(316002)(6512007)(110136005)(36756003)(66066001)(25786009)(31686004)(4326008)(54906003)(6436002)(2906002)(305945005)(6486002)(8676002)(7736002)(71190400001)(71200400001)(81156014)(81166006)(8936002)(68736007)(14454004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4631;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: x5qTanEWN44xo1UfOqjQWvhyVPgk01W0quruKSg/YJKlQPwO7MwRVSC/xVisQrzvm3bxIygfZbmBYnM+feHrFeOjNUzFxz/QPhrownUUPsBW2TFkR2p82nkywC3ih5qK3yBw6luMeijNEjGoXrjKEgCUOaecMbuMyudAYmzI+sBa4RiNqSD8QKkZCQsGW+9N1jaJ0W6hprRS8jqL1m+OFy1wwN73BsohqJgy16WWtpHSVpRZDfLO7B6ohJmLhoZ1f9ZxPbOjtMhLeMMXK1j+sHwYqG4nuokCCPQusv0s0YfSCje2b+yfherBAkkw5VWDQBumBuKeiwxRjJ6oGMFHU6jH9pmFh0xDUEo3STIddWEm4WlMu0RSSUlYM644nZ2EEpcx35rz6bsp3uAFIfxaMVGJqwJB244B4q/vyT+z7Dg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3F9CF592A11F147ADB8AAAB510D03A1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d3db9c-c8e4-4ec0-3432-08d6f498dcf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2019 09:31:10.0528 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4631
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.118
Subject: Re: [Qemu-devel] [PATCH v5 33/42] blockdev: Fix active commit choice
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTMuMDYuMjAxOSAxOjA5LCBNYXggUmVpdHogd3JvdGU6DQo+IFdlIGhhdmUgdG8gcGVyZm9ybSBh
biBhY3RpdmUgY29tbWl0IHdoZW5ldmVyIHRoZSB0b3Agbm9kZSBoYXMgYSBwYXJlbnQNCj4gdGhh
dCBoYXMgdGFrZW4gdGhlIFdSSVRFIHBlcm1pc3Npb24gb24gaXQuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBNYXggUmVpdHogPG1yZWl0ekByZWRoYXQuY29tPg0KPiAtLS0NCj4gICBibG9ja2Rldi5j
IHwgMjQgKysrKysrKysrKysrKysrKysrKysrLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIxIGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYmxvY2tkZXYu
YyBiL2Jsb2NrZGV2LmMNCj4gaW5kZXggYTQ2NGNhYmY5ZS4uNTM3MGYzYjczOCAxMDA2NDQNCj4g
LS0tIGEvYmxvY2tkZXYuYw0KPiArKysgYi9ibG9ja2Rldi5jDQo+IEBAIC0zMjk0LDYgKzMyOTQs
NyBAQCB2b2lkIHFtcF9ibG9ja19jb21taXQoYm9vbCBoYXNfam9iX2lkLCBjb25zdCBjaGFyICpq
b2JfaWQsIGNvbnN0IGNoYXIgKmRldmljZSwNCj4gICAgICAgICovDQo+ICAgICAgIEJsb2NrZGV2
T25FcnJvciBvbl9lcnJvciA9IEJMT0NLREVWX09OX0VSUk9SX1JFUE9SVDsNCj4gICAgICAgaW50
IGpvYl9mbGFncyA9IEpPQl9ERUZBVUxUOw0KPiArICAgIHVpbnQ2NF90IHRvcF9wZXJtLCB0b3Bf
c2hhcmVkOw0KPiAgIA0KPiAgICAgICBpZiAoIWhhc19zcGVlZCkgew0KPiAgICAgICAgICAgc3Bl
ZWQgPSAwOw0KPiBAQCAtMzQwNiwxNCArMzQwNywzMSBAQCB2b2lkIHFtcF9ibG9ja19jb21taXQo
Ym9vbCBoYXNfam9iX2lkLCBjb25zdCBjaGFyICpqb2JfaWQsIGNvbnN0IGNoYXIgKmRldmljZSwN
Cj4gICAgICAgICAgIGdvdG8gb3V0Ow0KPiAgICAgICB9DQo+ICAgDQo+IC0gICAgaWYgKHRvcF9i
cyA9PSBicykgew0KPiArICAgIC8qDQo+ICsgICAgICogQWN0aXZlIGNvbW1pdCBpcyByZXF1aXJl
ZCBpZiBhbmQgb25seSBpZiBzb21lb25lIGhhcyB0YWtlbiBhDQo+ICsgICAgICogV1JJVEUgcGVy
bWlzc2lvbiBvbiB0aGUgdG9wIG5vZGUuICBIaXN0b3JpY2FsbHksIHdlIGhhdmUgYWx3YXlzDQo+
ICsgICAgICogdXNlZCBhY3RpdmUgY29tbWl0IGZvciB0b3Agbm9kZXMsIHNvIGNvbnRpbnVlIHRo
YXQgcHJhY3RpY2UuDQo+ICsgICAgICogKEFjdGl2ZSBjb21taXQgaXMgbmV2ZXIgcmVhbGx5IHdy
b25nLikNCg0KSG1tLCBpZiB3ZSBzdGFydCBhY3RpdmUgY29tbWl0IHdoZW4gbm9ib2R5IGhhcyB3
cml0ZSBhY2Nlc3MsIHRoYW4NCndlIGxlYXZlIGEgcG9zc2liaWxpdHkgdG8gc29tZW9uZSB0byBn
ZXQgdGhpcyBhY2Nlc3MgZHVyaW5nIGNvbW1pdC4gQW5kIGR1cmluZw0KcGFzc2l2ZSBjb21taXQg
d3JpdGUgYWNjZXNzIGlzIGJsb2NrZWQuIFNvLCBtYXkgYmUgcmlnaHQgd2F5IGlzIGRvIGFjdGl2
ZSBjb21taXQNCmFsd2F5cz8gQmVuZWZpdHM6DQoxLiBPbmUgY29kZSBwYXRoLiBhbmQgaXQgc2hv
dWxkbid0IGJlIHdvcnNlIHdoZW4gbm8gd3JpdGVycywgd2l0aG91dCBndWVzdCB3cml0ZXMNCm1p
cnJvciBjb2RlIHNob3VsZG4ndCB3b3JrIHdvcnNlIHRoYW4gcGFzc2l2ZSBjb21taXQsIGlmIGl0
IGlzLCBpdCBzaG91bGQgYmUgZml4ZWQuDQoyLiBQb3NzaWJpbGl0eSBvZiB3cml0ZSBhY2Nlc3Mg
aWYgdXNlciBuZWVkcyBpdCBkdXJpbmcgY29tbWl0DQozLiBJJ20gc3VyZSB0aGF0IGFjdGl2ZSBj
b21taXQgKG1pcnJvciBjb2RlKSBhY3R1YWxseSB3b3JrcyBmYXN0ZXIsIGFzIGl0IHVzZXMNCmFz
eW5jIHJlcXVlc3RzIGFuZCBzbWFydGVyIGhhbmRsaW5nIG9mIGJsb2NrIHN0YXR1cy4NCg0KPiAr
ICAgICAqLw0KPiArICAgIGJkcnZfZ2V0X2N1bXVsYXRpdmVfcGVybSh0b3BfYnMsICZ0b3BfcGVy
bSwgJnRvcF9zaGFyZWQpOw0KPiArICAgIGlmICh0b3BfcGVybSAmIEJMS19QRVJNX1dSSVRFIHx8
DQo+ICsgICAgICAgIGJkcnZfc2tpcF9yd19maWx0ZXJzKHRvcF9icykgPT0gYmRydl9za2lwX3J3
X2ZpbHRlcnMoYnMpKQ0KPiArICAgIHsNCj4gICAgICAgICAgIGlmIChoYXNfYmFja2luZ19maWxl
KSB7DQo+ICAgICAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiJ2JhY2tpbmctZmlsZScgc3Bl
Y2lmaWVkLCINCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICIgYnV0ICd0b3AnIGlz
IHRoZSBhY3RpdmUgbGF5ZXIiKTsNCj4gICAgICAgICAgICAgICBnb3RvIG91dDsNCj4gICAgICAg
ICAgIH0NCj4gLSAgICAgICAgY29tbWl0X2FjdGl2ZV9zdGFydChoYXNfam9iX2lkID8gam9iX2lk
IDogTlVMTCwgYnMsIGJhc2VfYnMsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgam9i
X2ZsYWdzLCBzcGVlZCwgb25fZXJyb3IsDQo+ICsgICAgICAgIGlmICghaGFzX2pvYl9pZCkgew0K
PiArICAgICAgICAgICAgLyoNCj4gKyAgICAgICAgICAgICAqIEVtdWxhdGUgaGVyZSB3aGF0IGJs
b2NrX2pvYl9jcmVhdGUoKSBkb2VzLCBiZWNhdXNlIGl0DQo+ICsgICAgICAgICAgICAgKiBpcyBw
b3NzaWJsZSB0aGF0IEBicyAhPSBAdG9wX2JzICh0aGUgYmxvY2sgam9iIHNob3VsZA0KPiArICAg
ICAgICAgICAgICogYmUgbmFtZWQgYWZ0ZXIgQGJzLCBldmVuIGlmIEB0b3BfYnMgaXMgdGhlIGFj
dHVhbA0KPiArICAgICAgICAgICAgICogc291cmNlKQ0KPiArICAgICAgICAgICAgICovDQo+ICsg
ICAgICAgICAgICBqb2JfaWQgPSBiZHJ2X2dldF9kZXZpY2VfbmFtZShicyk7DQo+ICsgICAgICAg
IH0NCj4gKyAgICAgICAgY29tbWl0X2FjdGl2ZV9zdGFydChqb2JfaWQsIHRvcF9icywgYmFzZV9i
cywgam9iX2ZsYWdzLCBzcGVlZCwgb25fZXJyb3IsDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGZpbHRlcl9ub2RlX25hbWUsIE5VTEwsIE5VTEwsIGZhbHNlLCAmbG9jYWxfZXJyKTsN
Cj4gICAgICAgfSBlbHNlIHsNCj4gICAgICAgICAgIEJsb2NrRHJpdmVyU3RhdGUgKm92ZXJsYXlf
YnMgPSBiZHJ2X2ZpbmRfb3ZlcmxheShicywgdG9wX2JzKTsNCj4gDQoNCg0KLS0gDQpCZXN0IHJl
Z2FyZHMsDQpWbGFkaW1pcg0K

