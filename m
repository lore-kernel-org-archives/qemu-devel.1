Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6477C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 21:20:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 371ED207C3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 21:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UlKcKBmV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371ED207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZKm6-00007o-4z
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 16:20:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kZKVB-00087P-2I
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 16:03:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49337)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kZKV6-0005Zw-MT
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 16:03:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604264575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DNntoeEtj0SJrnhqzjCT+HG7pjKe/WL8K1SG1lJPz5s=;
 b=UlKcKBmVqJ2VbxKBV1kFLvRIJ1kQJbtMGy77WE/H6/npHKgs96lbLMyWkENlPYUUHssx36
 x92t/8cOAu0fimpfwf1psPCcOsO40SpF3oIOEiIoLB1KYrAhdR/NL7FSVCKXgv5B8EqsIQ
 V6953e0mrXKT2Vch7OBaYHYwRgUX4gk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-qZ0kTfwFNg2ezNVYR_Xn3w-1; Sun, 01 Nov 2020 16:02:42 -0500
X-MC-Unique: qZ0kTfwFNg2ezNVYR_Xn3w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0223804017;
 Sun,  1 Nov 2020 21:02:41 +0000 (UTC)
Received: from gimli.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 36DDF5C1A3;
 Sun,  1 Nov 2020 21:02:38 +0000 (UTC)
Subject: [PULL v3 25/32] s390x/pci: create a header dedicated to PCI CLP
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Date: Sun, 01 Nov 2020 14:02:38 -0700
Message-ID: <160426455798.24886.8853826740623062134.stgit@gimli.home>
In-Reply-To: <160426371498.24886.12193840637250368669.stgit@gimli.home>
References: <160426371498.24886.12193840637250368669.stgit@gimli.home>
User-Agent: StGit/0.21-dirty
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/01 15:59:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Cornelia Huck <cohuck@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Pierre Morel <pmorel@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pierre Morel <pmorel@linux.ibm.com>

To have a clean separation between s390-pci-bus.h and s390-pci-inst.h
headers we export the PCI CLP instructions in a dedicated header.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 include/hw/s390x/s390-pci-bus.h  |    1 
 include/hw/s390x/s390-pci-clp.h  |  211 ++++++++++++++++++++++++++++++++++++++
 include/hw/s390x/s390-pci-inst.h |  196 -----------------------------------
 3 files changed, 212 insertions(+), 196 deletions(-)
 create mode 100644 include/hw/s390x/s390-pci-clp.h

diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 6a35f1365bec..5f339e57fb68 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -19,6 +19,7 @@
 #include "hw/s390x/sclp.h"
 #include "hw/s390x/s390_flic.h"
 #include "hw/s390x/css.h"
+#include "hw/s390x/s390-pci-clp.h"
 #include "qom/object.h"
 
 #define TYPE_S390_PCI_HOST_BRIDGE "s390-pcihost"
