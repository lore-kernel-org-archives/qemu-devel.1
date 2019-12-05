Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB52C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 17:53:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 092DD206DB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 17:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 092DD206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icvK7-0006Jt-1j
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 12:53:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icvDI-0007cH-Ji
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:46:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icvDG-0003bF-9B
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:46:52 -0500
Received: from relay.sw.ru ([185.231.240.75]:48302)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1icvDE-0003Sx-4l
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:46:48 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1icvD7-00013M-2F; Thu, 05 Dec 2019 20:46:41 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 08/21] 9pfs: well form error hint helpers
Date: Thu,  5 Dec 2019 20:46:22 +0300
Message-Id: <20191205174635.18758-9-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191205174635.18758-1-vsementsov@virtuozzo.com>
References: <20191205174635.18758-1-vsementsov@virtuozzo.com>
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
Cc: vsementsov@virtuozzo.com, armbru@redhat.com, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make error_append_security_model_hint and
error_append_socket_sockfd_hint hint append helpers well formed:
switch errp paramter to Error *const * type, as it has uncommon
behavior: not change the pointer to return error, but operate on
already existent error object.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Acked-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c | 2 +-
 hw/9pfs/9p-proxy.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 4708c0bd89..ca641390fb 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1473,7 +1473,7 @@ static void local_cleanup(FsContext *ctx)
     g_free(data);
 }
 
-static void error_append_security_model_hint(Error **errp)
+static void error_append_security_model_hint(Error *const *errp)
 {
     error_append_hint(errp, "Valid options are: security_model="
                       "[passthrough|mapped-xattr|mapped-file|none]\n");
diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
index 97ab9c58a5..8136e1342d 100644
--- a/hw/9pfs/9p-proxy.c
+++ b/hw/9pfs/9p-proxy.c
@@ -1114,7 +1114,7 @@ static int connect_namedsocket(const char *path, Error **errp)
     return sockfd;
 }
 
-static void error_append_socket_sockfd_hint(Error **errp)
+static void error_append_socket_sockfd_hint(Error *const *errp)
 {
     error_append_hint(errp, "Either specify socket=/some/path where /some/path"
                       " points to a listening AF_UNIX socket or sock_fd=fd"
-- 
2.21.0


