Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBF7C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:50:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D42E2080A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AlirGH9s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D42E2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX9RQ-0003wh-D9
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 16:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.devolder@oracle.com>)
 id 1kX8yb-0008Ls-9k
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 16:20:22 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47230)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.devolder@oracle.com>)
 id 1kX8yX-0007xx-03
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 16:20:20 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09QKF87P026519;
 Mon, 26 Oct 2020 20:20:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=hubGvh+31oH7CwYXvROINJxHj6ZFK5RdlTTd5WOFHxY=;
 b=AlirGH9sEeNidcGXP+f3ODKSaabfahbcIAt0/EVw3tJHJZdnqubstPvHd+wgU/Ja8K9e
 zfPjeAlcC6u0MX870ese4cv8G/Ut8drwPhDXD+pl0O06+OA5sddcixUVhEOp8Pxkl7fA
 LoMvkLFuXUWuOorZsa6xH7diu6stUHiI6TluFxYclKjSuKDbULbyxFJ2GJX11hOxhPIr
 0Q6rS3LrA7ExwCfyn8HByhiysz3fatOmGvE6GcvbilaI9HuBa+JvnhwJy4tsBeyXC4v2
 chG86xiY0paefGNY+8Y1ATJEh4dNCSzf9azKru1E+mS67Ox/eMdkE96PsHGra13Qk9An xA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 34cc7kpmub-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 26 Oct 2020 20:20:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09QKGEPQ141429;
 Mon, 26 Oct 2020 20:20:12 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 34cx1pwrfu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Oct 2020 20:20:12 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09QKKB9Z029191;
 Mon, 26 Oct 2020 20:20:11 GMT
Received: from vm345.localdomain (/10.149.224.210)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 26 Oct 2020 13:20:10 -0700
From: Eric DeVolder <eric.devolder@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/1] acpi: Implement ACPI ERST support for guests
Date: Mon, 26 Oct 2020 16:19:33 -0400
Message-Id: <1603743573-9870-2-git-send-email-eric.devolder@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603743573-9870-1-git-send-email-eric.devolder@oracle.com>
References: <1603743573-9870-1-git-send-email-eric.devolder@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010260133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010260133
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=eric.devolder@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 14:28:53
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 26 Oct 2020 16:46:19 -0400
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
Cc: ehabkost@redhat.com, mst@redhat.com, konrad.wilk@oracle.com,
 pbonzini@redhat.com, imammedo@redhat.com, boris.ostrovsky@oracle.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This changeset introduces support for the ACPI Error Record
Serialization Table, ERST.

ERST is defined in [1], and the error records are defined
according to [2].

This changeset generates the ACPI ERST table, which OSPM
follows to program the associated ERST device. The ERST
device occupies 8KiB of address space, with the first 8 bytes
containing registers, and the remainder being an exchange
buffer for reading/writing error records.

The ERST device contains two registers, ACTION and VALUE
registers, following closely the ERST operations.

The ERST device only examines the record for the signature 'CPER',
its record identifier, and bounds-checks the length against the size
of the the CPER record header; otherwise all other record fields
and payload are ignored.

There are two options for this device:
 -global acpi-erst.size=X
 -global acpi-erst.filename=Y
The size X, if not specified, defaults to 64KiB, and must be within
64KiB and 1MiB.
The filename Y, if not specified, defaults to "acpi-erst.backing".
The ERST backing storage is not mapped into the guest address space,
just the 8KiB programming area is mapped into the guest.

This has been utilized as a backend for the Linux pstore feature.

[1] ACPI 6.3 Specification, 18.3 Error Serialization
    https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf

[2] UEFI 2.8 Specification, Appendix N Common Platform Error Record
    https://uefi.org/sites/default/files/resources/UEFI_Spec_2_8_final.pdf

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 hw/acpi/erst.c         | 909 +++++++++++++++++++++++++++++++++++++++++++++++++
 hw/acpi/meson.build    |   1 +
 hw/i386/acpi-build.c   |   4 +
 include/hw/acpi/erst.h |  97 ++++++
 4 files changed, 1011 insertions(+)
 create mode 100644 hw/acpi/erst.c
 create mode 100644 include/hw/acpi/erst.h

