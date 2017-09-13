Received: from eggs.gnu.org ([2001:4830:134:3::10]:43527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ds5RJ-0008MV-RR
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ds5RG-00013P-B9
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:02:41 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:54242 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ds5RF-00011P-RZ
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:02:38 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 13 Sep 2017 14:02:21 +0300
Message-Id: <150530054117.10902.5104031986565205704.stgit@frigg.lan>
In-Reply-To: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
References: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 17/22] trace: Introduce a proper structure
 to describe memory accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 include/exec/cpu_ldst_template.h          |   15 ++++++--------
 include/exec/cpu_ldst_useronly_template.h |   15 ++++++--------
 tcg/tcg-op.c                              |   22 +++++++++++++--------
 trace/mem-internal.h                      |   22 ++++++++++++---------
 trace/mem.h                               |   31 +++++++++++++++++++++++=
++----
 5 files changed, 66 insertions(+), 39 deletions(-)

diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_tem=
plate.h
index 4db2302962..debbabcfb2 100644
--- a/include/exec/cpu_ldst_template.h
+++ b/include/exec/cpu_ldst_template.h
@@ -88,9 +88,8 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUAr=
chState *env,
     TCGMemOpIdx oi;
=20
 #if !defined(SOFTMMU_CODE_ACCESS)
-    trace_guest_mem_before_exec(
-        ENV_GET_CPU(env), ptr,
-        trace_mem_build_info(SHIFT, false, MO_TE, false));
+    TraceMemInfo meminfo =3D trace_mem_build_info(SHIFT, false, MO_TE, f=
alse);
+    trace_guest_mem_before_exec(ENV_GET_CPU(env), ptr, meminfo.raw);
 #endif
=20
     addr =3D ptr;
@@ -126,9 +125,8 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPU=
ArchState *env,
     TCGMemOpIdx oi;
=20
 #if !defined(SOFTMMU_CODE_ACCESS)
-    trace_guest_mem_before_exec(
-        ENV_GET_CPU(env), ptr,
-        trace_mem_build_info(SHIFT, true, MO_TE, false));
+    TraceMemInfo meminfo =3D trace_mem_build_info(SHIFT, true, MO_TE, fa=
lse);
+    trace_guest_mem_before_exec(ENV_GET_CPU(env), ptr, meminfo.raw);
 #endif
=20
     addr =3D ptr;
@@ -168,9 +166,8 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUA=
rchState *env,
     TCGMemOpIdx oi;
=20
 #if !defined(SOFTMMU_CODE_ACCESS)
-    trace_guest_mem_before_exec(
-        ENV_GET_CPU(env), ptr,
-        trace_mem_build_info(SHIFT, false, MO_TE, true));
+    TraceMemInfo meminfo =3D trace_mem_build_info(SHIFT, false, MO_TE, t=
rue);
+    trace_guest_mem_before_exec(ENV_GET_CPU(env), ptr, meminfo.raw);
 #endif
=20
     addr =3D ptr;
diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu=
_ldst_useronly_template.h
index 7b8c7c506e..b0b3fc1b8d 100644
--- a/include/exec/cpu_ldst_useronly_template.h
+++ b/include/exec/cpu_ldst_useronly_template.h
@@ -61,9 +61,8 @@ static inline RES_TYPE
 glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong p=
tr)
 {
 #if !defined(CODE_ACCESS)
-    trace_guest_mem_before_exec(
-        ENV_GET_CPU(env), ptr,
-        trace_mem_build_info(DATA_SIZE, false, MO_TE, false));
+    TraceMemInfo meminfo =3D trace_mem_build_info(DATA_SIZE, false, MO_T=
E, false);
+    trace_guest_mem_before_exec(ENV_GET_CPU(env), ptr, meminfo.raw);
 #endif
     return glue(glue(ld, USUFFIX), _p)(g2h(ptr));
 }
@@ -81,9 +80,8 @@ static inline int
 glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong p=
