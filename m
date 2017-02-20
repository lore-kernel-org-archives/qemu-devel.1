Received: from eggs.gnu.org ([2001:4830:134:3::10]:47898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1cfqRM-0006O6-Ia
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 11:03:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1cfqRH-0004ys-Iu
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 11:03:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1cfqRH-0004yM-9i
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 11:03:47 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1KFdOPn141450
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 11:03:45 -0500
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28qw8ws3hf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 11:03:44 -0500
Received: from localhost
	by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Mon, 20 Feb 2017 13:03:41 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.18.232.42])
	by d24dlp02.br.ibm.com (Postfix) with ESMTP id A85601DC006D
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 11:03:40 -0500 (EST)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
	by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v1KG3dYi32112794
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 13:03:39 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
	by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v1KG3cIE010467
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 13:03:39 -0300
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Mon, 20 Feb 2017 13:03:16 -0300
Message-Id: <20170220160316.16803-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2] Changing error message of QMP
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

The previous error message was displaying the values in miliseconds,
being misleading with the command that accepts the value in seconds:

{ "execute": "migrate_set_downtime", "arguments": {"value": 3000}}
{"error": {"class": "GenericError", "desc": "Parameter 'downtime_limit'
expects an integer in the range of 0 to 2000000 milliseconds"}}

This patch changes it to '2000 seconds' to keep consistency with
the expected parameter. The macro 'QERR_INVALID_PARAMETER_VALUE'
was changed for a regular string that allows the use of the
MAX_MIGRATE_SET_DOWNTIME as a parameter, instead of hardcoding
the value in the error message.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 migration/migration.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index c6ae69d..c05e764 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -49,6 +49,9 @@
  * for sending the last part */
 #define DEFAULT_MIGRATE_SET_DOWNTIME 300
 
+/* Maximum migrate downtime set to 2000*1000 miliseconds */
+#define MAX_MIGRATE_SET_DOWNTIME (2000 * 1000)
+
 /* Default compression thread count */
 #define DEFAULT_MIGRATE_COMPRESS_THREAD_COUNT 8
 /* Default decompression thread count, usually decompression is at
@@ -843,10 +846,11 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
         return;
     }
     if (params->has_downtime_limit &&
-        (params->downtime_limit < 0 || params->downtime_limit > 2000000)) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "downtime_limit",
-                   "an integer in the range of 0 to 2000000 milliseconds");
+        (params->downtime_limit < 0 ||
+         params->downtime_limit > MAX_MIGRATE_SET_DOWNTIME)) {
+        error_setg(errp, "Parameter 'downtime_limit' expects an integer in "
+                         "the range of 0 to %d seconds",
+                         MAX_MIGRATE_SET_DOWNTIME / 1000);
         return;
     }
     if (params->has_x_checkpoint_delay && (params->x_checkpoint_delay < 0)) {
-- 
2.9.3
