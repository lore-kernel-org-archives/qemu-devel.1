Received: from eggs.gnu.org ([2001:4830:134:3::10]:52071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vadim.galitsyn@profitbricks.com>) id 1e6ePx-0004yi-7C
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 11:13:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vadim.galitsyn@profitbricks.com>) id 1e6ePw-0002C3-11
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 11:13:29 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:48384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vadim.galitsyn@profitbricks.com>)
	id 1e6ePv-0002Be-RM
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 11:13:27 -0400
Received: by mail-wm0-x244.google.com with SMTP id p75so10209984wmg.3
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 08:13:27 -0700 (PDT)
From: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Date: Mon, 23 Oct 2017 17:13:08 +0200
Message-Id: <20171023151310.6462-3-vadim.galitsyn@profitbricks.com>
In-Reply-To: <20171023151310.6462-1-vadim.galitsyn@profitbricks.com>
References: <20171023151310.6462-1-vadim.galitsyn@profitbricks.com>
Subject: [Qemu-devel] [PATCH 2/4] hmp: introduce 'writeconfig' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: vadim.galitsyn@profitbricks.com, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Otubo <eduardo.otubo@profitbricks.com>

Add 'writeconfig' command for HMP monitor. This command is a
sibling of QMP command 'writeconfig'.

This is a simple way to keep track of current state of VM
after series of hotplugs and/or hotunplugs of different devices.

Signed-off-by: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Signed-off-by: Eduardo Otubo <eduardo.otubo@profitbricks.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org
---
 hmp.h           |  1 +
 hmp.c           |  9 +++++++++
 hmp-commands.hx | 17 +++++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/hmp.h b/hmp.h
index 3605003e4c..2730b7f7b9 100644
--- a/hmp.h
+++ b/hmp.h
@@ -146,5 +146,6 @@ void hmp_info_ramblock(Monitor *mon, const QDict *qdict);
 void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
 void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
 void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
+void hmp_writeconfig(Monitor *mon, const QDict *qdict);
 
 #endif
diff --git a/hmp.c b/hmp.c
index ec61329ebb..20af8ab870 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2901,3 +2901,12 @@ void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict)
     }
     hmp_handle_error(mon, &err);
 }
+
+void hmp_writeconfig(Monitor *mon, const QDict *qdict)
+{
+     const char *file = qdict_get_str(qdict, "file");
+     Error *err = NULL;
+
+     qmp_writeconfig(file, &err);
+     hmp_handle_error(mon, &err);
+}
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 1941e19932..98a3dc4b66 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1858,6 +1858,23 @@ ETEXI
         .sub_table  = info_cmds,
     },
 
+    {
+        .name       = "writeconfig",
+        .args_type  = "file:F",
+        .params     = "file",
+        .help       = "dump current configuration into specified file",
+        .cmd        = hmp_writeconfig,
+    },
+
+STEXI
+@item writeconfig @var{file}
+@findex writeconfig
+Dump current configuration into specified @var{file}.
+@example
+(qemu) writeconfig /tmp/qemu.conf
+@end example
+ETEXI
+
 STEXI
 @end table
 ETEXI
-- 
2.13.1.394.g41dd433
