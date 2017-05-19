Received: from eggs.gnu.org ([2001:4830:134:3::10]:51245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dBg1B-00077T-D1
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dBg18-00024a-VE
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:24:25 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 19 May 2017 13:24:13 +0200
Message-Id: <20170519112415.19191-2-kraxel@redhat.com>
In-Reply-To: <20170519112415.19191-1-kraxel@redhat.com>
References: <20170519112415.19191-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/3] audio: Move arch_init audio code to
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, "open list:PReP" <qemu-ppc@nongnu.org>

From: Eduardo Habkost <ehabkost@redhat.com>

There's no reason to keep the soundhw table in arch_init.c. Move
that code to a new hw/audio/soundhw.c file.

While moving the code, trivial coding style issues were fixed.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20170508205735.23444-2-ehabkost@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/audio/audio.h   |   3 +
 include/sysemu/arch_init.h |   2 -
 arch_init.c                | 124 -----------------------------------
 hw/audio/soundhw.c         | 156 +++++++++++++++++++++++++++++++++++++++=
++++++
 hw/ppc/prep.c              |   1 +
 vl.c                       |   1 +
 hw/audio/Makefile.objs     |   2 +
 7 files changed, 163 insertions(+), 126 deletions(-)
 create mode 100644 hw/audio/soundhw.c

