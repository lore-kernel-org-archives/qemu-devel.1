Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8F5C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 23:38:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3A9D20835
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 23:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cfzvSwDC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mwCBR3p3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A9D20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55174 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLcKj-00034x-0H
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 19:38:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLcGI-0007YA-SS
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLcGH-0000HQ-UE
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:34:10 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:16235)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLcBE-000697-3e; Tue, 30 Apr 2019 19:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1556666936; x=1588202936;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-id:content-transfer-encoding: mime-version;
	bh=/PI+FLHUDutGpLAfkQ4VDPA7/rpbi7ZyRYW0VU06X3g=;
	b=cfzvSwDCJlwLFi4gobJla6mqQNgvHjsuZ6z1GaSGNeIUjC89qgfdFbPn
	yVXbclJQImTJA3LwUYaa+dhPLO+W+cA+jcrNjt5/Oc1e/Hhkt6oIM1HZM
	BLzBL2BpoY6bew67NzEbM6TjgqCcgj0NchOtBsh+FEj3m/Qe64INpemWw
	M0uKwZWpF3qTE9RiRjNpqbVCZLijg3PVhpWBAn8wi67idaWBUNoNwR+T5
	6mbm0aiqUjeuqgf9PcuEJkVzTWTYBHo6Hrbh1LLrPtM0fE+DPbGVSrr7L
	T8e2KUgJaFmd7II3nHb9/EaheV84BvVwmJnNCJ3R/90QEE0sOA6xno4Yz g==;
X-IronPort-AV: E=Sophos;i="5.60,415,1549900800"; d="scan'208";a="107219025"
Received: from mail-bn3nam01lp2055.outbound.protection.outlook.com (HELO
	NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.55])
	by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 07:28:53 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=/PI+FLHUDutGpLAfkQ4VDPA7/rpbi7ZyRYW0VU06X3g=;
	b=mwCBR3p3cKWPbpZYyQuPJhvsTOZWIDGSFp/iViPEtQMONE370L1gPNtj2yu9G6pIOlCCCC+3V9IpXM/pittdU04bUrKws7kmgoD959coboYGq5IaHpC2S6DKKwuadMxU1gF3yvfJX7b5liTcwsVXRqQuwKYoHAAO2nj6L7eFOAs=
Received: from DM6PR04MB4908.namprd04.prod.outlook.com (20.176.109.81) by
	DM6PR04MB6217.namprd04.prod.outlook.com (20.178.224.88) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1856.10; Tue, 30 Apr 2019 23:28:51 +0000
Received: from DM6PR04MB4908.namprd04.prod.outlook.com
	([fe80::9ba:6028:ae27:7d2]) by DM6PR04MB4908.namprd04.prod.outlook.com
	([fe80::9ba:6028:ae27:7d2%2]) with mapi id 15.20.1835.015;
	Tue, 30 Apr 2019 23:28:51 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2 4/5] linux-user/uname: Fix GCC 9 build warnings
Thread-Index: AQHU/6x4Qb+c+VmCSUK/Sp9zhg519A==
Date: Tue, 30 Apr 2019 23:28:51 +0000
Message-ID:
 <14aab381eaa678eca875d0b8bd456feb22a21bd8.1556666645.git.alistair.francis@wdc.com>
