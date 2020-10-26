Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B50C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:49:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65AFC2076D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65AFC2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX8Uc-00037F-CJ
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 15:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.widawsky@intel.com>)
 id 1kX8Lf-000371-9D
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:40:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:62565)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.widawsky@intel.com>)
 id 1kX8Lb-0002kJ-Is
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:40:06 -0400
IronPort-SDR: BtJiAeXmN2CmX3limi6tXmCXoGVoFo1w5X/ZtnapfJF0Qf0lwe07vIMdsAM8S7xjapBvyLFU5J
 3vWkZxT9421g==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="168103244"
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; d="scan'208";a="168103244"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2020 12:39:56 -0700
IronPort-SDR: ddc8LcyvM1RG4yDkNiBA2AND+wNCLGiBU/eQa6XE+6XsuamwIM8ncwm6nIlKispqiIx4g3giB7
 03DzGsdQWWzQ==
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; d="scan'208";a="334140296"
Received: from alhertig-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local)
 ([10.252.135.229])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2020 12:39:55 -0700
From: Ben Widawsky <ben.widawsky@intel.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] acpi/crs: Prevent bad ranges for host bridges
Date: Mon, 26 Oct 2020 12:39:23 -0700
Message-Id: <20201026193924.985014-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.24;
 envelope-from=ben.widawsky@intel.com; helo=mga09.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 15:39:56
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Ben Widawsky <ben.widawsky@intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Prevent _CRS resources being quietly chopped off and instead throw an
assertion. _CRS is used by host bridges to declare regions of io and/or
memory that they consume. On some (all?) platforms the host bridge
doesn't have PCI header space and so they need some way to convey the
information.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

---

1. I'm not aware of this being a real issue on platforms today as I think
   many platforms that use ACPI and actually have regions, constrain to
   32b to be complaint with legacy.
2. Since host bridges aren't usually hot plugged, it can't be invoked by
   a user, so assert() seems like the right way to handle this.
---
 hw/i386/acpi-build.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index eee7b57c37..df13abecf4 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -869,6 +869,8 @@ static Aml *build_crs(PCIHostState *host, CrsRangeSet *range_set)
     crs_range_merge(temp_range_set.mem_ranges);
     for (i = 0; i < temp_range_set.mem_ranges->len; i++) {
         entry = g_ptr_array_index(temp_range_set.mem_ranges, i);
+        assert(entry->limit <= UINT32_MAX &&
+               (entry->limit - entry->base + 1) <= UINT32_MAX);
         aml_append(crs,
                    aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED,
                                     AML_MAX_FIXED, AML_NON_CACHEABLE,
-- 
2.29.1


