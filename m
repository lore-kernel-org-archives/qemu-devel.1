Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CDAC10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:55:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B918205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gp60lUOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B918205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDe2B-000076-4T
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 20:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDdFH-0005gP-TJ
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:04:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDdFC-0002iY-QM
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:04:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56840
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDdFC-0002a1-LN
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584317073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aUztEG8VJUK8KWRteiatLwJDnt0GxjjutgLn6qrxOy8=;
 b=gp60lUOFm1XeUlBLIhXlMynO24EzB0ODlcT09Qk+IQerbIMikiQ9jUozboaskqqg0ScY1b
 AkFg5xx1ps13Thq8htJoFuPmTCTeTkFYNNd4gmNFc/aUzYYGnpbRirxM+7winc/AOtGEdm
 DYjQknmzoKNL0vBrXtWAbNVAzoEAUsw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-eHmG2mCRNpqC61gyVFkbng-1; Sun, 15 Mar 2020 20:04:30 -0400
X-MC-Unique: eHmG2mCRNpqC61gyVFkbng-1
Received: by mail-wr1-f69.google.com with SMTP id l16so7416812wrr.6
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 17:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wzIoCKZqybQh2QBuwEmmWMnz4Gia6mWJaIuM3SrKfJk=;
 b=S9/QdPd1gVSz1Pd0KBI5lnypURMHzOXyYCXv9+LPCwoSlrfeIbniGTVOtUH8PXm+vy
 6qGlcyz03XSWJFmOuTmdwAgPpETnel037JXnWZLbOB80ihA8DmH4L74gnTBYR9/EFEVh
 voxQX93j47pYXANX0Dj8K0/jrU6dirwyHRCwv9tPcsRwN0VsTVpj+panSQghvjykMUig
 cHLFN+PsWeZscJiywCgX3PSmXDfGLIbJT8iE1Av59vy4AaI917BL9hYT21Odnsc2wW2q
 tE+YnG56vzw3jEoJUDavZ12v91CbBCRqtPUcIs97db7rCJa62I8Lk6oQ/mXLgWRczD/5
 aSZw==
X-Gm-Message-State: ANhLgQ2t6uNHzcdW+WbNgdJjqLmXgj/5Ktn1aEVbs83DxKZBIuCVxRWr
 3uRhTGsHHwC9XMbbKIYUYu698CmSAxsG8+WIiu6NXUvHZJM/xZhkRlIMyPdofsf7BWRPzJufHtE
 UV/uzzsQOmt8wILc=
X-Received: by 2002:a5d:698c:: with SMTP id g12mr24837168wru.382.1584317069365; 
 Sun, 15 Mar 2020 17:04:29 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuwwoy4MA2ji05p6h7mlXLGYYea5kdEt5m2lDqqCkvHW/L3Dj7lqqZs/YB962cYN1C7R2fgew==
X-Received: by 2002:a5d:698c:: with SMTP id g12mr24837133wru.382.1584317068967; 
 Sun, 15 Mar 2020 17:04:28 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id w16sm58132908wrp.8.2020.03.15.17.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 17:04:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/8] qapi/misc: Restrict ACPI commands to machine code
Date: Mon, 16 Mar 2020 01:03:46 +0100
Message-Id: <20200316000348.29692-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316000348.29692-1-philmd@redhat.com>
References: <20200316000348.29692-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 qapi/machine.json                    | 154 +++++++++++++++++++++++++++
 qapi/misc.json                       | 154 ---------------------------
 include/hw/acpi/acpi_dev_interface.h |   2 +-
 hw/acpi/core.c                       |   2 +-
 hw/acpi/cpu.c                        |   2 +-
 hw/acpi/memory_hotplug.c             |   2 +-
 6 files changed, 158 insertions(+), 158 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 1a2a4b0d48..f77ee63730 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1018,3 +1018,157 @@
 ##
 { 'event': 'BALLOON_CHANGE',
   'data': { 'actual': 'int' } }
