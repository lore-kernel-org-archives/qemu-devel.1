Received: from eggs.gnu.org ([2001:4830:134:3::10]:54841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eKoo1-0000rW-Gc
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:08:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eKoo0-00076Y-KP
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:08:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eKoo0-00076P-Dn
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:08:52 -0500
Date: Fri, 1 Dec 2017 19:08:47 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1512148088-28733-5-git-send-email-mst@redhat.com>
References: <1512148088-28733-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1512148088-28733-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/7] dump-guest-memory.py: fix No symbol
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
Cc: Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

When qemu is compiled without debug, the dump gdb python script can fail =
with:

Error occurred in Python command: No symbol "vmcoreinfo_find" in current =
context.

Because vmcoreinfo_find() is inlined and not exported.

Use the underlying object_resolve_path_type() to get the instance instead=
.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 scripts/dump-guest-memory.py | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.py
index 69dd5ef..1af26c1 100644
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
MST