tr)
 {
 #if !defined(CODE_ACCESS)
-    trace_guest_mem_before_exec(
-        ENV_GET_CPU(env), ptr,
-        trace_mem_build_info(DATA_SIZE, true, MO_TE, false));
+    TraceMemInfo meminfo =3D trace_mem_build_info(DATA_SIZE, true, MO_TE=
, false);
+    trace_guest_mem_before_exec(ENV_GET_CPU(env), ptr, meminfo.raw);
 #endif
     return glue(glue(lds, SUFFIX), _p)(g2h(ptr));
 }
@@ -103,9 +101,8 @@ glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *e=
nv, target_ulong ptr,
                                       RES_TYPE v)
 {
 #if !defined(CODE_ACCESS)
-    trace_guest_mem_before_exec(
-        ENV_GET_CPU(env), ptr,
-        trace_mem_build_info(DATA_SIZE, false, MO_TE, true));
+    TraceMemInfo meminfo =3D trace_mem_build_info(DATA_SIZE, false, MO_T=
E, true);
+    trace_guest_mem_before_exec(ENV_GET_CPU(env), ptr, meminfo.raw);
 #endif
     glue(glue(st, SUFFIX), _p)(g2h(ptr), v);
 }
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 688d91755b..6edf70bdfc 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2676,24 +2676,28 @@ static void tcg_gen_req_mo(TCGBar type)
=20
 void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp m=
emop)
 {
+    TraceMemInfo meminfo;
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     memop =3D tcg_canonicalize_memop(memop, 0, 0);
-    trace_guest_mem_before_tcg(tcg_ctx.cpu, tcg_ctx.tcg_env,
-                               addr, trace_mem_get_info(memop, 0));
+    meminfo =3D trace_mem_get_info(memop, 0);
+    trace_guest_mem_before_tcg(tcg_ctx.cpu, tcg_ctx.tcg_env, addr, memin=
fo.raw);
     gen_ldst_i32(INDEX_op_qemu_ld_i32, val, addr, memop, idx);
 }
=20
 void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp m=
emop)
 {
+    TraceMemInfo meminfo;
     tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     memop =3D tcg_canonicalize_memop(memop, 0, 1);
-    trace_guest_mem_before_tcg(tcg_ctx.cpu, tcg_ctx.tcg_env,
-                               addr, trace_mem_get_info(memop, 1));
+    meminfo =3D trace_mem_get_info(memop, 1);
+    trace_guest_mem_before_tcg(tcg_ctx.cpu, tcg_ctx.tcg_env, addr, memin=
fo.raw);
     gen_ldst_i32(INDEX_op_qemu_st_i32, val, addr, memop, idx);
 }
=20
 void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp m=
emop)
 {
+    TraceMemInfo meminfo;
+
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     if (TCG_TARGET_REG_BITS =3D=3D 32 && (memop & MO_SIZE) < MO_64) {
         tcg_gen_qemu_ld_i32(TCGV_LOW(val), addr, idx, memop);
@@ -2706,13 +2710,15 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr,=
 TCGArg idx, TCGMemOp memop)
     }
=20
     memop =3D tcg_canonicalize_memop(memop, 1, 0);
-    trace_guest_mem_before_tcg(tcg_ctx.cpu, tcg_ctx.tcg_env,
-                               addr, trace_mem_get_info(memop, 0));
+    meminfo =3D trace_mem_get_info(memop, 0);
+    trace_guest_mem_before_tcg(tcg_ctx.cpu, tcg_ctx.tcg_env, addr, memin=
fo.raw);
     gen_ldst_i64(INDEX_op_qemu_ld_i64, val, addr, memop, idx);
 }
=20
 void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp m=
emop)
 {
+    TraceMemInfo meminfo;
+
     tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     if (TCG_TARGET_REG_BITS =3D=3D 32 && (memop & MO_SIZE) < MO_64) {
         tcg_gen_qemu_st_i32(TCGV_LOW(val), addr, idx, memop);
@@ -2720,8 +2726,8 @@ void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, T=
CGArg idx, TCGMemOp memop)
     }
=20
     memop =3D tcg_canonicalize_memop(memop, 1, 1);
