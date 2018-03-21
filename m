Received: from eggs.gnu.org ([2001:4830:134:3::10]:52378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eycYF-00042L-7O
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:09:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eycYC-0000Hd-Hr
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:09:07 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Wed, 21 Mar 2018 13:08:53 +0100
Message-Id: <20180321120853.14293-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH] dump: display cause of write failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Yasmin Beatriz <yasmins@linux.vnet.ibm.com>, Laurent Vivier <lvivier@redhat.com>

Use error_setg_errno() to display the reason why data write
has failed. For instance, instead of a laconic

  dump: failed to write elf header
or
  dump: failed to save memory

we have now:

  dump: failed to write elf header: No space left on device
or
  dump: failed to save memory: No space left on device

CC: Yasmin Beatriz <yasmins@linux.vnet.ibm.com>
CC: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 dump.c | 79 +++++++++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 47 insertions(+), 32 deletions(-)

diff --git a/dump.c b/dump.c
index 6bdb0dbe23..d04e3f56b0 100644
--- a/dump.c
+++ b/dump.c
@@ -140,7 +140,7 @@ static void write_elf64_header(DumpState *s, Error **errp)
 
     ret = fd_write_vmcore(&elf_header, sizeof(elf_header), s);
     if (ret < 0) {
-        error_setg(errp, "dump: failed to write elf header");
+        error_setg_errno(errp, errno, "dump: failed to write elf header");
     }
 }
 
@@ -171,7 +171,7 @@ static void write_elf32_header(DumpState *s, Error **errp)
 
     ret = fd_write_vmcore(&elf_header, sizeof(elf_header), s);
     if (ret < 0) {
-        error_setg(errp, "dump: failed to write elf header");
+        error_setg_errno(errp, errno, "dump: failed to write elf header");
     }
 }
 
@@ -194,7 +194,8 @@ static void write_elf64_load(DumpState *s, MemoryMapping *memory_mapping,
 
     ret = fd_write_vmcore(&phdr, sizeof(Elf64_Phdr), s);
     if (ret < 0) {
-        error_setg(errp, "dump: failed to write program header table");
+        error_setg_errno(errp, errno,
+                         "dump: failed to write program header table");
     }
 }
 
@@ -217,7 +218,8 @@ static void write_elf32_load(DumpState *s, MemoryMapping *memory_mapping,
 
     ret = fd_write_vmcore(&phdr, sizeof(Elf32_Phdr), s);
     if (ret < 0) {
-        error_setg(errp, "dump: failed to write program header table");
+        error_setg_errno(errp, errno,
+                         "dump: failed to write program header table");
     }
 }
 
@@ -237,7 +239,8 @@ static void write_elf64_note(DumpState *s, Error **errp)
 
     ret = fd_write_vmcore(&phdr, sizeof(Elf64_Phdr), s);
     if (ret < 0) {
-        error_setg(errp, "dump: failed to write program header table");
+        error_setg_errno(errp, errno,
+                         "dump: failed to write program header table");
     }
 }
 
@@ -254,7 +257,7 @@ static void write_guest_note(WriteCoreDumpFunction f, DumpState *s,
     if (s->guest_note) {
         ret = f(s->guest_note, s->guest_note_size, s);
         if (ret < 0) {
-            error_setg(errp, "dump: failed to write guest note");
+            error_setg_errno(errp, errno, "dump: failed to write guest note");
         }
     }
 }
@@ -270,7 +273,7 @@ static void write_elf64_notes(WriteCoreDumpFunction f, DumpState *s,
         id = cpu_index(cpu);
         ret = cpu_write_elf64_note(f, cpu, id, s);
         if (ret < 0) {
-            error_setg(errp, "dump: failed to write elf notes");
+            error_setg_errno(errp, errno, "dump: failed to write elf notes");
             return;
         }
     }
@@ -278,7 +281,7 @@ static void write_elf64_notes(WriteCoreDumpFunction f, DumpState *s,
     CPU_FOREACH(cpu) {
         ret = cpu_write_elf64_qemunote(f, cpu, s);
         if (ret < 0) {
-            error_setg(errp, "dump: failed to write CPU status");
+            error_setg_errno(errp, errno, "dump: failed to write CPU status");
             return;
         }
     }
@@ -302,7 +305,8 @@ static void write_elf32_note(DumpState *s, Error **errp)
 
     ret = fd_write_vmcore(&phdr, sizeof(Elf32_Phdr), s);
     if (ret < 0) {
-        error_setg(errp, "dump: failed to write program header table");
+        error_setg_errno(errp, errno,
+                         "dump: failed to write program header table");
     }
 }
 
