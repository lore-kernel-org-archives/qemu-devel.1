Received: from eggs.gnu.org ([209.51.188.92]:43217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbb-0002sz-Co
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbY-0007UX-Da
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:47 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:46059)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVbX-0007TV-Sj
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:44 -0500
Received: by mail-wr1-x436.google.com with SMTP id t6so15370567wrr.12
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:58:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.58.41 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:58:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:57:47 +0000
Message-Id: <20190118145805.6852-32-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 31/49] target/arm: Implement pauth_computepac
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

This is the main crypto routine, an implementation of QARMA.
This matches, as much as possible, ARM pseudocode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20190108223129.5570-28-richard.henderson@linaro.org
[PMM: fixed minor checkpatch nits]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/pauth_helper.c | 242 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 241 insertions(+), 1 deletion(-)

diff --git a/target/arm/pauth_helper.c b/target/arm/pauth_helper.c
index bc89dd8c111..d750f96edf0 100644
--- a/target/arm/pauth_helper.c
+++ b/target/arm/pauth_helper.c
@@ -26,10 +26,250 @@
 #include "tcg/tcg-gvec-desc.h"
 
 
+static uint64_t pac_cell_shuffle(uint64_t i)
+{
+    uint64_t o = 0;
+
+    o |= extract64(i, 52, 4);
+    o |= extract64(i, 24, 4) << 4;
+    o |= extract64(i, 44, 4) << 8;
+    o |= extract64(i,  0, 4) << 12;
+
+    o |= extract64(i, 28, 4) << 16;
+    o |= extract64(i, 48, 4) << 20;
+    o |= extract64(i,  4, 4) << 24;
+    o |= extract64(i, 40, 4) << 28;
+
+    o |= extract64(i, 32, 4) << 32;
+    o |= extract64(i, 12, 4) << 36;
+    o |= extract64(i, 56, 4) << 40;
+    o |= extract64(i, 20, 4) << 44;
+
+    o |= extract64(i,  8, 4) << 48;
+    o |= extract64(i, 36, 4) << 52;
+    o |= extract64(i, 16, 4) << 56;
+    o |= extract64(i, 60, 4) << 60;
+
+    return o;
+}
+
+static uint64_t pac_cell_inv_shuffle(uint64_t i)
+{
+    uint64_t o = 0;
+
+    o |= extract64(i, 12, 4);
+    o |= extract64(i, 24, 4) << 4;
+    o |= extract64(i, 48, 4) << 8;
+    o |= extract64(i, 36, 4) << 12;
+
+    o |= extract64(i, 56, 4) << 16;
+    o |= extract64(i, 44, 4) << 20;
+    o |= extract64(i,  4, 4) << 24;
+    o |= extract64(i, 16, 4) << 28;
+
+    o |= i & MAKE_64BIT_MASK(32, 4);
+    o |= extract64(i, 52, 4) << 36;
+    o |= extract64(i, 28, 4) << 40;
+    o |= extract64(i,  8, 4) << 44;
+
+    o |= extract64(i, 20, 4) << 48;
+    o |= extract64(i,  0, 4) << 52;
+    o |= extract64(i, 40, 4) << 56;
+    o |= i & MAKE_64BIT_MASK(60, 4);
+
+    return o;
+}
+
+static uint64_t pac_sub(uint64_t i)
+{
+    static const uint8_t sub[16] = {
+        0xb, 0x6, 0x8, 0xf, 0xc, 0x0, 0x9, 0xe,
+        0x3, 0x7, 0x4, 0x5, 0xd, 0x2, 0x1, 0xa,
+    };
+    uint64_t o = 0;
+    int b;
+
+    for (b = 0; b < 64; b += 16) {
+        o |= (uint64_t)sub[(i >> b) & 0xf] << b;
+    }
+    return o;
+}
+
+static uint64_t pac_inv_sub(uint64_t i)
+{
+    static const uint8_t inv_sub[16] = {
+        0x5, 0xe, 0xd, 0x8, 0xa, 0xb, 0x1, 0x9,
+        0x2, 0x6, 0xf, 0x0, 0x4, 0xc, 0x7, 0x3,
+    };
+    uint64_t o = 0;
+    int b;
+
+    for (b = 0; b < 64; b += 16) {
+        o |= (uint64_t)inv_sub[(i >> b) & 0xf] << b;
+    }
+    return o;
+}
+
+static int rot_cell(int cell, int n)
+{
+    /* 4-bit rotate left by n.  */
+    cell |= cell << 4;
+    return extract32(cell, 4 - n, 4);
+}
+
+static uint64_t pac_mult(uint64_t i)
+{
+    uint64_t o = 0;
+    int b;
+
+    for (b = 0; b < 4 * 4; b += 4) {
+        int i0, i4, i8, ic, t0, t1, t2, t3;
+
+        i0 = extract64(i, b, 4);
+        i4 = extract64(i, b + 4 * 4, 4);
+        i8 = extract64(i, b + 8 * 4, 4);
+        ic = extract64(i, b + 12 * 4, 4);
+
+        t0 = rot_cell(i8, 1) ^ rot_cell(i4, 2) ^ rot_cell(i0, 1);
+        t1 = rot_cell(ic, 1) ^ rot_cell(i4, 1) ^ rot_cell(i0, 2);
+        t2 = rot_cell(ic, 2) ^ rot_cell(i8, 1) ^ rot_cell(i0, 1);
+        t3 = rot_cell(ic, 1) ^ rot_cell(i8, 2) ^ rot_cell(i4, 1);
+
+        o |= (uint64_t)t3 << b;
+        o |= (uint64_t)t2 << (b + 4 * 4);
+        o |= (uint64_t)t1 << (b + 8 * 4);
+        o |= (uint64_t)t0 << (b + 12 * 4);
+    }
+    return o;
+}
+
+static uint64_t tweak_cell_rot(uint64_t cell)
+{
+    return (cell >> 1) | (((cell ^ (cell >> 1)) & 1) << 3);
+}
+
+static uint64_t tweak_shuffle(uint64_t i)
+{
+    uint64_t o = 0;
+
+    o |= extract64(i, 16, 4) << 0;
+    o |= extract64(i, 20, 4) << 4;
+    o |= tweak_cell_rot(extract64(i, 24, 4)) << 8;
+    o |= extract64(i, 28, 4) << 12;
+
+    o |= tweak_cell_rot(extract64(i, 44, 4)) << 16;
+    o |= extract64(i,  8, 4) << 20;
+    o |= extract64(i, 12, 4) << 24;
+    o |= tweak_cell_rot(extract64(i, 32, 4)) << 28;
+
+    o |= extract64(i, 48, 4) << 32;
+    o |= extract64(i, 52, 4) << 36;
+    o |= extract64(i, 56, 4) << 40;
+    o |= tweak_cell_rot(extract64(i, 60, 4)) << 44;
+
+    o |= tweak_cell_rot(extract64(i,  0, 4)) << 48;
+    o |= extract64(i,  4, 4) << 52;
+    o |= tweak_cell_rot(extract64(i, 40, 4)) << 56;
+    o |= tweak_cell_rot(extract64(i, 36, 4)) << 60;
+
+    return o;
+}
+
+static uint64_t tweak_cell_inv_rot(uint64_t cell)
+{
+    return ((cell << 1) & 0xf) | ((cell & 1) ^ (cell >> 3));
+}
+
+static uint64_t tweak_inv_shuffle(uint64_t i)
+{
+    uint64_t o = 0;
+
+    o |= tweak_cell_inv_rot(extract64(i, 48, 4));
+    o |= extract64(i, 52, 4) << 4;
+    o |= extract64(i, 20, 4) << 8;
+    o |= extract64(i, 24, 4) << 12;
+
+    o |= extract64(i,  0, 4) << 16;
+    o |= extract64(i,  4, 4) << 20;
+    o |= tweak_cell_inv_rot(extract64(i,  8, 4)) << 24;
+    o |= extract64(i, 12, 4) << 28;
+
+    o |= tweak_cell_inv_rot(extract64(i, 28, 4)) << 32;
+    o |= tweak_cell_inv_rot(extract64(i, 60, 4)) << 36;
+    o |= tweak_cell_inv_rot(extract64(i, 56, 4)) << 40;
+    o |= tweak_cell_inv_rot(extract64(i, 16, 4)) << 44;
+
+    o |= extract64(i, 32, 4) << 48;
+    o |= extract64(i, 36, 4) << 52;
+    o |= extract64(i, 40, 4) << 56;
+    o |= tweak_cell_inv_rot(extract64(i, 44, 4)) << 60;
+
+    return o;
+}
+
 static uint64_t pauth_computepac(uint64_t data, uint64_t modifier,
                                  ARMPACKey key)
 {
-    g_assert_not_reached(); /* FIXME */
+    static const uint64_t RC[5] = {
+        0x0000000000000000ull,
+        0x13198A2E03707344ull,
+        0xA4093822299F31D0ull,
+        0x082EFA98EC4E6C89ull,
+        0x452821E638D01377ull,
+    };
+    const uint64_t alpha = 0xC0AC29B7C97C50DDull;
+    /*
+     * Note that in the ARM pseudocode, key0 contains bits <127:64>
+     * and key1 contains bits <63:0> of the 128-bit key.
+     */
+    uint64_t key0 = key.hi, key1 = key.lo;
+    uint64_t workingval, runningmod, roundkey, modk0;
+    int i;
+
+    modk0 = (key0 << 63) | ((key0 >> 1) ^ (key0 >> 63));
+    runningmod = modifier;
+    workingval = data ^ key0;
+
+    for (i = 0; i <= 4; ++i) {
+        roundkey = key1 ^ runningmod;
+        workingval ^= roundkey;
+        workingval ^= RC[i];
+        if (i > 0) {
+            workingval = pac_cell_shuffle(workingval);
+            workingval = pac_mult(workingval);
+        }
+        workingval = pac_sub(workingval);
+        runningmod = tweak_shuffle(runningmod);
+    }
+    roundkey = modk0 ^ runningmod;
+    workingval ^= roundkey;
+    workingval = pac_cell_shuffle(workingval);
+    workingval = pac_mult(workingval);
+    workingval = pac_sub(workingval);
+    workingval = pac_cell_shuffle(workingval);
+    workingval = pac_mult(workingval);
+    workingval ^= key1;
+    workingval = pac_cell_inv_shuffle(workingval);
+    workingval = pac_inv_sub(workingval);
+    workingval = pac_mult(workingval);
+    workingval = pac_cell_inv_shuffle(workingval);
+    workingval ^= key0;
+    workingval ^= runningmod;
+    for (i = 0; i <= 4; ++i) {
+        workingval = pac_inv_sub(workingval);
+        if (i < 4) {
+            workingval = pac_mult(workingval);
+            workingval = pac_cell_inv_shuffle(workingval);
+        }
+        runningmod = tweak_inv_shuffle(runningmod);
+        roundkey = key1 ^ runningmod;
+        workingval ^= RC[4 - i];
+        workingval ^= roundkey;
+        workingval ^= alpha;
+    }
+    workingval ^= modk0;
+
+    return workingval;
 }
 
 static uint64_t pauth_addpac(CPUARMState *env, uint64_t ptr, uint64_t modifier,
-- 
2.20.1
