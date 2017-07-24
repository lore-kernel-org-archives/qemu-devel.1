Received: from eggs.gnu.org ([2001:4830:134:3::10]:38491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dZdvL-0003F5-7d
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:01:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dZdvI-0005pj-UE
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:01:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:8924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dZdvI-0005oj-KX
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:01:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7AE39356DB
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 14:01:23 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 24 Jul 2017 16:01:17 +0200
Message-Id: <20170724140117.27651-4-kraxel@redhat.com>
In-Reply-To: <20170724140117.27651-1-kraxel@redhat.com>
References: <20170724140117.27651-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] Add qemu-keymap tool.
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

qemu-keymap generates qemu reverse keymaps from xkb keymaps,
which can be used with the qemu "-k" command line switch.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure     |  23 ++++++
 Makefile      |   5 ++
 qemu-keymap.c | 243 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 271 insertions(+)
 create mode 100644 qemu-keymap.c

diff --git a/configure b/configure
index c573a777fc..e8e074c5f9 100755
--- a/configure
+++ b/configure
@@ -292,6 +292,7 @@ vde=""
 vnc_sasl=""
 vnc_jpeg=""
 vnc_png=""
+xkbcommon=""
 xen=""
 xen_ctrl_version=""
 xen_pv_domain_build="no"
@@ -2912,6 +2913,21 @@ EOF
 fi
 
 ##########################################
+# xkbcommon probe
+if test "$xkbcommon" != "no" ; then
+  if $pkg_config xkbcommon --exists; then
+    xkbcommon_cflags=$($pkg_config xkbcommon --cflags)
+    xkbcommon_libs=$($pkg_config xkbcommon --libs)
+    xkbcommon=yes
+  else
+    if test "$xkbcommon" = "yes" ; then
+      feature_not_found "xkbcommon" "Install libxkbcommon-devel"
+    fi
+    xkbcommon=no
+  fi
+fi
+
+##########################################
 # fnmatch() probe, used for ACL routines
 fnmatch="no"
 cat > $TMPC << EOF
@@ -5066,6 +5082,9 @@ if test "$softmmu" = yes ; then
     fi
   fi
 fi
+if test "$xkbcommon" = "yes"; then
+  tools="qemu-keymap\$(EXESUF) $tools"
+fi
 
 # Probe for guest agent support/options
 
@@ -5562,6 +5581,10 @@ fi
 if test "$vnc_png" = "yes" ; then
   echo "CONFIG_VNC_PNG=y" >> $config_host_mak
 fi
+if test "$xkbcommon" = "yes" ; then
+  echo "XKBCOMMON_CFLAGS=$xkbcommon_cflags" >> $config_host_mak
+  echo "XKBCOMMON_LIBS=$xkbcommon_libs" >> $config_host_mak
+fi
 if test "$fnmatch" = "yes" ; then
   echo "CONFIG_FNMATCH=y" >> $config_host_mak
 fi
diff --git a/Makefile b/Makefile
index ef721480eb..0b8ddfd2dd 100644
--- a/Makefile
+++ b/Makefile
@@ -381,6 +381,8 @@ qemu-io$(EXESUF): qemu-io.o $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj
 
 qemu-bridge-helper$(EXESUF): qemu-bridge-helper.o $(COMMON_LDADDS)
 
+qemu-keymap$(EXESUF): qemu-keymap.o ui/input-keymap.o
+
 fsdev/virtfs-proxy-helper$(EXESUF): fsdev/virtfs-proxy-helper.o fsdev/9p-marshal.o fsdev/9p-iov-marshal.o $(COMMON_LDADDS)
 fsdev/virtfs-proxy-helper$(EXESUF): LIBS += -lcap
 
@@ -390,6 +392,9 @@ qemu-img-cmds.h: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
 qemu-ga$(EXESUF): LIBS = $(LIBS_QGA)
 qemu-ga$(EXESUF): QEMU_CFLAGS += -I qga/qapi-generated
 
+qemu-keymap$(EXESUF): LIBS = $(XKBCOMMON_LIBS)
+qemu-keymap$(EXESUF): QEMU_CFLAGS += $(XKBCOMMON_CFLAGS)
+
 gen-out-type = $(subst .,-,$(suffix $@))
 
 qapi-py = $(SRC_PATH)/scripts/qapi.py $(SRC_PATH)/scripts/ordereddict.py