@@ -317,7 +321,7 @@ static void write_elf32_notes(WriteCoreDumpFunction f, DumpState *s,
         id = cpu_index(cpu);
         ret = cpu_write_elf32_note(f, cpu, id, s);
         if (ret < 0) {
-            error_setg(errp, "dump: failed to write elf notes");
+            error_setg_errno(errp, errno, "dump: failed to write elf notes");
             return;
         }
     }
@@ -325,7 +329,7 @@ static void write_elf32_notes(WriteCoreDumpFunction f, DumpState *s,
     CPU_FOREACH(cpu) {
         ret = cpu_write_elf32_qemunote(f, cpu, s);
         if (ret < 0) {
-            error_setg(errp, "dump: failed to write CPU status");
+            error_setg_errno(errp, errno, "dump: failed to write CPU status");
             return;
         }
     }
@@ -355,7 +359,8 @@ static void write_elf_section(DumpState *s, int type, Error **errp)
 
     ret = fd_write_vmcore(&shdr, shdr_size, s);
     if (ret < 0) {
-        error_setg(errp, "dump: failed to write section header table");
+        error_setg_errno(errp, errno,
+                         "dump: failed to write section header table");
     }
 }
 
@@ -365,7 +370,7 @@ static void write_data(DumpState *s, void *buf, int length, Error **errp)
 
     ret = fd_write_vmcore(buf, length, s);
     if (ret < 0) {
-        error_setg(errp, "dump: failed to save memory");
+        error_setg_errno(errp, errno, "dump: failed to save memory");
     } else {
         s->written_size += length;
     }
@@ -839,7 +844,7 @@ static void create_header32(DumpState *s, Error **errp)
     dh->status = cpu_to_dump32(s, status);
 
     if (write_buffer(s->fd, 0, dh, size) < 0) {
-        error_setg(errp, "dump: failed to write disk dump header");
+        error_setg_errno(errp, errno, "dump: failed to write disk dump header");
         goto out;
     }
 
@@ -870,7 +875,7 @@ static void create_header32(DumpState *s, Error **errp)
 
     if (write_buffer(s->fd, DISKDUMP_HEADER_BLOCKS *
                      block_size, kh, size) < 0) {
-        error_setg(errp, "dump: failed to write kdump sub header");
+        error_setg_errno(errp, errno, "dump: failed to write kdump sub header");
         goto out;
     }
 
@@ -886,7 +891,7 @@ static void create_header32(DumpState *s, Error **errp)
     }
     if (write_buffer(s->fd, offset_note, s->note_buf,
                      s->note_size) < 0) {
-        error_setg(errp, "dump: failed to write notes");
+        error_setg_errno(errp, errno, "dump: failed to write notes");
         goto out;
     }
 
@@ -951,7 +956,7 @@ static void create_header64(DumpState *s, Error **errp)
     dh->status = cpu_to_dump32(s, status);
 
     if (write_buffer(s->fd, 0, dh, size) < 0) {
-        error_setg(errp, "dump: failed to write disk dump header");
+        error_setg_errno(errp, errno, "dump: failed to write disk dump header");
         goto out;
     }
 
@@ -982,7 +987,7 @@ static void create_header64(DumpState *s, Error **errp)
 
     if (write_buffer(s->fd, DISKDUMP_HEADER_BLOCKS *
                      block_size, kh, size) < 0) {
-        error_setg(errp, "dump: failed to write kdump sub header");
+        error_setg_errno(errp, errno, "dump: failed to write kdump sub header");
         goto out;
     }
 
@@ -999,7 +1004,7 @@ static void create_header64(DumpState *s, Error **errp)
 
     if (write_buffer(s->fd, offset_note, s->note_buf,
                      s->note_size) < 0) {
-        error_setg(errp, "dump: failed to write notes");
+        error_setg_errno(errp, errno, "dump: failed to write notes");
         goto out;
     }
 
@@ -1183,7 +1188,7 @@ static void write_dump_bitmap(DumpState *s, Error **errp)
     while (get_next_page(&block_iter, &pfn, NULL, s)) {
         ret = set_dump_bitmap(last_pfn, pfn, true, dump_bitmap_buf, s);
         if (ret < 0) {
-            error_setg(errp, "dump: failed to set dump_bitmap");
+            error_setg_errno(errp, errno, "dump: failed to set dump_bitmap");
             goto out;
         }
 
@@ -1200,7 +1205,7 @@ static void write_dump_bitmap(DumpState *s, Error **errp)
         ret = set_dump_bitmap(last_pfn, last_pfn + bits_per_buf, false,
                               dump_bitmap_buf, s);
         if (ret < 0) {
-            error_setg(errp, "dump: failed to sync dump_bitmap");
+            error_setg_errno(errp, errno, "dump: failed to sync dump_bitmap");
             goto out;
         }
     }
