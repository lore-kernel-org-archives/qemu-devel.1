Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1516EC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:11:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAC20214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAC20214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzyIr-0000qn-QB
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 03:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42493)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hzy89-0005Iz-0e
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hzy87-00030w-Dm
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:00:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44916)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hzy87-00030G-5S
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:00:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7936D190C10B;
 Tue, 20 Aug 2019 07:00:30 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5178791E9F;
 Tue, 20 Aug 2019 07:00:29 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 08:59:26 +0200
Message-Id: <1566284395-30287-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
References: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Tue, 20 Aug 2019 07:00:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 07/36] configure: Define target access alignment
 in configure
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "tony.nguyen@bt.com" <tony.nguyen@bt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "tony.nguyen@bt.com" <tony.nguyen@bt.com>

This patch moves the define of target access alignment earlier from
target/foo/cpu.h to configure.

Suggested in Richard Henderson's reply to "[PATCH 1/4] tcg: TCGMemOp is now
accelerator independent MemOp"

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Message-Id: <11e818d38ebc40e986cfa62dd7d0afdc@tpw09926dag18e.domain1.systemhost.net>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: tony.nguyen@bt.com <tony.nguyen@bt.com>
---
 configure             | 12 ++++++++++--
 include/exec/poison.h |  1 +
 include/qom/cpu.h     |  2 +-
 target/alpha/cpu.h    |  2 --
 target/hppa/cpu.h     |  1 -
 target/mips/cpu.h     |  2 --
 target/sh4/cpu.h      |  2 --
 target/sparc/cpu.h    |  2 --
 target/xtensa/cpu.h   |  2 --
 tcg/tcg.c             |  2 +-
 tcg/tcg.h             |  8 +++++---
 11 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/configure b/configure
index 714e7fb..942a73b 100755
--- a/configure
+++ b/configure
@@ -7431,11 +7431,16 @@ for target in $target_list; do
 target_dir="$target"
 config_target_mak=$target_dir/config-target.mak
 target_name=$(echo $target | cut -d '-' -f 1)
+target_aligned_only="no"
+case "$target_name" in
+  alpha|hppa|mips64el|mips64|mipsel|mips|mipsn32|mipsn32el|sh4|sh4eb|sparc|sparc64|sparc32plus|xtensa|xtensaeb)
+  target_aligned_only="yes"
+  ;;
+esac
 target_bigendian="no"
-
 case "$target_name" in
   armeb|aarch64_be|hppa|lm32|m68k|microblaze|mips|mipsn32|mips64|moxie|or1k|ppc|ppc64|ppc64abi32|s390x|sh4eb|sparc|sparc64|sparc32plus|xtensaeb)
-  target_bigendian=yes
+  target_bigendian="yes"
   ;;
 esac
 target_softmmu="no"
@@ -7717,6 +7722,9 @@ fi
 if supported_whpx_target $target; then
     echo "CONFIG_WHPX=y" >> $config_target_mak
 fi
+if test "$target_aligned_only" = "yes" ; then
+  echo "TARGET_ALIGNED_ONLY=y" >> $config_target_mak
+fi
 if test "$target_bigendian" = "yes" ; then
   echo "TARGET_WORDS_BIGENDIAN=y" >> $config_target_mak
 fi
diff --git a/include/exec/poison.h b/include/exec/poison.h
index b862320..955eb86 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -35,6 +35,7 @@
 #pragma GCC poison TARGET_UNICORE32
 #pragma GCC poison TARGET_XTENSA
 
+#pragma GCC poison TARGET_ALIGNED_ONLY
 #pragma GCC poison TARGET_HAS_BFLT
 #pragma GCC poison TARGET_NAME
 #pragma GCC poison TARGET_SUPPORTS_MTTCG
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 5ee0046..9b50b73 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -89,7 +89,7 @@ struct TranslationBlock;
  * @do_unassigned_access: Callback for unassigned access handling.
  * (this is deprecated: new targets should use do_transaction_failed instead)
  * @do_unaligned_access: Callback for unaligned access handling, if
- * the target defines #ALIGNED_ONLY.
+ * the target defines #TARGET_ALIGNED_ONLY.
  * @do_transaction_failed: Callback for handling failed memory transactions
  * (ie bus faults or external aborts; not MMU faults)
  * @virtio_is_big_endian: Callback to return %true if a CPU which supports
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index b3e8a82..16eb804 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -23,8 +23,6 @@
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
 
-#define ALIGNED_ONLY
-
 /* Alpha processors have a weak memory model */
 #define TCG_GUEST_DEFAULT_MO      (0)
 
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index aab251b..2be67c2 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -30,7 +30,6 @@
    basis.  It's probably easier to fall back to a strong memory model.  */
 #define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
 
-#define ALIGNED_ONLY
 #define MMU_KERNEL_IDX   0
 #define MMU_USER_IDX     3
 #define MMU_PHYS_IDX     4
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 21c0615..c13cd4e 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1,8 +1,6 @@
 #ifndef MIPS_CPU_H
 #define MIPS_CPU_H
 
-#define ALIGNED_ONLY
-
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
 #include "fpu/softfloat.h"
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index aee733e..ecaa7a1 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -23,8 +23,6 @@
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
 
-#define ALIGNED_ONLY
-
 /* CPU Subtypes */
 #define SH_CPU_SH7750  (1 << 0)
 #define SH_CPU_SH7750S (1 << 1)
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 8ed2250..1406f0b 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -5,8 +5,6 @@
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
 
-#define ALIGNED_ONLY
-
 #if !defined(TARGET_SPARC64)
 #define TARGET_DPREGS 16
 #else
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 2c27713..0459243 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -32,8 +32,6 @@
 #include "exec/cpu-defs.h"
 #include "xtensa-isa.h"
 
-#define ALIGNED_ONLY
-
 /* Xtensa processors have a weak memory model */
 #define TCG_GUEST_DEFAULT_MO      (0)
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index be2c33c..8d23fb0 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1926,7 +1926,7 @@ static const char * const ldst_name[] =
 };
 
 static const char * const alignment_name[(MO_AMASK >> MO_ASHIFT) + 1] = {
-#ifdef ALIGNED_ONLY
+#ifdef TARGET_ALIGNED_ONLY
     [MO_UNALN >> MO_ASHIFT]    = "un+",
     [MO_ALIGN >> MO_ASHIFT]    = "",
 #else
diff --git a/tcg/tcg.h b/tcg/tcg.h
index b411e17..529acb2 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -333,10 +333,12 @@ typedef enum TCGMemOp {
     MO_TE    = MO_LE,
 #endif
 
-    /* MO_UNALN accesses are never checked for alignment.
+    /*
+     * MO_UNALN accesses are never checked for alignment.
      * MO_ALIGN accesses will result in a call to the CPU's
      * do_unaligned_access hook if the guest address is not aligned.
-     * The default depends on whether the target CPU defines ALIGNED_ONLY.
+     * The default depends on whether the target CPU defines
+     * TARGET_ALIGNED_ONLY.
      *
      * Some architectures (e.g. ARMv8) need the address which is aligned
      * to a size more than the size of the memory access.
@@ -353,7 +355,7 @@ typedef enum TCGMemOp {
      */
     MO_ASHIFT = 4,
     MO_AMASK = 7 << MO_ASHIFT,
-#ifdef ALIGNED_ONLY
+#ifdef TARGET_ALIGNED_ONLY
     MO_ALIGN = 0,
     MO_UNALN = MO_AMASK,
 #else
-- 
1.8.3.1



