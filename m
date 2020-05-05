Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72B8C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:43:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C8A4206B9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fOxE69ty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8A4206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVziy-0002nD-HN
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 11:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jVzVw-0003Wy-64
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:29:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41503
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jVzVn-0007R5-9W
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588692572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4w7IrnCXfuJRpn2Pwo4QWstitbRFNDkUmnPTKONht1E=;
 b=fOxE69tyC0+dbwNRneZv0kA9SrBlnsWOzbp998J3k4q+T7uHxKtjwR/e4JNixD4f0JGk3q
 O8/1Z+agtCYuivli9TK0QAgHHPexCRtWCNMdME5q3iuwvYcxoCXB6z/+JTx/sQk6eDvqId
 r0mRvlz8Lk0o34KzbuA7eiuR1cNejzM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-x42_PInpN6KRsYeJsEA54Q-1; Tue, 05 May 2020 11:29:30 -0400
X-MC-Unique: x42_PInpN6KRsYeJsEA54Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4600461
 for <qemu-devel@nongnu.org>; Tue,  5 May 2020 15:29:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 288CA165F6;
 Tue,  5 May 2020 15:29:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 44E9411358C3; Tue,  5 May 2020 17:29:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/18] qom: Drop object_property_set_description()
 parameter @errp
Date: Tue,  5 May 2020 17:29:15 +0200
Message-Id: <20200505152926.18877-8-armbru@redhat.com>
In-Reply-To: <20200505152926.18877-1-armbru@redhat.com>
References: <20200505152926.18877-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 03:48:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

object_property_set_description() and
object_class_property_set_description() fail only when property @name
is not found.

There are 85 calls of object_property_set_description() and
object_class_property_set_description().  None of them can fail:

* 84 immediately follow the creation of the property.

* The one in spapr_rng_instance_init() refers to a property created in
  spapr_rng_class_init(), from spapr_rng_properties[].

Every one of them still gets to decide what to pass for @errp.

51 calls pass &error_abort, 32 calls pass NULL, one receives the error
and propagates it to &error_abort, and one propagates it to
&error_fatal.  I'm actually surprised none of them violates the Error
API.

