Received: from eggs.gnu.org ([2001:4830:134:3::10]:41789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cFJgO-0007Go-Nu
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 06:49:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cFJgL-0007oj-Cy
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 06:49:44 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cFJgL-0007oS-2P
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 06:49:41 -0500
Received: by mail-wm0-f47.google.com with SMTP id u144so12821989wmu.1
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 03:49:40 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  9 Dec 2016 11:48:23 +0000
Message-Id: <20161209114830.9158-4-alex.bennee@linaro.org>
In-Reply-To: <20161209114830.9158-1-alex.bennee@linaro.org>
References: <20161209114830.9158-1-alex.bennee@linaro.org>
Subject: [Qemu-devel] [RISU PATCH v3 03/10] risu: paramterise send/receive
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, joserz@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This is a precursor to record/playback support. Instead of passing the
socket fd we now pass helper functions for reading/writing and
responding. This will allow us to do the rest of the record/playback
work without hacking up the arch specific stuff.

I've also added a header packet with pc/risu op in it so we can keep
better track of how things are going.

---
v3
  - new for v3
  - arm, aarch64, ppc64
---
 risu.c                 |  23 +++++++-
 risu.h                 |  11 +++-
 risu_aarch64.c         | 115 ++++++++++++++++++++++++--------------
 risu_arm.c             | 147 +++++++++++++++++++++++++++++++------------------
 risu_ppc64le.c         | 127 ++++++++++++++++++++++++++----------------
 risu_reginfo_aarch64.h |   7 +++
 risu_reginfo_arm.h     |   6 ++
 risu_reginfo_ppc64le.h |   6 ++
 8 files changed, 295 insertions(+), 147 deletions(-)

diff --git a/risu.c b/risu.c
index bcdc219..22571cd 100644
--- a/risu.c
+++ b/risu.c
@@ -47,9 +47,28 @@ void report_test_status(void *pc)
    }
 }
 
