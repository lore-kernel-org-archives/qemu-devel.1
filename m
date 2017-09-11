Received: from eggs.gnu.org ([2001:4830:134:3::10]:57640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drS3q-0005wf-6n
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 12:59:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drS3p-00077T-5Q
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 12:59:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1drS3o-000778-SI
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 12:59:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BABF4C00DBB0
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 16:59:47 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 11 Sep 2017 18:59:25 +0200
Message-Id: <20170911165929.2791-4-marcandre.lureau@redhat.com>
In-Reply-To: <20170911165929.2791-1-marcandre.lureau@redhat.com>
References: <20170911165929.2791-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 3/7] dump: add guest ELF note
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

Read the guest ELF PT_NOTE from guest memory when fw_cfg
etc/vmcoreinfo entry provides the location, and write it as an
additional note in the dump.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/sysemu/dump.h |   2 +
 dump.c                | 107 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
 2 files changed, 109 insertions(+)

diff --git a/include/sysemu/dump.h b/include/sysemu/dump.h
index 2672a15f8b..df43bd0e07 100644
--- a/include/sysemu/dump.h
+++ b/include/sysemu/dump.h
@@ -192,6 +192,8 @@ typedef struct DumpState {
                                   * this could be used to calculate
                                   * how much work we have
                                   * finished. */
+    uint8_t *guest_note;         /* ELF note content */
+    size_t guest_note_size;
 } DumpState;
=20
 uint16_t cpu_to_dump16(DumpState *s, uint16_t val);
diff --git a/dump.c b/dump.c
index a79773d0f7..3cec6a8c93 100644
--- a/dump.c
+++ b/dump.c
@@ -26,6 +26,8 @@
 #include "qapi/qmp/qerror.h"
 #include "qmp-commands.h"
 #include "qapi-event.h"
+#include "qemu/error-report.h"
+#include "hw/misc/vmcoreinfo.h"
=20
 #include <zlib.h>
 #ifdef CONFIG_LZO
@@ -38,6 +40,13 @@
 #define ELF_MACHINE_UNAME "Unknown"
 #endif
=20
+#define MAX_GUEST_NOTE_SIZE (1 << 20) /* 1MB should be enough */
+
+#define ELF_NOTE_SIZE(hdr_size, name_size, desc_size)   \
+    ((DIV_ROUND_UP((hdr_size), 4) +                     \
+      DIV_ROUND_UP((name_size), 4) +                    \
+      DIV_ROUND_UP((desc_size), 4)) * 4)
+
 uint16_t cpu_to_dump16(DumpState *s, uint16_t val)
 {
     if (s->dump_info.d_endian =3D=3D ELFDATA2LSB) {
@@ -76,6 +85,8 @@ static int dump_cleanup(DumpState *s)
     guest_phys_blocks_free(&s->guest_phys_blocks);
     memory_mapping_list_free(&s->list);
     close(s->fd);
+    g_free(s->guest_note);
+    s->guest_note =3D NULL;
     if (s->resume) {
         if (s->detached) {
             qemu_mutex_lock_iothread();
@@ -235,6 +246,19 @@ static inline int cpu_index(CPUState *cpu)
     return cpu->cpu_index + 1;
 }
=20
+static void write_guest_note(WriteCoreDumpFunction f, DumpState *s,
+                             Error **errp)
+{
+    int ret;
+
+    if (s->guest_note) {
+        ret =3D f(s->guest_note, s->guest_note_size, s);
+        if (ret < 0) {
+            error_setg(errp, "dump: failed to write guest note");
+        }
+    }
+}
+
 static void write_elf64_notes(WriteCoreDumpFunction f, DumpState *s,
                               Error **errp)
 {
@@ -258,6 +282,8 @@ static void write_elf64_notes(WriteCoreDumpFunction f=
, DumpState *s,
             return;
         }
     }
+
+    write_guest_note(f, s, errp);
 }
=20
 static void write_elf32_note(DumpState *s, Error **errp)
@@ -303,6 +329,8 @@ static void write_elf32_notes(WriteCoreDumpFunction f=
, DumpState *s,
             return;
         }
     }
+
+    write_guest_note(f, s, errp);
 }
=20
 static void write_elf_section(DumpState *s, int type, Error **errp)
