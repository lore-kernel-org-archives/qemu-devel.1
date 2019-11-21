Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCA2C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 01:03:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38E2A20878
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 01:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="IcxKWzfs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E2A20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXase-0005a5-BK
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 20:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iXao5-0001Qc-NI
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 19:58:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iXao4-0001rb-2w
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 19:58:49 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:39031 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iXao3-0001qw-CJ; Wed, 20 Nov 2019 19:58:48 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47JLm41Hqpz9sNx; Thu, 21 Nov 2019 11:58:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574297924;
 bh=fREJuuqgAEuiDzU2O79CZ0GSodqvDi8dVSOI0miZGuE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IcxKWzfsNp+TDMm/FcmYOF/G6BK8Fwdx7sj3AbbpJBecSmOD3EvejoKZXJ9Hdo5X4
 GBJcG9PY7fmZVX3w/91Q8nXcqBSmyoGG35fPguQUP2szAqbFxrua9emPjVKUaoeYJL
 b8W+cjT9+2k1AAe70PVOMNqijScMEkmCl0xnVIm4=
From: David Gibson <david@gibson.dropbear.id.au>
To: Alex Williamson <alex.williamson@redhat.com>,
	clg@kaod.org
Subject: [PATCH 1/5] kvm: Introduce KVM irqchip change notifier
Date: Thu, 21 Nov 2019 11:56:03 +1100
Message-Id: <20191121005607.274347-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121005607.274347-1-david@gibson.dropbear.id.au>
References: <20191121005607.274347-1-david@gibson.dropbear.id.au>
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
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, groug@kaod.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
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


