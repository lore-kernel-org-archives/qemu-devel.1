Received: from eggs.gnu.org ([2001:4830:134:3::10]:53726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fC93V-000659-EN
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:29:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fC93U-000106-3q
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:29:17 -0400
From: Laszlo Ersek <lersek@redhat.com>
Date: Fri, 27 Apr 2018 21:28:48 +0200
Message-Id: <20180427192852.15013-2-lersek@redhat.com>
In-Reply-To: <20180427192852.15013-1-lersek@redhat.com>
References: <20180427192852.15013-1-lersek@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/5] qapi: fill in CpuInfoFast.arch in
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
Cc: Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Viktor VM Mihajlovski <mihajlov@linux.vnet.ibm.com>, qemu-stable@nongnu.org

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
---

Notes:
    PATCHv3:
    
    - pick up Cornelia's and Markus's R-b's
    
    - no changes
    
    PATCHv2:
    
    - squash v1 patches 1/6 and 2/6 [Eric, Markus, Cornelia]
    
    - fix "added added" typo in the commit message [Eric]
    
    - update commit message wrt. S390X particulars [Cornelia, Markus,
      Viktor]
    
    - pick up Eric's R-b (synthesized from his R-b's for v1 1/6 & 2/6)
    
    - don't pick up Cornelia's R-b (only given for v1 1/6)
    
    - update the CC list
    
    PATCHv1:
    
    - new patch

 qapi/misc.json |  2 +-
 cpus.c         | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 5636f4a14997..104d013adba6 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -565,23 +565,23 @@
 { 'union': 'CpuInfoFast',
   'base': {'cpu-index': 'int', 'qom-path': 'str',
            'thread-id': 'int', '*props': 'CpuInstanceProperties',
            'arch': 'CpuInfoArch' },
   'discriminator': 'arch',
   'data': { 'x86': 'CpuInfoOther',
             'sparc': 'CpuInfoOther',
             'ppc': 'CpuInfoOther',
             'mips': 'CpuInfoOther',
             'tricore': 'CpuInfoOther',
             's390': 'CpuInfoS390',
-            'riscv': 'CpuInfoRISCV',
+            'riscv': 'CpuInfoOther',
             'other': 'CpuInfoOther' } }
 
 ##
 # @query-cpus-fast:
 #
 # Returns information about all virtual CPUs. This command does not
 # incur a performance penalty and should be used in production
 # instead of query-cpus.
 #
 # Returns: list of @CpuInfoFast
 #
diff --git a/cpus.c b/cpus.c
index 38eba8bff334..60563a6d54ec 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2210,27 +2210,41 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
         info->value->qom_path = object_get_canonical_path(OBJECT(cpu));
         info->value->thread_id = cpu->thread_id;
 
         info->value->has_props = !!mc->cpu_index_to_instance_props;
         if (info->value->has_props) {
             CpuInstanceProperties *props;
             props = g_malloc0(sizeof(*props));
             *props = mc->cpu_index_to_instance_props(ms, cpu->cpu_index);
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
         } else {
             cur_item->next = info;
             cur_item = info;
         }
     }
 
     return head;
 }
-- 
2.14.1.3.gb7cf6e02401b
