Received: from eggs.gnu.org ([2001:4830:134:3::10]:48554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gPQaB-0007EM-BY
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 06:22:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gPQa6-0008Sz-B5
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 06:22:11 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:32940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gPQa6-0008S4-2k
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 06:22:06 -0500
Received: by mail-pl1-x644.google.com with SMTP id z23so5127330plo.0
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 03:22:06 -0800 (PST)
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 21 Nov 2018 03:21:59 -0800
Message-Id: <1542799319-2595-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH] net: tap: use qemu_set_nonblock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com, mst@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

The fcntl will change the flags directly, use qemu_set_nonblock()
instead.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 net/tap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index cc8525f154..e8aadd8d4b 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -592,7 +592,7 @@ int net_init_bridge(const Netdev *netdev, const char *name,
         return -1;
     }
 
-    fcntl(fd, F_SETFL, O_NONBLOCK);
+    qemu_set_nonblock(fd);
     vnet_hdr = tap_probe_vnet_hdr(fd);
     s = net_tap_fd_init(peer, "bridge", name, fd, vnet_hdr);
 
@@ -707,7 +707,7 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                 }
                 return;
             }
-            fcntl(vhostfd, F_SETFL, O_NONBLOCK);
+            qemu_set_nonblock(vhostfd);
         }
         options.opaque = (void *)(uintptr_t)vhostfd;
 
@@ -791,7 +791,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
             return -1;
         }
 
-        fcntl(fd, F_SETFL, O_NONBLOCK);
+        qemu_set_nonblock(fd);
 
         vnet_hdr = tap_probe_vnet_hdr(fd);
 
@@ -839,7 +839,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
                 goto free_fail;
             }
 
-            fcntl(fd, F_SETFL, O_NONBLOCK);
+            qemu_set_nonblock(fd);
 
             if (i == 0) {
                 vnet_hdr = tap_probe_vnet_hdr(fd);
@@ -887,7 +887,7 @@ free_fail:
             return -1;
         }
 
-        fcntl(fd, F_SETFL, O_NONBLOCK);
+        qemu_set_nonblock(fd);
         vnet_hdr = tap_probe_vnet_hdr(fd);
 
         net_init_tap_one(tap, peer, "bridge", name, ifname,
-- 
2.11.0
