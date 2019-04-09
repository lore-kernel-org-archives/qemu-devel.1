Received: from eggs.gnu.org ([209.51.188.92]:51454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDt5u-00085o-Qc
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:55:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDt5t-0004ht-JG
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:55:30 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:45225)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hDt5t-0004a3-2t
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:55:29 -0400
Received: by mail-wr1-x436.google.com with SMTP id s15so21535056wra.12
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 08:55:23 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  9 Apr 2019 17:55:15 +0200
Message-Id: <1554825316-33288-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1554825316-33288-1-git-send-email-pbonzini@redhat.com>
References: <1554825316-33288-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 4/5] hw/i386/pc: Fix crash when hot-plugging
 nvdimm on older machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

QEMU currently crashes when you try to hot-plug an "nvdimm" device
on older machine types:

$ qemu-system-x86_64 -monitor stdio -M pc-1.1
QEMU 3.1.92 monitor - type 'help' for more information
(qemu) device_add nvdimm,id=nvdimmn1
qemu-system-x86_64: /home/thuth/devel/qemu/util/error.c:57: error_setv:
 Assertion `*errp == ((void *)0)' failed.
Aborted (core dumped)

The call to hotplug_handler_pre_plug() in pc_memory_pre_plug() has been
added recently before the check whether nvdimm is enabled. It should
be done after the check. And while we're at it, also check the errp
after the hotplug_handler_pre_plug(), otherwise errors are silently
ignored here.

Fixes: 9040e6dfa8c3fed87695a3de555d2c775727bb51
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190407092314.11066-1-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 6077d27..f2c15bf 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2078,6 +2078,7 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     const MachineState *ms = MACHINE(hotplug_dev);
     const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
     const uint64_t legacy_align = TARGET_PAGE_SIZE;
+    Error *local_err = NULL;
 
     /*
      * When -no-acpi is used with Q35 machine type, no ACPI is built,
@@ -2090,13 +2091,17 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    hotplug_handler_pre_plug(pcms->acpi_dev, dev, errp);
-
     if (is_nvdimm && !ms->nvdimms_state->is_enabled) {
         error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M'");
         return;
     }
 
+    hotplug_handler_pre_plug(pcms->acpi_dev, dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev),
                      pcmc->enforce_aligned_dimm ? NULL : &legacy_align, errp);
 }
-- 
1.8.3.1