What are we gaining by letting callers handle the "property not found"
error?  Use when the property is not known to exist is simpler: you
don't have to guard the call with a check.  We haven't found such a
use in 5+ years.  Until we do, let's make life a bit simpler and drop
the @errp parameter.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qom/object.h       |  6 ++----
 accel/kvm/kvm-all.c        |  4 ++--
 accel/tcg/tcg-all.c        |  2 +-
 backends/hostmem-memfd.c   |  9 +++------
 backends/hostmem.c         | 16 +++++++--------
 hw/arm/aspeed.c            |  2 +-
 hw/arm/vexpress.c          |  6 ++----
 hw/arm/virt.c              | 20 +++++++------------
 hw/arm/xlnx-zcu102.c       |  6 ++----
 hw/core/machine.c          | 41 ++++++++++++++++++--------------------
 hw/core/qdev.c             |  6 ++----
 hw/i386/microvm.c          | 14 ++++++-------
 hw/i386/pc.c               |  2 +-
 hw/i386/x86.c              |  6 +++---
 hw/ppc/mac_newworld.c      |  3 +--
 hw/ppc/pnv.c               |  3 +--
 hw/ppc/spapr.c             | 21 ++++++++-----------
 hw/ppc/spapr_caps.c        |  6 +-----
 hw/ppc/spapr_rng.c         |  3 +--
 hw/riscv/sifive_u.c        |  5 ++---
 hw/s390x/css-bridge.c      |  3 +--
 hw/s390x/s390-virtio-ccw.c |  9 +++------
 hw/sparc/sun4m.c           |  3 +--
 hw/xen/xen-common.c        |  2 +-
 qom/object.c               | 19 ++++--------------
 target/arm/cpu64.c         |  3 +--
 target/arm/kvm.c           |  2 +-
 target/i386/sev.c          |  6 +++---
 target/ppc/compat.c        |  2 +-
 target/s390x/cpu_models.c  |  4 ++--
 30 files changed, 91 insertions(+), 143 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 0ea5808432..1f0386a231 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1813,16 +1813,14 @@ ObjectProperty *object_property_add_const_link(Obje=
ct *obj, const char *name,
  * @obj: the object owning the property
  * @name: the name of the property
  * @description: the description of the property on the object
- * @errp: if an error occurs, a pointer to an area to store the error
  *
  * Set an object property's description.
  *
  */
 void object_property_set_description(Object *obj, const char *name,
-                                     const char *description, Error **errp=
);
+                                     const char *description);
 void object_class_property_set_description(ObjectClass *klass, const char =
*name,
-                                           const char *description,
-                                           Error **errp);
+                                           const char *description);
=20
 /**
  * object_child_foreach:
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 439a4efe52..2fb6099cf2 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3077,13 +3077,13 @@ static void kvm_accel_class_init(ObjectClass *oc, v=
oid *data)
         NULL, kvm_set_kernel_irqchip,
         NULL, NULL, &error_abort);
     object_class_property_set_description(oc, "kernel-irqchip",
-        "Configure KVM in-kernel irqchip", &error_abort);
+        "Configure KVM in-kernel irqchip");
=20
     object_class_property_add(oc, "kvm-shadow-mem", "int",
         kvm_get_kvm_shadow_mem, kvm_set_kvm_shadow_mem,
         NULL, NULL, &error_abort);
     object_class_property_set_description(oc, "kvm-shadow-mem",
-        "KVM shadow MMU size", &error_abort);
+        "KVM shadow MMU size");
 }
=20
 static const TypeInfo kvm_accel_type =3D {
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index acfdcfdf59..3398a56ef9 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -210,7 +210,7 @@ static void tcg_accel_class_init(ObjectClass *oc, void =
*data)
         tcg_get_tb_size, tcg_set_tb_size,
         NULL, NULL, &error_abort);
     object_class_property_set_description(oc, "tb-size",
-        "TCG translation block cache size", &error_abort);
+        "TCG translation block cache size");
=20
 }
=20
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 74ba9879c4..5991f31459 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -144,23 +144,20 @@ memfd_backend_class_init(ObjectClass *oc, void *data)
                                        memfd_backend_set_hugetlb,
                                        &error_abort);
         object_class_property_set_description(oc, "hugetlb",
-                                              "Use huge pages",
-                                              &error_abort);
+                                              "Use huge pages");
         object_class_property_add(oc, "hugetlbsize", "int",
                                   memfd_backend_get_hugetlbsize,
                                   memfd_backend_set_hugetlbsize,
                                   NULL, NULL, &error_abort);
         object_class_property_set_description(oc, "hugetlbsize",
-                                              "Huge pages size (ex: 2M, 1G=
)",
-                                              &error_abort);
+                                              "Huge pages size (ex: 2M, 1G=
)");
     }
     object_class_property_add_bool(oc, "seal",
                                    memfd_backend_get_seal,
                                    memfd_backend_set_seal,
                                    &error_abort);
     object_class_property_set_description(oc, "seal",
-                                          "Seal growing & shrinking",
-                                          &error_abort);
+                                          "Seal growing & shrinking");
 }
=20
 static const TypeInfo memfd_backend_info =3D {
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 327f9eebc3..946d176435 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -465,46 +465,46 @@ host_memory_backend_class_init(ObjectClass *oc, void =
*data)
         host_memory_backend_get_merge,
         host_memory_backend_set_merge, &error_abort);
     object_class_property_set_description(oc, "merge",
-        "Mark memory as mergeable", &error_abort);
+        "Mark memory as mergeable");
     object_class_property_add_bool(oc, "dump",
         host_memory_backend_get_dump,
         host_memory_backend_set_dump, &error_abort);
     object_class_property_set_description(oc, "dump",
-        "Set to 'off' to exclude from core dump", &error_abort);
+        "Set to 'off' to exclude from core dump");
     object_class_property_add_bool(oc, "prealloc",
         host_memory_backend_get_prealloc,
         host_memory_backend_set_prealloc, &error_abort);
     object_class_property_set_description(oc, "prealloc",
-        "Preallocate memory", &error_abort);
+        "Preallocate memory");
     object_class_property_add(oc, "prealloc-threads", "int",
         host_memory_backend_get_prealloc_threads,
         host_memory_backend_set_prealloc_threads,
         NULL, NULL, &error_abort);
     object_class_property_set_description(oc, "prealloc-threads",
-        "Number of CPU threads to use for prealloc", &error_abort);
+        "Number of CPU threads to use for prealloc");
     object_class_property_add(oc, "size", "int",
         host_memory_backend_get_size,
         host_memory_backend_set_size,
         NULL, NULL, &error_abort);
     object_class_property_set_description(oc, "size",
-        "Size of the memory region (ex: 500M)", &error_abort);
+        "Size of the memory region (ex: 500M)");
     object_class_property_add(oc, "host-nodes", "int",
         host_memory_backend_get_host_nodes,
         host_memory_backend_set_host_nodes,
         NULL, NULL, &error_abort);
     object_class_property_set_description(oc, "host-nodes",
-        "Binds memory to the list of NUMA host nodes", &error_abort);
+        "Binds memory to the list of NUMA host nodes");
     object_class_property_add_enum(oc, "policy", "HostMemPolicy",
         &HostMemPolicy_lookup,
         host_memory_backend_get_policy,
         host_memory_backend_set_policy, &error_abort);
     object_class_property_set_description(oc, "policy",
-        "Set the NUMA policy", &error_abort);
+        "Set the NUMA policy");
     object_class_property_add_bool(oc, "share",
         host_memory_backend_get_share, host_memory_backend_set_share,
         &error_abort);
     object_class_property_set_description(oc, "share",
-        "Mark the memory as private to QEMU or shared", &error_abort);
+        "Mark the memory as private to QEMU or shared");
     object_class_property_add_bool(oc, "x-use-canonical-path-for-ramblock-=
id",
         host_memory_backend_get_use_canonical_path,
         host_memory_backend_set_use_canonical_path, &error_abort);
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index a6a2102a93..b9a34cab75 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -422,7 +422,7 @@ static void aspeed_machine_class_props_init(ObjectClass=
 *oc)
                                    aspeed_get_mmio_exec,
                                    aspeed_set_mmio_exec, &error_abort);
     object_class_property_set_description(oc, "execute-in-place",
-                           "boot directly from CE0 flash device", &error_a=
bort);
+                           "boot directly from CE0 flash device");
 }
=20
 static void aspeed_machine_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index ed683eeea5..5372ab6c9b 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -752,8 +752,7 @@ static void vexpress_instance_init(Object *obj)
                              vexpress_set_secure, NULL);
     object_property_set_description(obj, "secure",
                                     "Set on/off to enable/disable the ARM =
"
-                                    "Security Extensions (TrustZone)",
-                                    NULL);
+                                    "Security Extensions (TrustZone)");
 }
=20
 static void vexpress_a15_instance_init(Object *obj)
@@ -770,8 +769,7 @@ static void vexpress_a15_instance_init(Object *obj)
     object_property_set_description(obj, "virtualization",
                                     "Set on/off to enable/disable the ARM =
"
                                     "Virtualization Extensions "
-                                    "(defaults to same as 'secure')",
-                                    NULL);
+                                    "(defaults to same as 'secure')");
 }
=20
 static void vexpress_a9_instance_init(Object *obj)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 171e6908ec..e9c6b9a340 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2258,7 +2258,7 @@ static void virt_machine_class_init(ObjectClass *oc, =
void *data)
         virt_get_acpi, virt_set_acpi,
         NULL, NULL, &error_abort);
     object_class_property_set_description(oc, "acpi",
-        "Enable ACPI", &error_abort);
+        "Enable ACPI");
 }
=20
 static void virt_instance_init(Object *obj)
@@ -2275,8 +2275,7 @@ static void virt_instance_init(Object *obj)
                              virt_set_secure, NULL);
     object_property_set_description(obj, "secure",
                                     "Set on/off to enable/disable the ARM =
"
-                                    "Security Extensions (TrustZone)",
-                                    NULL);
+                                    "Security Extensions (TrustZone)");
=20
     /* EL2 is also disabled by default, for similar reasons */
     vms->virt =3D false;
