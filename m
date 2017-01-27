Received: from eggs.gnu.org ([2001:4830:134:3::10]:33425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6qt-0004yn-7l
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6qr-0003w1-TH
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:07 -0500
Received: from mail-wj0-x241.google.com ([2a00:1450:400c:c01::241]:34291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX6qr-0003vZ-Mc
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:05 -0500
Received: by mail-wj0-x241.google.com with SMTP id ip10so5994195wjb.1
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:46:05 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:20 +0100
Message-Id: <1485524749-118532-13-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 12/41] hw/isa/lpc_ich9: negotiate SMI broadcast
 on pc-q35-2.9+ machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

From: Laszlo Ersek <lersek@redhat.com>

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20170126014416.11211-4-lersek@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/isa/lpc_ich9.c    | 2 ++
 include/hw/i386/pc.h | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index ced6f80..59930dd 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -776,6 +776,8 @@ static const VMStateDescription vmstate_ich9_lpc = {
 
 static Property ich9_lpc_properties[] = {
     DEFINE_PROP_BOOL("noreboot", ICH9LPCState, pin_strap.spkr_hi, true),
+    DEFINE_PROP_BIT64("x-smi-broadcast", ICH9LPCState, smi_host_features,
+                      ICH9_LPC_SMI_F_BROADCAST_BIT, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 738bfd6..020b632 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -381,6 +381,12 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
         .property = "x-mach-use-reliable-get-clock",\
         .value    = "off",\
     },\
+    {\
+        .driver   = "ICH9-LPC",\
+        .property = "x-smi-broadcast",\
+        .value    = "off",\
+    },\
+
 
 #define PC_COMPAT_2_7 \
     HW_COMPAT_2_7 \
-- 
1.8.3.1
