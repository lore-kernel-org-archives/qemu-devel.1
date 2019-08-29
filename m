Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA128C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 13:24:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4BF92339E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 13:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZdBVsjZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4BF92339E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3KPi-0007Y1-Lb
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 09:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i3KOC-0006gR-Vp
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 09:23:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i3KOB-0003wr-45
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 09:23:00 -0400
Received: from mail-eopbgr150097.outbound.protection.outlook.com
 ([40.107.15.97]:23614 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i3KOA-0003uR-6i; Thu, 29 Aug 2019 09:22:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0DGNri/NoUT8bzA+L0fRMd3TAmmIHRW7HFpFYK8BtLe7wbhyDiqWfaCTW3vTqUQpPNE2YLTIr7jcta5U5p/7G327gAPmNIiVNcsJuzpsFRQfRXkIgfPoGLIlbaMAzSflOqjrXMzEs53SY6bA8oJpCQWtB3t4paawMtpZKG24mfPDkBqFAbEAWd8DqUjAdiBQVIQ/gjsmJM3hnX2JpFZ5Sd95+f1j85dT+Phhb8OWBzYSED55IxKg8PUeu2Q+KOro8tVYfyGeItNvu+41oplnP5i7pEu0Tv81yRPQkRCD5lvqNR0vzfLjkx3En2eRoIKfMxW2yLvxFlT+mhqNg9EJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KoC68ROGbJQVRhCGtkOpZajkdhC9RLaD9v7s0FltG8=;
 b=g8hVV+Fn/DBeiEk/F3ZDDlIpVeB1iLAcBhDctEgo7T/lmqpd9MColAfcaOgTTsOV3jsv4W43s1ZqfpTE09bOVzrwPrSQY7kp+HZGO7ZSTesf/EacxBsxmQTgrKle34vkbp7Eo0w9MuYLd2YLtxHAz5ndbUHvcdtRJH1UxgDUpqlQ2QRgiWTQ6suiNnRe6EGLBa0jOa9cV7wLAB7k1uZ8l+rIo7Pm+aYtInM4Vp+6QNd3iwbTdoCmDy6etKZCq44v7u6niWhn3U1n2N68/FEWGy7atccYN37Owuu5K7BTLBAXcljCxG0uOEMsc6YjDcLwL63gCuNzszf273FP6UZKhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KoC68ROGbJQVRhCGtkOpZajkdhC9RLaD9v7s0FltG8=;
 b=ZdBVsjZTpJsa/oNk2wy7SBbR2Ltik0KqLIwqCxN7WFAV0+Ja3qMWfnO6zXcK6hrDGlZbCL4xfBupadP3nwbSrZvv8odZ2vo8JmmB582F4WIB+EuaciceKeC+4Q8MoKF5kDptPVFZ3e1kOqOxnKhlGKguoraedv03YEK1b67MlTc=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5274.eurprd08.prod.outlook.com (10.255.17.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Thu, 29 Aug 2019 13:22:55 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 13:22:55 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v9 07/13] iotests: prepare 124 and 257 bitmap querying
 for backup-top filter
Thread-Index: AQHVXCk9iayekel4IU+k3gtc2KeuvKcQxmiAgAFa/QA=
Date: Thu, 29 Aug 2019 13:22:55 +0000
Message-ID: <77ac0ee1-166d-fc50-f7b8-24485460b24c@virtuozzo.com>
References: <20190826161312.489398-1-vsementsov@virtuozzo.com>
 <20190826161312.489398-8-vsementsov@virtuozzo.com>
 <8700abe3-01a0-9395-59fb-ca78d9f05a30@redhat.com>
In-Reply-To: <8700abe3-01a0-9395-59fb-ca78d9f05a30@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0035.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::24) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190829162252328
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 394eadb0-e3cf-47ff-7c14-08d72c840079
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5274; 
x-ms-traffictypediagnostic: DB8PR08MB5274:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB5274E5492D104D2326A577FBC1A20@DB8PR08MB5274.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(39840400004)(346002)(136003)(396003)(366004)(199004)(189003)(52116002)(186003)(305945005)(3846002)(7736002)(6116002)(14454004)(86362001)(53936002)(71190400001)(2906002)(486006)(76176011)(31696002)(71200400001)(36756003)(31686004)(107886003)(6246003)(66066001)(11346002)(4326008)(54906003)(316002)(256004)(110136005)(446003)(53546011)(386003)(7416002)(6506007)(26005)(102836004)(64756008)(66476007)(66556008)(66446008)(25786009)(8936002)(6486002)(476003)(5660300002)(229853002)(478600001)(99286004)(8676002)(66946007)(6512007)(81156014)(81166006)(6436002)(2501003)(2616005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5274;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Rh2Lm8KdP3/aE+g/RQ+MQPOOhEHB5gtgIyvMuc4hJWyybtJWY9XvHhF/B2VBnprKB7JO6VpASaTwOhHLeU2/WvBbEdkK8YYT1ouVBBKUKeMm2vER3CYwuy9F65TVzj50KNj1b+WiPifdasx1kQbdWHatZOvLqhYpyoU7PGzbK5ZeUa4Ong/vbi76nA9GFuUzf2KJ5Wt0Yhwb6WcDF6sOgX7RsYbcLQbWu2U5vPQwCtxJIi6Q53i+LJOsAdX1wPtfUmRFPFlfl0eS1aGXtapTzcLVWsET5j2cG9PWBEkQZinEE8Km3SSuwvuibol8Dv0Px7w36C1/RrC/BJF+z9uQOz4uNQSnn4EwoDaPG822T+MrFuJ7hYGNnDL5zUMQxqZaFGvVU7XsRhGqo9KxfLK1fA3Ewppft8DF/d33rzAQp2M=
Content-Type: text/plain; charset="utf-8"
Content-ID: <51A3C016A2112F4A8F4159BA3ED54388@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 394eadb0-e3cf-47ff-7c14-08d72c840079
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 13:22:55.4273 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7H8hImM5WN2YXbuGTGE8OXzjYsLyxZB4dnmLau4Mmw8/nJyGW9gtZgLvwdrF9WhHxrCdps72dQEJQ41mM9aH/kgIYv7iffIlyQ01rspU3+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5274
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.97
Subject: Re: [Qemu-devel] [PATCH v9 07/13] iotests: prepare 124 and 257
 bitmap querying for backup-top filter
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "wencongyang2@huawei.com" <wencongyang2@huawei.com>,
 "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjguMDguMjAxOSAxOTo0MCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyNi4wOC4xOSAxODoxMywg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IEFmdGVyIGJhY2t1cC10b3Ag
ZmlsdGVyIGFwcGVhcmluZyBpdCdzIG5vdCBwb3NzaWJsZSB0byBzZWUgZGlydHkNCj4+IGJpdG1h
cHMgaW4gdG9wIG5vZGUsIHNvIHVzZSBub2RlLW5hbWUgaW5zdGVhZC4NCj4+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6
by5jb20+DQo+PiAtLS0NCj4+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzEyNCAgICAgICAgfCAgIDMg
Ky0NCj4+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzI1NyAgICAgICAgfCAgMzkgKy0tLQ0KPj4gICB0
ZXN0cy9xZW11LWlvdGVzdHMvMjU3Lm91dCAgICB8IDM2NCArKysrKysrKysrKysrLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQo+PiAgIHRlc3RzL3FlbXUtaW90ZXN0cy9pb3Rlc3RzLnB5IHwgIDIyICsr
DQo+PiAgIDQgZmlsZXMgY2hhbmdlZCwgMTczIGluc2VydGlvbnMoKyksIDI1NSBkZWxldGlvbnMo
LSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzEyNCBiL3Rlc3RzL3Fl
bXUtaW90ZXN0cy8xMjQNCj4+IGluZGV4IDM0NDBmNTQ3ODEuLjhiNjAyNDc2OWMgMTAwNzU1DQo+
PiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvMTI0DQo+PiArKysgYi90ZXN0cy9xZW11LWlvdGVz
dHMvMTI0DQo+PiBAQCAtNzQ5LDggKzc0OSw3IEBAIGNsYXNzIFRlc3RJbmNyZW1lbnRhbEJhY2t1
cEJsa2RlYnVnKFRlc3RJbmNyZW1lbnRhbEJhY2t1cEJhc2UpOg0KPj4gICANCj4+ICAgICAgICAg
ICAjIEJpdG1hcCBTdGF0dXMgQ2hlY2sNCj4+ICAgICAgICAgICBxdWVyeSA9IHNlbGYudm0ucW1w
KCdxdWVyeS1ibG9jaycpDQo+PiAtICAgICAgICByZXQgPSBbYm1hcCBmb3IgYm1hcCBpbiBxdWVy
eVsncmV0dXJuJ11bMF1bJ2RpcnR5LWJpdG1hcHMnXQ0KPj4gLSAgICAgICAgICAgICAgIGlmIGJt
YXAuZ2V0KCduYW1lJykgPT0gYml0bWFwLm5hbWVdWzBdDQo+PiArICAgICAgICByZXQgPSBzZWxm
LnZtLmdldF9iaXRtYXAoTm9uZSwgZHJpdmUwWydpZCddLCBiaXRtYXAubmFtZSkNCj4+ICAgICAg
ICAgICBzZWxmLmFzc2VydF9xbXAocmV0LCAnY291bnQnLCA0NTg3NTIpDQo+PiAgICAgICAgICAg
c2VsZi5hc3NlcnRfcW1wKHJldCwgJ2dyYW51bGFyaXR5JywgNjU1MzYpDQo+PiAgICAgICAgICAg
c2VsZi5hc3NlcnRfcW1wKHJldCwgJ3N0YXR1cycsICdmcm96ZW4nKQ0KPiANCj4gSSBzZWUgYSBj
b3VwbGUgbW9yZSBpbnN0YW5jZXMgb2YgcXVlcnlpbmcgdGhlIGJpdG1hcHMgdGhyb3VnaA0KPiBx
dWVyeS1ibG9jayBoZXJlLiAgV291bGRu4oCZdCBpdCBtYWtlIHNlbnNlIHRvIHJlcGxhY2UgdGhl
bSBhbGwgd2l0aA0KPiBnZXRfYml0bWFwKCk/DQo+IA0KPiBbLi4uXQ0KPiANCj4+IGRpZmYgLS1n
aXQgYS90ZXN0cy9xZW11LWlvdGVzdHMvaW90ZXN0cy5weSBiL3Rlc3RzL3FlbXUtaW90ZXN0cy9p
b3Rlc3RzLnB5DQo+PiBpbmRleCA4NDQzOGU4MzdjLi45MzgxOTY0ZDlmIDEwMDY0NA0KPj4gLS0t
IGEvdGVzdHMvcWVtdS1pb3Rlc3RzL2lvdGVzdHMucHkNCj4+ICsrKyBiL3Rlc3RzL3FlbXUtaW90
ZXN0cy9pb3Rlc3RzLnB5DQo+PiBAQCAtNjQzLDYgKzY0MywyOCBAQCBjbGFzcyBWTShxdGVzdC5R
RU1VUXRlc3RNYWNoaW5lKToNCj4+ICAgICAgICAgICAgICAgICAgIHJldHVybiB4DQo+PiAgICAg
ICAgICAgcmV0dXJuIE5vbmUNCj4+ICAgDQo+PiArICAgIGRlZiBxdWVyeV9iaXRtYXBzKHNlbGYp
Og0KPj4gKyAgICAgICAgcmVzID0gc2VsZi5xbXAoInF1ZXJ5LW5hbWVkLWJsb2NrLW5vZGVzIikN
Cj4+ICsgICAgICAgIHJldHVybiB7ImJpdG1hcHMiOiB7ZGV2aWNlWydub2RlLW5hbWUnXTogZGV2
aWNlWydkaXJ0eS1iaXRtYXBzJ10NCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGZvciBkZXZpY2UgaW4gcmVzWydyZXR1cm4nXQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGlmICdkaXJ0eS1iaXRtYXBzJyBpbiBkZXZpY2V9fQ0KPiANCj4gSeKAmWQg
bGVhdmUgdGhlIHdyYXBwaW5nIGluIHsiYml0bWFwcyI6IHh9IHRvIHRoZSBjYWxsZXJzLCBpZiB0
aGV5IG5lZWQgaXQuDQo+IA0KPj4gKw0KPj4gKyAgICBkZWYgZ2V0X2JpdG1hcChzZWxmLCBiaXRt
YXBzLCBub2RlX25hbWUsIG5hbWUsIHJlY29yZGluZz1Ob25lKToNCj4+ICsgICAgICAgICIiIg0K
Pj4gKyAgICAgICAgZ2V0IGEgc3BlY2lmaWMgYml0bWFwIGZyb20gdGhlIG9iamVjdCByZXR1cm5l
ZCBieSBxdWVyeV9iaXRtYXBzLg0KPj4gKyAgICAgICAgOnBhcmFtIHJlY29yZGluZzogSWYgc3Bl
Y2lmaWVkLCBmaWx0ZXIgcmVzdWx0cyBieSB0aGUgc3BlY2lmaWVkIHZhbHVlLg0KPj4gKyAgICAg
ICAgIiIiDQo+PiArICAgICAgICBpZiBiaXRtYXBzIGlzIE5vbmU6DQo+PiArICAgICAgICAgICAg
Yml0bWFwcyA9IHNlbGYucXVlcnlfYml0bWFwcygpDQo+PiArDQo+PiArICAgICAgICBmb3IgYml0
bWFwIGluIGJpdG1hcHNbJ2JpdG1hcHMnXVtub2RlX25hbWVdOg0KPj4gKyAgICAgICAgICAgIGlm
IGJpdG1hcC5nZXQoJ25hbWUnLCAnJykgPT0gbmFtZToNCj4+ICsgICAgICAgICAgICAgICAgaWYg
cmVjb3JkaW5nIGlzIE5vbmU6DQo+PiArICAgICAgICAgICAgICAgICAgICByZXR1cm4gYml0bWFw
DQo+PiArICAgICAgICAgICAgICAgIGVsaWYgYml0bWFwLmdldCgncmVjb3JkaW5nJykgPT0gcmVj
b3JkaW5nOg0KPj4gKyAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGJpdG1hcA0KPiANCj4gTWF5
YmUgYWRkIGEg4oCcYnJlYWvigJ0gb3Ig4oCccmV0dXJuIE5vbmXigJ0gaGVyZT8NCj4gDQo+IChZ
ZXMsIHllcywgeW91IGp1c3QgbW92ZWQgZXhpc3RpbmcgY29kZS4gIFN0aWxsLikNCj4gDQoNCk5v
LCBhcyB3ZSBtYXkgaGF2ZSBzZXZlcmFsIHVubmFtZWQgYml0bWFwcywgd2hpY2ggc2hvdWxkIGJl
IHNlbGVjdGVkIGJ5ICJyZWNvcmRpbmciLi4NCg0KPiANCj4+ICsgICAgICAgIHJldHVybiBOb25l
DQo+PiArDQo+PiAgIA0KPj4gICBpbmRleF9yZSA9IHJlLmNvbXBpbGUocicoW15cW10rKVxbKFte
XF1dKylcXScpDQo+PiAgIA0KPj4NCj4gDQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxh
ZGltaXINCg==

