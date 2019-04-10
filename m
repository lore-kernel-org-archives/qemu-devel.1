Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721F5C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 08:59:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F137206B6
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 08:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HFTbo3zs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F137206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56033 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hE94j-0000tG-9C
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 04:59:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hE93h-0000FS-F7
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 04:58:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hE93e-0003L4-92
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 04:58:16 -0400
Received: from mail-eopbgr40129.outbound.protection.outlook.com
	([40.107.4.129]:45481
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hE93Y-0003HD-A0; Wed, 10 Apr 2019 04:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=5FVHEI0X48N05Ia+xTQ+QzsqrPKDiGuunAUTUpgNy6o=;
	b=HFTbo3zsolRBH+uYg4/ReOXVgM7D1QetrlbT3JRliYgC/oa5jeQKP7dVt9MyUfgsAAA7ujcZoiMNYotrew3TT9oF7mj/JT18ndI4x4ViyrIrL2XX02ZDiVGqyS5HWaAYeLYfg7JOaMMfyL+elzUmLu+TZdJvoid1yWhV/Liv0dw=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3226.eurprd08.prod.outlook.com (52.134.111.12) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.16; Wed, 10 Apr 2019 08:58:05 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1771.021;
	Wed, 10 Apr 2019 08:58:05 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>
Thread-Topic: [PATCH 1/2] qemu-img convert: ignore read errors
Thread-Index: AQHU7uRwGafxFy5NUEy5nUvw1X2OT6Y1GTgA
Date: Wed, 10 Apr 2019 08:58:04 +0000
Message-ID: <26767b69-dbd4-c243-3078-2fba26020f0e@virtuozzo.com>
References: <1554821792-968307-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1554821792-968307-2-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1554821792-968307-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR06CA0155.eurprd06.prod.outlook.com
	(2603:10a6:7:16::42) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190410115802592
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b180504d-78ad-4e4f-9549-08d6bd92a4bb
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3226; 
x-ms-traffictypediagnostic: DB7PR08MB3226:
x-microsoft-antispam-prvs: <DB7PR08MB3226940E77F51FAAF5DA3EB4C12E0@DB7PR08MB3226.eurprd08.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(396003)(39850400004)(376002)(136003)(366004)(189003)(199004)(2201001)(305945005)(31696002)(2616005)(7736002)(86362001)(53936002)(76176011)(11346002)(25786009)(6486002)(36756003)(6436002)(52116002)(446003)(66066001)(107886003)(5660300002)(4326008)(71190400001)(102836004)(476003)(6246003)(110136005)(2501003)(6506007)(6116002)(3846002)(386003)(486006)(2906002)(71200400001)(105586002)(81156014)(256004)(8676002)(26005)(186003)(316002)(68736007)(106356001)(14454004)(14444005)(6512007)(478600001)(99286004)(54906003)(31686004)(97736004)(8936002)(229853002)(81166006);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3226;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eiPk4CNRBsuUdixoJhFokAYWekjF2Es/elVkEOsk9YhOG8wM+xEMtT4rjbVffHc3Gpd6slb0nDzpWRNMtWNQCDkydCjqp/QLuePM99GT5Jp2ggZO9XFwqkO3ld0CznGq28dJyhEwxTw0i7rFyPHP2vctv4pWAtf9yJNF+bTQFFzFlgbJ9p+2mSh7AgK/BKjJzXD4MpjtH8jh/Q5X9DmMvKWQZ1PbMSOAKYgHc53i3G16yK0Oxx0m+cE6WHuIuN8pe3K2OoeimEVbeNmmHAwKvZSneeTBh6o/39YQqZTz2ElzQX+tIFP2pSSNTiHgb26+GOiu6Z2yr2R6O1GGVMo14I9mMNNarrDrw3SNjvipojAzlzMXxgMXAb/6UhRh1sZZQ8R9/SSxusiOA4CZ2443c6fuYYwmFWd58f9E9L/WMbQ=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <062B089B4371D641A586201122FDF0A5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b180504d-78ad-4e4f-9549-08d6bd92a4bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 08:58:05.0478 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3226
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.129
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-img convert: ignore read errors
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
	"mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410085804.Pdzkswk_aQlzkUUylCuQbtZKvTSchtCGcUAF5POu8-U@z>

MDkuMDQuMjAxOSAxNzo1NiwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+IFRoZSAncWVtdS1p
bWcgY29udmVydCcgbmV3IGNvbW1hbmQgb3B0aW9uICdmb3JjZSByZWFkJyB3aXRoIHRoZSBrZXkg
Jy1SJw0KPiBhbGxvd3MgY29udmVydGluZyBhIGRhbWFnZWQgaW1hZ2UgdG8gZ2V0IGFsbCB0aGUg
YXZhaWxhYmxlIGluZm9ybWF0aW9uDQo+IGluIGNhc2Ugb2YgdGhlIHJlYWQgZXJyb3JzLiBUaGUg
cHJvZ3JhbSByZXBvcnRzIHJlYWQgZXJyb3JzIGFuZCBjb250aW51ZQ0KPiB0aGUgaW1hZ2UgY29u
dmVyc2lvbi4gVGhlIHVzZXJzIHNob3VsZCBrZWVwIGluIHRoZWlyIG1pbmRzIHRoYXQgdGhlDQo+
IHJlc3VsdGluZyBpbWFnZSBpcyBpbmNvbnNpc3RlbnQuDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IERl
bmlzIFYuIEx1bmV2IDxkZW5Ab3BlbnZ6Lm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IFNo
aW5rZXZpY2ggPGFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20+DQo+IC0tLQ0KPiAgIHFl
bXUtaW1nLWNtZHMuaHggfCAgNCArKy0tDQo+ICAgcWVtdS1pbWcuYyAgICAgICB8IDE4ICsrKysr
KysrKysrKysrKystLQ0KPiAgIHFlbXUtaW1nLnRleGkgICAgfCAgMiArLQ0KPiAgIDMgZmlsZXMg
Y2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9xZW11LWltZy1jbWRzLmh4IGIvcWVtdS1pbWctY21kcy5oeA0KPiBpbmRleCAxNTI2ZjMy
Li4wOWFmOWNiIDEwMDY0NA0KPiAtLS0gYS9xZW11LWltZy1jbWRzLmh4DQo+ICsrKyBiL3FlbXUt
aW1nLWNtZHMuaHgNCj4gQEAgLTQ0LDkgKzQ0LDkgQEAgU1RFWEkNCj4gICBFVEVYSQ0KPiAgIA0K
PiAgIERFRigiY29udmVydCIsIGltZ19jb252ZXJ0LA0KPiAtICAgICJjb252ZXJ0IFstLW9iamVj
dCBvYmplY3RkZWZdIFstLWltYWdlLW9wdHNdIFstLXRhcmdldC1pbWFnZS1vcHRzXSBbLVVdIFst
Q10gWy1jXSBbLXBdIFstcV0gWy1uXSBbLWYgZm10XSBbLXQgY2FjaGVdIFstVCBzcmNfY2FjaGVd
IFstTyBvdXRwdXRfZm10XSBbLUIgYmFja2luZ19maWxlXSBbLW8gb3B0aW9uc10gWy1sIHNuYXBz
aG90X3BhcmFtXSBbLVMgc3BhcnNlX3NpemVdIFstbSBudW1fY29yb3V0aW5lc10gWy1XXSBmaWxl
bmFtZSBbZmlsZW5hbWUyIFsuLi5dXSBvdXRwdXRfZmlsZW5hbWUiKQ0KPiArICAgICJjb252ZXJ0
IFstLW9iamVjdCBvYmplY3RkZWZdIFstLWltYWdlLW9wdHNdIFstLXRhcmdldC1pbWFnZS1vcHRz
XSBbLVVdIFstUl0gWy1DXSBbLWNdIFstcF0gWy1xXSBbLW5dIFstZiBmbXRdIFstdCBjYWNoZV0g
Wy1UIHNyY19jYWNoZV0gWy1PIG91dHB1dF9mbXRdIFstQiBiYWNraW5nX2ZpbGVdIFstbyBvcHRp
b25zXSBbLWwgc25hcHNob3RfcGFyYW1dIFstUyBzcGFyc2Vfc2l6ZV0gWy1tIG51bV9jb3JvdXRp
bmVzXSBbLVddIGZpbGVuYW1lIFtmaWxlbmFtZTIgWy4uLl1dIG91dHB1dF9maWxlbmFtZSIpDQo+
ICAgU1RFWEkNCj4gLUBpdGVtIGNvbnZlcnQgWy0tb2JqZWN0IEB2YXJ7b2JqZWN0ZGVmfV0gWy0t
aW1hZ2Utb3B0c10gWy0tdGFyZ2V0LWltYWdlLW9wdHNdIFstVV0gWy1jXSBbLXBdIFstcV0gWy1u
XSBbLWYgQHZhcntmbXR9XSBbLXQgQHZhcntjYWNoZX1dIFstVCBAdmFye3NyY19jYWNoZX1dIFst
TyBAdmFye291dHB1dF9mbXR9XSBbLUIgQHZhcntiYWNraW5nX2ZpbGV9XSBbLW8gQHZhcntvcHRp
b25zfV0gWy1sIEB2YXJ7c25hcHNob3RfcGFyYW19XSBbLVMgQHZhcntzcGFyc2Vfc2l6ZX1dIFst
bSBAdmFye251bV9jb3JvdXRpbmVzfV0gWy1XXSBAdmFye2ZpbGVuYW1lfSBbQHZhcntmaWxlbmFt
ZTJ9IFsuLi5dXSBAdmFye291dHB1dF9maWxlbmFtZX0NCj4gK0BpdGVtIGNvbnZlcnQgWy0tb2Jq
ZWN0IEB2YXJ7b2JqZWN0ZGVmfV0gWy0taW1hZ2Utb3B0c10gWy0tdGFyZ2V0LWltYWdlLW9wdHNd
IFstVV0gWy1SXSBbLWNdIFstcF0gWy1xXSBbLW5dIFstZiBAdmFye2ZtdH1dIFstdCBAdmFye2Nh
Y2hlfV0gWy1UIEB2YXJ7c3JjX2NhY2hlfV0gWy1PIEB2YXJ7b3V0cHV0X2ZtdH1dIFstQiBAdmFy
e2JhY2tpbmdfZmlsZX1dIFstbyBAdmFye29wdGlvbnN9XSBbLWwgQHZhcntzbmFwc2hvdF9wYXJh
bX1dIFstUyBAdmFye3NwYXJzZV9zaXplfV0gWy1tIEB2YXJ7bnVtX2Nvcm91dGluZXN9XSBbLVdd
IEB2YXJ7ZmlsZW5hbWV9IFtAdmFye2ZpbGVuYW1lMn0gWy4uLl1dIEB2YXJ7b3V0cHV0X2ZpbGVu
YW1lfQ0KPiAgIEVURVhJDQo+ICAgDQo+ICAgREVGKCJjcmVhdGUiLCBpbWdfY3JlYXRlLA0KPiBk
aWZmIC0tZ2l0IGEvcWVtdS1pbWcuYyBiL3FlbXUtaW1nLmMNCj4gaW5kZXggYWE2ZjgxZi4uNDk0
ZTg4MCAxMDA2NDQNCj4gLS0tIGEvcWVtdS1pbWcuYw0KPiArKysgYi9xZW11LWltZy5jDQo+IEBA
IC0xNzUsNiArMTc1LDcgQEAgc3RhdGljIHZvaWQgUUVNVV9OT1JFVFVSTiBoZWxwKHZvaWQpDQo+
ICAgICAgICAgICAgICAiUGFyYW1ldGVycyB0byBjb252ZXJ0IHN1YmNvbW1hbmQ6XG4iDQo+ICAg
ICAgICAgICAgICAiICAnLW0nIHNwZWNpZmllcyBob3cgbWFueSBjb3JvdXRpbmVzIHdvcmsgaW4g
cGFyYWxsZWwgZHVyaW5nIHRoZSBjb252ZXJ0XG4iDQo+ICAgICAgICAgICAgICAiICAgICAgIHBy
b2Nlc3MgKGRlZmF1bHRzIHRvIDgpXG4iDQo+ICsgICAgICAgICAgICIgICctUicgY29udGludWUg
dGhlIGltYWdlIGNvbnZlcnNpb24gaW4gY2FzZSBvZiB0aGUgc2VjdG9yIHJlYWQgZXJyb3JcbiIN
Cj4gICAgICAgICAgICAgICIgICctVycgYWxsb3cgdG8gd3JpdGUgdG8gdGhlIHRhcmdldCBvdXQg
b2Ygb3JkZXIgcmF0aGVyIHRoYW4gc2VxdWVudGlhbFxuIg0KPiAgICAgICAgICAgICAgIlxuIg0K
PiAgICAgICAgICAgICAgIlBhcmFtZXRlcnMgdG8gc25hcHNob3Qgc3ViY29tbWFuZDpcbiINCj4g
QEAgLTE1NzksNiArMTU4MCw3IEBAIHR5cGVkZWYgc3RydWN0IEltZ0NvbnZlcnRTdGF0ZSB7DQo+
ICAgICAgIGludDY0X3Qgd2FpdF9zZWN0b3JfbnVtW01BWF9DT1JPVVRJTkVTXTsNCj4gICAgICAg
Q29NdXRleCBsb2NrOw0KPiAgICAgICBpbnQgcmV0Ow0KPiArICAgIGJvb2wgZm9yY2VfcmVhZDsN
Cj4gICB9IEltZ0NvbnZlcnRTdGF0ZTsNCj4gICANCj4gICBzdGF0aWMgdm9pZCBjb252ZXJ0X3Nl
bGVjdF9wYXJ0KEltZ0NvbnZlcnRTdGF0ZSAqcywgaW50NjRfdCBzZWN0b3JfbnVtLA0KPiBAQCAt
MTY5Myw3ICsxNjk1LDE1IEBAIHN0YXRpYyBpbnQgY29yb3V0aW5lX2ZuIGNvbnZlcnRfY29fcmVh
ZChJbWdDb252ZXJ0U3RhdGUgKnMsIGludDY0X3Qgc2VjdG9yX251bSwNCj4gICAgICAgICAgICAg
ICAgICAgYmxrLCAoc2VjdG9yX251bSAtIHNyY19jdXJfb2Zmc2V0KSA8PCBCRFJWX1NFQ1RPUl9C
SVRTLA0KPiAgICAgICAgICAgICAgICAgICBuIDw8IEJEUlZfU0VDVE9SX0JJVFMsICZxaW92LCAw
KTsNCj4gICAgICAgICAgIGlmIChyZXQgPCAwKSB7DQo+IC0gICAgICAgICAgICByZXR1cm4gcmV0
Ow0KPiArICAgICAgICAgICAgaWYgKCFzLT5mb3JjZV9yZWFkKSB7DQo+ICsgICAgICAgICAgICAg
ICAgcmV0dXJuIHJldDsNCj4gKyAgICAgICAgICAgIH0NCj4gKyAgICAgICAgICAgIGludDY0X3Qg
b2Zmc2V0ID0gKHNlY3Rvcl9udW0gLSBzcmNfY3VyX29mZnNldCkgPDwgQkRSVl9TRUNUT1JfQklU
UzsNCj4gKyAgICAgICAgICAgIHVuc2lnbmVkIGludCBieXRlcyA9IG4gPDwgQkRSVl9TRUNUT1Jf
QklUUzsNCg0KZGVjbGFyYXRpb25zIHNob3VsZCBiZSBhdCBzdGFydCBvZiBibG9jayBhbmQgYmV0
dGVyIHNlcGFyYXRlZCBieSBvbmUgZW1wdHkgbGluZS4NCk9uIHRoZSBvdGhlciBoYW5kLCBpZiB3
ZSBhZGQgdGhlc2UgdmFyaWFibGVzLCBJIHRoaW5rIGJldHRlciB0byBkZWNsYXJlIHRoZW0gaW4g
d2hpbGUNCmJsb2NrIGFuZCByZXVzZSBmb3IgYmxrX2NvX3ByZWFkdiB0b28uDQoNCndpdGggYXQg
bGVhc3QgdGhpcyBmaXhlZCAoYnV0IG5vdGUsIGFsc28sIHRoYXQgSSdtIG5vdCBnb29kIGluIGNt
ZCBsaW5lIG9wdGlvbiBkZWZpbmluZy4gTG9va3MgbGlrZSB3ZQ0KaGF2ZSB0b28gbWFueSBwbGFj
ZXMgd2hlcmUgc29tZXRoaW5nIHNob3VsZCBiZSBhZGRlZCk6DQpSZXZpZXdlZC1ieTogVmxhZGlt
aXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQo+ICsg
ICAgICAgICAgICBlcnJvcl9yZXBvcnQoImZhaWxlZCB0byByZWFkICVkIGJ5dGVzIGF0IG9mZnNl
dCAlIiBQUklkNjQgIjogJXMiLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgIGJ5dGVzLCBv
ZmZzZXQsIHN0cmVycm9yKC1yZXQpKTsNCj4gKyAgICAgICAgICAgIG1lbXNldChidWYsIDAsIG4g
KiBCRFJWX1NFQ1RPUl9TSVpFKTsNCg0KaG1tLCBtYXkgYmUgc29tZSBub24temVybyBwYXR0ZXJu
IHdvdWxkIGJlIGJldHRlci4NCg0KPiArICAgICAgICAgICAgLyogVE9ETzogcmV0cnkgdG8gcmVh
ZCBzbWFsbGVyIGNodW5rcyAqLw0KPiAgICAgICAgICAgfQ0KPiAgIA0KPiAgICAgICAgICAgc2Vj
dG9yX251bSArPSBuOw0KPiBAQCAtMjAxOCw2ICsyMDI4LDcgQEAgc3RhdGljIGludCBpbWdfY29u
dmVydChpbnQgYXJnYywgY2hhciAqKmFyZ3YpDQo+ICAgICAgICAgICAuYnVmX3NlY3RvcnMgICAg
ICAgID0gSU9fQlVGX1NJWkUgLyBCRFJWX1NFQ1RPUl9TSVpFLA0KPiAgICAgICAgICAgLndyX2lu
X29yZGVyICAgICAgICA9IHRydWUsDQo+ICAgICAgICAgICAubnVtX2Nvcm91dGluZXMgICAgID0g
OCwNCj4gKyAgICAgICAgLmZvcmNlX3JlYWQgICAgICAgICA9IGZhbHNlLA0KDQpJdCBpcyBpbml0
aWFsaXplZCBieSB6ZXJvIGJ5IGRlZmF1bHQsIGFzIGFsbCBvdGhlciBmaWVsZHMuICIuY29weV9y
YW5nZSA9IGZhbHNlIiBpcw0KYmFkIGV4YW1wbGUgaGVyZSwgSSB0aGluay4NCg0KPiAgICAgICB9
Ow0KPiAgIA0KPiAgICAgICBmb3IoOzspIHsNCj4gQEAgLTIwMjksNyArMjA0MCw3IEBAIHN0YXRp
YyBpbnQgaW1nX2NvbnZlcnQoaW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0KPiAgICAgICAgICAgICAg
IHsidGFyZ2V0LWltYWdlLW9wdHMiLCBub19hcmd1bWVudCwgMCwgT1BUSU9OX1RBUkdFVF9JTUFH
RV9PUFRTfSwNCj4gICAgICAgICAgICAgICB7MCwgMCwgMCwgMH0NCj4gICAgICAgICAgIH07DQo+
IC0gICAgICAgIGMgPSBnZXRvcHRfbG9uZyhhcmdjLCBhcmd2LCAiOmhmOk86QjpDY286bDpTOnB0
OlQ6cW5tOldVIiwNCj4gKyAgICAgICAgYyA9IGdldG9wdF9sb25nKGFyZ2MsIGFyZ3YsICI6aGY6
TzpCOkNjbzpsOlM6cHQ6VDpxbm06UldVIiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICBs
b25nX29wdGlvbnMsIE5VTEwpOw0KPiAgICAgICAgICAgaWYgKGMgPT0gLTEpIHsNCj4gICAgICAg
ICAgICAgICBicmVhazsNCj4gQEAgLTIxMzIsNiArMjE0Myw5IEBAIHN0YXRpYyBpbnQgaW1nX2Nv
bnZlcnQoaW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0KPiAgICAgICAgICAgY2FzZSAnVSc6DQo+ICAg
ICAgICAgICAgICAgZm9yY2Vfc2hhcmUgPSB0cnVlOw0KPiAgICAgICAgICAgICAgIGJyZWFrOw0K
PiArICAgICAgICBjYXNlICdSJzoNCj4gKyAgICAgICAgICAgIHMuZm9yY2VfcmVhZCA9IHRydWU7
DQo+ICsgICAgICAgICAgICBicmVhazsNCj4gICAgICAgICAgIGNhc2UgT1BUSU9OX09CSkVDVDog
ew0KPiAgICAgICAgICAgICAgIFFlbXVPcHRzICpvYmplY3Rfb3B0czsNCj4gICAgICAgICAgICAg
ICBvYmplY3Rfb3B0cyA9IHFlbXVfb3B0c19wYXJzZV9ub2lzaWx5KCZxZW11X29iamVjdF9vcHRz
LA0KPiBkaWZmIC0tZ2l0IGEvcWVtdS1pbWcudGV4aSBiL3FlbXUtaW1nLnRleGkNCj4gaW5kZXgg
M2I2NzEwYS4uOTRmN2Q4MCAxMDA2NDQNCj4gLS0tIGEvcWVtdS1pbWcudGV4aQ0KPiArKysgYi9x
ZW11LWltZy50ZXhpDQo+IEBAIC0zMjUsNyArMzI1LDcgQEAgRXJyb3Igb24gcmVhZGluZyBkYXRh
DQo+ICAgDQo+ICAgQGVuZCB0YWJsZQ0KPiAgIA0KPiAtQGl0ZW0gY29udmVydCBbLS1vYmplY3Qg
QHZhcntvYmplY3RkZWZ9XSBbLS1pbWFnZS1vcHRzXSBbLS10YXJnZXQtaW1hZ2Utb3B0c10gWy1V
XSBbLUNdIFstY10gWy1wXSBbLXFdIFstbl0gWy1mIEB2YXJ7Zm10fV0gWy10IEB2YXJ7Y2FjaGV9
XSBbLVQgQHZhcntzcmNfY2FjaGV9XSBbLU8gQHZhcntvdXRwdXRfZm10fV0gWy1CIEB2YXJ7YmFj
a2luZ19maWxlfV0gWy1vIEB2YXJ7b3B0aW9uc31dIFstbCBAdmFye3NuYXBzaG90X3BhcmFtfV0g
Wy1TIEB2YXJ7c3BhcnNlX3NpemV9XSBbLW0gQHZhcntudW1fY29yb3V0aW5lc31dIFstV10gQHZh
cntmaWxlbmFtZX0gW0B2YXJ7ZmlsZW5hbWUyfSBbLi4uXV0gQHZhcntvdXRwdXRfZmlsZW5hbWV9
DQo+ICtAaXRlbSBjb252ZXJ0IFstLW9iamVjdCBAdmFye29iamVjdGRlZn1dIFstLWltYWdlLW9w
dHNdIFstLXRhcmdldC1pbWFnZS1vcHRzXSBbLVVdIFstUl0gWy1DXSBbLWNdIFstcF0gWy1xXSBb
LW5dIFstZiBAdmFye2ZtdH1dIFstdCBAdmFye2NhY2hlfV0gWy1UIEB2YXJ7c3JjX2NhY2hlfV0g
Wy1PIEB2YXJ7b3V0cHV0X2ZtdH1dIFstQiBAdmFye2JhY2tpbmdfZmlsZX1dIFstbyBAdmFye29w
dGlvbnN9XSBbLWwgQHZhcntzbmFwc2hvdF9wYXJhbX1dIFstUyBAdmFye3NwYXJzZV9zaXplfV0g
Wy1tIEB2YXJ7bnVtX2Nvcm91dGluZXN9XSBbLVddIEB2YXJ7ZmlsZW5hbWV9IFtAdmFye2ZpbGVu
YW1lMn0gWy4uLl1dIEB2YXJ7b3V0cHV0X2ZpbGVuYW1lfQ0KPiAgIA0KPiAgIENvbnZlcnQgdGhl
IGRpc2sgaW1hZ2UgQHZhcntmaWxlbmFtZX0gb3IgYSBzbmFwc2hvdCBAdmFye3NuYXBzaG90X3Bh
cmFtfQ0KPiAgIHRvIGRpc2sgaW1hZ2UgQHZhcntvdXRwdXRfZmlsZW5hbWV9IHVzaW5nIGZvcm1h
dCBAdmFye291dHB1dF9mbXR9LiBJdCBjYW4gYmUgb3B0aW9uYWxseSBjb21wcmVzc2VkIChAY29k
ZXstY30NCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

