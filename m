Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE95C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:56:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2623E20658
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwgvONBM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2623E20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35637 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCpUD-0008S7-A5
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 14:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCpGo-0002g5-KN
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:42:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCpGm-0006bP-B1
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:42:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21104
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCpGm-0006aw-6V
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584124971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8zSwxlmr2wPfyeIRR4RQsnt89CbzAttVCTp/kZ1725M=;
 b=fwgvONBMfhaDYt/5PR63C3Y+9q8/nuMCD0gj1GYHAJMQN/AFtmV5waQ8rGQy/YWvsiSlcz
 QMyWvL2npkpcHZeDnOGa/l8hHi3NmYWsfLdsfgKB1bPJcNg2ZdhkyELnsjuhDA3ZsT4SWs
 IDZOKL8FsnWMsty2qw9rrUk6+wrfFeY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-aZNlXubwPN68Cu71s4G7Cw-1; Fri, 13 Mar 2020 14:42:39 -0400
X-MC-Unique: aZNlXubwPN68Cu71s4G7Cw-1
Received: by mail-wm1-f70.google.com with SMTP id x7so3306608wmi.4
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 11:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Q5EvLViKHIAiPNDw9slWpthe+gCfBn00bhTYG8gq+7s=;
 b=bnvZU9ussN0tr+cmGWrIsgvPK209TEN6E0nPOho/cGYDvbZHOBoRP0gamFW6KMRqmX
 CDG385nMUdSUo6XyvhTngV0o8pIHRFFfKccJ6ON/SDC/oL71SyShOHfYQEkqJdxy1QCE
 qFSwmokaFIb7X79aG5Ba2D8l6SYkusIOSKe3z8XMtHK5jI+Mz+T4odquJpXUpPBkbMWN
 AXfniVcsnzwL1mD796A3E5gSioGaNn/VvsKuGOYSUFTg7QkcsYjgeUjpwqpl+xd++MJ+
 gcd71vTwOy8S3qwRK6XLlLjtRtieTqbavGj7FF+pEpuudqzzS67HK7dq/uowhSkSN6w+
 BqGA==
X-Gm-Message-State: ANhLgQ0G6XEF4UzzJ+ukV6dNJq4Ox85f1kWgB9oQEfogP53c9O7ter7L
 9ybIxnZXHi5aw2XX9oiuye377nstNE0iknvKVEi09WoRI6udBGbCl0zgzQ1IG1INJHc3+VmM9Xq
 bcYw5iw2Vljl6lHY=
X-Received: by 2002:adf:a3d3:: with SMTP id m19mr18415776wrb.377.1584124955865; 
 Fri, 13 Mar 2020 11:42:35 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuYVKYbUp1dOFNTBu7i59wk2vn1seAUsjrRTfeorztzqE/Vc5YTABjqsH1iFJDw6h8J/Yw11Q==
X-Received: by 2002:adf:a3d3:: with SMTP id m19mr18415737wrb.377.1584124955422; 
 Fri, 13 Mar 2020 11:42:35 -0700 (PDT)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id o5sm19075067wmb.8.2020.03.13.11.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 11:42:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 8/9] qapi/misc: Restrict PCI commands to machine code
Date: Fri, 13 Mar 2020 19:41:52 +0100
Message-Id: <20200313184153.11275-9-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200313184153.11275-1-philmd@redhat.com>
References: <20200313184153.11275-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Ben Warren <ben@skyportsystems.com>, Peter Lieven <pl@kamp.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Igor Mammedov <imammedo@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 qapi/machine.json | 304 ++++++++++++++++++++++++++++++++++++++++++++++
 qapi/misc.json    | 304 ----------------------------------------------
 hw/pci/pci-stub.c |   2 +-
 hw/pci/pci.c      |   2 +-
 4 files changed, 306 insertions(+), 306 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index f77ee63730..33b259dbd0 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1172,3 +1172,307 @@
 ##
 { 'event': 'ACPI_DEVICE_OST',
      'data': { 'info': 'ACPIOSTInfo' } }
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
+# @qdev_id: the device name of the PCI device
+#
+# @pci_bridge: if the device is a PCI bridge, the bridge information
+#
+# @regions: a list of the PCI I/O regions associated with the device
+#
+# Notes: the contents of @class_info.desc are not stable and should only b=
e
+#        treated as informational.
+#
+# Since: 0.14.0
+##
+{ 'struct': 'PciDeviceInfo',
+  'data': {'bus': 'int', 'slot': 'int', 'function': 'int',
+           'class_info': 'PciDeviceClass', 'id': 'PciDeviceId',
+           '*irq': 'int', 'qdev_id': 'str', '*pci_bridge': 'PciBridgeInfo'=
,
+           'regions': ['PciMemoryRegion']} }
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
+{ 'struct': 'PciInfo', 'data': {'bus': 'int', 'devices': ['PciDeviceInfo']=
} }
+
+##
+# @query-pci:
+#
+# Return information about the PCI bus topology of the guest.
+#
+# Returns: a list of @PciInfo for each PCI bus. Each bus is
+#          represented by a json-object, which has a key with a json-array=
 of
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
diff --git a/qapi/misc.json b/qapi/misc.json
index 0cfefef017..699a533e6c 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -124,310 +124,6 @@
 { 'command': 'query-iothreads', 'returns': ['IOThreadInfo'],
   'allow-preconfig': true }
=20
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
-# @qdev_id: the device name of the PCI device
-#
-# @pci_bridge: if the device is a PCI bridge, the bridge information
-#
-# @regions: a list of the PCI I/O regions associated with the device
-#
-# Notes: the contents of @class_info.desc are not stable and should only b=
e
-#        treated as informational.
-#
-# Since: 0.14.0
-##
-{ 'struct': 'PciDeviceInfo',
-  'data': {'bus': 'int', 'slot': 'int', 'function': 'int',
-           'class_info': 'PciDeviceClass', 'id': 'PciDeviceId',
-           '*irq': 'int', 'qdev_id': 'str', '*pci_bridge': 'PciBridgeInfo'=
,
-           'regions': ['PciMemoryRegion']} }
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
-{ 'struct': 'PciInfo', 'data': {'bus': 'int', 'devices': ['PciDeviceInfo']=
} }
-
-##
-# @query-pci:
-#
-# Return information about the PCI bus topology of the guest.
-#
-# Returns: a list of @PciInfo for each PCI bus. Each bus is
-#          represented by a json-object, which has a key with a json-array=
 of
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
diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
index cc2a2e1f73..b50c7ca590 100644
--- a/hw/pci/pci-stub.c
+++ b/hw/pci/pci-stub.c
@@ -22,7 +22,7 @@
 #include "sysemu/sysemu.h"
 #include "monitor/monitor.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-machine.h"
 #include "qapi/qmp/qerror.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/msi.h"
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index e1ed6677e1..5ebc783d57 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -46,7 +46,7 @@
 #include "hw/hotplug.h"
 #include "hw/boards.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-machine.h"
 #include "qemu/cutils.h"
=20
 //#define DEBUG_PCI
--=20
2.21.1


