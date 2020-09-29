Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1120C47420
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:24:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12B8A2076D
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TgCm20UW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B8A2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNMAZ-00072F-Rn
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 16:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNM66-0001mD-Ge
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:19:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57377)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNM62-0003Ty-EM
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:19:38 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601410773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MBM/bVem2B9Oad7cMaVnTEsGxanjQ4A5fE9lM3vi2ps=;
 b=TgCm20UWgAnhu4Hwb8T7x9REtg7aGFJZ24tent+Z47FXFa+OCzI18EPPXUyfJiF9HqEhlZ
 AP3Fjn6Sfct+iRU4+BhmU0mad1VV2vZ3TsHmUN1xUcRf2+ceMa210B6RBNMLxS8a6mLkvG
 jA840wZbJrWdsde9MFTSEkWViRehUd8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-H5RWRhJUNNSsBYeeIJboVg-1; Tue, 29 Sep 2020 16:19:31 -0400
X-MC-Unique: H5RWRhJUNNSsBYeeIJboVg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 335B21040C22;
 Tue, 29 Sep 2020 20:19:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD31D7BE49;
 Tue, 29 Sep 2020 20:19:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A744411358BC; Tue, 29 Sep 2020 22:19:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/29] qapi: Extract ACPI commands to 'acpi.json'
Date: Tue, 29 Sep 2020 22:19:04 +0200
Message-Id: <20200929201926.2155622-8-armbru@redhat.com>
In-Reply-To: <20200929201926.2155622-1-armbru@redhat.com>
References: <20200929201926.2155622-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

