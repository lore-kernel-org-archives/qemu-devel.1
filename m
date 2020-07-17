Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD90C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 09:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C96E20684
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 09:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VPyVmo9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C96E20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwN9W-0006re-Sh
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 05:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jwN6K-0002Hr-EN
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 05:56:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46891
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jwN6I-0001Bw-Qe
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 05:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594979778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y45lSEUMyIoE6yQPaB/pQzhjlzxFp9qm+lfH6IYnJT0=;
 b=VPyVmo9RnsP21P9urlXBQVkdx77chKhEcNYZG0y7W5+cz5NKs6DFqINh+oUiQesh9/6tob
 YrA1mYGADGpSkbR5HgbbIC5gOgudH63CnGxEeUgFhoIdH4reLFUTG0OTuTbEby93TJWcSo
 54ne1L3lRdL6NQfd/nULG8qhg8znbR4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-9CSaW7_LNHWBYV5PEIdgWg-1; Fri, 17 Jul 2020 05:56:16 -0400
X-MC-Unique: 9CSaW7_LNHWBYV5PEIdgWg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C5B91888AC0;
 Fri, 17 Jul 2020 09:56:15 +0000 (UTC)
Received: from thuth.com (ovpn-112-62.ams2.redhat.com [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2FB7D5C1D4;
 Fri, 17 Jul 2020 09:56:14 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 5/6] qom: Plug memory leak in "info qom-tree"
Date: Fri, 17 Jul 2020 11:56:04 +0200
Message-Id: <20200717095605.27589-6-thuth@redhat.com>
In-Reply-To: <20200717095605.27589-1-thuth@redhat.com>
References: <20200717095605.27589-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 03:33:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

Commit e8c9e65816 "qom: Make "info qom-tree" show children sorted"
created a memory leak, because I didn't realize
object_get_canonical_path_component()'s value needs to be freed.

Reproducer:

    $ qemu-system-x86_64 -nodefaults -display none -S -monitor stdio
    QEMU 5.0.50 monitor - type 'help' for more information
    (qemu) info qom-tree

This leaks some 4500 path components, 12-13 characters on average,
i.e. roughly 100kBytes depending on the allocator.  A couple of
hundred "info qom-tree" here, a couple of hundred there, and soon
enough we're talking about real memory.

Plug the leak.

Fixes: e8c9e65816f5dbfe18ad3b2be938d0d8192d459a
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reported-by: Reviewed-by: Li Qiang <liq3ea@gmail.com> [sent same patch]
Message-Id: <20200714160202.3121879-3-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qom/qom-hmp-cmds.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
index 9ed8bb1c9f..aaacadacca 100644
--- a/qom/qom-hmp-cmds.c
+++ b/qom/qom-hmp-cmds.c
@@ -96,8 +96,10 @@ static void print_qom_composition(Monitor *mon, Object *obj, int indent);
 
 static int qom_composition_compare(const void *a, const void *b, void *ignore)
 {
-    return g_strcmp0(a ? object_get_canonical_path_component(a) : NULL,
-                     b ? object_get_canonical_path_component(b) : NULL);
+    g_autofree char *ac = object_get_canonical_path_component(a);
+    g_autofree char *bc = object_get_canonical_path_component(b);
+
+    return g_strcmp0(ac, bc);
 }
 
 static int insert_qom_composition_child(Object *obj, void *opaque)
-- 
2.18.1


