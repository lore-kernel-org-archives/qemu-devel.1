Received: from eggs.gnu.org ([2001:4830:134:3::10]:42836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1ePdrG-0002q7-Fa
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 19:28:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1ePdrD-00065L-UY
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 19:28:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:60590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1ePdrD-00064G-P0
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 19:28:07 -0500
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Thu, 14 Dec 2017 16:28:02 -0800
Message-Id: <1513297683-14295-5-git-send-email-sstabellini@kernel.org>
In-Reply-To: <1513297683-14295-1-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1712141612170.3857@sstabellini-ThinkPad-X260>
	<1513297683-14295-1-git-send-email-sstabellini@kernel.org>
Subject: [Qemu-devel] [PULL 5/6] xenfb: activate input handlers for raw
 pointer devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@gmail.com
Cc: sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Owen Smith <owen.smith@citrix.com>

From: Owen Smith <owen.smith@citrix.com>

If the frontend requests raw pointers, the input handlers must be
activated to have the input events delivered to the xenfb backend.
Without activation, the input events are delivered to handlers
registered earlier, which would be the emulated USB tablet or
emulated PS/2 mouse.
HVM xen_kbdfront can incorrectly scale absolute coordinates when
the display resolution is not 800x600.

Signed-off-by: Owen Smith <owen.smith@citrix.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/display/xenfb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index 776a2ce..d4fc0fa 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -387,6 +387,11 @@ static void input_connected(struct XenDevice *xendev)
     in->qkbd = qemu_input_handler_register((DeviceState *)in, &xenfb_keyboard);
     in->qmou = qemu_input_handler_register((DeviceState *)in,
                in->abs_pointer_wanted ? &xenfb_abs_mouse : &xenfb_rel_mouse);
+
+    if (in->raw_pointer_wanted) {
+        qemu_input_handler_activate(in->qkbd);
+        qemu_input_handler_activate(in->qmou);
+    }
 }
 
 static void input_disconnect(struct XenDevice *xendev)
-- 
1.9.1
