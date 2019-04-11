Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588E2C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 16:04:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F2922133D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 16:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GvtEj9aK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F2922133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51536 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEcBl-0000H6-Qg
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 12:04:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEcA1-0007gt-6A
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:02:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEc9x-0000ST-B3
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:02:43 -0400
Received: from mail-eopbgr50115.outbound.protection.outlook.com
	([40.107.5.115]:8366
	helo=EUR03-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hEc9i-00008i-TM; Thu, 11 Apr 2019 12:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=WfXlN1Td7PM4W6mS7IZ8IUUSvcOrg9KNytP1uMQcm/M=;
	b=GvtEj9aKxZbhOY+HWa90K6NSN+iDx0ElFdS4hPonMAgioJ7bI0ieOhkt1JjBnoG+adTo1NOURipSWzRYEEs4wKm+ySDgOkYg1PzDal6J6vaBZQjeMDNJ3diC4/yM83VvkmTMVwdLQA9vN0DExkamRdkZCqrJjfnbe9wxrY0nbuc=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3403.eurprd08.prod.outlook.com (20.176.238.96) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1792.14; Thu, 11 Apr 2019 16:02:20 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1771.021;
	Thu, 11 Apr 2019 16:02:20 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v4 10/10] iotests: test nbd reconnect
Thread-Index: AQHUKPQ21gyj5rUokkeGsvxLDOh+a6WzKxqAgIWC3IA=
Date: Thu, 11 Apr 2019 16:02:19 +0000
Message-ID: <cfc22244-f796-746a-ce68-a372675dd9a3@virtuozzo.com>
References: <20180731173033.75467-1-vsementsov@virtuozzo.com>
	<20180731173033.75467-11-vsementsov@virtuozzo.com>
	<bc4780d7-dc96-e050-dfe0-1a47d99893d5@redhat.com>
In-Reply-To: <bc4780d7-dc96-e050-dfe0-1a47d99893d5@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0261.eurprd05.prod.outlook.com
	(2603:10a6:3:fc::13) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190411190217081
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e89145e-7e49-42cc-4069-08d6be971397
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3403; 
x-ms-traffictypediagnostic: DB7PR08MB3403:
x-microsoft-antispam-prvs: <DB7PR08MB3403F9693DAF9BDE6D30DDBAC12F0@DB7PR08MB3403.eurprd08.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(346002)(376002)(39850400004)(136003)(396003)(189003)(55674003)(199004)(14454004)(6436002)(97736004)(6116002)(3846002)(256004)(229853002)(36756003)(99286004)(316002)(2616005)(476003)(6246003)(6512007)(53936002)(6486002)(25786009)(31686004)(446003)(486006)(110136005)(54906003)(11346002)(8936002)(305945005)(102836004)(86362001)(71190400001)(7736002)(4326008)(2201001)(186003)(26005)(5660300002)(66066001)(2501003)(31696002)(68736007)(105586002)(71200400001)(106356001)(107886003)(6506007)(8676002)(53546011)(386003)(478600001)(52116002)(2906002)(76176011)(81166006)(81156014);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3403;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: B4ROI6TbjXI1bEYw9X5nnUuCogikQYxrJJQ4Fu8by0zhJjT4X3Aik9Pt38WglDeANzYf1Znf2NGJ3ukf9PODlNYxQXDeo9MV49ilNQodo0H7PsjzaWJyDR7l8Sc6NQ84x3Z5t84FTuaRaE/qw6mJJy9QMizCsPHtrO/EMc7EIGO3C/tj6aI6I5zdW5lLpzrJ2omMtpePJOD+WiWN3Mjf1JMvdfRmv85GKPvVwwpgpKvHoe6Tq3xQZyjziaAwt0ChW9r4b2oMm8DvUYlZXJHWwhri3REr1rGSTifIK/qZSaz/xn1nX0NCvf2iriXc1MPWT+keEXA3Badk63jUvmAq3LWE6Tv6Wl+SJA+5zwsFh8Cbw6XprTT6QOa+hYsi9ckPYLjWLXae6vZj7XA/paEKFrP5VEcIJliLPIwIKsYJiCs=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <DCA56F1028E73F4FA807B4D79EA0C083@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e89145e-7e49-42cc-4069-08d6be971397
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 16:02:20.0154 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3403
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.115
Subject: Re: [Qemu-devel] [PATCH v4 10/10] iotests: test nbd reconnect
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
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	Denis Lunev <den@virtuozzo.com>, "armbru@redhat.com" <armbru@redhat.com>,
	"mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411160219.LYkGvAw_ZyXMSrxsQgXVLnnFB4b7MPe9kHW8r4TKHCg@z>

