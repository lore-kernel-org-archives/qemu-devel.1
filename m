Received: from eggs.gnu.org ([2001:4830:134:3::10]:58950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmh0K-0002jv-W3
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:24:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmh0J-0002mS-AT
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:24:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cmh0J-0002mM-2B
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:24:15 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 11 Mar 2017 17:22:54 +0400
Message-Id: <20170311132256.22951-20-marcandre.lureau@redhat.com>
In-Reply-To: <20170311132256.22951-1-marcandre.lureau@redhat.com>
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 19/21] kdump: write vmcoreinfo in header
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 dump.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/dump.c b/dump.c
index 0ebfb5471a..bf88cb362b 100644
--- a/dump.c
+++ b/dump.c
@@ -785,8 +785,9 @@ static void create_header32(DumpState *s, Error **err=
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
@@ -835,7 +836,18 @@ static void create_header32(DumpState *s, Error **er=
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
+            s->vmcoreinfo + ((hsize + 3) / 4 + (name_size + 3) / 4) * 4;
+        kh->offset_vmcoreinfo =3D cpu_to_dump64(s, offset_vmcoreinfo);
+        kh->size_vmcoreinfo =3D cpu_to_dump32(s, size_vmcoreinfo);
+    }
+
+    offset_note =3D offset_vmcoreinfo + size_vmcoreinfo;
     kh->offset_note =3D cpu_to_dump64(s, offset_note);
     kh->note_size =3D cpu_to_dump32(s, s->note_size);
=20
@@ -845,6 +857,14 @@ static void create_header32(DumpState *s, Error **er=
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
@@ -885,8 +905,9 @@ static void create_header64(DumpState *s, Error **err=
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
@@ -935,7 +956,18 @@ static void create_header64(DumpState *s, Error **er=
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
+            s->vmcoreinfo + ((hsize + 3) / 4 + (name_size + 3) / 4) * 4;
+        kh->offset_vmcoreinfo =3D cpu_to_dump64(s, offset_vmcoreinfo);
+        kh->size_vmcoreinfo =3D cpu_to_dump64(s, size_vmcoreinfo);
+    }
+
+    offset_note =3D offset_vmcoreinfo + size_vmcoreinfo;
     kh->offset_note =3D cpu_to_dump64(s, offset_note);
     kh->note_size =3D cpu_to_dump64(s, s->note_size);
=20
@@ -945,6 +977,14 @@ static void create_header64(DumpState *s, Error **er=
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
2.12.0.191.gc5d8de91d
