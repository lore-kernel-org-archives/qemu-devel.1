Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA17C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:52:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D9B721556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWIS8ESx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D9B721556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Ylh-0002Dx-E7
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 06:52:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49005)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yk4-0000BD-Fe
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yk3-0005Jm-6m
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:12 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:39092)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Yk2-0005Gd-Ut
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:11 -0500
Received: by mail-wm1-x32f.google.com with SMTP id c84so2831736wme.4
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8dCAEQ3n3P+VCLpdHC3gGCW6UChRtkB4Jsl3UgbtDgs=;
 b=LWIS8ESx2vDfz1XxAtn7AAMyqhWuW2dBM7kRimDxxn+7fR+NIxRldLdgZWDHO7Z58r
 NfoL0OHc0wNUVqAuVwa/pfpV9apNfFQPeFLioFOpGSGIaerGzp3So5S64bxTZyV3rl6c
 nmkds2RBnE9eJvGUVX8yQ+n3uzz9jO1YM5YjHQnVFIQR96RDTKfZlxeYildI85QMSW0n
 I/U8wATZFTkLd1JFPK9xUFGQVAuHkpqrMIYTeolBX+G//Xi7w4T5eBlGDrHfNJ7UaIgp
 lkiFEkOVdOj5+UVqzdu3iQgA+PSBNOgVpIIYJ72OJTyqgQ2WG+memPyeNVNV4bCK4k+F
 04Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=8dCAEQ3n3P+VCLpdHC3gGCW6UChRtkB4Jsl3UgbtDgs=;
 b=X9OpDt5M7mHiR6Ovtpb5XuqC20Pp1ydcP8pBSXmlCC6idWj2GeM0tEyQ7zZwEajxto
 MyUUZ6zykKlSjB1Ul774BjEL3I2ToIWR9NvJX6faC9/ScMe2csdU4OKEElnFT6zmyjDT
 ggns86CxSxyBYIta+JE7kH9NGfrB9hQaPsyVt5L5pY8+Rc9siNfAsZ7aRxDfzDFtkZ2F
 q3UJiDMurQ9UlUvXPO15+GA8LBBv+VGmS4hWJmQhWpeFT3hGI/+7clYjzueU+xcJdCI6
 +vj/Rv8V+GD8oGJDP1h1rXvpTdvc6YWAB/j07HHHkoeODj08Pvgf3W/NWFJxIxW82Qd0
 iDww==
X-Gm-Message-State: APjAAAWrheS09lJoaWPCO6VfZtw+BATnmlyOsFfgaFKrMKFLXE2/TbPe
 v4v9JvIzyT+F6pmIF2rS9/yfYk3f
X-Google-Smtp-Source: APXvYqydUeEvydz9VfJHoVXpU5ngzUv+uTIvxWm9N6Yn/EEHEtMHL6mPwiTFohsDqNxtzQThycqW3Q==
X-Received: by 2002:a05:600c:224a:: with SMTP id
 a10mr4953426wmm.143.1582631469550; 
 Tue, 25 Feb 2020 03:51:09 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 003/136] machine: alias -mem-path and -mem-prealloc into
 memory-foo backend
Date: Tue, 25 Feb 2020 12:48:53 +0100
Message-Id: <1582631466-13880-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

Allow machine to opt in for hostmem backend based initial RAM
even if user uses old -mem-path/prealloc options by providing
  MachineClass::default_ram_id
Follow up patches will incrementally convert machines to new API,
by dropping memory_region_allocate_system_memory() and setting
default_ram_id that board used to use before conversion to keep
migration stream the same.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200219160953.13771-4-imammedo@redhat.com>
---
 backends/hostmem-file.c  |  7 -------
 backends/hostmem-ram.c   |  2 --
 include/hw/boards.h      |  8 ++++++++
 include/sysemu/hostmem.h | 16 ++++++++++++++++
 vl.c                     | 25 +++++++++++++++++++++++++
 5 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index be64020..cb319a9 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -18,13 +18,6 @@
 #include "sysemu/sysemu.h"
 #include "qom/object_interfaces.h"
 
-/* hostmem-file.c */
-/**
- * @TYPE_MEMORY_BACKEND_FILE:
- * name of backend that uses mmap on a file descriptor
- */
-#define TYPE_MEMORY_BACKEND_FILE "memory-backend-file"
-
 #define MEMORY_BACKEND_FILE(obj) \
     OBJECT_CHECK(HostMemoryBackendFile, (obj), TYPE_MEMORY_BACKEND_FILE)
 