diff --git a/include/hw/s390x/s390-pci-clp.h b/include/hw/s390x/s390-pci-clp.h
new file mode 100644
index 000000000000..3708acd173c6
--- /dev/null
+++ b/include/hw/s390x/s390-pci-clp.h
@@ -0,0 +1,211 @@
+/*
+ * s390 CLP instruction definitions
+ *
+ * Copyright 2019 IBM Corp.
+ * Author(s): Pierre Morel <pmorel@de.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#ifndef HW_S390_PCI_CLP
+#define HW_S390_PCI_CLP
+
+/* CLP common request & response block size */
+#define CLP_BLK_SIZE 4096
+#define PCI_BAR_COUNT 6
+#define PCI_MAX_FUNCTIONS 4096
+
+typedef struct ClpReqHdr {
+    uint16_t len;
+    uint16_t cmd;
+} QEMU_PACKED ClpReqHdr;
+
+typedef struct ClpRspHdr {
+    uint16_t len;
+    uint16_t rsp;
+} QEMU_PACKED ClpRspHdr;
+
+/* CLP Response Codes */
+#define CLP_RC_OK         0x0010  /* Command request successfully */
+#define CLP_RC_CMD        0x0020  /* Command code not recognized */
+#define CLP_RC_PERM       0x0030  /* Command not authorized */
+#define CLP_RC_FMT        0x0040  /* Invalid command request format */
+#define CLP_RC_LEN        0x0050  /* Invalid command request length */
+#define CLP_RC_8K         0x0060  /* Command requires 8K LPCB */
+#define CLP_RC_RESNOT0    0x0070  /* Reserved field not zero */
+#define CLP_RC_NODATA     0x0080  /* No data available */
+#define CLP_RC_FC_UNKNOWN 0x0100  /* Function code not recognized */
+
+/*
+ * Call Logical Processor - Command Codes
+ */
+#define CLP_LIST_PCI            0x0002
+#define CLP_QUERY_PCI_FN        0x0003
+#define CLP_QUERY_PCI_FNGRP     0x0004
+#define CLP_SET_PCI_FN          0x0005
+
+/* PCI function handle list entry */
+typedef struct ClpFhListEntry {
+    uint16_t device_id;
+    uint16_t vendor_id;
+#define CLP_FHLIST_MASK_CONFIG 0x80000000
+    uint32_t config;
+    uint32_t fid;
+    uint32_t fh;
+} QEMU_PACKED ClpFhListEntry;
+
+#define CLP_RC_SETPCIFN_FH      0x0101 /* Invalid PCI fn handle */
+#define CLP_RC_SETPCIFN_FHOP    0x0102 /* Fn handle not valid for op */
+#define CLP_RC_SETPCIFN_DMAAS   0x0103 /* Invalid DMA addr space */
+#define CLP_RC_SETPCIFN_RES     0x0104 /* Insufficient resources */
+#define CLP_RC_SETPCIFN_ALRDY   0x0105 /* Fn already in requested state */
+#define CLP_RC_SETPCIFN_ERR     0x0106 /* Fn in permanent error state */
+#define CLP_RC_SETPCIFN_RECPND  0x0107 /* Error recovery pending */
+#define CLP_RC_SETPCIFN_BUSY    0x0108 /* Fn busy */
+#define CLP_RC_LISTPCI_BADRT    0x010a /* Resume token not recognized */
+#define CLP_RC_QUERYPCIFG_PFGID 0x010b /* Unrecognized PFGID */
+
+/* request or response block header length */
+#define LIST_PCI_HDR_LEN 32
+
+/* Number of function handles fitting in response block */
+#define CLP_FH_LIST_NR_ENTRIES \
+    ((CLP_BLK_SIZE - 2 * LIST_PCI_HDR_LEN) \
+        / sizeof(ClpFhListEntry))
+
+#define CLP_SET_ENABLE_PCI_FN  0 /* Yes, 0 enables it */
+#define CLP_SET_DISABLE_PCI_FN 1 /* Yes, 1 disables it */
+
+#define CLP_UTIL_STR_LEN 64
+
+#define CLP_MASK_FMT 0xf0000000
+
+/* List PCI functions request */
+typedef struct ClpReqListPci {
+    ClpReqHdr hdr;
+    uint32_t fmt;
+    uint64_t reserved1;
+    uint64_t resume_token;
+    uint64_t reserved2;
+} QEMU_PACKED ClpReqListPci;
+
+/* List PCI functions response */
+typedef struct ClpRspListPci {
+    ClpRspHdr hdr;
+    uint32_t fmt;
+    uint64_t reserved1;
+    uint64_t resume_token;
+    uint32_t mdd;
+    uint16_t max_fn;
+    uint8_t flags;
+    uint8_t entry_size;
+    ClpFhListEntry fh_list[CLP_FH_LIST_NR_ENTRIES];
+} QEMU_PACKED ClpRspListPci;
+
+/* Query PCI function request */
+typedef struct ClpReqQueryPci {
+    ClpReqHdr hdr;
+    uint32_t fmt;
+    uint64_t reserved1;
+    uint32_t fh; /* function handle */
+    uint32_t reserved2;
+    uint64_t reserved3;
+} QEMU_PACKED ClpReqQueryPci;
+
+/* Query PCI function response */
+typedef struct ClpRspQueryPci {
+    ClpRspHdr hdr;
+    uint32_t fmt;
+    uint64_t reserved1;
+    uint16_t vfn; /* virtual fn number */
+#define CLP_RSP_QPCI_MASK_UTIL  0x100
+#define CLP_RSP_QPCI_MASK_PFGID 0xff
+    uint16_t ug;
+    uint32_t fid; /* pci function id */
+    uint8_t bar_size[PCI_BAR_COUNT];
+    uint16_t pchid;
+    uint32_t bar[PCI_BAR_COUNT];
+    uint64_t reserved2;
+    uint64_t sdma; /* start dma as */
+    uint64_t edma; /* end dma as */
+    uint32_t reserved3[11];
+    uint32_t uid;
+    uint8_t util_str[CLP_UTIL_STR_LEN]; /* utility string */
+} QEMU_PACKED ClpRspQueryPci;
+
+/* Query PCI function group request */
+typedef struct ClpReqQueryPciGrp {
+    ClpReqHdr hdr;
+    uint32_t fmt;
+    uint64_t reserved1;
+#define CLP_REQ_QPCIG_MASK_PFGID 0xff
+    uint32_t g;
+    uint32_t reserved2;
+    uint64_t reserved3;
+} QEMU_PACKED ClpReqQueryPciGrp;
+
+/* Query PCI function group response */
+typedef struct ClpRspQueryPciGrp {
+    ClpRspHdr hdr;
+    uint32_t fmt;
+    uint64_t reserved1;
+#define CLP_RSP_QPCIG_MASK_NOI 0xfff
+    uint16_t i;
+    uint8_t version;
+#define CLP_RSP_QPCIG_MASK_FRAME   0x2
+#define CLP_RSP_QPCIG_MASK_REFRESH 0x1
+    uint8_t fr;
+    uint16_t maxstbl;
+    uint16_t mui;
+    uint64_t reserved3;
+    uint64_t dasm; /* dma address space mask */
+    uint64_t msia; /* MSI address */
+    uint64_t reserved4;
+    uint64_t reserved5;
+} QEMU_PACKED ClpRspQueryPciGrp;
+
+/* Set PCI function request */
+typedef struct ClpReqSetPci {
+    ClpReqHdr hdr;
+    uint32_t fmt;
+    uint64_t reserved1;
+    uint32_t fh; /* function handle */
+    uint16_t reserved2;
+    uint8_t oc; /* operation controls */
+    uint8_t ndas; /* number of dma spaces */
+    uint64_t reserved3;
+} QEMU_PACKED ClpReqSetPci;
+
+/* Set PCI function response */
+typedef struct ClpRspSetPci {
+    ClpRspHdr hdr;
+    uint32_t fmt;
+    uint64_t reserved1;
+    uint32_t fh; /* function handle */
+    uint32_t reserved3;
+    uint64_t reserved4;
+} QEMU_PACKED ClpRspSetPci;
+
+typedef struct ClpReqRspListPci {
+    ClpReqListPci request;
+    ClpRspListPci response;
+} QEMU_PACKED ClpReqRspListPci;
+
+typedef struct ClpReqRspSetPci {
+    ClpReqSetPci request;
+    ClpRspSetPci response;
+} QEMU_PACKED ClpReqRspSetPci;
+
+typedef struct ClpReqRspQueryPci {
+    ClpReqQueryPci request;
+    ClpRspQueryPci response;
+} QEMU_PACKED ClpReqRspQueryPci;
+
+typedef struct ClpReqRspQueryPciGrp {
+    ClpReqQueryPciGrp request;
+    ClpRspQueryPciGrp response;
+} QEMU_PACKED ClpReqRspQueryPciGrp;
+
+#endif
diff --git a/include/hw/s390x/s390-pci-inst.h b/include/hw/s390x/s390-pci-inst.h
index 8ee3a3c23757..a55c448aad24 100644
--- a/include/hw/s390x/s390-pci-inst.h
+++ b/include/hw/s390x/s390-pci-inst.h
@@ -17,202 +17,6 @@
 #include "s390-pci-bus.h"
 #include "sysemu/dma.h"
 
