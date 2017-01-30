Received: from eggs.gnu.org ([2001:4830:134:3::10]:48073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cYAyG-0007IG-Tk
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:22:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cYAyC-0002eE-1V
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:22:08 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 30 Jan 2017 13:22:01 +0100
Message-Id: <1485778921-20869-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2] hw/core/register: Mark the device with
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
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

The "qemu,register" device needs to be wired up in source code, there
is no way the user can add this device with the "-device" parameter or
the "device_add" monitor command yet.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Changed patch description and comment

 hw/core/register.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/core/register.c b/hw/core/register.c
index 4bfbc50..1416691 100644
--- a/hw/core/register.c
+++ b/hw/core/register.c
@@ -274,9 +274,18 @@ void register_finalize_block(RegisterInfoArray *r_array)
     g_free(r_array);
 }
 
+static void register_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    /* Needs to be wired up in source code, see register_init_block32() */
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
