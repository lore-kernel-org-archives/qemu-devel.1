Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A46C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:34:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21E70214F1
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wn6GLjEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E70214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jefA0-0005T5-A1
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 09:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jef95-0003d4-RG
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:33:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54577
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jef94-0000UA-Nf
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590759238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8m8XGXzSlg/aHizKpT5tky9a9FO2x/l397fqNhWct5A=;
 b=Wn6GLjEPvbUVJ+WY/Du4ENPlZiI/0bLBezHH68EmLCzyFNg7Wr4dYyDjkQN1jkFOGJm3EA
 YUZ/n/aS48cgFcXiVwQpBLCn9wM4Iq4IEjMBmnv5ms0o+Ajx6bCC7/XCqeE9RgiYuNLfjV
 iKSiG4fdb0vESNk3lEd9WqGeb+Ms/3Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-HER5EnZENiqT1UzRqsuS9w-1; Fri, 29 May 2020 09:33:56 -0400
X-MC-Unique: HER5EnZENiqT1UzRqsuS9w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F2191005510;
 Fri, 29 May 2020 13:33:55 +0000 (UTC)
Received: from lisa.redhat.com (unknown [10.40.192.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0CD585D9D5;
 Fri, 29 May 2020 13:33:53 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] numa: Allow HMAT cache to be defined before HMAT
 latency/bandwidth
Date: Fri, 29 May 2020 15:33:47 +0200
Message-Id: <ecccd6ff03e14692a4b23f93cf9b0327e0c6bd5d.1590753455.git.mprivozn@redhat.com>
In-Reply-To: <cover.1590753455.git.mprivozn@redhat.com>
References: <cover.1590753455.git.mprivozn@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 23:43:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: jingqi.liu@intel.com, tao3.xu@intel.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently, when defining a HMAT cache for a NUMA node (in
parse_numa_hmat_cache()) there is this check that forces users to
define HMAT latency/bandwidth first. There is no real need for
this, because nothing in the parse function relies on that and
the HMAT table is constructed way later - when ACPI table is
constructed.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 hw/core/numa.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index 316bc50d75..338453461c 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -384,7 +384,6 @@ void parse_numa_hmat_cache(MachineState *ms, NumaHmatCacheOptions *node,
                            Error **errp)
 {
     int nb_numa_nodes = ms->numa_state->num_nodes;
-    NodeInfo *numa_info = ms->numa_state->nodes;
     NumaHmatCacheOptions *hmat_cache = NULL;
 
     if (node->node_id >= nb_numa_nodes) {
@@ -393,13 +392,6 @@ void parse_numa_hmat_cache(MachineState *ms, NumaHmatCacheOptions *node,
         return;
     }
 
-    if (numa_info[node->node_id].lb_info_provided != (BIT(0) | BIT(1))) {
-        error_setg(errp, "The latency and bandwidth information of "
-                   "node-id=%" PRIu32 " should be provided before memory side "
-                   "cache attributes", node->node_id);
-        return;
-    }
-
     if (node->level < 1 || node->level >= HMAT_LB_LEVELS) {
         error_setg(errp, "Invalid level=%" PRIu8 ", it should be larger than 0 "
                    "and less than or equal to %d", node->level,
-- 
2.26.2


