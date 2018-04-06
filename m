Received: from eggs.gnu.org ([2001:4830:134:3::10]:37088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikhilbalachandra.inbox@gmail.com>)
	id 1f4XG4-0006Gx-6L
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 15:42:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikhilbalachandra.inbox@gmail.com>)
	id 1f4XG0-00088U-RE
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 15:42:48 -0400
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:44950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nikhilbalachandra.inbox@gmail.com>)
	id 1f4XG0-00088C-Iw
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 15:42:44 -0400
Received: by mail-ot0-x232.google.com with SMTP id p33-v6so2385742otp.11
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 12:42:44 -0700 (PDT)
From: Nikhil Balachandra <nikhilbalachandra.inbox@gmail.com>
Date: Sat,  7 Apr 2018 01:12:05 +0530
Message-Id: <20180406194205.9872-1-nikhilbalachandra.inbox@gmail.com>
Subject: [Qemu-devel] [PATCH 1/1] Make qemu-bridge-helper work in macOS and
 FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Nikhil Balachandra <nikhilbalachandra.inbox@gmail.com>

Add macOS and FreeBSD support to the qemu-bridge-helper.

Differences when compared to linux version.
1) Does no drop privileges at the start of the process and run as root
   throughout the lifetime of the process there by increasing the risk
   incase of security vulnerability.
2) Does not support --use-vnet flag.

Signed-off-by: Nikhil Balachandra <nikhilbalachandra.inbox@gmail.com>
---
 Makefile             |   8 +++-
 Makefile.objs        |   5 ++
 configure            |   5 ++
 qemu-bridge-helper.c | 131 +++++++++++++++++++++++++++++++++------------------
 4 files changed, 102 insertions(+), 47 deletions(-)

This patch makes qemu-bridge-helper work in macOS and FreeBSD platforms.
The patch also contains changes in configure script and Makefile for
building qemu-bridge-helper in these platforms.

After applying the patch, running `$ make` or `$ make qemu-bridge-helper`
should build the binary (see macOS caveat below).

While the compilation process is straight-forward in FreeBSD, there is one
caveat while building for the macOS. Unlike FreeBSD, macOS does not ship
with net/if_bridgevar.h header file. This Header file however could be
obtained from the Darwin/XNU repository[1] and can be copied somewhere in
the include path before building.

Eventhough macOS does not ship with the if_bridgevar.h header file[2],
I expect the API to remain stable as this header file is similar to what
is found in other BSDs. If this patch is decided to be included in the
qemu, can experienced qemu developers please tell me how to go about
having this header file in the include path such that it does not require
manually downloading and copying the file[3]?

This is also my first patch to qemu and opensource C codebase project.
Please be critical while reviewing the code.

[1] - https://github.com/apple/darwin-xnu/blob/master/bsd/net/if_bridgevar.h
[2] - Adding to the complexity, this header file is also marked as 
private/internal. 
[3] - Couple of ideas: This could be automatically downloaded during the
build or can be directly copied into the qemu source tree if license
permits such a usage.

Thanks and Regards,
Nikhil


diff --git a/Makefile b/Makefile
index 727ef118f3..c581d91c6b 100644
--- a/Makefile
+++ b/Makefile
@@ -347,7 +347,10 @@ $(call set-vpath, $(SRC_PATH))
 
 LIBS+=-lz $(LIBS_TOOLS)
 
+# Build Helpers (currently only qemu-bridge-helper) for Linux, FreeBSD and macOS.
 HELPERS-$(CONFIG_LINUX) = qemu-bridge-helper$(EXESUF)
+HELPERS-$(CONFIG_FREEBSD) = qemu-bridge-helper$(EXESUF)
+HELPERS-$(CONFIG_DARWIN) = qemu-bridge-helper$(EXESUF)
 
 ifdef BUILD_DOCS
 DOCS=qemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8 qemu-ga.8
@@ -429,7 +432,8 @@ dummy := $(call unnest-vars,, \
                 ui-obj-m \
                 audio-obj-y \
                 audio-obj-m \
-                trace-obj-y)
+                trace-obj-y \
+                tap-obj-y)
 
 include $(SRC_PATH)/tests/Makefile.include
 
@@ -535,7 +539,7 @@ qemu-img$(EXESUF): qemu-img.o $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-o
 qemu-nbd$(EXESUF): qemu-nbd.o $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 qemu-io$(EXESUF): qemu-io.o $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 
-qemu-bridge-helper$(EXESUF): qemu-bridge-helper.o $(COMMON_LDADDS)
+qemu-bridge-helper$(EXESUF): qemu-bridge-helper.o $(tap-obj-y) $(COMMON_LDADDS)
 
 qemu-keymap$(EXESUF): qemu-keymap.o ui/input-keymap.o $(COMMON_LDADDS)
 
