Received: from eggs.gnu.org ([2001:4830:134:3::10]:39287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d4VXM-0006vO-2b
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 12:48:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d4VXL-0001OM-9B
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 12:48:00 -0400
Received: from hera.aquilenet.fr ([141.255.128.1]:54677)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d4VXL-0001O1-2n
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 12:47:59 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sat, 29 Apr 2017 18:47:50 +0200
Message-Id: <20170429164750.17414-10-samuel.thibault@ens-lyon.org>
In-Reply-To: <20170429164750.17414-1-samuel.thibault@ens-lyon.org>
References: <20170429164750.17414-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PULL 9/9] slirp: VMStatify remaining except for loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This converts the remaining components, except for the top level
loop, to VMState.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/slirp.c | 48 +++++++++++++++++++-----------------------------
 1 file changed, 19 insertions(+), 29 deletions(-)

diff --git a/slirp/slirp.c b/slirp/slirp.c
index c3426648e5..2f2ec2c1b3 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -1402,15 +1402,25 @@ static const VMStateDescription vmstate_slirp_socket = {
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
@@ -1430,22 +1440,10 @@ static void slirp_state_save(QEMUFile *f, void *opaque)
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
@@ -1480,13 +1478,5 @@ static int slirp_state_load(QEMUFile *f, void *opaque, int version_id)
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
2.11.0
