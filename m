Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0444AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 15:45:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B26A72070A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 15:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V3iUfK/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B26A72070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxuSi-0003YC-00
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 11:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jxuOy-0006tF-Hf
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 11:41:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54612
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jxuOv-0000Kv-40
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 11:41:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595346112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K1jl7GgxzTuUxDpF35nPb8WABrAQ6NBVuaEanr0jAzg=;
 b=V3iUfK/haTG6/II60pzI0rRpFkT2WV494tPd2lohcs2jaMeME1EFU7XdXtfzafJcwfF8gU
 QQztwuvO+9FsPjNG1ZZ9JH1a7S9s1XWHhtvzDYTk8GSDLtynLtXr3S40pTkuZ4IjRVA2MA
 pIgdQyL1mf7awp2n/c0zai9KuO1d+KU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-cvx2-EgTM8-pJpRaiu_hoQ-1; Tue, 21 Jul 2020 11:41:50 -0400
X-MC-Unique: cvx2-EgTM8-pJpRaiu_hoQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31C76100AA27;
 Tue, 21 Jul 2020 15:41:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A92C074F45;
 Tue, 21 Jul 2020 15:41:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6462210F5AF1; Tue, 21 Jul 2020 17:41:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] qom: Change object_get_canonical_path_component() not to
 malloc
Date: Tue, 21 Jul 2020 17:41:45 +0200
Message-Id: <20200721154147.1657100-2-armbru@redhat.com>
In-Reply-To: <20200721154147.1657100-1-armbru@redhat.com>
References: <20200721154147.1657100-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 10:17:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 Li Qiang <liq3ea@gmail.com>, pbonzini@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

object_get_canonical_path_component() returns a malloced copy of a
property name on success, null on failure.

19 of its 25 callers immediately free the returned copy.

Change object_get_canonical_path_component() to return the property
name directly.  Since modifying the name would be wrong, adjust the
return type to const char *.

Drop the free from the 19 callers become simpler, add the g_strdup()
to the other six.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200714160202.3121879-4-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
---
 include/qom/object.h       |  2 +-
 backends/hostmem.c         |  2 +-
 block/throttle-groups.c    |  2 +-
 gdbstub.c                  |  2 +-
 hw/arm/xlnx-zynqmp.c       |  6 ++----
 hw/block/nvme.c            |  5 ++---
 hw/core/machine-qmp-cmds.c |  2 +-
 hw/core/machine.c          |  5 ++---
 hw/mem/nvdimm.c            |  5 ++---
 hw/mem/pc-dimm.c           |  5 ++---
 hw/misc/ivshmem.c          |  5 ++---
 hw/ppc/spapr_drc.c         |  3 +--
 hw/virtio/virtio-crypto.c  |  5 ++---
 hw/virtio/virtio-mem.c     |  6 ++----
 hw/virtio/virtio-pmem.c    |  5 ++---
 iothread.c                 |  9 ++++-----
 net/net.c                  |  6 ++----
 qom/object.c               |  7 +++----
 qom/qom-hmp-cmds.c         | 11 ++++-------
 scsi/pr-manager-helper.c   |  3 +--
 scsi/pr-manager.c          |  2 +-
 softmmu/memory.c           |  2 +-
 hw/ppc/trace-events        |  2 +-
 23 files changed, 41 insertions(+), 61 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 79c8f838b6..55d925d2c8 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1462,7 +1462,7 @@ Object *object_get_internal_root(void);
  * path is the path within the composition tree starting from the root.
  * %NULL if the object doesn't have a parent (and thus a canonical path).
  */
-char *object_get_canonical_path_component(const Object *obj);
+const char *object_get_canonical_path_component(const Object *obj);
 
 /**
  * object_get_canonical_path:
diff --git a/backends/hostmem.c b/backends/hostmem.c
index c614f1bdc1..4bde00e8e7 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -33,7 +33,7 @@ char *
 host_memory_backend_get_name(HostMemoryBackend *backend)
 {
     if (!backend->use_canonical_path) {
-        return object_get_canonical_path_component(OBJECT(backend));
+        return g_strdup(object_get_canonical_path_component(OBJECT(backend)));
     }
 
     return object_get_canonical_path(OBJECT(backend));
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 03a53c89ea..98fea7fd47 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -771,7 +771,7 @@ static void throttle_group_obj_complete(UserCreatable *obj, Error **errp)
 
     /* set group name to object id if it exists */
     if (!tg->name && tg->parent_obj.parent) {
-        tg->name = object_get_canonical_path_component(OBJECT(obj));
+        tg->name = g_strdup(object_get_canonical_path_component(OBJECT(obj)));
     }
     /* We must have a group name at this point */
     assert(tg->name);
