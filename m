Received: from eggs.gnu.org ([208.118.235.92]:57695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gdz1e-0006Kx-MN
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:58:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gdz1c-0004hv-5P
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:58:42 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:60647 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gdz1b-00045w-D8
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:58:39 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 31 Dec 2018 15:56:35 +0100
Message-Id: <1546268200-26966-40-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1546268200-26966-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1546268200-26966-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 39/44] disas: nanoMIPS: Reorder declarations
 and definitions of gpr decoders
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Reorder declarations and definitions of gpr decoders by number of
input bits of corresponding encoding type.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 200 ++++++++++++++++++++++++++---------------------=
------
 disas/nanomips.h   |   7 +-
 2 files changed, 104 insertions(+), 103 deletions(-)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index 23556b4..d6632bb 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -292,6 +292,77 @@ uint64 NMD::renumber_registers(uint64 index, uint64 =
*register_list,
=20
=20
 /*
+ * NMD::decode_gpr_gpr4() - decoder for 'gpr4' gpr encoding type
+ *
+ *   Map a 4-bit code to the 5-bit register space according to this patt=
ern:
+ *
+ *                              1                   0
+ *                    5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *                    | | | | | | | | | | | | | | | |
+ *                    | | | | | | | | | | | | | | | |
+ *                    | | | | | | | | | | | =E2=94=94---------------=E2=94=
=90
+ *                    | | | | | | | | | | =E2=94=94---------------=E2=94=
=90 |
+ *                    | | | | | | | | | =E2=94=94---------------=E2=94=90=
 | |
+ *                    | | | | | | | | =E2=94=94---------------=E2=94=90 =
| | |
+ *                    | | | | | | | |         | | | | | | | |
+ *                    | | | | | | | |         | | | | | | | |
+ *    1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *      3                   2                   1                   0
+ *
+ *   Used in handling following instructions:
+ *
+ *     - ADDU[4X4]
+ *     - LW[4X4]
+ *     - MOVEP[REV]
+ *     - MUL[4X4]
+ *     - SW[4X4]
+ */
+uint64 NMD::decode_gpr_gpr4(uint64 d)
+{
+    static uint64 register_list[] =3D {  8,  9, 10, 11,  4,  5,  6,  7,
+                                      16, 17, 18, 19, 20, 21, 22, 23 };
+    return renumber_registers(d, register_list,
+               sizeof(register_list) / sizeof(register_list[0]));
+}
+
+
+/*
+ * NMD::decode_gpr_gpr4_zero() - decoder for 'gpr4.zero' gpr encoding ty=
pe
+ *
+ *   Map a 4-bit code to the 5-bit register space according to this patt=
ern:
+ *
+ *                              1                   0
+ *                    5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *                    | | | | | | | | | | | | | | | |
+ *                    | | | | | | | | | | | | =E2=94=94-----------------=
----=E2=94=90
+ *                    | | | | | | | | | | | =E2=94=94---------------=E2=94=
=90       |
+ *                    | | | | | | | | | | =E2=94=94---------------=E2=94=
=90 |       |
+ *                    | | | | | | | | | =E2=94=94---------------=E2=94=90=
 | |       |
+ *                    | | | | | | | | =E2=94=94---------------=E2=94=90 =
| | |       |
+ *                    | | | | | | | |           | | | | | | |       |
+ *                    | | | | | | | |           | | | | | | |       |
+ *    1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *      3                   2                   1                   0
+ *
+ *   This pattern is the same one used for 'gpr4' gpr encoding type, exc=
ept for
+ * the input value 3, that is mapped to the output value 0 instead of 11=
.
+ *
+ *   Used in handling following instructions:
+ *
+ *     - MOVE.BALC
+ *     - MOVEP
+ *     - SW[4X4]
+ */
+uint64 NMD::decode_gpr_gpr4_zero(uint64 d)
+{
+    static uint64 register_list[] =3D {  8,  9, 10,  0,  4,  5,  6,  7,
+                                      16, 17, 18, 19, 20, 21, 22, 23 };
+    return renumber_registers(d, register_list,
+               sizeof(register_list) / sizeof(register_list[0]));
+}
+
+
+/*
  * NMD::decode_gpr_gpr3() - decoder for 'gpr3' gpr encoding type
  *
  *   Map a 3-bit code to the 5-bit register space according to this patt=
ern:
@@ -390,106 +461,6 @@ uint64 NMD::decode_gpr_gpr3_src_store(uint64 d)
=20
=20
 /*
- * NMD::decode_gpr_gpr1() - decoder for 'gpr1' gpr encoding type
- *
- *   Map a 1-bit code to the 5-bit register space according to this patt=
ern:
- *
- *                                  1 0
- *                                  | |
- *                                  | |
- *                                  | =E2=94=94---------------------=E2=94=
=90
- *                                  =E2=94=94---------------------=E2=94=
=90 |
- *                                                        | |
- *                                                        | |
- *                                                        | |
- *                                                        | |
- *    1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
- *      3                   2                   1                   0
- *
- *   Used in handling following instruction:
- *
- *     - MOVE.BALC
- */
-uint64 NMD::decode_gpr_gpr1(uint64 d)
-{
-    static uint64 register_list[] =3D {  4,  5 };
-    return renumber_registers(d, register_list,
-               sizeof(register_list) / sizeof(register_list[0]));
-}
-
-
-/*
- * NMD::decode_gpr_gpr4_zero() - decoder for 'gpr4.zero' gpr encoding ty=
pe
- *
- *   Map a 4-bit code to the 5-bit register space according to this patt=
ern:
- *
- *                              1                   0
- *                    5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
- *                    | | | | | | | | | | | | | | | |
- *                    | | | | | | | | | | | | =E2=94=94-----------------=
----=E2=94=90
- *                    | | | | | | | | | | | =E2=94=94---------------=E2=94=
=90       |
- *                    | | | | | | | | | | =E2=94=94---------------=E2=94=
=90 |       |
- *                    | | | | | | | | | =E2=94=94---------------=E2=94=90=
 | |       |
- *                    | | | | | | | | =E2=94=94---------------=E2=94=90 =
| | |       |
- *                    | | | | | | | |           | | | | | | |       |
- *                    | | | | | | | |           | | | | | | |       |
- *    1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
- *      3                   2                   1                   0
- *
- *   This pattern is the same one used for 'gpr4' gpr encoding type, exc=
ept for
- * the input value 3, that is mapped to the output value 0 instead of 11=
.
- *
- *   Used in handling following instructions:
- *
- *     - MOVE.BALC
- *     - MOVEP
- *     - SW[4X4]
- */
-uint64 NMD::decode_gpr_gpr4_zero(uint64 d)
-{
-    static uint64 register_list[] =3D {  8,  9, 10,  0,  4,  5,  6,  7,
-                                      16, 17, 18, 19, 20, 21, 22, 23 };
-    return renumber_registers(d, register_list,
-               sizeof(register_list) / sizeof(register_list[0]));
-}
-
-
-/*
- * NMD::decode_gpr_gpr4() - decoder for 'gpr4' gpr encoding type
- *
- *   Map a 4-bit code to the 5-bit register space according to this patt=
ern:
- *
- *                              1                   0
- *                    5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
- *                    | | | | | | | | | | | | | | | |
- *                    | | | | | | | | | | | | | | | |
- *                    | | | | | | | | | | | =E2=94=94---------------=E2=94=
=90
- *                    | | | | | | | | | | =E2=94=94---------------=E2=94=
=90 |
- *                    | | | | | | | | | =E2=94=94---------------=E2=94=90=
 | |
- *                    | | | | | | | | =E2=94=94---------------=E2=94=90 =
| | |
- *                    | | | | | | | |         | | | | | | | |
- *                    | | | | | | | |         | | | | | | | |
- *    1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
- *      3                   2                   1                   0
- *
- *   Used in handling following instructions:
- *
- *     - ADDU[4X4]
- *     - LW[4X4]
- *     - MOVEP[REV]
- *     - MUL[4X4]
- *     - SW[4X4]
- */
-uint64 NMD::decode_gpr_gpr4(uint64 d)
-{
-    static uint64 register_list[] =3D {  8,  9, 10, 11,  4,  5,  6,  7,
-                                      16, 17, 18, 19, 20, 21, 22, 23 };
-    return renumber_registers(d, register_list,
-               sizeof(register_list) / sizeof(register_list[0]));
-}
-
-
-/*
  * NMD::decode_gpr_gpr2_reg1() - decoder for 'gpr2.reg1' gpr encoding ty=
pe
  *
  *   Map a 2-bit code to the 5-bit register space according to this patt=
ern:
@@ -549,6 +520,35 @@ uint64 NMD::decode_gpr_gpr2_reg2(uint64 d)
 }
=20
=20
+/*
+ * NMD::decode_gpr_gpr1() - decoder for 'gpr1' gpr encoding type
+ *
+ *   Map a 1-bit code to the 5-bit register space according to this patt=
ern:
+ *
+ *                                  1 0
+ *                                  | |
+ *                                  | |
+ *                                  | =E2=94=94---------------------=E2=94=
=90
+ *                                  =E2=94=94---------------------=E2=94=
=90 |
+ *                                                        | |
+ *                                                        | |
+ *                                                        | |
+ *                                                        | |
+ *    1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *      3                   2                   1                   0
+ *
+ *   Used in handling following instruction:
+ *
+ *     - MOVE.BALC
+ */
+uint64 NMD::decode_gpr_gpr1(uint64 d)
+{
+    static uint64 register_list[] =3D {  4,  5 };
+    return renumber_registers(d, register_list,
+               sizeof(register_list) / sizeof(register_list[0]));
+}
+
+
 uint64 NMD::copy(uint64 d)
 {
     return d;
diff --git a/disas/nanomips.h b/disas/nanomips.h
index d6a6e3f..6482eda 100644
--- a/disas/nanomips.h
+++ b/disas/nanomips.h
@@ -105,13 +105,14 @@ private:
=20
     uint64 renumber_registers(uint64 index, uint64 *register_list,
                               size_t register_list_size);
+
+    uint64 decode_gpr_gpr4(uint64 d);
+    uint64 decode_gpr_gpr4_zero(uint64 d);
     uint64 decode_gpr_gpr3(uint64 d);
     uint64 decode_gpr_gpr3_src_store(uint64 d);
-    uint64 decode_gpr_gpr1(uint64 d);
-    uint64 decode_gpr_gpr4_zero(uint64 d);
-    uint64 decode_gpr_gpr4(uint64 d);
     uint64 decode_gpr_gpr2_reg1(uint64 d);
     uint64 decode_gpr_gpr2_reg2(uint64 d);
+    uint64 decode_gpr_gpr1(uint64 d);
=20
     uint64 copy(uint64 d);
     int64 copy(int64 d);
--=20
2.7.4
