Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4609C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 15:51:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F4662168B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 15:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YLmWTVCu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F4662168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52906 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hboUa-0002Sq-DJ
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 11:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57646)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hboKO-0005eP-HX
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hboKM-000275-Ib
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:41:20 -0400
Received: from mail-am5eur02on0728.outbound.protection.outlook.com
 ([2a01:111:f400:fe07::728]:24331
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hboKD-0001yL-Hr; Fri, 14 Jun 2019 11:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvyrbLTzP/BpMItnm3+fc5GHCpLqSCPiRQ5A2ZohjZA=;
 b=YLmWTVCuLJT6apbcUgOZ4HtcKnYKKYP/5qMI7lXTGiECnBuGnon0tBuuWE76tQ1S4CHL0U9BLnKRJVqvnlfg1F6xz26ByWFA5hGEwVrn4bsLhDGiTdhlDGHWhSFnVE1lj0J75B62eA6cx5P8TcTypd8F3MfestVLHqhKa6ssb1g=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB4498.eurprd08.prod.outlook.com (20.179.33.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Fri, 14 Jun 2019 15:41:00 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Fri, 14 Jun 2019
 15:41:00 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 22/42] block: Use CAFs in
 bdrv_get_allocated_file_size()
Thread-Index: AQHVIWu7YTAzme1CY0G2fmSS+RVg2KabTEaA
Date: Fri, 14 Jun 2019 15:41:00 +0000
Message-ID: <e748a63f-2ee7-1c43-df21-573d038444b8@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-23-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-23-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0001.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::11) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190614184057819
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d7b3ef0-a03c-4ca5-0f42-08d6f0deb310
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB4498; 
x-ms-traffictypediagnostic: AM0PR08MB4498:
x-microsoft-antispam-prvs: <AM0PR08MB4498548D1F7E18F67EBAA7E9C1EE0@AM0PR08MB4498.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:843;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(136003)(346002)(366004)(396003)(39850400004)(189003)(199004)(476003)(76176011)(2616005)(11346002)(36756003)(81156014)(478600001)(6116002)(6506007)(66476007)(8936002)(386003)(73956011)(66946007)(31686004)(486006)(52116002)(305945005)(3846002)(7736002)(66556008)(2501003)(66446008)(64756008)(229853002)(446003)(99286004)(71200400001)(71190400001)(8676002)(53936002)(6246003)(6436002)(316002)(68736007)(110136005)(6486002)(5660300002)(14444005)(66066001)(14454004)(86362001)(4326008)(256004)(186003)(54906003)(81166006)(25786009)(31696002)(26005)(6512007)(102836004)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4498;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QumjpD3zzYA24ImPgbsW8igFgp5kMyoqGME4zwUEZmSA3jlJYRIZ8o0DXSJ+ZNXNOYz5FwUA8BTmLsn7VZHSF+VV34PdfkeiuWB9pcZPYR7fclOnjhScpcByzPyub76DUOrKDXcD/lqLFVt7A5JjRj90j36ZQUS3ilGWbLRSgmP4ettIAi8Y4uivKGNGmQEeGqlpBlo3Wkhh6fxpTqCb1/j8Ji3TenUdsqGkdh2KX6UJzVZAXpRctDgp7/nR7z8Ydv4nFaAyJJudYuqY3/2NPRk9EwvPOuhbggUqOPzrkUBQ5DKHywoFxH8SehufM4QerJJ4G3pIV2+rNyjtcFhMep92HhhYdmRlLS4Aks/N2/Qd0cl/la1EIThyfvDxku8uTzLtSEysOeDbbvR5goTG336+Y3qousHjZtIKAfz2ju0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A17DC3774A3134C95A6F3A732184E8E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7b3ef0-a03c-4ca5-0f42-08d6f0deb310
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 15:41:00.4479 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4498
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe07::728
Subject: Re: [Qemu-devel] [PATCH v5 22/42] block: Use CAFs in
 bdrv_get_allocated_file_size()
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

