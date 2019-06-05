Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D97C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 15:10:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA7B82067C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 15:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hq4JhF4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA7B82067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44281 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYXZ5-0007DH-0B
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 11:10:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYXYB-0006la-KV
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 11:10:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYXY1-00080P-IX
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 11:09:57 -0400
Received: from mail-eopbgr150129.outbound.protection.outlook.com
	([40.107.15.129]:4417
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hYXXl-0006lC-Du; Wed, 05 Jun 2019 11:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=eosp8YtGF43WO03MvG+AFP3+JrXlmXPjXXcifZfy+YA=;
	b=hq4JhF4/OWc8l9JGQa2qjRY7TSSB/WOXgEErvO/dKPro//aJ73yr3S6Htk5T5YnQ+Gt9IOpjdMLaGN+p9Qdb57V57JvoWEv4eYgtIAXXmo4RU6sPMXgHc4skGPmIID+gJTOCWojdn/la8teEaVHRreD6YCTkmqzRtK87EA+BFZQ=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
	AM0PR08MB4578.eurprd08.prod.outlook.com (20.178.22.85) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1943.22; Wed, 5 Jun 2019 15:08:54 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8]) by
	AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8%7]) with mapi id 15.20.1965.011;
	Wed, 5 Jun 2019 15:08:54 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [Qemu-block] [PATCH v2 2/2] iotests: test external snapshot with
	bitmap copying
Thread-Index: AQHVDMRByx866r1qO0izJzYzCi+V9KaNQtqAgAAEyQA=
Date: Wed, 5 Jun 2019 15:08:54 +0000
Message-ID: <81cc5a63-bd0e-4862-cf64-5390820d70d5@virtuozzo.com>
References: <20190517152111.206494-1-vsementsov@virtuozzo.com>
	<20190517152111.206494-3-vsementsov@virtuozzo.com>
	<235f1fe9-d878-7afd-ccf4-2b4f899a93b3@redhat.com>
In-Reply-To: <235f1fe9-d878-7afd-ccf4-2b4f899a93b3@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0285.eurprd05.prod.outlook.com
	(2603:10a6:7:93::16) To AM0PR08MB2961.eurprd08.prod.outlook.com
	(2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190605180852296
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 521986eb-3624-4c60-0f87-08d6e9c7b9bf
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:AM0PR08MB4578; 
x-ms-traffictypediagnostic: AM0PR08MB4578:
x-microsoft-antispam-prvs: <AM0PR08MB45788FC4E0056E51266AF547C1160@AM0PR08MB4578.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 00594E8DBA
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(366004)(396003)(39850400004)(376002)(346002)(199004)(189003)(54906003)(31696002)(7736002)(110136005)(305945005)(6512007)(53546011)(6116002)(3846002)(86362001)(6506007)(4326008)(386003)(229853002)(8676002)(26005)(2906002)(36756003)(14454004)(256004)(2501003)(6486002)(81166006)(2201001)(53936002)(8936002)(186003)(316002)(81156014)(478600001)(66556008)(71200400001)(71190400001)(6436002)(66066001)(99286004)(25786009)(76176011)(73956011)(6246003)(31686004)(5660300002)(52116002)(66946007)(11346002)(486006)(446003)(476003)(2616005)(4744005)(66446008)(64756008)(102836004)(68736007)(66476007);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4578;
	H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rlyifdfwnHvB+vQ1ZpWFrvg5Y1KvQFQVEybn6TBw2YOUguPG5y1NgL1tFQPoH6cANMvktUw+iRBBalVQBknIZgkQanrPKqAuoklGOLyRjXxXhnwLDsVYc56Ep1IeV4mM6cq1t+en03G6GdoXwVcRaeAMCJuV8u3flgYks2i0houpMzwHdG1GwXkLVfpf5BLXcGzl5ynmVgGsivW352LknahfAhE3mnfgw26M23RsO+XjdQTbW73JKe5w9SI8GGdTTXHbhUfdREN4H3xP8iNvOUi9uw0A3tqQIWOGOUQmbeh222G6wX9uKY8lYuemxBqCylj8TytFYnrDVmgTLSoG2OF3wiOGWzIbHLty4C1acDEkB9L/EGK57j3WQHL9VWb7eW3f6ahjK66UnKYAUlVMlhBK4ZVmFWcbV9JvAqS+KoI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C1E9F722C2A5B488CF1AA8DF52694D4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 521986eb-3624-4c60-0f87-08d6e9c7b9bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2019 15:08:54.5782 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4578
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.129
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 2/2] iotests: test external
 snapshot with bitmap copying
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
	Denis Lunev <den@virtuozzo.com>, "armbru@redhat.com" <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDUuMDYuMjAxOSAxNzo1MSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxNy4wNS4xOSAxNzoyMSwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IFRoaXMgdGVzdCBzaG93cyB0
aGF0IGV4dGVybmFsIHNuYXBzaG90cyBhbmQgaW5jcmVtZW50YWwgYmFja3VwcyBhcmUNCj4+IGZy
aWVuZHMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tp
eSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4gLS0tDQo+PiAgIHRlc3RzL3FlbXUtaW90
ZXN0cy8yNTQgICAgIHwgNTIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzI1NC5vdXQgfCA1MiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvZ3JvdXAgICB8ICAx
ICsNCj4+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxMDUgaW5zZXJ0aW9ucygrKQ0KPj4gICBjcmVhdGUg
bW9kZSAxMDA3NTUgdGVzdHMvcWVtdS1pb3Rlc3RzLzI1NA0KPj4gICBjcmVhdGUgbW9kZSAxMDA2
NDQgdGVzdHMvcWVtdS1pb3Rlc3RzLzI1NC5vdXQNCj4gDQo+IFRoaXMgdGVzdCBmYWlscyBmb3Ig
bWUgd2l0aCBxY293ICh2MSkuDQo+IA0KPiBNYXgNCj4gDQoNClRoYW5rcywgd2lsbCBmaXggc29t
ZWhvdyBzb29uLg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

