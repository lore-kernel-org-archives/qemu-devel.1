Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B02CC31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 15:15:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47311213F2
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 15:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="U9edOj7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47311213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58884 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdFpl-00075P-F2
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 11:15:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37587)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hdFA2-0005bm-3H
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 10:32:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hdFA0-0001aR-D7
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 10:32:33 -0400
Received: from mail-ve1eur01on0709.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::709]:12099
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hdF9t-0001Og-UD; Tue, 18 Jun 2019 10:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcsJhmQEejvDrKxv8fc4ktg+UXzzcVMc0obVCEULDHs=;
 b=U9edOj7wvqCOkYqzYylqldwdH3HuLK01xrlxPT/g6ZXGrv/+90ucp/7iABKH5C29OseY1sN/JfKHSkiRRU8yQehTjNa9Mh+BM2nh14lPv7TGUkjwd22xblllQm52LCPPUisq7L8TiEoJC28kW9XYRGjFqiv8npjGGR/7itJiabQ=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB4377.eurprd08.prod.outlook.com (20.179.42.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Tue, 18 Jun 2019 14:32:21 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 14:32:21 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH] blockdev: enable non-root nodes for transaction
 drive-backup source
Thread-Index: AQHVJd9E9eBQj0Xt/0uDeVodskEogaahdziAgAACTAA=
Date: Tue, 18 Jun 2019 14:32:21 +0000
Message-ID: <da012073-ae26-3764-869d-94ce132fd86a@virtuozzo.com>
References: <20190618140804.59214-1-vsementsov@virtuozzo.com>
 <a4aef1ae-d53e-7bfd-efc1-4a1ce9a40254@redhat.com>
