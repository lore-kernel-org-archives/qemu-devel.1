Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE354C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:45:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EC9E21848
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="3/el18BB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC9E21848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAjd6-0007hX-MC
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 19:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iAjEi-0000Z1-Ey
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iAjEg-0002hR-Ls
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:48 -0400
Received: from mail-eopbgr700099.outbound.protection.outlook.com
 ([40.107.70.99]:57953 helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iAjEg-0002fm-Ez
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHgl8A/u4+7JfnSWzpNhQpfZWcl6h5WaRNHGcZUOGAeDSJ8C9z4I8y3MJehujTnU0CD6Gt4je8JAwiOTlMJoWf7eOlpiQN+MJBl9lku0NEAlDkSKk5F9zvJSyaqS6ckzVehhWBUNVFWYw4rvlcBbUCIsPfrEwl6/jW7KZRCfajcjYBcy3Kd1JZ2VpJBOtbeHBaWDLJoRMD3+9VD5EN1xYwk4JZ1hM4G8Zb4gyD5IV2uB55RPKz5/o4Xldj4ty2bJw6QKkyCwvkgcBrH38GcBHtu5bWAqEUNZ4aHsFiwTp/JtvfUBbEbxEHTuVcOj9waGBcfAan5MSEdSnmtfrc53Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69ahgLwP1KKvLigotiQVJE9rboGJ+71jKBnrGIWB8No=;
 b=GwtRKol5H5/AUex9ZKMbQj0/qBlS1RRpcSw//Lx4NVYq3pdbRf8ZDVru848UNnG7zzelI1DaETiKtuJ+Nt2pKIQvn2kinf7SD802GgnATX8JadxM080f5Bx8nlthrlOZRL6kye6jz/LYW8y4oi7a5MZEFR/oguC8HcBlAzX3OWML6JS/PsPYFXfTbw7acniaHYkBp5TDsjic2f5TSWtA1+5FSSjjH5NooT0mFlB8ZyDFUeP05nZiX57Tu64DVy0gV6y5rQh7zwb8ErRyKlmvzoYo3BwhebfneVZ6zP63qLyi6a4N3fU1nhQf2FjOnL4Ya0h4DZh9tToG9hMPza6Qng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69ahgLwP1KKvLigotiQVJE9rboGJ+71jKBnrGIWB8No=;
 b=3/el18BBLmOzQVYES0weCOOu8r11QoZk9h7+hRnZLHMKfI6NPkxcohjAxAeBFMPashuWsyqgmLglk24UwpKKMO6bwt2yHxBFhETFneEHejfPWaZGmfsvdOYze6KVPtpHfM9EYyXgz5lXznmybH5jecgkp8F3Yxr1MiNhXgaTHm8=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB3016.namprd03.prod.outlook.com (10.175.117.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 18 Sep 2019 23:19:43 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107%3]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 23:19:43 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 16/22] fuzz: add fuzzer skeleton
