Received: from eggs.gnu.org ([2001:4830:134:3::10]:58969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmh0N-0002mm-UI
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:24:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmh0N-0002nx-1e
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:24:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cmh0M-0002nt-Rw
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:24:18 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 11 Mar 2017 17:22:55 +0400
Message-Id: <20170311132256.22951-21-marcandre.lureau@redhat.com>
In-Reply-To: <20170311132256.22951-1-marcandre.lureau@redhat.com>
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 20/21] scripts/dump-guest-memory.py: fix
 int128_get64 on recent gcc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, anderson@redhat.com, mdroth@linux.vnet.ibm.com, armbru@redhat.com, lersek@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The Int128 is no longer a struct, reaching a python exception:
Python Exception <class 'gdb.error'> Attempt to extract a component of a =
value that is not a (null).:

Replace struct access with a cast to uint64 instead.

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1427466

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/dump-guest-memory.py | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.py
index 9956fc036c..f7c6635f15 100644
--- a/scripts/dump-guest-memory.py
+++ b/scripts/dump-guest-memory.py
@@ -314,8 +314,18 @@ def get_arch_phdr(endianness, elfclass):
 def int128_get64(val):
     """Returns low 64bit part of Int128 struct."""
=20
-    assert val["hi"] =3D=3D 0
-    return val["lo"]
+    try:
+        assert val["hi"] =3D=3D 0
+        return val["lo"]
+    except gdb.error:
+        u64t =3D gdb.lookup_type('uint64_t').array(2)
+        u64 =3D val.cast(u64t)
+        if sys.byteorder =3D=3D 'little':
+            assert u64[1] =3D=3D 0
+            return u64[0]
+        else:
+            assert u64[0] =3D=3D 0
+            return u64[1]
=20
=20
 def qlist_foreach(head, field_str):
--=20
2.12.0.191.gc5d8de91d
