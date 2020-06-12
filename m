Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8CEC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 01:49:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94E5D20853
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 01:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sh9rj0Ze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E5D20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjYoe-0005sz-UN
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 21:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Zd7iXgMKCqoTUjQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--jkz.bounces.google.com>)
 id 1jjYlz-0000xD-Ds
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 21:46:23 -0400
Received: from mail-qk1-x749.google.com ([2607:f8b0:4864:20::749]:44709)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Zd7iXgMKCqoTUjQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--jkz.bounces.google.com>)
 id 1jjYlx-0001Up-C4
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 21:46:23 -0400
Received: by mail-qk1-x749.google.com with SMTP id j16so6800262qka.11
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 18:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=zrAZryzclMmQ2GnW3+4bij4G7St8PIqWiedWlSplzFg=;
 b=sh9rj0Ze7pugCxLZjpbqmMaoKlnzXdDEqx/0wdHHh9PVhw4JU8BVAU9wsvU9wzdJlS
 ePqKSE3IET/Y0oQuMhPvY+zLcJBGM+VmOFC0L+xzIYUtD91jkMN53kZ1q22nKXZR0X7C
 ckJMAcHT2f7K46LiAknyOzQnkRg0WrGvwRwWM7FpNOXDfsKFfQq61cB3AxUM/OUntXnz
 3HRqfbv9yyC6eNrF6rg1krmH3bJBFbf6AuvXeWAXa487ExLV02Z0j4ZkOr2EQNtw6I8f
 vO5tFuFVza2sg2qWpJ+LZ2pCWyVv7Fo7dmTCSp25BvsW6H7LCErYb+7rz8pYmSiIna4f
 IYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=zrAZryzclMmQ2GnW3+4bij4G7St8PIqWiedWlSplzFg=;
 b=UMvV0cRJ3Z79iaQhocj7/K0aLJ7mnfO+ONFriCr3w8BKlKkCuG9906V6MNbO0XpmcX
 sItLpM5AIndpwIu64RLQy+uM+LwLg0odeDE8YjBbRuFcKJQVFSoEoJg5AQx0g3XQ4ftG
 8Se68ngJB1tX9ViUppinEqlIH9a4iuJ6y8sVs9qTWB1uYekeiWAbVaiy3RLikXopUiMN
 VIssGI9q1BdYB/IFh9ygNz5oqW7T8Zz/7IgSK3mUKuKxTVdafy4Ivkpipz5Db135VfwF
 WqWKaZ/UA1ovVktZq8/NISPCSUb51tqh6KMfPzxTGnEjkeruwdoa1VSG4fmT3Nm6cb6Y
 jp2w==
X-Gm-Message-State: AOAM530iRx0+dTNVNv/Xbdf/HplfmFjJe7Ig3BlXwX6lNk/J80i8hsRw
 L6Gw0/UB2mS11erji7FfiIjetdKckQU5+REmcWOcPzJHgIaZFOv/j03jO+KCPIlMtBmABqp38Kr
 9HtTo42QDV7ywDsudHWj8LuxqP1q50XRzWQbh4tmMW+LGf2AHJnZl
X-Google-Smtp-Source: ABdhPJzeAyJjF03I50ifR/5PtDnbCByuW3dr6mY5DWWXG5piARCTwYxjHYUyEDMxEGJFh1LCFlWtfWc=
X-Received: by 2002:a05:6214:846:: with SMTP id
 dg6mr9942730qvb.210.1591926373252; 
 Thu, 11 Jun 2020 18:46:13 -0700 (PDT)
Date: Thu, 11 Jun 2020 18:46:03 -0700
In-Reply-To: <20200612014606.147691-1-jkz@google.com>
Message-Id: <20200612014606.147691-3-jkz@google.com>
Mime-Version: 1.0
References: <20200612014606.147691-1-jkz@google.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH 2/5] linux-user: Make fd_trans task-specific.
From: Josh Kunz <jkz@google.com>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, laurent@vivier.eu, alex.bennee@linaro.org, 
 Josh Kunz <jkz@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::749;
 envelope-from=3Zd7iXgMKCqoTUjQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--jkz.bounces.google.com;
 helo=mail-qk1-x749.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The file-descriptor translation subsystem used by QEMU uses some global
