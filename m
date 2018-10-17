Received: from eggs.gnu.org ([2001:4830:134:3::10]:51214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gChAo-0008H3-12
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:27:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gChAd-00018x-Eg
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:27:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41209)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gChAc-00014q-S9
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:27:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5E80230C9EE8
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 08:27:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 286C65DD95
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 08:27:09 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 17 Oct 2018 10:26:47 +0200
Message-Id: <20181017082702.5581-24-armbru@redhat.com>
In-Reply-To: <20181017082702.5581-1-armbru@redhat.com>
References: <20181017082702.5581-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 23/38] vl: Clean up error reporting in
 parse_fw_cfg()
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
is suspicious.  parse_fw_cfg() does that, and then fails without
setting an error.  Its caller main(), via qemu_opts_foreach(), is fine
with it, but clean it up anyway.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 vl.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/vl.c b/vl.c
index cd8e8a6586..c5bc54f72b 100644
--- a/vl.c
+++ b/vl.c
@@ -2174,7 +2174,7 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opt=
s, Error **errp)
     FWCfgState *fw_cfg =3D (FWCfgState *) opaque;
=20
     if (fw_cfg =3D=3D NULL) {
-        error_report("fw_cfg device not available");
+        error_setg(errp, "fw_cfg device not available");
         return -1;
     }
     name =3D qemu_opt_get(opts, "name");
@@ -2183,15 +2183,16 @@ static int parse_fw_cfg(void *opaque, QemuOpts *o=
pts, Error **errp)
=20
     /* we need name and either a file or the content string */
     if (!(nonempty_str(name) && (nonempty_str(file) || nonempty_str(str)=
))) {
-        error_report("invalid argument(s)");
+        error_setg(errp, "invalid argument(s)");
         return -1;
     }
     if (nonempty_str(file) && nonempty_str(str)) {
-        error_report("file and string are mutually exclusive");
+        error_setg(errp, "file and string are mutually exclusive");
         return -1;
     }
     if (strlen(name) > FW_CFG_MAX_FILE_PATH - 1) {
-        error_report("name too long (max. %d char)", FW_CFG_MAX_FILE_PAT=
H - 1);
+        error_setg(errp, "name too long (max. %d char)",
+                   FW_CFG_MAX_FILE_PATH - 1);
         return -1;
     }
     if (strncmp(name, "opt/", 4) !=3D 0) {
@@ -2203,7 +2204,7 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opt=
s, Error **errp)
         buf =3D g_memdup(str, size);
     } else {
         if (!g_file_get_contents(file, &buf, &size, NULL)) {
-            error_report("can't load %s", file);
+            error_setg(errp, "can't load %s", file);
             return -1;
         }
     }
@@ -4476,10 +4477,8 @@ int main(int argc, char **argv, char **envp)
         hax_sync_vcpus();
     }
=20
-    if (qemu_opts_foreach(qemu_find_opts("fw_cfg"),
-                          parse_fw_cfg, fw_cfg_find(), NULL) !=3D 0) {
-        exit(1);
-    }
+    qemu_opts_foreach(qemu_find_opts("fw_cfg"),
+                      parse_fw_cfg, fw_cfg_find(), &error_fatal);
=20
     /* init USB devices */
     if (machine_usb(current_machine)) {
--=20
2.17.1
