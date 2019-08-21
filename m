Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5225DC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:10:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D932216F4
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fc567Lfc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D932216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0SGA-0002To-N0
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 11:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen.git@gmail.com>) id 1i0SEz-0001Tt-Lx
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:09:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen.git@gmail.com>) id 1i0SEy-0001sV-70
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:09:37 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:42919)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tony.nguyen.git@gmail.com>)
 id 1i0SEx-0001q2-U6
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:09:36 -0400
Received: by mail-pl1-x643.google.com with SMTP id y1so1474000plp.9
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 08:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0l7y7+YzddUCO1ZZokVB7I29ZOqZMPg6LQzchxJqgfM=;
 b=Fc567Lfc+9t3kKxDF/ls05GzH2rZTT3lZLTzwzjBacIKkupBv34CSX1O5BQigCz8MT
 1BwkLtCfNsv/g8SLOCjCpgLDeUbMYg78QeVm/OnNqQelH8CI2JLHXjYVLarPFkz6sHne
 mkrHDlRGPxQ/WmQ7tSka3b/LLkWSqvC7TZK1reHn4SaRUUY8y++tWAon4Z39qNVBcrIE
 gStjQxDCQSaa3lA//iOjw6PDIA/geqdxhWIV5yBQalFQJ8I3zxbOZ8INSoS11je4DKXq
 RggcFWcW0acilcBNfEgIDfa8i2cK+hcNBsE7rUF61ocdS614Kj6z7WKHVGISnv1B6L4+
 zSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0l7y7+YzddUCO1ZZokVB7I29ZOqZMPg6LQzchxJqgfM=;
 b=k4+BELB5t3RADlLwmq5IPXNUCaSVoh1PH5Hra3ENkhy/K5CGmM5tW0bMdZ7lwkXXBR
 nFJseMfd81xDpk/p1eNhOGTnfPOHbr/Nk7Y6/r2mTkQdon0qgoeU2luNMsDuocQqN8mw
 7oXp/GCOCwhjmDXksqwq731bXxzG6yoQeheyosaDaYjvfnM2rGwtmTHZzSA+pLPRpVHf
 kesGaU8zK9nu0M9GWDwa5d6v4OC8u0d68vQEQdGzYdmyzuHE5kjn69njjYbJnFUScEDV
 H9touqHGaBLzvXw9C6u4PkmIfotnmfjqs6DMX+y3Je6OmRbhawf3kBIuRQoVZM2U+Bys
 L/2w==
X-Gm-Message-State: APjAAAXUlG52LAongCcaX7fAliUJyaXL+SdwlLe9NxnBHfumSWYGDW6G
 GE+hpWSm1H32z1OQVWIIVu72FDSZL3s=
X-Google-Smtp-Source: APXvYqycWy1ryBhBSjFYgrzqnpXc7NkmHMbECQeCPRve0Z6Jd+SXyNGfm3FxV9FK4iDAokghrcGpOw==
X-Received: by 2002:a17:902:b406:: with SMTP id
 x6mr33031895plr.114.1566400174426; 
 Wed, 21 Aug 2019 08:09:34 -0700 (PDT)
Received: from localhost.localdomain ([58.173.98.68])
 by smtp.gmail.com with ESMTPSA id e19sm5887633pfh.114.2019.08.21.08.09.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 21 Aug 2019 08:09:34 -0700 (PDT)
From: Tony Nguyen <tony.nguyen.git@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 01:08:55 +1000
Message-Id: <00f837b07ebb2468af5254626cc6b2bf94ddab4b.1566397711.git.tony.nguyen.git@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566397711.git.tony.nguyen.git@gmail.com>
References: <cover.1566397711.git.tony.nguyen.git@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v8 01/21] configure: Define TARGET_ALIGNED_ONLY
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
Cc: Tony Nguyen <tony.nguyen@bt.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Tony Nguyen <tony.nguyen.git@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename ALIGNED_ONLY to TARGET_ALIGNED_ONLY for clarity and move
defines out of target/foo/cpu.h into configure, as we do with
TARGET_WORDS_BIGENDIAN, so that it is always defined early.

Poisoned TARGET_ALIGNED_ONLY to prevent use in common code.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 configure             | 10 +++++++++-
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
 11 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/configure b/configure
index 714e7fb6a1..482ba0b240 100755
--- a/configure
+++ b/configure
@@ -7431,8 +7431,13 @@ for target in $target_list; do
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
   target_bigendian=yes
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
index b862320fa6..955eb863ab 100644
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
index ddb91bbaff..77fca95a40 100644
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
index 4619530660..a530249a5b 100644
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
index 4b816cc13a..6713d04f11 100644
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
index d235117dab..1fd4a180e1 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1,8 +1,6 @@
 #ifndef MIPS_CPU_H
 #define MIPS_CPU_H
 
-#define ALIGNED_ONLY
-
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
 #include "fpu/softfloat-types.h"
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index aee733eaaa..ecaa7a18a9 100644
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
index 0d5b01efe5..694d7139cf 100644
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
index 2c277134f1..0459243e6b 100644
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
index 2db83ce2e8..0458eaec57 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1925,7 +1925,7 @@ static const char * const ldst_name[] =
 };
 
 static const char * const alignment_name[(MO_AMASK >> MO_ASHIFT) + 1] = {
-#ifdef ALIGNED_ONLY
+#ifdef TARGET_ALIGNED_ONLY
     [MO_UNALN >> MO_ASHIFT]    = "un+",
     [MO_ALIGN >> MO_ASHIFT]    = "",
 #else
diff --git a/tcg/tcg.h b/tcg/tcg.h
index b411e17a28..529acb2ed8 100644
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
2.23.0


