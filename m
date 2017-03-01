Received: from eggs.gnu.org ([2001:4830:134:3::10]:33556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cj0hz-0006XN-6w
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:38:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cj0hu-0006q1-9g
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:38:07 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:53763)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cj0hu-0006pR-03
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:38:02 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed,  1 Mar 2017 10:37:48 +0100
Message-Id: <20170301093748.28033-3-laurent@vivier.eu>
In-Reply-To: <20170301093748.28033-1-laurent@vivier.eu>
References: <20170301093748.28033-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 2/2] linux-user: fix eventfd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>

When a fd is opened using eventfd(), a read provides
a 64bit counter in the host byte order, and a
write increase the internal counter by the provided
64bit value.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b2b563e..2da8426 100644
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
2.9.3
