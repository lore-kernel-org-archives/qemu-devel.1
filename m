Received: from eggs.gnu.org ([2001:4830:134:3::10]:39579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1demaE-0006uR-AH
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 14:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dema9-00007A-5p
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 14:16:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dema8-00005u-UP
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 14:16:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D4F827EA88
	for <qemu-devel@nongnu.org>; Mon,  7 Aug 2017 18:16:47 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  7 Aug 2017 20:16:15 +0200
Message-Id: <20170807181618.22562-6-marcandre.lureau@redhat.com>
In-Reply-To: <20170807181618.22562-1-marcandre.lureau@redhat.com>
References: <20170807181618.22562-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 5/8] dump: update phys_base header field
 based on VMCOREINFO content
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

If the guest note is VMCOREINFO, try to get phys_base from it.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 dump.c                | 56 +++++++++++++++++++++++++++++++++++++++++++++=
++++--
 docs/specs/fw_cfg.txt |  8 ++++++++
 2 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/dump.c b/dump.c
index 7fe1044280..cef2dd5bf9 100644
--- a/dump.c
+++ b/dump.c
@@ -780,6 +780,23 @@ static void get_note_sizes(DumpState *s, const void =
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
@@ -1554,6 +1571,39 @@ static int64_t dump_calculate_size(DumpState *s)
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
@@ -1631,8 +1681,9 @@ static void dump_init(DumpState *s, int fd, bool ha=
s_format,
     }
=20
     /*
-     * The goal of this block is to copy the guest note out of
-     * the guest.  Failure to do so is not fatal for dumping.
+     * The goal of this block is to (a) update the previously guessed
+     * phys_base, (b) copy the guest note note out of the guest.
+     * Failure to do so is not fatal for dumping.
      */
     if (fw_cfg) {
         uint64_t addr, note_head_size, name_size, desc_size;
@@ -1661,6 +1712,7 @@ static void dump_init(DumpState *s, int fd, bool ha=
s_format,
                 g_free(s->guest_note);
                 s->guest_note =3D NULL;
             } else {
+                vmcoreinfo_update_phys_base(s);
                 s->note_size +=3D s->guest_note_size;
             }
         }
diff --git a/docs/specs/fw_cfg.txt b/docs/specs/fw_cfg.txt
index 37d0f9f40a..64c6aaed1f 100644
--- a/docs/specs/fw_cfg.txt
+++ b/docs/specs/fw_cfg.txt
@@ -152,6 +152,14 @@ struct FWCfgVMCoreInfo {
 The note format/class must be of the target bitness and the size must
 be less than 1Mb.
=20
+If the ELF note name is "VMCOREINFO", it is expected to be the Linux
+vmcoreinfo note (see Documentation/ABI/testing/sysfs-kernel-vmcoreinfo
+in Linux source). In this case, qemu dump code will read the content
+as a key=3Dvalue text file, looking for "NUMBER(phys_base)" key
+value. The value is expected to be more accurate than architecture
+guess of the value. This is useful for KASLR-enabled guest with
+ancient tools not handling the VMCOREINFO note.
+
 =3D=3D=3D All Other Data Items =3D=3D=3D
=20
 Please consult the QEMU source for the most up-to-date and authoritative=
 list
--=20
2.14.0.1.geff633fa0
