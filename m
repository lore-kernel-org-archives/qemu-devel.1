Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E567BC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 15:28:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DCEA206CA
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 15:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9aLE44J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DCEA206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGOUT-0002vX-Ds
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 11:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGOPy-0004Sk-6N
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 11:23:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34955
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGOPu-00084S-8C
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 11:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599751396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NZPCQVl3ep4pWF3IBqndp0t2wUcQ6LmigyaYwHFGaeE=;
 b=a9aLE44JldT4LAR6tZLlh5JD6ZMQYk7fuxD5ueoyo2w8olgylfrxHNsl4w9sU6GOTzKgos
 No+aG2U6y3rJNYbOMoR7zUiAwybImqVfC+FNTLjQqmxkH3qylI6STzT4+d/Wpb4UUwHK3D
 c4PfsQmEHvfqvmq5euHE8XVkJxceucY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-ZaalG1DdOcCW1DUfP1SPHg-1; Thu, 10 Sep 2020 11:23:13 -0400
X-MC-Unique: ZaalG1DdOcCW1DUfP1SPHg-1
Received: by mail-wr1-f69.google.com with SMTP id w7so2394674wrp.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 08:23:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NZPCQVl3ep4pWF3IBqndp0t2wUcQ6LmigyaYwHFGaeE=;
 b=GW6Vets4lB6ScN6vARXsRb1+3ircokqNWkJmckvvXa/BeXYytAjd7Ls1trAWQDUQ8s
 qfpHcxA6YfjIr0GWC4Bn0+xkihj697KiGtyhxArmeTM93AsmAB9veVhuLAp7rVqhIZZa
 0jfk7MT/i3kPr7u6kSpofdCiSXpO7qcSuDSiE9MdVSc9wU80BwbGzqMRUvulxVPsa2uI
 SSBqg/boV7AJWMIY+Ysghu0SAwFretHkriooB7J2vI16grT5JxL3J18QooVzZ7wmM+Fh
 DFMbRvX1OY15nJY4/Lau1L+5lMQ33uWQMoOenhmD7P/nDRaBrF4688UfUlO3F8n1Lk6a
 USMg==
X-Gm-Message-State: AOAM532UWb2mWDMaIHEcnA9f88QoPYFp+P+YJNXTTey5S73DzBN/Jkfs
 6JisRISsNDOIcwpHLrVKZxgsm0374HAipRnx1iKMOG+feOcWpjwMMCZgVJcr7rLGrMUzItZvCD/
 lWu7vAe+wvLhhgw0=
X-Received: by 2002:a05:600c:2246:: with SMTP id
 a6mr578027wmm.38.1599751391589; 
 Thu, 10 Sep 2020 08:23:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAuIPfIbHnzY4zcgLjKEicBTWWSSlm3oPEtK0jhEAQ0znsFnIqyFbmn6aWnaqvw8UKgR8Y8w==
X-Received: by 2002:a05:600c:2246:: with SMTP id
 a6mr577987wmm.38.1599751391231; 
 Thu, 10 Sep 2020 08:23:11 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id u66sm4505506wme.1.2020.09.10.08.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 08:23:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 8/9] qapi: Extract ACPI commands to 'acpi.json'
Date: Thu, 10 Sep 2020 17:22:24 +0200
Message-Id: <20200910152225.524322-9-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910152225.524322-1-philmd@redhat.com>
References: <20200910152225.524322-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.004
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 09:07:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Extracting the ACPI commands to their own schema reduces
the size of the qapi-misc* headers generated, and allows
pulling less declarations/definitions to user-mode.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
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
index 00000000000..51f0d55db73
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
index 71d11365ead..4b00b18e547 100644
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
index f03ff91ceb5..4d8b3a9afe2 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -85,3 +85,4 @@
 { 'include': 'misc.json' }
 { 'include': 'misc-target.json' }
 { 'include': 'audio.json' }
+{ 'include': 'acpi.json' }
diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
index a2a12af9b90..2f6824a6a07 100644
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
index ac06db34504..ade9158cbf1 100644
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
index 3d6a500fb7e..2d4ee1a7a44 100644
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
index dfe57af4292..f2552b2a462 100644
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
index 864cbfa32e6..0ab5b785805 100644
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
index 7d0a5e91e4f..acc40633fdc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1613,6 +1613,7 @@ F: hw/acpi/*
 F: hw/smbios/*
 F: hw/i386/acpi-build.[hc]
 F: hw/arm/virt-acpi-build.c
+F: qapi/acpi.json
 F: tests/qtest/bios-tables-test*
 F: tests/qtest/acpi-utils.[hc]
 F: tests/data/acpi/
diff --git a/qapi/meson.build b/qapi/meson.build
index 2b2872a41d8..f57acc24026 100644
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


