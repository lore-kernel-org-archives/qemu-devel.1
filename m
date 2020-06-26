Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BA0C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 12:57:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 127B32076E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 12:57:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 127B32076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tachyum.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jonv6-0003fC-AY
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 08:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mkysel@tachyum.com>)
 id 1jonu7-0002P3-IW
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 08:56:27 -0400
Received: from mx1.tachyum.com ([66.160.133.170]:34941 helo=mail.tachyum.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mkysel@tachyum.com>)
 id 1jonu5-0001Ty-Tu
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 08:56:27 -0400
Received: by mail.tachyum.com (Postfix, from userid 1001)
 id CF935858; Fri, 26 Jun 2020 05:56:24 -0700 (PDT)
Received: from tsk-dev-swd001.tachyum.sk (unknown [93.184.71.90])
 by mail.tachyum.com (Postfix) with ESMTP id 5ABBB64D;
 Fri, 26 Jun 2020 05:56:16 -0700 (PDT)
From: Matus Kysel <mkysel@tachyum.com>
To: mkysel@tachyum.com, riku.voipio@iki.fi, laurent@vivier.eu,
 qemu-devel@nongnu.org
Subject: [PATCH v3 1/2] linux-user: refactor ipc syscall
Date: Fri, 26 Jun 2020 14:46:11 +0200
Message-Id: <20200626124612.58593-2-mkysel@tachyum.com>
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

Refactoring ipc syscall for s390x and SPARC, so it matches glibc implementation

Signed-off-by: Matus Kysel <mkysel@tachyum.com>
---
 linux-user/syscall.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 97de9fb5c9..990412733b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -814,9 +814,14 @@ safe_syscall4(int, clock_nanosleep, const clockid_t, clock, int, flags,
               const struct timespec *, req, struct timespec *, rem)
 #endif
 #ifdef __NR_ipc
+#ifdef __s390x__
+safe_syscall5(int, ipc, int, call, long, first, long, second, long, third,
+              void *, ptr)
+#else
 safe_syscall6(int, ipc, int, call, long, first, long, second, long, third,
               void *, ptr, long, fifth)
 #endif
+#endif
 #ifdef __NR_msgsnd
 safe_syscall4(int, msgsnd, int, msgid, const void *, msgp, size_t, sz,
               int, flags)
@@ -4053,8 +4058,13 @@ static inline abi_long do_msgsnd(int msqid, abi_long msgp,
 #endif
 #ifdef __NR_ipc
     if (ret == -TARGET_ENOSYS) {
+#ifdef __s390x__
+        ret = get_errno(safe_ipc(IPCOP_msgsnd, msqid, msgsz, msgflg,
+                                 host_mb));
+#else
         ret = get_errno(safe_ipc(IPCOP_msgsnd, msqid, msgsz, msgflg,
                                  host_mb, 0));
+#endif
     }
 #endif
     g_free(host_mb);
@@ -4063,6 +4073,20 @@ static inline abi_long do_msgsnd(int msqid, abi_long msgp,
     return ret;
 }
 
+#ifdef __NR_ipc
+#if defined(__sparc__)
+/* SPARC for msgrcv it does not use the kludge on final 2 arguments.  */
+#define MSGRCV_ARGS(__msgp, __msgtyp) __msgp, __msgtyp
+#elif defined(__s390x__)
+/* The s390 sys_ipc variant has only five parameters.  */
+#define MSGRCV_ARGS(__msgp, __msgtyp) \
+    ((long int[]){(long int)__msgp, __msgtyp})
+#else
+#define MSGRCV_ARGS(__msgp, __msgtyp) \
+    ((long int[]){(long int)__msgp, __msgtyp}), 0
+#endif
+#endif
+
 static inline abi_long do_msgrcv(int msqid, abi_long msgp,
                                  ssize_t msgsz, abi_long msgtyp,
                                  int msgflg)
@@ -4091,7 +4115,7 @@ static inline abi_long do_msgrcv(int msqid, abi_long msgp,
 #ifdef __NR_ipc
     if (ret == -TARGET_ENOSYS) {
         ret = get_errno(safe_ipc(IPCOP_CALL(1, IPCOP_msgrcv), msqid, msgsz,
-                        msgflg, host_mb, msgtyp));
+                        msgflg, MSGRCV_ARGS(host_mb, msgtyp)));
     }
 #endif
 
-- 
2.17.1


