Received: from eggs.gnu.org ([2001:4830:134:3::10]:44978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fW2k9-0003yz-Uu
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:47:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fW2k9-0003fm-3l
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:47:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44314 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fW2k8-0003ek-Vt
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:47:33 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 21 Jun 2018 17:47:21 +0100
Message-Id: <20180621164727.36626-4-dgilbert@redhat.com>
In-Reply-To: <20180621164727.36626-1-dgilbert@redhat.com>
References: <20180621164727.36626-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 3/9] hmp: Add flag for preconfig commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, imammedo@redhat.com, sjitindarsingh@gmail.com, walling@linux.ibm.com
Cc: armbru@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add a flag to command definitions to allow them to be used in preconfig
and check it.
If users try to use commands that aren't available, tell them to use
the exit_preconfig comand we're adding in a few patches.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20180620153947.30834-2-dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 monitor.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/monitor.c b/monitor.c
index 2a8187f5d7..ff26d863db 100644
--- a/monitor.c
+++ b/monitor.c
@@ -128,6 +128,7 @@ typedef struct mon_cmd_t {
     const char *args_type;
     const char *params;
     const char *help;
+    const char *flags; /* p=preconfig */
     void (*cmd)(Monitor *mon, const QDict *qdict);
     /* @sub_table is a list of 2nd level of commands. If it does not exist,
      * cmd should be used. If it exists, sub_table[?].cmd should be
@@ -958,6 +959,19 @@ static int parse_cmdline(const char *cmdline,
     return -1;
 }
 
+/*
+ * Returns true if the command can be executed in preconfig mode
+ * i.e. it has the 'p' flag.
+ */
+static bool cmd_can_preconfig(const mon_cmd_t *cmd)
+{
+    if (!cmd->flags) {
+        return false;
+    }
+
+    return strchr(cmd->flags, 'p');
+}
+
 static void help_cmd_dump_one(Monitor *mon,
                               const mon_cmd_t *cmd,
                               char **prefix_args,
@@ -3041,6 +3055,12 @@ static const mon_cmd_t *monitor_parse_command(Monitor *mon,
                        (int)(p - cmdp_start), cmdp_start);
         return NULL;
     }
+    if (runstate_check(RUN_STATE_PRECONFIG) && !cmd_can_preconfig(cmd)) {
+        monitor_printf(mon, "Command '%.*s' not available with -preconfig "
+                            "until after exit_preconfig.\n",
+                       (int)(p - cmdp_start), cmdp_start);
+        return NULL;
+    }
 
     /* filter out following useless space */
     while (qemu_isspace(*p)) {
-- 
2.17.1
