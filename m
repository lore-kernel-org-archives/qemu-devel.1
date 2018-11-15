Received: from eggs.gnu.org ([2001:4830:134:3::10]:41707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1gNHbb-0002vj-PM
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:22:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1gNHba-0006v8-0H
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:22:47 -0500
Received: from zucker2.schokokeks.org ([178.63.68.90]:51727)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1gNHbZ-0006tV-PR
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:22:45 -0500
From: Simon Ruderich <simon@ruderich.org>
Date: Thu, 15 Nov 2018 14:22:37 +0100
Message-Id: <7d1a33870ea5fd66ae92bab5164c939c633112a6.1542287931.git.simon@ruderich.org>
In-Reply-To: <cover.1542287931.git.simon@ruderich.org>
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
	<cover.1542287931.git.simon@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v7 4/7] hmp: use l for size argument in
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
index db0c681f74..ff96c3ad24 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -833,7 +833,7 @@ ETEXI
 
     {
         .name       = "memsave",
-        .args_type  = "val:l,size:i,filename:s",
+        .args_type  = "val:l,size:l,filename:s",
         .params     = "addr size file",
         .help       = "save to disk virtual memory dump starting at 'addr' of size 'size'",
         .cmd        = hmp_memsave,
@@ -847,7 +847,7 @@ ETEXI
 
     {
         .name       = "pmemsave",
-        .args_type  = "val:l,size:i,filename:s",
+        .args_type  = "val:l,size:l,filename:s",
         .params     = "addr size file",
         .help       = "save to disk physical memory dump starting at 'addr' of size 'size'",
         .cmd        = hmp_pmemsave,
diff --git a/hmp.c b/hmp.c
index 7828f93a39..42a5d163cd 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1143,7 +1143,7 @@ void hmp_cpu(Monitor *mon, const QDict *qdict)
 
 void hmp_memsave(Monitor *mon, const QDict *qdict)
 {
-    uint32_t size = qdict_get_int(qdict, "size");
+    uint64_t size = qdict_get_int(qdict, "size");
     const char *filename = qdict_get_str(qdict, "filename");
     uint64_t addr = qdict_get_int(qdict, "val");
     Error *err = NULL;
@@ -1160,7 +1160,7 @@ void hmp_memsave(Monitor *mon, const QDict *qdict)
 
 void hmp_pmemsave(Monitor *mon, const QDict *qdict)
 {
-    uint32_t size = qdict_get_int(qdict, "size");
+    uint64_t size = qdict_get_int(qdict, "size");
     const char *filename = qdict_get_str(qdict, "filename");
     uint64_t addr = qdict_get_int(qdict, "val");
     Error *err = NULL;
-- 
2.19.1
