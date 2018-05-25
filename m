Received: from eggs.gnu.org ([2001:4830:134:3::10]:48821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fMAWQ-0003ir-4h
	for qemu-devel@nongnu.org; Fri, 25 May 2018 07:04:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fMAWN-0000Vy-SS
	for qemu-devel@nongnu.org; Fri, 25 May 2018 07:04:34 -0400
Received: from mga04.intel.com ([192.55.52.120]:54812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1fMAWN-0000Pd-KQ
	for qemu-devel@nongnu.org; Fri, 25 May 2018 07:04:31 -0400
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Fri, 25 May 2018 19:04:41 +0800
Message-Id: <20180525110441.7185-6-tiwei.bie@intel.com>
In-Reply-To: <20180525110441.7185-1-tiwei.bie@intel.com>
References: <20180525110441.7185-1-tiwei.bie@intel.com>
Subject: [Qemu-devel] [PATCH v2 5/5] vhost-user-bridge: support host notifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: tiwei.bie@intel.com

This patch introduces the host notifier support in
vhost-user-bridge. A new option (-H) is added to use
the host notifier. This is mainly used to test the
host notifier implementation in vhost user.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 tests/vhost-user-bridge.c | 98 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 95 insertions(+), 3 deletions(-)

diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
index e0605a529e..0884294141 100644
--- a/tests/vhost-user-bridge.c
+++ b/tests/vhost-user-bridge.c
@@ -29,6 +29,7 @@
 
 #define _FILE_OFFSET_BITS 64
 
+#include "qemu/atomic.h"
 #include "qemu/osdep.h"
 #include "qemu/iov.h"
 #include "standard-headers/linux/virtio_net.h"
@@ -65,6 +66,11 @@ typedef struct VubrDev {
     int sock;
     int ready;
     int quit;
+    struct {
+        int fd;
+        void *addr;
+        pthread_t thread;
+    } notifier;
 } VubrDev;
 
 static void
@@ -445,14 +451,22 @@ static uint64_t
 vubr_get_features(VuDev *dev)
 {
     return 1ULL << VIRTIO_NET_F_GUEST_ANNOUNCE |
-        1ULL << VIRTIO_NET_F_MRG_RXBUF;
+        1ULL << VIRTIO_NET_F_MRG_RXBUF |
+        1ULL << VIRTIO_F_VERSION_1;
 }
 
 static void
 vubr_queue_set_started(VuDev *dev, int qidx, bool started)
 {
+    VubrDev *vubr = container_of(dev, VubrDev, vudev);
     VuVirtq *vq = vu_get_queue(dev, qidx);
 
+    if (started && vubr->notifier.fd >= 0) {
+        vu_set_queue_host_notifier(dev, vq, vubr->notifier.fd,
+                                   getpagesize(),
+                                   qidx * getpagesize());
+    }
+
     if (qidx % 2 == 1) {
         vu_set_queue_handler(dev, vq, started ? vubr_handle_tx : NULL);
     }
@@ -522,6 +536,8 @@ vubr_new(const char *path, bool client)
         vubr_die("socket");
     }
 
+    dev->notifier.fd = -1;
+
     un.sun_family = AF_UNIX;
     strcpy(un.sun_path, path);
     len = sizeof(un.sun_family) + strlen(path);
@@ -559,6 +575,73 @@ vubr_new(const char *path, bool client)
     return dev;
 }
 
+static void *notifier_thread(void *arg)
+{
+    VuDev *dev = (VuDev *)arg;
+    VubrDev *vubr = container_of(dev, VubrDev, vudev);
+    int pagesize = getpagesize();
+    int qidx;
+
+    while (true) {
+        for (qidx = 0; qidx < VHOST_MAX_NR_VIRTQUEUE; qidx++) {
+            uint16_t *n = vubr->notifier.addr + pagesize * qidx;
+
+            if (*n == qidx) {
+                *n = 0xffff;
+                /* We won't miss notifications if we reset
+                 * the memory first. */
+                smp_mb();
+
+                DPRINT("Got a notification for queue%d via host notifier.\n",
+                       qidx);
+
+                if (qidx % 2 == 1) {
+                    vubr_handle_tx(dev, qidx);
+                }
+            }
+            usleep(1000);
+        }
+    }
+
+    return NULL;
+}
+
+static void
+vubr_host_notifier_setup(VubrDev *dev)
+{
+    char template[] = "/tmp/vubr-XXXXXX";
+    pthread_t thread;
+    size_t length;
+    void *addr;
+    int fd;
+
+    length = getpagesize() * VHOST_MAX_NR_VIRTQUEUE;
+
+    fd = mkstemp(template);
+    if (fd < 0) {
+        vubr_die("mkstemp()");
+    }
+
+    if (posix_fallocate(fd, 0, length) != 0) {
+        vubr_die("posix_fallocate()");
+    }
+
+    addr = mmap(NULL, length, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+    if (addr == MAP_FAILED) {
+        vubr_die("mmap()");
+    }
+
+    memset(addr, 0xff, length);
+
+    if (pthread_create(&thread, NULL, notifier_thread, &dev->vudev) != 0) {
+        vubr_die("pthread_create()");
+    }
+
+    dev->notifier.fd = fd;
+    dev->notifier.addr = addr;
+    dev->notifier.thread = thread;
+}
+
 static void
 vubr_set_host(struct sockaddr_in *saddr, const char *host)
 {
@@ -673,8 +756,9 @@ main(int argc, char *argv[])
     VubrDev *dev;
     int opt;
     bool client = false;
+    bool host_notifier = false;
 
-    while ((opt = getopt(argc, argv, "l:r:u:c")) != -1) {
+    while ((opt = getopt(argc, argv, "l:r:u:cH")) != -1) {
 
         switch (opt) {
         case 'l':
@@ -693,6 +777,9 @@ main(int argc, char *argv[])
         case 'c':
             client = true;
             break;
+        case 'H':
+            host_notifier = true;
+            break;
         default:
             goto out;
         }
@@ -708,6 +795,10 @@ main(int argc, char *argv[])
         return 1;
     }
 
+    if (host_notifier) {
+        vubr_host_notifier_setup(dev);
+    }
+
     vubr_backend_udp_setup(dev, lhost, lport, rhost, rport);
     vubr_run(dev);
 
@@ -717,7 +808,7 @@ main(int argc, char *argv[])
 
 out:
     fprintf(stderr, "Usage: %s ", argv[0]);
-    fprintf(stderr, "[-c] [-u ud_socket_path] [-l lhost:lport] [-r rhost:rport]\n");
+    fprintf(stderr, "[-c] [-H] [-u ud_socket_path] [-l lhost:lport] [-r rhost:rport]\n");
     fprintf(stderr, "\t-u path to unix doman socket. default: %s\n",
             DEFAULT_UD_SOCKET);
     fprintf(stderr, "\t-l local host and port. default: %s:%s\n",
@@ -725,6 +816,7 @@ out:
     fprintf(stderr, "\t-r remote host and port. default: %s:%s\n",
             DEFAULT_RHOST, DEFAULT_RPORT);
     fprintf(stderr, "\t-c client mode\n");
+    fprintf(stderr, "\t-H use host notifier\n");
 
     return 1;
 }
-- 
2.17.0
