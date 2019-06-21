Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D903C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 12:04:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE5BF208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 12:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TijSQSd1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE5BF208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60194 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heIHD-0004Ec-59
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 08:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52974)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1heHzU-0005vp-Qv
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:46:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1heHzM-0004ut-Bf
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:45:56 -0400
Received: from mail-eopbgr30111.outbound.protection.outlook.com
 ([40.107.3.111]:59566 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1heHzD-0004rI-1i; Fri, 21 Jun 2019 07:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvOJ9hZBM8h04aYkr0Jk9fG2dl1iNBIrfAsJIJPMzmw=;
 b=TijSQSd1KOxJ11CuHe2pZLIjV315Netbqd5qdrUO4hOa0P7JrHjOULJEDZbpwSm5i1cYee2RzdDTMgDt/BrubKzveiEevrN7xQVK83J1suk6fXD70bOJfenps9yAnCW6Nytlep9oApRfdr3A+dD2a88o3Jsvz6xMwn3PwMj53ak=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB4664.eurprd08.prod.outlook.com (10.255.78.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Fri, 21 Jun 2019 11:45:39 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 11:45:39 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH 05/12] hbitmap: enable merging across granularities
Thread-Index: AQHVJwQT19qzFPzhvEyXs1QUU1uOMqakwc2AgAE92QA=
Date: Fri, 21 Jun 2019 11:45:39 +0000
Message-ID: <c949a010-29b9-b314-d21d-9a4e56014f37@virtuozzo.com>
References: <20190620010356.19164-1-jsnow@redhat.com>
 <20190620010356.19164-6-jsnow@redhat.com>
 <eec0e84e-9ec3-9e8d-ff55-6a67fddf42fa@redhat.com>
In-Reply-To: <eec0e84e-9ec3-9e8d-ff55-6a67fddf42fa@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0073.eurprd07.prod.outlook.com
 (2603:10a6:3:64::17) To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190621144536830
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7de5b62b-1cd8-443f-4bef-08d6f63dfbad
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4664; 
x-ms-traffictypediagnostic: DBBPR08MB4664:
x-microsoft-antispam-prvs: <DBBPR08MB46644C9519A8142B708115ECC1E70@DBBPR08MB4664.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(396003)(39840400004)(376002)(346002)(199004)(189003)(486006)(7416002)(53546011)(54906003)(110136005)(14444005)(71190400001)(71200400001)(386003)(25786009)(256004)(3846002)(6116002)(6506007)(186003)(476003)(4744005)(446003)(76176011)(2501003)(2616005)(31696002)(11346002)(86362001)(26005)(316002)(478600001)(102836004)(8936002)(2201001)(66066001)(52116002)(6486002)(99286004)(8676002)(229853002)(73956011)(6436002)(66476007)(66556008)(66446008)(64756008)(14454004)(2906002)(36756003)(68736007)(6246003)(81156014)(81166006)(305945005)(7736002)(31686004)(5660300002)(4326008)(6512007)(66946007)(53936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4664;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dzbYzfk4ECxSXQmI3305UGCOQag5GuJxJ+/+k9W/xlu/tZmo66Sc0VnDvX1fbhl+kfCd+wTI3Z3dNdRFzO7QjN1pwnFJxnVixPZj2ncRGUOdgU4PIgh+n+0e/srEuzptSPFpHABoaM2OhOoK67+/QvV10o/Ioi4ZVL9NpIWKPamC/G+mrrwwEOtlvPX4T+CQiai8xOtsfz1BtF9sQiuzgpxmdz4zD1jXVyC+wASW/egW1UwVkERJgY0kVoF08k8phmXH5ylud9ZFXg5SwLPNkdLeySCbgKmdXoKabtAG+UVcu+7U8JjaDXXyW8f4F/2Y+d8jNG1FM5ze2xQWaZkjElpRHKzNz1bs5354fwdbz7ma0TeHkroRBEDo0QzL+pJ9fBROTnMI2ofwhQwKP6CWeV6+kqD9cB2CnlGcT9ddRtk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <228FEC5E914029429ECABFF7362D3D94@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de5b62b-1cd8-443f-4bef-08d6f63dfbad
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 11:45:39.8108 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4664
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.111
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
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjAuMDYuMjAxOSAxOTo0NywgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyMC4wNi4xOSAwMzowMywg
Sm9obiBTbm93IHdyb3RlOg0KPj4gU2lnbmVkLW9mZi1ieTogSm9obiBTbm93IDxqc25vd0ByZWRo
YXQuY29tPg0KPj4gLS0tDQo+PiAgIHV0aWwvaGJpdG1hcC5jIHwgMjIgKysrKysrKysrKysrKysr
KysrKysrLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPiANCj4gSSB3b25kZXIgd2hldGhlciB0aGlzIGNvdWxkIGJlIHVzZWQgaW4NCj4gYmFj
a3VwX2luY3JlbWVudGFsX2luaXRfY29weV9iaXRtYXAoKS4gIFRoZSBzeW5jX2JpdG1hcCBtdXN0
IGhhdmUgdGhlDQo+IHNhbWUgbGVuZ3RoIGFzIHRoZSBzb3VyY2UgQkRTLCByaWdodD8NCj4gDQoN
CkEgbGl0dGxlIHByb2JsZW0gaGVyZSBpcyB0aGF0IGluIGJhY2t1cCBjb2RlIHdlIG1lcmdlIEJk
cnZEaXJ0eUJpdG1hcCBpbnRvDQpIQml0bWFwLCBzbyBoYml0bWFwIEFQSSBjYW4ndCBiZSBkaXJl
Y3RseSB1c2VkIGhlcmUsIGFuZCB0byBhdm9pZCBjb2RlDQpkdXBsaWNhdGlvbiB3ZSBuZWVkIHRv
IGNyZWF0ZSBhIGJpdCBzdHJhbmdlIGludGVyZmFjZSBvZiBtZXJnaW5nIGV4YWN0bHkNCkJkcnZE
aXJ0eUJpdG1hcCBpbnRvIEhCaXRtYXAuLiBCdXQsIGFueXdheSBpdCdzIGJldHRlciB0aGFuIGNv
ZGUgZHVwbGljYXRpb24uDQoNClllcywgdGhleSBzaG91bGQgaGF2ZSB0aGUgc2FtZSBsZW5ndGgu
DQoNCkJ1dCB3ZSBtYXkgYWxsb3cgYXQgbGVhc3QgbWVyZ2luZyBzbWFsbGVyIGJpdG1hcCBpbnRv
IGxhcmdlciwgd2h5IG5vdD8NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

