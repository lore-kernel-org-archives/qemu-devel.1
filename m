Received: from eggs.gnu.org ([2001:4830:134:3::10]:48849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3ZW4-0002Dv-Mc
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:23:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3ZW3-0006J6-DA
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:23:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1e3ZW3-0006Ht-6m
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:23:03 -0400
Date: Sun, 15 Oct 2017 06:23:01 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1508036858-13479-8-git-send-email-mst@redhat.com>
References: <1508036858-13479-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1508036858-13479-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/26] kdump: set vmcoreinfo location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

kdump header provides offset and size of the vmcoreinfo content,
append it if available (skip the ELF note header).

crash-7.1.9 was the first version that started looking in the
vmcoreinfo data for phys_base instead of in the kdump_sub_header.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 dump.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/dump.c b/dump.c
index 5674512..d4a8c94 100644
--- a/dump.c
+++ b/dump.c
@@ -857,6 +857,18 @@ static void create_header32(DumpState *s, Error **er=
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
@@ -957,6 +969,18 @@ static void create_header64(DumpState *s, Error **er=
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
MST
