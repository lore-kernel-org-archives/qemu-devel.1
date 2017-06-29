Received: from eggs.gnu.org ([2001:4830:134:3::10]:47505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dQZQ8-0001kh-Nx
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:23:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dQZQ5-0007oU-W7
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:23:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dQZQ5-0007o9-OP
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:23:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D9BC3ABB26
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 13:23:40 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 29 Jun 2017 15:23:07 +0200
Message-Id: <20170629132310.18865-5-marcandre.lureau@redhat.com>
In-Reply-To: <20170629132310.18865-1-marcandre.lureau@redhat.com>
References: <20170629132310.18865-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/7] dump: add vmcoreinfo ELF note
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

Read the vmcoreinfo ELF PT_NOTE from guest memory when vmcoreinfo
device provides the location, and write it as an ELF note in the dump.

There are now 2 possible sources of phys_base information.

(1) arch guessed value from arch_dump_info_get()
(2) vmcoreinfo ELF note NUMBER(phys_base)=3D field

    NUMBER(phys_base) in vmcoreinfo has only been recently introduced
    in Linux 4.10 (401721ecd1dc "kexec: export the value of phys_base
    instead of symbol address").

Since (2) has better chances to be accurate, the guessed value is
replaced by the value from the vmcoreinfo ELF note.

The phys_base value is stored in the same dump field locations as
before, and may duplicate the information available in the vmcoreinfo
ELF PT_NOTE. Crash tools should be prepared to handle this case.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/sysemu/dump.h |   2 +
 dump.c                | 117 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
 2 files changed, 119 insertions(+)

diff --git a/include/sysemu/dump.h b/include/sysemu/dump.h
index 2672a15f8b..111a7dcaa4 100644
--- a/include/sysemu/dump.h
+++ b/include/sysemu/dump.h
@@ -192,6 +192,8 @@ typedef struct DumpState {
                                   * this could be used to calculate
                                   * how much work we have
                                   * finished. */
+    uint8_t *vmcoreinfo;         /* ELF note content */
+    size_t vmcoreinfo_size;
 } DumpState;
=20
 uint16_t cpu_to_dump16(DumpState *s, uint16_t val);
diff --git a/dump.c b/dump.c
index d9090a24cc..8fda5cc1ed 100644
--- a/dump.c
+++ b/dump.c
@@ -26,6 +26,8 @@
 #include "qapi/qmp/qerror.h"
 #include "qmp-commands.h"
 #include "qapi-event.h"
+#include "qemu/error-report.h"
+#include "hw/acpi/vmcoreinfo.h"
=20
 #include <zlib.h>
 #ifdef CONFIG_LZO
@@ -38,6 +40,11 @@
 #define ELF_MACHINE_UNAME "Unknown"
 #endif
=20
+#define ELF_NOTE_SIZE(hdr_size, name_size, desc_size)   \
+    ((DIV_ROUND_UP((hdr_size), 4)                       \
+      + DIV_ROUND_UP((name_size), 4)                    \
+      + DIV_ROUND_UP((desc_size), 4)) * 4)
+
 uint16_t cpu_to_dump16(DumpState *s, uint16_t val)
 {
     if (s->dump_info.d_endian =3D=3D ELFDATA2LSB) {
@@ -76,6 +83,8 @@ static int dump_cleanup(DumpState *s)
     guest_phys_blocks_free(&s->guest_phys_blocks);
     memory_mapping_list_free(&s->list);
     close(s->fd);
+    g_free(s->vmcoreinfo);
+    s->vmcoreinfo =3D NULL;
     if (s->resume) {
         if (s->detached) {
             qemu_mutex_lock_iothread();
@@ -235,6 +244,19 @@ static inline int cpu_index(CPUState *cpu)
     return cpu->cpu_index + 1;
 }
=20
+static void write_vmcoreinfo_note(WriteCoreDumpFunction f, DumpState *s,
+                                  Error **errp)
+{
+    int ret;
+
+    if (s->vmcoreinfo) {
+        ret =3D f(s->vmcoreinfo, s->vmcoreinfo_size, s);
+        if (ret < 0) {
+            error_setg(errp, "dump: failed to write vmcoreinfo");
+        }
+    }
+}
+
 static void write_elf64_notes(WriteCoreDumpFunction f, DumpState *s,
                               Error **errp)
 {
@@ -258,6 +280,8 @@ static void write_elf64_notes(WriteCoreDumpFunction f=
, DumpState *s,
             return;
         }
     }
+
+    write_vmcoreinfo_note(f, s, errp);
 }
=20
 static void write_elf32_note(DumpState *s, Error **errp)
@@ -303,6 +327,8 @@ static void write_elf32_notes(WriteCoreDumpFunction f=
, DumpState *s,
             return;
         }
     }
+
+    write_vmcoreinfo_note(f, s, errp);
 }
=20
 static void write_elf_section(DumpState *s, int type, Error **errp)
@@ -714,6 +740,44 @@ static int buf_write_note(const void *buf, size_t si=
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
+        name_sz =3D hdr->n_namesz;
+        desc_sz =3D hdr->n_descsz;
+    } else {
+        const Elf32_Nhdr *hdr =3D note;
+        note_head_sz =3D sizeof(Elf32_Nhdr);
+        name_sz =3D hdr->n_namesz;
+        desc_sz =3D hdr->n_descsz;
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
@@ -1488,10 +1552,38 @@ static int64_t dump_calculate_size(DumpState *s)
     return total;
 }
=20
+static void vmcoreinfo_update_phys_base(DumpState *s)
+{
+    uint64_t size, note_head_size, name_size;
+    char **lines;
+    uint8_t *vmci;
+    size_t i;
+
+    get_note_sizes(s, s->vmcoreinfo, &note_head_size, &name_size, &size)=
;
+    note_head_size =3D ROUND_UP(note_head_size, 4);
+    name_size =3D ROUND_UP(name_size, 4);
+    vmci =3D s->vmcoreinfo + note_head_size + name_size;
+    *(vmci + size) =3D '\0';
+
+    lines =3D g_strsplit((char *)vmci, "\n", -1);
+    for (i =3D 0; lines[i]; i++) {
+        if (g_str_has_prefix(lines[i], "NUMBER(phys_base)=3D")) {
+            if (qemu_strtou64(lines[i] + 18, NULL, 16,
+                              &s->dump_info.phys_base) < 0) {
+                error_report("Failed to read NUMBER(phys_base)=3D");
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
 {
+    Object *vmcoreinfo_dev =3D find_vmcoreinfo_dev();
     CPUState *cpu;
     int nr_cpus;
     Error *err =3D NULL;
@@ -1563,6 +1655,31 @@ static void dump_init(DumpState *s, int fd, bool h=
as_format,
         goto cleanup;
     }
=20
+    if (vmcoreinfo_dev) {
+        uint64_t addr, size, note_head_size, name_size, desc_size;
+
+        if (!vmcoreinfo_get(VMCOREINFO(vmcoreinfo_dev),
+                            &addr, &size, &err)) {
+            error_report_err(err);
+        } else {
+            s->vmcoreinfo =3D g_malloc(size);
+            cpu_physical_memory_read(addr, s->vmcoreinfo, size);
+
+            get_note_sizes(s, s->vmcoreinfo,
+                           &note_head_size, &name_size, &desc_size);
+            s->vmcoreinfo_size =3D ELF_NOTE_SIZE(note_head_size, name_si=
ze,
+                                               desc_size);
+            if (s->vmcoreinfo_size > size) {
+                error_report("Invalid vmcoreinfo header, size mismatch")=
;
+                g_free(s->vmcoreinfo);
+                s->vmcoreinfo =3D NULL;
+            } else {
+                vmcoreinfo_update_phys_base(s);
+                s->note_size +=3D s->vmcoreinfo_size;
+            }
+        }
+    }
+
     /* get memory mapping */
     if (paging) {
         qemu_get_guest_memory_mapping(&s->list, &s->guest_phys_blocks, &=
err);
--=20
2.13.1.395.gf7b71de06
