Received: from eggs.gnu.org ([209.51.188.92]:38411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1go3VG-000557-BH
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:46:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1go3VF-0002tK-Aq
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:46:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52904
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1go3VF-0002sy-4L
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:46:53 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0S9hmF0002518
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 04:46:52 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q9x59udte-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 04:46:52 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Mon, 28 Jan 2019 09:46:50 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 28 Jan 2019 10:46:13 +0100
In-Reply-To: <20190128094625.4428-1-clg@kaod.org>
References: <20190128094625.4428-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190128094625.4428-8-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 07/19] target/ppc: Make special ORs match x86
 pause and don't generate on mttcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

There's no point in going out of translation on an SMT OR with
mttcg since the backend won't do anything useful such as pausing,
it's only useful on traditional TCG to give time to other processors.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/translate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index e169c43643a1..7d40a1fbe6bd 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1580,7 +1580,7 @@ static void gen_pause(DisasContext *ctx)
     tcg_temp_free_i32(t0);
=20
     /* Stop translation, this gives other CPUs a chance to run */
-    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
+    gen_exception_nip(ctx, EXCP_INTERRUPT, ctx->base.pc_next);
 }
 #endif /* defined(TARGET_PPC64) */
=20
@@ -1662,7 +1662,9 @@ static void gen_or(DisasContext *ctx)
          * than no-op, e.g., miso(rs=3D26), yield(27), mdoio(29), mdoom(=
30),
          * and all currently undefined.
          */
-        gen_pause(ctx);
+        if (!mttcg_enabled) {
+            gen_pause(ctx);
+        }
 #endif
 #endif
     }
--=20
2.20.1
