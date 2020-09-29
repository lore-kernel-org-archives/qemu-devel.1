Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADD4C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:21:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F2E92076D
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dU5xZ8YA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2E92076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNM86-0003h8-VI
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 16:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNM68-0001nB-D9
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:19:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21599)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNM62-0003TZ-Dq
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:19:38 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601410773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MgitbMqeM3f1gxlb1eMc97YNGzeiuZxcB+VxofU9rrY=;
 b=dU5xZ8YADZBlS6Sg0gXwHHw0sIuoYgqKBsa14/3AXrLLqLXCyguNoDndjfLWzgUxbSzGLh
 A60fv/mHkzbTN5jGM5Hdsy/8sCRNp9kN3/T7j7Wk+9oM2HhRS+a4s3r/JjH8Aak3JUGP/p
 HY8MVdmdtsrnSaFTYaP87ZXxHFmFoJM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-D7wt7LcRNZm38h7zIUV9rg-1; Tue, 29 Sep 2020 16:19:31 -0400
X-MC-Unique: D7wt7LcRNZm38h7zIUV9rg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EF8B1DDF3;
 Tue, 29 Sep 2020 20:19:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A54FA19D7D;
 Tue, 29 Sep 2020 20:19:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A2C4D113639D; Tue, 29 Sep 2020 22:19:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/29] qapi: Restrict device memory commands to machine code
Date: Tue, 29 Sep 2020 22:19:03 +0200
Message-Id: <20200929201926.2155622-7-armbru@redhat.com>
In-Reply-To: <20200929201926.2155622-1-armbru@redhat.com>
References: <20200929201926.2155622-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Only qemu-system-FOO and qemu-storage-daemon provide QMP
monitors, therefore such declarations and definitions are
irrelevant for user-mode emulation.

Restricting the memory commands to machine.json pulls less
QAPI-generated code into user-mode.

