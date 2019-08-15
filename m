Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A307C433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 03:00:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 140C02084F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 03:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JV+g1OgZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140C02084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy604-0001Hq-65
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 23:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vandersonmr2@gmail.com>) id 1hy5e5-0006iM-T4
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:37:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1hy5e4-0006Xu-4s
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:37:45 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:39771)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1hy5e4-0006XW-0J
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:37:44 -0400
Received: by mail-qk1-x741.google.com with SMTP id 125so784853qkl.6
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7PSdejEU6nOjvtVAT4ESUG+7JrlxyYioJbT+TnDMWaQ=;
 b=JV+g1OgZW0iYc5DcTWkHtBCe7AEsl+n7bkIikOpP3yABiXxsiuHMvhMPZ4NXhMrS9G
 j5pTN5roOkc01rtmCfJrC+Kz+/Hemxj8nhWEYAwSxn5xeE/fLkUkDcCj4URt/+AQSt1S
 NsTHsVvl5Pyt9aggLpfdpbq3ianUKeWCTIDnmSC6OZUQfloQU56zw5FbvyOAD7KVXxa2
 lW109KveAOJWBmNFSfaT6FBqxnFBankkt5rniM6bLPownpiymg5l1GWiiP7ir/OefJqV
 E8nn57BIV7iead2A2PeEQNxbz790wRd0RFbgsOefuiWNr3kdsx3BmfCYu8MB12Jpez2a
 PV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7PSdejEU6nOjvtVAT4ESUG+7JrlxyYioJbT+TnDMWaQ=;
 b=nUrxyJtBz5B7aIrGAY7JXKqQjxAGYSz6+Y/I1Jr6zP53RIBEdE9jiJcHQXV4MwGWx6
 XN+goFVMUCfbQLOZxWnxLGv4ui9f00F6rhjhRDxv6ylMcE0J57k/CMOwpqgdvitQRL/F
 FLU6KsKrt96xwVejUC/Fc2+zdJ5fqbbg8r+NiZAepfHNZ4Ts5KBYMgB9n6s0THIrCVfT
 +xRn+2KuQ2676CgjonObUTcafyPUxrbeQkHQU0k9Xj6Rq52w5MURpEOIlr/A26HZ5Gmd
 bQnD+EI0ImeV+GKvV7pHUgCnBtcH65k0sVPiZZVCJWNzsAEMV8ekfg+ccnkYKeO0mPY8
 mMnQ==
X-Gm-Message-State: APjAAAWZNG8/vb3RvguhTVGSNoGT/Xg2mykLvzwtB0Hg3sWpfKpUE+cC
 wvvzthlPQKZ3j9oLuM27MUxEpJEr3Gd11g==
X-Google-Smtp-Source: APXvYqyXR+MphWeBfl0gVyOpXTv9mC6gj3xqGguQIM+EaZTYADl7pLCQo99bbEoeGvhmlrsIZKxoMQ==
X-Received: by 2002:a37:94c4:: with SMTP id w187mr2163782qkd.292.1565836663175; 
 Wed, 14 Aug 2019 19:37:43 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:121::1])
 by smtp.googlemail.com with ESMTPSA id t24sm764052qto.69.2019.08.14.19.37.41
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:37:42 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 23:37:24 -0300
Message-Id: <20190815023725.2659-2-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190815023725.2659-1-vandersonmr2@gmail.com>
References: <20190815023725.2659-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
Subject: [Qemu-devel] [PATCH v1 1/2] accel/tcg: adding integration with
 linux perf
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 vandersonmr <vandersonmr2@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This commit adds support to Linux Perf in order
to be able to analyze qemu jitted code and
also to able to see the TBs PC in it.

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
---
 accel/tcg/Makefile.objs      |   1 +
 accel/tcg/perf/Makefile.objs |   1 +
 accel/tcg/perf/jitdump.c     | 180 +++++++++++++++++++++++++++++++++++
 accel/tcg/perf/jitdump.h     |  19 ++++
 accel/tcg/translate-all.c    |  12 +++
 include/qemu-common.h        |   3 +
 linux-user/main.c            |   7 ++
 qemu-options.hx              |  12 +++
 8 files changed, 235 insertions(+)
 create mode 100644 accel/tcg/perf/Makefile.objs
 create mode 100644 accel/tcg/perf/jitdump.c
 create mode 100644 accel/tcg/perf/jitdump.h

diff --git a/accel/tcg/Makefile.objs b/accel/tcg/Makefile.objs
index d381a02f34..f393a7438f 100644
--- a/accel/tcg/Makefile.objs
+++ b/accel/tcg/Makefile.objs
@@ -3,6 +3,7 @@ obj-$(CONFIG_SOFTMMU) += cputlb.o
 obj-y += tcg-runtime.o tcg-runtime-gvec.o
 obj-y += cpu-exec.o cpu-exec-common.o translate-all.o
 obj-y += translator.o
+obj-y += perf/
 
 obj-$(CONFIG_USER_ONLY) += user-exec.o
 obj-$(call lnot,$(CONFIG_SOFTMMU)) += user-exec-stub.o