Extracting the ACPI commands to their own schema reduces the size of
the qapi-misc* headers generated, and pulls less QAPI-generated code
into user-mode.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200913195348.1064154-8-philmd@redhat.com>
[Commit message tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/acpi.json                       | 141 +++++++++++++++++++++++++++
 qapi/misc.json                       | 131 -------------------------
 qapi/qapi-schema.json                |   1 +
 include/hw/acpi/acpi_dev_interface.h |   2 +-
 hw/acpi/core.c                       |   2 +-
 hw/acpi/cpu.c                        |   2 +-
 hw/acpi/memory_hotplug.c             |   2 +-
 monitor/qmp-cmds.c                   |   1 +
 MAINTAINERS                          |   1 +
 qapi/meson.build                     |   1 +
 10 files changed, 149 insertions(+), 135 deletions(-)
 create mode 100644 qapi/acpi.json

diff --git a/qapi/acpi.json b/qapi/acpi.json
new file mode 100644
index 0000000000..51f0d55db7
--- /dev/null
+++ b/qapi/acpi.json
@@ -0,0 +1,141 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+##
+# = ACPI
+##
+
+##
+# @AcpiTableOptions:
+#
+# Specify an ACPI table on the command line to load.
+#
+# At most one of @file and @data can be specified. The list of files specified
+# by any one of them is loaded and concatenated in order. If both are omitted,
+# @data is implied.
+#
+# Other fields / optargs can be used to override fields of the generic ACPI
+# table header; refer to the ACPI specification 5.0, section 5.2.6 System
+# Description Table Header. If a header field is not overridden, then the
+# corresponding value from the concatenated blob is used (in case of @file), or
+# it is filled in with a hard-coded value (in case of @data).
+#
+# String fields are copied into the matching ACPI member from lowest address
+# upwards, and silently truncated / NUL-padded to length.
+#
+# @sig: table signature / identifier (4 bytes)
+#
+# @rev: table revision number (dependent on signature, 1 byte)
+#
+# @oem_id: OEM identifier (6 bytes)
+#
+# @oem_table_id: OEM table identifier (8 bytes)
+#
+# @oem_rev: OEM-supplied revision number (4 bytes)
+#
+# @asl_compiler_id: identifier of the utility that created the table
+#                   (4 bytes)
+#
+# @asl_compiler_rev: revision number of the utility that created the
+#                    table (4 bytes)
+#
+# @file: colon (:) separated list of pathnames to load and
+#        concatenate as table data. The resultant binary blob is expected to
+#        have an ACPI table header. At least one file is required. This field
+#        excludes @data.
+#
+# @data: colon (:) separated list of pathnames to load and
+#        concatenate as table data. The resultant binary blob must not have an
+#        ACPI table header. At least one file is required. This field excludes
+#        @file.
+#
+# Since: 1.5
+##
+{ 'struct': 'AcpiTableOptions',
+  'data': {
+    '*sig':               'str',
+    '*rev':               'uint8',
+    '*oem_id':            'str',
+    '*oem_table_id':      'str',
+    '*oem_rev':           'uint32',
+    '*asl_compiler_id':   'str',
+    '*asl_compiler_rev':  'uint32',
+    '*file':              'str',
+    '*data':              'str' }}
+
+##
+# @ACPISlotType:
+#
+# @DIMM: memory slot
+# @CPU: logical CPU slot (since 2.7)
+##
+{ 'enum': 'ACPISlotType', 'data': [ 'DIMM', 'CPU' ] }
+
+##
+# @ACPIOSTInfo:
+#
+# OSPM Status Indication for a device
+# For description of possible values of @source and @status fields
+# see "_OST (OSPM Status Indication)" chapter of ACPI5.0 spec.
+#
+# @device: device ID associated with slot
+#
+# @slot: slot ID, unique per slot of a given @slot-type
+#
+# @slot-type: type of the slot
+#
+# @source: an integer containing the source event
+#
+# @status: an integer containing the status code
+#
+# Since: 2.1
+##
+{ 'struct': 'ACPIOSTInfo',
+  'data'  : { '*device': 'str',
+              'slot': 'str',
+              'slot-type': 'ACPISlotType',
+              'source': 'int',
+              'status': 'int' } }
+
+##
+# @query-acpi-ospm-status:
+#
+# Return a list of ACPIOSTInfo for devices that support status
+# reporting via ACPI _OST method.
+#
+# Since: 2.1
+#
+# Example:
+#
+# -> { "execute": "query-acpi-ospm-status" }
+# <- { "return": [ { "device": "d1", "slot": "0", "slot-type": "DIMM", "source": 1, "status": 0},
+#                  { "slot": "1", "slot-type": "DIMM", "source": 0, "status": 0},
+#                  { "slot": "2", "slot-type": "DIMM", "source": 0, "status": 0},
+#                  { "slot": "3", "slot-type": "DIMM", "source": 0, "status": 0}
+#    ]}
+#
+##
+{ 'command': 'query-acpi-ospm-status', 'returns': ['ACPIOSTInfo'] }
+
+##
+# @ACPI_DEVICE_OST:
+#
+# Emitted when guest executes ACPI _OST method.
+#
+# @info: OSPM Status Indication
+#
+# Since: 2.1
+#
+# Example:
+#
+# <- { "event": "ACPI_DEVICE_OST",
+#      "data": { "device": "d1", "slot": "0",
+#                "slot-type": "DIMM", "source": 1, "status": 0 } }
+#
+##
+{ 'event': 'ACPI_DEVICE_OST',
+     'data': { 'info': 'ACPIOSTInfo' } }
diff --git a/qapi/misc.json b/qapi/misc.json
index 71d11365ea..4b00b18e54 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -970,64 +970,6 @@
 ##
 { 'command': 'query-fdsets', 'returns': ['FdsetInfo'] }
 
-##
-# @AcpiTableOptions:
-#
-# Specify an ACPI table on the command line to load.
-#
-# At most one of @file and @data can be specified. The list of files specified
-# by any one of them is loaded and concatenated in order. If both are omitted,
-# @data is implied.
-#
-# Other fields / optargs can be used to override fields of the generic ACPI
-# table header; refer to the ACPI specification 5.0, section 5.2.6 System
-# Description Table Header. If a header field is not overridden, then the
-# corresponding value from the concatenated blob is used (in case of @file), or
-# it is filled in with a hard-coded value (in case of @data).
-#
-# String fields are copied into the matching ACPI member from lowest address
-# upwards, and silently truncated / NUL-padded to length.
-#
-# @sig: table signature / identifier (4 bytes)
-#
-# @rev: table revision number (dependent on signature, 1 byte)
-#
-# @oem_id: OEM identifier (6 bytes)
-#
-# @oem_table_id: OEM table identifier (8 bytes)
-#
-# @oem_rev: OEM-supplied revision number (4 bytes)
-#
-# @asl_compiler_id: identifier of the utility that created the table
-#                   (4 bytes)
-#
-# @asl_compiler_rev: revision number of the utility that created the
-#                    table (4 bytes)
-#
-# @file: colon (:) separated list of pathnames to load and
-#        concatenate as table data. The resultant binary blob is expected to
-#        have an ACPI table header. At least one file is required. This field
-#        excludes @data.
-#
-# @data: colon (:) separated list of pathnames to load and
-#        concatenate as table data. The resultant binary blob must not have an
-#        ACPI table header. At least one file is required. This field excludes
-#        @file.
-#
-# Since: 1.5
-##
-{ 'struct': 'AcpiTableOptions',
-  'data': {
-    '*sig':               'str',
-    '*rev':               'uint8',
-    '*oem_id':            'str',
-    '*oem_table_id':      'str',
-    '*oem_rev':           'uint32',
-    '*asl_compiler_id':   'str',
-    '*asl_compiler_rev':  'uint32',
-    '*file':              'str',
-    '*data':              'str' }}
-
 ##
 # @CommandLineParameterType:
 #
@@ -1121,79 +1063,6 @@
  'returns': ['CommandLineOptionInfo'],
  'allow-preconfig': true }
 
