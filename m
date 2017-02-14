Received: from eggs.gnu.org ([2001:4830:134:3::10]:53875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdfBA-0007GB-N5
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 10:38:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdfB9-0007rJ-Fu
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 10:38:08 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 14 Feb 2017 16:37:56 +0100
Message-Id: <1487086676-24339-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1487086676-24339-1-git-send-email-armbru@redhat.com>
References: <1487086676-24339-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v2 2/2] block: Crude initial implementation
 of -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com

The new command line option -blockdev works like QMP command
blockdev-add.

The option argument may be given in JSON syntax, exactly as in QMP.
Example usage:

    -blockdev '{"node-name": "foo", "driver": "raw", "file": {"driver": "file", "filename": "foo.img"} }'

The JSON argument doesn't exactly blend into the existing option
syntax, so the traditional KEY=VALUE,... syntax is also supported,
using dotted keys to do the nesting:

    -blockdev node-name=foo,driver=raw,file.driver=file,file.filename=foo.img

Note that calling qmp_blockdev_add() (say via qmp_marshal_block_add())
right away would crash.  We need to stash the configuration for later
instead.  This is crudely done, and bypasses QemuOpts, even though
storing configuration is what QemuOpts is for.  Need to revamp option
infrastructure to support QAPI types like BlockdevOptions.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qemu-options.hx |  3 +++
 vl.c            | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index ad2f8fc..a66bd65 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -512,6 +512,9 @@ Use @var{file} as CD-ROM image (you cannot use @option{-hdc} and
 using @file{/dev/cdrom} as filename (@pxref{host_drives}).
 ETEXI
 
+DEF("blockdev", HAS_ARG, QEMU_OPTION_blockdev,
+    "-blockdev FIXME document\n", QEMU_OPTION_blockdev)
+
 DEF("drive", HAS_ARG, QEMU_OPTION_drive,
     "-drive [file=file][,if=type][,bus=n][,unit=m][,media=d][,index=i]\n"
     "       [,cyls=c,heads=h,secs=s[,trans=t]][,snapshot=on|off]\n"
diff --git a/vl.c b/vl.c
index b4eaf03..f2d46c3 100644
--- a/vl.c
+++ b/vl.c
@@ -94,6 +94,9 @@ int main(int argc, char **argv)
 #include "migration/colo.h"
 #include "sysemu/kvm.h"
 #include "sysemu/hax.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qapi-visit.h"
 #include "qapi/qmp/qjson.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
@@ -2965,6 +2968,12 @@ int main(int argc, char **argv, char **envp)
     Error *main_loop_err = NULL;
     Error *err = NULL;
     bool list_data_dirs = false;
+    typedef struct BlockdevOptions_queue {
+        BlockdevOptions *bdo;
+        Location loc;
+        QSIMPLEQ_ENTRY(BlockdevOptions_queue) entry;
+    } BlockdevOptions_queue;
+    QSIMPLEQ_HEAD(, BlockdevOptions_queue) bdo_queue = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
 
     module_call_init(MODULE_INIT_TRACE);
 
@@ -3106,6 +3115,38 @@ int main(int argc, char **argv, char **envp)
                 drive_add(IF_DEFAULT, popt->index - QEMU_OPTION_hda, optarg,
                           HD_OPTS);
                 break;
+            case QEMU_OPTION_blockdev:
+                {
+                    bool is_json = optarg[0] == '{';
+                    QObject *obj;
+                    QDict *args;
+                    Visitor *v;
+                    BlockdevOptions_queue *bdo;
+
+                    if (is_json) {
+                        obj = qobject_from_json(optarg);
+                        // TODO get error out of parser
+                        if (!obj) {
+                            error_report("invalid JSON");
+                            exit(1);
+                        }
+                        args = qobject_to_qdict(obj);
+                        assert(args);
+                    } else {
+                        args = opt_parse_qdict(optarg, "driver",
+                                               &error_fatal);
+                    }
+
+                    bdo = g_new(BlockdevOptions_queue, 1);
+                    v = qobject_input_visitor_new(QOBJECT(args), true);
+                    visit_type_BlockdevOptions(v, NULL, &bdo->bdo,
+                                               &error_fatal);
+                    visit_free(v);
+                    QDECREF(args);
+                    loc_save(&bdo->loc);
+                    QSIMPLEQ_INSERT_TAIL(&bdo_queue, bdo, entry);
+                    break;
+                }
             case QEMU_OPTION_drive:
                 if (drive_def(optarg) == NULL) {
                     exit(1);
@@ -4418,6 +4459,16 @@ int main(int argc, char **argv, char **envp)
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
