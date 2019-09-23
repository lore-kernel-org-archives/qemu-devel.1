Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B60C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:59:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E74220578
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DxRA7dYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E74220578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCPoP-0004cA-Fr
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 10:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1iCPmm-0002qZ-4f
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:57:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1iCPmk-00052l-Nl
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:57:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47126)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1iCPmj-00051U-RU
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:57:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8NErugs142898;
 Mon, 23 Sep 2019 14:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=R0/jEg5jJTQGW0zuYYANk3tamFjG4Ejjn3PnInEGSjI=;
 b=DxRA7dYkgibU/CThW9N2p4UvyH/r9qJbN/2bGGtR/TueXM/E6I8HtQKX5FVFCUeDhqts
 rM7aRQqo6X+E8zs53HgK1mST9N7xu+iSc2qSR3R9heiQXgLUtgoXUuQ0V8TT7dB1+IOV
 i3reLA4n+KSWC0Gk36N8UVGXPUQXqQJ2Nc7KSvSpLbWVDgMvcGmNmD6Cl2/WupqpgHHJ
 WalrVTSukDDQYEgef3avIB1JMm3W8Ly5LsVVHdQHzkEKiB3Id1Q23P9BGJCPPada8O1p
 Tz1iF2Pi8LpZitsyx8q4fiy0DckNK8toMgHmQ7Q69KH7+DRHj/htULcRB9Z99aBCVkTp 1Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2v5b9tfh2e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Sep 2019 14:57:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8NErkxM178961;
 Mon, 23 Sep 2019 14:55:50 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 2v6yvn11ds-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Sep 2019 14:55:50 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8NEtn9o032505;
 Mon, 23 Sep 2019 14:55:49 GMT