Acked-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200913195348.1064154-7-philmd@redhat.com>
[Commit message tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/machine.json               | 216 +++++++++++++++++++++++++++++++
 qapi/misc.json                  | 217 --------------------------------
 include/hw/mem/memory-device.h  |   2 +-
 include/hw/virtio/virtio-pmem.h |   2 +-
 hw/acpi/memory_hotplug.c        |   1 +
 hw/virtio/virtio-mem-pci.c      |   1 +
 6 files changed, 220 insertions(+), 219 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 5e5ddd7a5e..c061cce0e4 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1085,3 +1085,219 @@
 ##
 { 'event': 'BALLOON_CHANGE',
   'data': { 'actual': 'int' } }
+
+##
+# @MemoryInfo:
+#
+# Actual memory information in bytes.
+#
+# @base-memory: size of "base" memory specified with command line
+#               option -m.
+#
+# @plugged-memory: size of memory that can be hot-unplugged. This field
+#                  is omitted if target doesn't support memory hotplug
+#                  (i.e. CONFIG_MEM_DEVICE not defined at build time).
+#
+# Since: 2.11.0
+##
+{ 'struct': 'MemoryInfo',
+  'data'  : { 'base-memory': 'size', '*plugged-memory': 'size' } }
+
+##
+# @query-memory-size-summary:
+#
+# Return the amount of initially allocated and present hotpluggable (if
+# enabled) memory in bytes.
+#
+# Example:
+#
+# -> { "execute": "query-memory-size-summary" }
+# <- { "return": { "base-memory": 4294967296, "plugged-memory": 0 } }
+#
+# Since: 2.11.0
+##
+{ 'command': 'query-memory-size-summary', 'returns': 'MemoryInfo' }
+
+##
+# @PCDIMMDeviceInfo:
+#
+# PCDIMMDevice state information
+#
+# @id: device's ID
+#
+# @addr: physical address, where device is mapped
+#
+# @size: size of memory that the device provides
+#
+# @slot: slot number at which device is plugged in
+#
+# @node: NUMA node number where device is plugged in
+#
+# @memdev: memory backend linked with device
+#
+# @hotplugged: true if device was hotplugged
+#
+# @hotpluggable: true if device if could be added/removed while machine is running
+#
+# Since: 2.1
+##
+{ 'struct': 'PCDIMMDeviceInfo',
+  'data': { '*id': 'str',
+            'addr': 'int',
+            'size': 'int',
+            'slot': 'int',
+            'node': 'int',
+            'memdev': 'str',
+            'hotplugged': 'bool',
+            'hotpluggable': 'bool'
+          }
+}
+
+##
+# @VirtioPMEMDeviceInfo:
+#
+# VirtioPMEM state information
+#
+# @id: device's ID
+#
+# @memaddr: physical address in memory, where device is mapped
+#
+# @size: size of memory that the device provides
+#
+# @memdev: memory backend linked with device
+#
+# Since: 4.1
+##
+{ 'struct': 'VirtioPMEMDeviceInfo',
+  'data': { '*id': 'str',
+            'memaddr': 'size',
+            'size': 'size',
+            'memdev': 'str'
+          }
+}
+
+##
+# @VirtioMEMDeviceInfo:
+#
+# VirtioMEMDevice state information
+#
+# @id: device's ID
+#
+# @memaddr: physical address in memory, where device is mapped
+#
+# @requested-size: the user requested size of the device
+#
+# @size: the (current) size of memory that the device provides
+#
+# @max-size: the maximum size of memory that the device can provide
+#
+# @block-size: the block size of memory that the device provides
+#
+# @node: NUMA node number where device is assigned to
+#
+# @memdev: memory backend linked with the region
+#
+# Since: 5.1
+##
+{ 'struct': 'VirtioMEMDeviceInfo',
+  'data': { '*id': 'str',
+            'memaddr': 'size',
+            'requested-size': 'size',
+            'size': 'size',
+            'max-size': 'size',
+            'block-size': 'size',
+            'node': 'int',
+            'memdev': 'str'
+          }
+}
+
+##
+# @MemoryDeviceInfo:
+#
+# Union containing information about a memory device
+#
+# nvdimm is included since 2.12. virtio-pmem is included since 4.1.
+# virtio-mem is included since 5.1.
+#
+# Since: 2.1
+##
+{ 'union': 'MemoryDeviceInfo',
+  'data': { 'dimm': 'PCDIMMDeviceInfo',
+            'nvdimm': 'PCDIMMDeviceInfo',
+            'virtio-pmem': 'VirtioPMEMDeviceInfo',
+            'virtio-mem': 'VirtioMEMDeviceInfo'
+          }
+}
+
+##
+# @query-memory-devices:
+#
+# Lists available memory devices and their state
+#
+# Since: 2.1
+#
+# Example:
+#
+# -> { "execute": "query-memory-devices" }
+# <- { "return": [ { "data":
+#                       { "addr": 5368709120,
+#                         "hotpluggable": true,
+#                         "hotplugged": true,
+#                         "id": "d1",
+#                         "memdev": "/objects/memX",
+#                         "node": 0,
+#                         "size": 1073741824,
+#                         "slot": 0},
+#                    "type": "dimm"
+#                  } ] }
+#
+##
+{ 'command': 'query-memory-devices', 'returns': ['MemoryDeviceInfo'] }
+
+##
+# @MEMORY_DEVICE_SIZE_CHANGE:
+#
+# Emitted when the size of a memory device changes. Only emitted for memory
+# devices that can actually change the size (e.g., virtio-mem due to guest
+# action).
+#
+# @id: device's ID
+# @size: the new size of memory that the device provides
+#
+# Note: this event is rate-limited.
+#
+# Since: 5.1
+#
+# Example:
+#
+# <- { "event": "MEMORY_DEVICE_SIZE_CHANGE",
+#      "data": { "id": "vm0", "size": 1073741824},
+#      "timestamp": { "seconds": 1588168529, "microseconds": 201316 } }
+#
+##
+{ 'event': 'MEMORY_DEVICE_SIZE_CHANGE',
+  'data': { '*id': 'str', 'size': 'size' } }
+
+
+##
+# @MEM_UNPLUG_ERROR:
+#
+# Emitted when memory hot unplug error occurs.
+#
+# @device: device name
+#
+# @msg: Informative message
+#
+# Since: 2.4
+#
+# Example:
+#
+# <- { "event": "MEM_UNPLUG_ERROR"
+#      "data": { "device": "dimm1",
+#                "msg": "acpi: device unplug for unsupported device"
+#      },
+#      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#
+##
+{ 'event': 'MEM_UNPLUG_ERROR',
+  'data': { 'device': 'str', 'msg': 'str' } }
diff --git a/qapi/misc.json b/qapi/misc.json
index 05db6295fe..71d11365ea 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -826,39 +826,6 @@
 ##
 { 'command': 'closefd', 'data': {'fdname': 'str'} }
 
-##
-# @MemoryInfo:
-#
-# Actual memory information in bytes.
-#
-# @base-memory: size of "base" memory specified with command line
-#               option -m.
-#
-# @plugged-memory: size of memory that can be hot-unplugged. This field
-#                  is omitted if target doesn't support memory hotplug
-#                  (i.e. CONFIG_MEM_DEVICE not defined at build time).
-#
-# Since: 2.11.0
-##
-{ 'struct': 'MemoryInfo',
-  'data'  : { 'base-memory': 'size', '*plugged-memory': 'size' } }
-
-##
-# @query-memory-size-summary:
-#
-# Return the amount of initially allocated and present hotpluggable (if
-# enabled) memory in bytes.
-#
-# Example:
-#
-# -> { "execute": "query-memory-size-summary" }
-# <- { "return": { "base-memory": 4294967296, "plugged-memory": 0 } }
-#
-# Since: 2.11.0
-##
-{ 'command': 'query-memory-size-summary', 'returns': 'MemoryInfo' }
-
-
 ##
 # @AddfdInfo:
 #
@@ -1154,190 +1121,6 @@
  'returns': ['CommandLineOptionInfo'],
  'allow-preconfig': true }
 
