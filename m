Received: from eggs.gnu.org ([209.51.188.92]:37359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hDJtv-0007Dn-3r
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 22:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hDJtu-0003Vb-3q
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 22:20:47 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:32960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <catherine.hecx@gmail.com>)
	id 1hDJtt-0003VF-RV
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 22:20:46 -0400
Received: by mail-qt1-x843.google.com with SMTP id k14so13743158qtb.0
	for <qemu-devel@nongnu.org>; Sun, 07 Apr 2019 19:20:45 -0700 (PDT)
From: Catherine Ho <catherine.hecx@gmail.com>
Date: Sun,  7 Apr 2019 22:19:05 -0400
Message-Id: <1554689945-18619-1-git-send-email-catherine.hecx@gmail.com>
Subject: [Qemu-devel] [PATCH] hostmem-file: warn when memory-backend-file,
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
 backends/hostmem-file.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 37ac6445d2..59429ee0b4 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -16,6 +16,7 @@
 #include "sysemu/hostmem.h"
 #include "sysemu/sysemu.h"
 #include "qom/object_interfaces.h"
+#include "migration/migration.h"
 
 /* hostmem-file.c */
 /**
@@ -79,6 +80,16 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         }
     }
 
+    /*
+     * In ignore shared case, if share=on for host memory backend file,
+     * the ram might be written after incoming process is finished. Thus
+     * the memory backend can't be reused for 2nd/3rd... incoming
+     */
+    if (backend->share && migrate_ignore_shared()
+                       && runstate_check(RUN_STATE_INMIGRATE))
+        warn_report("share=on for memory backend file might be "
+                        "conflicted with incoming in ignore shared case");
+
     backend->force_prealloc = mem_prealloc;
     name = host_memory_backend_get_name(backend);
     memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
-- 
2.17.1
