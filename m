Received: from eggs.gnu.org ([2001:4830:134:3::10]:47520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dQZQB-0001oT-Kx
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:23:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dQZQA-0007q0-Md
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:23:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dQZQA-0007pn-DG
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:23:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 714B2A78C6
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 13:23:45 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 29 Jun 2017 15:23:08 +0200
Message-Id: <20170629132310.18865-6-marcandre.lureau@redhat.com>
In-Reply-To: <20170629132310.18865-1-marcandre.lureau@redhat.com>
References: <20170629132310.18865-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 5/7] kdump: add vmcoreinfo ELF note
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
 dump.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/dump.c b/dump.c
index 8fda5cc1ed..b78bc1fda7 100644
--- a/dump.c
+++ b/dump.c
@@ -788,8 +788,9 @@ static void create_header32(DumpState *s, Error **err=
p)
     uint32_t sub_hdr_size;
     uint32_t bitmap_blocks;
     uint32_t status =3D 0;
-    uint64_t offset_note;
+    uint64_t offset_note, offset_vmcoreinfo, size_vmcoreinfo =3D 0;
     Error *local_err =3D NULL;
+    uint8_t *vmcoreinfo =3D NULL;
=20
     /* write common header, the version of kdump-compressed format is 6t=
h */
     size =3D sizeof(DiskDumpHeader32);
@@ -838,7 +839,18 @@ static void create_header32(DumpState *s, Error **er=
rp)
     kh->phys_base =3D cpu_to_dump32(s, s->dump_info.phys_base);
     kh->dump_level =3D cpu_to_dump32(s, DUMP_LEVEL);
=20
-    offset_note =3D DISKDUMP_HEADER_BLOCKS * block_size + size;
+    offset_vmcoreinfo =3D DISKDUMP_HEADER_BLOCKS * block_size + size;
+    if (s->vmcoreinfo) {
+        uint64_t hsize, name_size;
+
+        get_note_sizes(s, s->vmcoreinfo, &hsize, &name_size, &size_vmcor=
einfo);
+        vmcoreinfo =3D
+            s->vmcoreinfo + (DIV_ROUND_UP(hsize, 4) + DIV_ROUND_UP(name_=
size, 4)) * 4;
+        kh->offset_vmcoreinfo =3D cpu_to_dump64(s, offset_vmcoreinfo);
+        kh->size_vmcoreinfo =3D cpu_to_dump32(s, size_vmcoreinfo);
+    }
+
+    offset_note =3D offset_vmcoreinfo + size_vmcoreinfo;
     kh->offset_note =3D cpu_to_dump64(s, offset_note);
     kh->note_size =3D cpu_to_dump32(s, s->note_size);
=20
@@ -848,6 +860,14 @@ static void create_header32(DumpState *s, Error **er=
rp)
         goto out;
     }
=20
+    if (vmcoreinfo) {
+        if (write_buffer(s->fd, offset_vmcoreinfo, vmcoreinfo,
+                         size_vmcoreinfo) < 0) {
+            error_setg(errp, "dump: failed to vmcoreinfo");
+            goto out;
+        }
+    }
+
     /* write note */
     s->note_buf =3D g_malloc0(s->note_size);
     s->note_buf_offset =3D 0;
@@ -888,8 +908,9 @@ static void create_header64(DumpState *s, Error **err=
p)
     uint32_t sub_hdr_size;
     uint32_t bitmap_blocks;
     uint32_t status =3D 0;
-    uint64_t offset_note;
+    uint64_t offset_note, offset_vmcoreinfo, size_vmcoreinfo =3D 0;
     Error *local_err =3D NULL;
+    uint8_t *vmcoreinfo =3D NULL;
=20
     /* write common header, the version of kdump-compressed format is 6t=
h */
     size =3D sizeof(DiskDumpHeader64);
@@ -938,7 +959,18 @@ static void create_header64(DumpState *s, Error **er=
rp)
     kh->phys_base =3D cpu_to_dump64(s, s->dump_info.phys_base);
     kh->dump_level =3D cpu_to_dump32(s, DUMP_LEVEL);
=20
-    offset_note =3D DISKDUMP_HEADER_BLOCKS * block_size + size;
+    offset_vmcoreinfo =3D DISKDUMP_HEADER_BLOCKS * block_size + size;
+    if (s->vmcoreinfo) {
+        uint64_t hsize, name_size;
+
+        get_note_sizes(s, s->vmcoreinfo, &hsize, &name_size, &size_vmcor=
einfo);
+        vmcoreinfo =3D
+            s->vmcoreinfo + (DIV_ROUND_UP(hsize, 4) + DIV_ROUND_UP(name_=
size, 4)) * 4;
+        kh->offset_vmcoreinfo =3D cpu_to_dump64(s, offset_vmcoreinfo);
+        kh->size_vmcoreinfo =3D cpu_to_dump64(s, size_vmcoreinfo);
+    }
+
+    offset_note =3D offset_vmcoreinfo + size_vmcoreinfo;
     kh->offset_note =3D cpu_to_dump64(s, offset_note);
     kh->note_size =3D cpu_to_dump64(s, s->note_size);
=20
@@ -948,6 +980,14 @@ static void create_header64(DumpState *s, Error **er=
rp)
         goto out;
     }
=20
+    if (vmcoreinfo) {
+        if (write_buffer(s->fd, offset_vmcoreinfo, vmcoreinfo,
+                         size_vmcoreinfo) < 0) {
+            error_setg(errp, "dump: failed to vmcoreinfo");
+            goto out;
+        }
+    }
+
     /* write note */
     s->note_buf =3D g_malloc0(s->note_size);
     s->note_buf_offset =3D 0;
--=20
2.13.1.395.gf7b71de06
