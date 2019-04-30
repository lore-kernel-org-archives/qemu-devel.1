Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82526C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 20:13:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3522C20652
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 20:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nihU214D";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="j4lhoz2f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3522C20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52767 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLZ7j-0005Hm-Eu
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 16:13:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLZ3m-0002LD-RG
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:09:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLZ3l-00070G-PL
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:09:02 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:40728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLZ3j-0006x4-AQ; Tue, 30 Apr 2019 16:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1556654961; x=1588190961;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-id:content-transfer-encoding: mime-version;
	bh=3hk22IXiPanYCVCAORHPd9Ou1I5+RlgHyiylTOqL6Fc=;
	b=nihU214Da6cvVraf5J9g9WnsjeDekSNoRyaJcXnYqTammYCTQ9mkXwIS
	GG4oGhd7w3HgUXwgAzT9ATosbUaB0V+UWC9by3DHaBBuuKabruEUS7eHa
	xcMGJdjX8KIDwY0GimIfKFgMMdDkicwVOmlSGNuiG4T6nH2ofmjvcEzka
	/RzpMDroTXcD5up7a2neGHMRFL/cZCZyjXdBAKbtzUWkXc6ib49B40cFh
	CrwTJp2rpetv6mRdkMlqvK1ltHpC8fzRhRLC2SFuUr25bGVJk6aUsu/wj
	/KOtPQmBaCij9hM4SOWs0wnC+OO3Caz5rUVn8fPBi4OFXokh2LBkrNdZL Q==;
X-IronPort-AV: E=Sophos;i="5.60,414,1549900800"; d="scan'208";a="206404325"
Received: from mail-sn1nam04lp2059.outbound.protection.outlook.com (HELO
	NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.59])
	by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 04:09:19 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=3hk22IXiPanYCVCAORHPd9Ou1I5+RlgHyiylTOqL6Fc=;
	b=j4lhoz2fhTC7xzgAlZw42uTrM1K8lQyUalbFDZqLelOVijileO2rwXgj7MsesLDzVgYYpLkB9bgHLtyPAYojOHPWkDiG4lK8rz6cv+Hp0KZfU2K9wX89WqW2pUBBwwjJkEqTTd5t0zSpQL0H3MIQRsHi9R5K0alUZx75YdBDofk=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB5672.namprd04.prod.outlook.com (20.179.57.22) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1856.10; Tue, 30 Apr 2019 20:08:56 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::4d89:bbf8:952c:3d66]) by
	BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::4d89:bbf8:952c:3d66%5]) with mapi id 15.20.1835.018;
	Tue, 30 Apr 2019 20:08:56 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v1 1/5] util/qemu-sockets: Fix GCC 9 build warnings
Thread-Index: AQHU/5CKMl0GweNxUkGP2/9h0Xa6UA==
Date: Tue, 30 Apr 2019 20:08:56 +0000
Message-ID:
 <81a342ee886cf0f63cdbfc8573b14dd2d41de42d.1556650594.git.alistair.francis@wdc.com>
