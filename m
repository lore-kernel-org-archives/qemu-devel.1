Received: from eggs.gnu.org ([2001:4830:134:3::10]:41071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqez-0003ed-ND
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqey-00046p-D9
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:53 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:39883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqey-000465-4u
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:52 -0400
Received: by mail-pl0-x241.google.com with SMTP id f1-v6so10400347plt.6
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:04:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:40 -1000
Message-Id: <20180610030220.3777-69-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 068/108] linux-user: Split out capget, capset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 156 ++++++++++++++++++++++++-------------------
 1 file changed, 86 insertions(+), 70 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1e1ac8defd..c906719152 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7703,6 +7703,90 @@ IMPL(brk)
     return do_brk(arg1);
 }
 
+IMPL(capget)
+{
+    struct target_user_cap_header *target_header;
+    struct __user_cap_header_struct header;
+    struct __user_cap_data_struct data[2];
+    int data_items;
+    abi_long ret;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_header, arg1, 1)) {
+        return -TARGET_EFAULT;
+    }
+    header.version = tswap32(target_header->version);
+    header.pid = tswap32(target_header->pid);
+
+    /* Version 2 and up takes pointer to two user_data structs */
+    data_items = (header.version == _LINUX_CAPABILITY_VERSION ? 1 : 2);
+
+    ret = get_errno(capget(&header, arg2 ? data : NULL));
+
+    /* The kernel always updates version for both capget and capset */
+    target_header->version = tswap32(header.version);
+    unlock_user_struct(target_header, arg1, 1);
+
+    if (arg2) {
+        struct target_user_cap_data *target_data;
+        int target_datalen = sizeof(*target_data) * data_items;
+        int i;
+
+        target_data = lock_user(VERIFY_WRITE, arg2, target_datalen, 0);
+        if (!target_data) {
+            return -TARGET_EFAULT;
+        }
+        for (i = 0; i < data_items; i++) {
+            target_data[i].effective = tswap32(data[i].effective);
+            target_data[i].permitted = tswap32(data[i].permitted);
+            target_data[i].inheritable = tswap32(data[i].inheritable);
+        }
+        unlock_user(target_data, arg2, target_datalen);
+    }
+    return ret;
+}
+
+IMPL(capset)
+{
+    struct target_user_cap_header *target_header;
+    struct __user_cap_header_struct header;
+    struct __user_cap_data_struct data[2];
+    abi_long ret;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_header, arg1, 1)) {
+        return -TARGET_EFAULT;
+    }
+    header.version = tswap32(target_header->version);
+    header.pid = tswap32(target_header->pid);
+
+    if (arg2) {
+        /* Version 2 and up takes pointer to two user_data structs */
+        int data_items = (header.version == _LINUX_CAPABILITY_VERSION ? 1 : 2);
+        struct target_user_cap_data *target_data;
+        int target_datalen = sizeof(*target_data) * data_items;
+        int i;
+
+        target_data = lock_user(VERIFY_READ, arg2, target_datalen, 1);
+        if (!target_data) {
+            unlock_user_struct(target_header, arg1, 0);
+            return -TARGET_EFAULT;
+        }
+
+        for (i = 0; i < data_items; i++) {
+            data[i].effective = tswap32(target_data[i].effective);
+            data[i].permitted = tswap32(target_data[i].permitted);
+            data[i].inheritable = tswap32(target_data[i].inheritable);
+        }
+        unlock_user(target_data, arg2, 0);
+    }
+
+    ret = get_errno(capset(&header, arg2 ? data : NULL));
+
+    /* The kernel always updates version for both capget and capset */
+    target_header->version = tswap32(header.version);
+    unlock_user_struct(target_header, arg1, 1);
+    return ret;
+}
+
 IMPL(chdir)
 {
     char *p = lock_user_string(arg1);
@@ -11181,76 +11265,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_capget:
-    case TARGET_NR_capset:
-    {
-        struct target_user_cap_header *target_header;
-        struct target_user_cap_data *target_data = NULL;
-        struct __user_cap_header_struct header;
-        struct __user_cap_data_struct data[2];
-        struct __user_cap_data_struct *dataptr = NULL;
-        int i, target_datalen;
-        int data_items = 1;
-
-        if (!lock_user_struct(VERIFY_WRITE, target_header, arg1, 1)) {
-            return -TARGET_EFAULT;
-        }
-        header.version = tswap32(target_header->version);
-        header.pid = tswap32(target_header->pid);
-
-        if (header.version != _LINUX_CAPABILITY_VERSION) {
-            /* Version 2 and up takes pointer to two user_data structs */
-            data_items = 2;
-        }
-
-        target_datalen = sizeof(*target_data) * data_items;
-
-        if (arg2) {
-            if (num == TARGET_NR_capget) {
-                target_data = lock_user(VERIFY_WRITE, arg2, target_datalen, 0);
-            } else {
-                target_data = lock_user(VERIFY_READ, arg2, target_datalen, 1);
-            }
-            if (!target_data) {
-                unlock_user_struct(target_header, arg1, 0);
-                return -TARGET_EFAULT;
-            }
-
-            if (num == TARGET_NR_capset) {
-                for (i = 0; i < data_items; i++) {
-                    data[i].effective = tswap32(target_data[i].effective);
-                    data[i].permitted = tswap32(target_data[i].permitted);
-                    data[i].inheritable = tswap32(target_data[i].inheritable);
-                }
-            }
-
-            dataptr = data;
-        }
-
-        if (num == TARGET_NR_capget) {
-            ret = get_errno(capget(&header, dataptr));
-        } else {
-            ret = get_errno(capset(&header, dataptr));
-        }
-
-        /* The kernel always updates version for both capget and capset */
-        target_header->version = tswap32(header.version);
-        unlock_user_struct(target_header, arg1, 1);
-
-        if (arg2) {
-            if (num == TARGET_NR_capget) {
-                for (i = 0; i < data_items; i++) {
-                    target_data[i].effective = tswap32(data[i].effective);
-                    target_data[i].permitted = tswap32(data[i].permitted);
-                    target_data[i].inheritable = tswap32(data[i].inheritable);
-                }
-                unlock_user(target_data, arg2, target_datalen);
-            } else {
-                unlock_user(target_data, arg2, 0);
-            }
-        }
-        return ret;
-    }
 #ifdef CONFIG_SENDFILE
     case TARGET_NR_sendfile:
     {
@@ -12991,6 +13005,8 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(bind);
 #endif
         SYSCALL(brk);
+        SYSCALL(capget);
+        SYSCALL(capset);
 #ifdef CONFIG_CLOCK_ADJTIME
         SYSCALL(clock_adjtime);
 #endif
-- 
2.17.1
