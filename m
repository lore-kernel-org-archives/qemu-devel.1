Received: from eggs.gnu.org ([2001:4830:134:3::10]:36850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqN76-0008Cr-3b
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:35:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqN72-0002k1-SW
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:35:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fqN72-0002j3-Mo
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:35:12 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2EF9B83F45
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 18:35:11 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 16 Aug 2018 15:35:09 -0300
Message-Id: <20180816183509.8231-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH] i386: Fix arch_query_cpu_model_expansion() leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Reported by Coverity:

Error: RESOURCE_LEAK (CWE-772): [#def439]
qemu-2.12.0/target/i386/cpu.c:3179: alloc_fn: Storage is returned from allocation function "qdict_new".
qemu-2.12.0/qobject/qdict.c:34:5: alloc_fn: Storage is returned from allocation function "g_malloc0".
qemu-2.12.0/qobject/qdict.c:34:5: var_assign: Assigning: "qdict" = "g_malloc0(4120UL)".
qemu-2.12.0/qobject/qdict.c:37:5: return_alloc: Returning allocated memory "qdict".
qemu-2.12.0/target/i386/cpu.c:3179: var_assign: Assigning: "props" = storage returned from "qdict_new()".
qemu-2.12.0/target/i386/cpu.c:3217: leaked_storage: Variable "props" going out of scope leaks the storage it points to.

This was introduced by commit b8097deb359b ("i386: Improve
query-cpu-model-expansion full mode").

The leak is only theoretical: if ret->model->props is set to
props, the qapi_free_CpuModelExpansionInfo() call will free props
too in case of errors.  The only way for this to not happen is if
we enter the default branch of the switch statement, which would
never happen because all CpuModelExpansionType values are being
handled.

It's still worth to change this to make the allocation logic
easier to follow and make the Coverity error go away.  To make
everything simpler, initialize ret->model and ret->model->props
earlier in the function.

While at it, remove redundant check for !prop because prop is
always initialized at the beginning of the function.

Fixes: b8097deb359bbbd92592b9670adfe9e245b2d0bd
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 723e02221e..e23c05c4e1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3758,6 +3758,9 @@ arch_query_cpu_model_expansion(CpuModelExpansionType type,
     }
 
     props = qdict_new();
+    ret->model = g_new0(CpuModelInfo, 1);
+    ret->model->props = QOBJECT(props);
+    ret->model->has_props = true;
 
     switch (type) {
     case CPU_MODEL_EXPANSION_TYPE_STATIC:
@@ -3778,15 +3781,9 @@ arch_query_cpu_model_expansion(CpuModelExpansionType type,
         goto out;
     }
 
-    if (!props) {
-        props = qdict_new();
-    }
     x86_cpu_to_dict(xc, props);
 
-    ret->model = g_new0(CpuModelInfo, 1);
     ret->model->name = g_strdup(base_name);
-    ret->model->props = QOBJECT(props);
-    ret->model->has_props = true;
 
 out:
     object_unref(OBJECT(xc));
-- 
2.18.0.rc1.1.g3f1ff2140
