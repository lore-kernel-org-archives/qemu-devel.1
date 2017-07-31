Received: from eggs.gnu.org ([2001:4830:134:3::10]:54647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc7zf-0003MZ-8G
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:32:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc7ze-0004Td-CG
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:32:11 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 31 Jul 2017 13:21:37 +0300
Message-Id: <a44af723b3d5e6fa003b9d7f70f249c5529aa03a.1501496350.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
References: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
References: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 18/25] thunk: assert nb_fields is valid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

thunk.c:91:32: warning: Call to 'malloc' has an allocation size of 0 byte=
s
        se->field_offsets[i] =3D malloc(nb_fields * sizeof(int));
                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 thunk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/thunk.c b/thunk.c
index 2dac36666d..d5d8645cd4 100644
--- a/thunk.c
+++ b/thunk.c
@@ -67,7 +67,6 @@ void thunk_register_struct(int id, const char *name, co=
nst argtype *types)
     int nb_fields, offset, max_align, align, size, i, j;
=20
     assert(id < max_struct_entries);
-    se =3D struct_entries + id;
=20
     /* first we count the number of fields */
     type_ptr =3D types;
@@ -76,6 +75,8 @@ void thunk_register_struct(int id, const char *name, co=
nst argtype *types)
         type_ptr =3D thunk_type_next(type_ptr);
         nb_fields++;
     }
+    assert(nb_fields > 0);
+    se =3D struct_entries + id;
     se->field_types =3D types;
     se->nb_fields =3D nb_fields;
     se->name =3D name;
--=20
2.11.0
