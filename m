Received: from eggs.gnu.org ([2001:4830:134:3::10]:39626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1demaJ-0006zA-O1
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 14:17:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1demaE-0000Ay-Pe
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 14:16:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1demaE-0000AL-JO
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 14:16:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8A22C883A0
	for <qemu-devel@nongnu.org>; Mon,  7 Aug 2017 18:16:53 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  7 Aug 2017 20:16:16 +0200
Message-Id: <20170807181618.22562-7-marcandre.lureau@redhat.com>
In-Reply-To: <20170807181618.22562-1-marcandre.lureau@redhat.com>
References: <20170807181618.22562-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 6/8] kdump: set vmcoreinfo location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, berrange@redhat.com, ehabkost@redhat.com, mst@redhat.com, anderson@redhat.com, lersek@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

kdump header provides offset and size of the vmcoreinfo content,
append it if available (skip the ELF note header).

crash-7.1.9 was the first version that started looking in the
vmcoreinfo data for phys_base instead of in the kdump_sub_header.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 dump.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/dump.c b/dump.c
index cef2dd5bf9..49805a3cdc 100644
--- a/dump.c
+++ b/dump.c
@@ -858,6 +858,18 @@ static void create_header32(DumpState *s, Error **er=
rp)
     kh->dump_level =3D cpu_to_dump32(s, DUMP_LEVEL);
=20
     offset_note =3D DISKDUMP_HEADER_BLOCKS * block_size + size;
+    if (s->guest_note &&
+        note_name_equal(s, s->guest_note, "VMCOREINFO")) {
+        uint64_t hsize, name_size, size_vmcoreinfo_desc, offset_vmcorein=
fo;
+
+        get_note_sizes(s, s->guest_note,
+                       &hsize, &name_size, &size_vmcoreinfo_desc);
+        offset_vmcoreinfo =3D offset_note + s->note_size - s->guest_note=
_size +
+            (DIV_ROUND_UP(hsize, 4) + DIV_ROUND_UP(name_size, 4)) * 4;
+        kh->offset_vmcoreinfo =3D cpu_to_dump64(s, offset_vmcoreinfo);
+        kh->size_vmcoreinfo =3D cpu_to_dump32(s, size_vmcoreinfo_desc);
+    }
+
     kh->offset_note =3D cpu_to_dump64(s, offset_note);
     kh->note_size =3D cpu_to_dump32(s, s->note_size);
=20
@@ -958,6 +970,18 @@ static void create_header64(DumpState *s, Error **er=
rp)
     kh->dump_level =3D cpu_to_dump32(s, DUMP_LEVEL);
=20
     offset_note =3D DISKDUMP_HEADER_BLOCKS * block_size + size;
+    if (s->guest_note &&
+        note_name_equal(s, s->guest_note, "VMCOREINFO")) {
+        uint64_t hsize, name_size, size_vmcoreinfo_desc, offset_vmcorein=
fo;
+
+        get_note_sizes(s, s->guest_note,
+                       &hsize, &name_size, &size_vmcoreinfo_desc);
+        offset_vmcoreinfo =3D offset_note + s->note_size - s->guest_note=
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
2.14.0.1.geff633fa0
