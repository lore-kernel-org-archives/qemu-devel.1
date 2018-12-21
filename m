Received: from eggs.gnu.org ([2001:4830:134:3::10]:46339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gaSyh-00013l-38
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 17:09:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gaSye-0000tY-0i
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 17:09:07 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gaR4R-00056f-Gy
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 15:06:57 -0500
From: Liam Merwick <liam.merwick@oracle.com>
Date: Fri, 21 Dec 2018 20:03:50 +0000
Message-Id: <1545422632-24444-3-git-send-email-liam.merwick@oracle.com>
In-Reply-To: <1545422632-24444-1-git-send-email-liam.merwick@oracle.com>
References: <1545422632-24444-1-git-send-email-liam.merwick@oracle.com>
Subject: [Qemu-devel] [RFC v2 2/4] elf-ops.h: Add get_elf_note_type()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, ehabkost@redhat.com, rth@twiddle.net, xen-devel@lists.xenproject.org, sgarzare@redhat.com, mst@redhat.com, stefanha@redhat.com, maran.wilson@oracle.com, george.kennedy@oracle.com, boris.ostrovsky@oracle.com, liam.merwick@oracle.com

Introduce a routine which, given a pointer to a range of ELF Notes,
searches through them looking for a note matching the type specified
and returns a pointer to the matching ELF note.

Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
---
 include/hw/elf_ops.h | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index 37d20a3800c1..ffbdfbe9c2d8 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -265,6 +265,49 @@ fail:
     return ret;
 }
 
+/* Given 'nhdr', a pointer to a range of ELF Notes, search through them
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
+        /* If the offset calculated in this iteration exceeds the
+	 * supplied size, we are done and no matching note was found.
+	 */
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
@@ -512,6 +555,13 @@ static int glue(load_elf, SZ)(const char *name, int fd,
                 }
             }
 
+	    /* Search the ELF notes to find one with a type matching the
+	     * value passed in via 'translate_opaque'
+	     */
+            nhdr = (struct elf_note *)data;
+	    assert(translate_opaque != NULL);
+            nhdr = glue(get_elf_note_type, SZ)(nhdr, file_size, ph->p_align,
+                                               *(uint64_t *)translate_opaque);
             if (nhdr != NULL) {
                 bool is64 =
                     sizeof(struct elf_note) == sizeof(struct elf64_note);
-- 
1.8.3.1
