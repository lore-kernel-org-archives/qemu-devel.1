Received: from eggs.gnu.org ([2001:4830:134:3::10]:43469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4wN-00021J-0o
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:25:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4wM-00064H-4n
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:25:55 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  9 Feb 2018 10:25:06 +0100
Message-Id: <20180209092524.31348-12-cohuck@redhat.com>
In-Reply-To: <20180209092524.31348-1-cohuck@redhat.com>
References: <20180209092524.31348-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 11/29] s390x/flic: implement
 qemu_s390_clear_io_flic()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Now that we have access to the io interrupts, we can implement
clear_io_irq() for TCG.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180129125623.21729-11-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/intc/s390_flic.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index 928bdc3037..cb216de9ba 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -79,8 +79,35 @@ static void qemu_s390_release_adapter_routes(S390FLICState *fs,
 static int qemu_s390_clear_io_flic(S390FLICState *fs, uint16_t subchannel_id,
                            uint16_t subchannel_nr)
 {
-    /* Fixme TCG */
-    return -ENOSYS;
+    QEMUS390FLICState *flic  = QEMU_S390_FLIC(fs);
+    QEMUS390FlicIO *cur, *next;
+    uint8_t isc;
+
+    g_assert(qemu_mutex_iothread_locked());
+    if (!(flic->pending & FLIC_PENDING_IO)) {
+        return 0;
+    }
+
+    /* check all iscs */
+    for (isc = 0; isc < 8; isc++) {
+        if (QLIST_EMPTY(&flic->io[isc])) {
+            continue;
+        }
+
+        /* search and delete any matching one */
+        QLIST_FOREACH_SAFE(cur, &flic->io[isc], next, next) {
+            if (cur->id == subchannel_id && cur->nr == subchannel_nr) {
+                QLIST_REMOVE(cur, next);
+                g_free(cur);
+            }
+        }
+
+        /* update our indicator bit */
+        if (QLIST_EMPTY(&flic->io[isc])) {
+            flic->pending &= ~ISC_TO_PENDING_IO(isc);
+        }
+    }
+    return 0;
 }
 
 static int qemu_s390_modify_ais_mode(S390FLICState *fs, uint8_t isc,
-- 
2.13.6
