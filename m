Received: from eggs.gnu.org ([2001:4830:134:3::10]:50948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@de.ibm.com>) id 1emGeh-0006CT-Ul
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 05:20:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@de.ibm.com>) id 1emGed-0001xN-D6
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 05:20:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37602
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@de.ibm.com>) id 1emGed-0001xF-7O
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 05:20:39 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1FAEIEo040014
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 05:20:38 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g57yj12jp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 05:20:38 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@de.ibm.com>;
	Thu, 15 Feb 2018 10:20:36 -0000
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Thu, 15 Feb 2018 11:20:26 +0100
In-Reply-To: <1518690027-31318-1-git-send-email-mihajlov@linux.vnet.ibm.com>
References: <1518690027-31318-1-git-send-email-mihajlov@linux.vnet.ibm.com>
Message-Id: <1518690027-31318-4-git-send-email-mihajlov@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCHv3 3/4] qmp: add architecture specific cpu data
 for query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: agraf@suse.de, ehabkost@redhat.com, armbru@redhat.com, cohuck@redhat.com, david@redhat.com, dgilbert@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, eblake@redhat.com

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
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Acked-by: Eric Blake <eblake@redhat.com>
---
 cpus.c           | 10 ++++++++++
 hmp.c            | 10 ++++++++++
 qapi-schema.json | 25 ++++++++++++++++++-------
 3 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/cpus.c b/cpus.c
index 6df6660..af67826 100644
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
diff --git a/hmp.c b/hmp.c
index 0bd3b3a..e27433e 100644
--- a/hmp.c
+++ b/hmp.c
@@ -418,6 +418,16 @@ void hmp_info_cpus_fast(Monitor *mon, const QDict *qdict)
 
     for (cpu = head; cpu; cpu = cpu->next) {
         monitor_printf(mon, "  CPU #%" PRId64 ":", cpu->value->cpu_index);
+
+        switch (cpu->value->arch) {
+        case CPU_INFO_ARCH_S390:
+            monitor_printf(mon, " state=%s",
+                           CpuS390State_str(cpu->value->u.s390.cpu_state));
+            break;
+        default:
+            break;
+        }
+
         monitor_printf(mon, " thread-id=%" PRId64 "\n", cpu->value->thread_id);
     }
 
diff --git a/qapi-schema.json b/qapi-schema.json
index 815f072..e6ca63f 100644
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
1.9.1
