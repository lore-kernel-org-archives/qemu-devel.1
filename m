Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA16C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:27:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 636DF218AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="0Dptc4Q3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 636DF218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAjMY-0001VM-1c
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 19:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33194)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iAjEV-0000FN-LF
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iAjEU-0002U7-BT
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:35 -0400
Received: from mail-eopbgr710132.outbound.protection.outlook.com
 ([40.107.71.132]:6167 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iAjEU-0002SZ-4x
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqYmcOFpUJUXLr3thaHsHP0N9/JD/rkW7723NAlQRaRiOcrbmKcd4eNrrLNojuj6eMDvjBul9nIeChSRRE4h8keHBxGTeKGPwsqNpmzMVXRADfaYuBtkWvZyl4qHLhzCz+cHYIq5sf+aThjSQGBBtUD8x6DNfrUlnh2ZwoHP13IhZldR1MqJfZaGtUhFuO8XQjP7B4i2+4Ex6ShhYaOwe3fWXA79SsT4TzJ3Q6Nr/9g+f+51zf34pxov76jt/ZwNeGlEewbiERipPd8Arp+z10eSGSRDJG7h7W7li78a715Vbl0RnyHXpvikQxzJ/LnzWrZYu2zV1OK6ZQOancnOlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8J8YnIhyLbBKPhiXZHVbhgPfNPSO/Ewl+judJpegH4=;
 b=UAEVFbY06P3oTZJT94mXSrq3VAhwmDRiFoKIDb2LV9GHxgf3Hw1rIIXSNEy1a/he4B1Y9Yf6vCWNr4MVeV6lsTJYpxbKbbNUBEjxwlzS+gd2zqqG9IM79sM2clGOqOJtSD74rqdA0V3QUvGUzGjcb9Og1b3GZX8k2PycXf962Qypx9eJRJ18xXcRWsBzhnt0zgWNrfGYlK0X+37Tc8gYrbt1avRlQPkS4tzHcL4pYMNn83sukPN1YdFG8t7qNfvV9e6lydOHdzSvtE0UF/Bn4MccqK8sOAIzQK6GW820AYiqlfLlVNpKwG76ftk2BBhS+4YzR6erzcfTBkYl3KGNiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8J8YnIhyLbBKPhiXZHVbhgPfNPSO/Ewl+judJpegH4=;
 b=0Dptc4Q3GAsn4BBiYoz+avUvsv2ZhG7CP+ajIw4q7CkwLmVjggXDoxq17mj0MTF/VFve6od40nQNGLl42XGtTCOJ7EffAyiwEe8s+LKSkOtMzRS+51rlK5WwgU3L18MulTNpNUXStfZvp9uk1RuvVmcJk1x/DO6G3ndbH7BX754=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB3016.namprd03.prod.outlook.com (10.175.117.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 18 Sep 2019 23:19:31 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107%3]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 23:19:31 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 04/22] qtest: add qtest_server_send abstraction
