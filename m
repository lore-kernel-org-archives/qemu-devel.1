Received: from eggs.gnu.org ([2001:4830:134:3::10]:43289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d69Fy-0007DT-PE
	for qemu-devel@nongnu.org; Thu, 04 May 2017 01:24:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d69Fv-0007S5-LI
	for qemu-devel@nongnu.org; Thu, 04 May 2017 01:24:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1d69Fv-0007RR-Cx
	for qemu-devel@nongnu.org; Thu, 04 May 2017 01:24:47 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  4 May 2017 07:24:41 +0200
Message-Id: <1493875481-16388-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2] Fix the -accel parameter and the
 documentation for 'hax'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vincent Palatin <vpalatin@chromium.org>, Eduardo Habkost <ehabkost@redhat.com>

Since 'hax' is a possible accelerator nowadays, too, the '-accel'
option should support it and we should mention this accelerator
in the documentation, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2:
 - Use qemu_opt_set() instead of qemu_opts_parse_noisily()
 - Improve the documentation of the -accel option

 qemu-options.hx | 18 +++++++++---------
 vl.c            | 23 +++++++++--------------
 2 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 787b9c3..21f8ff2 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -31,7 +31,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "-machine [type=]name[,prop[=value][,...]]\n"
     "                selects emulated machine ('-machine help' for list)\n"
     "                property accel=accel1[:accel2[:...]] selects accelerator\n"
-    "                supported accelerators are kvm, xen, tcg (default: tcg)\n"
+    "                supported accelerators are kvm, xen, hax or tcg (default: tcg)\n"
     "                kernel_irqchip=on|off|split controls accelerated irqchip support (default=off)\n"
     "                vmport=on|off|auto controls emulation of vmport (default: auto)\n"
     "                kvm_shadow_mem=size of KVM shadow MMU in bytes\n"
@@ -52,9 +52,9 @@ available machines. Supported machine properties are:
 @table @option
 @item accel=@var{accels1}[:@var{accels2}[:...]]
 This is used to enable an accelerator. Depending on the target architecture,
-kvm, xen, or tcg can be available. By default, tcg is used. If there is more
-than one accelerator specified, the next one is used if the previous one fails
-to initialize.
+kvm, xen, hax or tcg can be available. By default, tcg is used. If there is
+more than one accelerator specified, the next one is used if the previous one
+fails to initialize.
 @item kernel_irqchip=on|off
 Controls in-kernel irqchip support for the chosen accelerator when available.
 @item gfx_passthru=on|off
@@ -97,15 +97,15 @@ ETEXI
 
 DEF("accel", HAS_ARG, QEMU_OPTION_accel,
     "-accel [accel=]accelerator[,thread=single|multi]\n"
-    "               select accelerator ('-accel help for list')\n"
-    "               thread=single|multi (enable multi-threaded TCG)", QEMU_ARCH_ALL)
+    "                select accelerator (kvm, xen, hax or tcg; use 'help' for a list)\n"
+    "                thread=single|multi (enable multi-threaded TCG)", QEMU_ARCH_ALL)
 STEXI
 @item -accel @var{name}[,prop=@var{value}[,...]]
 @findex -accel
 This is used to enable an accelerator. Depending on the target architecture,
-kvm, xen, or tcg can be available. By default, tcg is used. If there is more
-than one accelerator specified, the next one is used if the previous one fails
-to initialize.
+kvm, xen, hax or tcg can be available. By default, tcg is used. If there is
+more than one accelerator specified, the next one is used if the previous one
+fails to initialize.
 @table @option
 @item thread=single|multi
 Controls number of TCG threads. When the TCG is multi-threaded there will be one
diff --git a/vl.c b/vl.c
index f46e070..0a1b931 100644
--- a/vl.c
+++ b/vl.c
@@ -3725,26 +3725,21 @@ int main(int argc, char **argv, char **envp)
                 qdev_prop_register_global(&kvm_pit_lost_tick_policy);
                 break;
             }
-            case QEMU_OPTION_accel:
+            case QEMU_OPTION_accel: {
+                QemuOpts *accel_opts;
+
                 accel_opts = qemu_opts_parse_noisily(qemu_find_opts("accel"),
                                                      optarg, true);
                 optarg = qemu_opt_get(accel_opts, "accel");
-
-                olist = qemu_find_opts("machine");
-                if (strcmp("kvm", optarg) == 0) {
-                    qemu_opts_parse_noisily(olist, "accel=kvm", false);
-                } else if (strcmp("xen", optarg) == 0) {
-                    qemu_opts_parse_noisily(olist, "accel=xen", false);
-                } else if (strcmp("tcg", optarg) == 0) {
-                    qemu_opts_parse_noisily(olist, "accel=tcg", false);
-                } else {
-                    if (!is_help_option(optarg)) {
-                        error_printf("Unknown accelerator: %s", optarg);
-                    }
-                    error_printf("Supported accelerators: kvm, xen, tcg\n");
+                if (!optarg || is_help_option(optarg)) {
+                    error_printf("Possible accelerators: kvm, xen, hax, tcg\n");
                     exit(1);
                 }
+                accel_opts = qemu_opts_create(qemu_find_opts("machine"), NULL,
+                                              false, &error_abort);
+                qemu_opt_set(accel_opts, "accel", optarg, &error_abort);
                 break;
+            }
             case QEMU_OPTION_usb:
                 olist = qemu_find_opts("machine");
                 qemu_opts_parse_noisily(olist, "usb=on", false);
-- 
1.8.3.1
