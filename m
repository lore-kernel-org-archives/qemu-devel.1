Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07937C2BB86
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 11:29:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A69D1206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 11:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eOp25Bb8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A69D1206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOJlK-00009I-OH
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 07:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOJkX-0007y0-5y
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 07:29:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOJkR-0001tr-Bg
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 07:29:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43471
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOJkR-0001tZ-6C
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 07:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586863738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pTf3QLeHpcOYduWphAoO+w3SmCQQn4b0NnjWRberdf8=;
 b=eOp25Bb8/WFEKiX7w4y09lig79Rhv0dzuJQDyx6nanTidjsrpRoy0qzKiaugeHtiZdklKE
 qjGE10VZYw7YXKsYa19Nqmy0/6X9nZBRuPjpWkyUFmJDXvucKUZ2eSUjHXtgd19Pon7xSM
 iySjR7+UlrsbWwTz6rSvFjHPRIbnDOc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-wXVCif0lOaSLhCR4BCMaFA-1; Tue, 14 Apr 2020 07:28:54 -0400
X-MC-Unique: wXVCif0lOaSLhCR4BCMaFA-1
Received: by mail-wr1-f71.google.com with SMTP id r17so8505343wrg.19
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 04:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xrbx/B/FEUz26DzCeTVKZHfO5lvgbHiFX/NQv+ojUUc=;
 b=ltzXGVQzAkY1CFwtMFr8rdxPtchrjU8pkAW8u6c+6GtI4HD/Bv8/3v0uSImLnvQmTH
 kYEfisChuVdjOeBXpFmH+nbx9NBXgk/Ad1mBlTV5FGW8bRAsM+mLX5q26E3HtfICYtmi
 eSUP5peEcm3MRIqyWMJriziuf+XsgvHCMdCJkkcU06ynY018NC4m4qFBzJmNsyNmA2QP
 2j+Fa8w6kfOs0+18rwTGNiwHSUB74nFN7vDFk54alCgIKtFfJXPIu1iJUWyLAObX1hkw
 pGKY1mleB109KTMasuaJR4Is+Hxy8zYKT5iCIkTm5cVK5t4CdDIWeVCU102atpEGK/x8
 77Zw==
X-Gm-Message-State: AGi0PuaS1y5+o++ZobUPyRuyfGz7wNfyZHNl5yoJfzww5CUJz97HupXK
 gtxlOyOdD9IrkV72qegmTx42FyklZmmPznMNt82XqHIrGAv+zfDUfV7EEBzaWvmkK4BWIqBJm7F
 qJWhmlXr3E5XHBXw=
X-Received: by 2002:a5d:68ca:: with SMTP id p10mr23755735wrw.154.1586863732632; 
 Tue, 14 Apr 2020 04:28:52 -0700 (PDT)
X-Google-Smtp-Source: APiQypL9QhtdmUXSHIWmi+tntQYqYBG9Fl1IhttsCnANllvsftiyxUFv9XDf8TGynVJDUmAi5IfZkA==
X-Received: by 2002:a5d:68ca:: with SMTP id p10mr23755637wrw.154.1586863731469; 
 Tue, 14 Apr 2020 04:28:51 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id c18sm15680962wrb.97.2020.04.14.04.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 04:28:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1] gdbstub: Rename GByteArray variable 'mem_buf' as
 'array'
Date: Tue, 14 Apr 2020 13:28:48 +0200
Message-Id: <20200414112849.21787-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

