Received: from eggs.gnu.org ([2001:4830:134:3::10]:38806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1ejNjY-0005El-Cw
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:17:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1ejNjX-0005ii-2J
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:17:48 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:54682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1ejNjW-0005hv-P7
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:17:47 -0500
Received: by mail-wm0-x244.google.com with SMTP id i186so2425369wmi.4
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 03:17:46 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed,  7 Feb 2018 11:17:28 +0000
Message-Id: <20180207111729.15737-5-ard.biesheuvel@linaro.org>
In-Reply-To: <20180207111729.15737-1-ard.biesheuvel@linaro.org>
References: <20180207111729.15737-1-ard.biesheuvel@linaro.org>
Subject: [Qemu-devel] [PATCH v6 4/5] target/arm: implement SM4 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>

This implements emulation of the new SM4 instructions that have
been added as an optional extension to the ARMv8 Crypto Extensions
in ARM v8.2.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 target/arm/cpu.h           |  1 +
 target/arm/crypto_helper.c | 91 ++++++++++++++++++++
 target/arm/helper.h        |  3 +
 target/arm/translate-a64.c |  8 ++
 4 files changed, 103 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 18383666e02d..bad13a76d06c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1375,6 +1375,7 @@ enum arm_features {
     ARM_FEATURE_V8_SHA512, /* implements SHA512 part of v8 Crypto Extensions */
     ARM_FEATURE_V8_SHA3, /* implements SHA3 part of v8 Crypto Extensions */
     ARM_FEATURE_V8_SM3, /* implements SM3 part of v8 Crypto Extensions */
+    ARM_FEATURE_V8_SM4, /* implements SM4 part of v8 Crypto Extensions */
 };
 
 static inline int arm_feature(CPUARMState *env, int feature)
diff --git a/target/arm/crypto_helper.c b/target/arm/crypto_helper.c
index 2f6744edb088..cc339ea7e0ca 100644
--- a/target/arm/crypto_helper.c
+++ b/target/arm/crypto_helper.c
@@ -603,3 +603,94 @@ void HELPER(crypto_sm3tt)(void *vd, void *vn, void *vm, uint32_t imm2,
     rd[0] = d.l[0];
     rd[1] = d.l[1];
 }
+
+static uint8_t const sm4_sbox[] = {
+    0xd6, 0x90, 0xe9, 0xfe, 0xcc, 0xe1, 0x3d, 0xb7,
+    0x16, 0xb6, 0x14, 0xc2, 0x28, 0xfb, 0x2c, 0x05,
+    0x2b, 0x67, 0x9a, 0x76, 0x2a, 0xbe, 0x04, 0xc3,
+    0xaa, 0x44, 0x13, 0x26, 0x49, 0x86, 0x06, 0x99,
+    0x9c, 0x42, 0x50, 0xf4, 0x91, 0xef, 0x98, 0x7a,
+    0x33, 0x54, 0x0b, 0x43, 0xed, 0xcf, 0xac, 0x62,
+    0xe4, 0xb3, 0x1c, 0xa9, 0xc9, 0x08, 0xe8, 0x95,
+    0x80, 0xdf, 0x94, 0xfa, 0x75, 0x8f, 0x3f, 0xa6,
+    0x47, 0x07, 0xa7, 0xfc, 0xf3, 0x73, 0x17, 0xba,
+    0x83, 0x59, 0x3c, 0x19, 0xe6, 0x85, 0x4f, 0xa8,
+    0x68, 0x6b, 0x81, 0xb2, 0x71, 0x64, 0xda, 0x8b,
+    0xf8, 0xeb, 0x0f, 0x4b, 0x70, 0x56, 0x9d, 0x35,
+    0x1e, 0x24, 0x0e, 0x5e, 0x63, 0x58, 0xd1, 0xa2,
+    0x25, 0x22, 0x7c, 0x3b, 0x01, 0x21, 0x78, 0x87,
+    0xd4, 0x00, 0x46, 0x57, 0x9f, 0xd3, 0x27, 0x52,
+    0x4c, 0x36, 0x02, 0xe7, 0xa0, 0xc4, 0xc8, 0x9e,
+    0xea, 0xbf, 0x8a, 0xd2, 0x40, 0xc7, 0x38, 0xb5,
+    0xa3, 0xf7, 0xf2, 0xce, 0xf9, 0x61, 0x15, 0xa1,
+    0xe0, 0xae, 0x5d, 0xa4, 0x9b, 0x34, 0x1a, 0x55,
+    0xad, 0x93, 0x32, 0x30, 0xf5, 0x8c, 0xb1, 0xe3,
+    0x1d, 0xf6, 0xe2, 0x2e, 0x82, 0x66, 0xca, 0x60,
+    0xc0, 0x29, 0x23, 0xab, 0x0d, 0x53, 0x4e, 0x6f,
+    0xd5, 0xdb, 0x37, 0x45, 0xde, 0xfd, 0x8e, 0x2f,
+    0x03, 0xff, 0x6a, 0x72, 0x6d, 0x6c, 0x5b, 0x51,
+    0x8d, 0x1b, 0xaf, 0x92, 0xbb, 0xdd, 0xbc, 0x7f,
+    0x11, 0xd9, 0x5c, 0x41, 0x1f, 0x10, 0x5a, 0xd8,
+    0x0a, 0xc1, 0x31, 0x88, 0xa5, 0xcd, 0x7b, 0xbd,
+    0x2d, 0x74, 0xd0, 0x12, 0xb8, 0xe5, 0xb4, 0xb0,
+    0x89, 0x69, 0x97, 0x4a, 0x0c, 0x96, 0x77, 0x7e,
+    0x65, 0xb9, 0xf1, 0x09, 0xc5, 0x6e, 0xc6, 0x84,
+    0x18, 0xf0, 0x7d, 0xec, 0x3a, 0xdc, 0x4d, 0x20,
+    0x79, 0xee, 0x5f, 0x3e, 0xd7, 0xcb, 0x39, 0x48,
+};
+
+void HELPER(crypto_sm4e)(void *vd, void *vn)
+{
+    uint64_t *rd = vd;
+    uint64_t *rn = vn;
+    union CRYPTO_STATE d = { .l = { rd[0], rd[1] } };
+    union CRYPTO_STATE n = { .l = { rn[0], rn[1] } };
+    uint32_t t, i;
+
+    for (i = 0; i < 4; i++) {
+        t = CR_ST_WORD(d, (i + 1) % 4) ^
+            CR_ST_WORD(d, (i + 2) % 4) ^
+            CR_ST_WORD(d, (i + 3) % 4) ^
+            CR_ST_WORD(n, i);
+
+        t = sm4_sbox[t & 0xff] |
+            sm4_sbox[(t >> 8) & 0xff] << 8 |
+            sm4_sbox[(t >> 16) & 0xff] << 16 |
+            sm4_sbox[(t >> 24) & 0xff] << 24;
+
+        CR_ST_WORD(d, i) ^= t ^ rol32(t, 2) ^ rol32(t, 10) ^ rol32(t, 18) ^
+                            rol32(t, 24);
+    }
+
+    rd[0] = d.l[0];
+    rd[1] = d.l[1];
+}
+
+void HELPER(crypto_sm4ekey)(void *vd, void *vn, void* vm)
+{
+    uint64_t *rd = vd;
+    uint64_t *rn = vn;
+    uint64_t *rm = vm;
+    union CRYPTO_STATE d;
+    union CRYPTO_STATE n = { .l = { rn[0], rn[1] } };
+    union CRYPTO_STATE m = { .l = { rm[0], rm[1] } };
+    uint32_t t, i;
+
+    d = n;
+    for (i = 0; i < 4; i++) {
+        t = CR_ST_WORD(d, (i + 1) % 4) ^
+            CR_ST_WORD(d, (i + 2) % 4) ^
+            CR_ST_WORD(d, (i + 3) % 4) ^
+            CR_ST_WORD(m, i);
+
+        t = sm4_sbox[t & 0xff] |
+            sm4_sbox[(t >> 8) & 0xff] << 8 |
+            sm4_sbox[(t >> 16) & 0xff] << 16 |
+            sm4_sbox[(t >> 24) & 0xff] << 24;
+
+        CR_ST_WORD(d, i) ^= t ^ rol32(t, 13) ^ rol32(t, 23);
+    }
+
+    rd[0] = d.l[0];
+    rd[1] = d.l[1];
+}
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 9d9f42cc89a6..6383d7d09e0d 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -543,6 +543,9 @@ DEF_HELPER_FLAGS_5(crypto_sm3tt, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32, i32)
 DEF_HELPER_FLAGS_3(crypto_sm3partw1, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
 DEF_HELPER_FLAGS_3(crypto_sm3partw2, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
 
+DEF_HELPER_FLAGS_2(crypto_sm4e, TCG_CALL_NO_RWG, void, ptr, ptr)
+DEF_HELPER_FLAGS_3(crypto_sm4ekey, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
+
 DEF_HELPER_FLAGS_3(crc32, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 DEF_HELPER_2(dc_zva, void, env, i64)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index afa1e7b5a27f..186f2ebae9f2 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11177,6 +11177,10 @@ static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
             feature = ARM_FEATURE_V8_SM3;
             genfn = gen_helper_crypto_sm3partw2;
             break;
+        case 2: /* SM4EKEY */
+            feature = ARM_FEATURE_V8_SM4;
+            genfn = gen_helper_crypto_sm4ekey;
+            break;
         default:
             unallocated_encoding(s);
             return;
@@ -11250,6 +11254,10 @@ static void disas_crypto_two_reg_sha512(DisasContext *s, uint32_t insn)
         feature = ARM_FEATURE_V8_SHA512;
         genfn = gen_helper_crypto_sha512su0;
         break;
+    case 1: /* SM4E */
+        feature = ARM_FEATURE_V8_SM4;
+        genfn = gen_helper_crypto_sm4e;
+        break;
     default:
         unallocated_encoding(s);
         return;
-- 
2.11.0
