Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB91C4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:15:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7F4120888
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WeU6qpA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7F4120888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLNLj-0003bq-W5
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 05:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kLNKR-0002ld-3q
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:14:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42841)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kLNKO-0004oT-Vr
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600938851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xrA1xnOQI7cZoLHiSTx7dq0DORnQfVpxcHHT/gOBmIw=;
 b=WeU6qpA6q0mxGiXCQXhmCk3+QZ55ysMUdTtnUStRMD74G8Evi6dyPEIgT2c/on1vPWChxQ
 xp7eJGWgaoLICtYXNQUJDRDzQ8Vlt3c49T51EEzn2JHW680f/SOUeuIZ4L0o66mgU65vPZ
 rECP+KgAiknKCLyoV0aB5PhO3MmK6Q0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-p1Y8jOKiPZydyimlyHfzjw-1; Thu, 24 Sep 2020 05:14:10 -0400
X-MC-Unique: p1Y8jOKiPZydyimlyHfzjw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DE67420EF;
 Thu, 24 Sep 2020 09:14:09 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B9715C22B;
 Thu, 24 Sep 2020 09:14:08 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] numa: hmat: require parent cache description before the next
 level one
Date: Thu, 24 Sep 2020 05:14:06 -0400
Message-Id: <20200924091406.1321012-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: jingqi.liu@intel.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Spec[1] defines 0 - 3 level memory side cache, however QEMU
CLI allows to specify an intermediate cache level without
specifying previous level. Such option(s) silently ignored
when building HMAT table, which leads to incomplete cache
information.
Make sure that previous level exists and error out
if it hasn't been provided.

1) ACPI 6.2A 5.2.27.5 Memory Side Cache Information Structure

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1842877
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/core/numa.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index f9593ec716..8282e0b2e6 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -424,7 +424,13 @@ void parse_numa_hmat_cache(MachineState *ms, NumaHmatCacheOptions *node,
     }
 
     if ((node->level > 1) &&
-        ms->numa_state->hmat_cache[node->node_id][node->level - 1] &&
+        ms->numa_state->hmat_cache[node->node_id][node->level - 1] == NULL) {
+        error_setg(errp, "Cache level=%" PRIu8 " shall be defined first",
+                   node->level - 1);
+        return;
+    }
+
+    if ((node->level > 1) &&
         (node->size <=
             ms->numa_state->hmat_cache[node->node_id][node->level - 1]->size)) {
         error_setg(errp, "Invalid size=%" PRIu64 ", the size of level=%" PRIu8
-- 
2.27.0


