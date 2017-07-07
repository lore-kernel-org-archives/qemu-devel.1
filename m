Received: from eggs.gnu.org ([2001:4830:134:3::10]:54488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dTUTU-0005tC-Pr
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:43:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dTUTU-00044s-1w
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:43:16 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dTUTT-00040L-RF
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:43:15 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  7 Jul 2017 15:42:52 +0100
Message-Id: <1499438577-7674-7-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1499438577-7674-1-git-send-email-peter.maydell@linaro.org>
References: <1499438577-7674-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 06/11]
 scripts/coccinelle/memory-region-init-ram.cocci: New script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Add a coccinelle script that can be used to automatically convert
manual sequences of
 memory_region_init_ram_nomigrate()
 vmstate_register_ram{,_global}()
to use the new
 memory_region_init_ram()

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/coccinelle/memory-region-init-ram.cocci | 38 +++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 scripts/coccinelle/memory-region-init-ram.cocci

diff --git a/scripts/coccinelle/memory-region-init-ram.cocci b/scripts/coccinelle/memory-region-init-ram.cocci
new file mode 100644
index 0000000..d290150
--- /dev/null
+++ b/scripts/coccinelle/memory-region-init-ram.cocci
@@ -0,0 +1,38 @@
+// Replace by-hand memory_region_init_ram_nomigrate/vmstate_register_ram
+// code sequences with use of the new memory_region_init_ram function.
+// Similarly for the _rom and _rom_device functions.
+// We don't try to replace sequences with a non-NULL owner, because
+// there are none in the tree that can be automatically converted
+// (and only a handful that can be manually converted).
+@@
+expression MR;
+expression NAME;
+expression SIZE;
+expression ERRP;
+@@
+-memory_region_init_ram_nomigrate(MR, NULL, NAME, SIZE, ERRP);
++memory_region_init_ram(MR, NULL, NAME, SIZE, ERRP);
+ ...
+-vmstate_register_ram_global(MR);
+@@
+expression MR;
+expression NAME;
+expression SIZE;
+expression ERRP;
+@@
+-memory_region_init_rom_nomigrate(MR, NULL, NAME, SIZE, ERRP);
++memory_region_init_rom(MR, NULL, NAME, SIZE, ERRP);
+ ...
+-vmstate_register_ram_global(MR);
+@@
+expression MR;
+expression OPS;
+expression OPAQUE;
+expression NAME;
+expression SIZE;
+expression ERRP;
+@@
+-memory_region_init_rom_device_nomigrate(MR, NULL, OPS, OPAQUE, NAME, SIZE, ERRP);
++memory_region_init_rom_device(MR, NULL, OPS, OPAQUE, NAME, SIZE, ERRP);
+ ...
+-vmstate_register_ram_global(MR);
-- 
2.7.4
