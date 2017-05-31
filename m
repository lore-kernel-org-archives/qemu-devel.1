Received: from eggs.gnu.org ([2001:4830:134:3::10]:36717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1dG3Md-0007St-8P
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1dG3Mc-0003cr-2o
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:39 -0400
Received: from mail-lf0-x231.google.com ([2a00:1450:4010:c07::231]:34426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1dG3Mb-0003cY-RE
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:37 -0400
Received: by mail-lf0-x231.google.com with SMTP id 99so8618602lfu.1
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 06:08:37 -0700 (PDT)
From: riku.voipio@linaro.org
Date: Wed, 31 May 2017 16:08:16 +0300
Message-Id: <c4e316cfb5e3f4b58d5d6fb6cb6c2279a5c3229a.1496234766.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1496234766.git.riku.voipio@linaro.org>
References: <cover.1496234766.git.riku.voipio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/15] linux-user: fix inotify
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
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/syscall.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 671b13a23b..32aba195c5 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7693,6 +7693,33 @@ static TargetFdTrans target_eventfd_trans = {
     .target_to_host_data = swap_data_eventfd,
 };
 
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
@@ -11736,6 +11763,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_inotify_init) && defined(__NR_inotify_init)
     case TARGET_NR_inotify_init:
         ret = get_errno(sys_inotify_init());
+        fd_trans_register(ret, &target_inotify_trans);
         break;
 #endif
 #ifdef CONFIG_INOTIFY1
@@ -11743,6 +11771,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_inotify_init1:
         ret = get_errno(sys_inotify_init1(target_to_host_bitmask(arg1,
                                           fcntl_flags_tbl)));
+        fd_trans_register(ret, &target_inotify_trans);
         break;
 #endif
 #endif
-- 
2.11.0
