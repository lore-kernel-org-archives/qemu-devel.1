Received: from eggs.gnu.org ([209.51.188.92]:51799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldyC-0004Rv-Eg
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldyB-0004GA-Kl
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:48 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gldyB-0004FJ-Do
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:47 -0500
Received: by mail-wr1-x444.google.com with SMTP id c14so24530438wrr.0
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:06:47 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Jan 2019 19:05:55 +0100
Message-Id: <1548093980-43088-25-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
References: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 24/49] elf-ops.h: Add get_elf_note_type()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Liam Merwick <liam.merwick@oracle.com>

Introduce a routine which, given a pointer to a range of ELF Notes,
searches through them looking for a note matching the type specified
and returns a pointer to the matching ELF note.

get_elf_note_type() is used by elf_load[32|64]() to find the
specified note type required by the 'elf_note_fn' parameter
added in the previous commit.

Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
---
 include/hw/elf_ops.h | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index 3438d6f..690f923 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -265,6 +265,51 @@ fail:
     return ret;
 }
 
+/*
+ * Given 'nhdr', a pointer to a range of ELF Notes, search through them
+ * for a note matching type 'elf_note_type' and return a pointer to
+ * the matching ELF note.
+ */
+static struct elf_note *glue(get_elf_note_type, SZ)(struct elf_note *nhdr,
+                                                    elf_word note_size,
+                                                    elf_word phdr_align,
+                                                    elf_word elf_note_type)
+{
+    elf_word nhdr_size = sizeof(struct elf_note);
+    elf_word elf_note_entry_offset = 0;
+    elf_word note_type;
+    elf_word nhdr_namesz;
+    elf_word nhdr_descsz;
+
+    if (nhdr == NULL) {
+        return NULL;
+    }
+
+    note_type = nhdr->n_type;
+    while (note_type != elf_note_type) {
+        nhdr_namesz = nhdr->n_namesz;
+        nhdr_descsz = nhdr->n_descsz;
+
+        elf_note_entry_offset = nhdr_size +
+            QEMU_ALIGN_UP(nhdr_namesz, phdr_align) +
+            QEMU_ALIGN_UP(nhdr_descsz, phdr_align);
+
+        /*
+         * If the offset calculated in this iteration exceeds the
+         * supplied size, we are done and no matching note was found.
+         */
+        if (elf_note_entry_offset > note_size) {
+            return NULL;
+        }
+
+        /* skip to the next ELF Note entry */
+        nhdr = (void *)nhdr + elf_note_entry_offset;
+        note_type = nhdr->n_type;
+    }
+
+    return nhdr;
+}
+
 static int glue(load_elf, SZ)(const char *name, int fd,
                               uint64_t (*elf_note_fn)(void *, void *, bool),
                               uint64_t (*translate_fn)(void *, uint64_t),
@@ -497,6 +542,36 @@ static int glue(load_elf, SZ)(const char *name, int fd,
                 high = addr + mem_size;
 
             data = NULL;
+
+        } else if (ph->p_type == PT_NOTE && elf_note_fn) {
+            struct elf_note *nhdr = NULL;
+
+            file_size = ph->p_filesz; /* Size of the range of ELF notes */
+            data = g_malloc0(file_size);
+            if (ph->p_filesz > 0) {
+                if (lseek(fd, ph->p_offset, SEEK_SET) < 0) {
+                    goto fail;
+                }
+                if (read(fd, data, file_size) != file_size) {
+                    goto fail;
+                }
+            }
+
+            /*
+             * Search the ELF notes to find one with a type matching the
+             * value passed in via 'translate_opaque'
+             */
+            nhdr = (struct elf_note *)data;
+            assert(translate_opaque != NULL);
+            nhdr = glue(get_elf_note_type, SZ)(nhdr, file_size, ph->p_align,
+                                               *(uint64_t *)translate_opaque);
+            if (nhdr != NULL) {
+                bool is64 =
+                    sizeof(struct elf_note) == sizeof(struct elf64_note);
+                elf_note_fn((void *)nhdr, (void *)&ph->p_align, is64);
+            }
+            g_free(data);
+            data = NULL;
         }
     }
 
-- 
1.8.3.1
