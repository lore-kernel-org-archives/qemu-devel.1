Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BDAC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:22:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 541B620748
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZE4IGcm5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 541B620748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is4AG-0000cL-3w
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 07:22:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1is48i-0007Hs-Bw
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:20:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1is48e-0005tL-C3
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:20:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41182
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1is48e-0005sj-7s
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:20:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579177239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sYnfPFXcRCPUJl1lwxxib1qUqJLh3By4WmGJiIKC3eQ=;
 b=ZE4IGcm5Z2ZZkyqXpT8GcCMtMyXUTUmzR549kwHNtN1rWYgHie1bgv1pqfCoTZI09SyttC
 3ZN9XUyepK0xmcM3m9CDpjskAEqhu3e3JPEC2enghnR61mQ4quMT8TcU+Ot1db45c3dx2M
 P+V8F27ZIh+KSOCJdrNe7YSkzjW3xhU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-7yA_y7SyOquZ5NCelCNhTg-1; Thu, 16 Jan 2020 07:20:36 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2545E1005502;
 Thu, 16 Jan 2020 12:20:35 +0000 (UTC)
Received: from thuth.com (ovpn-204-105.brq.redhat.com [10.40.204.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B1B4184333;
 Thu, 16 Jan 2020 12:20:30 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH] target/s390x/kvm: Enable adapter interruption suppression
 again
Date: Thu, 16 Jan 2020 13:20:26 +0100
Message-Id: <20200116122026.5804-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 7yA_y7SyOquZ5NCelCNhTg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The AIS feature has been disabled late in the v2.10 development
cycle since there were some issues with migration (see commit
3f2d07b3b01ea61126b - "s390x/ais: for 2.10 stable: disable ais
facility"). We originally wanted to enable it again for newer
machine types, but apparently we forgot to do this so far. Let's
do it for the new s390-ccw-virtio-5.0 machine now.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1756946
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c         |  4 ++++
 include/hw/s390x/s390-virtio-ccw.h |  4 ++++
 target/s390x/kvm.c                 | 11 ++++++++---
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index e7eadd14e8..6f43136396 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -456,6 +456,7 @@ static void ccw_machine_class_init(ObjectClass *oc, voi=
d *data)
     s390mc->cpu_model_allowed =3D true;
     s390mc->css_migration_enabled =3D true;
     s390mc->hpage_1m_allowed =3D true;
+    s390mc->kvm_ais_allowed =3D true;
     mc->init =3D ccw_init;
     mc->reset =3D s390_machine_reset;
     mc->hot_add_cpu =3D s390_hot_add_cpu;
@@ -662,6 +663,9 @@ static void ccw_machine_4_2_instance_options(MachineSta=
te *machine)
=20
 static void ccw_machine_4_2_class_options(MachineClass *mc)
 {
+    S390CcwMachineClass *s390mc =3D S390_MACHINE_CLASS(mc);
+
+    s390mc->kvm_ais_allowed =3D false;
     ccw_machine_5_0_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
 }
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-vir=
tio-ccw.h
index 8aa27199c9..f142d379c6 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -21,6 +21,9 @@
 #define S390_MACHINE_CLASS(klass) \
     OBJECT_CLASS_CHECK(S390CcwMachineClass, (klass), TYPE_S390_CCW_MACHINE=
)
=20
+#define S390_CCW_MACHINE_OBJ_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(S390CcwMachineClass, obj, TYPE_S390_CCW_MACHINE)
+
 typedef struct S390CcwMachineState {
     /*< private >*/
     MachineState parent_obj;
@@ -40,6 +43,7 @@ typedef struct S390CcwMachineClass {
     bool cpu_model_allowed;
     bool css_migration_enabled;
     bool hpage_1m_allowed;
+    bool kvm_ais_allowed;
 } S390CcwMachineClass;
=20
 /* runtime-instrumentation allowed by the machine */
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 15260aeb9a..4c1c8c0208 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -329,6 +329,8 @@ static void ccw_machine_class_foreach(ObjectClass *oc, =
void *opaque)
=20
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
+    S390CcwMachineClass *smc =3D S390_CCW_MACHINE_OBJ_GET_CLASS(ms);
+
     object_class_foreach(ccw_machine_class_foreach, TYPE_S390_CCW_MACHINE,
                          false, NULL);
=20
@@ -365,10 +367,13 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     /*
      * The migration interface for ais was introduced with kernel 4.13
      * but the capability itself had been active since 4.12. As migration
-     * support is considered necessary let's disable ais in the 2.10
-     * machine.
+     * support is considered necessary we only enable this for newer
+     * machine types and if KVM_CAP_S390_AIS_MIGRATION is available.
      */
-    /* kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0); */
+    if (smc->kvm_ais_allowed &&
+        kvm_check_extension(s, KVM_CAP_S390_AIS_MIGRATION)) {
+        kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
+    }
=20
     kvm_set_max_memslot_size(KVM_SLOT_MAX_BYTES);
     return 0;
--=20
2.18.1


