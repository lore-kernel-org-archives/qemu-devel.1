Received: from eggs.gnu.org ([209.51.188.92]:33335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hCWkQ-0004xK-UN
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 17:51:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hCWkO-0007Ta-9E
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 17:51:42 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri,  5 Apr 2019 21:16:35 +0200
Message-Id: <20190405191635.25740-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.1] qemu-nbd: Look up flag names in array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>

The existing code to convert flag bits into strings looks a bit strange
now, and if we ever add more flags, it will look even stranger.  Prevent
that from happening by making it look up the flag names in an array.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
Looking at the diff stat I can't claim this patch really improves
anything by much, but the current code just pains me so.
---
 include/block/nbd.h | 38 +++++++++++++++++++++++++------------
 qemu-nbd.c          | 46 +++++++++++++++++----------------------------
 2 files changed, 43 insertions(+), 41 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 6d05983a55..bb9f5bc021 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -127,18 +127,32 @@ typedef struct NBDExtent {
=20
 /* Transmission (export) flags: sent from server to client during handsh=
ake,
    but describe what will happen during transmission */
-#define NBD_FLAG_HAS_FLAGS         (1 << 0) /* Flags are there */
-#define NBD_FLAG_READ_ONLY         (1 << 1) /* Device is read-only */
-#define NBD_FLAG_SEND_FLUSH        (1 << 2) /* Send FLUSH */
-#define NBD_FLAG_SEND_FUA          (1 << 3) /* Send FUA (Force Unit Acce=
ss) */
-#define NBD_FLAG_ROTATIONAL        (1 << 4) /* Use elevator algorithm -
-                                               rotational media */
-#define NBD_FLAG_SEND_TRIM         (1 << 5) /* Send TRIM (discard) */
-#define NBD_FLAG_SEND_WRITE_ZEROES (1 << 6) /* Send WRITE_ZEROES */
-#define NBD_FLAG_SEND_DF           (1 << 7) /* Send DF (Do not Fragment)=
 */
