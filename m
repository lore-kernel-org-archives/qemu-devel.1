Return-Path: <SRS0=kzat=2W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850B6C2D0DC
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jan 2020 11:26:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA94206E6
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jan 2020 11:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X8+WtyiA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA94206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imc8W-0004aj-Uw
	for qemu-devel@archiver.kernel.org; Wed, 01 Jan 2020 06:26:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imc6K-0002Vu-1c
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 06:23:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imc6G-0007L5-RC
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 06:23:43 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25883
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imc6G-0007J9-Kg
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 06:23:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577877820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kMbpgAVSPVenMOZC7CUCklS/YKMCXNycnc3R2IzxXeY=;
 b=X8+WtyiA/K7GQPRrT5DRqyruIfabSwNJUCz6K/inVBzxskCQyzTrc64ALczZrnWJlVdvJi
 BVE016e/C0Lht08zMQUPEXYCMXIy2PBm650Ry4rtO6UrufBDZHp6/HHRuTCXILQiE3wx33
 lt+anVapsLEx7mNKFNPi8LmNq3tLJFU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-oeqe4A3fMpifsMnXFnkcUA-1; Wed, 01 Jan 2020 06:23:38 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F1C9477;
 Wed,  1 Jan 2020 11:23:33 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-116-36.ams2.redhat.com [10.36.116.36])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 66B8C5D9E2;
 Wed,  1 Jan 2020 11:23:24 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/4] tcg: Search includes from the project root source
 directory
Date: Wed,  1 Jan 2020 12:23:00 +0100
Message-Id: <20200101112303.20724-2-philmd@redhat.com>
In-Reply-To: <20200101112303.20724-1-philmd@redhat.com>
References: <20200101112303.20724-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: oeqe4A3fMpifsMnXFnkcUA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>, Anthony Green <green@moxielogic.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Riku Voipio <riku.voipio@iki.fi>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>,
 qemu-riscv@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>,
 Claudio Fontana <claudio.fontana@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We currently search both the root and the tcg/ directories for tcg
files:

  $ git grep '#include "tcg/' | wc -l
  28

  $ git grep '#include "tcg[^/]' | wc -l
  94

To simplify the preprocessor search path, unify by expliciting the
tcg/ directory.

Patch created mechanically by running:

  $ for x in \
      tcg.h tcg-mo.h tcg-op.h tcg-opc.h \
      tcg-op-gvec.h tcg-gvec-desc.h; do \
    sed -i "s,#include \"$x\",#include \"tcg/$x\"," \
      $(git grep -l "#include \"$x\""); \
    done

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/exec/cpu_ldst.h       | 2 +-
 tcg/i386/tcg-target.h         | 2 +-
 tcg/tcg-op.h                  | 2 +-
 tcg/tcg.h                     | 4 ++--
 accel/tcg/cpu-exec.c          | 2 +-
 accel/tcg/tcg-runtime-gvec.c  | 2 +-
 accel/tcg/translate-all.c     | 2 +-
 accel/tcg/user-exec.c         | 2 +-
 bsd-user/main.c               | 2 +-
 cpus.c                        | 2 +-
 exec.c                        | 2 +-
 linux-user/main.c             | 2 +-
 target/alpha/translate.c      | 2 +-
 target/arm/helper-a64.c       | 2 +-
 target/arm/translate-a64.c    | 4 ++--
 target/arm/translate-sve.c    | 6 +++---
 target/arm/translate.c        | 4 ++--
 target/cris/translate.c       | 2 +-
 target/hppa/translate.c       | 2 +-
 target/i386/mem_helper.c      | 2 +-
 target/i386/translate.c       | 2 +-
 target/lm32/translate.c       | 2 +-
 target/m68k/translate.c       | 2 +-
 target/microblaze/translate.c | 2 +-
 target/mips/translate.c       | 2 +-
 target/moxie/translate.c      | 2 +-
 target/nios2/translate.c      | 2 +-
 target/openrisc/translate.c   | 2 +-
 target/ppc/mem_helper.c       | 2 +-
 target/ppc/translate.c        | 4 ++--
 target/riscv/cpu_helper.c     | 2 +-
 target/riscv/translate.c      | 2 +-
 target/s390x/translate.c      | 4 ++--
 target/sh4/translate.c        | 2 +-
 target/sparc/ldst_helper.c    | 2 +-
 target/sparc/translate.c      | 2 +-
 target/tilegx/translate.c     | 2 +-
 target/tricore/translate.c    | 2 +-
 target/unicore32/translate.c  | 2 +-
 target/xtensa/translate.c     | 2 +-
 tcg/optimize.c                | 2 +-
 tcg/tcg-common.c              | 2 +-
 tcg/tcg-op-gvec.c             | 8 ++++----
 tcg/tcg-op-vec.c              | 6 +++---
 tcg/tcg-op.c                  | 6 +++---
 tcg/tcg.c                     | 2 +-
 tcg/tci.c                     | 2 +-
 47 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index fd499f7e2f..9c637f6e89 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -153,7 +153,7 @@ static inline void clear_helper_retaddr(void)
 #else
