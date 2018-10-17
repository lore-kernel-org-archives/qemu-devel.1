Received: from eggs.gnu.org ([2001:4830:134:3::10]:51211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gChAo-0008H0-0f
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:27:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gChAd-00017p-5Y
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:27:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gChAc-00014j-IR
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:27:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 44F7474867
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 08:27:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 14BF85DD79
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 08:27:09 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 17 Oct 2018 10:26:46 +0200
Message-Id: <20181017082702.5581-23-armbru@redhat.com>
In-Reply-To: <20181017082702.5581-1-armbru@redhat.com>
References: <20181017082702.5581-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 22/38] vl: Clean up error reporting in
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
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 vl.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/vl.c b/vl.c
index c3c17106bf..cd8e8a6586 100644
--- a/vl.c
+++ b/vl.c
@@ -2270,8 +2270,8 @@ static int mon_init_func(void *opaque, QemuOpts *op=
ts, Error **errp)
     } else if (strcmp(mode, "control") =3D=3D 0) {
         flags =3D MONITOR_USE_CONTROL;
     } else {
-        error_report("unknown monitor mode \"%s\"", mode);
-        exit(1);
+        error_setg(errp, "unknown monitor mode \"%s\"", mode);
+        return -1;
     }
=20
     if (qemu_opt_get_bool(opts, "pretty", 0))
@@ -2285,8 +2285,8 @@ static int mon_init_func(void *opaque, QemuOpts *op=
ts, Error **errp)
     chardev =3D qemu_opt_get(opts, "chardev");
     chr =3D qemu_chr_find(chardev);
     if (chr =3D=3D NULL) {
-        error_report("chardev \"%s\" not found", chardev);
-        exit(1);
+        error_setg(errp, "chardev \"%s\" not found", chardev);
+        return -1;
     }
=20
     monitor_init(chr, flags);
@@ -4412,10 +4412,8 @@ int main(int argc, char **argv, char **envp)
     default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
     default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);
=20
-    if (qemu_opts_foreach(qemu_find_opts("mon"),
-                          mon_init_func, NULL, NULL)) {
-        exit(1);
-    }
+    qemu_opts_foreach(qemu_find_opts("mon"),
+                      mon_init_func, NULL, &error_fatal);
=20
     if (foreach_device_config(DEV_SERIAL, serial_parse) < 0)
         exit(1);
--=20
2.17.1