diff --git a/Makefile.objs b/Makefile.objs
index c6c9b8fc21..1f9ced33bf 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -86,6 +86,11 @@ qom-obj-y = qom/
 
 io-obj-y = io/
 
+#######################################################################
+# tap-obj-y is code used by qemu-bridge-helper
+
+tap-obj-y = net/
+
 ######################################################################
 # Target independent part of system emulation. The long term path is to
 # suppress *all* target specific code in case of system emulation, i.e. a
diff --git a/configure b/configure
index a2301dd0dc..34b6c398c7 100755
--- a/configure
+++ b/configure
@@ -728,6 +728,7 @@ GNU/kFreeBSD)
 ;;
 FreeBSD)
   bsd="yes"
+  freebsd="yes"
   make="${MAKE-gmake}"
   audio_drv_list="oss"
   audio_possible_drivers="oss sdl pa"
@@ -5985,6 +5986,10 @@ if test "$linux" = "yes" ; then
   echo "CONFIG_LINUX=y" >> $config_host_mak
 fi
 
+if test "$freebsd" = "yes" ; then
+  echo "CONFIG_FREEBSD=y" >> $config_host_mak
+fi
+
 if test "$darwin" = "yes" ; then
   echo "CONFIG_DARWIN=y" >> $config_host_mak
 fi
diff --git a/qemu-bridge-helper.c b/qemu-bridge-helper.c
index 5396fbfbb6..2ed1b5503f 100644
--- a/qemu-bridge-helper.c
+++ b/qemu-bridge-helper.c
@@ -15,23 +15,47 @@
 
 #include "qemu/osdep.h"
 
-
 #include <sys/ioctl.h>
 #include <sys/socket.h>
 #include <sys/un.h>
-#include <sys/prctl.h>
-
 #include <net/if.h>
 
+#if defined(__linux__)
+#include <sys/prctl.h>
 #include <linux/sockios.h>
+#include "net/tap-linux.h"
+#elif defined(__FreeBSD__) || defined(__APPLE__)
+#include <sys/sockio.h>
+#endif
 
-#ifndef SIOCBRADDIF
+#if defined(__linux__) && !defined(SIOCBRADDIF)
 #include <linux/if_bridge.h>
 #endif
 
+#if defined(__FreeBSD__)
+#include <net/ethernet.h>
+#include <net/if_bridgevar.h>
+#endif
+
+/* Unlike other BSDs, macOS does not ship with if_bridgevar.h header and has
+ * marked header file as private (internal to Apple). Since this header file
+ * is similar to what found in other BSDs, it should have a fairly stable API
+ * to be used in this file.
+ */
+#if defined(__APPLE__)
+#ifndef PRIVATE
+#define PRIVATE 1
+#include "osx/if_bridgevar.h"
+#undef PRIVATE
+#else
+#include "osx/if_bridgevar.h"
+#endif
+#endif
+
 #include "qemu/queue.h"
+#include "qapi/error.h"
 
-#include "net/tap-linux.h"
+#include "net/tap_int.h"
 
 #ifdef CONFIG_LIBCAP
 #include <cap-ng.h>
@@ -143,6 +167,13 @@ static int parse_acl_file(const char *filename, ACLList *acl_list)
     return 0;
 }
 
+static void prep_ifreq(struct ifreq *ifr, const char *ifname)
+{
+    memset(ifr, 0, sizeof(*ifr));
+    snprintf(ifr->ifr_name, IFNAMSIZ, "%s", ifname);
+}
+
+#if defined(__linux__)
 static bool has_vnet_hdr(int fd)
 {
     unsigned int features = 0;
@@ -158,11 +189,48 @@ static bool has_vnet_hdr(int fd)
     return true;
 }
 
-static void prep_ifreq(struct ifreq *ifr, const char *ifname)
+static int add_iface_to_bridge(const char *iface, const char *bridge, int ctlfd)
 {
-    memset(ifr, 0, sizeof(*ifr));
-    snprintf(ifr->ifr_name, IFNAMSIZ, "%s", ifname);
+    int ifindex;
+    int ret;
+    struct ifreq ifr;
+    prep_ifreq(&ifr, bridge);
+    ifindex = if_nametoindex(iface);
+#ifndef SIOCBRADDIF
+    unsigned long ifargs[4];
+    ifargs[0] = BRCTL_ADD_IF;
+    ifargs[1] = ifindex;
+    ifargs[2] = 0;
+    ifargs[3] = 0;
+    ifr.ifr_data = (void *)ifargs;
+    ret = ioctl(ctlfd, SIOCDEVPRIVATE, &ifr);
+#else
+    ifr.ifr_ifindex = ifindex;
+    ret = ioctl(ctlfd, SIOCBRADDIF, &ifr);
+#endif
+    return ret;
 }
