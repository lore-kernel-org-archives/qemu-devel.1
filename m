Received: from eggs.gnu.org ([2001:4830:134:3::10]:47615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dkiQP-0002OP-TU
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 23:03:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dkiQP-0000vh-35
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 23:03:17 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 24 Aug 2017 05:03:03 +0200
Message-Id: <1503543783-17192-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11] hw/ide/microdrive: Mark the dscm1xxxx
 device with user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Andrzej Zaborowski <balrogg@gmail.com>

QEMU currently aborts with an assertion message when the user is trying
to remove a dscm1xxxx again:

$ aarch64-softmmu/qemu-system-aarch64 -S -M integratorcp -nographic
QEMU 2.9.93 monitor - type 'help' for more information
(qemu) device_add dscm1xxxx,id=xyz
(qemu) device_del xyz
**
ERROR:qemu/qdev-monitor.c:872:qdev_unplug: assertion failed: (hotplug_ctrl)
Aborted (core dumped)

Looks like this device has to be wired up in code and is not meant
to be hot-pluggable, so let's mark it with user_creatable = false.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/ide/microdrive.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/ide/microdrive.c b/hw/ide/microdrive.c
index e3fd30e..17917c0 100644
--- a/hw/ide/microdrive.c
+++ b/hw/ide/microdrive.c
@@ -575,12 +575,15 @@ PCMCIACardState *dscm1xxxx_init(DriveInfo *dinfo)
 static void dscm1xxxx_class_init(ObjectClass *oc, void *data)
 {
     PCMCIACardClass *pcc = PCMCIA_CARD_CLASS(oc);
+    DeviceClass *dc = DEVICE_CLASS(oc);
 
     pcc->cis = dscm1xxxx_cis;
     pcc->cis_len = sizeof(dscm1xxxx_cis);
 
     pcc->attach = dscm1xxxx_attach;
     pcc->detach = dscm1xxxx_detach;
+    /* Reason: Needs to be wired-up in code, see dscm1xxxx_init() */
+    dc->user_creatable = false;
 }
 
 static const TypeInfo dscm1xxxx_type_info = {
-- 
1.8.3.1