Received: from starbug-lenovo.ie.oracle.com (/10.169.104.251)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 23 Sep 2019 07:55:48 -0700
Date: Mon, 23 Sep 2019 15:55:46 +0100
From: Darren Kenny <darren.kenny@oracle.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [Qemu-devel] [PATCH v3 16/22] fuzz: add fuzzer skeleton
Message-ID: <20190923145546.w7cy6jyaqeqi3b45@starbug-lenovo.ie.oracle.com>
Mail-Followup-To: "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
References: <20190918231846.22538-1-alxndr@bu.edu>
 <20190918231846.22538-17-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20190918231846.22538-17-alxndr@bu.edu>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9389
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909230142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9389
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909230142
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
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
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 18, 2019 at 11:19:43PM +0000, Oleinik, Alexander wrote:
>tests/fuzz/fuzz.c serves as the entry point for the virtual-device
>fuzzer. Namely, libfuzzer invokes the LLVMFuzzerInitialize and
>LLVMFuzzerTestOneInput functions, both of which are defined in this
>file. This change adds a "FuzzTarget" struct, along with the
>fuzz_add_target function, which should be used to define new fuzz
>targets.
>
>Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
>---
> tests/fuzz/Makefile.include |   4 +-
> tests/fuzz/fuzz.c           | 179 ++++++++++++++++++++++++++++++++++++
> tests/fuzz/fuzz.h           |  30 ++++++
> 3 files changed, 211 insertions(+), 2 deletions(-)
> create mode 100644 tests/fuzz/fuzz.c
> create mode 100644 tests/fuzz/fuzz.h
>
>diff --git a/tests/fuzz/Makefile.include b/tests/fuzz/Makefile.include
>index 324e6c1433..b415b056b0 100644
>--- a/tests/fuzz/Makefile.include
>+++ b/tests/fuzz/Makefile.include
>@@ -1,4 +1,4 @@
>-# QEMU_PROG_FUZZ=qemu-fuzz-$(TARGET_NAME)$(EXESUF)
>+QEMU_PROG_FUZZ=qemu-fuzz-$(TARGET_NAME)$(EXESUF)
> fuzz-obj-y = $(libqos-obj-y)
> fuzz-obj-y += tests/libqtest.o
>-
>+fuzz-obj-y += tests/fuzz/fuzz.o
>diff --git a/tests/fuzz/fuzz.c b/tests/fuzz/fuzz.c
>new file mode 100644
>index 0000000000..833f436731
>--- /dev/null
>+++ b/tests/fuzz/fuzz.c
>@@ -0,0 +1,179 @@
>+#include "qemu/osdep.h"
>+
>+#include <stdio.h>
>+#include <stdlib.h>
>+
>+
>+#include "tests/libqtest.h"
>+#include "sysemu/qtest.h"
>+#include "fuzz.h"
>+#include "tests/libqos/qgraph.h"
>+#include "sysemu/runstate.h"
>+#include "sysemu/sysemu.h"
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
>+static bool trace;
>+
>+
>+void set_fuzz_target_args(int argc, char **argv)
>+{
>+    if (fuzz_target) {
>+        fuzz_target->main_argc = argc;
>+        fuzz_target->main_argv = argv;
>+    }
>+}
>+
>+void reboot(QTestState *s)
>+{
>+    qemu_system_reset(SHUTDOWN_CAUSE_GUEST_RESET);
>+}
>+
>+static QTestState *qtest_setup(void)
>+{
>+    qtest_server_set_tx_handler(&qtest_client_inproc_recv, NULL);
>+    return qtest_inproc_init(trace, fuzz_arch, &qtest_server_inproc_recv);
>+}
>+
>+void fuzz_add_target(const char *name, const char *description,
>+        FuzzTarget *target)
>+{
>+    FuzzTargetState *tmp;
>+    FuzzTargetState *target_state;
>+    if (!fuzz_target_list) {
>+        fuzz_target_list = g_new0(FuzzTargetList, 1);
>+    }
>+
>+    QSLIST_FOREACH(tmp, fuzz_target_list, target_list) {
>+        if (g_strcmp0(tmp->target->name->str, name) == 0) {
>+            fprintf(stderr, "Error: Fuzz target name %s already in use\n",
>+                    name);
>+            abort();
>+        }
>+    }
>+    target_state = g_new0(FuzzTargetState, 1);
>+    target_state->target = g_new0(FuzzTarget, 1);
>+    *(target_state->target) = *target;
>+    target_state->target->name = g_string_new(name);
>+    target_state->target->description = g_string_new(description);
>+    QSLIST_INSERT_HEAD(fuzz_target_list, target_state, target_list);
>+}
>+
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
>+        if (g_strcmp0(tmp->target->name->str, name) == 0) {
>+            break;
>+        }
>+    }
>+    return tmp->target;
>+}
>+
>+
>+static void usage(char *path)
>+{
>+    printf("Usage: %s --FUZZ_TARGET [LIBFUZZER ARGUMENTS]\n", path);
>+    printf("where --FUZZ_TARGET is one of:\n");
>+    FuzzTargetState *tmp;
>+    if (!fuzz_target_list) {
>+        fprintf(stderr, "Fuzz target list not initialized\n");
>+        abort();
>+    }
>+    QSLIST_FOREACH(tmp, fuzz_target_list, target_list) {
>+        printf(" --%s  : %s\n", tmp->target->name->str,
>+                tmp->target->description->str);
>+    }
>+    exit(0);
>+}
>+
>+
>+/* Executed for each fuzzing-input */
>+int LLVMFuzzerTestOneInput(const unsigned char *Data, size_t Size)
>+{
>+    if (fuzz_target->fuzz) {
>+        fuzz_target->fuzz(fuzz_qts, Data, Size);
>+    }
>+    return 0;
>+}
>+
>+/* Executed once, prior to fuzzing */
>+int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
>+{
>+
>+    char *target_name, *trace_qtest;
>+
>+    /* --trace is useful for outputting a log of qtest commands that trigger
>+     * a crash. The log can can then be replayed with a simple qtest script. */
>+    if (*argc > 2) {
>+        trace_qtest = (*argv)[2];
>+        if (strcmp(trace_qtest, "--trace") == 0) {
>+            trace = true;
>+        }
>+    }
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
>+    target_name += 2;
>+    fuzz_target = fuzz_get_target(target_name);
>+
>+    fuzz_qts = qtest_setup(void);

Shouldn't be passing void as an argument here, causes a build
failure for me.

Thanks,

Darren.

