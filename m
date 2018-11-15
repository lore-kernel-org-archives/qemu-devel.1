Received: from eggs.gnu.org ([2001:4830:134:3::10]:35933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1gNHHA-00075f-6w
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:01:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1gNHH8-0003cs-Hc
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:01:40 -0500
Received: from zucker2.schokokeks.org ([178.63.68.90]:40299)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1gNHH8-0003WP-BJ
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:01:38 -0500
From: Simon Ruderich <simon@ruderich.org>
Date: Thu, 15 Nov 2018 14:01:14 +0100
Message-Id: <50e486c7e6d8d39bee2d12ee95b15adb7012ef36.1542285958.git.simon@ruderich.org>
In-Reply-To: <cover.1542285958.git.simon@ruderich.org>
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
	<cover.1542285958.git.simon@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v6 6/6] hmp: add pmemload command
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

Adapted patch from Baojun Wang [1] with the following commit message:

    I found this could be useful to have qemu-softmmu as a cross
    debugger (launch with -s -S command line option), then if we can
    have a command to load guest physical memory, we can use cross gdb
    to do some target debug which gdb cannot do directly.

This patch contains only the hmp changes of the original patch.

[1]: https://lists.gnu.org/archive/html/qemu-trivial/2014-04/msg00074.html

Based-on-patch-by: Baojun Wang <wangbj@gmail.com>
Signed-off-by: Simon Ruderich <simon@ruderich.org>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp-commands.hx | 14 ++++++++++++++
 hmp.c           | 12 ++++++++++++
 hmp.h           |  1 +
 3 files changed, 27 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 2404a5210d..baadbb3a69 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -857,6 +857,20 @@ STEXI
 @item pmemsave @var{addr} @var{size} @var{file}
 @findex pmemsave
 save to disk physical memory dump starting at @var{addr} of size @var{size}.
+ETEXI
+
+    {
+        .name       = "pmemload",
+        .args_type  = "val:l,size:l,offset:l,filename:F",
+        .params     = "addr size offset file",
+        .help       = "load from disk physical memory dump starting at 'addr' of size 'size' at file offset 'offset'",
+        .cmd        = hmp_pmemload,
+    },
+
+STEXI
+@item pmemload @var{addr} @var{size} @var{offset} @var{file}
+@findex pmemload
+load from disk physical memory dump starting at @var{addr} of size @var{size} at file offset @var{offset}.
 ETEXI
 
     {
diff --git a/hmp.c b/hmp.c
index 42a5d163cd..c2a77fc390 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1169,6 +1169,18 @@ void hmp_pmemsave(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, &err);
 }
 
+void hmp_pmemload(Monitor *mon, const QDict *qdict)
+{
+    uint64_t size = qdict_get_int(qdict, "size");
+    uint64_t offset = qdict_get_int(qdict, "offset");
+    const char *filename = qdict_get_str(qdict, "filename");
+    uint64_t addr = qdict_get_int(qdict, "val");
+    Error *err = NULL;
+
+    qmp_pmemload(addr, filename, true, size, true, offset, &err);
+    hmp_handle_error(mon, &err);
+}
+
 void hmp_ringbuf_write(Monitor *mon, const QDict *qdict)
 {
     const char *chardev = qdict_get_str(qdict, "device");
diff --git a/hmp.h b/hmp.h
index 5f1addcca2..6503146a8c 100644
--- a/hmp.h
+++ b/hmp.h
@@ -49,6 +49,7 @@ void hmp_exit_preconfig(Monitor *mon, const QDict *qdict);
 void hmp_cpu(Monitor *mon, const QDict *qdict);
 void hmp_memsave(Monitor *mon, const QDict *qdict);
 void hmp_pmemsave(Monitor *mon, const QDict *qdict);
+void hmp_pmemload(Monitor *mon, const QDict *qdict);
 void hmp_ringbuf_write(Monitor *mon, const QDict *qdict);
 void hmp_ringbuf_read(Monitor *mon, const QDict *qdict);
 void hmp_cont(Monitor *mon, const QDict *qdict);
-- 
2.19.1
