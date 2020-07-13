Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C292AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:06:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97B4D20758
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B4D20758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juvLu-0003Rh-TZ
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 06:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1juvL5-0002Ze-HG
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:05:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:52748)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1juvL3-00048C-Te
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:05:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A1A3DB0B6;
 Mon, 13 Jul 2020 10:05:34 +0000 (UTC)
From: Andreas Schwab <schwab@suse.de>
To: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] linux-user: implement the semtimedop syscall
X-Yow: ..  the MYSTERIANS are in here with my CORDUROY SOAP DISH!!
Date: Mon, 13 Jul 2020 12:05:32 +0200
Message-ID: <mvmy2nn7ms3.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.15; envelope-from=schwab@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 00:02:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 linux-user/syscall.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9ec03a889d..7c0f5b83ff 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3877,23 +3877,37 @@ static inline abi_long target_to_host_sembuf(struct sembuf *host_sembuf,
     return 0;
 }
 
-static inline abi_long do_semop(int semid, abi_long ptr, unsigned nsops)
+static inline abi_long do_semtimedop(int semid, abi_long ptr, unsigned nsops,
+    abi_long timeout)
 {
     struct sembuf sops[nsops];
+    struct timespec ts, *pts;
     abi_long ret;
 
     if (target_to_host_sembuf(sops, ptr, nsops))
         return -TARGET_EFAULT;
 
+    if (timeout) {
+        pts = &ts;
+        if (target_to_host_timespec(pts, timeout)) {
+            return -TARGET_EFAULT;
+        }
+    } else {
+        pts = NULL;
+    }
+
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
+    if (!is_error(ret) && timeout) {
+        ret = host_to_target_timespec(timeout, pts);
+    }
     return ret;
 }
 
@@ -4371,7 +4385,11 @@ static abi_long do_ipc(CPUArchState *cpu_env,
 
     switch (call) {
     case IPCOP_semop:
-        ret = do_semop(first, ptr, second);
+        ret = do_semtimedop(first, ptr, second, 0);
+        break;
+
+    case IPCOP_semtimedop:
+        ret = do_semtimedop(first, ptr, second, third);
         break;
 
     case IPCOP_semget:
@@ -9683,7 +9701,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
2.26.2


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

