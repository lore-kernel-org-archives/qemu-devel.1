Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860DCC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 08:59:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5649F21D6C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 08:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5649F21D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIqm3-0007Ca-GX
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 04:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iIqdm-0004Pn-W6
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:51:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iIqdl-00066F-U5
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:51:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:57822)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iIqdl-00065Q-MC
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:51:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Oct 2019 01:51:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,283,1566889200"; d="scan'208";a="224271741"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga002.fm.intel.com with ESMTP; 11 Oct 2019 01:51:11 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: quintela@redhat.com,
	dgilbert@redhat.com
Subject: [PATCH 2/4] migration/multifd: use pages->allocated instead of the
 static max
Date: Fri, 11 Oct 2019 16:50:48 +0800
Message-Id: <20191011085050.17622-3-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011085050.17622-1-richardw.yang@linux.intel.com>
References: <20191011085050.17622-1-richardw.yang@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.88
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
Cc: qemu-devel@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

multifd_send_fill_packet() prepares meta data for following pages to
transfer. It would be more proper to fill pages->allocated instead of
static max value, especially we want to support flexible packet size.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 migration/ram.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index cf30171f44..6a3bef0434 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -791,13 +791,12 @@ static void multifd_pages_clear(MultiFDPages_t *pages)
 static void multifd_send_fill_packet(MultiFDSendParams *p)
 {
     MultiFDPacket_t *packet = p->packet;
-    uint32_t page_max = MULTIFD_PACKET_SIZE / qemu_target_page_size();
     int i;
 
     packet->magic = cpu_to_be32(MULTIFD_MAGIC);
     packet->version = cpu_to_be32(MULTIFD_VERSION);
     packet->flags = cpu_to_be32(p->flags);
-    packet->pages_alloc = cpu_to_be32(page_max);
+    packet->pages_alloc = cpu_to_be32(p->pages->allocated);
     packet->pages_used = cpu_to_be32(p->pages->used);
     packet->next_packet_size = cpu_to_be32(p->next_packet_size);
     packet->packet_num = cpu_to_be64(p->packet_num);
-- 
2.17.1


