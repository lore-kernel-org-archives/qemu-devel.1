Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAB8C388F7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 22:21:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8F4F206D4
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 22:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N01ua3Jk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F4F206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kandj-0000cy-Dl
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 17:21:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kanbY-0007FP-Sz
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 17:19:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31766)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kanbV-00041K-Gq
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 17:19:40 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0A5M33Lb049144; Thu, 5 Nov 2020 17:19:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=odZCzxgTRcMQ2DchUfi6h89JAhOqzq/bzlVGfblpgig=;
 b=N01ua3JkhZdEcnf7irIc25Sw8oIKQKQpkwO0lxwXEgJxdU79kVZitSyyL4NWYPXSIGlw
 nbNcQUa9PnTTAm2fvCEJmtrmXrFb4migkc0PppU50QTrL7fbG1eAwJuir/vMJo96MTkL
 /RGn8TqBNsOcTnqDF2rcy3X3uYegUTXxzG6sgqZW9z/khQKgtb5qiQ2mF8VEbynVHAGU
 ZdP13RTlcuutfksVV5S2xLMQWJvBvVOUiCSIOhKCjLte4PilwuZqazYwuBBv02u/KxkA
 9svPs/xLdqlurFp38n0p2Kb8+w03GD/SabEOOD1X5E8MEyvnBolT3c8jOb0LOE/+1lHV wg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34m8wwb21g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Nov 2020 17:19:35 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A5M3XN1051075;
 Thu, 5 Nov 2020 17:19:35 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34m8wwb21a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Nov 2020 17:19:34 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A5MBpab000532;
 Thu, 5 Nov 2020 22:19:34 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma04dal.us.ibm.com with ESMTP id 34h02mgc1j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Nov 2020 22:19:34 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0A5MJOL811403792
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Nov 2020 22:19:24 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EB54C6A051;
 Thu,  5 Nov 2020 22:19:32 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 58AC26A047;
 Thu,  5 Nov 2020 22:19:32 +0000 (GMT)
Received: from Buonos-Thinkpad-X1.ibm.com (unknown [9.65.222.173])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu,  5 Nov 2020 22:19:32 +0000 (GMT)
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
To: dbuono@linux.vnet.ibm.com, qemu-devel@nongnu.org
Subject: [PATCH v3 7/9] cfi: Initial support for cfi-icall in QEMU
Date: Thu,  5 Nov 2020 17:19:03 -0500
Message-Id: <20201105221905.1350-8-dbuono@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201105221905.1350-1-dbuono@linux.vnet.ibm.com>
References: <20201105221905.1350-1-dbuono@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-05_15:2020-11-05,
 2020-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=2
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011050141
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 17:19:16
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
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

Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org> for plugins
---
 accel/tcg/cpu-exec.c    | 11 +++++++++++
 include/qemu/compiler.h | 12 ++++++++++++
 plugins/core.c          | 37 +++++++++++++++++++++++++++++++++++++
 plugins/loader.c        |  7 +++++++
 tcg/tci.c               |  7 +++++++
 util/main-loop.c        | 11 +++++++++++
 util/oslib-posix.c      | 11 +++++++++++
 7 files changed, 96 insertions(+)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 58aea605d8..ffe0e1e3fb 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -26,6 +26,7 @@
 #include "exec/exec-all.h"
 #include "tcg/tcg.h"
 #include "qemu/atomic.h"
+#include "qemu/compiler.h"
 #include "sysemu/qtest.h"
 #include "qemu/timer.h"
 #include "qemu/rcu.h"
@@ -144,6 +145,16 @@ static void init_delay_params(SyncClocks *sc, const CPUState *cpu)
 #endif /* CONFIG USER ONLY */
 
 /* Execute a TB, and fix up the CPU state afterwards if necessary */
