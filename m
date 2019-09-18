Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77890C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:21:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31EE2218AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="xlGKAd2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31EE2218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAjGg-0002AD-GB
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 19:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33143)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iAjET-0000DR-Lh
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iAjER-0002SR-T6
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:33 -0400
Received: from mail-eopbgr710125.outbound.protection.outlook.com
 ([40.107.71.125]:35255 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iAjER-0002RC-Lq
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/NhWbLUxcywtGtl1ZFbYtQzBToJMNwDHKgSPj1m3p34MKVKDJrjxA4jIxlhdDjdJM7+GZt4Xrtd5z35SoksVdToswA0im3YrxygwEOIWOHK/4YT2ElIqUL+oQmPp6KPoBX6gOF7JCLGSnkR/sT4OUIWowQFPJIe30dfiS6zP9N6M5gLsz3jXKO9QDT9xGn8Xs3YzVsSIG68Cs4Jey4sNq8DcbHDjow2X+W2olOQV6Y1HK2NzX8gbG8Q0MdwreNvb7KHjURpsJ3+oiomdwFoEbsOXAWzKqArBNkeRmZdeF9rwfcQJL/x2334SdY7I6sUZuShKR9rXzdunU75IchwbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTTSY45zl8aDnZ4fQRRsQ4KW1PyknjWwSKAD4E24ht8=;
 b=ibJDgF5Dc3v9wTUpHnihojsktHOg9WlZ6ewLXt4fjmz6MfiqMnhjqC4PrL5F9TZnEhNuH9VXQRutrB4drsDPWYE5XN30FWN1RkVWhBlQz3FAgrCQ7xx1Vg/FQCBpGqiqXggi/pJG2nNGeuyLfNA8YoKRn61OAKFfM2Umi7jY0gEITKSb2yP/Asl0Je0ERovfKd3akvFdoEEv7s9JXe3JOUvS8aF/3erPmipI6btFGRPeU4hXgtMgn8jRMceKciADT+uLLl4rNJpmOJKqMp/S8JheseHw+ZJ7tD4vF3sugzbBUEUaGk1MHsSa3FPKs5a5ijwDS3ygFQWHhvh9of3O5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTTSY45zl8aDnZ4fQRRsQ4KW1PyknjWwSKAD4E24ht8=;
 b=xlGKAd2sTylvKY4VMFUeQRoz9Xp0d7p4sfKykqkG8OAC5dGVllmqn68c0QKnJBE3h6/6VJwdOFijjCOrIgaB9i2O2FoXchy0k6ELiB+amY0InWnD8dpYj1TyKRvt/Ot/ELfjbiBHUPaZG+JKwgJfwt7FzD3r7B8ChAf4pGTerW0=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB3016.namprd03.prod.outlook.com (10.175.117.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 18 Sep 2019 23:19:28 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107%3]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 23:19:28 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 01/22] softmmu: split off vl.c:main() into main.c
