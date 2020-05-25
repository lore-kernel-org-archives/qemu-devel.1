Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFE5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:16:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEF5B2073B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ly8Ho+u1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF5B2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdEqT-0000su-Qa
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 11:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdEhY-000692-6V
 for qemu-devel@nongnu.org; Mon, 25 May 2020 11:07:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58257
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdEhW-0006ly-94
 for qemu-devel@nongnu.org; Mon, 25 May 2020 11:07:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590419257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DO/BvadkUCoefg0yYzYKVQLnmXpv83dYTuuAYZRTCz0=;
 b=Ly8Ho+u1itVHS+BLG9BXHjOLoYOTd5zSnPMghMYu7+b8edkBGKFQ/o/INFD1vV/2hY/M7o
 yco7pcCGyhWSVW+qTBGQT1jJAknf2ougg+GWzB3HxnS5SzD7i/6QMph/4Kl5aoi1K1NS1E
 yiGjGh4TUE1nJuoSPWpDO/J5/AHZmns=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-jnnKIBg1PTC-ldUiYBxicQ-1; Mon, 25 May 2020 11:07:36 -0400
X-MC-Unique: jnnKIBg1PTC-ldUiYBxicQ-1
Received: by mail-ej1-f71.google.com with SMTP id t26so6424682ejs.19
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 08:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DO/BvadkUCoefg0yYzYKVQLnmXpv83dYTuuAYZRTCz0=;
 b=Pti4Tb8yDAX6xa8+X6d7rEFRfjE/yaLqDXI0n5Sha1cdOIe9xui2rt62LxCmFNfb3Y
 yo1tF8+KQ2gYX69kj9k8tqlux1PgZzguNr0uN6NrsyHVV0U8jEVdljKK0JCm9O3IOTS1
 VpLfJvfxhxJBfqIIwJh53XvDsOy7q4hoG0vj/aV91oWRh6o23/DbktmOlJuo8lCKifTR
 NxSj8b2fcNwdCdp6MOgor21yCEG4AUq0bgTsOwfy9PpaMgaRfcAPL3pbEoyqvYTZ9/il
 k31jo/6jZOBhTl3iBEba4vC69YS474tPKp+5bpafbr8W3sxcz9sMCH0NnCCaji4rWJ63
 DHJQ==
X-Gm-Message-State: AOAM533d4bJy2hSEhOnNDj1xqQIxR5wws4p/v8HT29LISFf6av3d5Vy3
 G9UPBAmR1xmXUbfORP7d7PFVEQxt5xPKp5GOFiB+pPwIb2FaMBsOfr/uBvGJzh7XtlkbPdmHPdQ
 gvZz3+t6Am7FP1pA=
X-Received: by 2002:a05:6402:c0e:: with SMTP id
 co14mr15468548edb.177.1590419252910; 
 Mon, 25 May 2020 08:07:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzw7SsvlnPpjU/3yaSTAhtXmTPl1MhrdZWipZKU/I0EgM2TahrnYNSW5BzKSlTejjUrhmtXLg==
X-Received: by 2002:a05:6402:c0e:: with SMTP id
 co14mr15468523edb.177.1590419252578; 
 Mon, 25 May 2020 08:07:32 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id df21sm16145181edb.27.2020.05.25.08.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 08:07:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 8/9] qapi/misc: Restrict PCI commands to machine code
Date: Mon, 25 May 2020 17:06:39 +0200
Message-Id: <20200525150640.30879-9-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200525150640.30879-1-philmd@redhat.com>
References: <20200525150640.30879-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 01:44:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Ben Warren <ben@skyportsystems.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 qapi/machine.json | 304 ++++++++++++++++++++++++++++++++++++++++++++++
 qapi/misc.json    | 304 ----------------------------------------------
 hw/pci/pci-stub.c |   2 +-
 hw/pci/pci.c      |   2 +-
 4 files changed, 306 insertions(+), 306 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 04b124be67..3ab1089a44 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1215,3 +1215,307 @@
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
+# Notes: the contents of @class_info.desc are not stable and should only be
+#        treated as informational.
+#
+# Since: 0.14.0
+##
+{ 'struct': 'PciDeviceInfo',
+  'data': {'bus': 'int', 'slot': 'int', 'function': 'int',
+           'class_info': 'PciDeviceClass', 'id': 'PciDeviceId',
+           '*irq': 'int', 'qdev_id': 'str', '*pci_bridge': 'PciBridgeInfo',
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
diff --git a/qapi/misc.json b/qapi/misc.json
index ecceba9d32..3f4add1c2e 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -156,310 +156,6 @@
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
-           '*irq': 'int', 'qdev_id': 'str', '*pci_bridge': 'PciBridgeInfo',
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
index 70c66965f5..a8aa2aaa2f 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -46,7 +46,7 @@
 #include "hw/hotplug.h"
 #include "hw/boards.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-machine.h"
 #include "qemu/cutils.h"
 
 //#define DEBUG_PCI
-- 
2.21.3