MTMuMDYuMjAxOSAxOjA5LCBNYXggUmVpdHogd3JvdGU6DQo+IFNpZ25lZC1vZmYtYnk6IE1heCBS
ZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgIGJsb2NrLmMgfCAyNiArKysrKysr
KysrKysrKysrKysrKysrKystLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Jsb2NrLmMgYi9ibG9jay5jDQo+
IGluZGV4IDExYjdiYThjZjYuLjg1NmQ5YjU4YmUgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrLmMNCj4g
KysrIGIvYmxvY2suYw0KPiBAQCAtNDUxMSwxNSArNDUxMSwzNyBAQCBleGl0Og0KPiAgIGludDY0
X3QgYmRydl9nZXRfYWxsb2NhdGVkX2ZpbGVfc2l6ZShCbG9ja0RyaXZlclN0YXRlICpicykNCj4g
ICB7DQo+ICAgICAgIEJsb2NrRHJpdmVyICpkcnYgPSBicy0+ZHJ2Ow0KPiArICAgIEJsb2NrRHJp
dmVyU3RhdGUgKnN0b3JhZ2VfYnMsICptZXRhZGF0YV9iczsNCj4gKw0KPiAgICAgICBpZiAoIWRy
dikgew0KPiAgICAgICAgICAgcmV0dXJuIC1FTk9NRURJVU07DQo+ICAgICAgIH0NCj4gKw0KPiAg
ICAgICBpZiAoZHJ2LT5iZHJ2X2dldF9hbGxvY2F0ZWRfZmlsZV9zaXplKSB7DQo+ICAgICAgICAg
ICByZXR1cm4gZHJ2LT5iZHJ2X2dldF9hbGxvY2F0ZWRfZmlsZV9zaXplKGJzKTsNCj4gICAgICAg
fQ0KPiAtICAgIGlmIChicy0+ZmlsZSkgew0KPiAtICAgICAgICByZXR1cm4gYmRydl9nZXRfYWxs
b2NhdGVkX2ZpbGVfc2l6ZShicy0+ZmlsZS0+YnMpOw0KPiArDQo+ICsgICAgc3RvcmFnZV9icyA9
IGJkcnZfc3RvcmFnZV9icyhicyk7DQo+ICsgICAgbWV0YWRhdGFfYnMgPSBiZHJ2X21ldGFkYXRh
X2JzKGJzKTsNCj4gKw0KPiArICAgIGlmIChzdG9yYWdlX2JzKSB7DQo+ICsgICAgICAgIGludDY0
X3QgZGF0YV9zaXplLCBtZXRhZGF0YV9zaXplID0gMDsNCj4gKw0KPiArICAgICAgICBkYXRhX3Np
emUgPSBiZHJ2X2dldF9hbGxvY2F0ZWRfZmlsZV9zaXplKHN0b3JhZ2VfYnMpOw0KPiArICAgICAg
ICBpZiAoZGF0YV9zaXplIDwgMCkgew0KPiArICAgICAgICAgICAgcmV0dXJuIGRhdGFfc2l6ZTsN
Cj4gKyAgICAgICAgfQ0KPiArDQo+ICsgICAgICAgIGlmIChzdG9yYWdlX2JzICE9IG1ldGFkYXRh
X2JzKSB7DQo+ICsgICAgICAgICAgICBtZXRhZGF0YV9zaXplID0gYmRydl9nZXRfYWxsb2NhdGVk
X2ZpbGVfc2l6ZShtZXRhZGF0YV9icyk7DQo+ICsgICAgICAgICAgICBpZiAobWV0YWRhdGFfc2l6
ZSA8IDApIHsNCj4gKyAgICAgICAgICAgICAgICByZXR1cm4gbWV0YWRhdGFfc2l6ZTsNCj4gKyAg
ICAgICAgICAgIH0NCj4gKyAgICAgICAgfQ0KPiArDQo+ICsgICAgICAgIHJldHVybiBkYXRhX3Np
emUgKyBtZXRhZGF0YV9zaXplOw0KPiAgICAgICB9DQo+ICsNCj4gICAgICAgcmV0dXJuIC1FTk9U
U1VQOw0KPiAgIH0NCj4gICANCj4gDQoNCkFnYWluLCBJIGRpc2xpa2UgbmFpbGluZyBkb3duIG5l
dyBmcmVzaCBmZWF0dXJlIGFib3V0IHNlcGFyYXRlIG1ldGFkYXRhIGFuZCBzdG9yYWdlIGNoaWxk
DQp0byB0aGUgZ2VuZXJpYyBibG9jayBsYXllciwgYXMgaXQncyBzaW1wbGUgdG8gaW1hZ2luZSBh
IGRyaXZlciB3aGljaCBuZWVkcyB0aHJlZSBvciBtb3JlDQpjaGlsZHJlbiB0byBzdG9yZSBhbGwg
aXRzIGRhdGEgYW5kIG1ldGFkYXRhLi4NCg0KSXNuJ3QgaXQgYmV0dGVyIGJ5IGRlZmF1bHQgbG9v
cCB0aHJvdWdoIGFsbCBjaGlsZHJlbiBhbmQgc3VtIGFsbCB0aGVpciBhbGxvY2F0ZWQgc2l6ZXM/
DQoNCkhtbSwgYnV0IHdlIHdhbnQgZXhjbHVkZSBiYWNraW5nLCB5ZXM/IFN0aWxsIHdlIG1heSBp
Z25vcmUgaXQgd2hpbGUgaXRlcmF0aW5nLg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWly
DQo=

