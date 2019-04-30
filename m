Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF399C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 23:33:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8343D2087B
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 23:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LR1CuH+G";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fvFYF4D0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8343D2087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55078 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLcFn-0006be-KN
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 19:33:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLcBb-0003RR-Ia
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:29:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLcBZ-0006Oi-Lj
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:29:19 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:16243)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLcBU-0006HX-T2; Tue, 30 Apr 2019 19:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1556666953; x=1588202953;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-id:content-transfer-encoding: mime-version;
	bh=tXUTsIRiuDGCHyauZRrtG/QeDpa6BCwT3JY/YNrnlkw=;
	b=LR1CuH+GsDF8jqwuIISnvB7Q6QLzqeAyejAa5CpXo9OOvN3ONrc8B/yv
	el3//aEgCuGE09NOI4n0LkwX99PS9xcmnQkw+qT/SWFgPNuxsLC4KyUKH
	bNuKevQClFzydyRmBWTOYMRNr96exbIIPs7HowxvfiHXAU4UYTnq4pMB2
	/pAFE6AcbRzuS525n/L3DE6l8ZW5yoxmejpVAMVbxH+AfCBti8icfyUek
	AbzzJnAGk4r/ETPZ8cAQQWMP5oY3EzEK1imnEL/kIynDZH9SjWkNKblIf
	/6nGyEdcVs7nWhRqekJhEcqYY2q62CQf+WzzwzziAmn3sUDKB7iUtbjPi w==;
X-IronPort-AV: E=Sophos;i="5.60,415,1549900800"; d="scan'208";a="107219031"
Received: from mail-bn3nam01lp2050.outbound.protection.outlook.com (HELO
	NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.50])
	by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 07:29:04 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=tXUTsIRiuDGCHyauZRrtG/QeDpa6BCwT3JY/YNrnlkw=;
	b=fvFYF4D0TP2zit7ldylSVoOesae30ZzrURA+MkW8xKP4zyB11eKamEdawgAqk3OvHGvZ1o++2hjVTMkkGeeuUrfgKiuK36QnZql6kTOhybmnE8uoxU389Ar/AdsmM45NjZuQta5zJWHXZy+0K30K/T96y9wFoO5iczckOj+xdTs=
Received: from DM6PR04MB4908.namprd04.prod.outlook.com (20.176.109.81) by
	DM6PR04MB6217.namprd04.prod.outlook.com (20.178.224.88) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1856.10; Tue, 30 Apr 2019 23:29:01 +0000
Received: from DM6PR04MB4908.namprd04.prod.outlook.com
	([fe80::9ba:6028:ae27:7d2]) by DM6PR04MB4908.namprd04.prod.outlook.com
	([fe80::9ba:6028:ae27:7d2%2]) with mapi id 15.20.1835.015;
	Tue, 30 Apr 2019 23:29:01 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2 5/5] linux-user/elfload: Fix GCC 9 build warnings
Thread-Index: AQHU/6x+xmB4VEre5EW2C7se/oJgig==
Date: Tue, 30 Apr 2019 23:29:01 +0000
Message-ID:
 <c4d2b1de9efadcf1c900b91361af9302823a72a9.1556666645.git.alistair.francis@wdc.com>
References: <cover.1556666645.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1556666645.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR07CA0003.namprd07.prod.outlook.com
	(2603:10b6:a02:bc::16) To DM6PR04MB4908.namprd04.prod.outlook.com
	(2603:10b6:5:19::17)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ea03c69-e3cd-41cb-c2d0-08d6cdc3a07a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR04MB6217; 
