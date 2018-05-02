Received: from eggs.gnu.org ([2001:4830:134:3::10]:45984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fDvUa-0002rz-5C
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:24:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fDvUY-00029x-Gq
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:24:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57840 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fDvUY-00029m-Bi
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:24:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E9AE54023155
	for <qemu-devel@nongnu.org>; Wed,  2 May 2018 17:24:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Wed,  2 May 2018 19:24:26 +0200
Message-Id: <1525281868-24747-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1525281868-24747-1-git-send-email-thuth@redhat.com>
References: <1525281868-24747-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] qemu-options: Remove deprecated
 -no-kvm-pit-reinjection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Deprecated since the beginning when it was added for compatibility with
the ancient qemu-kvm fork of QEMU, and it even printed out the deprecation
warning since right from the start (i.e. QEMU v1.3.0), so it's really time
to remove this now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qemu-doc.texi   |  5 -----
 qemu-options.hx |  4 ----
 vl.c            | 12 ------------
 3 files changed, 21 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 5813d27..dd39bac 100644
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
index 44daa10..9c0d60d 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3917,10 +3917,6 @@ ETEXI
 HXCOMM Deprecated by -machine accel=tcg property
 DEF("no-kvm", 0, QEMU_OPTION_no_kvm, "", QEMU_ARCH_I386)
 
-HXCOMM Deprecated by kvm-pit driver properties
-DEF("no-kvm-pit-reinjection", 0, QEMU_OPTION_no_kvm_pit_reinjection,
-    "", QEMU_ARCH_I386)
-
 HXCOMM Deprecated by -machine kernel_irqchip=on|off property
 DEF("no-kvm-irqchip", 0, QEMU_OPTION_no_kvm_irqchip, "", QEMU_ARCH_I386)
 
diff --git a/vl.c b/vl.c
index 7487535..24478b1 100644
--- a/vl.c
+++ b/vl.c
@@ -3741,18 +3741,6 @@ int main(int argc, char **argv, char **envp)
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
