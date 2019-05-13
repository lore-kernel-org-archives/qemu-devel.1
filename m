Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6243C04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:57:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 901BE20989
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UW3Adevf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 901BE20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54412 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ7i8-0004tE-V2
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 05:57:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hQ7hN-0004SS-9G
	for qemu-devel@nongnu.org; Mon, 13 May 2019 05:56:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hQ7hM-0003ar-31
	for qemu-devel@nongnu.org; Mon, 13 May 2019 05:56:45 -0400
Received: from mail-eopbgr120132.outbound.protection.outlook.com
	([40.107.12.132]:7858
	helo=FRA01-PR2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hQ7hJ-0003Ym-AQ; Mon, 13 May 2019 05:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Tuymg7ki45v/MnTaxJKwe9aVRyur4dKwm7xXy/JxAjg=;
	b=UW3AdevfwwwNPxijx8Lvw6R0pZvO7Abchxo7qnDK2UPZ+/7/9uWmqSdfGHxlyhXG5VevUKjWfnNllAVyT02pbcMZJws2YT0hg+5rjhkqNQYowTG53MeHh7QvG0lNjbNk+fOEmK3PKZ3bLpV1hyg5kwx2I6n1l5eZtukSGQI6Wb0=
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com (52.133.109.209) by
	PR2PR08MB4747.eurprd08.prod.outlook.com (52.133.111.74) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1878.20; Mon, 13 May 2019 09:56:39 +0000
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::9c35:2e89:30c4:5cc4]) by
	PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::9c35:2e89:30c4:5cc4%3]) with mapi id 15.20.1878.024;
	Mon, 13 May 2019 09:56:39 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v6 0/8] qcow2: encryption threads
Thread-Index: AQHVBBfkp37usDxTHk2YnAVe1273lKZi5qgAgAX1dIA=
Date: Mon, 13 May 2019 09:56:39 +0000
Message-ID: <bf68e127-b30d-75db-4ecb-8fc354cb25fe@virtuozzo.com>
References: <20190506142741.41731-1-vsementsov@virtuozzo.com>
	<5a643d95-3732-e22d-7cc5-122ae5792641@redhat.com>
In-Reply-To: <5a643d95-3732-e22d-7cc5-122ae5792641@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P195CA0011.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::21)
	To PR2PR08MB4684.eurprd08.prod.outlook.com
	(2603:10a6:101:22::17)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190513125635479
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bcf0720-055d-486c-ae62-08d6d7894af9
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:PR2PR08MB4747; 
x-ms-traffictypediagnostic: PR2PR08MB4747:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <PR2PR08MB47472ADAD9EF31E42069AF80C10F0@PR2PR08MB4747.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(39840400004)(376002)(396003)(346002)(136003)(189003)(199004)(99286004)(2616005)(31696002)(53936002)(2906002)(76176011)(52116002)(2201001)(2501003)(476003)(486006)(66066001)(478600001)(305945005)(7736002)(8676002)(81156014)(8936002)(81166006)(6116002)(86362001)(3846002)(5660300002)(966005)(53546011)(386003)(66446008)(4326008)(68736007)(25786009)(446003)(6512007)(102836004)(186003)(71190400001)(26005)(6436002)(6506007)(71200400001)(6486002)(64756008)(66556008)(66476007)(73956011)(66946007)(31686004)(6246003)(229853002)(316002)(107886003)(54906003)(6306002)(36756003)(11346002)(110136005)(256004)(14444005)(14454004);
	DIR:OUT; SFP:1102; SCL:1; SRVR:PR2PR08MB4747;
	H:PR2PR08MB4684.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WWOVBaQHC6kKe36auvNtVySbZyXLevcFC6KA4d1UYKAU0/mu/rThe26toUPzns461Vgx9BTDERIpUxeHUOX/d5eJgJjGIQfg7yS0/+ApxP6FIcLYTaNRQ+JLOQCOR8AIwkXHmSqQzYcjjMVq38L9RpZXNTeCiECPhIePNAszTPnDfwr+loDfaF0nty96YmxoJatouzWtuQi7lZPqvJ9SQpjzdZXvqX3sLbriIQPTVcLdnMDus85m/C+2G0YX4N7QjLwwpmHhSxrlOZlRdo6Z+XUKnXGL9oHSKcgZnokyaWvGuBM8JExMvc27PFSuKXLNOkDzkKbgUdLsk7o6JqrqkUtxerin1+chH946W9fBu8wTY8l6jj8ZSrMup08NtZtkM0HMDjS3yLjDyGM45NNQ9kOP4M/YEkzWsKB7ZIBPIYo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0BE810EDACC5341BA5A3251E4F055B4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bcf0720-055d-486c-ae62-08d6d7894af9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 09:56:39.0354 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4747
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.12.132
Subject: Re: [Qemu-devel] [PATCH v6 0/8] qcow2: encryption threads
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"berto@igalia.com" <berto@igalia.com>,
	"berrange@redhat.com" <berrange@redhat.com>,
	Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDkuMDUuMjAxOSAxNzo1NiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAwNi4wNS4xOSAxNjoyNywg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IHY2Og0KPj4gICAtIFJlYmFz
