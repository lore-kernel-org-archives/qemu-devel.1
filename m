Return-Path: <SRS0=P1lm=VZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30571C41514
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2019 13:14:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 096CF2087C
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2019 13:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 096CF2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hrj0i-0006Dg-Ao
	for qemu-devel@archiver.kernel.org; Sun, 28 Jul 2019 09:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59665)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hrizb-0004yE-Th
 for qemu-devel@nongnu.org; Sun, 28 Jul 2019 09:13:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hriza-0002Qo-S5
 for qemu-devel@nongnu.org; Sun, 28 Jul 2019 09:13:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:60138)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1hriza-0002LS-In
 for qemu-devel@nongnu.org; Sun, 28 Jul 2019 09:13:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Jul 2019 06:13:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,318,1559545200"; d="scan'208";a="370141711"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga005.fm.intel.com with ESMTP; 28 Jul 2019 06:13:32 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Sun, 28 Jul 2019 21:13:02 +0800
Message-Id: <20190728131304.1282-2-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190728131304.1282-1-richardw.yang@linux.intel.com>
References: <20190728131304.1282-1-richardw.yang@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.20
Subject: [Qemu-devel] [PATCH 1/3] memory-device: not necessary to use goto
 for the last check
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
Cc: imammedo@redhat.com, david@redhat.com,
 Wei Yang <richardw.yang@linux.intel.com>, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are already at the last condition check.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 hw/mem/memory-device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 5f2c408036..df3261b32a 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -186,7 +186,6 @@ static uint64_t memory_device_get_free_addr(MachineState *ms,
     if (!range_contains_range(&as, &new)) {
         error_setg(errp, "could not find position in guest address space for "
                    "memory device - memory fragmented due to alignments");
-        goto out;
     }
 out:
     g_slist_free(list);
-- 
2.17.1


