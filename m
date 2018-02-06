Received: from eggs.gnu.org ([2001:4830:134:3::10]:44514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8j3-0005ec-84
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8iv-0008Bk-6u
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41636
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8iu-0008Az-Ut
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:09 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JERMB020846
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:16:08 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fyf6usgf0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:16:04 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:16:03 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:14:24 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20180206191515.25830-4-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 03/54] target/sh4: fix TCG leak during gusa
 sequence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

From: Alex Benn=C3=A9e <alex.bennee@linaro.org>

This fixes bug #1735384 while running java under qemu-sh4. When debug
was enabled it showed a problem with TCG temps. Once fixed I was able
to run java -version normally.

Cc: qemu-stable@nongnu.org
Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Message-Id: <20171206093050.25308-1-alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
(cherry picked from commit 6d56fc6cc372284a4571f09b361a9ccd99318103)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/sh4/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 703020fe87..b4b5c822d0 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -2189,7 +2189,7 @@ static int decode_gusa(DisasContext *ctx, CPUSH4Sta=
te *env, int *pmax_insns)
     }
=20
     /* If op_src is not a valid register, then op_arg was a constant.  *=
/
-    if (op_src < 0) {
+    if (op_src < 0 && !TCGV_IS_UNUSED(op_arg)) {
         tcg_temp_free_i32(op_arg);
     }
=20
--=20
2.11.0