References: <cover.1556650594.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1556650594.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR01CA0021.prod.exchangelabs.com (2603:10b6:a02:80::34)
	To BYAPR04MB4901.namprd04.prod.outlook.com
	(2603:10b6:a03:4f::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b89b123-5382-46d6-108b-08d6cda7aca4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB5672; 
x-ms-traffictypediagnostic: BYAPR04MB5672:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB56725DDF071D9370DABB7198903A0@BYAPR04MB5672.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(346002)(396003)(366004)(376002)(39860400002)(189003)(199004)(99286004)(4326008)(50226002)(71190400001)(71200400001)(7736002)(305945005)(316002)(14444005)(256004)(44832011)(186003)(36756003)(8936002)(6436002)(54906003)(2501003)(11346002)(102836004)(2906002)(26005)(6486002)(446003)(486006)(476003)(2616005)(5660300002)(8676002)(25786009)(6116002)(81156014)(81166006)(72206003)(3846002)(86362001)(66066001)(478600001)(73956011)(6512007)(66556008)(118296001)(66446008)(14454004)(66476007)(66946007)(64756008)(68736007)(53936002)(76176011)(97736004)(52116002)(2351001)(386003)(6506007)(5640700003)(6916009);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5672;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2O42GKT+to90woIdiQOfhNgavJ++bevtANJIgysVRLEVri3fcJvkyQNQ8EVZVT/K5riPp9k09mcfXE+sD+c4EY5EbcQBhQkJXzI9bePbWYr0qXxq6giIorfol1I530EChBOCVWlJtYCWyYTugIX3XQ25VTcjyVBwDEXv0YHGfQcRy0aNfeh1cpqJIl+zg8qkhpjUs7j35ybyT6hAibMsG1HO6LnfdAcaMllPIUs0e0nkiM9FeVA3Ms4RsrrM18QybPM175zjvrv4ztwofG50RlOsnIINYOs2IP6ZdGegRN1AfJcwXlxweNOz9POZrMDig3SH+gMkz8C5nd7ERk7i2q+VpvzaGyiwOqyFHPwpd7JYVp09bU0jnDuM3TTMidyAWwwV7opieGbAX2IHy3PR+1QvHUJB4Mj9QpPMM3H08dQ=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <488EE58CF61ABB40A8A18DC96C8835D1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b89b123-5382-46d6-108b-08d6cda7aca4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 20:08:56.2261 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5672
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 68.232.143.124
Subject: [Qemu-devel] [PATCH v1 1/5] util/qemu-sockets: Fix GCC 9 build
 warnings
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
Message-ID: <20190430200856.H47Ok27x8FmciXI29S-Mk7VgG-PDV21r5A57WRz2sl8@z>

Rml4IHRoaXMgd2FybmluZyB3aGVuIGJ1aWxkaW5nIHdpdGggR0NDOSBvbiBGZWRvcmEgMzA6DQpJ
biBmdW5jdGlvbiDigJhzdHJuY3B54oCZLA0KICAgIGlubGluZWQgZnJvbSDigJh1bml4X2Nvbm5l
Y3Rfc2FkZHIuaXNyYS4w4oCZIGF0IHV0aWwvcWVtdS1zb2NrZXRzLmM6OTI1OjU6DQovdXNyL2lu
Y2x1ZGUvYml0cy9zdHJpbmdfZm9ydGlmaWVkLmg6MTA2OjEwOiBlcnJvcjog4oCYX19idWlsdGlu
X3N0cm5jcHnigJkgc3BlY2lmaWVkIGJvdW5kIDEwOCBlcXVhbHMgZGVzdGluYXRpb24gc2l6ZSBb
LVdlcnJvcj1zdHJpbmdvcC10cnVuY2F0aW9uXQ0KICAxMDYgfCAgIHJldHVybiBfX2J1aWx0aW5f
X19zdHJuY3B5X2NoayAoX19kZXN0LCBfX3NyYywgX19sZW4sIF9fYm9zIChfX2Rlc3QpKTsNCiAg
ICAgIHwgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn4NCkluIGZ1bmN0aW9uIOKAmHN0cm5jcHnigJksDQogICAgaW5s
aW5lZCBmcm9tIOKAmHVuaXhfbGlzdGVuX3NhZGRyLmlzcmEuMOKAmSBhdCB1dGlsL3FlbXUtc29j
a2V0cy5jOjg4MDo1Og0KDQpTaWduZWQtb2ZmLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFp
ci5mcmFuY2lzQHdkYy5jb20+DQotLS0NCiB1dGlsL3FlbXUtc29ja2V0cy5jIHwgNCArKy0tDQog
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAt
LWdpdCBhL3V0aWwvcWVtdS1zb2NrZXRzLmMgYi91dGlsL3FlbXUtc29ja2V0cy5jDQppbmRleCA5
NzA1MDUxNjkwLi40MzIyNjUyNDI4IDEwMDY0NA0KLS0tIGEvdXRpbC9xZW11LXNvY2tldHMuYw0K
KysrIGIvdXRpbC9xZW11LXNvY2tldHMuYw0KQEAgLTg3Nyw3ICs4NzcsNyBAQCBzdGF0aWMgaW50
IHVuaXhfbGlzdGVuX3NhZGRyKFVuaXhTb2NrZXRBZGRyZXNzICpzYWRkciwNCiANCiAgICAgbWVt
c2V0KCZ1biwgMCwgc2l6ZW9mKHVuKSk7DQogICAgIHVuLnN1bl9mYW1pbHkgPSBBRl9VTklYOw0K
LSAgICBzdHJuY3B5KHVuLnN1bl9wYXRoLCBwYXRoLCBzaXplb2YodW4uc3VuX3BhdGgpKTsNCisg
ICAgc3RybmNweSh1bi5zdW5fcGF0aCwgcGF0aCwgc2l6ZW9mKHVuLnN1bl9wYXRoKSAtIDEpOw0K
IA0KICAgICBpZiAoYmluZChzb2NrLCAoc3RydWN0IHNvY2thZGRyKikgJnVuLCBzaXplb2YodW4p
KSA8IDApIHsNCiAgICAgICAgIGVycm9yX3NldGdfZXJybm8oZXJycCwgZXJybm8sICJGYWlsZWQg
dG8gYmluZCBzb2NrZXQgdG8gJXMiLCBwYXRoKTsNCkBAIC05MjIsNyArOTIyLDcgQEAgc3RhdGlj
IGludCB1bml4X2Nvbm5lY3Rfc2FkZHIoVW5peFNvY2tldEFkZHJlc3MgKnNhZGRyLCBFcnJvciAq
KmVycnApDQogDQogICAgIG1lbXNldCgmdW4sIDAsIHNpemVvZih1bikpOw0KICAgICB1bi5zdW5f
ZmFtaWx5ID0gQUZfVU5JWDsNCi0gICAgc3RybmNweSh1bi5zdW5fcGF0aCwgc2FkZHItPnBhdGgs
IHNpemVvZih1bi5zdW5fcGF0aCkpOw0KKyAgICBzdHJuY3B5KHVuLnN1bl9wYXRoLCBzYWRkci0+
cGF0aCwgc2l6ZW9mKHVuLnN1bl9wYXRoKSAtIDEpOw0KIA0KICAgICAvKiBjb25uZWN0IHRvIHBl
ZXIgKi8NCiAgICAgZG8gew0KLS0gDQoyLjIxLjANCg0K

