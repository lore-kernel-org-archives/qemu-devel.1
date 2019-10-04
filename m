Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21604C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 12:26:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EABC220867
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 12:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EABC220867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGMfN-0005Zd-1k
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 08:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58545)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iGMIs-0008RJ-5x
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 08:03:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iGMIq-0003Iq-SC
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 08:03:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47900)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1iGMIn-0003DF-6S; Fri, 04 Oct 2019 08:03:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 56CFC2102;
 Fri,  4 Oct 2019 12:03:16 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF34160BE1;
 Fri,  4 Oct 2019 12:03:14 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Subject: [PATCH v2] target/arm/arch_dump: Add SVE notes
Date: Fri,  4 Oct 2019 14:03:13 +0200
Message-Id: <20191004120313.5347-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Fri, 04 Oct 2019 12:03:16 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Dave.Martin@arm.com, eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When dumping a guest with dump-guest-memory also dump the SVE
registers if they are in use.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 include/elf.h          |   2 +
 target/arm/arch_dump.c | 135 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 135 insertions(+), 2 deletions(-)

diff --git a/include/elf.h b/include/elf.h
index 3501e0c8d03a..a7c357af74ca 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -1650,6 +1650,8 @@ typedef struct elf64_shdr {
 #define NT_ARM_HW_BREAK 0x402           /* ARM hardware breakpoint regis=
ters */
 #define NT_ARM_HW_WATCH 0x403           /* ARM hardware watchpoint regis=
ters */
 #define NT_ARM_SYSTEM_CALL      0x404   /* ARM system call number */
+#define NT_ARM_SVE	0x405		/* ARM Scalable Vector Extension
+					   registers */
=20
 /*
  * Physical entry point into the kernel.
diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
index 26a2c098687c..b02e398430b9 100644
--- a/target/arm/arch_dump.c
+++ b/target/arm/arch_dump.c
@@ -62,12 +62,23 @@ struct aarch64_user_vfp_state {
=20
 QEMU_BUILD_BUG_ON(sizeof(struct aarch64_user_vfp_state) !=3D 528);
=20
+/* struct user_sve_header from arch/arm64/include/uapi/asm/ptrace.h */
+struct aarch64_user_sve_header {
+    uint32_t size;
+    uint32_t max_size;
+    uint16_t vl;
+    uint16_t max_vl;
+    uint16_t flags;
+    uint16_t reserved;
+} QEMU_PACKED;
+
 struct aarch64_note {
     Elf64_Nhdr hdr;
     char name[8]; /* align_up(sizeof("CORE"), 4) */
     union {
         struct aarch64_elf_prstatus prstatus;
         struct aarch64_user_vfp_state vfp;
+        struct aarch64_user_sve_header sve;
     };
 } QEMU_PACKED;
=20
@@ -76,6 +87,8 @@ struct aarch64_note {
             (AARCH64_NOTE_HEADER_SIZE + sizeof(struct aarch64_elf_prstat=
us))
 #define AARCH64_PRFPREG_NOTE_SIZE \
             (AARCH64_NOTE_HEADER_SIZE + sizeof(struct aarch64_user_vfp_s=
tate))
+#define AARCH64_SVE_NOTE_SIZE(env) \
+            (AARCH64_NOTE_HEADER_SIZE + sve_size(env))
=20
 static void aarch64_note_init(struct aarch64_note *note, DumpState *s,
                               const char *name, Elf64_Word namesz,
@@ -128,11 +141,113 @@ static int aarch64_write_elf64_prfpreg(WriteCoreDu=
mpFunction f,
     return 0;
 }
=20
+#ifdef TARGET_AARCH64
+static off_t sve_zreg_offset(uint32_t vq, int n)
+{
+    off_t off =3D sizeof(struct aarch64_user_sve_header);
+    return ROUND_UP(off, 16) + vq * 16 * n;
+}
+static off_t sve_preg_offset(uint32_t vq, int n)
+{
+    return sve_zreg_offset(vq, 32) + vq * 16 / 8 * n;
+}
+static off_t sve_fpsr_offset(uint32_t vq)
+{
+    off_t off =3D sve_preg_offset(vq, 17) + offsetof(struct aarch64_note=
, sve);
+    return ROUND_UP(off, 16) - offsetof(struct aarch64_note, sve);
+}
+static off_t sve_fpcr_offset(uint32_t vq)
+{
+    return sve_fpsr_offset(vq) + sizeof(uint32_t);
+}
+static uint32_t sve_current_vq(CPUARMState *env)
+{
+    return sve_zcr_len_for_el(env, arm_current_el(env)) + 1;
+}
+static size_t sve_size_vq(uint32_t vq)
+{
+    off_t off =3D sve_fpcr_offset(vq) + sizeof(uint32_t) +
+                offsetof(struct aarch64_note, sve);
+    return ROUND_UP(off, 16) - offsetof(struct aarch64_note, sve);
+}
+static size_t sve_size(CPUARMState *env)
+{
+    return sve_size_vq(sve_current_vq(env));
+}
+
+static int aarch64_write_elf64_sve(WriteCoreDumpFunction f,
+                                   CPUARMState *env, int cpuid,
+                                   DumpState *s)
+{
+    struct aarch64_note *note;
+    ARMCPU *cpu =3D env_archcpu(env);
+    uint32_t vq =3D sve_current_vq(env);
+    uint32_t fpr;
+    uint8_t *buf;
+    int ret, i;
+
+    note =3D g_malloc0(AARCH64_SVE_NOTE_SIZE(env));
+    buf =3D (uint8_t *)&note->sve;
+
+    aarch64_note_init(note, s, "LINUX", 6, NT_ARM_SVE, sve_size_vq(vq));
+
+    note->sve.size =3D cpu_to_dump32(s, sve_size_vq(vq));
+    note->sve.max_size =3D cpu_to_dump32(s, sve_size_vq(cpu->sve_max_vq)=
);
+    note->sve.vl =3D cpu_to_dump16(s, vq * 16);
+    note->sve.max_vl =3D cpu_to_dump16(s, cpu->sve_max_vq * 16);
+    note->sve.flags =3D cpu_to_dump16(s, 1);
+
+    for (i =3D 0; i < 32; ++i) {
+#ifdef HOST_WORDS_BIGENDIAN
+        uint64_t d[vq * 2];
+        int j;
+
+        for (j =3D 0; j < vq * 2; ++j) {
+            d[j] =3D bswap64(env->vfp.zregs[i].d[j]);
+        }
+#else
+        uint64_t *d =3D &env->vfp.zregs[i].d[0];
+#endif
+        memcpy(&buf[sve_zreg_offset(vq, i)], &d[0], vq * 16);
+    }
+
+    for (i =3D 0; i < 17; ++i) {
+#ifdef HOST_WORDS_BIGENDIAN
+        uint64_t d[DIV_ROUND_UP(vq * 2, 8)];
+        int j;
+
+        for (j =3D 0; j < DIV_ROUND_UP(vq * 2, 8); ++j) {
+            d[j] =3D bswap64(env->vfp.pregs[i].p[j]);
+        }
+#else
+        uint64_t *d =3D &env->vfp.pregs[i].p[0];
+#endif
+        memcpy(&buf[sve_preg_offset(vq, i)], &d[0], vq * 16 / 8);
+    }
+
+    fpr =3D cpu_to_dump32(s, vfp_get_fpsr(env));
+    memcpy(&buf[sve_fpsr_offset(vq)], &fpr, sizeof(uint32_t));
+
+    fpr =3D cpu_to_dump32(s, vfp_get_fpcr(env));
+    memcpy(&buf[sve_fpcr_offset(vq)], &fpr, sizeof(uint32_t));
+
+    ret =3D f(note, AARCH64_SVE_NOTE_SIZE(env), s);
+    g_free(note);
+
+    if (ret < 0) {
+        return -1;
+    }
+
+    return 0;
+}
+#endif
+
 int arm_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
                              int cpuid, void *opaque)
 {
     struct aarch64_note note;
-    CPUARMState *env =3D &ARM_CPU(cs)->env;
+    ARMCPU *cpu =3D ARM_CPU(cs);
+    CPUARMState *env =3D &cpu->env;
     DumpState *s =3D opaque;
     uint64_t pstate, sp;
     int ret, i;
@@ -163,7 +278,18 @@ int arm_cpu_write_elf64_note(WriteCoreDumpFunction f=
, CPUState *cs,
         return -1;
     }
=20
-    return aarch64_write_elf64_prfpreg(f, env, cpuid, s);
+    ret =3D aarch64_write_elf64_prfpreg(f, env, cpuid, s);
+    if (ret) {
+        return ret;
+    }
+
+#ifdef TARGET_AARCH64
+    if (cpu_isar_feature(aa64_sve, cpu)) {
+        ret =3D aarch64_write_elf64_sve(f, env, cpuid, s);
+    }
+#endif
+
+    return ret;
 }
=20
 /* struct pt_regs from arch/arm/include/asm/ptrace.h */
@@ -335,6 +461,11 @@ ssize_t cpu_get_note_size(int class, int machine, in=
t nr_cpus)
     if (class =3D=3D ELFCLASS64) {
         note_size =3D AARCH64_PRSTATUS_NOTE_SIZE;
         note_size +=3D AARCH64_PRFPREG_NOTE_SIZE;
+#ifdef TARGET_AARCH64
+        if (cpu_isar_feature(aa64_sve, cpu)) {
+            note_size +=3D AARCH64_SVE_NOTE_SIZE(env);
+        }
+#endif
     } else {
         note_size =3D ARM_PRSTATUS_NOTE_SIZE;
         if (arm_feature(env, ARM_FEATURE_VFP)) {
--=20
2.20.1


