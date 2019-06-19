Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEECC31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 09:22:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD84720B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 09:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MgljgcMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD84720B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36056 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdWn4-0005sI-4g
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 05:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34063)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hdWlE-0004Mo-K0
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:20:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hdWlD-0007QH-Et
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:20:08 -0400
Received: from mail-eopbgr70115.outbound.protection.outlook.com
 ([40.107.7.115]:1501 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hdWlB-0007Jk-Qb; Wed, 19 Jun 2019 05:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o21c8MFkc6qBOR5lK7ddoacIXgGkKW4JpvFTaKMdeI8=;
 b=MgljgcMKt7xd6kuKr/apoMTQ9IByUzxHY5tDeNeRlWU4HnSf/5M63vUasOCICs8egVmo7M/JmMP290bQOgqsBYB0a2sZ8ctpO5MIcnf47vDFhuMcr+c4+OpWIFqaZf6Bq8Ug98Ppdiu/Isow9yEfcwP9bkmwgOYZavgdrVCEcI0=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB5222.eurprd08.prod.outlook.com (20.179.47.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Wed, 19 Jun 2019 09:19:50 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Wed, 19 Jun 2019
 09:19:50 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 32/42] block: Make bdrv_get_cumulative_perm() public
Thread-Index: AQHVIWvK+aQcQ3wXCEOK/wB+7KpP0aaivXAA
Date: Wed, 19 Jun 2019 09:19:50 +0000
Message-ID: <65b5612d-9453-dfbc-dd61-8c218f00fe47@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-33-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-33-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0049.eurprd09.prod.outlook.com
 (2603:10a6:7:15::38) To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190619121948417
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81a117ef-fac2-469d-978f-08d6f49747e4
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB5222; 
x-ms-traffictypediagnostic: DBBPR08MB5222:
x-microsoft-antispam-prvs: <DBBPR08MB5222C62909D2ADE33D0E747DC1E50@DBBPR08MB5222.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 0073BFEF03
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(366004)(39850400004)(396003)(376002)(199004)(189003)(2616005)(31686004)(476003)(229853002)(14454004)(8676002)(7736002)(478600001)(6506007)(81166006)(11346002)(446003)(186003)(66556008)(2501003)(99286004)(81156014)(386003)(31696002)(54906003)(6436002)(2906002)(305945005)(110136005)(316002)(66476007)(66946007)(36756003)(71200400001)(14444005)(6116002)(73956011)(86362001)(6486002)(6512007)(3846002)(66066001)(53936002)(71190400001)(486006)(6246003)(66446008)(102836004)(5660300002)(64756008)(68736007)(76176011)(8936002)(25786009)(256004)(52116002)(26005)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB5222;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iwFv2Kp3ioYyKtqk7HRmx07+Z+nO/KOUr3KrbZ6PVO2Nw3qbAKl7uDhWWyYA0dU43wNNxFQu1fLNXwHlCikNXUwLZ4O/CjMRbo++duvzcNpKNgUE592MaAu8SqaYPOdtoH9WkVLQU+8Nxw724waenJ4LQ8P4o0vX9Qx4M7rrJVr4o8UUz1cK7sicQkgGj7fH9lla6jTir822+ZKV/6RqSQKbNkA8JDYPJNXqTzXtJgYMwCSfKaYyZ0jMG1oSuSYn+Ni/voQ0Qgz6HT3x2C9uYyhb+Z9a/DLdpLyYw60nb4+yNa2zQTRaSkr9z64G44GayTNcDJLJ9w8Vh1SMWl87TuDqK7qab0Y0Le7n2v0SelLPpVP435YscngWRGiQgR6NRhBTX3dXzRnXpLrHDJ8o5W8eUdXQJDjFAACzdwDq+Vw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <962A263E4135D742AB648DB4DAD0DBC4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a117ef-fac2-469d-978f-08d6f49747e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2019 09:19:50.4465 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5222
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.115
Subject: Re: [Qemu-devel] [PATCH v5 32/42] block: Make
 bdrv_get_cumulative_perm() public
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

MTMuMDYuMjAxOSAxOjA5LCBNYXggUmVpdHogd3JvdGU6DQo+IFRoaXMgaXMgdXNlZnVsIGluIG90
aGVyIGZpbGVzIGxpa2UgYmxvY2tkZXYuYyB0byBkZXRlcm1pbmUgZm9yIGV4YW1wbGUNCj4gd2hl
dGhlciBhIG5vZGUgY2FuIGJlIHdyaXR0ZW4gdG8gb3Igbm90Lg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogTWF4IFJlaXR6IDxtcmVpdHpAcmVkaGF0LmNvbT4NCg0KDQpSZXZpZXdlZC1ieTogVmxhZGlt
aXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQoNCj4g
LS0tDQo+ICAgaW5jbHVkZS9ibG9jay9ibG9ja19pbnQuaCB8IDMgKysrDQo+ICAgYmxvY2suYyAg
ICAgICAgICAgICAgICAgICB8IDYgKystLS0tDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ibG9j
ay9ibG9ja19pbnQuaCBiL2luY2x1ZGUvYmxvY2svYmxvY2tfaW50LmgNCj4gaW5kZXggYzBhMDVi
ZWVjMy4uY2ZlZmIwMDEwNCAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9ibG9jay9ibG9ja19pbnQu
aA0KPiArKysgYi9pbmNsdWRlL2Jsb2NrL2Jsb2NrX2ludC5oDQo+IEBAIC0xMTgxLDYgKzExODEs
OSBAQCB2b2lkIGJkcnZfcm9vdF91bnJlZl9jaGlsZChCZHJ2Q2hpbGQgKmNoaWxkKTsNCj4gICBp
bnQgYmRydl9jaGlsZF90cnlfc2V0X3Blcm0oQmRydkNoaWxkICpjLCB1aW50NjRfdCBwZXJtLCB1
aW50NjRfdCBzaGFyZWQsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoq
ZXJycCk7DQo+ICAgDQo+ICt2b2lkIGJkcnZfZ2V0X2N1bXVsYXRpdmVfcGVybShCbG9ja0RyaXZl
clN0YXRlICpicywNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90ICpw
ZXJtLCB1aW50NjRfdCAqc2hhcmVkX3Blcm0pOw0KPiArDQo+ICAgLyogRGVmYXVsdCBpbXBsZW1l
bnRhdGlvbiBmb3IgQmxvY2tEcml2ZXIuYmRydl9jaGlsZF9wZXJtKCkgdGhhdCBjYW4gYmUgdXNl
ZCBieQ0KPiAgICAqIGJsb2NrIGZpbHRlcnM6IEZvcndhcmQgQ09OU0lTVEVOVF9SRUFELCBXUklU
RSwgV1JJVEVfVU5DSEFOR0VEIGFuZCBSRVNJWkUgdG8NCj4gICAgKiBhbGwgY2hpbGRyZW4gKi8N
Cj4gZGlmZiAtLWdpdCBhL2Jsb2NrLmMgYi9ibG9jay5jDQo+IGluZGV4IDg1NmQ5YjU4YmUuLjU5
ZDFkNGIyYjEgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrLmMNCj4gKysrIGIvYmxvY2suYw0KPiBAQCAt
MTcxMSw4ICsxNzExLDYgQEAgc3RhdGljIGludCBiZHJ2X2NoaWxkX2NoZWNrX3Blcm0oQmRydkNo
aWxkICpjLCBCbG9ja1Jlb3BlblF1ZXVlICpxLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIEdTTGlzdCAqaWdub3JlX2NoaWxkcmVuLCBFcnJvciAqKmVycnApOw0KPiAgIHN0
YXRpYyB2b2lkIGJkcnZfY2hpbGRfYWJvcnRfcGVybV91cGRhdGUoQmRydkNoaWxkICpjKTsNCj4g
ICBzdGF0aWMgdm9pZCBiZHJ2X2NoaWxkX3NldF9wZXJtKEJkcnZDaGlsZCAqYywgdWludDY0X3Qg
cGVybSwgdWludDY0X3Qgc2hhcmVkKTsNCj4gLXN0YXRpYyB2b2lkIGJkcnZfZ2V0X2N1bXVsYXRp
dmVfcGVybShCbG9ja0RyaXZlclN0YXRlICpicywgdWludDY0X3QgKnBlcm0sDQo+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3QgKnNoYXJlZF9wZXJtKTsNCj4g
ICANCj4gICB0eXBlZGVmIHN0cnVjdCBCbG9ja1Jlb3BlblF1ZXVlRW50cnkgew0KPiAgICAgICAg
Ym9vbCBwcmVwYXJlZDsNCj4gQEAgLTE5MDQsOCArMTkwMiw4IEBAIHN0YXRpYyB2b2lkIGJkcnZf
c2V0X3Blcm0oQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIHVpbnQ2NF90IGN1bXVsYXRpdmVfcGVybXMs
DQo+ICAgICAgIH0NCj4gICB9DQo+ICAgDQo+IC1zdGF0aWMgdm9pZCBiZHJ2X2dldF9jdW11bGF0
aXZlX3Blcm0oQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIHVpbnQ2NF90ICpwZXJtLA0KPiAtICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90ICpzaGFyZWRfcGVybSkNCj4g
K3ZvaWQgYmRydl9nZXRfY3VtdWxhdGl2ZV9wZXJtKEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3QgKnBlcm0sIHVpbnQ2NF90ICpz
aGFyZWRfcGVybSkNCj4gICB7DQo+ICAgICAgIEJkcnZDaGlsZCAqYzsNCj4gICAgICAgdWludDY0
X3QgY3VtdWxhdGl2ZV9wZXJtcyA9IDA7DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxh
ZGltaXINCg==

