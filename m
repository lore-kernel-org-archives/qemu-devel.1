Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B267FC35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:56:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66388217F4
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PgMNQC3I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66388217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izJHp-0003WY-KA
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 06:56:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1izJHB-00034U-Sz
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:55:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1izJH9-00060w-Nv
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:55:25 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54520)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1izJH9-0005tK-D4
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:55:23 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015BsMuF014817;
 Wed, 5 Feb 2020 11:55:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=sG/E6fc15tIRZK17h6+f/jtlWiI3AD10g4TWToOVHdI=;
 b=PgMNQC3IYL4azOi+BLz2c1gfooBaEoc7gYCiPxx+fA1ohMpUFdw1u0PPr8/kDyoiRCYC
 lmtLnlfFWWkDU+392CO1p/nROHSHSe/gx1G3pU2lRPmljBj7vCU2j+esNnmn06eEsYMh
 KLaKg/2Z13xQoVtYYNDHkqz/1rGpRS+L2QbuMdf4GTXvaTYdZRpa+KcNgdnx6FsrtT6E
 MDUf29A1mwz665EoE55MuFl/9kVT5WbnlXpUzqIdqpDXVoy9zNoRHXfVDFc/jOVWALDx
 ytynMeoCtP2lo+PsUPw5KjlPdr0Tulqwkg3GFdBy062N66ZPYNSxio+Z2NvB5J5bZBHd Og== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 2xykbp2hgb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 11:55:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015BsFYr087012;
 Wed, 5 Feb 2020 11:55:17 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 2xymusj7nr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 11:55:17 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 015BtGW2032446;
 Wed, 5 Feb 2020 11:55:16 GMT
Received: from starbug-mbp.localdomain (/10.169.111.17)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 05 Feb 2020 03:55:16 -0800
Received: from starbug-mbp (localhost [127.0.0.1])
 by starbug-mbp.localdomain (Postfix) with SMTP id 780C157D7861;
 Wed,  5 Feb 2020 11:55:07 +0000 (GMT)
Date: Wed, 5 Feb 2020 11:55:07 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: "Bulekov, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v8 11/21] fuzz: add fuzzer skeleton
Message-ID: <20200205115507.4jbao74r5ylvetgm@starbug-mbp>
Mail-Followup-To: "Bulekov, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
References: <20200129053357.27454-1-alxndr@bu.edu>
 <20200129053357.27454-12-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200129053357.27454-12-alxndr@bu.edu>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050097
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex,

