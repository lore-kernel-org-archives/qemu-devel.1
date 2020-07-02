Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DDCC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:20:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7C4620720
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vvpkw4I8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C4620720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr1xC-0003yg-46
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 12:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jr1YD-0008CU-5M
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:55:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56847
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jr1Y9-0006Sg-Gm
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593705288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WngLkthvvchIhhbnvRTy0ZsyXq7NMrEVu7iL+15sq5E=;
 b=Vvpkw4I8NofjGBHdoazJGGPdINOgDHLHPBXX3OGn1mjnjyNbYTtV17MotZz+FQA7mBnKJS
 n1MqNzOHdEfPwg0fprosZQg6lbUsrNKvydnjUaTnPJMCnUBcpZ3EJa7kM90wfIdVUusf8+
 jwcjwNQhALF4fhP1Si954AvAsbFaZRc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-lalNHKEZPy6Wgz_z3n3rbw-1; Thu, 02 Jul 2020 11:54:47 -0400
X-MC-Unique: lalNHKEZPy6Wgz_z3n3rbw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5EBB1937FE5;
 Thu,  2 Jul 2020 15:54:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B1FE9121E24;
 Thu,  2 Jul 2020 15:54:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 54EE41138648; Thu,  2 Jul 2020 17:54:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 00/44] Less clumsy error checking
References: <20200702155000.3455325-1-armbru@redhat.com>
Date: Thu, 02 Jul 2020 17:54:37 +0200
In-Reply-To: <20200702155000.3455325-1-armbru@redhat.com> (Markus Armbruster's
 message of "Thu, 2 Jul 2020 17:49:16 +0200")
Message-ID: <871rlt6hfm.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:23:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 ehabkost@redhat.com, qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

diff -w between v1 rebased and v2, with:

diff --git a/include/qapi/error.h b/include/qapi/error.h
index c3d84d610a..5ceb3ace06 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -145,10 +145,10 @@
  * Likewise, do *not*
  *     Error *err = NULL;
  *     if (cond1) {
- *         error_setg(err, ...);
+ *         error_setg(&err, ...);
  *     }
  *     if (cond2) {
- *         error_setg(err, ...); // WRONG!
+ *         error_setg(&err, ...); // WRONG!
  *     }
  * because this may pass a non-null err to error_setg().
  */
diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index 7d1b8d579c..ebc19ede7f 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -284,7 +284,7 @@ void visit_free(Visitor *v);
  * On failure, set *@obj to NULL and store an error through @errp.
  * Can happen only when @v is an input visitor.
  *
- * Return true on succes, false on failure.
+ * Return true on success, false on failure.
  *
  * After visit_start_struct() succeeds, the caller may visit its
  * members one after the other, passing the member's name and address