ZSBvbiBtYXN0ZXIsIHNvIDAyIGNoYW5nZWQgdG8gcmVmbGVjdCBjaGFuZ2VzIGluDQo+PiAgICAg
cWNvdzJfY29tcHJlc3MoKSwga2VlcCByLWIuDQo+PiAgIC0gUmV3cml0ZSAwNiB0byBldmVuIHNp
bXBsZXIgbG9ja2luZyBbTWF4XSwgZHJvcCByLWINCj4+ICAgICBEcm9wIGZvbGxvd2luZw0KPj4g
ICAgICJxY293MjogcWNvdzJfY29fcHJlYWR2OiBza2lwIHVzaW5nIGhkX3Fpb3Ygd2hlbiBwb3Nz
aWJsZSIsIEknbGwgZG8NCj4+ICAgICBpdCBpbiBteSBvdGhlciBjb21pbmcgc29vbiBzZXJpZXMs
IGFuZCBpdCBpcyBhY3R1YWxseSB1bnJlbGF0ZWQgdG8NCj4+ICAgICBjdXJyZW50Lg0KPj4gICAt
IERyb3AgY29udHJvdmVyc2lhbCBwZXJmIHRlc3QsIGhvcGUgSSdsbCByZXR1cm4gdG8gdGhpcyB0
b3BpYywgYnV0IG5vdA0KPj4gICAgIGluIGNvbnRleHQgb2YgdGhlc2Ugc2VyaWVzLg0KPj4gICAt
IEFkZCBNYXgncyByLWIncyB0byBhbGwgaGVyZSwgZXhjZXB0IDA2DQo+Pg0KPj4gVmxhZGltaXIg
U2VtZW50c292LU9naWV2c2tpeSAoOCk6DQo+PiAgICBxY293Mi5oOiBhZGQgbWlzc2luZyBpbmNs
dWRlDQo+PiAgICBxY293MjogYWRkIHNlcGFyYXRlIGZpbGUgZm9yIHRocmVhZGVkIGRhdGEgcHJv
Y2Vzc2luZyBmdW5jdGlvbnMNCj4+ICAgIHFjb3cyLXRocmVhZHM6IHVzZSB0aHJlYWRfcG9vbF9z
dWJtaXRfY28NCj4+ICAgIHFjb3cyLXRocmVhZHM6IHFjb3cyX2NvX2RvX2NvbXByZXNzOiBwcm90
ZWN0IHF1ZXVpbmcgYnkgbXV0ZXgNCj4+ICAgIHFjb3cyLXRocmVhZHM6IHNwbGl0IG91dCBnZW5l
cmljIHBhdGgNCj4+ICAgIHFjb3cyOiBxY293Ml9jb19wcmVhZHY6IGltcHJvdmUgbG9ja2luZw0K
Pj4gICAgcWNvdzI6IGJkcnZfY29fcHdyaXRldjogbW92ZSBlbmNyeXB0aW9uIGNvZGUgb3V0IG9m
IHRoZSBsb2NrDQo+PiAgICBxY293MjogZG8gZW5jcnlwdGlvbiBpbiB0aHJlYWRzDQo+Pg0KPj4g
ICBibG9jay9xY293Mi5oICAgICAgICAgIHwgIDIwICsrLQ0KPj4gICBibG9jay9xY293Mi1iaXRt
YXAuYyAgIHwgICAxIC0NCj4+ICAgYmxvY2svcWNvdzItY2FjaGUuYyAgICB8ICAgMSAtDQo+PiAg
IGJsb2NrL3Fjb3cyLWNsdXN0ZXIuYyAgfCAgIDggKy0NCj4+ICAgYmxvY2svcWNvdzItcmVmY291
bnQuYyB8ICAgMSAtDQo+PiAgIGJsb2NrL3Fjb3cyLXNuYXBzaG90LmMgfCAgIDEgLQ0KPj4gICBi
bG9jay9xY293Mi10aHJlYWRzLmMgIHwgMjY4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+PiAgIGJsb2NrL3Fjb3cyLmMgICAgICAgICAgfCAyNDEgKysrKystLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiAgIGJsb2NrL01ha2VmaWxlLm9ianMgICAg
fCAgIDIgKy0NCj4+ICAgOSBmaWxlcyBjaGFuZ2VkLCAzMjEgaW5zZXJ0aW9ucygrKSwgMjIyIGRl
bGV0aW9ucygtKQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgYmxvY2svcWNvdzItdGhyZWFkcy5j
DQo+IA0KPiBUaGFua3MsIGFwcGxpZWQgdG8gbXkgYmxvY2sgYnJhbmNoOg0KPiANCj4gaHR0cHM6
Ly9naXQueGFuY2xpYy5tb2UvWGFuQ2xpYy9xZW11L2NvbW1pdHMvYnJhbmNoL2Jsb2NrDQo+IA0K
DQpUaGFuayB5b3UhIQ0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

