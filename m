Received: from eggs.gnu.org ([209.51.188.92]:51183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=910900a2a=Alistair.Francis@wdc.com>)
	id 1gjC7Z-0003f4-AT
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 18:58:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=910900a2a=Alistair.Francis@wdc.com>)
	id 1gjC7T-0000Ua-AY
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 18:58:17 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Mon, 14 Jan 2019 23:58:08 +0000
Message-ID: <1fb62bc8ef624c022bcf5553b8e8d9512b328823.1547510220.git.alistair.francis@wdc.com>
References: <cover.1547510220.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1547510220.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 3/8] RISC-V: Implement mstatus.TSR/TW/TVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>

From: Michael Clark <mjc@sifive.com>

This adds the necessary minimum to support S-mode
virtualization for priv ISA >=3D v1.10

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Cc: Matthew Suozzo <msuozzo@google.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Co-authored-by: Matthew Suozzo <msuozzo@google.com>
Co-authored-by: Michael Clark <mjc@sifive.com>
---
 target/riscv/csr.c       | 17 +++++++++++++----
 target/riscv/op_helper.c | 25 +++++++++++++++++++++----
 2 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5714147689..390d3a9a56 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -305,7 +305,8 @@ static int write_mstatus(CPURISCVState *env, int csrno,=
 target_ulong val)
         }
         mask =3D MSTATUS_SIE | MSTATUS_SPIE | MSTATUS_MIE | MSTATUS_MPIE |
             MSTATUS_SPP | MSTATUS_FS | MSTATUS_MPRV | MSTATUS_SUM |
-            MSTATUS_MPP | MSTATUS_MXR;
+            MSTATUS_MPP | MSTATUS_MXR | MSTATUS_TVM | MSTATUS_TSR |
+            MSTATUS_TW;
     }
=20
     /* silenty discard mstatus.mpp writes for unsupported modes */
@@ -642,7 +643,11 @@ static int read_satp(CPURISCVState *env, int csrno, ta=
rget_ulong *val)
     if (!riscv_feature(env, RISCV_FEATURE_MMU)) {
         *val =3D 0;
     } else if (env->priv_ver >=3D PRIV_VERSION_1_10_0) {
-        *val =3D env->satp;
+        if (env->priv =3D=3D PRV_S && get_field(env->mstatus, MSTATUS_TVM)=
) {
+            return -1;
+        } else {
+            *val =3D env->satp;
+        }
     } else {
         *val =3D env->sptbr;
     }
@@ -663,8 +668,12 @@ static int write_satp(CPURISCVState *env, int csrno, t=
arget_ulong val)
         validate_vm(env, get_field(val, SATP_MODE)) &&
         ((val ^ env->satp) & (SATP_MODE | SATP_ASID | SATP_PPN)))
     {
-        tlb_flush(CPU(riscv_env_get_cpu(env)));
-        env->satp =3D val;
+        if (env->priv =3D=3D PRV_S && get_field(env->mstatus, MSTATUS_TVM)=
) {
+            return -1;
+        } else {
+            tlb_flush(CPU(riscv_env_get_cpu(env)));
+            env->satp =3D val;
+        }
     }
     return 0;
 }
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 81bd1a77ea..77c79ba36e 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -82,6 +82,11 @@ target_ulong helper_sret(CPURISCVState *env, target_ulon=
g cpu_pc_deb)
         do_raise_exception_err(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
     }
=20
+    if (env->priv_ver >=3D PRIV_VERSION_1_10_0 &&
+        get_field(env->mstatus, MSTATUS_TSR)) {
+        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    }
+
     target_ulong mstatus =3D env->mstatus;
     target_ulong prev_priv =3D get_field(mstatus, MSTATUS_SPP);
     mstatus =3D set_field(mstatus,
@@ -125,16 +130,28 @@ void helper_wfi(CPURISCVState *env)
 {
     CPUState *cs =3D CPU(riscv_env_get_cpu(env));
=20
-    cs->halted =3D 1;
-    cs->exception_index =3D EXCP_HLT;
-    cpu_loop_exit(cs);
+    if (env->priv =3D=3D PRV_S &&
+        env->priv_ver >=3D PRIV_VERSION_1_10_0 &&
+        get_field(env->mstatus, MSTATUS_TW)) {
+        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    } else {
+        cs->halted =3D 1;
+        cs->exception_index =3D EXCP_HLT;
+        cpu_loop_exit(cs);
+    }
 }
=20
 void helper_tlb_flush(CPURISCVState *env)
 {
     RISCVCPU *cpu =3D riscv_env_get_cpu(env);
     CPUState *cs =3D CPU(cpu);
-    tlb_flush(cs);
+    if (env->priv =3D=3D PRV_S &&
+        env->priv_ver >=3D PRIV_VERSION_1_10_0 &&
+        get_field(env->mstatus, MSTATUS_TVM)) {
+        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    } else {
+        tlb_flush(cs);
+    }
 }
=20
 #endif /* !CONFIG_USER_ONLY */
--=20
2.19.1
