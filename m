Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C509C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:30:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03D6920675
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B8K0MJT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D6920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsqTu-0003Mh-53
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsq7U-0002rW-D7
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:06:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56282
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsq7A-0006rY-VD
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594137994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eSliBWAMKffRLmhjVD35PxyDhRnwXGqnBgSkCIV32J0=;
 b=B8K0MJT9uXOxofJaNgFgCHOqZTJsF9NUn7JFfYm7Y3JG5OsU0N96uS/g+65f3N5LC4/ezG
 /RDy12IxevQivAdXQAP10b0OWu8n9YdEnR9k7g+iDdBxgcOrMxdGgKn66RL8SAhQpj3hIO
 2yFqJORDE0ETgEvCsrVrzEZQa1y0lT8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-Vdmo2POlNtevDu7F7fpqkA-1; Tue, 07 Jul 2020 12:06:32 -0400
X-MC-Unique: Vdmo2POlNtevDu7F7fpqkA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C7F38C99E9;
 Tue,  7 Jul 2020 16:06:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 19AD97922B;
 Tue,  7 Jul 2020 16:06:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 14929119643E; Tue,  7 Jul 2020 18:06:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 36/45] error: Eliminate error_propagate() manually
Date: Tue,  7 Jul 2020 18:06:04 +0200
Message-Id: <20200707160613.848843-37-armbru@redhat.com>
In-Reply-To: <20200707160613.848843-1-armbru@redhat.com>
References: <20200707160613.848843-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:46:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, groug@kaod.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When all we do with an Error we receive into a local variable is
propagating to somewhere else, we can just as well receive it there
right away.  The previous two commits did that for sufficiently simple
cases with Coccinelle.  Do it for several more manually.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/replication.c        |  4 +---
 blockdev.c                 | 16 ++++----------
 bootdevice.c               |  6 ++----
 dump/dump.c                |  7 ++----
 hw/block/fdc.c             |  8 +++----
 hw/core/numa.c             | 44 ++++++++++++--------------------------
 hw/i386/x86.c              |  6 ++----
 hw/intc/xive.c             | 12 +++--------
 hw/ppc/spapr_cpu_core.c    | 14 ++++--------
 hw/s390x/s390-pci-bus.c    |  4 +---
 hw/s390x/s390-virtio-ccw.c |  6 ++----
 hw/s390x/sclp.c            | 12 ++++-------
 hw/usb/bus.c               |  4 +---
 qdev-monitor.c             | 12 ++++-------
 qga/commands-posix.c       |  4 +---
 qom/object.c               | 33 +++++++++++-----------------
 qom/qom-qobject.c          |  5 +----
 target/i386/cpu.c          | 19 +++++-----------
 18 files changed, 67 insertions(+), 149 deletions(-)

diff --git a/block/replication.c b/block/replication.c
index b844a09eb1..dcd430624e 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -367,7 +367,6 @@ static void reopen_backing_file(BlockDriverState *bs, bool writable,
 {
     BDRVReplicationState *s = bs->opaque;
     BlockReopenQueue *reopen_queue = NULL;
-    Error *local_err = NULL;
 
     if (writable) {
         s->orig_hidden_read_only = bdrv_is_read_only(s->hidden_disk->bs);
@@ -392,8 +391,7 @@ static void reopen_backing_file(BlockDriverState *bs, bool writable,
     }
 
     if (reopen_queue) {
-        bdrv_reopen_multiple(reopen_queue, &local_err);
-        error_propagate(errp, local_err);
+        bdrv_reopen_multiple(reopen_queue, errp);
     }
 
     bdrv_subtree_drained_end(s->hidden_disk->bs);
diff --git a/blockdev.c b/blockdev.c
index 1f254e7110..59b0b8ffaf 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -793,7 +793,6 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type,
     bool read_only = false;
     bool copy_on_read;
     const char *filename;
-    Error *local_err = NULL;
     int i;
 
     /* Change legacy command line options into QMP ones */
@@ -1003,13 +1002,10 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type,
     }
 
     /* Actual block device init: Functionality shared with blockdev-add */
-    blk = blockdev_init(filename, bs_opts, &local_err);
+    blk = blockdev_init(filename, bs_opts, errp);
     bs_opts = NULL;
     if (!blk) {
-        error_propagate(errp, local_err);
         goto fail;
-    } else {
-        assert(!local_err);
     }
 
     /* Create legacy DriveInfo */
@@ -3141,9 +3137,8 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
                            arg->has_copy_mode, arg->copy_mode,
                            arg->has_auto_finalize, arg->auto_finalize,
                            arg->has_auto_dismiss, arg->auto_dismiss,
-                           &local_err);
+                           errp);
     bdrv_unref(target_bs);
