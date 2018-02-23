Received: from eggs.gnu.org ([2001:4830:134:3::10]:48308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epFYK-0003qd-G4
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:46:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epFYH-0008Qp-N7
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:46:28 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:44747)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1epFYH-0008OZ-Eu
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:46:25 -0500
Received: by mail-wr0-x242.google.com with SMTP id v65so14522971wrc.11
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 07:46:25 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 23 Feb 2018 15:46:13 +0000
Message-Id: <20180223154613.2096-9-alex.bennee@linaro.org>
In-Reply-To: <20180223154613.2096-1-alex.bennee@linaro.org>
References: <20180223154613.2096-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 8/8] aarch64.risu: update Floating-point
 data-processing (1 source)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This adds the half-precision encoding and shuffles around the RES
space to indicate this.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 aarch64.risu | 55 +++++++++++++++++++++++++++----------------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/aarch64.risu b/aarch64.risu
index 06a9f3c..5b11e50 100644
--- a/aarch64.risu
+++ b/aarch64.risu
@@ -2678,49 +2678,48 @@ FCSEL_RES2 A64_V 000 11110 1 type:1 1 rm:5 cond:4 11 rn:5 rd:5
 # Floating-point data-processing (1 source)
 # 31 30 29 28 27 26 25 24 |23 22| 21 20        15 14 13 12 11 10 9  5 4  0
 #  M  0  S  1  1  1  1  0 |type |  1    opcode     1  0  0  0  0  Rn   Rd
-
+#
+# v8.2 introduced half-precision variants
+@FPDataProc1Src
 # FMOV (register) opc = 0
-FMOV A64_V 00011110 type:2 1 0000 00 10000 rn:5 rd:5 \
-!constraints { $type < 2; }
-# UnallocatedEncoding: type >= 2
-FMOV_RES A64_V 00011110 1 type:1 1 0000 00 10000 rn:5 rd:5
-
+FMOV       A64_V   00011110 0 type:1 1 0000 00 10000 rn:5 rd:5
+FMOV_RES   A64_V80 00011110 1 type:1 1 0000 00 10000 rn:5 rd:5
+FMOV       A64_V82 00011110   type:2 1 0000 00 10000 rn:5 rd:5
 # FABS (scalar) opc = 1
-FABS A64_V 00011110 type:2 1 0000 01 10000 rn:5 rd:5 \
-!constraints { $type < 2; }
-# UnallocatedEncoding: type >= 2
-FABS_RES A64_V 00011110 1 type:1 1 0000 01 10000 rn:5 rd:5
-
+FABS       A64_V   00011110 0 type:1 1 0000 01 10000 rn:5 rd:5
+FABS_RES   A64_V80 00011110 1 type:1 1 0000 01 10000 rn:5 rd:5
+FABS       A64_V82 00011110   type:2 1 0000 01 10000 rn:5 rd:5
 # FNEG (scalar) opc = 2
-FNEG A64_V 00011110 type:2 1 0000 10 10000 rn:5 rd:5 \
-!constraints { $type < 2; }
-# UnallocatedEncoding: type >= 2
-FNEG_RES A64_V 00011110 1 type:1 1 0000 10 10000 rn:5 rd:5
-
+FNEG       A64_V   00011110 0 type:1 1 0000 10 10000 rn:5 rd:5
+FNEG_RES   A64_V80 00011110 1 type:1 1 0000 10 10000 rn:5 rd:5
+FNEG       A64_V82 00011110   type:2 1 0000 10 10000 rn:5 rd:5
 # FSQRT (scalar) opc = 3
-FSQRT A64_V 00011110 type:2 1 0000 11 10000 rn:5 rd:5 \
-!constraints { $type < 2; }
-# UnallocatedEncoding: type >= 2
-FSQRT_RES A64_V 00011110 1 type:1 1 0000 11 10000 rn:5 rd:5
-
+FSQRT      A64_V   00011110 0 type:1 1 0000 11 10000 rn:5 rd:5
+FSQRT_RES  A64_V80 00011110 1 type:1 1 0000 11 10000 rn:5 rd:5
+FSQRT      A64_V82 00011110   type:2 1 0000 11 10000 rn:5 rd:5
 # FCVT (all forms) - NB: conversion with src = dst is not allowed
-FCVT A64_V 00011110 type:2 1 0001 opc:2 10000 rn:5 rd:5 \
+FCVT       A64_V   00011110   type:2 1 0001 opc:2 10000 rn:5 rd:5 \
 !constraints { $type != 2 && $opc != 2 && $type != $opc; }
+FCVT       A64_V82 00011110   type:2 1 0001 opc:2 10000 rn:5 rd:5 \
+!constraints { $type != $opc; }
 # UnallocatedEncoding: type == 2
-FCVT_RES1 A64_V 00011110 10 1 0001 opc:2 10000 rn:5 rd:5
+FCVT_RES1  A64_V80 00011110       10 1 0001 opc:2 10000 rn:5 rd:5
 # UnallocatedEncoding: opc == 2
-FCVT_RES2 A64_V 00011110 type:2 1 0001 10 10000 rn:5 rd:5
+FCVT_RES2  A64_V80 00011110   type:2 1 0001 10    10000 rn:5 rd:5
 # UnallocatedEncoding: type == opc
-FCVT_RES3 A64_V 00011110 type:2 1 0001 opc:2 10000 rn:5 rd:5 \
+FCVT_RES3  A64_V   00011110   type:2 1 0001 opc:2 10000 rn:5 rd:5 \
 !constraints { $type == $opc; }
 
 # FRINT (scalar), all rounding modes
-FRINT A64_V 00011110 type:2 1 001 mode:3 10000 rn:5 rd:5 \
+FRINT      A64_V   00011110   type:2 1 001 mode:3 10000 rn:5 rd:5 \
 !constraints { $type < 2 && $mode != 5; }
+FRINT      A64_V82 00011110   type:2 1 001 mode:3 10000 rn:5 rd:5 \
+!constraints { $mode != 5; }
 # UnallocatedEncoding: type >= 2
-FRINT_RES1 A64_V 00011110 1 type:1 1 001 mode:3 10000 rn:5 rd:5
+FRINT_RES1 A64_V80 00011110 1 type:1 1 001 mode:3 10000 rn:5 rd:5
 # UnallocatedEncoding: rounding mode == 5
-FRINT_RES2 A64_V 00011110 type:2 1 001 101 10000 rn:5 rd:5
+FRINT_RES2 A64_V   00011110   type:2 1 001    101 10000 rn:5 rd:5
+@
 
 # Floating-point data-processing (2 source)
 # 31 30 29 28 27 26 25 24 23 22 21 20    16 15      12 11 10 9  5 4  0
-- 
2.15.1