-##
-# @ACPISlotType:
-#
-# @DIMM: memory slot
-# @CPU: logical CPU slot (since 2.7)
-##
-{ 'enum': 'ACPISlotType', 'data': [ 'DIMM', 'CPU' ] }
-
-##
-# @ACPIOSTInfo:
-#
-# OSPM Status Indication for a device
-# For description of possible values of @source and @status fields
-# see "_OST (OSPM Status Indication)" chapter of ACPI5.0 spec.
-#
-# @device: device ID associated with slot
-#
-# @slot: slot ID, unique per slot of a given @slot-type
-#
-# @slot-type: type of the slot
-#
-# @source: an integer containing the source event
-#
-# @status: an integer containing the status code
-#
-# Since: 2.1
-##
-{ 'struct': 'ACPIOSTInfo',
-  'data'  : { '*device': 'str',
-              'slot': 'str',
-              'slot-type': 'ACPISlotType',
-              'source': 'int',
-              'status': 'int' } }
-
-##
-# @query-acpi-ospm-status:
-#
-# Return a list of ACPIOSTInfo for devices that support status
-# reporting via ACPI _OST method.
-#
-# Since: 2.1
-#
-# Example:
-#
-# -> { "execute": "query-acpi-ospm-status" }
-# <- { "return": [ { "device": "d1", "slot": "0", "slot-type": "DIMM", "source": 1, "status": 0},
-#                  { "slot": "1", "slot-type": "DIMM", "source": 0, "status": 0},
-#                  { "slot": "2", "slot-type": "DIMM", "source": 0, "status": 0},
-#                  { "slot": "3", "slot-type": "DIMM", "source": 0, "status": 0}
-#    ]}
-#
-##
-{ 'command': 'query-acpi-ospm-status', 'returns': ['ACPIOSTInfo'] }
-
-##
-# @ACPI_DEVICE_OST:
-#
-# Emitted when guest executes ACPI _OST method.
-#
-# @info: OSPM Status Indication
-#
-# Since: 2.1
-#
-# Example:
-#
-# <- { "event": "ACPI_DEVICE_OST",
-#      "data": { "device": "d1", "slot": "0",
-#                "slot-type": "DIMM", "source": 1, "status": 0 } }
-#
-##
-{ 'event': 'ACPI_DEVICE_OST',
-     'data': { 'info': 'ACPIOSTInfo' } }
-
 ##
 # @ReplayMode:
 #
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index f03ff91ceb..4d8b3a9afe 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -85,3 +85,4 @@
 { 'include': 'misc.json' }
 { 'include': 'misc-target.json' }
 { 'include': 'audio.json' }
+{ 'include': 'acpi.json' }
diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
index 9adf1e4706..769ff55c7e 100644
--- a/include/hw/acpi/acpi_dev_interface.h
+++ b/include/hw/acpi/acpi_dev_interface.h
@@ -1,7 +1,7 @@
 #ifndef ACPI_DEV_INTERFACE_H
 #define ACPI_DEV_INTERFACE_H
 
-#include "qapi/qapi-types-misc.h"
+#include "qapi/qapi-types-acpi.h"
 #include "qom/object.h"
 #include "hw/boards.h"
 #include "hw/qdev-core.h"
diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index ac06db3450..ade9158cbf 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -27,7 +27,7 @@
 #include "qapi/error.h"
 #include "qapi/opts-visitor.h"
 #include "qapi/qapi-events-run-state.h"
-#include "qapi/qapi-visit-misc.h"
+#include "qapi/qapi-visit-acpi.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 8dd4d8ebbf..f099b50927 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -3,7 +3,7 @@
 #include "migration/vmstate.h"
 #include "hw/acpi/cpu.h"
 #include "qapi/error.h"
-#include "qapi/qapi-events-misc.h"
+#include "qapi/qapi-events-acpi.h"
 #include "trace.h"
 #include "sysemu/numa.h"
 
diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index dfe57af429..f2552b2a46 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -7,8 +7,8 @@
 #include "migration/vmstate.h"
 #include "trace.h"
 #include "qapi/error.h"
+#include "qapi/qapi-events-acpi.h"
 #include "qapi/qapi-events-machine.h"
-#include "qapi/qapi-events-misc.h"
 
 #define MEMORY_SLOTS_NUMBER          "MDNR"
 #define MEMORY_HOTPLUG_IO_REGION     "HPMR"
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index 864cbfa32e..0ab5b78580 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -30,6 +30,7 @@
 #include "sysemu/blockdev.h"
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
+#include "qapi/qapi-commands-acpi.h"
 #include "qapi/qapi-commands-block.h"
 #include "qapi/qapi-commands-control.h"
 #include "qapi/qapi-commands-machine.h"
diff --git a/MAINTAINERS b/MAINTAINERS
index 5eed1e692b..f99b5db940 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1632,6 +1632,7 @@ F: hw/acpi/*
 F: hw/smbios/*
 F: hw/i386/acpi-build.[hc]
 F: hw/arm/virt-acpi-build.c
+F: qapi/acpi.json
 F: tests/qtest/bios-tables-test*
 F: tests/qtest/acpi-utils.[hc]
 F: tests/data/acpi/
diff --git a/qapi/meson.build b/qapi/meson.build
index 2b2872a41d..f57acc2402 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -14,6 +14,7 @@ util_ss.add(files(
 ))
 
 qapi_all_modules = [
+  'acpi',
   'audio',
   'authz',
   'block-core',
-- 
2.26.2


