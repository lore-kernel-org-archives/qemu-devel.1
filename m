Received: from eggs.gnu.org ([2001:4830:134:3::10]:46502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHVGn-00088z-C3
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:45:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHVGk-00016K-Kc
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:45:24 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:36193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gHVGi-00011u-KE
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:45:21 -0400
Received: by mail-qt1-x842.google.com with SMTP id u34-v6so13729479qth.3
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 07:45:20 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 30 Oct 2018 09:43:37 -0500
Message-Id: <20181030144358.23144-4-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20181030144358.23144-1-mdroth@linux.vnet.ibm.com>
References: <20181030144358.23144-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/24] qga: ignore non present cpus when
 handling qmp_guest_get_vcpus()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

If VM has VCPUs plugged sparselly (for example a VM started with
3 VCPUs (cpu0, cpu1 and cpu2) and then cpu1 was hotunplugged so
only cpu0 and cpu2 are present), QGA will rise a error
  error: internal error: unable to execute QEMU agent command 'guest-get-vcpus':
  open("/sys/devices/system/cpu/cpu1/"): No such file or directory
when
  virsh vcpucount FOO --guest
is executed.
Fix it by ignoring non present CPUs when fetching CPUs status from sysfs.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-posix.c | 115 ++++++++++++++++++++++---------------------
 1 file changed, 59 insertions(+), 56 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 37e8a2d791..42d30f078e 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -2035,61 +2035,56 @@ static long sysconf_exact(int name, const char *name_str, Error **errp)
  * Written members remain unmodified on error.
  */
 static void transfer_vcpu(GuestLogicalProcessor *vcpu, bool sys2vcpu,
-                          Error **errp)
+                          char *dirpath, Error **errp)
 {
-    char *dirpath;
+    int fd;
+    int res;
     int dirfd;
+    static const char fn[] = "online";
 
-    dirpath = g_strdup_printf("/sys/devices/system/cpu/cpu%" PRId64 "/",
-                              vcpu->logical_id);
     dirfd = open(dirpath, O_RDONLY | O_DIRECTORY);
     if (dirfd == -1) {
         error_setg_errno(errp, errno, "open(\"%s\")", dirpath);
-    } else {
-        static const char fn[] = "online";
-        int fd;
-        int res;
-
-        fd = openat(dirfd, fn, sys2vcpu ? O_RDONLY : O_RDWR);
-        if (fd == -1) {
-            if (errno != ENOENT) {
-                error_setg_errno(errp, errno, "open(\"%s/%s\")", dirpath, fn);
-            } else if (sys2vcpu) {
-                vcpu->online = true;
-                vcpu->can_offline = false;
-            } else if (!vcpu->online) {
-                error_setg(errp, "logical processor #%" PRId64 " can't be "
-                           "offlined", vcpu->logical_id);
-            } /* otherwise pretend successful re-onlining */
-        } else {
-            unsigned char status;
-
-            res = pread(fd, &status, 1, 0);
-            if (res == -1) {
-                error_setg_errno(errp, errno, "pread(\"%s/%s\")", dirpath, fn);
-            } else if (res == 0) {
-                error_setg(errp, "pread(\"%s/%s\"): unexpected EOF", dirpath,
-                           fn);
-            } else if (sys2vcpu) {
-                vcpu->online = (status != '0');
-                vcpu->can_offline = true;
-            } else if (vcpu->online != (status != '0')) {
-                status = '0' + vcpu->online;
-                if (pwrite(fd, &status, 1, 0) == -1) {
-                    error_setg_errno(errp, errno, "pwrite(\"%s/%s\")", dirpath,
-                                     fn);
-                }
-            } /* otherwise pretend successful re-(on|off)-lining */
+        return;
+    }
 
-            res = close(fd);
-            g_assert(res == 0);
-        }
+    fd = openat(dirfd, fn, sys2vcpu ? O_RDONLY : O_RDWR);
+    if (fd == -1) {
+        if (errno != ENOENT) {
+            error_setg_errno(errp, errno, "open(\"%s/%s\")", dirpath, fn);
+        } else if (sys2vcpu) {
+            vcpu->online = true;
+            vcpu->can_offline = false;
+        } else if (!vcpu->online) {
+            error_setg(errp, "logical processor #%" PRId64 " can't be "
+                       "offlined", vcpu->logical_id);
+        } /* otherwise pretend successful re-onlining */
+    } else {
+        unsigned char status;
+
+        res = pread(fd, &status, 1, 0);
+        if (res == -1) {
+            error_setg_errno(errp, errno, "pread(\"%s/%s\")", dirpath, fn);
+        } else if (res == 0) {
+            error_setg(errp, "pread(\"%s/%s\"): unexpected EOF", dirpath,
+                       fn);
+        } else if (sys2vcpu) {
+            vcpu->online = (status != '0');
+            vcpu->can_offline = true;
+        } else if (vcpu->online != (status != '0')) {
+            status = '0' + vcpu->online;
+            if (pwrite(fd, &status, 1, 0) == -1) {
+                error_setg_errno(errp, errno, "pwrite(\"%s/%s\")", dirpath,
+                                 fn);
+            }
+        } /* otherwise pretend successful re-(on|off)-lining */
 
-        res = close(dirfd);
+        res = close(fd);
         g_assert(res == 0);
     }
 
-    g_free(dirpath);
+    res = close(dirfd);
+    g_assert(res == 0);
 }
 
 GuestLogicalProcessorList *qmp_guest_get_vcpus(Error **errp)
@@ -2107,17 +2102,21 @@ GuestLogicalProcessorList *qmp_guest_get_vcpus(Error **errp)
     while (local_err == NULL && current < sc_max) {
         GuestLogicalProcessor *vcpu;
         GuestLogicalProcessorList *entry;
-
-        vcpu = g_malloc0(sizeof *vcpu);
-        vcpu->logical_id = current++;
-        vcpu->has_can_offline = true; /* lolspeak ftw */
-        transfer_vcpu(vcpu, true, &local_err);
-
-        entry = g_malloc0(sizeof *entry);
-        entry->value = vcpu;
-
-        *link = entry;
-        link = &entry->next;
+        int64_t id = current++;
+        char *path = g_strdup_printf("/sys/devices/system/cpu/cpu%" PRId64 "/",
+                                     id);
+
+        if (g_file_test(path, G_FILE_TEST_EXISTS)) {
+            vcpu = g_malloc0(sizeof *vcpu);
+            vcpu->logical_id = id;
+            vcpu->has_can_offline = true; /* lolspeak ftw */
+            transfer_vcpu(vcpu, true, path, &local_err);
+            entry = g_malloc0(sizeof *entry);
+            entry->value = vcpu;
+            *link = entry;
+            link = &entry->next;
+        }
+        g_free(path);
     }
 
     if (local_err == NULL) {
@@ -2138,7 +2137,11 @@ int64_t qmp_guest_set_vcpus(GuestLogicalProcessorList *vcpus, Error **errp)
 
     processed = 0;
     while (vcpus != NULL) {
-        transfer_vcpu(vcpus->value, false, &local_err);
+        char *path = g_strdup_printf("/sys/devices/system/cpu/cpu%" PRId64 "/",
+                                     vcpus->value->logical_id);
+
+        transfer_vcpu(vcpus->value, false, path, &local_err);
+        g_free(path);
         if (local_err != NULL) {
             break;
         }
-- 
2.17.1