x-ms-traffictypediagnostic: DM6PR04MB6217:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM6PR04MB6217C5346A2F304F05263438903A0@DM6PR04MB6217.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:773;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(979002)(366004)(39860400002)(136003)(346002)(376002)(396003)(199004)(189003)(5640700003)(8936002)(6436002)(53936002)(73956011)(316002)(54906003)(14454004)(81156014)(6486002)(6916009)(81166006)(68736007)(8676002)(186003)(26005)(3846002)(66446008)(6116002)(66476007)(64756008)(7736002)(6512007)(66946007)(305945005)(102836004)(2906002)(66556008)(5660300002)(386003)(446003)(6506007)(66066001)(44832011)(2501003)(2351001)(11346002)(50226002)(478600001)(36756003)(486006)(476003)(2616005)(76176011)(4326008)(52116002)(14444005)(99286004)(71190400001)(71200400001)(256004)(118296001)(72206003)(86362001)(25786009)(969003)(989001)(999001)(1009001)(1019001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR04MB6217;
	H:DM6PR04MB4908.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QcvX4ELAxCo1eXfQlDtmxxfhTJn6io18fMIZL7DTqZ0L31MCiZen/OFqmQzGnUlTXdDAHsIlvx1ImNtqDZ2CzGRxjDV2bdnMW99QaNLO9rUoNrupIgapf5BY0lalGuktQLxIlJk7oOblvPPaVd+vB7CWXuidym0c6+W+681SCEfT7/DqWpe1gKB87cfFBjtMsk7Ag3n+e2y7YFso7nfGD/ColbvxmlbqzcC/4Y7kh2T1iXA4jC1cr5MlXc+1p0AAYMp0hJUa+Og90JlS5ujekRBSi59xFAcMaEB2gxQx8tJq48NvH7vPysw7nSN5Mmv1ohNDLcCR1WATDtGXAsoEiInNe8ovLd3Y6HwPO8kJopBPWXtqACayjaEN69MkTclJSejgGWRCJLq9Vpl2fwaJawZ30S2rWg+cHR62KfOI5Ds=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <667FC14ACE4DD1458B8B48476394801A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea03c69-e3cd-41cb-c2d0-08d6cdc3a07a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 23:29:01.6462 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6217
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.154.42
Subject: [Qemu-devel] [PATCH v2 5/5] linux-user/elfload: Fix GCC 9 build
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
Message-ID: <20190430232901.MfO6loOw6bPzX-6pqUDuuL6lZDuZnkFInK2b4R42jN4@z>

Rml4IHRoaXMgd2FybmluZyB3aGVuIGJ1aWxkaW5nIHdpdGggR0NDOSBvbiBGZWRvcmEgMzA6DQpJ
biBmdW5jdGlvbiDigJhzdHJuY3B54oCZLA0KICAgIGlubGluZWQgZnJvbSDigJhmaWxsX3BzaW5m
b+KAmSBhdCAvaG9tZS9hbGlzdGFpci9xZW11L2xpbnV4LXVzZXIvZWxmbG9hZC5jOjMyMDg6MTIs
DQogICAgaW5saW5lZCBmcm9tIOKAmGZpbGxfbm90ZV9pbmZv4oCZIGF0IC9ob21lL2FsaXN0YWly
L3FlbXUvbGludXgtdXNlci9lbGZsb2FkLmM6MzM5MDo1LA0KICAgIGlubGluZWQgZnJvbSDigJhl
bGZfY29yZV9kdW1w4oCZIGF0IC9ob21lL2FsaXN0YWlyL3FlbXUvbGludXgtdXNlci9lbGZsb2Fk
LmM6MzUzOTo5Og0KL3Vzci9pbmNsdWRlL2JpdHMvc3RyaW5nX2ZvcnRpZmllZC5oOjEwNjoxMDog
ZXJyb3I6IOKAmF9fYnVpbHRpbl9zdHJuY3B54oCZIHNwZWNpZmllZCBib3VuZCAxNiBlcXVhbHMg
ZGVzdGluYXRpb24gc2l6ZSBbLVdlcnJvcj1zdHJpbmdvcC10cnVuY2F0aW9uXQ0KICAxMDYgfCAg
IHJldHVybiBfX2J1aWx0aW5fX19zdHJuY3B5X2NoayAoX19kZXN0LCBfX3NyYywgX19sZW4sIF9f
Ym9zIChfX2Rlc3QpKTsNCiAgICAgIHwgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCg0KU2lnbmVkLW9mZi1ieTog
QWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KLS0tDQogbGludXgt
dXNlci9lbGZsb2FkLmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9saW51eC11c2VyL2VsZmxvYWQuYyBiL2xpbnV4
LXVzZXIvZWxmbG9hZC5jDQppbmRleCBjMWEyNjAyMWY4Li5kMDhmZTIzNDY2IDEwMDY0NA0KLS0t
IGEvbGludXgtdXNlci9lbGZsb2FkLmMNCisrKyBiL2xpbnV4LXVzZXIvZWxmbG9hZC5jDQpAQCAt
Mjg3Miw3ICsyODcyLDcgQEAgc3RydWN0IHRhcmdldF9lbGZfcHJwc2luZm8gew0KICAgICB0YXJn
ZXRfZ2lkX3QgcHJfZ2lkOw0KICAgICB0YXJnZXRfcGlkX3QgcHJfcGlkLCBwcl9wcGlkLCBwcl9w
Z3JwLCBwcl9zaWQ7DQogICAgIC8qIExvdHMgbWlzc2luZyAqLw0KLSAgICBjaGFyICAgIHByX2Zu
YW1lWzE2XTsgICAgICAgICAgIC8qIGZpbGVuYW1lIG9mIGV4ZWN1dGFibGUgKi8NCisgICAgY2hh
ciAgICBwcl9mbmFtZVsxNl0gUUVNVV9OT05TVFJJTkc7IC8qIGZpbGVuYW1lIG9mIGV4ZWN1dGFi
bGUgKi8NCiAgICAgY2hhciAgICBwcl9wc2FyZ3NbRUxGX1BSQVJHU1pdOyAvKiBpbml0aWFsIHBh
cnQgb2YgYXJnIGxpc3QgKi8NCiB9Ow0KIA0KLS0gDQoyLjIxLjANCg0K

