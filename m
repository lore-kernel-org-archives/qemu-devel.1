Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271D7C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:15:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D8462240A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ar0IOJmJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8462240A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWzXV-0006YP-9r
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 06:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWzPA-0002e0-Lt
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:07:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52681)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWzP1-0006gH-Ks
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603706817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=tggwgkkb1+KGW5RlyNzlZ6ZtcwmGXHxKNFTOsB5GyGw=;
 b=Ar0IOJmJO2xzxGNOwsCSSx0ea5Wa1sGgd+NjvicSZ5tp1GMJe1xpDw1i792UDmWqe39Pp5
 EX2TkEM5Ps7yWG4Fdud5hDc99tFFaxvR6+87KX6kx9LmuDjQeqSTsph6eL+8KRsJuztQRW
 kHrbrBia8hD71yWiIvXr49UoQiix2f8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-d6MVrigYPwi-dNMWjrxTDg-1; Mon, 26 Oct 2020 06:06:54 -0400
X-MC-Unique: d6MVrigYPwi-dNMWjrxTDg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A135D10E2186;
 Mon, 26 Oct 2020 10:06:53 +0000 (UTC)
Received: from thuth.com (ovpn-112-104.ams2.redhat.com [10.36.112.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C623555774;
 Mon, 26 Oct 2020 10:06:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 11/31] fuzz: Add PCI features to the generic fuzzer
Date: Mon, 26 Oct 2020 11:06:12 +0100
Message-Id: <20201026100632.212530-12-thuth@redhat.com>
In-Reply-To: <20201026100632.212530-1-thuth@redhat.com>
References: <20201026100632.212530-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
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
Cc: Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Bulekov <alxndr@bu.edu>

This patch compares TYPE_PCI_DEVICE objects against the user-provided
matching pattern. If there is a match, we use some hacks and leverage
QOS to map each possible BAR for that device. Now fuzzed inputs might be
converted to pci_read/write commands which target specific. This means
that we can fuzz a particular device's PCI configuration space,

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Message-Id: <20201023150746.107063-4-alxndr@bu.edu>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/fuzz/generic_fuzz.c | 81 +++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
index 6e3faf4e92..483d41fb2c 100644
--- a/tests/qtest/fuzz/generic_fuzz.c
+++ b/tests/qtest/fuzz/generic_fuzz.c
@@ -24,6 +24,7 @@
 #include "exec/ramblock.h"
 #include "exec/address-spaces.h"
 #include "hw/qdev-core.h"
+#include "hw/pci/pci.h"
 
 /*
  * SEPARATOR is used to separate "operations" in the fuzz input
@@ -35,12 +36,17 @@ enum cmds {
     OP_OUT,
     OP_READ,
     OP_WRITE,
+    OP_PCI_READ,
+    OP_PCI_WRITE,
     OP_CLOCK_STEP,
 };
 
 #define DEFAULT_TIMEOUT_US 100000
 #define USEC_IN_SEC 1000000000
 
+#define PCI_HOST_BRIDGE_CFG 0xcf8
+#define PCI_HOST_BRIDGE_DATA 0xcfc
+
 typedef struct {
     ram_addr_t addr;
     ram_addr_t size; /* The number of bytes until the end of the I/O region */
@@ -55,6 +61,7 @@ static bool qtest_log_enabled;
  * user for fuzzing.
  */
 static GHashTable *fuzzable_memoryregions;
+static GPtrArray *fuzzable_pci_devices;
 
 struct get_io_cb_info {
     int index;
@@ -283,6 +290,65 @@ static void op_write(QTestState *s, const unsigned char * data, size_t len)
     }
 }
 
