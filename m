Received: from eggs.gnu.org ([2001:4830:134:3::10]:34639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=473f30fe0=owen.smith@citrix.com>)
	id 1eAaaX-0005sF-Uz
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=473f30fe0=owen.smith@citrix.com>)
	id 1eAaaT-0003Wv-La
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:56:42 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:36064)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=473f30fe0=owen.smith@citrix.com>)
	id 1eAaaT-0003VK-GB
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:56:37 -0400
From: Owen Smith <owen.smith@citrix.com>
Date: Fri, 3 Nov 2017 11:56:31 +0000
Message-ID: <20171103115631.15175-5-owen.smith@citrix.com>
In-Reply-To: <20171103115631.15175-1-owen.smith@citrix.com>
References: <20171103115631.15175-1-owen.smith@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 4/4] xenfb: activate input handlers for raw
 pointer devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sstabellini@kernel.org, anthony.perard@citrix.com, kraxel@redhat.com
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, owen.smith@citrix.com

If the frontend requests raw pointers, the input handlers must be
activated to have the input events delivered to the xenfb backend.
Without activation, the input events are delivered to handlers
registered earlier, which would be the emulated USB tablet or
emulated PS/2 mouse.
HVM xen_kbdfront can incorrectly scale absolute coordinates when
the display resolution is not 800x600.

Signed-off-by: Owen Smith <owen.smith@citrix.com>
---
 hw/display/xenfb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index 3cbc248c34..c070c84f5b 100644
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
2.11.0
