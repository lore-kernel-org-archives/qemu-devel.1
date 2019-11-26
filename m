Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EEDC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 06:21:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5561720656
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 06:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hkP6PPW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5561720656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZUE3-00050A-BT
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 01:21:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iZU90-0007Mj-DE
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 01:16:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iZTvF-0004Mv-QK
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 01:02:03 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:47519 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iZTvF-0004KR-1J; Tue, 26 Nov 2019 01:02:01 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47MYFc4CkQz9sQy; Tue, 26 Nov 2019 17:01:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574748116;
 bh=cBWAaxRMUmAXyV+l5qyTcoCm3QGnkC4O/NUuXad1Dwo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hkP6PPW0emxpvL8P7/4Ytg3ONKytAO5nND08tb22XllAjDLt06fIc2HnK25HEabtL
 KUxL/8GEmcLkYFLeT0OrSlizoS23NwBim+5I8VII9WiYAulcaujZPGhSPmipwsjEJo
 nSGEO4E8ScfJyrW0bfS0DzcAdpA3vQ+Qds4v2aes=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 2/8] kvm: Introduce KVM irqchip change notifier
Date: Tue, 26 Nov 2019 17:01:45 +1100
Message-Id: <20191126060151.729845-3-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191126060151.729845-1-david@gibson.dropbear.id.au>
References: <20191126060151.729845-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, Alexey Kardashevskiy <aik@ozlabs.ru>,
 qemu-devel@nongnu.org, groug@kaod.org,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Awareness of an in kernel irqchip is usually local to the machine and its
top-level interrupt controller.  However, in a few cases other things nee=
d
to know about it.  In particular vfio devices need this in order to
accelerate interrupt delivery.

If interrupt routing is changed, such devices may need to readjust their
connection to the KVM irqchip.  pci_bus_fire_intx_routing_notifier() exis=
ts
to do just this.

However, for the pseries machine type we have a situation where the routi=
ng
remains constant but the top-level irq chip itself is changed.  This occu=
rs
because of PAPR feature negotiation which allows the guest to decide
between the older XICS and newer XIVE irq chip models (both of which are
paravirtualized).

To allow devices like vfio to adjust to this change, introduce a new
notifier for the purpose kvm_irqchip_change_notify().

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Tested-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
---
 accel/kvm/kvm-all.c    | 18 ++++++++++++++++++
 accel/stubs/kvm-stub.c | 12 ++++++++++++
 include/sysemu/kvm.h   |  5 +++++
 3 files changed, 35 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 140b0bd8f6..ca00daa2f5 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -149,6 +149,9 @@ static const KVMCapabilityInfo kvm_required_capabilit=
es[] =3D {
     KVM_CAP_LAST_INFO
 };
=20
+static NotifierList kvm_irqchip_change_notifiers =3D
+    NOTIFIER_LIST_INITIALIZER(kvm_irqchip_change_notifiers);
+
 #define kvm_slots_lock(kml)      qemu_mutex_lock(&(kml)->slots_lock)
 #define kvm_slots_unlock(kml)    qemu_mutex_unlock(&(kml)->slots_lock)
=20
@@ -1396,6 +1399,21 @@ void kvm_irqchip_release_virq(KVMState *s, int vir=
q)
     trace_kvm_irqchip_release_virq(virq);
 }
=20
+void kvm_irqchip_add_change_notifier(Notifier *n)
+{
+    notifier_list_add(&kvm_irqchip_change_notifiers, n);
+}
+
+void kvm_irqchip_remove_change_notifier(Notifier *n)
+{
+    notifier_remove(n);
+}
+
+void kvm_irqchip_change_notify(void)
+{
+    notifier_list_notify(&kvm_irqchip_change_notifiers, NULL);
+}
+
 static unsigned int kvm_hash_msi(uint32_t data)
 {
     /* This is optimized for IA32 MSI layout. However, no other arch sha=
ll
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 6feb66ed80..82f118d2df 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -138,6 +138,18 @@ void kvm_irqchip_commit_routes(KVMState *s)
 {
 }
=20
+void kvm_irqchip_add_change_notifier(Notifier *n)
+{
+}
+
+void kvm_irqchip_remove_change_notifier(Notifier *n)
+{
+}
+
+void kvm_irqchip_change_notify(void)
+{
+}
+
 int kvm_irqchip_add_adapter_route(KVMState *s, AdapterInfo *adapter)
 {
     return -ENOSYS;
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 9d143282bc..9fe233b9bf 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -201,6 +201,7 @@ typedef struct KVMCapabilityInfo {
 struct KVMState;
 typedef struct KVMState KVMState;
 extern KVMState *kvm_state;
+typedef struct Notifier Notifier;
=20
 /* external API */
=20
@@ -401,6 +402,10 @@ int kvm_irqchip_send_msi(KVMState *s, MSIMessage msg=
);
=20
 void kvm_irqchip_add_irq_route(KVMState *s, int gsi, int irqchip, int pi=
n);
=20
+void kvm_irqchip_add_change_notifier(Notifier *n);
+void kvm_irqchip_remove_change_notifier(Notifier *n);
+void kvm_irqchip_change_notify(void);
+
 void kvm_get_apic_state(DeviceState *d, struct kvm_lapic_state *kapic);
=20
 struct kvm_guest_debug;
--=20
2.23.0


