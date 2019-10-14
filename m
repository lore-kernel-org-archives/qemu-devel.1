Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C005ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 09:18:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D37720659
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 09:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hZhrQScU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D37720659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJwV7-00082U-14
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 05:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iJwSP-0006CO-6B
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 05:16:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iJwSN-0002Ji-M0
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 05:16:01 -0400
Received: from mail-eopbgr130092.outbound.protection.outlook.com
 ([40.107.13.92]:48902 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iJwSN-0002I6-A4
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 05:15:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+9dJrHOa802Xy/Rgqmh3rTjrSi7ayuR9ipGmJTsdcGoIB55mC9Lv6eVNkTRdHj6c8PsZGo+pVof4pwhNy+6fq9GeHF/+nA3WmImxKV6+V2gdQjgBq/Cg7wApuqFSpiZHWsn89Cx6A8LX2O+HhShEptmTHyKgx2KrwXp8s4zgIRm2BZxs8/dNSL0lejATaW3fv6toXjkXjO3AR5jDb9J2LIrNlARTe6bApmFXlUMPMuWqSoDMCUuO1idbcMHw3Y/PRtEJ+htF2EM5Xx87SV3NAVUQ6idUbJ67JjUtoFjcBda08hHyqOcO5NiCmxh23cOrQNpRQZC1gy36EinZSAsvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6+vvla83T4bVRJeXZzSNZzcgljQewm9OtCOXxeSqLY=;
 b=T/YqNKYfLe165yg3g9HFVe0nHXA2xzv30TbGXuWGKIg1cVwt0npumdWicdUVia0jkL7N5LXL2TiPQCu1DXpjgHUPnIShN0JZtUbXfcIXmYHPoRTg+iYim+kO2+GFY9kmxHW2kKmG6U6bBg65IFLEMOXAu6qel8RL+jCT/zKxKA7UMHKZ6URZitE8nM1jFQl+zlaFz30lhyg2HyezSfAb1lG1lvgw8y48ny7dXY6u85lYavCkEhqBh0qySFYuimCGr+gtJ3K9+eYFq1Ewp4EpK98I+fBCq58HJSEBhWfjFuosZEwQH4hUbjcGqRlmyG5GFct1mWSboP9/SwKKzuueIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6+vvla83T4bVRJeXZzSNZzcgljQewm9OtCOXxeSqLY=;
 b=hZhrQScUeRC9f1oxbsTILW39ZLV6rss1QBZ8fzmmnwRZyPAcRZZXE/RQN0M9DEh9ziyd4V2nBhL3G7PRHusioO3WrGRt161Hu0Wps3FwZl6EUP4qUH5e1N2rGjdI8Ef7aF2Msha4TKYfGCrTifQRIZz5op4Adf+67HZs2Dr7k4I=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5195.eurprd08.prod.outlook.com (20.179.15.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Mon, 14 Oct 2019 09:15:57 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2347.021; Mon, 14 Oct 2019
 09:15:57 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Eric Blake
 <eblake@redhat.com>
Subject: Re: [RFC v5 121/126] hw/sd/ssi-sd.c: introduce ERRP_AUTO_PROPAGATE
Thread-Topic: [RFC v5 121/126] hw/sd/ssi-sd.c: introduce ERRP_AUTO_PROPAGATE
Thread-Index: AQHVgFAeU/NDl8/6KE+3Ou+1v7KVfqdWjTeAgANPtwCAAAHwAIAAAHcA
Date: Mon, 14 Oct 2019 09:15:57 +0000
Message-ID: <c3973e38-fa7c-80c9-48e8-62725d9d60af@virtuozzo.com>
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-122-vsementsov@virtuozzo.com>
 <fe720ff6-0949-fced-8d33-2e8dcb5d568a@redhat.com>
 <8af36e08-26ce-4a49-00f8-a50affe0132f@virtuozzo.com>
 <a8610c4e-2f33-a348-e44e-688e6ca3c4e1@redhat.com>
In-Reply-To: <a8610c4e-2f33-a348-e44e-688e6ca3c4e1@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0170.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::18) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191014121554504
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2227156-8e3e-4dbe-140e-08d750871f2c
x-ms-traffictypediagnostic: DB8PR08MB5195:
x-microsoft-antispam-prvs: <DB8PR08MB51957968192F6B9F7959C0DEC1900@DB8PR08MB5195.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 01901B3451
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(39850400004)(136003)(346002)(366004)(396003)(189003)(199004)(486006)(76176011)(476003)(110136005)(54906003)(64756008)(26005)(71200400001)(66946007)(66556008)(66476007)(31686004)(31696002)(66446008)(86362001)(186003)(71190400001)(316002)(36756003)(6512007)(6506007)(446003)(11346002)(386003)(2616005)(66066001)(53546011)(14444005)(256004)(52116002)(102836004)(305945005)(6486002)(6246003)(8936002)(14454004)(478600001)(2906002)(2501003)(8676002)(4326008)(81156014)(81166006)(6436002)(7736002)(229853002)(5660300002)(6116002)(3846002)(25786009)(99286004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5195;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GoZ26LxO1Bg4nHk1xZPXOFRP3rV4oQfcP5TxC49utRAm8077IyPYSg7GdTp65hgKRGmBhRcAc0cc2b1ZcGXNp1WgWxa3HXI3Q7aWFTBZDsopmRdfBtj+Np9CGRyaomtA0punWykLku9gyV2n+vg0qIXwmBAV9aztj9JO4KmKhCvuIPHeOmPMnHS+s4Df+o8JnUFQ1j4jLgUbVaA0MDT9wfvgFOd8PtQws/FlotIgJkYoFc6JD/w1t7L950CxpnLbw20en7n1IR53jZ+lVs+63YNGPaEefYqfnxO+GQ0WnIXS1KvuywvFUnD7NBieCwKYZpbUyDd5eatEMJkDASXgr7HwYC6Ol4YVQWR75JwOboqxn63iqTNYcZ3Q8+1pcmKJvlM1hqTwFfs16DFNkUZy/KY/nhFGB+WPeasGyKFTgLw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C4D9B8B33E71741AFE74798F5BA292B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2227156-8e3e-4dbe-140e-08d750871f2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2019 09:15:57.1675 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R+QeGKiT5ZSt3IAozW/PVJD0O92r6Sljm0OFlzM8FVHGMiWiiGtKx/7jenNb9zS6qQLOisBpjUDcEAo7QUiOnvJcmNyBoUcgRllMPKYnULM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5195
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.92
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
Cc: Kevin Wolf <kwolf@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTQuMTAuMjAxOSAxMjoxNCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9uIDEw
LzE0LzE5IDExOjA3IEFNLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4g
MTIuMTAuMjAxOSA5OjMzLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+PiBPbiAx
MC8xMS8xOSA2OjA1IFBNLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4+
PiBJZiB3ZSB3YW50IHRvIGFkZCBzb21lIGluZm8gdG8gZXJycCAoYnkgZXJyb3JfcHJlcGVuZCgp
IG9yDQo+Pj4+IGVycm9yX2FwcGVuZF9oaW50KCkpLCB3ZSBtdXN0IHVzZSB0aGUgRVJSUF9BVVRP
X1BST1BBR0FURSBtYWNyby4NCj4+Pj4gT3RoZXJ3aXNlLCB0aGlzIGluZm8gd2lsbCBub3QgYmUg
YWRkZWQgd2hlbiBlcnJwID09ICZmYXRhbF9lcnINCj4+Pj4gKHRoZSBwcm9ncmFtIHdpbGwgZXhp
dCBwcmlvciB0byB0aGUgZXJyb3JfYXBwZW5kX2hpbnQoKSBvcg0KPj4+PiBlcnJvcl9wcmVwZW5k
KCkgY2FsbCkuwqAgRml4IHN1Y2ggY2FzZXMuDQo+Pj4+DQo+Pj4+IElmIHdlIHdhbnQgdG8gY2hl
Y2sgZXJyb3IgYWZ0ZXIgZXJycC1mdW5jdGlvbiBjYWxsLCB3ZSBuZWVkIHRvDQo+Pj4+IGludHJv
ZHVjZSBsb2NhbF9lcnIgYW5kIHRoYW4gcHJvcGFnYXRlIGl0IHRvIGVycnAuIEluc3RlYWQsIHVz
ZQ0KPj4+PiBFUlJQX0FVVE9fUFJPUEFHQVRFIG1hY3JvLCBiZW5lZml0cyBhcmU6DQo+Pj4+IDEu
IE5vIG5lZWQgb2YgZXhwbGljaXQgZXJyb3JfcHJvcGFnYXRlIGNhbGwNCj4+Pj4gMi4gTm8gbmVl
ZCBvZiBleHBsaWNpdCBsb2NhbF9lcnIgdmFyaWFibGU6IHVzZSBlcnJwIGRpcmVjdGx5DQo+Pj4+
IDMuIEVSUlBfQVVUT19QUk9QQUdBVEUgbGVhdmVzIGVycnAgYXMgaXMgaWYgaXQncyBub3QgTlVM
TCBvcg0KPj4+PiDCoMKgwqDCoCAmZXJyb3JfZmF0ZWwsIHRoaXMgbWVhbnMgdGhhdCB3ZSBkb24n
dCBicmVhayBlcnJvcl9hYm9ydA0KPj4+PiDCoMKgwqDCoCAod2UnbGwgYWJvcnQgb24gZXJyb3Jf
c2V0LCBub3Qgb24gZXJyb3JfcHJvcGFnYXRlKQ0KPj4+Pg0KPj4+PiBUaGlzIGNvbW1pdCAodG9n
ZXRoZXIgd2l0aCBpdHMgbmVpZ2hib3JzKSB3YXMgZ2VuZXJhdGVkIGJ5DQo+Pj4+DQo+Pj4+IGZv
ciBmIGluICQoZ2l0IGdyZXAgLWwgZXJycCBcKi5bY2hdKTsgZG8gXA0KPj4+PiDCoMKgwqDCoMKg
IHNwYXRjaCAtLXNwLWZpbGUgc2NyaXB0cy9jb2NjaW5lbGxlL2F1dG8tcHJvcGFnYXRlZC1lcnJw
LmNvY2NpIFwNCj4+Pj4gwqDCoMKgwqDCoCAtLW1hY3JvLWZpbGUgc2NyaXB0cy9jb2NjaS1tYWNy
by1maWxlLmggLS1pbi1wbGFjZSAtLW5vLXNob3ctZGlmZiAkZjsgXA0KPj4+PiBkb25lOw0KPj4+
Pg0KPj4+PiB0aGVuIGZpeCBhIGJpdCBvZiBjb21waWxhdGlvbiBwcm9ibGVtczogY29jY2luZWxs
ZSBmb3Igc29tZSByZWFzb24NCj4+Pj4gbGVhdmVzIHNldmVyYWwNCj4+Pj4gZigpIHsNCj4+Pj4g
wqDCoMKgwqDCoCAuLi4NCj4+Pj4gwqDCoMKgwqDCoCBnb3RvIG91dDsNCj4+Pj4gwqDCoMKgwqDC
oCAuLi4NCj4+Pj4gwqDCoMKgwqDCoCBvdXQ6DQo+Pj4+IH0NCj4+Pj4gcGF0dGVybnMsIHdpdGgg
Im91dDoiIGF0IGZ1bmN0aW9uIGVuZC4NCj4+Pj4NCj4+Pj4gdGhlbg0KPj4+PiAuL3B5dGhvbi9j
b21taXQtcGVyLXN1YnN5c3RlbS5weSBNQUlOVEFJTkVSUyAiJCg8IGF1dG8tbXNnKSINCj4+Pj4N
Cj4+Pj4gKGF1dG8tbXNnIHdhcyBhIGZpbGUgd2l0aCB0aGlzIGNvbW1pdCBtZXNzYWdlKQ0KPj4+
Pg0KPj4+PiBTdGlsbCwgZm9yIGJhY2twb3J0aW5nIGl0IG1heSBiZSBtb3JlIGNvbWZvcnRhYmxl
IHRvIHVzZSBvbmx5IHRoZSBmaXJzdA0KPj4+PiBjb21tYW5kIGFuZCB0aGVuIGRvIG9uZSBodWdl
IGNvbW1pdC4NCj4+Pj4NCj4+Pj4gUmVwb3J0ZWQtYnk6IEtldmluIFdvbGYgPGt3b2xmQHJlZGhh
dC5jb20+DQo+Pj4+IFJlcG9ydGVkLWJ5OiBHcmVnIEt1cnogPGdyb3VnQGthb2Qub3JnPg0KPj4+
PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292
QHZpcnR1b3p6by5jb20+DQo+Pj4+IC0tLQ0KPj4+PiDCoMKgIGh3L3NkL3NzaS1zZC5jIHwgMTQg
KysrKysrKystLS0tLS0NCj4+Pj4gwqDCoCAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCsp
LCA2IGRlbGV0aW9ucygtKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvaHcvc2Qvc3NpLXNkLmMg
Yi9ody9zZC9zc2ktc2QuYw0KPj4+PiBpbmRleCA5MWRiMDY5MjEyLi5mNDIyMDRkNjQ5IDEwMDY0
NA0KPj4+PiAtLS0gYS9ody9zZC9zc2ktc2QuYw0KPj4+PiArKysgYi9ody9zZC9zc2ktc2QuYw0K
Pj4+PiBAQCAtMjQxLDEwICsyNDEsMTAgQEAgc3RhdGljIGNvbnN0IFZNU3RhdGVEZXNjcmlwdGlv
biB2bXN0YXRlX3NzaV9zZCA9IHsNCj4+Pj4gwqDCoCBzdGF0aWMgdm9pZCBzc2lfc2RfcmVhbGl6
ZShTU0lTbGF2ZSAqZCwgRXJyb3IgKiplcnJwKQ0KPj4+PiDCoMKgIHsNCj4+Pj4gK8KgwqDCoCBF
UlJQX0FVVE9fUFJPUEFHQVRFKCk7DQo+Pj4+IMKgwqDCoMKgwqDCoCBzc2lfc2Rfc3RhdGUgKnMg
PSBGUk9NX1NTSV9TTEFWRShzc2lfc2Rfc3RhdGUsIGQpOw0KPj4+PiDCoMKgwqDCoMKgwqAgRGV2
aWNlU3RhdGUgKmNhcmRkZXY7DQo+Pj4+IMKgwqDCoMKgwqDCoCBEcml2ZUluZm8gKmRpbmZvOw0K
Pj4+PiAtwqDCoMKgIEVycm9yICplcnIgPSBOVUxMOw0KPj4+PiDCoMKgwqDCoMKgwqAgcWJ1c19j
cmVhdGVfaW5wbGFjZSgmcy0+c2RidXMsIHNpemVvZihzLT5zZGJ1cyksIFRZUEVfU0RfQlVTLA0K
Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IERFVklDRShkKSwgInNkLWJ1cyIpOw0KPj4+PiBAQCAtMjU0LDEyICsyNTQsMTQgQEAgc3RhdGlj
IHZvaWQgc3NpX3NkX3JlYWxpemUoU1NJU2xhdmUgKmQsIEVycm9yICoqZXJycCkNCj4+Pj4gwqDC
oMKgwqDCoMKgIGRpbmZvID0gZHJpdmVfZ2V0X25leHQoSUZfU0QpOw0KPj4+PiDCoMKgwqDCoMKg
wqAgY2FyZGRldiA9IHFkZXZfY3JlYXRlKEJVUygmcy0+c2RidXMpLCBUWVBFX1NEX0NBUkQpOw0K
Pj4+PiDCoMKgwqDCoMKgwqAgaWYgKGRpbmZvKSB7DQo+Pj4+IC3CoMKgwqDCoMKgwqDCoCBxZGV2
X3Byb3Bfc2V0X2RyaXZlKGNhcmRkZXYsICJkcml2ZSIsIGJsa19ieV9sZWdhY3lfZGluZm8oZGlu
Zm8pLCAmZXJyKTsNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHFkZXZfcHJvcF9zZXRfZHJpdmUoY2Fy
ZGRldiwgImRyaXZlIiwgYmxrX2J5X2xlZ2FjeV9kaW5mbyhkaW5mbyksDQo+Pj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXJycCk7DQo+
Pj4NCj4+PiBUaGlzIGZpdHMgNzIgY2hhcnMsIGNhbiB5b3Uga2VlcCBpdCBpbiB0aGUgc2FtZSBs
aW5lPw0KPj4NCj4+IEhvbmVzdGx5LCBJJ2QgcHJlZmVyIG5vdCBmaXhpbmcgY29kZSBzdHlsZSBp
biB0aGVzZSAxMDAgYXV0by1nZW5lcmF0ZWQgY29tbWl0cy4uLg0KPj4gQnV0IGlmIG9ubHkgeW91
IHJlcXVlc3QgdGhpcywgaXQncyBub3QgYSBwcm9ibGVtLg0KPiANCj4gQWgsIENvY2NpbmVsbGUg
YWRkZWQgdGhlIG5ld2xpbmUuIEhtbSBtYXliZSB0aGVyZSBpcyBhIHNwYXRjaCBhcmd1bWVudCB0
byBzZXQgdGhlIG1heGltdW0gbGluZSBsZW5ndGg/DQo+IA0KPiAkIHNwYXRjaCAtLWxvbmdoZWxw
DQo+IFsuLi5dDQo+ICDCoCAtLWxpbnV4LXNwYWNpbmfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHNwYWNpbmcgb2YgKyBjb2RlIGZvbGxvd3MgdGhlIGNvbnZlbnRpb25zIG9mIExpbnV4DQo+
ICDCoCAtLXNtcGwtc3BhY2luZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzcGFjaW5n
IG9mICsgY29kZSBmb2xsb3dzIHRoZSBzZW1hbnRpYyBwYXRjaA0KPiAgwqAgLS1pbmRlbnTCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVmYXVsdCBpbmRlbnQsIGlu
IHNwYWNlcyAobm8gdGFicykNCj4gIMKgIC0tbWF4LXdpZHRowqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGNvbHVtbiBsaW1pdCBmb3IgZ2VuZXJhdGVkIGNvZGUNCj4gDQo+IEhh
dmUgeW91IHRyaWVkIC0tbWF4LXdpZHRoPyBNYXliZSB3ZSBuZWVkIGEgY29tYmluYXRpb24gd2l0
aCAtLXNtcGwtc3BhY2luZy4NCg0KSG1tLCB0aGFua3MsIEknbGwgdHJ5Lg0KDQo+IA0KPj4+DQo+
Pj4+IMKgwqDCoMKgwqDCoCB9DQo+Pj4+IC3CoMKgwqAgb2JqZWN0X3Byb3BlcnR5X3NldF9ib29s
KE9CSkVDVChjYXJkZGV2KSwgdHJ1ZSwgInNwaSIsICZlcnIpOw0KPj4+PiAtwqDCoMKgIG9iamVj
dF9wcm9wZXJ0eV9zZXRfYm9vbChPQkpFQ1QoY2FyZGRldiksIHRydWUsICJyZWFsaXplZCIsICZl
cnIpOw0KPj4+PiAtwqDCoMKgIGlmIChlcnIpIHsNCj4+Pj4gLcKgwqDCoMKgwqDCoMKgIGVycm9y
X3NldGcoZXJycCwgImZhaWxlZCB0byBpbml0IFNEIGNhcmQ6ICVzIiwgZXJyb3JfZ2V0X3ByZXR0
eShlcnIpKTsNCj4+Pj4gK8KgwqDCoCBvYmplY3RfcHJvcGVydHlfc2V0X2Jvb2woT0JKRUNUKGNh
cmRkZXYpLCB0cnVlLCAic3BpIiwgZXJycCk7DQo+Pj4+ICvCoMKgwqAgb2JqZWN0X3Byb3BlcnR5
X3NldF9ib29sKE9CSkVDVChjYXJkZGV2KSwgdHJ1ZSwgInJlYWxpemVkIiwgZXJycCk7DQo+Pj4+
ICvCoMKgwqAgaWYgKCplcnJwKSB7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBlcnJvcl9zZXRnKGVy
cnAsICJmYWlsZWQgdG8gaW5pdCBTRCBjYXJkOiAlcyIsDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZXJyb3JfZ2V0X3ByZXR0eSgqZXJycCkpOw0KPj4+DQo+Pj4g
RGl0dG8uLi4NCj4+Pg0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo+Pj4+IMKg
wqDCoMKgwqDCoCB9DQo+Pj4+IMKgwqAgfQ0KPj4+Pg0KPj4+DQo+Pj4gSWYgcG9zc2libGUgcGxl
YXNlIHNxdWFzaCB3aXRoICI0Ny8xMjYgU0QgKFNlY3VyZSBDYXJkKSINCj4+DQo+PiBIbW0gdGhp
cyBpcyBpbiBzZXBhcmF0ZSwgYXMgaXQncyB1bm1haW50YWluZWQgYWNjb3JkaW5nbHkgdG8gTUFJ
TlRBSU5FUlMuIEknbGwgcmViYXNlDQo+PiB0aGUgbmV4dCB2ZXJzaW9uIG9uIHlvdXIgTUFJTlRB
SU5FUlMtZml4ZXMgYW5kIGl0IHNob3VsZCB3b3JrLg0KPj4NCj4+Pg0KPj4+IFJldmlld2VkLWJ5
OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQHJlZGhhdC5jb20+DQo+Pg0KPj4gVGhh
bmtzIQ0KPj4NCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

