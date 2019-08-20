Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5224C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:09:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9384214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9384214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzyGR-00064h-Jq
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 03:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42430)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hzy7z-00053s-Cb
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:00:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hzy7t-0002lb-FG
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:00:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60218)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hzy7s-0002ij-QG
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:00:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E08D34628B
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 07:00:13 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ADF2A17BBB;
 Tue, 20 Aug 2019 07:00:11 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 08:59:23 +0200
Message-Id: <1566284395-30287-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
References: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 20 Aug 2019 07:00:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 04/36] elf-ops.h: Map into memory the ELF to load
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefano Garzarella <sgarzare@redhat.com>

In order to reduce the memory footprint we map into memory
the ELF to load using g_mapped_file_new_from_fd() instead of
reading each sections. In this way we can share the ELF pages
between multiple instances of QEMU.

Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20190724143105.307042-3-sgarzare@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/elf_ops.h | 71 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 29 deletions(-)

diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index fede37e..1496d7e 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -323,8 +323,9 @@ static int glue(load_elf, SZ)(const char *name, int fd,
     struct elfhdr ehdr;
     struct elf_phdr *phdr = NULL, *ph;
     int size, i, total_size;
-    elf_word mem_size, file_size;
+    elf_word mem_size, file_size, data_offset;
     uint64_t addr, low = (uint64_t)-1, high = 0;
+    GMappedFile *mapped_file = NULL;
     uint8_t *data = NULL;
     char label[128];
     int ret = ELF_LOAD_FAILED;
@@ -409,20 +410,32 @@ static int glue(load_elf, SZ)(const char *name, int fd,
         }
     }
 
+    /*
+     * Since we want to be able to modify the mapped buffer, we set the
+     * 'writeble' parameter to 'true'. Modifications to the buffer are not
+     * written back to the file.
+     */
+    mapped_file = g_mapped_file_new_from_fd(fd, true, NULL);
+    if (!mapped_file) {
+        goto fail;
+    }
+
     total_size = 0;
     for(i = 0; i < ehdr.e_phnum; i++) {
         ph = &phdr[i];
         if (ph->p_type == PT_LOAD) {
             mem_size = ph->p_memsz; /* Size of the ROM */
             file_size = ph->p_filesz; /* Size of the allocated data */
-            data = g_malloc0(file_size);
-            if (ph->p_filesz > 0) {
-                if (lseek(fd, ph->p_offset, SEEK_SET) < 0) {
-                    goto fail;
-                }
-                if (read(fd, data, file_size) != file_size) {
+            data_offset = ph->p_offset; /* Offset where the data is located */
+
+            if (file_size > 0) {
+                if (g_mapped_file_get_length(mapped_file) <
+                    file_size + data_offset) {
                     goto fail;
                 }
+
+                data = (uint8_t *)g_mapped_file_get_contents(mapped_file);
+                data += data_offset;
             }
 
             /* The ELF spec is somewhat vague about the purpose of the
@@ -513,25 +526,25 @@ static int glue(load_elf, SZ)(const char *name, int fd,
                 *pentry = ehdr.e_entry - ph->p_vaddr + ph->p_paddr;
             }
 
-            if (mem_size == 0) {
-                /* Some ELF files really do have segments of zero size;
-                 * just ignore them rather than trying to create empty
-                 * ROM blobs, because the zero-length blob can falsely
-                 * trigger the overlapping-ROM-blobs check.
-                 */
-                g_free(data);
-            } else {
+            /* Some ELF files really do have segments of zero size;
+             * just ignore them rather than trying to create empty
+             * ROM blobs, because the zero-length blob can falsely
+             * trigger the overlapping-ROM-blobs check.
+             */
+            if (mem_size != 0) {
                 if (load_rom) {
                     snprintf(label, sizeof(label), "phdr #%d: %s", i, name);
 
-                    /* rom_add_elf_program() seize the ownership of 'data' */
-                    rom_add_elf_program(label, NULL, data, file_size, mem_size,
-                                        addr, as);
+                    /*
+                     * rom_add_elf_program() takes its own reference to
+                     * 'mapped_file'.
+                     */
+                    rom_add_elf_program(label, mapped_file, data, file_size,
+                                        mem_size, addr, as);
                 } else {
                     address_space_write(as ? as : &address_space_memory,
                                         addr, MEMTXATTRS_UNSPECIFIED,
                                         data, file_size);
-                    g_free(data);
                 }
             }
 
@@ -547,14 +560,16 @@ static int glue(load_elf, SZ)(const char *name, int fd,
             struct elf_note *nhdr = NULL;
 
             file_size = ph->p_filesz; /* Size of the range of ELF notes */
-            data = g_malloc0(file_size);
-            if (ph->p_filesz > 0) {
-                if (lseek(fd, ph->p_offset, SEEK_SET) < 0) {
-                    goto fail;
-                }
-                if (read(fd, data, file_size) != file_size) {
+            data_offset = ph->p_offset; /* Offset where the notes are located */
+
+            if (file_size > 0) {
+                if (g_mapped_file_get_length(mapped_file) <
+                    file_size + data_offset) {
                     goto fail;
                 }
+
+                data = (uint8_t *)g_mapped_file_get_contents(mapped_file);
+                data += data_offset;
             }
 
             /*
@@ -570,19 +585,17 @@ static int glue(load_elf, SZ)(const char *name, int fd,
                     sizeof(struct elf_note) == sizeof(struct elf64_note);
                 elf_note_fn((void *)nhdr, (void *)&ph->p_align, is64);
             }
-            g_free(data);
             data = NULL;
         }
     }
 
-    g_free(phdr);
     if (lowaddr)
         *lowaddr = (uint64_t)(elf_sword)low;
     if (highaddr)
         *highaddr = (uint64_t)(elf_sword)high;
-    return total_size;
+    ret = total_size;
  fail:
-    g_free(data);
+    g_mapped_file_unref(mapped_file);
     g_free(phdr);
     return ret;
 }
-- 
1.8.3.1