References: <cover.1556666645.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1556666645.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR01CA0049.prod.exchangelabs.com (2603:10b6:a03:94::26)
	To DM6PR04MB4908.namprd04.prod.outlook.com
	(2603:10b6:5:19::17)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 581cfe8c-5c07-4223-f550-08d6cdc39a59
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR04MB6217; 
x-ms-traffictypediagnostic: DM6PR04MB6217:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM6PR04MB62179F7141AA1531AE11B13D903A0@DM6PR04MB6217.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(39860400002)(136003)(346002)(376002)(396003)(199004)(189003)(5640700003)(8936002)(6436002)(53936002)(73956011)(316002)(54906003)(14454004)(81156014)(6486002)(6916009)(81166006)(68736007)(8676002)(186003)(26005)(3846002)(66446008)(6116002)(66476007)(64756008)(7736002)(6512007)(66946007)(305945005)(102836004)(2906002)(66556008)(5660300002)(386003)(446003)(6506007)(66066001)(44832011)(2501003)(2351001)(11346002)(50226002)(478600001)(36756003)(486006)(476003)(2616005)(76176011)(4326008)(52116002)(14444005)(99286004)(71190400001)(71200400001)(256004)(118296001)(72206003)(86362001)(25786009);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR04MB6217;
	H:DM6PR04MB4908.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Yk3TlvrK4dOt+zqBO9ylfCV6rVr9gitrHnqsu+qq+lOHBTUIdB/EbFZWH9Aa4h4p6eQUjHl5lXXoy9sp0ZODoaTYYH68TsIck3NcVDqY2jHrjbxM2bJeWV2USlTs65NV29q8cVdBfmeTz1aC2ee2ZYuZwKVlXx+EMvprvoxI0eCNIymbeTejZSNCQcnGvs8AyN6aCFxkJWGsAtghQyCeBO+cmIfwcqm/UQmWQPNZljoGvsxRjQo6Ylmfg2oIVYAgxPbZyb2R4P0RanqPeTx3vH5MIZk3k3p8YjFzUKFu3VN7l4giIvM0pWM4qdS/NIE+/kjJQ1PEy12mnaQTrJtzinq7xTVSngf7Y5IV8W4yQ6dAjEWW3j3r2jRWv2RBI/oSTHBEbhh2WaxShAobpzf98gD4OPHIjMs6wv0fgAS6vJQ=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <8DD885F69E374B48B23CF9E3994BDC7C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 581cfe8c-5c07-4223-f550-08d6cdc39a59
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 23:28:51.3889 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6217
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.154.42
Subject: [Qemu-devel] [PATCH v2 4/5] linux-user/uname: Fix GCC 9 build
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
Message-ID: <20190430232851.oeW634oUE2s0g0yhlaZqSpS98ZDRC6TsfRlDQSwzr94@z>

Rml4IHRoaXMgd2FybmluZyB3aGVuIGJ1aWxkaW5nIHdpdGggR0NDOSBvbiBGZWRvcmEgMzA6DQpJ
biBmdW5jdGlvbiDigJhzdHJuY3B54oCZLA0KICAgIGlubGluZWQgZnJvbSDigJhzeXNfdW5hbWXi
gJkgYXQgL2hvbWUvYWxpc3RhaXIvcWVtdS9saW51eC11c2VyL3VuYW1lLmM6OTQ6MzoNCi91c3Iv
aW5jbHVkZS9iaXRzL3N0cmluZ19mb3J0aWZpZWQuaDoxMDY6MTA6IGVycm9yOiDigJhfX2J1aWx0
aW5fc3RybmNweeKAmSBvdXRwdXQgbWF5IGJlIHRydW5jYXRlZCBjb3B5aW5nIDY0IGJ5dGVzIGZy
b20gYSBzdHJpbmcgb2YgbGVuZ3RoIDY0IFstV2Vycm9yPXN0cmluZ29wLXRydW5jYXRpb25dDQog
IDEwNiB8ICAgcmV0dXJuIF9fYnVpbHRpbl9fX3N0cm5jcHlfY2hrIChfX2Rlc3QsIF9fc3JjLCBf
X2xlbiwgX19ib3MgKF9fZGVzdCkpOw0KICAgICAgfCAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KDQpTaWduZWQt
b2ZmLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+DQotLS0N
CiBsaW51eC11c2VyL3VuYW1lLmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9saW51eC11c2VyL3VuYW1lLmMgYi9s
aW51eC11c2VyL3VuYW1lLmMNCmluZGV4IDMxM2I3OWRiYWQuLjJmYzYwOTZhNWIgMTAwNjQ0DQot
LS0gYS9saW51eC11c2VyL3VuYW1lLmMNCisrKyBiL2xpbnV4LXVzZXIvdW5hbWUuYw0KQEAgLTcz
LDcgKzczLDcgQEAgY29uc3QgY2hhciAqY3B1X3RvX3VuYW1lX21hY2hpbmUodm9pZCAqY3B1X2Vu
dikNCiAjZGVmaW5lIENPUFlfVVRTTkFNRV9GSUVMRChkZXN0LCBzcmMpIFwNCiAgIGRvIHsgXA0K
ICAgICAgIC8qIF9fTkVXX1VUU19MRU4gZG9lc24ndCBpbmNsdWRlIHRlcm1pbmF0aW5nIG51bGwg
Ki8gXA0KLSAgICAgICh2b2lkKSBzdHJuY3B5KChkZXN0KSwgKHNyYyksIF9fTkVXX1VUU19MRU4p
OyBcDQorICAgICAgKHZvaWQpIG1lbWNweSgoZGVzdCksIChzcmMpLCBNSU4oc3RybGVuKHNyYyks
IF9fTkVXX1VUU19MRU4pKTsgXA0KICAgICAgIChkZXN0KVtfX05FV19VVFNfTEVOXSA9ICdcMCc7
IFwNCiAgIH0gd2hpbGUgKDApDQogDQotLSANCjIuMjEuMA0KDQo=

