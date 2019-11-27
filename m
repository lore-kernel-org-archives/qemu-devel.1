Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD89C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 19:18:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7CF220862
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 19:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7CF220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia2pM-0001Rm-Nq
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 14:18:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ia2n6-0008Q6-KK
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:15:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ia2n4-0004OK-6k
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:15:55 -0500
Received: from relay.sw.ru ([185.231.240.75]:53328)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ia2n3-0004Lw-9w
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:15:54 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1ia2mz-0003f3-85; Wed, 27 Nov 2019 22:15:49 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6] 9pfs: well form error hint helpers
Date: Wed, 27 Nov 2019 22:15:49 +0300
Message-Id: <20191127191549.21216-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: vsementsov@virtuozzo.com, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make error_append_security_model_hint and
error_append_socket_sockfd_hint hint append helpers well formed:
rename errp to errp_in, as it is IN-parameter here (which is unusual
for errp).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Acked-by: Greg Kurz <groug@kaod.org>
---

v6: add Greg's a-b

 hw/9pfs/9p-local.c | 4 ++--
 hw/9pfs/9p-proxy.c | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 4708c0bd89..76fa1858b7 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1473,9 +1473,9 @@ static void local_cleanup(FsContext *ctx)
     g_free(data);
 }
 
-static void error_append_security_model_hint(Error **errp)
+static void error_append_security_model_hint(Error **errp_in)
 {
-    error_append_hint(errp, "Valid options are: security_model="
+    error_append_hint(errp_in, "Valid options are: security_model="
                       "[passthrough|mapped-xattr|mapped-file|none]\n");
 }
 
diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
index 97ab9c58a5..9e29abc3ef 100644
--- a/hw/9pfs/9p-proxy.c
+++ b/hw/9pfs/9p-proxy.c
@@ -1114,9 +1114,10 @@ static int connect_namedsocket(const char *path, Error **errp)
     return sockfd;
 }
 
-static void error_append_socket_sockfd_hint(Error **errp)
+static void error_append_socket_sockfd_hint(Error **errp_in)
 {
-    error_append_hint(errp, "Either specify socket=/some/path where /some/path"
+    error_append_hint(errp_in,
+                      "Either specify socket=/some/path where /some/path"
                       " points to a listening AF_UNIX socket or sock_fd=fd"
                       " where fd is a file descriptor to a connected AF_UNIX"
                       " socket\n");
-- 
2.21.0


