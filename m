Received: from eggs.gnu.org ([2001:4830:134:3::10]:36671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1dG3Ma-0007S6-Fc
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1dG3MZ-0003bt-7L
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:36 -0400
Received: from mail-lf0-x232.google.com ([2a00:1450:4010:c07::232]:35553)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1dG3MY-0003bT-W4
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:35 -0400
Received: by mail-lf0-x232.google.com with SMTP id c184so3857929lfe.2
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 06:08:34 -0700 (PDT)
From: riku.voipio@linaro.org
Date: Wed, 31 May 2017 16:08:14 +0300
Message-Id: <562a20b4ef63bdde6e2e5bac0da02302aeb5299f.1496234766.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1496234766.git.riku.voipio@linaro.org>
References: <cover.1496234766.git.riku.voipio@linaro.org>
Subject: [Qemu-devel] [PULL 02/15] linux-user: fix eventfd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, stefanha@redhat.com, Laurent Vivier <laurent@vivier.eu>

From: Laurent Vivier <laurent@vivier.eu>

When a fd is opened using eventfd(), a read provides
a 64bit counter in the host byte order, and a
write increase the internal counter by the provided
64bit value.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/syscall.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b2b563e388..2da8426aaa 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7671,6 +7671,28 @@ static target_timer_t get_timer_id(abi_long arg)
     return timerid;
 }
 
+static abi_long swap_data_eventfd(void *buf, size_t len)
+{
+    uint64_t *counter = buf;
+    int i;
+
+    if (len < sizeof(uint64_t)) {
+        return -EINVAL;
+    }
+
+    for (i = 0; i < len; i += sizeof(uint64_t)) {
+        *counter = tswap64(*counter);
+        counter++;
+    }
+
+    return len;
+}
+
+static TargetFdTrans target_eventfd_trans = {
+    .host_to_target_data = swap_data_eventfd,
+    .target_to_host_data = swap_data_eventfd,
+};
+
 /* do_syscall() should always have a single exit point at the end so
    that actions, such as logging of syscall results, can be performed.
    All errnos that do_syscall() returns must be -TARGET_<errcode>. */
@@ -11876,7 +11898,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_eventfd)
     case TARGET_NR_eventfd:
         ret = get_errno(eventfd(arg1, 0));
-        fd_trans_unregister(ret);
+        fd_trans_register(ret, &target_eventfd_trans);
         break;
 #endif
 #if defined(TARGET_NR_eventfd2)
@@ -11890,7 +11912,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             host_flags |= O_CLOEXEC;
         }
         ret = get_errno(eventfd(arg1, host_flags));
-        fd_trans_unregister(ret);
+        fd_trans_register(ret, &target_eventfd_trans);
         break;
     }
 #endif
-- 
2.11.0
