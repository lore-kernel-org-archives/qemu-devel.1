Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2501EC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 11:59:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6E1F208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 11:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Lq7qAvPY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E1F208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60090 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heICf-0008Bs-G2
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 07:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52087)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1heHvI-0002ZJ-Vh
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:41:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1heHvF-0000mj-TH
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:41:40 -0400
Received: from mail-eopbgr50111.outbound.protection.outlook.com
 ([40.107.5.111]:15173 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1heHv8-0000dE-AH; Fri, 21 Jun 2019 07:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJ8Q14Hq6xMBtmMyJP7uJ7f6a0WBBI5cfOiBdUdavNw=;
 b=Lq7qAvPYE9ElaRubvgx/0ZlphNjO8143w6z/lTELvimilMfWQMJj6iklCpJaJM28Ozst67/Y0K30tBTVpvMsjxKjQU72ZeLavTVhBAF+k0d5PiHZ0pbrJagQAs18MtUja1IeuvmlFTsksz6sV+Wy1M274PZiNtW4uR0rFE1HE8A=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB4743.eurprd08.prod.outlook.com (10.255.79.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Fri, 21 Jun 2019 11:41:23 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 11:41:23 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH 05/12] hbitmap: enable merging across granularities
Thread-Index: AQHVJwQT19qzFPzhvEyXs1QUU1uOMqal/naA
Date: Fri, 21 Jun 2019 11:41:23 +0000
Message-ID: <49880a7b-0af3-3e58-bd84-afc988da9894@virtuozzo.com>
References: <20190620010356.19164-1-jsnow@redhat.com>
 <20190620010356.19164-6-jsnow@redhat.com>
In-Reply-To: <20190620010356.19164-6-jsnow@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0034.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::44) To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190621144121040
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a3d9029-5277-4dd0-ae24-08d6f63d62f3
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4743; 
x-ms-traffictypediagnostic: DBBPR08MB4743:
x-microsoft-antispam-prvs: <DBBPR08MB4743C221A56490A8E4D8C7A9C1E70@DBBPR08MB4743.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(376002)(346002)(396003)(366004)(136003)(189003)(199004)(486006)(4326008)(64756008)(2616005)(305945005)(386003)(3846002)(36756003)(66066001)(73956011)(14444005)(316002)(81156014)(6486002)(6436002)(6512007)(2906002)(7736002)(71190400001)(2501003)(54906003)(71200400001)(5660300002)(31696002)(68736007)(7416002)(11346002)(26005)(8936002)(446003)(476003)(66476007)(229853002)(110136005)(256004)(66946007)(6506007)(2201001)(102836004)(99286004)(186003)(66556008)(14454004)(6116002)(66446008)(478600001)(86362001)(25786009)(6246003)(81166006)(53936002)(8676002)(31686004)(52116002)(76176011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4743;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 51S5B8I2BmvOkoO8E9jXtDgcXhPF1ck6KAMGD7VlM02QsHjybzWTtW+e6U2ot/SeflnId5jImqeGCyoW3RIW3rsa1rovSlF+It4RrLi1DnXqSjNNGIyiNT7YNTRxi7z8uFssTt7/fOD8M03dbYlWOFuQg9m/0vTkK+YAg4dk71fatu7AL9EmJJDuvW7p7X7qTjRwVc8Ch09eeh+rwGqi/CpkSbUJlLhEID89c5HJq2dOZTyx7BhhL+2L7WejBr0r6HrMjlBiC208iuktmu07VE+31ZQYcbK6kDMktS6x0Bx7LsLhpVhxItjs01p2lLFkKCM2gRIX2uBEhphB086FkHgnRyecBockLdcpq0CZIWnHdwEyOYPnr+ER1LB8CkYWoe0/OJSkNIaeX6wH175AZZICWv6KkK8E/0GtgYcwduQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <134380F54E0A1E44B777D9BED7F30FB3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a3d9029-5277-4dd0-ae24-08d6f63d62f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 11:41:23.8225 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4743
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.111
Subject: Re: [Qemu-devel] [PATCH 05/12] hbitmap: enable merging across
 granularities
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjAuMDYuMjAxOSA0OjAzLCBKb2huIFNub3cgd3JvdGU6DQo+IFNpZ25lZC1vZmYtYnk6IEpvaG4g
U25vdyA8anNub3dAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICAgdXRpbC9oYml0bWFwLmMgfCAyMiAr
KysrKysrKysrKysrKysrKysrKystDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS91dGlsL2hiaXRtYXAuYyBiL3V0
aWwvaGJpdG1hcC5jDQo+IGluZGV4IDQ1ZDE3MjVkYWYuLjBkNjcyNGI3YmMgMTAwNjQ0DQo+IC0t
LSBhL3V0aWwvaGJpdG1hcC5jDQo+ICsrKyBiL3V0aWwvaGJpdG1hcC5jDQo+IEBAIC03NzcsNyAr
Nzc3LDE3IEBAIHZvaWQgaGJpdG1hcF90cnVuY2F0ZShIQml0bWFwICpoYiwgdWludDY0X3Qgc2l6
ZSkNCj4gICANCj4gICBib29sIGhiaXRtYXBfY2FuX21lcmdlKGNvbnN0IEhCaXRtYXAgKmEsIGNv
bnN0IEhCaXRtYXAgKmIpDQo+ICAgew0KPiAtICAgIHJldHVybiAoYS0+c2l6ZSA9PSBiLT5zaXpl
KSAmJiAoYS0+Z3JhbnVsYXJpdHkgPT0gYi0+Z3JhbnVsYXJpdHkpOw0KPiArICAgIHJldHVybiAo
YS0+c2l6ZSA9PSBiLT5zaXplKTsNCj4gK30NCj4gKw0KPiArc3RhdGljIHZvaWQgaGJpdG1hcF9z
cGFyc2VfbWVyZ2UoSEJpdG1hcCAqZHN0LCBjb25zdCBIQml0bWFwICpzcmMpDQo+ICt7DQo+ICsg
ICAgdWludDY0X3Qgb2Zmc2V0ID0gMDsNCj4gKyAgICB1aW50NjRfdCBjb3VudCA9IHNyYy0+b3Jp
Z19zaXplOw0KPiArDQo+ICsgICAgd2hpbGUgKGhiaXRtYXBfbmV4dF9kaXJ0eV9hcmVhKHNyYywg
Jm9mZnNldCwgJmNvdW50KSkgew0KPiArICAgICAgICBoYml0bWFwX3NldChkc3QsIG9mZnNldCwg
Y291bnQpOw0KDQpUaGlzIHdpbGwgbm90IHdvcmssIGFzIGhiaXRtYXBfbmV4dF9kaXJ0eV9hcmVh
IHdpbGwgcmV0dXJuIHRoZSBzYW1lIGFuc3dlciBhbGwgdGhlIHRpbWUgSSB0aGluay4NCllvdSBu
ZWVkIHRvIHVwZGF0ZSBvZmZzZXQgYW5kIGNvdW50IGluIGEgbG9vcCwgbGlrZSBpdCBpcyBkb25l
IGluIGJhY2t1cF9pbmNyZW1lbnRhbF9pbml0X2NvcHlfYml0bWFwLg0KDQoNCj4gKyAgICB9DQo+
ICAgfQ0KPiAgIA0KPiAgIC8qKg0KPiBAQCAtODA0LDYgKzgxNCwxNiBAQCBib29sIGhiaXRtYXBf
bWVyZ2UoY29uc3QgSEJpdG1hcCAqYSwgY29uc3QgSEJpdG1hcCAqYiwgSEJpdG1hcCAqcmVzdWx0
KQ0KPiAgICAgICAgICAgcmV0dXJuIHRydWU7DQo+ICAgICAgIH0NCj4gICANCj4gKyAgICBpZiAo
YS0+c2l6ZSAhPSBiLT5zaXplKSB7DQo+ICsgICAgICAgIGlmIChhICE9IHJlc3VsdCkgew0KPiAr
ICAgICAgICAgICAgaGJpdG1hcF9zcGFyc2VfbWVyZ2UocmVzdWx0LCBhKTsNCj4gKyAgICAgICAg
fQ0KPiArICAgICAgICBpZiAoYiAhPSByZXN1bHQpIHsNCj4gKyAgICAgICAgICAgIGhiaXRtYXBf
c3BhcnNlX21lcmdlKHJlc3VsdCwgYik7DQo+ICsgICAgICAgIH0NCj4gKyAgICAgICAgcmV0dXJu
IHRydWU7DQo+ICsgICAgfQ0KPiArDQo+ICAgICAgIC8qIFRoaXMgbWVyZ2UgaXMgTyhzaXplKSwg
YXMgQklUU19QRVJfTE9ORyBhbmQgSEJJVE1BUF9MRVZFTFMgYXJlIGNvbnN0YW50Lg0KPiAgICAg
ICAgKiBJdCBtYXkgYmUgcG9zc2libGUgdG8gaW1wcm92ZSBydW5uaW5nIHRpbWVzIGZvciBzcGFy
c2VseSBwb3B1bGF0ZWQgbWFwcw0KPiAgICAgICAgKiBieSB1c2luZyBoYml0bWFwX2l0ZXJfbmV4
dCwgYnV0IHRoaXMgaXMgc3Vib3B0aW1hbCBmb3IgZGVuc2UgbWFwcy4NCj4gDQoNCg0KLS0gDQpC
ZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

