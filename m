Received: from eggs.gnu.org ([2001:4830:134:3::10]:50102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWQuF-0006QB-EP
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 13:31:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWQuD-0000oF-87
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 13:31:03 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:36380)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dWQuD-0000no-0C
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 13:31:01 -0400
Received: by mail-pg0-x241.google.com with SMTP id y129so14323290pgy.3
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 10:31:00 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sat, 15 Jul 2017 07:30:44 -1000
Message-Id: <20170715173050.31018-3-rth@twiddle.net>
In-Reply-To: <20170715173050.31018-1-rth@twiddle.net>
References: <20170715173050.31018-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 2/8] target/s390x: Implement CONVERT UNICODE
 insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/helper.h      |   6 +
 target/s390x/mem_helper.c  | 310 +++++++++++++++++++++++++++++++++++++++++++++
 target/s390x/translate.c   |  51 ++++++++
 target/s390x/insn-data.def |  13 ++
 4 files changed, 380 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 23e8d1d..2793cf3 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -107,6 +107,12 @@ DEF_HELPER_2(stfle, i32, env, i64)
 DEF_HELPER_FLAGS_2(lpq, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_4(stpq, TCG_CALL_NO_WG, void, env, i64, i64, i64)
 DEF_HELPER_4(mvcos, i32, env, i64, i64, i64)
+DEF_HELPER_4(cu12, i32, env, i32, i32, i32)
+DEF_HELPER_4(cu14, i32, env, i32, i32, i32)
+DEF_HELPER_4(cu21, i32, env, i32, i32, i32)
+DEF_HELPER_4(cu24, i32, env, i32, i32, i32)
+DEF_HELPER_4(cu41, i32, env, i32, i32, i32)
+DEF_HELPER_4(cu42, i32, env, i32, i32, i32)
 
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 513b402..b9c7391 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -2196,3 +2196,313 @@ uint32_t HELPER(mvcos)(CPUS390XState *env, uint64_t dest, uint64_t src,
 
     return cc;
 }
+
+/* Decode a Unicode character.  A return value < 0 indicates success, storing
+   the UTF-32 result into OCHAR and the input length into OLEN.  A return
+   value >= 0 indicates failure, and the CC value to be returned.  */
+typedef int (*decode_unicode_fn)(CPUS390XState *env, uint64_t addr,
+                                 uint64_t ilen, bool enh_check, uintptr_t ra,
+                                 uint32_t *ochar, uint32_t *olen);
+
+/* Encode a Unicode character.  A return value < 0 indicates success, storing
+   the bytes into ADDR and the output length into OLEN.  A return value >= 0
+   indicates failure, and the CC value to be returned.  */
+typedef int (*encode_unicode_fn)(CPUS390XState *env, uint64_t addr,
+                                 uint64_t ilen, uintptr_t ra, uint32_t c,
+                                 uint32_t *olen);
+
+static int decode_utf8(CPUS390XState *env, uint64_t addr, uint64_t ilen,
+                       bool enh_check, uintptr_t ra,
+                       uint32_t *ochar, uint32_t *olen)
+{
+    uint8_t s0, s1, s2, s3;
+    uint32_t c, l;
+
+    if (ilen < 1) {
+        return 0;
+    }
+    s0 = cpu_ldub_data_ra(env, addr, ra);
+    if (s0 <= 0x7f) {
+        /* one byte character */
+        l = 1;
+        c = s0;
+    } else if (s0 <= (enh_check ? 0xc1 : 0xbf)) {
+        /* invalid character */
+        return 2;
+    } else if (s0 <= 0xdf) {
+        /* two byte character */
+        l = 2;
+        if (ilen < 2) {
+            return 0;
+        }
+        s1 = cpu_ldub_data_ra(env, addr + 1, ra);
+        c = s0 & 0x1f;
+        c = (c << 6) | (s1 & 0x3f);
+        if (enh_check && (s1 & 0xc0) != 0x80) {
+            return 2;
+        }
+    } else if (s0 <= 0xef) {
+        /* three byte character */
+        l = 3;
+        if (ilen < 3) {
+            return 0;
+        }
+        s1 = cpu_ldub_data_ra(env, addr + 1, ra);
+        s2 = cpu_ldub_data_ra(env, addr + 2, ra);
+        c = s0 & 0x0f;
+        c = (c << 6) | (s1 & 0x3f);
+        c = (c << 6) | (s2 & 0x3f);
+        /* Fold the byte-by-byte range descriptions in the PoO into
+           tests against the complete value.  It disallows encodings
+           that could be smaller, and the UTF-16 surrogates.  */
+        if (enh_check
+            && ((s1 & 0xc0) != 0x80
+                || (s2 & 0xc0) != 0x80
+                || c < 0x1000
+                || (c >= 0xd800 && c <= 0xdfff))) {
+            return 2;
+        }
+    } else if (s0 <= (enh_check ? 0xf4 : 0xf7)) {
+        /* four byte character */
+        l = 4;
+        if (ilen < 4) {
+            return 0;
+        }
+        s1 = cpu_ldub_data_ra(env, addr + 1, ra);
+        s2 = cpu_ldub_data_ra(env, addr + 2, ra);
+        s3 = cpu_ldub_data_ra(env, addr + 3, ra);
+        c = s0 & 0x07;
+        c = (c << 6) | (s1 & 0x3f);
+        c = (c << 6) | (s2 & 0x3f);
+        c = (c << 6) | (s3 & 0x3f);
+        /* See above.  */
+        if (enh_check
+            && ((s1 & 0xc0) != 0x80
+                || (s2 & 0xc0) != 0x80
+                || (s3 & 0xc0) != 0x80
+                || c < 0x010000
+                || c > 0x10ffff)) {
+            return 2;
+        }
+    } else {
+        /* invalid character */
+        return 2;
+    }
+
+    *ochar = c;
+    *olen = l;
+    return -1;
+}
+
+static int decode_utf16(CPUS390XState *env, uint64_t addr, uint64_t ilen,
+                        bool enh_check, uintptr_t ra,
+                        uint32_t *ochar, uint32_t *olen)
+{
+    uint16_t s0, s1;
+    uint32_t c, l;
+
+    if (ilen < 2) {
+        return 0;
+    }
+    s0 = cpu_lduw_data_ra(env, addr, ra);
+    if ((s0 & 0xfc00) != 0xd800) {
+        /* one word character */
+        l = 2;
+        c = s0;
+    } else {
+        /* two word character */
+        l = 4;
+        if (ilen < 4) {
+            return 0;
+        }
+        s1 = cpu_lduw_data_ra(env, addr + 2, ra);
+        c = extract32(s0, 6, 4) + 1;
+        c = (c << 6) | (s0 & 0x3f);
+        c = (c << 10) | (s1 & 0x3ff);
+        if (enh_check && (s1 & 0xfc00) != 0xdc00) {
+            /* invalid surrogate character */
+            return 2;
+        }
+    }
+
+    *ochar = c;
+    *olen = l;
+    return -1;
+}
+
+static int decode_utf32(CPUS390XState *env, uint64_t addr, uint64_t ilen,
+                        bool enh_check, uintptr_t ra,
+                        uint32_t *ochar, uint32_t *olen)
+{
+    uint32_t c;
+
+    if (ilen < 4) {
+        return 0;
+    }
+    c = cpu_ldl_data_ra(env, addr, ra);
+    if ((c >= 0xd800 && c <= 0xdbff) || c > 0x10ffff) {
+        /* invalid unicode character */
+        return 2;
+    }
+
+    *ochar = c;
+    *olen = 4;
+    return -1;
+}
+
+static int encode_utf8(CPUS390XState *env, uint64_t addr, uint64_t ilen,
+                       uintptr_t ra, uint32_t c, uint32_t *olen)
+{
+    uint8_t d[4];
+    uint32_t l, i;
+
+    if (c <= 0x7f) {
+        /* one byte character */
+        l = 1;
+        d[0] = c;
+    } else if (c <= 0x7ff) {
+        /* two byte character */
+        l = 2;
+        d[1] = 0x80 | extract32(c, 0, 6);
+        d[0] = 0xc0 | extract32(c, 6, 5);
+    } else if (c <= 0xffff) {
+        /* three byte character */
+        l = 3;
+        d[2] = 0x80 | extract32(c, 0, 6);
+        d[1] = 0x80 | extract32(c, 6, 6);
+        d[0] = 0xe0 | extract32(c, 12, 4);
+    } else {
+        /* four byte character */
+        l = 4;
+        d[3] = 0x80 | extract32(c, 0, 6);
+        d[2] = 0x80 | extract32(c, 6, 6);
+        d[1] = 0x80 | extract32(c, 12, 6);
+        d[0] = 0xf0 | extract32(c, 18, 3);
+    }
+
+    if (ilen < l) {
+        return 1;
+    }
+    for (i = 0; i < l; ++i) {
+        cpu_stb_data_ra(env, addr + i, d[i], ra);
+    }
+
+    *olen = l;
+    return -1;
+}
+
+static int encode_utf16(CPUS390XState *env, uint64_t addr, uint64_t ilen,
+                        uintptr_t ra, uint32_t c, uint32_t *olen)
+{
+    uint16_t d0, d1;
+
+    if (c <= 0xffff) {
+        /* one word character */
+        if (ilen < 2) {
+            return 1;
+        }
+        cpu_stw_data_ra(env, addr, c, ra);
+        *olen = 2;
+    } else {
+        /* two word character */
+        if (ilen < 4) {
+            return 1;
+        }
+        d1 = 0xdc00 | extract32(c, 0, 10);
+        d0 = 0xd800 | extract32(c, 10, 6);
+        d0 = deposit32(d0, 6, 4, extract32(c, 16, 5) - 1);
+        cpu_stw_data_ra(env, addr + 0, d0, ra);
+        cpu_stw_data_ra(env, addr + 2, d1, ra);
+        *olen = 4;
+    }
+
+    return -1;
+}
+
+static int encode_utf32(CPUS390XState *env, uint64_t addr, uint64_t ilen,
+                        uintptr_t ra, uint32_t c, uint32_t *olen)
+{
+    if (ilen < 4) {
+        return 1;
+    }
+    cpu_stl_data_ra(env, addr, c, ra);
+    *olen = 4;
+    return -1;
+}
+
+static inline uint32_t convert_unicode(CPUS390XState *env, uint32_t r1,
+                                       uint32_t r2, uint32_t m3, uintptr_t ra,
+                                       decode_unicode_fn decode,
+                                       encode_unicode_fn encode)
+{
+    uint64_t dst = get_address(env, r1);
+    uint64_t dlen = get_length(env, r1 + 1);
+    uint64_t src = get_address(env, r2);
+    uint64_t slen = get_length(env, r2 + 1);
+    bool enh_check = m3 & 1;
+    int cc, i;
+
+    /* Lest we fail to service interrupts in a timely manner, limit the
+       amount of work we're willing to do.  For now, let's cap at 256.  */
+    for (i = 0; i < 256; ++i) {
+        uint32_t c, ilen, olen;
+
+        cc = decode(env, src, slen, enh_check, ra, &c, &ilen);
+        if (unlikely(cc >= 0)) {
+            break;
+        }
+        cc = encode(env, dst, dlen, ra, c, &olen);
+        if (unlikely(cc >= 0)) {
+            break;
+        }
+
+        src += ilen;
+        slen -= ilen;
+        dst += olen;
+        dlen -= olen;
+        cc = 3;
+    }
+
+    set_address(env, r1, dst);
+    set_length(env, r1 + 1, dlen);
+    set_address(env, r2, src);
+    set_length(env, r2 + 1, slen);
+
+    return cc;
+}
+
+uint32_t HELPER(cu12)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t m3)
+{
+    return convert_unicode(env, r1, r2, m3, GETPC(),
+                           decode_utf8, encode_utf16);
+}
+
+uint32_t HELPER(cu14)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t m3)
+{
+    return convert_unicode(env, r1, r2, m3, GETPC(),
+                           decode_utf8, encode_utf32);
+}
+
+uint32_t HELPER(cu21)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t m3)
+{
+    return convert_unicode(env, r1, r2, m3, GETPC(),
+                           decode_utf16, encode_utf8);
+}
+
+uint32_t HELPER(cu24)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t m3)
+{
+    return convert_unicode(env, r1, r2, m3, GETPC(),
+                           decode_utf16, encode_utf32);
+}
+
+uint32_t HELPER(cu41)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t m3)
+{
+    return convert_unicode(env, r1, r2, m3, GETPC(),
+                           decode_utf32, encode_utf8);
+}
+
+uint32_t HELPER(cu42)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t m3)
+{
+    return convert_unicode(env, r1, r2, m3, GETPC(),
+                           decode_utf32, encode_utf16);
+}
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index e739525..edfdaf40 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2122,6 +2122,56 @@ static ExitStatus op_ct(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_cuXX(DisasContext *s, DisasOps *o)
+{
+    int m3 = get_field(s->fields, m3);
+    int r1 = get_field(s->fields, r1);
+    int r2 = get_field(s->fields, r2);
+    TCGv_i32 tr1, tr2, chk;
+
+    /* R1 and R2 must both be even.  */
+    if ((r1 | r2) & 1) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return EXIT_NORETURN;
+    }
+    if (!s390_has_feat(S390_FEAT_ETF3_ENH)) {
+        m3 = 0;
+    }
+
+    tr1 = tcg_const_i32(r1);
+    tr2 = tcg_const_i32(r2);
+    chk = tcg_const_i32(m3);
+
+    switch (s->insn->data) {
+    case 12:
+        gen_helper_cu12(cc_op, cpu_env, tr1, tr2, chk);
+        break;
+    case 14:
+        gen_helper_cu14(cc_op, cpu_env, tr1, tr2, chk);
+        break;
+    case 21:
+        gen_helper_cu21(cc_op, cpu_env, tr1, tr2, chk);
+        break;
+    case 24:
+        gen_helper_cu24(cc_op, cpu_env, tr1, tr2, chk);
+        break;
+    case 41:
+        gen_helper_cu41(cc_op, cpu_env, tr1, tr2, chk);
+        break;
+    case 42:
+        gen_helper_cu42(cc_op, cpu_env, tr1, tr2, chk);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    tcg_temp_free_i32(tr1);
+    tcg_temp_free_i32(tr2);
+    tcg_temp_free_i32(chk);
+    set_cc_static(s);
+    return NO_EXIT;
+}
+
 #ifndef CONFIG_USER_ONLY
 static ExitStatus op_diag(DisasContext *s, DisasOps *o)
 {
@@ -5477,6 +5527,7 @@ enum DisasInsnEnum {
 #define FAC_EH          S390_FEAT_STFLE_49 /* execution-hint */
 #define FAC_PPA         S390_FEAT_STFLE_49 /* processor-assist */
 #define FAC_LZRB        S390_FEAT_STFLE_53 /* load-and-zero-rightmost-byte */
+#define FAC_ETF3        S390_FEAT_EXTENDED_TRANSLATION_3
 
 static const DisasInsn insn_info[] = {
 #include "insn-data.def"
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 6ac12b8..323a301 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -313,6 +313,19 @@
     C(0xb3a1, CDLGBR,  RRF_e, FPE, 0, r2_o, f1, 0, cdlgb, 0)
     C(0xb3a2, CXLGBR,  RRF_e, FPE, 0, r2_o, x1, 0, cxlgb, 0)
 
+/* CONVERT UTF-8 TO UTF-16 */
+    D(0xb2a7, CU12,    RRF_c, Z,   0, 0, 0, 0, cuXX, 0, 12)
+/* CONVERT UTF-8 TO UTF-32 */
+    D(0xb9b0, CU14,    RRF_c, ETF3, 0, 0, 0, 0, cuXX, 0, 14)
+/* CONVERT UTF-16 to UTF-8 */
+    D(0xb2a6, CU21,    RRF_c, Z,   0, 0, 0, 0, cuXX, 0, 21)
+/* CONVERT UTF-16 to UTF-32 */
+    D(0xb9b1, CU24,    RRF_c, ETF3, 0, 0, 0, 0, cuXX, 0, 24)
+/* CONVERT UTF-32 to UTF-8 */
+    D(0xb9b2, CU41,    RRF_c, ETF3, 0, 0, 0, 0, cuXX, 0, 41)
+/* CONVERT UTF-32 to UTF-16 */
+    D(0xb9b3, CU42,    RRF_c, ETF3, 0, 0, 0, 0, cuXX, 0, 42)
+
 /* DIVIDE */
     C(0x1d00, DR,      RR_a,  Z,   r1_D32, r2_32s, new_P, r1_P32, divs32, 0)
     C(0x5d00, D,       RX_a,  Z,   r1_D32, m2_32s, new_P, r1_P32, divs32, 0)
-- 
2.9.4
