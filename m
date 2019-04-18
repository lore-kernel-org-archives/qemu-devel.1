Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D18C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 15:03:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04915206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 15:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04915206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42620 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH8ZQ-0006GW-5V
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 11:03:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hH8V0-0002PV-O1
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:58:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hH8QM-0002Bk-0U
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:54:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hH8QL-0002BL-Qa
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:54:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2E7A530ADBB1
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 14:54:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0097E5C206
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 14:53:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id EC4CD1132B3B; Thu, 18 Apr 2019 16:53:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 18 Apr 2019 16:53:55 +0200
Message-Id: <20190418145355.21100-7-armbru@redhat.com>
In-Reply-To: <20190418145355.21100-1-armbru@redhat.com>
References: <20190418145355.21100-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Thu, 18 Apr 2019 14:54:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 6/6] cutils: Simplify how parse_uint() checks
 for whitespace
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
Message-ID: <20190418145355.XbGNI4foHcdU363B7ALtMqGSkdx5mcGA3bqvHztUKFA@z>

Use qemu_isspace() so we don't have to cast to unsigned char.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 util/cutils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/cutils.c b/util/cutils.c
index e098debdc0..bed63fc2f1 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -683,7 +683,7 @@ int parse_uint(const char *s, unsigned long long *value, char **endptr,
     }
 
     /* make sure we reject negative numbers: */
-    while (isspace((unsigned char)*s)) {
+    while (qemu_isspace(*s)) {
         s++;
     }
     if (*s == '-') {
-- 
2.17.2


