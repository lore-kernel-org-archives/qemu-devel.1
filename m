Received: from eggs.gnu.org ([2001:4830:134:3::10]:42661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cRMoJ-0005kv-46
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:35:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cRMoH-0007ym-Tr
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:35:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cRMoH-0007yf-Ns
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:35:41 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DE13980F6D
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 17:35:41 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
Date: Wed, 11 Jan 2017 18:35:28 +0100
Message-Id: <20170111173528.30510-4-lersek@redhat.com>
In-Reply-To: <20170111173528.30510-1-lersek@redhat.com>
References: <20170111173528.30510-1-lersek@redhat.com>
Subject: [Qemu-devel] [PATCH v5 wave 2 3/3] hw/isa/lpc_ich9: negotiate SMI
 broadcast on pc-q35-2.9+ machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel list <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---

Notes:
    v5:
    - replace the v4 patch "hw/i386/pc_q35: advertise broadcast SMI if VCPU
      hotplug is turned off" with a simple device property and compat
      setting [Igor]

 include/hw/i386/pc.h | 5 +++++
 hw/isa/lpc_ich9.c    | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 230e9e70c504..fb8ca7c907f6 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -376,6 +376,11 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 
 #define PC_COMPAT_2_8 \
     HW_COMPAT_2_8 \
+    {\
+        .driver   = "ICH9-LPC",\
+        .property = "smi_broadcast",\
+        .value    = "off",\
+    },\
 
 
 #define PC_COMPAT_2_7 \
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index ced6f803a4f2..27fae5144744 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -776,6 +776,8 @@ static const VMStateDescription vmstate_ich9_lpc = {
 
 static Property ich9_lpc_properties[] = {
     DEFINE_PROP_BOOL("noreboot", ICH9LPCState, pin_strap.spkr_hi, true),
+    DEFINE_PROP_BIT64("smi_broadcast", ICH9LPCState, smi_host_features,
+                      ICH9_LPC_SMI_F_BROADCAST_BIT, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.9.3