+static void op_pci_read(QTestState *s, const unsigned char * data, size_t len)
+{
+    enum Sizes {Byte, Word, Long, end_sizes};
+    struct {
+        uint8_t size;
+        uint8_t base;
+        uint8_t offset;
+    } a;
+    if (len < sizeof(a) || fuzzable_pci_devices->len == 0) {
+        return;
+    }
+    memcpy(&a, data, sizeof(a));
+    PCIDevice *dev = g_ptr_array_index(fuzzable_pci_devices,
+                                  a.base % fuzzable_pci_devices->len);
+    int devfn = dev->devfn;
+    qtest_outl(s, PCI_HOST_BRIDGE_CFG, (1U << 31) | (devfn << 8) | a.offset);
+    switch (a.size %= end_sizes) {
+    case Byte:
+        qtest_inb(s, PCI_HOST_BRIDGE_DATA);
+        break;
+    case Word:
+        qtest_inw(s, PCI_HOST_BRIDGE_DATA);
+        break;
+    case Long:
+        qtest_inl(s, PCI_HOST_BRIDGE_DATA);
+        break;
+    }
+}
+
+static void op_pci_write(QTestState *s, const unsigned char * data, size_t len)
+{
+    enum Sizes {Byte, Word, Long, end_sizes};
+    struct {
+        uint8_t size;
+        uint8_t base;
+        uint8_t offset;
+        uint32_t value;
+    } a;
+    if (len < sizeof(a) || fuzzable_pci_devices->len == 0) {
+        return;
+    }
+    memcpy(&a, data, sizeof(a));
+    PCIDevice *dev = g_ptr_array_index(fuzzable_pci_devices,
+                                  a.base % fuzzable_pci_devices->len);
+    int devfn = dev->devfn;
+    qtest_outl(s, PCI_HOST_BRIDGE_CFG, (1U << 31) | (devfn << 8) | a.offset);
+    switch (a.size %= end_sizes) {
+    case Byte:
+        qtest_outb(s, PCI_HOST_BRIDGE_DATA, a.value & 0xFF);
+        break;
+    case Word:
+        qtest_outw(s, PCI_HOST_BRIDGE_DATA, a.value & 0xFFFF);
+        break;
+    case Long:
+        qtest_outl(s, PCI_HOST_BRIDGE_DATA, a.value & 0xFFFFFFFF);
+        break;
+    }
+}
+
 static void op_clock_step(QTestState *s, const unsigned char *data, size_t len)
 {
     qtest_clock_step_next(s);
@@ -341,6 +407,8 @@ static void generic_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
         [OP_OUT]                = op_out,
         [OP_READ]               = op_read,
         [OP_WRITE]              = op_write,
+        [OP_PCI_READ]           = op_pci_read,
+        [OP_PCI_WRITE]          = op_pci_write,
         [OP_CLOCK_STEP]         = op_clock_step,
     };
     const unsigned char *cmd = Data;
@@ -432,6 +500,18 @@ static int locate_fuzz_objects(Object *child, void *opaque)
         /* Find and save ptrs to any child MemoryRegions */
         object_child_foreach_recursive(child, locate_fuzz_memory_regions, NULL);
 
+        /*
+         * We matched an object. If its a PCI device, store a pointer to it so
+         * we can map BARs and fuzz its config space.
+         */
+        if (object_dynamic_cast(OBJECT(child), TYPE_PCI_DEVICE)) {
+            /*
+             * Don't want duplicate pointers to the same PCIDevice, so remove
+             * copies of the pointer, before adding it.
+             */
+            g_ptr_array_remove_fast(fuzzable_pci_devices, PCI_DEVICE(child));
+            g_ptr_array_add(fuzzable_pci_devices, PCI_DEVICE(child));
+        }
     } else if (object_dynamic_cast(OBJECT(child), TYPE_MEMORY_REGION)) {
         if (g_pattern_match_simple(pattern,
             object_get_canonical_path_component(child))) {
@@ -464,6 +544,7 @@ static void generic_pre_fuzz(QTestState *s)
     }
 
     fuzzable_memoryregions = g_hash_table_new(NULL, NULL);
+    fuzzable_pci_devices   = g_ptr_array_new();
 
     result = g_strsplit(getenv("QEMU_FUZZ_OBJECTS"), " ", -1);
     for (int i = 0; result[i] != NULL; i++) {
-- 
2.18.2


