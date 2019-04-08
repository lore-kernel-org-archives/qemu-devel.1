Received: from eggs.gnu.org ([209.51.188.92]:52207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hDPtU-0006eb-Tu
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:44:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hDPtT-0000OT-TX
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:44:44 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:34604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <catherine.hecx@gmail.com>)
	id 1hDPtR-0000KS-MK
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:44:42 -0400
Received: by mail-qt1-x842.google.com with SMTP id k2so14481914qtm.1
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 01:44:39 -0700 (PDT)
From: Catherine Ho <catherine.hecx@gmail.com>
Date: Mon,  8 Apr 2019 04:43:00 -0400
Message-Id: <1554712980-18714-1-git-send-email-catherine.hecx@gmail.com>
In-Reply-To: <1554689945-18619-1-git-send-email-catherine.hecx@gmail.com>
References: <1554689945-18619-1-git-send-email-catherine.hecx@gmail.com>
Subject: [Qemu-devel] [PATCH v2] hostmem-file: warn when memory-backend-file,
 share=on and in incoming migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Catherine Ho <catherine.hecx@gmail.com>

Currently it is not forbidden to use "-object memory-backend-file,share=on"
and together with "-incoming". But after incoming migration is finished,
the memory-backend-file will be definitely written if share=on. So the
memory-backend-file can only be used once, but failed in the 2nd time
incoming.

Thus it gives a warning and the users can run the qemu if they really
want to do it.

Signed-off-by: Catherine Ho <catherine.hecx@gmail.com>
---
 backends/hostmem-file.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 37ac6445d2..ce03dc0a18 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -16,6 +16,7 @@
 #include "sysemu/hostmem.h"
 #include "sysemu/sysemu.h"
 #include "qom/object_interfaces.h"
+#include "migration/migration.h"
 
 /* hostmem-file.c */
 /**
@@ -79,6 +80,17 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         }
     }
 
+    /*
+     * In ignore shared incoming migration, if share=on for host memory
+     * backend file, the ram might be modified after incoming process.
+     * The user should know this potential risk.
+     */
+    if (backend->share && migrate_ignore_shared()
+                       && runstate_check(RUN_STATE_INMIGRATE))
+        warn_report("NOTE: Please make sure the data on the shared memory "
+                    "backend file and the data from the incoming migration"
+                    " stream contains matching contents, otherwise...");
+
     backend->force_prealloc = mem_prealloc;
     name = host_memory_backend_get_name(backend);
     memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
-- 
2.17.1
