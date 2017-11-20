Received: from eggs.gnu.org ([2001:4830:134:3::10]:50712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eGgHr-0000AE-Sy
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 02:14:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eGgHo-0004D6-MA
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 02:14:35 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 20 Nov 2017 18:14:23 +1100
Message-Id: <20171120071423.11693-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH] spapr: Implement bug in spapr-vty device to be
 compatible with PowerVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lvivier@redhat.com, paulus@samba.org, groug@kaod.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The spapr-vty device implements the PAPR defined virtual console,
which is also implemented by IBM's proprietary PowerVM hypervisor.

PowerVM's implementation has a bug where it inserts an extra \0 after
every \r going to the guest.  Because of that Linux's guest side
driver has a workaround which strips \0 characters that appear
immediately after a \r.

That means that when running under qemu, sending a binary stream from
host to guest via spapr-vty which happens to include a \r\0 sequence
will get corrupted by that workaround.

To deal with that, this patch duplicates PowerVM's bug, inserting an
extra \0 after each \r.  Ugly, but the best option available.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/char/spapr_vty.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
index 0fa416ca6b..a95e5e91a7 100644
--- a/hw/char/spapr_vty.c
+++ b/hw/char/spapr_vty.c
@@ -58,6 +58,24 @@ static int vty_getchars(VIOsPAPRDevice *sdev, uint8_t *buf, int max)
 
     while ((n < max) && (dev->out != dev->in)) {
         buf[n++] = dev->buf[dev->out++ % VTERM_BUFSIZE];
+
+        /* PowerVM's vty implementation has a bug where it inserts a
+         * \0 after every \r going to the guest.  Existing guests have
+         * a workaround for this which removes every \0 immediately
+         * following a \r, so here we make ourselves bug-for-bug
+         * compatible, so that the guest won't drop a real \0-after-\r
+         * that happens to occur in a binary stream. */
+        if (buf[n-1] == '\r') {
+            if (n < max) {
+                buf[n++] = '\0';
+            } else {
+                /* No room for the extra \0, roll back and try again
+                 * next time */
+                dev->out--;
+                n--;
+                break;
+            }
+        }
     }
 
     qemu_chr_fe_accept_input(&dev->chardev);
-- 
2.14.3