-/* CLP common request & response block size */
-#define CLP_BLK_SIZE 4096
-#define PCI_BAR_COUNT 6
-#define PCI_MAX_FUNCTIONS 4096
-
-typedef struct ClpReqHdr {
-    uint16_t len;
-    uint16_t cmd;
-} QEMU_PACKED ClpReqHdr;
-
-typedef struct ClpRspHdr {
-    uint16_t len;
-    uint16_t rsp;
-} QEMU_PACKED ClpRspHdr;
-
-/* CLP Response Codes */
-#define CLP_RC_OK         0x0010  /* Command request successfully */
-#define CLP_RC_CMD        0x0020  /* Command code not recognized */
-#define CLP_RC_PERM       0x0030  /* Command not authorized */
-#define CLP_RC_FMT        0x0040  /* Invalid command request format */
-#define CLP_RC_LEN        0x0050  /* Invalid command request length */
-#define CLP_RC_8K         0x0060  /* Command requires 8K LPCB */
-#define CLP_RC_RESNOT0    0x0070  /* Reserved field not zero */
-#define CLP_RC_NODATA     0x0080  /* No data available */
-#define CLP_RC_FC_UNKNOWN 0x0100  /* Function code not recognized */
-
-/*
- * Call Logical Processor - Command Codes
- */
-#define CLP_LIST_PCI            0x0002
-#define CLP_QUERY_PCI_FN        0x0003
-#define CLP_QUERY_PCI_FNGRP     0x0004
-#define CLP_SET_PCI_FN          0x0005
-
-/* PCI function handle list entry */
-typedef struct ClpFhListEntry {
-    uint16_t device_id;
-    uint16_t vendor_id;
-#define CLP_FHLIST_MASK_CONFIG 0x80000000
-    uint32_t config;
-    uint32_t fid;
-    uint32_t fh;
-} QEMU_PACKED ClpFhListEntry;
-
-#define CLP_RC_SETPCIFN_FH      0x0101 /* Invalid PCI fn handle */
-#define CLP_RC_SETPCIFN_FHOP    0x0102 /* Fn handle not valid for op */
-#define CLP_RC_SETPCIFN_DMAAS   0x0103 /* Invalid DMA addr space */
-#define CLP_RC_SETPCIFN_RES     0x0104 /* Insufficient resources */
-#define CLP_RC_SETPCIFN_ALRDY   0x0105 /* Fn already in requested state */
-#define CLP_RC_SETPCIFN_ERR     0x0106 /* Fn in permanent error state */
-#define CLP_RC_SETPCIFN_RECPND  0x0107 /* Error recovery pending */
-#define CLP_RC_SETPCIFN_BUSY    0x0108 /* Fn busy */
-#define CLP_RC_LISTPCI_BADRT    0x010a /* Resume token not recognized */
-#define CLP_RC_QUERYPCIFG_PFGID 0x010b /* Unrecognized PFGID */
-
-/* request or response block header length */
-#define LIST_PCI_HDR_LEN 32
-
-/* Number of function handles fitting in response block */
-#define CLP_FH_LIST_NR_ENTRIES \
-    ((CLP_BLK_SIZE - 2 * LIST_PCI_HDR_LEN) \
-        / sizeof(ClpFhListEntry))
-
-#define CLP_SET_ENABLE_PCI_FN  0 /* Yes, 0 enables it */
-#define CLP_SET_DISABLE_PCI_FN 1 /* Yes, 1 disables it */
-
-#define CLP_UTIL_STR_LEN 64
-
-#define CLP_MASK_FMT 0xf0000000
-
-/* List PCI functions request */
-typedef struct ClpReqListPci {
-    ClpReqHdr hdr;
-    uint32_t fmt;
-    uint64_t reserved1;
-    uint64_t resume_token;
-    uint64_t reserved2;
-} QEMU_PACKED ClpReqListPci;
-
-/* List PCI functions response */
-typedef struct ClpRspListPci {
-    ClpRspHdr hdr;
-    uint32_t fmt;
-    uint64_t reserved1;
-    uint64_t resume_token;
-    uint32_t mdd;
-    uint16_t max_fn;
-    uint8_t flags;
-    uint8_t entry_size;
-    ClpFhListEntry fh_list[CLP_FH_LIST_NR_ENTRIES];
-} QEMU_PACKED ClpRspListPci;
-
-/* Query PCI function request */
-typedef struct ClpReqQueryPci {
-    ClpReqHdr hdr;
-    uint32_t fmt;
-    uint64_t reserved1;
-    uint32_t fh; /* function handle */
-    uint32_t reserved2;
-    uint64_t reserved3;
-} QEMU_PACKED ClpReqQueryPci;
-
-/* Query PCI function response */
-typedef struct ClpRspQueryPci {
-    ClpRspHdr hdr;
-    uint32_t fmt;
-    uint64_t reserved1;
-    uint16_t vfn; /* virtual fn number */
-#define CLP_RSP_QPCI_MASK_UTIL  0x100
-#define CLP_RSP_QPCI_MASK_PFGID 0xff
-    uint16_t ug;
-    uint32_t fid; /* pci function id */
-    uint8_t bar_size[PCI_BAR_COUNT];
-    uint16_t pchid;
-    uint32_t bar[PCI_BAR_COUNT];
-    uint64_t reserved2;
-    uint64_t sdma; /* start dma as */
-    uint64_t edma; /* end dma as */
-    uint32_t reserved3[11];
-    uint32_t uid;
-    uint8_t util_str[CLP_UTIL_STR_LEN]; /* utility string */
-} QEMU_PACKED ClpRspQueryPci;
-
-/* Query PCI function group request */
-typedef struct ClpReqQueryPciGrp {
-    ClpReqHdr hdr;
-    uint32_t fmt;
-    uint64_t reserved1;
-#define CLP_REQ_QPCIG_MASK_PFGID 0xff
-    uint32_t g;
-    uint32_t reserved2;
-    uint64_t reserved3;
-} QEMU_PACKED ClpReqQueryPciGrp;
-
-/* Query PCI function group response */
-typedef struct ClpRspQueryPciGrp {
-    ClpRspHdr hdr;
-    uint32_t fmt;
-    uint64_t reserved1;
-#define CLP_RSP_QPCIG_MASK_NOI 0xfff
-    uint16_t i;
-    uint8_t version;
-#define CLP_RSP_QPCIG_MASK_FRAME   0x2
-#define CLP_RSP_QPCIG_MASK_REFRESH 0x1
-    uint8_t fr;
-    uint16_t maxstbl;
-    uint16_t mui;
-    uint64_t reserved3;
-    uint64_t dasm; /* dma address space mask */
-    uint64_t msia; /* MSI address */
-    uint64_t reserved4;
-    uint64_t reserved5;
-} QEMU_PACKED ClpRspQueryPciGrp;
-
-/* Set PCI function request */
-typedef struct ClpReqSetPci {
-    ClpReqHdr hdr;
-    uint32_t fmt;
-    uint64_t reserved1;
-    uint32_t fh; /* function handle */
-    uint16_t reserved2;
-    uint8_t oc; /* operation controls */
-    uint8_t ndas; /* number of dma spaces */
-    uint64_t reserved3;
-} QEMU_PACKED ClpReqSetPci;
-
-/* Set PCI function response */
-typedef struct ClpRspSetPci {
-    ClpRspHdr hdr;
-    uint32_t fmt;
-    uint64_t reserved1;
-    uint32_t fh; /* function handle */
-    uint32_t reserved3;
-    uint64_t reserved4;
-} QEMU_PACKED ClpRspSetPci;
-
-typedef struct ClpReqRspListPci {
-    ClpReqListPci request;
-    ClpRspListPci response;
-} QEMU_PACKED ClpReqRspListPci;
-
-typedef struct ClpReqRspSetPci {
-    ClpReqSetPci request;
-    ClpRspSetPci response;
-} QEMU_PACKED ClpReqRspSetPci;
-
-typedef struct ClpReqRspQueryPci {
-    ClpReqQueryPci request;
-    ClpRspQueryPci response;
-} QEMU_PACKED ClpReqRspQueryPci;
-
-typedef struct ClpReqRspQueryPciGrp {
-    ClpReqQueryPciGrp request;
-    ClpRspQueryPciGrp response;
-} QEMU_PACKED ClpReqRspQueryPciGrp;
-
 /* Load/Store status codes */
 #define ZPCI_PCI_ST_FUNC_NOT_ENABLED        4
 #define ZPCI_PCI_ST_FUNC_IN_ERR             8