diff --git a/backends/hostmem-ram.c b/backends/hostmem-ram.c
index 6aab8d3..5cc53e7 100644
--- a/backends/hostmem-ram.c
+++ b/backends/hostmem-ram.c
@@ -16,8 +16,6 @@
 #include "qemu/module.h"
 #include "qom/object_interfaces.h"
 
-#define TYPE_MEMORY_BACKEND_RAM "memory-backend-ram"
-
 static void
 ram_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 {
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 7b4b6b7..8e536ca 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -170,6 +170,13 @@ typedef struct {
  *    false is returned, an error must be set to show the reason of
  *    the rejection.  If the hook is not provided, all hotplug will be
  *    allowed.
+ * @default_ram_id:
+ *    Specifies inital RAM MemoryRegion name to be used for default backend
+ *    creation if user explicitly hasn't specified backend with "memory-backend"
+ *    property.
+ *    It also will be used as a way to optin into "-m" option support.
+ *    If it's not set by board, '-m' will be ignored and generic code will
+ *    not create default RAM MemoryRegion.
  */
 struct MachineClass {
     /*< private >*/
@@ -226,6 +233,7 @@ struct MachineClass {
     bool nvdimm_supported;
     bool numa_mem_supported;
     bool auto_enable_numa;
+    const char *default_ram_id;
 
     HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
                                            DeviceState *dev);
diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
index 4dbdadd..5db0d66 100644
--- a/include/sysemu/hostmem.h
+++ b/include/sysemu/hostmem.h
@@ -27,6 +27,22 @@
 #define MEMORY_BACKEND_CLASS(klass) \
     OBJECT_CLASS_CHECK(HostMemoryBackendClass, (klass), TYPE_MEMORY_BACKEND)
 
+/* hostmem-ram.c */
+/**
+ * @TYPE_MEMORY_BACKEND_RAM:
+ * name of backend that uses mmap on the anonymous RAM
+ */
+
+#define TYPE_MEMORY_BACKEND_RAM "memory-backend-ram"
+
+/* hostmem-file.c */
+/**
+ * @TYPE_MEMORY_BACKEND_FILE:
+ * name of backend that uses mmap on a file descriptor
+ */
+#define TYPE_MEMORY_BACKEND_FILE "memory-backend-file"
+
+typedef struct HostMemoryBackend HostMemoryBackend;
 typedef struct HostMemoryBackendClass HostMemoryBackendClass;
 
 /**
diff --git a/vl.c b/vl.c
index 794f2e5..4dc4803 100644
--- a/vl.c
+++ b/vl.c
@@ -75,6 +75,7 @@ int main(int argc, char **argv)
 #include "ui/input.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/numa.h"
+#include "sysemu/hostmem.h"
 #include "exec/gdbstub.h"
 #include "qemu/timer.h"
 #include "chardev/char.h"
@@ -2805,6 +2806,26 @@ static void configure_accelerators(const char *progname)
     }
 }
 
+static void create_default_memdev(MachineState *ms, const char *path,
+                                  bool prealloc)
+{
+    Object *obj;
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+
+    obj = object_new(path ? TYPE_MEMORY_BACKEND_FILE : TYPE_MEMORY_BACKEND_RAM);
+    if (path) {
+        object_property_set_str(obj, path, "mem-path", &error_fatal);
+    }
+    object_property_set_bool(obj, prealloc, "prealloc", &error_fatal);
+    object_property_set_int(obj, ms->ram_size, "size", &error_fatal);
+    object_property_add_child(object_get_objects_root(), mc->default_ram_id,
+                              obj, &error_fatal);
+    user_creatable_complete(USER_CREATABLE(obj), &error_fatal);
+    object_unref(obj);
+    object_property_set_str(OBJECT(ms), mc->default_ram_id, "memory-backend",
+                            &error_fatal);
+}
+
 int main(int argc, char **argv, char **envp)
 {
     int i;
@@ -4268,6 +4289,10 @@ int main(int argc, char **argv, char **envp)
     }
     parse_numa_opts(current_machine);
 
+    if (machine_class->default_ram_id && current_machine->ram_size &&
+        !current_machine->ram_memdev_id) {
+        create_default_memdev(current_machine, mem_path, mem_prealloc);
+    }
     /* do monitor/qmp handling at preconfig state if requested */
     main_loop();
 
-- 
1.8.3.1