+
+##
+# @AcpiTableOptions:
+#
+# Specify an ACPI table on the command line to load.
+#
+# At most one of @file and @data can be specified. The list of files speci=
fied
+# by any one of them is loaded and concatenated in order. If both are omit=
ted,
+# @data is implied.
+#
+# Other fields / optargs can be used to override fields of the generic ACP=
I
+# table header; refer to the ACPI specification 5.0, section 5.2.6 System
+# Description Table Header. If a header field is not overridden, then the
+# corresponding value from the concatenated blob is used (in case of @file=
), or
+# it is filled in with a hard-coded value (in case of @data).
+#
+# String fields are copied into the matching ACPI member from lowest addre=
ss
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
+#        concatenate as table data. The resultant binary blob is expected =
to
+#        have an ACPI table header. At least one file is required. This fi=
eld
+#        excludes @data.
+#
+# @data: colon (:) separated list of pathnames to load and
+#        concatenate as table data. The resultant binary blob must not hav=
e an
+#        ACPI table header. At least one file is required. This field excl=
udes
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
+# <- { "return": [ { "device": "d1", "slot": "0", "slot-type": "DIMM", "so=
urce": 1, "status": 0},
+#                  { "slot": "1", "slot-type": "DIMM", "source": 0, "statu=
s": 0},
+#                  { "slot": "2", "slot-type": "DIMM", "source": 0, "statu=
s": 0},
+#                  { "slot": "3", "slot-type": "DIMM", "source": 0, "statu=
s": 0}
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
index 8c02870227..3d9d7327fe 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -999,64 +999,6 @@
 ##
 { 'command': 'query-fdsets', 'returns': ['FdsetInfo'] }
=20
-##
-# @AcpiTableOptions:
-#
-# Specify an ACPI table on the command line to load.
-#
-# At most one of @file and @data can be specified. The list of files speci=
fied
-# by any one of them is loaded and concatenated in order. If both are omit=
ted,
-# @data is implied.
-#
-# Other fields / optargs can be used to override fields of the generic ACP=
I
-# table header; refer to the ACPI specification 5.0, section 5.2.6 System
-# Description Table Header. If a header field is not overridden, then the
-# corresponding value from the concatenated blob is used (in case of @file=
), or
-# it is filled in with a hard-coded value (in case of @data).
-#
-# String fields are copied into the matching ACPI member from lowest addre=
ss
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
-#        concatenate as table data. The resultant binary blob is expected =
to
-#        have an ACPI table header. At least one file is required. This fi=
eld
-#        excludes @data.
-#
-# @data: colon (:) separated list of pathnames to load and
-#        concatenate as table data. The resultant binary blob must not hav=
e an
-#        ACPI table header. At least one file is required. This field excl=
udes
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
@@ -1249,102 +1191,6 @@
 ##
 { 'command': 'query-memory-devices', 'returns': ['MemoryDeviceInfo'] }
=20
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
-# <- { "return": [ { "device": "d1", "slot": "0", "slot-type": "DIMM", "so=
urce": 1, "status": 0},
-#                  { "slot": "1", "slot-type": "DIMM", "source": 0, "statu=
s": 0},
-#                  { "slot": "2", "slot-type": "DIMM", "source": 0, "statu=
s": 0},
-#                  { "slot": "3", "slot-type": "DIMM", "source": 0, "statu=
s": 0}
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
diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_de=
v_interface.h
index a2a12af9b9..a1b63d51db 100644
--- a/include/hw/acpi/acpi_dev_interface.h
+++ b/include/hw/acpi/acpi_dev_interface.h
@@ -1,7 +1,7 @@
 #ifndef ACPI_DEV_INTERFACE_H
 #define ACPI_DEV_INTERFACE_H
=20
-#include "qapi/qapi-types-misc.h"
+#include "qapi/qapi-types-machine.h"
 #include "qom/object.h"
 #include "hw/boards.h"
 #include "hw/qdev-core.h"
diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index 45cbed49ab..4f8d90f50b 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -27,7 +27,7 @@
 #include "qapi/error.h"
 #include "qapi/opts-visitor.h"
 #include "qapi/qapi-events-run-state.h"
-#include "qapi/qapi-visit-misc.h"
+#include "qapi/qapi-visit-machine.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index e2c957ce00..8be15db96d 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -3,7 +3,7 @@
 #include "migration/vmstate.h"
 #include "hw/acpi/cpu.h"
 #include "qapi/error.h"
-#include "qapi/qapi-events-misc.h"
+#include "qapi/qapi-events-machine.h"
 #include "trace.h"
 #include "sysemu/numa.h"
=20
diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index 8d2e82240f..aa454f5cb2 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -7,7 +7,7 @@
 #include "migration/vmstate.h"
 #include "trace.h"
 #include "qapi/error.h"
-#include "qapi/qapi-events-misc.h"
+#include "qapi/qapi-events-machine.h"
=20
 #define MEMORY_SLOTS_NUMBER          "MDNR"
 #define MEMORY_HOTPLUG_IO_REGION     "HPMR"
--=20
2.21.1


