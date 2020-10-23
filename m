Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0D1C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 20:11:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B858E2074B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 20:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PozgcYe5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B858E2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW3PY-0001Qa-Au
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 16:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kW3LB-0004mu-PV
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 16:07:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63408
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kW3L9-0003jZ-H3
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 16:07:09 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09NK2F0J129000; Fri, 23 Oct 2020 16:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=C5YTzriKKSoE/1Li/eahOuIiN7OD3uue9rzSUpEG8hc=;
 b=PozgcYe5gKQC+2hwXv/RYDibirUn4eaxWLoAi4Mut/K9TMiEknTEG0OfR+uI6HwCjLo4
 KJm1UplVW7lExNDflNO32ecZHDJbYfpojsyImQxfKvylXeCkJxuRMyQRkOqlDTXmvFyh
 S8v5Bry4CWNF0le4eqezt/DpDMwnXPAXjhXRhd25f9lf3rdW+xZHZUTMlWgLqXSM1o+2
 Z8cK6g4vtR3PWb9HJ1ByLW2ROs+OmCZh400C6rmxtsHA9zDV7a5DqMF/YD7kqXnfoJLB
 XAI/KyGyCyJKWhzYF/bNZM8AV3VyZn8JtsbbjZli/esSFskdBEWvhOQMgWekoNQ0SKFw 3Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 34c1ct8mr4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2020 16:07:05 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09NK2GtT129119;
 Fri, 23 Oct 2020 16:07:04 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0b-001b2d01.pphosted.com with ESMTP id 34c1ct8mqq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2020 16:07:04 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09NK71wB027543;
 Fri, 23 Oct 2020 20:07:03 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma01dal.us.ibm.com with ESMTP id 34bhyqhat7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2020 20:07:03 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09NK72FO49217870
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Oct 2020 20:07:02 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9691F6A047;
 Fri, 23 Oct 2020 20:07:02 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F2076A04D;
 Fri, 23 Oct 2020 20:07:01 +0000 (GMT)
Received: from Buonos-Thinkpad-X1.ibm.com (unknown [9.65.212.19])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 23 Oct 2020 20:07:01 +0000 (GMT)
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/6] cfi: Initial support for cfi-icall in QEMU
Date: Fri, 23 Oct 2020 16:06:42 -0400
Message-Id: <20201023200645.1055-5-dbuono@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201023200645.1055-1-dbuono@linux.vnet.ibm.com>
References: <20201023200645.1055-1-dbuono@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.737
 definitions=2020-10-23_14:2020-10-23,
 2020-10-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 impostorscore=0 mlxscore=0 suspectscore=3 clxscore=1011 priorityscore=1501
 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010230119
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 16:07:01
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Alexander Bulekov <alxndr@bu.edu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Daniele Buono <dbuono@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

LLVM/Clang, supports runtime checks for forward-edge Control-Flow
Integrity (CFI).

CFI on indirect function calls (cfi-icall) ensures that, in indirect
function calls, the function called is of the right signature for the
pointer type defined at compile time.

For this check to work, the code must always respect the function
signature when using function pointer, the function must be defined
at compile time, and be compiled with link-time optimization.

This rules out, for example, shared libraries that are dynamically loaded
(given that functions are not known at compile time), and code that is
dynamically generated at run-time.

This patch:

1) Introduces the CONFIG_CFI flag to support cfi in QEMU

2) Introduces a decorator to allow the definition of "sensitive"
functions, where a non-instrumented function may be called at runtime
through a pointer. The decorator will take care of disabling cfi-icall
checks on such functions, when cfi is enabled.

3) Marks functions currently in QEMU that exhibit such behavior,
in particular:
- The function in TCG that calls pre-compiled TBs
- The function in TCI that interprets instructions
- Functions in the plugin infrastructures that jump to callbacks
- Functions in util that directly call a signal handler

4) Add a new section in MAINTAINERS with me as a maintainer for
include/qemu/sanitizers.h, in case a maintainer is deemed
necessary for this feature

Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
---
 MAINTAINERS               |  5 +++++
 accel/tcg/cpu-exec.c      |  9 +++++++++
 include/qemu/sanitizers.h | 22 ++++++++++++++++++++++
 plugins/core.c            | 25 +++++++++++++++++++++++++
 plugins/loader.c          |  5 +++++
 tcg/tci.c                 |  5 +++++
 util/main-loop.c          |  9 +++++++++
 util/oslib-posix.c        |  9 +++++++++
 8 files changed, 89 insertions(+)
 create mode 100644 include/qemu/sanitizers.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6a197bd358..93b2b52b88 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3094,6 +3094,11 @@ S: Maintained
 F: hw/semihosting/
 F: include/hw/semihosting/
 