@@ -304,7 +304,7 @@ bool visit_start_struct(Visitor *v, const char *name, void **obj,
  * On failure, store an error through @errp.  Can happen only when @v
  * is an input visitor.
  *
- * Return true on succes, false on failure.
+ * Return true on success, false on failure.
  *
  * Should be called prior to visit_end_struct() if all other
  * intermediate visit steps were successful, to allow the visitor one
@@ -343,7 +343,7 @@ void visit_end_struct(Visitor *v, void **obj);
  * On failure, set *@list to NULL and store an error through @errp.
  * Can happen only when @v is an input visitor.
  *
- * Return true on succes, false on failure.
+ * Return true on success, false on failure.
  *
  * After visit_start_list() succeeds, the caller may visit its members
  * one after the other.  A real visit (where @list is non-NULL) uses
@@ -380,7 +380,7 @@ GenericList *visit_next_list(Visitor *v, GenericList *tail, size_t size);
  * On failure, store an error through @errp.  Can happen only when @v
  * is an input visitor.
  *
- * Return true on succes, false on failure.
+ * Return true on success, false on failure.
  *
  * Should be called prior to visit_end_list() if all other
  * intermediate visit steps were successful, to allow the visitor one
@@ -418,7 +418,7 @@ void visit_end_list(Visitor *v, void **list);
  * On failure, set *@obj to NULL and store an error through @errp.
  * Can happen only when @v is an input visitor.
  *
- * Return true on succes, false on failure.
+ * Return true on success, false on failure.
  *
  * If successful, this must be paired with visit_end_alternate() with
  * the same @obj to clean up, even if visiting the contents of the
@@ -476,7 +476,7 @@ bool visit_optional(Visitor *v, const char *name, bool *present);
  * On failure, store an error through @errp.  Can happen only when @v
  * is an input visitor.
  *
- * Return true on succes, false on failure.
+ * Return true on success, false on failure.
  *
  * May call visit_type_str() under the hood, and the enum visit may
  * fail even if the corresponding string visit succeeded; this implies
@@ -510,7 +510,7 @@ bool visit_is_dealloc(Visitor *v);
  * On failure, store an error through @errp.  Can happen only when @v
  * is an input visitor.
  *
- * Return true on succes, false on failure.
+ * Return true on success, false on failure.
  */
 bool visit_type_int(Visitor *v, const char *name, int64_t *obj, Error **errp);
 
@@ -591,7 +591,7 @@ bool visit_type_size(Visitor *v, const char *name, uint64_t *obj,
  * On failure, store an error through @errp.  Can happen only when @v
  * is an input visitor.
  *
- * Return true on succes, false on failure.
+ * Return true on success, false on failure.
  */
 bool visit_type_bool(Visitor *v, const char *name, bool *obj, Error **errp);
 
@@ -612,7 +612,7 @@ bool visit_type_bool(Visitor *v, const char *name, bool *obj, Error **errp);
  * On failure, set *@obj to NULL and store an error through @errp.
  * Can happen only when @v is an input visitor.
  *
- * Return true on succes, false on failure.
+ * Return true on success, false on failure.
  *
  * FIXME: Callers that try to output NULL *obj should not be allowed.
  */
@@ -631,7 +631,7 @@ bool visit_type_str(Visitor *v, const char *name, char **obj, Error **errp);
  * On failure, store an error through @errp.  Can happen only when @v
  * is an input visitor.
  *
- * Return true on succes, false on failure.
+ * Return true on success, false on failure.
  */
 bool visit_type_number(Visitor *v, const char *name, double *obj,
                        Error **errp);
@@ -649,7 +649,7 @@ bool visit_type_number(Visitor *v, const char *name, double *obj,
  * On failure, set *@obj to NULL and store an error through @errp.
  * Can happen only when @v is an input visitor.
  *
- * Return true on succes, false on failure.
+ * Return true on success, false on failure.
  *
  * Note that some kinds of input can't express arbitrary QObject.
  * E.g. the visitor returned by qobject_input_visitor_new_keyval()
@@ -669,7 +669,7 @@ bool visit_type_any(Visitor *v, const char *name, QObject **obj, Error **errp);
  * On failure, set *@obj to NULL and store an error through @errp.
  * Can happen only when @v is an input visitor.
  *
- * Return true on succes, false on failure.
+ * Return true on success, false on failure.
  */
 bool visit_type_null(Visitor *v, const char *name, QNull **obj,
                      Error **errp);
diff --git a/block/vxhs.c b/block/vxhs.c
index ef2848fb60..dc0e254730 100644
--- a/block/vxhs.c
+++ b/block/vxhs.c
@@ -300,6 +300,7 @@ static int vxhs_open(BlockDriverState *bs, QDict *options,
     QemuOpts *opts = NULL;
     QemuOpts *tcp_opts = NULL;
     char *of_vsa_addr = NULL;
+    Error *local_err = NULL;
     const char *vdisk_id_opt;
     const char *server_host_opt;
     int ret = 0;
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
diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
index b700ff45fe..5037ca265e 100644
--- a/hw/core/platform-bus.c
+++ b/hw/core/platform-bus.c
@@ -66,7 +66,6 @@ hwaddr platform_bus_get_mmio_addr(PlatformBusDevice *pbus, SysBusDevice *sbdev,
 
     parent_mr = object_property_get_link(OBJECT(sbdev_mr), "container",
                                          &error_abort);
-    assert(parent_mr);
     if (parent_mr != pbus_mr_obj) {
         /* MMIO region is not mapped on platform bus */
         return -1;
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 81903d2711..67bee1bcb8 100644
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
     qdev_realize(DEVICE(cpu), NULL, errp);
 
 out:
     object_unref(cpu);
-    error_propagate(errp, local_err);
 }
 
 void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index 87bc4aeca1..46835ed085 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -91,7 +91,6 @@ static void vm_change_state_handler(void *opaque, int running,
 static void kvm_arm_its_realize(DeviceState *dev, Error **errp)
 {
     GICv3ITSState *s = ARM_GICV3_ITS_COMMON(dev);
-    Error *local_err = NULL;
 
     s->dev_fd = kvm_create_device(kvm_state, KVM_DEV_TYPE_ARM_VGIC_ITS, false);
     if (s->dev_fd < 0) {
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 6705220380..68bb1914b9 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -309,7 +309,6 @@ int ics_set_kvm_state(ICSState *ics, Error **errp)
     }
 
     for (i = 0; i < ics->nr_irqs; i++) {
-        Error *local_err = NULL;
         int ret;
 
         if (ics_irq_free(ics, i)) {
diff --git a/hw/ppc/spapr_pci_nvlink2.c b/hw/ppc/spapr_pci_nvlink2.c
index e4e09a93e6..dd8cd6db96 100644
--- a/hw/ppc/spapr_pci_nvlink2.c
+++ b/hw/ppc/spapr_pci_nvlink2.c
@@ -141,10 +141,9 @@ static void spapr_phb_pci_collect_nvgpu(PCIBus *bus, PCIDevice *pdev,
     if (tgt) {
         Error *local_err = NULL;
         SpaprPhbPciNvGpuConfig *nvgpus = opaque;
-        Object *mr_gpu = object_property_get_link(po, "nvlink2-mr[0]",
-                                                  &error_abort);
+        Object *mr_gpu = object_property_get_link(po, "nvlink2-mr[0]", NULL);
         Object *mr_npu = object_property_get_link(po, "nvlink2-atsd-mr[0]",
-                                                  &error_abort);
+                                                  NULL);
 
         g_assert(mr_gpu || mr_npu);
         if (mr_gpu) {
diff --git a/net/tap.c b/net/tap.c
index ca48f2a285..f9dcc2ef51 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -790,9 +790,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
             return -1;
         }
 
-        fd = monitor_fd_param(cur_mon, tap->fd, &err);
+        fd = monitor_fd_param(cur_mon, tap->fd, errp);
         if (fd == -1) {
-            error_propagate(errp, err);
             return -1;
         }
 
@@ -837,9 +836,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
         }
 
         for (i = 0; i < nfds; i++) {
-            fd = monitor_fd_param(cur_mon, fds[i], &err);
+            fd = monitor_fd_param(cur_mon, fds[i], errp);
             if (fd == -1) {
-                error_propagate(errp, err);
                 ret = -1;
                 goto free_fail;
             }
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index b186ddb4aa..aaa71f147b 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -278,8 +278,6 @@ out:
 static void execute_async(DWORD WINAPI (*func)(LPVOID), LPVOID opaque,
                           Error **errp)
 {
-    Error *local_err = NULL;
-
     HANDLE thread = CreateThread(NULL, 0, func, opaque, 0, NULL);
     if (!thread) {
         error_setg(errp, QERR_QGA_COMMAND_FAILED,
@@ -1269,7 +1267,6 @@ typedef enum {
 static void check_suspend_mode(GuestSuspendMode mode, Error **errp)
 {
     SYSTEM_POWER_CAPABILITIES sys_pwr_caps;
-    Error *local_err = NULL;
 
     ZeroMemory(&sys_pwr_caps, sizeof(sys_pwr_caps));
     if (!GetPwrCapabilities(&sys_pwr_caps)) {
diff --git a/qom/object.c b/qom/object.c
index 9b479621e4..8d698abf4d 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -528,7 +528,8 @@ void object_initialize(void *data, size_t size, const char *typename)
 
 bool object_initialize_child_with_props(Object *parentobj,
                                         const char *propname,
-                             void *childobj, size_t size, const char *type,
+                                        void *childobj, size_t size,
+                                        const char *type,
                                         Error **errp, ...)
 {
     va_list vargs;
@@ -544,7 +545,8 @@ bool object_initialize_child_with_props(Object *parentobj,
 
 bool object_initialize_child_with_propsv(Object *parentobj,
                                          const char *propname,
-                              void *childobj, size_t size, const char *type,
+                                         void *childobj, size_t size,
+                                         const char *type,
                                          Error **errp, va_list vargs)
 {
     bool ok = false;
diff --git a/util/qemu-option.c b/util/qemu-option.c
index da74a239e9..c5a9d49b46 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -281,7 +281,6 @@ static void qemu_opt_del_all(QemuOpts *opts, const char *name)
 const char *qemu_opt_get(QemuOpts *opts, const char *name)
 {
     QemuOpt *opt;
-    const char *def_val;
 
     if (opts == NULL) {
         return NULL;
@@ -289,9 +288,9 @@ const char *qemu_opt_get(QemuOpts *opts, const char *name)
 
     opt = qemu_opt_find(opts, name);
     if (!opt) {
-        def_val = find_default_by_name(opts, name);
-        return def_val;
+        return find_default_by_name(opts, name);
     }
+
     return opt->str;
 }
 
@@ -321,7 +320,6 @@ const char *qemu_opt_iter_next(QemuOptsIter *iter)
 char *qemu_opt_get_del(QemuOpts *opts, const char *name)
 {
     QemuOpt *opt;
-    const char *def_val;
     char *str;
 
     if (opts == NULL) {
@@ -330,8 +328,7 @@ char *qemu_opt_get_del(QemuOpts *opts, const char *name)
 
     opt = qemu_opt_find(opts, name);
     if (!opt) {
-        def_val = find_default_by_name(opts, name);
-        return g_strdup(def_val);
+        return g_strdup(find_default_by_name(opts, name));
     }
     str = opt->str;
     opt->str = NULL;
@@ -523,13 +520,13 @@ static QemuOpt *opt_create(QemuOpts *opts, const char *name, char *value,
     return opt;
 }
 
-static bool opt_set(QemuOpts *opts, QemuOpt *opt, bool *help_wanted,
+static bool opt_validate(QemuOpt *opt, bool *help_wanted,
                          Error **errp)
 {
     const QemuOptDesc *desc;
 
-    desc = find_desc_by_name(opts->list->desc, opt->name);
-    if (!desc && !opts_accepts_any(opts)) {
+    desc = find_desc_by_name(opt->opts->list->desc, opt->name);
+    if (!desc && !opts_accepts_any(opt->opts)) {
         error_setg(errp, QERR_INVALID_PARAMETER, opt->name);
         if (help_wanted && is_help_option(opt->name)) {
             *help_wanted = true;
@@ -550,7 +547,7 @@ bool qemu_opt_set(QemuOpts *opts, const char *name, const char *value,
 {
     QemuOpt *opt = opt_create(opts, name, g_strdup(value), false);
 
-    if (!opt_set(opts, opt, NULL, errp)) {
+    if (!opt_validate(opt, NULL, errp)) {
         qemu_opt_del(opt);
         return false;
     }
@@ -844,7 +841,7 @@ static bool opts_do_parse(QemuOpts *opts, const char *params,
 
         opt = opt_create(opts, option, value, prepend);
         g_free(option);
-        if (!opt_set(opts, opt, help_wanted, errp)) {
+        if (!opt_validate(opt, help_wanted, errp)) {
             qemu_opt_del(opt);
             return false;
         }


