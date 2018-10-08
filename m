Received: from eggs.gnu.org ([2001:4830:134:3::10]:41343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9ZNf-0005AX-33
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9ZNa-0005n4-Cq
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1g9ZNZ-0005ja-UZ
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:38 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 908D331F40B
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 17:31:35 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  8 Oct 2018 19:31:21 +0200
Message-Id: <20181008173125.19678-28-armbru@redhat.com>
In-Reply-To: <20181008173125.19678-1-armbru@redhat.com>
References: <20181008173125.19678-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 27/31] spice: Clean up error reporting in
 add_channel()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Calling error_report() in a function that takes an Error ** argument
is suspicious.  add_channel() does that, and then exit()s.  Its caller
main(), via qemu_opts_foreach(), is fine with it, but clean it up
anyway.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 ui/spice-core.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/ui/spice-core.c b/ui/spice-core.c
index a4fbbc3898..ebaae24643 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -597,9 +597,9 @@ static int add_channel(void *opaque, const char *name, const char *value,
     if (strcmp(name, "tls-channel") == 0) {
         int *tls_port = opaque;
         if (!*tls_port) {
-            error_report("spice: tried to setup tls-channel"
-                         " without specifying a TLS port");
-            exit(1);
+            error_setg(errp, "spice: tried to setup tls-channel"
+                       " without specifying a TLS port");
+            return -1;
         }
         security = SPICE_CHANNEL_SECURITY_SSL;
     }
@@ -615,8 +615,9 @@ static int add_channel(void *opaque, const char *name, const char *value,
         rc = spice_server_set_channel_security(spice_server, value, security);
     }
     if (rc != 0) {
-        error_report("spice: failed to set channel security for %s", value);
-        exit(1);
+        error_setg(errp, "spice: failed to set channel security for %s",
+                   value);
+        return -1;
     }
     return 0;
 }
@@ -787,7 +788,7 @@ void qemu_spice_init(void)
     spice_server_set_playback_compression
         (spice_server, qemu_opt_get_bool(opts, "playback-compression", 1));
 
-    qemu_opt_foreach(opts, add_channel, &tls_port, NULL);
+    qemu_opt_foreach(opts, add_channel, &tls_port, &error_fatal);
 
     spice_server_set_name(spice_server, qemu_name);
     spice_server_set_uuid(spice_server, (unsigned char *)&qemu_uuid);
-- 
2.17.1