+Control Flow Integrity
+M: Daniele Buono <dbuono@linux.vnet.ibm.com>
+S: Maintained
+F: include/qemu/sanitizers.h
+
 Build and test automation
 -------------------------
 Build and test automation
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 58aea605d8..efa01c51db 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -26,6 +26,7 @@
 #include "exec/exec-all.h"
 #include "tcg/tcg.h"
 #include "qemu/atomic.h"
+#include "qemu/sanitizers.h"
 #include "sysemu/qtest.h"
 #include "qemu/timer.h"
 #include "qemu/rcu.h"
@@ -144,6 +145,14 @@ static void init_delay_params(SyncClocks *sc, const CPUState *cpu)
 #endif /* CONFIG USER ONLY */
 
 /* Execute a TB, and fix up the CPU state afterwards if necessary */
+/* Disable CFI checks.
+ * TCG creates binary blobs at runtime, with the transformed code.
+ * A TB is a blob of binary code, created at runtime and called with an
+ * indirect function call. Since such function did not exist at compile time,
+ * the CFI runtime has no way to verify its signature and would fail.
+ * TCG is not considered a security-sensitive part of QEMU so this does not
+ * affect the impact of CFI in environment with high security requirements */
+__disable_cfi__
 static inline tcg_target_ulong cpu_tb_exec(CPUState *cpu, TranslationBlock *itb)
 {
     CPUArchState *env = cpu->env_ptr;
diff --git a/include/qemu/sanitizers.h b/include/qemu/sanitizers.h
new file mode 100644
index 0000000000..31e404d58d
--- /dev/null
+++ b/include/qemu/sanitizers.h
@@ -0,0 +1,22 @@
+/*
+ * Decorators to disable sanitizers on specific functions
+ *
+ * Copyright IBM Corp., 2020
+ *
+ * Author:
+ *  Daniele Buono <dbuono@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifdef CONFIG_CFI
+/* If CFI is enabled, use an attribute to disable cfi-icall on the following
+ * function */
+#define __disable_cfi__ __attribute__((no_sanitize("cfi-icall")))
+#else
+/* If CFI is not enabled, use an empty define to not change the behavior */
+#define __disable_cfi__
+#endif
+
diff --git a/plugins/core.c b/plugins/core.c
index 51bfc94787..9b712ca4ac 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -31,6 +31,7 @@
 #include "tcg/tcg-op.h"
 #include "trace/mem-internal.h" /* mem_info macros */
 #include "plugin.h"
+#include "qemu/sanitizers.h"
 
 struct qemu_plugin_cb {
     struct qemu_plugin_ctx *ctx;
@@ -90,6 +91,10 @@ void plugin_unregister_cb__locked(struct qemu_plugin_ctx *ctx,
     }
 }
 
+/* Disable CFI checks.
+ * The callback function has been loaded from an external library so we do not
+ * have type information */
+__disable_cfi__
 static void plugin_vcpu_cb__simple(CPUState *cpu, enum qemu_plugin_event ev)
 {
     struct qemu_plugin_cb *cb, *next;
@@ -111,6 +116,10 @@ static void plugin_vcpu_cb__simple(CPUState *cpu, enum qemu_plugin_event ev)
     }
 }
 
+/* Disable CFI checks.
+ * The callback function has been loaded from an external library so we do not
+ * have type information */
+__disable_cfi__
 static void plugin_cb__simple(enum qemu_plugin_event ev)
 {
     struct qemu_plugin_cb *cb, *next;
@@ -128,6 +137,10 @@ static void plugin_cb__simple(enum qemu_plugin_event ev)
     }
 }
 
+/* Disable CFI checks.
+ * The callback function has been loaded from an external library so we do not
+ * have type information */
+__disable_cfi__
 static void plugin_cb__udata(enum qemu_plugin_event ev)
 {
     struct qemu_plugin_cb *cb, *next;
@@ -325,6 +338,10 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
     dyn_cb->f.generic = cb;
 }
 
