Received: from eggs.gnu.org ([2001:4830:134:3::10]:60388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1crAIF-0003WH-Bv
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 17:29:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1crAIE-0008Ar-Jy
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 17:29:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1crAIE-0008AI-Dh
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 17:29:14 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 23 Mar 2017 18:28:45 -0300
Message-Id: <20170323212848.8492-2-ehabkost@redhat.com>
In-Reply-To: <20170323212848.8492-1-ehabkost@redhat.com>
References: <20170323212848.8492-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 1/4] [UNTESTED] xen: Don't force
 has_dynamic_sysbus on machine class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jgross@suse.com, Thomas Huth <thuth@redhat.com>, sstabellini@kernel.org, Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

The xen-backend devices created by the Xen code are not supposed
to be treated as dynamic sysbus devices. This is an attempt to
change that and see what happens, but I couldn't test it because
I don't have a Xen host set up.

If this patch breaks anything, this means we have a bug in
foreach_dynamic_sysbus_device(), which is supposed to return only
devices created using -device.

The original code that sets has_dynamic_sysbus was added by
commit 3a6c9172ac5951e6dac2b3f6cbce3cfccdec5894, but I don't see
any comment explaining why it was necessary.

Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/xen/xen_backend.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
index 6c21c37d68..4607d6d3ee 100644
--- a/hw/xen/xen_backend.c
+++ b/hw/xen/xen_backend.c
@@ -550,15 +550,6 @@ err:
     return -1;
 }
 
-static void xen_set_dynamic_sysbus(void)
-{
-    Object *machine = qdev_get_machine();
-    ObjectClass *oc = object_get_class(machine);
-    MachineClass *mc = MACHINE_CLASS(oc);
-
-    mc->has_dynamic_sysbus = true;
-}
-
 int xen_be_register(const char *type, struct XenDevOps *ops)
 {
     char path[50];
@@ -580,8 +571,6 @@ int xen_be_register(const char *type, struct XenDevOps *ops)
 
 void xen_be_register_common(void)
 {
-    xen_set_dynamic_sysbus();
-
     xen_be_register("console", &xen_console_ops);
     xen_be_register("vkbd", &xen_kbdmouse_ops);
     xen_be_register("qdisk", &xen_blkdev_ops);
-- 
2.11.0.259.g40922b1
