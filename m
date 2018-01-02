Received: from eggs.gnu.org ([2001:4830:134:3::10]:59325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eWQ1q-0006u5-Au
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 12:07:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eWQ1m-0000cr-8L
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 12:07:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33332
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eWQ1m-0000c7-2W
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 12:07:02 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	w02H3fHN082111
	for <qemu-devel@nongnu.org>; Tue, 2 Jan 2018 12:07:01 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2f8700rsnp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 12:07:00 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 2 Jan 2018 12:07:00 -0500
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue,  2 Jan 2018 15:06:45 -0200
Message-Id: <20180102170645.5877-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH RESEND 1/1] qmp.c: system_wakeup: adding
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
Cc: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

The qmp/hmp command 'system_wakeup' is simply a direct call to
'qemu_system_wakeup_request' from vl.c. This function verifies if
runstate is SUSPENDED and if the wake up reason is valid before
proceeding. However, no error or warning is thrown if any of those
pre-requirements isn't met.

This leads to situations such as the one described in
https://github.com/open-power-host-os/qemu/issues/31, where one
can induce the OS to be suspended by using pm-suspend (via
dompmsuspend, for example) but for some reason the machine failed to
go to the SUSPENDED runstate, staying at runstate RUNNING. The user
then tries to wake up the guest using system_wakeup (or dompmwakeup),
no error is thrown but nothing happened either because the wake up
wasn't fired at all. In the end, the user is left with a guest that
is dormant and believing that system_wakeup isn't working.

This patch changes qmp_system_wakeup to make the runstate verification
before proceeding to call qemu_system_wakeup_request, firing up
an error message if the user tries to wake up a machine that
isn't in SUSPENDED state. The change isn't made inside
qemu_system_wakeup_request because it is used in migration,
ACPI and others where this usage might be valid. This patch
by no means fixes the situation described above, but it can direct
the user/management closer to the real problem.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
CC: Markus Armbruster <armbru@redhat.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp.c | 4 +++-
 qmp.c | 5 +++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/hmp.c b/hmp.c
index 35a7041824..2c2326a00e 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1158,7 +1158,9 @@ void hmp_cont(Monitor *mon, const QDict *qdict)
 
 void hmp_system_wakeup(Monitor *mon, const QDict *qdict)
 {
-    qmp_system_wakeup(NULL);
+    Error *err = NULL;
+    qmp_system_wakeup(&err);
+    hmp_handle_error(mon, &err);
 }
 
 void hmp_nmi(Monitor *mon, const QDict *qdict)
diff --git a/qmp.c b/qmp.c
index 52cfd2d81c..d0be43fa1a 100644
--- a/qmp.c
+++ b/qmp.c
@@ -201,6 +201,11 @@ void qmp_cont(Error **errp)
 
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
2.13.6
