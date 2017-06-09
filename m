Received: from eggs.gnu.org ([2001:4830:134:3::10]:33235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dJAvF-0002TU-M2
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 23:49:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dJAvE-0007TU-RU
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 23:49:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dJAvE-0007T7-L8
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 23:49:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9E7D983F44
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 03:49:15 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri,  9 Jun 2017 11:48:57 +0800
Message-Id: <1496980142-8986-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1496980142-8986-1-git-send-email-peterx@redhat.com>
References: <1496980142-8986-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/6] machine: export register_compat_prop()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

We have HW_COMPAT_*, however that's only binded to machines, not other
things (like accelerators).  Behind it, it was register_compat_prop()
that played the trick.  Let's export the function for further use
outside HW_COMPAT_* magic.

CC: Eduardo Habkost <ehabkost@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
CC: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/core/machine.c   | 6 +++---
 include/hw/boards.h | 3 +++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 3adebf1..320486d 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -753,9 +753,9 @@ static void machine_class_finalize(ObjectClass *klass, void *data)
     g_free(mc->name);
 }
 
-static void register_compat_prop(const char *driver,
-                                 const char *property,
-                                 const char *value)
+void register_compat_prop(const char *driver,
+                          const char *property,
+                          const char *value)
 {
     GlobalProperty *p = g_new0(GlobalProperty, 1);
     /* Machine compat_props must never cause errors: */
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 76ce021..6e0f5c7 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -41,6 +41,9 @@ int machine_kvm_shadow_mem(MachineState *machine);
 int machine_phandle_start(MachineState *machine);
 bool machine_dump_guest_core(MachineState *machine);
 bool machine_mem_merge(MachineState *machine);
+void register_compat_prop(const char *driver,
+                          const char *property,
+                          const char *value);
 void machine_register_compat_props(MachineState *machine);
 HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machine);
 void machine_set_cpu_numa_node(MachineState *machine,
-- 
2.7.4
