Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27304C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 14:12:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9EC221726
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 14:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XVfNSzzw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9EC221726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46485 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVGMz-0000Su-QR
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 10:12:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hVGM8-000063-Mn
	for qemu-devel@nongnu.org; Mon, 27 May 2019 10:12:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hVGM7-0000za-Nt
	for qemu-devel@nongnu.org; Mon, 27 May 2019 10:12:04 -0400
Received: from mail-eopbgr60109.outbound.protection.outlook.com
	([40.107.6.109]:24128
	helo=EUR04-DB3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
	id 1hVGM5-0000x9-0g; Mon, 27 May 2019 10:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=9EyMcAJrlZdCrGGUL7FwTmIi/O/YOG/1ptd36rxBA9E=;
	b=XVfNSzzwsNRF/3EjIbLQv5Ks0dBWqRtPEDDCcdwN8YlX/QQi76+bC7AJM/e/LyoRMMeTwrUQfd3fXi9qK3rgJK7GBV4PKcKhEtfzhmwEWAF9UtNaCFnNyaC7sNsP6Np1bkNwuuiMAc1TnEIVOsVFdp8IzvzYQeQI2652Vdoj8W0=
Received: from VI1PR08MB3677.eurprd08.prod.outlook.com (20.177.61.92) by
	VI1PR08MB3727.eurprd08.prod.outlook.com (20.178.14.146) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1922.15; Mon, 27 May 2019 14:11:56 +0000
Received: from VI1PR08MB3677.eurprd08.prod.outlook.com
	([fe80::3c2b:bc42:b670:6c5e]) by
	VI1PR08MB3677.eurprd08.prod.outlook.com
	([fe80::3c2b:bc42:b670:6c5e%7]) with mapi id 15.20.1922.021;
	Mon, 27 May 2019 14:11:56 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH] qcow2-bitmap: initialize bitmap directory alignment
Thread-Index: AQHVFIsC0MkvK4SQ5ka8/p6ZvhTCP6Z+9v4AgAAMMQA=
Date: Mon, 27 May 2019 14:11:56 +0000
Message-ID: <2b542d39-e4e3-ccda-0f56-cd9254f5bcf0@virtuozzo.com>
References: <1558961521-131620-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<19ec2744-5f44-0c89-e84b-90889c09abab@redhat.com>
In-Reply-To: <19ec2744-5f44-0c89-e84b-90889c09abab@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P195CA0012.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::22)
	To VI1PR08MB3677.eurprd08.prod.outlook.com
	(2603:10a6:803:85::28)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42470676-7269-4525-717f-08d6e2ad46ae
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:VI1PR08MB3727; 
x-ms-traffictypediagnostic: VI1PR08MB3727:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR08MB3727FE048478FB0B672EC16AF41D0@VI1PR08MB3727.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0050CEFE70
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(346002)(136003)(366004)(396003)(39850400004)(189003)(199004)(229853002)(2616005)(76176011)(966005)(102836004)(2906002)(4744005)(6486002)(14454004)(44832011)(486006)(6306002)(6512007)(6436002)(7736002)(6506007)(386003)(53546011)(2501003)(31686004)(305945005)(71190400001)(446003)(476003)(71200400001)(478600001)(66066001)(11346002)(3846002)(26005)(8936002)(66556008)(25786009)(53936002)(110136005)(54906003)(99286004)(4326008)(66946007)(66476007)(73956011)(66446008)(81166006)(64756008)(81156014)(86362001)(8676002)(6116002)(31696002)(256004)(14444005)(6246003)(2201001)(52116002)(107886003)(36756003)(68736007)(316002)(5660300002)(186003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3727;
	H:VI1PR08MB3677.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UqiljxILHIYgg90BzgcWLNyHRPRh6DOIgj+gledTF6esS5vTEHP+f88A4nlj9RnavvRJE/4KidEXEUWG7YtYoHWp2PqmMqZft3wwayDkGx4mz6A5QQ3M+fcHhF8oFa2FKZUgnB2kL4rE6jRi0oQnTzoIqSQFY9yX83w9T1n4sFlARprz/PYlNsKhqH+r3fz3K0DWqzSS70moOn+SZ3DvVF1wsSQsMcsujfWarxuVMBjrpFAMrTuKv55TpplnsIgw4po+MXioxsirW3Koedhk3GCUvXnlvsos+31uPUYV/2c/728CKT2SaYWMMAdk7K6noo/CYzfYDCJMK3GEHapFQKDJaPxbGhvvoKjEyiaBrCdVfA22O8CM2i7G+eumqW4VptnsO8xSdRe9XWCFOtvDMGF6kGSa/VQbFROTs66bHHw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA995FBE62617145B448B5EACA9740BE@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42470676-7269-4525-717f-08d6e2ad46ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2019 14:11:56.5968 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andrey.shinkevich@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3727
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.109
Subject: Re: [Qemu-devel] [PATCH] qcow2-bitmap: initialize bitmap directory
 alignment
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
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDI3LzA1LzIwMTkgMTY6MjgsIE1heCBSZWl0eiB3cm90ZToNCj4gT24gMjcuMDUuMTkg
MTQ6NTIsIEFuZHJleSBTaGlua2V2aWNoIHdyb3RlOg0KPj4gVmFsZ3JpbmQgZGV0ZWN0cyBtdWx0
aXBsZSBpc3N1ZXMgaW4gUUVNVSBpb3Rlc3RzIHdoZW4gdGhlIG1lbW9yeSBpcw0KPj4gdXNlZCB3
aXRob3V0IGJlaW5nIGluaXRpYWxpemVkLiBWYWxncmluZCBtYXkgZHVtcCBsb3RzIG9mIHVubmVj
ZXNzYXJ5DQo+PiByZXBvcnRzIHdoYXQgbWFrZXMgdGhlIG1lbW9yeSBpc3N1ZSBhbmFseXNpcyBo
YXJkZXIuIFBhcnRpY3VsYXJseSwNCj4+IHRoYXQgaXMgdHJ1ZSBmb3IgdGhlIGFsaWduZWQgYml0
bWFwIGRpcmVjdG9yeSBhbmQgY2FuIGJlIHNlZW4gd2hpbGUNCj4+IHJ1bm5pbmcgdGhlIGlvdGVz
dCAjMTY5LiBQYWRkaW5nIHRoZSBhbGlnbmVkIHNwYWNlIHdpdGggemVyb3MgZWFzZXMNCj4+IHRo
ZSBwYWluLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBTaGlua2V2aWNoIDxhbmRyZXku
c2hpbmtldmljaEB2aXJ0dW96em8uY29tPg0KPj4gLS0tDQo+PiAgIGJsb2NrL3Fjb3cyLWJpdG1h
cC5jIHwgMiArLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkNCj4gDQo+IFRoYW5rcywgYXBwbGllZCB0byBteSBibG9jayBicmFuY2g6DQo+IA0KPiBo
dHRwczovL2dpdC54YW5jbGljLm1vZS9YYW5DbGljL3FlbXUvY29tbWl0cy9icmFuY2gvYmxvY2sN
Cj4gDQo+IE1heA0KPiANCg0KVGhhbmsgeW91IHRvbyENCkFuZHJleQ0KDQo=