-##
-# @PCDIMMDeviceInfo:
-#
-# PCDIMMDevice state information
-#
-# @id: device's ID
-#
-# @addr: physical address, where device is mapped
-#
-# @size: size of memory that the device provides
-#
-# @slot: slot number at which device is plugged in
-#
-# @node: NUMA node number where device is plugged in
-#
-# @memdev: memory backend linked with device
-#
-# @hotplugged: true if device was hotplugged
-#
-# @hotpluggable: true if device if could be added/removed while machine is running
-#
-# Since: 2.1
-##
-{ 'struct': 'PCDIMMDeviceInfo',
-  'data': { '*id': 'str',
-            'addr': 'int',
-            'size': 'int',
-            'slot': 'int',
-            'node': 'int',
-            'memdev': 'str',
-            'hotplugged': 'bool',
-            'hotpluggable': 'bool'
-          }
-}
-
-##
-# @VirtioPMEMDeviceInfo:
-#
-# VirtioPMEM state information
-#
-# @id: device's ID
-#
-# @memaddr: physical address in memory, where device is mapped
-#
-# @size: size of memory that the device provides
-#
-# @memdev: memory backend linked with device
-#
-# Since: 4.1
-##
-{ 'struct': 'VirtioPMEMDeviceInfo',
-  'data': { '*id': 'str',
-            'memaddr': 'size',
-            'size': 'size',
-            'memdev': 'str'
-          }
-}
-
-##
-# @VirtioMEMDeviceInfo:
-#
-# VirtioMEMDevice state information
-#
-# @id: device's ID
-#
-# @memaddr: physical address in memory, where device is mapped
-#
-# @requested-size: the user requested size of the device
-#
-# @size: the (current) size of memory that the device provides
-#
-# @max-size: the maximum size of memory that the device can provide
-#
-# @block-size: the block size of memory that the device provides
-#
-# @node: NUMA node number where device is assigned to
-#
-# @memdev: memory backend linked with the region
-#
-# Since: 5.1
-##
-{ 'struct': 'VirtioMEMDeviceInfo',
-  'data': { '*id': 'str',
-            'memaddr': 'size',
-            'requested-size': 'size',
-            'size': 'size',
-            'max-size': 'size',
-            'block-size': 'size',
-            'node': 'int',
-            'memdev': 'str'
-          }
-}
-
-##
-# @MemoryDeviceInfo:
-#
-# Union containing information about a memory device
-#
-# nvdimm is included since 2.12. virtio-pmem is included since 4.1.
-# virtio-mem is included since 5.1.
-#
-# Since: 2.1
-##
-{ 'union': 'MemoryDeviceInfo',
-  'data': { 'dimm': 'PCDIMMDeviceInfo',
-            'nvdimm': 'PCDIMMDeviceInfo',
-            'virtio-pmem': 'VirtioPMEMDeviceInfo',
-            'virtio-mem': 'VirtioMEMDeviceInfo'
-          }
-}
-
-##
-# @query-memory-devices:
-#
-# Lists available memory devices and their state
-#
-# Since: 2.1
-#
-# Example:
-#
-# -> { "execute": "query-memory-devices" }
-# <- { "return": [ { "data":
-#                       { "addr": 5368709120,
-#                         "hotpluggable": true,
-#                         "hotplugged": true,
-#                         "id": "d1",
-#                         "memdev": "/objects/memX",
-#                         "node": 0,
-#                         "size": 1073741824,
-#                         "slot": 0},
-#                    "type": "dimm"
-#                  } ] }
-#
-##
-{ 'command': 'query-memory-devices', 'returns': ['MemoryDeviceInfo'] }
-
-##
-# @MEMORY_DEVICE_SIZE_CHANGE:
-#
-# Emitted when the size of a memory device changes. Only emitted for memory
-# devices that can actually change the size (e.g., virtio-mem due to guest
-# action).
-#
-# @id: device's ID
-# @size: the new size of memory that the device provides
-#
-# Note: this event is rate-limited.
-#
-# Since: 5.1
-#
-# Example:
-#
-# <- { "event": "MEMORY_DEVICE_SIZE_CHANGE",
-#      "data": { "id": "vm0", "size": 1073741824},
-#      "timestamp": { "seconds": 1588168529, "microseconds": 201316 } }
-#
-##
-{ 'event': 'MEMORY_DEVICE_SIZE_CHANGE',
-  'data': { '*id': 'str', 'size': 'size' } }
-
-
-##
-# @MEM_UNPLUG_ERROR:
-#
-# Emitted when memory hot unplug error occurs.
-#
-# @device: device name
-#
-# @msg: Informative message
-#
-# Since: 2.4
-#
-# Example:
-#
-# <- { "event": "MEM_UNPLUG_ERROR"
-#      "data": { "device": "dimm1",
-#                "msg": "acpi: device unplug for unsupported device"
-#      },
-#      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
-#
-##
-{ 'event': 'MEM_UNPLUG_ERROR',
-  'data': { 'device': 'str', 'msg': 'str' } }
-
 ##
 # @ACPISlotType:
 #
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index cde52e83c9..30d7e99f52 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -14,7 +14,7 @@
 #define MEMORY_DEVICE_H
 
 #include "hw/qdev-core.h"
