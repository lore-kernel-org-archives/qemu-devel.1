Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3B3C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 15:13:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 871432187F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 15:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDRrp6BX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 871432187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irkLr-0001uz-6U
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 10:12:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1irkJe-00071N-Fu
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:10:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1irkJd-0007te-4a
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:10:42 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43710
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1irkJd-0007tD-0R
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:10:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579101040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Gaa0sACd1XCZkfyy2jXhJFqktsmLZLtDiAaMONxV2s=;
 b=RDRrp6BXyAPjaGhe1mAcANRJY2C/g9FopBp6XGmMzx/ASjUBtR2afa86TUrToY7QriLLnT
 2ZYR/gUc1svZRqO+9VzRye/v2UAmp73BwDPOQoI/jOld2UKcm+Otfi2CPejd8nH3gB+iZu
 VuXePWp77d6ti6VadjEehMNScgIIKZw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-X8xLEHLvM4O7gAvIytasPw-1; Wed, 15 Jan 2020 10:10:39 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54F1410845C9
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 15:10:38 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 25DFE28DC5;
 Wed, 15 Jan 2020 15:10:35 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/86] machine: introduce convenience MachineState::ram
Date: Wed, 15 Jan 2020 16:06:19 +0100
Message-Id: <1579100861-73692-5-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: X8xLEHLvM4O7gAvIytasPw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

the new field will be used by boards to get access to main
RAM memory region and will help to save boiler plate in
boards which often add a field or variable just for this
purpose.

Memory region will be equivalent to what currently used
memory_region_allocate_system_memory() is returning apart
from that it will come from hostmem backend.
Followup patches will incrementally switch boards to using
RAM from MachineState::ram.

Patch takes care of non-NUMA case and follow up patch will
initialize MachineState::ram for NUMA case.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: ehabkost@redhat.com
CC: pbonzini@redhat.com
---
 include/hw/boards.h |  9 ++++++++-
 hw/core/machine.c   | 21 +++++++++++++++++++++
 hw/core/numa.c      | 14 +-------------
 3 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index e3ea8b0..80d73b2 100644
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
@@ -292,6 +297,8 @@ struct MachineState {
     bool enable_graphics;
     char *memory_encryption;
     HostMemoryBackend *ram_memdev;
+    /* convenience alias to ram_memdev memory region or numa container */
+    MemoryRegion *ram;
     DeviceMemoryState *device_memory;
=20
     ram_addr_t ram_size;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index fd573d2..9a43081 100644
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
@@ -1041,10 +1042,30 @@ static void machine_numa_finish_cpu_init(MachineSta=
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
+    if (machine->ram_memdev) {
+        machine->ram =3D machine_consume_memdev(machine, machine->ram_memd=
ev);
+    }
+
     if (machine->numa_state) {
         numa_complete_configuration(machine);
         if (machine->numa_state->num_nodes) {
diff --git a/hw/core/numa.c b/hw/core/numa.c
index 840e685..8264336 100644
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
2.7.4


