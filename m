Received: from eggs.gnu.org ([2001:4830:134:3::10]:49104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cQVkJ-0003D2-Qu
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 03:56:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cQVkI-0001oY-Ts
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 03:56:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cQVkI-0001np-OB
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 03:56:02 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CF11361B86
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 08:56:02 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon,  9 Jan 2017 16:55:53 +0800
Message-Id: <1483952153-7221-4-git-send-email-peterx@redhat.com>
In-Reply-To: <1483952153-7221-1-git-send-email-peterx@redhat.com>
References: <1483952153-7221-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] x86: ioapic: fix fail migration when
 irqchip=split
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/intc/ioapic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index d1254f8..9047b89 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -439,6 +439,11 @@ static void ioapic_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     k->realize = ioapic_realize;
+    /*
+     * If APIC is in kernel, we need to update the kernel cache after
+     * migration, otherwise first 24 gsi routes will be invalid.
+     */
+    k->post_load = ioapic_update_kvm_routes;
     dc->reset = ioapic_reset_common;
     dc->props = ioapic_properties;
 }
-- 
2.7.4
