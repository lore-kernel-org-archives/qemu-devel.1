Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F95C54E4B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 07:47:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92DA9206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 07:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92DA9206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tachyum.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYPde-0007xU-OT
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 03:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mkysel@tachyum.com>)
 id 1jYPct-0007Ye-DO
 for qemu-devel@nongnu.org; Tue, 12 May 2020 03:46:55 -0400
Received: from mx1.tachyum.com ([66.160.133.170]:55333 helo=mail.tachyum.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mkysel@tachyum.com>)
 id 1jYPcs-0002kL-II
 for qemu-devel@nongnu.org; Tue, 12 May 2020 03:46:55 -0400
Received: by mail.tachyum.com (Postfix, from userid 1001)
 id ADA9162C; Mon, 11 May 2020 16:46:55 -0700 (PDT)
Received: from tsk-dev-swd001.tachyum.sk (unknown [93.184.71.90])
 by mail.tachyum.com (Postfix) with ESMTP id B6009103;
 Mon, 11 May 2020 16:46:51 -0700 (PDT)
From: Matus Kysel <mkysel@tachyum.com>
To: 
Subject: [PATCH v2] linux-user: support of semtimedop syscall
Date: Tue, 12 May 2020 09:45:10 +0200
Message-Id: <20200512074510.40215-1-mkysel@tachyum.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=66.160.133.170; envelope-from=mkysel@tachyum.com;
 helo=mail.tachyum.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 03:46:53
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Matus Kysel <mkysel@tachyum.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We should add support of semtimedop syscall as new version of
glibc 2.31 uses semop based on semtimedop (commit: https://gitlab.com/freedesktop-sdk/mirrors/sourceware/glibc/-/commit/765cdd0bffd77960ae852104fc4ea5edcdb8aed3 ).

Signed-off-by: Matus Kysel <mkysel@tachyum.com>
---
 linux-user/syscall.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 05f03919ff..7c6f9439e0 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1227,7 +1227,8 @@ static inline abi_long copy_to_user_timeval64(abi_ulong target_tv_addr,
     defined(TARGET_NR_pselect6) || defined(TARGET_NR_pselect6) || \
     defined(TARGET_NR_nanosleep) || defined(TARGET_NR_clock_settime) || \
     defined(TARGET_NR_utimensat) || defined(TARGET_NR_mq_timedsend) || \
-    defined(TARGET_NR_mq_timedreceive)
+    defined(TARGET_NR_mq_timedreceive) || defined(TARGET_NR_ipc) || \
+    defined(TARGET_NR_semop) || defined(TARGET_NR_semtimedop)
 static inline abi_long target_to_host_timespec(struct timespec *host_ts,
                                                abi_ulong target_addr)
 {
@@ -3875,25 +3876,39 @@ static inline abi_long target_to_host_sembuf(struct sembuf *host_sembuf,
     return 0;
 }

-static inline abi_long do_semop(int semid, abi_long ptr, unsigned nsops)
+#if defined(TARGET_NR_ipc) || defined(TARGET_NR_semop) || \
+    defined(TARGET_NR_semtimedop)
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
+        ret = get_errno(safe_ipc(IPCOP_semtimedop, semid, nsops, 0, sops, pts));
     }
 #endif
     return ret;
 }
+#endif

 struct target_msqid_ds
 {
@@ -4369,7 +4384,10 @@ static abi_long do_ipc(CPUArchState *cpu_env,

     switch (call) {
     case IPCOP_semop:
-        ret = do_semop(first, ptr, second);
+        ret = do_semtimedop(first, ptr, second, 0);
+        break;
+    case IPCOP_semtimedop:
+        ret = do_semtimedop(first, ptr, second, third);
         break;

     case IPCOP_semget:
@@ -9594,7 +9612,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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


