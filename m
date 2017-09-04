Received: from eggs.gnu.org ([2001:4830:134:3::10]:34186)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1douib-00048F-T2
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 12:59:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1douiX-0001uh-17
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 12:59:25 -0400
Received: from mout.gmx.net ([212.227.17.20]:65023)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1douiW-0001tW-N9
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 12:59:20 -0400
From: Kamil Rytarowski <n54@gmx.com>
Date: Mon,  4 Sep 2017 18:46:59 +0200
Message-Id: <20170904164659.26915-1-n54@gmx.com>
In-Reply-To: <20170903163130.14288-1-n54@gmx.com>
References: <20170903163130.14288-1-n54@gmx.com>
Subject: [Qemu-devel] [PATCH v2] target/m68k: Switch fpu_rom from
 make_floatx80() to make_floatx80_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: laurent@vivier.eu
Cc: qemu-devel@nongnu.org, f4bug@amsat.org, peter.maydell@linaro.org, Kamil Rytarowski <n54@gmx.com>

GCC 4.7.2 on SunOS reports that the values assigned to array members are not
real constants:

target/m68k/fpu_helper.c:32:5: error: initializer element is not constant
target/m68k/fpu_helper.c:32:5: error: (near initialization for 'fpu_rom[0]')
rules.mak:66: recipe for target 'target/m68k/fpu_helper.o' failed

Convert the array to make_floatx80_init() to fix it.
Replace floatx80_pi-like constants with make_floatx80_init() as they are
defined as make_floatx80().

This fixes build on SmartOS (Joyent).

Signed-off-by: Kamil Rytarowski <n54@gmx.com>
---
 target/m68k/fpu_helper.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index bdfc537c68..8afd319ede 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -29,28 +29,28 @@
  */
 
 static const floatx80 fpu_rom[128] = {
-    [0x00] = floatx80_pi,                                   /* Pi */
-    [0x0b] = make_floatx80(0x3ffd, 0x9a209a84fbcff798ULL),  /* Log10(2) */
-    [0x0c] = make_floatx80(0x4000, 0xadf85458a2bb4a9aULL),  /* e        */
-    [0x0d] = make_floatx80(0x3fff, 0xb8aa3b295c17f0bcULL),  /* Log2(e)  */
-    [0x0e] = make_floatx80(0x3ffd, 0xde5bd8a937287195ULL),  /* Log10(e) */
-    [0x0f] = floatx80_zero,                                 /* Zero     */
-    [0x30] = floatx80_ln2,                                  /* ln(2)    */
-    [0x31] = make_floatx80(0x4000, 0x935d8dddaaa8ac17ULL),  /* ln(10)   */
-    [0x32] = floatx80_one,                                  /* 10^0     */
-    [0x33] = make_floatx80(0x4002, 0xa000000000000000ULL),  /* 10^1     */
-    [0x34] = make_floatx80(0x4005, 0xc800000000000000ULL),  /* 10^2     */
-    [0x35] = make_floatx80(0x400c, 0x9c40000000000000ULL),  /* 10^4     */
-    [0x36] = make_floatx80(0x4019, 0xbebc200000000000ULL),  /* 10^8     */
-    [0x37] = make_floatx80(0x4034, 0x8e1bc9bf04000000ULL),  /* 10^16    */
-    [0x38] = make_floatx80(0x4069, 0x9dc5ada82b70b59eULL),  /* 10^32    */
-    [0x39] = make_floatx80(0x40d3, 0xc2781f49ffcfa6d5ULL),  /* 10^64    */
-    [0x3a] = make_floatx80(0x41a8, 0x93ba47c980e98ce0ULL),  /* 10^128   */
-    [0x3b] = make_floatx80(0x4351, 0xaa7eebfb9df9de8eULL),  /* 10^256   */
-    [0x3c] = make_floatx80(0x46a3, 0xe319a0aea60e91c7ULL),  /* 10^512   */
-    [0x3d] = make_floatx80(0x4d48, 0xc976758681750c17ULL),  /* 10^1024  */
-    [0x3e] = make_floatx80(0x5a92, 0x9e8b3b5dc53d5de5ULL),  /* 10^2048  */
-    [0x3f] = make_floatx80(0x7525, 0xc46052028a20979bULL),  /* 10^4096  */
+    [0x00] = make_floatx80_init(0x4000, 0x0c90fdaa22168c235LL),  /* Pi       */
+    [0x0b] = make_floatx80_init(0x3ffd, 0x9a209a84fbcff798ULL),  /* Log10(2) */
+    [0x0c] = make_floatx80_init(0x4000, 0xadf85458a2bb4a9aULL),  /* e        */
+    [0x0d] = make_floatx80_init(0x3fff, 0xb8aa3b295c17f0bcULL),  /* Log2(e)  */
+    [0x0e] = make_floatx80_init(0x3ffd, 0xde5bd8a937287195ULL),  /* Log10(e) */
+    [0x0f] = make_floatx80_init(0x0000, 0x00000000000000000LL),  /* Zero     */
+    [0x30] = make_floatx80_init(0x3ffe, 0x0b17217f7d1cf79acLL),  /* ln(2)    */
+    [0x31] = make_floatx80_init(0x4000, 0x935d8dddaaa8ac17ULL),  /* ln(10)   */
+    [0x32] = make_floatx80_init(0x3fff, 0x08000000000000000LL),  /* 10^0     */
+    [0x33] = make_floatx80_init(0x4002, 0xa000000000000000ULL),  /* 10^1     */
+    [0x34] = make_floatx80_init(0x4005, 0xc800000000000000ULL),  /* 10^2     */
+    [0x35] = make_floatx80_init(0x400c, 0x9c40000000000000ULL),  /* 10^4     */
+    [0x36] = make_floatx80_init(0x4019, 0xbebc200000000000ULL),  /* 10^8     */
+    [0x37] = make_floatx80_init(0x4034, 0x8e1bc9bf04000000ULL),  /* 10^16    */
+    [0x38] = make_floatx80_init(0x4069, 0x9dc5ada82b70b59eULL),  /* 10^32    */
+    [0x39] = make_floatx80_init(0x40d3, 0xc2781f49ffcfa6d5ULL),  /* 10^64    */
+    [0x3a] = make_floatx80_init(0x41a8, 0x93ba47c980e98ce0ULL),  /* 10^128   */
+    [0x3b] = make_floatx80_init(0x4351, 0xaa7eebfb9df9de8eULL),  /* 10^256   */
+    [0x3c] = make_floatx80_init(0x46a3, 0xe319a0aea60e91c7ULL),  /* 10^512   */
+    [0x3d] = make_floatx80_init(0x4d48, 0xc976758681750c17ULL),  /* 10^1024  */
+    [0x3e] = make_floatx80_init(0x5a92, 0x9e8b3b5dc53d5de5ULL),  /* 10^2048  */
+    [0x3f] = make_floatx80_init(0x7525, 0xc46052028a20979bULL),  /* 10^4096  */
 };
 
 int32_t HELPER(reds32)(CPUM68KState *env, FPReg *val)
-- 
2.14.1