-    trace_guest_mem_before_tcg(tcg_ctx.cpu, tcg_ctx.tcg_env,
-                               addr, trace_mem_get_info(memop, 1));
+    meminfo =3D trace_mem_get_info(memop, 1);
+    trace_guest_mem_before_tcg(tcg_ctx.cpu, tcg_ctx.tcg_env, addr, memin=
fo.raw);
     gen_ldst_i64(INDEX_op_qemu_st_i64, val, addr, memop, idx);
 }
=20
diff --git a/trace/mem-internal.h b/trace/mem-internal.h
index ddda934253..b77079527f 100644
--- a/trace/mem-internal.h
+++ b/trace/mem-internal.h
@@ -1,7 +1,7 @@
 /*
  * Helper functions for guest memory tracing
  *
- * Copyright (C) 2016 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ * Copyright (C) 2016-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
@@ -10,8 +10,9 @@
 #ifndef TRACE__MEM_INTERNAL_H
 #define TRACE__MEM_INTERNAL_H
=20
-static inline uint8_t trace_mem_get_info(TCGMemOp op, bool store)
+static inline TraceMemInfo trace_mem_get_info(TCGMemOp op, bool store)
 {
+    TraceMemInfo res_;
     uint8_t res =3D op;
     bool be =3D (op & MO_BSWAP) =3D=3D MO_BE;
=20
@@ -27,19 +28,22 @@ static inline uint8_t trace_mem_get_info(TCGMemOp op,=
 bool store)
         res |=3D 1ULL << 4;
     }
=20
-    return res;
+    res_.raw =3D res;
+    return res_;
 }
=20
-static inline uint8_t trace_mem_build_info(
+static inline TraceMemInfo trace_mem_build_info(
     TCGMemOp size, bool sign_extend, TCGMemOp endianness, bool store)
 {
-    uint8_t res =3D 0;
-    res |=3D size;
-    res |=3D (sign_extend << 2);
+    TraceMemInfo res;
+    res.size_shift =3D size;
+    res.sign_extend =3D sign_extend;
     if (endianness =3D=3D MO_BE) {
-        res |=3D (1ULL << 3);
+        res.endianness =3D 1;
+    } else {
+        res.endianness =3D 0;
     }
-    res |=3D (store << 4);
+    res.store =3D store;
     return res;
 }
=20
diff --git a/trace/mem.h b/trace/mem.h
index 9c88bcb4e6..9866b41401 100644
--- a/trace/mem.h
+++ b/trace/mem.h
@@ -1,7 +1,7 @@
 /*
  * Helper functions for guest memory tracing
  *
- * Copyright (C) 2016 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ * Copyright (C) 2016-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
@@ -12,21 +12,44 @@
=20
 #include "tcg/tcg.h"
=20
+/**
+ * TraceMemInfo:
+ * @size_shift: Memoy access size, interpreted as "1 << size_shift" byte=
s.
+ * @sign_extend: Whether the access is sign-extended.
+ * @endianness: Endinness type (0: little, 1: big).
+ * @store: Whether it's a store operation.
+ *
+ * Memory access information.
+ *
+ * NOTE: Keep in sync with QIMemInfo.
+ */
+typedef struct TraceMemInfo {
+    union {
+        struct {
+            uint8_t size_shift : 2;
+            bool    sign_extend: 1;
+            uint8_t endianness : 1;
+            bool    store      : 1;
+        };
+        uint8_t raw;
+    };
+} TraceMemInfo;
+
=20
 /**
  * trace_mem_get_info:
  *
  * Return a value for the 'info' argument in guest memory access traces.
  */
-static uint8_t trace_mem_get_info(TCGMemOp op, bool store);
+static TraceMemInfo trace_mem_get_info(TCGMemOp op, bool store);
=20
 /**
  * trace_mem_build_info:
  *
  * Return a value for the 'info' argument in guest memory access traces.
  */
-static uint8_t trace_mem_build_info(TCGMemOp size, bool sign_extend,
-                                    TCGMemOp endianness, bool store);
+static TraceMemInfo trace_mem_build_info(TCGMemOp size, bool sign_extend=
,
+                                         TCGMemOp endianness, bool store=
);
=20
=20
 #include "trace/mem-internal.h"
