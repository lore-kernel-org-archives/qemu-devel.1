Received: from eggs.gnu.org ([209.51.188.92]:40131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gliO0-0001Ni-Rx
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 17:49:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gliNx-0005BV-Lo
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 17:49:44 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 21 Jan 2019 16:49:01 -0600
Message-Id: <20190121224907.26634-16-eblake@redhat.com>
In-Reply-To: <20190121224907.26634-1-eblake@redhat.com>
References: <20190121224907.26634-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/21] nbd/client: Pull out oldstyle size
 determination
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Richard W . M . Jones" <rjones@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

Another refactoring creating nbd_negotiate_finish_oldstyle()
for further reuse during 'qemu-nbd --list'.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
Message-Id: <20190117193658.16413-16-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/client.c | 49 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 77cc12356f2..6829c684fec 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -814,7 +814,7 @@ static int nbd_negotiate_simple_meta_context(QIOChann=
el *ioc,
  * Start the handshake to the server.  After a positive return, the serv=
er
  * is ready to accept additional NBD_OPT requests.
  * Returns: negative errno: failure talking to server
- *          0: server is oldstyle, client must still parse export size
+ *          0: server is oldstyle, must call nbd_negotiate_finish_oldsty=
le
  *          1: server is newstyle, but can only accept EXPORT_NAME
  *          2: server is newstyle, but lacks structured replies
  *          3: server is newstyle and set up for structured replies
@@ -920,6 +920,36 @@ static int nbd_start_negotiate(QIOChannel *ioc, QCry=
ptoTLSCreds *tlscreds,
     }
 }

+/*
+ * nbd_negotiate_finish_oldstyle:
+ * Populate @info with the size and export flags from an oldstyle server=
,
+ * but does not consume 124 bytes of reserved zero padding.
+ * Returns 0 on success, -1 with @errp set on failure
+ */
+static int nbd_negotiate_finish_oldstyle(QIOChannel *ioc, NBDExportInfo =
*info,
+                                         Error **errp)
+{
+    uint32_t oldflags;
+
+    if (nbd_read(ioc, &info->size, sizeof(info->size), errp) < 0) {
+        error_prepend(errp, "Failed to read export length: ");
+        return -EINVAL;
+    }
+    info->size =3D be64_to_cpu(info->size);
+
+    if (nbd_read(ioc, &oldflags, sizeof(oldflags), errp) < 0) {
+        error_prepend(errp, "Failed to read export flags: ");
+        return -EINVAL;
+    }
+    oldflags =3D be32_to_cpu(oldflags);
+    if (oldflags & ~0xffff) {
+        error_setg(errp, "Unexpected export flags %0x" PRIx32, oldflags)=
;
+        return -EINVAL;
+    }
+    info->flags =3D oldflags;
+    return 0;
+}
+
 /*
  * nbd_receive_negotiate:
  * Connect to server, complete negotiation, and move into transmission p=
hase.
@@ -933,7 +963,6 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLS=
Creds *tlscreds,
     int result;
     bool zeroes;
     bool base_allocation =3D info->base_allocation;
-    uint32_t oldflags;

     assert(info->name);
     trace_nbd_receive_negotiate_name(info->name);
@@ -1006,23 +1035,9 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCrypto=
TLSCreds *tlscreds,
             error_setg(errp, "Server does not support non-empty export n=
ames");
             return -EINVAL;
         }
-
-        if (nbd_read(ioc, &info->size, sizeof(info->size), errp) < 0) {
-            error_prepend(errp, "Failed to read export length: ");
+        if (nbd_negotiate_finish_oldstyle(ioc, info, errp) < 0) {
             return -EINVAL;
         }
-        info->size =3D be64_to_cpu(info->size);
-
-        if (nbd_read(ioc, &oldflags, sizeof(oldflags), errp) < 0) {
-            error_prepend(errp, "Failed to read export flags: ");
-            return -EINVAL;
-        }
-        oldflags =3D be32_to_cpu(oldflags);
-        if (oldflags & ~0xffff) {
-            error_setg(errp, "Unexpected export flags %0x" PRIx32, oldfl=
ags);
-            return -EINVAL;
-        }
-        info->flags =3D oldflags;
         break;
     default:
         return result;
--=20
2.20.1
