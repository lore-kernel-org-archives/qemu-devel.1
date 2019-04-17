Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8030DC282DD
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 11:34:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40E142054F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 11:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E142054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50912 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGipF-0002Hi-Gf
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 07:34:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGinR-0001Fu-Iz
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 07:32:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGinP-0001x4-K9
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 07:32:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hGinL-0001tg-TU; Wed, 17 Apr 2019 07:32:05 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F0EF537E85;
	Wed, 17 Apr 2019 11:32:02 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-141.ams2.redhat.com [10.36.117.141])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 569761001E66;
	Wed, 17 Apr 2019 11:31:55 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Apr 2019 13:31:42 +0200
Message-Id: <20190417113143.5551-2-david@redhat.com>
In-Reply-To: <20190417113143.5551-1-david@redhat.com>
References: <20190417113143.5551-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Wed, 17 Apr 2019 11:32:03 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 1/2] s390x/kvm: Configure page size after
 memory has actually been initialized
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>,
	David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com,
	Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190417113142.kUhI1NBX70GTHDto1GSY5vXExpy8lSdk7faSWek5RLU@z>

Right now we configure the pagesize quite early, when initializing KVM.
This is long before system memory is actually allocated via
memory_region_allocate_system_memory(), and therefore memory backends
marked as mapped.

Instead, let's configure the maximum page size after initializing
memory in s390_memory_init(). cap_hpage_1m is still properly
configured before creating any CPUs, and therefore before configuring
the CPU model and eventually enabling CMMA.

This is not a fix but rather a preparation for the future, when initial
memory might reside on memory backends (not the case for s390x right now)
We will replace qemu_getrampagesize() soon by a function that will always
return the maximum page size (not the minimum page size, which only
works by pure luck so far, as there are no memory backends).

Acked-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 12 ++++++++++++
 target/s390x/cpu.c         |  7 +++++++
 target/s390x/cpu.h         |  1 +
 target/s390x/kvm-stub.c    |  4 ++++
 target/s390x/kvm.c         | 35 ++++++++++++++---------------------
 target/s390x/kvm_s390x.h   |  1 +
 6 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index d11069b860..3be5679657 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -15,6 +15,7 @@
 #include "cpu.h"
 #include "hw/boards.h"
 #include "exec/address-spaces.h"
+#include "exec/ram_addr.h"
 #include "hw/s390x/s390-virtio-hcall.h"
 #include "hw/s390x/sclp.h"
 #include "hw/s390x/s390_flic.h"
@@ -163,6 +164,7 @@ static void s390_memory_init(ram_addr_t mem_size)
     MemoryRegion *sysmem =3D get_system_memory();
     ram_addr_t chunk, offset =3D 0;
     unsigned int number =3D 0;
+    Error *local_err =3D NULL;
     gchar *name;
=20
     /* allocate RAM for core */
@@ -182,6 +184,15 @@ static void s390_memory_init(ram_addr_t mem_size)
     }
     g_free(name);
=20
+    /*
+     * Configure the maximum page size. As no memory devices were create=
d
+     * yet, this is the page size of initial memory only.
+     */
+    s390_set_max_pagesize(qemu_getrampagesize(), &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        exit(EXIT_FAILURE);
+    }
     /* Initialize storage key device */
     s390_skeys_init();
     /* Initialize storage attributes device */
@@ -253,6 +264,7 @@ static void ccw_init(MachineState *machine)
     DeviceState *dev;
=20
     s390_sclp_init();
+    /* init memory + setup max page size. Required for the CPU model */
     s390_memory_init(machine->ram_size);
=20
     /* init CPUs (incl. CPU model) early so s390_has_feature() works */
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 698dd9cb82..b58ef0a8ef 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -399,6 +399,13 @@ int s390_set_memory_limit(uint64_t new_limit, uint64=
_t *hw_limit)
     return 0;
 }
