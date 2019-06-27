Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9965AC48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 15:06:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 637302086D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 15:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dTufqs2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 637302086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgVyQ-0006V3-LY
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 11:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56481)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hgVwp-0005BI-Cp
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hgVwn-0003oH-Cf
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:04:27 -0400
Received: from mail-eopbgr130121.outbound.protection.outlook.com
 ([40.107.13.121]:35303 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1hgVwk-0003iD-Tp; Thu, 27 Jun 2019 11:04:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=SkU3i8T5lwpaj9tMMG44FHNxdwO7bg+PNGPJ21lvWuTUExgkY/eueT0SDCpIcqD65bLq2MQLMhgjh1/FAgoQEZZMOMyuu93+OGUbknYmlAmyD6+F/RaEJMCFuvx9G6yiJrWuKrwY5zSnOODO3JQB571boRHULuvUWGB61CBk7xM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsb7Y24+Drtx8sQa16IV2KQTGT3K/FICpbA5b4rkhps=;
 b=HSQhzb6+ljaiuKLv7vLSlEiHvMsvgS54QHMdcELVA2sSPrONRcLUUoaRhjWzqf8wDMtjeBKcwEU3JW+Xu5MysUONooZO052DmzxsKirHb3h9+HBNQ4dl2OxP0h/BXgAhtF+EwUYTM2Xn9+5YrcHYkFI8kr4QldAFUaCJE+PEe4M=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsb7Y24+Drtx8sQa16IV2KQTGT3K/FICpbA5b4rkhps=;
 b=dTufqs2U++pp5L/ZnT4Mg8sWjTJYigNAoADctYlg34IBl6rtiGnWtaLevGEZPX9B3OXeXXr1KbgEXUerMCIt7omGGGzMMhyWWqmlFGTwDyG0g8ki7mzZ4DPmlXQmscRjeTbmqJtwb1sjVwwvr8SYzfv40E71j8WHoSf6yu/Ptos=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB5154.eurprd08.prod.outlook.com (10.255.31.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Thu, 27 Jun 2019 15:04:17 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::44eb:4518:e1f2:144c]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::44eb:4518:e1f2:144c%7]) with mapi id 15.20.2008.014; Thu, 27 Jun 2019
 15:04:17 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com"
 <mreitz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PING PING] [PATCH v0 0/3] add zstd cluster compression
Thread-Index: AQHVLPmX+3v/GNFGukuSR5Rb4xgV8A==
Date: Thu, 27 Jun 2019 15:04:17 +0000
Message-ID: <0501ea7b-0ded-ae2a-3e21-0b1f9e975623@virtuozzo.com>
References: <20190528143727.10529-1-dplotnikov@virtuozzo.com>
 <8d74b270-b70e-4779-e10e-72b11387aefc@virtuozzo.com>