GByteArray type has should not be treated as a u8[] buffer.
The GLib Byte Arrays API should be used instead.
Rename the 'mem_buf' variable as 'array' to make it more
obvious in the code.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Based-on: <20200414111846.27495-1-philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/exec/gdbstub.h      | 34 +++++++-------
 include/hw/core/cpu.h       |  2 +-
 target/alpha/cpu.h          |  2 +-
 target/arm/cpu.h            |  4 +-
 target/cris/cpu.h           |  4 +-
 target/hppa/cpu.h           |  2 +-
 target/i386/cpu.h           |  2 +-
 target/lm32/cpu.h           |  2 +-
 target/m68k/cpu.h           |  2 +-
 target/microblaze/cpu.h     |  2 +-
 target/mips/internal.h      |  2 +-
 target/openrisc/cpu.h       |  2 +-
 target/ppc/cpu.h            |  4 +-
 target/riscv/cpu.h          |  2 +-
 target/rx/cpu.h             |  2 +-
 target/s390x/internal.h     |  2 +-
 target/sh4/cpu.h            |  2 +-
 target/sparc/cpu.h          |  2 +-
 target/xtensa/cpu.h         |  2 +-
 gdbstub.c                   |  6 +--
 hw/core/cpu.c               |  3 +-
 target/alpha/gdbstub.c      |  4 +-
 target/arm/gdbstub.c        | 10 ++--
 target/arm/gdbstub64.c      | 10 ++--
 target/cris/gdbstub.c       | 34 +++++++-------
 target/hppa/gdbstub.c       |  6 +--
 target/i386/gdbstub.c       | 92 ++++++++++++++++++-------------------
 target/lm32/gdbstub.c       | 18 ++++----
 target/m68k/gdbstub.c       | 10 ++--
 target/m68k/helper.c        | 24 +++++-----
 target/microblaze/gdbstub.c |  6 +--
 target/mips/gdbstub.c       | 30 ++++++------
 target/nios2/cpu.c          |  8 ++--
 target/openrisc/gdbstub.c   | 10 ++--
 target/riscv/gdbstub.c      |  6 +--
 target/rx/gdbstub.c         | 22 ++++-----
 target/s390x/gdbstub.c      | 28 +++++------
 target/sh4/gdbstub.c        | 38 +++++++--------
 target/sparc/gdbstub.c      | 46 +++++++++----------
 target/xtensa/gdbstub.c     | 20 ++++----
 40 files changed, 254 insertions(+), 253 deletions(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 52a4a936c6..29150d1344 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -80,47 +80,47 @@ void gdb_register_coprocessor(CPUState *cpu,
  * append to the array.
  */
=20
-static inline int gdb_get_reg8(GByteArray *buf, uint8_t val)
+static inline int gdb_get_reg8(GByteArray *array, uint8_t val)
 {
-    g_byte_array_append(buf, &val, 1);
+    g_byte_array_append(array, &val, 1);
     return 1;
 }
=20
-static inline int gdb_get_reg16(GByteArray *buf, uint16_t val)
+static inline int gdb_get_reg16(GByteArray *array, uint16_t val)
 {
     uint16_t to_word =3D tswap16(val);
-    g_byte_array_append(buf, (uint8_t *) &to_word, 2);
+    g_byte_array_append(array, (uint8_t *) &to_word, 2);
     return 2;
 }
=20
-static inline int gdb_get_reg32(GByteArray *buf, uint32_t val)
+static inline int gdb_get_reg32(GByteArray *array, uint32_t val)
 {
     uint32_t to_long =3D tswap32(val);
-    g_byte_array_append(buf, (uint8_t *) &to_long, 4);
+    g_byte_array_append(array, (uint8_t *) &to_long, 4);
     return 4;
 }
=20
-static inline int gdb_get_reg64(GByteArray *buf, uint64_t val)
+static inline int gdb_get_reg64(GByteArray *array, uint64_t val)
 {
     uint64_t to_quad =3D tswap64(val);
-    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
+    g_byte_array_append(array, (uint8_t *) &to_quad, 8);
     return 8;
 }
=20
-static inline int gdb_get_reg128(GByteArray *buf, uint64_t val_hi,
+static inline int gdb_get_reg128(GByteArray *array, uint64_t val_hi,
                                  uint64_t val_lo)
 {
     uint64_t to_quad;
 #ifdef TARGET_WORDS_BIGENDIAN
     to_quad =3D tswap64(val_hi);
-    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
+    g_byte_array_append(array, (uint8_t *) &to_quad, 8);
     to_quad =3D tswap64(val_lo);
-    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
+    g_byte_array_append(array, (uint8_t *) &to_quad, 8);
 #else
     to_quad =3D tswap64(val_lo);
-    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
+    g_byte_array_append(array, (uint8_t *) &to_quad, 8);
     to_quad =3D tswap64(val_hi);
-    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
+    g_byte_array_append(array, (uint8_t *) &to_quad, 8);
 #endif
     return 16;
 }
@@ -154,16 +154,16 @@ static inline int gdb_get_zeroes(GByteArray *array, s=
ize_t len)
  * element for additional processing. Some front-ends do additional
  * dynamic swapping of the elements based on CPU state.
  */
-static inline uint8_t * gdb_get_reg_ptr(GByteArray *buf, int len)
+static inline uint8_t *gdb_get_reg_ptr(GByteArray *array, int len)
 {
-    return buf->data + buf->len - len;
+    return array->data + array->len - len;
 }
=20
 #if TARGET_LONG_BITS =3D=3D 64
-#define gdb_get_regl(buf, val) gdb_get_reg64(buf, val)
+#define gdb_get_regl(array, val) gdb_get_reg64(array, val)
 #define ldtul_p(addr) ldq_p(addr)
 #else
-#define gdb_get_regl(buf, val) gdb_get_reg32(buf, val)
+#define gdb_get_regl(array, val) gdb_get_reg32(array, val)
 #define ldtul_p(addr) ldl_p(addr)
 #endif
=20
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 5bf94d28cf..31434d3b1f 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -193,7 +193,7 @@ typedef struct CPUClass {
     hwaddr (*get_phys_page_attrs_debug)(CPUState *cpu, vaddr addr,
                                         MemTxAttrs *attrs);
     int (*asidx_from_attrs)(CPUState *cpu, MemTxAttrs attrs);
-    int (*gdb_read_register)(CPUState *cpu, GByteArray *buf, int reg);
+    int (*gdb_read_register)(CPUState *cpu, GByteArray *array, int reg);
     int (*gdb_write_register)(CPUState *cpu, uint8_t *buf, int reg);
     bool (*debug_check_watchpoint)(CPUState *cpu, CPUWatchpoint *wp);
     void (*debug_excp_handler)(CPUState *cpu);
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index be29bdd530..94853d0bee 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -280,7 +280,7 @@ void alpha_cpu_do_interrupt(CPUState *cpu);
 bool alpha_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 hwaddr alpha_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-int alpha_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+int alpha_cpu_gdb_read_register(CPUState *cpu, GByteArray *array, int reg)=
;
 int alpha_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void alpha_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
                                    MMUAccessType access_type,
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8b9f2961ba..cbd3a262f3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -975,7 +975,7 @@ bool arm_cpu_exec_interrupt(CPUState *cpu, int int_req)=
;
 hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
                                          MemTxAttrs *attrs);
=20
-int arm_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+int arm_cpu_gdb_read_register(CPUState *cpu, GByteArray *array, int reg);
 int arm_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
=20
 /*
@@ -997,7 +997,7 @@ int arm_cpu_write_elf32_note(WriteCoreDumpFunction f, C=
PUState *cs,
                              int cpuid, void *opaque);
=20
 #ifdef TARGET_AARCH64
-int aarch64_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)=
;
+int aarch64_cpu_gdb_read_register(CPUState *cpu, GByteArray *array, int re=
g);
 int aarch64_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq);
 void aarch64_sve_change_el(CPUARMState *env, int old_el,
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index 8f08d7628b..474a06f929 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -195,8 +195,8 @@ void cris_cpu_dump_state(CPUState *cs, FILE *f, int fla=
gs);
=20
 hwaddr cris_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
=20
-int crisv10_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)=
;
-int cris_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+int crisv10_cpu_gdb_read_register(CPUState *cpu, GByteArray *array, int re=
g);
+int cris_cpu_gdb_read_register(CPUState *cpu, GByteArray *array, int reg);
 int cris_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
=20
 /* you can call this signal handler from your SIGBUS and SIGSEGV
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 801a4fb1ba..d584ad49b4 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -321,7 +321,7 @@ void cpu_hppa_change_prot_id(CPUHPPAState *env);
=20
 int cpu_hppa_signal_handler(int host_signum, void *pinfo, void *puc);
 hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr);
-int hppa_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+int hppa_cpu_gdb_read_register(CPUState *cpu, GByteArray *array, int reg);
 int hppa_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void hppa_cpu_do_interrupt(CPUState *cpu);
 bool hppa_cpu_exec_interrupt(CPUState *cpu, int int_req);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e818fc712a..9ad798c87e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1770,7 +1770,7 @@ void x86_cpu_dump_state(CPUState *cs, FILE *f, int fl=
ags);
 hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
                                          MemTxAttrs *attrs);
=20
-int x86_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+int x86_cpu_gdb_read_register(CPUState *cpu, GByteArray *array, int reg);
 int x86_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
=20
 void x86_cpu_exec_enter(CPUState *cpu);
diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index 01d408eb55..b64e7fdc44 100644
--- a/target/lm32/cpu.h
+++ b/target/lm32/cpu.h
@@ -202,7 +202,7 @@ void lm32_cpu_do_interrupt(CPUState *cpu);
 bool lm32_cpu_exec_interrupt(CPUState *cs, int int_req);
 void lm32_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr lm32_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-int lm32_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+int lm32_cpu_gdb_read_register(CPUState *cpu, GByteArray *array, int reg);
 int lm32_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
=20
 typedef enum {
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 521ac67cdd..705d26746d 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -168,7 +168,7 @@ void m68k_cpu_do_interrupt(CPUState *cpu);
 bool m68k_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void m68k_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr m68k_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-int m68k_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+int m68k_cpu_gdb_read_register(CPUState *cpu, GByteArray *array, int reg);
 int m68k_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
=20
 void m68k_tcg_init(void);
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 1a700a880c..77d6c859ae 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -313,7 +313,7 @@ void mb_cpu_do_interrupt(CPUState *cs);
 bool mb_cpu_exec_interrupt(CPUState *cs, int int_req);
 void mb_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr mb_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-int mb_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+int mb_cpu_gdb_read_register(CPUState *cpu, GByteArray *array, int reg);
 int mb_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
=20
 void mb_tcg_init(void);
diff --git a/target/mips/internal.h b/target/mips/internal.h
index 1bf274b3ef..27a9e811f7 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -82,7 +82,7 @@ void mips_cpu_do_interrupt(CPUState *cpu);
 bool mips_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void mips_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr mips_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-int mips_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+int mips_cpu_gdb_read_register(CPUState *cpu, GByteArray *array, int reg);
 int mips_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void mips_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
                                   MMUAccessType access_type,
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index f37a52e153..1d2d5214c2 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -320,7 +320,7 @@ void openrisc_cpu_do_interrupt(CPUState *cpu);
 bool openrisc_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void openrisc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-int openrisc_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg=
);
+int openrisc_cpu_gdb_read_register(CPUState *cpu, GByteArray *array, int r=
eg);
 int openrisc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void openrisc_translate_init(void);
 bool openrisc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 88d9449555..049400f8d7 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1207,8 +1207,8 @@ bool ppc_cpu_exec_interrupt(CPUState *cpu, int int_re=
q);
 void ppc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 void ppc_cpu_dump_statistics(CPUState *cpu, int flags);
 hwaddr ppc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-int ppc_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
-int ppc_cpu_gdb_read_register_apple(CPUState *cpu, GByteArray *buf, int re=
g);
+int ppc_cpu_gdb_read_register(CPUState *cpu, GByteArray *array, int reg);
+int ppc_cpu_gdb_read_register_apple(CPUState *cpu, GByteArray *array, int =
reg);
 int ppc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 int ppc_cpu_gdb_write_register_apple(CPUState *cpu, uint8_t *buf, int reg)=
;
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7d21addbab..806cb3b044 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -293,7 +293,7 @@ extern const char * const riscv_excp_names[];
 extern const char * const riscv_intr_names[];
=20
 void riscv_cpu_do_interrupt(CPUState *cpu);
-int riscv_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+int riscv_cpu_gdb_read_register(CPUState *cpu, GByteArray *array, int reg)=
;
 int riscv_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
 bool riscv_cpu_fp_enabled(CPURISCVState *env);
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index d1fb1ef3ca..994ab0c6fd 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -128,7 +128,7 @@ const char *rx_crname(uint8_t cr);
 void rx_cpu_do_interrupt(CPUState *cpu);
 bool rx_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void rx_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
-int rx_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+int rx_cpu_gdb_read_register(CPUState *cpu, GByteArray *array, int reg);
 int rx_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 hwaddr rx_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
=20
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index 8c95c734db..04fcb7da74 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -292,7 +292,7 @@ uint16_t float128_dcmask(CPUS390XState *env, float128 f=
1);
=20
=20
 /* gdbstub.c */
-int s390_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+int s390_cpu_gdb_read_register(CPUState *cpu, GByteArray *array, int reg);
 int s390_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void s390_cpu_gdb_init(CPUState *cs);
=20
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index dbe58c7888..6901c88d7e 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -208,7 +208,7 @@ void superh_cpu_do_interrupt(CPUState *cpu);
 bool superh_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void superh_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr superh_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-int superh_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+int superh_cpu_gdb_read_register(CPUState *cpu, GByteArray *array, int reg=
);
 int superh_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void superh_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
                                     MMUAccessType access_type,
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index b9369398f2..bb9126b546 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -571,7 +571,7 @@ extern const VMStateDescription vmstate_sparc_cpu;
 void sparc_cpu_do_interrupt(CPUState *cpu);
 void sparc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr sparc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-int sparc_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+int sparc_cpu_gdb_read_register(CPUState *cpu, GByteArray *array, int reg)=
;
 int sparc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void QEMU_NORETURN sparc_cpu_do_unaligned_access(CPUState *cpu, vaddr addr=
,
                                                  MMUAccessType access_type=
,
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 7a46dccbe1..8a851e0b00 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -572,7 +572,7 @@ void xtensa_cpu_dump_state(CPUState *cpu, FILE *f, int =
flags);
 hwaddr xtensa_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void xtensa_count_regs(const XtensaConfig *config,
                        unsigned *n_regs, unsigned *n_core_regs);
-int xtensa_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+int xtensa_cpu_gdb_read_register(CPUState *cpu, GByteArray *array, int reg=
);
 int xtensa_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void xtensa_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
                                     MMUAccessType access_type,
diff --git a/gdbstub.c b/gdbstub.c
index 171e150950..bc24b613b2 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -906,19 +906,19 @@ static const char *get_feature_xml(const char *p, con=
st char **newp,
     return name ? xml_builtin[i][1] : NULL;
 }
=20
-static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
+static int gdb_read_register(CPUState *cpu, GByteArray *array, int reg)
 {
     CPUClass *cc =3D CPU_GET_CLASS(cpu);
     CPUArchState *env =3D cpu->env_ptr;
     GDBRegisterState *r;
=20
     if (reg < cc->gdb_num_core_regs) {
-        return cc->gdb_read_register(cpu, buf, reg);
+        return cc->gdb_read_register(cpu, array, reg);
     }
=20
     for (r =3D cpu->gdb_regs; r; r =3D r->next) {
         if (r->base_reg <=3D reg && reg < r->base_reg + r->num_regs) {
-            return r->get_reg(env, buf, reg - r->base_reg);
+            return r->get_reg(env, array, reg - r->base_reg);
         }
     }
     return 0;
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index 786a1bec8a..0f2bd00176 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -177,7 +177,8 @@ static int cpu_common_write_elf64_note(WriteCoreDumpFun=
ction f,
 }
=20
=20
-static int cpu_common_gdb_read_register(CPUState *cpu, GByteArray *buf, in=
t reg)
+static int cpu_common_gdb_read_register(CPUState *cpu, GByteArray *array,
+                                        int reg)
 {
     return 0;
 }
diff --git a/target/alpha/gdbstub.c b/target/alpha/gdbstub.c
index 0cd76ddaa9..415f422b03 100644
--- a/target/alpha/gdbstub.c
+++ b/target/alpha/gdbstub.c
@@ -21,7 +21,7 @@
 #include "cpu.h"
 #include "exec/gdbstub.h"
=20
-int alpha_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
+int alpha_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int n)
 {
     AlphaCPU *cpu =3D ALPHA_CPU(cs);
     CPUAlphaState *env =3D &cpu->env;
@@ -54,7 +54,7 @@ int alpha_cpu_gdb_read_register(CPUState *cs, GByteArray =
*mem_buf, int n)
     default:
         return 0;
     }
-    return gdb_get_regl(mem_buf, val);
+    return gdb_get_regl(array, val);
 }
=20
 int alpha_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 063551df23..66a8af8a19 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -33,21 +33,21 @@ typedef struct RegisterSysregXmlParam {
    We hack round this by giving the FPA regs zero size when talking to a
    newer gdb.  */
=20
-int arm_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
+int arm_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int n)
 {
     ARMCPU *cpu =3D ARM_CPU(cs);
     CPUARMState *env =3D &cpu->env;
=20
     if (n < 16) {
         /* Core integer register.  */
-        return gdb_get_reg32(mem_buf, env->regs[n]);
+        return gdb_get_reg32(array, env->regs[n]);
     }
     if (n < 24) {
         /* FPA registers.  */
         if (gdb_has_xml) {
             return 0;
         }
-        return gdb_get_zeroes(mem_buf, 12);
+        return gdb_get_zeroes(array, 12);
     }
     switch (n) {
     case 24:
@@ -55,10 +55,10 @@ int arm_cpu_gdb_read_register(CPUState *cs, GByteArray =
*mem_buf, int n)
         if (gdb_has_xml) {
             return 0;
         }
-        return gdb_get_reg32(mem_buf, 0);
+        return gdb_get_reg32(array, 0);
     case 25:
         /* CPSR */
-        return gdb_get_reg32(mem_buf, cpsr_read(env));
+        return gdb_get_reg32(array, cpsr_read(env));
     }
     /* Unknown register.  */
     return 0;
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 35d0b80c2d..16860a0522 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -20,22 +20,22 @@
 #include "cpu.h"
 #include "exec/gdbstub.h"
=20
-int aarch64_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n=
)
+int aarch64_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int n)
 {
     ARMCPU *cpu =3D ARM_CPU(cs);
     CPUARMState *env =3D &cpu->env;
=20
     if (n < 31) {
         /* Core integer register.  */
-        return gdb_get_reg64(mem_buf, env->xregs[n]);
+        return gdb_get_reg64(array, env->xregs[n]);
     }
     switch (n) {
     case 31:
-        return gdb_get_reg64(mem_buf, env->xregs[31]);
+        return gdb_get_reg64(array, env->xregs[31]);
     case 32:
-        return gdb_get_reg64(mem_buf, env->pc);
+        return gdb_get_reg64(array, env->pc);
     case 33:
-        return gdb_get_reg32(mem_buf, pstate_read(env));
+        return gdb_get_reg32(array, pstate_read(env));
     }
     /* Unknown register.  */
     return 0;
diff --git a/target/cris/gdbstub.c b/target/cris/gdbstub.c
index b01b2aa081..dd7f754935 100644
--- a/target/cris/gdbstub.c
+++ b/target/cris/gdbstub.c
@@ -21,31 +21,31 @@
 #include "cpu.h"
 #include "exec/gdbstub.h"
=20
-int crisv10_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n=
)
+int crisv10_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int n)
 {
     CRISCPU *cpu =3D CRIS_CPU(cs);
     CPUCRISState *env =3D &cpu->env;
=20
     if (n < 15) {
-        return gdb_get_reg32(mem_buf, env->regs[n]);
+        return gdb_get_reg32(array, env->regs[n]);
     }
=20
     if (n =3D=3D 15) {
-        return gdb_get_reg32(mem_buf, env->pc);
+        return gdb_get_reg32(array, env->pc);
     }
=20
     if (n < 32) {
         switch (n) {
         case 16:
-            return gdb_get_reg8(mem_buf, env->pregs[n - 16]);
+            return gdb_get_reg8(array, env->pregs[n - 16]);
         case 17:
-            return gdb_get_reg8(mem_buf, env->pregs[n - 16]);
+            return gdb_get_reg8(array, env->pregs[n - 16]);
         case 20:
         case 21:
-            return gdb_get_reg16(mem_buf, env->pregs[n - 16]);
+            return gdb_get_reg16(array, env->pregs[n - 16]);
         default:
             if (n >=3D 23) {
-                return gdb_get_reg32(mem_buf, env->pregs[n - 16]);
+                return gdb_get_reg32(array, env->pregs[n - 16]);
             }
             break;
         }
@@ -53,7 +53,7 @@ int crisv10_cpu_gdb_read_register(CPUState *cs, GByteArra=
y *mem_buf, int n)
     return 0;
 }
=20
-int cris_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
+int cris_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int n)
 {
     CRISCPU *cpu =3D CRIS_CPU(cs);
     CPUCRISState *env =3D &cpu->env;
@@ -61,28 +61,28 @@ int cris_cpu_gdb_read_register(CPUState *cs, GByteArray=
 *mem_buf, int n)
=20
     srs =3D env->pregs[PR_SRS];
     if (n < 16) {
-        return gdb_get_reg32(mem_buf, env->regs[n]);
+        return gdb_get_reg32(array, env->regs[n]);
     }
=20
     if (n >=3D 21 && n < 32) {
-        return gdb_get_reg32(mem_buf, env->pregs[n - 16]);
+        return gdb_get_reg32(array, env->pregs[n - 16]);
     }
     if (n >=3D 33 && n < 49) {
-        return gdb_get_reg32(mem_buf, env->sregs[srs][n - 33]);
+        return gdb_get_reg32(array, env->sregs[srs][n - 33]);
     }
     switch (n) {
     case 16:
-        return gdb_get_reg8(mem_buf, env->pregs[0]);
+        return gdb_get_reg8(array, env->pregs[0]);
     case 17:
-        return gdb_get_reg8(mem_buf, env->pregs[1]);
+        return gdb_get_reg8(array, env->pregs[1]);
     case 18:
-        return gdb_get_reg32(mem_buf, env->pregs[2]);
+        return gdb_get_reg32(array, env->pregs[2]);
     case 19:
-        return gdb_get_reg8(mem_buf, srs);
+        return gdb_get_reg8(array, srs);
     case 20:
-        return gdb_get_reg16(mem_buf, env->pregs[4]);
+        return gdb_get_reg16(array, env->pregs[4]);
     case 32:
-        return gdb_get_reg32(mem_buf, env->pc);
+        return gdb_get_reg32(array, env->pc);
     }
=20
     return 0;
diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
index a6428a2893..d0618f5175 100644
--- a/target/hppa/gdbstub.c
+++ b/target/hppa/gdbstub.c
@@ -21,7 +21,7 @@
 #include "cpu.h"
 #include "exec/gdbstub.h"
=20
-int hppa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
+int hppa_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int n)
 {
     HPPACPU *cpu =3D HPPA_CPU(cs);
     CPUHPPAState *env =3D &cpu->env;
@@ -140,9 +140,9 @@ int hppa_cpu_gdb_read_register(CPUState *cs, GByteArray=
 *mem_buf, int n)
     }
=20
     if (TARGET_REGISTER_BITS =3D=3D 64) {
-        return gdb_get_reg64(mem_buf, val);
+        return gdb_get_reg64(array, val);
     } else {
-        return gdb_get_reg32(mem_buf, val);
+        return gdb_get_reg32(array, val);
     }
 }