-    error_propagate(errp, local_err);
 out:
     aio_context_release(aio_context);
 }
@@ -3171,7 +3166,6 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
     AioContext *aio_context;
     AioContext *old_context;
     BlockMirrorBackingMode backing_mode = MIRROR_LEAVE_BACKING_CHAIN;
-    Error *local_err = NULL;
     bool zero_target;
     int ret;
 
@@ -3213,8 +3207,7 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
                            has_copy_mode, copy_mode,
                            has_auto_finalize, auto_finalize,
                            has_auto_dismiss, auto_dismiss,
-                           &local_err);
-    error_propagate(errp, local_err);
+                           errp);
 out:
     aio_context_release(aio_context);
 }
@@ -3433,8 +3426,7 @@ void qmp_change_backing_file(const char *device,
     }
 
     if (ro) {
-        bdrv_reopen_set_read_only(image_bs, true, &local_err);
-        error_propagate(errp, local_err);
+        bdrv_reopen_set_read_only(image_bs, true, errp);
     }
 
 out:
diff --git a/bootdevice.c b/bootdevice.c
index 8185402a5a..add4e3d2d1 100644
--- a/bootdevice.c
+++ b/bootdevice.c
@@ -303,15 +303,13 @@ static void device_set_bootindex(Object *obj, Visitor *v, const char *name,
     /* check whether bootindex is present in fw_boot_order list  */
     check_boot_index(boot_index, &local_err);
     if (local_err) {
-        goto out;
+        error_propagate(errp, local_err);
+        return;
     }
     /* change bootindex to a new one */
     *prop->bootindex = boot_index;
 
     add_boot_device_path(*prop->bootindex, prop->dev, prop->suffix);
-
-out:
-    error_propagate(errp, local_err);
 }
 
 static void property_release_bootindex(Object *obj, const char *name,
diff --git a/dump/dump.c b/dump/dump.c
index 248ea06370..383bc7876b 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -1031,14 +1031,11 @@ out:
 
 static void write_dump_header(DumpState *s, Error **errp)
 {
-     Error *local_err = NULL;
-
     if (s->dump_info.d_class == ELFCLASS32) {
-        create_header32(s, &local_err);
+        create_header32(s, errp);
     } else {
-        create_header64(s, &local_err);
+        create_header64(s, errp);
     }
-    error_propagate(errp, local_err);
 }
 
 static size_t dump_bitmap_get_bufsize(DumpState *s)
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index f22f46c9c9..e9ed3eef45 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -2528,7 +2528,7 @@ static void fdctrl_connect_drives(FDCtrl *fdctrl, DeviceState *fdc_dev,
     FDrive *drive;
     DeviceState *dev;
     BlockBackend *blk;
-    Error *local_err = NULL;
+    bool ok;
     const char *fdc_name, *drive_suffix;
 
     for (i = 0; i < MAX_FD; i++) {
@@ -2567,11 +2567,9 @@ static void fdctrl_connect_drives(FDCtrl *fdctrl, DeviceState *fdc_dev,
         blk_ref(blk);
         blk_detach_dev(blk, fdc_dev);
         fdctrl->qdev_for_drives[i].blk = NULL;
-        qdev_prop_set_drive_err(dev, "drive", blk, &local_err);
+        ok = qdev_prop_set_drive_err(dev, "drive", blk, errp);
         blk_unref(blk);
-
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (!ok) {
             return;
         }
 
diff --git a/hw/core/numa.c b/hw/core/numa.c
index 0e311a12df..d208fd5008 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -456,40 +456,33 @@ void parse_numa_hmat_cache(MachineState *ms, NumaHmatCacheOptions *node,
 
 void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
 {
-    Error *err = NULL;
-
     if (!ms->numa_state) {
         error_setg(errp, "NUMA is not supported by this machine-type");
-        goto end;
+        return;
     }
 
     switch (object->type) {
     case NUMA_OPTIONS_TYPE_NODE:
-        parse_numa_node(ms, &object->u.node, &err);
-        if (err) {
-            goto end;
-        }
+        parse_numa_node(ms, &object->u.node, errp);
         break;
     case NUMA_OPTIONS_TYPE_DIST:
-        parse_numa_distance(ms, &object->u.dist, &err);
-        if (err) {
-            goto end;
-        }
+        parse_numa_distance(ms, &object->u.dist, errp);
         break;
     case NUMA_OPTIONS_TYPE_CPU:
         if (!object->u.cpu.has_node_id) {
-            error_setg(&err, "Missing mandatory node-id property");
-            goto end;
+            error_setg(errp, "Missing mandatory node-id property");
+            return;
         }
         if (!ms->numa_state->nodes[object->u.cpu.node_id].present) {
-            error_setg(&err, "Invalid node-id=%" PRId64 ", NUMA node must be "
-                "defined with -numa node,nodeid=ID before it's used with "
-                "-numa cpu,node-id=ID", object->u.cpu.node_id);
-            goto end;
+            error_setg(errp, "Invalid node-id=%" PRId64 ", NUMA node must be "
+                       "defined with -numa node,nodeid=ID before it's used with "
+                       "-numa cpu,node-id=ID", object->u.cpu.node_id);
+            return;
         }
 
-        machine_set_cpu_numa_node(ms, qapi_NumaCpuOptions_base(&object->u.cpu),
-                                  &err);
+        machine_set_cpu_numa_node(ms,
+                                  qapi_NumaCpuOptions_base(&object->u.cpu),
+                                  errp);
         break;
     case NUMA_OPTIONS_TYPE_HMAT_LB:
         if (!ms->numa_state->hmat_enabled) {
@@ -499,10 +492,7 @@ void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
             return;
         }
 
-        parse_numa_hmat_lb(ms->numa_state, &object->u.hmat_lb, &err);
-        if (err) {
-            goto end;
-        }
+        parse_numa_hmat_lb(ms->numa_state, &object->u.hmat_lb, errp);
         break;
     case NUMA_OPTIONS_TYPE_HMAT_CACHE:
         if (!ms->numa_state->hmat_enabled) {
@@ -512,17 +502,11 @@ void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
             return;
         }
 
-        parse_numa_hmat_cache(ms, &object->u.hmat_cache, &err);
-        if (err) {
-            goto end;
-        }
+        parse_numa_hmat_cache(ms, &object->u.hmat_cache, errp);
         break;
     default:
         abort();
     }
-
-end:
-    error_propagate(errp, err);
 }
 
 static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 22b524e0ab..67bee1bcb8 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -118,17 +118,15 @@ uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
 
 void x86_cpu_new(X86MachineState *x86ms, int64_t apic_id, Error **errp)
 {
-    Error *local_err = NULL;
     Object *cpu = object_new(MACHINE(x86ms)->cpu_type);
 
-    if (!object_property_set_uint(cpu, "apic-id", apic_id, &local_err)) {
+    if (!object_property_set_uint(cpu, "apic-id", apic_id, errp)) {
         goto out;
     }
-    qdev_realize(DEVICE(cpu), NULL, &local_err);
+    qdev_realize(DEVICE(cpu), NULL, errp);
 
 out:
     object_unref(cpu);
-    error_propagate(errp, local_err);
 }
 
 void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 34591659d3..9a162431e0 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -757,7 +757,6 @@ static const TypeInfo xive_tctx_info = {
 
 Object *xive_tctx_create(Object *cpu, XivePresenter *xptr, Error **errp)
 {
-    Error *local_err = NULL;
     Object *obj;
 
     obj = object_new(TYPE_XIVE_TCTX);
@@ -765,16 +764,11 @@ Object *xive_tctx_create(Object *cpu, XivePresenter *xptr, Error **errp)
     object_unref(obj);
     object_property_set_link(obj, "cpu", cpu, &error_abort);
     object_property_set_link(obj, "presenter", OBJECT(xptr), &error_abort);
-    if (!qdev_realize(DEVICE(obj), NULL, &local_err)) {
-        goto error;
+    if (!qdev_realize(DEVICE(obj), NULL, errp)) {
+        object_unparent(obj);
+        return NULL;
     }
-
     return obj;
-
-error:
-    object_unparent(obj);
-    error_propagate(errp, local_err);
-    return NULL;
 }
 
 void xive_tctx_destroy(XiveTCTX *tctx)
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 85330d08a1..c4f47dcc04 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -239,8 +239,8 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, SpaprMachineState *spapr,
     CPUState *cs = CPU(cpu);
     Error *local_err = NULL;
 
-    if (!qdev_realize(DEVICE(cpu), NULL, &local_err)) {
-        goto error;
+    if (!qdev_realize(DEVICE(cpu), NULL, errp)) {
+        return;
     }
 
     /* Set time-base frequency to 512 MHz */
@@ -250,20 +250,14 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, SpaprMachineState *spapr,
     kvmppc_set_papr(cpu);
 
     if (spapr_irq_cpu_intc_create(spapr, cpu, &local_err) < 0) {
-        goto error_intc_create;
+        cpu_remove_sync(CPU(cpu));
+        return;
     }
 
     if (!sc->pre_3_0_migration) {
         vmstate_register(NULL, cs->cpu_index, &vmstate_spapr_cpu_state,
                          cpu->machine_data);
     }
-
-    return;
-
-error_intc_create:
-    cpu_remove_sync(CPU(cpu));
-error:
-    error_propagate(errp, local_err);
 }
 
 static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *sc, int i, Error **errp)
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 24de4edfc6..92146a2119 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -743,7 +743,6 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
     BusState *bus;
     PCIHostState *phb = PCI_HOST_BRIDGE(dev);
     S390pciState *s = S390_PCI_HOST_BRIDGE(dev);
-    Error *local_err = NULL;
 
     DPRINTF("host_init\n");
 
@@ -767,8 +766,7 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
     QTAILQ_INIT(&s->zpci_devs);
 
     css_register_io_adapters(CSS_IO_ADAPTER_PCI, true, false,
-                             S390_ADAPTER_SUPPRESSIBLE, &local_err);
-    error_propagate(errp, local_err);
+                             S390_ADAPTER_SUPPRESSIBLE, errp);
 }
 
 static int s390_pci_msix_init(S390PCIBusDevice *pbdev)
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index f7a68343ef..877ea2af9d 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -69,20 +69,18 @@ static S390CPU *s390x_new_cpu(const char *typename, uint32_t core_id,
                               Error **errp)
 {
     S390CPU *cpu = S390_CPU(object_new(typename));
-    Error *err = NULL;
     S390CPU *ret = NULL;
 
-    if (!object_property_set_int(OBJECT(cpu), "core-id", core_id, &err)) {
+    if (!object_property_set_int(OBJECT(cpu), "core-id", core_id, errp)) {
         goto out;
     }
-    if (!qdev_realize(DEVICE(cpu), NULL, &err)) {
+    if (!qdev_realize(DEVICE(cpu), NULL, errp)) {
         goto out;
     }
     ret = cpu;
 
 out:
     object_unref(OBJECT(cpu));
-    error_propagate(errp, err);
     return ret;
 }
 
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 03364343eb..a0ce444b4b 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -329,7 +329,6 @@ static void sclp_realize(DeviceState *dev, Error **errp)
 {
     MachineState *machine = MACHINE(qdev_get_machine());
     SCLPDevice *sclp = SCLP(dev);
-    Error *err = NULL;
     uint64_t hw_limit;
     int ret;
 
@@ -338,20 +337,17 @@ static void sclp_realize(DeviceState *dev, Error **errp)
      * as we can't find a fitting bus via the qom tree, we have to add the
      * event facility to the sysbus, so e.g. a sclp console can be created.
      */
-    if (!sysbus_realize(SYS_BUS_DEVICE(sclp->event_facility), &err)) {
-        goto out;
+    if (!sysbus_realize(SYS_BUS_DEVICE(sclp->event_facility), errp)) {
+        return;
     }
 
     ret = s390_set_memory_limit(machine->maxram_size, &hw_limit);
     if (ret == -E2BIG) {
-        error_setg(&err, "host supports a maximum of %" PRIu64 " GB",
+        error_setg(errp, "host supports a maximum of %" PRIu64 " GB",
                    hw_limit / GiB);
     } else if (ret) {
-        error_setg(&err, "setting the guest size failed");
+        error_setg(errp, "setting the guest size failed");
     }
-
-out:
-    error_propagate(errp, err);
 }
 
 static void sclp_memory_init(SCLPDevice *sclp)
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index ba27afe9f2..b17bda3b29 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -723,15 +723,13 @@ static bool usb_get_attached(Object *obj, Error **errp)
 static void usb_set_attached(Object *obj, bool value, Error **errp)
 {
     USBDevice *dev = USB_DEVICE(obj);
-    Error *err = NULL;
 
     if (dev->attached == value) {
         return;
     }
 
     if (value) {
-        usb_device_attach(dev, &err);
-        error_propagate(errp, err);
+        usb_device_attach(dev, errp);
     } else {
         usb_device_detach(dev);
     }
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 4139dd2fe3..96e52a9e81 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -597,7 +597,6 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
     const char *driver, *path;
     DeviceState *dev = NULL;
     BusState *bus = NULL;
-    Error *err = NULL;
     bool hide;
 
     driver = qemu_opt_get(opts, "driver");
@@ -652,15 +651,13 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
     dev = qdev_new(driver);
 
     /* Check whether the hotplug is allowed by the machine */
-    if (qdev_hotplug && !qdev_hotplug_allowed(dev, &err)) {
-        /* Error must be set in the machine hook */
-        assert(err);
+    if (qdev_hotplug && !qdev_hotplug_allowed(dev, errp)) {
         goto err_del_dev;
     }
 
     if (!bus && qdev_hotplug && !qdev_get_machine_hotplug_handler(dev)) {
         /* No bus, no machine hotplug handler --> device is not hotpluggable */
-        error_setg(&err, "Device '%s' can not be hotplugged on this machine",
+        error_setg(errp, "Device '%s' can not be hotplugged on this machine",
                    driver);
         goto err_del_dev;
     }
@@ -668,19 +665,18 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
     qdev_set_id(dev, qemu_opts_id(opts));
 
     /* set properties */
-    if (qemu_opt_foreach(opts, set_property, dev, &err)) {
+    if (qemu_opt_foreach(opts, set_property, dev, errp)) {
         goto err_del_dev;
     }
 
     dev->opts = opts;
-    if (!qdev_realize(DEVICE(dev), bus, &err)) {
+    if (!qdev_realize(DEVICE(dev), bus, errp)) {
         dev->opts = NULL;
         goto err_del_dev;
     }
     return dev;
 
 err_del_dev:
-    error_propagate(errp, err);
     if (dev) {
         object_unparent(OBJECT(dev));
         object_unref(OBJECT(dev));
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index cdbeb59dcc..1a62a3a70d 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1552,13 +1552,12 @@ static int run_process_child(const char *command[], Error **errp)
 
 static bool systemd_supports_mode(SuspendMode mode, Error **errp)
 {
-    Error *local_err = NULL;
     const char *systemctl_args[3] = {"systemd-hibernate", "systemd-suspend",
                                      "systemd-hybrid-sleep"};
     const char *cmd[4] = {"systemctl", "status", systemctl_args[mode], NULL};
     int status;
 
-    status = run_process_child(cmd, &local_err);
+    status = run_process_child(cmd, errp);
 
     /*
      * systemctl status uses LSB return codes so we can expect
@@ -1572,7 +1571,6 @@ static bool systemd_supports_mode(SuspendMode mode, Error **errp)
         return true;
     }
 
-    error_propagate(errp, local_err);
     return false;
 }
 
diff --git a/qom/object.c b/qom/object.c
index 6b0d06c4fa..d6bba48e41 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -549,7 +549,6 @@ bool object_initialize_child_with_propsv(Object *parentobj,
                                          const char *type,
                                          Error **errp, va_list vargs)
 {
-    Error *local_err = NULL;
     bool ok = false;
     Object *obj;
     UserCreatable *uc;
@@ -565,7 +564,7 @@ bool object_initialize_child_with_propsv(Object *parentobj,
 
     uc = (UserCreatable *)object_dynamic_cast(obj, TYPE_USER_CREATABLE);
     if (uc) {
-        if (!user_creatable_complete(uc, &local_err)) {
+        if (!user_creatable_complete(uc, errp)) {
             object_unparent(obj);
             goto out;
         }
@@ -583,8 +582,6 @@ out:
      * the reference taken by object_property_add_child().
      */
     object_unref(obj);
-
-    error_propagate(errp, local_err);
     return ok;
 }
 
@@ -737,7 +734,6 @@ Object *object_new_with_propv(const char *typename,
 {
     Object *obj;
     ObjectClass *klass;
-    Error *local_err = NULL;
     UserCreatable *uc;
 
     klass = object_class_by_name(typename);
@@ -762,7 +758,7 @@ Object *object_new_with_propv(const char *typename,
 
     uc = (UserCreatable *)object_dynamic_cast(obj, TYPE_USER_CREATABLE);
     if (uc) {
-        if (!user_creatable_complete(uc, &local_err)) {
+        if (!user_creatable_complete(uc, errp)) {
             if (id != NULL) {
                 object_unparent(obj);
             }
@@ -774,7 +770,6 @@ Object *object_new_with_propv(const char *typename,
     return obj;
 
  error:
-    error_propagate(errp, local_err);
     object_unref(obj);
     return NULL;
 }
@@ -2312,36 +2307,34 @@ static void property_get_tm(Object *obj, Visitor *v, const char *name,
 
     prop->get(obj, &value, &err);
     if (err) {
-        goto out;
+        error_propagate(errp, err);
+        return;
     }
 
-    if (!visit_start_struct(v, name, NULL, 0, &err)) {
-        goto out;
+    if (!visit_start_struct(v, name, NULL, 0, errp)) {
+        return;
     }
-    if (!visit_type_int32(v, "tm_year", &value.tm_year, &err)) {
+    if (!visit_type_int32(v, "tm_year", &value.tm_year, errp)) {
         goto out_end;
     }
-    if (!visit_type_int32(v, "tm_mon", &value.tm_mon, &err)) {
+    if (!visit_type_int32(v, "tm_mon", &value.tm_mon, errp)) {
         goto out_end;
     }
-    if (!visit_type_int32(v, "tm_mday", &value.tm_mday, &err)) {
+    if (!visit_type_int32(v, "tm_mday", &value.tm_mday, errp)) {
         goto out_end;
     }
-    if (!visit_type_int32(v, "tm_hour", &value.tm_hour, &err)) {
+    if (!visit_type_int32(v, "tm_hour", &value.tm_hour, errp)) {
         goto out_end;
     }
-    if (!visit_type_int32(v, "tm_min", &value.tm_min, &err)) {
+    if (!visit_type_int32(v, "tm_min", &value.tm_min, errp)) {
         goto out_end;
     }
-    if (!visit_type_int32(v, "tm_sec", &value.tm_sec, &err)) {
+    if (!visit_type_int32(v, "tm_sec", &value.tm_sec, errp)) {
         goto out_end;
     }
-    visit_check_struct(v, &err);
+    visit_check_struct(v, errp);
 out_end:
     visit_end_struct(v, NULL);
-out:
-    error_propagate(errp, err);
-
 }
 
 static void property_release_tm(Object *obj, const char *name,
diff --git a/qom/qom-qobject.c b/qom/qom-qobject.c
index 62ac5e07ac..21ce22de94 100644
--- a/qom/qom-qobject.c
+++ b/qom/qom-qobject.c
@@ -34,15 +34,12 @@ QObject *object_property_get_qobject(Object *obj, const char *name,
                                      Error **errp)
 {
     QObject *ret = NULL;
-    Error *local_err = NULL;
     Visitor *v;
 
     v = qobject_output_visitor_new(&ret);
-    object_property_get(obj, name, v, &local_err);
-    if (!local_err) {
+    if (object_property_get(obj, name, v, errp)) {
         visit_complete(v, &ret);
     }
-    error_propagate(errp, local_err);
     visit_free(v);
     return ret;
 }
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6f27f12ec7..e46ab8f774 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5260,16 +5260,13 @@ static void x86_cpu_to_dict_full(X86CPU *cpu, QDict *props)
 static void object_apply_props(Object *obj, QDict *props, Error **errp)
 {
     const QDictEntry *prop;
-    Error *err = NULL;
 
     for (prop = qdict_first(props); prop; prop = qdict_next(props, prop)) {
         if (!object_property_set_qobject(obj, qdict_entry_key(prop),
-                                         qdict_entry_value(prop), &err)) {
+                                         qdict_entry_value(prop), errp)) {
             break;
         }
     }
-
-    error_propagate(errp, err);
 }
 
 /* Create X86CPU object according to model+props specification */
@@ -6327,19 +6324,18 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
     FeatureWord w;
     int i;
     GList *l;
-    Error *local_err = NULL;
 
     for (l = plus_features; l; l = l->next) {
         const char *prop = l->data;
-        if (!object_property_set_bool(OBJECT(cpu), prop, true, &local_err)) {
-            goto out;
+        if (!object_property_set_bool(OBJECT(cpu), prop, true, errp)) {
+            return;
         }
     }
 
     for (l = minus_features; l; l = l->next) {
         const char *prop = l->data;
-        if (!object_property_set_bool(OBJECT(cpu), prop, false, &local_err)) {
-            goto out;
+        if (!object_property_set_bool(OBJECT(cpu), prop, false, errp)) {
+            return;
         }
     }
 
@@ -6437,11 +6433,6 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
     if (env->cpuid_xlevel2 == UINT32_MAX) {
         env->cpuid_xlevel2 = env->cpuid_min_xlevel2;
     }
-
-out:
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
-    }
 }
 
 /*
-- 
2.26.2


