Received: from eggs.gnu.org ([2001:4830:134:3::10]:56899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fUM0b-0005nl-RX
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 20:57:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fUM0Y-0003I4-2y
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 20:57:33 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34526)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fUM0X-0003Hv-TJ
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 20:57:30 -0400
Received: by mail-qk0-x243.google.com with SMTP id q70-v6so7676318qke.1
	for <qemu-devel@nongnu.org>; Sat, 16 Jun 2018 17:57:29 -0700 (PDT)
From: Keno Fischer <keno@juliacomputing.com>
Date: Sat, 16 Jun 2018 20:56:56 -0400
Message-Id: <a96f6f560722a2a7fa617473cbf9d5ed33c1f7a3.1529196703.git.keno@juliacomputing.com>
In-Reply-To: <cover.1529196703.git.keno@juliacomputing.com>
References: <cover.1529196703.git.keno@juliacomputing.com>
In-Reply-To: <cover.1529196703.git.keno@juliacomputing.com>
References: <cover.1529196703.git.keno@juliacomputing.com>
Subject: [Qemu-devel] [PATCH v3 12/13] 9p: darwin: virtfs-proxy: Implement
 setuid code for darwin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Keno Fischer <keno@juliacomputing.com>, groug@kaod.org

Darwin does not have linux capabilities, so make that code linux-only.
Darwin also does not have setresuid/gid. The correct way to temporarily
drop capabilities is to call seteuid/gid.

Also factor out the code that acquires acquire_dac_override into a separate
function in the linux implementation. I had originally done this when
I thought it made sense to have only one `setugid` function, but I retained
this because it seems clearer this way.

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---
 fsdev/virtfs-proxy-helper.c | 200 +++++++++++++++++++++++++++-----------------
 1 file changed, 125 insertions(+), 75 deletions(-)

diff --git a/fsdev/virtfs-proxy-helper.c b/fsdev/virtfs-proxy-helper.c
index d8dd3f5..6baf2a6 100644
--- a/fsdev/virtfs-proxy-helper.c
+++ b/fsdev/virtfs-proxy-helper.c
@@ -82,6 +82,7 @@ static void do_perror(const char *string)
     }
 }
 
+#ifdef CONFIG_LINUX
 static int do_cap_set(cap_value_t *cap_value, int size, int reset)
 {
     cap_t caps;
@@ -121,6 +122,85 @@ error:
     return -1;
 }
 
+static int acquire_dac_override(void)
+{
+    cap_value_t cap_list[] = {
+        CAP_DAC_OVERRIDE,
+    };
+    return do_cap_set(cap_list, ARRAY_SIZE(cap_list), 0);
+}
+
+/*
+ * from man 7 capabilities, section
+ * Effect of User ID Changes on Capabilities:
+ * If the effective user ID is changed from nonzero to 0, then the permitted
+ * set is copied to the effective set.  If the effective user ID is changed
+ * from 0 to nonzero, then all capabilities are are cleared from the effective
+ * set.
+ *
+ * The setfsuid/setfsgid man pages warn that changing the effective user ID may
+ * expose the program to unwanted signals, but this is not true anymore: for an
+ * unprivileged (without CAP_KILL) program to send a signal, the real or
+ * effective user ID of the sending process must equal the real or saved user
+ * ID of the target process.  Even when dropping privileges, it is enough to
+ * keep the saved UID to a "privileged" value and virtfs-proxy-helper won't
+ * be exposed to signals.  So just use setresuid/setresgid.
+ */
+static int setugid(int uid, int gid, int *suid, int *sgid)
+{
+    int retval;
+
+    *suid = geteuid();
+    *sgid = getegid();
+
+    if (setresgid(-1, gid, *sgid) == -1) {
+        retval = -errno;
+        goto err_out;
+    }
+
+    if (setresuid(-1, uid, *suid) == -1) {
+        retval = -errno;
+        goto err_sgid;
+    }
+
+    if (uid != 0 || gid != 0) {
+        /*
+        * We still need DAC_OVERRIDE because we don't change
+        * supplementary group ids, and hence may be subjected DAC rules
+        */
+        if (acquire_dac_override() < 0) {
+            retval = -errno;
+            goto err_suid;
+        }
+    }
+    return 0;
+
+err_suid:
+    if (setresuid(-1, *suid, *suid) == -1) {
+        abort();
+    }
+err_sgid:
+    if (setresgid(-1, *sgid, *sgid) == -1) {
+        abort();
+    }
+err_out:
+    return retval;
+}
+
+/*
+ * This is used to reset the ugid back with the saved values
+ * There is nothing much we can do checking error values here.
+ */
+static void resetugid(int suid, int sgid)
+{
+    if (setresgid(-1, sgid, sgid) == -1) {
+        abort();
+    }
+    if (setresuid(-1, suid, suid) == -1) {
+        abort();
+    }
+}
+
 static int init_capabilities(void)
 {
     /* helper needs following capabilities only */
@@ -135,6 +215,51 @@ static int init_capabilities(void)
     };
     return do_cap_set(cap_list, ARRAY_SIZE(cap_list), 1);
 }