=20
diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index f3d23b614e..40f1b03a36 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -79,7 +79,7 @@ static const int gpr_map32[8] =3D { 0, 1, 2, 3, 4, 5, 6, =
7 };
 #endif
=20
=20
-int x86_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
+int x86_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int n)
 {
     X86CPU *cpu =3D X86_CPU(cs);
     CPUX86State *env =3D &cpu->env;
@@ -93,25 +93,25 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArray =
*mem_buf, int n)
     if (n < CPU_NB_REGS) {
         if (TARGET_LONG_BITS =3D=3D 64) {
             if (env->hflags & HF_CS64_MASK) {
-                return gdb_get_reg64(mem_buf, env->regs[gpr_map[n]]);
+                return gdb_get_reg64(array, env->regs[gpr_map[n]]);
             } else if (n < CPU_NB_REGS32) {
-                return gdb_get_reg64(mem_buf,
+                return gdb_get_reg64(array,
                                      env->regs[gpr_map[n]] & 0xffffffffUL)=
;
             } else {
-                return gdb_get_regl(mem_buf, 0);
+                return gdb_get_regl(array, 0);
             }
         } else {
-            return gdb_get_reg32(mem_buf, env->regs[gpr_map32[n]]);
+            return gdb_get_reg32(array, env->regs[gpr_map32[n]]);
         }
     } else if (n >=3D IDX_FP_REGS && n < IDX_FP_REGS + 8) {
         floatx80 *fp =3D (floatx80 *) &env->fpregs[n - IDX_FP_REGS];
-        int len =3D gdb_get_reg64(mem_buf, cpu_to_le64(fp->low));
-        len +=3D gdb_get_reg16(mem_buf + len, cpu_to_le16(fp->high));
+        int len =3D gdb_get_reg64(array, cpu_to_le64(fp->low));
+        len +=3D gdb_get_reg16(array + len, cpu_to_le16(fp->high));
         return len;
     } else if (n >=3D IDX_XMM_REGS && n < IDX_XMM_REGS + CPU_NB_REGS) {
         n -=3D IDX_XMM_REGS;
         if (n < CPU_NB_REGS32 || TARGET_LONG_BITS =3D=3D 64) {
-            return gdb_get_reg128(mem_buf,
+            return gdb_get_reg128(array,
                                   env->xmm_regs[n].ZMM_Q(0),
                                   env->xmm_regs[n].ZMM_Q(1));
         }
@@ -120,95 +120,95 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArra=
y *mem_buf, int n)
         case IDX_IP_REG:
             if (TARGET_LONG_BITS =3D=3D 64) {
                 if (env->hflags & HF_CS64_MASK) {
-                    return gdb_get_reg64(mem_buf, env->eip);
+                    return gdb_get_reg64(array, env->eip);
                 } else {
-                    return gdb_get_reg64(mem_buf, env->eip & 0xffffffffUL)=
;
+                    return gdb_get_reg64(array, env->eip & 0xffffffffUL);
                 }
             } else {
-                return gdb_get_reg32(mem_buf, env->eip);
+                return gdb_get_reg32(array, env->eip);
             }
         case IDX_FLAGS_REG:
-            return gdb_get_reg32(mem_buf, env->eflags);
+            return gdb_get_reg32(array, env->eflags);
=20
         case IDX_SEG_REGS:
-            return gdb_get_reg32(mem_buf, env->segs[R_CS].selector);
+            return gdb_get_reg32(array, env->segs[R_CS].selector);
         case IDX_SEG_REGS + 1:
-            return gdb_get_reg32(mem_buf, env->segs[R_SS].selector);
+            return gdb_get_reg32(array, env->segs[R_SS].selector);
         case IDX_SEG_REGS + 2:
-            return gdb_get_reg32(mem_buf, env->segs[R_DS].selector);
+            return gdb_get_reg32(array, env->segs[R_DS].selector);
         case IDX_SEG_REGS + 3:
-            return gdb_get_reg32(mem_buf, env->segs[R_ES].selector);
+            return gdb_get_reg32(array, env->segs[R_ES].selector);
         case IDX_SEG_REGS + 4:
-            return gdb_get_reg32(mem_buf, env->segs[R_FS].selector);
+            return gdb_get_reg32(array, env->segs[R_FS].selector);
         case IDX_SEG_REGS + 5:
-            return gdb_get_reg32(mem_buf, env->segs[R_GS].selector);
+            return gdb_get_reg32(array, env->segs[R_GS].selector);
=20
         case IDX_SEG_REGS + 6:
             if ((env->hflags & HF_CS64_MASK) || GDB_FORCE_64) {
-                return gdb_get_reg64(mem_buf, env->segs[R_FS].base);
+                return gdb_get_reg64(array, env->segs[R_FS].base);
             }
-            return gdb_get_reg32(mem_buf, env->segs[R_FS].base);
+            return gdb_get_reg32(array, env->segs[R_FS].base);
=20
         case IDX_SEG_REGS + 7:
             if ((env->hflags & HF_CS64_MASK) || GDB_FORCE_64) {
-                return gdb_get_reg64(mem_buf, env->segs[R_GS].base);
+                return gdb_get_reg64(array, env->segs[R_GS].base);
             }
-            return gdb_get_reg32(mem_buf, env->segs[R_GS].base);
+            return gdb_get_reg32(array, env->segs[R_GS].base);
=20
         case IDX_SEG_REGS + 8:
 #ifdef TARGET_X86_64
             if ((env->hflags & HF_CS64_MASK) || GDB_FORCE_64) {
-                return gdb_get_reg64(mem_buf, env->kernelgsbase);
+                return gdb_get_reg64(array, env->kernelgsbase);
             }
-            return gdb_get_reg32(mem_buf, env->kernelgsbase);
+            return gdb_get_reg32(array, env->kernelgsbase);
 #else
-            return gdb_get_reg32(mem_buf, 0);
+            return gdb_get_reg32(array, 0);
 #endif
=20
         case IDX_FP_REGS + 8:
-            return gdb_get_reg32(mem_buf, env->fpuc);
+            return gdb_get_reg32(array, env->fpuc);
         case IDX_FP_REGS + 9:
-            return gdb_get_reg32(mem_buf, (env->fpus & ~0x3800) |
+            return gdb_get_reg32(array, (env->fpus & ~0x3800) |
                                           (env->fpstt & 0x7) << 11);
         case IDX_FP_REGS + 10:
-            return gdb_get_reg32(mem_buf, 0); /* ftag */
+            return gdb_get_reg32(array, 0); /* ftag */
         case IDX_FP_REGS + 11:
-            return gdb_get_reg32(mem_buf, 0); /* fiseg */
+            return gdb_get_reg32(array, 0); /* fiseg */
         case IDX_FP_REGS + 12:
-            return gdb_get_reg32(mem_buf, 0); /* fioff */
+            return gdb_get_reg32(array, 0); /* fioff */
         case IDX_FP_REGS + 13:
-            return gdb_get_reg32(mem_buf, 0); /* foseg */
+            return gdb_get_reg32(array, 0); /* foseg */
         case IDX_FP_REGS + 14:
-            return gdb_get_reg32(mem_buf, 0); /* fooff */
+            return gdb_get_reg32(array, 0); /* fooff */
         case IDX_FP_REGS + 15:
-            return gdb_get_reg32(mem_buf, 0); /* fop */
+            return gdb_get_reg32(array, 0); /* fop */
=20
         case IDX_MXCSR_REG:
-            return gdb_get_reg32(mem_buf, env->mxcsr);
+            return gdb_get_reg32(array, env->mxcsr);
=20
         case IDX_CTL_CR0_REG:
             if ((env->hflags & HF_CS64_MASK) || GDB_FORCE_64) {
-                return gdb_get_reg64(mem_buf, env->cr[0]);
+                return gdb_get_reg64(array, env->cr[0]);
             }
-            return gdb_get_reg32(mem_buf, env->cr[0]);
+            return gdb_get_reg32(array, env->cr[0]);
=20
         case IDX_CTL_CR2_REG:
             if ((env->hflags & HF_CS64_MASK) || GDB_FORCE_64) {
-                return gdb_get_reg64(mem_buf, env->cr[2]);
+                return gdb_get_reg64(array, env->cr[2]);
             }
-            return gdb_get_reg32(mem_buf, env->cr[2]);
+            return gdb_get_reg32(array, env->cr[2]);
=20
         case IDX_CTL_CR3_REG:
             if ((env->hflags & HF_CS64_MASK) || GDB_FORCE_64) {
-                return gdb_get_reg64(mem_buf, env->cr[3]);
+                return gdb_get_reg64(array, env->cr[3]);
             }
-            return gdb_get_reg32(mem_buf, env->cr[3]);
+            return gdb_get_reg32(array, env->cr[3]);
=20
         case IDX_CTL_CR4_REG:
             if ((env->hflags & HF_CS64_MASK) || GDB_FORCE_64) {
-                return gdb_get_reg64(mem_buf, env->cr[4]);
+                return gdb_get_reg64(array, env->cr[4]);
             }
-            return gdb_get_reg32(mem_buf, env->cr[4]);
+            return gdb_get_reg32(array, env->cr[4]);
=20
         case IDX_CTL_CR8_REG:
 #ifdef CONFIG_SOFTMMU
@@ -217,15 +217,15 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArra=
y *mem_buf, int n)
             tpr =3D 0;
 #endif
             if ((env->hflags & HF_CS64_MASK) || GDB_FORCE_64) {
-                return gdb_get_reg64(mem_buf, tpr);
+                return gdb_get_reg64(array, tpr);
             }
-            return gdb_get_reg32(mem_buf, tpr);
+            return gdb_get_reg32(array, tpr);
=20
         case IDX_CTL_EFER_REG:
             if ((env->hflags & HF_CS64_MASK) || GDB_FORCE_64) {
-                return gdb_get_reg64(mem_buf, env->efer);
+                return gdb_get_reg64(array, env->efer);
             }
-            return gdb_get_reg32(mem_buf, env->efer);
+            return gdb_get_reg32(array, env->efer);
         }
     }
     return 0;