Thread-Index: AQHVbneNlE8fR7mgcUOLZqeMV0v7RQ==
Date: Wed, 18 Sep 2019 23:19:43 +0000
Message-ID: <20190918231846.22538-17-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: 6b7b05ea-507e-4cf6-3e2b-08d73c8eb011
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:CY4PR03MB3016; 
x-ms-traffictypediagnostic: CY4PR03MB3016:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB3016008E94ED5A614B1B85D9BA8E0@CY4PR03MB3016.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(199004)(189003)(66066001)(86362001)(52116002)(478600001)(2616005)(7736002)(71190400001)(8676002)(36756003)(71200400001)(14454004)(54906003)(316002)(786003)(6486002)(81156014)(75432002)(256004)(6436002)(305945005)(6916009)(6512007)(5640700003)(386003)(486006)(26005)(11346002)(186003)(102836004)(99286004)(76176011)(66946007)(446003)(476003)(66476007)(66556008)(64756008)(66446008)(6506007)(5660300002)(4326008)(2501003)(2351001)(6116002)(81166006)(50226002)(25786009)(1076003)(2906002)(88552002)(8936002)(3846002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB3016;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4SoPupVyY1DUzUBiE9IBgR2DGcbYK06JANxynqLRzaUoWONY4pn5l0W24x1h3ngcUuS62kf793fijFnx/dMPxfINaTTDFoIGptWL6JM3Uf+JoXK5YWS9bVjahSb5RwmloHfyDKxHGidImiaKg6yl2afrUbMnhijFyeiRevYJF1oBJ/gpCdspS/TvrGS10RRGYM7NObwRkkGieDib0tJcxEQtQm8HYRgUSoM0Wbq/PmyUiv7nH+7PKaORlwXLxYogMFWBjCDlMh+saJRICEftIUWUMkplTJijgZYjJXuRg9ZwKAxpxpVi8KbbJ1tjXN6pspEpxBVBo3LjMTSbDUcxfIJA6h5B4a6kfTBQglc+SlskhUVYp6UOAkYfu9+KtI/Un+pWf8f7ASyQ/B1b19S2XgcX3ei0KcFMIqYCnWAgQmw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7b05ea-507e-4cf6-3e2b-08d73c8eb011
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 23:19:43.4856 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MOBXxMqhQz7Zlpt48lSeNA6xkkMKyvOEnhTfhW5DzYBVvilwthaPAwyhpSK5edg6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3016
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.70.99
Subject: [Qemu-devel] [PATCH v3 16/22] fuzz: add fuzzer skeleton
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

tests/fuzz/fuzz.c serves as the entry point for the virtual-device
fuzzer. Namely, libfuzzer invokes the LLVMFuzzerInitialize and
LLVMFuzzerTestOneInput functions, both of which are defined in this
file. This change adds a "FuzzTarget" struct, along with the
fuzz_add_target function, which should be used to define new fuzz
targets.

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 tests/fuzz/Makefile.include |   4 +-
 tests/fuzz/fuzz.c           | 179 ++++++++++++++++++++++++++++++++++++
 tests/fuzz/fuzz.h           |  30 ++++++
 3 files changed, 211 insertions(+), 2 deletions(-)
 create mode 100644 tests/fuzz/fuzz.c
 create mode 100644 tests/fuzz/fuzz.h

diff --git a/tests/fuzz/Makefile.include b/tests/fuzz/Makefile.include
index 324e6c1433..b415b056b0 100644
--- a/tests/fuzz/Makefile.include
+++ b/tests/fuzz/Makefile.include
@@ -1,4 +1,4 @@
-# QEMU_PROG_FUZZ=3Dqemu-fuzz-$(TARGET_NAME)$(EXESUF)
+QEMU_PROG_FUZZ=3Dqemu-fuzz-$(TARGET_NAME)$(EXESUF)
 fuzz-obj-y =3D $(libqos-obj-y)
 fuzz-obj-y +=3D tests/libqtest.o
-
+fuzz-obj-y +=3D tests/fuzz/fuzz.o
diff --git a/tests/fuzz/fuzz.c b/tests/fuzz/fuzz.c
new file mode 100644
index 0000000000..833f436731
--- /dev/null
+++ b/tests/fuzz/fuzz.c
@@ -0,0 +1,179 @@
+#include "qemu/osdep.h"
+
+#include <stdio.h>
+#include <stdlib.h>
+
+
+#include "tests/libqtest.h"
+#include "sysemu/qtest.h"
+#include "fuzz.h"
+#include "tests/libqos/qgraph.h"
+#include "sysemu/runstate.h"
+#include "sysemu/sysemu.h"
+
+typedef struct FuzzTargetState {
+        FuzzTarget *target;
+        QSLIST_ENTRY(FuzzTargetState) target_list;
+} FuzzTargetState;
+
+typedef QSLIST_HEAD(, FuzzTargetState) FuzzTargetList;
+
+static const char *fuzz_arch =3D TARGET_NAME;
+
+static FuzzTargetList *fuzz_target_list;
+static FuzzTarget *fuzz_target;
+static QTestState *fuzz_qts;
+static bool trace;
+
+
+void set_fuzz_target_args(int argc, char **argv)
+{
+    if (fuzz_target) {
+        fuzz_target->main_argc =3D argc;
+        fuzz_target->main_argv =3D argv;
+    }
+}
+
+void reboot(QTestState *s)
+{
+    qemu_system_reset(SHUTDOWN_CAUSE_GUEST_RESET);
+}
+
+static QTestState *qtest_setup(void)
+{
+    qtest_server_set_tx_handler(&qtest_client_inproc_recv, NULL);
+    return qtest_inproc_init(trace, fuzz_arch, &qtest_server_inproc_recv);
+}
+
+void fuzz_add_target(const char *name, const char *description,
+        FuzzTarget *target)
+{
+    FuzzTargetState *tmp;
+    FuzzTargetState *target_state;
+    if (!fuzz_target_list) {
+        fuzz_target_list =3D g_new0(FuzzTargetList, 1);
+    }
+
+    QSLIST_FOREACH(tmp, fuzz_target_list, target_list) {
+        if (g_strcmp0(tmp->target->name->str, name) =3D=3D 0) {
+            fprintf(stderr, "Error: Fuzz target name %s already in use\n",
+                    name);
+            abort();
+        }
+    }
+    target_state =3D g_new0(FuzzTargetState, 1);
+    target_state->target =3D g_new0(FuzzTarget, 1);
+    *(target_state->target) =3D *target;
+    target_state->target->name =3D g_string_new(name);
+    target_state->target->description =3D g_string_new(description);
+    QSLIST_INSERT_HEAD(fuzz_target_list, target_state, target_list);
+}
+
+
+static FuzzTarget *fuzz_get_target(char* name)
+{
+    FuzzTargetState *tmp;
+    if (!fuzz_target_list) {
+        fprintf(stderr, "Fuzz target list not initialized\n");
+        abort();
+    }
+
+    QSLIST_FOREACH(tmp, fuzz_target_list, target_list) {
+        if (g_strcmp0(tmp->target->name->str, name) =3D=3D 0) {
+            break;
+        }
+    }
+    return tmp->target;
+}
+
+
+static void usage(char *path)
+{
+    printf("Usage: %s --FUZZ_TARGET [LIBFUZZER ARGUMENTS]\n", path);
+    printf("where --FUZZ_TARGET is one of:\n");
+    FuzzTargetState *tmp;
+    if (!fuzz_target_list) {
+        fprintf(stderr, "Fuzz target list not initialized\n");
+        abort();
+    }
+    QSLIST_FOREACH(tmp, fuzz_target_list, target_list) {
+        printf(" --%s  : %s\n", tmp->target->name->str,
+                tmp->target->description->str);
+    }
+    exit(0);
+}
+
+
+/* Executed for each fuzzing-input */
+int LLVMFuzzerTestOneInput(const unsigned char *Data, size_t Size)
+{
+    if (fuzz_target->fuzz) {
+        fuzz_target->fuzz(fuzz_qts, Data, Size);
+    }
+    return 0;
+}
+
+/* Executed once, prior to fuzzing */
+int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
+{
+
+    char *target_name, *trace_qtest;
+
+    /* --trace is useful for outputting a log of qtest commands that trigg=
er
+     * a crash. The log can can then be replayed with a simple qtest scrip=
t. */
+    if (*argc > 2) {
+        trace_qtest =3D (*argv)[2];
+        if (strcmp(trace_qtest, "--trace") =3D=3D 0) {
+            trace =3D true;
+        }
+    }
+
+    /* Initialize qgraph and modules */
+    qos_graph_init();
+    module_call_init(MODULE_INIT_FUZZ_TARGET);
+    module_call_init(MODULE_INIT_QOM);
+    module_call_init(MODULE_INIT_LIBQOS);
+
+    if (*argc <=3D 1) {
+        usage(**argv);
+    }
+
+    /* Identify the fuzz target */
+    target_name =3D (*argv)[1];
+    target_name +=3D 2;
+    fuzz_target =3D fuzz_get_target(target_name);
+
+    fuzz_qts =3D qtest_setup(void);
+
+    if (!fuzz_target) {
+        fprintf(stderr, "Error: Fuzz fuzz_target name %s not found\n",
+                target_name);
+        usage(**argv);
+    }
+
+    if (fuzz_target->pre_main) {
+        fuzz_target->pre_main();
+    }
+
+    if (trace) {
+        printf("### cmd_line: ");
+        for (int i =3D 0; i < (fuzz_target->main_argc); i++) {
+            printf("%s ", ((fuzz_target->main_argv))[i]);
+        }
+        printf("\n");
+    }
+
+    /* Run QEMU's softmmu main with the calculated arguments*/
+    qemu_init(fuzz_target->main_argc, fuzz_target->main_argv, NULL);
+
+    /* If configured, this is a good spot to set up snapshotting */
+    if (fuzz_target->pre_fuzz) {
+        fuzz_target->pre_fuzz(fuzz_qts);
+    }
+
+    if (trace) {
+        printf("### END INITIALIZATION\n");
+    }
+
+    return 0;
+}
diff --git a/tests/fuzz/fuzz.h b/tests/fuzz/fuzz.h
new file mode 100644
index 0000000000..73af029c82
--- /dev/null
+++ b/tests/fuzz/fuzz.h
@@ -0,0 +1,30 @@
+#ifndef FUZZER_H_
+#define FUZZER_H_
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "exec/memory.h"
+#include "tests/libqtest.h"
+
+
+typedef struct FuzzTarget {
+    GString *name;
+    GString *description;
+    void(*pre_main)(void);
+    void(*pre_fuzz)(QTestState *);
+    void(*fuzz)(QTestState *, const unsigned char *, size_t);
+    int main_argc;
+    char **main_argv;
+} FuzzTarget;
+
+void set_fuzz_target_args(int argc, char **argv);
+void reboot(QTestState *);
+void fuzz_add_target(const char *name, const char *description, FuzzTarget
+        *target);
+
+int LLVMFuzzerTestOneInput(const unsigned char *Data, size_t Size);
+int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp);
+
+#endif
+
--=20
2.23.0


