Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1503C282E1
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 02:26:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70DD72183F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 02:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JH18NsZO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="m57MvPSv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70DD72183F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35772 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHfhn-0004k0-AQ
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 22:26:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHffz-0003O9-2o
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:24:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHffY-0002GB-Rv
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:23:57 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:5759)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHffX-0002Du-MO; Fri, 19 Apr 2019 22:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1555727074; x=1587263074;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-transfer-encoding:mime-version;
	bh=rIKrYt7w8dvN5WsBNs/xhO+LKNL7nnzJmFQzezzMR5s=;
	b=JH18NsZOddT/ycyCX4PjyfC0xkCpazTJlsZ6ZPq28jRxRutmK9cSch/E
	9z+wrApF62EWN0HXa0xNKh+w9ZM338+FeAGx19CPus5kz4Lf+7iwez/qM
	GgMBVzYnn6ku95RhcDXYx/mX1r4YhOXkJxIeEBVprf/kLhVVShog03/Rf
	WPVR5sHS+docKBmVUyS80ctfFz5rQGWu/+pnaOAPCTitd4B7zvas41ZoC
	2dKiNbbOEbCY0x26tFx/A28QXoDsqUr1DOBt+tigVI4Qwz+5jhlfn8wPd
	Q5nOp185u4G67s9s4zemgce5AYWOemkr4L3ONF1rbi0U+xN36pyj1JwDt Q==;
X-IronPort-AV: E=Sophos;i="5.60,372,1549900800"; d="scan'208";a="205476495"
Received: from mail-by2nam03lp2051.outbound.protection.outlook.com (HELO
	NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.51])
	by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2019 10:24:32 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=rIKrYt7w8dvN5WsBNs/xhO+LKNL7nnzJmFQzezzMR5s=;
	b=m57MvPSvqLBMRqSwYLk0VVTmJENPkHooV1vTn1F7MCOloFOa88oDALnJFupOnnVCamh7o3hQvSyA7gAylzRj9yj8OhD47kOP/sizarEovkHzmaC0tnHEOdg2L1ePz9EYBHHhbFKUETyG7DCOHDFtrR8yCGhxocA3AHnuQBJArGk=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB3943.namprd04.prod.outlook.com (52.135.215.18) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.12; Sat, 20 Apr 2019 02:23:53 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c]) by BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c%4]) with mapi id 15.20.1813.011;
	Sat, 20 Apr 2019 02:23:53 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
	<qemu-riscv@nongnu.org>
Thread-Topic: [PATCH v1 2/6] riscv: virt: Allow specifying a CPU via
	commandline
Thread-Index: AQHU9yAZenMWYgTtrUWdN4w/lJrkWg==
Date: Sat, 20 Apr 2019 02:23:53 +0000
Message-ID:
 <6480a4d099d59afc8103313a3ac51262fac43cbc.1555726824.git.alistair.francis@wdc.com>
