Received: from eggs.gnu.org ([2001:4830:134:3::10]:52133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dDafO-0003oQ-Vt
	for qemu-devel@nongnu.org; Wed, 24 May 2017 14:05:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dDafL-0001JV-58
	for qemu-devel@nongnu.org; Wed, 24 May 2017 14:05:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vyasevic@redhat.com>) id 1dDafK-0001JJ-S1
	for qemu-devel@nongnu.org; Wed, 24 May 2017 14:05:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D64F3C056793
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 18:05:45 +0000 (UTC)
From: Vladislav Yasevich <vyasevic@redhat.com>
Date: Wed, 24 May 2017 14:05:17 -0400
Message-Id: <1495649128-10529-2-git-send-email-vyasevic@redhat.com>
In-Reply-To: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
Subject: [Qemu-devel] [PATCH 01/12] migration: Introduce announce parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com
Cc: germano@redhat.com, lvivier@redhat.com, jasowang@redhat.com, jdenemar@redhat.com, kashyap@redhat.com, armbru@redhat.com, mst@redhat.com, Vladislav Yasevich <vyasevic@redhat.com>

Add parameters that control RARP/GARP announcement timeouts.
The parameters structure is added to the QAPI and a qmp command
is added to set/get the parameter data.

Based on work by "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
---
 include/sysemu/sysemu.h |  7 ++++
 migration/savevm.c      | 98 +++++++++++++++++++++++++++++++++++++++++++++++++
 qapi-schema.json        | 84 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 189 insertions(+)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 83c1ceb..7fd49c4 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -78,6 +78,13 @@ void qemu_remove_machine_init_done_notifier(Notifier *notify);
 int save_vmstate(const char *name, Error **errp);
 int load_vmstate(const char *name, Error **errp);
 
+AnnounceParameters *qemu_get_announce_params(void);
+void qemu_fill_announce_parameters(AnnounceParameters **to,
+                                   AnnounceParameters *from);
+bool qemu_validate_announce_parameters(AnnounceParameters *params,
+                                       Error **errp);
+void qemu_set_announce_parameters(AnnounceParameters *announce_params,
+                                  AnnounceParameters *params);
 void qemu_announce_self(void);
 
 /* Subcommands for QEMU_VM_COMMAND */
diff --git a/migration/savevm.c b/migration/savevm.c
index f5e8194..cee2837 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -78,6 +78,104 @@ static struct mig_cmd_args {
     [MIG_CMD_MAX]              = { .len = -1, .name = "MAX" },
 };
 