=20
+void s390_set_max_pagesize(uint64_t pagesize, Error **errp)
+{
+    if (kvm_enabled()) {
+        kvm_s390_set_max_pagesize(pagesize, errp);
+    }
+}
+
 void s390_cmma_reset(void)
 {
     if (kvm_enabled()) {
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index cb6d77053a..c14be2b5ba 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -734,6 +734,7 @@ static inline void s390_do_cpu_load_normal(CPUState *=
cs, run_on_cpu_data arg)
 /* cpu.c */
 void s390_crypto_reset(void);
 int s390_set_memory_limit(uint64_t new_limit, uint64_t *hw_limit);
+void s390_set_max_pagesize(uint64_t pagesize, Error **errp);
 void s390_cmma_reset(void);
 void s390_enable_css_support(S390CPU *cpu);
 int s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch_id=
,
diff --git a/target/s390x/kvm-stub.c b/target/s390x/kvm-stub.c
index bf7795e47a..22b4514ca6 100644
--- a/target/s390x/kvm-stub.c
+++ b/target/s390x/kvm-stub.c
@@ -93,6 +93,10 @@ int kvm_s390_set_mem_limit(uint64_t new_limit, uint64_=
t *hw_limit)
     return 0;
 }
=20
+void kvm_s390_set_max_pagesize(uint64_t pagesize, Error **errp)
+{
+}
+
 void kvm_s390_crypto_reset(void)
 {
 }
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 19530fb94e..bee73dc1a4 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -283,44 +283,37 @@ void kvm_s390_crypto_reset(void)
     }
 }
=20
-static int kvm_s390_configure_mempath_backing(KVMState *s)
+void kvm_s390_set_max_pagesize(uint64_t pagesize, Error **errp)
 {
-    size_t path_psize =3D qemu_getrampagesize();
-
-    if (path_psize =3D=3D 4 * KiB) {
-        return 0;
+    if (pagesize =3D=3D 4 * KiB) {
+        return;
     }
=20
     if (!hpage_1m_allowed()) {
-        error_report("This QEMU machine does not support huge page "
-                     "mappings");
-        return -EINVAL;
+        error_setg(errp, "This QEMU machine does not support huge page "
+                   "mappings");
+        return;
     }
=20
-    if (path_psize !=3D 1 * MiB) {
-        error_report("Memory backing with 2G pages was specified, "
-                     "but KVM does not support this memory backing");
-        return -EINVAL;
+    if (pagesize !=3D 1 * MiB) {
+        error_setg(errp, "Memory backing with 2G pages was specified, "
+                   "but KVM does not support this memory backing");
+        return;
     }
=20
-    if (kvm_vm_enable_cap(s, KVM_CAP_S390_HPAGE_1M, 0)) {
-        error_report("Memory backing with 1M pages was specified, "
-                     "but KVM does not support this memory backing");
-        return -EINVAL;
+    if (kvm_vm_enable_cap(kvm_state, KVM_CAP_S390_HPAGE_1M, 0)) {
+        error_setg(errp, "Memory backing with 1M pages was specified, "
+                   "but KVM does not support this memory backing");
+        return;
     }
=20
     cap_hpage_1m =3D 1;
-    return 0;
 }
=20
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     MachineClass *mc =3D MACHINE_GET_CLASS(ms);
=20
-    if (kvm_s390_configure_mempath_backing(s)) {
-        return -EINVAL;
-    }
-
     mc->default_cpu_type =3D S390_CPU_TYPE_NAME("host");
     cap_sync_regs =3D kvm_check_extension(s, KVM_CAP_SYNC_REGS);
     cap_async_pf =3D kvm_check_extension(s, KVM_CAP_ASYNC_PF);
diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
index 6e52287da3..caf985955b 100644
--- a/target/s390x/kvm_s390x.h
+++ b/target/s390x/kvm_s390x.h
@@ -36,6 +36,7 @@ int kvm_s390_cmma_active(void);
 void kvm_s390_cmma_reset(void);
 void kvm_s390_reset_vcpu(S390CPU *cpu);
 int kvm_s390_set_mem_limit(uint64_t new_limit, uint64_t *hw_limit);
+void kvm_s390_set_max_pagesize(uint64_t pagesize, Error **errp);
 void kvm_s390_crypto_reset(void);
 void kvm_s390_restart_interrupt(S390CPU *cpu);
 void kvm_s390_stop_interrupt(S390CPU *cpu);
--=20
2.20.1


