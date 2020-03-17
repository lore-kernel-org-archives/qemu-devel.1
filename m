Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E01C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:59:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6B9820724
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B9820724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEEcm-0002bk-S1
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 11:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36996)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jEEVK-0004n4-Oi
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:51:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jEEVJ-0007Er-8p
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:51:42 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:45607)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jEEVI-00079X-TO
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:51:41 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MEFnP-1j6mEs38wH-00AG8X; Tue, 17 Mar 2020 16:51:28 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 05/37] linux-user: Flush out implementation of gettimeofday
Date: Tue, 17 Mar 2020 16:50:44 +0100
Message-Id: <20200317155116.1227513-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317155116.1227513-1-laurent@vivier.eu>
References: <20200317155116.1227513-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KIjloFeouvdqoRQtjFpfzvMOSrLAOXzEk5nAgrs4TWepSBGo5Wi
 /h5/Hj436gRPs0M20Q4PhgUoYHs2f7k1XCJi3D2fel07GWw2QmCM1bscH2zM7raqRafhK2t
 fBD82+V/wS70jihJO9KPVHt3fIB2x9qFa+11+2n62SUq1gSbY91Wq7pHaf8ZLjAIWYhEuEQ
 XrLgBOnypEwWRQ8i7oVvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PsR78ypMXdE=:q0xGaGQa6YRnauCRYk4qaa
 +g1kNI49Ny94IMtoYSaTaMgEZkgAS+JVe7AkRz3qcShd4f+I5fThjIpVFaY+EPKeWpevTGVbv
 uPdjw7QpzKJ67FBcWNBubJgV7ahfKKVSH98/6cMzM0pWLThJ3J/YkCQJia4XySjNQnzJfWnP8
 PGnj3IgtoLVq1rL2LTfNZcYlKSIQYCObeTFEEauibqzIpqTHHKn55ipsyAHwSD7A10LSdnkUf
 SVBtIsHKejP18bk3XWpWVU8cSzcu27T1xFb4uGq9BFj7V/oxtMRECVVZvyoV7QYZv2NEq2lbf
 bw//fmVeaVCZ+ifyawi6MCIQABZeL3llBEeH4UIUKYtQiCgt2iYeYNx6bq6c+K1fE+4vb5aUw
 aKvQQd4o9QilDdZKX8Z7ry03zvZNagqe3R21GCS5r+1Qro/hOMC8iid9R1PknZLmrImblNleb
 9MpVbVNm7+YLRguX04KdhGvjHEDhgMnoXDTRPLQYXkLYG8Kox9kl1AMgczheFOU8pc2y+msiJ
 I9zUndGWy/Pdd8rtg1R5jIkgCkUhUfvNOmthnOlwc+nAUOirIq8CEunPvQYUMWnVh2DKKs92k
 xQpLWxsOWWQGxxXKYIiXTeelcLotc+TcbwOT34zLtQNRMVsBJMgIjYEAf4xTVG5HTNg++Oqs0
 vlUh2g9mqVKKQeaP5Qy8sStQLZ0uXZU8mJvLePTReG3vzyP4FOQPqGTiijlHCb9P+AfH+m00+
 5Z6uKn7EbIRFRzS7TuXA7lwudh86W1zAhkl5rJHZCLdy/E5tKlHalWOr3a+htj6YaRNubX0H9
 uICzpsa99szhFHrg6+ydlBF47gF7O8Tm4NAcQfnZy1B6FtKhGdAtNhq5nH4nuWWSuD2CPAx
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

The first argument, timeval, is allowed to be NULL.

The second argument, timezone, was missing.  While its use is
deprecated, it is still present in the syscall.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200213032223.14643-6-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5479d67a10be..811495c3a0bc 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1228,6 +1228,23 @@ static inline abi_long host_to_target_timespec64(abi_ulong target_addr,
     return 0;
 }
 
+static inline abi_long copy_to_user_timezone(abi_ulong target_tz_addr,
+                                             struct timezone *tz)
+{
+    struct target_timezone *target_tz;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_tz, target_tz_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+
+    __put_user(tz->tz_minuteswest, &target_tz->tz_minuteswest);
+    __put_user(tz->tz_dsttime, &target_tz->tz_dsttime);
+
+    unlock_user_struct(target_tz, target_tz_addr, 1);
+
+    return 0;
+}
+
 static inline abi_long copy_from_user_timezone(struct timezone *tz,
                                                abi_ulong target_tz_addr)
 {
@@ -8642,10 +8659,16 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_gettimeofday:
         {
             struct timeval tv;
-            ret = get_errno(gettimeofday(&tv, NULL));
+            struct timezone tz;
+
+            ret = get_errno(gettimeofday(&tv, &tz));
             if (!is_error(ret)) {
-                if (copy_to_user_timeval(arg1, &tv))
+                if (arg1 && copy_to_user_timeval(arg1, &tv)) {
                     return -TARGET_EFAULT;
+                }
+                if (arg2 && copy_to_user_timezone(arg2, &tz)) {
+                    return -TARGET_EFAULT;
+                }
             }
         }
         return ret;
-- 
2.24.1


