Received: from eggs.gnu.org ([2001:4830:134:3::10]:41421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAt9-0003A8-Uz
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAt8-0001WV-UQ
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:15 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fGAt8-0001WK-Mf
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:14 -0400
Received: by mail-wm0-x241.google.com with SMTP id o78-v6so24238531wmg.0
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 15:15:14 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  9 May 2018 00:14:37 +0200
Message-Id: <1525817687-34620-21-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
References: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 20/30] qemu-options: Remove deprecated
 -no-kvm-pit-reinjection
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

Deprecated since the beginning when it was added for compatibility with
the ancient qemu-kvm fork of QEMU, and it even printed out the deprecation
warning since right from the start (i.e. QEMU v1.3.0), so it's really time
to remove this now.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1525453270-23074-4-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-doc.texi   |  5 -----
 qemu-options.hx |  4 ----
 vl.c            | 12 ------------
 3 files changed, 21 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 4add403..85a7a39 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2786,11 +2786,6 @@ which is the default.
 
 @section System emulator command line arguments
 
-@subsection -no-kvm-pit-reinjection (since 1.3.0)
-
-The ``-no-kvm-pit-reinjection'' argument is now a
-synonym for setting ``-global kvm-pit.lost_tick_policy=discard''.
-
 @subsection -no-kvm-irqchip (since 1.3.0)
 
 The ``-no-kvm-irqchip'' argument is now a synonym for
diff --git a/qemu-options.hx b/qemu-options.hx
index 50c906c..dfff698 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3914,10 +3914,6 @@ ETEXI
 HXCOMM Deprecated by -machine accel=tcg property
 DEF("no-kvm", 0, QEMU_OPTION_no_kvm, "", QEMU_ARCH_I386)
 
-HXCOMM Deprecated by kvm-pit driver properties
-DEF("no-kvm-pit-reinjection", 0, QEMU_OPTION_no_kvm_pit_reinjection,
-    "", QEMU_ARCH_I386)
-
 HXCOMM Deprecated by -machine kernel_irqchip=on|off property
 DEF("no-kvm-irqchip", 0, QEMU_OPTION_no_kvm_irqchip, "", QEMU_ARCH_I386)
 
diff --git a/vl.c b/vl.c
index a23acb2..23d55a4 100644
--- a/vl.c
+++ b/vl.c
@@ -3696,18 +3696,6 @@ int main(int argc, char **argv, char **envp)
                 olist = qemu_find_opts("machine");
                 qemu_opts_parse_noisily(olist, "accel=tcg", false);
                 break;
-            case QEMU_OPTION_no_kvm_pit_reinjection: {
-                static GlobalProperty kvm_pit_lost_tick_policy = {
-                    .driver   = "kvm-pit",
-                    .property = "lost_tick_policy",
-                    .value    = "discard",
-                };
-
-                warn_report("deprecated, replaced by "
-                            "-global kvm-pit.lost_tick_policy=discard");
-                qdev_prop_register_global(&kvm_pit_lost_tick_policy);
-                break;
-            }
             case QEMU_OPTION_accel:
                 accel_opts = qemu_opts_parse_noisily(qemu_find_opts("accel"),
                                                      optarg, true);
-- 
1.8.3.1
