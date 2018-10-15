Received: from eggs.gnu.org ([2001:4830:134:3::10]:39659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gC1RD-0004GU-4x
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gC1RB-0002BD-2a
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gC1R9-00020w-47
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C21C37F6CB
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 11:53:17 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 15 Oct 2018 13:53:02 +0200
Message-Id: <20181015115309.17089-29-armbru@redhat.com>
In-Reply-To: <20181015115309.17089-1-armbru@redhat.com>
References: <20181015115309.17089-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 28/35] numa: Clean up error reporting in
 parse_numa()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>

Calling error_report() in a function that takes an Error ** argument
is suspicious.  parse_numa() does that, and then fails without setting
an error.  Its caller main(), via qemu_opts_foreach(), is fine with
it, but clean it up anyway.

While there, give parse_numa() internal linkage.

Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/sysemu/numa.h | 1 -
 numa.c                | 8 +++-----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 7a0ae751aa..21713b7e2f 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -22,7 +22,6 @@ struct NumaNodeMem {
 };
 
 extern NodeInfo numa_info[MAX_NODES];
-int parse_numa(void *opaque, QemuOpts *opts, Error **errp);
 void parse_numa_opts(MachineState *ms);
 void numa_complete_configuration(MachineState *ms);
 void query_numa_node_mem(NumaNodeMem node_mem[]);
diff --git a/numa.c b/numa.c
index 1d7c49ad43..50ec016013 100644
--- a/numa.c
+++ b/numa.c
@@ -215,7 +215,7 @@ end:
     error_propagate(errp, err);
 }
 
-int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
+static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
 {
     NumaOptions *object = NULL;
     MachineState *ms = MACHINE(opaque);
@@ -239,7 +239,7 @@ int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
 end:
     qapi_free_NumaOptions(object);
     if (err) {
-        error_report_err(err);
+        error_propagate(errp, err);
         return -1;
     }
 
@@ -444,9 +444,7 @@ void numa_complete_configuration(MachineState *ms)
 
 void parse_numa_opts(MachineState *ms)
 {
-    if (qemu_opts_foreach(qemu_find_opts("numa"), parse_numa, ms, NULL)) {
-        exit(1);
-    }
+    qemu_opts_foreach(qemu_find_opts("numa"), parse_numa, ms, &error_fatal);
 }
 
 void qmp_set_numa_node(NumaOptions *cmd, Error **errp)
-- 
2.17.1
