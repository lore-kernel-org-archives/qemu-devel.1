Received: from eggs.gnu.org ([2001:4830:134:3::10]:45476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1e3zRB-0001kz-HO
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 03:03:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1e3zR8-0003Mv-DX
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 03:03:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46820
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1e3zR8-0003MD-7z
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 03:03:42 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9G72b6W036262
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 03:03:38 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dmq08a9k2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 03:03:37 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Mon, 16 Oct 2017 08:03:36 +0100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id v9G73Vbs27459738
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 07:03:33 GMT
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v9G73MJE017662
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 18:03:22 +1100
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Mon, 16 Oct 2017 12:33:26 +0530
Message-Id: <1508137406-5222-1-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [FIX PATCH] monitor: Don't return CPU marked for
 unplug as monitor CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, armbru@redhat.com, sathnaga@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.vnet.ibm.com>

The following sequence of steps kill the QEMU:

- Hotplug a CPU
- Change the default CPU to the newly hotplugged cpu using "cpu" HMP command.
- Hot unplug the CPU
- Run "info cpus"

Fix this by not letting monitor_get_cpu() to return a CPU which is marked
for unplug.

Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 monitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor.c b/monitor.c
index fe0d1bd..8d60e57 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1053,7 +1053,7 @@ int monitor_set_cpu(int cpu_index)
 
 CPUState *mon_get_cpu(void)
 {
-    if (!cur_mon->mon_cpu) {
+    if (!cur_mon->mon_cpu || cur_mon->mon_cpu->unplug) {
         if (!first_cpu) {
             return NULL;
         }
-- 
2.7.4
