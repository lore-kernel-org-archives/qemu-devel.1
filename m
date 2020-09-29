Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD22C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:24:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF2F2076B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sof5tra3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF2F2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNMAe-0007Cw-0O
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 16:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNM68-0001nI-GI
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:19:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26342)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNM62-0003UF-NR
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:19:40 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601410773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hcxMoybGVAVk+zhb7G9oVk0b12g9DqOFO6UWlKHtzto=;
 b=Sof5tra3hyNGSlCI7NJSOVPG4Tt4aPJii4iyiE9Xy5/dqxOVDlcW5iYdNoQ+AqA2Z3tSfB
 egGVVnBBYiA4VcERDjXbpYn++WQiosXVJW5D5oHSH4T8HPo1pinsIUXUq9o/d9ms8b95cn
 ZMefcIsiwvTh4iO6efC5cR1r3TdhGGM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-QxlwWTU5Pz2GL62hGrfENg-1; Tue, 29 Sep 2020 16:19:31 -0400
X-MC-Unique: QxlwWTU5Pz2GL62hGrfENg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B62D801AE2;
 Tue, 29 Sep 2020 20:19:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B310F5C1C4;
 Tue, 29 Sep 2020 20:19:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AB3A611358BE; Tue, 29 Sep 2020 22:19:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/29] qapi: Extract PCI commands to 'pci.json'
Date: Tue, 29 Sep 2020 22:19:05 +0200
Message-Id: <20200929201926.2155622-9-armbru@redhat.com>
In-Reply-To: <20200929201926.2155622-1-armbru@redhat.com>
References: <20200929201926.2155622-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Only qemu-system-FOO and qemu-storage-daemon provide QMP
monitors, therefore such declarations and definitions are
irrelevant for user-mode emulation.

