Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8B7C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 07:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6596F20818
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 07:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6596F20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43029 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hETzW-0002Um-AT
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 03:19:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hETyG-0001oj-RP
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 03:18:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hETyF-0005U6-Ut
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 03:18:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:47561)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hETyF-0005T4-Ki
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 03:18:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	11 Apr 2019 00:18:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,336,1549958400"; d="scan'208";a="222497725"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga001.jf.intel.com with ESMTP; 11 Apr 2019 00:17:59 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Apr 2019 15:17:39 +0800
Message-Id: <20190411071739.22889-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.88
Subject: [Qemu-devel] [PATCH] hw/i386/pc: check apci hotplug capability
 before nvdimm's
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pbonzini@redhat.com, thuth@redhat.com,
	Wei Yang <richardw.yang@linux.intel.com>, ehabkost@redhat.com,
	rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190411071739.-iH9Ujilq1O_eXTowJgMzgZrGNo5O1v-iOaKr0_0xDg@z>

pc_memory_pre_plug() is called during hotplug for both pc-dimm and
nvdimm. This is more proper to check apci hotplug capability before
check nvdimm specific capability.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 hw/i386/pc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f2c15bf1f2..d48b6f9582 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2091,17 +2091,17 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    if (is_nvdimm && !ms->nvdimms_state->is_enabled) {
-        error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M'");
-        return;
-    }
-
     hotplug_handler_pre_plug(pcms->acpi_dev, dev, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
 
+    if (is_nvdimm && !ms->nvdimms_state->is_enabled) {
+        error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M'");
+        return;
+    }
+
     pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev),
                      pcmc->enforce_aligned_dimm ? NULL : &legacy_align, errp);
 }
-- 
2.19.1


