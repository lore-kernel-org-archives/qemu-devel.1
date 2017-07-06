Received: from eggs.gnu.org ([2001:4830:134:3::10]:35311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dT3q1-0004ZD-0b
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 06:16:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dT3pu-0000cO-TC
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 06:16:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dT3pu-0000bx-Md
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 06:16:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BC253C0587C0
	for <qemu-devel@nongnu.org>; Thu,  6 Jul 2017 10:16:37 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  6 Jul 2017 12:16:09 +0200
Message-Id: <20170706101611.27031-6-marcandre.lureau@redhat.com>
In-Reply-To: <20170706101611.27031-1-marcandre.lureau@redhat.com>
References: <20170706101611.27031-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 5/7] kdump: add vmcoreinfo ELF note
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, anderson@redhat.com, berrange@redhat.com, ehabkost@redhat.com, lersek@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

kdump header provides offset and size of the vmcoreinfo ELF note,
append it if available.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 dump.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/dump.c b/dump.c
index f699198204..dd416ad271 100644
--- a/dump.c
+++ b/dump.c
@@ -839,6 +839,16 @@ static void create_header32(DumpState *s, Error **er=
rp)
     kh->dump_level =3D cpu_to_dump32(s, DUMP_LEVEL);
=20
     offset_note =3D DISKDUMP_HEADER_BLOCKS * block_size + size;
+    if (s->vmcoreinfo) {
+        uint64_t hsize, name_size, size_vmcoreinfo_desc, offset_vmcorein=
fo;
+
+        get_note_sizes(s, s->vmcoreinfo, &hsize, &name_size, &size_vmcor=
einfo_desc);
+        offset_vmcoreinfo =3D offset_note + s->note_size - s->vmcoreinfo=
_size +
+            (DIV_ROUND_UP(hsize, 4) + DIV_ROUND_UP(name_size, 4)) * 4;
+        kh->offset_vmcoreinfo =3D cpu_to_dump64(s, offset_vmcoreinfo);
+        kh->size_vmcoreinfo =3D cpu_to_dump32(s, size_vmcoreinfo_desc);
+    }
+
     kh->offset_note =3D cpu_to_dump64(s, offset_note);
     kh->note_size =3D cpu_to_dump32(s, s->note_size);
=20
@@ -939,6 +949,16 @@ static void create_header64(DumpState *s, Error **er=
rp)
     kh->dump_level =3D cpu_to_dump32(s, DUMP_LEVEL);
=20
     offset_note =3D DISKDUMP_HEADER_BLOCKS * block_size + size;
+    if (s->vmcoreinfo) {
+        uint64_t hsize, name_size, size_vmcoreinfo_desc, offset_vmcorein=
fo;
+
+        get_note_sizes(s, s->vmcoreinfo, &hsize, &name_size, &size_vmcor=
einfo_desc);
+        offset_vmcoreinfo =3D offset_note + s->note_size - s->vmcoreinfo=
_size +
+            (DIV_ROUND_UP(hsize, 4) + DIV_ROUND_UP(name_size, 4)) * 4;
+        kh->offset_vmcoreinfo =3D cpu_to_dump64(s, offset_vmcoreinfo);
+        kh->size_vmcoreinfo =3D cpu_to_dump64(s, size_vmcoreinfo_desc);
+    }
+
     kh->offset_note =3D cpu_to_dump64(s, offset_note);
     kh->note_size =3D cpu_to_dump64(s, s->note_size);
=20
--=20
2.13.1.395.gf7b71de06