-#include "qapi/qapi-types-misc.h"
+#include "qapi/qapi-types-machine.h"
 #include "qom/object.h"
 
 #define TYPE_MEMORY_DEVICE "memory-device"
diff --git a/include/hw/virtio/virtio-pmem.h b/include/hw/virtio/virtio-pmem.h
index 66b590821e..fc4fd1f7fe 100644
--- a/include/hw/virtio/virtio-pmem.h
+++ b/include/hw/virtio/virtio-pmem.h
@@ -15,7 +15,7 @@
 #define HW_VIRTIO_PMEM_H
 
 #include "hw/virtio/virtio.h"
-#include "qapi/qapi-types-misc.h"
+#include "qapi/qapi-types-machine.h"
 #include "qom/object.h"
 
 #define TYPE_VIRTIO_PMEM "virtio-pmem"
diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index 8d2e82240f..dfe57af429 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -7,6 +7,7 @@
 #include "migration/vmstate.h"
 #include "trace.h"
 #include "qapi/error.h"
+#include "qapi/qapi-events-machine.h"
 #include "qapi/qapi-events-misc.h"
 
 #define MEMORY_SLOTS_NUMBER          "MDNR"
diff --git a/hw/virtio/virtio-mem-pci.c b/hw/virtio/virtio-mem-pci.c
index 590cec041b..913f4a3326 100644
--- a/hw/virtio/virtio-mem-pci.c
+++ b/hw/virtio/virtio-mem-pci.c
@@ -14,6 +14,7 @@
 #include "virtio-mem-pci.h"
 #include "hw/mem/memory-device.h"
 #include "qapi/error.h"
+#include "qapi/qapi-events-machine.h"
 #include "qapi/qapi-events-misc.h"
 
 static void virtio_mem_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
-- 
2.26.2


