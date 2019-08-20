Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D107DC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:06:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2B2020C01
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B2020C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzyDh-0002Vj-AQ
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 03:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hzy7t-0004wU-D6
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:00:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hzy7p-0002iR-Kj
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:00:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51400)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hzy7o-0002gV-Mz
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:00:13 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 409A6307D921
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 07:00:11 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5EE3F18139;
 Tue, 20 Aug 2019 07:00:09 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 08:59:22 +0200
Message-Id: <1566284395-30287-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
References: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 20 Aug 2019 07:00:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 03/36] loader: Handle memory-mapped ELFs
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

This patch allows handling an ELF memory-mapped, taking care
the reference count of the GMappedFile* passed through
rom_add_elf_program().
In this case, the 'data' pointer is not heap-allocated, so
we cannot free it.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20190724143105.307042-2-sgarzare@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/loader.c     | 38 ++++++++++++++++++++++++++++++--------
 include/hw/elf_ops.h |  2 +-
 include/hw/loader.h  |  5 +++--
 3 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 425bf69..9fb93a6 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -836,6 +836,7 @@ struct Rom {
     int isrom;
     char *fw_dir;
     char *fw_file;
+    GMappedFile *mapped_file;
 
     bool committed;
 
@@ -846,10 +847,25 @@ struct Rom {
 static FWCfgState *fw_cfg;
 static QTAILQ_HEAD(, Rom) roms = QTAILQ_HEAD_INITIALIZER(roms);
 
-/* rom->data must be heap-allocated (do not use with rom_add_elf_program()) */
+/*
+ * rom->data can be heap-allocated or memory-mapped (e.g. when added with
+ * rom_add_elf_program())
+ */
+static void rom_free_data(Rom *rom)
+{
+    if (rom->mapped_file) {
+        g_mapped_file_unref(rom->mapped_file);
+        rom->mapped_file = NULL;
+    } else {
+        g_free(rom->data);
+    }
+
+    rom->data = NULL;
+}
+
 static void rom_free(Rom *rom)
 {
-    g_free(rom->data);
+    rom_free_data(rom);
     g_free(rom->path);
     g_free(rom->name);
     g_free(rom->fw_dir);
@@ -1056,11 +1072,12 @@ MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
 
 /* This function is specific for elf program because we don't need to allocate
  * all the rom. We just allocate the first part and the rest is just zeros. This
- * is why romsize and datasize are different. Also, this function seize the
- * memory ownership of "data", so we don't have to allocate and copy the buffer.
+ * is why romsize and datasize are different. Also, this function takes its own
+ * reference to "mapped_file", so we don't have to allocate and copy the buffer.
  */
-int rom_add_elf_program(const char *name, void *data, size_t datasize,
-                        size_t romsize, hwaddr addr, AddressSpace *as)
+int rom_add_elf_program(const char *name, GMappedFile *mapped_file, void *data,
+                        size_t datasize, size_t romsize, hwaddr addr,
+                        AddressSpace *as)
 {
     Rom *rom;
 
@@ -1071,6 +1088,12 @@ int rom_add_elf_program(const char *name, void *data, size_t datasize,
     rom->romsize  = romsize;
     rom->data     = data;
     rom->as       = as;
+
+    if (mapped_file && data) {
+        g_mapped_file_ref(mapped_file);
+        rom->mapped_file = mapped_file;
+    }
+
     rom_insert(rom);
     return 0;
 }
@@ -1105,8 +1128,7 @@ static void rom_reset(void *unused)
         }
         if (rom->isrom) {
             /* rom needs to be written only once */
-            g_free(rom->data);
-            rom->data = NULL;
+            rom_free_data(rom);
         }
         /*
          * The rom loader is really on the same level as firmware in the guest
diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index 690f923..fede37e 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -525,7 +525,7 @@ static int glue(load_elf, SZ)(const char *name, int fd,
                     snprintf(label, sizeof(label), "phdr #%d: %s", i, name);
 
                     /* rom_add_elf_program() seize the ownership of 'data' */
-                    rom_add_elf_program(label, data, file_size, mem_size,
+                    rom_add_elf_program(label, NULL, data, file_size, mem_size,
                                         addr, as);
                 } else {
                     address_space_write(as ? as : &address_space_memory,
diff --git a/include/hw/loader.h b/include/hw/loader.h
index 3e1b3a4..07fd928 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -258,8 +258,9 @@ MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
                            FWCfgCallback fw_callback,
                            void *callback_opaque, AddressSpace *as,
                            bool read_only);
-int rom_add_elf_program(const char *name, void *data, size_t datasize,
-                        size_t romsize, hwaddr addr, AddressSpace *as);
+int rom_add_elf_program(const char *name, GMappedFile *mapped_file, void *data,
+                        size_t datasize, size_t romsize, hwaddr addr,
+                        AddressSpace *as);
 int rom_check_and_register_reset(void);
 void rom_set_fw(FWCfgState *f);
 void rom_set_order_override(int order);
-- 
1.8.3.1



