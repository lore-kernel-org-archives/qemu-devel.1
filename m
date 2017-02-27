Received: from eggs.gnu.org ([2001:4830:134:3::10]:44770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciJMb-0006DP-3u
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:21:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciJMW-00014T-4j
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:21:09 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 27 Feb 2017 12:20:44 +0100
Message-Id: <1488194450-28056-19-git-send-email-armbru@redhat.com>
In-Reply-To: <1488194450-28056-1-git-send-email-armbru@redhat.com>
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 18/24] block: Initial implementation of
 -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, eblake@redhat.com, "mdroth@linux.vnet.ibm.commdroth"@linux.vnet.ibm.com

The new command line option -blockdev works like QMP command
blockdev-add.

The option argument may be given in JSON syntax, exactly as in QMP.
Example usage:

    -blockdev '{"node-name": "foo", "driver": "raw", "file": {"driver": "file", "filename": "foo.img"} }'

The JSON argument doesn't exactly blend into the existing option
syntax, so the traditional KEY=VALUE,... syntax is also supported,
using dotted keys to do the nesting:

    -blockdev node-name=foo,driver=raw,file.driver=file,file.filename=foo.img

This does not yet support lists or downstream extensions, i.e. keys
with __RFQDN_ prefix, but the next few patches will take care of that.

Note that calling qmp_blockdev_add() (say via qmp_marshal_block_add())
right away would crash.  We need to stash the configuration for later
instead.  This is crudely done, and bypasses QemuOpts, even though
storing configuration is what QemuOpts is for.  Need to revamp option
infrastructure to support QAPI types like BlockdevOptions.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qemu-options.hx |  7 +++++++
 vl.c            | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index bf458f8..8f02264 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -532,6 +532,13 @@ Use @var{file} as CD-ROM image (you cannot use @option{-hdc} and
 using @file{/dev/cdrom} as filename (@pxref{host_drives}).
 ETEXI
 
+DEF("blockdev", HAS_ARG, QEMU_OPTION_blockdev,
+    "-blockdev driver[,node-name=N][,discard=ignore|unmap]\n"
+    "          [,cache.direct=on|off][,cache.no-flush=on|off]\n"
+    "          [,read-only=on|off][,detect-zeroes=on|off|unmap]\n"
+    "          [,driver specific parameters...]\n"
+    "                configure a block backend\n", QEMU_ARCH_ALL)
+
 DEF("drive", HAS_ARG, QEMU_OPTION_drive,
     "-drive [file=file][,if=type][,bus=n][,unit=m][,media=d][,index=i]\n"
     "       [,cyls=c,heads=h,secs=s[,trans=t]][,snapshot=on|off]\n"
diff --git a/vl.c b/vl.c
index c6020b9..0684d52 100644
--- a/vl.c
+++ b/vl.c
@@ -95,6 +95,9 @@ int main(int argc, char **argv)
 #include "migration/colo.h"
 #include "sysemu/kvm.h"
 #include "sysemu/hax.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qapi-visit.h"
 #include "qapi/qmp/qjson.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
@@ -2975,6 +2978,13 @@ int main(int argc, char **argv, char **envp)
     Error *main_loop_err = NULL;
     Error *err = NULL;
     bool list_data_dirs = false;
+    typedef struct BlockdevOptions_queue {
+        BlockdevOptions *bdo;
+        Location loc;
+        QSIMPLEQ_ENTRY(BlockdevOptions_queue) entry;
+    } BlockdevOptions_queue;
+    QSIMPLEQ_HEAD(, BlockdevOptions_queue) bdo_queue
+        = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
 
     module_call_init(MODULE_INIT_TRACE);
 
@@ -3117,6 +3127,25 @@ int main(int argc, char **argv, char **envp)
                 drive_add(IF_DEFAULT, popt->index - QEMU_OPTION_hda, optarg,
                           HD_OPTS);
                 break;
+            case QEMU_OPTION_blockdev:
+                {
+                    Visitor *v;
+                    BlockdevOptions_queue *bdo;
+
+                    v = qobject_input_visitor_new_str(optarg, "driver", &err);
+                    if (!v) {
+                        error_report_err(err);
+                        exit(1);
+                    }
+
+                    bdo = g_new(BlockdevOptions_queue, 1);
+                    visit_type_BlockdevOptions(v, NULL, &bdo->bdo,
+                                               &error_fatal);
+                    visit_free(v);
+                    loc_save(&bdo->loc);
+                    QSIMPLEQ_INSERT_TAIL(&bdo_queue, bdo, entry);
+                    break;
+                }
             case QEMU_OPTION_drive:
                 if (drive_def(optarg) == NULL) {
                     exit(1);
@@ -4454,6 +4483,16 @@ int main(int argc, char **argv, char **envp)
         qemu_opts_foreach(qemu_find_opts("drive"), drive_enable_snapshot,
                           NULL, NULL);
     }
+    while (!QSIMPLEQ_EMPTY(&bdo_queue)) {
+        BlockdevOptions_queue *bdo = QSIMPLEQ_FIRST(&bdo_queue);
+
+        QSIMPLEQ_REMOVE_HEAD(&bdo_queue, entry);
+        loc_push_restore(&bdo->loc);
+        qmp_blockdev_add(bdo->bdo, &error_fatal);
+        loc_pop(&bdo->loc);
+        qapi_free_BlockdevOptions(bdo->bdo);
+        g_free(bdo);
+    }
     if (qemu_opts_foreach(qemu_find_opts("drive"), drive_init_func,
                           &machine_class->block_default_type, NULL)) {
         exit(1);
-- 
2.7.4