+/* Master functions */
+
+int read_sock(void *ptr, size_t bytes)
+{
+   return recv_data_pkt(master_socket, ptr, bytes);
+}
+
+void respond_sock(int r)
+{
+   send_response_byte(master_socket, r);
+}
+
+/* Apprentice function */
+
+int write_sock(void *ptr, size_t bytes)
+{
+   return send_data_pkt(apprentice_socket, ptr, bytes);
+}
+
 void master_sigill(int sig, siginfo_t *si, void *uc)
 {
-   switch (recv_and_compare_register_info(master_socket, uc))
+   switch (recv_and_compare_register_info(read_sock, respond_sock, uc))
    {
       case 0:
          /* match OK */
@@ -63,7 +82,7 @@ void master_sigill(int sig, siginfo_t *si, void *uc)
 
 void apprentice_sigill(int sig, siginfo_t *si, void *uc)
 {
-   switch (send_register_info(apprentice_socket, uc))
+   switch (send_register_info(write_sock, uc))
    {
       case 0:
          /* match OK */
diff --git a/risu.h b/risu.h
index e4bb323..b0178df 100644
--- a/risu.h
+++ b/risu.h
@@ -40,17 +40,24 @@ extern int ismaster;
 
 /* Interface provided by CPU-specific code: */
 
+/* To keep the read/write logic from multiplying across all arches
+ * we wrap up the function here to keep all the changes in one place
+ */
+typedef int (*write_fn) (void *ptr, size_t bytes);
+typedef int (*read_fn) (void *ptr, size_t bytes);
+typedef void (*respond_fn) (int response);
+
 /* Send the register information from the struct ucontext down the socket.
  * Return the response code from the master.
  * NB: called from a signal handler.
  */
-int send_register_info(int sock, void *uc);
+int send_register_info(write_fn write_fn, void *uc);
 
 /* Read register info from the socket and compare it with that from the
  * ucontext. Return 0 for match, 1 for end-of-test, 2 for mismatch.
  * NB: called from a signal handler.
  */
-int recv_and_compare_register_info(int sock, void *uc);
+int recv_and_compare_register_info(read_fn read_fn, respond_fn respond, void *uc);
 
 /* Print a useful report on the status of the last comparison
  * done in recv_and_compare_register_info(). This is called on
diff --git a/risu_aarch64.c b/risu_aarch64.c
index 1595604..c4c0d4d 100644
--- a/risu_aarch64.c
+++ b/risu_aarch64.c
@@ -50,21 +50,30 @@ static int get_risuop(uint32_t insn)
     return (key != risukey) ? -1 : op;
 }
 
-int send_register_info(int sock, void *uc)
+int send_register_info(write_fn write_fn, void *uc)
 {
     struct reginfo ri;
-    int op;
+    trace_header_t header;
+    int op, r = 0;
+
     reginfo_init(&ri, uc);
     op = get_risuop(ri.faulting_insn);
 
+    /* Write a header with PC/op to keep in sync */
+    header.pc = ri.pc;
+    header.risu_op = op;
+    if (write_fn(&header, sizeof(header)) != 0) {
+       fprintf(stderr,"%s: failed header write\n", __func__);
+       return -1;
+    }
+
     switch (op) {
-    case OP_COMPARE:
     case OP_TESTEND:
-    default:
-        /* Do a simple register compare on (a) explicit request
-         * (b) end of test (c) a non-risuop UNDEF
-         */
-        return send_data_pkt(sock, &ri, sizeof(ri));
+       if (write_fn(&ri, sizeof(ri)) != 0) {
+          fprintf(stderr,"%s: failed last write\n", __func__);
+       }
+       r = 1;
+       break;
     case OP_SETMEMBLOCK:
         memblock = (void *)ri.regs[0];
        break;
@@ -72,10 +81,16 @@ int send_register_info(int sock, void *uc)
         set_x0(uc, ri.regs[0] + (uintptr_t)memblock);
         break;
     case OP_COMPAREMEM:
-        return send_data_pkt(sock, memblock, MEMBLOCKLEN);
+        return write_fn(memblock, MEMBLOCKLEN);
         break;
+    case OP_COMPARE:
+    default:
+        /* Do a simple register compare on (a) explicit request
+         * (b) end of test (c) a non-risuop UNDEF
+         */
+        return write_fn(&ri, sizeof(ri));
     }
-    return 0;
+    return r;
 }
 
 /* Read register info from the socket and compare it with that from the
@@ -86,51 +101,69 @@ int send_register_info(int sock, void *uc)
  * that says whether it's register or memory data, so if the two
  * sides get out of sync then we will fail obscurely.
  */
-int recv_and_compare_register_info(int sock, void *uc)
+int recv_and_compare_register_info(read_fn read_fn, respond_fn resp_fn, void *uc)
 {
     int resp = 0, op;
+    trace_header_t header;
 
     reginfo_init(&master_ri, uc);
     op = get_risuop(master_ri.faulting_insn);
 
-    switch (op) {
-    case OP_COMPARE:
-    case OP_TESTEND:
-    default:
-        /* Do a simple register compare on (a) explicit request
-         * (b) end of test (c) a non-risuop UNDEF
-         */
-        if (recv_data_pkt(sock, &apprentice_ri, sizeof(apprentice_ri))) {
-            packet_mismatch = 1;
-            resp = 2;
-
-        } else if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
-            /* register mismatch */
-            resp = 2;
-
-        } else if (op == OP_TESTEND) {
-            resp = 1;
-        }
-        send_response_byte(sock, resp);
-        break;
-      case OP_SETMEMBLOCK:
+    if (read_fn(&header, sizeof(header)) != 0) {
+       fprintf(stderr,"%s: failed header read\n", __func__);
+       return -1;
+    }
+
+    if (header.risu_op == op ) {
+
+       /* send OK for the header */
+       resp_fn(0);
+
+       switch (op) {
+       case OP_COMPARE:
+       case OP_TESTEND:
+       default:
+          /* Do a simple register compare on (a) explicit request
+           * (b) end of test (c) a non-risuop UNDEF
+           */
+          if (read_fn(&apprentice_ri, sizeof(apprentice_ri))) {
+             packet_mismatch = 1;
+             resp = 2;
+
+          } else if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
+             /* register mismatch */
+             resp = 2;
+
+          } else if (op == OP_TESTEND) {
+             resp = 1;
+          }
+          resp_fn(resp);
+          break;
+       case OP_SETMEMBLOCK:
           memblock = (void *)master_ri.regs[0];
           break;
-      case OP_GETMEMBLOCK:
+       case OP_GETMEMBLOCK:
           set_x0(uc, master_ri.regs[0] + (uintptr_t)memblock);
           break;
-      case OP_COMPAREMEM:
-         mem_used = 1;
-         if (recv_data_pkt(sock, apprentice_memblock, MEMBLOCKLEN)) {
-             packet_mismatch = 1;
-             resp = 2;
-         } else if (memcmp(memblock, apprentice_memblock, MEMBLOCKLEN) != 0) {
+       case OP_COMPAREMEM:
+          mem_used = 1;
+          if (read_fn(apprentice_memblock, MEMBLOCKLEN)) {
+                packet_mismatch = 1;
+                resp = 2;
+             } else if (memcmp(memblock, apprentice_memblock, MEMBLOCKLEN) != 0) {
              /* memory mismatch */
              resp = 2;
          }
-         send_response_byte(sock, resp);
+         resp_fn(resp);
          break;
-   }
+       }
+   } else {
+      fprintf(stderr, "out of sync %lx/%lx %d/%d\n",
+              master_ri.pc, header.pc,
+              op, header.risu_op);
+      resp = 2;
+      resp_fn(resp);
+    }
 
     return resp;
 }
diff --git a/risu_arm.c b/risu_arm.c
index c3fe3d3..474729c 100644
--- a/risu_arm.c
+++ b/risu_arm.c
@@ -73,22 +73,31 @@ static int get_risuop(uint32_t insn, int isz)
 }
 
 
-int send_register_info(int sock, void *uc)
+int send_register_info(write_fn write_fn, void *uc)
 {
    struct reginfo ri;
-   int op;
+   trace_header_t header;
+   int op, r = 0;
+
    reginfo_init(&ri, uc);
    op = get_risuop(ri.faulting_insn, ri.faulting_insn_size);
 
+   /* Write a header with PC/op to keep in sync */
+   header.pc = ri.gpreg[15];
+   header.risu_op = op;
+   if (write_fn(&header, sizeof(header)) != 0) {
+      fprintf(stderr,"%s: failed header write\n", __func__);
+      return -1;
+   }
+
    switch (op)
    {
-      case OP_COMPARE:
       case OP_TESTEND:
-      default:
-         /* Do a simple register compare on (a) explicit request
-          * (b) end of test (c) a non-risuop UNDEF
-          */
-         return send_data_pkt(sock, &ri, sizeof(ri));
+         if (write_fn(&ri, sizeof(ri)) != 0) {
+            fprintf(stderr,"%s: failed last write\n", __func__);
+         }
+         r = 1;
+         break;
       case OP_SETMEMBLOCK:
          memblock = (void *)ri.gpreg[0];
          break;
@@ -96,10 +105,18 @@ int send_register_info(int sock, void *uc)
          set_r0(uc, ri.gpreg[0] + (uintptr_t)memblock);
          break;
       case OP_COMPAREMEM:
-         return send_data_pkt(sock, memblock, MEMBLOCKLEN);
+         r = write_fn(memblock, MEMBLOCKLEN);
+         break;
+      case OP_COMPARE:
+      default:
+         /* Do a simple register compare on (a) explicit request
+          * (b) end of test (c) a non-risuop UNDEF
+          */
+         r = write_fn(&ri, sizeof(ri));
          break;
    }
-   return 0;
+
+   return r;
 }
 
 /* Read register info from the socket and compare it with that from the
@@ -110,58 +127,78 @@ int send_register_info(int sock, void *uc)
  * that says whether it's register or memory data, so if the two
  * sides get out of sync then we will fail obscurely.
  */
-int recv_and_compare_register_info(int sock, void *uc)
+int recv_and_compare_register_info(read_fn read_fn, respond_fn resp_fn, void *uc)
 {
    int resp = 0, op;
+   trace_header_t header;
 
    reginfo_init(&master_ri, uc);
    op = get_risuop(master_ri.faulting_insn, master_ri.faulting_insn_size);
 
-   switch (op)
-   {
-      case OP_COMPARE:
-      case OP_TESTEND:
-      default:
-         /* Do a simple register compare on (a) explicit request
-          * (b) end of test (c) a non-risuop UNDEF
-          */
-         if (recv_data_pkt(sock, &apprentice_ri, sizeof(apprentice_ri)))
-         {
-            packet_mismatch = 1;
-            resp = 2;
-         }
-         else if (memcmp(&master_ri, &apprentice_ri, sizeof(master_ri)) != 0)
-         {
-            /* register mismatch */
-            resp = 2;
-         }
-         else if (op == OP_TESTEND)
-         {
-            resp = 1;
-         }
-         send_response_byte(sock, resp);
-         break;
-      case OP_SETMEMBLOCK:
-         memblock = (void *)master_ri.gpreg[0];
-         break;
-      case OP_GETMEMBLOCK:
-         set_r0(uc, master_ri.gpreg[0] + (uintptr_t)memblock);
-         break;
-      case OP_COMPAREMEM:
-         mem_used = 1;
-         if (recv_data_pkt(sock, apprentice_memblock, MEMBLOCKLEN))
-         {
-            packet_mismatch = 1;
-            resp = 2;
-         }
-         else if (memcmp(memblock, apprentice_memblock, MEMBLOCKLEN) != 0)
-         {
-            /* memory mismatch */
-            resp = 2;
-         }
-         send_response_byte(sock, resp);
-         break;
+   if (read_fn(&header, sizeof(header)) != 0) {
+      fprintf(stderr,"%s: failed header read\n", __func__);
+      return -1;
    }
+
+   if ( header.pc == master_ri.gpreg[15] &&
+        header.risu_op == op ) {
+
+      /* send OK for the header */
+      resp_fn(0);
+
+      switch (op)
+      {
+         case OP_COMPARE:
+         case OP_TESTEND:
+         default:
+            /* Do a simple register compare on (a) explicit request
+             * (b) end of test (c) a non-risuop UNDEF
+             */
+            if (read_fn(&apprentice_ri, sizeof(apprentice_ri)))
+            {
+               packet_mismatch = 1;
+               resp = 2;
+            }
+            else if (memcmp(&master_ri, &apprentice_ri, sizeof(master_ri)) != 0)
+            {
+               /* register mismatch */
+               resp = 2;
+            }
+            else if (op == OP_TESTEND)
+            {
+               resp = 1;
+            }
+            resp_fn(resp);
+            break;
+         case OP_SETMEMBLOCK:
+            memblock = (void *)master_ri.gpreg[0];
+            break;
+         case OP_GETMEMBLOCK:
+            set_r0(uc, master_ri.gpreg[0] + (uintptr_t)memblock);
+            break;
+         case OP_COMPAREMEM:
+            mem_used = 1;
+            if (read_fn(apprentice_memblock, MEMBLOCKLEN))
+            {
+               packet_mismatch = 1;
+               resp = 2;
+            }
+            else if (memcmp(memblock, apprentice_memblock, MEMBLOCKLEN) != 0)
+            {
+               /* memory mismatch */
+               resp = 2;
+            }
+            resp_fn(resp);
+            break;
+      }
+   } else {
+      fprintf(stderr, "out of sync %x/%x %d/%d\n",
+              master_ri.gpreg[15], header.pc,
+              op, header.risu_op);
+      resp = 2;
+      resp_fn(resp);
+   }
+
    return resp;
 }
 
diff --git a/risu_ppc64le.c b/risu_ppc64le.c
index 9c1fafd..f156ed8 100644
--- a/risu_ppc64le.c
+++ b/risu_ppc64le.c
@@ -44,19 +44,30 @@ static int get_risuop(uint32_t insn)
     return (key != risukey) ? -1 : op;
 }
 
-int send_register_info(int sock, void *uc)
+int send_register_info(write_fn write_fn, void *uc)
 {
     struct reginfo ri;
-    int op;
+    trace_header_t header;
+    int op, r = 0;
 
     reginfo_init(&ri, uc);
     op = get_risuop(ri.faulting_insn);
 
+    /* Write a header with PC/op to keep in sync */
+    header.pc = ri.nip;
+    header.risu_op = op;
+    if (write_fn(&header, sizeof(header)) != 0) {
+       fprintf(stderr,"%s: failed header write\n", __func__);
+       return -1;
+    }
+
     switch (op) {
-    case OP_COMPARE:
     case OP_TESTEND:
-    default:
-        return send_data_pkt(sock, &ri, sizeof(ri));
+       if (write_fn(&ri, sizeof(ri)) != 0) {
+          fprintf(stderr,"%s: failed last write\n", __func__);
+       }
+       r = 1;
+       break;
     case OP_SETMEMBLOCK:
         memblock = (void*)ri.gregs[0];
         break;
@@ -64,57 +75,79 @@ int send_register_info(int sock, void *uc)
         set_x0(uc, ri.gregs[0] + (uintptr_t)memblock);
         break;
     case OP_COMPAREMEM:
-        return send_data_pkt(sock, memblock, MEMBLOCKLEN);
+        return write_fn(memblock, MEMBLOCKLEN);
         break;
+    case OP_COMPARE:
+    default:
+        return write_fn(&ri, sizeof(ri));
     }
-    return 0;
+    return r;
 }
 
 /* Read register info from the socket and compare it with that from the
  * ucontext. Return 0 for match, 1 for end-of-test, 2 for mismatch.
  * NB: called from a signal handler.
  */
-int recv_and_compare_register_info(int sock, void *uc)
+int recv_and_compare_register_info(read_fn read_fn, respond_fn resp_fn, void *uc)
 {
-    int resp = 0;
-    int op;
-
-    reginfo_init(&master_ri, uc);
-    op = get_risuop(master_ri.faulting_insn);
-
-    switch (op) {
-    case OP_COMPARE:
-    case OP_TESTEND:
-    default:
-        if (recv_data_pkt(sock, &apprentice_ri, sizeof(apprentice_ri))) {
-            packet_mismatch = 1;
-            resp = 2;
-        } else if (!reginfo_is_eq(&master_ri, &apprentice_ri, uc)) {
-            resp = 2;
-        }
-        else if (op == OP_TESTEND) {
-            resp = 1;
-        }
-        send_response_byte(sock, resp);
-        break;
-    case OP_SETMEMBLOCK:
-        memblock = (void*)master_ri.gregs[0];
-        break;
-    case OP_GETMEMBLOCK:
-        set_x0(uc, master_ri.gregs[0] + (uintptr_t)memblock);
-        break;
-    case OP_COMPAREMEM:
-        mem_used = 1;
-        if (recv_data_pkt(sock, apprentice_memblock, MEMBLOCKLEN)) {
-            packet_mismatch = 1;
-            resp = 2;
-        } else if (memcmp(memblock, apprentice_memblock, MEMBLOCKLEN) != 0) {
-            resp = 2;
-        }
-        send_response_byte(sock, resp);
-        break;
-    }
-    return resp;
+   int resp = 0;
+   int op;
+   trace_header_t header;
+
+   reginfo_init(&master_ri, uc);
+   op = get_risuop(master_ri.faulting_insn);
+
+   if (read_fn(&header, sizeof(header)) != 0) {
+      fprintf(stderr,"%s: failed header read\n", __func__);
+      return -1;
+   }
+
+   if (header.risu_op == op ) {
+
+      /* send OK for the header */
+      resp_fn(0);
+
+      switch (op) {
+         case OP_COMPARE:
+         case OP_TESTEND:
+         default:
+            if (read_fn(&apprentice_ri, sizeof(apprentice_ri))) {
+               packet_mismatch = 1;
+               resp = 2;
+            } else if (!reginfo_is_eq(&master_ri, &apprentice_ri, uc)) {
+               resp = 2;
+            }
+            else if (op == OP_TESTEND) {
+               resp = 1;
+            }
+            resp_fn(resp);
+            break;
+         case OP_SETMEMBLOCK:
+            memblock = (void*)master_ri.gregs[0];
+            break;
+         case OP_GETMEMBLOCK:
+            set_x0(uc, master_ri.gregs[0] + (uintptr_t)memblock);
+            break;
+         case OP_COMPAREMEM:
+            mem_used = 1;
+            if (read_fn(apprentice_memblock, MEMBLOCKLEN)) {
+               packet_mismatch = 1;
+               resp = 2;
+            } else if (memcmp(memblock, apprentice_memblock, MEMBLOCKLEN) != 0) {
+               resp = 2;
+            }
+            resp_fn(resp);
+            break;
+      }
+   } else {
+      fprintf(stderr, "out of sync %lx/%lx %d/%d\n",
+              master_ri.nip, header.pc,
+              op, header.risu_op);
+      resp = 2;
+      resp_fn(resp);
+   }
+
+   return resp;
 }
 
 /* Print a useful report on the status of the last comparison
diff --git a/risu_reginfo_aarch64.h b/risu_reginfo_aarch64.h
index 166b76c..db51cb2 100644
--- a/risu_reginfo_aarch64.h
+++ b/risu_reginfo_aarch64.h
@@ -28,6 +28,13 @@ struct reginfo
     __uint128_t vregs[32];
 };
 
+typedef struct
+{
+    uint64_t pc;
+    uint32_t risu_op;
+} trace_header_t;
+
+
 /* initialize structure from a ucontext */
 void reginfo_init(struct reginfo *ri, ucontext_t *uc);
 
diff --git a/risu_reginfo_arm.h b/risu_reginfo_arm.h
index 80c28c6..7e7e408 100644
--- a/risu_reginfo_arm.h
+++ b/risu_reginfo_arm.h
@@ -23,6 +23,12 @@ struct reginfo
     uint32_t fpscr;
 };
 
+typedef struct
+{
+    uint32_t pc;
+    uint32_t risu_op;
+} trace_header_t;
+
 /* initialize a reginfo structure with data from uc */
 void reginfo_init(struct reginfo *ri, ucontext_t *uc);
 
diff --git a/risu_reginfo_ppc64le.h b/risu_reginfo_ppc64le.h
index abe6002..49b4938 100644
--- a/risu_reginfo_ppc64le.h
+++ b/risu_reginfo_ppc64le.h
@@ -25,6 +25,12 @@ struct reginfo
     vrregset_t vrregs;
 };
 
+typedef struct
+{
+    uint64_t pc;
+    uint32_t risu_op;
+} trace_header_t;
+
 /* initialize structure from a ucontext */
 void reginfo_init(struct reginfo *ri, ucontext_t *uc);
 
-- 
2.11.0
