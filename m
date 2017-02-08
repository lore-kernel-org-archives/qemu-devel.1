Received: from eggs.gnu.org ([2001:4830:134:3::10]:51659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cbWVH-0001rW-2Z
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 12:58:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cbWVE-00048t-12
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 12:58:03 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed,  8 Feb 2017 18:57:38 +0100
Message-Id: <1486576658-29719-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v3] hw/core/register: Mark the device with
 cannot_instantiate_with_device_add_yet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>

The "qemu,register" device needs to be wired up in source code, there
is no way the user can make any real use of this device with the
"-device" parameter or the "device_add" monitor command yet.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v3: Another update to the patch description and comment

 hw/core/register.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/core/register.c b/hw/core/register.c
index 4bfbc50..be170dc 100644
--- a/hw/core/register.c
+++ b/hw/core/register.c
@@ -274,9 +274,18 @@ void register_finalize_block(RegisterInfoArray *r_array)
     g_free(r_array);
 }
 
+static void register_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    /* Reason: needs to be wired up to work */
+    dc->cannot_instantiate_with_device_add_yet = true;
+}
+
 static const TypeInfo register_info = {
     .name  = TYPE_REGISTER,
     .parent = TYPE_DEVICE,
+    .class_init = register_class_init,
 };
 
 static void register_register_types(void)
-- 
1.8.3.1
