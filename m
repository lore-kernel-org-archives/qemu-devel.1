Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F704C433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 11:07:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 076AA2067D
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 11:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 076AA2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqaae-00062D-B8
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 07:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1jqaZ6-0003xO-Qf
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 07:06:08 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:29827)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1jqaZ4-0004hH-4l
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 07:06:08 -0400
Authentication-Results: esa3.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: O9QW0YFfOy/Q8znWGSQyuQdD4h7Q1vNcBI3M2+mjz9GEaC7kFJVVDmpxhYneOT9S47gxJiQleo
 PrCokCKxRoaWButroNqmg9QXKqtyRm2isR7CGli4k57BFDK6r2OYK/eCN3U0B3Xmd2p9RGuBzz
 P3NuV9pqLTiKNzacmENIeijRLdch6KFftsg/vd8hwvH8qRf+QfUk6TKDh9EAef0BKEUinOAVCO
 lgcn2sa6Uq7togA1Y5GT//NNLssbHDu30Rd4Bq4xdQX6RzDHsv9UMs7goO6RZ2OrnB3yE9ovUI
 t0A=
X-SBRS: 2.7
X-MesageID: 21375916
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.75,300,1589256000"; d="scan'208";a="21375916"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH] acpi: Fix access to PM1 control and status registers
Date: Wed, 1 Jul 2020 12:05:49 +0100
Message-ID: <20200701110549.148522-1-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=216.71.145.155;
 envelope-from=anthony.perard@citrix.com; helo=esa3.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 07:06:03
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
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
Cc: Anthony PERARD <anthony.perard@citrix.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ACPI spec state that "Accesses to PM1 control registers are
accessed through byte and word accesses." (In section 4.7.3.2.1 PM1
Control Registers of my old spec copy rev 4.0a).

With commit 5d971f9e6725 ("memory: Revert "memory: accept mismatching
sizes in memory_region_access_valid""), it wasn't possible anymore to
access the pm1_cnt register by reading a single byte, and that is use
by at least a Xen firmware called "hvmloader".

Also, take care of the PM1 Status Registers which also have "Accesses
to the PM1 status registers are done through byte or word accesses"
(In section 4.7.3.1.1 PM1 Status Registers).

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/acpi/core.c | 46 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index 45cbed49abdd..31974e2f91bf 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -394,9 +394,17 @@ uint16_t acpi_pm1_evt_get_sts(ACPIREGS *ar)
     return ar->pm1.evt.sts;
 }
 
-static void acpi_pm1_evt_write_sts(ACPIREGS *ar, uint16_t val)
+static void acpi_pm1_evt_write_sts(ACPIREGS *ar, hwaddr addr, uint16_t val,
+                                   unsigned width)
 {
     uint16_t pm1_sts = acpi_pm1_evt_get_sts(ar);
+    if (width == 1) {
+        if (addr == 0) {
+            val |= pm1_sts & 0xff00;
+        } else if (addr == 1) {
+            val = (val << BITS_PER_BYTE) | (pm1_sts & 0xff);
+        }
+    }
     if (pm1_sts & val & ACPI_BITMASK_TIMER_STATUS) {
         /* if TMRSTS is reset, then compute the new overflow time */
         acpi_pm_tmr_calc_overflow_time(ar);
@@ -404,8 +412,16 @@ static void acpi_pm1_evt_write_sts(ACPIREGS *ar, uint16_t val)
     ar->pm1.evt.sts &= ~val;
 }
 
-static void acpi_pm1_evt_write_en(ACPIREGS *ar, uint16_t val)
+static void acpi_pm1_evt_write_en(ACPIREGS *ar, hwaddr addr, uint16_t val,
+                                  unsigned width)
 {
+    if (width == 1) {
+        if (addr == 0) {
+            val |= ar->pm1.evt.en & 0xff00;
+        } else if (addr == 1) {
+            val = (val << BITS_PER_BYTE) | (ar->pm1.evt.en & 0xff);
+        }
+    }
     ar->pm1.evt.en = val;
     qemu_system_wakeup_enable(QEMU_WAKEUP_REASON_RTC,
                               val & ACPI_BITMASK_RT_CLOCK_ENABLE);
@@ -434,9 +450,11 @@ static uint64_t acpi_pm_evt_read(void *opaque, hwaddr addr, unsigned width)
     ACPIREGS *ar = opaque;
     switch (addr) {
     case 0:
-        return acpi_pm1_evt_get_sts(ar);
+    case 1:
+        return acpi_pm1_evt_get_sts(ar) >> (addr * BITS_PER_BYTE);
     case 2:
-        return ar->pm1.evt.en;
+    case 3:
+        return ar->pm1.evt.en >> ((addr - 2) * BITS_PER_BYTE);
     default:
         return 0;
     }
@@ -448,11 +466,13 @@ static void acpi_pm_evt_write(void *opaque, hwaddr addr, uint64_t val,
     ACPIREGS *ar = opaque;
     switch (addr) {
     case 0:
-        acpi_pm1_evt_write_sts(ar, val);
+    case 1:
+        acpi_pm1_evt_write_sts(ar, addr, val, width);
         ar->pm1.evt.update_sci(ar);
         break;
     case 2:
-        acpi_pm1_evt_write_en(ar, val);
+    case 3:
+        acpi_pm1_evt_write_en(ar, addr - 2, val, width);
         ar->pm1.evt.update_sci(ar);
         break;
     }
@@ -461,7 +481,7 @@ static void acpi_pm_evt_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps acpi_pm_evt_ops = {
     .read = acpi_pm_evt_read,
     .write = acpi_pm_evt_write,
-    .valid.min_access_size = 2,
+    .valid.min_access_size = 1,
     .valid.max_access_size = 2,
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
@@ -590,19 +610,27 @@ void acpi_pm1_cnt_update(ACPIREGS *ar,
 static uint64_t acpi_pm_cnt_read(void *opaque, hwaddr addr, unsigned width)
 {
     ACPIREGS *ar = opaque;
-    return ar->pm1.cnt.cnt;
+    return ar->pm1.cnt.cnt >> (addr * BITS_PER_BYTE);
 }
 
 static void acpi_pm_cnt_write(void *opaque, hwaddr addr, uint64_t val,
                               unsigned width)
 {
+    ACPIREGS *ar = opaque;
+    if (width == 1) {
+        if (addr == 0) {
+            val |= ar->pm1.cnt.cnt & 0xff00;
+        } else if (addr == 1) {
+            val = (val << BITS_PER_BYTE) | (ar->pm1.cnt.cnt & 0xff);
+        }
+    }
     acpi_pm1_cnt_write(opaque, val);
 }
 
 static const MemoryRegionOps acpi_pm_cnt_ops = {
     .read = acpi_pm_cnt_read,
     .write = acpi_pm_cnt_write,
-    .valid.min_access_size = 2,
+    .valid.min_access_size = 1,
     .valid.max_access_size = 2,
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
-- 
Anthony PERARD


