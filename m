Received: from eggs.gnu.org ([2001:4830:134:3::10]:60007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1dH5Dj-0001eQ-W5
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 05:19:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1dH5Dg-0006pS-RL
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 05:19:43 -0400
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sat,  3 Jun 2017 02:19:24 -0700
Message-Id: <1496481564-20545-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] target/xtensa: handle unknown registers in
 gdbstub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, qemu-stable@nongnu.org

Xtensa cores may have registers of types/sizes not supported by the
gdbstub accessors. Ignore writes to such registers and return zero on
read, but always return correct register size, so that gdb on the other
side is able to access all registers in the packet holding unsupported
registers in the middle. This fixes gdb interaction with cores that have
vector/custom TIE registers.

Cc: qemu-stable@nongnu.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/gdbstub.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/target/xtensa/gdbstub.c b/target/xtensa/gdbstub.c
index fa5469a..da131ae 100644
--- a/target/xtensa/gdbstub.c
+++ b/target/xtensa/gdbstub.c
@@ -58,7 +58,10 @@ int xtensa_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
         case 8:
             return gdb_get_reg64(mem_buf, float64_val(env->fregs[i].f64));
         default:
-            return 0;
+            qemu_log_mask(LOG_UNIMP, "%s from reg %d of unsupported size %d\n",
+                          __func__, n, reg->size);
+            memset(mem_buf, 0, reg->size);
+            return reg->size;
         }
 
     case 8: /*a*/
@@ -67,6 +70,8 @@ int xtensa_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
     default:
         qemu_log_mask(LOG_UNIMP, "%s from reg %d of unsupported type %d\n",
                       __func__, n, reg->type);
+        memset(mem_buf, 0, reg->size);
+        return reg->size;
         return 0;
     }
 }
@@ -111,7 +116,9 @@ int xtensa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
             env->fregs[reg->targno & 0x0f].f64 = make_float64(tmp);
             return 8;
         default:
-            return 0;
+            qemu_log_mask(LOG_UNIMP, "%s to reg %d of unsupported size %d\n",
+                          __func__, n, reg->size);
+            return reg->size;
         }
 
     case 8: /*a*/
@@ -121,7 +128,7 @@ int xtensa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     default:
         qemu_log_mask(LOG_UNIMP, "%s to reg %d of unsupported type %d\n",
                       __func__, n, reg->type);
-        return 0;
+        return reg->size;
     }
 
     return 4;
-- 
2.1.4
