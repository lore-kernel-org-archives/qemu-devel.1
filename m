Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CF6C5517A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:53:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 581B520795
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581B520795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX8YD-0006nm-67
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 15:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.widawsky@intel.com>)
 id 1kX8Lh-0003Bn-DA
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:40:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:62565)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.widawsky@intel.com>)
 id 1kX8Lf-0002kJ-GI
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:40:09 -0400
IronPort-SDR: lx/+YXnimXKlQ35YPAtJL4PkYFgmZ0/c6UTTQ/HJXemvek90ekMzq0eflFS+1vdyJO3n3yybPe
 Bdx+Ti9rzTmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="168103249"
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; d="scan'208";a="168103249"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2020 12:39:56 -0700
IronPort-SDR: d/JXoVTLHd1Wd0oiGXdUxvd+QlFIiJnRLFyhmJpCix7EQ1av7knxiZc7M8m0Y8g98uGiSePL4b
 YzcJtMGaOB6g==
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; d="scan'208";a="334140300"
Received: from alhertig-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local)
 ([10.252.135.229])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2020 12:39:56 -0700
From: Ben Widawsky <ben.widawsky@intel.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] acpi/crs: Support ranges > 32b for hosts
Date: Mon, 26 Oct 2020 12:39:24 -0700
Message-Id: <20201026193924.985014-2-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201026193924.985014-1-ben.widawsky@intel.com>
References: <20201026193924.985014-1-ben.widawsky@intel.com>
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

According to PCIe spec 5.0 Type 1 header space Base Address Registers
are defined by 7.5.1.2.1 Base Address Registers (same as Type 0). The
_CRS region should allow for the same range (up to 64b). Prior to this
change, any host bridge utilizing more than 32b for the BAR would have
the address truncated and likely lead to conflicts when the operating
systems reads the _CRS object.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

---
I don't think this effects any code currently in QEMU. You'd need to
have a host bridge which has a BAR, and that BAR wants to be > 32b. I've
hit this because I have a modified PXB device that does advertise a 64b
BAR. Also, you'd need a platform that cares about ACPI, which, many do
not.
---
 hw/i386/acpi-build.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index df13abecf4..75604bdc74 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -789,8 +789,14 @@ static Aml *build_crs(PCIHostState *host, CrsRangeSet *range_set)
                 crs_range_insert(temp_range_set.io_ranges,
                                  range_base, range_limit);
             } else { /* "memory" */
-                crs_range_insert(temp_range_set.mem_ranges,
-                                 range_base, range_limit);
+                uint64_t length = range_limit - range_base + 1;
+                if (range_limit <= UINT32_MAX && length <= UINT32_MAX) {
+                    crs_range_insert(temp_range_set.mem_ranges, range_base,
+                                     range_limit);
+                } else {
+                    crs_range_insert(temp_range_set.mem_64bit_ranges,
+                                     range_base, range_limit);
+                }
             }
         }
 
-- 
2.29.1


