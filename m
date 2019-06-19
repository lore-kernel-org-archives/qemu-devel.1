Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7162DC31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 09:21:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FABB20B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 09:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="D8IDM2hy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FABB20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36047 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdWm4-0004jp-AT
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 05:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33767)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hdWk0-0003YL-QQ
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hdWjy-0005yP-UM
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:18:52 -0400
Received: from mail-eopbgr70090.outbound.protection.outlook.com
 ([40.107.7.90]:28869 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hdWjw-0005tI-4V; Wed, 19 Jun 2019 05:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmREFwsg/1BweN6tXL0zs7GAb+Q2a0cYY3m5XynxxiY=;
 b=D8IDM2hyoqv0ei7yoWIt6ZqlaAe7whaqAcyRjsO9zbYnZSs7vfIecmtOGtnFxRx1qH22od3yXJDbQDpFqRveJt3UPIeBdfDH+Emk92/thMQX14JlrX9cxoIMBvVSX95WNTV1I0p0nDykOmvK+NYAlxCAoN3aSzZ4W6Q3HcIeCOg=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB4886.eurprd08.prod.outlook.com (20.179.47.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Wed, 19 Jun 2019 09:18:43 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Wed, 19 Jun 2019
 09:18:43 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 31/42] block: Drop backing_bs()
Thread-Index: AQHVIWvKp4MTEifYA02GA4VGaQjj3aaivSCA
Date: Wed, 19 Jun 2019 09:18:43 +0000
Message-ID: <63ccec3a-861e-9a48-4964-f0e889fe9b4e@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-32-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-32-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0196.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::20) To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190619121841406
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3725337-3a75-4618-f06c-08d6f4971ff5
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DBBPR08MB4886; 
x-ms-traffictypediagnostic: DBBPR08MB4886:
x-microsoft-antispam-prvs: <DBBPR08MB48865BF6A1BE7BABFD9D5513C1E50@DBBPR08MB4886.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:989;
x-forefront-prvs: 0073BFEF03
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(366004)(346002)(39850400004)(136003)(199004)(189003)(229853002)(2906002)(110136005)(316002)(71190400001)(53936002)(68736007)(26005)(186003)(76176011)(81166006)(71200400001)(54906003)(52116002)(5660300002)(102836004)(66556008)(66446008)(386003)(6436002)(31686004)(256004)(64756008)(66476007)(66946007)(31696002)(36756003)(73956011)(6512007)(478600001)(4744005)(446003)(4326008)(11346002)(14454004)(81156014)(8676002)(6486002)(8936002)(6506007)(86362001)(6246003)(6116002)(3846002)(476003)(305945005)(486006)(7736002)(2616005)(99286004)(25786009)(2501003)(66066001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4886;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LDspw0RKoLoUzB6GVlPvymJEquXFTRuMin1AuwkAOF6Ht/X65Z3YWAmyh0I+sKGiOtQAMFli5GHpZabvvGsatV5OrpsFpKMQH/XKjydZ3Q3mtcyaPlO0hBfSjV9uI+rWLdaioTFEBB+HS/77MqHb2x8pAdDPEj1gFzwVAw9k3+YH8VW0cxdPZOCIA9TPah3CLc1upz+ndKR456aTSc3vZ6r8TLKWOj0L2cMe89oUkKcixlEcihKZp+lwJzsAr0OsYmJlntzjSpGaBEcHlmIc461In99vqphmJE+Al99fgdoaLhUznZw8lJAN6CWCpPnBPYSoAP6Db9ob0skDhXSsAZNEzZVUVS2UlW7Sbic1/ZzIEqzxVXMRF0uR7W+/Ei5HGCcVhUvr9gp+RsDwUQcHdhbieNsvtZXFPB7/PNzkDSo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E855355972587C43900B8C71DA5D5766@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3725337-3a75-4618-f06c-08d6f4971ff5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2019 09:18:43.6562 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4886
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.90
Subject: Re: [Qemu-devel] [PATCH v5 31/42] block: Drop backing_bs()
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

MTMuMDYuMjAxOSAxOjA5LCBNYXggUmVpdHogd3JvdGU6DQo+IFdlIHdhbnQgdG8gbWFrZSBpdCBl
eHBsaWNpdCB3aGVyZSBicy0+YmFja2luZyBpcyB1c2VkLCBhbmQgd2UgaGF2ZSBkb25lDQo+IHNv
LiAgVGhlIG9sZCByb2xlIG9mIGJhY2tpbmdfYnMoKSBpcyBub3cgZWZmZWN0aXZlbHkgdGFrZW4g
YnkNCj4gYmRydl9maWx0ZXJlZF9jb3dfYnMoKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1heCBS
ZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+DQoNCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVu
dHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KDQo+IC0tLQ0KPiAg
IGluY2x1ZGUvYmxvY2svYmxvY2tfaW50LmggfCA1IC0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ibG9jay9ibG9ja19p
bnQuaCBiL2luY2x1ZGUvYmxvY2svYmxvY2tfaW50LmgNCj4gaW5kZXggODc1YTMzZjI1NS4uYzBh
MDViZWVjMyAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9ibG9jay9ibG9ja19pbnQuaA0KPiArKysg
Yi9pbmNsdWRlL2Jsb2NrL2Jsb2NrX2ludC5oDQo+IEBAIC05MjUsMTEgKzkyNSw2IEBAIHR5cGVk
ZWYgZW51bSBCbG9ja01pcnJvckJhY2tpbmdNb2RlIHsNCj4gICAgICAgTUlSUk9SX0xFQVZFX0JB
Q0tJTkdfQ0hBSU4sDQo+ICAgfSBCbG9ja01pcnJvckJhY2tpbmdNb2RlOw0KPiAgIA0KPiAtc3Rh
dGljIGlubGluZSBCbG9ja0RyaXZlclN0YXRlICpiYWNraW5nX2JzKEJsb2NrRHJpdmVyU3RhdGUg
KmJzKQ0KPiAtew0KPiAtICAgIHJldHVybiBicy0+YmFja2luZyA/IGJzLT5iYWNraW5nLT5icyA6
IE5VTEw7DQo+IC19DQo+IC0NCj4gICANCj4gICAvKiBFc3NlbnRpYWwgYmxvY2sgZHJpdmVycyB3
aGljaCBtdXN0IGFsd2F5cyBiZSBzdGF0aWNhbGx5IGxpbmtlZCBpbnRvIHFlbXUsIGFuZA0KPiAg
ICAqIHdoaWNoIHRoZXJlZm9yZSBjYW4gYmUgYWNjZXNzZWQgd2l0aG91dCB1c2luZyBiZHJ2X2Zp
bmRfZm9ybWF0KCkgKi8NCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