References: <cover.1555726824.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1555726824.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR02CA0042.namprd02.prod.outlook.com
	(2603:10b6:a03:54::19) To BYAPR04MB4901.namprd04.prod.outlook.com
	(2603:10b6:a03:4f::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89293068-841e-42f2-301c-08d6c5373b62
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB3943; 
x-ms-traffictypediagnostic: BYAPR04MB3943:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB3943C5A01641D4708457183190200@BYAPR04MB3943.namprd04.prod.outlook.com>
x-forefront-prvs: 0013079544
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(376002)(396003)(136003)(39860400002)(346002)(199004)(189003)(14454004)(446003)(2501003)(6486002)(53936002)(6436002)(50226002)(97736004)(5660300002)(4326008)(305945005)(71200400001)(86362001)(81166006)(8936002)(7736002)(8676002)(71190400001)(73956011)(68736007)(6512007)(25786009)(66946007)(81156014)(66446008)(64756008)(66476007)(66556008)(2906002)(256004)(14444005)(6116002)(3846002)(36756003)(478600001)(72206003)(99286004)(44832011)(52116002)(66066001)(76176011)(110136005)(386003)(6506007)(102836004)(26005)(186003)(316002)(118296001)(54906003)(2616005)(486006)(476003)(11346002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB3943;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qEJ+8C5g0vOPgPMdKgmZBnyk393EhD4E83pLwt4J0a68thru3o50pj0oUikeH5dudt7k6X61HoMCrU+Xo8lW5bGhM42ngPqNyVjn+itm6N9wSFIKVe9tg6fKCHRYOVK6DxV6W7MhpBo/mwYI1O4KqUfZpq5HxjXE0BpBpIkc9W4ZqbF2uxCKheh2T7yAqBzr9PbXK5HkJ4dPf9cz84iVd7mM3dfrfyonA+Ln+igkDce2MPYXf5rcb/P0C+W6flmE2zIYVXcEmgiR39nbkM3luwPpNMDbRQUQORjWbuoJq3J00y+lz9UgDQCwNh/tGbQWnenYmnKVxGxzUI/F5oNKj6QFdprY5wnlolEA9dZcvJehlEh5jW4yUbxYcNcECeUVKAQRxKXF8uULEmw1/0TB03IXpSe1DCoCLKuQNnDkIWM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89293068-841e-42f2-301c-08d6c5373b62
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2019 02:23:53.2549 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3943
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 68.232.143.124
Subject: [Qemu-devel] [PATCH v1 2/6] riscv: virt: Allow specifying a CPU via
 commandline
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
Cc: "alistair23@gmail.com" <alistair23@gmail.com>,
	"palmer@sifive.com" <palmer@sifive.com>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190420022353.8ThjxKQWN_4ogSmqbTOAt7KSTVzaKaf4V75SSMTXiA8@z>

U2lnbmVkLW9mZi1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29t
Pg0KUmV2aWV3ZWQtYnk6IElnb3IgTWFtbWVkb3YgPGltYW1tZWRvQHJlZGhhdC5jb20+DQotLS0N
CiBody9yaXNjdi92aXJ0LmMgfCAzICsrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2h3L3Jpc2N2L3ZpcnQuYyBiL2h3L3Jp
c2N2L3ZpcnQuYw0KaW5kZXggZmM0YzZiMzA2ZS4uNWIyNWYwMjhhZCAxMDA2NDQNCi0tLSBhL2h3
L3Jpc2N2L3ZpcnQuYw0KKysrIGIvaHcvcmlzY3YvdmlydC5jDQpAQCAtNDAwLDcgKzQwMCw3IEBA
IHN0YXRpYyB2b2lkIHJpc2N2X3ZpcnRfYm9hcmRfaW5pdChNYWNoaW5lU3RhdGUgKm1hY2hpbmUp
DQogICAgIC8qIEluaXRpYWxpemUgU09DICovDQogICAgIG9iamVjdF9pbml0aWFsaXplX2NoaWxk
KE9CSkVDVChtYWNoaW5lKSwgInNvYyIsICZzLT5zb2MsIHNpemVvZihzLT5zb2MpLA0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBUWVBFX1JJU0NWX0hBUlRfQVJSQVksICZlcnJvcl9hYm9y
dCwgTlVMTCk7DQotICAgIG9iamVjdF9wcm9wZXJ0eV9zZXRfc3RyKE9CSkVDVCgmcy0+c29jKSwg
VklSVF9DUFUsICJjcHUtdHlwZSIsDQorICAgIG9iamVjdF9wcm9wZXJ0eV9zZXRfc3RyKE9CSkVD
VCgmcy0+c29jKSwgbWFjaGluZS0+Y3B1X3R5cGUsICJjcHUtdHlwZSIsDQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICZlcnJvcl9hYm9ydCk7DQogICAgIG9iamVjdF9wcm9wZXJ0eV9zZXRf
aW50KE9CSkVDVCgmcy0+c29jKSwgc21wX2NwdXMsICJudW0taGFydHMiLA0KICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAmZXJyb3JfYWJvcnQpOw0KQEAgLTUyNiw2ICs1MjYsNyBAQCBzdGF0
aWMgdm9pZCByaXNjdl92aXJ0X2JvYXJkX21hY2hpbmVfaW5pdChNYWNoaW5lQ2xhc3MgKm1jKQ0K
ICAgICBtYy0+ZGVzYyA9ICJSSVNDLVYgVmlydElPIEJvYXJkIChQcml2aWxlZ2VkIElTQSB2MS4x
MCkiOw0KICAgICBtYy0+aW5pdCA9IHJpc2N2X3ZpcnRfYm9hcmRfaW5pdDsNCiAgICAgbWMtPm1h
eF9jcHVzID0gODsgLyogaGFyZGNvZGVkIGxpbWl0IGluIEJCTCAqLw0KKyAgICBtYy0+ZGVmYXVs
dF9jcHVfdHlwZSA9IFZJUlRfQ1BVOw0KIH0NCiANCiBERUZJTkVfTUFDSElORSgidmlydCIsIHJp
c2N2X3ZpcnRfYm9hcmRfbWFjaGluZV9pbml0KQ0KLS0gDQoyLjIxLjANCg0K

