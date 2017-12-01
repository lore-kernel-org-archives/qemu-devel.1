Received: from eggs.gnu.org ([2001:4830:134:3::10]:44963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eKo9A-0003QT-Jz
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:26:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eKo97-00037r-KV
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:26:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eKo97-00035T-EL
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:26:37 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DAAFB915B4
	for <qemu-devel@nongnu.org>; Fri,  1 Dec 2017 11:37:50 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  1 Dec 2017 12:37:44 +0100
Message-Id: <20171201113744.2313-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] dump-guest-memory.py: fix No symbol
 "vmcoreinfo_find"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, lersek@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

When qemu is compiled without debug, the dump gdb python script can fail =
with:

Error occurred in Python command: No symbol "vmcoreinfo_find" in current =
context.

Because vmcoreinfo_find() is inlined and not exported.

Use the underlying object_resolve_path_type() to get the instance instead=
.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/dump-guest-memory.py | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.py
index 69dd5efadf..1af26c1a45 100644
--- a/scripts/dump-guest-memory.py
+++ b/scripts/dump-guest-memory.py
@@ -546,13 +546,15 @@ shape and this command should mostly work."""
         return None
=20
     def add_vmcoreinfo(self):
-        if not gdb.parse_and_eval("vmcoreinfo_find()") \
-           or not gdb.parse_and_eval("vmcoreinfo_find()->has_vmcoreinfo"=
):
+        vmci =3D '(VMCoreInfoState *)' + \
+               'object_resolve_path_type("", "vmcoreinfo", 0)'
+        if not gdb.parse_and_eval("%s" % vmci) \
+           or not gdb.parse_and_eval("(%s)->has_vmcoreinfo" % vmci):
             return
=20
-        fmt =3D gdb.parse_and_eval("vmcoreinfo_find()->vmcoreinfo.guest_=
format")
-        addr =3D gdb.parse_and_eval("vmcoreinfo_find()->vmcoreinfo.paddr=
")
-        size =3D gdb.parse_and_eval("vmcoreinfo_find()->vmcoreinfo.size"=
)
+        fmt =3D gdb.parse_and_eval("(%s)->vmcoreinfo.guest_format" % vmc=
i)
+        addr =3D gdb.parse_and_eval("(%s)->vmcoreinfo.paddr" % vmci)
+        size =3D gdb.parse_and_eval("(%s)->vmcoreinfo.size" % vmci)
=20
         fmt =3D le16_to_cpu(fmt)
         addr =3D le64_to_cpu(addr)
--=20
2.15.0.277.ga3d2ad2c43