@@ -2285,8 +2284,7 @@ static void virt_instance_init(Object *obj)
     object_property_set_description(obj, "virtualization",
                                     "Set on/off to enable/disable emulatin=
g a "
                                     "guest CPU which implements the ARM "
-                                    "Virtualization Extensions",
-                                    NULL);
+                                    "Virtualization Extensions");
=20
     /* High memory is enabled by default */
     vms->highmem =3D true;
@@ -2294,15 +2292,13 @@ static void virt_instance_init(Object *obj)
                              virt_set_highmem, NULL);
     object_property_set_description(obj, "highmem",
                                     "Set on/off to enable/disable using "
-                                    "physical address space above 32 bits"=
,
-                                    NULL);
+                                    "physical address space above 32 bits"=
);
     vms->gic_version =3D VIRT_GIC_VERSION_NOSEL;
     object_property_add_str(obj, "gic-version", virt_get_gic_version,
                         virt_set_gic_version, NULL);
     object_property_set_description(obj, "gic-version",
                                     "Set GIC version. "
-                                    "Valid values are 2, 3, host and max",
-                                    NULL);
+                                    "Valid values are 2, 3, host and max")=
;
=20
     vms->highmem_ecam =3D !vmc->no_highmem_ecam;
=20
@@ -2315,8 +2311,7 @@ static void virt_instance_init(Object *obj)
                                  virt_set_its, NULL);
         object_property_set_description(obj, "its",
                                         "Set on/off to enable/disable "
-                                        "ITS instantiation",
-                                        NULL);
+                                        "ITS instantiation");
     }
=20
     /* Default disallows iommu instantiation */
@@ -2324,8 +2319,7 @@ static void virt_instance_init(Object *obj)
     object_property_add_str(obj, "iommu", virt_get_iommu, virt_set_iommu, =
NULL);
     object_property_set_description(obj, "iommu",
                                     "Set the IOMMU type. "
-                                    "Valid values are none and smmuv3",
-                                    NULL);
+                                    "Valid values are none and smmuv3");
=20
     vms->irqmap =3D a15irqmap;
=20
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index a798e228b7..808fdae804 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -212,8 +212,7 @@ static void xlnx_zcu102_machine_instance_init(Object *o=
bj)
                              zcu102_set_secure, NULL);
     object_property_set_description(obj, "secure",
                                     "Set on/off to enable/disable the ARM =
"
-                                    "Security Extensions (TrustZone)",
-                                    NULL);
+                                    "Security Extensions (TrustZone)");
=20
     /* Default to virt (EL2) being disabled */
     s->virt =3D false;
@@ -222,8 +221,7 @@ static void xlnx_zcu102_machine_instance_init(Object *o=
bj)
     object_property_set_description(obj, "virtualization",
                                     "Set on/off to enable/disable emulatin=
g a "
                                     "guest CPU which implements the ARM "
-                                    "Virtualization Extensions",
-                                    NULL);
+                                    "Virtualization Extensions");
 }
=20
 static void xlnx_zcu102_machine_class_init(ObjectClass *oc, void *data)
