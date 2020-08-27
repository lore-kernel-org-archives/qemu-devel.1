Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90AFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:21:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C8F2207CD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C8F2207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBNSk-0005CX-Nj
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 15:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBNRp-0003hm-4q
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:20:33 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:60077)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBNRn-000092-5A
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:20:32 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mt6x5-1kRGV71Vt3-00tPp9; Thu, 27 Aug 2020 21:20:24 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 01/18] linux-user: Fix 'semop()' and 'semtimedop()'
 implementation
Date: Thu, 27 Aug 2020 21:20:01 +0200
Message-Id: <20200827192018.2442099-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200827192018.2442099-1-laurent@vivier.eu>
References: <20200827192018.2442099-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/HRRcOuhczjHgzZbLLSklhEjqNLzfAOG9DXUgU8oxc+rjK0Fgdt
 gmqY5YLLNGV6RBc0VnaXdJ/1UGoFkovVqhPmoWWDWOcwWBrMaqLnifRHgnrJmQ2RNKGBc1E
 gDfV+2Acn6717S80KHd161upAQMhdV/2f3V5YErHrCrfNuZu5tFnkU/vcF/az3+k5O9ttKV
 Q4LHmYN1Dk4FsjN0bykwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WuFA+C8fl50=:f5wmrMsMqROf4Q2A+XGEL1
 BLGE75OL4ZiYRbvwH5r/74OkIgaUB8DN+DcjUZyIkES0IqA9HaGTix+WCVIXrl9UdQedn6fUY
 T25TRqp8hwQuIxHKR+/3DjbTJpCT1Vz6UWfJLUPphKF2t2wiMafgJ02rigcB4Oy/7uEGmT2W8
 NMJb6tBwIEofzqJnBrgVi/NLd4BTH+bXr+OVCaC5pHOPzx3c5l1DeTtmI3L4xJKSAuhPhHwyA
 j+sKHzhTzRJ3R3IWQUV9xwJhWa/pMP3hwiNDHt5IUqjmLWXMjmtQLOa6dFm2uQBTATyNoTnGc
 anruVWDV+leR2PZNtW8XmcNpKwruk/Vlv0d/qHA4pQdv1Kirtr44xDFbYIAj5NuXjdizWO3li
 oMz7fxw8nCNNtrAOTPWEk6XTv3z22CRG8m/JFnR7HerxHD4+rSnCVSbcKmus9585sP9+b3ixW
 F1ygaR4W4aHUNmg3QdvQzawkuAMafTDSmsETZLTNe47Yx74bb5dNUmvxtYW/aPXQPl+lC2SdV
 KY5tDevQp36eKuvqzNT3ia4nIhd0St0FYUQHkP9CRcbiTNAZKGr2OFSH7KDHUR9/np7XLEwV+
 D7R2EV2Ebew1EO+GwZ6veYCu7kF/xJ5XgLLtdgIViqO1POmA+0zzyQ85PF90brqyNrAITt8nA
 23+oQgFVjohpNrbPDhml4sItALu0C5dXEKgDYCYvWRaffiKtnccoRMWZ41CzQgyCOnU+hOzkN
 RMvKLrJr9A5UQhiXQiePJhdhI+8cgWWIIuNv10eTbjB0OkQ/0OGLMG8RGdQpFXkobQXuNXrsI
 ibH8fKwASoG3d4Yi6YKVbCr9opdnbQiBvUjyfoYnfUsGgIx5wWUnV8XMRqL185kjMxBmHTk
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 15:20:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

The implementations of syscalls 'semop()' and 'semtimedop()' in
file 'syscall.c' use function 'target_to_host_sembuf()' to convert
values of 'struct sembuf' from host to target. However, before this
conversion it should be check whether the number of semaphore operations
'nsops' is not bigger than maximum allowed semaphor operations per
syscall: 'SEMOPM'. In these cases, errno 'E2BIG' ("Arg list too long")
should be set. But the implementation will set errno 'EFAULT' ("Bad address")
in this case since the conversion from target to host in this case fails.

This was confirmed with the LTP test for 'semop()' ('ipc/semop/semop02') in
test case where 'nsops' is greater than SEMOPM with unaproppriate errno EFAULT:

semop02.c:130: FAIL: semop failed unexpectedly; expected: E2BIG: EFAULT (14)

This patch changes this by adding a check whether 'nsops' is bigger than
'SEMOPM' before the conversion function 'target_to_host_sembuf()' is called.
After the changes from this patch, the test works fine along with the other
LTP testcases for 'semop()'):

semop02.c:126: PASS: semop failed as expected: E2BIG (7)

Implementation notes:

    A target value ('TARGET_SEMOPM') was added for 'SEMOPM' as to be sure
    in case the value is not available for some targets.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200818180722.45089-1-Filip.Bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c      | 13 +++++++++++--
 linux-user/syscall_defs.h |  2 ++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b4a7b605f3d4..5b3fce3dc0cb 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3901,7 +3901,7 @@ static inline abi_long do_semtimedop(int semid,
                                      unsigned nsops,
                                      abi_long timeout)
 {
-    struct sembuf sops[nsops];
+    struct sembuf *sops;
     struct timespec ts, *pts = NULL;
     abi_long ret;
 
@@ -3912,8 +3912,16 @@ static inline abi_long do_semtimedop(int semid,
         }
     }
 
-    if (target_to_host_sembuf(sops, ptr, nsops))
+    if (nsops > TARGET_SEMOPM) {
+        return -TARGET_E2BIG;
+    }
+
+    sops = g_new(struct sembuf, nsops);
+
+    if (target_to_host_sembuf(sops, ptr, nsops)) {
+        g_free(sops);
         return -TARGET_EFAULT;
+    }
 
     ret = -TARGET_ENOSYS;
 #ifdef __NR_semtimedop
@@ -3925,6 +3933,7 @@ static inline abi_long do_semtimedop(int semid,
                                  SEMTIMEDOP_IPC_ARGS(nsops, sops, (long)pts)));
     }
 #endif
+    g_free(sops);
     return ret;
 }
 #endif
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 427a25f5bce5..9aa3bd724f0c 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -46,6 +46,8 @@
 #define IPCOP_shmget		23
 #define IPCOP_shmctl		24
 
+#define TARGET_SEMOPM     500
+
 /*
  * The following is for compatibility across the various Linux
  * platforms.  The i386 ioctl numbering scheme doesn't really enforce
-- 
2.26.2