In-Reply-To: <8d74b270-b70e-4779-e10e-72b11387aefc@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0186.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::34) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dccaa823-f12e-4dad-42c5-08d6fb10b986
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB5154; 
x-ms-traffictypediagnostic: AM0PR08MB5154:
x-microsoft-antispam-prvs: <AM0PR08MB515432CDBB902D7C673F55DBCFFD0@AM0PR08MB5154.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(136003)(39850400004)(376002)(366004)(189003)(199004)(11346002)(54906003)(6486002)(6116002)(81156014)(2201001)(2906002)(71190400001)(31696002)(53936002)(4326008)(110136005)(99286004)(71200400001)(68736007)(81166006)(186003)(73956011)(66946007)(7736002)(102836004)(6436002)(476003)(8936002)(36756003)(486006)(86362001)(8676002)(316002)(26005)(2501003)(6506007)(66476007)(76176011)(386003)(446003)(2616005)(66556008)(25786009)(256004)(66066001)(5660300002)(478600001)(66446008)(64756008)(53546011)(305945005)(31686004)(6512007)(107886003)(3846002)(14454004)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5154;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RFV0I8DvxclMCzg+ikYlkT/RnSVniMoP41+Vw4aJFwMyseaENCtM+wCoCxfZTSr2iGLGEVS7F2TV4lczQBRVxF2oq8CEEfe8VKd5tZEgSDtnXuA8z0nljWp8zwNslHyH5U5JglZ3lF1huQDFp+JzcRWQzKtVjpsFYWaozT3bryuXSLE0HWyjJx75e0RPWfookRfAAI0bfScSw1hf7B3IC7WHvgNpJlh4jnu3ew2oAvevvO2jnOsv9BOpMrgzEJT2wG5fAkGQYUYctquu6U6AbbpZAVqmcLdiKyVj/iHPLEjB0GPaUBJ6zBLhR5Zfc5X/8mgaeiWZ4UVdJEX72hpuj29v9TzJ7EdwL2Q4M2XquG7skd+GLtIq++9zB7DMX+d/GdQ4BDeflu75/Rmw83+k77iMMspUnk8BkFuLssiHTjk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC2EF1C97BC206409D23603CA11F8604@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dccaa823-f12e-4dad-42c5-08d6fb10b986
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 15:04:17.3244 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dplotnikov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5154
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.121
Subject: [Qemu-devel] [PING PING] [PATCH v0 0/3] add zstd cluster compression
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDA0LjA2LjIwMTkgMTA6NTYsIERlbmlzIFBsb3RuaWtvdiB3cm90ZToNCj4gDQo+IA0K
PiBPbiAyOC4wNS4yMDE5IDE3OjM3LCBEZW5pcyBQbG90bmlrb3Ygd3JvdGU6DQo+PiBUaGUgZ29h
bCBvZiB0aGUgcGF0Y2gtc2V0IGlzIHRvIGVuYWJsZSBxY293MiB0byB1c2UgenN0ZCBjb21wcmVz
c2lvbiBmb3INCj4+IGNsdXN0ZXJzLiBaU1REIHByb3ZpZGVzIGJldHRlciAoZGUpY29tcHJlc3Np
b24gcGVyZm9ybWFuY2UgdGhhbiBjdXJyZW50bHkNCj4+IHVzZWQgWkxJQi4gVXNpbmcgaXQgd2ls
bCBpbXByb3ZlIHBlcmZvcmFtbmNlIChyZWR1Y2UgY29tcHJlc3Npb24gdGltZSkNCj4+IHdoZW4g
dGhlIGNvbXByZXNzZWQgY2x1c3RlcnMgaXMgdXNlZCwgZS5nIGJhY2t1cCBzY2VuYXJpb3MuDQo+
Pg0KPj4gQWxzbywgdGhlIHBhdGNoLXNldCBleHRlbmRzIHFjb3cyIHNwZWNpZmljYXRpb24gYnkg
YWRkaW5nIGNvbXByZXNzaW9uX3R5cGUNCj4+IGZlYXR1cmUuIFRoZSBmZWF0dXJlIGVuYWJsZXMg
YWRkaW5nIFpTVEQgYW5kIGFub3RoZXIgY29tcHJlc3Npb24gYWxnb3JpdGhtcw0KPj4gaW4gdGhl
IGZ1dHVyZS4NCj4+DQo+PiBIZXJlIGlzIHNvbWUgbWVhc3VyZW1lbnRzIFpTVEQgdnMgWkxJQjoN
Cj4+DQo+PiBUaGUgdGVzdDoNCj4+ICAgICAgIFRlc3QgY29tcHJlc3NlcyBhbmQgZGVjb21wcmVz
c2VzIHFlbXUgcWNvdzIgaW1hZ2Ugd2l0aCBqdXN0DQo+PiAgICAgICBpbnN0YWxsZWQgcmhlbC03
LjYgZ3Vlc3QuDQo+PiAgICAgICBJbWFnZSBjbHVzdGVyIHNpemU6IDY0Sy4gSW1hZ2Ugb24gZGlz
ayBzaXplOiAyLjJHDQo+PiAgICAgICANCj4+ICAgICAgIFRoZSB0ZXN0IHdhcyBjb25kdWN0ZWQg
d2l0aCBicmQgZGlzayB0byByZWR1Y2UgdGhlIGluZmx1ZW5jZQ0KPj4gICAgICAgb2YgZGlzayBz
dWJzeXN0ZW0gdG8gdGhlIHRlc3QgcmVzdWx0cy4NCj4+ICAgICAgIFRoZSByZXN1bHRzIGlzIGdp
dmVuIGluIHNlY29uZHMuDQo+PiAgICAgICANCj4+ICAgICAgIGNvbXByZXNzIGNtZDoNCj4+ICAg
ICAgICAgdGltZSAuL3FlbXUtaW1nIGNvbnZlcnQgLU8gcWNvdzIgLWMgLW8gY29tcHJlc3Npb25f
dHlwZT1bemxpYnx6c3RkXQ0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgc3JjLmltZyBbemxp
Ynx6c3RkXV9jb21wcmVzc2VkLmltZw0KPj4gICAgICAgZGVjb21wcmVzcyBjbWQNCj4+ICAgICAg
ICAgdGltZSAuL3FlbXUtaW1nIGNvbnZlcnQgLU8gcWNvdzINCj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgIFt6bGlifHpzdGRdX2NvbXByZXNzZWQuaW1nIHVuY29tcHJlc3NlZC5pbWcNCj4+DQo+
Pg0KPj4gVGhlIHJlc3VsdHM6DQo+PiAgICAgICAgICAgICAgICAgIGNvbXByZXNzaW9uICAgICAg
ICAgICAgICAgZGVjb21wcmVzc2lvbg0KPj4gICAgICAgICAgICAgICAgemxpYiAgICAgICB6c3Rk
ICAgICAgICAgICB6bGliICAgICAgICAgenN0ZA0KPj4gICAgICAgLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiAgICAgICByZWFs
ICAgICA2NS41ICAgICAgIDE2LjMgKC03NSAlKSAgICAxLjkgICAgICAgICAgMS42ICgtMTYgJSkN
Cj4+ICAgICAgIHVzZXIgICAgIDY1LjAgICAgICAgMTUuOCAgICAgICAgICAgIDUuMyAgICAgICAg
ICAyLjUNCj4+ICAgICAgIHN5cyAgICAgICAzLjMgICAgICAgIDAuMiAgICAgICAgICAgIDIuMCAg
ICAgICAgICAyLjANCj4+ICAgICAgIA0KPj4gICAgICAgQm90aCBaTElCIGFuZCBaU1REIGdhdmUg
dGhlIHNhbWUgY29tcHJlc3Npb24gcmF0aW86IH4xLjUNCj4+ICAgICAgIGNvbXByZXNzZWQgaW1h
Z2Ugc2l6ZSBpbiBib3RoIGNhc2VzOiB+MS40Rw0KPj4NCj4+IERlbmlzIFBsb3RuaWtvdiAoMyk6
DQo+PiAgICAgcWNvdzI6IGludHJvZHVjZSBjb21wcmVzc2lvbiB0eXBlIGZlYXR1cmUNCj4+ICAg
ICBxY293MjogYWRkIGNvbXByZXNzaW9uIHR5cGUgcHJvY2Vzc2luZw0KPj4gICAgIHFjb3cyOiBh
ZGQgenN0ZCBjbHVzdGVyIGNvbXByZXNzaW9uDQo+Pg0KPj4gICAgYmxvY2svcWNvdzIuYyAgICAg
ICAgICAgICB8IDI0MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KPj4g
ICAgYmxvY2svcWNvdzIuaCAgICAgICAgICAgICB8ICAyOSArKystLQ0KPj4gICAgY29uZmlndXJl
ICAgICAgICAgICAgICAgICB8ICAyNiArKysrKw0KPj4gICAgZG9jcy9pbnRlcm9wL3Fjb3cyLnR4
dCAgICB8ICAzNyArKysrKy0NCj4+ICAgIGluY2x1ZGUvYmxvY2svYmxvY2tfaW50LmggfCAgIDEg
Kw0KPj4gICAgcWFwaS9ibG9jay1jb3JlLmpzb24gICAgICB8ICAzNCArKysrKy0NCj4+ICAgIDYg
ZmlsZXMgY2hhbmdlZCwgMzQ4IGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQ0KPj4NCj4g
DQoNCi0tIA0KQmVzdCwNCkRlbmlzDQo=

