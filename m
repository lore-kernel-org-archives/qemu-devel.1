Received: from eggs.gnu.org ([2001:4830:134:3::10]:43769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eOORS-0004ff-KW
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:48:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eOORR-0007f1-RN
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:48:22 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 11 Dec 2017 14:47:35 +0100
Message-Id: <20171211134740.8235-11-david@redhat.com>
In-Reply-To: <20171211134740.8235-1-david@redhat.com>
References: <20171211134740.8235-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 for-2-12 10/15] s390x/flic: implement
 qemu_s390_clear_io_flic()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

Now that we have access to the io interrupts, we can implement
clear_io_irq() for TCG.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/intc/s390_flic.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index 3a28bee90c..fe6ad02f29 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -83,8 +83,35 @@ static void qemu_s390_release_adapter_routes(S390FLICState *fs,
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
2.14.3
