Received: from eggs.gnu.org ([2001:4830:134:3::10]:35080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eqfDq-00060i-Ip
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:23:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eqfDp-0000G9-94
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:23:10 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 27 Feb 2018 14:21:45 +0100
Message-Id: <20180227132150.13847-22-cohuck@redhat.com>
In-Reply-To: <20180227132150.13847-1-cohuck@redhat.com>
References: <20180227132150.13847-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 21/26] qmp: add architecture specific cpu data
 for query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

The s390 CPU state can be retrieved without interrupting the
VM execution. Extendend the CpuInfoFast union with architecture
specific data and an implementation for s390.

Return data looks like this:
 [
   {"thread-id":64301,"props":{"core-id":0},
    "arch":"s390","cpu-state":"operating",
    "qom-path":"/machine/unattached/device[0]","cpu-index":0},
   {"thread-id":64302,"props":{"core-id":1},
    "arch":"s390","cpu-state":"operating",
    "qom-path":"/machine/unattached/device[1]","cpu-index":1}
]

Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1518797321-28356-4-git-send-email-mihajlov@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 cpus.c           | 10 ++++++++++
 qapi-schema.json | 25 ++++++++++++++++++-------
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/cpus.c b/cpus.c
index 6df6660ccf..af678264f6 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2166,6 +2166,10 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     CpuInfoFastList *head = NULL, *cur_item = NULL;
     CPUState *cpu;
+#if defined(TARGET_S390X)
+    S390CPU *s390_cpu;
+    CPUS390XState *env;
+#endif
 
     CPU_FOREACH(cpu) {
         CpuInfoFastList *info = g_malloc0(sizeof(*info));
@@ -2183,6 +2187,12 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
             info->value->props = props;
         }
 
+#if defined(TARGET_S390X)
+        s390_cpu = S390_CPU(cpu);
+        env = &s390_cpu->env;
+        info->value->arch = CPU_INFO_ARCH_S390;
+        info->value->u.s390.cpu_state = env->cpu_state;
+#endif
         if (!cur_item) {
             head = cur_item = info;
         } else {
diff --git a/qapi-schema.json b/qapi-schema.json
index 815f072876..e6ca63f718 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -408,7 +408,7 @@
 # @CpuInfoArch:
 #
 # An enumeration of cpu types that enable additional information during
-# @query-cpus.
+# @query-cpus and @query-cpus-fast.
 #
 # @s390: since 2.12
 #
@@ -604,12 +604,24 @@
 # @props: properties describing to which node/socket/core/thread
 #         virtual CPU belongs to, provided if supported by board
 #
+# @arch: architecture of the cpu, which determines which additional fields
+#        will be listed
+#
 # Since: 2.12
 #
 ##
-{ 'struct': 'CpuInfoFast',
-  'data': {'cpu-index': 'int', 'qom-path': 'str',
-           'thread-id': 'int', '*props': 'CpuInstanceProperties' } }
+{ 'union': 'CpuInfoFast',
+  'base': {'cpu-index': 'int', 'qom-path': 'str',
+           'thread-id': 'int', '*props': 'CpuInstanceProperties',
+           'arch': 'CpuInfoArch' },
+  'discriminator': 'arch',
+  'data': { 'x86': 'CpuInfoOther',
+            'sparc': 'CpuInfoOther',
+            'ppc': 'CpuInfoOther',
+            'mips': 'CpuInfoOther',
+            'tricore': 'CpuInfoOther',
+            's390': 'CpuInfoS390',
+            'other': 'CpuInfoOther' } }
 
 ##
 # @query-cpus-fast:
@@ -620,9 +632,6 @@
 #
 # Returns: list of @CpuInfoFast
 #
-# Notes: The CPU architecture name is not returned by query-cpus-fast.
-#        Use query-target to retrieve that information.
-#
 # Since: 2.12
 #
 # Example:
@@ -637,6 +646,7 @@
 #                 "socket-id": 0
 #             },
 #             "qom-path": "/machine/unattached/device[0]",
+#             "arch":"x86",
 #             "cpu-index": 0
 #         },
 #         {
@@ -647,6 +657,7 @@
 #                 "socket-id": 1
 #             },
 #             "qom-path": "/machine/unattached/device[2]",
+#             "arch":"x86",
 #             "cpu-index": 1
 #         }
 #     ]
-- 
2.13.6
