Received: from eggs.gnu.org ([2001:4830:134:3::10]:53360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lyan@suse.com>) id 1dkXHh-0000oO-2A
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:09:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lyan@suse.com>) id 1dkXHb-000347-Sk
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:09:33 -0400
From: Liang Yan <lyan@suse.com>
Date: Wed, 23 Aug 2017 11:09:03 -0400
Message-Id: <20170823150903.19982-1-lyan@suse.com>
Subject: [Qemu-devel] [PATCH] hw/display/xenfb.c: Add trace_xenfb_key_event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sstabellini@kernel.org, anthony.perard@citrix.com
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org

It may be better to add a trace event to monitor the last moment of
a key event from QEMU to guest VM

Signed-off-by: Liang Yan <lyan@suse.com>
---
 hw/display/trace-events | 1 +
 hw/display/xenfb.c      | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/hw/display/trace-events b/hw/display/trace-events
index ed8cca0755..da498c1def 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -6,6 +6,7 @@ jazz_led_write(uint64_t addr, uint8_t new) "write addr=0x%"PRIx64": 0x%x"
 
 # hw/display/xenfb.c
 xenfb_mouse_event(void *opaque, int dx, int dy, int dz, int button_state, int abs_pointer_wanted) "%p x %d y %d z %d bs 0x%x abs %d"
+xenfb_key_event(void *opaque, int scancode, int button_state) "%p scancode %d bs 0x%x"
 xenfb_input_connected(void *xendev, int abs_pointer_wanted) "%p abs %d"
 
 # hw/display/g364fb.c
diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index df8b78f6f4..afc43f33a2 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -290,6 +290,8 @@ static void xenfb_key_event(void *opaque, int scancode)
 	scancode |= 0x80;
 	xenfb->extended = 0;
     }
+
+    trace_xenfb_key_event(opaque, scancode2linux[scancode], down);
     xenfb_send_key(xenfb, down, scancode2linux[scancode]);
 }
 
-- 
2.14.1