+#else
+static bool has_vnet_hdr(int fd)
+{
+    return false;
+}
+static int add_iface_to_bridge(const char *iface, const char *bridge, int ctlfd)
+{
+    struct ifbreq req;
+    memset(&req, 0, sizeof(req));
+    strlcpy(req.ifbr_ifsname, iface, sizeof(req.ifbr_ifsname));
+
+    struct ifdrv ifd;
+    memset(&ifd, 0, sizeof(ifd));
+
+    strlcpy(ifd.ifd_name, bridge, sizeof(ifd.ifd_name));
+    ifd.ifd_cmd = BRDGADD;
+    ifd.ifd_len = sizeof(req);
+    ifd.ifd_data = &req;
+    return ioctl(ctlfd, SIOCSDRVSPEC, &ifd);
+}
+#endif
 
 static int send_fd(int c, int fd)
 {
@@ -215,10 +283,6 @@ static int drop_privileges(void)
 int main(int argc, char **argv)
 {
     struct ifreq ifr;
-#ifndef SIOCBRADDIF
-    unsigned long ifargs[4];
-#endif
-    int ifindex;
     int fd = -1, ctlfd = -1, unixfd = -1;
     int use_vnet = 0;
     int mtu;
@@ -310,30 +374,18 @@ int main(int argc, char **argv)
         goto cleanup;
     }
 
+
     /* open the tap device */
-    fd = open("/dev/net/tun", O_RDWR);
+    memset(&iface, '\0', sizeof(char) * IFNAMSIZ);
+    int vnet_supported = has_vnet_hdr(fd);
+    Error *err = NULL;
+    fd = tap_open(&iface[0], sizeof(iface), &vnet_supported, use_vnet, 0, &err);
     if (fd == -1) {
-        fprintf(stderr, "failed to open /dev/net/tun: %s\n", strerror(errno));
+        fprintf(stderr, "%s\n", error_get_pretty(err));
         ret = EXIT_FAILURE;
         goto cleanup;
     }
-
-    /* request a tap device, disable PI, and add vnet header support if
-     * requested and it's available. */
-    prep_ifreq(&ifr, "tap%d");
-    ifr.ifr_flags = IFF_TAP|IFF_NO_PI;
-    if (use_vnet && has_vnet_hdr(fd)) {
-        ifr.ifr_flags |= IFF_VNET_HDR;
-    }
-
-    if (ioctl(fd, TUNSETIFF, &ifr) == -1) {
-        fprintf(stderr, "failed to create tun device: %s\n", strerror(errno));
-        ret = EXIT_FAILURE;
-        goto cleanup;
-    }
-
-    /* save tap device name */
-    snprintf(iface, sizeof(iface), "%s", ifr.ifr_name);
+    error_free(err);
 
     /* get the mtu of the bridge */
     prep_ifreq(&ifr, bridge);
@@ -357,6 +409,7 @@ int main(int argc, char **argv)
         goto cleanup;
     }
 
+#if defined(__linux__)
     /* Linux uses the lowest enslaved MAC address as the MAC address of
      * the bridge.  Set MAC address to a high value so that it doesn't
      * affect the MAC address of the bridge.
@@ -374,22 +427,10 @@ int main(int argc, char **argv)
         ret = EXIT_FAILURE;
         goto cleanup;
     }
+#endif
 
     /* add the interface to the bridge */
-    prep_ifreq(&ifr, bridge);
-    ifindex = if_nametoindex(iface);
-#ifndef SIOCBRADDIF
-    ifargs[0] = BRCTL_ADD_IF;
-    ifargs[1] = ifindex;
-    ifargs[2] = 0;
-    ifargs[3] = 0;
-    ifr.ifr_data = (void *)ifargs;
-    ret = ioctl(ctlfd, SIOCDEVPRIVATE, &ifr);
-#else
-    ifr.ifr_ifindex = ifindex;
-    ret = ioctl(ctlfd, SIOCBRADDIF, &ifr);
-#endif
-    if (ret == -1) {
+    if (add_iface_to_bridge(iface, bridge, ctlfd) == -1) {
         fprintf(stderr, "failed to add interface `%s' to bridge `%s': %s\n",
                 iface, bridge, strerror(errno));
         ret = EXIT_FAILURE;
-- 
2.16.3
