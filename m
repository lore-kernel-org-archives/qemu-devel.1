Received: from eggs.gnu.org ([2001:4830:134:3::10]:58938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmh0G-0002gG-Tj
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:24:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmh0F-0002lx-Ir
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:24:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cmh0F-0002lp-9v
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:24:11 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 11 Mar 2017 17:22:53 +0400
Message-Id: <20170311132256.22951-19-marcandre.lureau@redhat.com>
In-Reply-To: <20170311132256.22951-1-marcandre.lureau@redhat.com>
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 18/21] dump: use qga VMDUMP_INFO for ELF dump
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

Add vmcoreinfo ELF note.

NUMBRE(phys_base) in vmcoreinfo has only been recently introduced in
Linux 4.10 ("kexec: export the value of phys_base instead of symbol
address"). To accomadate for older kernels, modify the vmcoreinfo to add
the new fields and help newer crash that will use it.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/sysemu/dump.h |   2 +
 dump.c                | 133 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
 2 files changed, 135 insertions(+)

diff --git a/include/sysemu/dump.h b/include/sysemu/dump.h
index ef931be469..ff0e9894b7 100644
--- a/include/sysemu/dump.h
+++ b/include/sysemu/dump.h
@@ -191,6 +191,8 @@ typedef struct DumpState {
                                   * this could be used to calculate
                                   * how much work we have
                                   * finished. */
+    uint8_t *vmcoreinfo;
+    size_t vmcoreinfo_size;
 } DumpState;
=20
 uint16_t cpu_to_dump16(DumpState *s, uint16_t val);
diff --git a/dump.c b/dump.c
index 68b406459e..0ebfb5471a 100644
--- a/dump.c
+++ b/dump.c
@@ -27,6 +27,7 @@
 #include "qapi/qmp/qerror.h"
 #include "qmp-commands.h"
 #include "qapi-event.h"
+#include "qemu/error-report.h"
=20
 #include <zlib.h>
 #ifdef CONFIG_LZO
@@ -82,6 +83,8 @@ static int dump_cleanup(DumpState *s)
     if (s->resume) {
         vm_start();
     }
+    g_free(s->vmcoreinfo);
+    s->vmcoreinfo =3D NULL;
=20
     return 0;
 }
@@ -232,6 +235,19 @@ static inline int cpu_index(CPUState *cpu)
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
@@ -255,6 +271,8 @@ static void write_elf64_notes(WriteCoreDumpFunction f=
, DumpState *s,
             return;
         }
     }
+
+    write_vmcoreinfo_note(f, s, errp);
 }
=20
 static void write_elf32_note(DumpState *s, Error **errp)
@@ -300,6 +318,8 @@ static void write_elf32_notes(WriteCoreDumpFunction f=
, DumpState *s,
             return;
         }
     }
+
+    write_vmcoreinfo_note(f, s, errp);
 }
=20
 static void write_elf_section(DumpState *s, int type, Error **errp)
@@ -711,6 +731,50 @@ static int buf_write_note(const void *buf, size_t si=
ze, void *opaque)
     return 0;
 }
=20
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
+static void set_note_desc_size(DumpState *s, void *note,
+                               uint64_t desc_size)
+{
+    if (s->dump_info.d_class =3D=3D ELFCLASS64) {
+        Elf64_Nhdr *hdr =3D note;
+        hdr->n_descsz =3D desc_size;
+    } else {
+        Elf32_Nhdr *hdr =3D note;
+        hdr->n_descsz =3D desc_size;
+    }
+}
+
 /* write common header, sub header and elf note to vmcore */
 static void create_header32(DumpState *s, Error **errp)
 {
@@ -1485,6 +1549,42 @@ static int64_t dump_calculate_size(DumpState *s)
     return total;
 }
=20
+static void vmcoreinfo_add_phys_base(DumpState *s)
+{
+    uint64_t size, note_head_size, name_size;
+    char **lines, *physbase =3D NULL;
+    uint8_t *newvmci, *vmci;
+    size_t i;
+
+    get_note_sizes(s, s->vmcoreinfo, &note_head_size, &name_size, &size)=
;
+    note_head_size =3D ((note_head_size + 3) / 4) * 4;
+    name_size =3D ((name_size + 3) / 4) * 4;
+    vmci =3D s->vmcoreinfo + note_head_size + name_size;
+    *(vmci + size) =3D '\0';
+    lines =3D g_strsplit((char *)vmci, "\n", -1);
+    for (i =3D 0; lines[i]; i++) {
+        if (g_str_has_prefix(lines[i], "NUMBER(phys_base)=3D")) {
+            goto end;
+        }
+    }
+
+    physbase =3D g_strdup_printf("\nNUMBER(phys_base)=3D%ld",
+                               s->dump_info.phys_base);
+    s->vmcoreinfo_size =3D
+        ((note_head_size + name_size + size + strlen(physbase) + 3) / 4)=
 * 4;
+
+    newvmci =3D g_malloc(s->vmcoreinfo_size);
+    memcpy(newvmci, s->vmcoreinfo, note_head_size + name_size + size - 1=
);
+    memcpy(newvmci + note_head_size + name_size + size - 1, physbase,
+           strlen(physbase) + 1);
+    g_free(s->vmcoreinfo);
+    s->vmcoreinfo =3D newvmci;
+    set_note_desc_size(s, s->vmcoreinfo, size + strlen(physbase));
+
+end:
+    g_strfreev(lines);
+}
+
 static void dump_init(DumpState *s, int fd, bool has_format,
                       DumpGuestMemoryFormat format, bool paging, bool ha=
s_filter,
                       int64_t begin, int64_t length, Error **errp)
@@ -1560,6 +1660,39 @@ static void dump_init(DumpState *s, int fd, bool h=
as_format,
         goto cleanup;
     }
=20
+    if (dump_info.has_phys_base) {
+        s->dump_info.phys_base =3D dump_info.phys_base;
+    }
+    if (dump_info.vmcoreinfo) {
+        uint64_t addr, size, note_head_size, name_size, desc_size;
+        int count =3D sscanf(dump_info.vmcoreinfo, "%" PRIx64 " %" PRIx6=
4,
+                           &addr, &size);
+        if (count !=3D 2) {
+            /* non fatal error */
+            error_report("Failed to parse vmcoreinfo");
+        } else {
+            assert(!s->vmcoreinfo);
+            s->vmcoreinfo =3D g_malloc(size);
+            cpu_physical_memory_read(addr, s->vmcoreinfo, size);
+
+            get_note_sizes(s, s->vmcoreinfo,
+                           &note_head_size, &name_size, &desc_size);
+            s->vmcoreinfo_size =3D ((note_head_size + 3) / 4 +
+                                  (name_size + 3) / 4 +
+                                  (desc_size + 3) / 4) * 4;
+            if (s->vmcoreinfo_size > size) {
+                error_report("Invalid vmcoreinfo header, size mismatch")=
;
+                g_free(s->vmcoreinfo);
+                s->vmcoreinfo =3D NULL;
+            } else {
+                if (dump_info.has_phys_base) {
+                    vmcoreinfo_add_phys_base(s);
+                }
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
2.12.0.191.gc5d8de91d
