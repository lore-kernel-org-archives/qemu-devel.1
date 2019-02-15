Received: from eggs.gnu.org ([209.51.188.92]:33492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gugrB-0001sn-R5
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:01:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gugr9-0005e2-N0
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:00:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gugr7-0005Ql-Id
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:00:54 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1FGxrma087464
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 12:00:50 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qp0p2tnec-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 12:00:49 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Fri, 15 Feb 2019 17:00:45 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 15 Feb 2019 18:00:26 +0100
In-Reply-To: <20190215170029.15641-1-clg@kaod.org>
References: <20190215170029.15641-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190215170029.15641-10-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 09/12] target/ppc: Flush the TLB locally when
 the LPIDR is written
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Our TCG TLB only tags whether it's a HV vs a guest access, so it must
be flushed when the LPIDR is changed.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/helper.h             |  1 +
 target/ppc/misc_helper.c        | 15 +++++++++++++++
 target/ppc/translate_init.inc.c |  7 ++++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index c7de04e06896..fe293937c646 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -718,6 +718,7 @@ DEF_HELPER_2(store_ptcr, void, env, tl)
 #endif
 DEF_HELPER_2(store_sdr1, void, env, tl)
 DEF_HELPER_2(store_pidr, void, env, tl)
+DEF_HELPER_2(store_lpidr, void, env, tl)
 DEF_HELPER_FLAGS_2(store_tbl, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_2(store_tbu, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_2(store_atbl, TCG_CALL_NO_RWG, void, env, tl)
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index b88493009609..c65d1ade15c2 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -117,6 +117,21 @@ void helper_store_pidr(CPUPPCState *env, target_ulon=
g val)
     tlb_flush(CPU(cpu));
 }
=20
+void helper_store_lpidr(CPUPPCState *env, target_ulong val)
+{
+    PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
+
+    env->spr[SPR_LPIDR] =3D val;
+
+    /*
+     * We need to flush the TLB on LPID changes as we only tag HV vs
+     * guest in TCG TLB. Also the quadrants means the HV will
+     * potentially access and cache entries for the current LPID as
+     * well.
+     */
+    tlb_flush(CPU(cpu));
+}
+
 void helper_store_hid0_601(CPUPPCState *env, target_ulong val)
 {
     target_ulong hid0;
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
index 59e0b8676236..6f8b459e3b39 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -407,6 +407,11 @@ static void spr_write_pidr(DisasContext *ctx, int sp=
rn, int gprn)
     gen_helper_store_pidr(cpu_env, cpu_gpr[gprn]);
 }
=20
+static void spr_write_lpidr(DisasContext *ctx, int sprn, int gprn)
+{
+    gen_helper_store_lpidr(cpu_env, cpu_gpr[gprn]);
+}
+
 static void spr_read_hior(DisasContext *ctx, int gprn, int sprn)
 {
     tcg_gen_ld_tl(cpu_gpr[gprn], cpu_env, offsetof(CPUPPCState, excp_pre=
fix));
@@ -7876,7 +7881,7 @@ static void gen_spr_book3s_ids(CPUPPCState *env)
     spr_register_hv(env, SPR_LPIDR, "LPIDR",
                  SPR_NOACCESS, SPR_NOACCESS,
                  SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
+                 &spr_read_generic, &spr_write_lpidr,
                  0x00000000);
     spr_register_hv(env, SPR_HFSCR, "HFSCR",
                  SPR_NOACCESS, SPR_NOACCESS,
--=20
2.20.1