diff --git a/qemu-keymap.c b/qemu-keymap.c
new file mode 100644
index 0000000000..950fd54bdc
--- /dev/null
+++ b/qemu-keymap.c
@@ -0,0 +1,243 @@
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qapi-types.h"
+#include "qemu/notify.h"
+#include "ui/input.h"
+
+#include <xkbcommon/xkbcommon.h>
+
+struct xkb_rule_names names = {
+    .rules   = NULL,
+    .model   = "pc105",
+    .layout  = "us",
+    .variant = NULL,
+    .options = NULL,
+};
+
+static xkb_mod_mask_t shift;
+static xkb_mod_mask_t ctrl;
+static xkb_mod_mask_t altgr;
+
+static xkb_mod_mask_t numlock;
+
+static FILE *outfile;
+
+/* ------------------------------------------------------------------------ */
+
+static void print_sym(xkb_keysym_t sym, uint32_t number, const char *mod)
+{
+    char name[64];
+
+    if (sym == XKB_KEY_NoSymbol) {
+        return;
+    }
+    xkb_keysym_get_name(sym, name, sizeof(name));
+    fprintf(outfile, "%s 0x%02x%s\n", name, number, mod);
+}
+
+static void walk_map(struct xkb_keymap *map, xkb_keycode_t code, void *data)
+{
+    struct xkb_state *state = data;
+    xkb_keysym_t kbase, knumlock, kshift, kaltgr, kaltgrshift;
+    uint32_t evdev, qcode, number;
+    KeyValue keyvalue;
+    char name[64];
+
+    fprintf(outfile, "\n");
+
+    /*
+     * map xkb keycode -> QKeyCode
+     *
+     * xkb keycode is linux evdev shifted by 8
+     */
+    evdev = code - 8;
+    qcode = qemu_input_linux_to_qcode(evdev);
+    if (qcode == Q_KEY_CODE_UNMAPPED) {
+        fprintf(outfile, "# evdev %d (0x%x): no evdev -> qcode mapping",
+                evdev, evdev);
+        goto nomap;
+    }
+
+    /*
+     * map QKeyCode -> number
+     *
+     * TODO: long-term we should use QKeyCode names in keymaps instead
+     */
+    keyvalue.type = KEY_VALUE_KIND_QCODE;
+    keyvalue.u.qcode.data = qcode;
+    number = qemu_input_key_value_to_number(&keyvalue);
+    if (number == 0) {
+        fprintf(outfile,
+                "# evdev %d (0x%x), qcode %d: no qcode -> number mapping",
+                evdev, evdev, qcode);
+        goto nomap;
+    }
+    fprintf(outfile, "# evdev %d (0x%x), qcode %d, number 0x%x\n",
+            evdev, evdev, qcode, number);
+
+    /*
+     * check which modifier states generate which keysyms
+     */
+    xkb_state_update_mask(state,  0, 0, 0,  0, 0, 0);
+    kbase = xkb_state_key_get_one_sym(state, code);
+    print_sym(kbase, number, "");
+
+    xkb_state_update_mask(state,  0, 0, numlock,  0, 0, 0);
+    knumlock = xkb_state_key_get_one_sym(state, code);
+    if (kbase != knumlock) {
+        print_sym(knumlock, number, " numlock");
+    }
+
+    xkb_state_update_mask(state,  shift, 0, 0,  0, 0, 0);
+    kshift = xkb_state_key_get_one_sym(state, code);
+    if (kbase != kshift && knumlock != kshift) {
+        print_sym(kshift, number, " shift");
+    }
+
+    xkb_state_update_mask(state,  altgr, 0, 0,  0, 0, 0);
+    kaltgr = xkb_state_key_get_one_sym(state, code);
+    if (kbase != kaltgr) {
+        print_sym(kaltgr, number, " altgr");
+    }
+
+    xkb_state_update_mask(state,  altgr | shift, 0, 0,  0, 0, 0);
+    kaltgrshift = xkb_state_key_get_one_sym(state, code);
+    if (kshift != kaltgrshift && kaltgr != kaltgrshift) {
+        print_sym(kaltgrshift, number, " shift altgr");
+    }
+    return;
+
+nomap:
+    xkb_state_update_mask(state,  0, 0, 0,  0, 0, 0);
+    kbase = xkb_state_key_get_one_sym(state, code);
+    xkb_keysym_get_name(kbase, name, sizeof(name));
+    fprintf(outfile, " (xkb keysym %s)\n", name);
+}
+
+static void usage(FILE *out)
+{
+    fprintf(out,
+            "\n"
+            "This tool generates qemu reverse keymaps from xkb keymaps,\n"
+            "which can be used with the qemu \"-k\" command line switch.\n"
+            "\n"
+            "usage: qemu-keymap <options>\n"
+            "options:\n"
+            "    -h             print this text\n"
+            "    -f <file>      set output file  (default: stdout)\n"
+            "    -m <model>     set kbd model    (default: %s)\n"
+            "    -l <layout>    set kbd layout   (default: %s)\n"
+            "    -v <variant>   set kbd variant  (default: %s)\n"
+            "    -o <options>   set kbd options  (default: %s)\n"
+            "\n",
+            names.model, names.layout,
+            names.variant ?: "-",
+            names.options ?: "-");
+}
+
+int main(int argc, char *argv[])
+{
+    struct xkb_context *ctx;
+    struct xkb_keymap *map;
+    struct xkb_state *state;
+    xkb_mod_index_t mod, mods;
+    int rc;
+
+    for (;;) {
+        rc = getopt(argc, argv, "hm:l:v:o:f:");
+        if (rc == -1)
+            break;
+        switch (rc) {
+        case 'm':
+            names.model = optarg;
+            break;
+        case 'l':
+            names.layout = optarg;
+            break;
+        case 'v':
+            names.variant = optarg;
+            break;
+        case 'o':
+            names.options = optarg;
+            break;
+        case 'f':
+            outfile = fopen(optarg, "w");
+            if (outfile == NULL) {
+                fprintf(stderr, "open %s: %s\n", optarg, strerror(errno));
+                exit(1);
+            }
+            break;
+        case 'h':
+            usage(stdout);
+            exit(0);
+        default:
+            usage(stderr);
+            exit(1);
+        }
+    }
+
+    if (outfile == NULL) {
+        outfile = stdout;
+    }
+
+    fprintf(outfile,
+            "#\n"
+            "# generated by qemu-keymap\n"
+            "#    model   : %s\n"
+            "#    layout  : %s\n"
+            "#    variant : %s\n"
+            "#    options : %s\n"
+            "#\n\n",
+            names.model, names.layout,
+            names.variant ?: "-",
+            names.options ?: "-");
+
+    ctx = xkb_context_new(XKB_CONTEXT_NO_FLAGS);
+    map = xkb_keymap_new_from_names(ctx, &names, XKB_KEYMAP_COMPILE_NO_FLAGS);
+    if (!map) {
+        /* libxkbcommon prints error */
+        exit(1);
+    }
+
+    fprintf(outfile, "# modifiers\n");
+    mods = xkb_keymap_num_mods(map);
+    for (mod = 0; mod < mods; mod++) {
+        fprintf(outfile, "#    %2d: %s\n",
+                mod, xkb_keymap_mod_get_name(map, mod));
+    }
+
+    mod = xkb_keymap_mod_get_index(map, "Shift");
+    shift = (1 << mod);
+    mod = xkb_keymap_mod_get_index(map, "Control");
+    ctrl = (1 << mod);
+    mod = xkb_keymap_mod_get_index(map, "AltGr");
+    altgr = (1 << mod);
+    mod = xkb_keymap_mod_get_index(map, "NumLock");
+    numlock = (1 << mod);
+
+    state = xkb_state_new(map);
+    xkb_keymap_key_for_each(map, walk_map, state);
+
+    /*
+     * add quirks
+     *
+     * Sometimes multiple keysyms generate the same keycodes.
+     * With our keycode -> keysym lookup we'll find only one
+     * of the keysyms.  So append them here.
+     */
+    fprintf(outfile, "\n# quirks section\n"
+            "\n"
+            "Print 0xb7\n"
+            "Sys_Req 0xb7\n"
+            "Execute 0xb7\n"
+            "\n"
+            "KP_Decimal 0x53 numlock\n"
+            "KP_Separator 0x53 numlock\n"
+            "\n"
+            "Alt_R 0xb8\n"
+            "ISO_Level3_Shift 0xb8\n"
+            "Mode_switch 0xb8\n"
+            "\n");
+
+    exit(0);
+}
-- 
2.9.3
