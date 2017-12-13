Received: from eggs.gnu.org ([2001:4830:134:3::10]:52681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1ePBZe-0007e8-82
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:16:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1ePBZa-0002Nh-5B
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:16:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50148
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1ePBZZ-0002NB-W4
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:16:02 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBDIDj8b107937
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 13:15:57 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2eu6k7rgra-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 13:15:57 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Wed, 13 Dec 2017 11:15:56 -0700
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Wed, 13 Dec 2017 16:15:39 -0200
In-Reply-To: <20171213181540.7949-1-danielhb@linux.vnet.ibm.com>
References: <20171213181540.7949-1-danielhb@linux.vnet.ibm.com>
Message-Id: <20171213181540.7949-2-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 1/2] qmp.c: (re)implement qmp_cpu
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

Commit 755f196898 ("qapi: Convert the cpu command") added the qmp_cpu
function in qmp.c, leaving it blank. It the same commit, a working
hmp_cpu was implemented. Since then, no further changes were made in
qmp_cpu, resulting now in a working 'cpu' command that works in HMP
and a 'cpu' command in QMP that does nothing.

Regardless of what constraints were involved that time in not implemeting
qmp_cpu, at this moment it is possible to have both. This patch brings
the logic of hmp_cpu to qmp_cpu and converts the HMP function to use its
QMP counterpart.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 hmp.c            |  8 +++-----
 qapi-schema.json | 14 +++++++++++---
 qmp.c            |  4 +++-
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/hmp.c b/hmp.c
index 35a7041824..7506f105a0 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1070,13 +1070,11 @@ void hmp_system_powerdown(Monitor *mon, const QDict *qdict)
 void hmp_cpu(Monitor *mon, const QDict *qdict)
 {
     int64_t cpu_index;
+    Error *err = NULL;
 
-    /* XXX: drop the monitor_set_cpu() usage when all HMP commands that
-            use it are converted to the QAPI */
     cpu_index = qdict_get_int(qdict, "index");
-    if (monitor_set_cpu(cpu_index) < 0) {
-        monitor_printf(mon, "invalid CPU index\n");
-    }
+    qmp_cpu(cpu_index, &err);
+    hmp_handle_error(mon, &err);
 }
 
 void hmp_memsave(Monitor *mon, const QDict *qdict)
diff --git a/qapi-schema.json b/qapi-schema.json
index 18457954a8..4c8f2d405e 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1048,11 +1048,19 @@
 ##
 # @cpu:
 #
-# This command is a nop that is only provided for the purposes of compatibility.
+# Set the default CPU.
 #
-# Since: 0.14.0
+# @index: The index of the virtual CPU to be set as default
+#
+# Returns: Nothing on success
+#
+# Since: 2.12.0
+#
+# Example:
+#
+# -> { "execute": "cpu", "arguments": { "index": 2 } }
+# <- { "return": {} }
 #
-# Notes: Do not use this command.
 ##
 { 'command': 'cpu', 'data': {'index': 'int'} }
 
diff --git a/qmp.c b/qmp.c
index e8c303116a..c482225d5c 100644
--- a/qmp.c
+++ b/qmp.c
@@ -115,7 +115,9 @@ void qmp_system_powerdown(Error **erp)
 
 void qmp_cpu(int64_t index, Error **errp)
 {
-    /* Just do nothing */
+    if (monitor_set_cpu(index) < 0) {
+        error_setg(errp, "Invalid CPU index");
+    }
 }
 
 void qmp_cpu_add(int64_t id, Error **errp)
-- 
2.13.6
