Received: from eggs.gnu.org ([2001:4830:134:3::10]:32851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dOGUx-0005pJ-Ok
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 00:47:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dOGUw-0001EH-SC
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 00:47:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dOGUw-0001Dy-MQ
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 00:47:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9E32E1F580
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 04:47:09 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri, 23 Jun 2017 12:46:39 +0800
Message-Id: <1498193206-18007-4-git-send-email-peterx@redhat.com>
In-Reply-To: <1498193206-18007-1-git-send-email-peterx@redhat.com>
References: <1498193206-18007-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v5 03/10] vl: clean up global property
 registerations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

It's not that clear on how the global properties are registered to
global_props (and also its priority relationship). Let's provide a
single function to be called in main() for that, with comment to explain
it a bit.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 vl.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/vl.c b/vl.c
index 4452d7a..cdd2ec8 100644
--- a/vl.c
+++ b/vl.c
@@ -2969,6 +2969,25 @@ static int qemu_read_default_config_file(void)
     return 0;
 }
 
+static void user_register_compat_props(void)
+{
+    qemu_opts_foreach(qemu_find_opts("global"),
+                      global_init_func, NULL, NULL);
+}
+
+/*
+ * Note: we should see that these compat properties are actually
+ * having a priority: accel < machine < user. This means e.g. when
+ * user specifies something in "-global", it'll always be used with
+ * highest priority.
+ */
+static void register_global_properties(MachineState *ms)
+{
+    accel_register_compat_props(ms->accelerator);
+    machine_register_compat_props(ms);
+    user_register_compat_props();
+}
+
 int main(int argc, char **argv, char **envp)
 {
     int i;
@@ -4571,11 +4590,11 @@ int main(int argc, char **argv, char **envp)
             exit (i == 1 ? 1 : 0);
     }
 
-    accel_register_compat_props(current_machine->accelerator);
-    machine_register_compat_props(current_machine);
-
-    qemu_opts_foreach(qemu_find_opts("global"),
-                      global_init_func, NULL, NULL);
+    /*
+     * Register all the global properties, including accel properties,
+     * machine properties, and user-specified ones.
+     */
+    register_global_properties(current_machine);
 
     /* This checkpoint is required by replay to separate prior clock
        reading from the other reads, because timer polling functions query
-- 
2.7.4