diff --git a/hw/core/machine.c b/hw/core/machine.c
index c1a444cb75..39310acf36 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -786,83 +786,82 @@ static void machine_class_init(ObjectClass *oc, void =
*data)
     object_class_property_add_str(oc, "kernel",
         machine_get_kernel, machine_set_kernel, &error_abort);
     object_class_property_set_description(oc, "kernel",
-        "Linux kernel image file", &error_abort);
+        "Linux kernel image file");
=20
     object_class_property_add_str(oc, "initrd",
         machine_get_initrd, machine_set_initrd, &error_abort);
     object_class_property_set_description(oc, "initrd",
-        "Linux initial ramdisk file", &error_abort);
+        "Linux initial ramdisk file");
=20
     object_class_property_add_str(oc, "append",
         machine_get_append, machine_set_append, &error_abort);
     object_class_property_set_description(oc, "append",
-        "Linux kernel command line", &error_abort);
+        "Linux kernel command line");
=20
     object_class_property_add_str(oc, "dtb",
         machine_get_dtb, machine_set_dtb, &error_abort);
     object_class_property_set_description(oc, "dtb",
-        "Linux kernel device tree file", &error_abort);
+        "Linux kernel device tree file");
=20
     object_class_property_add_str(oc, "dumpdtb",
         machine_get_dumpdtb, machine_set_dumpdtb, &error_abort);
     object_class_property_set_description(oc, "dumpdtb",
-        "Dump current dtb to a file and quit", &error_abort);
+        "Dump current dtb to a file and quit");
=20
     object_class_property_add(oc, "phandle-start", "int",
         machine_get_phandle_start, machine_set_phandle_start,
         NULL, NULL, &error_abort);
     object_class_property_set_description(oc, "phandle-start",
-            "The first phandle ID we may generate dynamically", &error_abo=
rt);
+        "The first phandle ID we may generate dynamically");
=20
     object_class_property_add_str(oc, "dt-compatible",
         machine_get_dt_compatible, machine_set_dt_compatible, &error_abort=
);
     object_class_property_set_description(oc, "dt-compatible",
-        "Overrides the \"compatible\" property of the dt root node",
-        &error_abort);
+        "Overrides the \"compatible\" property of the dt root node");
=20
     object_class_property_add_bool(oc, "dump-guest-core",
         machine_get_dump_guest_core, machine_set_dump_guest_core, &error_a=
bort);
     object_class_property_set_description(oc, "dump-guest-core",
-        "Include guest memory in a core dump", &error_abort);
+        "Include guest memory in a core dump");
=20
     object_class_property_add_bool(oc, "mem-merge",
         machine_get_mem_merge, machine_set_mem_merge, &error_abort);
     object_class_property_set_description(oc, "mem-merge",
-        "Enable/disable memory merge support", &error_abort);
+        "Enable/disable memory merge support");
=20
     object_class_property_add_bool(oc, "usb",
         machine_get_usb, machine_set_usb, &error_abort);
     object_class_property_set_description(oc, "usb",
-        "Set on/off to enable/disable usb", &error_abort);
+        "Set on/off to enable/disable usb");
=20
     object_class_property_add_bool(oc, "graphics",
         machine_get_graphics, machine_set_graphics, &error_abort);
     object_class_property_set_description(oc, "graphics",
-        "Set on/off to enable/disable graphics emulation", &error_abort);
+        "Set on/off to enable/disable graphics emulation");
=20
     object_class_property_add_str(oc, "firmware",
         machine_get_firmware, machine_set_firmware,
         &error_abort);
     object_class_property_set_description(oc, "firmware",
-        "Firmware image", &error_abort);
+        "Firmware image");
=20
     object_class_property_add_bool(oc, "suppress-vmdesc",
         machine_get_suppress_vmdesc, machine_set_suppress_vmdesc,
         &error_abort);
     object_class_property_set_description(oc, "suppress-vmdesc",
-        "Set on to disable self-describing migration", &error_abort);
+        "Set on to disable self-describing migration");
=20
     object_class_property_add_bool(oc, "enforce-config-section",
         machine_get_enforce_config_section, machine_set_enforce_config_sec=
tion,
         &error_abort);
     object_class_property_set_description(oc, "enforce-config-section",
-        "Set on to enforce configuration section migration", &error_abort)=
;
+        "Set on to enforce configuration section migration");
=20
     object_class_property_add_str(oc, "memory-encryption",
         machine_get_memory_encryption, machine_set_memory_encryption,
         &error_abort);
     object_class_property_set_description(oc, "memory-encryption",
-        "Set memory encryption object to use", &error_abort);
+        "Set memory encryption object to use");
 }
=20
 static void machine_class_base_init(ObjectClass *oc, void *data)
@@ -895,7 +894,7 @@ static void machine_initfn(Object *obj)
                                  &error_abort);
         object_property_set_description(obj, "nvdimm",
                                         "Set on/off to enable/disable "
-                                        "NVDIMM instantiation", NULL);
+                                        "NVDIMM instantiation");
=20
         object_property_add_str(obj, "nvdimm-persistence",
                                 machine_get_nvdimm_persistence,
@@ -903,8 +902,7 @@ static void machine_initfn(Object *obj)
                                 &error_abort);
         object_property_set_description(obj, "nvdimm-persistence",
                                         "Set NVDIMM persistence"
-                                        "Valid values are cpu, mem-ctrl",
-                                        NULL);
+                                        "Valid values are cpu, mem-ctrl");
     }