On Wed, Jan 29, 2020 at 05:34:20AM +0000, Bulekov, Alexander wrote:
>tests/fuzz/fuzz.c serves as the entry point for the virtual-device
>fuzzer. Namely, libfuzzer invokes the LLVMFuzzerInitialize and
>LLVMFuzzerTestOneInput functions, both of which are defined in this
>file. This change adds a "FuzzTarget" struct, along with the
>fuzz_add_target function, which should be used to define new fuzz
>targets.
>
>Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
>Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>---
> tests/qtest/fuzz/Makefile.include |   6 +
> tests/qtest/fuzz/fuzz.c           | 179 ++++++++++++++++++++++++++++++
> tests/qtest/fuzz/fuzz.h           |  95 ++++++++++++++++
> 3 files changed, 280 insertions(+)
> create mode 100644 tests/qtest/fuzz/Makefile.include
> create mode 100644 tests/qtest/fuzz/fuzz.c
> create mode 100644 tests/qtest/fuzz/fuzz.h
>
>diff --git a/tests/qtest/fuzz/Makefile.include b/tests/qtest/fuzz/Makefile.include
>new file mode 100644
>index 0000000000..8632bb89f4
>--- /dev/null
>+++ b/tests/qtest/fuzz/Makefile.include
>@@ -0,0 +1,6 @@
>+QEMU_PROG_FUZZ=qemu-fuzz-$(TARGET_NAME)$(EXESUF)
>+
>+fuzz-obj-y += tests/qtest/libqtest.o
>+fuzz-obj-y += tests/qtest/fuzz/fuzz.o # Fuzzer skeleton
>+
>+FUZZ_CFLAGS += -I$(SRC_PATH)/tests -I$(SRC_PATH)/tests/qtest
>diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
>new file mode 100644
>index 0000000000..0d78ac8d36
>--- /dev/null
>+++ b/tests/qtest/fuzz/fuzz.c
>@@ -0,0 +1,179 @@
>+/*
>+ * fuzzing driver
>+ *
>+ * Copyright Red Hat Inc., 2019
>+ *
>+ * Authors:
>+ *  Alexander Bulekov   <alxndr@bu.edu>
>+ *
>+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
>+ * See the COPYING file in the top-level directory.
>+ *
>+ */
>+
>+#include "qemu/osdep.h"
>+
>+#include <wordexp.h>
>+
>+#include "sysemu/qtest.h"
>+#include "sysemu/runstate.h"
>+#include "sysemu/sysemu.h"
>+#include "qemu/main-loop.h"
>+#include "tests/qtest/libqtest.h"
>+#include "tests/qtest/libqos/qgraph.h"
>+#include "fuzz.h"
>+
>+#define MAX_EVENT_LOOPS 10
>+
>+typedef struct FuzzTargetState {
>+        FuzzTarget *target;
>+        QSLIST_ENTRY(FuzzTargetState) target_list;
>+} FuzzTargetState;
>+
>+typedef QSLIST_HEAD(, FuzzTargetState) FuzzTargetList;
>+
>+static const char *fuzz_arch = TARGET_NAME;
>+
>+static FuzzTargetList *fuzz_target_list;
>+static FuzzTarget *fuzz_target;
>+static QTestState *fuzz_qts;
>+
>+
>+
>+void flush_events(QTestState *s)
>+{
>+    int i = MAX_EVENT_LOOPS;
>+    while (g_main_context_pending(NULL) && i-- > 0) {
>+        main_loop_wait(false);
>+    }
>+}
>+
>+static QTestState *qtest_setup(void)
>+{
>+    qtest_server_set_send_handler(&qtest_client_inproc_recv, &fuzz_qts);
>+    return qtest_inproc_init(&fuzz_qts, false, fuzz_arch,
>+            &qtest_server_inproc_recv);
>+}
>+
>+void fuzz_add_target(const FuzzTarget *target)
>+{
>+    FuzzTargetState *tmp;
>+    FuzzTargetState *target_state;
>+    if (!fuzz_target_list) {
>+        fuzz_target_list = g_new0(FuzzTargetList, 1);
>+    }
>+
>+    QSLIST_FOREACH(tmp, fuzz_target_list, target_list) {
>+        if (g_strcmp0(tmp->target->name, target->name) == 0) {
>+            fprintf(stderr, "Error: Fuzz target name %s already in use\n",
>+                    target->name);
>+            abort();
>+        }
>+    }
>+    target_state = g_new0(FuzzTargetState, 1);
>+    target_state->target = g_new0(FuzzTarget, 1);
>+    *(target_state->target) = *target;

It's a nit, but I would be wary of doing a structure assignment
where the structure contains pointers (or in this case, strings). I
know that they are declared as const char* in the structure, and the
most common use-case today is during init only, but it is usually
safer to clone such a structure, and possibly create functions to
clone, and possibly free.

It's not vital, so I'm happy to give a Rb based on the current
code, but something worth considering for the future.

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

Thanks,

Darren.

>+    QSLIST_INSERT_HEAD(fuzz_target_list, target_state, target_list);
>+}
>+
>+
>+
>+static void usage(char *path)
>+{
>+    printf("Usage: %s --fuzz-target=FUZZ_TARGET [LIBFUZZER ARGUMENTS]\n", path);
>+    printf("where FUZZ_TARGET is one of:\n");
>+    FuzzTargetState *tmp;
>+    if (!fuzz_target_list) {
>+        fprintf(stderr, "Fuzz target list not initialized\n");
>+        abort();
>+    }
>+    QSLIST_FOREACH(tmp, fuzz_target_list, target_list) {
>+        printf(" * %s  : %s\n", tmp->target->name,
>+                tmp->target->description);
>+    }
>+    exit(0);
>+}
>+
>+static FuzzTarget *fuzz_get_target(char* name)
>+{
>+    FuzzTargetState *tmp;
>+    if (!fuzz_target_list) {
>+        fprintf(stderr, "Fuzz target list not initialized\n");
>+        abort();
>+    }
>+
>+    QSLIST_FOREACH(tmp, fuzz_target_list, target_list) {
>+        if (strcmp(tmp->target->name, name) == 0) {
>+            return tmp->target;
>+        }
>+    }
>+    return NULL;
>+}
>+
>+
>+/* Executed for each fuzzing-input */
>+int LLVMFuzzerTestOneInput(const unsigned char *Data, size_t Size)
>+{
>+    /*
>+     * Do the pre-fuzz-initialization before the first fuzzing iteration,
>+     * instead of before the actual fuzz loop. This is needed since libfuzzer
>+     * may fork off additional workers, prior to the fuzzing loop, and if
>+     * pre_fuzz() sets up e.g. shared memory, this should be done for the
>+     * individual worker processes
>+     */
>+    static int pre_fuzz_done;
>+    if (!pre_fuzz_done && fuzz_target->pre_fuzz) {
>+        fuzz_target->pre_fuzz(fuzz_qts);
>+        pre_fuzz_done = true;
>+    }
>+
>+    fuzz_target->fuzz(fuzz_qts, Data, Size);
>+    return 0;
>+}
>+
>+/* Executed once, prior to fuzzing */
>+int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
>+{
>+
>+    char *target_name;
>+
>+    /* Initialize qgraph and modules */
>+    qos_graph_init();
>+    module_call_init(MODULE_INIT_FUZZ_TARGET);
>+    module_call_init(MODULE_INIT_QOM);
>+    module_call_init(MODULE_INIT_LIBQOS);
>+
>+    if (*argc <= 1) {
>+        usage(**argv);
>+    }
>+
>+    /* Identify the fuzz target */
>+    target_name = (*argv)[1];
>+    if (!strstr(target_name, "--fuzz-target=")) {
>+        usage(**argv);
>+    }
>+
>+    target_name += strlen("--fuzz-target=");
>+
>+    fuzz_target = fuzz_get_target(target_name);
>+    if (!fuzz_target) {
>+        usage(**argv);
>+    }
>+
>+    fuzz_qts = qtest_setup();
>+
>+    if (fuzz_target->pre_vm_init) {
>+        fuzz_target->pre_vm_init();
>+    }
>+
>+    /* Run QEMU's softmmu main with the fuzz-target dependent arguments */
>+    const char *init_cmdline = fuzz_target->get_init_cmdline(fuzz_target);
>+
>+    /* Split the runcmd into an argv and argc */
>+    wordexp_t result;
>+    wordexp(init_cmdline, &result, 0);
>+
>+    qemu_init(result.we_wordc, result.we_wordv, NULL);
>+
>+    return 0;
>+}
>diff --git a/tests/qtest/fuzz/fuzz.h b/tests/qtest/fuzz/fuzz.h
>new file mode 100644
>index 0000000000..03901d414e
>--- /dev/null
>+++ b/tests/qtest/fuzz/fuzz.h
>@@ -0,0 +1,95 @@
>+/*
>+ * fuzzing driver
>+ *
>+ * Copyright Red Hat Inc., 2019
>+ *
>+ * Authors:
>+ *  Alexander Bulekov   <alxndr@bu.edu>
>+ *
>+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
>+ * See the COPYING file in the top-level directory.
>+ *
>+ */
>+
>+#ifndef FUZZER_H_
>+#define FUZZER_H_
>+
>+#include "qemu/osdep.h"
>+#include "qemu/units.h"
>+#include "qapi/error.h"
>+
>+#include "tests/qtest/libqtest.h"
>+
>+/**
>+ * A libfuzzer fuzzing target
>+ *
>+ * The QEMU fuzzing binary is built with all available targets, each
>+ * with a unique @name that can be specified on the command-line to
>+ * select which target should run.
>+ *
>+ * A target must implement ->fuzz() to process a random input.  If QEMU
>+ * crashes in ->fuzz() then libfuzzer will record a failure.
>+ *
>+ * Fuzzing targets are registered with fuzz_add_target():
>+ *
>+ *   static const FuzzTarget fuzz_target = {
>+ *       .name = "my-device-fifo",
>+ *       .description = "Fuzz the FIFO buffer registers of my-device",
>+ *       ...
>+ *   };
>+ *
>+ *   static void register_fuzz_target(void)
>+ *   {
>+ *       fuzz_add_target(&fuzz_target);
>+ *   }
>+ *   fuzz_target_init(register_fuzz_target);
>+ */
>+typedef struct FuzzTarget {
>+    const char *name;         /* target identifier (passed to --fuzz-target=)*/
>+    const char *description;  /* help text */
>+
>+
>+    /*
>+     * returns the arg-list that is passed to qemu/softmmu init()
>+     * Cannot be NULL
>+     */
>+    const char* (*get_init_cmdline)(struct FuzzTarget *);
>+
>+    /*
>+     * will run once, prior to running qemu/softmmu init.
>+     * eg: set up shared-memory for communication with the child-process
>+     * Can be NULL
>+     */
>+    void(*pre_vm_init)(void);
>+
>+    /*
>+     * will run once, after QEMU has been initialized, prior to the fuzz-loop.
>+     * eg: detect the memory map
>+     * Can be NULL
>+     */
>+    void(*pre_fuzz)(QTestState *);
>+
>+    /*
>+     * accepts and executes an input from libfuzzer. this is repeatedly
>+     * executed during the fuzzing loop. Its should handle setup, input
>+     * execution and cleanup.
>+     * Cannot be NULL
>+     */
>+    void(*fuzz)(QTestState *, const unsigned char *, size_t);
>+
>+} FuzzTarget;
>+
>+void flush_events(QTestState *);
>+void reboot(QTestState *);
>+
>+/*
>+ * makes a copy of *target and adds it to the target-list.
>+ * i.e. fine to set up target on the caller's stack
>+ */
>+void fuzz_add_target(const FuzzTarget *target);
>+
>+int LLVMFuzzerTestOneInput(const unsigned char *Data, size_t Size);
>+int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp);
>+
>+#endif
>+
>-- 
>2.23.0
>
>