@@ -1333,7 +1338,8 @@ static void write_dump_pages(DumpState *s, Error **errp)
     ret = write_cache(&page_data, buf, s->dump_info.page_size, false);
     g_free(buf);
     if (ret < 0) {
-        error_setg(errp, "dump: failed to write page data (zero page)");
+        error_setg_errno(errp, errno,
+                         "dump: failed to write page data (zero page)");
         goto out;
     }
 
@@ -1349,7 +1355,8 @@ static void write_dump_pages(DumpState *s, Error **errp)
             ret = write_cache(&page_desc, &pd_zero, sizeof(PageDescriptor),
                               false);
             if (ret < 0) {
-                error_setg(errp, "dump: failed to write page desc");
+                error_setg_errno(errp, errno,
+                                 "dump: failed to write page desc");
                 goto out;
             }
         } else {
@@ -1374,7 +1381,8 @@ static void write_dump_pages(DumpState *s, Error **errp)
 
                 ret = write_cache(&page_data, buf_out, size_out, false);
                 if (ret < 0) {
-                    error_setg(errp, "dump: failed to write page data");
+                    error_setg_errno(errp, errno,
+                                     "dump: failed to write page data");
                     goto out;
                 }
 #ifdef CONFIG_LZO
@@ -1387,7 +1395,8 @@ static void write_dump_pages(DumpState *s, Error **errp)
 
                 ret = write_cache(&page_data, buf_out, size_out, false);
                 if (ret < 0) {
-                    error_setg(errp, "dump: failed to write page data");
+                    error_setg_errno(errp, errno,
+                                     "dump: failed to write page data");
                     goto out;
                 }
 #endif
@@ -1401,7 +1410,8 @@ static void write_dump_pages(DumpState *s, Error **errp)
 
                 ret = write_cache(&page_data, buf_out, size_out, false);
                 if (ret < 0) {
-                    error_setg(errp, "dump: failed to write page data");
+                    error_setg_errno(errp, errno,
+                                     "dump: failed to write page data");
                     goto out;
                 }
 #endif
@@ -1417,7 +1427,8 @@ static void write_dump_pages(DumpState *s, Error **errp)
                 ret = write_cache(&page_data, buf,
                                   s->dump_info.page_size, false);
                 if (ret < 0) {
-                    error_setg(errp, "dump: failed to write page data");
+                    error_setg_errno(errp, errno,
+                                     "dump: failed to write page data");
                     goto out;
                 }
             }
@@ -1429,7 +1440,8 @@ static void write_dump_pages(DumpState *s, Error **errp)
 
             ret = write_cache(&page_desc, &pd, sizeof(PageDescriptor), false);
             if (ret < 0) {
-                error_setg(errp, "dump: failed to write page desc");
+                error_setg_errno(errp, errno,
+                                 "dump: failed to write page desc");
                 goto out;
             }
         }
@@ -1438,12 +1450,14 @@ static void write_dump_pages(DumpState *s, Error **errp)
 
     ret = write_cache(&page_desc, NULL, 0, true);
     if (ret < 0) {
-        error_setg(errp, "dump: failed to sync cache for page_desc");
+        error_setg_errno(errp, errno,
+                         "dump: failed to sync cache for page_desc");
         goto out;
     }
     ret = write_cache(&page_data, NULL, 0, true);
     if (ret < 0) {
-        error_setg(errp, "dump: failed to sync cache for page_data");
+        error_setg_errno(errp, errno,
+                         "dump: failed to sync cache for page_data");
         goto out;
     }
 
@@ -1487,7 +1501,8 @@ static void create_kdump_vmcore(DumpState *s, Error **errp)
 
     ret = write_start_flat_header(s->fd);
     if (ret < 0) {
-        error_setg(errp, "dump: failed to write start flat header");
+        error_setg_errno(errp, errno,
+                         "dump: failed to write start flat header");
         return;
     }
 
@@ -1511,7 +1526,7 @@ static void create_kdump_vmcore(DumpState *s, Error **errp)
 
     ret = write_end_flat_header(s->fd);
     if (ret < 0) {
-        error_setg(errp, "dump: failed to write end flat header");
+        error_setg_errno(errp, errno, "dump: failed to write end flat header");
         return;
     }
 }
-- 
2.14.3
