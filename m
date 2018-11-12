Received: from eggs.gnu.org ([2001:4830:134:3::10]:60722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gMFi8-0004KL-5s
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:09:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gMFi7-0000sQ-AF
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:09:16 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52546)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gMFi7-0008MG-1G
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:09:15 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gMFhI-0005rX-2z
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 17:08:24 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Nov 2018 17:08:04 +0000
Message-Id: <20181112170816.500-5-peter.maydell@linaro.org>
In-Reply-To: <20181112170816.500-1-peter.maydell@linaro.org>
References: <20181112170816.500-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/16] hw/arm/sysbus-fdt: Only call match_fn
 callback if the type matches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Auger <eric.auger@redhat.com>

Commit af7d64ede0b9 (hw/arm/sysbus-fdt: Allow device matching with DT
compatible value) introduced a match_fn callback which gets called
for each registered combo to check whether a sysbus device can be
dynamically instantiated. However the callback gets called even if
the device type does not match the binding combo typename field.
This causes an assert when passing "-device ramfb" to the qemu
command line as vfio_platform_match() gets called on a non
vfio-platform device.

To fix this regression, let's change the add_fdt_node() logic so
that we first check the type and if the match_fn callback is defined,
then we also call it.

Binding combos only requesting a type check do not define the
match_fn callback.

Fixes: af7d64ede0b9 (hw/arm/sysbus-fdt: Allow device matching with
DT compatible value)

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reported-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Message-id: 20181106184212.29377-1-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/sysbus-fdt.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
index 0e24c803a1c..ad698d4832c 100644
--- a/hw/arm/sysbus-fdt.c
+++ b/hw/arm/sysbus-fdt.c
@@ -449,7 +449,7 @@ static bool type_match(SysBusDevice *sbdev, const BindingEntry *entry)
     return !strcmp(object_get_typename(OBJECT(sbdev)), entry->typename);
 }
 
-#define TYPE_BINDING(type, add_fn) {(type), NULL, (add_fn), type_match}
+#define TYPE_BINDING(type, add_fn) {(type), NULL, (add_fn), NULL}
 
 /* list of supported dynamic sysbus bindings */
 static const BindingEntry bindings[] = {
@@ -481,10 +481,12 @@ static void add_fdt_node(SysBusDevice *sbdev, void *opaque)
     for (i = 0; i < ARRAY_SIZE(bindings); i++) {
         const BindingEntry *iter = &bindings[i];
 
-        if (iter->match_fn(sbdev, iter)) {
-            ret = iter->add_fn(sbdev, opaque);
-            assert(!ret);
-            return;
+        if (type_match(sbdev, iter)) {
+            if (!iter->match_fn || iter->match_fn(sbdev, iter)) {
+                ret = iter->add_fn(sbdev, opaque);
+                assert(!ret);
+                return;
+            }
         }
     }
     error_report("Device %s can not be dynamically instantiated",
-- 
2.19.1
