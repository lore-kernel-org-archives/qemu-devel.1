Received: from eggs.gnu.org ([2001:4830:134:3::10]:40414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cft2d-0006oH-Vy
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 13:50:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cft2d-0002U9-60
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 13:50:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cft2c-0002Ti-Vj
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 13:50:31 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 20 Feb 2017 18:50:20 +0000
Message-Id: <20170220185020.774-6-dgilbert@redhat.com>
In-Reply-To: <20170220185020.774-1-dgilbert@redhat.com>
References: <20170220185020.774-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v4 5/5] slirp: VMStatify remaining except for
 loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com
Cc: quintela@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This converts the remaining components, except for the top level
loop, to VMState.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 slirp/slirp.c | 48 +++++++++++++++++++-----------------------------
 1 file changed, 19 insertions(+), 29 deletions(-)

diff --git a/slirp/slirp.c b/slirp/slirp.c
index 6583de8..f8ee7f9 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -1343,15 +1343,25 @@ static const VMStateDescription vmstate_slirp_socket = {
     }
 };
 
-static void slirp_bootp_save(QEMUFile *f, Slirp *slirp)
-{
-    int i;
+static const VMStateDescription vmstate_slirp_bootp_client = {
+    .name = "slirp_bootpclient",
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT16(allocated, BOOTPClient),
+        VMSTATE_BUFFER(macaddr, BOOTPClient),
+        VMSTATE_END_OF_LIST()
+    }
+};
 
-    for (i = 0; i < NB_BOOTP_CLIENTS; i++) {
-        qemu_put_be16(f, slirp->bootp_clients[i].allocated);
-        qemu_put_buffer(f, slirp->bootp_clients[i].macaddr, 6);
+static const VMStateDescription vmstate_slirp = {
+    .name = "slirp",
+    .version_id = 4,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT16_V(ip_id, Slirp, 2),
+        VMSTATE_STRUCT_ARRAY(bootp_clients, Slirp, NB_BOOTP_CLIENTS, 3,
+                             vmstate_slirp_bootp_client, BOOTPClient),
+        VMSTATE_END_OF_LIST()
     }
-}
+};
 
 static void slirp_state_save(QEMUFile *f, void *opaque)
 {
@@ -1371,22 +1381,10 @@ static void slirp_state_save(QEMUFile *f, void *opaque)
         }
     qemu_put_byte(f, 0);
 
-    qemu_put_be16(f, slirp->ip_id);
-
-    slirp_bootp_save(f, slirp);
+    vmstate_save_state(f, &vmstate_slirp, slirp, NULL);
 }
 
 
-static void slirp_bootp_load(QEMUFile *f, Slirp *slirp)
-{
-    int i;
-
-    for (i = 0; i < NB_BOOTP_CLIENTS; i++) {
-        slirp->bootp_clients[i].allocated = qemu_get_be16(f);
-        qemu_get_buffer(f, slirp->bootp_clients[i].macaddr, 6);
-    }
-}
-
 static int slirp_state_load(QEMUFile *f, void *opaque, int version_id)
 {
     Slirp *slirp = opaque;
@@ -1421,13 +1419,5 @@ static int slirp_state_load(QEMUFile *f, void *opaque, int version_id)
         so->extra = (void *)ex_ptr->ex_exec;
     }
 
-    if (version_id >= 2) {
-        slirp->ip_id = qemu_get_be16(f);
-    }
-
-    if (version_id >= 3) {
-        slirp_bootp_load(f, slirp);
-    }
-
-    return 0;
+    return vmstate_load_state(f, &vmstate_slirp, slirp, version_id);
 }
-- 
2.9.3