=20
     if (mc->cpu_index_to_instance_props && mc->get_default_cpu_node_id) {
@@ -915,7 +913,7 @@ static void machine_initfn(Object *obj)
         object_property_set_description(obj, "hmat",
                                         "Set on/off to enable/disable "
                                         "ACPI Heterogeneous Memory Attribu=
te "
-                                        "Table (HMAT)", NULL);
+                                        "Table (HMAT)");
     }
=20
     object_property_add_str(obj, "memory-backend",
@@ -923,8 +921,7 @@ static void machine_initfn(Object *obj)
                             &error_abort);
     object_property_set_description(obj, "memory-backend",
                                     "Set RAM backend"
-                                    "Valid value is ID of hostmem based ba=
ckend",
-                                     &error_abort);
+                                    "Valid value is ID of hostmem based ba=
ckend");
=20
     /* Register notifier when init is done for sysbus sanity checks */
     ms->sysbus_notifier.notify =3D machine_init_notify;
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index dd77a56067..ea7118ab0e 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -775,8 +775,7 @@ void qdev_property_add_static(DeviceState *dev, Propert=
y *prop)
                              prop, &error_abort);
=20
     object_property_set_description(obj, prop->name,
-                                    prop->info->description,
-                                    &error_abort);
+                                    prop->info->description);
=20
     if (prop->set_default) {
         prop->info->set_default_value(op, prop);
@@ -805,8 +804,7 @@ static void qdev_class_add_property(DeviceClass *klass,=
 Property *prop)
         }
     }
     object_class_property_set_description(oc, prop->name,
-                                          prop->info->description,
-                                          &error_abort);
+                                          prop->info->description);
 }
