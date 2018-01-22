Received: from eggs.gnu.org ([2001:4830:134:3::10]:51629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1edamu-0001pz-90
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:01:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1edamo-0005xB-J2
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:01:20 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 22 Jan 2018 13:00:42 +0100
Message-Id: <20180122120045.13538-7-cohuck@redhat.com>
In-Reply-To: <20180122120045.13538-1-cohuck@redhat.com>
References: <20180122120045.13538-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 6/9] s390x/tcg: fixup TEST PROTECTION
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

CC == 2 can only happen due to a protection exception, not if memory is
not available (PGM_ADDRESSING). So all PGM_ADDRESSING exceptions have to
be forwarded to the guest.

Since the initial definition of TEST PROTECTION, we now read globals
(e.g. PSW mask), so we have to correctly mark the instruction
(otherwise, e.g. booting fedora 27 fails).

Also, the architecture explicitly specifies which exceptions are
forwarded to the guest, this makes the code a little nicer.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180112125452.8569-1-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu.h        |  2 ++
 target/s390x/helper.h     |  2 +-
 target/s390x/mem_helper.c | 41 +++++++++++++++++++----------------------
 3 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 1a8b6b9ae9..915bccbc75 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -759,6 +759,8 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
         s390_cpu_virt_mem_rw(cpu, laddr, ar, dest, len, false)
 #define s390_cpu_virt_mem_write(cpu, laddr, ar, dest, len)       \
         s390_cpu_virt_mem_rw(cpu, laddr, ar, dest, len, true)
+#define s390_cpu_virt_mem_check_read(cpu, laddr, ar, len)   \
+        s390_cpu_virt_mem_rw(cpu, laddr, ar, NULL, len, false)
 #define s390_cpu_virt_mem_check_write(cpu, laddr, ar, len)   \
         s390_cpu_virt_mem_rw(cpu, laddr, ar, NULL, len, true)
 void s390_cpu_virt_mem_handle_exc(S390CPU *cpu, uintptr_t ra);
diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 26c1b07b44..59a1d9869b 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -137,7 +137,7 @@ DEF_HELPER_FLAGS_4(lctlg, TCG_CALL_NO_WG, void, env, i32, i64, i32)
 DEF_HELPER_FLAGS_4(stctl, TCG_CALL_NO_WG, void, env, i32, i64, i32)
 DEF_HELPER_FLAGS_4(stctg, TCG_CALL_NO_WG, void, env, i32, i64, i32)
 DEF_HELPER_FLAGS_2(testblock, TCG_CALL_NO_WG, i32, env, i64)
-DEF_HELPER_FLAGS_3(tprot, TCG_CALL_NO_RWG, i32, env, i64, i64)
+DEF_HELPER_FLAGS_3(tprot, TCG_CALL_NO_WG, i32, env, i64, i64)
 DEF_HELPER_FLAGS_2(iske, TCG_CALL_NO_RWG_SE, i64, env, i64)
 DEF_HELPER_FLAGS_3(sske, TCG_CALL_NO_RWG, void, env, i64, i64)
 DEF_HELPER_FLAGS_2(rrbe, TCG_CALL_NO_RWG, i32, env, i64)
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 359e446c6f..c957febc6d 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1730,34 +1730,31 @@ uint32_t HELPER(tprot)(CPUS390XState *env, uint64_t a1, uint64_t a2)
         /* Fetching permitted; storing permitted */
         return 0;
     }
+
+    if (env->int_pgm_code == PGM_PROTECTION) {
+        /* retry if reading is possible */
+        cs->exception_index = 0;
+        if (!s390_cpu_virt_mem_check_read(cpu, a1, 0, 1)) {
+            /* Fetching permitted; storing not permitted */
+            return 1;
+        }
+    }
+
     switch (env->int_pgm_code) {
     case PGM_PROTECTION:
-        /* Fetching permitted; storing not permitted */
-        cs->exception_index = 0;
-        return 1;
-    case PGM_ADDRESSING:
         /* Fetching not permitted; storing not permitted */
         cs->exception_index = 0;
         return 2;
-    case PGM_ASCE_TYPE:
-    case PGM_REG_FIRST_TRANS:
-    case PGM_REG_SEC_TRANS:
-    case PGM_REG_THIRD_TRANS:
-    case PGM_SEGMENT_TRANS:
-    case PGM_PAGE_TRANS:
-    case PGM_ALET_SPEC:
-    case PGM_ALEN_SPEC:
-    case PGM_ALE_SEQ:
-    case PGM_ASTE_VALID:
-    case PGM_ASTE_SEQ:
-    case PGM_EXT_AUTH:
-        /* Translation not available */
-        cs->exception_index = 0;
-        return 3;
+    case PGM_ADDRESSING:
+    case PGM_TRANS_SPEC:
+        /* exceptions forwarded to the guest */
+        s390_cpu_virt_mem_handle_exc(cpu, GETPC());
+        return 0;
     }
-    /* any other exception is forwarded to the guest */
-    s390_cpu_virt_mem_handle_exc(cpu, GETPC());
-    return 0;
+
+    /* Translation not available */
+    cs->exception_index = 0;
+    return 3;
 }
 
 /* insert storage key extended */
-- 
2.13.6
