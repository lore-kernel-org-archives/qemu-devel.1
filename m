Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37C0C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 09:27:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CEC1206B8
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 09:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i1xElfed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CEC1206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKIbn-0006Dp-Ov
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 05:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57035)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jKIae-0004uA-U3
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 05:26:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jKIad-00073G-3y
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 05:26:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59390
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jKIab-0006xW-55
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 05:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585905972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EQ26Zm0S5mxnnM71PIpJvjjpyIZUPvjOv85mJSuKM4M=;
 b=i1xElfed7PxGzENCs/fwr+wa48SFZDtwVeonsV/EVW8AoTm33S8H/kLGAhG19CGMgqWakf
 hK5u0efYYCyaPHFCxbSziyD0eeJwsgF0x3lmsWLiqw8LZKPGhO75cbtmr921qKiXl7MpM9
 gJINs4O7Es9w/vJlPSa/aluzSbh3+G0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-BPy0ZkQXNTqu535pOA8tUQ-1; Fri, 03 Apr 2020 05:26:10 -0400
X-MC-Unique: BPy0ZkQXNTqu535pOA8tUQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D269149C6;
 Fri,  3 Apr 2020 09:26:09 +0000 (UTC)
Received: from localhost (ovpn-113-80.ams2.redhat.com [10.36.113.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DB2E92FAD;
 Fri,  3 Apr 2020 09:26:06 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL for-5.0 2/2] vl/s390x: fixup ram sizes for compat machines
Date: Fri,  3 Apr 2020 11:25:53 +0200
Message-Id: <20200403092553.25803-3-cohuck@redhat.com>
In-Reply-To: <20200403092553.25803-1-cohuck@redhat.com>
References: <20200403092553.25803-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

Older QEMU versions did fixup the ram size to match what can be reported
via sclp. We need to mimic this behaviour for machine types 4.2 and
older to not fail on inbound migration for memory sizes that do not fit.
Old machines with proper aligned memory sizes are not affected.

Alignment table:
 VM size (<=3D) | Alignment
--------------------------
      1020M   |     1M
      2040M   |     2M
      4080M   |     4M
      8160M   |     8M
     16320M   |    16M
     32640M   |    32M
     65280M   |    64M
    130560M   |   128M
    261120M   |   256M
    522240M   |   512M
   1044480M   |     1G
   2088960M   |     2G
   4177920M   |     4G
   8355840M   |     8G

Suggested action is to replace unaligned -m value with a suitable
aligned one or if a change to a newer machine type is possible, use a
machine version >=3D 5.0.

A future version might remove the compatibility handling.

For machine types >=3D 5.0 we can simply use an increment size of 1M and
use the full range of increment number which allows for all possible
memory sizes. The old limitation of having a maximum of 1020 increments
was added for standby memory, which we no longer support. With that we
can now support even weird memory sizes like 10001234 MB.

As we no longer fixup maxram_size as well, make other users use ram_size
instead. Keep using maxram_size when setting the maximum ram size in KVM,
as that will come in handy in the future when supporting memory hotplug
(in contrast, storage keys and storage attributes for hotplugged memory
will have to be migrated per RAM block in the future).

Fixes: 3a12fc61af5c ("390x/s390-virtio-ccw: use memdev for RAM")
Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20200401123754.109602-1-borntraeger@de.ibm.com>
[CH: fixed up message on memory size fixup]
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-skeys.c        |  2 +-
 hw/s390x/s390-stattrib-kvm.c |  4 ++--
 hw/s390x/s390-virtio-ccw.c   | 22 ++++++++++++++++++++++
 hw/s390x/sclp.c              | 17 +++++------------
 include/hw/boards.h          |  7 +++++++
 softmmu/vl.c                 |  3 +++
 6 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index 5da6e5292fae..a9a4ae7b3990 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -176,7 +176,7 @@ static void qemu_s390_skeys_init(Object *obj)
     QEMUS390SKeysState *skeys =3D QEMU_S390_SKEYS(obj);
     MachineState *machine =3D MACHINE(qdev_get_machine());
=20
-    skeys->key_count =3D machine->maxram_size / TARGET_PAGE_SIZE;
+    skeys->key_count =3D machine->ram_size / TARGET_PAGE_SIZE;
     skeys->keydata =3D g_malloc0(skeys->key_count);
 }
