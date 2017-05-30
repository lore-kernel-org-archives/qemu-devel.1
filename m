Received: from eggs.gnu.org ([2001:4830:134:3::10]:50705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dFcRK-0006VJ-80
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:23:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dFcRH-0001Nt-7q
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:23:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1dFcRG-0001M2-VG
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:23:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 103CE81243
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 08:23:38 +0000 (UTC)
Received: from moe.brq.redhat.com (dhcp129-131.brq.redhat.com [10.34.129.131])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8A55717151
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 08:23:37 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
Date: Tue, 30 May 2017 10:23:33 +0200
Message-Id: <99971bb1889d4e5a4d603121034b1ed39a4e6912.1496132443.git.mprivozn@redhat.com>
In-Reply-To: <cover.1496132443.git.mprivozn@redhat.com>
References: <cover.1496132443.git.mprivozn@redhat.com>
In-Reply-To: <cover.1496132443.git.mprivozn@redhat.com>
References: <cover.1496132443.git.mprivozn@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] qemu-bridge-helper: Reverse return value
 setting logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Instead of initializing the return value @ret to a success value
and then having to reset it to failure value in every error path,
we can do the opposite. Initialize the value to failure value and
then set it to success value only after we've succeeded in all
we've attempted.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 qemu-bridge-helper.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/qemu-bridge-helper.c b/qemu-bridge-helper.c
index 5396fbfbb6..af6613ea18 100644
--- a/qemu-bridge-helper.c
+++ b/qemu-bridge-helper.c
@@ -228,7 +228,7 @@ int main(int argc, char **argv)
     ACLRule *acl_rule;
     ACLList acl_list;
     int access_allowed, access_denied;
-    int ret = EXIT_SUCCESS;
+    int rv, ret = EXIT_FAILURE;
 
 #ifdef CONFIG_LIBCAP
     /* if we're run from an suid binary, immediately drop privileges preserving
@@ -265,7 +265,6 @@ int main(int argc, char **argv)
     if (parse_acl_file(DEFAULT_ACL_FILE, &acl_list) == -1) {
         fprintf(stderr, "failed to parse default acl file `%s'\n",
                 DEFAULT_ACL_FILE);
-        ret = EXIT_FAILURE;
         goto cleanup;
     }
 
@@ -298,7 +297,6 @@ int main(int argc, char **argv)
 
     if ((access_allowed == 0) || (access_denied == 1)) {
         fprintf(stderr, "access denied by acl file\n");
-        ret = EXIT_FAILURE;
         goto cleanup;
     }
 
@@ -306,7 +304,6 @@ int main(int argc, char **argv)
     ctlfd = socket(AF_INET, SOCK_STREAM, 0);
     if (ctlfd == -1) {
         fprintf(stderr, "failed to open control socket: %s\n", strerror(errno));
-        ret = EXIT_FAILURE;
         goto cleanup;
     }
 
@@ -314,7 +311,6 @@ int main(int argc, char **argv)
     fd = open("/dev/net/tun", O_RDWR);
     if (fd == -1) {
         fprintf(stderr, "failed to open /dev/net/tun: %s\n", strerror(errno));
-        ret = EXIT_FAILURE;
         goto cleanup;
     }
 
@@ -328,7 +324,6 @@ int main(int argc, char **argv)
 
     if (ioctl(fd, TUNSETIFF, &ifr) == -1) {
         fprintf(stderr, "failed to create tun device: %s\n", strerror(errno));
-        ret = EXIT_FAILURE;
         goto cleanup;
     }
 
@@ -340,7 +335,6 @@ int main(int argc, char **argv)
     if (ioctl(ctlfd, SIOCGIFMTU, &ifr) == -1) {
         fprintf(stderr, "failed to get mtu of bridge `%s': %s\n",
                 bridge, strerror(errno));
-        ret = EXIT_FAILURE;
         goto cleanup;
     }
 
@@ -353,7 +347,6 @@ int main(int argc, char **argv)
     if (ioctl(ctlfd, SIOCSIFMTU, &ifr) == -1) {
         fprintf(stderr, "failed to set mtu of device `%s' to %d: %s\n",
                 iface, mtu, strerror(errno));
-        ret = EXIT_FAILURE;
         goto cleanup;
     }
 
@@ -364,14 +357,12 @@ int main(int argc, char **argv)
     if (ioctl(ctlfd, SIOCGIFHWADDR, &ifr) < 0) {
         fprintf(stderr, "failed to get MAC address of device `%s': %s\n",
                 iface, strerror(errno));
-        ret = EXIT_FAILURE;
         goto cleanup;
     }
     ifr.ifr_hwaddr.sa_data[0] = 0xFE;
     if (ioctl(ctlfd, SIOCSIFHWADDR, &ifr) < 0) {
         fprintf(stderr, "failed to set MAC address of device `%s': %s\n",
                 iface, strerror(errno));
-        ret = EXIT_FAILURE;
         goto cleanup;
     }
 
@@ -384,15 +375,14 @@ int main(int argc, char **argv)
     ifargs[2] = 0;
     ifargs[3] = 0;
     ifr.ifr_data = (void *)ifargs;
-    ret = ioctl(ctlfd, SIOCDEVPRIVATE, &ifr);
+    rv = ioctl(ctlfd, SIOCDEVPRIVATE, &ifr);
 #else
     ifr.ifr_ifindex = ifindex;
-    ret = ioctl(ctlfd, SIOCBRADDIF, &ifr);
+    rv = ioctl(ctlfd, SIOCBRADDIF, &ifr);
 #endif
-    if (ret == -1) {
+    if (rv == -1) {
         fprintf(stderr, "failed to add interface `%s' to bridge `%s': %s\n",
                 iface, bridge, strerror(errno));
-        ret = EXIT_FAILURE;
         goto cleanup;
     }
 
@@ -401,7 +391,6 @@ int main(int argc, char **argv)
     if (ioctl(ctlfd, SIOCGIFFLAGS, &ifr) == -1) {
         fprintf(stderr, "failed to get interface flags for `%s': %s\n",
                 iface, strerror(errno));
-        ret = EXIT_FAILURE;
         goto cleanup;
     }
 
@@ -409,7 +398,6 @@ int main(int argc, char **argv)
     if (ioctl(ctlfd, SIOCSIFFLAGS, &ifr) == -1) {
         fprintf(stderr, "failed to bring up interface `%s': %s\n",
                 iface, strerror(errno));
-        ret = EXIT_FAILURE;
         goto cleanup;
     }
 
@@ -417,13 +405,13 @@ int main(int argc, char **argv)
     if (send_fd(unixfd, fd) == -1) {
         fprintf(stderr, "failed to write fd to unix socket: %s\n",
                 strerror(errno));
-        ret = EXIT_FAILURE;
         goto cleanup;
     }
 
     /* ... */
 
     /* profit! */
+    ret = EXIT_SUCCESS;
 
 cleanup:
     if (fd >= 0) {
-- 
2.13.0
