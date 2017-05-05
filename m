Received: from eggs.gnu.org ([2001:4830:134:3::10]:47145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6aFK-0002OQ-UE
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:14:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6aFJ-0006fj-N3
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:13:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d6aFJ-0006fM-Df
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:13:57 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 720F03D974
	for <qemu-devel@nongnu.org>; Fri,  5 May 2017 10:13:56 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  5 May 2017 12:13:30 +0200
Message-Id: <20170505101337.4650-15-pbonzini@redhat.com>
In-Reply-To: <20170505101337.4650-1-pbonzini@redhat.com>
References: <20170505101337.4650-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 14/21] Fix the -accel parameter and the
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
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

Since 'hax' is a possible accelerator nowadays, too, the '-accel'
option should support it and we should mention this accelerator
in the documentation, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1493875481-16388-1-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-options.hx | 18 +++++++++---------
 vl.c            | 23 +++++++++--------------
 2 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index f68829f3b0..70c0ded12e 100644
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
index 42d4bce439..17b9a8ac2f 100644
--- a/vl.c
+++ b/vl.c
@@ -3727,26 +3727,21 @@ int main(int argc, char **argv, char **envp)
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
2.12.2
