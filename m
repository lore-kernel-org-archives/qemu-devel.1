Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1E8C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 16:19:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 574232087C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 16:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UzjJ92++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 574232087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBKcY-0008VK-IR
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 12:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kBKbs-0007bP-Ma
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 12:18:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39269
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kBKbq-00076w-0o
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 12:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598545120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=v4vUinftXWf3bEhPQgaqHWCzjCJ1ZRzAaGWx9OJziI4=;
 b=UzjJ92++C1C1G7IXJHfzjQjqcrNr4btX3sa/0UcXj1dR3qkwZljEkLWDTeL9FUcVL6yZE0
 ECHMZL+56XKnbKLD8LaK1m64qw/WVuznzYNRvyKNVqHt3vLDuCQjAiZnh7TQ48/ipUH1Fq
 duTDdo3aCLZ4syxtFYInCiVCCa49K6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-A9tBrpJWP3SoiZvrmzHS5A-1; Thu, 27 Aug 2020 12:18:38 -0400
X-MC-Unique: A9tBrpJWP3SoiZvrmzHS5A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A36E18BA288
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 16:18:37 +0000 (UTC)
Received: from localhost (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E68FF7A4D0;
 Thu, 27 Aug 2020 16:18:29 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH] test-vmstate: fix bad GTree usage, use-after-free
Date: Thu, 27 Aug 2020 20:18:26 +0400
Message-Id: <20200827161826.1165971-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=marcandre.lureau@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:13:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

According to g_tree_foreach() documentation:
"The tree may not be modified while iterating over it (you can't
add/remove items)."

Fixes: 9a85e4b8f6 ("migration: Support gtree migration")
Cc: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/test-vmstate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
index f7b3868881..31aefa78f0 100644
--- a/tests/test-vmstate.c
+++ b/tests/test-vmstate.c
@@ -1078,7 +1078,6 @@ static gboolean diff_tree(gpointer key, gpointer value, gpointer data)
     struct match_node_data d = {tp->tree2, key, value};
 
     g_tree_foreach(tp->tree2, tp->match_node, &d);
-    g_tree_remove(tp->tree1, key);
     return false;
 }
 
@@ -1088,7 +1087,7 @@ static void compare_trees(GTree *tree1, GTree *tree2,
     struct tree_cmp_data tp = {tree1, tree2, function};
 
     g_tree_foreach(tree1, diff_tree, &tp);
-    assert(g_tree_nnodes(tree1) == 0);
+    g_tree_destroy(g_tree_ref(tree1));
     assert(g_tree_nnodes(tree2) == 0);
 }
 
-- 
2.26.2