Extracting the PCI commands to their own schema reduces the size of
the qapi-misc* headers generated, and pulls less QAPI-generated code
into user-mode.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200913195348.1064154-9-philmd@redhat.com>
[Commit message tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/misc.json        | 306 ----------------------------------------
 qapi/pci.json         | 316 ++++++++++++++++++++++++++++++++++++++++++
 qapi/qapi-schema.json |   1 +
 hw/pci/pci-stub.c     |   2 +-
 hw/pci/pci.c          |   2 +-
 monitor/hmp-cmds.c    |   1 +
 MAINTAINERS           |   1 +
 qapi/meson.build      |   1 +
 8 files changed, 322 insertions(+), 308 deletions(-)
 create mode 100644 qapi/pci.json

diff --git a/qapi/misc.json b/qapi/misc.json
index 4b00b18e54..694d2142f3 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -157,312 +157,6 @@
 { 'command': 'query-iothreads', 'returns': ['IOThreadInfo'],
   'allow-preconfig': true }
 
-##
-# @PciMemoryRange:
-#
-# A PCI device memory region
-#
-# @base: the starting address (guest physical)
-#
-# @limit: the ending address (guest physical)
-#
-# Since: 0.14.0
-##
-{ 'struct': 'PciMemoryRange', 'data': {'base': 'int', 'limit': 'int'} }
-
-##
-# @PciMemoryRegion:
-#
-# Information about a PCI device I/O region.
-#
-# @bar: the index of the Base Address Register for this region
-#
-# @type: - 'io' if the region is a PIO region
-#        - 'memory' if the region is a MMIO region
-#
-# @size: memory size
-#
-# @prefetch: if @type is 'memory', true if the memory is prefetchable
-#
-# @mem_type_64: if @type is 'memory', true if the BAR is 64-bit
-#
-# Since: 0.14.0
-##
-{ 'struct': 'PciMemoryRegion',
-  'data': {'bar': 'int', 'type': 'str', 'address': 'int', 'size': 'int',
-           '*prefetch': 'bool', '*mem_type_64': 'bool' } }
-
-##
-# @PciBusInfo:
-#
-# Information about a bus of a PCI Bridge device
-#
-# @number: primary bus interface number.  This should be the number of the
-#          bus the device resides on.
-#
-# @secondary: secondary bus interface number.  This is the number of the
-#             main bus for the bridge
-#
-# @subordinate: This is the highest number bus that resides below the
-#               bridge.
-#
-# @io_range: The PIO range for all devices on this bridge
-#
-# @memory_range: The MMIO range for all devices on this bridge
-#
-# @prefetchable_range: The range of prefetchable MMIO for all devices on
-#                      this bridge
-#
-# Since: 2.4
-##
-{ 'struct': 'PciBusInfo',
-  'data': {'number': 'int', 'secondary': 'int', 'subordinate': 'int',
-           'io_range': 'PciMemoryRange',
-           'memory_range': 'PciMemoryRange',
-           'prefetchable_range': 'PciMemoryRange' } }
-
-##
-# @PciBridgeInfo:
-#
-# Information about a PCI Bridge device
-#
-# @bus: information about the bus the device resides on
-#
-# @devices: a list of @PciDeviceInfo for each device on this bridge
-#
-# Since: 0.14.0
-##
-{ 'struct': 'PciBridgeInfo',
-  'data': {'bus': 'PciBusInfo', '*devices': ['PciDeviceInfo']} }
-
-##
-# @PciDeviceClass:
-#
-# Information about the Class of a PCI device
-#
-# @desc: a string description of the device's class
-#
-# @class: the class code of the device
-#
-# Since: 2.4
-##
-{ 'struct': 'PciDeviceClass',
-  'data': {'*desc': 'str', 'class': 'int'} }
-
-##
-# @PciDeviceId:
-#
-# Information about the Id of a PCI device
-#
-# @device: the PCI device id
-#
-# @vendor: the PCI vendor id
-#
-# @subsystem: the PCI subsystem id (since 3.1)
-#
-# @subsystem-vendor: the PCI subsystem vendor id (since 3.1)
-#
-# Since: 2.4
-##
-{ 'struct': 'PciDeviceId',
-  'data': {'device': 'int', 'vendor': 'int', '*subsystem': 'int',
-            '*subsystem-vendor': 'int'} }
-
-##
-# @PciDeviceInfo:
-#
-# Information about a PCI device
-#
-# @bus: the bus number of the device
-#
-# @slot: the slot the device is located in
-#
-# @function: the function of the slot used by the device
-#
-# @class_info: the class of the device
-#
-# @id: the PCI device id
-#
-# @irq: if an IRQ is assigned to the device, the IRQ number
-#
-# @irq_pin: the IRQ pin, zero means no IRQ (since 5.1)
-#
-# @qdev_id: the device name of the PCI device
-#
-# @pci_bridge: if the device is a PCI bridge, the bridge information
-#
-# @regions: a list of the PCI I/O regions associated with the device
-#
-# Notes: the contents of @class_info.desc are not stable and should only be
-#        treated as informational.
-#
-# Since: 0.14.0
-##
-{ 'struct': 'PciDeviceInfo',
-  'data': {'bus': 'int', 'slot': 'int', 'function': 'int',
-           'class_info': 'PciDeviceClass', 'id': 'PciDeviceId',
-           '*irq': 'int', 'irq_pin': 'int', 'qdev_id': 'str',
-           '*pci_bridge': 'PciBridgeInfo', 'regions': ['PciMemoryRegion'] }}
-
-##
-# @PciInfo:
-#
-# Information about a PCI bus
-#
-# @bus: the bus index
-#
-# @devices: a list of devices on this bus
-#
-# Since: 0.14.0
-##
-{ 'struct': 'PciInfo', 'data': {'bus': 'int', 'devices': ['PciDeviceInfo']} }
-
-##
-# @query-pci:
-#
-# Return information about the PCI bus topology of the guest.
-#
-# Returns: a list of @PciInfo for each PCI bus. Each bus is
-#          represented by a json-object, which has a key with a json-array of
-#          all PCI devices attached to it. Each device is represented by a
-#          json-object.
-#
-# Since: 0.14.0
-#
-# Example:
-#
-# -> { "execute": "query-pci" }
-# <- { "return": [
-#          {
-#             "bus": 0,
-#             "devices": [
-#                {
-#                   "bus": 0,
-#                   "qdev_id": "",
-#                   "slot": 0,
-#                   "class_info": {
-#                      "class": 1536,
-#                      "desc": "Host bridge"
-#                   },
-#                   "id": {
-#                      "device": 32902,
-#                      "vendor": 4663
-#                   },
-#                   "function": 0,
-#                   "regions": [
-#                   ]
-#                },
-#                {
-#                   "bus": 0,
-#                   "qdev_id": "",
-#                   "slot": 1,
-#                   "class_info": {
-#                      "class": 1537,
-#                      "desc": "ISA bridge"
-#                   },
-#                   "id": {
-#                      "device": 32902,
-#                      "vendor": 28672
-#                   },
-#                   "function": 0,
-#                   "regions": [
-#                   ]
-#                },
-#                {
-#                   "bus": 0,
-#                   "qdev_id": "",
-#                   "slot": 1,
-#                   "class_info": {
-#                      "class": 257,
-#                      "desc": "IDE controller"
-#                   },
-#                   "id": {
-#                      "device": 32902,
-#                      "vendor": 28688
-#                   },
-#                   "function": 1,
-#                   "regions": [
-#                      {
-#                         "bar": 4,
-#                         "size": 16,
-#                         "address": 49152,
-#                         "type": "io"
-#                      }
-#                   ]
-#                },
-#                {
-#                   "bus": 0,
-#                   "qdev_id": "",
-#                   "slot": 2,
-#                   "class_info": {
-#                      "class": 768,
-#                      "desc": "VGA controller"
-#                   },
-#                   "id": {
-#                      "device": 4115,
-#                      "vendor": 184
-#                   },
-#                   "function": 0,
-#                   "regions": [
-#                      {
-#                         "prefetch": true,
-#                         "mem_type_64": false,
-#                         "bar": 0,
-#                         "size": 33554432,
-#                         "address": 4026531840,
-#                         "type": "memory"
-#                      },
-#                      {
-#                         "prefetch": false,
-#                         "mem_type_64": false,
-#                         "bar": 1,
-#                         "size": 4096,
-#                         "address": 4060086272,
-#                         "type": "memory"
-#                      },
-#                      {
-#                         "prefetch": false,
-#                         "mem_type_64": false,
-#                         "bar": 6,
-#                         "size": 65536,
-#                         "address": -1,
-#                         "type": "memory"
-#                      }
-#                   ]
-#                },
-#                {
-#                   "bus": 0,
-#                   "qdev_id": "",
-#                   "irq": 11,
-#                   "slot": 4,
-#                   "class_info": {
-#                      "class": 1280,
-#                      "desc": "RAM controller"
-#                   },
-#                   "id": {
-#                      "device": 6900,
-#                      "vendor": 4098
-#                   },
-#                   "function": 0,
-#                   "regions": [
-#                      {
-#                         "bar": 0,
-#                         "size": 32,
-#                         "address": 49280,
-#                         "type": "io"
-#                      }
-#                   ]
-#                }
-#             ]
-#          }
-#       ]
-#    }
-#
-# Note: This example has been shortened as the real response is too long.
-#
-##
-{ 'command': 'query-pci', 'returns': ['PciInfo'] }
-
 ##
 # @stop:
 #
diff --git a/qapi/pci.json b/qapi/pci.json
new file mode 100644
index 0000000000..b79cbd787b
--- /dev/null
+++ b/qapi/pci.json
@@ -0,0 +1,316 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+##
+# = PCI
+##
+
+##
+# @PciMemoryRange:
+#
+# A PCI device memory region
+#
+# @base: the starting address (guest physical)
+#
+# @limit: the ending address (guest physical)
+#
+# Since: 0.14.0
+##
+{ 'struct': 'PciMemoryRange', 'data': {'base': 'int', 'limit': 'int'} }
+
+##
+# @PciMemoryRegion:
+#
+# Information about a PCI device I/O region.
+#
+# @bar: the index of the Base Address Register for this region
+#
+# @type: - 'io' if the region is a PIO region
+#        - 'memory' if the region is a MMIO region
+#
+# @size: memory size
+#
+# @prefetch: if @type is 'memory', true if the memory is prefetchable
+#
+# @mem_type_64: if @type is 'memory', true if the BAR is 64-bit
+#
+# Since: 0.14.0
+##
+{ 'struct': 'PciMemoryRegion',
+  'data': {'bar': 'int', 'type': 'str', 'address': 'int', 'size': 'int',
+           '*prefetch': 'bool', '*mem_type_64': 'bool' } }
+
+##
+# @PciBusInfo:
+#
+# Information about a bus of a PCI Bridge device
+#
+# @number: primary bus interface number.  This should be the number of the
+#          bus the device resides on.
+#
+# @secondary: secondary bus interface number.  This is the number of the
+#             main bus for the bridge
+#
+# @subordinate: This is the highest number bus that resides below the
+#               bridge.
+#
+# @io_range: The PIO range for all devices on this bridge
+#
+# @memory_range: The MMIO range for all devices on this bridge
+#
+# @prefetchable_range: The range of prefetchable MMIO for all devices on
+#                      this bridge
+#
+# Since: 2.4
+##
+{ 'struct': 'PciBusInfo',
+  'data': {'number': 'int', 'secondary': 'int', 'subordinate': 'int',
+           'io_range': 'PciMemoryRange',
+           'memory_range': 'PciMemoryRange',
+           'prefetchable_range': 'PciMemoryRange' } }
+
+##
+# @PciBridgeInfo:
+#
+# Information about a PCI Bridge device
+#
+# @bus: information about the bus the device resides on
+#
+# @devices: a list of @PciDeviceInfo for each device on this bridge
+#
+# Since: 0.14.0
+##
+{ 'struct': 'PciBridgeInfo',
+  'data': {'bus': 'PciBusInfo', '*devices': ['PciDeviceInfo']} }
+
+##
+# @PciDeviceClass:
+#
+# Information about the Class of a PCI device
+#
+# @desc: a string description of the device's class
+#
+# @class: the class code of the device
+#
+# Since: 2.4
+##
+{ 'struct': 'PciDeviceClass',
+  'data': {'*desc': 'str', 'class': 'int'} }
+
+##
+# @PciDeviceId:
+#
+# Information about the Id of a PCI device
+#
+# @device: the PCI device id
+#
+# @vendor: the PCI vendor id
+#
+# @subsystem: the PCI subsystem id (since 3.1)
+#
+# @subsystem-vendor: the PCI subsystem vendor id (since 3.1)
+#
+# Since: 2.4
+##
+{ 'struct': 'PciDeviceId',
+  'data': {'device': 'int', 'vendor': 'int', '*subsystem': 'int',
+            '*subsystem-vendor': 'int'} }
+
+##
+# @PciDeviceInfo:
+#
+# Information about a PCI device
+#
+# @bus: the bus number of the device
+#
+# @slot: the slot the device is located in
+#
+# @function: the function of the slot used by the device
+#
+# @class_info: the class of the device
+#
+# @id: the PCI device id
+#
+# @irq: if an IRQ is assigned to the device, the IRQ number
+#
+# @irq_pin: the IRQ pin, zero means no IRQ (since 5.1)
+#
+# @qdev_id: the device name of the PCI device
+#
+# @pci_bridge: if the device is a PCI bridge, the bridge information
+#
+# @regions: a list of the PCI I/O regions associated with the device
+#
+# Notes: the contents of @class_info.desc are not stable and should only be
+#        treated as informational.
+#
+# Since: 0.14.0
+##
+{ 'struct': 'PciDeviceInfo',
+  'data': {'bus': 'int', 'slot': 'int', 'function': 'int',
+           'class_info': 'PciDeviceClass', 'id': 'PciDeviceId',
+           '*irq': 'int', 'irq_pin': 'int', 'qdev_id': 'str',
+           '*pci_bridge': 'PciBridgeInfo', 'regions': ['PciMemoryRegion'] }}
+
+##
+# @PciInfo:
+#
+# Information about a PCI bus
+#
+# @bus: the bus index
+#
+# @devices: a list of devices on this bus
+#
+# Since: 0.14.0
+##
+{ 'struct': 'PciInfo', 'data': {'bus': 'int', 'devices': ['PciDeviceInfo']} }
+
+##
+# @query-pci:
+#
+# Return information about the PCI bus topology of the guest.
+#
+# Returns: a list of @PciInfo for each PCI bus. Each bus is
+#          represented by a json-object, which has a key with a json-array of
+#          all PCI devices attached to it. Each device is represented by a
+#          json-object.
+#
+# Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "query-pci" }
+# <- { "return": [
+#          {
+#             "bus": 0,
+#             "devices": [
+#                {
+#                   "bus": 0,
+#                   "qdev_id": "",
+#                   "slot": 0,
+#                   "class_info": {
+#                      "class": 1536,
+#                      "desc": "Host bridge"
+#                   },
+#                   "id": {
+#                      "device": 32902,
+#                      "vendor": 4663
+#                   },
+#                   "function": 0,
+#                   "regions": [
+#                   ]
+#                },
+#                {
+#                   "bus": 0,
+#                   "qdev_id": "",
+#                   "slot": 1,
+#                   "class_info": {
+#                      "class": 1537,
+#                      "desc": "ISA bridge"
+#                   },
+#                   "id": {
+#                      "device": 32902,
+#                      "vendor": 28672
+#                   },
+#                   "function": 0,
+#                   "regions": [
+#                   ]
+#                },
+#                {
+#                   "bus": 0,
+#                   "qdev_id": "",
+#                   "slot": 1,
+#                   "class_info": {
+#                      "class": 257,
+#                      "desc": "IDE controller"
+#                   },
+#                   "id": {
+#                      "device": 32902,
+#                      "vendor": 28688
+#                   },
+#                   "function": 1,
+#                   "regions": [
+#                      {
+#                         "bar": 4,
+#                         "size": 16,
+#                         "address": 49152,
+#                         "type": "io"
+#                      }
+#                   ]
+#                },
+#                {
+#                   "bus": 0,
+#                   "qdev_id": "",
+#                   "slot": 2,
+#                   "class_info": {
+#                      "class": 768,
+#                      "desc": "VGA controller"
+#                   },
+#                   "id": {
+#                      "device": 4115,
+#                      "vendor": 184
+#                   },
+#                   "function": 0,
+#                   "regions": [
+#                      {
+#                         "prefetch": true,
+#                         "mem_type_64": false,
+#                         "bar": 0,
+#                         "size": 33554432,
+#                         "address": 4026531840,
+#                         "type": "memory"
+#                      },
+#                      {
+#                         "prefetch": false,
+#                         "mem_type_64": false,
+#                         "bar": 1,
+#                         "size": 4096,
+#                         "address": 4060086272,
+#                         "type": "memory"
+#                      },
+#                      {
+#                         "prefetch": false,
+#                         "mem_type_64": false,
+#                         "bar": 6,
+#                         "size": 65536,
+#                         "address": -1,
+#                         "type": "memory"
+#                      }
+#                   ]
+#                },
+#                {
+#                   "bus": 0,
+#                   "qdev_id": "",
+#                   "irq": 11,
+#                   "slot": 4,
+#                   "class_info": {
+#                      "class": 1280,
+#                      "desc": "RAM controller"
+#                   },
+#                   "id": {
+#                      "device": 6900,
+#                      "vendor": 4098
+#                   },
+#                   "function": 0,
+#                   "regions": [
+#                      {
+#                         "bar": 0,
+#                         "size": 32,
+#                         "address": 49280,
+#                         "type": "io"
+#                      }
+#                   ]
+#                }
+#             ]
+#          }
+#       ]
+#    }
+#
+# Note: This example has been shortened as the real response is too long.
+#
+##
+{ 'command': 'query-pci', 'returns': ['PciInfo'] }
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 4d8b3a9afe..54c8ba6444 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -86,3 +86,4 @@
 { 'include': 'misc-target.json' }
 { 'include': 'audio.json' }
 { 'include': 'acpi.json' }
+{ 'include': 'pci.json' }
diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
index cc2a2e1f73..3a027c42e4 100644
--- a/hw/pci/pci-stub.c
+++ b/hw/pci/pci-stub.c
@@ -22,7 +22,7 @@
 #include "sysemu/sysemu.h"
 #include "monitor/monitor.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-pci.h"
 #include "qapi/qmp/qerror.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/msi.h"
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index fce725474b..3c8f10b461 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -46,7 +46,7 @@
 #include "hw/hotplug.h"
 #include "hw/boards.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-pci.h"
 #include "qemu/cutils.h"
 
 //#define DEBUG_PCI
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index de01ba2084..dc0de39219 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -36,6 +36,7 @@
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qapi-commands-net.h"
+#include "qapi/qapi-commands-pci.h"
 #include "qapi/qapi-commands-rocker.h"
 #include "qapi/qapi-commands-run-state.h"
 #include "qapi/qapi-commands-tpm.h"
diff --git a/MAINTAINERS b/MAINTAINERS
index f99b5db940..be0a8e648c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1617,6 +1617,7 @@ F: include/hw/pci/*
 F: hw/misc/pci-testdev.c
 F: hw/pci/*
 F: hw/pci-bridge/*
+F: qapi/pci.json
 F: docs/pci*
 F: docs/specs/*pci*
 F: default-configs/pci.mak
diff --git a/qapi/meson.build b/qapi/meson.build
index f57acc2402..298b510492 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -35,6 +35,7 @@ qapi_all_modules = [
   'net',
   'pragma',
   'qdev',
+  'pci',
   'qom',
   'rdma',
   'rocker',
-- 
2.26.2