diff --git a/accel/tcg/perf/Makefile.objs b/accel/tcg/perf/Makefile.objs
new file mode 100644
index 0000000000..f82fba35e5
--- /dev/null
+++ b/accel/tcg/perf/Makefile.objs
@@ -0,0 +1 @@
+obj-y += jitdump.o
diff --git a/accel/tcg/perf/jitdump.c b/accel/tcg/perf/jitdump.c
new file mode 100644
index 0000000000..6f4c0911c2
--- /dev/null
+++ b/accel/tcg/perf/jitdump.c
@@ -0,0 +1,180 @@
+#ifdef __linux__
+
+#include <stdint.h>
+
+#include <stdio.h>
+#include <unistd.h>
+#include <time.h>
+#include <sys/syscall.h>
+#include <elf.h>
+
+#include "jitdump.h"
+#include "qemu-common.h"
+
+struct jitheader {
+    uint32_t magic;     /* characters "jItD" */
+    uint32_t version;   /* header version */
+    uint32_t total_size;/* total size of header */
+    uint32_t elf_mach;  /* elf mach target */
+    uint32_t pad1;      /* reserved */
+    uint32_t pid;       /* JIT process id */
+    uint64_t timestamp; /* timestamp */
+    uint64_t flags;     /* flags */
+};
+
+enum jit_record_type {
+    JIT_CODE_LOAD       = 0,
+    JIT_CODE_MOVE       = 1,
+    JIT_CODE_DEBUG_INFO = 2,
+    JIT_CODE_CLOSE      = 3,
+
+    JIT_CODE_MAX,
+};
+
+/* record prefix (mandatory in each record) */
+struct jr_prefix {
+    uint32_t id;
+    uint32_t total_size;
+    uint64_t timestamp;
+};
+
+struct jr_code_load {
+    struct jr_prefix p;
+
+    uint32_t pid;
+    uint32_t tid;
+    uint64_t vma;
+    uint64_t code_addr;
+    uint64_t code_size;
+    uint64_t code_index;
+};
+
+struct jr_code_close {
+    struct jr_prefix p;
+};
+
+struct jr_code_move {
+    struct jr_prefix p;
+
+    uint32_t pid;
+    uint32_t tid;
+    uint64_t vma;
+    uint64_t old_code_addr;
+    uint64_t new_code_addr;
+    uint64_t code_size;
+    uint64_t code_index;
+};
+
+FILE *dumpfile;
+void *perf_marker;
+
+static uint64_t get_timestamp(void)
+{
+    struct timespec ts;
+    if (clock_gettime(CLOCK_MONOTONIC, &ts)) {
+        fprintf(stderr, "No support for CLOCK_MONOTONIC! -perf cannot be used!\n");
+        exit(1);
+    }
+    return (uint64_t) ts.tv_sec * 1000000000 + ts.tv_nsec;
+}
+
+static uint32_t get_e_machine(void)
+{
+    uint32_t e_machine = EM_NONE;
+    Elf64_Ehdr elf_header;
+    FILE *exe = fopen("/proc/self/exe", "r");
+
+    if (exe == NULL) {
+        return e_machine;
+    }
+
+    if (fread(&elf_header, sizeof(Elf64_Ehdr), 1, exe) != 1) {
+        goto end;
+    }
+
+    e_machine = elf_header.e_machine;
+
+end:
+    fclose(exe);
+    return e_machine;
+}
+
+void start_jitdump_file(void)
+{
+    GString *dumpfile_name = g_string_new(NULL);;
+    g_string_printf(dumpfile_name, "./jit-%d.dump", getpid());
+    dumpfile = fopen(dumpfile_name->str, "w+");
+
+    perf_marker = mmap(NULL, sysconf(_SC_PAGESIZE),
+                          PROT_READ | PROT_EXEC,
+                          MAP_PRIVATE,
+                          fileno(dumpfile), 0);
+
+    if (perf_marker == MAP_FAILED) {
+        printf("Failed to create mmap marker file for perf %d\n", fileno(dumpfile));
+        fclose(dumpfile);
+        return;
+    }
+
+    g_string_free(dumpfile_name, TRUE);
+
+    struct jitheader *header = g_new0(struct jitheader, 1);
+    header->magic = 0x4A695444;
+    header->version = 1;
+    header->elf_mach = get_e_machine();
+    header->total_size = sizeof(struct jitheader);
+    header->pid = getpid();
+    header->timestamp = get_timestamp();
+
+    fwrite(header, header->total_size, 1, dumpfile);
+
+    free(header);
+    fflush(dumpfile);
+}
+
+void append_load_in_jitdump_file(TranslationBlock *tb)
+{
+    GString *func_name = g_string_new(NULL);
+    g_string_printf(func_name, "TB virt:0x"TARGET_FMT_lx"%c", tb->pc, '\0');
+
+    struct jr_code_load *load_event = g_new0(struct jr_code_load, 1);
+    load_event->p.id = JIT_CODE_LOAD;
+    load_event->p.total_size = sizeof(struct jr_code_load) + func_name->len + tb->tc.size;
+    load_event->p.timestamp = get_timestamp();
+    load_event->pid = getpid();
+    load_event->tid = syscall(SYS_gettid);
+    load_event->vma = tb->pc;
+    load_event->code_addr = (uint64_t) tb->tc.ptr;
+    load_event->code_size = tb->tc.size;
+    load_event->code_index = tb->pc;
+
+    fwrite(load_event, sizeof(struct jr_code_load), 1, dumpfile);
+    fwrite(func_name->str, func_name->len, 1, dumpfile);
+    fwrite(tb->tc.ptr, tb->tc.size, 1, dumpfile);
+
+    g_string_free(func_name, TRUE);
+    free(load_event);
+    fflush(dumpfile);
+}
+
+void close_jitdump_file(void)
+{
+    fclose(dumpfile);
+    if (perf_marker != MAP_FAILED) {
+        munmap(perf_marker, sysconf(_SC_PAGESIZE));
+    }
+}
+
+bool is_jitdump_enabled;
+
+void jitdump_enable(void)
+{
+    is_jitdump_enabled = true;
+}
+
+bool jitdump_enabled(void)
+{
+    return is_jitdump_enabled;
+}
+
+#endif
diff --git a/accel/tcg/perf/jitdump.h b/accel/tcg/perf/jitdump.h
new file mode 100644
index 0000000000..12c0991b04
--- /dev/null
+++ b/accel/tcg/perf/jitdump.h
@@ -0,0 +1,19 @@
+#ifdef __linux__
+#ifndef JITDUMP_H
+#define JITDUMP_H
+
+#include "qemu/osdep.h"
+
+#include "disas/disas.h"
+#include "exec/exec-all.h"
+
+void start_jitdump_file(void);
+
+void append_load_in_jitdump_file(TranslationBlock *tb);
+void append_move_in_jitdump_file(TranslationBlock *tb);
+
+void close_jitdump_file(void);
+
+#endif
+
+#endif
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 5d1e08b169..0a4211d3d2 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -58,6 +58,8 @@
 #include "sysemu/cpus.h"
 #include "sysemu/tcg.h"
 
