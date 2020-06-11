Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED38C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:11:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99DC5206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZoFnvLxP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99DC5206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTXZ-0004eN-O7
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8u-0007tB-7B
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45904
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8q-00011a-Ua
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PMkk8hqdAgfZ2X3p5aW45AQlLiVDJAHPMgDqr+FqlA4=;
 b=ZoFnvLxPlXLeuov8xzL1ir8D/QsM+R8gZK1RluZudp/rbThRWv0elhkzMs+HobHOCL+xto
 K1nC/Ez39iki4fVjS3X5/1u+dgzkQK91Sm32CxuvM9KdqeQf06BQ+WMcMA9CqhjQkUQ+v3
 Upb+oL5dzfNWyi1xwBi4GaTNbKnQ53w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-LZ5NVVH0PS-IsE_K_ClniQ-1; Thu, 11 Jun 2020 15:45:29 -0400
X-MC-Unique: LZ5NVVH0PS-IsE_K_ClniQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAEA1872FE1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 19:45:28 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 955485C1B2;
 Thu, 11 Jun 2020 19:45:28 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 045/115] cpus: Fix botched configure_icount() error API
 violation fix
Date: Thu, 11 Jun 2020 15:43:39 -0400
Message-Id: <20200611194449.31468-46-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 08:37:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

Before recent commit abc9bf69a66, configure_icount() returned early
when option "shift" was absent: succeed when option "align" was also
absent, else fail.

Since then, it still errors out when only "align" is present, but
continues when both are absent.  Crashes when examining the value of
"shift" further.  Reproducer: -icount "".

Revert this erroneous part of the commit.

Fixes: abc9bf69a66a11499a801ff545b8fe7adbb3a04c
Fixes: Coverity CID 1428754
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200515042231.18201-1-armbru@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/cpus.c b/cpus.c
index 7ce0d569b3..34fc203808 100644
--- a/cpus.c
+++ b/cpus.c
@@ -821,8 +821,10 @@ void configure_icount(QemuOpts *opts, Error **errp)
     bool align = qemu_opt_get_bool(opts, "align", false);
     long time_shift = -1;
 
-    if (!option && qemu_opt_get(opts, "align")) {
-        error_setg(errp, "Please specify shift option when using align");
+    if (!option) {
+        if (qemu_opt_get(opts, "align") != NULL) {
+            error_setg(errp, "Please specify shift option when using align");
+        }
         return;
     }
 
-- 
2.26.2



