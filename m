Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCAFC4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 10:04:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68BE22133F
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 10:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="IJNM7NRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68BE22133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGKS7-0005hX-Tz
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 06:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK2t-0005Wr-Mq
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:38:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK2p-0005hM-Ov
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:38:41 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:39539)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iGK2p-0005Ew-DF; Fri, 04 Oct 2019 05:38:39 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46l4YL3KJJz9sS3; Fri,  4 Oct 2019 19:37:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570181878;
 bh=ho2fKq4vjUXP49oH6LTbepFtUQxZVS1nRH0xY8op6C0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IJNM7NRmys3v0LAL6qitoLQc/Yts3YyX7KgzU2M1Jab7qtuIP58irvLDzJLBeaMAf
 LoQwj7agHXwKeXW0gSbLpO2zH86qwPCxhTa/lKxfn3LHCvTlWydCKg/p5gYe7rc6fZ
 Rr/Kp3WL8F8jT3NVrRusgLejU3G1R0rrFK5zIbKU=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 27/53] target/ppc: use existing VsrD() macro to eliminate
 HI_IDX and LO_IDX from dfp_helper.c
Date: Fri,  4 Oct 2019 19:37:21 +1000
Message-Id: <20191004093747.31350-28-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191004093747.31350-1-david@gibson.dropbear.id.au>
References: <20191004093747.31350-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: lvivier@redhat.com, aik@ozlabs.ru,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Switch over all accesses to the decimal numbers held in struct PPC_DFP fr=
om
using HI_IDX and LO_IDX to using the VsrD() macro instead. Not only does =
this
allow the compiler to ensure that the various dfp_* functions are being p=
assed
a ppc_vsr_t rather than an arbitrary uint64_t pointer, but also allows th=
e
host endian-specific HI_IDX and LO_IDX to be completely removed from
dfp_helper.c.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190926185801.11176-7-mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/dfp_helper.c | 70 ++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 39 deletions(-)

diff --git a/target/ppc/dfp_helper.c b/target/ppc/dfp_helper.c
index b72084d50a..c2bb458a78 100644
--- a/target/ppc/dfp_helper.c
+++ b/target/ppc/dfp_helper.c
@@ -28,13 +28,6 @@
 #include "libdecnumber/dpd/decimal64.h"
 #include "libdecnumber/dpd/decimal128.h"
=20
-#if defined(HOST_WORDS_BIGENDIAN)
-#define HI_IDX 0
-#define LO_IDX 1
-#else
-#define HI_IDX 1
-#define LO_IDX 0
-#endif
=20
 static void get_dfp64(ppc_vsr_t *dst, ppc_fprp_t *dfp)
 {
@@ -1039,31 +1032,31 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t,=
 ppc_fprp_t *b)              \
 DFP_HELPER_CTFIX(dctfix, 64)
 DFP_HELPER_CTFIX(dctfixq, 128)
=20
-static inline void dfp_set_bcd_digit_64(uint64_t *t, uint8_t digit,
-                                            unsigned n)
+static inline void dfp_set_bcd_digit_64(ppc_vsr_t *t, uint8_t digit,
+                                        unsigned n)
 {
-    *t |=3D ((uint64_t)(digit & 0xF) << (n << 2));
+    t->VsrD(1) |=3D ((uint64_t)(digit & 0xF) << (n << 2));
 }
=20
-static inline void dfp_set_bcd_digit_128(uint64_t *t, uint8_t digit,
-                                             unsigned n)
+static inline void dfp_set_bcd_digit_128(ppc_vsr_t *t, uint8_t digit,
+                                         unsigned n)
 {
-    t[(n & 0x10) ? HI_IDX : LO_IDX] |=3D
+    t->VsrD((n & 0x10) ? 0 : 1) |=3D
         ((uint64_t)(digit & 0xF) << ((n & 15) << 2));
 }
=20
-static inline void dfp_set_sign_64(uint64_t *t, uint8_t sgn)
+static inline void dfp_set_sign_64(ppc_vsr_t *t, uint8_t sgn)
 {
-    *t <<=3D 4;
-    *t |=3D (sgn & 0xF);
+    t->VsrD(1) <<=3D 4;
+    t->VsrD(1) |=3D (sgn & 0xF);
 }
=20
-static inline void dfp_set_sign_128(uint64_t *t, uint8_t sgn)
+static inline void dfp_set_sign_128(ppc_vsr_t *t, uint8_t sgn)
 {
-    t[HI_IDX] <<=3D 4;
-    t[HI_IDX] |=3D (t[LO_IDX] >> 60);
-    t[LO_IDX] <<=3D 4;
-    t[LO_IDX] |=3D (sgn & 0xF);
+    t->VsrD(0) <<=3D 4;
+    t->VsrD(0) |=3D (t->VsrD(1) >> 60);
+    t->VsrD(1) <<=3D 4;
+    t->VsrD(1) |=3D (sgn & 0xF);
 }
=20
 #define DFP_HELPER_DEDPD(op, size)                                      =
  \
@@ -1081,7 +1074,7 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, p=
pc_fprp_t *b,          \
     N =3D dfp.b.digits;                                                 =
    \
                                                                         =
  \
     for (i =3D 0; (i < N) && (i < (size)/4); i++) {                     =
    \
-        dfp_set_bcd_digit_##size(&dfp.vt.u64[0], digits[N - i - 1], i); =
  \
+        dfp_set_bcd_digit_##size(&dfp.vt, digits[N - i - 1], i);        =
  \
     }                                                                   =
  \
                                                                         =
  \
     if (sp & 2) {                                                       =
  \
@@ -1092,7 +1085,7 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, p=
pc_fprp_t *b,          \
         } else {                                                        =
  \
             sgn =3D ((sp & 1) ? 0xF : 0xC);                             =
    \
         }                                                               =
  \
