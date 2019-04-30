Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02319C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 23:38:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADFCC20835
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 23:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="doPq3HH2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PCnnGVkg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADFCC20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55176 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLcKv-0003DS-0E
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 19:38:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLcGK-0007aV-Q8
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:34:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLcGJ-0000IX-QC
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:34:12 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:16222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLcB3-00064c-61; Tue, 30 Apr 2019 19:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1556666926; x=1588202926;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-id:content-transfer-encoding: mime-version;
	bh=1SQQMt5THO5pV6WlYA8KAW7IDcB7IjPg+8ezER5gZSg=;
	b=doPq3HH2HCRsCkWVDrsbYQRtNI0ipiDk8NfKdgCDiTdiq3JBCcWbV6ty
	i0OrfXso6GYXZ6UcyHB/fyHBaKzJpMu/n1oD+wcVqpjFyFuMV9aeZxQrW
	G3HTdTsNf4d/o+kICa7IAFSgMt3MFiPbvbqZQwpcyhkXNh3y8Qji2UzUf
	fDcPyXzjvat3EV4cpwBOTmbAEKSFKO6NZbm5A/27kXEDcNea5S0hbEpvw
	k+avM4dxUqzAza7CJd+XulmUsVorinz0PUtaboO3BbRiHuFfk9KXr0wn+
	RTubT60V0ptP6Q4Ck8yBEhqdYbKwOuupCVf/eST7W5n9CiZWyKCMEuPWJ A==;
X-IronPort-AV: E=Sophos;i="5.60,415,1549900800"; d="scan'208";a="107219018"
Received: from mail-bn3nam01lp2055.outbound.protection.outlook.com (HELO
	NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.55])
	by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 07:28:43 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=1SQQMt5THO5pV6WlYA8KAW7IDcB7IjPg+8ezER5gZSg=;
	b=PCnnGVkgfsVVfLNJfgKomcYnO7NUh6/VLhITyuBjQADhsInhdC9QT7MJUpnoxQDifrD2gOXyLyu7X0qwiKoM2jHqG+NgKF7H8/zEsUlz/RB0Ny56IeZKKrZSD8/9nenXZYh6s4EuTY8W6t4y1r39TKE9WFotwuIhAkdLj4CQlTk=
Received: from DM6PR04MB4908.namprd04.prod.outlook.com (20.176.109.81) by
	DM6PR04MB6217.namprd04.prod.outlook.com (20.178.224.88) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1856.10; Tue, 30 Apr 2019 23:28:41 +0000
Received: from DM6PR04MB4908.namprd04.prod.outlook.com
	([fe80::9ba:6028:ae27:7d2]) by DM6PR04MB4908.namprd04.prod.outlook.com
	([fe80::9ba:6028:ae27:7d2%2]) with mapi id 15.20.1835.015;
	Tue, 30 Apr 2019 23:28:41 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2 3/5] hw/usb/dev-mtp: Fix GCC 9 build warning
Thread-Index: AQHU/6xy4BPLUqZ6DUSUqz4nuwVSww==
Date: Tue, 30 Apr 2019 23:28:41 +0000
Message-ID:
 <aeb0e851e027a591eaba99c175011158b1012876.1556666645.git.alistair.francis@wdc.com>
References: <cover.1556666645.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1556666645.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR07CA0013.namprd07.prod.outlook.com
	(2603:10b6:a02:bc::26) To DM6PR04MB4908.namprd04.prod.outlook.com
	(2603:10b6:5:19::17)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb962b1a-19e7-4f29-da9b-08d6cdc3947f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR04MB6217; 
x-ms-traffictypediagnostic: DM6PR04MB6217:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM6PR04MB62176DD291AC7E5D8ABDA158903A0@DM6PR04MB6217.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:669;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(39860400002)(136003)(346002)(376002)(396003)(199004)(189003)(5640700003)(8936002)(6436002)(53936002)(73956011)(316002)(54906003)(14454004)(81156014)(6486002)(6916009)(81166006)(68736007)(8676002)(186003)(26005)(3846002)(66446008)(6116002)(66476007)(64756008)(7736002)(6512007)(66946007)(305945005)(102836004)(2906002)(66556008)(5660300002)(386003)(446003)(6506007)(66066001)(44832011)(2501003)(2351001)(11346002)(50226002)(478600001)(36756003)(486006)(476003)(2616005)(76176011)(4326008)(52116002)(14444005)(99286004)(71190400001)(71200400001)(256004)(118296001)(72206003)(86362001)(25786009);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR04MB6217;
	H:DM6PR04MB4908.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: q7I/epXAdgLWL5cSHcH231z0IYnTSy/YMBN88ZJYLYTTTuli7zv5Sd29xEQcNyj75XsIyChxJE4OV6LVVOEDGn5Wou7hLP2tqEcTmP4B0h4Fw7/sFUG+E7H4YSGqbHAqke7O9r4l3S/3MIEAsWbQflytnxzkr7FlPS45oN+l05SF6m3JlzyzELTeInSgzy8+pflzc3A3WWOHGi+WweSzCdb1A7M9ShxyZYioo+dousimFDQuHlTgkmJXzsyH5pxJJnzJG5QInSCiwuaIY9f96eT6qaQCrXVJs9b4EREPuh1TtsYBArsMhdTMM+o693n0rXtSQg86xWAr3GcWknnBeRM8A/iJdYiCuxnb1GQtn0R3fOK6hN3lKhLy4I96OH6JrR1wZvg/34m0KAicO7mkmwkUzTeaRGsGE6rbpOdVcew=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <D9ADAB462B3E164EAF1B1DA248BF794D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb962b1a-19e7-4f29-da9b-08d6cdc3947f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 23:28:41.5489 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6217
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.154.42
Subject: [Qemu-devel] [PATCH v2 3/5] hw/usb/dev-mtp: Fix GCC 9 build warning
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
	"riku.voipio@iki.fi" <riku.voipio@iki.fi>,
	"laurent@vivier.eu" <laurent@vivier.eu>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"kraxel@redhat.com" <kraxel@redhat.com>,
	"alistair23@gmail.com" <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430232841.dUpXAeIdRQQI2776KWTqafecoHUEYrTqWEio2W8K8vs@z>