MTYuMDEuMjAxOSAyMDoxMSwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gNy8zMS8xOCAxMjozMCBQ
TSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IEFkZCB0ZXN0LCB3aGlj
aCBzdGFydHMgYmFja3VwIHRvIG5iZCB0YXJnZXQgYW5kIHJlc3RhcnRzIG5iZCBzZXJ2ZXINCj4+
IGR1cmluZyBiYWNrdXAuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292
LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4gLS0tDQo+PiAgIHRlc3Rz
L3FlbXUtaW90ZXN0cy8yMjAgICAgICAgIHwgNjcgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMjIwLm91dCAgICB8ICA3
ICsrKysrDQo+PiAgIHRlc3RzL3FlbXUtaW90ZXN0cy9ncm91cCAgICAgIHwgIDEgKw0KPj4gICB0
ZXN0cy9xZW11LWlvdGVzdHMvaW90ZXN0cy5weSB8ICA0ICsrKw0KPj4gICA0IGZpbGVzIGNoYW5n
ZWQsIDc5IGluc2VydGlvbnMoKykNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNzU1IHRlc3RzL3FlbXUt
aW90ZXN0cy8yMjANCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3FlbXUtaW90ZXN0cy8y
MjAub3V0DQo+Pg0KPiANCj4gVGVzdCAyMjAgaGFzIGJlZW4gY3JlYXRlZCBpbiB0aGUgbWVhbnRp
bWU7IHRoZSBvYnZpb3VzIHJlc29sdXRpb24gaXMgdG8NCj4gcGljayBhIG5ldyB0ZXN0IG51bWJl
ci4NCj4gDQo+PiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzIyMCBiL3Rlc3RzL3Fl
bXUtaW90ZXN0cy8yMjANCj4+IG5ldyBmaWxlIG1vZGUgMTAwNzU1DQo+PiBpbmRleCAwMDAwMDAw
MDAwLi5jOTcwMmE3ZGFkDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi90ZXN0cy9xZW11LWlv
dGVzdHMvMjIwDQo+PiBAQCAtMCwwICsxLDY3IEBADQo+PiArIyEvdXNyL2Jpbi9lbnYgcHl0aG9u
DQo+IA0KPj4gKw0KPj4gK2ltcG9ydCBpb3Rlc3RzDQo+PiArZnJvbSBpb3Rlc3RzIGltcG9ydCBx
ZW11X2ltZ19jcmVhdGUsIGZpbGVfcGF0aCwgcWVtdV9uYmRfcG9wZW4NCj4+ICsNCj4+ICtkaXNr
X2EsIGRpc2tfYiwgbmJkX3NvY2sgPSBmaWxlX3BhdGgoJ2Rpc2tfYScsICdkaXNrX2InLCAnbmJk
LXNvY2snKQ0KPj4gK25iZF91cmkgPSAnbmJkK3VuaXg6Ly8vZXhwP3NvY2tldD0nICsgbmJkX3Nv
Y2sNCj4+ICsNCj4+ICtxZW11X2ltZ19jcmVhdGUoJy1mJywgaW90ZXN0cy5pbWdmbXQsIGRpc2tf
YSwgJzVNJykNCj4+ICtxZW11X2ltZ19jcmVhdGUoJy1mJywgaW90ZXN0cy5pbWdmbXQsIGRpc2tf
YiwgJzVNJykNCj4+ICtzcnYgPSBxZW11X25iZF9wb3BlbignLWsnLCBuYmRfc29jaywgJy14Jywg
J2V4cCcsICctZicsIGlvdGVzdHMuaW1nZm10LCBkaXNrX2IpDQo+PiArdGltZS5zbGVlcCgxKQ0K
Pj4gKw0KPj4gK3ZtID0gaW90ZXN0cy5WTSgpLmFkZF9kcml2ZShkaXNrX2EpDQo+PiArdm0ubGF1
bmNoKCkNCj4+ICt2bS5obXBfcWVtdV9pbygnZHJpdmUwJywgJ3dyaXRlIDAgNU0nKQ0KPj4gKw0K
Pj4gK3ByaW50ICdibG9ja2Rldi1hZGQ6Jywgdm0ucW1wKCdibG9ja2Rldi1hZGQnLCBub2RlX25h
bWU9J2JhY2t1cDAnLCBkcml2ZXI9J3JhdycsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgZmlsZT17J2RyaXZlcic6J25iZCcsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgJ2V4cG9ydCc6ICdleHAnLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICdzZXJ2ZXInOiB7J3R5cGUnOiAndW5peCcsDQo+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAncGF0aCc6IG5iZF9zb2NrfX0pDQo+
PiArcHJpbnQgJ2Jsb2NrZGV2LWJhY2t1cDonLCB2bS5xbXAoJ2Jsb2NrZGV2LWJhY2t1cCcsIGRl
dmljZT0nZHJpdmUwJywNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzeW5j
PSdmdWxsJywgdGFyZ2V0PSdiYWNrdXAwJykNCj4+ICsNCj4+ICt0aW1lLnNsZWVwKDEpDQo+PiAr
cHJpbnQgJ0tpbGwgTkJEIHNlcnZlcicNCj4+ICtzcnYua2lsbCgpDQo+PiArDQo+PiAram9icyA9
IHZtLnFtcCgncXVlcnktYmxvY2stam9icycpWydyZXR1cm4nXQ0KPj4gK2lmIGpvYnMgYW5kIGpv
YnNbMF1bJ29mZnNldCddIDwgam9ic1swXVsnbGVuJ106DQo+PiArICAgIHByaW50ICdCYWNrdXAg
am9iIGlzIHN0aWxsIGluIHByb2dyZXNzJw0KPj4gKw0KPj4gK3RpbWUuc2xlZXAoMSkNCj4gDQo+
IFRoYXQncyBhIGxvdCBvZiBzbGVlcCgpcyBmb3IgYSB0ZXN0IG1hcmtlZCBxdWljay4gQXJlIHdl
IHN1cmUgaXQgd29uJ3QNCj4gZmFpbCB1bmRlciBoZWF2eSBsb2FkPyBDYW4geW91IG1ha2UgdGhl
IHRlc3QgbW9yZSByZWxpYWJsZSBieSBsb29raW5nDQo+IGZvciBzcGVjaWZpYyBldmVudHMgcmF0
aGVyIHRoYW4ganVzdCBhIGZpeGVkLWxlbmd0aCBzbGVlcD8NCg0KSG1tLi4gMyBzZWNvbmRzIGlz
IHN0aWxsIHF1aWNrIEkgdGhpbmsuDQoNCkZpcnN0bHkgSSB3YW50IG5iZCBzZXJ2ZXIgdG8gYmUg
YWN0dWFsbHkgc3RhcnRlZCwgYnV0IGl0IGhhcyBubyBldmVudHMuIFRoZW4gSSB3YW50DQpiYWNr
dXAgdG8gZG8gc29tZSBwcm9ncmVzcywgYWdhaW4sIG5vIGV2ZW50IGZvciBwcm9ncmVzcy4gQW5k
IHRoZSBsYXN0IG9uZSBhY3R1YWwgc2VydmVyDQp1bmF2YWlsYWJsZSB0aW1lLi4gU28sIEkgZG9u
J3QgaGF2ZSBiZXR0ZXIgaWRlYS4NCg0KPiANCj4+ICsNCj4+ICtwcmludCAnU3RhcnQgTkJEIHNl
cnZlcicNCj4+ICtzcnYgPSBxZW11X25iZF9wb3BlbignLWsnLCBuYmRfc29jaywgJy14JywgJ2V4
cCcsICctZicsIGlvdGVzdHMuaW1nZm10LCBkaXNrX2IpDQo+PiArDQo+PiArdHJ5Og0KPj4gKyAg
ICBlID0gdm0uZXZlbnRfd2FpdCgnQkxPQ0tfSk9CX0NPTVBMRVRFRCcpDQo+PiArICAgIHByaW50
IGVbJ2V2ZW50J10sICc6JywgZVsnZGF0YSddDQo+PiArZXhjZXB0Og0KPj4gKyAgICBwYXNzDQo+
PiArDQo+PiArcHJpbnQgJ2Jsb2NrZGV2LWRlbDonLCB2bS5xbXAoJ2Jsb2NrZGV2LWRlbCcsIG5v
ZGVfbmFtZT0nYmFja3VwMCcpDQo+PiArc3J2LmtpbGwoKQ0KPj4gK3ZtLnNodXRkb3duKCkNCj4+
IGRpZmYgLS1naXQgYS90ZXN0cy9xZW11LWlvdGVzdHMvMjIwLm91dCBiL3Rlc3RzL3FlbXUtaW90
ZXN0cy8yMjAub3V0DQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAw
MC4uZGFlMWE0OWQ5Zg0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvdGVzdHMvcWVtdS1pb3Rl
c3RzLzIyMC5vdXQNCj4+IEBAIC0wLDAgKzEsNyBAQA0KPj4gK2Jsb2NrZGV2LWFkZDoge3UncmV0
dXJuJzoge319DQo+PiArYmxvY2tkZXYtYmFja3VwOiB7dSdyZXR1cm4nOiB7fX0NCj4+ICtLaWxs
IE5CRCBzZXJ2ZXINCj4+ICtCYWNrdXAgam9iIGlzIHN0aWxsIGluIHByb2dyZXNzDQo+PiArU3Rh
cnQgTkJEIHNlcnZlcg0KPj4gK0JMT0NLX0pPQl9DT01QTEVURUQgOiB7dSdkZXZpY2UnOiB1J2Ry
aXZlMCcsIHUndHlwZSc6IHUnYmFja3VwJywgdSdzcGVlZCc6IDAsIHUnbGVuJzogNTI0Mjg4MCwg
dSdvZmZzZXQnOiA1MjQyODgwfQ0KPj4gK2Jsb2NrZGV2LWRlbDoge3UncmV0dXJuJzoge319DQo+
PiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3RzL2dyb3VwIGIvdGVzdHMvcWVtdS1pb3Rl
c3RzL2dyb3VwDQo+PiBpbmRleCBiOTczZGM4NDJkLi5lZTI0NzNjNmEzIDEwMDY0NA0KPj4gLS0t
IGEvdGVzdHMvcWVtdS1pb3Rlc3RzL2dyb3VwDQo+PiArKysgYi90ZXN0cy9xZW11LWlvdGVzdHMv
Z3JvdXANCj4+IEBAIC0yMTksNiArMjE5LDcgQEANCj4+ICAgMjE3IHJ3IGF1dG8gcXVpY2sNCj4+
ICAgMjE4IHJ3IGF1dG8gcXVpY2sNCj4+ICAgMjE5IHJ3IGF1dG8NCj4+ICsyMjAgcncgYXV0byBx
dWljaw0KPj4gICAyMjEgcncgYXV0byBxdWljaw0KPj4gICAyMjIgcncgYXV0byBxdWljaw0KPj4g
ICAyMjMgcncgYXV0byBxdWljaw0KPj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3FlbXUtaW90ZXN0cy9p
b3Rlc3RzLnB5IGIvdGVzdHMvcWVtdS1pb3Rlc3RzL2lvdGVzdHMucHkNCj4+IGluZGV4IDRlNjdm
YmJlOTYuLjE3YmM4YzhlMzIgMTAwNjQ0DQo+PiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvaW90
ZXN0cy5weQ0KPj4gKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzL2lvdGVzdHMucHkNCj4+IEBAIC0x
ODUsNiArMTg1LDEwIEBAIGRlZiBxZW11X25iZCgqYXJncyk6DQo+PiAgICAgICAnJydSdW4gcWVt
dS1uYmQgaW4gZGFlbW9uIG1vZGUgYW5kIHJldHVybiB0aGUgcGFyZW50J3MgZXhpdCBjb2RlJycn
DQo+PiAgICAgICByZXR1cm4gc3VicHJvY2Vzcy5jYWxsKHFlbXVfbmJkX2FyZ3MgKyBbJy0tZm9y
ayddICsgbGlzdChhcmdzKSkNCj4+ICAgDQo+PiArZGVmIHFlbXVfbmJkX3BvcGVuKCphcmdzKToN
Cj4+ICsgICAgJycnUnVuIHFlbXUtbmJkIGluIGRhZW1vbiBtb2RlIGFuZCByZXR1cm4gdGhlIHBh
cmVudCdzIGV4aXQgY29kZScnJw0KPj4gKyAgICByZXR1cm4gc3VicHJvY2Vzcy5Qb3BlbihxZW11
X25iZF9hcmdzICsgWyctLXBlcnNpc3RlbnQnXSArIGxpc3QoYXJncykpDQo+PiArDQo+PiAgIGRl
ZiBjb21wYXJlX2ltYWdlcyhpbWcxLCBpbWcyLCBmbXQxPWltZ2ZtdCwgZm10Mj1pbWdmbXQpOg0K
Pj4gICAgICAgJycnUmV0dXJuIFRydWUgaWYgdHdvIGltYWdlIGZpbGVzIGFyZSBpZGVudGljYWwn
JycNCj4+ICAgICAgIHJldHVybiBxZW11X2ltZygnY29tcGFyZScsICctZicsIGZtdDEsDQo+Pg0K
PiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

