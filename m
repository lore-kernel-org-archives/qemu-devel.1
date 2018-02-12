Received: from eggs.gnu.org ([2001:4830:134:3::10]:56051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@de.ibm.com>) id 1elD0p-000731-NO
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 07:15:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@de.ibm.com>) id 1elD0k-0008J0-CP
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 07:15:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46942
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@de.ibm.com>) id 1elD0k-0008Hu-5Z
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 07:15:06 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1CCEsMq050894
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 07:15:03 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g3977bvt6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 07:14:59 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@de.ibm.com>;
	Mon, 12 Feb 2018 12:14:42 -0000
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Mon, 12 Feb 2018 13:14:32 +0100
In-Reply-To: <1518437672-7724-1-git-send-email-mihajlov@linux.vnet.ibm.com>
References: <1518437672-7724-1-git-send-email-mihajlov@linux.vnet.ibm.com>
Message-Id: <1518437672-7724-4-git-send-email-mihajlov@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 3/3] qmp: add architecture specific cpu data
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
Cc: qemu-s390x@nongnu.org, lcapitulino@redhat.com, ehabkost@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, dgilbert@redhat.com, rth@twiddle.net, cohuck@redhat.com, borntraeger@de.ibm.com, agraf@suse.de, david@redhat.com, eblake@redhat.com, armbru@redhat.com, berrange@redhat.com

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

Currently there's a certain amount of duplication between
the definitions of CpuInfo and CpuInfoFast, both in the
base and variable areas, since there are data fields common
to the slow and fast variants.

A suggestion was made on the mailing list to enhance the QAPI
code generation to support two layers of unions. This would
allow to specify the common fields once and avoid the duplication
in the leaf unions.

On the other hand, the slow query-cpus should be deprecated
along with the slow CpuInfo type and eventually be removed.
Assuming that new architectures will not be added at high
rates, we could live with the duplication for the time being.

Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
---
 cpus.c           | 10 ++++++++++
 hmp.c            |  8 ++++++++
 qapi-schema.json | 35 +++++++++++++++++++++++++++++------
 3 files changed, 47 insertions(+), 6 deletions(-)

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
index 598bfe5..94bfc7d 100644
--- a/hmp.c
+++ b/hmp.c
@@ -425,6 +425,14 @@ void hmp_info_cpus_fast(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "CPU%" PRId64 "\n", cpu->value->cpu_index);
         monitor_printf(mon, " thread-id=%" PRId64 "\n", cpu->value->thread_id);
         monitor_printf(mon, " qom-path=%s\n", cpu->value->qom_path);
+        switch (cpu->value->arch) {
+        case CPU_INFO_ARCH_S390:
+            monitor_printf(mon, " state=%s\n",
+                           CpuS390State_str(cpu->value->u.s390.cpu_state));
+            break;
+        default:
+            break;
+        }
         monitor_printf(mon, "\n");
     }
 
diff --git a/qapi-schema.json b/qapi-schema.json
index 2a614af..a681d83 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -537,15 +537,26 @@
   'data': [ 'uninitialized', 'stopped', 'check-stop', 'operating', 'load' ] }
 
 ##
-# @CpuInfoS390:
+# @CpuInfoS390Fast:
 #
-# Additional information about a virtual S390 CPU
+# Additional information about a virtual S390 CPU which can be
+# obtained without a performance penalty for a running VM
 #
 # @cpu-state: the virtual CPU's state
 #
 # Since: 2.12
 ##
-{ 'struct': 'CpuInfoS390', 'data': { 'cpu-state': 'CpuS390State' } }
+{ 'struct': 'CpuInfoS390Fast', 'data': { 'cpu-state': 'CpuS390State' } }
+
+##
+# @CpuInfoS390:
+#
+# Additional information about a virtual S390 CPU, potentially expensive
+# to obtain
+#
+# Since: 2.12
+##
+{ 'struct': 'CpuInfoS390', 'base': 'CpuInfoS390Fast', 'data': { } }
 
 ##
 # @query-cpus:
@@ -604,12 +615,24 @@
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
+            's390': 'CpuInfoS390Fast',
+            'other': 'CpuInfoOther' } }
 
 ##
 # @query-cpus-fast:
-- 
1.9.1
