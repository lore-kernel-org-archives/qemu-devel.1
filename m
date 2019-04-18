Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5512CC10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 15:03:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D04D206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 15:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D04D206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42616 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH8ZH-00067s-AL
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 11:03:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hH8V0-0002P9-Uo
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:58:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hH8QM-0002C2-2O
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:54:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hH8QL-0002Ai-S1
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:54:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 920C75859C
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 14:53:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6459260856
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 14:53:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id DDD521132BD3; Thu, 18 Apr 2019 16:53:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 18 Apr 2019 16:53:51 +0200
Message-Id: <20190418145355.21100-3-armbru@redhat.com>
In-Reply-To: <20190418145355.21100-1-armbru@redhat.com>
References: <20190418145355.21100-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Thu, 18 Apr 2019 14:53:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/6] tests/vhost-user-bridge: Fix misuse of
 isdigit()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190418145351.vtRwutdyFsICsGCc0vxl97-T7tyMuBf_cEgYmQ5reOs@z>

vubr_set_host() passes char values to isdigit().  Undefined behavior
when the value is negative.

Fix by using qemu_isdigit() instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/vhost-user-bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
index 0033b61f2e..d70b107ebc 100644
--- a/tests/vhost-user-bridge.c
+++ b/tests/vhost-user-bridge.c
@@ -645,7 +645,7 @@ vubr_host_notifier_setup(VubrDev *dev)
 static void
 vubr_set_host(struct sockaddr_in *saddr, const char *host)
 {
-    if (isdigit(host[0])) {
+    if (qemu_isdigit(host[0])) {
         if (!inet_aton(host, &saddr->sin_addr)) {
             fprintf(stderr, "inet_aton() failed.\n");
             exit(1);
-- 
2.17.2