variables to track file descriptors an their associated state. In the
future (when clone is implemented) it may be possible to have two
processes that share memory, but have a unique set of file descriptors.
This change associates the file-descriptor translation table with the
per-task TaskState structure. Since many tasks will share file
descriptors (e.g., threads), a structure similar to the existing structure is
used. Each task has a pointer to a global table. That table can be
shared by multiple tasks, or changed if a task needs to use a different
FD table.

Signed-off-by: Josh Kunz <jkz@google.com>
---
 linux-user/Makefile.objs   |  2 +-
 linux-user/fd-trans-tbl.c  | 13 +++++++
 linux-user/fd-trans-type.h | 17 +++++++++
 linux-user/fd-trans.c      |  3 --
 linux-user/fd-trans.h      | 75 ++++++++++++++++++++++++--------------
 linux-user/main.c          |  1 +
 linux-user/qemu.h          | 24 ++++++++++++
 linux-user/syscall.c       | 12 ++++++
 8 files changed, 115 insertions(+), 32 deletions(-)
 create mode 100644 linux-user/fd-trans-tbl.c
 create mode 100644 linux-user/fd-trans-type.h

diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
index d6788f012c..d19102e244 100644
--- a/linux-user/Makefile.objs
+++ b/linux-user/Makefile.objs
@@ -1,7 +1,7 @@
 obj-y = main.o syscall.o strace.o mmap.o signal.o \
 	elfload.o linuxload.o uaccess.o uname.o \
 	safe-syscall.o $(TARGET_ABI_DIR)/signal.o \
-        $(TARGET_ABI_DIR)/cpu_loop.o exit.o fd-trans.o clone.o
+        $(TARGET_ABI_DIR)/cpu_loop.o exit.o fd-trans.o clone.o fd-trans-tbl.o
 
 obj-$(TARGET_HAS_BFLT) += flatload.o
 obj-$(TARGET_I386) += vm86.o
diff --git a/linux-user/fd-trans-tbl.c b/linux-user/fd-trans-tbl.c
new file mode 100644
index 0000000000..6afe91096e
--- /dev/null
+++ b/linux-user/fd-trans-tbl.c
@@ -0,0 +1,13 @@
+#include "qemu/osdep.h"
+#include "fd-trans.h"
+
+struct fd_trans_table *fd_trans_table_clone(struct fd_trans_table *tbl)
+{
+    struct fd_trans_table *new_tbl = g_new0(struct fd_trans_table, 1);
+    new_tbl->fd_max = tbl->fd_max;
+    new_tbl->entries = g_new0(TargetFdTrans*, tbl->fd_max);
+    memcpy(new_tbl->entries,
+           tbl->entries,
+           sizeof(*new_tbl->entries) * tbl->fd_max);
+    return new_tbl;
+}
diff --git a/linux-user/fd-trans-type.h b/linux-user/fd-trans-type.h
new file mode 100644
index 0000000000..06c4427642
--- /dev/null
+++ b/linux-user/fd-trans-type.h
@@ -0,0 +1,17 @@
+#ifndef FD_TRANS_TYPE_H
+#define FD_TRANS_TYPE_H
+
+/*
+ * Break out the TargetFdTrans typedefs into a separate file, to break
+ * the circular dependency between qemu.h and fd-trans.h.
+ */
+
+typedef abi_long (*TargetFdDataFunc)(void *, size_t);
+typedef abi_long (*TargetFdAddrFunc)(void *, abi_ulong, socklen_t);
+typedef struct TargetFdTrans {
+    TargetFdDataFunc host_to_target_data;
+    TargetFdDataFunc target_to_host_data;
+    TargetFdAddrFunc target_to_host_addr;
+} TargetFdTrans;
+
+#endif /* FD_TRANS_TYPE_H */
diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
index c0687c52e6..c552034a5e 100644
--- a/linux-user/fd-trans.c
+++ b/linux-user/fd-trans.c
@@ -261,9 +261,6 @@ enum {
     QEMU___RTA_MAX
 };
 