+#else
+static int setugid(int uid, int gid, int *suid, int *sgid)
+{
+    int retval;
+
+    *suid = geteuid();
+    *sgid = getegid();
+
+    if (setegid(gid) == -1) {
+        retval = -errno;
+        goto err_out;
+    }
+
+    if (seteuid(uid) == -1) {
+        retval = -errno;
+        goto err_sgid;
+    }
+
+err_sgid:
+    if (setgid(*sgid) == -1) {
+        abort();
+    }
+err_out:
+    return retval;
+}
+
+/*
+ * This is used to reset the ugid back with the saved values
+ * There is nothing much we can do checking error values here.
+ */
+static void resetugid(int suid, int sgid)
+{
+    if (setegid(sgid) == -1) {
+        abort();
+    }
+    if (seteuid(suid) == -1) {
+        abort();
+    }
+}
+
+static int init_capabilities(void)
+{
+    return 0;
+}
+#endif
 
 static int socket_read(int sockfd, void *buff, ssize_t size)
 {
@@ -279,81 +404,6 @@ static int send_status(int sockfd, struct iovec *iovec, int status)
 }
 
 /*
- * from man 7 capabilities, section
- * Effect of User ID Changes on Capabilities:
- * If the effective user ID is changed from nonzero to 0, then the permitted
- * set is copied to the effective set.  If the effective user ID is changed
- * from 0 to nonzero, then all capabilities are are cleared from the effective
- * set.
- *
- * The setfsuid/setfsgid man pages warn that changing the effective user ID may
- * expose the program to unwanted signals, but this is not true anymore: for an
- * unprivileged (without CAP_KILL) program to send a signal, the real or
- * effective user ID of the sending process must equal the real or saved user
- * ID of the target process.  Even when dropping privileges, it is enough to
- * keep the saved UID to a "privileged" value and virtfs-proxy-helper won't
- * be exposed to signals.  So just use setresuid/setresgid.
- */
-static int setugid(int uid, int gid, int *suid, int *sgid)
-{
-    int retval;
-
-    /*
-     * We still need DAC_OVERRIDE because we don't change
-     * supplementary group ids, and hence may be subjected DAC rules
-     */
-    cap_value_t cap_list[] = {
-        CAP_DAC_OVERRIDE,
-    };
-
-    *suid = geteuid();
-    *sgid = getegid();
-
-    if (setresgid(-1, gid, *sgid) == -1) {
-        retval = -errno;
-        goto err_out;
-    }
-
-    if (setresuid(-1, uid, *suid) == -1) {
-        retval = -errno;
-        goto err_sgid;
-    }
-
-    if (uid != 0 || gid != 0) {
-        if (do_cap_set(cap_list, ARRAY_SIZE(cap_list), 0) < 0) {
-            retval = -errno;
-            goto err_suid;
-        }
-    }
-    return 0;
-
-err_suid:
-    if (setresuid(-1, *suid, *suid) == -1) {
-        abort();
-    }
-err_sgid:
-    if (setresgid(-1, *sgid, *sgid) == -1) {
-        abort();
-    }
-err_out:
-    return retval;
-}
-
-/*
- * This is used to reset the ugid back with the saved values
- * There is nothing much we can do checking error values here.
- */
-static void resetugid(int suid, int sgid)
-{
-    if (setresgid(-1, sgid, sgid) == -1) {
-        abort();
-    }
-    if (setresuid(-1, suid, suid) == -1) {
-        abort();
-    }
-}
-
-/*
  * send response in two parts
  * 1) ProxyHeader
  * 2) Response or error status
-- 
2.8.1