@@ -714,6 +742,44 @@ static int buf_write_note(const void *buf, size_t si=
ze, void *opaque)
     return 0;
 }
=20
+/*
+ * This function retrieves various sizes from an elf header.
+ *
+ * @note has to be a valid ELF note. The return sizes are unmodified
+ * (not padded or rounded up to be multiple of 4).
+ */
+static void get_note_sizes(DumpState *s, const void *note,
+                           uint64_t *note_head_size,
+                           uint64_t *name_size,
+                           uint64_t *desc_size)
+{
+    uint64_t note_head_sz;
+    uint64_t name_sz;
+    uint64_t desc_sz;
+
+    if (s->dump_info.d_class =3D=3D ELFCLASS64) {
+        const Elf64_Nhdr *hdr =3D note;
+        note_head_sz =3D sizeof(Elf64_Nhdr);
+        name_sz =3D tswap64(hdr->n_namesz);
+        desc_sz =3D tswap64(hdr->n_descsz);
+    } else {
+        const Elf32_Nhdr *hdr =3D note;
+        note_head_sz =3D sizeof(Elf32_Nhdr);
+        name_sz =3D tswap32(hdr->n_namesz);
+        desc_sz =3D tswap32(hdr->n_descsz);
+    }
+
+    if (note_head_size) {
+        *note_head_size =3D note_head_sz;
+    }
+    if (name_size) {
+        *name_size =3D name_sz;
+    }
+    if (desc_size) {
+        *desc_size =3D desc_sz;
+    }
+}
+
 /* write common header, sub header and elf note to vmcore */
 static void create_header32(DumpState *s, Error **errp)
 {
@@ -1492,6 +1558,7 @@ static void dump_init(DumpState *s, int fd, bool ha=
s_format,
                       DumpGuestMemoryFormat format, bool paging, bool ha=
s_filter,
                       int64_t begin, int64_t length, Error **errp)
 {
+    VMCoreInfoState *vmci =3D vmcoreinfo_find();
     CPUState *cpu;
     int nr_cpus;
     Error *err =3D NULL;
@@ -1563,6 +1630,46 @@ static void dump_init(DumpState *s, int fd, bool h=
as_format,
         goto cleanup;
     }
=20
+    /*
+     * The goal of this block is to copy the guest note out of
+     * the guest.  Failure to do so is not fatal for dumping.
+     */
+    if (vmci) {
+        uint64_t addr, note_head_size, name_size, desc_size;
+        uint32_t size;
+        uint16_t format;
+
+        note_head_size =3D s->dump_info.d_class =3D=3D ELFCLASS32 ?
+            sizeof(Elf32_Nhdr) : sizeof(Elf64_Nhdr);
+
+        format =3D le16_to_cpu(vmci->vmcoreinfo.guest_format);
+        size =3D le32_to_cpu(vmci->vmcoreinfo.size);
+        addr =3D le64_to_cpu(vmci->vmcoreinfo.paddr);
+        if (!vmci->has_vmcoreinfo) {
+            warn_report("guest note is not present");
+        } else if (size < note_head_size || size > MAX_GUEST_NOTE_SIZE) =
{
+            warn_report("guest note size is invalid: %" PRIu32, size);
+        } else if (format !=3D VMCOREINFO_FORMAT_ELF) {
+            warn_report("guest note format is unsupported: %" PRIu16, fo=
rmat);
+        } else {
+            s->guest_note =3D g_malloc(size + 1); /* +1 for adding \0 */
+            cpu_physical_memory_read(addr, s->guest_note, size);
+
+            get_note_sizes(s, s->guest_note, NULL, &name_size, &desc_siz=
e);
+            s->guest_note_size =3D ELF_NOTE_SIZE(note_head_size, name_si=
ze,
+                                               desc_size);
+            if (name_size > MAX_GUEST_NOTE_SIZE ||
+                desc_size > MAX_GUEST_NOTE_SIZE ||
+                s->guest_note_size > size) {
+                warn_report("Invalid guest note header");
+                g_free(s->guest_note);
+                s->guest_note =3D NULL;
+            } else {
+                s->note_size +=3D s->guest_note_size;
+            }
+        }
+    }
+
     /* get memory mapping */
     if (paging) {
         qemu_get_guest_memory_mapping(&s->list, &s->guest_phys_blocks, &=
err);
--=20
2.14.1.146.gd35faa819