+/*
+ * Disable CFI checks.
+ * TCG creates binary blobs at runtime, with the transformed code.
+ * A TB is a blob of binary code, created at runtime and called with an
+ * indirect function call. Since such function did not exist at compile time,
+ * the CFI runtime has no way to verify its signature and would fail.
+ * TCG is not considered a security-sensitive part of QEMU so this does not
+ * affect the impact of CFI in environment with high security requirements
+ */
+QEMU_DISABLE_CFI
 static inline tcg_target_ulong cpu_tb_exec(CPUState *cpu, TranslationBlock *itb)
 {
     CPUArchState *env = cpu->env_ptr;
diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index c76281f354..c87c242063 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -243,4 +243,16 @@ extern void QEMU_NORETURN QEMU_ERROR("code path is reachable")
 #define qemu_build_not_reached()  g_assert_not_reached()
 #endif
 
+#ifdef CONFIG_CFI
+/*
+ * If CFI is enabled, use an attribute to disable cfi-icall on the following
+ * function
+ */
+#define QEMU_DISABLE_CFI __attribute__((no_sanitize("cfi-icall")))
+#else
+/* If CFI is not enabled, use an empty define to not change the behavior */
+#define QEMU_DISABLE_CFI
+#endif
+
+
 #endif /* COMPILER_H */
diff --git a/plugins/core.c b/plugins/core.c
index 51bfc94787..87b823bbc4 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -31,6 +31,7 @@
 #include "tcg/tcg-op.h"
 #include "trace/mem-internal.h" /* mem_info macros */
 #include "plugin.h"
+#include "qemu/compiler.h"
 
 struct qemu_plugin_cb {
     struct qemu_plugin_ctx *ctx;
@@ -90,6 +91,12 @@ void plugin_unregister_cb__locked(struct qemu_plugin_ctx *ctx,
     }
 }
 
+/*
+ * Disable CFI checks.
+ * The callback function has been loaded from an external library so we do not
+ * have type information
+ */
+QEMU_DISABLE_CFI
 static void plugin_vcpu_cb__simple(CPUState *cpu, enum qemu_plugin_event ev)
 {
     struct qemu_plugin_cb *cb, *next;
@@ -111,6 +118,12 @@ static void plugin_vcpu_cb__simple(CPUState *cpu, enum qemu_plugin_event ev)
     }
 }
 
+/*
+ * Disable CFI checks.
+ * The callback function has been loaded from an external library so we do not
+ * have type information
+ */
+QEMU_DISABLE_CFI
 static void plugin_cb__simple(enum qemu_plugin_event ev)
 {
     struct qemu_plugin_cb *cb, *next;
@@ -128,6 +141,12 @@ static void plugin_cb__simple(enum qemu_plugin_event ev)
     }
 }
 
+/*
+ * Disable CFI checks.
+ * The callback function has been loaded from an external library so we do not
+ * have type information
+ */
+QEMU_DISABLE_CFI
 static void plugin_cb__udata(enum qemu_plugin_event ev)
 {
     struct qemu_plugin_cb *cb, *next;
@@ -325,6 +344,12 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
     dyn_cb->f.generic = cb;
 }
 
+/*
+ * Disable CFI checks.
+ * The callback function has been loaded from an external library so we do not
+ * have type information
+ */
+QEMU_DISABLE_CFI
 void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *tb)
 {
     struct qemu_plugin_cb *cb, *next;
@@ -339,6 +364,12 @@ void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *tb)
     }
 }
 
+/*
+ * Disable CFI checks.
+ * The callback function has been loaded from an external library so we do not
+ * have type information
+ */
+QEMU_DISABLE_CFI
 void
 qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
                          uint64_t a3, uint64_t a4, uint64_t a5,
@@ -358,6 +389,12 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
     }
 }
 
