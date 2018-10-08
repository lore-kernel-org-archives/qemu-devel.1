Received: from eggs.gnu.org ([2001:4830:134:3::10]:41271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9ZNd-0005AM-Jb
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9ZNZ-0005lr-IG
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1g9ZNZ-0005ij-0N
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8E9C531F40A
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 17:31:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D3A25C6CD
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 17:31:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  8 Oct 2018 19:31:15 +0200
Message-Id: <20181008173125.19678-22-armbru@redhat.com>
In-Reply-To: <20181008173125.19678-1-armbru@redhat.com>
References: <20181008173125.19678-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 21/31] vl: Clean up error reporting in
 mon_init_func()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Calling error_report() in a function that takes an Error ** argument
is suspicious.  mon_init_func() does that, and then fails without
setting an error.  Its caller main(), via qemu_opts_foreach(), is fine
with it, but clean it up anyway.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 vl.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/vl.c b/vl.c
index 3adc9dbe4f..1009d708a0 100644
--- a/vl.c
+++ b/vl.c
@@ -2270,8 +2270,8 @@ static int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
     } else if (strcmp(mode, "control") == 0) {
         flags = MONITOR_USE_CONTROL;
     } else {
-        error_report("unknown monitor mode \"%s\"", mode);
-        exit(1);
+        error_setg(errp, "unknown monitor mode \"%s\"", mode);
+        return -1;
     }
 
     if (qemu_opt_get_bool(opts, "pretty", 0))
@@ -2285,8 +2285,8 @@ static int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
     chardev = qemu_opt_get(opts, "chardev");
     chr = qemu_chr_find(chardev);
     if (chr == NULL) {
-        error_report("chardev \"%s\" not found", chardev);
-        exit(1);
+        error_setg(errp, "chardev \"%s\" not found", chardev);
+        return -1;
     }
 
     monitor_init(chr, flags);
@@ -4365,10 +4365,8 @@ int main(int argc, char **argv, char **envp)
     default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
     default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);
 
-    if (qemu_opts_foreach(qemu_find_opts("mon"),
-                          mon_init_func, NULL, NULL)) {
-        exit(1);
-    }
+    qemu_opts_foreach(qemu_find_opts("mon"),
+                      mon_init_func, NULL, &error_fatal);
 
     if (foreach_device_config(DEV_SERIAL, serial_parse) < 0)
         exit(1);
-- 
2.17.1
