Received: from eggs.gnu.org ([2001:4830:134:3::10]:38529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOWNn-0005AX-7a
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:49:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOWNm-0000pQ-I9
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:49:23 -0400
Received: from mail-pl0-x230.google.com ([2607:f8b0:400e:c01::230]:47027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOWNm-0000p0-CQ
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:49:22 -0400
Received: by mail-pl0-x230.google.com with SMTP id 30-v6so14074562pld.13
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 15:49:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 31 May 2018 15:49:09 -0700
Message-Id: <20180531224911.23725-5-richard.henderson@linaro.org>
In-Reply-To: <20180531224911.23725-1-richard.henderson@linaro.org>
References: <20180531224911.23725-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 4/6] linux-user: Check contains_hostfd in
 select syscalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, evgreen@chromium.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5339f0bc1c..b98125829b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1506,6 +1506,11 @@ static abi_long do_select(int n,
     if (ret) {
         return ret;
     }
+    if (contains_hostfd(&rfds) ||
+        contains_hostfd(&wfds) ||
+        contains_hostfd(&efds)) {
+        return -TARGET_EBADF;
+    }
 
     if (target_tv_addr) {
         if (copy_from_user_timeval(&tv, target_tv_addr))
@@ -9392,6 +9397,11 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             if (ret) {
                 goto fail;
             }
+            if (contains_hostfd(&rfds) ||
+                contains_hostfd(&wfds) ||
+                contains_hostfd(&efds)) {
+                goto ebadf;
+            }
 
             /*
              * This takes a timespec, and not a timeval, so we cannot
-- 
2.17.0
