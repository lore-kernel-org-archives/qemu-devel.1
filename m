Received: from eggs.gnu.org ([2001:4830:134:3::10]:39869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cih5U-0007v9-BF
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cih5S-00007C-Jx
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cih5S-00005D-BZ
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:02 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 28 Feb 2017 12:40:30 +0000
Message-Id: <20170228124056.5074-2-dgilbert@redhat.com>
In-Reply-To: <20170228124056.5074-1-dgilbert@redhat.com>
References: <20170228124056.5074-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 01/27] Changing error message of QMP
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
Cc: quintela@redhat.com, lvivier@redhat.com, marcandre.lureau@redhat.com, vsementsov@virtuozzo.com, danielhb@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, ashijeetacharya@gmail.com

From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

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
Message-Id: <20170222151729.5812-1-danielhb@linux.vnet.ibm.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
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
