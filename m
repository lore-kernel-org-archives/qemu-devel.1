Received: from eggs.gnu.org ([2001:4830:134:3::10]:52683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1ePBZe-0007e9-8t
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:16:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1ePBZb-0002Oc-2X
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:16:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49386
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1ePBZa-0002OB-T4
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:16:02 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBDIDkgR005441
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 13:16:02 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2eu6mmrtan-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 13:16:02 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Wed, 13 Dec 2017 11:16:01 -0700
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Wed, 13 Dec 2017 16:15:40 -0200
In-Reply-To: <20171213181540.7949-1-danielhb@linux.vnet.ibm.com>
References: <20171213181540.7949-1-danielhb@linux.vnet.ibm.com>
Message-Id: <20171213181540.7949-3-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 2/2] cpus.c: change qmp_query_cpus
 'value->current' logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, armbru@redhat.com, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

qmp_query_cpus always return the same information, ignoring the
monitor state. This means that information such as cpu->value->current
will always return the same value ((cpu == first_cpu) at this moment).
This function is used by hmp_info_cpus that does its own logic based on
monitor_get_cpu_index() to print the current/active CPU information,
ignoring cpu->value->current. This value is used as is in QMP
query-cpus though.

This wasn't a problem because QMP couldn't set its current CPU via
qmp_cpu anyway, so query-cpus returning the same state all the time
(regarding current CPU for the monitor) wasn't a problem. But now
we can use qmp_cpu to set the current monitor CPU, making the return
from query-cpus wrong.

This patch makes a simple change in qmp_query_cpus to change the
cpu->value->current logic to consider the current monitor state,
like it was being done in hmp_info_cpus. Now, cpu->value->current
will return an accurate value for both QMP and HMP calls. hmp_info_cpus
can no use this value directly instead of doing its own logic.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 cpus.c | 2 +-
 hmp.c  | 6 +-----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/cpus.c b/cpus.c
index 114c29b6a0..d3b79d1c02 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1919,7 +1919,7 @@ CpuInfoList *qmp_query_cpus(Error **errp)
         info = g_malloc0(sizeof(*info));
         info->value = g_malloc0(sizeof(*info->value));
         info->value->CPU = cpu->cpu_index;
-        info->value->current = (cpu == first_cpu);
+        info->value->current = (cpu->cpu_index == monitor_get_cpu_index());
         info->value->halted = cpu->halted;
         info->value->qom_path = object_get_canonical_path(OBJECT(cpu));
         info->value->thread_id = cpu->thread_id;
diff --git a/hmp.c b/hmp.c
index 7506f105a0..1259cafc1f 100644
--- a/hmp.c
+++ b/hmp.c
@@ -363,11 +363,7 @@ void hmp_info_cpus(Monitor *mon, const QDict *qdict)
     cpu_list = qmp_query_cpus(NULL);
 
     for (cpu = cpu_list; cpu; cpu = cpu->next) {
-        int active = ' ';
-
-        if (cpu->value->CPU == monitor_get_cpu_index()) {
-            active = '*';
-        }
+        int active = cpu->value->current ? '*' : ' ';
 
         monitor_printf(mon, "%c CPU #%" PRId64 ":", active, cpu->value->CPU);
 
-- 
2.13.6
