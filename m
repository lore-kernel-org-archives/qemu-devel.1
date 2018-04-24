Received: from eggs.gnu.org ([2001:4830:134:3::10]:32873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fB5lK-0002lJ-5P
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 17:46:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fB5lG-000725-Ub
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 17:46:10 -0400
From: Laszlo Ersek <lersek@redhat.com>
Date: Tue, 24 Apr 2018 23:45:45 +0200
Message-Id: <20180424214550.32549-2-lersek@redhat.com>
In-Reply-To: <20180424214550.32549-1-lersek@redhat.com>
References: <20180424214550.32549-1-lersek@redhat.com>
Subject: [Qemu-devel] [PATCH 1/6] qapi: fill in CpuInfoFast.arch in
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
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, qemu-stable@nongnu.org

Commit ca230ff33f89 added added the @arch field to @CpuInfoFast, but it
failed to set the new field in qmp_query_cpus_fast(), when TARGET_S390X
was not defined. The updated @query-cpus-fast example in
"qapi-schema.json" showed "arch":"x86" only because qmp_query_cpus_fast()
calls g_malloc0() to allocate CpuInfoFast, and the CPU_INFO_ARCH_X86 enum
constant is generated with value 0.

All @arch values other than @s390 implied the @CpuInfoOther sub-struct for
@CpuInfoFast -- at the time of writing the patch --, thus no fields other
than @arch needed to be set when TARGET_S390X was not defined. Set @arch
now, by copying the corresponding assignments from qmp_query_cpus().

Cc: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: qemu-stable@nongnu.org
Fixes: ca230ff33f89bf7102cbfbc2328716da6750aaed
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---

Notes:
    PATCHv1:
    
    - new patch

 cpus.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/cpus.c b/cpus.c
index 38eba8bff334..1a9a2edee1f2 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2210,27 +2210,39 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
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
