Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7267BC34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:14:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C90320675
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gH6Vuhyc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C90320675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Rzt-0002Un-Cb
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 11:14:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j4RvN-0001xl-Mi
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j4RvM-0000UT-29
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34397
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j4RvL-0000UA-U5
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582128607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l/r/1AWPRa0yO7eBl0fnS9tdiCEMSa1nH6cRdCVb/1Q=;
 b=gH6VuhycuBId2Bhjat1PP+WPkVzHMyLVOTlnVHt53+UDTHm/IzrU861qewcmGQMyMSjbu5
 HP0tp29vkSUQhq2rmKXfiGWXw5WJlSjxAHhIKqsf5GaFhgIrTo59pZ5LrKQQ7o8cU6uY/U
 Bph7tuqNmaavneslu0iX19tjhS7CNEM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-ILWhX0ydMhKv2RQFAOZfVA-1; Wed, 19 Feb 2020 11:10:03 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD93F6EDFE;
 Wed, 19 Feb 2020 16:10:02 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B2B008ED01;
 Wed, 19 Feb 2020 16:10:01 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 04/79] machine: introduce convenience MachineState::ram
Date: Wed, 19 Feb 2020 11:08:38 -0500
Message-Id: <20200219160953.13771-5-imammedo@redhat.com>
In-Reply-To: <20200219160953.13771-1-imammedo@redhat.com>
References: <20200219160953.13771-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: ILWhX0ydMhKv2RQFAOZfVA-1
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
Cc: pasic@linux.ibm.com, Paolo Bonzini <pbonzini@redhat.com>,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

the new field will be used by boards to get access to main
RAM memory region and will help to save boiler plate in
boards which often introduce a field or variable just for
this purpose.

Memory region will be equivalent to what currently used
memory_region_allocate_system_memory() is returning apart
from that it will come from hostmem backend.
Followup patches will incrementally switch boards to using
RAM from MachineState::ram.

Patch takes care of non-NUMA case and follow up patch will
initialize MachineState::ram for NUMA case.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
CC: ehabkost@redhat.com
CC: pbonzini@redhat.com
CC: pasic@linux.ibm.com
---
 include/hw/boards.h | 12 +++++++++++-
 hw/core/machine.c   | 24 ++++++++++++++++++++++++
 hw/core/numa.c      | 14 +-------------
 3 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 8e536cafb2..ae2b60fb5e 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -73,7 +73,12 @@ void machine_set_cpu_numa_node(MachineState *machine,
                                Error **errp);
=20
 void machine_class_allow_dynamic_sysbus_dev(MachineClass *mc, const char *=
type);
-
+/*
+ * Checks that backend isn't used, preps it for exclusive usage and
+ * returns migratable MemoryRegion provided by backend.
+ */
+MemoryRegion *machine_consume_memdev(MachineState *machine,
+                                     HostMemoryBackend *backend);
=20
 /**
  * CPUArchId:
@@ -295,6 +300,11 @@ struct MachineState {
     bool enable_graphics;
     char *memory_encryption;
     char *ram_memdev_id;
+    /*
+     * convenience alias to ram_memdev_id backend memory region
+     * or to numa container memory region
+     */
+    MemoryRegion *ram;
     DeviceMemoryState *device_memory;
=20
     ram_addr_t ram_size;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 1a6e485c87..c8d361b710 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -26,6 +26,7 @@
 #include "sysemu/qtest.h"
 #include "hw/pci/pci.h"
 #include "hw/mem/nvdimm.h"
+#include "migration/vmstate.h"
=20
 GlobalProperty hw_compat_4_2[] =3D {
     { "virtio-blk-device", "x-enable-wce-if-config-wce", "off" },
@@ -1059,10 +1060,33 @@ static void machine_numa_finish_cpu_init(MachineSta=
te *machine)
     g_string_free(s, true);
 }
=20
+MemoryRegion *machine_consume_memdev(MachineState *machine,
+                                     HostMemoryBackend *backend)
+{
+    MemoryRegion *ret =3D host_memory_backend_get_memory(backend);
+
+    if (memory_region_is_mapped(ret)) {
+        char *path =3D object_get_canonical_path_component(OBJECT(backend)=
);
+        error_report("memory backend %s can't be used multiple times.", pa=
th);
+        g_free(path);
+        exit(EXIT_FAILURE);
+    }
+    host_memory_backend_set_mapped(backend, true);
+    vmstate_register_ram_global(ret);
+    return ret;
+}
+
 void machine_run_board_init(MachineState *machine)
 {
     MachineClass *machine_class =3D MACHINE_GET_CLASS(machine);
=20
+    if (machine->ram_memdev_id) {
+        Object *o;
+        o =3D object_resolve_path_type(machine->ram_memdev_id,
+                                     TYPE_MEMORY_BACKEND, NULL);
+        machine->ram =3D machine_consume_memdev(machine, MEMORY_BACKEND(o)=
);
+    }
+
     if (machine->numa_state) {
         numa_complete_configuration(machine);
         if (machine->numa_state->num_nodes) {
diff --git a/hw/core/numa.c b/hw/core/numa.c
index 840e68581f..8264336209 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -817,20 +817,8 @@ void memory_region_allocate_system_memory(MemoryRegion=
 *mr, Object *owner,
         if (!backend) {
             continue;
         }
-        MemoryRegion *seg =3D host_memory_backend_get_memory(backend);
-
-        if (memory_region_is_mapped(seg)) {
-            char *path =3D object_get_canonical_path_component(OBJECT(back=
end));
-            error_report("memory backend %s is used multiple times. Each "
-                         "-numa option must use a different memdev value."=
,
-                         path);
-            g_free(path);
-            exit(1);
-        }
-
-        host_memory_backend_set_mapped(backend, true);
+        MemoryRegion *seg =3D machine_consume_memdev(ms, backend);
         memory_region_add_subregion(mr, addr, seg);
-        vmstate_register_ram_global(seg);
         addr +=3D size;
     }
 }
--=20
2.18.1