Thread-Index: AQHVbneGCY8YhbIzf0iyqWM37iID8w==
Date: Wed, 18 Sep 2019 23:19:31 +0000
Message-ID: <20190918231846.22538-5-alxndr@bu.edu>
References: <20190918231846.22538-1-alxndr@bu.edu>
In-Reply-To: <20190918231846.22538-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0124.namprd02.prod.outlook.com
 (2603:10b6:208:35::29) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6dff444d-7eff-4e78-fd0e-08d73c8ea8fe
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:CY4PR03MB3016; 
x-ms-traffictypediagnostic: CY4PR03MB3016:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB301646AC295000A05B261975BA8E0@CY4PR03MB3016.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(199004)(189003)(66066001)(86362001)(52116002)(478600001)(2616005)(7736002)(71190400001)(8676002)(36756003)(71200400001)(14454004)(54906003)(316002)(786003)(6486002)(81156014)(75432002)(256004)(6436002)(305945005)(6916009)(6512007)(5640700003)(386003)(486006)(26005)(11346002)(186003)(102836004)(99286004)(76176011)(66946007)(446003)(476003)(66476007)(66556008)(64756008)(66446008)(6506007)(5660300002)(4326008)(2501003)(2351001)(6116002)(81166006)(50226002)(25786009)(1076003)(2906002)(88552002)(8936002)(3846002)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB3016;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TQBRupeNsL1VObYFz4Y4c1s9rznakhTRSG60EpJfj2Gn5bLp8kvWZix9pC9sGUbD/4petXuTSH4sobp1RAs2fMLg07tSjjt1TEs/um7Oin63LzH85bIVwTfd0BxJDgoDuEYe65EFICnLUH//4pWgCUPKkqQrcAboXciFgdUYHi50zbtybn+o5W/6hO/5Ilef/cUyAMGcxdFKPidwWE6KR1KlYv1mHZiPVmO1TAIhniIQvz4jUhYXnhhW2KvHkpJrx50U3gnnWMy0OXezzJ+Gt2vmz4xYZ+vl+NbX6diQ/Prni2GR2VHjLSBH6KLlcUkl+FTpKW+y6UgvqHX02Z5vGmylVw6DjI80pZLg5y6Mjo12dgrtxXEA0qf0/eCwWajqUMm0T/XDoBn1blVdPfXg73poJeeDkePiqGvv5tx16G0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dff444d-7eff-4e78-fd0e-08d73c8ea8fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 23:19:31.6239 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hEym71XIE92pUcQ1Nf4f/GOzJq/vG8KEJMwDi6fLH5XV3OCSlJW3HI8XBNR2fL0y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3016
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.132
Subject: [Qemu-devel] [PATCH v3 04/22] qtest: add qtest_server_send
 abstraction
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Oleinik, Alexander" <alxndr@bu.edu>, "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qtest_server_send is a function pointer specifying the handler used to
transmit data to the qtest client. In the standard configuration, this
calls the CharBackend handler, but now it is possible for other types of
handlers, e.g direct-function calls if the qtest client and server
exist within the same process (inproc)

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 include/sysemu/qtest.h |  3 +++
 qtest.c                | 17 +++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/sysemu/qtest.h b/include/sysemu/qtest.h
index 5ed09c80b1..fda7000d2c 100644
--- a/include/sysemu/qtest.h
+++ b/include/sysemu/qtest.h
@@ -26,4 +26,7 @@ bool qtest_driver(void);
=20
 void qtest_server_init(const char *qtest_chrdev, const char *qtest_log, Er=
ror **errp);
=20
+void qtest_server_set_tx_handler(void (*send)(void *, const char *, size_t=
),
+                                 void *opaque);
+
 #endif
diff --git a/qtest.c b/qtest.c
index 8b50e2783e..ae7e6d779d 100644
--- a/qtest.c
+++ b/qtest.c
@@ -42,6 +42,8 @@ static GString *inbuf;
 static int irq_levels[MAX_IRQ];
 static qemu_timeval start_time;
 static bool qtest_opened;
+static void (*qtest_server_send)(void*, const char*, size_t);
+static void *qtest_server_send_opaque;
=20
 #define FMT_timeval "%ld.%06ld"
=20
@@ -228,8 +230,9 @@ static void GCC_FMT_ATTR(1, 2) qtest_log_send(const cha=
r *fmt, ...)
     va_end(ap);
 }
=20
-static void do_qtest_send(CharBackend *chr, const char *str, size_t len)
+static void qtest_server_char_be_send(void *opaque, const char *str, size_=
t len)
 {
+    CharBackend* chr =3D (CharBackend *)opaque;
     qemu_chr_fe_write_all(chr, (uint8_t *)str, len);
     if (qtest_log_fp && qtest_opened) {
         fprintf(qtest_log_fp, "%s", str);
@@ -238,7 +241,7 @@ static void do_qtest_send(CharBackend *chr, const char =
*str, size_t len)
=20
 static void qtest_send(CharBackend *chr, const char *str)
 {
-    do_qtest_send(chr, str, strlen(str));
+    qtest_server_send(qtest_server_send_opaque, str, strlen(str));
 }
=20
 static void GCC_FMT_ATTR(2, 3) qtest_sendf(CharBackend *chr,
@@ -783,6 +786,16 @@ void qtest_server_init(const char *qtest_chrdev, const=
 char *qtest_log, Error **
     qemu_chr_fe_set_echo(&qtest_chr, true);
=20
     inbuf =3D g_string_new("");
+
+    if (!qtest_server_send) {
+        qtest_server_set_tx_handler(qtest_server_char_be_send, &qtest_chr)=
;
+    }
+}
+
+void qtest_server_set_tx_handler(void (*send)(void*, const char*, size_t),=
 void *opaque)
+{
+    qtest_server_send =3D send;
+    qtest_server_send_opaque =3D opaque;
 }
=20
 bool qtest_driver(void)
--=20
2.23.0


