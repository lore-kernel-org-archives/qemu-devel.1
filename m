Received: from eggs.gnu.org ([2001:4830:134:3::10]:48833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3ZW3-0002Cw-JI
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3ZW2-0006Hm-I4
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:23:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1e3ZW2-0006GF-8y
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:23:02 -0400
Date: Sun, 15 Oct 2017 06:22:58 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1508036858-13479-7-git-send-email-mst@redhat.com>
References: <1508036858-13479-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1508036858-13479-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/26] dump: update phys_base header field based
 on VMCOREINFO content
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

If the guest note is VMCOREINFO, try to get phys_base from it.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/specs/vmcoreinfo.txt |  8 +++++++
 dump.c                    | 56 +++++++++++++++++++++++++++++++++++++++++=
++++--
 2 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/docs/specs/vmcoreinfo.txt b/docs/specs/vmcoreinfo.txt
index 2868a77..8212610 100644
--- a/docs/specs/vmcoreinfo.txt
+++ b/docs/specs/vmcoreinfo.txt
@@ -39,3 +39,11 @@ qemu dumps.
=20
 The note format/class must be of the target bitness and the size must
 be less than 1Mb.
+
+If the ELF note name is "VMCOREINFO", it is expected to be the Linux
+vmcoreinfo note (see Documentation/ABI/testing/sysfs-kernel-vmcoreinfo
+in Linux source). In this case, qemu dump code will read the content
+as a key=3Dvalue text file, looking for "NUMBER(phys_base)" key
+value. The value is expected to be more accurate than architecture
+guess of the value. This is useful for KASLR-enabled guest with
+ancient tools not handling the VMCOREINFO note.
diff --git a/dump.c b/dump.c
index 1479f1f..5674512 100644
--- a/dump.c
+++ b/dump.c
@@ -779,6 +779,23 @@ static void get_note_sizes(DumpState *s, const void =
*note,
     }
 }
=20
+static bool note_name_equal(DumpState *s,
+                            const uint8_t *note, const char *name)
+{
+    int len =3D strlen(name) + 1;
+    uint64_t head_size, name_size;
+
+    get_note_sizes(s, note, &head_size, &name_size, NULL);
+    head_size =3D ROUND_UP(head_size, 4);
+
+    if (name_size !=3D len ||
+        memcmp(note + head_size, "VMCOREINFO", len)) {
+        return false;
+    }
+
+    return true;
+}
+
 /* write common header, sub header and elf note to vmcore */
 static void create_header32(DumpState *s, Error **errp)
 {
@@ -1553,6 +1570,39 @@ static int64_t dump_calculate_size(DumpState *s)
     return total;
 }
=20
+static void vmcoreinfo_update_phys_base(DumpState *s)
+{
+    uint64_t size, note_head_size, name_size, phys_base;
+    char **lines;
+    uint8_t *vmci;
+    size_t i;
+
+    if (!note_name_equal(s, s->guest_note, "VMCOREINFO")) {
+        return;
+    }
+
+    get_note_sizes(s, s->guest_note, &note_head_size, &name_size, &size)=
;
+    note_head_size =3D ROUND_UP(note_head_size, 4);
+
+    vmci =3D s->guest_note + note_head_size + ROUND_UP(name_size, 4);
+    *(vmci + size) =3D '\0';
+
+    lines =3D g_strsplit((char *)vmci, "\n", -1);
+    for (i =3D 0; lines[i]; i++) {
+        if (g_str_has_prefix(lines[i], "NUMBER(phys_base)=3D")) {
+            if (qemu_strtou64(lines[i] + 18, NULL, 16,
+                              &phys_base) < 0) {
+                warn_report("Failed to read NUMBER(phys_base)=3D");
+            } else {
+                s->dump_info.phys_base =3D phys_base;
+            }
+            break;
+        }
+    }
+
+    g_strfreev(lines);
+}
+
 static void dump_init(DumpState *s, int fd, bool has_format,
                       DumpGuestMemoryFormat format, bool paging, bool ha=
s_filter,
                       int64_t begin, int64_t length, Error **errp)
@@ -1636,8 +1686,9 @@ static void dump_init(DumpState *s, int fd, bool ha=
s_format,
     }
=20
     /*
-     * The goal of this block is to copy the guest note out of
-     * the guest.  Failure to do so is not fatal for dumping.
+     * The goal of this block is to (a) update the previously guessed
+     * phys_base, (b) copy the guest note out of the guest.
+     * Failure to do so is not fatal for dumping.
      */
     if (vmci) {
         uint64_t addr, note_head_size, name_size, desc_size;
@@ -1670,6 +1721,7 @@ static void dump_init(DumpState *s, int fd, bool ha=
s_format,
                 g_free(s->guest_note);
                 s->guest_note =3D NULL;
             } else {
+                vmcoreinfo_update_phys_base(s);
                 s->note_size +=3D s->guest_note_size;
             }
         }
--=20
MST