=20
diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
index c7e1f35524bc..f89d8d9d1698 100644
--- a/hw/s390x/s390-stattrib-kvm.c
+++ b/hw/s390x/s390-stattrib-kvm.c
@@ -85,7 +85,7 @@ static int kvm_s390_stattrib_set_stattr(S390StAttribState=
 *sa,
 {
     KVMS390StAttribState *sas =3D KVM_S390_STATTRIB(sa);
     MachineState *machine =3D MACHINE(qdev_get_machine());
-    unsigned long max =3D machine->maxram_size / TARGET_PAGE_SIZE;
+    unsigned long max =3D machine->ram_size / TARGET_PAGE_SIZE;
=20
     if (start_gfn + count > max) {
         error_report("Out of memory bounds when setting storage attributes=
");
@@ -104,7 +104,7 @@ static void kvm_s390_stattrib_synchronize(S390StAttribS=
tate *sa)
 {
     KVMS390StAttribState *sas =3D KVM_S390_STATTRIB(sa);
     MachineState *machine =3D MACHINE(qdev_get_machine());
-    unsigned long max =3D machine->maxram_size / TARGET_PAGE_SIZE;
+    unsigned long max =3D machine->ram_size / TARGET_PAGE_SIZE;
     /* We do not need to reach the maximum buffer size allowed */
     unsigned long cx, len =3D KVM_S390_SKEYS_MAX / 2;
     int r;
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 895498cca619..0fa00a9fff3d 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -26,6 +26,7 @@
 #include "qemu/ctype.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
+#include "qemu/qemu-print.h"
 #include "s390-pci-bus.h"
 #include "sysemu/reset.h"
 #include "hw/s390x/storage-keys.h"
@@ -439,6 +440,26 @@ static void s390_nmi(NMIState *n, int cpu_index, Error=
 **errp)
     s390_cpu_restart(S390_CPU(cs));
 }
=20
+static ram_addr_t s390_fixup_ram_size(ram_addr_t sz)
+{
+    /* same logic as in sclp.c */
+    int increment_size =3D 20;
+    ram_addr_t newsz;
+
+    while ((sz >> increment_size) > MAX_STORAGE_INCREMENTS) {
+        increment_size++;
+    }
+    newsz =3D sz >> increment_size << increment_size;
+
+    if (sz !=3D newsz) {
+        qemu_printf("Ram size %" PRIu64 "MB was fixed up to %" PRIu64
+                    "MB to match machine restrictions. Consider updating "
+                    "the guest definition.\n", (uint64_t) (sz / MiB),
+                    (uint64_t) (newsz / MiB));
+    }
+    return newsz;
+}
+
 static void ccw_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
@@ -668,6 +689,7 @@ static void ccw_machine_4_2_instance_options(MachineSta=
te *machine)
 static void ccw_machine_4_2_class_options(MachineClass *mc)
 {
     ccw_machine_5_0_class_options(mc);
+    mc->fixup_ram_size =3D s390_fixup_ram_size;
     compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
 }
 DEFINE_CCW_MACHINE(4_2, "4.2", false);
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index af0bfbc2eca7..f0c35aa57afd 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -327,27 +327,20 @@ out:
 static void sclp_memory_init(SCLPDevice *sclp)
 {
     MachineState *machine =3D MACHINE(qdev_get_machine());
+    MachineClass *machine_class =3D MACHINE_GET_CLASS(qdev_get_machine());
     ram_addr_t initial_mem =3D machine->ram_size;
     int increment_size =3D 20;
=20
     /* The storage increment size is a multiple of 1M and is a power of 2.
-     * The number of storage increments must be MAX_STORAGE_INCREMENTS or =
fewer.
+     * For some machine types, the number of storage increments must be
+     * MAX_STORAGE_INCREMENTS or fewer.
      * The variable 'increment_size' is an exponent of 2 that can be
      * used to calculate the size (in bytes) of an increment. */
-    while ((initial_mem >> increment_size) > MAX_STORAGE_INCREMENTS) {
+    while (machine_class->fixup_ram_size !=3D NULL &&
+           (initial_mem >> increment_size) > MAX_STORAGE_INCREMENTS) {
         increment_size++;
     }
     sclp->increment_size =3D increment_size;
-
-    /* The core memory area needs to be aligned with the increment size.
-     * In effect, this can cause the user-specified memory size to be roun=
ded
-     * down to align with the nearest increment boundary. */
-    initial_mem =3D initial_mem >> increment_size << increment_size;
-
-    machine->ram_size =3D initial_mem;
-    machine->maxram_size =3D initial_mem;
-    /* let's propagate the changed ram size into the global variable. */
-    ram_size =3D initial_mem;
 }
=20
 static void sclp_init(Object *obj)
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 236d239c19e8..fd4d62b5010f 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -152,6 +152,12 @@ typedef struct {
  *    It also will be used as a way to optin into "-m" option support.
  *    If it's not set by board, '-m' will be ignored and generic code will
  *    not create default RAM MemoryRegion.
+ * @fixup_ram_size:
+ *    Amends user provided ram size (with -m option) using machine
+ *    specific algorithm. To be used by old machine types for compat
+ *    purposes only.
+ *    Applies only to default memory backend, i.e., explicit memory backen=
d
+ *    wasn't used.
  */
 struct MachineClass {
     /*< private >*/
@@ -218,6 +224,7 @@ struct MachineClass {
                                                          unsigned cpu_inde=
x);
     const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
     int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
+    ram_addr_t (*fixup_ram_size)(ram_addr_t size);
 };
=20
 /**
diff --git a/softmmu/vl.c b/softmmu/vl.c
index a331fb532112..a0c1a879ce60 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2600,6 +2600,9 @@ static bool set_memory_options(uint64_t *ram_slots, r=
am_addr_t *maxram_size,
     }
=20
     sz =3D QEMU_ALIGN_UP(sz, 8192);
+    if (mc->fixup_ram_size) {
+        sz =3D mc->fixup_ram_size(sz);
+    }
     ram_size =3D sz;
     if (ram_size !=3D sz) {
         error_report("ram size too large");
--=20
2.21.1