diff --git a/hw/acpi/erst.c b/hw/acpi/erst.c
new file mode 100644
index 0000000..407dc97
--- /dev/null
+++ b/hw/acpi/erst.c
@@ -0,0 +1,909 @@
+/*
+ * ACPI Error Record Serialization Table, ERST, Implementation
+ *
+ * Copyright (c) 2020 Oracle and/or its affiliates.
+ *
+ * See ACPI specification,
+ * "ACPI Platform Error Interfaces" : "Error Serialization"
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>
+ */
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/sysbus.h"
+#include "qom/object_interfaces.h"
+#include "qemu/error-report.h"
+#include "migration/vmstate.h"
+#include "hw/qdev-properties.h"
+#include "hw/acpi/acpi.h"
+#include "hw/acpi/acpi-defs.h"
+#include "hw/acpi/aml-build.h"
+#include "hw/acpi/bios-linker-loader.h"
+#include "exec/address-spaces.h"
+#include "hw/acpi/erst.h"
+
+#ifdef _ERST_DEBUG
+#define erst_debug(fmt, ...) \
+    do { fprintf(stderr, fmt, ## __VA_ARGS__); fflush(stderr); } while (0)
+#else
+#define erst_debug(fmt, ...) do { } while (0)
+#endif
+
+/* See UEFI spec, Appendix N Common Platform Error Record */
+/* UEFI CPER allows for an OSPM book keeping area in the record */
+#define UEFI_CPER_RECORD_MIN_SIZE 128U
+#define UEFI_CPER_SIZE_OFFSET 20U
+#define UEFI_CPER_RECORD_ID_OFFSET 96U
+#define IS_UEFI_CPER_RECORD(ptr) \
+    (((ptr)[0] == 'C') && \
+     ((ptr)[1] == 'P') && \
+     ((ptr)[2] == 'E') && \
+     ((ptr)[3] == 'R'))
+#define THE_UEFI_CPER_RECORD_ID(ptr) \
+    (*(uint64_t *)(&(ptr)[UEFI_CPER_RECORD_ID_OFFSET]))
+
+#define ERST_INVALID_RECORD_ID (~0UL)
+#define ERST_EXECUTE_OPERATION_MAGIC 0x9CUL
+#define ERST_CSR_ACTION (0UL << 3) /* action (cmd) */
+#define ERST_CSR_VALUE  (1UL << 3) /* argument/value (data) */
+
+/*
+ * As ERST_IOMEM_SIZE is used to map the ERST into the guest,
+ * it should/must be an integer multiple of PAGE_SIZE.
+ * NOTE that any change to this value will make any pre-
+ * existing backing files, not of the same ERST_IOMEM_SIZE,
+ * unusable to the guest.
+ */
+#define ERST_IOMEM_SIZE (2UL * 4096)
+
+/*
+ * This implementation is an ACTION (cmd) and VALUE (data)
+ * interface consisting of just two 64-bit registers.
+ */
+#define ERST_REG_LEN (2UL * sizeof(uint64_t))
+
+/*
+ * The space not utilized by the register interface is the
+ * buffer for exchanging ERST record contents.
+ */
+#define ERST_RECORD_SIZE (ERST_IOMEM_SIZE - ERST_REG_LEN)
+
+/*
+ * Mode to be used for backing file
+ */
+#define ERST_BACKING_FILE_MODE 0644 /* S_IRWXU|S_IRWXG */
+
+#define ACPIERST(obj) \
+    OBJECT_CHECK(ERSTDeviceState, (obj), TYPE_ACPI_ERST)
+#define ACPIERST_CLASS(oc) \
+    OBJECT_CLASS_CHECK(ERSTDeviceStateClass, (oc), TYPE_ACPI_ERST)
+#define ACPIERST_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(ERSTDeviceStateClass, (obj), TYPE_ACPI_ERST)
+
+static hwaddr erst_base;
+
+typedef struct {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    uint32_t prop_size;
+    char *prop_filename;
+    hwaddr base;
+
+    uint8_t operation;
+    uint8_t busy_status;
+    uint8_t command_status;
+    uint32_t record_offset;
+    uint32_t record_count;
+    uint64_t reg_action;
+    uint64_t reg_value;
+    uint64_t record_identifier;
+
+    unsigned next_record_index;
+    uint8_t record[ERST_RECORD_SIZE]; /* read/written directly by guest */
+    uint8_t tmp_record[ERST_RECORD_SIZE]; /* intermediate manipulation buffer */
+    uint8_t *nvram; /* persistent storage, of length prop_size */
+
+} ERSTDeviceState;
+
+static void update_erst_backing_file(ERSTDeviceState *s,
+    off_t offset, const uint8_t *data, size_t length)
+{
+    int fd;
+
+    /* Bounds check */
+    if ((offset + length) > s->prop_size) {
+        error_report("update: off 0x%lx len 0x%lx > size 0x%lx out of range",
+            (long)offset, (long)length, (long)s->prop_size);
+        return;
+    }
+
+    fd = open(s->prop_filename, O_WRONLY | O_CREAT, ERST_BACKING_FILE_MODE);
+    if (fd > 0) {
+        off_t src;
+        size_t wrc = 0;
+        src = lseek(fd, offset, SEEK_SET);
+        if (offset == src) {
+            wrc = write(fd, data, length);
+        }
+        if ((offset != src) || (length != wrc)) {
+            error_report("ERST write failed: %d %d", (int)wrc, (int)length);
+        }
+        close(fd);
+    } else {
+        error_report("open failed: %s : %d", s->prop_filename, fd);
+    }
+}
+
+static unsigned copy_from_nvram_by_index(ERSTDeviceState *s, unsigned index)
+{
+    /* Read a nvram[] entry into tmp_record */
+    unsigned rc = ACPI_ERST_STATUS_FAILED;
+    off_t offset = (index * ERST_RECORD_SIZE);
+
+    if ((offset + ERST_RECORD_SIZE) <= s->prop_size) {
+        memcpy(s->tmp_record, &s->nvram[offset], ERST_RECORD_SIZE);
+        rc = ACPI_ERST_STATUS_SUCCESS;
+    }
+    return rc;
+}
+
+static unsigned copy_to_nvram_by_index(ERSTDeviceState *s, unsigned index)
+{
+    /* Write entry in tmp_record into nvram[], and backing file */
+    unsigned rc = ACPI_ERST_STATUS_FAILED;
+    off_t offset = (index * ERST_RECORD_SIZE);
+
+    if ((offset + ERST_RECORD_SIZE) <= s->prop_size) {
+        memcpy(&s->nvram[offset], s->tmp_record, ERST_RECORD_SIZE);
+        update_erst_backing_file(s, offset, s->tmp_record, ERST_RECORD_SIZE);
+        rc = ACPI_ERST_STATUS_SUCCESS;
+    }
+    return rc;
+}
+
+static int lookup_erst_record_by_identifier(ERSTDeviceState *s,
+    uint64_t record_identifier, bool *record_found, bool alloc_for_write)
+{
+    int rc = -1;
+    int empty_index = -1;
+    int index = 0;
+    unsigned rrc;
+
+    *record_found = 0;
+
+    do {
+        rrc = copy_from_nvram_by_index(s, (unsigned)index);
+        if (rrc == ACPI_ERST_STATUS_SUCCESS) {
+            uint64_t this_identifier;
+            this_identifier = THE_UEFI_CPER_RECORD_ID(s->tmp_record);
+            if (IS_UEFI_CPER_RECORD(s->tmp_record) &&
+                (this_identifier == record_identifier)) {
+                rc = index;
+                *record_found = 1;
+                break;
+            }
+            if ((this_identifier == ERST_INVALID_RECORD_ID) &&
+                (empty_index < 0)) {
+                empty_index = index; /* first available for write */
+            }
+        }
+        ++index;
+    } while (rrc == ACPI_ERST_STATUS_SUCCESS);
+
+    /* Record not found, allocate for writing */
+    if ((rc < 0) && alloc_for_write) {
+        rc = empty_index;
+    }
+
+    return rc;
+}
+
+static unsigned clear_erst_record(ERSTDeviceState *s)
+{
+    unsigned rc = ACPI_ERST_STATUS_RECORD_NOT_FOUND;
+    bool record_found;
+    int index;
+
+    index = lookup_erst_record_by_identifier(s,
+        s->record_identifier, &record_found, 0);
+    if (record_found) {
+        memset(s->tmp_record, 0xFF, ERST_RECORD_SIZE);
+        rc = copy_to_nvram_by_index(s, (unsigned)index);
+        if (rc == ACPI_ERST_STATUS_SUCCESS) {
+            s->record_count -= 1;
+        }
+    }
+
+    return rc;
+}
+
+static unsigned write_erst_record(ERSTDeviceState *s)
+{
+    unsigned rc = ACPI_ERST_STATUS_FAILED;
+
+    if (s->record_offset < (ERST_RECORD_SIZE - UEFI_CPER_RECORD_MIN_SIZE)) {
+        uint64_t record_identifier;
+        uint8_t *record = &s->record[s->record_offset];
+        bool record_found;
+        int index;
+
+        record_identifier = (s->record_identifier == ERST_INVALID_RECORD_ID)
+            ? THE_UEFI_CPER_RECORD_ID(record) : s->record_identifier;
+
+        index = lookup_erst_record_by_identifier(s,
+            record_identifier, &record_found, 1);
+        if (index < 0) {
+            rc = ACPI_ERST_STATUS_NOT_ENOUGH_SPACE;
+        } else {
+            if (0 != s->record_offset) {
+                memset(&s->tmp_record[ERST_RECORD_SIZE - s->record_offset],
+                    0xFF, s->record_offset);
+            }
+            memcpy(s->tmp_record, record, ERST_RECORD_SIZE - s->record_offset);
+            rc = copy_to_nvram_by_index(s, (unsigned)index);
+            if (rc == ACPI_ERST_STATUS_SUCCESS) {
+                if (!record_found) { /* not overwriting existing record */
+                    s->record_count += 1; /* writing new record */
+                }
+            }
+        }
+    }
+
+    return rc;
+}
+
+static unsigned next_erst_record(ERSTDeviceState *s,
+    uint64_t *record_identifier)
+{
+    unsigned rc = ACPI_ERST_STATUS_RECORD_NOT_FOUND;
+    unsigned index;
+    unsigned rrc;
+
+    *record_identifier = ERST_INVALID_RECORD_ID;
+
+    index = s->next_record_index;
+    do {
+        rrc = copy_from_nvram_by_index(s, (unsigned)index);
+        if (rrc == ACPI_ERST_STATUS_SUCCESS) {
+            if (IS_UEFI_CPER_RECORD(s->tmp_record)) {
+                s->next_record_index = index + 1; /* where to start next time */
+                *record_identifier = THE_UEFI_CPER_RECORD_ID(s->tmp_record);
+                rc = ACPI_ERST_STATUS_SUCCESS;
+                break;
+            }
+            ++index;
+        } else {
+            if (s->next_record_index == 0) {
+                rc = ACPI_ERST_STATUS_RECORD_STORE_EMPTY;
+            }
+            s->next_record_index = 0; /* at end, reset */
+        }
+    } while (rrc == ACPI_ERST_STATUS_SUCCESS);
+
+    return rc;
+}
+
+static unsigned read_erst_record(ERSTDeviceState *s)
+{
+    unsigned rc = ACPI_ERST_STATUS_RECORD_NOT_FOUND;
+    bool record_found;
+    int index;
+
+    index = lookup_erst_record_by_identifier(s,
+        s->record_identifier, &record_found, 0);
+    if (record_found) {
+        rc = copy_from_nvram_by_index(s, (unsigned)index);
+        if (rc == ACPI_ERST_STATUS_SUCCESS) {
+            if (s->record_offset < ERST_RECORD_SIZE) {
+                memcpy(&s->record[s->record_offset], s->tmp_record,
+                    ERST_RECORD_SIZE - s->record_offset);
+            }
+        }
+    }
+
+    return rc;
+}
+
+static unsigned get_erst_record_count(ERSTDeviceState *s)
+{
+    /* Compute record_count */
+    off_t offset;
+
+    s->record_count = 0;
+    offset = 0;
+    do {
+        uint8_t *ptr = &s->nvram[offset];
+        uint64_t record_identifier = THE_UEFI_CPER_RECORD_ID(ptr);
+        if (IS_UEFI_CPER_RECORD(ptr) &&
+            (ERST_INVALID_RECORD_ID != record_identifier)) {
+            s->record_count += 1;
+        }
+        offset += ERST_RECORD_SIZE;
+    } while (offset < (off_t)s->prop_size);
+
+    return s->record_count;
+}
+
+static void load_erst_backing_file(ERSTDeviceState *s)
+{
+    int fd;
+    struct stat statbuf;
+
+    erst_debug("+load_erst_backing_file()\n");
+
+    /* Allocate and initialize nvram[] */
+    s->nvram = g_malloc(s->prop_size);
+    memset(s->nvram, 0xFF, s->prop_size);
+
+    /* Ensure backing file at least same as prop_size */
+    if (stat(s->prop_filename, &statbuf) == 0) {
+        /* ensure prop_size at least matches file size */
+        if (statbuf.st_size < s->prop_size) {
+            /* Ensure records are ERST_INVALID_RECORD_ID */
+            memset(s->nvram, 0xFF, s->prop_size - statbuf.st_size);
+            update_erst_backing_file(s,
+                statbuf.st_size, s->nvram, s->prop_size - statbuf.st_size);
+        }
+    }
+
+    /* Pre-load nvram[] from backing file, if present */
+    fd = open(s->prop_filename, O_RDONLY, ERST_BACKING_FILE_MODE);
+    if (fd > 0) {
+        size_t rrc = read(fd, s->nvram, s->prop_size);
+        (void)rrc;
+        close(fd);
+        /*
+         * If existing file is smaller than prop_size, it will be resized
+         * accordingly upon subsequent record writes. If the file
+         * is larger than prop_size, only prop_size bytes are utilized,
+         * the extra bytes are untouched (though will be lost after
+         * a migration when the backing file is re-written as length
+         * of prop_size bytes).
+         */
+    } else {
+        /* Create empty backing file */
+        update_erst_backing_file(s, 0, s->nvram, s->prop_size);
+    }
+
+    /* Initialize record_count */
+    get_erst_record_count(s);
+
+    erst_debug("-load_erst_backing_file() %d\n", s->record_count);
+}
+
+static uint64_t erst_rd_reg64(hwaddr addr,
+    uint64_t reg, unsigned size)
+{
+    uint64_t rdval;
+    uint64_t mask;
+    unsigned shift;
+
+    if (size == sizeof(uint64_t)) {
+        /* 64b access */
+        mask = 0xFFFFFFFFFFFFFFFFUL;
+        shift = 0;
+    } else {
+        /* 32b access */
+        mask = 0x00000000FFFFFFFFUL;
+        shift = ((addr & 0x4) == 0x4) ? 32 : 0;
+    }
+
+    rdval = reg;
+    rdval >>= shift;
+    rdval &= mask;
+
+    return rdval;
+}
+
+static uint64_t erst_wr_reg64(hwaddr addr,
+    uint64_t reg, uint64_t val, unsigned size)
+{
+    uint64_t wrval;
+    uint64_t mask;
+    unsigned shift;
+
+    if (size == sizeof(uint64_t)) {
+        /* 64b access */
+        mask = 0xFFFFFFFFFFFFFFFFUL;
+        shift = 0;
+    } else {
+        /* 32b access */
+        mask = 0x00000000FFFFFFFFUL;
+        shift = ((addr & 0x4) == 0x4) ? 32 : 0;
+    }
+
+    val &= mask;
+    val <<= shift;
+    mask <<= shift;
+    wrval = reg;
+    wrval &= ~mask;
+    wrval |= val;
+
+    return wrval;
+}
+
+static void erst_write(void *opaque, hwaddr addr,
+    uint64_t val, unsigned size)
+{
+    ERSTDeviceState *s = (ERSTDeviceState *)opaque;
+
+    if (addr < ERST_REG_LEN) {
+        /*
+         * NOTE: All actions/operations/side effects happen on the WRITE,
+         * by design. The READs simply return the reg_value contents.
+         */
+        erst_debug("ERST write %016lx %10s val %016lx sz %u",
+            addr, erst_reg(addr), val, size);
+        /* The REGISTER region */
+        switch (addr) {
+        case ERST_CSR_VALUE + 0:
+        case ERST_CSR_VALUE + 4:
+            s->reg_value = erst_wr_reg64(addr, s->reg_value, val, size);
+            break;
+        case ERST_CSR_ACTION + 0:
+/*      case ERST_CSR_ACTION+4: as coded, not really a 64b register */
+            switch (val) {
+            case ACPI_ERST_ACTION_BEGIN_WRITE_OPERATION:
+            case ACPI_ERST_ACTION_BEGIN_READ_OPERATION:
+            case ACPI_ERST_ACTION_BEGIN_CLEAR_OPERATION:
+            case ACPI_ERST_ACTION_BEGIN_DUMMY_WRITE_OPERATION:
+            case ACPI_ERST_ACTION_END_OPERATION:
+                s->operation = val;
+                break;
+            case ACPI_ERST_ACTION_SET_RECORD_OFFSET:
+                s->record_offset = s->reg_value;
+                break;
+            case ACPI_ERST_ACTION_EXECUTE_OPERATION:
+                if ((uint8_t)s->reg_value == ERST_EXECUTE_OPERATION_MAGIC) {
+                    s->busy_status = 1;
+                    switch (s->operation) {
+                    case ACPI_ERST_ACTION_BEGIN_WRITE_OPERATION:
+                        s->command_status = write_erst_record(s);
+                        break;
+                    case ACPI_ERST_ACTION_BEGIN_READ_OPERATION:
+                        s->command_status = read_erst_record(s);
+                        break;
+                    case ACPI_ERST_ACTION_BEGIN_CLEAR_OPERATION:
+                        s->command_status = clear_erst_record(s);
+                        break;
+                    case ACPI_ERST_ACTION_BEGIN_DUMMY_WRITE_OPERATION:
+                        s->command_status = ACPI_ERST_STATUS_SUCCESS;
+                        break;
+                    case ACPI_ERST_ACTION_END_OPERATION:
+                        s->command_status = ACPI_ERST_STATUS_SUCCESS;
+                        break;
+                    default:
+                        s->command_status = ACPI_ERST_STATUS_FAILED;
+                        break;
+                    }
+                    s->record_identifier = ERST_INVALID_RECORD_ID;
+                    s->busy_status = 0;
+                }
+                break;
+            case ACPI_ERST_ACTION_CHECK_BUSY_STATUS:
+                s->reg_value = s->busy_status;
+                break;
+            case ACPI_ERST_ACTION_GET_COMMAND_STATUS:
+                s->reg_value = s->command_status;
+                break;
+            case ACPI_ERST_ACTION_GET_RECORD_IDENTIFIER:
+                s->command_status = next_erst_record(s, &s->reg_value);
+                break;
+            case ACPI_ERST_ACTION_SET_RECORD_IDENTIFIER:
+                s->record_identifier = s->reg_value;
+                break;
+            case ACPI_ERST_ACTION_GET_RECORD_COUNT:
+                s->reg_value = s->record_count;
+                break;
+            case ACPI_ERST_ACTION_GET_ERROR_LOG_ADDRESS_RANGE:
+                s->reg_value = s->base + ERST_REG_LEN;
+                break;
+            case ACPI_ERST_ACTION_GET_ERROR_LOG_ADDRESS_LENGTH:
+                s->reg_value = ERST_RECORD_SIZE;
+                break;
+            case ACPI_ERST_ACTION_GET_ERROR_LOG_ADDRESS_RANGE_ATTRIBUTES:
+                s->reg_value = 0; /* correct/intended value */
+                break;
+            case ACPI_ERST_ACTION_GET_EXECUTE_OPERATION_TIMINGS:
+                /*
+                 * 100UL is max, 10UL is nominal
+                 */
+                s->reg_value = ((100UL << 32) | (10UL << 0));
+                break;
+            case ACPI_ERST_ACTION_RESERVED:
+            default:
+                /*
+                 * NOP
+                 */
+                break;
+            }
+            break;
+        default:
+            /*
+             * All other register writes are NO-OPs
+             */
+            break;
+        }
+    } else {
+        /* The RECORD region */
+        unsigned offset = addr - ERST_REG_LEN;
+        uint8_t *ptr = &s->record[offset];
+        switch (size) {
+        default:
+        case sizeof(uint8_t):
+            *(uint8_t *)ptr = (uint8_t)val;
+            break;
+        case sizeof(uint16_t):
+            *(uint16_t *)ptr = (uint16_t)val;
+            break;
+        case sizeof(uint32_t):
+            *(uint32_t *)ptr = (uint32_t)val;
+            break;
+        case sizeof(uint64_t):
+            *(uint64_t *)ptr = (uint64_t)val;
+            break;
+        }
+    }
+}
+
+static uint64_t erst_read(void *opaque, hwaddr addr,
+                                unsigned size)
+{
+    ERSTDeviceState *s = (ERSTDeviceState *)opaque;
+    uint64_t val = 0;
+
+    if (addr < ERST_REG_LEN) {
+        switch (addr) {
+        case ERST_CSR_ACTION + 0:
+        case ERST_CSR_ACTION + 4:
+            val = erst_rd_reg64(addr, s->reg_action, size);
+            break;
+        case ERST_CSR_VALUE + 0:
+        case ERST_CSR_VALUE + 4:
+            val = erst_rd_reg64(addr, s->reg_value, size);
+            break;
+        default:
+            break;
+        }
+    erst_debug("ERST read  %016lx %10s val %016lx sz %u\n",
+        addr, erst_reg(addr), val, size);
+    } else {
+        /*
+         * The RECORD region
+         */
+        uint8_t *ptr = &s->record[addr - ERST_REG_LEN];
+        switch (size) {
+        default:
+        case sizeof(uint8_t):
+            val = *(uint8_t *)ptr;
+            break;
+        case sizeof(uint16_t):
+            val = *(uint16_t *)ptr;
+            break;
+        case sizeof(uint32_t):
+            val = *(uint32_t *)ptr;
+            break;
+        case sizeof(uint64_t):
+            val = *(uint64_t *)ptr;
+            break;
+        }
+    }
+    erst_debug("ERST read  %016lx %10s val %016lx sz %u\n",
+        addr, erst_reg(addr), val, size);
+    return val;
+}
+
+static size_t build_erst_action(GArray *table_data,
+    uint8_t serialization_action,
+    uint8_t instruction,
+    uint8_t flags,
+    uint8_t width,
+    uint64_t address,
+    uint64_t value,
+    uint64_t mask)
+{
+    Acpi20ErstSerializationAction *action;
+
+    action = acpi_data_push(table_data, sizeof(*action));
+    action->serialization_action = serialization_action;
+    action->instruction = instruction;
+    action->flags = flags;
+    action->reserved = 0;
+    action->addr.space_id = AML_SYSTEM_MEMORY;
+    action->addr.bit_width = width;
+    action->addr.bit_offset = 0;
+    switch (width) {
+    case 8:
+        action->addr.access_width = 1;
+        break;
+    case 16:
+        action->addr.access_width = 2;
+        break;
+    case 32:
+        action->addr.access_width = 3;
+        break;
+    case 64:
+        action->addr.access_width = 4;
+        break;
+    default:
+        action->addr.access_width = 0;
+        break;
+    }
+    action->addr.address = cpu_to_le64(address);
+    action->value = cpu_to_le64(value);
+    action->mask = cpu_to_le64(mask);
+
+    return 1;
+}
+
+static const MemoryRegionOps erst_rw_ops = {
+    .read = erst_read,
+    .write = erst_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+void build_erst(GArray *table_data, BIOSLinker *linker, hwaddr base)
+{
+    Acpi20Erst *erst;
+    unsigned action, insns = 0;
+    unsigned erst_len = 0;
+
+    erst = acpi_data_push(table_data, sizeof(*erst));
+    erst->serialization_header_length = cpu_to_le32(sizeof(*erst));
+    erst->reserved = cpu_to_le32(0);
+    erst_len += sizeof(*erst);
+
+#define BEA(I, F, W, ADDR, VAL, MASK) \
+    build_erst_action(table_data, action, \
+        ACPI_ERST_INST_##I, F, W, base + ADDR, VAL, MASK)
+#define MASK8  0x00000000000000FFUL
+#define MASK16 0x000000000000FFFFUL
+#define MASK32 0x00000000FFFFFFFFUL
+#define MASK64 0xFFFFFFFFFFFFFFFFUL
+
+    for (action = 0; action < ACPI_ERST_MAX_ACTIONS; ++action) {
+        switch (action) {
+        case ACPI_ERST_ACTION_BEGIN_WRITE_OPERATION:
+            insns += BEA(WRITE_REGISTER_VALUE, 0, 32, ERST_CSR_ACTION, action, MASK8);
+            break;
+        case ACPI_ERST_ACTION_BEGIN_READ_OPERATION:
+            insns += BEA(WRITE_REGISTER_VALUE, 0, 32, ERST_CSR_ACTION, action, MASK8);
+            break;
+        case ACPI_ERST_ACTION_BEGIN_CLEAR_OPERATION:
+            insns += BEA(WRITE_REGISTER_VALUE, 0, 32, ERST_CSR_ACTION, action, MASK8);
+            break;
+        case ACPI_ERST_ACTION_END_OPERATION:
+            insns += BEA(WRITE_REGISTER_VALUE, 0, 32, ERST_CSR_ACTION, action, MASK8);
+            break;
+        case ACPI_ERST_ACTION_SET_RECORD_OFFSET:
+            insns += BEA(WRITE_REGISTER      , 0, 32, ERST_CSR_VALUE , 0, MASK32);
+            insns += BEA(WRITE_REGISTER_VALUE, 0, 32, ERST_CSR_ACTION, action, MASK8);
+            break;
+        case ACPI_ERST_ACTION_EXECUTE_OPERATION:
+            insns += BEA(WRITE_REGISTER_VALUE, 0, 32, ERST_CSR_VALUE , ERST_EXECUTE_OPERATION_MAGIC, MASK8);
+            insns += BEA(WRITE_REGISTER_VALUE, 0, 32, ERST_CSR_ACTION, action, MASK8);
+            break;
+        case ACPI_ERST_ACTION_CHECK_BUSY_STATUS:
+            insns += BEA(WRITE_REGISTER_VALUE, 0, 32, ERST_CSR_ACTION, action, MASK8);
+            insns += BEA(READ_REGISTER_VALUE , 0, 32, ERST_CSR_VALUE, 0x01, MASK8);
+            break;
+        case ACPI_ERST_ACTION_GET_COMMAND_STATUS:
+            insns += BEA(WRITE_REGISTER_VALUE, 0, 32, ERST_CSR_ACTION, action, MASK8);
+            insns += BEA(READ_REGISTER       , 0, 32, ERST_CSR_VALUE, 0, MASK8);
+            break;
+        case ACPI_ERST_ACTION_GET_RECORD_IDENTIFIER:
+            insns += BEA(WRITE_REGISTER_VALUE, 0, 32, ERST_CSR_ACTION, action, MASK8);
+            insns += BEA(READ_REGISTER       , 0, 64, ERST_CSR_VALUE, 0, MASK64);
+            break;
+        case ACPI_ERST_ACTION_SET_RECORD_IDENTIFIER:
+            insns += BEA(WRITE_REGISTER      , 0, 64, ERST_CSR_VALUE , 0, MASK64);
+            insns += BEA(WRITE_REGISTER_VALUE, 0, 32, ERST_CSR_ACTION, action, MASK8);
+            break;
+        case ACPI_ERST_ACTION_GET_RECORD_COUNT:
+            insns += BEA(WRITE_REGISTER_VALUE, 0, 32, ERST_CSR_ACTION, action, MASK8);
+            insns += BEA(READ_REGISTER       , 0, 32, ERST_CSR_VALUE, 0, MASK32);
+            break;
+        case ACPI_ERST_ACTION_BEGIN_DUMMY_WRITE_OPERATION:
+            insns += BEA(WRITE_REGISTER_VALUE, 0, 32, ERST_CSR_ACTION, action, MASK8);
+            break;
+        case ACPI_ERST_ACTION_RESERVED:
+            insns += BEA(WRITE_REGISTER_VALUE, 0, 32, ERST_CSR_ACTION, action, MASK8);
+            break;
+        case ACPI_ERST_ACTION_GET_ERROR_LOG_ADDRESS_RANGE:
+            insns += BEA(WRITE_REGISTER_VALUE, 0, 32, ERST_CSR_ACTION, action, MASK8);
+            insns += BEA(READ_REGISTER       , 0, 64, ERST_CSR_VALUE, 0, MASK64);
+            break;
+        case ACPI_ERST_ACTION_GET_ERROR_LOG_ADDRESS_LENGTH:
+            insns += BEA(WRITE_REGISTER_VALUE, 0, 32, ERST_CSR_ACTION, action, MASK8);
+            insns += BEA(READ_REGISTER       , 0, 64, ERST_CSR_VALUE, 0, MASK32);
+            break;
+        case ACPI_ERST_ACTION_GET_ERROR_LOG_ADDRESS_RANGE_ATTRIBUTES:
+            insns += BEA(WRITE_REGISTER_VALUE, 0, 32, ERST_CSR_ACTION, action, MASK8);
+            insns += BEA(READ_REGISTER       , 0, 32, ERST_CSR_VALUE, 0, MASK32);
+            break;
+        case ACPI_ERST_ACTION_GET_EXECUTE_OPERATION_TIMINGS:
+            insns += BEA(WRITE_REGISTER_VALUE, 0, 32, ERST_CSR_ACTION, action, MASK8);
+            insns += BEA(READ_REGISTER       , 0, 64, ERST_CSR_VALUE, 0, MASK64);
+        default:
+            insns += BEA(NOOP, 0, 0, 0, action, 0);
+            break;
+        }
+    }
+    erst->instruction_entry_count = cpu_to_le32(insns);
+    erst_len += (insns * sizeof(Acpi20ErstSerializationAction));
+
+    build_header(linker, table_data,
+                 (void *)erst, "ERST", erst_len, 1, NULL, NULL);
+
+    if (erst_base == 0) {
+        /*
+         * This ACPI routine is invoked * twice, but this code
+         * snippet needs to happen just once.
+         * And this code in erst_class_init() is too early.
+         */
+        DeviceState *dev;
+        SysBusDevice *s;
+
+        dev = qdev_new(TYPE_ACPI_ERST);
+        erst_debug("qdev_create dev %p\n", dev);
+        s = SYS_BUS_DEVICE(dev);
+        sysbus_realize_and_unref(s, &error_fatal);
+
+        ACPIERST(dev)->base = base;
+        sysbus_mmio_map(s, 0, base);
+        erst_base = base;
+        erst_debug("erst_base %lx\n", base);
+    }
+}
+
+/*******************************************************************/
+/*******************************************************************/
+static int erst_post_load(void *opaque, int version_id)
+{
+    ERSTDeviceState *s = opaque;
+    erst_debug("+erst_post_load(%d)\n", version_id);
+    /* Ensure nvram[] persists into backing file */
+    update_erst_backing_file(s, 0, s->nvram, s->prop_size);
+    erst_debug("-erst_post_load()\n");
+    return 0;
+}
+
+static const VMStateDescription erst_vmstate  = {
+    .name = "acpi-erst",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = erst_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8(operation, ERSTDeviceState),
+        VMSTATE_UINT8(busy_status, ERSTDeviceState),
+        VMSTATE_UINT8(command_status, ERSTDeviceState),
+        VMSTATE_UINT32(record_offset, ERSTDeviceState),
+        VMSTATE_UINT32(record_count, ERSTDeviceState),
+        VMSTATE_UINT64(reg_action, ERSTDeviceState),
+        VMSTATE_UINT64(reg_value, ERSTDeviceState),
+        VMSTATE_UINT64(record_identifier, ERSTDeviceState),
+        VMSTATE_UINT8_ARRAY(record, ERSTDeviceState, ERST_RECORD_SIZE),
+        VMSTATE_UINT8_ARRAY(tmp_record, ERSTDeviceState, ERST_RECORD_SIZE),
+        VMSTATE_VARRAY_UINT32(nvram, ERSTDeviceState, prop_size, 0,
+            vmstate_info_uint8, uint8_t),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void erst_realizefn(DeviceState *dev, Error **errp)
+{
+    SysBusDevice *d = SYS_BUS_DEVICE(dev);
+    ERSTDeviceState *s = ACPIERST(dev);
+
+    erst_debug("+erst_realizefn()\n");
+    if (!s->prop_filename) {
+        s->prop_filename = (char *)(TYPE_ACPI_ERST ".backing");
+    }
+
+    if (!s->prop_filename) {
+        error_setg(errp, "'filename' property is not set");
+        return;
+    }
+
+    if (!(s->prop_size > ERST_RECORD_SIZE) &&
+        (s->prop_size <= 0x04000000)) {
+        error_setg(errp, "'size' property %d is not set properly",
+            s->prop_size);
+        return;
+    }
+
+    /* Convert prop_size to integer multiple of ERST_RECORD_SIZE */
+    s->prop_size -= (s->prop_size % ERST_RECORD_SIZE);
+
+    load_erst_backing_file(s);
+
+    erst_debug("filename %s\n", s->prop_filename);
+    erst_debug("size %x\n", s->prop_size);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &erst_rw_ops, s,
+                          TYPE_ACPI_ERST, ERST_IOMEM_SIZE);
+    sysbus_init_mmio(d, &s->iomem);
+    erst_debug("-erst_realizefn()\n");
+}
+
+static void erst_unrealizefn(DeviceState *dev)
+{
+    ERSTDeviceState *s = ACPIERST(dev);
+
+    erst_debug("+erst_unrealizefn()\n");
+    if (s->nvram) {
+        /* Ensure nvram[] persists into backing file */
+        update_erst_backing_file(s, 0, s->nvram, s->prop_size);
+        g_free(s->nvram);
+        s->nvram = NULL;
+    }
+    erst_debug("-erst_unrealizefn()\n");
+}
+
+static void erst_reset(DeviceState *dev)
+{
+    ERSTDeviceState *s = ACPIERST(dev);
+
+    erst_debug("+erst_reset(%p) %d\n", s, s->record_count);
+    s->operation = 0;
+    s->busy_status = 0;
+    s->command_status = ACPI_ERST_STATUS_SUCCESS;
+    /* indicate empty/no-more until further notice */
+    s->record_identifier = ERST_INVALID_RECORD_ID;
+    s->record_offset = 0;
+    s->next_record_index = 0;
+    /* NOTE: record_count and nvram[] are initialized elsewhere */
+    erst_debug("-erst_reset()\n");
+}
+
+static Property erst_properties[] = {
+    DEFINE_PROP_UINT32("size", ERSTDeviceState, prop_size, 0x00010000),
+    DEFINE_PROP_STRING("filename", ERSTDeviceState, prop_filename),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void erst_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    erst_debug("+erst_class_init()\n");
+    dc->realize = erst_realizefn;
+    dc->unrealize = erst_unrealizefn;
+    dc->reset = erst_reset;
+    dc->vmsd = &erst_vmstate;
+    device_class_set_props(dc, erst_properties);
+    dc->desc = "ACPI Error Record Serialization Table (ERST) device";
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    erst_debug("-erst_class_init()\n");
+}
+
+static const TypeInfo erst_type_info = {
+    .name          = TYPE_ACPI_ERST,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .class_init    = erst_class_init,
+    .instance_size = sizeof(ERSTDeviceState),
+};
+
+static void erst_register_types(void)
+{
+    type_register_static(&erst_type_info);
+}
+
+type_init(erst_register_types)
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index dd69577..262a8ee 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -4,6 +4,7 @@ acpi_ss.add(files(
   'aml-build.c',
   'bios-linker-loader.c',
   'utils.c',
+  'erst.c',
 ))
 acpi_ss.add(when: 'CONFIG_ACPI_CPU_HOTPLUG', if_true: files('cpu.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_CPU_HOTPLUG', if_true: files('cpu_hotplug.c'))
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index e3a4bc2..2c6b867 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -43,6 +43,7 @@
 #include "sysemu/tpm.h"
 #include "hw/acpi/tpm.h"
 #include "hw/acpi/vmgenid.h"
+#include "hw/acpi/erst.h"
 #include "hw/boards.h"
 #include "sysemu/tpm_backend.h"
 #include "hw/rtc/mc146818rtc_regs.h"
@@ -2479,6 +2480,9 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     acpi_build_madt(tables_blob, tables->linker, x86ms,
                     ACPI_DEVICE_IF(x86ms->acpi_dev));
 
+    acpi_add_table(table_offsets, tables_blob);
+    build_erst(tables_blob, tables->linker, HPET_BASE + 0x10000UL);
+
     vmgenid_dev = find_vmgenid_dev();
     if (vmgenid_dev) {
         acpi_add_table(table_offsets, tables_blob);
diff --git a/include/hw/acpi/erst.h b/include/hw/acpi/erst.h
new file mode 100644
index 0000000..7882239
--- /dev/null
+++ b/include/hw/acpi/erst.h
@@ -0,0 +1,97 @@
+/*
+ * ACPI Error Record Serialization Table, ERST, Implementation
+ *
+ * Copyright (c) 2020 Oracle and/or its affiliates.
+ *
+ * See ACPI specification, "ACPI Platform Error Interfaces" : "Error Serialization"
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>
+ */
+#ifndef HW_ACPI_ERST_H
+#define HW_ACPI_ERST_H
+
+/*
+ * ERST Description Table
+ */
+struct Acpi20Erst {
+    ACPI_TABLE_HEADER_DEF                    /* ACPI common table header */
+    uint32_t           serialization_header_length;
+    uint32_t           reserved;
+    uint32_t           instruction_entry_count;
+} QEMU_PACKED;
+typedef struct Acpi20Erst Acpi20Erst;
+
+struct Acpi20ErstSerializationAction {
+    uint8_t serialization_action;
+    uint8_t instruction;
+    uint8_t flags;
+    uint8_t reserved;
+    struct AcpiGenericAddress addr;
+    uint64_t value;
+    uint64_t mask;
+} QEMU_PACKED;
+typedef struct Acpi20ErstSerializationAction Acpi20ErstSerializationAction;
+
+void build_erst(GArray *table_data, BIOSLinker *linker, hwaddr base);
+
+#define TYPE_ACPI_ERST "acpi-erst"
+
+#define ACPI_ERST_ACTION_BEGIN_WRITE_OPERATION         0x0
+#define ACPI_ERST_ACTION_BEGIN_READ_OPERATION          0x1
+#define ACPI_ERST_ACTION_BEGIN_CLEAR_OPERATION         0x2
+#define ACPI_ERST_ACTION_END_OPERATION                 0x3
+#define ACPI_ERST_ACTION_SET_RECORD_OFFSET             0x4
+#define ACPI_ERST_ACTION_EXECUTE_OPERATION             0x5
+#define ACPI_ERST_ACTION_CHECK_BUSY_STATUS             0x6
+#define ACPI_ERST_ACTION_GET_COMMAND_STATUS            0x7
+#define ACPI_ERST_ACTION_GET_RECORD_IDENTIFIER         0x8
+#define ACPI_ERST_ACTION_SET_RECORD_IDENTIFIER         0x9
+#define ACPI_ERST_ACTION_GET_RECORD_COUNT              0xA
+#define ACPI_ERST_ACTION_BEGIN_DUMMY_WRITE_OPERATION   0xB
+#define ACPI_ERST_ACTION_RESERVED                      0xC
+#define ACPI_ERST_ACTION_GET_ERROR_LOG_ADDRESS_RANGE   0xD
+#define ACPI_ERST_ACTION_GET_ERROR_LOG_ADDRESS_LENGTH  0xE
+#define ACPI_ERST_ACTION_GET_ERROR_LOG_ADDRESS_RANGE_ATTRIBUTES 0xF
+#define ACPI_ERST_ACTION_GET_EXECUTE_OPERATION_TIMINGS 0x10
+#define ACPI_ERST_MAX_ACTIONS (ACPI_ERST_ACTION_GET_EXECUTE_OPERATION_TIMINGS + 1)
+
+#define ACPI_ERST_STATUS_SUCCESS                0x00
+#define ACPI_ERST_STATUS_NOT_ENOUGH_SPACE       0x01
+#define ACPI_ERST_STATUS_HARDWARE_NOT_AVAILABLE 0x02
+#define ACPI_ERST_STATUS_FAILED                 0x03
+#define ACPI_ERST_STATUS_RECORD_STORE_EMPTY     0x04
+#define ACPI_ERST_STATUS_RECORD_NOT_FOUND       0x05
+
+#define ACPI_ERST_INST_READ_REGISTER                 0x00
+#define ACPI_ERST_INST_READ_REGISTER_VALUE           0x01
+#define ACPI_ERST_INST_WRITE_REGISTER                0x02
+#define ACPI_ERST_INST_WRITE_REGISTER_VALUE          0x03
+#define ACPI_ERST_INST_NOOP                          0x04
+#define ACPI_ERST_INST_LOAD_VAR1                     0x05
+#define ACPI_ERST_INST_LOAD_VAR2                     0x06
+#define ACPI_ERST_INST_STORE_VAR1                    0x07
+#define ACPI_ERST_INST_ADD                           0x08
+#define ACPI_ERST_INST_SUBTRACT                      0x09
+#define ACPI_ERST_INST_ADD_VALUE                     0x0A
+#define ACPI_ERST_INST_SUBTRACT_VALUE                0x0B
+#define ACPI_ERST_INST_STALL                         0x0C
+#define ACPI_ERST_INST_STALL_WHILE_TRUE              0x0D
+#define ACPI_ERST_INST_SKIP_NEXT_INSTRUCTION_IF_TRUE 0x0E
+#define ACPI_ERST_INST_GOTO                          0x0F
+#define ACPI_ERST_INST_SET_SRC_ADDRESS_BASE          0x10
+#define ACPI_ERST_INST_SET_DST_ADDRESS_BASE          0x11
+#define ACPI_ERST_INST_MOVE_DATA                     0x12
+
+#endif
+
-- 
1.8.3.1