In-Reply-To: <a4aef1ae-d53e-7bfd-efc1-4a1ce9a40254@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0379.eurprd05.prod.outlook.com
 (2603:10a6:7:94::38) To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190618173218366
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff2ce6ae-fe88-429e-cb42-08d6f3f9c5a9
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4377; 
x-ms-traffictypediagnostic: DBBPR08MB4377:
x-microsoft-antispam-prvs: <DBBPR08MB4377058E290ED2E2573F41EAC1EA0@DBBPR08MB4377.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:506;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(136003)(366004)(39850400004)(396003)(189003)(199004)(446003)(8936002)(6246003)(5660300002)(478600001)(31686004)(76176011)(305945005)(6512007)(52116002)(25786009)(102836004)(3846002)(6116002)(68736007)(186003)(71190400001)(36756003)(53546011)(6506007)(6436002)(81166006)(71200400001)(386003)(7736002)(26005)(53936002)(6486002)(14454004)(2501003)(256004)(2906002)(14444005)(86362001)(476003)(11346002)(486006)(54906003)(2201001)(2616005)(229853002)(66066001)(316002)(110136005)(66446008)(4326008)(31696002)(66556008)(99286004)(66476007)(8676002)(64756008)(81156014)(73956011)(66946007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4377;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3DWBsgrGCITf+U2OPeXyvMGP3AtBqKk4jbGMxj+zT3J+iMJ0dupX6nEMBvExIzdyGCIDhPN7BdXKyUAA+7Vkw+YuiJoS/q/VWp9udB+Llfnj8l06BvdxkpJp/cSjVx7L4XHFNM+Z6UHj0Lt3EJ2jupI60l3vkufsv2J9YvokB5CwvNJBsXVwJ12BaraOGEmceum46hj8y2dFlvxEJFCs0w2N/lKRihGwN5Brq9LF5/DtydqBXbuUav+fQzihLKKGhBE/XouzN6QagZ1ewbw0pUU1CbMKl3Bb4UbmH1qyOFLyyAzLORtUB3KmfksXsJN8uNjaGe/MBb91kNEY6J1LIr6Gn1Qkw4CN6KIZzXZSVxJPFuVPO+MGe+xn6Q7/LfboMY5X+N5BxjSXXIieZ4VN8digIVEDqT2HyLq1KiakUJM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D773CBBA760A1E478B98C80A99592958@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2ce6ae-fe88-429e-cb42-08d6f3f9c5a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 14:32:21.2396 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4377
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe1f::709
Subject: Re: [Qemu-devel] [PATCH] blockdev: enable non-root nodes for
 transaction drive-backup source
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTguMDYuMjAxOSAxNzoyNCwgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDYvMTgvMTkg
MTA6MDggQU0sIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+PiBXZSBmb3Jn
ZXQgdG8gZW5hYmxlIGl0IGZvciB0cmFuc2FjdGlvbiAucHJlcGFyZSwgd2hpbGUgaXQgaXMgYWxy
ZWFkeQ0KPj4gZW5hYmxlZCBpbiBkb19kcml2ZV9iYWNrdXAgc2luY2UgY29tbWl0IGEyZDY2NWMx
YmMzNjINCj4+ICAgICAgImJsb2NrZGV2OiBsb29zZW4gcmVzdHJpY3Rpb25zIG9uIGRyaXZlLWJh
Y2t1cCBzb3VyY2Ugbm9kZSINCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRz
b3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+PiAtLS0NCj4+DQo+PiBI
bW0sIEkndmUgdG8gYWRkIEpvaG4gYnkgaGFuZCwgZ2V0X21haW50YWluZXIucGwgZG9uJ3QgcmVw
b3J0IGhpbS4NCj4+IFNob3VsZG4ndCB3ZSBpbmNsdWRlIGJsb2NrZGV2LmMgaW50byBCbG9jayBK
b2JzIGluIE1BSU5UQUlORVJTPw0KPj4gSXQgZGVmaW5pdGVseSByZWxhdGVkIHRvIGJsb2NrIGpv
YnMuDQo+Pg0KPj4gICBibG9ja2Rldi5jIHwgMiArLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYmxvY2tkZXYu
YyBiL2Jsb2NrZGV2LmMNCj4+IGluZGV4IGI1YzBmZDNjNDkuLjRhZTgxZDY4N2EgMTAwNjQ0DQo+
PiAtLS0gYS9ibG9ja2Rldi5jDQo+PiArKysgYi9ibG9ja2Rldi5jDQo+PiBAQCAtMTc3NSw3ICsx
Nzc1LDcgQEAgc3RhdGljIHZvaWQgZHJpdmVfYmFja3VwX3ByZXBhcmUoQmxrQWN0aW9uU3RhdGUg
KmNvbW1vbiwgRXJyb3IgKiplcnJwKQ0KPj4gICAgICAgYXNzZXJ0KGNvbW1vbi0+YWN0aW9uLT50
eXBlID09IFRSQU5TQUNUSU9OX0FDVElPTl9LSU5EX0RSSVZFX0JBQ0tVUCk7DQo+PiAgICAgICBi
YWNrdXAgPSBjb21tb24tPmFjdGlvbi0+dS5kcml2ZV9iYWNrdXAuZGF0YTsNCj4+ICAgDQo+PiAt
ICAgIGJzID0gcW1wX2dldF9yb290X2JzKGJhY2t1cC0+ZGV2aWNlLCBlcnJwKTsNCj4+ICsgICAg
YnMgPSBiZHJ2X2xvb2t1cF9icyhiYWNrdXAtPmRldmljZSwgYmFja3VwLT5kZXZpY2UsIGVycnAp
Ow0KPj4gICAgICAgaWYgKCFicykgew0KPj4gICAgICAgICAgIHJldHVybjsNCj4+ICAgICAgIH0N
Cj4+DQo+IA0KPiBBaCwgdGNoLiBJIHNob3VsZCBleHRlbmQgMjU2IHRvbyBpbiB0aGlzIGNhc2Uu
IFdvdWxkIHlvdSBsaWtlIG1lIHRvIHRha2UNCj4gY2FyZSBvZiB0aGF0Pw0KDQpJdCB3aWxsIGJl
IGdyZWF0DQoNCj4gDQo+IEpva2luZ2x5OiAiZHJpdmUtYmFja3VwIGlzIGEgbGVnYWN5IGludGVy
ZmFjZSwgcGxlYXNlIGRvbid0IHVzZSBpdCEiDQo+IA0KPiAtLWpzDQo+IA0KDQoNCi0tIA0KQmVz
dCByZWdhcmRzLA0KVmxhZGltaXINCg==

