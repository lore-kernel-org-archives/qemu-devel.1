Received: from eggs.gnu.org ([2001:4830:134:3::10]:51210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gChAo-0008Gz-0m
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:27:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gChAe-00019s-0f
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:27:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gChAd-00016L-H1
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:27:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 152E93086258
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 08:27:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 17 Oct 2018 10:26:54 +0200
Message-Id: <20181017082702.5581-31-armbru@redhat.com>
In-Reply-To: <20181017082702.5581-1-armbru@redhat.com>
References: <20181017082702.5581-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 30/38] spice: Clean up error reporting in
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
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 ui/spice-core.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/ui/spice-core.c b/ui/spice-core.c
index a4fbbc3898..ebaae24643 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -597,9 +597,9 @@ static int add_channel(void *opaque, const char *name=
, const char *value,
     if (strcmp(name, "tls-channel") =3D=3D 0) {
         int *tls_port =3D opaque;
         if (!*tls_port) {
-            error_report("spice: tried to setup tls-channel"
-                         " without specifying a TLS port");
-            exit(1);
+            error_setg(errp, "spice: tried to setup tls-channel"
+                       " without specifying a TLS port");
+            return -1;
         }
         security =3D SPICE_CHANNEL_SECURITY_SSL;
     }
@@ -615,8 +615,9 @@ static int add_channel(void *opaque, const char *name=
, const char *value,
         rc =3D spice_server_set_channel_security(spice_server, value, se=
curity);
     }
     if (rc !=3D 0) {
-        error_report("spice: failed to set channel security for %s", val=
ue);
-        exit(1);
+        error_setg(errp, "spice: failed to set channel security for %s",
+                   value);
+        return -1;
     }
     return 0;
 }
@@ -787,7 +788,7 @@ void qemu_spice_init(void)
     spice_server_set_playback_compression
         (spice_server, qemu_opt_get_bool(opts, "playback-compression", 1=
));
=20
-    qemu_opt_foreach(opts, add_channel, &tls_port, NULL);
+    qemu_opt_foreach(opts, add_channel, &tls_port, &error_fatal);
=20
     spice_server_set_name(spice_server, qemu_name);
     spice_server_set_uuid(spice_server, (unsigned char *)&qemu_uuid);
--=20
2.17.1