=20
 /* @qdev_alias_all_properties - Add alias properties to the source object =
for
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 38d8e51703..76aaa7a8d8 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -512,36 +512,35 @@ static void microvm_class_init(ObjectClass *oc, void =
*data)
                               microvm_machine_set_pic,
                               NULL, NULL, &error_abort);
     object_class_property_set_description(oc, MICROVM_MACHINE_PIC,
-        "Enable i8259 PIC", &error_abort);
+        "Enable i8259 PIC");
=20
     object_class_property_add(oc, MICROVM_MACHINE_PIT, "OnOffAuto",
                               microvm_machine_get_pit,
                               microvm_machine_set_pit,
                               NULL, NULL, &error_abort);
     object_class_property_set_description(oc, MICROVM_MACHINE_PIT,
-        "Enable i8254 PIT", &error_abort);
+        "Enable i8254 PIT");
=20
     object_class_property_add(oc, MICROVM_MACHINE_RTC, "OnOffAuto",
                               microvm_machine_get_rtc,
                               microvm_machine_set_rtc,
                               NULL, NULL, &error_abort);
     object_class_property_set_description(oc, MICROVM_MACHINE_RTC,
-        "Enable MC146818 RTC", &error_abort);
+        "Enable MC146818 RTC");
=20
     object_class_property_add_bool(oc, MICROVM_MACHINE_ISA_SERIAL,
                                    microvm_machine_get_isa_serial,
                                    microvm_machine_set_isa_serial,
                                    &error_abort);
     object_class_property_set_description(oc, MICROVM_MACHINE_ISA_SERIAL,
-        "Set off to disable the instantiation an ISA serial port",
-        &error_abort);
+        "Set off to disable the instantiation an ISA serial port");
=20
     object_class_property_add_bool(oc, MICROVM_MACHINE_OPTION_ROMS,
                                    microvm_machine_get_option_roms,
                                    microvm_machine_set_option_roms,
                                    &error_abort);
     object_class_property_set_description(oc, MICROVM_MACHINE_OPTION_ROMS,
-        "Set off to disable loading option ROMs", &error_abort);
+        "Set off to disable loading option ROMs");
=20
     object_class_property_add_bool(oc, MICROVM_MACHINE_AUTO_KERNEL_CMDLINE=
,
                                    microvm_machine_get_auto_kernel_cmdline=
,
@@ -549,8 +548,7 @@ static void microvm_class_init(ObjectClass *oc, void *d=
ata)
                                    &error_abort);
     object_class_property_set_description(oc,
         MICROVM_MACHINE_AUTO_KERNEL_CMDLINE,
-        "Set off to disable adding virtio-mmio devices to the kernel cmdli=
ne",
-        &error_abort);
+        "Set off to disable adding virtio-mmio devices to the kernel cmdli=
ne");
 }
=20
 static const TypeInfo microvm_machine_info =3D {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f6b8431c8b..37c16de1df 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1968,7 +1968,7 @@ static void pc_machine_class_init(ObjectClass *oc, vo=
id *data)
         pc_machine_get_vmport, pc_machine_set_vmport,
         NULL, NULL, &error_abort);
     object_class_property_set_description(oc, PC_MACHINE_VMPORT,
-        "Enable vmport (pc & q35)", &error_abort);
+        "Enable vmport (pc & q35)");
=20
     object_class_property_add_bool(oc, PC_MACHINE_SMBUS,
         pc_machine_get_smbus, pc_machine_set_smbus, &error_abort);
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index b82770024c..e2bf601273 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -984,19 +984,19 @@ static void x86_machine_class_init(ObjectClass *oc, v=
oid *data)
         x86_machine_get_max_ram_below_4g, x86_machine_set_max_ram_below_4g=
,
         NULL, NULL, &error_abort);
     object_class_property_set_description(oc, X86_MACHINE_MAX_RAM_BELOW_4G=
,
-        "Maximum ram below the 4G boundary (32bit boundary)", &error_abort=
);
+        "Maximum ram below the 4G boundary (32bit boundary)");
=20
     object_class_property_add(oc, X86_MACHINE_SMM, "OnOffAuto",
         x86_machine_get_smm, x86_machine_set_smm,
         NULL, NULL, &error_abort);
     object_class_property_set_description(oc, X86_MACHINE_SMM,
-        "Enable SMM", &error_abort);
+        "Enable SMM");
=20
     object_class_property_add(oc, X86_MACHINE_ACPI, "OnOffAuto",
         x86_machine_get_acpi, x86_machine_set_acpi,
         NULL, NULL, &error_abort);
     object_class_property_set_description(oc, X86_MACHINE_ACPI,
-        "Enable ACPI", &error_abort);
+        "Enable ACPI");
 }
=20
 static const TypeInfo x86_machine_info =3D {
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 428cf63578..55d1419442 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -631,8 +631,7 @@ static void core99_instance_init(Object *obj)
                             core99_set_via_config, NULL);
     object_property_set_description(obj, "via",
                                     "Set VIA configuration. "
-                                    "Valid values are cuda, pmu and pmu-ad=
b",
-                                    NULL);
+                                    "Valid values are cuda, pmu and pmu-ad=
b");
=20
     return;
 }
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index c9cb6fa357..71b08e2ae7 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2002,8 +2002,7 @@ static void pnv_machine_class_init(ObjectClass *oc, v=
oid *data)
                                    pnv_machine_get_hb, pnv_machine_set_hb,
                                    &error_abort);
     object_class_property_set_description(oc, "hb-mode",
-                              "Use a hostboot like boot loader",
-                              NULL);
+                              "Use a hostboot like boot loader");
 }
=20
 #define DEFINE_PNV8_CHIP_TYPE(type, class_initfn) \
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9a2bd501aa..91138e7c67 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3317,8 +3317,7 @@ static void spapr_instance_init(Object *obj)
     object_property_add_str(obj, "kvm-type",
                             spapr_get_kvm_type, spapr_set_kvm_type, NULL);
     object_property_set_description(obj, "kvm-type",
-                                    "Specifies the KVM virtualization mode=
 (HV, PR)",
-                                    NULL);
+                                    "Specifies the KVM virtualization mode=
 (HV, PR)");
     object_property_add_bool(obj, "modern-hotplug-events",
                             spapr_get_modern_hotplug_events,
                             spapr_set_modern_hotplug_events,
@@ -3326,8 +3325,7 @@ static void spapr_instance_init(Object *obj)
     object_property_set_description(obj, "modern-hotplug-events",
                                     "Use dedicated hotplug event mechanism=
 in"
                                     " place of standard EPOW events when p=
ossible"
-                                    " (required for memory hot-unplug supp=
ort)",
-                                    NULL);
+                                    " (required for memory hot-unplug supp=
ort)");
     ppc_compat_add_property(obj, "max-cpu-compat", &spapr->max_compat_pvr,
                             "Maximum permitted CPU compatibility mode",
                             &error_fatal);
@@ -3335,14 +3333,13 @@ static void spapr_instance_init(Object *obj)
     object_property_add_str(obj, "resize-hpt",
                             spapr_get_resize_hpt, spapr_set_resize_hpt, NU=
LL);
     object_property_set_description(obj, "resize-hpt",
-                                    "Resizing of the Hash Page Table (enab=
led, disabled, required)",
-                                    NULL);
+                                    "Resizing of the Hash Page Table (enab=
led, disabled, required)");
     object_property_add_uint32_ptr(obj, "vsmt",
                                    &spapr->vsmt, OBJ_PROP_FLAG_READWRITE,
                                    &error_abort);
     object_property_set_description(obj, "vsmt",
                                     "Virtual SMT: KVM behaves as if this w=
ere"
-                                    " the host's SMT mode", &error_abort);
+                                    " the host's SMT mode");
=20
     object_property_add_bool(obj, "vfio-no-msix-emulation",
                              spapr_get_msix_emulation, NULL, NULL);
@@ -3352,27 +3349,25 @@ static void spapr_instance_init(Object *obj)
                                    &error_abort);
     object_property_set_description(obj, "kernel-addr",
                                     stringify(KERNEL_LOAD_ADDR)
-                                    " for -kernel is the default",
-                                    NULL);
+                                    " for -kernel is the default");
     spapr->kernel_addr =3D KERNEL_LOAD_ADDR;
     /* The machine class defines the default interrupt controller mode */
     spapr->irq =3D smc->irq;
     object_property_add_str(obj, "ic-mode", spapr_get_ic_mode,
                             spapr_set_ic_mode, NULL);
     object_property_set_description(obj, "ic-mode",
-                 "Specifies the interrupt controller mode (xics, xive, dua=
l)",
-                 NULL);
+                 "Specifies the interrupt controller mode (xics, xive, dua=
l)");
=20
     object_property_add_str(obj, "host-model",
         spapr_get_host_model, spapr_set_host_model,
         &error_abort);
     object_property_set_description(obj, "host-model",
-        "Host model to advertise in guest device tree", &error_abort);
+        "Host model to advertise in guest device tree");
     object_property_add_str(obj, "host-serial",
         spapr_get_host_serial, spapr_set_host_serial,
         &error_abort);
     object_property_set_description(obj, "host-serial",
-        "Host serial number to advertise in guest device tree", &error_abo=
rt);
+        "Host serial number to advertise in guest device tree");
 }
