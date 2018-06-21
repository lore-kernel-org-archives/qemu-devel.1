Received: from eggs.gnu.org ([2001:4830:134:3::10]:45048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fW2kH-00045a-1r
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fW2kF-0003kb-4Q
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:47:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49336 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fW2kE-0003kI-VU
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:47:39 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 21 Jun 2018 17:47:26 +0100
Message-Id: <20180621164727.36626-9-dgilbert@redhat.com>
In-Reply-To: <20180621164727.36626-1-dgilbert@redhat.com>
References: <20180621164727.36626-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 8/9] hmp: add exit_preconfig
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

Add the exit_preconfig command to return to normality.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20180620153947.30834-7-dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp-commands.hx | 19 +++++++++++++++++++
 hmp.c           |  8 ++++++++
 hmp.h           |  1 +
 3 files changed, 28 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 4acf6a3222..ba9cdb8800 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -55,6 +55,25 @@ STEXI
 @item q or quit
 @findex quit
 Quit the emulator.
+ETEXI
+
+    {
+        .name       = "exit_preconfig",
+        .args_type  = "",
+        .params     = "",
+        .help       = "exit the preconfig state",
+        .cmd        = hmp_exit_preconfig,
+        .flags      = "p",
+    },
+
+STEXI
+@item exit_preconfig
+@findex exit_preconfig
+This command makes QEMU exit the preconfig state and proceed with
+VM initialization using configuration data provided on the command line
+and via the QMP monitor during the preconfig state. The command is only
+available during the preconfig state (i.e. when the --preconfig command
+line option was in use).
 ETEXI
 
     {
diff --git a/hmp.c b/hmp.c
index f40d8279cf..f601099f90 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1068,6 +1068,14 @@ void hmp_system_powerdown(Monitor *mon, const QDict *qdict)
     qmp_system_powerdown(NULL);
 }
 
+void hmp_exit_preconfig(Monitor *mon, const QDict *qdict)
+{
+    Error *err = NULL;
+
+    qmp_exit_preconfig(&err);
+    hmp_handle_error(mon, &err);
+}
+
 void hmp_cpu(Monitor *mon, const QDict *qdict)
 {
     int64_t cpu_index;
diff --git a/hmp.h b/hmp.h
index 20f27439d3..33354f1bdd 100644
--- a/hmp.h
+++ b/hmp.h
@@ -44,6 +44,7 @@ void hmp_quit(Monitor *mon, const QDict *qdict);
 void hmp_stop(Monitor *mon, const QDict *qdict);
 void hmp_system_reset(Monitor *mon, const QDict *qdict);
 void hmp_system_powerdown(Monitor *mon, const QDict *qdict);
+void hmp_exit_preconfig(Monitor *mon, const QDict *qdict);
 void hmp_cpu(Monitor *mon, const QDict *qdict);
 void hmp_memsave(Monitor *mon, const QDict *qdict);
 void hmp_pmemsave(Monitor *mon, const QDict *qdict);
-- 
2.17.1
