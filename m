Received: from eggs.gnu.org ([2001:4830:134:3::10]:48103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cRk3Y-0001K9-1M
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:25:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cRk3X-0002gF-84
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:25:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cRk3X-0002fw-2w
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:24:59 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 458387F7C5
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 18:24:59 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
Date: Thu, 12 Jan 2017 19:24:46 +0100
Message-Id: <20170112182446.9600-4-lersek@redhat.com>
In-Reply-To: <20170112182446.9600-1-lersek@redhat.com>
References: <20170112182446.9600-1-lersek@redhat.com>
Subject: [Qemu-devel] [PATCH v6 wave 2 3/3] hw/isa/lpc_ich9: negotiate SMI
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
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---

Notes:
    v6:
    - rename "smi_broadcast" to "x-smi-broadcast" [Eduardo]
    - pick up Eduardo's R-b
    - pick up Michael's R-b
    
    v5:
    - replace the v4 patch "hw/i386/pc_q35: advertise broadcast SMI if VCPU
      hotplug is turned off" with a simple device property and compat
      setting [Igor]

 include/hw/i386/pc.h | 5 +++++
 hw/isa/lpc_ich9.c    | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 230e9e70c504..9d950733abdf 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -376,6 +376,11 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 
 #define PC_COMPAT_2_8 \
     HW_COMPAT_2_8 \
+    {\
+        .driver   = "ICH9-LPC",\
+        .property = "x-smi-broadcast",\
+        .value    = "off",\
+    },\
 
 
 #define PC_COMPAT_2_7 \
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index ced6f803a4f2..59930dd9d09d 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -776,6 +776,8 @@ static const VMStateDescription vmstate_ich9_lpc = {
 
 static Property ich9_lpc_properties[] = {
     DEFINE_PROP_BOOL("noreboot", ICH9LPCState, pin_strap.spkr_hi, true),
+    DEFINE_PROP_BIT64("x-smi-broadcast", ICH9LPCState, smi_host_features,
+                      ICH9_LPC_SMI_F_BROADCAST_BIT, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.9.3
