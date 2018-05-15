Received: from eggs.gnu.org ([2001:4830:134:3::10]:40301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.ibm.com>) id 1fIc7V-00019d-CQ
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:44:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.ibm.com>) id 1fIc7Q-0003dQ-Eg
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:44:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58158
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.ibm.com>)
	id 1fIc7Q-0003d7-8s
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:44:04 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4FFaQ8q103114
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 11:44:03 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2j01cm48et-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 11:44:02 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.ibm.com>;
	Tue, 15 May 2018 11:44:00 -0400
From: Daniel Henrique Barboza <danielhb@linux.ibm.com>
Date: Tue, 15 May 2018 12:43:53 -0300
Message-Id: <20180515154353.17691-1-danielhb@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v3 1/1] qmp.c: system_wakeup: adding
 RUN_STATE_SUSPENDED check before proceeding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb@linux.ibm.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>

The qmp/hmp command 'system_wakeup' is simply a direct call to
'qemu_system_wakeup_request' from vl.c. This function verifies if
runstate is SUSPENDED and if the wake up reason is valid before
proceeding.

However, no error or warning is thrown if any of those
pre-requirements isn't met. There is no way for the caller to
differentiate between a successful wakeup or an error state caused
when trying to wake up a guest that wasn't suspended. Silent
failures should be interpreted as bugs and there is no API break
in fixing this behavior - applications that didn't check the result
will remain broken, the ones that check will have a chance to deal
with it.

This patch changes qmp_system_wakeup to make the runstate verification
before proceeding to call qemu_system_wakeup_request, firing up
an error message if the user tries to wake up a machine that
isn't in SUSPENDED state. The change isn't made inside
qemu_system_wakeup_request because it is used in migration,
ACPI and others where this usage might be valid.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.ibm.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Eric Blake <eblake@redhat.com>
---

Changes in v3:
- improved commit message, as requested by Eric Blake
- added Eric's R-b

 hmp.c | 4 +++-
 qmp.c | 5 +++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/hmp.c b/hmp.c
index 898e25f3e1..2c4c867cab 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1156,7 +1156,9 @@ void hmp_cont(Monitor *mon, const QDict *qdict)
 
 void hmp_system_wakeup(Monitor *mon, const QDict *qdict)
 {
-    qmp_system_wakeup(NULL);
+    Error *err = NULL;
+    qmp_system_wakeup(&err);
+    hmp_handle_error(mon, &err);
 }
 
 void hmp_nmi(Monitor *mon, const QDict *qdict)
diff --git a/qmp.c b/qmp.c
index 25fdc9a5b2..9c1d0df1ab 100644
--- a/qmp.c
+++ b/qmp.c
@@ -205,6 +205,11 @@ void qmp_cont(Error **errp)
 
 void qmp_system_wakeup(Error **errp)
 {
+    if (!runstate_check(RUN_STATE_SUSPENDED)) {
+        error_setg(errp,
+                   "Unable to wake up: guest is not in suspended state");
+        return;
+    }
     qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER);
 }
 
-- 
2.14.3
