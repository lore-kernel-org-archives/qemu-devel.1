Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387C9C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:06:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F36C2207DA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hI9BTjeu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F36C2207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k93w0-0007Kn-8A
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k93vM-0006av-3L
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:05:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33040)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k93vK-0007eW-Cw
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598004325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Fhb5To+Ttj21y3yRy/23iibfl/9NI9yBxf4rvHBGA68=;
 b=hI9BTjeuBAEKAsCoyb5aSETo43IpTHZzewNc1O2KmqiyCYDJqA/sKY9vUCM5/jjABRoiFJ
 hQZig/DAendpeBu/+7DkiaFszy0CzgMBj2h2PSYIlV0ua8Btpx+OOduzLgfZMVVjY5J91b
 uwfyZMLgHBfZHzOuJNAbGNOYGlktcPo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-Xyv00I7yN2KaAXsLprzQlQ-1; Fri, 21 Aug 2020 06:05:23 -0400
X-MC-Unique: Xyv00I7yN2KaAXsLprzQlQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E446F81F03C;
 Fri, 21 Aug 2020 10:05:22 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD6335DA74;
 Fri, 21 Aug 2020 10:05:21 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] numa: hmat: fix cache size check
Date: Fri, 21 Aug 2020 06:05:19 -0400
Message-Id: <20200821100519.1325691-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:26:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
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
Cc: mprivozn@redhat.com, ehabkost@redhat.com, jingqi.liu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

when QEMU is started like:

qemu-system-x86_64 -smp 2 -machine hmat=on \
 -m 2G \
 -object memory-backend-ram,size=1G,id=m0 \
 -object memory-backend-ram,size=1G,id=m1 \
 -numa node,nodeid=0,memdev=m0 \
 -numa node,nodeid=1,memdev=m1,initiator=0 \
 -numa cpu,node-id=0,socket-id=0 \
 -numa cpu,node-id=0,socket-id=1 \
 -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-latency,latency=5 \
 -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=200M \
 -numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-latency,latency=10 \
 -numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-bandwidth,bandwidth=100M \
 -numa hmat-cache,node-id=0,size=8K,level=1,associativity=direct,policy=write-back,line=5 \
 -numa hmat-cache,node-id=0,size=16K,level=2,associativity=direct,policy=write-back,line=5

it errors out with:
 -numa hmat-cache,node-id=0,size=16K,level=2,associativity=direct,policy=write-back,line=5:
        Invalid size=16384, the size of level=2 should be less than the size(8192) of level=1

which doesn't look right as one would expect that L1 < L2 < L3 ...
Fix it by sawpping relevant size checks.

Fixes: c412a48d4d91 (numa: Extend CLI to provide memory side cache information)
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: jingqi.liu@intel.com

 hw/core/numa.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index d1a94a14f8..f9593ec716 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -425,10 +425,10 @@ void parse_numa_hmat_cache(MachineState *ms, NumaHmatCacheOptions *node,
 
     if ((node->level > 1) &&
         ms->numa_state->hmat_cache[node->node_id][node->level - 1] &&
-        (node->size >=
+        (node->size <=
             ms->numa_state->hmat_cache[node->node_id][node->level - 1]->size)) {
         error_setg(errp, "Invalid size=%" PRIu64 ", the size of level=%" PRIu8
-                   " should be less than the size(%" PRIu64 ") of "
+                   " should be larger than the size(%" PRIu64 ") of "
                    "level=%u", node->size, node->level,
                    ms->numa_state->hmat_cache[node->node_id]
                                              [node->level - 1]->size,
@@ -438,10 +438,10 @@ void parse_numa_hmat_cache(MachineState *ms, NumaHmatCacheOptions *node,
 
     if ((node->level < HMAT_LB_LEVELS - 1) &&
         ms->numa_state->hmat_cache[node->node_id][node->level + 1] &&
-        (node->size <=
+        (node->size >=
             ms->numa_state->hmat_cache[node->node_id][node->level + 1]->size)) {
         error_setg(errp, "Invalid size=%" PRIu64 ", the size of level=%" PRIu8
-                   " should be larger than the size(%" PRIu64 ") of "
+                   " should be less than the size(%" PRIu64 ") of "
                    "level=%u", node->size, node->level,
                    ms->numa_state->hmat_cache[node->node_id]
                                              [node->level + 1]->size,
-- 
2.26.2


