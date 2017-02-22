Received: from eggs.gnu.org ([2001:4830:134:3::10]:53158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1cgYgd-00062L-9q
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 10:18:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1cgYga-0004vR-4f
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 10:18:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37960
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1cgYgZ-0004uV-UY
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 10:18:32 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1MF9pTW062134
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 10:18:31 -0500
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28s9r42dsa-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 10:18:30 -0500
Received: from localhost
	by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Wed, 22 Feb 2017 12:18:27 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.18.232.42])
	by d24dlp01.br.ibm.com (Postfix) with ESMTP id 1BC34352005F
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 10:17:52 -0500 (EST)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
	by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v1MFIKpj39911492
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 12:18:25 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
	by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v1MFI5G3030281
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 12:18:05 -0300
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Wed, 22 Feb 2017 12:17:29 -0300
Message-Id: <20170222151729.5812-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3] Changing error message of QMP
 'migrate_set_downtime' to seconds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, dgilbert@redhat.com

Using QMP, the error message of 'migrate_set_downtime' was displaying
the values in milliseconds, being misleading with the command that
accepts the value in seconds:

{ "execute": "migrate_set_downtime", "arguments": {"value": 3000}}
{"error": {"class": "GenericError", "desc": "Parameter 'downtime_limit'
expects an integer in the range of 0 to 2000000 milliseconds"}}

This message is also seen in HMP when trying to set the same
parameter:

(qemu) migrate_set_parameter downtime-limit 3000000
Parameter 'downtime_limit' expects an integer in the range of 0 to
2000000 milliseconds

To allow for a proper error message when using QMP, a validation
of the user input was added in 'qmp_migrate_set_downtime'.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 migration/migration.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index c6ae69d..4fab538 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -49,6 +49,10 @@
  * for sending the last part */
 #define DEFAULT_MIGRATE_SET_DOWNTIME 300
 
+/* Maximum migrate downtime set to 2000 seconds */
+#define MAX_MIGRATE_DOWNTIME_SECONDS 2000
+#define MAX_MIGRATE_DOWNTIME (MAX_MIGRATE_DOWNTIME_SECONDS * 1000)
+
 /* Default compression thread count */
 #define DEFAULT_MIGRATE_COMPRESS_THREAD_COUNT 8
 /* Default decompression thread count, usually decompression is at
@@ -843,10 +847,11 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
         return;
     }
     if (params->has_downtime_limit &&
-        (params->downtime_limit < 0 || params->downtime_limit > 2000000)) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "downtime_limit",
-                   "an integer in the range of 0 to 2000000 milliseconds");
+        (params->downtime_limit < 0 ||
+         params->downtime_limit > MAX_MIGRATE_DOWNTIME)) {
+        error_setg(errp, "Parameter 'downtime_limit' expects an integer in "
+                         "the range of 0 to %d milliseconds",
+                         MAX_MIGRATE_DOWNTIME);
         return;
     }
     if (params->has_x_checkpoint_delay && (params->x_checkpoint_delay < 0)) {
@@ -1289,6 +1294,13 @@ void qmp_migrate_set_speed(int64_t value, Error **errp)
 
 void qmp_migrate_set_downtime(double value, Error **errp)
 {
+    if (value < 0 || value > MAX_MIGRATE_DOWNTIME_SECONDS) {
+        error_setg(errp, "Parameter 'downtime_limit' expects an integer in "
+                         "the range of 0 to %d seconds",
+                         MAX_MIGRATE_DOWNTIME_SECONDS);
+        return;
+    }
+
     value *= 1000; /* Convert to milliseconds */
     value = MAX(0, MIN(INT64_MAX, value));
 
-- 
2.9.3
