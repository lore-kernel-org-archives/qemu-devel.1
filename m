Received: from eggs.gnu.org ([2001:4830:134:3::10]:36010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cjF1M-0004RV-HA
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 19:55:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cjF1J-0005id-8w
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 19:55:04 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:51846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cjF1I-0005g7-Pq
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 19:55:01 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu,  2 Mar 2017 01:54:48 +0100
Message-Id: <20170302005448.21336-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH] linux-user: fix inotify
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

When a fd is opened using inotify_init(), a read provides
one or more inotify_event structures:

    struct inotify_event {
        int      wd;
        uint32_t mask;
        uint32_t cookie;
        uint32_t len;
        char     name[];
    };

The integer fields must be byte-swapped to the target endianness.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index cec8428..c2c4f3a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7671,6 +7671,33 @@ static target_timer_t get_timer_id(abi_long arg)
     return timerid;
 }
 
+#if (defined(TARGET_NR_inotify_init) && defined(__NR_inotify_init)) || \
+    (defined(CONFIG_INOTIFY1) && defined(TARGET_NR_inotify_init1) && \
+     defined(__NR_inotify_init1))
+static abi_long host_to_target_data_inotify(void *buf, size_t len)
+{
+    struct inotify_event *ev;
+    int i;
+    uint32_t name_len;
+
+    for (i = 0; i < len; i += sizeof(struct inotify_event) + name_len) {
+        ev = (struct inotify_event *)((char *)buf + i);
+        name_len = ev->len;
+
+        ev->wd = tswap32(ev->wd);
+        ev->mask = tswap32(ev->mask);
+        ev->cookie = tswap32(ev->cookie);
+        ev->len = tswap32(name_len);
+    }
+
+    return len;
+}
+
+static TargetFdTrans target_inotify_trans = {
+    .host_to_target_data = host_to_target_data_inotify,
+};
+#endif
+
 /* do_syscall() should always have a single exit point at the end so
    that actions, such as logging of syscall results, can be performed.
    All errnos that do_syscall() returns must be -TARGET_<errcode>. */
@@ -11694,6 +11721,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_inotify_init) && defined(__NR_inotify_init)
     case TARGET_NR_inotify_init:
         ret = get_errno(sys_inotify_init());
+        fd_trans_register(ret, &target_inotify_trans);
         break;
 #endif
 #ifdef CONFIG_INOTIFY1
@@ -11701,6 +11729,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_inotify_init1:
         ret = get_errno(sys_inotify_init1(target_to_host_bitmask(arg1,
                                           fcntl_flags_tbl)));
+        fd_trans_register(ret, &target_inotify_trans);
         break;
 #endif
 #endif
-- 
2.9.3
