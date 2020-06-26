Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51708C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 12:58:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A8712076E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 12:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A8712076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tachyum.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jonwE-00059u-G8
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 08:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mkysel@tachyum.com>)
 id 1jonu7-0002Pp-Tx
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 08:56:27 -0400
Received: from mx1.tachyum.com ([66.160.133.170]:31153 helo=mail.tachyum.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mkysel@tachyum.com>)
 id 1jonu5-0001U0-VE
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 08:56:27 -0400
Received: by mail.tachyum.com (Postfix, from userid 1001)
 id D1A15859; Fri, 26 Jun 2020 05:56:24 -0700 (PDT)
Received: from tsk-dev-swd001.tachyum.sk (unknown [93.184.71.90])
 by mail.tachyum.com (Postfix) with ESMTP id 2BFA5857;
 Fri, 26 Jun 2020 05:56:23 -0700 (PDT)
From: Matus Kysel <mkysel@tachyum.com>
To: mkysel@tachyum.com, riku.voipio@iki.fi, laurent@vivier.eu,
 qemu-devel@nongnu.org
Subject: [PATCH v3 2/2] linux-user: support of semtimedop syscall
Date: Fri, 26 Jun 2020 14:46:12 +0200
Message-Id: <20200626124612.58593-3-mkysel@tachyum.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200626124612.58593-1-mkysel@tachyum.com>
References: <20200626124612.58593-1-mkysel@tachyum.com>
Received-SPF: pass client-ip=66.160.133.170; envelope-from=mkysel@tachyum.com;
 helo=mail.tachyum.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 07:27:33
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

We should add support of semtimedop syscall as new version of glibc
2.31 uses semop based on semtimedop
(commit: https://gitlab.com/freedesktop-sdk/mirrors/sourceware/glibc/-/commit/765cdd0bffd77960ae852104fc4ea5edcdb8aed3 ).

Signed-off-by: Matus Kysel <mkysel@tachyum.com>
---
 linux-user/syscall.c | 58 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 6 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 990412733b..538a7e673c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1232,7 +1232,8 @@ static inline abi_long copy_to_user_timeval64(abi_ulong target_tv_addr,
     defined(TARGET_NR_pselect6) || defined(TARGET_NR_pselect6) || \
     defined(TARGET_NR_nanosleep) || defined(TARGET_NR_clock_settime) || \
     defined(TARGET_NR_utimensat) || defined(TARGET_NR_mq_timedsend) || \
-    defined(TARGET_NR_mq_timedreceive)
+    defined(TARGET_NR_mq_timedreceive) || defined(TARGET_NR_ipc) || \
+    defined(TARGET_NR_semop) || defined(TARGET_NR_semtimedop)
 static inline abi_long target_to_host_timespec(struct timespec *host_ts,
                                                abi_ulong target_addr)
 {
@@ -3880,25 +3881,53 @@ static inline abi_long target_to_host_sembuf(struct sembuf *host_sembuf,
     return 0;
 }
 
-static inline abi_long do_semop(int semid, abi_long ptr, unsigned nsops)
+#if defined(TARGET_NR_ipc) || defined(TARGET_NR_semop) || \
+    defined(TARGET_NR_semtimedop)
+
+/*
+ * This macro is required to handle the s390 variants, which passes the
+ * arguments in a different order than default.
+ */
+#ifdef __s390x__
+#define SEMTIMEDOP_IPC_ARGS(__nsops, __sops, __timeout) \
+  (__nsops), (__timeout), (__sops)
+#else
+#define SEMTIMEDOP_IPC_ARGS(__nsops, __sops, __timeout) \
+  (__nsops), 0, (__sops), (__timeout)
+#endif
+
+static inline abi_long do_semtimedop(int semid,
+                                     abi_long ptr,
+                                     unsigned nsops,
+                                     abi_long timeout)
 {
     struct sembuf sops[nsops];
+    struct timespec ts, *pts = NULL;
     abi_long ret;
 
+    if (timeout) {
+        pts = &ts;
+        if (target_to_host_timespec(pts, timeout)) {
+            return -TARGET_EFAULT;
+        }
+    }
+
     if (target_to_host_sembuf(sops, ptr, nsops))
         return -TARGET_EFAULT;
 
     ret = -TARGET_ENOSYS;
 #ifdef __NR_semtimedop
-    ret = get_errno(safe_semtimedop(semid, sops, nsops, NULL));
+    ret = get_errno(safe_semtimedop(semid, sops, nsops, pts));
 #endif
 #ifdef __NR_ipc
     if (ret == -TARGET_ENOSYS) {
-        ret = get_errno(safe_ipc(IPCOP_semtimedop, semid, nsops, 0, sops, 0));
+        ret = get_errno(safe_ipc(IPCOP_semtimedop, semid,
+                                 SEMTIMEDOP_IPC_ARGS(nsops, sops, (long)pts)));
     }
 #endif
     return ret;
 }
+#endif
 
 struct target_msqid_ds
 {
@@ -4393,7 +4422,20 @@ static abi_long do_ipc(CPUArchState *cpu_env,
 
     switch (call) {
     case IPCOP_semop:
-        ret = do_semop(first, ptr, second);
+        ret = do_semtimedop(first, ptr, second, 0);
+        break;
+    case IPCOP_semtimedop:
+    /*
+     * The s390 sys_ipc variant has only five parameters instead of six
+     * (as for default variant) and the only difference is the handling of
+     * SEMTIMEDOP where on s390 the third parameter is used as a pointer
+     * to a struct timespec where the generic variant uses fifth parameter.
+     */
+#if defined(TARGET_S390X)
+        ret = do_semtimedop(first, ptr, second, third);
+#else
+        ret = do_semtimedop(first, ptr, second, fifth);
+#endif
         break;
 
     case IPCOP_semget:
@@ -9644,7 +9686,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_semop
     case TARGET_NR_semop:
-        return do_semop(arg1, arg2, arg3);
+        return do_semtimedop(arg1, arg2, arg3, 0);
+#endif
+#ifdef TARGET_NR_semtimedop
+    case TARGET_NR_semtimedop:
+        return do_semtimedop(arg1, arg2, arg3, arg4);
 #endif
 #ifdef TARGET_NR_semctl
     case TARGET_NR_semctl:
-- 
2.17.1