Thread-Index: AQHVbneErncWI2VHukm8RkgqcYgDRQ==
Date: Wed, 18 Sep 2019 23:19:28 +0000
Message-ID: <20190918231846.22538-2-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: cd0ec660-50e9-4a65-86de-08d73c8ea6e3
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:CY4PR03MB3016; 
x-ms-traffictypediagnostic: CY4PR03MB3016:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB3016B1534797D7126623E517BA8E0@CY4PR03MB3016.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(199004)(189003)(66066001)(86362001)(52116002)(478600001)(2616005)(7736002)(71190400001)(8676002)(36756003)(71200400001)(14454004)(54906003)(316002)(786003)(6486002)(81156014)(75432002)(256004)(6436002)(305945005)(6916009)(6512007)(5640700003)(386003)(486006)(26005)(11346002)(186003)(102836004)(99286004)(76176011)(66946007)(446003)(476003)(66476007)(66556008)(64756008)(66446008)(6506007)(5660300002)(4326008)(2501003)(2351001)(6116002)(81166006)(50226002)(25786009)(1076003)(2906002)(88552002)(8936002)(3846002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB3016;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8paaOiuIrRVDNYkldxa9AsBIHHDkCNTHTpyFekBQRclB0x01adgTFJJdzIEm99Zy/WnQA9zJqP8Lzf6Jxw6W8p/QpLLCgWQpWNnOuuG3fxE/rjqUNdBJOpZtJYo1Ep8LQStah5LQgBBiajQrT34M+9M28qPsPDddqlfK3gUPYM1y3R6T3CLRjD4l0j9AZrXtoYFm48IwHgqrRSJlxmFHORvwJzP8xmmgSmLz8IOGe5JK0wFmWl3B/rrUpaPGDmkfhH4m6X370qg27G/O//Afz8OSYEnqd3CAZ4OQWfBSQM9Im60XdzpIJf/PX+lEkWIpNGMvjbInSkIZDpfyklZpQqIW9NyTLvHQ5AndEi+OZ5WA0OeRcTxndraEt7PNndmuy+Lip6EWY17MytWZwEM24868J179ggR3yOlCnEqpZ84=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0ec660-50e9-4a65-86de-08d73c8ea6e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 23:19:28.1565 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TjyfWHuw4Z8i3UOATN4drJFaQVU8Ht9kIZLXgRXJzmXSF/iqVWOnVxCsgZJNTNvp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3016
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.125
Subject: [Qemu-devel] [PATCH v3 01/22] softmmu: split off vl.c:main() into
 main.c
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "Oleinik, Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A program might rely on functions implemented in vl.c, but implement its
own main(). By placing main into a separate source file, there are no
complaints about duplicate main()s when linking against vl.o. For
example, the virtual-device fuzzer uses a main() provided by libfuzzer,
and needs to perform some initialization before running the softmmu
initialization. Now, main simply calls three vl.c functions which
handle the guest initialization, main loop and cleanup.

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 Makefile                |  1 +
 Makefile.objs           |  2 ++
 include/sysemu/sysemu.h |  4 ++++
 main.c                  | 29 +++++++++++++++++++++++++++++
 vl.c                    | 25 +++++++------------------
 5 files changed, 43 insertions(+), 18 deletions(-)
 create mode 100644 main.c

diff --git a/Makefile b/Makefile
index b3528617e4..f628783571 100644
--- a/Makefile
+++ b/Makefile
@@ -463,6 +463,7 @@ $(SOFTMMU_ALL_RULES): $(crypto-obj-y)
 $(SOFTMMU_ALL_RULES): $(io-obj-y)
 $(SOFTMMU_ALL_RULES): config-all-devices.mak
 $(SOFTMMU_ALL_RULES): $(edk2-decompressed)
+$(SOFTMMU_ALL_RULES): $(softmmu-main-y)
=20
 .PHONY: $(TARGET_DIRS_RULES)
 # The $(TARGET_DIRS_RULES) are of the form SUBDIR/GOAL, so that
diff --git a/Makefile.objs b/Makefile.objs
index 6a143dcd57..bb1cfa05ef 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -86,6 +86,8 @@ common-obj-$(CONFIG_FDT) +=3D device_tree.o
 # qapi
=20
 common-obj-y +=3D qapi/
+
+softmmu-main-y =3D main.o
 endif
=20
 #######################################################################
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 44f18eb739..aa204ebbb0 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -114,6 +114,10 @@ QemuOpts *qemu_get_machine_opts(void);
=20
 bool defaults_enabled(void);
=20
+void main_loop(void);
+int qemu_init(int argc, char **argv, char **envp);
+void qemu_cleanup(void);
+
 extern QemuOptsList qemu_legacy_drive_opts;
 extern QemuOptsList qemu_common_drive_opts;
 extern QemuOptsList qemu_drive_opts;
diff --git a/main.c b/main.c
new file mode 100644
index 0000000000..279275069d
--- /dev/null
+++ b/main.c
@@ -0,0 +1,29 @@
+#include "qemu/osdep.h"
+#include "sysemu/sysemu.h"
+
+#ifdef CONFIG_SDL
+#if defined(__APPLE__) || defined(main)
+#include <SDL.h>
+int qemu_main(int argc, char **argv, char **envp);
+int main(int argc, char **argv)
+{
+    return qemu_main(argc, argv, NULL);
+}
+#undef main
+#define main qemu_main
+#endif
+#endif /* CONFIG_SDL */
+
+int main(int argc, char **argv, char **envp)
+{
+    int ret =3D qemu_init(argc, argv, envp);
+    if (ret !=3D 0) {
+        return ret;
+    }
+
+    main_loop();
+
+    qemu_cleanup();
+
+    return 0;
+}
diff --git a/vl.c b/vl.c
index 630f5c5e9c..327510c81f 100644
--- a/vl.c
+++ b/vl.c
@@ -36,18 +36,6 @@
 #include "sysemu/seccomp.h"
 #include "sysemu/tcg.h"
=20
-#ifdef CONFIG_SDL
-#if defined(__APPLE__) || defined(main)
-#include <SDL.h>
-int qemu_main(int argc, char **argv, char **envp);
-int main(int argc, char **argv)
-{
-    return qemu_main(argc, argv, NULL);
-}
-#undef main
-#define main qemu_main
-#endif
-#endif /* CONFIG_SDL */
=20
 #ifdef CONFIG_COCOA
 #undef main
@@ -1794,7 +1782,7 @@ static bool main_loop_should_exit(void)
     return false;
 }
=20
-static void main_loop(void)
+void main_loop(void)
 {
 #ifdef CONFIG_PROFILER
     int64_t ti;
@@ -2869,7 +2857,7 @@ static void user_register_global_props(void)
                       global_init_func, NULL, NULL);
 }
=20
-int main(int argc, char **argv, char **envp)
+int qemu_init(int argc, char **argv, char **envp)
 {
     int i;
     int snapshot, linux_boot;
@@ -4468,7 +4456,7 @@ int main(int argc, char **argv, char **envp)
     if (vmstate_dump_file) {
         /* dump and exit */
         dump_vmstate_json_to_file(vmstate_dump_file);
-        return 0;
+        exit(0);
     }
=20
     if (incoming) {
@@ -4485,8 +4473,11 @@ int main(int argc, char **argv, char **envp)
     accel_setup_post(current_machine);
     os_setup_post();
=20
-    main_loop();
+    return 0;
+}
=20
+void qemu_cleanup()
+{
     gdbserver_cleanup();
=20
     /*
@@ -4522,6 +4513,4 @@ int main(int argc, char **argv, char **envp)
     qemu_chr_cleanup();
     user_creatable_cleanup();
     /* TODO: unref root container, check all devices are ok */
-
-    return 0;
 }
--=20
2.23.0


