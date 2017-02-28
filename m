Received: from eggs.gnu.org ([2001:4830:134:3::10]:33796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciqDy-0005Ab-IE
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:26:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciqDu-0000cH-7Y
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:26:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ciqDt-0000aB-Rt
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:26:22 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1006D80F8D
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 22:26:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A51F91DCC2
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 22:26:21 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Feb 2017 23:26:12 +0100
Message-Id: <1488320775-9849-22-git-send-email-armbru@redhat.com>
In-Reply-To: <1488320775-9849-1-git-send-email-armbru@redhat.com>
References: <1488320775-9849-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 21/24] block: Initial implementation of -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1488317230-26248-22-git-send-email-armbru@redhat.com>
---
 qemu-options.hx |  7 +++++++
 vl.c            | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index c85f77d..f5202c9 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -532,6 +532,13 @@ Use @var{file} as CD-ROM image (you cannot use @option{-hdc} and
 using @file{/dev/cdrom} as filename (@pxref{host_drives}).
 ETEXI
 
+DEF("blockdev", HAS_ARG, QEMU_OPTION_blockdev,
+    "-blockdev [driver=]driver[,node-name=N][,discard=ignore|unmap]\n"
+    "          [,cache.direct=on|off][,cache.no-flush=on|off]\n"
+    "          [,read-only=on|off][,detect-zeroes=on|off|unmap]\n"
+    "          [,driver specific parameters...]\n"
+    "                configure a block backend\n", QEMU_ARCH_ALL)
+
 DEF("drive", HAS_ARG, QEMU_OPTION_drive,
     "-drive [file=file][,if=type][,bus=n][,unit=m][,media=d][,index=i]\n"
     "       [,cyls=c,heads=h,secs=s[,trans=t]][,snapshot=on|off]\n"
diff --git a/vl.c b/vl.c
index c6020b9..68405c6 100644
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
@@ -4450,6 +4479,16 @@ int main(int argc, char **argv, char **envp)
     }
 
     /* open the virtual block devices */
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
     if (snapshot || replay_mode != REPLAY_MODE_NONE) {
         qemu_opts_foreach(qemu_find_opts("drive"), drive_enable_snapshot,
                           NULL, NULL);
-- 
2.7.4