-#define NBD_FLAG_CAN_MULTI_CONN    (1 << 8) /* Multi-client cache consis=
tent */
-#define NBD_FLAG_SEND_RESIZE       (1 << 9) /* Send resize */
-#define NBD_FLAG_SEND_CACHE        (1 << 10) /* Send CACHE (prefetch) */
+enum {
+    NBD_FLAG_HAS_FLAGS_BIT          =3D  0, /* Flags are there */
+    NBD_FLAG_READ_ONLY_BIT          =3D  1, /* Device is read-only */
+    NBD_FLAG_SEND_FLUSH_BIT         =3D  2, /* Send FLUSH */
+    NBD_FLAG_SEND_FUA_BIT           =3D  3, /* Send FUA (Force Unit Acce=
ss) */
+    NBD_FLAG_ROTATIONAL_BIT         =3D  4, /* Use elevator algorithm -
+                                             rotational media */
+    NBD_FLAG_SEND_TRIM_BIT          =3D  5, /* Send TRIM (discard) */
+    NBD_FLAG_SEND_WRITE_ZEROES_BIT  =3D  6, /* Send WRITE_ZEROES */
+    NBD_FLAG_SEND_DF_BIT            =3D  7, /* Send DF (Do not Fragment)=
 */
+    NBD_FLAG_CAN_MULTI_CONN_BIT     =3D  8, /* Multi-client cache consis=
tent */
+    NBD_FLAG_SEND_RESIZE_BIT        =3D  9, /* Send resize */
+    NBD_FLAG_SEND_CACHE_BIT         =3D 10, /* Send CACHE (prefetch) */
+};
+
+#define NBD_FLAG_HAS_FLAGS         (1 << NBD_FLAG_HAS_FLAGS_BIT)
+#define NBD_FLAG_READ_ONLY         (1 << NBD_FLAG_READ_ONLY_BIT)
+#define NBD_FLAG_SEND_FLUSH        (1 << NBD_FLAG_SEND_FLUSH_BIT)
+#define NBD_FLAG_SEND_FUA          (1 << NBD_FLAG_SEND_FUA_BIT)
+#define NBD_FLAG_ROTATIONAL        (1 << NBD_FLAG_ROTATIONAL_BIT)
+#define NBD_FLAG_SEND_TRIM         (1 << NBD_FLAG_SEND_TRIM_BIT)
+#define NBD_FLAG_SEND_WRITE_ZEROES (1 << NBD_FLAG_SEND_WRITE_ZEROES_BIT)
+#define NBD_FLAG_SEND_DF           (1 << NBD_FLAG_SEND_DF_BIT)
+#define NBD_FLAG_CAN_MULTI_CONN    (1 << NBD_FLAG_CAN_MULTI_CONN_BIT)
+#define NBD_FLAG_SEND_RESIZE       (1 << NBD_FLAG_SEND_RESIZE_BIT)
+#define NBD_FLAG_SEND_CACHE        (1 << NBD_FLAG_SEND_CACHE_BIT)
=20
 /* New-style handshake (global) flags, sent from server to client, and
    control what will happen during handshake phase. */
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 941ba729c2..a9c85db58e 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -279,37 +279,25 @@ static int qemu_nbd_client_list(SocketAddress *sadd=
r, QCryptoTLSCreds *tls,
             printf("  description: %s\n", list[i].description);
         }
         if (list[i].flags & NBD_FLAG_HAS_FLAGS) {
+            static const char *const flag_names[] =3D {
+                [NBD_FLAG_READ_ONLY_BIT]            =3D "readonly",
+                [NBD_FLAG_SEND_FLUSH_BIT]           =3D "flush",
+                [NBD_FLAG_SEND_FUA_BIT]             =3D "fua",
+                [NBD_FLAG_ROTATIONAL_BIT]           =3D "rotational",
+                [NBD_FLAG_SEND_TRIM_BIT]            =3D "trim",
+                [NBD_FLAG_SEND_WRITE_ZEROES_BIT]    =3D "zeroes",
+                [NBD_FLAG_SEND_DF_BIT]              =3D "df",
+                [NBD_FLAG_CAN_MULTI_CONN_BIT]       =3D "multi",
+                [NBD_FLAG_SEND_RESIZE_BIT]          =3D "resize",
+                [NBD_FLAG_SEND_CACHE_BIT]           =3D "cache",
+            };
+
             printf("  size:  %" PRIu64 "\n", list[i].size);
             printf("  flags: 0x%x (", list[i].flags);
-            if (list[i].flags & NBD_FLAG_READ_ONLY) {
-                printf(" readonly");
-            }
-            if (list[i].flags & NBD_FLAG_SEND_FLUSH) {
-                printf(" flush");
-            }
-            if (list[i].flags & NBD_FLAG_SEND_FUA) {
-                printf(" fua");
-            }
-            if (list[i].flags & NBD_FLAG_ROTATIONAL) {
-                printf(" rotational");
-            }
-            if (list[i].flags & NBD_FLAG_SEND_TRIM) {
-                printf(" trim");
-            }
-            if (list[i].flags & NBD_FLAG_SEND_WRITE_ZEROES) {
-                printf(" zeroes");
-            }
-            if (list[i].flags & NBD_FLAG_SEND_DF) {
-                printf(" df");
-            }
-            if (list[i].flags & NBD_FLAG_CAN_MULTI_CONN) {
-                printf(" multi");
-            }
-            if (list[i].flags & NBD_FLAG_SEND_RESIZE) {
-                printf(" resize");
-            }
-            if (list[i].flags & NBD_FLAG_SEND_CACHE) {
-                printf(" cache");
+            for (size_t bit =3D 0; bit < ARRAY_SIZE(flag_names); bit++) =
{
+                if (flag_names[bit] && (list[i].flags & (1 << bit))) {
+                    printf(" %s", flag_names[bit]);
+                }
             }
             printf(" )\n");
         }
--=20
2.20.1
