Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39992C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:10:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 066CB205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iLDfxE7K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 066CB205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imHIR-0005e5-M9
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 08:10:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imHBo-00055h-Mk
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imHBn-0002D8-4E
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49888
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imHBm-0002AW-VF
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:03:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577797438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CvQmX9TtRsW2ZDQR4ftwakYAXnfi8zri8FLICoD7kqw=;
 b=iLDfxE7KnyA+tSG/AL2gSbE45qx9jxWrKKpo9V+IybQC5o2FD4ng4xn9ciuDTcFWhlaj5O
 ifTItj4qYzxTupwVenFiX0CVnuR+rKfqZcN03Y3UO3n+6u9mAEbbXCfejqpFl5wwZCEZcL
 hwT6gzZKrBFfixO5YR8bsZNL1B7snGA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-TZ0EcxrmMA64nCqRLRmc3Q-1; Tue, 31 Dec 2019 08:03:56 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29498800D50
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:03:55 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A420E78E96
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:03:54 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/86] machine: introduce convenience MachineState::ram
Date: Tue, 31 Dec 2019 14:02:50 +0100
Message-Id: <1577797450-88458-7-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: TZ0EcxrmMA64nCqRLRmc3Q-1
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
 include/hw/boards.h |  9 ++++++++-
 hw/core/machine.c   | 21 +++++++++++++++++++++
 hw/core/numa.c      | 14 +-------------
 3 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 65da7f0..70491c1 100644
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
@@ -295,6 +300,8 @@ struct MachineState {
     bool enable_graphics;
     char *memory_encryption;
     HostMemoryBackend *ram_memdev;
+    /* convenience alias to ram_memdev memory region or numa container */
+    MemoryRegion *ram;
     DeviceMemoryState *device_memory;
=20
     ram_addr_t ram_size;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 4a5cd0d..080ce57 100644
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
@@ -971,10 +972,30 @@ static void machine_numa_finish_cpu_init(MachineState=
 *machine)
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
index e0c6a69..ee655b0 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -520,20 +520,8 @@ void memory_region_allocate_system_memory(MemoryRegion=
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


