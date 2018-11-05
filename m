Received: from eggs.gnu.org ([2001:4830:134:3::10]:35438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gJcZD-00070U-1w
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 05:57:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gJcUj-0002aO-6Y
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 05:52:37 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Mon,  5 Nov 2018 11:51:48 +0100
Message-Id: <20181105105148.15833-1-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/arm/sysbus-fdt: Only call match_fn callback
 if the type matches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, geert+renesas@glider.be, alex.williamson@redhat.com, thuth@redhat.com

Commit af7d64ede0b9 (hw/arm/sysbus-fdt: Allow device matching with DT
compatible value) introduced a match_fn callback which gets called
for each registered combo to check whether a sysbus device can be
dynamically instantiated. However the callback gets called even if
the device type does not match the binding combo typename field.

Let's change the add_fdt_node() logic so that we first check the
type and if the match_fn callback is defined, then we also call it.

Binding combos only requesting a type check do not define the
match_fn callback.

Fixes: af7d64ede0b9 (hw/arm/sysbus-fdt: Allow device matching with
DT compatible value)

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reported-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/sysbus-fdt.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
index 0e24c803a1..a44cf7f255 100644
--- a/hw/arm/sysbus-fdt.c
+++ b/hw/arm/sysbus-fdt.c
@@ -449,7 +449,7 @@ static bool type_match(SysBusDevice *sbdev, const BindingEntry *entry)
     return !strcmp(object_get_typename(OBJECT(sbdev)), entry->typename);
 }
 
-#define TYPE_BINDING(type, add_fn) {(type), NULL, (add_fn), type_match}
+#define TYPE_BINDING(type, add_fn) {(type), NULL, (add_fn), NULL}
 
 /* list of supported dynamic sysbus bindings */
 static const BindingEntry bindings[] = {
@@ -481,10 +481,18 @@ static void add_fdt_node(SysBusDevice *sbdev, void *opaque)
     for (i = 0; i < ARRAY_SIZE(bindings); i++) {
         const BindingEntry *iter = &bindings[i];
 
-        if (iter->match_fn(sbdev, iter)) {
-            ret = iter->add_fn(sbdev, opaque);
-            assert(!ret);
-            return;
+        if (type_match(sbdev, iter)) {
+            if (iter->match_fn) {
+                if (iter->match_fn(sbdev, iter)) {
+                    ret = iter->add_fn(sbdev, opaque);
+                    assert(!ret);
+                    return;
+                }
+            } else {
+                ret = iter->add_fn(sbdev, opaque);
+                assert(!ret);
+                return;
+            }
         }
     }
     error_report("Device %s can not be dynamically instantiated",
-- 
2.17.2
