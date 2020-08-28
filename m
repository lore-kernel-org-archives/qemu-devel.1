Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8509C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:41:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DA35207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA35207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBedI-0003Lq-RS
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 09:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBeZz-0003dA-Ll
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:38:07 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:33755)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBeZx-0007Fm-T0
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:38:07 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N14xe-1kadTS0Y5i-012V20; Fri, 28 Aug 2020 15:37:56 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 01/18] linux-user: Fix 'semop()' and 'semtimedop()'
 implementation
Date: Fri, 28 Aug 2020 15:37:36 +0200
Message-Id: <20200828133753.2622286-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200828133753.2622286-1-laurent@vivier.eu>
References: <20200828133753.2622286-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fykUZ8gQu6OhB2vhQ5RrNKq5YNnxIiXkuw0t1HQUZVc8mqPWlh8
 ptsH6fcDrIFrgOF14gftkqbZ/RAnPpcYSeq4xLyjml9/SlgQQpguzTlVhaQhZq4YjmKkVCP
 4V29i5txyfqVD+w0GBvILeVAFSYaFWdBCiaEwxkK1rVBAI7vKuylsrmiRkA/+s3VFQmjLX1
 +1yF0ju4TCbMyeNqf4KqQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CTHB2D4AHhA=:IZA+X2JLS2p8R6Dj4FY64u
 JXWN5E70sEtdPFIYF8ws+w2ik+wgpAkLgKQkjLV3gqX8w0I5C/kpYbc+dXy/m2o0nJxJiM2VE
 cMcnFUZmK0GsnRi1pfkray+px7O/ies29ykBpDv4RfKZJ9bLs+VuRxbNC4OW+1KB2wB3EXjYL
 z2HuI838dbirYNatzXIot4LS0OIo/+hA+ohwCn4R+q5VIgTsjnV725guELFqVooODc06V+V2U
 eZQllWyDHsy/upsV6gSlB8g4tfWoswrgd0VmLC0LB3U6EkQTHmWebbpFVp+y/rmjCbhsWmlRN
 9xL0Jnmk/0mIiELLUK4p9OUBC4pY/3hcIWhqIXAuq24do/dria32+U4j2WyQnY/nMWxWLr/Bi
 dPYiKUQxInxQkXc7GRDv4Y1dFIVUkSPUS09Ee4CKENaJl5LAbQtWVy0vh1kwOQLBI3s7iE5kY
 lQYR2IGPLkGYrslT4bgIcnN9zt0fZZO15ebBXXYKVx5ZdvPyDtGT10zFe62NWFrmwHPiWRFdO
 +H2VjZ4TKvMNSfWt2xrY2gNezNfA5tZzcLmfXh9s6mpLyx64xweUrVt7a9s7SggRRLyxsZUX7
 ZqLVcUf63UGHVw5ToA9ltHCH/Ru08zAeizrlLACsGec6nzNKeoNCG7F6Jo5JANGGMuWCLaNWy
 xWPmE+PsHoS27yoh1J7aCg3nrq6bA+Fp2vUWiBTWjHRtVCQnfnmU1C86MTVaZyJxH6PamZjKY
 +SzP/fqg4JVl0a9ZNgArCH6ns/fW2qBGXXIOp+du5sib/AiPxPNrHtgQRh2NDqiNPy0aBenXc
 LoWZmoAsJdtcrr6PbaDJhV9iaA949IQ+kVa7qME2NVEQSMc+pVxouDXery6SKrV/XPbNt4z
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 09:38:04
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


