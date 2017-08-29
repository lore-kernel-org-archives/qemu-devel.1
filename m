Received: from eggs.gnu.org ([2001:4830:134:3::10]:48523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCh-0001YO-Aq
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCe-0005oO-2M
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCd-0005mC-Mf
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:23 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0E70K090091
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:22 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmvyehksk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:22 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 18:16:21 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:31 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-57-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 56/79] target/xtensa: handle unknown registers
 in gdbstub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>

From: Max Filippov <jcmvbkbc@gmail.com>

Xtensa cores may have registers of types/sizes not supported by the
gdbstub accessors. Ignore writes to such registers and return zero on
read, but always return correct register size, so that gdb on the other
side is able to access all registers in the packet holding unsupported
registers in the middle. This fixes gdb interaction with cores that have
vector/custom TIE registers.

Cc: qemu-stable@nongnu.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
(cherry picked from commit dd7b952b793e341c905355581a21cdbaa8b13c31)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
2.7.4
