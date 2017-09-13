Received: from eggs.gnu.org ([2001:4830:134:3::10]:41318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dsBTx-0007qh-KT
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 13:29:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dsBTu-0002jG-89
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 13:29:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dsBTu-0002hM-0Z
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 13:29:46 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 13 Sep 2017 19:29:41 +0200
Message-Id: <20170913172941.5470-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v2] accel: default to an actually available
 accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lvivier@redhat.com, pbonzini@redhat.com, thuth@redhat.com, mreitz@redhat.com, kwolf@redhat.com, richard.henderson@linaro.org, peter.maydell@linaro.org, Cornelia Huck <cohuck@redhat.com>

configure_accelerator() falls back to tcg if no accelerator has
been specified. Formerly, we could be sure that tcg is always
available; however, with --disable-tcg, this is not longer true,
and you are not able to start qemu without explicitly specifying
another accelerator on those builds.

Instead, choose an accelerator in the order tcg->kvm->hax.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
RFC->v2:
- drop xen from the list of fallbacks
- use comma-delimited list of accelerators (much easier)
- changed one place in qemu-options.hx that had been missed
---
 accel/accel.c   | 3 +--
 qemu-options.hx | 8 +++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/accel/accel.c b/accel/accel.c
index 8ae40e1e13..e8a3121d06 100644
--- a/accel/accel.c
+++ b/accel/accel.c
@@ -79,8 +79,7 @@ void configure_accelerator(MachineState *ms)
 
     accel = qemu_opt_get(qemu_get_machine_opts(), "accel");
     if (accel == NULL) {
-        /* Use the default "accelerator", tcg */
-        accel = "tcg";
+        accel = "tcg:kvm:hax";
     }
 
     p = accel;
diff --git a/qemu-options.hx b/qemu-options.hx
index 9f6e2adfff..2ff88389e0 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -31,7 +31,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "-machine [type=]name[,prop[=value][,...]]\n"
     "                selects emulated machine ('-machine help' for list)\n"
     "                property accel=accel1[:accel2[:...]] selects accelerator\n"
-    "                supported accelerators are kvm, xen, hax or tcg (default: tcg)\n"
+    "                supported accelerators are kvm, xen, hax or tcg (default: tcg:kvm:hax)\n"
     "                kernel_irqchip=on|off|split controls accelerated irqchip support (default=off)\n"
     "                vmport=on|off|auto controls emulation of vmport (default: auto)\n"
     "                kvm_shadow_mem=size of KVM shadow MMU in bytes\n"
@@ -66,7 +66,8 @@ Supported machine properties are:
 @table @option
 @item accel=@var{accels1}[:@var{accels2}[:...]]
 This is used to enable an accelerator. Depending on the target architecture,
-kvm, xen, hax or tcg can be available. By default, tcg is used. If there is
+kvm, xen, hax or tcg can be available. By default, the first one available
+out of tcg, kvm, hax (in that order) is used. If there is
 more than one accelerator specified, the next one is used if the previous one
 fails to initialize.
 @item kernel_irqchip=on|off
@@ -126,7 +127,8 @@ STEXI
 @item -accel @var{name}[,prop=@var{value}[,...]]
 @findex -accel
 This is used to enable an accelerator. Depending on the target architecture,
-kvm, xen, hax or tcg can be available. By default, tcg is used. If there is
+kvm, xen, hax or tcg can be available. By default, the first one available
+out of tcg, kvm, hax (in that order) is used. If there is
 more than one accelerator specified, the next one is used if the previous one
 fails to initialize.
 @table @option
-- 
2.13.5
