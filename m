Received: from eggs.gnu.org ([2001:4830:134:3::10]:48387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVv-0005iZ-6z
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVt-0006k9-Fe
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:19 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:38810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1etCVt-0006ij-5X
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:17 -0500
Received: by mail-wm0-x242.google.com with SMTP id z9so22090600wmb.3
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:20:17 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Mar 2018 14:19:30 +0100
Message-Id: <1520342370-123606-35-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 34/34] use g_path_get_basename instead of
 basename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Julia Suvorova <jusual@mail.ru>

From: Julia Suvorova <jusual@mail.ru>

basename(3) and dirname(3) modify their argument and may return
pointers to statically allocated memory which may be overwritten by
subsequent calls.
g_path_get_basename and g_path_get_dirname have no such issues, and
therefore more preferable.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
Message-Id: <1519888086-4207-1-git-send-email-jusual@mail.ru>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 fsdev/virtfs-proxy-helper.c | 15 +++++++++------
 hw/s390x/s390-ccw.c         |  2 +-
 hw/vfio/pci.c               |  2 +-
 hw/vfio/platform.c          |  2 +-
 qemu-io.c                   |  2 +-
 qga/commands-posix.c        |  4 ++--
 6 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/fsdev/virtfs-proxy-helper.c b/fsdev/virtfs-proxy-helper.c
index 8e48500..6f132c5 100644
--- a/fsdev/virtfs-proxy-helper.c
+++ b/fsdev/virtfs-proxy-helper.c
@@ -55,6 +55,7 @@ static struct option helper_opts[] = {
 
 static bool is_daemon;
 static bool get_version; /* IOC getversion IOCTL supported */
+static char *prog_name;
 
 static void GCC_FMT_ATTR(2, 3) do_log(int loglevel, const char *format, ...)
 {
@@ -785,7 +786,7 @@ error:
     return -1;
 }
 
-static void usage(char *prog)
+static void usage(void)
 {
     fprintf(stderr, "usage: %s\n"
             " -p|--path <path> 9p path to export\n"
@@ -795,7 +796,7 @@ static void usage(char *prog)
             " access to this socket\n"
             " \tNote: -s & -f can not be used together\n"
             " [-n|--nodaemon] Run as a normal program\n",
-            basename(prog));
+            prog_name);
 }
 
 static int process_reply(int sock, int type,
@@ -1045,6 +1046,8 @@ int main(int argc, char **argv)
     struct statfs st_fs;
 #endif
 
+    prog_name = g_path_get_basename(argv[0]);
+
     is_daemon = true;
     sock = -1;
     own_u = own_g = -1;
@@ -1077,7 +1080,7 @@ int main(int argc, char **argv)
         case '?':
         case 'h':
         default:
-            usage(argv[0]);
+            usage();
             exit(EXIT_FAILURE);
         }
     }
@@ -1085,13 +1088,13 @@ int main(int argc, char **argv)
     /* Parameter validation */
     if ((sock_name == NULL && sock == -1) || rpath == NULL) {
         fprintf(stderr, "socket, socket descriptor or path not specified\n");
-        usage(argv[0]);
+        usage();
         return -1;
     }
 
     if (sock_name && sock != -1) {
         fprintf(stderr, "both named socket and socket descriptor specified\n");
-        usage(argv[0]);
+        usage();
         exit(EXIT_FAILURE);
     }
 
@@ -1099,7 +1102,7 @@ int main(int argc, char **argv)
         fprintf(stderr, "owner uid:gid not specified, ");
         fprintf(stderr,
                 "owner uid:gid specifies who can access the socket file\n");
-        usage(argv[0]);
+        usage();
         exit(EXIT_FAILURE);
     }
 
diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
index 7fc1c60..214c940 100644
--- a/hw/s390x/s390-ccw.c
+++ b/hw/s390x/s390-ccw.c
@@ -48,7 +48,7 @@ static void s390_ccw_get_dev_info(S390CCWDevice *cdev,
         return;
     }
 
-    cdev->mdevid = g_strdup(basename(dev_path));
+    cdev->mdevid = g_path_get_basename(dev_path);
 
     tmp = basename(dirname(dev_path));
     if (sscanf(tmp, "%2x.%1x.%4x", &cssid, &ssid, &devid) != 3) {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 033cc8d..3ba3cbc 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2807,7 +2807,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         return;
     }
 
-    vdev->vbasedev.name = g_strdup(basename(vdev->vbasedev.sysfsdev));
+    vdev->vbasedev.name = g_path_get_basename(vdev->vbasedev.sysfsdev);
     vdev->vbasedev.ops = &vfio_pci_ops;
     vdev->vbasedev.type = VFIO_DEVICE_TYPE_PCI;
     vdev->vbasedev.dev = &vdev->pdev.qdev;
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 0d4bc0a..5c921c2 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -561,7 +561,7 @@ static int vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
     /* @sysfsdev takes precedence over @host */
     if (vbasedev->sysfsdev) {
         g_free(vbasedev->name);
-        vbasedev->name = g_strdup(basename(vbasedev->sysfsdev));
+        vbasedev->name = g_path_get_basename(vbasedev->sysfsdev);
     } else {
         if (!vbasedev->name || strchr(vbasedev->name, '/')) {
             error_setg(errp, "wrong host device name");
diff --git a/qemu-io.c b/qemu-io.c
index 2c00ea0..160fb2a 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -504,7 +504,7 @@ int main(int argc, char **argv)
 #endif
 
     module_call_init(MODULE_INIT_TRACE);
-    progname = basename(argv[0]);
+    progname = g_path_get_basename(argv[0]);
     qemu_init_exec_dir(argv[0]);
 
     qcrypto_init(&error_fatal);
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index ac17d0d..0dc219d 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -808,7 +808,7 @@ static char *get_pci_driver(char const *syspath, int pathlen, Error **errp)
     len = readlink(dpath, buf, sizeof(buf) - 1);
     if (len != -1) {
         buf[len] = 0;
-        driver = g_strdup(basename(buf));
+        driver = g_path_get_basename(buf);
     }
     g_free(dpath);
     g_free(path);
@@ -1053,7 +1053,7 @@ static void build_guest_fsinfo_for_device(char const *devpath,
     }
 
     if (!fs->name) {
-        fs->name = g_strdup(basename(syspath));
+        fs->name = g_path_get_basename(syspath);
     }
 
     g_debug("  parse sysfs path '%s'", syspath);
-- 
1.8.3.1