diff --git a/gdbstub.c b/gdbstub.c
index 6950fd243f..f3a318cd7f 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2059,7 +2059,7 @@ static void handle_query_thread_extra(GdbCmdContext *gdb_ctx, void *user_ctx)
         /* Print the CPU model and name in multiprocess mode */
         ObjectClass *oc = object_get_class(OBJECT(cpu));
         const char *cpu_model = object_class_get_name(oc);
-        g_autofree char *cpu_name =
+        const char *cpu_name =
             object_get_canonical_path_component(OBJECT(cpu));
         g_string_printf(rs, "%s %s [%s]", cpu_model, cpu_name,
                         cpu->halted ? "halted " : "running");
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 772cfa3771..e14323c991 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -190,7 +190,7 @@ static void xlnx_zynqmp_create_rpu(MachineState *ms, XlnxZynqMPState *s,
     qdev_prop_set_uint32(DEVICE(&s->rpu_cluster), "cluster-id", 1);
 
     for (i = 0; i < num_rpus; i++) {
-        char *name;
+        const char *name;
 
         object_initialize_child(OBJECT(&s->rpu_cluster), "rpu-cpu[*]",
                                 &s->rpu_cpu[i],
@@ -204,7 +204,6 @@ static void xlnx_zynqmp_create_rpu(MachineState *ms, XlnxZynqMPState *s,
         } else {
             s->boot_cpu_ptr = &s->rpu_cpu[i];
         }
-        g_free(name);
 
         object_property_set_bool(OBJECT(&s->rpu_cpu[i]), "reset-hivecs", true,
                                  &error_abort);
@@ -341,7 +340,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
 
     /* Realize APUs before realizing the GIC. KVM requires this.  */
     for (i = 0; i < num_apus; i++) {
-        char *name;
+        const char *name;
 
         object_property_set_int(OBJECT(&s->apu_cpu[i]), "psci-conduit",
                                 QEMU_PSCI_CONDUIT_SMC, &error_abort);
@@ -354,7 +353,6 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         } else {
             s->boot_cpu_ptr = &s->apu_cpu[i];
         }
-        g_free(name);
 
         object_property_set_bool(OBJECT(&s->apu_cpu[i]), "has_el3", s->secure,
                                  NULL);
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 1aee042d4c..3426e17e65 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1397,9 +1397,8 @@ static void nvme_check_constraints(NvmeCtrl *n, Error **errp)
 
     if (!n->params.cmb_size_mb && n->pmrdev) {
         if (host_memory_backend_is_mapped(n->pmrdev)) {
-            char *path = object_get_canonical_path_component(OBJECT(n->pmrdev));
-            error_setg(errp, "can't use already busy memdev: %s", path);
-            g_free(path);
+            error_setg(errp, "can't use already busy memdev: %s",
+                       object_get_canonical_path_component(OBJECT(n->pmrdev)));
             return;
         }
 
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 2c5da8413d..963088b798 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -315,7 +315,7 @@ static int query_memdev(Object *obj, void *opaque)
 
         m->value = g_malloc0(sizeof(*m->value));
 
-        m->value->id = object_get_canonical_path_component(obj);
+        m->value->id = g_strdup(object_get_canonical_path_component(obj));
         m->value->has_id = !!m->value->id;
 
         m->value->size = object_property_get_uint(obj, "size",
diff --git a/hw/core/machine.c b/hw/core/machine.c
index eb267b828d..2f881d6d75 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1073,9 +1073,8 @@ MemoryRegion *machine_consume_memdev(MachineState *machine,
     MemoryRegion *ret = host_memory_backend_get_memory(backend);
 
     if (memory_region_is_mapped(ret)) {
-        char *path = object_get_canonical_path_component(OBJECT(backend));
-        error_report("memory backend %s can't be used multiple times.", path);
-        g_free(path);
+        error_report("memory backend %s can't be used multiple times.",
+                     object_get_canonical_path_component(OBJECT(backend)));
         exit(EXIT_FAILURE);
     }
     host_memory_backend_set_mapped(backend, true);
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index d0d6e553cf..e1574bc07c 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -137,13 +137,12 @@ static void nvdimm_prepare_memory_region(NVDIMMDevice *nvdimm, Error **errp)
 
     if (size <= nvdimm->label_size || !pmem_size) {
         HostMemoryBackend *hostmem = dimm->hostmem;
-        char *path = object_get_canonical_path_component(OBJECT(hostmem));
 
         error_setg(errp, "the size of memdev %s (0x%" PRIx64 ") is too "
                    "small to contain nvdimm label (0x%" PRIx64 ") and "
                    "aligned PMEM (0x%" PRIx64 ")",
-                   path, memory_region_size(mr), nvdimm->label_size, align);
-        g_free(path);
+                   object_get_canonical_path_component(OBJECT(hostmem)),
+                   memory_region_size(mr), nvdimm->label_size, align);
         return;
     }
 
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 9d3f0b9691..c30351070b 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -179,9 +179,8 @@ static void pc_dimm_realize(DeviceState *dev, Error **errp)
         error_setg(errp, "'" PC_DIMM_MEMDEV_PROP "' property is not set");
         return;
     } else if (host_memory_backend_is_mapped(dimm->hostmem)) {
-        char *path = object_get_canonical_path_component(OBJECT(dimm->hostmem));
-        error_setg(errp, "can't use already busy memdev: %s", path);
-        g_free(path);
+        error_setg(errp, "can't use already busy memdev: %s",
+                   object_get_canonical_path_component(OBJECT(dimm->hostmem)));
         return;
     }
     if (((nb_numa_nodes > 0) && (dimm->node >= nb_numa_nodes)) ||
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index fc128b25e2..2b6882face 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -1037,9 +1037,8 @@ static void ivshmem_plain_realize(PCIDevice *dev, Error **errp)
         error_setg(errp, "You must specify a 'memdev'");
         return;
     } else if (host_memory_backend_is_mapped(s->hostmem)) {
-        char *path = object_get_canonical_path_component(OBJECT(s->hostmem));
-        error_setg(errp, "can't use already busy memdev: %s", path);
-        g_free(path);
+        error_setg(errp, "can't use already busy memdev: %s",
+                   object_get_canonical_path_component(OBJECT(s->hostmem)));
         return;
     }
 
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 43d12bc33a..fe998d8108 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -513,7 +513,7 @@ static void realize(DeviceState *d, Error **errp)
     SpaprDrc *drc = SPAPR_DR_CONNECTOR(d);
     Object *root_container;
     gchar *link_name;
-    char *child_name;
+    const char *child_name;
 
     trace_spapr_drc_realize(spapr_drc_index(drc));
     /* NOTE: we do this as part of realize/unrealize due to the fact
@@ -529,7 +529,6 @@ static void realize(DeviceState *d, Error **errp)
     trace_spapr_drc_realize_child(spapr_drc_index(drc), child_name);
     object_property_add_alias(root_container, link_name,
                               drc->owner, child_name);
-    g_free(child_name);
     g_free(link_name);
     vmstate_register(VMSTATE_IF(drc), spapr_drc_index(drc), &vmstate_spapr_drc,
                      drc);
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index bd9165c565..6da12e315f 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -786,9 +786,8 @@ static void virtio_crypto_device_realize(DeviceState *dev, Error **errp)
         error_setg(errp, "'cryptodev' parameter expects a valid object");
         return;
     } else if (cryptodev_backend_is_used(vcrypto->cryptodev)) {
-        char *path = object_get_canonical_path_component(OBJECT(vcrypto->conf.cryptodev));
-        error_setg(errp, "can't use already used cryptodev backend: %s", path);
-        g_free(path);
+        error_setg(errp, "can't use already used cryptodev backend: %s",
+                   object_get_canonical_path_component(OBJECT(vcrypto->conf.cryptodev)));
         return;
     }
 
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 65850530e7..c12e9f79b0 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -409,11 +409,9 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
         error_setg(errp, "'%s' property is not set", VIRTIO_MEM_MEMDEV_PROP);
         return;
     } else if (host_memory_backend_is_mapped(vmem->memdev)) {
-        char *path = object_get_canonical_path_component(OBJECT(vmem->memdev));
-
         error_setg(errp, "'%s' property specifies a busy memdev: %s",
-                   VIRTIO_MEM_MEMDEV_PROP, path);
-        g_free(path);
+                   VIRTIO_MEM_MEMDEV_PROP,
+                   object_get_canonical_path_component(OBJECT(vmem->memdev)));
         return;
     } else if (!memory_region_is_ram(&vmem->memdev->mr) ||
         memory_region_is_rom(&vmem->memdev->mr) ||
diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
index c3374b2f3f..1e0c137497 100644
--- a/hw/virtio/virtio-pmem.c
+++ b/hw/virtio/virtio-pmem.c
@@ -112,9 +112,8 @@ static void virtio_pmem_realize(DeviceState *dev, Error **errp)
     }
 
     if (host_memory_backend_is_mapped(pmem->memdev)) {
-        char *path = object_get_canonical_path_component(OBJECT(pmem->memdev));
-        error_setg(errp, "can't use already busy memdev: %s", path);
-        g_free(path);
+        error_setg(errp, "can't use already busy memdev: %s",
+                   object_get_canonical_path_component(OBJECT(pmem->memdev)));
         return;
     }
 
diff --git a/iothread.c b/iothread.c
index 0598a6d20d..263ec6e5bc 100644
--- a/iothread.c
+++ b/iothread.c
@@ -165,7 +165,7 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
 {
     Error *local_error = NULL;
     IOThread *iothread = IOTHREAD(obj);
-    char *name, *thread_name;
+    char *thread_name;
 
     iothread->stopping = false;
     iothread->running = true;
@@ -195,12 +195,11 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
     /* This assumes we are called from a thread with useful CPU affinity for us
      * to inherit.
      */
-    name = object_get_canonical_path_component(OBJECT(obj));
-    thread_name = g_strdup_printf("IO %s", name);
+    thread_name = g_strdup_printf("IO %s",
+                        object_get_canonical_path_component(OBJECT(obj)));
     qemu_thread_create(&iothread->thread, thread_name, iothread_run,
                        iothread, QEMU_THREAD_JOINABLE);
     g_free(thread_name);
-    g_free(name);
 
     /* Wait for initialization to complete */
     while (iothread->thread_id == -1) {
@@ -303,7 +302,7 @@ type_init(iothread_register_types)
 
 char *iothread_get_id(IOThread *iothread)
 {
-    return object_get_canonical_path_component(OBJECT(iothread));
+    return g_strdup(object_get_canonical_path_component(OBJECT(iothread)));
 }
 
 AioContext *iothread_get_aio_context(IOThread *iothread)
diff --git a/net/net.c b/net/net.c
index 7fddcebaa2..bbaedb3c7a 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1185,12 +1185,10 @@ void print_net_client(Monitor *mon, NetClientState *nc)
         monitor_printf(mon, "filters:\n");
     }
     QTAILQ_FOREACH(nf, &nc->filters, next) {
-        char *path = object_get_canonical_path_component(OBJECT(nf));
-
-        monitor_printf(mon, "  - %s: type=%s", path,
+        monitor_printf(mon, "  - %s: type=%s",
+                       object_get_canonical_path_component(OBJECT(nf)),
                        object_get_typename(OBJECT(nf)));
         netfilter_print_info(mon, nf);
-        g_free(path);
     }
 }
 
diff --git a/qom/object.c b/qom/object.c
index 76f5f75239..00fdf89b3b 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1931,7 +1931,7 @@ object_property_add_const_link(Object *obj, const char *name,
                                 NULL, OBJ_PROP_LINK_DIRECT);
 }
 
-char *object_get_canonical_path_component(const Object *obj)
+const char *object_get_canonical_path_component(const Object *obj)
 {
     ObjectProperty *prop = NULL;
     GHashTableIter iter;
@@ -1947,7 +1947,7 @@ char *object_get_canonical_path_component(const Object *obj)
         }
 
         if (prop->opaque == obj) {
-            return g_strdup(prop->name);
+            return prop->name;
         }
     }
 
@@ -1966,7 +1966,7 @@ char *object_get_canonical_path(const Object *obj)
     }
 
     do {
-        char *component = object_get_canonical_path_component(obj);
+        const char *component = object_get_canonical_path_component(obj);
 
         if (!component) {
             /* A canonical path must be complete, so discard what was
@@ -1978,7 +1978,6 @@ char *object_get_canonical_path(const Object *obj)
 
         newpath = g_strdup_printf("/%s%s", component, path ? path : "");
         g_free(path);
-        g_free(component);
         path = newpath;
         obj = obj->parent;
     } while (obj != root);
diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
index aaacadacca..4032c96089 100644
--- a/qom/qom-hmp-cmds.c
+++ b/qom/qom-hmp-cmds.c
@@ -96,10 +96,8 @@ static void print_qom_composition(Monitor *mon, Object *obj, int indent);
 
 static int qom_composition_compare(const void *a, const void *b, void *ignore)
 {
-    g_autofree char *ac = object_get_canonical_path_component(a);
-    g_autofree char *bc = object_get_canonical_path_component(b);
-
-    return g_strcmp0(ac, bc);
+    return g_strcmp0(object_get_canonical_path_component(a),
+                     object_get_canonical_path_component(b));
 }
 
 static int insert_qom_composition_child(Object *obj, void *opaque)
@@ -112,18 +110,17 @@ static int insert_qom_composition_child(Object *obj, void *opaque)
 
 static void print_qom_composition(Monitor *mon, Object *obj, int indent)
 {
-    char *name;
+    const char *name;
     GQueue children;
     Object *child;
 
     if (obj == object_get_root()) {
-        name = g_strdup("");
+        name = "";
     } else {
         name = object_get_canonical_path_component(obj);
     }
     monitor_printf(mon, "%*s/%s (%s)\n", indent, "", name,
                    object_get_typename(obj));
-    g_free(name);
 
     g_queue_init(&children);
     object_child_foreach(obj, insert_qom_composition_child, &children);
diff --git a/scsi/pr-manager-helper.c b/scsi/pr-manager-helper.c
index bf62cbec11..5acccfb4e3 100644
--- a/scsi/pr-manager-helper.c
+++ b/scsi/pr-manager-helper.c
@@ -42,11 +42,10 @@ typedef struct PRManagerHelper {
 
 static void pr_manager_send_status_changed_event(PRManagerHelper *pr_mgr)
 {
-    char *id = object_get_canonical_path_component(OBJECT(pr_mgr));
+    const char *id = object_get_canonical_path_component(OBJECT(pr_mgr));
 
     if (id) {
         qapi_event_send_pr_manager_status_changed(id, !!pr_mgr->ioc);
-        g_free(id);
     }
 }
 
diff --git a/scsi/pr-manager.c b/scsi/pr-manager.c
index 0c866e8698..32b9287e68 100644
--- a/scsi/pr-manager.c
+++ b/scsi/pr-manager.c
@@ -128,7 +128,7 @@ static int query_one_pr_manager(Object *object, void *opaque)
 
     elem = g_new0(PRManagerInfoList, 1);
     info = g_new0(PRManagerInfo, 1);
-    info->id = object_get_canonical_path_component(object);
+    info->id = g_strdup(object_get_canonical_path_component(object));
     info->connected = pr_manager_is_connected(pr_mgr);
     elem->value = info;
     elem->next = NULL;
diff --git a/softmmu/memory.c b/softmmu/memory.c
index 9200b20130..af25987518 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -1764,7 +1764,7 @@ const char *memory_region_name(const MemoryRegion *mr)
 {
     if (!mr->name) {
         ((MemoryRegion *)mr)->name =
-            object_get_canonical_path_component(OBJECT(mr));
+            g_strdup(object_get_canonical_path_component(OBJECT(mr)));
     }
     return mr->name;
 }
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index 9ea620f23c..7c0be4102e 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -57,7 +57,7 @@ spapr_drc_detach(uint32_t index) "drc: 0x%"PRIx32
 spapr_drc_awaiting_quiesce(uint32_t index) "drc: 0x%"PRIx32
 spapr_drc_reset(uint32_t index) "drc: 0x%"PRIx32
 spapr_drc_realize(uint32_t index) "drc: 0x%"PRIx32
-spapr_drc_realize_child(uint32_t index, char *childname) "drc: 0x%"PRIx32", child name: %s"
+spapr_drc_realize_child(uint32_t index, const char *childname) "drc: 0x%"PRIx32", child name: %s"
 spapr_drc_realize_complete(uint32_t index) "drc: 0x%"PRIx32
 spapr_drc_unrealize(uint32_t index) "drc: 0x%"PRIx32
 
-- 
2.26.2


