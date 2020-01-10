Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E640C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 17:18:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEDA120838
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 17:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="mj7FM5jz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEDA120838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipxv9-0004Cz-27
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 12:18:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1ipxtU-0003Eo-IZ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 12:16:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1ipxtT-0007yN-FX
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 12:16:20 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:47495)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1ipxtS-0007g8-PL; Fri, 10 Jan 2020 12:16:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
 bh=qgkNJkwqRe3hT9BZYSupicKMfv+PAwrqHOkYefNmWUk=; 
 b=mj7FM5jzLKYJdMsdnfROeIuoNb+HChq5gB1XN8TrDHG35EzWcT9qjVkLIdak03Sid4izWGnXOlXRZ8G9LfVlWyHw3EW5PmCCkKwPJ74uqHNX1So6G2rUYxkzUuDbSwkBR1RDX/IQG7JtDe3K42HIdvwCFA/HfKNqV7ICU7PRswKsfESbFUqb/jMTeidn24xk4JDdNr/nrJJG3Mg35B9X/2EZ0RcyN00PYjJjyd2n5fO1rlwcdNS9cB1QseIA5TPOOLjdneXmQ4W9bRP5xJhVShU1Nl9wmqHkviA/1y39VVbu0hEM1Lf4yKMkn/161Z2WfZB+K86DR0+AJ2/fQ2iimQ==;
Received: from [213.99.255.143] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1ipxtN-0005cB-O6; Fri, 10 Jan 2020 18:16:13 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1ipxsY-0005mI-Ny; Fri, 10 Jan 2020 18:15:22 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] block: Use a GString in bdrv_perm_names()
Date: Fri, 10 Jan 2020 18:15:18 +0100
Message-Id: <20200110171518.22168-1-berto@igalia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a bit more efficient than having to allocate and free memory
for each new permission.

The default size (30) is enough for "consistent read, write, resize".

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/block.c b/block.c
index 1b6f7c86e8..2bc9e58392 100644
--- a/block.c
+++ b/block.c
@@ -1976,18 +1976,19 @@ char *bdrv_perm_names(uint64_t perm)
         { 0, NULL }
     };
 
-    char *result = g_strdup("");
+    GString *result = g_string_sized_new(30);
     struct perm_name *p;
 
     for (p = permissions; p->name; p++) {
         if (perm & p->perm) {
-            char *old = result;
-            result = g_strdup_printf("%s%s%s", old, *old ? ", " : "", p->name);
-            g_free(old);
+            if (result->len > 0) {
+                g_string_append(result, ", ");
+            }
+            g_string_append(result, p->name);
         }
     }
 
-    return result;
+    return g_string_free(result, FALSE);
 }
 
 /*
-- 
2.20.1


