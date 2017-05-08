Received: from eggs.gnu.org ([2001:4830:134:3::10]:37768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d7p5D-0007WL-3g
	for qemu-devel@nongnu.org; Mon, 08 May 2017 16:16:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d7p5B-0002mq-HB
	for qemu-devel@nongnu.org; Mon, 08 May 2017 16:16:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7871)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d7p5B-0002mi-8o
	for qemu-devel@nongnu.org; Mon, 08 May 2017 16:16:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 298C480474
	for <qemu-devel@nongnu.org>; Mon,  8 May 2017 20:16:36 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  8 May 2017 17:16:26 -0300
Message-Id: <20170508201628.32502-2-ehabkost@redhat.com>
In-Reply-To: <20170508201628.32502-1-ehabkost@redhat.com>
References: <20170508201628.32502-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/3] audio: Move arch_init audio code to
 hw/audio/soundhw.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

There's no reason to keep the soundhw table in arch_init.c. Move
that code to a new hw/audio/soundhw.c file.

While moving the code, trivial coding style issues were fixed.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* Rebase to latest qemu.git master
---
 include/hw/audio/audio.h   |   3 +
 include/sysemu/arch_init.h |   2 -
 arch_init.c                | 124 -----------------------------------
 hw/audio/soundhw.c         | 156 +++++++++++++++++++++++++++++++++++++++++++++
 vl.c                       |   1 +
 hw/audio/Makefile.objs     |   2 +
 6 files changed, 162 insertions(+), 126 deletions(-)
 create mode 100644 hw/audio/soundhw.c

