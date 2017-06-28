Received: from eggs.gnu.org ([2001:4830:134:3::10]:49960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dQBBp-0002sx-9a
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dQBBk-0004VC-Ti
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:31:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dQBBk-0004U6-OT
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:31:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C19594E4D2
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 11:31:15 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 28 Jun 2017 13:30:55 +0200
Message-Id: <20170628113106.5248-4-quintela@redhat.com>
In-Reply-To: <20170628113106.5248-1-quintela@redhat.com>
References: <20170628113106.5248-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 03/14] vl: clean up global property registration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

From: Peter Xu <peterx@redhat.com>

It's not that clear on how the global properties are registered to
global_props (and also its priority relationship). Let's provide a
single function to be called in main() for that, with comment to explain
it a bit.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <1498536619-14548-4-git-send-email-peterx@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 vl.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/vl.c b/vl.c
index 4452d7a..c0cdb17 100644
--- a/vl.c
+++ b/vl.c
@@ -2969,6 +2969,25 @@ static int qemu_read_default_config_file(void)
     return 0;
 }
 
+static void user_register_global_props(void)
+{
+    qemu_opts_foreach(qemu_find_opts("global"),
+                      global_init_func, NULL, NULL);
+}
+
+/*
+ * Note: we should see that these properties are actually having a
+ * priority: accel < machine < user. This means e.g. when user
+ * specifies something in "-global", it'll always be used with highest
+ * priority than either machine/accelerator compat properties.
+ */
+static void register_global_properties(MachineState *ms)
+{
+    accel_register_compat_props(ms->accelerator);
+    machine_register_compat_props(ms);
+    user_register_global_props();
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
2.9.4
