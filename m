Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C85C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 11:08:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AAC02085A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 11:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SHp7Jr74"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AAC02085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55596 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdBy6-0004VD-Te
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 07:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40732)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rkagan@virtuozzo.com>) id 1hdBxH-0003yO-KS
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 07:07:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rkagan@virtuozzo.com>) id 1hdBxG-0007ba-FG
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 07:07:11 -0400
Received: from mail-db3eur04on0728.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::728]:20053
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
 id 1hdBxF-0007Xo-Ic
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 07:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gH9Pg8uABzh/niC4rK4D79DO68RV94nuNvXGlP4cuS0=;
 b=SHp7Jr740nb2EwBQgSSzyIwrPM57GCEVZP5dMJhasT23cyhSnbnkgU4cX6KSKXtRDkbq0JKN+jTYlJBdRiuZIWWICri0NR37m/zDcAMNWD/LKTpFKThai9bqY69FTKEi53eAtVIOh2s/SzeFofLHN11nfwYtpdlej35xXiwjpV0=
Received: from DB8PR08MB3977.eurprd08.prod.outlook.com (20.179.11.95) by
 DB8PR08MB5146.eurprd08.prod.outlook.com (10.255.17.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Tue, 18 Jun 2019 11:07:07 +0000
Received: from DB8PR08MB3977.eurprd08.prod.outlook.com
 ([fe80::3530:3b13:be7f:2944]) by DB8PR08MB3977.eurprd08.prod.outlook.com
 ([fe80::3530:3b13:be7f:2944%4]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 11:07:07 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: Eduardo Habkost <ehabkost@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Vadim Rozenfeld <vrozenfe@redhat.com>
Thread-Topic: [PATCH] i386: make 'hv-spinlocks' a regular uint32 property
Thread-Index: AQHVJcX3+KQutj1BX0CzGldPDul1lA==
Date: Tue, 18 Jun 2019 11:07:06 +0000
Message-ID: <20190618110659.14744-1-rkagan@virtuozzo.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR02CA0109.eurprd02.prod.outlook.com
 (2603:10a6:7:29::38) To DB8PR08MB3977.eurprd08.prod.outlook.com
 (2603:10a6:10:ad::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.21.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16f85302-6cc4-4e78-2ea9-08d6f3dd19ba
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5146; 
x-ms-traffictypediagnostic: DB8PR08MB5146:
x-microsoft-antispam-prvs: <DB8PR08MB5146636F7B0477D47D94CC27C9EA0@DB8PR08MB5146.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(366004)(376002)(39850400004)(346002)(189003)(199004)(66556008)(6486002)(68736007)(25786009)(6436002)(86362001)(2616005)(305945005)(3846002)(7736002)(54906003)(4326008)(26005)(486006)(52116002)(110136005)(386003)(99286004)(1076003)(2501003)(256004)(102836004)(6506007)(53936002)(66446008)(5660300002)(6512007)(8676002)(81166006)(50226002)(81156014)(66066001)(316002)(14454004)(6116002)(186003)(66946007)(478600001)(71200400001)(73956011)(476003)(36756003)(71190400001)(2906002)(66476007)(8936002)(64756008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5146;
 H:DB8PR08MB3977.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6jrw6DhLxBDT2jzPKiLlk6+TDAhGuzhg0un5NmwolqTVMfjC6nZqPevzSLZ3vhHGTWvr7SpmTH/cGoWcs1zD7SqoTHf61pOavdVL2x3NNGQYhVH7BxGbc89AcjyCwSFSWYiF6lqshhkHmNYZpPzF6LOGQ1BW0s3SXk7abhdTuN2CzyLugAX4ljncBImnHrhJdpU+IvpnU+eTyK90k8ZRFev7ycQHILW1IX0A7RGXvWbHanUCpbDoDVElkMW4CmIE9L/c73cQoaui6GjmYrfjFR+7jNVbhNYC1ds2RsIBpgMy9wsYzE32eJO1yq5IXJLJAeJe8Mbz6f1Lf1bM5M4ANYHvFe02GQNrjYUecdFt4KOg2nrPff9gRchd3w0ColquW1thl4iKP8DLyUw+6PKd9r4Vl0idcWpvEM1k/T2U0NY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f85302-6cc4-4e78-2ea9-08d6f3dd19ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 11:07:06.9235 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkagan@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5146
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0c::728
Subject: [Qemu-devel] [PATCH] i386: make 'hv-spinlocks' a regular uint32
 property
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

WDg2Q1BVLmh2LXNwaW5sb2NrcyBpcyBhIHVpbnQzMiBwcm9wZXJ0eSB0aGF0IGhhcyBhIHNwZWNp
YWwgc2V0dGVyDQp2YWxpZGF0aW5nIHRoZSB2YWx1ZSB0byBiZSBubyBsZXNzIHRoYW4gMHhGRkYg
YW5kIG5vIGJpZ2dlciB0aGFuDQpVSU5UX01BWC4gIFRoZSBsYXR0ZXIgY2hlY2sgaXMgcmVkdW5k
YW50OyBhcyBmb3IgdGhlIGZvcm1lciwgdGhlcmUNCmFwcGVhcnMgdG8gYmUgbm8gcmVhc29uIHRv
IHByb2hpYml0IHRoZSB1c2VyIGZyb20gc2V0dGluZyBpdCB0byBhIGxvd2VyDQp2YWx1ZS4NCg0K
U28gbnVrZSB0aGUgZGVkaWNhdGVkIGdldHRlci9zZXR0ZXIgcGFpciBhbmQgY29udmVydCAnaHYt
c3BpbmxvY2tzJyB0byBhDQpyZWd1bGFyIHVpbnQzMiBwcm9wZXJ0eS4NCg0KU2lnbmVkLW9mZi1i
eTogUm9tYW4gS2FnYW4gPHJrYWdhbkB2aXJ0dW96em8uY29tPg0KLS0tDQpCYXNlZC1vbjogPDIw
MTkwNjE1MjAwNTA1LjMxMzQ4LTEtZWhhYmtvc3RAcmVkaGF0LmNvbT4NCihbUEFUQ0hdIGkzODY6
IEZpeCBzaWduZWRuZXNzIG9mIGh5cGVydl9zcGlubG9ja19hdHRlbXB0cykNCg0KIHRhcmdldC9p
Mzg2L2NwdS5jIHwgNDUgKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNDMgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS90YXJnZXQvaTM4Ni9jcHUuYyBiL3RhcmdldC9pMzg2L2NwdS5jDQppbmRl
eCBmYmVkMmViODA0Li44NDNkNDUyNjJlIDEwMDY0NA0KLS0tIGEvdGFyZ2V0L2kzODYvY3B1LmMN
CisrKyBiL3RhcmdldC9pMzg2L2NwdS5jDQpAQCAtMzQ5Nyw0NiArMzQ5Nyw2IEBAIHN0YXRpYyB2
b2lkIHg4Nl9jcHVfZ2V0X2ZlYXR1cmVfd29yZHMoT2JqZWN0ICpvYmosIFZpc2l0b3IgKnYsDQog
ICAgIHZpc2l0X3R5cGVfWDg2Q1BVRmVhdHVyZVdvcmRJbmZvTGlzdCh2LCAiZmVhdHVyZS13b3Jk
cyIsICZsaXN0LCBlcnJwKTsNCiB9DQogDQotc3RhdGljIHZvaWQgeDg2X2dldF9odl9zcGlubG9j
a3MoT2JqZWN0ICpvYmosIFZpc2l0b3IgKnYsIGNvbnN0IGNoYXIgKm5hbWUsDQotICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqb3BhcXVlLCBFcnJvciAqKmVycnApDQotew0K
LSAgICBYODZDUFUgKmNwdSA9IFg4Nl9DUFUob2JqKTsNCi0gICAgaW50NjRfdCB2YWx1ZSA9IGNw
dS0+aHlwZXJ2X3NwaW5sb2NrX2F0dGVtcHRzOw0KLQ0KLSAgICB2aXNpdF90eXBlX2ludCh2LCBu
YW1lLCAmdmFsdWUsIGVycnApOw0KLX0NCi0NCi1zdGF0aWMgdm9pZCB4ODZfc2V0X2h2X3NwaW5s
b2NrcyhPYmplY3QgKm9iaiwgVmlzaXRvciAqdiwgY29uc3QgY2hhciAqbmFtZSwNCi0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkICpvcGFxdWUsIEVycm9yICoqZXJycCkNCi17
DQotICAgIGNvbnN0IGludDY0X3QgbWluID0gMHhGRkY7DQotICAgIGNvbnN0IGludDY0X3QgbWF4
ID0gVUlOVF9NQVg7DQotICAgIFg4NkNQVSAqY3B1ID0gWDg2X0NQVShvYmopOw0KLSAgICBFcnJv
ciAqZXJyID0gTlVMTDsNCi0gICAgaW50NjRfdCB2YWx1ZTsNCi0NCi0gICAgdmlzaXRfdHlwZV9p
bnQodiwgbmFtZSwgJnZhbHVlLCAmZXJyKTsNCi0gICAgaWYgKGVycikgew0KLSAgICAgICAgZXJy
b3JfcHJvcGFnYXRlKGVycnAsIGVycik7DQotICAgICAgICByZXR1cm47DQotICAgIH0NCi0NCi0g
ICAgaWYgKHZhbHVlIDwgbWluIHx8IHZhbHVlID4gbWF4KSB7DQotICAgICAgICBlcnJvcl9zZXRn
KGVycnAsICJQcm9wZXJ0eSAlcy4lcyBkb2Vzbid0IHRha2UgdmFsdWUgJSIgUFJJZDY0DQotICAg
ICAgICAgICAgICAgICAgICIgKG1pbmltdW06ICUiIFBSSWQ2NCAiLCBtYXhpbXVtOiAlIiBQUklk
NjQgIikiLA0KLSAgICAgICAgICAgICAgICAgICBvYmplY3RfZ2V0X3R5cGVuYW1lKG9iaiksIG5h
bWUgPyBuYW1lIDogIm51bGwiLA0KLSAgICAgICAgICAgICAgICAgICB2YWx1ZSwgbWluLCBtYXgp
Ow0KLSAgICAgICAgcmV0dXJuOw0KLSAgICB9DQotICAgIGNwdS0+aHlwZXJ2X3NwaW5sb2NrX2F0
dGVtcHRzID0gdmFsdWU7DQotfQ0KLQ0KLXN0YXRpYyBjb25zdCBQcm9wZXJ0eUluZm8gcWRldl9w
cm9wX3NwaW5sb2NrcyA9IHsNCi0gICAgLm5hbWUgID0gImludCIsDQotICAgIC5nZXQgICA9IHg4
Nl9nZXRfaHZfc3BpbmxvY2tzLA0KLSAgICAuc2V0ICAgPSB4ODZfc2V0X2h2X3NwaW5sb2NrcywN
Ci19Ow0KLQ0KIC8qIENvbnZlcnQgYWxsICdfJyBpbiBhIGZlYXR1cmUgc3RyaW5nIG9wdGlvbiBu
YW1lIHRvICctJywgdG8gbWFrZSBmZWF0dXJlDQogICogbmFtZSBjb25mb3JtIHRvIFFPTSBwcm9w
ZXJ0eSBuYW1pbmcgcnVsZSwgd2hpY2ggdXNlcyAnLScgaW5zdGVhZCBvZiAnXycuDQogICovDQpA
QCAtNTY1OCw4ICs1NjE4LDYgQEAgc3RhdGljIHZvaWQgeDg2X2NwdV9pbml0Zm4oT2JqZWN0ICpv
YmopDQogICAgIG9iamVjdF9wcm9wZXJ0eV9hZGQob2JqLCAiY3Jhc2gtaW5mb3JtYXRpb24iLCAi
R3Vlc3RQYW5pY0luZm9ybWF0aW9uIiwNCiAgICAgICAgICAgICAgICAgICAgICAgICB4ODZfY3B1
X2dldF9jcmFzaF9pbmZvX3FvbSwgTlVMTCwgTlVMTCwgTlVMTCwgTlVMTCk7DQogDQotICAgIGNw
dS0+aHlwZXJ2X3NwaW5sb2NrX2F0dGVtcHRzID0gSFlQRVJWX1NQSU5MT0NLX05FVkVSX1JFVFJZ
Ow0KLQ0KICAgICBmb3IgKHcgPSAwOyB3IDwgRkVBVFVSRV9XT1JEUzsgdysrKSB7DQogICAgICAg
ICBpbnQgYml0bnI7DQogDQpAQCAtNTg1Myw3ICs1ODExLDggQEAgc3RhdGljIFByb3BlcnR5IHg4
Nl9jcHVfcHJvcGVydGllc1tdID0gew0KICNlbmRpZg0KICAgICBERUZJTkVfUFJPUF9JTlQzMigi
bm9kZS1pZCIsIFg4NkNQVSwgbm9kZV9pZCwgQ1BVX1VOU0VUX05VTUFfTk9ERV9JRCksDQogICAg
IERFRklORV9QUk9QX0JPT0woInBtdSIsIFg4NkNQVSwgZW5hYmxlX3BtdSwgZmFsc2UpLA0KLSAg
ICB7IC5uYW1lICA9ICJodi1zcGlubG9ja3MiLCAuaW5mbyAgPSAmcWRldl9wcm9wX3NwaW5sb2Nr
cyB9LA0KKyAgICBERUZJTkVfUFJPUF9VSU5UMzIoImh2LXNwaW5sb2NrcyIsIFg4NkNQVSwgaHlw
ZXJ2X3NwaW5sb2NrX2F0dGVtcHRzLA0KKyAgICAgICAgICAgICAgICAgICAgICAgSFlQRVJWX1NQ
SU5MT0NLX05FVkVSX1JFVFJZKSwNCiAgICAgREVGSU5FX1BST1BfQk9PTCgiaHYtcmVsYXhlZCIs
IFg4NkNQVSwgaHlwZXJ2X3JlbGF4ZWRfdGltaW5nLCBmYWxzZSksDQogICAgIERFRklORV9QUk9Q
X0JPT0woImh2LXZhcGljIiwgWDg2Q1BVLCBoeXBlcnZfdmFwaWMsIGZhbHNlKSwNCiAgICAgREVG
SU5FX1BST1BfQk9PTCgiaHYtdGltZSIsIFg4NkNQVSwgaHlwZXJ2X3RpbWUsIGZhbHNlKSwNCi0t
IA0KMi4yMS4wDQoNCg==

