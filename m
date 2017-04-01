Received: from eggs.gnu.org ([2001:4830:134:3::10]:51713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cu7CF-0004t8-HQ
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:47:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cu7CE-0006Xk-JU
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:47:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cu7CE-0006WH-EZ
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:47:14 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 31 Mar 2017 21:46:13 -0300
Message-Id: <20170401004624.30886-9-ehabkost@redhat.com>
In-Reply-To: <20170401004624.30886-1-ehabkost@redhat.com>
References: <20170401004624.30886-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 08/19] ioapic: Remove user_creatable flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

An ioapic device is already created by the q35 initialization
code, and using "-device ioapic" or "-device kvm-ioapic" will
always fail with "Only 1 ioapics allowed". Remove the
user_creatable flag from the ioapic device classes.

Cc: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/kvm/ioapic.c | 5 -----
 hw/intc/ioapic.c     | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
index cdc35de661..98ca480792 100644
--- a/hw/i386/kvm/ioapic.c
+++ b/hw/i386/kvm/ioapic.c
@@ -167,11 +167,6 @@ static void kvm_ioapic_class_init(ObjectClass *klass, void *data)
     k->post_load = kvm_ioapic_put;
     dc->reset    = kvm_ioapic_reset;
     dc->props    = kvm_ioapic_properties;
-    /*
-     * FIXME: Set only for compatibility on q35 machine-type.
-     * Probably never meant to be user-creatable
-     */
-    dc->user_creatable = true;
 }
 
 static const TypeInfo kvm_ioapic_info = {
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 38af393538..37c4386ae3 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -448,11 +448,6 @@ static void ioapic_class_init(ObjectClass *klass, void *data)
     k->post_load = ioapic_update_kvm_routes;
     dc->reset = ioapic_reset_common;
     dc->props = ioapic_properties;
-    /*
-     * FIXME: Set only for compatibility on q35 machine-type.
-     * Probably never meant to be user-creatable
-     */
-    dc->user_creatable = true;
 }
 
 static const TypeInfo ioapic_info = {
-- 
2.11.0.259.g40922b1