+#define QEMU_ANNOUNCE_INITIAL    50
+#define QEMU_ANNOUNCE_MAX       550
+#define QEMU_ANNOUNCE_ROUNDS      5
+#define QEMU_ANNOUNCE_STEP      100
+
+AnnounceParameters *qemu_get_announce_params(void)
+{
+    static AnnounceParameters announce = {
+        .initial = QEMU_ANNOUNCE_INITIAL,
+        .max = QEMU_ANNOUNCE_MAX,
+        .rounds = QEMU_ANNOUNCE_ROUNDS,
+        .step = QEMU_ANNOUNCE_STEP,
+    };
+
+    return &announce;
+}
+
+void qemu_fill_announce_parameters(AnnounceParameters **to,
+                                   AnnounceParameters *from)
+{
+    AnnounceParameters *params;
+
+    params = *to = g_malloc0(sizeof(*params));
+    params->has_initial = true;
+    params->initial = from->initial;
+    params->has_max = true;
+    params->max = from->max;
+    params->has_rounds = true;
+    params->rounds = from->rounds;
+    params->has_step = true;
+    params->step = from->step;
+}
+
+bool qemu_validate_announce_parameters(AnnounceParameters *params, Error **errp)
+{
+    if (params->has_initial &&
+        (params->initial < 1 || params->initial > 100000)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "initial",
+                   "is invalid, it should be in the range of 1 to 100000 ms");
+        return false;
+    }
+    if (params->has_max &&
+        (params->max < 1 || params->max > 100000)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "max",
+                   "is invalid, it should be in the range of 1 to 100000 ms");
+        return false;
+    }
+    if (params->has_rounds &&
+        (params->rounds < 1 || params->rounds > 1000)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "rounds",
+                   "is invalid, it should be in the range of 1 to 1000");
+        return false;
+    }
+    if (params->has_step &&
+        (params->step < 0 || params->step > 10000)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "step",
+                   "is invalid, it should be in the range of 1 to 10000 ms");
+        return false;
+    }
+
+    return true;
+}
+
+void qemu_set_announce_parameters(AnnounceParameters *announce_params,
+                                  AnnounceParameters *params)
+{
+    if (params->has_initial) {
+        announce_params->initial = params->initial;
+    }
+    if (params->has_max) {
+        announce_params->max = params->max;
+    }
+    if (params->has_rounds) {
+        announce_params->rounds = params->rounds;
+    }
+    if (params->has_step) {
+        announce_params->step = params->step;
+    }
+}
+
+AnnounceParameters *qmp_query_announce_parameters(Error **errp)
+{
+    AnnounceParameters *params = NULL;
+
+    qemu_fill_announce_parameters(&params, qemu_get_announce_params());
+    return params;
+}
+
+void qmp_announce_set_parameters(AnnounceParameters *params, Error **errp)
+{
+    AnnounceParameters *current = qemu_get_announce_params();
+
+    if (!qemu_validate_announce_parameters(params, errp))
+        return;
+
+    qemu_set_announce_parameters(current, params);
+}
+
 static int announce_self_create(uint8_t *buf,
                                 uint8_t *mac_addr)
 {
diff --git a/qapi-schema.json b/qapi-schema.json
index 80603cf..2030087 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -569,6 +569,90 @@
 ##
 { 'command': 'query-events', 'returns': ['EventInfo'] }
 
+
+##
+# @AnnounceParameter:
+#
+# @AnnounceParameter enumeration
+#
+# @initial: Initial delay (in ms) before sending the first GARP/RARP
+#       announcement
+#
+# @max: Maximum delay (in ms) to between GARP/RARP announcemnt packets
+#
+# @rounds: Number of self-announcement attempts
+#
+# @step: Delay increate (in ms) after each self-announcment attempt
+#
+# Since: 2.10
+##
+{ 'enum' : 'AnnounceParameter',
+  'data' : [ 'initial', 'max', 'rounds', 'step' ] }
+
+##
+# @AnnounceParameters:
+#
+# Optional members may be omited on input, but all values will be present
+# on output.
+#           
+# @initial: Initial delay (in ms) before sending the first GARP/RARP
+#       announcement
+#
+# @max: Maximum delay (in ms) to between GARP/RARP announcemnt packets
+#
+# @rounds: Number of self-announcement attempts
+#
+# @step: Delay increate (in ms) after each self-announcment attempt
+#
+# Since: 2.10
+##
+
+{ 'struct': 'AnnounceParameters',
+  'data': { '*initial': 'int',
+            '*max': 'int',
+            '*rounds': 'int',
+            '*step': 'int' } }
+
+##
+# @announce-set-parameters:
+#
+# Set qemu announce parameters.
+#
+# Since: 2.10
+#
+# Example:
+#
+# -> { "execute": "announce-set-parameters",
+#      "arguments": { "announce-rounds": 10 } }
+#
+##
+{ 'command': 'announce-set-parameters', 'boxed': true,
+  'data': 'AnnounceParameters' }
+
+##
+# @query-announce-parameters:
+#
+# Returns information about the current announce parameters
+#
+# Returns: @AnnounceParameters
+#
+# Since: 2.10
+#
+# Example:
+#
+# -> { "execute": "query-announce-parameters" }
+# <- { "return": {
+#          "initial": 50,
+#          "max": 500,
+#          "rounds": 5,
+#          "step": 100
+#       }
+#    }
+#
+##
+{ 'command': 'query-announce-parameters',
+  'returns': 'AnnounceParameters' }
+
 ##
 # @MigrationStats:
 #
-- 
2.7.4