diff --git a/include/hw/audio/audio.h b/include/hw/audio/audio.h
index 55d40f71bf..259bb2cf96 100644
--- a/include/hw/audio/audio.h
+++ b/include/hw/audio/audio.h
@@ -7,4 +7,7 @@ void isa_register_soundhw(const char *name, const char *descr,
 void pci_register_soundhw(const char *name, const char *descr,
                           int (*init_pci)(PCIBus *bus));
 
+void audio_init(void);
+void select_soundhw(const char *optarg);
+
 #endif
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 2bf16b203c..8751c468ed 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -28,8 +28,6 @@ enum {
 
 extern const uint32_t arch_type;
 
-void select_soundhw(const char *optarg);
-void audio_init(void);
 int kvm_available(void);
 int xen_available(void);
 
diff --git a/arch_init.c b/arch_init.c
index 0810116144..74ca62f508 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -85,130 +85,6 @@ int graphic_depth = 32;
 
 const uint32_t arch_type = QEMU_ARCH;
 
-struct soundhw {
-    const char *name;
-    const char *descr;
-    int enabled;
-    int isa;
-    union {
-        int (*init_isa) (ISABus *bus);
-        int (*init_pci) (PCIBus *bus);
-    } init;
-};
-
-static struct soundhw soundhw[9];
-static int soundhw_count;
-
-void isa_register_soundhw(const char *name, const char *descr,
-                          int (*init_isa)(ISABus *bus))
-{
-    assert(soundhw_count < ARRAY_SIZE(soundhw) - 1);
-    soundhw[soundhw_count].name = name;
-    soundhw[soundhw_count].descr = descr;
-    soundhw[soundhw_count].isa = 1;
-    soundhw[soundhw_count].init.init_isa = init_isa;
-    soundhw_count++;
-}
-
-void pci_register_soundhw(const char *name, const char *descr,
-                          int (*init_pci)(PCIBus *bus))
-{
-    assert(soundhw_count < ARRAY_SIZE(soundhw) - 1);
-    soundhw[soundhw_count].name = name;
-    soundhw[soundhw_count].descr = descr;
-    soundhw[soundhw_count].isa = 0;
-    soundhw[soundhw_count].init.init_pci = init_pci;
-    soundhw_count++;
-}
-
-void select_soundhw(const char *optarg)
-{
-    struct soundhw *c;
-
-    if (is_help_option(optarg)) {
-    show_valid_cards:
-
-        if (soundhw_count) {
-             printf("Valid sound card names (comma separated):\n");
-             for (c = soundhw; c->name; ++c) {
-                 printf ("%-11s %s\n", c->name, c->descr);
-             }
-             printf("\n-soundhw all will enable all of the above\n");
-        } else {
-             printf("Machine has no user-selectable audio hardware "
-                    "(it may or may not have always-present audio hardware).\n");
-        }
-        exit(!is_help_option(optarg));
-    }
-    else {
-        size_t l;
-        const char *p;
-        char *e;
-        int bad_card = 0;
-
-        if (!strcmp(optarg, "all")) {
-            for (c = soundhw; c->name; ++c) {
-                c->enabled = 1;
-            }
-            return;
-        }
-
-        p = optarg;
-        while (*p) {
-            e = strchr(p, ',');
-            l = !e ? strlen(p) : (size_t) (e - p);
-
-            for (c = soundhw; c->name; ++c) {
-                if (!strncmp(c->name, p, l) && !c->name[l]) {
-                    c->enabled = 1;
-                    break;
-                }
-            }
-
-            if (!c->name) {
-                if (l > 80) {
-                    error_report("Unknown sound card name (too big to show)");
-                }
-                else {
-                    error_report("Unknown sound card name `%.*s'",
-                                 (int) l, p);
-                }
-                bad_card = 1;
-            }
-            p += l + (e != NULL);
-        }
-
-        if (bad_card) {
-            goto show_valid_cards;
-        }
-    }
-}
-
-void audio_init(void)
-{
-    struct soundhw *c;
-    ISABus *isa_bus = (ISABus *) object_resolve_path_type("", TYPE_ISA_BUS, NULL);
-    PCIBus *pci_bus = (PCIBus *) object_resolve_path_type("", TYPE_PCI_BUS, NULL);
-
-    for (c = soundhw; c->name; ++c) {
-        if (c->enabled) {
-            if (c->isa) {
-                if (!isa_bus) {
-                    error_report("ISA bus not available for %s", c->name);
-                    exit(1);
-                }
-                c->init.init_isa(isa_bus);
-            } else {
-                if (!pci_bus) {
-                    error_report("PCI bus not available for %s", c->name);
-                    exit(1);
-                }
-                c->init.init_pci(pci_bus);
-            }
-        }
-    }
-}
-
 int kvm_available(void)
 {
 #ifdef CONFIG_KVM
diff --git a/hw/audio/soundhw.c b/hw/audio/soundhw.c
new file mode 100644
index 0000000000..5e96b73c81
--- /dev/null
+++ b/hw/audio/soundhw.c
@@ -0,0 +1,156 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/help_option.h"
+#include "qemu/error-report.h"
+#include "qom/object.h"
+#include "hw/isa/isa.h"
+#include "hw/pci/pci.h"
+#include "hw/audio/audio.h"
+
+struct soundhw {
+    const char *name;
+    const char *descr;
+    int enabled;
+    int isa;
+    union {
+        int (*init_isa) (ISABus *bus);
+        int (*init_pci) (PCIBus *bus);
+    } init;
+};
+
+static struct soundhw soundhw[9];
+static int soundhw_count;
+
+void isa_register_soundhw(const char *name, const char *descr,
+                          int (*init_isa)(ISABus *bus))
+{
+    assert(soundhw_count < ARRAY_SIZE(soundhw) - 1);
+    soundhw[soundhw_count].name = name;
+    soundhw[soundhw_count].descr = descr;
+    soundhw[soundhw_count].isa = 1;
+    soundhw[soundhw_count].init.init_isa = init_isa;
+    soundhw_count++;
+}
+
+void pci_register_soundhw(const char *name, const char *descr,
+                          int (*init_pci)(PCIBus *bus))
+{
+    assert(soundhw_count < ARRAY_SIZE(soundhw) - 1);
+    soundhw[soundhw_count].name = name;
+    soundhw[soundhw_count].descr = descr;
+    soundhw[soundhw_count].isa = 0;
+    soundhw[soundhw_count].init.init_pci = init_pci;
+    soundhw_count++;
+}
+
+void select_soundhw(const char *optarg)
+{
+    struct soundhw *c;
+
+    if (is_help_option(optarg)) {
+    show_valid_cards:
+
+        if (soundhw_count) {
+             printf("Valid sound card names (comma separated):\n");
+             for (c = soundhw; c->name; ++c) {
+                 printf ("%-11s %s\n", c->name, c->descr);
+             }
+             printf("\n-soundhw all will enable all of the above\n");
+        } else {
+             printf("Machine has no user-selectable audio hardware "
+                    "(it may or may not have always-present audio hardware).\n");
+        }
+        exit(!is_help_option(optarg));
+    }
+    else {
+        size_t l;
+        const char *p;
+        char *e;
+        int bad_card = 0;
+
+        if (!strcmp(optarg, "all")) {
+            for (c = soundhw; c->name; ++c) {
+                c->enabled = 1;
+            }
+            return;
+        }
+
+        p = optarg;
+        while (*p) {
+            e = strchr(p, ',');
+            l = !e ? strlen(p) : (size_t) (e - p);
+
+            for (c = soundhw; c->name; ++c) {
+                if (!strncmp(c->name, p, l) && !c->name[l]) {
+                    c->enabled = 1;
+                    break;
+                }
+            }
+
+            if (!c->name) {
+                if (l > 80) {
+                    error_report("Unknown sound card name (too big to show)");
+                }
+                else {
+                    error_report("Unknown sound card name `%.*s'",
+                                 (int) l, p);
+                }
+                bad_card = 1;
+            }
+            p += l + (e != NULL);
+        }
+
+        if (bad_card) {
+            goto show_valid_cards;
+        }
+    }
+}
+
+void audio_init(void)
+{
+    struct soundhw *c;
+    ISABus *isa_bus = (ISABus *) object_resolve_path_type("", TYPE_ISA_BUS, NULL);
+    PCIBus *pci_bus = (PCIBus *) object_resolve_path_type("", TYPE_PCI_BUS, NULL);
+
+    for (c = soundhw; c->name; ++c) {
+        if (c->enabled) {
+            if (c->isa) {
+                if (!isa_bus) {
+                    error_report("ISA bus not available for %s", c->name);
+                    exit(1);
+                }
+                c->init.init_isa(isa_bus);
+            } else {
+                if (!pci_bus) {
+                    error_report("PCI bus not available for %s", c->name);
+                    exit(1);
+                }
+                c->init.init_pci(pci_bus);
+            }
+        }
+    }
+}
+
diff --git a/vl.c b/vl.c
index 560288fe0c..a2400e1ab6 100644
--- a/vl.c
+++ b/vl.c
@@ -89,6 +89,7 @@ int main(int argc, char **argv)
 #include "migration/block.h"
 #include "sysemu/tpm.h"
 #include "sysemu/dma.h"
+#include "hw/audio/audio.h"
 #include "audio/audio.h"
 #include "migration/migration.h"
 #include "sysemu/cpus.h"
diff --git a/hw/audio/Makefile.objs b/hw/audio/Makefile.objs
index bb6f07a91e..63db383709 100644
--- a/hw/audio/Makefile.objs
+++ b/hw/audio/Makefile.objs
@@ -14,3 +14,5 @@ common-obj-$(CONFIG_PL041) += pl041.o lm4549.o
 common-obj-$(CONFIG_CS4231) += cs4231.o
 common-obj-$(CONFIG_MARVELL_88W8618) += marvell_88w8618.o
 common-obj-$(CONFIG_MILKYMIST) += milkymist-ac97.o
+
+common-obj-y += soundhw.o
-- 
2.11.0.259.g40922b1