diff --git a/target/lm32/gdbstub.c b/target/lm32/gdbstub.c
index b6fe12e1d6..6198719944 100644
--- a/target/lm32/gdbstub.c
+++ b/target/lm32/gdbstub.c
@@ -22,30 +22,30 @@
 #include "exec/gdbstub.h"
 #include "hw/lm32/lm32_pic.h"
=20
-int lm32_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
+int lm32_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int n)
 {
     LM32CPU *cpu =3D LM32_CPU(cs);
     CPULM32State *env =3D &cpu->env;
=20
     if (n < 32) {
-        return gdb_get_reg32(mem_buf, env->regs[n]);
+        return gdb_get_reg32(array, env->regs[n]);
     } else {
         switch (n) {
         case 32:
-            return gdb_get_reg32(mem_buf, env->pc);
+            return gdb_get_reg32(array, env->pc);
         /* FIXME: put in right exception ID */
         case 33:
-            return gdb_get_reg32(mem_buf, 0);
+            return gdb_get_reg32(array, 0);
         case 34:
-            return gdb_get_reg32(mem_buf, env->eba);
+            return gdb_get_reg32(array, env->eba);
         case 35:
-            return gdb_get_reg32(mem_buf, env->deba);
+            return gdb_get_reg32(array, env->deba);
         case 36:
-            return gdb_get_reg32(mem_buf, env->ie);
+            return gdb_get_reg32(array, env->ie);
         case 37:
-            return gdb_get_reg32(mem_buf, lm32_pic_get_im(env->pic_state))=
;
+            return gdb_get_reg32(array, lm32_pic_get_im(env->pic_state));
         case 38:
-            return gdb_get_reg32(mem_buf, lm32_pic_get_ip(env->pic_state))=
;
+            return gdb_get_reg32(array, lm32_pic_get_ip(env->pic_state));
         }
     }
     return 0;
diff --git a/target/m68k/gdbstub.c b/target/m68k/gdbstub.c
index eb2d030e14..9405dc4b4e 100644
--- a/target/m68k/gdbstub.c
+++ b/target/m68k/gdbstub.c
@@ -21,24 +21,24 @@
 #include "cpu.h"
 #include "exec/gdbstub.h"
=20
-int m68k_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
+int m68k_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int n)
 {
     M68kCPU *cpu =3D M68K_CPU(cs);
     CPUM68KState *env =3D &cpu->env;
=20
     if (n < 8) {
         /* D0-D7 */
-        return gdb_get_reg32(mem_buf, env->dregs[n]);
+        return gdb_get_reg32(array, env->dregs[n]);
     } else if (n < 16) {
         /* A0-A7 */
-        return gdb_get_reg32(mem_buf, env->aregs[n - 8]);
+        return gdb_get_reg32(array, env->aregs[n - 8]);
     } else {
         switch (n) {
         case 16:
             /* SR is made of SR+CCR, CCR is many 1bit flags so uses helper=
 */
-            return gdb_get_reg32(mem_buf, env->sr | cpu_m68k_get_ccr(env))=
;
+            return gdb_get_reg32(array, env->sr | cpu_m68k_get_ccr(env));
         case 17:
-            return gdb_get_reg32(mem_buf, env->pc);
+            return gdb_get_reg32(array, env->pc);
         }
     }
     /*
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 014657c637..968371476a 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -68,19 +68,19 @@ void m68k_cpu_list(void)
     g_slist_free(list);
 }
=20
-static int cf_fpu_gdb_get_reg(CPUM68KState *env, GByteArray *mem_buf, int =
n)
+static int cf_fpu_gdb_get_reg(CPUM68KState *env, GByteArray *array, int n)
 {
     if (n < 8) {
         float_status s;
-        return gdb_get_reg64(mem_buf, floatx80_to_float64(env->fregs[n].d,=
 &s));
+        return gdb_get_reg64(array, floatx80_to_float64(env->fregs[n].d, &=
s));
     }
     switch (n) {
     case 8: /* fpcontrol */
-        return gdb_get_reg32(mem_buf, env->fpcr);
+        return gdb_get_reg32(array, env->fpcr);
     case 9: /* fpstatus */
-        return gdb_get_reg32(mem_buf, env->fpsr);
+        return gdb_get_reg32(array, env->fpsr);
     case 10: /* fpiar, not implemented */
-        return gdb_get_reg32(mem_buf, 0);
+        return gdb_get_reg32(array, 0);
     }
     return 0;
 }
