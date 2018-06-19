Received: from eggs.gnu.org ([2001:4830:134:3::10]:47007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5ja-00034Q-0Z
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:47:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5jY-0000qB-CC
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:47:02 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:42:43 -0500
Message-Id: <20180619014319.28272-78-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 077/113] s390x/css: disabled subchannels cannot
 be status pending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: Cornelia Huck <cohuck@redhat.com>

The 3270 code will try to post an attention interrupt when the
3270 emulator (e.g. x3270) attaches. If the guest has not yet
enabled the subchannel for the 3270 device, we will present a spurious
cc 1 (status pending) when it uses msch on it later on, e.g. when
trying to enable the subchannel.

To fix this, just don't do anything in css_conditional_io_interrupt()
if the subchannel is not enabled. The 3270 code will work fine with
that, and the other user of this function (virtio-ccw) never
attempts to post an interrupt for a disabled device to begin with.

CC: qemu-stable@nongnu.org
Reported-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
(cherry picked from commit 6e9c893ecd00afd5344c35d0d0ded50eaa0938f6)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/s390x/css.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index f6b5c807cd..f530080243 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -618,6 +618,14 @@ void css_inject_io_interrupt(SubchDev *sch)
 void css_conditional_io_interrupt(SubchDev *sch)
 {
     /*
+     * If the subchannel is not enabled, it is not made status pending
+     * (see PoP p. 16-17, "Status Control").
+     */
+    if (!(sch->curr_status.pmcw.flags & PMCW_FLAGS_MASK_ENA)) {
+        return;
+    }
+
+    /*
      * If the subchannel is not currently status pending, make it pending
      * with alert status.
      */
-- 
2.11.0