+/* Disable CFI checks.
+ * The callback function has been loaded from an external library so we do not
+ * have type information */
+__disable_cfi__
 void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *tb)
 {
     struct qemu_plugin_cb *cb, *next;
@@ -339,6 +356,10 @@ void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *tb)
     }
 }
 
+/* Disable CFI checks.
+ * The callback function has been loaded from an external library so we do not
+ * have type information */
+__disable_cfi__
 void
 qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
                          uint64_t a3, uint64_t a4, uint64_t a5,
@@ -358,6 +379,10 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
     }
 }
 
+/* Disable CFI checks.
+ * The callback function has been loaded from an external library so we do not
+ * have type information */
+__disable_cfi__
 void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
 {
     struct qemu_plugin_cb *cb, *next;
diff --git a/plugins/loader.c b/plugins/loader.c
index 8ac5dbc20f..d193c5772e 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -32,6 +32,7 @@
 #ifndef CONFIG_USER_ONLY
 #include "hw/boards.h"
 #endif
+#include "qemu/sanitizers.h"
 
 #include "plugin.h"
 
@@ -150,6 +151,10 @@ static uint64_t xorshift64star(uint64_t x)
     return x * UINT64_C(2685821657736338717);
 }
 
+/* Disable CFI checks.
+ * The install and version functions have been loaded from an external library
+ * so we do not have type information */
+__disable_cfi__
 static int plugin_load(struct qemu_plugin_desc *desc, const qemu_info_t *info)
 {
     qemu_plugin_install_func_t install;
diff --git a/tcg/tci.c b/tcg/tci.c
index 82039fd163..b82cae3d24 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -31,6 +31,7 @@
 #include "tcg/tcg.h"           /* MAX_OPC_PARAM_IARGS */
 #include "exec/cpu_ldst.h"
 #include "tcg/tcg-op.h"
+#include "qemu/sanitizers.h"
 
 /* Marker for missing code. */
 #define TODO() \
@@ -475,6 +476,10 @@ static bool tci_compare64(uint64_t u0, uint64_t u1, TCGCond condition)
 #endif
 
 /* Interpret pseudo code in tb. */
+/* Disable CFI checks.
+ * One possible operation in the pseudo code is a call to binary code.
+ * Therefore, disable CFI checks in the interpreter function */
+__disable_cfi__
 uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
 {
     tcg_target_ulong regs[TCG_TARGET_NB_REGS];
diff --git a/util/main-loop.c b/util/main-loop.c
index 6470f8eae3..610ef26cb0 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -33,6 +33,7 @@
 #include "block/aio.h"
 #include "qemu/error-report.h"
 #include "qemu/queue.h"
+#include "qemu/sanitizers.h"
 
 #ifndef _WIN32
 #include <sys/wait.h>
@@ -44,6 +45,14 @@
  * use signalfd to listen for them.  We rely on whatever the current signal
  * handler is to dispatch the signals when we receive them.
  */
+/* Disable CFI checks.
+ * We are going to call a signal hander directly. Such handler may or may not
+ * have been defined in our binary, so there's no guarantee that the pointer
+ * used to set the handler is a cfi-valid pointer. Since the handlers are
+ * stored in kernel memory, changing the handler to an attacker-defined
+ * function requires being able to call a sigaction() syscall,
+ * which is not as easy as overwriting a pointer in memory. */
+__disable_cfi__
 static void sigfd_handler(void *opaque)
 {
     int fd = (intptr_t)opaque;
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index f15234b5c0..099c50acc1 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -39,6 +39,7 @@
 #include "qemu/thread.h"
 #include <libgen.h>
 #include "qemu/cutils.h"
+#include "qemu/sanitizers.h"
 
 #ifdef CONFIG_LINUX
 #include <sys/syscall.h>
@@ -773,6 +774,14 @@ void qemu_free_stack(void *stack, size_t sz)
     munmap(stack, sz);
 }
 
+/* Disable CFI checks.
+ * We are going to call a signal hander directly. Such handler may or may not
+ * have been defined in our binary, so there's no guarantee that the pointer
+ * used to set the handler is a cfi-valid pointer. Since the handlers are
+ * stored in kernel memory, changing the handler to an attacker-defined
+ * function requires being able to call a sigaction() syscall,
+ * which is not as easy as overwriting a pointer in memory. */
+__disable_cfi__
 void sigaction_invoke(struct sigaction *action,
                       struct qemu_signalfd_siginfo *info)
 {
-- 
2.17.1


