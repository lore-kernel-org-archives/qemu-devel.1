Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C03CA9EA0
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 01:27:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6732521D7B
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 01:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6732521D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOArD-0002eD-Fh
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 21:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54967)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iOADB-0002Zz-F7
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 20:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iOADA-0004kg-DV
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 20:45:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:5552)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iOADA-0004k9-66
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 20:45:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 17:45:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,230,1569308400"; d="scan'208";a="204705106"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by FMSMGA003.fm.intel.com with ESMTP; 25 Oct 2019 17:45:42 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: quintela@redhat.com,
	dgilbert@redhat.com
Subject: [PATCH v2 1/6] migration/multifd: move Params update and pages
 cleanup into multifd_send_fill_packet()
Date: Sat, 26 Oct 2019 08:45:15 +0800
Message-Id: <20191026004520.5515-2-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191026004520.5515-1-richardw.yang@linux.intel.com>
References: <20191026004520.5515-1-richardw.yang@linux.intel.com>
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

Fill data and update/cleanup related field in one place. Also make the
code a little clean.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 migration/ram.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 5876054195..35f147388b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -789,15 +789,16 @@ static void multifd_pages_clear(MultiFDPages_t *pages)
     g_free(pages);
 }
 
-static void multifd_send_fill_packet(MultiFDSendParams *p)
+static void multifd_send_fill_packet(MultiFDSendParams *p, uint32_t used)
 {
     MultiFDPacket_t *packet = p->packet;
+    uint32_t next_packet_size = used * qemu_target_page_size();
     int i;
 
     packet->flags = cpu_to_be32(p->flags);
     packet->pages_alloc = cpu_to_be32(p->pages->allocated);
     packet->pages_used = cpu_to_be32(p->pages->used);
-    packet->next_packet_size = cpu_to_be32(p->next_packet_size);
+    packet->next_packet_size = cpu_to_be32(next_packet_size);
     packet->packet_num = cpu_to_be64(p->packet_num);
 
     if (p->pages->block) {
@@ -807,6 +808,13 @@ static void multifd_send_fill_packet(MultiFDSendParams *p)
     for (i = 0; i < p->pages->used; i++) {
         packet->offset[i] = cpu_to_be64(p->pages->offset[i]);
     }
+
+    p->next_packet_size = next_packet_size;
+    p->flags = 0;
+    p->num_packets++;
+    p->num_pages += used;
+    p->pages->used = 0;
+    p->pages->block = NULL;
 }
 
 static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
@@ -1109,13 +1117,7 @@ static void *multifd_send_thread(void *opaque)
             uint64_t packet_num = p->packet_num;
             flags = p->flags;
 
-            p->next_packet_size = used * qemu_target_page_size();
-            multifd_send_fill_packet(p);
-            p->flags = 0;
-            p->num_packets++;
-            p->num_pages += used;
-            p->pages->used = 0;
-            p->pages->block = NULL;
+            multifd_send_fill_packet(p, used);
             qemu_mutex_unlock(&p->mutex);
 
             trace_multifd_send(p->id, packet_num, used, flags,
-- 
2.17.1