Rml4IHRoaXMgd2FybmluZyB3aXRoIEdDQyA5IG9uIEZlZG9yYSAzMDoNCmh3L3VzYi9kZXYtbXRw
LmM6MTcxNTozNjogZXJyb3I6IHRha2luZyBhZGRyZXNzIG9mIHBhY2tlZCBtZW1iZXIgb2Yg4oCY
c3RydWN0IDxhbm9ueW1vdXM+4oCZIG1heSByZXN1bHQgaW4gYW4gdW5hbGlnbmVkIHBvaW50ZXIg
dmFsdWUgWy1XZXJyb3I9YWRkcmVzcy1vZi1wYWNrZWQtbWVtYmVyXQ0KIDE3MTUgfCAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgZGF0YXNldC0+ZmlsZW5hbWUpOw0KICAgICAgfCAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfn5+fn5+fl5+fn5+fn5+fn4NCg0KU2lnbmVkLW9mZi1ieTog
QWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KLS0tDQogaHcvdXNi
L2Rldi1tdHAuYyB8IDEzICsrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0
aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvdXNiL2Rldi1tdHAuYyBiL2h3L3VzYi9kZXYtbXRw
LmMNCmluZGV4IDk5NTQ4YjAxMmQuLjgyMzNiZWFjYWIgMTAwNjQ0DQotLS0gYS9ody91c2IvZGV2
LW10cC5jDQorKysgYi9ody91c2IvZGV2LW10cC5jDQpAQCAtMTcxMSw5ICsxNzExLDIyIEBAIHN0
YXRpYyB2b2lkIHVzYl9tdHBfd3JpdGVfbWV0YWRhdGEoTVRQU3RhdGUgKnMsIHVpbnQ2NF90IGRs
ZW4pDQogICAgIGFzc2VydCghcy0+d3JpdGVfcGVuZGluZyk7DQogICAgIGFzc2VydChwICE9IE5V
TEwpOw0KIA0KKy8qDQorICogV2UgYXJlIGFib3V0IHRvIGFjY2VzcyBhIHBhY2tlZCBzdHJ1Y3Qu
IFdlIGFyZSBjb25maWRlbnQgdGhhdCB0aGUgcG9pbnRlcg0KKyAqIGFkZHJlc3Mgd29uJ3QgYmUg
dW5hbGlnbmVkLCBzbyB3ZSBpZ25vcmUgR0NDIHdhcm5pbmdzLg0KKyAqLw0KKyNpZiBkZWZpbmVk
KENPTkZJR19QUkFHTUFfRElBR05PU1RJQ19BVkFJTEFCTEUpICYmIFFFTVVfR05VQ19QUkVSRVEo
OSwgMCkNCisjcHJhZ21hIEdDQyBkaWFnbm9zdGljIHB1c2gNCisjcHJhZ21hIEdDQyBkaWFnbm9z
dGljIGlnbm9yZWQgIi1XYWRkcmVzcy1vZi1wYWNrZWQtbWVtYmVyIg0KKyNlbmRpZg0KKw0KICAg
ICBmaWxlbmFtZSA9IHV0ZjE2X3RvX3N0cihNSU4oZGF0YXNldC0+bGVuZ3RoLCBmaWxlbmFtZV9j
aGFycyksDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRhdGFzZXQtPmZpbGVuYW1lKTsN
CiANCisjaWYgZGVmaW5lZChDT05GSUdfUFJBR01BX0RJQUdOT1NUSUNfQVZBSUxBQkxFKSAmJiBR
RU1VX0dOVUNfUFJFUkVRKDksIDApDQorI3ByYWdtYSBHQ0MgZGlhZ25vc3RpYyBwb3ANCisjZW5k
aWYNCisNCiAgICAgaWYgKHN0cmNocihmaWxlbmFtZSwgJy8nKSkgew0KICAgICAgICAgdXNiX210
cF9xdWV1ZV9yZXN1bHQocywgUkVTX1BBUkFNRVRFUl9OT1RfU1VQUE9SVEVELCBkLT50cmFucywN
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAsIDAsIDAsIDApOw0KLS0gDQoyLjIxLjAN
Cg0K