diff --git a/include/hw/audio/audio.h b/include/hw/audio/audio.h
index 55d40f71bf..259bb2cf96 100644
--- a/include/hw/audio/audio.h
+++ b/include/hw/audio/audio.h
@@ -7,4 +7,7 @@ void isa_register_soundhw(const char *name, const char *d=
escr,
 void pci_register_soundhw(const char *name, const char *descr,
                           int (*init_pci)(PCIBus *bus));
=20
+void audio_init(void);
+void select_soundhw(const char *optarg);
+
 #endif
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 2bf16b203c..8751c468ed 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -28,8 +28,6 @@ enum {
=20
 extern const uint32_t arch_type;
=20
-void select_soundhw(const char *optarg);
-void audio_init(void);
 int kvm_available(void);
 int xen_available(void);
=20
diff --git a/arch_init.c b/arch_init.c
index 0810116144..74ca62f508 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -85,130 +85,6 @@ int graphic_depth =3D 32;
=20
 const uint32_t arch_type =3D QEMU_ARCH;
=20
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
-    soundhw[soundhw_count].name =3D name;
-    soundhw[soundhw_count].descr =3D descr;
-    soundhw[soundhw_count].isa =3D 1;
-    soundhw[soundhw_count].init.init_isa =3D init_isa;
-    soundhw_count++;
-}
-
-void pci_register_soundhw(const char *name, const char *descr,
-                          int (*init_pci)(PCIBus *bus))
-{
-    assert(soundhw_count < ARRAY_SIZE(soundhw) - 1);
-    soundhw[soundhw_count].name =3D name;
-    soundhw[soundhw_count].descr =3D descr;
-    soundhw[soundhw_count].isa =3D 0;
-    soundhw[soundhw_count].init.init_pci =3D init_pci;
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
-             for (c =3D soundhw; c->name; ++c) {
-                 printf ("%-11s %s\n", c->name, c->descr);
-             }
-             printf("\n-soundhw all will enable all of the above\n");
-        } else {
-             printf("Machine has no user-selectable audio hardware "
-                    "(it may or may not have always-present audio hardwa=
re).\n");
-        }
-        exit(!is_help_option(optarg));
-    }
-    else {
-        size_t l;
-        const char *p;
-        char *e;
-        int bad_card =3D 0;
-
-        if (!strcmp(optarg, "all")) {
-            for (c =3D soundhw; c->name; ++c) {
-                c->enabled =3D 1;
-            }
-            return;
-        }
-
-        p =3D optarg;
-        while (*p) {
-            e =3D strchr(p, ',');
-            l =3D !e ? strlen(p) : (size_t) (e - p);
-
-            for (c =3D soundhw; c->name; ++c) {
-                if (!strncmp(c->name, p, l) && !c->name[l]) {
-                    c->enabled =3D 1;
-                    break;
-                }
-            }
-
-            if (!c->name) {
-                if (l > 80) {
-                    error_report("Unknown sound card name (too big to sh=
ow)");
-                }
-                else {
-                    error_report("Unknown sound card name `%.*s'",
-                                 (int) l, p);
-                }
-                bad_card =3D 1;
-            }
-            p +=3D l + (e !=3D NULL);
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
-    ISABus *isa_bus =3D (ISABus *) object_resolve_path_type("", TYPE_ISA=
_BUS, NULL);
-    PCIBus *pci_bus =3D (PCIBus *) object_resolve_path_type("", TYPE_PCI=
_BUS, NULL);
-
-    for (c =3D soundhw; c->name; ++c) {
-        if (c->enabled) {
-            if (c->isa) {
-                if (!isa_bus) {
-                    error_report("ISA bus not available for %s", c->name=
);
-                    exit(1);
-                }
-                c->init.init_isa(isa_bus);
-            } else {
-                if (!pci_bus) {
-                    error_report("PCI bus not available for %s", c->name=
);
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
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
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
+    soundhw[soundhw_count].name =3D name;
+    soundhw[soundhw_count].descr =3D descr;
+    soundhw[soundhw_count].isa =3D 1;
+    soundhw[soundhw_count].init.init_isa =3D init_isa;
+    soundhw_count++;
+}
+
+void pci_register_soundhw(const char *name, const char *descr,
+                          int (*init_pci)(PCIBus *bus))
+{
+    assert(soundhw_count < ARRAY_SIZE(soundhw) - 1);
+    soundhw[soundhw_count].name =3D name;
+    soundhw[soundhw_count].descr =3D descr;
+    soundhw[soundhw_count].isa =3D 0;
+    soundhw[soundhw_count].init.init_pci =3D init_pci;
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
+             for (c =3D soundhw; c->name; ++c) {
+                 printf ("%-11s %s\n", c->name, c->descr);
+             }
+             printf("\n-soundhw all will enable all of the above\n");
+        } else {
+             printf("Machine has no user-selectable audio hardware "
+                    "(it may or may not have always-present audio hardwa=
re).\n");
+        }
+        exit(!is_help_option(optarg));
+    }
+    else {
+        size_t l;
+        const char *p;
+        char *e;
+        int bad_card =3D 0;
+
+        if (!strcmp(optarg, "all")) {
+            for (c =3D soundhw; c->name; ++c) {
+                c->enabled =3D 1;
+            }
+            return;
+        }
+
+        p =3D optarg;
+        while (*p) {
+            e =3D strchr(p, ',');
+            l =3D !e ? strlen(p) : (size_t) (e - p);
+
+            for (c =3D soundhw; c->name; ++c) {
+                if (!strncmp(c->name, p, l) && !c->name[l]) {
+                    c->enabled =3D 1;
+                    break;
+                }
+            }
+
+            if (!c->name) {
+                if (l > 80) {
+                    error_report("Unknown sound card name (too big to sh=
ow)");
+                }
+                else {
+                    error_report("Unknown sound card name `%.*s'",
+                                 (int) l, p);
+                }
+                bad_card =3D 1;
+            }
+            p +=3D l + (e !=3D NULL);
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
+    ISABus *isa_bus =3D (ISABus *) object_resolve_path_type("", TYPE_ISA=
_BUS, NULL);
+    PCIBus *pci_bus =3D (PCIBus *) object_resolve_path_type("", TYPE_PCI=
_BUS, NULL);
+
+    for (c =3D soundhw; c->name; ++c) {
+        if (c->enabled) {
+            if (c->isa) {
+                if (!isa_bus) {
+                    error_report("ISA bus not available for %s", c->name=
);
+                    exit(1);
+                }
+                c->init.init_isa(isa_bus);
+            } else {
+                if (!pci_bus) {
+                    error_report("PCI bus not available for %s", c->name=
);
+                    exit(1);
+                }
+                c->init.init_pci(pci_bus);
+            }
+        }
+    }
+}
+
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 961230c569..96a4813b3f 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -36,6 +36,7 @@
 #include "hw/pci/pci_host.h"
 #include "hw/ppc/ppc.h"
 #include "hw/boards.h"
+#include "hw/audio/audio.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "hw/ide.h"
diff --git a/vl.c b/vl.c
index 1512df6e9e..6e46889cde 100644
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
@@ -14,3 +14,5 @@ common-obj-$(CONFIG_PL041) +=3D pl041.o lm4549.o
 common-obj-$(CONFIG_CS4231) +=3D cs4231.o
 common-obj-$(CONFIG_MARVELL_88W8618) +=3D marvell_88w8618.o
 common-obj-$(CONFIG_MILKYMIST) +=3D milkymist-ac97.o
+
+common-obj-y +=3D soundhw.o
--=20
2.9.3
