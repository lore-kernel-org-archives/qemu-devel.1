Received: from eggs.gnu.org ([2001:4830:134:3::10]:34478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYAOF-0004qQ-IT
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 08:54:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYAOE-0008Dd-CH
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 08:53:59 -0500
From: Eric Blake <eblake@redhat.com>
Date: Sat, 15 Dec 2018 07:53:10 -0600
Message-Id: <20181215135324.152629-9-eblake@redhat.com>
In-Reply-To: <20181215135324.152629-1-eblake@redhat.com>
References: <20181215135324.152629-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 08/22] nbd/client: Drop pointless buf
 variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: nsoffer@redhat.com, jsnow@redhat.com, rjones@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

There's no need to read into a temporary buffer (oversized
since commit 7d3123e1) followed by a byteswap into a uint64_t
to check for a magic number via memcmp(), when the code
immediately below demonstrates reading into the uint64_t then
byteswapping in place and checking for a magic number via
integer math.  What's more, having a different error message
when the server's first reply byte is 0 is unusual - it's no
different from any other wrong magic number, and we already
detected short reads. That whole strlen() issue has been
present and useless since commit 1d45f8b5 in 2010; perhaps it
was leftover debugging (since the correct magic number happens
to be ASCII)?  Make the error messages more consistent and
detailed while touching things.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

---
v2: improve commit message based on git archaeology [Rich]
added strategic comments, and improve error messages [Vladimir]
---
 nbd/nbd-internal.h |  3 ++-
 nbd/client.c       | 22 +++++++---------------
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index eeff78d3c98..443e177d44a 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -46,8 +46,9 @@
 /* Size of oldstyle negotiation */
 #define NBD_OLDSTYLE_NEGOTIATE_SIZE (8 + 8 + 8 + 4 + 124)

+#define NBD_INIT_MAGIC              0x4e42444d41474943LL /* ASCII "NBDMAGIC" */
 #define NBD_REQUEST_MAGIC           0x25609513
-#define NBD_OPTS_MAGIC              0x49484156454F5054LL
+#define NBD_OPTS_MAGIC              0x49484156454F5054LL /* ASCII "IHAVEOPT" */
 #define NBD_CLIENT_MAGIC            0x0000420281861253LL
 #define NBD_REP_MAGIC               0x0003e889045565a9LL

diff --git a/nbd/client.c b/nbd/client.c
index 3d9086af39d..1a3a620fb6d 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -731,7 +731,6 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
                           QIOChannel **outioc, NBDExportInfo *info,
                           Error **errp)
 {
-    char buf[256];
     uint64_t magic;
     int rc;
     bool zeroes = true;
@@ -752,27 +751,20 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
         goto fail;
     }

-    if (nbd_read(ioc, buf, 8, errp) < 0) {
-        error_prepend(errp, "Failed to read data: ");
+    if (nbd_read(ioc, &magic, sizeof(magic), errp) < 0) {
+        error_prepend(errp, "Failed to read initial magic: ");
         goto fail;
     }
-
-    buf[8] = '\0';
-    if (strlen(buf) == 0) {
-        error_setg(errp, "Server connection closed unexpectedly");
-        goto fail;
-    }
-
-    magic = ldq_be_p(buf);
+    magic = be64_to_cpu(magic);
     trace_nbd_receive_negotiate_magic(magic);

-    if (memcmp(buf, "NBDMAGIC", 8) != 0) {
-        error_setg(errp, "Invalid magic received");
+    if (magic != NBD_INIT_MAGIC) {
+        error_setg(errp, "Bad initial magic received: 0x%" PRIx64, magic);
         goto fail;
     }

     if (nbd_read(ioc, &magic, sizeof(magic), errp) < 0) {
-        error_prepend(errp, "Failed to read magic: ");
+        error_prepend(errp, "Failed to read server magic: ");
         goto fail;
     }
     magic = be64_to_cpu(magic);
@@ -911,7 +903,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
         }
         info->flags = oldflags;
     } else {
-        error_setg(errp, "Bad magic received");
+        error_setg(errp, "Bad server magic received: 0x%" PRIx64, magic);
         goto fail;
     }

-- 
2.17.2
