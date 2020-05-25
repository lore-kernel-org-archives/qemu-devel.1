Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418A5C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:11:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0B382073B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3+FBUrJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B382073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdElO-0002sP-5H
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 11:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdEhc-0006Aw-T6
 for qemu-devel@nongnu.org; Mon, 25 May 2020 11:07:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47931
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdEhb-0006pc-1i
 for qemu-devel@nongnu.org; Mon, 25 May 2020 11:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590419262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=weWxNPbVdQ3MTKccN/ZjEjAT/VhUoUmdY4b4staYdWU=;
 b=D3+FBUrJDNzmfHlJRAErPMh+zM7SOLFo14n4MKWBuwOjC0zUcj3jH7TqanPf1vr4jZyhPD
 yIqKW+HZJt28+e8P2NuI92LIU+v5tiHnI4AZUjPBh8IGP1+hKa2IqPa/I76MDr3X+dGAme
 fgUGOeTB9SjAABX5U2LT8jN8h+4Rc6A=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-qLZOQ1suPd20S0OHY3Icmg-1; Mon, 25 May 2020 11:07:40 -0400
X-MC-Unique: qLZOQ1suPd20S0OHY3Icmg-1
Received: by mail-ed1-f69.google.com with SMTP id g10so7610230edt.3
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 08:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=weWxNPbVdQ3MTKccN/ZjEjAT/VhUoUmdY4b4staYdWU=;
 b=bWK4WKQrrfTOK7EYtDbUB0EaTaPDTfyAj9StPOr1X1/+dTZ7eF+wEZB9Wzanh8fAIZ
 YXh36OXtfniJG1GD6Uj2JQMMexajCTQPT5AgkaKZeD8zMDr2dT+OvPaiFle/B4XllPBd
 +xY+tqPKdWjzoITaZYmesj6FcZwuhutyv8FdsrE7scaDDUpyodmm0bH83k7Og1NAI8Qc
 H9vspMviKIa6JxKuXKTW2a21P6WhvpqA0TkzhKYshTMl+wDBrQgpcvePEfqSuog54I1D
 FUGVzsoWItjEcL1rg3o+s9I9x4BSgxuu+Xmri3BtE0Yn6jPlzu2uYQq5AWViV+QgPdMA
 FRAA==
X-Gm-Message-State: AOAM533URog0TumwxVUsIfaYkTQoksOIKmHzInSC6OYXlOStFS/sYcke
 dmWCIGnFXfxWh8SpecVuMirIx3ADS04PyWIT1WKsuf979ud4kHb4g6HO8pUbzzyJoHSPIZN+coB
 t1FM7BbQ2ex4kWIE=
X-Received: by 2002:a17:906:9617:: with SMTP id
 s23mr18859487ejx.505.1590419258992; 
 Mon, 25 May 2020 08:07:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0IE+K4zLC2So3qXa3HkVhXPWoEg7qeP6z8H7ybzsEbyGgjySeeGCTQh4ahitlXrbpOdGy+g==
X-Received: by 2002:a17:906:9617:: with SMTP id
 s23mr18859460ejx.505.1590419258633; 
 Mon, 25 May 2020 08:07:38 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id cf7sm10835128edb.17.2020.05.25.08.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 08:07:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 9/9] qapi/misc: Restrict device memory commands to machine
 code
Date: Mon, 25 May 2020 17:06:40 +0200
Message-Id: <20200525150640.30879-10-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200525150640.30879-1-philmd@redhat.com>
References: <20200525150640.30879-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 08:28:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Acked-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 qapi/machine.json               | 131 +++++++++++++++++++++++++++++++
 qapi/misc.json                  | 132 --------------------------------
 include/hw/mem/memory-device.h  |   1 +
 include/hw/virtio/virtio-pmem.h |   2 +-
 4 files changed, 133 insertions(+), 133 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 3ab1089a44..d1490edeb1 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1519,3 +1519,134 @@
 #
 ##
 { 'command': 'query-pci', 'returns': ['PciInfo'] }
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
+# @MemoryDeviceInfo:
+#
+# Union containing information about a memory device
+#
+# nvdimm is included since 2.12. virtio-pmem is included since 4.1.
+#
+# Since: 2.1
+##
+{ 'union': 'MemoryDeviceInfo',
+  'data': { 'dimm': 'PCDIMMDeviceInfo',
+            'nvdimm': 'PCDIMMDeviceInfo',
+            'virtio-pmem': 'VirtioPMEMDeviceInfo'
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
diff --git a/qapi/misc.json b/qapi/misc.json
index 3f4add1c2e..d241f67bad 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -519,39 +519,6 @@
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
@@ -789,105 +756,6 @@
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
-# @MemoryDeviceInfo:
-#
-# Union containing information about a memory device
-#
-# nvdimm is included since 2.12. virtio-pmem is included since 4.1.
-#
-# Since: 2.1
-##
-{ 'union': 'MemoryDeviceInfo',
-  'data': { 'dimm': 'PCDIMMDeviceInfo',
-            'nvdimm': 'PCDIMMDeviceInfo',
-            'virtio-pmem': 'VirtioPMEMDeviceInfo'
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
 ##
 # @ReplayMode:
 #
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index 04476acb8f..76f3de0f7e 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -14,6 +14,7 @@
 #define MEMORY_DEVICE_H
 
 #include "hw/qdev-core.h"
+#include "qapi/qapi-types-machine.h"
 #include "qapi/qapi-types-misc.h"
 #include "qom/object.h"
 
diff --git a/include/hw/virtio/virtio-pmem.h b/include/hw/virtio/virtio-pmem.h
index 33f1999320..72863412b2 100644
--- a/include/hw/virtio/virtio-pmem.h
+++ b/include/hw/virtio/virtio-pmem.h
@@ -15,7 +15,7 @@
 #define HW_VIRTIO_PMEM_H
 
 #include "hw/virtio/virtio.h"
-#include "qapi/qapi-types-misc.h"
+#include "qapi/qapi-types-machine.h"
 
 #define TYPE_VIRTIO_PMEM "virtio-pmem"
 
-- 
2.21.3


