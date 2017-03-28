Received: from eggs.gnu.org ([2001:4830:134:3::10]:40372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cst30-0007hG-J3
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:28:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cst2w-00072d-Fz
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:28:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35743)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cst2w-00072U-7Y
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:28:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4713E7E9EE
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 15:28:33 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 28 Mar 2017 16:27:43 +0100
Message-Id: <20170328152745.28186-5-dgilbert@redhat.com>
In-Reply-To: <20170328152745.28186-1-dgilbert@redhat.com>
References: <20170328152745.28186-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 4/6] migration/announce: Update hmp migrate
 parameter info/set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, lvivier@redhat.com
Cc: kashyap@redhat.com, germano@redhat.com, armbru@redhat.com, jasowang@redhat.com, jdenemar@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add the new announce parameters to HMPs migrate_parameter commands.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/hmp.c b/hmp.c
index edb8970..83a982a 100644
--- a/hmp.c
+++ b/hmp.c
@@ -285,6 +285,22 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
 
     if (params) {
         monitor_printf(mon, "parameters:");
+        assert(params->has_announce_initial);
+        monitor_printf(mon, " %s: %" PRId64,
+            MigrationParameter_lookup[MIGRATION_PARAMETER_ANNOUNCE_INITIAL],
+            params->announce_initial);
+        assert(params->has_announce_max);
+        monitor_printf(mon, " %s: %" PRId64,
+            MigrationParameter_lookup[MIGRATION_PARAMETER_ANNOUNCE_MAX],
+            params->announce_max);
+        assert(params->has_announce_rounds);
+        monitor_printf(mon, " %s: %" PRId64,
+            MigrationParameter_lookup[MIGRATION_PARAMETER_ANNOUNCE_ROUNDS],
+            params->announce_rounds);
+        assert(params->has_announce_step);
+        monitor_printf(mon, " %s: %" PRId64,
+            MigrationParameter_lookup[MIGRATION_PARAMETER_ANNOUNCE_STEP],
+            params->announce_step);
         assert(params->has_compress_level);
         monitor_printf(mon, " %s: %" PRId64,
             MigrationParameter_lookup[MIGRATION_PARAMETER_COMPRESS_LEVEL],
@@ -1354,6 +1370,22 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         if (strcmp(param, MigrationParameter_lookup[i]) == 0) {
             MigrationParameters p = { 0 };
             switch (i) {
+            case MIGRATION_PARAMETER_ANNOUNCE_INITIAL:
+                p.has_announce_initial = true;
+                use_int_value = true;
+                break;
+            case MIGRATION_PARAMETER_ANNOUNCE_MAX:
+                p.has_announce_max = true;
+                use_int_value = true;
+                break;
+            case MIGRATION_PARAMETER_ANNOUNCE_ROUNDS:
+                p.has_announce_rounds = true;
+                use_int_value = true;
+                break;
+            case MIGRATION_PARAMETER_ANNOUNCE_STEP:
+                p.has_announce_step = true;
+                use_int_value = true;
+                break;
             case MIGRATION_PARAMETER_COMPRESS_LEVEL:
                 p.has_compress_level = true;
                 use_int_value = true;
@@ -1410,6 +1442,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
                 }
                 /* Set all integers; only one has_FOO will be set, and
                  * the code ignores the remaining values */
+                p.announce_initial = valueint;
+                p.announce_max = valueint;
+                p.announce_rounds = valueint;
+                p.announce_step = valueint;
                 p.compress_level = valueint;
                 p.compress_threads = valueint;
                 p.decompress_threads = valueint;
-- 
2.9.3
