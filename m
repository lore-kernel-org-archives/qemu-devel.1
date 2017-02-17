Received: from eggs.gnu.org ([2001:4830:134:3::10]:41309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1cemJR-0002m0-6b
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 12:27:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1cemJM-0001px-A2
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 12:27:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51987
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1cemJM-0001oa-3x
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 12:27:12 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1HHNx41077354
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 12:27:11 -0500
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28ngt9qksk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 12:27:10 -0500
Received: from localhost
	by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Fri, 17 Feb 2017 15:27:08 -0200
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.18.232.225])
	by d24dlp01.br.ibm.com (Postfix) with ESMTP id 5170B3520068
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 12:26:33 -0500 (EST)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
	by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v1HHR1ku35717250
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 15:27:06 -0200
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
	by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v1HHQkAf027218
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 15:26:46 -0200
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Fri, 17 Feb 2017 15:26:07 -0200
Message-Id: <20170217172607.25575-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] Changing error message of QMP
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
the expected parameter.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 migration/migration.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index c6ae69d..2dc63b1 100644
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
+        (params->downtime_limit < 0 ||
+         params->downtime_limit > MAX_MIGRATE_SET_DOWNTIME)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "downtime_limit",
-                   "an integer in the range of 0 to 2000000 milliseconds");
+                   "an integer in the range of 0 to 2000 seconds");
         return;
     }
     if (params->has_x_checkpoint_delay && (params->x_checkpoint_delay < 0)) {
-- 
2.9.3
