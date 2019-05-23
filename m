Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92573C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 11:00:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49F2C20868
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 11:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WH8U7TUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F2C20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33680 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTlSj-0001l6-Ln
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 07:00:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1hTlN8-0005GH-4X
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1hTlN6-0004tD-Jl
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:54:53 -0400
Received: from mail-eopbgr10111.outbound.protection.outlook.com
	([40.107.1.111]:47693
	helo=EUR02-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1hTlN6-0004rv-CU
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Tv2Cbli/Tqvu7owPtK43D91girBk3sDgN7PJDxaDH2Y=;
	b=WH8U7TUpwDL7M5fgaDthqF46qEihBfd/WGJeHI1c+gutrh7P7nt+pDqiJcAcavTSx2oP5awKIXeujLxXpDY6FYcFqtTdllWU/JsRLAzSNkyQ8p1+QxCIjrg/lk2F2Y/DGINE15bdixgisc3y42tE7fxuq4mJJ+0uS3d7WF8uDTg=
Received: from DBBPR08MB4854.eurprd08.prod.outlook.com (20.179.46.205) by
	DBBPR08MB4425.eurprd08.prod.outlook.com (20.179.43.13) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1922.16; Thu, 23 May 2019 10:54:48 +0000
Received: from DBBPR08MB4854.eurprd08.prod.outlook.com
	([fe80::4d46:2c95:d6e:ab3f]) by DBBPR08MB4854.eurprd08.prod.outlook.com
	([fe80::4d46:2c95:d6e:ab3f%7]) with mapi id 15.20.1900.010;
	Thu, 23 May 2019 10:54:48 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
Thread-Topic: [RFC PATCH 1/2] cpus-common: nuke finish_safe_work
Thread-Index: AQHVEVXwRYejWVDaoEKIMQ4+lvoMHA==
Date: Thu, 23 May 2019 10:54:48 +0000
Message-ID: <20190523105440.27045-2-rkagan@virtuozzo.com>
References: <20190523105440.27045-1-rkagan@virtuozzo.com>
In-Reply-To: <20190523105440.27045-1-rkagan@virtuozzo.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR0901CA0058.eurprd09.prod.outlook.com
	(2603:10a6:3:45::26) To DBBPR08MB4854.eurprd08.prod.outlook.com
	(2603:10a6:10:da::13)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.21.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f746d30-988c-4662-6c5a-08d6df6d12fe
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DBBPR08MB4425; 
x-ms-traffictypediagnostic: DBBPR08MB4425:
x-microsoft-antispam-prvs: <DBBPR08MB4425A3840062F138C09C1FC4C9010@DBBPR08MB4425.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(136003)(39840400004)(366004)(376002)(396003)(199004)(189003)(81166006)(81156014)(8676002)(8936002)(50226002)(7736002)(2501003)(305945005)(36756003)(53936002)(386003)(6506007)(102836004)(52116002)(6486002)(14454004)(316002)(76176011)(1076003)(478600001)(99286004)(86362001)(6512007)(11346002)(2616005)(476003)(446003)(186003)(66066001)(68736007)(2906002)(26005)(256004)(71200400001)(110136005)(25786009)(66946007)(64756008)(14444005)(71190400001)(66476007)(66556008)(73956011)(5660300002)(3846002)(6436002)(66446008)(486006)(6116002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4425;
	H:DBBPR08MB4854.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iQinH8RizUEZu28b2N8lSGYmFRqFrlge6WBPSDwQQf3+3XXRjgAdq9mSWruCLthVkX3cGulT+85GhzTxH7doXQHut5PQ8XKwYzt8FD+Vkimm1RmBRCdK8ttrFw1xMvgmmHEwtgbS19sE370yRtxVN10jqzYd73tSQTA5IkMwmOMpcuKjcF2FuUbNotBrW5x+XBR7ooXb2O1WyGXSP4eJM6RHVo0jlImaqnaZNtw20/Z8BwUOB6Kre7Ylnvk9eSzRmGrp4JN84LgP33fnj1asOTh4bDxgB/rcl8KN1/F3VrZVMiMAXCGDxVOuPw0m3l1yAs9p8G4OQF0VqGZ0vjE42DgZ7asNHn/q9KFX0ll44wG6HH4HtMPTMzz4fz8GbT0DSAosQ008zHXR8VLh1eo+Sh+SEfLeYoT5JfbbRtYCpdE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f746d30-988c-4662-6c5a-08d6df6d12fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 10:54:48.5235 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4425
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.111
Subject: [Qemu-devel] [RFC PATCH 1/2] cpus-common: nuke finish_safe_work
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SXQgd2FzIGludHJvZHVjZWQgaW4gY29tbWl0IGIxMjk5NzJjOGI0MWUxNWIwNTIxODk1YTQ2ZmQ5
Yzc1MmI2OGE1ZSwNCndpdGggdGhlIGZvbGxvd2luZyBtb3RpdmF0aW9uOg0KDQogIEJlY2F1c2Ug
c3RhcnRfZXhjbHVzaXZlIHVzZXMgQ1BVX0ZPUkVBQ0gsIG1lcmdlIGV4Y2x1c2l2ZV9sb2NrIHdp
dGgNCiAgcWVtdV9jcHVfbGlzdF9sb2NrOiB0b2dldGhlciB3aXRoIGEgY2FsbCB0byBleGNsdXNp
dmVfaWRsZSAodmlhDQogIGNwdV9leGVjX3N0YXJ0L2VuZCkgaW4gY3B1X2xpc3RfYWRkLCB0aGlz
IHByb3RlY3RzIGV4Y2x1c2l2ZSB3b3JrDQogIGFnYWluc3QgY29uY3VycmVudCBDUFUgYWRkaXRp
b24gYW5kIHJlbW92YWwuDQoNCkhvd2V2ZXIsIGl0IHNlZW1zIHRvIGJlIHJlZHVuZGFudCwgYmVj
YXVzZSB0aGUgY3B1LWV4Y2x1c2l2ZQ0KaW5mcmFzdHJ1Y3R1cmUgcHJvdmlkZXMgc3VmZmlmaWNl
bnQgcHJvdGVjdGlvbiBhZ2FpbnN0IHRoZSBuZXdseSBhZGRlZA0KQ1BVIHN0YXJ0aW5nIGV4ZWN1
dGlvbiB3aGlsZSB0aGUgY3B1LWV4Y2x1c2l2ZSB3b3JrIGlzIHJ1bm5pbmcsIGFuZCB0aGUNCmFm
b3JlbWVudGlvbmVkIHRyYXZlcnNpbmcgb2YgdGhlIGNwdSBsaXN0IGlzIHByb3RlY3RlZCBieQ0K
cWVtdV9jcHVfbGlzdF9sb2NrLg0KDQpCZXNpZGVzLCB0aGlzIGFwcGVhcnMgdG8gYmUgdGhlIG9u
bHkgcGxhY2Ugd2hlcmUgdGhlIGNwdS1leGNsdXNpdmUNCnNlY3Rpb24gaXMgZW50ZXJlZCB3aXRo
IHRoZSBCUUwgdGFrZW4sIHdoaWNoIGhhcyBiZWVuIGZvdW5kIHRvIHRyaWdnZXINCkFCLUJBIGRl
YWRsb2NrIGFzIGZvbGxvd3M6DQoNCiAgICB2Q1BVIHRocmVhZCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgbWFpbiB0aHJlYWQNCiAgICAtLS0tLS0tLS0tLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgLS0tLS0tLS0tLS0NCmFzeW5jX3NhZmVfcnVuX29uX2NwdShzZWxmLA0KICAgICAg
ICAgICAgICAgICAgICAgIGFzeW5jX3N5bmljX3VwZGF0ZSkNCi4uLiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgW2NwdSBob3QtYWRkXQ0KcHJvY2Vzc19xdWV1ZWRfY3B1
X3dvcmsoKQ0KICBxZW11X211dGV4X3VubG9ja19pb3RocmVhZCgpDQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFtncmFiIEJRTF0NCiAgc3RhcnRfZXhjbHVzaXZl
KCkgICAgICAgICAgICAgICAgICAgICAgICAgY3B1X2xpc3RfYWRkKCkNCiAgYXN5bmNfc3luaWNf
dXBkYXRlKCkgICAgICAgICAgICAgICAgICAgICAgICBmaW5pc2hfc2FmZV93b3JrKCkNCiAgICBx
ZW11X211dGV4X2xvY2tfaW90aHJlYWQoKSAgICAgICAgICAgICAgICAgIGNwdV9leGVjX3N0YXJ0
KCkNCg0KU28gcmVtb3ZlIGl0LiAgVGhpcyBwYXZlcyB0aGUgd2F5IHRvIGVzdGFibGlzaGluZyBh
IHN0cmljdCBuZXN0aW5nIHJ1bGUNCm9mIG5ldmVyIGVudGVyaW5nIHRoZSBleGNsdXNpdmUgc2Vj
dGlvbiB3aXRoIHRoZSBCUUwgdGFrZW4uDQoNClNpZ25lZC1vZmYtYnk6IFJvbWFuIEthZ2FuIDxy
a2FnYW5AdmlydHVvenpvLmNvbT4NCi0tLQ0KIGNwdXMtY29tbW9uLmMgfCA4IC0tLS0tLS0tDQog
MSBmaWxlIGNoYW5nZWQsIDggZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9jcHVzLWNvbW1v
bi5jIGIvY3B1cy1jb21tb24uYw0KaW5kZXggM2NhNThjNjRlOC4uMDIzY2ZlYmZhMyAxMDA2NDQN
Ci0tLSBhL2NwdXMtY29tbW9uLmMNCisrKyBiL2NwdXMtY29tbW9uLmMNCkBAIC02OSwxMiArNjks
NiBAQCBzdGF0aWMgaW50IGNwdV9nZXRfZnJlZV9pbmRleCh2b2lkKQ0KICAgICByZXR1cm4gY3B1
X2luZGV4Ow0KIH0NCiANCi1zdGF0aWMgdm9pZCBmaW5pc2hfc2FmZV93b3JrKENQVVN0YXRlICpj
cHUpDQotew0KLSAgICBjcHVfZXhlY19zdGFydChjcHUpOw0KLSAgICBjcHVfZXhlY19lbmQoY3B1
KTsNCi19DQotDQogdm9pZCBjcHVfbGlzdF9hZGQoQ1BVU3RhdGUgKmNwdSkNCiB7DQogICAgIHFl
bXVfbXV0ZXhfbG9jaygmcWVtdV9jcHVfbGlzdF9sb2NrKTsNCkBAIC04Niw4ICs4MCw2IEBAIHZv
aWQgY3B1X2xpc3RfYWRkKENQVVN0YXRlICpjcHUpDQogICAgIH0NCiAgICAgUVRBSUxRX0lOU0VS
VF9UQUlMX1JDVSgmY3B1cywgY3B1LCBub2RlKTsNCiAgICAgcWVtdV9tdXRleF91bmxvY2soJnFl
bXVfY3B1X2xpc3RfbG9jayk7DQotDQotICAgIGZpbmlzaF9zYWZlX3dvcmsoY3B1KTsNCiB9DQog
DQogdm9pZCBjcHVfbGlzdF9yZW1vdmUoQ1BVU3RhdGUgKmNwdSkNCi0tIA0KMi4yMS4wDQoNCg==