=20
 static void spapr_machine_finalizefn(Object *obj)
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index eb54f94227..0870961fc9 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -845,12 +845,8 @@ void spapr_caps_add_properties(SpaprMachineClass *smc,=
 Error **errp)
         }
=20
         desc =3D g_strdup_printf("%s", cap->description);
-        object_class_property_set_description(klass, name, desc, &local_er=
r);
+        object_class_property_set_description(klass, name, desc);
         g_free(name);
         g_free(desc);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return;
-        }
     }
 }
diff --git a/hw/ppc/spapr_rng.c b/hw/ppc/spapr_rng.c
index e8e8d65ec0..85bf64d68e 100644
--- a/hw/ppc/spapr_rng.c
+++ b/hw/ppc/spapr_rng.c
@@ -103,8 +103,7 @@ static void spapr_rng_instance_init(Object *obj)
     }
=20
     object_property_set_description(obj, "rng",
-                                    "ID of the random number generator bac=
kend",
-                                    NULL);
+                                    "ID of the random number generator bac=
kend");
 }
=20
 static void spapr_rng_realize(DeviceState *dev, Error **errp)
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index bed10fcfa8..da48c958e2 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -445,13 +445,12 @@ static void sifive_u_machine_instance_init(Object *ob=
j)
                              sifive_u_machine_set_start_in_flash, NULL);
     object_property_set_description(obj, "start-in-flash",
                                     "Set on to tell QEMU's ROM to jump to =
"
-                                    "flash. Otherwise QEMU will jump to DR=
AM",
-                                    NULL);
+                                    "flash. Otherwise QEMU will jump to DR=
AM");
=20
     s->serial =3D OTP_SERIAL;
     object_property_add(obj, "serial", "uint32", sifive_u_machine_get_seri=
al,
                         sifive_u_machine_set_serial, NULL, &s->serial, NUL=
L);
-    object_property_set_description(obj, "serial", "Board serial number", =
NULL);
+    object_property_set_description(obj, "serial", "Board serial number");
 }
=20
 static void sifive_u_machine_class_init(ObjectClass *oc, void *data)
diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index a306a78e6c..c9ce06b043 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -144,8 +144,7 @@ static void virtual_css_bridge_class_init(ObjectClass *=
klass, void *data)
                                    prop_get_true, NULL, NULL);
     object_class_property_set_description(klass, "cssid-unrestricted",
             "A css device can use any cssid, regardless whether virtual"
-            " or not (read only, always true)",
-            NULL);
+            " or not (read only, always true)");
 }
=20
 static const TypeInfo virtual_css_bridge_info =3D {
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 45292fb5a8..8643c0baae 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -731,24 +731,21 @@ static inline void s390_machine_initfn(Object *obj)
                              machine_get_aes_key_wrap,
                              machine_set_aes_key_wrap, NULL);
     object_property_set_description(obj, "aes-key-wrap",
-            "enable/disable AES key wrapping using the CPACF wrapping key"=
,
-            NULL);
+            "enable/disable AES key wrapping using the CPACF wrapping key"=
);
     object_property_set_bool(obj, true, "aes-key-wrap", NULL);
=20
     object_property_add_bool(obj, "dea-key-wrap",
                              machine_get_dea_key_wrap,
                              machine_set_dea_key_wrap, NULL);
     object_property_set_description(obj, "dea-key-wrap",
-            "enable/disable DEA key wrapping using the CPACF wrapping key"=
,
-            NULL);
+            "enable/disable DEA key wrapping using the CPACF wrapping key"=
);
     object_property_set_bool(obj, true, "dea-key-wrap", NULL);
     object_property_add_str(obj, "loadparm",
             machine_get_loadparm, machine_set_loadparm, NULL);
     object_property_set_description(obj, "loadparm",
             "Up to 8 chars in set of [A-Za-z0-9. ] (lower case chars conve=
rted"
             " to upper case) to pass to machine loader, boot manager,"
-            " and guest kernel",
-            NULL);
+            " and guest kernel");
 }
=20
 static const TypeInfo ccw_machine_info =3D {
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 36ee1a0a3d..7472d24e2c 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -797,8 +797,7 @@ static void ram_initfn(Object *obj)
                              object_property_allow_set_link,
                              OBJ_PROP_LINK_STRONG, &error_abort);
     object_property_set_description(obj, "memdev", "Set RAM backend"
-                                    "Valid value is ID of a hostmem backen=
d",
-                                     &error_abort);
+                                    "Valid value is ID of a hostmem backen=
d");
 }
=20
 static void ram_class_init(ObjectClass *klass, void *data)
diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
index a15070f7f6..adaab81ce0 100644
--- a/hw/xen/xen-common.c
+++ b/hw/xen/xen-common.c
@@ -201,7 +201,7 @@ static void xen_accel_class_init(ObjectClass *oc, void =
*data)
         xen_get_igd_gfx_passthru, xen_set_igd_gfx_passthru,
         &error_abort);
     object_class_property_set_description(oc, "igd-passthru",
-        "Set on/off to enable/disable igd passthrou", &error_abort);
+        "Set on/off to enable/disable igd passthrou");
 }
=20
 #define TYPE_XEN_ACCEL ACCEL_CLASS_NAME("xen")
diff --git a/qom/object.c b/qom/object.c
index 4e5b2ecacd..58a6ec9b1b 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2802,38 +2802,27 @@ object_property_add_alias(Object *obj, const char *=
name,
     }
=20
     object_property_set_description(obj, op->name,
-                                    target_prop->description,
-                                    &error_abort);
+                                    target_prop->description);
     return op;
 }
=20
 void object_property_set_description(Object *obj, const char *name,
-                                     const char *description, Error **errp=
)
+                                     const char *description)
 {
     ObjectProperty *op;
=20
-    op =3D object_property_find(obj, name, errp);
-    if (!op) {
-        return;
-    }
-
+    op =3D object_property_find(obj, name, &error_abort);
     g_free(op->description);
     op->description =3D g_strdup(description);
 }
=20
 void object_class_property_set_description(ObjectClass *klass,
                                            const char *name,
-                                           const char *description,
-                                           Error **errp)
+                                           const char *description)
 {
     ObjectProperty *op;
=20
     op =3D g_hash_table_lookup(klass->properties, name);
-    if (!op) {
-        error_setg(errp, "Property '.%s' not found", name);
-        return;
-    }
-
     g_free(op->description);
     op->description =3D g_strdup(description);
 }
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 9bdf75b1ab..a435a1f24f 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -781,8 +781,7 @@ static void aarch64_cpu_initfn(Object *obj)
                              aarch64_cpu_set_aarch64, NULL);
     object_property_set_description(obj, "aarch64",
                                     "Set on/off to enable/disable aarch64 =
"
-                                    "execution state ",
-                                    NULL);
+                                    "execution state ");
 }
=20
 static void aarch64_cpu_finalizefn(Object *obj)
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 390077c518..1ea2d047e3 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -204,7 +204,7 @@ void kvm_arm_add_vcpu_properties(Object *obj)
     object_property_set_description(obj, "kvm-no-adjvtime",
                                     "Set on to disable the adjustment of "
                                     "the virtual counter. VM stopped time =
"
-                                    "will be counted.", &error_abort);
+                                    "will be counted.");
 }
=20
 bool kvm_arm_pmu_supported(CPUState *cpu)
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 846018a12d..6842cfc26d 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -251,19 +251,19 @@ qsev_guest_class_init(ObjectClass *oc, void *data)
                                   qsev_guest_set_sev_device,
                                   NULL);
     object_class_property_set_description(oc, "sev-device",
-            "SEV device to use", NULL);
+            "SEV device to use");
     object_class_property_add_str(oc, "dh-cert-file",
                                   qsev_guest_get_dh_cert_file,
                                   qsev_guest_set_dh_cert_file,
                                   NULL);
     object_class_property_set_description(oc, "dh-cert-file",
-            "guest owners DH certificate (encoded with base64)", NULL);
+            "guest owners DH certificate (encoded with base64)");
     object_class_property_add_str(oc, "session-file",
                                   qsev_guest_get_session_file,
                                   qsev_guest_set_session_file,
                                   NULL);
     object_class_property_set_description(oc, "session-file",
-            "guest owners session parameters (encoded with base64)", NULL)=
;
+            "guest owners session parameters (encoded with base64)");
 }
=20
 static void
diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index f48df25944..46ffb6da6d 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -324,7 +324,7 @@ void ppc_compat_add_property(Object *obj, const char *n=
ame,
=20
     names =3D g_strjoinv(", ", namesv);
     desc =3D g_strdup_printf("%s. Valid values are %s.", basedesc, names);
-    object_property_set_description(obj, name, desc, &local_err);
+    object_property_set_description(obj, name, desc);
=20
     g_free(names);
     g_free(desc);
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 7c32180269..aa7fc713ca 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -1107,13 +1107,13 @@ void s390_cpu_model_register_props(Object *obj)
         const S390FeatDef *def =3D s390_feat_def(feat);
         object_property_add(obj, def->name, "bool", get_feature,
                             set_feature, NULL, (void *) feat, NULL);
-        object_property_set_description(obj, def->name, def->desc , NULL);
+        object_property_set_description(obj, def->name, def->desc);
     }
     for (group =3D 0; group < S390_FEAT_GROUP_MAX; group++) {
         const S390FeatGroupDef *def =3D s390_feat_group_def(group);
         object_property_add(obj, def->name, "bool", get_feature_group,
                             set_feature_group, NULL, (void *) group, NULL)=
;
-        object_property_set_description(obj, def->name, def->desc , NULL);
+        object_property_set_description(obj, def->name, def->desc);
     }
 }
=20
--=20
2.21.1