-        dfp_set_sign_##size(&dfp.vt.u64[0], sgn);                       =
  \
+        dfp_set_sign_##size(&dfp.vt, sgn);                              =
  \
     }                                                                   =
  \
                                                                         =
  \
     if (size =3D=3D 64) {                                               =
      \
@@ -1105,14 +1098,14 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t,=
 ppc_fprp_t *b,          \
 DFP_HELPER_DEDPD(ddedpd, 64)
 DFP_HELPER_DEDPD(ddedpdq, 128)
=20
-static inline uint8_t dfp_get_bcd_digit_64(uint64_t *t, unsigned n)
+static inline uint8_t dfp_get_bcd_digit_64(ppc_vsr_t *t, unsigned n)
 {
-    return *t >> ((n << 2) & 63) & 15;
+    return t->VsrD(1) >> ((n << 2) & 63) & 15;
 }
=20
-static inline uint8_t dfp_get_bcd_digit_128(uint64_t *t, unsigned n)
+static inline uint8_t dfp_get_bcd_digit_128(ppc_vsr_t *t, unsigned n)
 {
-    return t[(n & 0x10) ? HI_IDX : LO_IDX] >> ((n << 2) & 63) & 15;
+    return t->VsrD((n & 0x10) ? 0 : 1) >> ((n << 2) & 63) & 15;
 }
=20
 #define DFP_HELPER_ENBCD(op, size)                                      =
     \
@@ -1128,8 +1121,7 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, p=
pc_fprp_t *b,             \
     decNumberZero(&dfp.t);                                              =
     \
                                                                         =
     \
     if (s) {                                                            =
     \
-        uint8_t sgnNibble =3D dfp_get_bcd_digit_##size(&dfp.vb.u64[0],  =
       \
-                                                     offset++);         =
     \
+        uint8_t sgnNibble =3D dfp_get_bcd_digit_##size(&dfp.vb, offset++=
);     \
         switch (sgnNibble) {                                            =
     \
         case 0xD:                                                       =
     \
         case 0xB:                                                       =
     \
@@ -1149,7 +1141,7 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, p=
pc_fprp_t *b,             \
                                                                         =
     \
     while (offset < (size) / 4) {                                       =
     \
         n++;                                                            =
     \
-        digits[(size) / 4 - n] =3D dfp_get_bcd_digit_##size(&dfp.vb.u64[=
0],    \
+        digits[(size) / 4 - n] =3D dfp_get_bcd_digit_##size(&dfp.vb,    =
       \
                                                           offset++);    =
     \
         if (digits[(size) / 4 - n] > 10) {                              =
     \
             dfp_set_FPSCR_flag(&dfp, FP_VX | FP_VXCVI, FPSCR_VE);       =
     \
@@ -1212,16 +1204,16 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t,=
 ppc_fprp_t *b) \
 DFP_HELPER_XEX(dxex, 64)
 DFP_HELPER_XEX(dxexq, 128)
=20
-static void dfp_set_raw_exp_64(uint64_t *t, uint64_t raw)
+static void dfp_set_raw_exp_64(ppc_vsr_t *t, uint64_t raw)
 {
-    *t &=3D 0x8003ffffffffffffULL;
-    *t |=3D (raw << (63 - 13));
+    t->VsrD(1) &=3D 0x8003ffffffffffffULL;
+    t->VsrD(1) |=3D (raw << (63 - 13));
 }
=20
-static void dfp_set_raw_exp_128(uint64_t *t, uint64_t raw)
+static void dfp_set_raw_exp_128(ppc_vsr_t *t, uint64_t raw)
 {
-    t[HI_IDX] &=3D 0x80003fffffffffffULL;
-    t[HI_IDX] |=3D (raw << (63 - 17));
+    t->VsrD(0) &=3D 0x80003fffffffffffULL;
+    t->VsrD(0) |=3D (raw << (63 - 17));
 }
=20
 #define DFP_HELPER_IEX(op, size)                                        =
  \
@@ -1258,11 +1250,11 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t,=
 ppc_fprp_t *a,          \
         dfp.vt.VsrD(0) =3D dfp.vb.VsrD(0);                              =
    \
         dfp.vt.VsrD(1) =3D dfp.vb.VsrD(1);                              =
    \
         if (exp =3D=3D -1) {                                            =
      \
-            dfp_set_raw_exp_##size(&dfp.vt.u64[0], raw_inf);            =
  \
+            dfp_set_raw_exp_##size(&dfp.vt, raw_inf);                   =
  \
         } else if (exp =3D=3D -3) {                                     =
      \
-            dfp_set_raw_exp_##size(&dfp.vt.u64[0], raw_snan);           =
  \
+            dfp_set_raw_exp_##size(&dfp.vt, raw_snan);                  =
  \
         } else {                                                        =
  \
-            dfp_set_raw_exp_##size(&dfp.vt.u64[0], raw_qnan);           =
  \
+            dfp_set_raw_exp_##size(&dfp.vt, raw_qnan);                  =
  \
         }                                                               =
  \
     } else {                                                            =
  \
         dfp.t =3D dfp.b;                                                =
    \
--=20
2.21.0


