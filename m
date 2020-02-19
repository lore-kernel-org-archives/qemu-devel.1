Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7762C34053
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:16:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7419820675
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iFK1olQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7419820675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4S1p-0006CH-JV
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 11:16:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j4RvP-00021J-Ka
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j4RvO-0000Vh-0A
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24939
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j4RvN-0000VH-RW
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582128609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RHbQacxYOv+U2X1sWtSNF0Hw6aIvjDuOLElsJhiu51o=;
 b=iFK1olQWviH5AJGVZ/ft1XL9Sbf0+UQIfkjwnLG/FiT+DGtgS/XjBXiqhlFy7bC73KEjuu
 N7UQ3cUrHx+NILyA6fP7VjPXqMnoWdk1uuTfQEQhdUKVtn3p/s24sIcK/rtScrqW7eh7OA
 50is0cST4RABU36A90X79CmPKzaDPzw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-r1owoshPNvmfiEL8l4GcOg-1; Wed, 19 Feb 2020 11:10:02 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A1838F5E35;
 Wed, 19 Feb 2020 16:10:01 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3CE746E3EE;
 Wed, 19 Feb 2020 16:10:00 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 03/79] machine: alias -mem-path and -mem-prealloc into
 memory-foo backend
Date: Wed, 19 Feb 2020 11:08:37 -0500
Message-Id: <20200219160953.13771-4-imammedo@redhat.com>
In-Reply-To: <20200219160953.13771-1-imammedo@redhat.com>
References: <20200219160953.13771-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: r1owoshPNvmfiEL8l4GcOg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: pasic@linux.ibm.com, Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow machine to opt in for hostmem backend based initial RAM
even if user uses old -mem-path/prealloc options by providing
  MachineClass::default_ram_id
Follow up patches will incrementally convert machines to new API,
by dropping memory_region_allocate_system_memory() and setting
default_ram_id that board used to use before conversion to keep
migration stream the same.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v3:
   * rename "ram-memdev" property to "memory-backend"
     (Paolo Bonzini <pbonzini@redhat.com>)
v4:
   * previous patch changed memory-backend property from link
     to string to allow for delayed backend creation, when
     backend comes explicitly from CLI.
     So s/object_property_set_link()/object_property_set_str()/
     to account for that.
v5:
   * add comment clarifaing that MachineClass::default_ram_id will
     serve as a way to enable "-m" support

CC: ehabkost@redhat.com
CC: pbonzini@redhat.com
CC: philmd@redhat.com
CC: pasic@linux.ibm.com
---
 include/hw/boards.h      |  8 ++++++++
 include/sysemu/hostmem.h | 16 ++++++++++++++++
 backends/hostmem-file.c  |  7 -------
 backends/hostmem-ram.c   |  2 --
 vl.c                     | 25 +++++++++++++++++++++++++
 5 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 7b4b6b79d7..8e536cafb2 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -170,6 +170,13 @@ typedef struct {
  *    false is returned, an error must be set to show the reason of
  *    the rejection.  If the hook is not provided, all hotplug will be
  *    allowed.
+ * @default_ram_id:
+ *    Specifies inital RAM MemoryRegion name to be used for default backen=
d
+ *    creation if user explicitly hasn't specified backend with "memory-ba=
ckend"
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
=20
     HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
                                            DeviceState *dev);
diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
index 4dbdadd39e..5db0d668ec 100644
--- a/include/sysemu/hostmem.h
+++ b/include/sysemu/hostmem.h
@@ -27,6 +27,22 @@
 #define MEMORY_BACKEND_CLASS(klass) \
     OBJECT_CLASS_CHECK(HostMemoryBackendClass, (klass), TYPE_MEMORY_BACKEN=
D)
=20
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
=20
 /**
diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index be64020746..cb319a9157 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -18,13 +18,6 @@
 #include "sysemu/sysemu.h"
 #include "qom/object_interfaces.h"
=20
-/* hostmem-file.c */
-/**
- * @TYPE_MEMORY_BACKEND_FILE:
- * name of backend that uses mmap on a file descriptor
- */
-#define TYPE_MEMORY_BACKEND_FILE "memory-backend-file"
-
 #define MEMORY_BACKEND_FILE(obj) \
     OBJECT_CHECK(HostMemoryBackendFile, (obj), TYPE_MEMORY_BACKEND_FILE)
=20
diff --git a/backends/hostmem-ram.c b/backends/hostmem-ram.c
index 6aab8d3a73..5cc53e76c9 100644
--- a/backends/hostmem-ram.c
+++ b/backends/hostmem-ram.c
@@ -16,8 +16,6 @@
 #include "qemu/module.h"
 #include "qom/object_interfaces.h"
=20
-#define TYPE_MEMORY_BACKEND_RAM "memory-backend-ram"
-
 static void
 ram_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 {
diff --git a/vl.c b/vl.c
index 794f2e5733..4dc4803611 100644
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
@@ -2805,6 +2806,26 @@ static void configure_accelerators(const char *progn=
ame)
     }
 }
=20
+static void create_default_memdev(MachineState *ms, const char *path,
+                                  bool prealloc)
+{
+    Object *obj;
+    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
+
+    obj =3D object_new(path ? TYPE_MEMORY_BACKEND_FILE : TYPE_MEMORY_BACKE=
ND_RAM);
+    if (path) {
+        object_property_set_str(obj, path, "mem-path", &error_fatal);
+    }
+    object_property_set_bool(obj, prealloc, "prealloc", &error_fatal);
+    object_property_set_int(obj, ms->ram_size, "size", &error_fatal);
+    object_property_add_child(object_get_objects_root(), mc->default_ram_i=
d,
+                              obj, &error_fatal);
+    user_creatable_complete(USER_CREATABLE(obj), &error_fatal);
+    object_unref(obj);
+    object_property_set_str(OBJECT(ms), mc->default_ram_id, "memory-backen=
d",
+                            &error_fatal);
+}
+
 int main(int argc, char **argv, char **envp)
 {
     int i;
@@ -4268,6 +4289,10 @@ int main(int argc, char **argv, char **envp)
     }
     parse_numa_opts(current_machine);
=20
+    if (machine_class->default_ram_id && current_machine->ram_size &&
+        !current_machine->ram_memdev_id) {
+        create_default_memdev(current_machine, mem_path, mem_prealloc);
+    }
     /* do monitor/qmp handling at preconfig state if requested */
     main_loop();
=20
--=20
2.18.1


