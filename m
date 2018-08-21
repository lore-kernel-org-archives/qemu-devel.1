Received: from eggs.gnu.org ([2001:4830:134:3::10]:33719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4n-0002IN-UU
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4X-0006rA-Qj
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:11 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:36956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4W-0006Eo-Rw
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:01 -0400
Received: by mail-wm0-x235.google.com with SMTP id n11-v6so3495222wmc.2
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:37 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:02:02 +0200
Message-Id: <1534870966-9287-31-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 30/74] i386: Fix
 arch_query_cpu_model_expansion() leak
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

From: Eduardo Habkost <ehabkost@redhat.com>

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
Message-Id: <20180816183509.8231-1-ehabkost@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4e4fe8f..f24295e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3880,6 +3880,9 @@ arch_query_cpu_model_expansion(CpuModelExpansionType type,
     }
 
     props = qdict_new();
+    ret->model = g_new0(CpuModelInfo, 1);
+    ret->model->props = QOBJECT(props);
+    ret->model->has_props = true;
 
     switch (type) {
     case CPU_MODEL_EXPANSION_TYPE_STATIC:
@@ -3900,15 +3903,9 @@ arch_query_cpu_model_expansion(CpuModelExpansionType type,
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
1.8.3.1
