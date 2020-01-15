Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37455C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 15:12:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 039C32187F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 15:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wq6IE3ku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 039C32187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irkLc-0001Mv-Ig
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 10:12:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48509)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1irkJc-0006x2-3a
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:10:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1irkJa-0007sd-H0
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:10:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42144
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1irkJa-0007sJ-Co
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:10:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579101037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dWgkt/GjmTaXS+BKDJKhJL6ilO1+22S9q88Cm1FzNuQ=;
 b=Wq6IE3kuy6b5Mm00EckZyEUMKWwVmUSYafECcKjqarr0Q6nnybBuBLX+JnbjHv0+e+N1Lr
 JcYHAn5LIRCRPztPkJ0ZnaBLoBchCz4jrXk2K7rMahtlfzdho2VvIWc5nXM+cUpaucgQrY
 LLmCh4KC/buYBbslmWLRAsROR1q1wVI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-F1-J8NJZMWW6E5CW_P-jnA-1; Wed, 15 Jan 2020 10:10:36 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2A838036C2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 15:10:35 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA9312899E;
 Wed, 15 Jan 2020 15:10:12 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/86] machine: alias -mem-path and -mem-prealloc into
 memory-foo backend
Date: Wed, 15 Jan 2020 16:06:18 +0100
Message-Id: <1579100861-73692-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: F1-J8NJZMWW6E5CW_P-jnA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: pbonzini@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow a machine to opt in for hostmem backend based initial
RAM even if user used old -mem-path/prealloc options by providing
  MachineClass::default_ram_id
Follow up patches will incrementally convert machines to new API,
by dropping memory_region_allocate_system_memory() and setting
default_ram_id that board used to use before conversion to keep
migration stream the same.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: ehabkost@redhat.com
CC: pbonzini@redhat.com
---
 include/hw/boards.h      |  5 +++++
 include/sysemu/hostmem.h | 16 ++++++++++++++++
 backends/hostmem-file.c  |  7 -------
 backends/hostmem-ram.c   |  2 --
 vl.c                     | 25 +++++++++++++++++++++++++
 5 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 6aa01b8..e3ea8b0 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -170,6 +170,10 @@ typedef struct {
  *    false is returned, an error must be set to show the reason of
  *    the rejection.  If the hook is not provided, all hotplug will be
  *    allowed.
+ * @default_ram_id:
+ *    Specifies inital RAM MemoryRegion name to be used for default backen=
d
+ *    creation if user explicitly hasn't specified backend with "ram-memde=
v"
+ *    property.
  */
 struct MachineClass {
     /*< private >*/
@@ -226,6 +230,7 @@ struct MachineClass {
     bool nvdimm_supported;
     bool numa_mem_supported;
     bool auto_enable_numa;
+    const char *default_ram_id;
=20
     HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
                                            DeviceState *dev);
diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
index 4dbdadd..5db0d66 100644
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
index be64020..cb319a9 100644
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
index 6aab8d3..5cc53e7 100644
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
index 7514012..d36a857 100644
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
@@ -2820,6 +2821,25 @@ static void configure_accelerators(const char *progn=
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
+    object_property_set_link(OBJECT(ms), obj, "ram-memdev", &error_fatal);
+}
+
 int main(int argc, char **argv, char **envp)
 {
     int i;
@@ -4283,6 +4303,11 @@ int main(int argc, char **argv, char **envp)
     }
     parse_numa_opts(current_machine);
=20
+    if (!current_machine->ram_memdev &&
+         machine_class->default_ram_size &&
+         machine_class->default_ram_id) {
+        create_default_memdev(current_machine, mem_path, mem_prealloc);
+    }
     /* do monitor/qmp handling at preconfig state if requested */
     main_loop();
=20
--=20
2.7.4