=20
 /* The memory helpers for tcg-generated code need tcg_target_long etc.  */
-#include "tcg.h"
+#include "tcg/tcg.h"
=20
 static inline target_ulong tlb_addr_write(const CPUTLBEntry *entry)
 {
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 928e8b87bb..bfb3f5f6e9 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -223,7 +223,7 @@ static inline void tb_target_set_jmp_target(uintptr_t t=
c_ptr,
  * The x86 has a pretty strong memory ordering which only really
  * allows for some stores to be re-ordered after loads.
  */
-#include "tcg-mo.h"
+#include "tcg/tcg-mo.h"
=20
 #define TCG_TARGET_DEFAULT_MO (TCG_MO_ALL & ~TCG_MO_ST_LD)
=20
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 4af272daa5..230db6e022 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -25,7 +25,7 @@
 #ifndef TCG_TCG_OP_H
 #define TCG_TCG_OP_H
=20
-#include "tcg.h"
+#include "tcg/tcg.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
=20
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 92ca10dffc..bb59027240 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -31,7 +31,7 @@
 #include "qemu/bitops.h"
 #include "qemu/plugin.h"
 #include "qemu/queue.h"
-#include "tcg-mo.h"
+#include "tcg/tcg-mo.h"
 #include "tcg-target.h"
 #include "qemu/int128.h"
=20
@@ -211,7 +211,7 @@ typedef uint64_t TCGRegSet;
=20
 typedef enum TCGOpcode {
 #define DEF(name, oargs, iargs, cargs, flags) INDEX_op_ ## name,
-#include "tcg-opc.h"
+#include "tcg/tcg-opc.h"
 #undef DEF
     NB_OPS,
 } TCGOpcode;
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 62068d10c3..2560c90eec 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -23,7 +23,7 @@
 #include "trace.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
-#include "tcg.h"
+#include "tcg/tcg.h"
 #include "qemu/atomic.h"
 #include "sysemu/qtest.h"
 #include "qemu/timer.h"
diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index 51cb29ca79..5b1902d591 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -21,7 +21,7 @@
 #include "qemu/host-utils.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
-#include "tcg-gvec-desc.h"
+#include "tcg/tcg-gvec-desc.h"
=20
=20
 /* Virtually all hosts support 16-byte vectors.  Those that don't can emul=
ate
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index bb325a2bc4..a08ab11f65 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -25,7 +25,7 @@
 #include "trace.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
-#include "tcg.h"
+#include "tcg/tcg.h"
 #if defined(CONFIG_USER_ONLY)
 #include "qemu.h"
 #if defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index b09f7a1577..2d45613231 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -20,7 +20,7 @@
 #include "cpu.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
-#include "tcg.h"
+#include "tcg/tcg.h"
 #include "qemu/bitops.h"
 #include "exec/cpu_ldst.h"
 #include "translate-all.h"
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 7f4e3cd627..770c2b267a 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -33,7 +33,7 @@
 #include "qemu/module.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
-#include "tcg.h"
+#include "tcg/tcg.h"
 #include "qemu/timer.h"
 #include "qemu/envlist.h"
 #include "exec/log.h"
diff --git a/cpus.c b/cpus.c
index b472378b70..18f56572fa 100644
--- a/cpus.c
+++ b/cpus.c
@@ -53,7 +53,7 @@
 #include "qemu/bitmap.h"
 #include "qemu/seqlock.h"
 #include "qemu/guest-random.h"
-#include "tcg.h"
+#include "tcg/tcg.h"
 #include "hw/nmi.h"
 #include "sysemu/replay.h"
 #include "sysemu/runstate.h"
diff --git a/exec.c b/exec.c
index d4b769d0d4..0f6b087f57 100644
--- a/exec.c
+++ b/exec.c
@@ -25,7 +25,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/target_page.h"
-#include "tcg.h"
+#include "tcg/tcg.h"
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
 #if !defined(CONFIG_USER_ONLY)
diff --git a/linux-user/main.c b/linux-user/main.c
index 8718d03ee2..fba833aac9 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -37,7 +37,7 @@
 #include "qemu/plugin.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
-#include "tcg.h"
+#include "tcg/tcg.h"
 #include "qemu/timer.h"
 #include "qemu/envlist.h"
 #include "qemu/guest-random.h"
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index f7f1ed0f41..8870284f57 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -23,7 +23,7 @@
 #include "disas/disas.h"
 #include "qemu/host-utils.h"
 #include "exec/exec-all.h"
-#include "tcg-op.h"
+#include "tcg/tcg-op.h"
 #include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index b4cd680fc4..36aa6badfd 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -31,7 +31,7 @@
 #include "exec/cpu_ldst.h"
 #include "qemu/int128.h"
 #include "qemu/atomic128.h"
-#include "tcg.h"
+#include "tcg/tcg.h"
 #include "fpu/softfloat.h"
 #include <zlib.h> /* For crc32 */
=20
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d4bebbe629..a1d4dce4fa 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -20,8 +20,8 @@
=20
 #include "cpu.h"
 #include "exec/exec-all.h"
-#include "tcg-op.h"
-#include "tcg-op-gvec.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
 #include "qemu/log.h"
 #include "arm_ldst.h"
 #include "translate.h"
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 5d7edd0907..b35bad245e 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -20,9 +20,9 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
-#include "tcg-op.h"
-#include "tcg-op-gvec.h"
-#include "tcg-gvec-desc.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg-gvec-desc.h"
 #include "qemu/log.h"
 #include "arm_ldst.h"
 #include "translate.h"
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 2b6c1f91bf..39821d040b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -24,8 +24,8 @@
 #include "internals.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
-#include "tcg-op.h"
-#include "tcg-op-gvec.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
 #include "qemu/log.h"
 #include "qemu/bitops.h"
 #include "arm_ldst.h"
diff --git a/target/cris/translate.c b/target/cris/translate.c
index cb57516a44..aaa46b5bca 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -27,7 +27,7 @@
 #include "cpu.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
-#include "tcg-op.h"
+#include "tcg/tcg-op.h"
 #include "exec/helper-proto.h"
 #include "mmu.h"
 #include "exec/cpu_ldst.h"
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 2f8d407a82..f25927aeca 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -22,7 +22,7 @@
 #include "disas/disas.h"
 #include "qemu/host-utils.h"
 #include "exec/exec-all.h"
-#include "tcg-op.h"
+#include "tcg/tcg-op.h"
 #include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
diff --git a/target/i386/mem_helper.c b/target/i386/mem_helper.c
index d50d4b0c40..acf41f8885 100644
--- a/target/i386/mem_helper.c
+++ b/target/i386/mem_helper.c
@@ -24,7 +24,7 @@
 #include "exec/cpu_ldst.h"
 #include "qemu/int128.h"
 #include "qemu/atomic128.h"
-#include "tcg.h"
+#include "tcg/tcg.h"
=20
 void helper_cmpxchg8b_unlocked(CPUX86State *env, target_ulong a0)
 {
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 7c99ef1385..d9af8f4078 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -22,7 +22,7 @@
 #include "cpu.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
-#include "tcg-op.h"
+#include "tcg/tcg-op.h"
 #include "exec/cpu_ldst.h"
 #include "exec/translator.h"
=20
diff --git a/target/lm32/translate.c b/target/lm32/translate.c
index 73db9654d6..e583d52d03 100644
--- a/target/lm32/translate.c
+++ b/target/lm32/translate.c
@@ -23,7 +23,7 @@
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
 #include "exec/translator.h"
-#include "tcg-op.h"
+#include "tcg/tcg-op.h"
 #include "qemu/qemu-print.h"
=20
 #include "exec/cpu_ldst.h"
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index fcdb7bc8e4..31b743717e 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -22,7 +22,7 @@
 #include "cpu.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
-#include "tcg-op.h"
+#include "tcg/tcg-op.h"
 #include "qemu/log.h"
 #include "qemu/qemu-print.h"
 #include "exec/cpu_ldst.h"
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 525115b041..37a844db99 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -22,7 +22,7 @@
 #include "cpu.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
-#include "tcg-op.h"
+#include "tcg/tcg-op.h"
 #include "exec/helper-proto.h"
 #include "microblaze-decode.h"
 #include "exec/cpu_ldst.h"
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 4bff585bd6..efe75e6be0 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -26,7 +26,7 @@
 #include "internal.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
-#include "tcg-op.h"
+#include "tcg/tcg-op.h"
 #include "exec/cpu_ldst.h"
 #include "hw/mips/cpudevs.h"
=20
diff --git a/target/moxie/translate.c b/target/moxie/translate.c
index c87e9ec2b1..d5fb27dfb8 100644
--- a/target/moxie/translate.c
+++ b/target/moxie/translate.c
@@ -26,7 +26,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "disas/disas.h"
-#include "tcg-op.h"
+#include "tcg/tcg-op.h"
 #include "exec/cpu_ldst.h"
 #include "qemu/qemu-print.h"
=20
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index 82107bf270..6c34cd3193 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -23,7 +23,7 @@
=20
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "tcg-op.h"
+#include "tcg/tcg-op.h"
 #include "exec/exec-all.h"
 #include "disas/disas.h"
 #include "exec/helper-proto.h"
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 8dd28d6cf1..52323a16df 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -22,7 +22,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "disas/disas.h"
-#include "tcg-op.h"
+#include "tcg/tcg-op.h"
 #include "qemu/log.h"
 #include "qemu/bitops.h"
 #include "qemu/qemu-print.h"
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 1351b53f28..7404b14bed 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -25,7 +25,7 @@
 #include "exec/helper-proto.h"
 #include "helper_regs.h"
 #include "exec/cpu_ldst.h"
-#include "tcg.h"
+#include "tcg/tcg.h"
 #include "internal.h"
 #include "qemu/atomic128.h"
=20
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index f5fe5d0611..9dcf8dc261 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -23,8 +23,8 @@
 #include "internal.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
-#include "tcg-op.h"
-#include "tcg-op-gvec.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
 #include "qemu/host-utils.h"
 #include "qemu/main-loop.h"
 #include "exec/cpu_ldst.h"
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 767c8762ac..85403da9c8 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -22,7 +22,7 @@
 #include "qemu/main-loop.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
-#include "tcg-op.h"
+#include "tcg/tcg-op.h"
 #include "trace.h"
=20
 int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch)
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index ab6a891dc3..56b1b1fe7b 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -19,7 +19,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "cpu.h"
-#include "tcg-op.h"
+#include "tcg/tcg-op.h"
 #include "disas/disas.h"
 #include "exec/cpu_ldst.h"
 #include "exec/exec-all.h"
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 4292bb0dd0..b764ec3140 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -33,8 +33,8 @@
 #include "internal.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
-#include "tcg-op.h"
-#include "tcg-op-gvec.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
 #include "qemu/log.h"
 #include "qemu/host-utils.h"
 #include "exec/cpu_ldst.h"
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 922785e225..6192d83e8c 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -23,7 +23,7 @@
 #include "cpu.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
-#include "tcg-op.h"
+#include "tcg/tcg-op.h"
 #include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 7345827a96..e91cfdecd3 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -19,7 +19,7 @@
=20
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "tcg.h"
+#include "tcg/tcg.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index edc23a7c40..9416a551cf 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -24,7 +24,7 @@
 #include "disas/disas.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
-#include "tcg-op.h"
+#include "tcg/tcg-op.h"
 #include "exec/cpu_ldst.h"
=20
 #include "exec/helper-gen.h"
diff --git a/target/tilegx/translate.c b/target/tilegx/translate.c
index abce7e1c75..65f1c91f4f 100644
--- a/target/tilegx/translate.c
+++ b/target/tilegx/translate.c
@@ -24,7 +24,7 @@
 #include "exec/log.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
-#include "tcg-op.h"
+#include "tcg/tcg-op.h"
 #include "exec/cpu_ldst.h"
 #include "linux-user/syscall_defs.h"
=20
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index c574638c9f..609d75ae8a 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -22,7 +22,7 @@
 #include "cpu.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
-#include "tcg-op.h"
+#include "tcg/tcg-op.h"
 #include "exec/cpu_ldst.h"
 #include "qemu/qemu-print.h"
=20
diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
index 0f6891b8aa..d4b06df672 100644
--- a/target/unicore32/translate.c
+++ b/target/unicore32/translate.c
@@ -13,7 +13,7 @@
 #include "cpu.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
-#include "tcg-op.h"
+#include "tcg/tcg-op.h"
 #include "qemu/log.h"
 #include "exec/cpu_ldst.h"
 #include "exec/translator.h"
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index a99f5296e2..f5510ef043 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -33,7 +33,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "disas/disas.h"
-#include "tcg-op.h"
+#include "tcg/tcg-op.h"
 #include "qemu/log.h"
 #include "qemu/qemu-print.h"
 #include "exec/cpu_ldst.h"
diff --git a/tcg/optimize.c b/tcg/optimize.c
index f7f4e873c9..53aa8e5329 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -24,7 +24,7 @@
  */
=20
 #include "qemu/osdep.h"
-#include "tcg-op.h"
+#include "tcg/tcg-op.h"
=20
 #define CASE_OP_32_64(x)                        \
         glue(glue(case INDEX_op_, x), _i32):    \
diff --git a/tcg/tcg-common.c b/tcg/tcg-common.c
index 97305a3efc..7e1992e79e 100644
--- a/tcg/tcg-common.c
+++ b/tcg/tcg-common.c
@@ -32,7 +32,7 @@ uintptr_t tci_tb_ptr;
 TCGOpDef tcg_op_defs[] =3D {
 #define DEF(s, oargs, iargs, cargs, flags) \
          { #s, oargs, iargs, cargs, iargs + oargs + cargs, flags },
-#include "tcg-opc.h"
+#include "tcg/tcg-opc.h"
 #undef DEF
 };
 const size_t tcg_op_defs_max =3D ARRAY_SIZE(tcg_op_defs);
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 5c95ecd51c..41b4a3c661 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -18,11 +18,11 @@
  */
=20
 #include "qemu/osdep.h"
-#include "tcg.h"
-#include "tcg-op.h"
-#include "tcg-op-gvec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
 #include "qemu/main-loop.h"
-#include "tcg-gvec-desc.h"
+#include "tcg/tcg-gvec-desc.h"
=20
 #define MAX_UNROLL  4
=20
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 6714991bf4..b6937e8d64 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -19,9 +19,9 @@
=20
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "tcg.h"
-#include "tcg-op.h"
-#include "tcg-mo.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-mo.h"
=20
 /* Reduce the number of ifdefs below.  This assumes that all uses of
    TCGV_HIGH and TCGV_LOW are properly protected by a conditional that
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c245126f98..7d782002e3 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -25,9 +25,9 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
-#include "tcg.h"
-#include "tcg-op.h"
-#include "tcg-mo.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-mo.h"
 #include "trace-tcg.h"
 #include "trace/mem.h"
 #include "exec/plugin-gen.h"
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 4f616ba38b..dd4b3d7684 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -48,7 +48,7 @@
 #include "hw/boards.h"
 #endif
=20
-#include "tcg-op.h"
+#include "tcg/tcg-op.h"
=20
 #if UINTPTR_MAX =3D=3D UINT32_MAX
 # define ELF_CLASS  ELFCLASS32
diff --git a/tcg/tci.c b/tcg/tci.c
index a6208653e8..46fe9ce63f 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -30,7 +30,7 @@
 #include "qemu-common.h"
 #include "tcg/tcg.h"           /* MAX_OPC_PARAM_IARGS */
 #include "exec/cpu_ldst.h"
-#include "tcg-op.h"
+#include "tcg/tcg-op.h"
=20
 /* Marker for missing code. */
 #define TODO() \
--=20
2.21.0


