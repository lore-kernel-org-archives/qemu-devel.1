Received: from eggs.gnu.org ([2001:4830:134:3::10]:42358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJt-000397-Gp
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJr-0004qU-7Q
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:37 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:06 -0500
Message-Id: <20180723201748.25573-58-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 57/99] qapi: fill in CpuInfoFast.arch in
 query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Viktor VM Mihajlovski <mihajlov@linux.vnet.ibm.com>

From: Laszlo Ersek <lersek@redhat.com>

* Commit ca230ff33f89 added the @arch field to @CpuInfoFast, but it failed
  to set the new field in qmp_query_cpus_fast(), when TARGET_S390X was not
  defined. The updated @query-cpus-fast example in "qapi-schema.json"
  showed "arch":"x86" only because qmp_query_cpus_fast() calls g_malloc0()
  to allocate @CpuInfoFast, and the CPU_INFO_ARCH_X86 enum constant is
  generated with value 0.

  All @arch values other than @s390 implied the @CpuInfoOther sub-struct
  for @CpuInfoFast -- at the time of writing the patch --, thus no fields
  other than @arch needed to be set when TARGET_S390X was not defined. Set
  @arch now, by copying the corresponding assignments from
  qmp_query_cpus().

* Commit 25fa194b7b11 added the @riscv enum constant to @CpuInfoArch (used
  in both @CpuInfo and @CpuInfoFast -- the return types of the @query-cpus
  and @query-cpus-fast commands, respectively), and assigned, in both
  return structures, the @CpuInfoRISCV sub-structure to the new enum
  value.

  However, qmp_query_cpus_fast() would not populate either the @arch field
  or the @CpuInfoRISCV sub-structure, when TARGET_RISCV was defined; only
  qmp_query_cpus() would.

  Assign @CpuInfoOther to the @riscv enum constant in @CpuInfoFast, and
  populate only the @arch field in qmp_query_cpus_fast(). Getting CPU
  state without interrupting KVM is an exceptional thing that only S390X
  does currently. Quoting Cornelia Huck <cohuck@redhat.com>, "s390x is
  exceptional in that it has state in QEMU that is actually interesting
  for upper layers and can be retrieved without performance penalty". See
  also
  <https://www.redhat.com/archives/libvir-list/2018-February/msg00121.html>.

Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Viktor VM Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: qemu-stable@nongnu.org
Fixes: ca230ff33f89bf7102cbfbc2328716da6750aaed
Fixes: 25fa194b7b11901561532e435beb83d046899f7a
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180427192852.15013-2-lersek@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
(cherry picked from commit 96054f56396eaa0b9b5c681fc3e42a0004b17ade)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 cpus.c         | 16 +++++++++++++++-
 qapi/misc.json |  2 +-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/cpus.c b/cpus.c
index e1d94038fd..6fa701e423 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2218,11 +2218,25 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
             info->value->props = props;
         }
 
-#if defined(TARGET_S390X)
+#if defined(TARGET_I386)
+        info->value->arch = CPU_INFO_ARCH_X86;
+#elif defined(TARGET_PPC)
+        info->value->arch = CPU_INFO_ARCH_PPC;
+#elif defined(TARGET_SPARC)
+        info->value->arch = CPU_INFO_ARCH_SPARC;
+#elif defined(TARGET_MIPS)
+        info->value->arch = CPU_INFO_ARCH_MIPS;
+#elif defined(TARGET_TRICORE)
+        info->value->arch = CPU_INFO_ARCH_TRICORE;
+#elif defined(TARGET_S390X)
         s390_cpu = S390_CPU(cpu);
         env = &s390_cpu->env;
         info->value->arch = CPU_INFO_ARCH_S390;
         info->value->u.s390.cpu_state = env->cpu_state;
+#elif defined(TARGET_RISCV)
+        info->value->arch = CPU_INFO_ARCH_RISCV;
+#else
+        info->value->arch = CPU_INFO_ARCH_OTHER;
 #endif
         if (!cur_item) {
             head = cur_item = info;
diff --git a/qapi/misc.json b/qapi/misc.json
index 5636f4a149..104d013adb 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -573,7 +573,7 @@
             'mips': 'CpuInfoOther',
             'tricore': 'CpuInfoOther',
             's390': 'CpuInfoS390',
-            'riscv': 'CpuInfoRISCV',
+            'riscv': 'CpuInfoOther',
             'other': 'CpuInfoOther' } }
 
 ##
-- 
2.17.1
