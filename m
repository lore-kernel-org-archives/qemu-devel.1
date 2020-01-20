Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6C3C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 13:28:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8997921835
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 13:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fQD99N4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8997921835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36393 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itX61-0002Fh-CH
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 08:28:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1itX3A-0007ag-Qy
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:25:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1itX35-0007IC-0p
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:25:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51914
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1itX34-0007Hh-J2
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:24:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579526698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sF4Ud5L0zZevDuhybWBy7H82xBqSBZw/RBHwEBsyoqs=;
 b=fQD99N4+tldveFuZ4LRJIjxUk4KMh0ImSVFaFf8meIBzJtYK2FJgj0v0fGScR3G3QLcLtz
 Af8aQXzVDi1ZLejSzcupnQsZQIX8lCi+rGptwaLR2FR+LgPX1xG2n2tiH+XPl4+2PwFXB1
 AAcJxSz5Rd9x4xAzCA4C6hrV/mtXqw4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-XX3ej6IeMfyeGlI77XYNuQ-1; Mon, 20 Jan 2020 08:24:51 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D5C68010C4;
 Mon, 20 Jan 2020 13:24:50 +0000 (UTC)
Received: from thuth.com (ovpn-116-99.ams2.redhat.com [10.36.116.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 650C585720;
 Mon, 20 Jan 2020 13:24:45 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v3] target/s390x/kvm: Enable adapter interruption suppression
 again
Date: Mon, 20 Jan 2020 14:24:41 +0100
Message-Id: <20200120132441.11884-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: XX3ej6IeMfyeGlI77XYNuQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The AIS feature has been disabled late in the v2.10 development cycle since
there were some issues with migration (see commit 3f2d07b3b01ea61126b -
"s390x/ais: for 2.10 stable: disable ais facility"). We originally wanted
to enable it again for newer machine types, but apparently we forgot to do
this so far. Let's do it for the new s390-ccw-virtio-5.0 machine now.

While at it, also add a more verbose comment why we need the *_allowed()
wrappers in s390-virtio-ccw.c.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1756946
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v3: Moved "s390mc->kvm_ais_allowed =3D false" to the end of the function

 hw/s390x/s390-virtio-ccw.c         | 20 +++++++++++++++++---
 include/hw/s390x/s390-virtio-ccw.h |  3 +++
 target/s390x/kvm.c                 |  9 ++++++---
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index e0e28139a2..76254e8447 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -452,6 +452,7 @@ static void ccw_machine_class_init(ObjectClass *oc, voi=
d *data)
     s390mc->cpu_model_allowed =3D true;
     s390mc->css_migration_enabled =3D true;
     s390mc->hpage_1m_allowed =3D true;
+    s390mc->kvm_ais_allowed =3D true;
     mc->init =3D ccw_init;
     mc->reset =3D s390_machine_reset;
     mc->hot_add_cpu =3D s390_hot_add_cpu;
@@ -505,6 +506,14 @@ static inline void machine_set_dea_key_wrap(Object *ob=
j, bool value,
=20
 static S390CcwMachineClass *current_mc;
=20
+/*
+ * Get the class of the s390-ccw-virtio machine that is currently in use.
+ * Note: libvirt is using the "none" machine to probe for the features of =
the
+ * host CPU, so in case this is called with the "none" machine, the functi=
on
+ * returns the TYPE_S390_CCW_MACHINE base class. In this base class, all t=
he
+ * various "*_allowed" variables are enabled, so that the *_allowed() wrap=
pers
+ * below return the correct default value for the "none" machine.
+ */
 static S390CcwMachineClass *get_machine_class(void)
 {
     if (unlikely(!current_mc)) {
@@ -521,22 +530,24 @@ static S390CcwMachineClass *get_machine_class(void)
=20
 bool ri_allowed(void)
 {
-    /* for "none" machine this results in true */
     return get_machine_class()->ri_allowed;
 }
=20
 bool cpu_model_allowed(void)
 {
-    /* for "none" machine this results in true */
     return get_machine_class()->cpu_model_allowed;
 }
=20
 bool hpage_1m_allowed(void)
 {
-    /* for "none" machine this results in true */
     return get_machine_class()->hpage_1m_allowed;
 }
=20
+bool kvm_ais_allowed(void)
+{
+    return get_machine_class()->kvm_ais_allowed;
+}
+
 static char *machine_get_loadparm(Object *obj, Error **errp)
 {
     S390CcwMachineState *ms =3D S390_CCW_MACHINE(obj);
@@ -658,8 +669,11 @@ static void ccw_machine_4_2_instance_options(MachineSt=
ate *machine)
=20
 static void ccw_machine_4_2_class_options(MachineClass *mc)
 {
+    S390CcwMachineClass *s390mc =3D S390_MACHINE_CLASS(mc);
+
     ccw_machine_5_0_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
+    s390mc->kvm_ais_allowed =3D false;
 }
 DEFINE_CCW_MACHINE(4_2, "4.2", false);
=20
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-vir=
tio-ccw.h
index 8aa27199c9..e3ba3b88b1 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -40,6 +40,7 @@ typedef struct S390CcwMachineClass {
     bool cpu_model_allowed;
     bool css_migration_enabled;
     bool hpage_1m_allowed;
+    bool kvm_ais_allowed;
 } S390CcwMachineClass;
=20
 /* runtime-instrumentation allowed by the machine */
@@ -48,6 +49,8 @@ bool ri_allowed(void);
 bool cpu_model_allowed(void);
 /* 1M huge page mappings allowed by the machine */
 bool hpage_1m_allowed(void);
+/* adapter-interrupt suppression allowed by the machine? */
+bool kvm_ais_allowed(void);
=20
 /**
  * Returns true if (vmstate based) migration of the channel subsystem
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 15260aeb9a..cf4fb4f2d9 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -365,10 +365,13 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     /*
      * The migration interface for ais was introduced with kernel 4.13
      * but the capability itself had been active since 4.12. As migration
-     * support is considered necessary let's disable ais in the 2.10
-     * machine.
+     * support is considered necessary, we only try to enable this for
+     * newer machine types if KVM_CAP_S390_AIS_MIGRATION is available.
      */
-    /* kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0); */
+    if (kvm_ais_allowed() &&
+        kvm_check_extension(s, KVM_CAP_S390_AIS_MIGRATION)) {
+        kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
+    }
=20
     kvm_set_max_memslot_size(KVM_SLOT_MAX_BYTES);
     return 0;
--=20
2.18.1


