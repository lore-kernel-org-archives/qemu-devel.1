Received: from eggs.gnu.org ([2001:4830:134:3::10]:54029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geert@linux-m68k.org>) id 1ekBDa-0007M0-5U
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:08:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geert@linux-m68k.org>) id 1ekBDY-0001G6-Gt
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:08:06 -0500
Received: from leibniz.telenet-ops.be ([195.130.137.77]:55134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <geert@linux-m68k.org>)
	id 1ekBDY-0001Ez-1r
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:08:04 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be
	[IPv6:2a02:1800:110:4::f00:18])
	by leibniz.telenet-ops.be (Postfix) with ESMTPS id 3zdJvz2vw1zMqc1B
	for <qemu-devel@nongnu.org>; Fri,  9 Feb 2018 16:32:15 +0100 (CET)
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri,  9 Feb 2018 16:16:48 +0100
Message-Id: <1518189413-2761-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1518189413-2761-1-git-send-email-geert+renesas@glider.be>
References: <1518189413-2761-1-git-send-email-geert+renesas@glider.be>
Subject: [Qemu-devel] [PATCH/RFC 1/6] vfio: platform: Allow runtime override
 of reset_required
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Baptiste Reynal <b.reynal@virtualopensystems.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Alexander Graf <agraf@suse.de>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, kvm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, qemu-devel@nongnu.org, Geert Uytterhoeven <geert+renesas@glider.be>

Currently reset_required can be configured using a module parameter.
But it cannot be overridden at runtime through sysfs, as the parameter
is read-only.

Make it writeable for root, as this is useful if vfio-platform is
builtin, so the following works:

    echo 0 > /sys/module/vfio_platform/parameters/reset_required

Not-Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
TODO: Implement a vfio reset driver instead.
---
 drivers/vfio/platform/vfio_platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/platform/vfio_platform.c b/drivers/vfio/platform/vfio_platform.c
index 6561751a1063ee29..ef89146deddcea80 100644
--- a/drivers/vfio/platform/vfio_platform.c
+++ b/drivers/vfio/platform/vfio_platform.c
@@ -24,7 +24,7 @@
 #define DRIVER_DESC     "VFIO for platform devices - User Level meta-driver"
 
 static bool reset_required = true;
-module_param(reset_required, bool, 0444);
+module_param(reset_required, bool, 0644);
 MODULE_PARM_DESC(reset_required, "override reset requirement (default: 1)");
 
 /* probing devices from the linux platform bus */
-- 
2.7.4
