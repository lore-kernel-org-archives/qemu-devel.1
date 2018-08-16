Received: from eggs.gnu.org ([2001:4830:134:3::10]:56454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fqEAP-00056R-7n
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:02:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fqEAL-0002Oy-7O
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:02:05 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:41839)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1fqEAK-0002Nd-VZ
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:02:01 -0400
From: Simon Ruderich <simon@ruderich.org>
Date: Thu, 16 Aug 2018 11:01:52 +0200
Message-Id: <fce204f66589995fb1470a9e2a490b2dd24cf551.1534409363.git.simon@ruderich.org>
In-Reply-To: <cover.1534409363.git.simon@ruderich.org>
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
	<cover.1534409363.git.simon@ruderich.org>
Subject: [Qemu-devel] [PATCH v4 4/7] hmp: use l for size argument in
 memsave/pmemsave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Alan Gilbert <dgilbert@redhat.com>, Peter Crosthwaite <crosthwaitepeter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Simon Ruderich <simon@ruderich.org>

i is only 32-bit. To prevent possible truncation when dumping large
memory regions use l which is target long.

Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Simon Ruderich <simon@ruderich.org>
---
 hmp-commands.hx | 4 ++--
 hmp.c           | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 91dfe51c37..79c158a140 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -818,7 +818,7 @@ ETEXI
 
     {
         .name       = "memsave",
-        .args_type  = "val:l,size:i,filename:s",
+        .args_type  = "val:l,size:l,filename:s",
         .params     = "addr size file",
         .help       = "save to disk virtual memory dump starting at 'addr' of size 'size'",
         .cmd        = hmp_memsave,
@@ -832,7 +832,7 @@ ETEXI
 
     {
         .name       = "pmemsave",
-        .args_type  = "val:l,size:i,filename:s",
+        .args_type  = "val:l,size:l,filename:s",
         .params     = "addr size file",
         .help       = "save to disk physical memory dump starting at 'addr' of size 'size'",
         .cmd        = hmp_pmemsave,
diff --git a/hmp.c b/hmp.c
index 2aafb50e8e..1fb0724107 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1094,7 +1094,7 @@ void hmp_cpu(Monitor *mon, const QDict *qdict)
 
 void hmp_memsave(Monitor *mon, const QDict *qdict)
 {
-    uint32_t size = qdict_get_int(qdict, "size");
+    uint64_t size = qdict_get_int(qdict, "size");
     const char *filename = qdict_get_str(qdict, "filename");
     uint64_t addr = qdict_get_int(qdict, "val");
     Error *err = NULL;
@@ -1111,7 +1111,7 @@ void hmp_memsave(Monitor *mon, const QDict *qdict)
 
 void hmp_pmemsave(Monitor *mon, const QDict *qdict)
 {
-    uint32_t size = qdict_get_int(qdict, "size");
+    uint64_t size = qdict_get_int(qdict, "size");
     const char *filename = qdict_get_str(qdict, "filename");
     uint64_t addr = qdict_get_int(qdict, "val");
     Error *err = NULL;
-- 
2.17.1