-TargetFdTrans **target_fd_trans;
-unsigned int target_fd_max;
-
 static void tswap_nlmsghdr(struct nlmsghdr *nlh)
 {
     nlh->nlmsg_len = tswap32(nlh->nlmsg_len);
diff --git a/linux-user/fd-trans.h b/linux-user/fd-trans.h
index a3fcdaabc7..07ae04dad7 100644
--- a/linux-user/fd-trans.h
+++ b/linux-user/fd-trans.h
@@ -16,38 +16,45 @@
 #ifndef FD_TRANS_H
 #define FD_TRANS_H
 
-typedef abi_long (*TargetFdDataFunc)(void *, size_t);
-typedef abi_long (*TargetFdAddrFunc)(void *, abi_ulong, socklen_t);
-typedef struct TargetFdTrans {
-    TargetFdDataFunc host_to_target_data;
-    TargetFdDataFunc target_to_host_data;
-    TargetFdAddrFunc target_to_host_addr;
-} TargetFdTrans;
+#include "qemu.h"
+#include "fd-trans-type.h"
 
-extern TargetFdTrans **target_fd_trans;
-
-extern unsigned int target_fd_max;
+/*
+ * Return a duplicate of the given fd_trans_table. This function always
+ * succeeds. Ownership of the pointed-to table is yielded to the caller. The
+ * caller is responsible for freeing the table when it is no longer in-use.
+ */
+struct fd_trans_table *fd_trans_table_clone(struct fd_trans_table *tbl);
 
 static inline TargetFdDataFunc fd_trans_target_to_host_data(int fd)
 {
-    if (fd >= 0 && fd < target_fd_max && target_fd_trans[fd]) {
-        return target_fd_trans[fd]->target_to_host_data;
+    TaskState *ts = (TaskState *)thread_cpu->opaque;
+    struct fd_trans_table *tbl = ts->fd_trans_tbl;
+
+    if (fd >= 0 && fd < tbl->fd_max && tbl->entries[fd]) {
+        return tbl->entries[fd]->target_to_host_data;
     }
     return NULL;
 }
 
 static inline TargetFdDataFunc fd_trans_host_to_target_data(int fd)
 {
-    if (fd >= 0 && fd < target_fd_max && target_fd_trans[fd]) {
-        return target_fd_trans[fd]->host_to_target_data;
+    TaskState *ts = (TaskState *)thread_cpu->opaque;
+    struct fd_trans_table *tbl = ts->fd_trans_tbl;
+
+    if (fd >= 0 && fd < tbl->fd_max && tbl->entries[fd]) {
+        return tbl->entries[fd]->host_to_target_data;
     }
     return NULL;
 }
 
 static inline TargetFdAddrFunc fd_trans_target_to_host_addr(int fd)
 {
-    if (fd >= 0 && fd < target_fd_max && target_fd_trans[fd]) {
-        return target_fd_trans[fd]->target_to_host_addr;
+    TaskState *ts = (TaskState *)thread_cpu->opaque;
+    struct fd_trans_table *tbl = ts->fd_trans_tbl;
+
+    if (fd >= 0 && fd < tbl->fd_max && tbl->entries[fd]) {
+        return tbl->entries[fd]->target_to_host_addr;
     }
     return NULL;
 }
@@ -56,29 +63,41 @@ static inline void fd_trans_register(int fd, TargetFdTrans *trans)
 {
     unsigned int oldmax;
 
-    if (fd >= target_fd_max) {
-        oldmax = target_fd_max;
-        target_fd_max = ((fd >> 6) + 1) << 6; /* by slice of 64 entries */
-        target_fd_trans = g_renew(TargetFdTrans *,
-                                  target_fd_trans, target_fd_max);
-        memset((void *)(target_fd_trans + oldmax), 0,
-               (target_fd_max - oldmax) * sizeof(TargetFdTrans *));
+    TaskState *ts = (TaskState *)thread_cpu->opaque;
+    struct fd_trans_table *tbl = ts->fd_trans_tbl;
+
+    /*
+     * TODO: This is racy. Updates to tbl->entries should be guarded by
+     * a lock.
+     */
+    if (fd >= tbl->fd_max) {
+        oldmax = tbl->fd_max;
+        tbl->fd_max = ((fd >> 6) + 1) << 6; /* by slice of 64 entries */
+        tbl->entries = g_renew(TargetFdTrans *, tbl->entries, tbl->fd_max);
+        memset((void *)(tbl->entries + oldmax), 0,
+               (tbl->fd_max - oldmax) * sizeof(TargetFdTrans *));
     }
-    target_fd_trans[fd] = trans;
+    tbl->entries[fd] = trans;
 }
 
 static inline void fd_trans_unregister(int fd)
 {
-    if (fd >= 0 && fd < target_fd_max) {
-        target_fd_trans[fd] = NULL;
+    TaskState *ts = (TaskState *)thread_cpu->opaque;
+    struct fd_trans_table *tbl = ts->fd_trans_tbl;
+
+    if (fd >= 0 && fd < tbl->fd_max) {
+        tbl->entries[fd] = NULL;
     }
 }
 
 static inline void fd_trans_dup(int oldfd, int newfd)
 {
+    TaskState *ts = (TaskState *)thread_cpu->opaque;
+    struct fd_trans_table *tbl = ts->fd_trans_tbl;
+
     fd_trans_unregister(newfd);
-    if (oldfd < target_fd_max && target_fd_trans[oldfd]) {
-        fd_trans_register(newfd, target_fd_trans[oldfd]);
+    if (oldfd >= 0 && oldfd < tbl->fd_max && tbl->entries[oldfd]) {
+        fd_trans_register(newfd, tbl->entries[oldfd]);
     }
 }
 
diff --git a/linux-user/main.c b/linux-user/main.c
index 3597e99bb1..d1ed0f6120 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -796,6 +796,7 @@ int main(int argc, char **argv, char **envp)
     ts->bprm = &bprm;
     cpu->opaque = ts;
     task_settid(ts);
+    ts->fd_trans_tbl = g_new0(struct fd_trans_table, 1);
 
     ret = loader_exec(execfd, exec_path, target_argv, target_environ, regs,
         info, &bprm);
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index ce902f5132..989e01ad8d 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -5,6 +5,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
+#include "fd-trans-type.h"
 
 #undef DEBUG_REMAP
 #ifdef DEBUG_REMAP
@@ -96,6 +97,22 @@ struct emulated_sigtable {
     target_siginfo_t info;
 };
 
+/*
+ * The fd_trans_table is used the FD data translation subsystem to
+ * find FD data translators (i.e. functions). `entries` is an array of pointers
+ * with size `fd_max`, containing pointers to TargetFDTrans structs. A pointer
+ * to a struct of this type is stored TaskState, which allows the struct itself
+ * to be shared by all tasks (e.g., threads) that share a file descriptor
+ * namespace. Storing a pointer to this table in the TaskState struct is needed
+ * to support rare cases where tasks share an address space, but do not share
+ * a set of file descriptors (e.g., after clone(CLONE_VM) when CLONE_FILES is
+ * not set). See `fd-trans.h` for more info on the FD translation subsystem.
+ */
+struct fd_trans_table {
+    uint64_t fd_max;
+    TargetFdTrans **entries;
+};
+
 /* NOTE: we force a big alignment so that the stack stored after is
    aligned too */
 typedef struct TaskState {
@@ -153,6 +170,13 @@ typedef struct TaskState {
 
     /* This thread's sigaltstack, if it has one */
     struct target_sigaltstack sigaltstack_used;
+
+    /*
+     * A pointer to the FD trans table to be used by this task. Note that the
+     * task doesn't have exclusive control of the fd_trans_table so access to
+     * the table itself should be guarded.
+     */
+    struct fd_trans_table *fd_trans_tbl;
 } __attribute__((aligned(16))) TaskState;
 
 extern char *exec_path;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 7ce021cea2..ff1d07871f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6013,6 +6013,18 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
     ts->info = parent_ts->info;
     ts->signal_mask = parent_ts->signal_mask;
 
+    if (flags & CLONE_FILES) {
+        ts->fd_trans_tbl = parent_ts->fd_trans_tbl;
+    } else {
+        /*
+         * When CLONE_FILES is not set, the parent and child will have
+         * different file descriptor tables, so we need a new
+         * fd_trans_tbl. Clone from parent_ts, since child inherits all our
+         * file descriptors.
+         */
+        ts->fd_trans_tbl = fd_trans_table_clone(parent_ts->fd_trans_tbl);
+    }
+
     if (flags & CLONE_CHILD_CLEARTID) {
         ts->child_tidptr = child_tidptr;
     }
-- 
2.27.0.290.gba653c62da-goog


