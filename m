Received: from eggs.gnu.org ([2001:4830:134:3::10]:40736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dMuCU-0007Mt-Ej
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:46:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dMuCT-0004un-DD
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:46:30 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:34415)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dMuCT-0004tt-3w
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:46:29 -0400
Received: by mail-wr0-x22b.google.com with SMTP id 77so69495531wrb.1
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 03:46:28 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 19 Jun 2017 11:46:50 +0100
Message-Id: <20170619104655.31104-9-alex.bennee@linaro.org>
In-Reply-To: <20170619104655.31104-1-alex.bennee@linaro.org>
References: <20170619104655.31104-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v5 08/13] risu: add header to trace stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

I've also added a header packet with pc/risu op in it so we can keep
better track of how things are going.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v5
  - re-base without formatting fixes
  - dropped fprintfs in signal context
v4
  - split from previous patch
---
 reginfo.c      | 94 +++++++++++++++++++++++++++++++++++++---------------------
 risu.h         |  9 ++++++
 risu_aarch64.c |  5 ++++
 risu_arm.c     |  5 ++++
 risu_m68k.c    |  5 ++++
 risu_ppc64.c   |  5 ++++
 6 files changed, 89 insertions(+), 34 deletions(-)

diff --git a/reginfo.c b/reginfo.c
index 90cea8f..4ff937f 100644
--- a/reginfo.c
+++ b/reginfo.c
@@ -24,10 +24,19 @@ static int packet_mismatch;
 int send_register_info(write_fn write_fn, void *uc)
 {
     struct reginfo ri;
+    trace_header_t header;
     int op;
+
     reginfo_init(&ri, uc);
     op = get_risuop(&ri);
 
+    /* Write a header with PC/op to keep in sync */
+    header.pc = get_pc(&ri);
+    header.risu_op = op;
+    if (write_fn(&header, sizeof(header)) != 0) {
+        return -1;
+    }
+
     switch (op) {
     case OP_TESTEND:
         write_fn(&ri, sizeof(ri));
@@ -63,46 +72,63 @@ int send_register_info(write_fn write_fn, void *uc)
 int recv_and_compare_register_info(read_fn read_fn, respond_fn resp_fn, void *uc)
 {
     int resp = 0, op;
+    trace_header_t header;
 
     reginfo_init(&master_ri, uc);
     op = get_risuop(&master_ri);
 
-    switch (op) {
-    case OP_COMPARE:
-    case OP_TESTEND:
-    default:
-        /* Do a simple register compare on (a) explicit request
-         * (b) end of test (c) a non-risuop UNDEF
-         */
-        if (read_fn(&apprentice_ri, sizeof(apprentice_ri))) {
-            packet_mismatch = 1;
-            resp = 2;
-        } else if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
-            /* register mismatch */
-            resp = 2;
-        } else if (op == OP_TESTEND) {
-            resp = 1;
-        }
-        resp_fn(resp);
-        break;
-    case OP_SETMEMBLOCK:
-        memblock = (void *)(uintptr_t)get_reginfo_paramreg(&master_ri);
-        break;
-    case OP_GETMEMBLOCK:
-        set_ucontext_paramreg(uc, get_reginfo_paramreg(&master_ri) +
-                              (uintptr_t)memblock);
-        break;
-    case OP_COMPAREMEM:
-        mem_used = 1;
-        if (read_fn(apprentice_memblock, MEMBLOCKLEN)) {
-            packet_mismatch = 1;
-            resp = 2;
-        } else if (memcmp(memblock, apprentice_memblock, MEMBLOCKLEN) != 0) {
-            /* memory mismatch */
-            resp = 2;
+    if (read_fn(&header, sizeof(header)) != 0) {
+        return -1;
+    }
+
+    if (header.risu_op == op ) {
+
+        /* send OK for the header */
+        resp_fn(0);
+
+        switch (op) {
+        case OP_COMPARE:
+        case OP_TESTEND:
+        default:
+            /* Do a simple register compare on (a) explicit request
+             * (b) end of test (c) a non-risuop UNDEF
+             */
+            if (read_fn(&apprentice_ri, sizeof(apprentice_ri))) {
+                packet_mismatch = 1;
+                resp = 2;
+
+            } else if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
+                /* register mismatch */
+                resp = 2;
+
+            } else if (op == OP_TESTEND) {
+                resp = 1;
+            }
+            resp_fn(resp);
+            break;
+        case OP_SETMEMBLOCK:
+            memblock = (void *)(uintptr_t)get_reginfo_paramreg(&master_ri);
+            break;
+        case OP_GETMEMBLOCK:
+            set_ucontext_paramreg(uc, get_reginfo_paramreg(&master_ri) +
+                                  (uintptr_t)memblock);
+            break;
+        case OP_COMPAREMEM:
+            mem_used = 1;
+            if (read_fn(apprentice_memblock, MEMBLOCKLEN)) {
+                packet_mismatch = 1;
+                resp = 2;
+            } else if (memcmp(memblock, apprentice_memblock, MEMBLOCKLEN) != 0) {
+                /* memory mismatch */
+                resp = 2;
+            }
+            resp_fn(resp);
+            break;
         }
+    } else {
+        /* We are out of sync */
+        resp = 2;
         resp_fn(resp);
-        break;
     }
 
     return resp;
diff --git a/risu.h b/risu.h
index 32241bc..e9e70ab 100644
--- a/risu.h
+++ b/risu.h
@@ -51,6 +51,12 @@ extern int ismaster;
 
 struct reginfo;
 
+typedef struct
+{
+   uintptr_t pc;
+   uint32_t risu_op;
+} trace_header_t;
+
 /* Functions operating on reginfo */
 
 /* To keep the read/write logic from multiplying across all arches
@@ -102,6 +108,9 @@ uint64_t get_reginfo_paramreg(struct reginfo *ri);
  */
 int get_risuop(struct reginfo *ri);
 
+/* Return the PC from a reginfo */
+uintptr_t get_pc(struct reginfo *ri);
+
 /* initialize structure from a ucontext */
 void reginfo_init(struct reginfo *ri, ucontext_t *uc);
 
diff --git a/risu_aarch64.c b/risu_aarch64.c
index 9c6809d..492d141 100644
--- a/risu_aarch64.c
+++ b/risu_aarch64.c
@@ -40,3 +40,8 @@ int get_risuop(struct reginfo *ri)
     uint32_t risukey = 0x00005af0;
     return (key != risukey) ? -1 : op;
 }
+
+uintptr_t get_pc(struct reginfo *ri)
+{
+   return ri->pc;
+}
diff --git a/risu_arm.c b/risu_arm.c
index a55c6c2..5fcb2a5 100644
--- a/risu_arm.c
+++ b/risu_arm.c
@@ -68,3 +68,8 @@ int get_risuop(struct reginfo *ri)
     uint32_t risukey = (isz == 2) ? 0xdee0 : 0xe7fe5af0;
     return (key != risukey) ? -1 : op;
 }
+
+uintptr_t get_pc(struct reginfo *ri)
+{
+   return ri->gpreg[15];
+}
diff --git a/risu_m68k.c b/risu_m68k.c
index 0bf5c14..1056eef 100644
--- a/risu_m68k.c
+++ b/risu_m68k.c
@@ -33,3 +33,8 @@ int get_risuop(struct reginfo *ri)
     uint32_t risukey = 0x4afc7000;
     return (key != risukey) ? -1 : op;
 }
+
+uintptr_t get_pc(struct reginfo *ri)
+{
+    return ri->gregs[R_PC];
+}
diff --git a/risu_ppc64.c b/risu_ppc64.c
index eb60573..83f8d1f 100644
--- a/risu_ppc64.c
+++ b/risu_ppc64.c
@@ -38,3 +38,8 @@ int get_risuop(struct reginfo *ri)
     uint32_t risukey = 0x00005af0;
     return (key != risukey) ? -1 : op;
 }
+
+uintptr_t get_pc(struct reginfo *ri)
+{
+   return ri->nip;
+}
-- 
2.13.0