@@ -105,21 +105,21 @@ static int cf_fpu_gdb_set_reg(CPUM68KState *env, uint=
8_t *mem_buf, int n)
     return 0;
 }
=20
-static int m68k_fpu_gdb_get_reg(CPUM68KState *env, GByteArray *mem_buf, in=
t n)
+static int m68k_fpu_gdb_get_reg(CPUM68KState *env, GByteArray *array, int =
n)
 {
     if (n < 8) {
-        int len =3D gdb_get_reg16(mem_buf, env->fregs[n].l.upper);
-        len +=3D gdb_get_reg16(mem_buf + len, 0);
-        len +=3D gdb_get_reg64(mem_buf + len, env->fregs[n].l.lower);
+        int len =3D gdb_get_reg16(array, env->fregs[n].l.upper);
+        len +=3D gdb_get_reg16(array + len, 0);
+        len +=3D gdb_get_reg64(array + len, env->fregs[n].l.lower);
         return len;
     }
     switch (n) {
     case 8: /* fpcontrol */
-        return gdb_get_reg32(mem_buf, env->fpcr);
+        return gdb_get_reg32(array, env->fpcr);
     case 9: /* fpstatus */
-        return gdb_get_reg32(mem_buf, env->fpsr);
+        return gdb_get_reg32(array, env->fpsr);
     case 10: /* fpiar, not implemented */
-        return gdb_get_reg32(mem_buf, 0);
+        return gdb_get_reg32(array, 0);
     }
     return 0;
 }
diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index f41ebf1f33..40d41e12ce 100644
--- a/target/microblaze/gdbstub.c
+++ b/target/microblaze/gdbstub.c
@@ -21,15 +21,15 @@
 #include "cpu.h"
 #include "exec/gdbstub.h"
=20
-int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
+int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int n)
 {
     MicroBlazeCPU *cpu =3D MICROBLAZE_CPU(cs);
     CPUMBState *env =3D &cpu->env;
=20
     if (n < 32) {
-        return gdb_get_reg32(mem_buf, env->regs[n]);
+        return gdb_get_reg32(array, env->regs[n]);
     } else {
-        return gdb_get_reg32(mem_buf, env->sregs[n - 32]);
+        return gdb_get_reg32(array, env->sregs[n - 32]);
     }
     return 0;
 }
diff --git a/target/mips/gdbstub.c b/target/mips/gdbstub.c
index 98f56e660d..0fc957d5cd 100644
--- a/target/mips/gdbstub.c
+++ b/target/mips/gdbstub.c
@@ -22,54 +22,54 @@
 #include "internal.h"
 #include "exec/gdbstub.h"
=20
-int mips_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
+int mips_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int n)
 {
     MIPSCPU *cpu =3D MIPS_CPU(cs);
     CPUMIPSState *env =3D &cpu->env;
=20
     if (n < 32) {
-        return gdb_get_regl(mem_buf, env->active_tc.gpr[n]);
+        return gdb_get_regl(array, env->active_tc.gpr[n]);
     }
     if (env->CP0_Config1 & (1 << CP0C1_FP) && n >=3D 38 && n < 72) {
         switch (n) {
         case 70:
-            return gdb_get_regl(mem_buf, (int32_t)env->active_fpu.fcr31);
+            return gdb_get_regl(array, (int32_t)env->active_fpu.fcr31);
         case 71:
-            return gdb_get_regl(mem_buf, (int32_t)env->active_fpu.fcr0);
+            return gdb_get_regl(array, (int32_t)env->active_fpu.fcr0);
         default:
             if (env->CP0_Status & (1 << CP0St_FR)) {
-                return gdb_get_regl(mem_buf,
+                return gdb_get_regl(array,
                     env->active_fpu.fpr[n - 38].d);
             } else {
-                return gdb_get_regl(mem_buf,
+                return gdb_get_regl(array,
                     env->active_fpu.fpr[n - 38].w[FP_ENDIAN_IDX]);
             }
         }
     }
     switch (n) {
     case 32:
-        return gdb_get_regl(mem_buf, (int32_t)env->CP0_Status);
+        return gdb_get_regl(array, (int32_t)env->CP0_Status);
     case 33:
-        return gdb_get_regl(mem_buf, env->active_tc.LO[0]);
+        return gdb_get_regl(array, env->active_tc.LO[0]);
     case 34:
-        return gdb_get_regl(mem_buf, env->active_tc.HI[0]);
+        return gdb_get_regl(array, env->active_tc.HI[0]);
     case 35:
-        return gdb_get_regl(mem_buf, env->CP0_BadVAddr);
+        return gdb_get_regl(array, env->CP0_BadVAddr);
     case 36:
-        return gdb_get_regl(mem_buf, (int32_t)env->CP0_Cause);
+        return gdb_get_regl(array, (int32_t)env->CP0_Cause);
     case 37:
-        return gdb_get_regl(mem_buf, env->active_tc.PC |
+        return gdb_get_regl(array, env->active_tc.PC |
                                      !!(env->hflags & MIPS_HFLAG_M16));
     case 72:
-        return gdb_get_regl(mem_buf, 0); /* fp */
+        return gdb_get_regl(array, 0); /* fp */
     case 89:
-        return gdb_get_regl(mem_buf, (int32_t)env->CP0_PRid);
+        return gdb_get_regl(array, (int32_t)env->CP0_PRid);
     default:
         if (n > 89) {
             return 0;
         }
         /* 16 embedded regs.  */
-        return gdb_get_regl(mem_buf, 0);
+        return gdb_get_regl(array, 0);
     }
=20
     return 0;
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index 8f7011fcb9..3cf696402f 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -124,7 +124,7 @@ static void nios2_cpu_disas_set_info(CPUState *cpu, dis=
assemble_info *info)
 #endif
 }
=20
-static int nios2_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, =
int n)
+static int nios2_cpu_gdb_read_register(CPUState *cs, GByteArray *array, in=
t n)
 {
     Nios2CPU *cpu =3D NIOS2_CPU(cs);
     CPUClass *cc =3D CPU_GET_CLASS(cs);
@@ -135,11 +135,11 @@ static int nios2_cpu_gdb_read_register(CPUState *cs, =
GByteArray *mem_buf, int n)
     }
=20
     if (n < 32) {          /* GP regs */
-        return gdb_get_reg32(mem_buf, env->regs[n]);
+        return gdb_get_reg32(array, env->regs[n]);
     } else if (n =3D=3D 32) {    /* PC */
-        return gdb_get_reg32(mem_buf, env->regs[R_PC]);
+        return gdb_get_reg32(array, env->regs[R_PC]);
     } else if (n < 49) {     /* Status regs */
-        return gdb_get_reg32(mem_buf, env->regs[n - 1]);
+        return gdb_get_reg32(array, env->regs[n - 1]);
     }
=20
     /* Invalid regs */
diff --git a/target/openrisc/gdbstub.c b/target/openrisc/gdbstub.c
index 095bf76c12..c34d3696ec 100644
--- a/target/openrisc/gdbstub.c
+++ b/target/openrisc/gdbstub.c
@@ -21,23 +21,23 @@
 #include "cpu.h"
 #include "exec/gdbstub.h"
=20
-int openrisc_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int =
n)
+int openrisc_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int n)
 {
     OpenRISCCPU *cpu =3D OPENRISC_CPU(cs);
     CPUOpenRISCState *env =3D &cpu->env;
=20
     if (n < 32) {
-        return gdb_get_reg32(mem_buf, cpu_get_gpr(env, n));
+        return gdb_get_reg32(array, cpu_get_gpr(env, n));
     } else {
         switch (n) {
         case 32:    /* PPC */
-            return gdb_get_reg32(mem_buf, env->ppc);
+            return gdb_get_reg32(array, env->ppc);
=20
         case 33:    /* NPC (equals PC) */
-            return gdb_get_reg32(mem_buf, env->pc);
+            return gdb_get_reg32(array, env->pc);
=20
         case 34:    /* SR */
-            return gdb_get_reg32(mem_buf, cpu_get_sr(env));
+            return gdb_get_reg32(array, cpu_get_sr(env));
=20
         default:
             break;
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index eba12a86f2..8e1d64c1cf 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -270,15 +270,15 @@ static int csr_register_map[] =3D {
     CSR_MHCOUNTEREN,
 };
=20
-int riscv_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
+int riscv_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int n)
 {
     RISCVCPU *cpu =3D RISCV_CPU(cs);
     CPURISCVState *env =3D &cpu->env;
=20
     if (n < 32) {
-        return gdb_get_regl(mem_buf, env->gpr[n]);
+        return gdb_get_regl(array, env->gpr[n]);
     } else if (n =3D=3D 32) {
-        return gdb_get_regl(mem_buf, env->pc);
+        return gdb_get_regl(array, env->pc);
     }
     return 0;
 }
diff --git a/target/rx/gdbstub.c b/target/rx/gdbstub.c
index 9391e8151e..91dee774f6 100644
--- a/target/rx/gdbstub.c
+++ b/target/rx/gdbstub.c
@@ -20,32 +20,32 @@
 #include "cpu.h"
 #include "exec/gdbstub.h"
=20
-int rx_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
+int rx_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int n)
 {
     RXCPU *cpu =3D RXCPU(cs);
     CPURXState *env =3D &cpu->env;
=20
     switch (n) {
     case 0 ... 15:
-        return gdb_get_regl(mem_buf, env->regs[n]);
+        return gdb_get_regl(array, env->regs[n]);
     case 16:
-        return gdb_get_regl(mem_buf, (env->psw_u) ? env->regs[0] : env->us=
p);
+        return gdb_get_regl(array, (env->psw_u) ? env->regs[0] : env->usp)=
;
     case 17:
-        return gdb_get_regl(mem_buf, (!env->psw_u) ? env->regs[0] : env->i=
sp);
+        return gdb_get_regl(array, (!env->psw_u) ? env->regs[0] : env->isp=
);
     case 18:
-        return gdb_get_regl(mem_buf, rx_cpu_pack_psw(env));
+        return gdb_get_regl(array, rx_cpu_pack_psw(env));
     case 19:
-        return gdb_get_regl(mem_buf, env->pc);
+        return gdb_get_regl(array, env->pc);
     case 20:
-        return gdb_get_regl(mem_buf, env->intb);
+        return gdb_get_regl(array, env->intb);
     case 21:
-        return gdb_get_regl(mem_buf, env->bpsw);
+        return gdb_get_regl(array, env->bpsw);
     case 22:
-        return gdb_get_regl(mem_buf, env->bpc);
+        return gdb_get_regl(array, env->bpc);
     case 23:
-        return gdb_get_regl(mem_buf, env->fintv);
+        return gdb_get_regl(array, env->fintv);
     case 24:
-        return gdb_get_regl(mem_buf, env->fpsw);
+        return gdb_get_regl(array, env->fpsw);
     case 25:
         return 0;
     }
diff --git a/target/s390x/gdbstub.c b/target/s390x/gdbstub.c
index d6fce5ff1e..adbe7b5d39 100644
--- a/target/s390x/gdbstub.c
+++ b/target/s390x/gdbstub.c
@@ -27,7 +27,7 @@
 #include "sysemu/hw_accel.h"
 #include "sysemu/tcg.h"
=20
-int s390_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
+int s390_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int n)
 {
     S390CPU *cpu =3D S390_CPU(cs);
     CPUS390XState *env =3D &cpu->env;
@@ -40,13 +40,13 @@ int s390_cpu_gdb_read_register(CPUState *cs, GByteArray=
 *mem_buf, int n)
             cc_op =3D calc_cc(env, env->cc_op, env->cc_src, env->cc_dst,
                             env->cc_vr);
             val =3D deposit64(env->psw.mask, 44, 2, cc_op);
-            return gdb_get_regl(mem_buf, val);
+            return gdb_get_regl(array, val);
         }
-        return gdb_get_regl(mem_buf, env->psw.mask);
+        return gdb_get_regl(array, env->psw.mask);
     case S390_PSWA_REGNUM:
-        return gdb_get_regl(mem_buf, env->psw.addr);
+        return gdb_get_regl(array, env->psw.addr);
     case S390_R0_REGNUM ... S390_R15_REGNUM:
-        return gdb_get_regl(mem_buf, env->regs[n - S390_R0_REGNUM]);
+        return gdb_get_regl(array, env->regs[n - S390_R0_REGNUM]);
     }
     return 0;
 }