+/*
+ * Disable CFI checks.
+ * The callback function has been loaded from an external library so we do not
+ * have type information
+ */
+QEMU_DISABLE_CFI
 void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
 {
     struct qemu_plugin_cb *cb, *next;
diff --git a/plugins/loader.c b/plugins/loader.c
index 8ac5dbc20f..fd491961de 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -32,6 +32,7 @@
 #ifndef CONFIG_USER_ONLY
 #include "hw/boards.h"
 #endif
+#include "qemu/compiler.h"
 
 #include "plugin.h"
 
@@ -150,6 +151,12 @@ static uint64_t xorshift64star(uint64_t x)
     return x * UINT64_C(2685821657736338717);
 }
 
+/*
+ * Disable CFI checks.
+ * The install and version functions have been loaded from an external library
+ * so we do not have type information
+ */
+QEMU_DISABLE_CFI
 static int plugin_load(struct qemu_plugin_desc *desc, const qemu_info_t *info)
 {
     qemu_plugin_install_func_t install;
diff --git a/tcg/tci.c b/tcg/tci.c
index 82039fd163..5d97b7c71c 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -31,6 +31,7 @@
 #include "tcg/tcg.h"           /* MAX_OPC_PARAM_IARGS */
 #include "exec/cpu_ldst.h"
 #include "tcg/tcg-op.h"
+#include "qemu/compiler.h"
 
 /* Marker for missing code. */
 #define TODO() \
@@ -475,6 +476,12 @@ static bool tci_compare64(uint64_t u0, uint64_t u1, TCGCond condition)
 #endif
 
 /* Interpret pseudo code in tb. */
+/*
+ * Disable CFI checks.
+ * One possible operation in the pseudo code is a call to binary code.
+ * Therefore, disable CFI checks in the interpreter function
+ */
+QEMU_DISABLE_CFI
 uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
 {
     tcg_target_ulong regs[TCG_TARGET_NB_REGS];
diff --git a/util/main-loop.c b/util/main-loop.c
index 6470f8eae3..6bfc7c46f5 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -33,6 +33,7 @@
 #include "block/aio.h"
 #include "qemu/error-report.h"
 #include "qemu/queue.h"
+#include "qemu/compiler.h"
 
 #ifndef _WIN32
 #include <sys/wait.h>
@@ -44,6 +45,16 @@
  * use signalfd to listen for them.  We rely on whatever the current signal
  * handler is to dispatch the signals when we receive them.
  */
+/*
+ * Disable CFI checks.
+ * We are going to call a signal hander directly. Such handler may or may not
+ * have been defined in our binary, so there's no guarantee that the pointer
+ * used to set the handler is a cfi-valid pointer. Since the handlers are
+ * stored in kernel memory, changing the handler to an attacker-defined
+ * function requires being able to call a sigaction() syscall,
+ * which is not as easy as overwriting a pointer in memory.
+ */
+QEMU_DISABLE_CFI
 static void sigfd_handler(void *opaque)
 {
     int fd = (intptr_t)opaque;
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index f15234b5c0..f1e2801b11 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -39,6 +39,7 @@
 #include "qemu/thread.h"
 #include <libgen.h>
 #include "qemu/cutils.h"
+#include "qemu/compiler.h"
 
 #ifdef CONFIG_LINUX
 #include <sys/syscall.h>
@@ -773,6 +774,16 @@ void qemu_free_stack(void *stack, size_t sz)
     munmap(stack, sz);
 }
 
+/*
+ * Disable CFI checks.
+ * We are going to call a signal hander directly. Such handler may or may not
+ * have been defined in our binary, so there's no guarantee that the pointer
+ * used to set the handler is a cfi-valid pointer. Since the handlers are
+ * stored in kernel memory, changing the handler to an attacker-defined
+ * function requires being able to call a sigaction() syscall,
+ * which is not as easy as overwriting a pointer in memory.
+ */
+QEMU_DISABLE_CFI
 void sigaction_invoke(struct sigaction *action,
                       struct qemu_signalfd_siginfo *info)
 {
-- 
2.17.1