+#include "perf/jitdump.h"
+
 /* #define DEBUG_TB_INVALIDATE */
 /* #define DEBUG_TB_FLUSH */
 /* make various TB consistency checks */
@@ -1148,6 +1150,11 @@ void tcg_exec_init(unsigned long tb_size)
     cpu_gen_init();
     page_init();
     tb_htable_init();
+#ifdef __linux__
+    if (jitdump_enabled()) {
+        start_jitdump_file();
+    }
+#endif
     code_gen_alloc(tb_size);
 #if defined(CONFIG_SOFTMMU)
     /* There's no guest base to take into account, so go ahead and
@@ -1877,6 +1884,11 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
         return existing_tb;
     }
     tcg_tb_insert(tb);
+#ifdef __linux__
+    if (jitdump_enabled()) {
+        append_load_in_jitdump_file(tb);
+    }
+#endif
     return tb;
 }
 
diff --git a/include/qemu-common.h b/include/qemu-common.h
index 0235cd3b91..bd564a9e5c 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -130,4 +130,7 @@ void page_size_init(void);
  * returned. */
 bool dump_in_progress(void);
 
+void jitdump_enable(void);
+bool jitdump_enabled(void);
+
 #endif
diff --git a/linux-user/main.c b/linux-user/main.c
index 8ffc525195..6521cf0c68 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -378,6 +378,11 @@ static void handle_arg_strace(const char *arg)
     do_strace = 1;
 }
 
+static void handle_arg_perf(const char *arg)
+{
+    jitdump_enable();
+}
+
 static void handle_arg_version(const char *arg)
 {
     printf("qemu-" TARGET_NAME " version " QEMU_FULL_VERSION
@@ -443,6 +448,8 @@ static const struct qemu_argument arg_table[] = {
      "",           "Seed for pseudo-random number generator"},
     {"trace",      "QEMU_TRACE",       true,  handle_arg_trace,
      "",           "[[enable=]<pattern>][,events=<file>][,file=<file>]"},
+    {"perf",      "QEMU_PERF",         false, handle_arg_perf,
+     "",           "dump jitdump files to help linux perf JIT code visualization"},
     {"version",    "QEMU_VERSION",     false, handle_arg_version,
      "",           "display version information and exit"},
     {NULL, NULL, false, NULL, NULL, NULL}
diff --git a/qemu-options.hx b/qemu-options.hx
index 9621e934c0..1c26eeeb9c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4147,6 +4147,18 @@ STEXI
 Enable FIPS 140-2 compliance mode.
 ETEXI
 
+#ifdef __linux__
+DEF("perf", 0, QEMU_OPTION_perf,
+    "-perf    dump jitdump files to help linux perf JIT code visualization\n",
+    QEMU_ARCH_ALL)
+#endif
+STEXI
+@item -perf
+@findex -perf
+Dumps jitdump files to help linux perf JIT code visualization
+ETEXI
+
+
 HXCOMM Deprecated by -machine accel=tcg property
 DEF("no-kvm", 0, QEMU_OPTION_no_kvm, "", QEMU_ARCH_I386)
 
-- 
2.22.0