@@ -223,25 +223,25 @@ static int cpu_write_c_reg(CPUS390XState *env, uint8_=
t *mem_buf, int n)
 /* total number of registers in s390-virt.xml */
 #define S390_NUM_VIRT_REGS 8
=20
-static int cpu_read_virt_reg(CPUS390XState *env, GByteArray *mem_buf, int =
n)
+static int cpu_read_virt_reg(CPUS390XState *env, GByteArray *array, int n)
 {
     switch (n) {
     case S390_VIRT_CKC_REGNUM:
-        return gdb_get_regl(mem_buf, env->ckc);
+        return gdb_get_regl(array, env->ckc);
     case S390_VIRT_CPUTM_REGNUM:
-        return gdb_get_regl(mem_buf, env->cputm);
+        return gdb_get_regl(array, env->cputm);
     case S390_VIRT_BEA_REGNUM:
-        return gdb_get_regl(mem_buf, env->gbea);
+        return gdb_get_regl(array, env->gbea);
     case S390_VIRT_PREFIX_REGNUM:
-        return gdb_get_regl(mem_buf, env->psa);
+        return gdb_get_regl(array, env->psa);
     case S390_VIRT_PP_REGNUM:
-        return gdb_get_regl(mem_buf, env->pp);
+        return gdb_get_regl(array, env->pp);
     case S390_VIRT_PFT_REGNUM:
-        return gdb_get_regl(mem_buf, env->pfault_token);
+        return gdb_get_regl(array, env->pfault_token);
     case S390_VIRT_PFS_REGNUM:
-        return gdb_get_regl(mem_buf, env->pfault_select);
+        return gdb_get_regl(array, env->pfault_select);
     case S390_VIRT_PFC_REGNUM:
-        return gdb_get_regl(mem_buf, env->pfault_compare);
+        return gdb_get_regl(array, env->pfault_compare);
     default:
         return 0;
     }
diff --git a/target/sh4/gdbstub.c b/target/sh4/gdbstub.c
index da95205889..964b31d065 100644
--- a/target/sh4/gdbstub.c
+++ b/target/sh4/gdbstub.c
@@ -24,7 +24,7 @@
 /* Hint: Use "set architecture sh4" in GDB to see fpu registers */
 /* FIXME: We should use XML for this.  */
=20
-int superh_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
+int superh_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int n)
 {
     SuperHCPU *cpu =3D SUPERH_CPU(cs);
     CPUSH4State *env =3D &cpu->env;
@@ -32,43 +32,43 @@ int superh_cpu_gdb_read_register(CPUState *cs, GByteArr=
ay *mem_buf, int n)
     switch (n) {
     case 0 ... 7:
         if ((env->sr & (1u << SR_MD)) && (env->sr & (1u << SR_RB))) {
-            return gdb_get_regl(mem_buf, env->gregs[n + 16]);
+            return gdb_get_regl(array, env->gregs[n + 16]);
         } else {
-            return gdb_get_regl(mem_buf, env->gregs[n]);
+            return gdb_get_regl(array, env->gregs[n]);
         }
     case 8 ... 15:
-        return gdb_get_regl(mem_buf, env->gregs[n]);
+        return gdb_get_regl(array, env->gregs[n]);
     case 16:
-        return gdb_get_regl(mem_buf, env->pc);
+        return gdb_get_regl(array, env->pc);
     case 17:
-        return gdb_get_regl(mem_buf, env->pr);
+        return gdb_get_regl(array, env->pr);
     case 18:
-        return gdb_get_regl(mem_buf, env->gbr);
+        return gdb_get_regl(array, env->gbr);
     case 19:
-        return gdb_get_regl(mem_buf, env->vbr);
+        return gdb_get_regl(array, env->vbr);
     case 20:
-        return gdb_get_regl(mem_buf, env->mach);
+        return gdb_get_regl(array, env->mach);
     case 21:
-        return gdb_get_regl(mem_buf, env->macl);
+        return gdb_get_regl(array, env->macl);
     case 22:
-        return gdb_get_regl(mem_buf, cpu_read_sr(env));
+        return gdb_get_regl(array, cpu_read_sr(env));
     case 23:
-        return gdb_get_regl(mem_buf, env->fpul);
+        return gdb_get_regl(array, env->fpul);
     case 24:
-        return gdb_get_regl(mem_buf, env->fpscr);
+        return gdb_get_regl(array, env->fpscr);
     case 25 ... 40:
         if (env->fpscr & FPSCR_FR) {
-            return gdb_get_freg32(mem_buf, env->fregs[n - 9]);
+            return gdb_get_freg32(array, env->fregs[n - 9]);
         }
-        return gdb_get_freg32(mem_buf, env->fregs[n - 25]);
+        return gdb_get_freg32(array, env->fregs[n - 25]);
     case 41:
-        return gdb_get_regl(mem_buf, env->ssr);
+        return gdb_get_regl(array, env->ssr);
     case 42:
-        return gdb_get_regl(mem_buf, env->spc);
+        return gdb_get_regl(array, env->spc);
     case 43 ... 50:
-        return gdb_get_regl(mem_buf, env->gregs[n - 43]);
+        return gdb_get_regl(array, env->gregs[n - 43]);
     case 51 ... 58:
-        return gdb_get_regl(mem_buf, env->gregs[n - (51 - 16)]);
+        return gdb_get_regl(array, env->gregs[n - (51 - 16)]);
     }
=20
     return 0;
diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index 78dc8dcc98..6e6dc9f184 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -27,78 +27,78 @@
 #define gdb_get_rega(buf, val) gdb_get_regl(buf, val)
 #endif
=20
-int sparc_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
+int sparc_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int n)
 {
     SPARCCPU *cpu =3D SPARC_CPU(cs);
     CPUSPARCState *env =3D &cpu->env;
=20
     if (n < 8) {
         /* g0..g7 */
-        return gdb_get_rega(mem_buf, env->gregs[n]);
+        return gdb_get_rega(array, env->gregs[n]);
     }
     if (n < 32) {
         /* register window */
-        return gdb_get_rega(mem_buf, env->regwptr[n - 8]);
+        return gdb_get_rega(array, env->regwptr[n - 8]);
     }
 #if defined(TARGET_ABI32) || !defined(TARGET_SPARC64)
     if (n < 64) {
         /* fprs */
         if (n & 1) {
-            return gdb_get_reg32(mem_buf, env->fpr[(n - 32) / 2].l.lower);
+            return gdb_get_reg32(array, env->fpr[(n - 32) / 2].l.lower);
         } else {
-            return gdb_get_reg32(mem_buf, env->fpr[(n - 32) / 2].l.upper);
+            return gdb_get_reg32(array, env->fpr[(n - 32) / 2].l.upper);
         }
     }
     /* Y, PSR, WIM, TBR, PC, NPC, FPSR, CPSR */
     switch (n) {
     case 64:
-        return gdb_get_rega(mem_buf, env->y);
+        return gdb_get_rega(array, env->y);
     case 65:
-        return gdb_get_rega(mem_buf, cpu_get_psr(env));
+        return gdb_get_rega(array, cpu_get_psr(env));
     case 66:
-        return gdb_get_rega(mem_buf, env->wim);
+        return gdb_get_rega(array, env->wim);
     case 67:
-        return gdb_get_rega(mem_buf, env->tbr);
+        return gdb_get_rega(array, env->tbr);
     case 68:
-        return gdb_get_rega(mem_buf, env->pc);
+        return gdb_get_rega(array, env->pc);
     case 69:
-        return gdb_get_rega(mem_buf, env->npc);
+        return gdb_get_rega(array, env->npc);
     case 70:
-        return gdb_get_rega(mem_buf, env->fsr);
+        return gdb_get_rega(array, env->fsr);
     case 71:
-        return gdb_get_rega(mem_buf, 0); /* csr */
+        return gdb_get_rega(array, 0); /* csr */
     default:
-        return gdb_get_rega(mem_buf, 0);
+        return gdb_get_rega(array, 0);
     }
 #else
     if (n < 64) {
         /* f0-f31 */
         if (n & 1) {
-            return gdb_get_reg32(mem_buf, env->fpr[(n - 32) / 2].l.lower);
+            return gdb_get_reg32(array, env->fpr[(n - 32) / 2].l.lower);
         } else {
-            return gdb_get_reg32(mem_buf, env->fpr[(n - 32) / 2].l.upper);
+            return gdb_get_reg32(array, env->fpr[(n - 32) / 2].l.upper);
         }
     }
     if (n < 80) {
         /* f32-f62 (double width, even numbers only) */
-        return gdb_get_reg64(mem_buf, env->fpr[(n - 32) / 2].ll);
+        return gdb_get_reg64(array, env->fpr[(n - 32) / 2].ll);
     }
     switch (n) {
     case 80:
-        return gdb_get_regl(mem_buf, env->pc);
+        return gdb_get_regl(array, env->pc);
     case 81:
-        return gdb_get_regl(mem_buf, env->npc);
+        return gdb_get_regl(array, env->npc);
     case 82:
-        return gdb_get_regl(mem_buf, (cpu_get_ccr(env) << 32) |
+        return gdb_get_regl(array, (cpu_get_ccr(env) << 32) |
                                      ((env->asi & 0xff) << 24) |
                                      ((env->pstate & 0xfff) << 8) |
                                      cpu_get_cwp64(env));
     case 83:
-        return gdb_get_regl(mem_buf, env->fsr);
+        return gdb_get_regl(array, env->fsr);
     case 84:
-        return gdb_get_regl(mem_buf, env->fprs);
+        return gdb_get_regl(array, env->fprs);
     case 85:
-        return gdb_get_regl(mem_buf, env->y);
+        return gdb_get_regl(array, env->y);
     }
 #endif
     return 0;
diff --git a/target/xtensa/gdbstub.c b/target/xtensa/gdbstub.c
index 4d43f1340a..26d8f4ee9b 100644
--- a/target/xtensa/gdbstub.c
+++ b/target/xtensa/gdbstub.c
@@ -63,7 +63,7 @@ void xtensa_count_regs(const XtensaConfig *config,
     }
 }
=20
-int xtensa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
+int xtensa_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int n)
 {
     XtensaCPU *cpu =3D XTENSA_CPU(cs);
     CPUXtensaState *env =3D &cpu->env;
@@ -81,40 +81,40 @@ int xtensa_cpu_gdb_read_register(CPUState *cs, GByteArr=
ay *mem_buf, int n)
=20
     switch (reg->type) {
     case xtRegisterTypeVirtual: /*pc*/
-        return gdb_get_reg32(mem_buf, env->pc);
+        return gdb_get_reg32(array, env->pc);
=20
     case xtRegisterTypeArRegfile: /*ar*/
         xtensa_sync_phys_from_window(env);
-        return gdb_get_reg32(mem_buf, env->phys_regs[(reg->targno & 0xff)
+        return gdb_get_reg32(array, env->phys_regs[(reg->targno & 0xff)
                                                      % env->config->nareg]=
);
=20
     case xtRegisterTypeSpecialReg: /*SR*/
-        return gdb_get_reg32(mem_buf, env->sregs[reg->targno & 0xff]);
+        return gdb_get_reg32(array, env->sregs[reg->targno & 0xff]);
=20
     case xtRegisterTypeUserReg: /*UR*/
-        return gdb_get_reg32(mem_buf, env->uregs[reg->targno & 0xff]);
+        return gdb_get_reg32(array, env->uregs[reg->targno & 0xff]);
=20
     case xtRegisterTypeTieRegfile: /*f*/
         i =3D reg->targno & 0x0f;
         switch (reg->size) {
         case 4:
-            return gdb_get_reg32(mem_buf,
+            return gdb_get_reg32(array,
                                  float32_val(env->fregs[i].f32[FP_F32_LOW]=
));
         case 8:
-            return gdb_get_reg64(mem_buf, float64_val(env->fregs[i].f64));
+            return gdb_get_reg64(array, float64_val(env->fregs[i].f64));
         default:
             qemu_log_mask(LOG_UNIMP, "%s from reg %d of unsupported size %=
d\n",
                           __func__, n, reg->size);
-            return gdb_get_zeroes(mem_buf, reg->size);
+            return gdb_get_zeroes(array, reg->size);
         }
=20
     case xtRegisterTypeWindow: /*a*/
-        return gdb_get_reg32(mem_buf, env->regs[reg->targno & 0x0f]);
+        return gdb_get_reg32(array, env->regs[reg->targno & 0x0f]);
=20
     default:
         qemu_log_mask(LOG_UNIMP, "%s from reg %d of unsupported type %d\n"=
,
                       __func__, n, reg->type);
-        return gdb_get_zeroes(mem_buf, reg->size);
+        return gdb_get_zeroes(array, reg->size);
     }
 }
=20
--=20
2.21.1


