Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A3DC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 15:32:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE3A82087C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 15:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eODm9U66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE3A82087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGOYo-0000Cw-Vv
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 11:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGOQ1-0004Ur-TJ
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 11:23:30 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42500
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGOPy-000853-Dy
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 11:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599751401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2yxXZD8J+IHazZUEfYGbKM4tEb0OF8qwppJW+h4DFJU=;
 b=eODm9U66WCJOJ2ExlfX2iwmj/I7ditJWAepwolmQCp4e3tb+tu7VCQdnFGfuKx7BU96o5y
 aZQ5ASPDSMNf4EAHg/9qYp3tphxyYim76u6lG1xcpIMjogGQ8bTZ623vHQ3g4JuvG60hXU
 OgVTZ3SfIqFTWfOZ94YomAe2Cp9RkGY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-lEo_4RRONq-zHYOHRdzXjA-1; Thu, 10 Sep 2020 11:23:19 -0400
X-MC-Unique: lEo_4RRONq-zHYOHRdzXjA-1
Received: by mail-wr1-f71.google.com with SMTP id o6so2377235wrp.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 08:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2yxXZD8J+IHazZUEfYGbKM4tEb0OF8qwppJW+h4DFJU=;
 b=OLqJKQaOmb3YwQ3lv7YzUZ6rngNUgjka9niHjKdh8khza7vUyOoxfXWRN34e5eak4X
 +/pUmzvBoR4GVCRsKKgUsrqd1lCZKFNfaBGnMp0Eo6PPBU2vzHSFZ9BmA2OXOG+Sh6hy
 MC0lk9yt8Lyku0Bw4E0h81S5hQea5vZTITLbtqXKOKIu3KT56lTgki7MnSmy8wzBbabg
 PnjpZdh4fM4b1x3qjE8iw0Vgxrnl4G2YyFR/5cQ5cN5W7ukywtrV3ASdriTGBHwDrVTm
 4MpStp4orTe0bMh67CKBSRsr6oXAYINyWW47Uzc2UlrFtwvZDyRT/WFq8mGObLosCqEm
 aAgA==
X-Gm-Message-State: AOAM531lUFx3pvQOoVt7wmA/WmmZCnJJtQLlokpa5hObuYF2YkV9yVhu
 3u3wFV/ofqfbUqOtrTwHCRfc2cjPpLA+WJZLxsjlyhK96cdR75RLqSqDcT/Hv5LzDjOBvcZMYxo
 dTJoR+x5U1niOvys=
X-Received: by 2002:a1c:7502:: with SMTP id o2mr498233wmc.29.1599751396978;
 Thu, 10 Sep 2020 08:23:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHqW1zBqCrvwx9ArWSNr5VXpoEhFKzamZ+fPmoYHmJCzkJJFyYTzcLapQZJ9KWUUGW64ExXg==
X-Received: by 2002:a1c:7502:: with SMTP id o2mr498195wmc.29.1599751396602;
 Thu, 10 Sep 2020 08:23:16 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id s17sm9847044wrr.40.2020.09.10.08.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 08:23:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 9/9] qapi: Extract PCI commands to 'pci.json'
Date: Thu, 10 Sep 2020 17:22:25 +0200
Message-Id: <20200910152225.524322-10-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910152225.524322-1-philmd@redhat.com>
References: <20200910152225.524322-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 08:38:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>,
 David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Lieven <pl@kamp.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Only qemu-system-FOO and qemu-storage-daemon provide QMP
monitors, therefore such declarations and definitions are
irrelevant for user-mode emulation.

Extracting the PCI commands to their own schema reduces
the size of the qapi-misc* headers generated, and allows
pulling less declarations/definitions to user-mode.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
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
index 4b00b18e547..694d2142f37 100644
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
index 00000000000..b79cbd787be
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
index 4d8b3a9afe2..54c8ba64441 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -86,3 +86,4 @@
 { 'include': 'misc-target.json' }
 { 'include': 'audio.json' }
 { 'include': 'acpi.json' }
+{ 'include': 'pci.json' }
diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
index cc2a2e1f735..3a027c42e43 100644
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
index de0fae10ab9..e950e72d848 100644
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
index de01ba20845..dc0de392196 100644
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
index acc40633fdc..7814dd187de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1598,6 +1598,7 @@ F: include/hw/pci/*
 F: hw/misc/pci-testdev.c
 F: hw/pci/*
 F: hw/pci-bridge/*
+F: qapi/pci.json
 F: docs/pci*
 F: docs/specs/*pci*
 F: default-configs/pci.mak
diff --git a/qapi/meson.build b/qapi/meson.build
index f57acc24026..298b510492b 100644
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


