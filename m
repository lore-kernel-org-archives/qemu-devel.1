Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE9FC10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 15:06:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E625205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 15:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E625205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42686 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH8cJ-0000H0-Op
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 11:06:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hH8V2-0002P9-Jk
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hH8QL-0002Be-SA
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:54:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hH8QL-0002Aj-LC
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:54:01 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9365A756
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 14:53:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6460460BEC
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 14:53:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id DBA4E1132BB6; Thu, 18 Apr 2019 16:53:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 18 Apr 2019 16:53:50 +0200
Message-Id: <20190418145355.21100-2-armbru@redhat.com>
In-Reply-To: <20190418145355.21100-1-armbru@redhat.com>
References: <20190418145355.21100-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Thu, 18 Apr 2019 14:53:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/6] qemu-bridge-helper: Fix misuse of isspace()
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
Message-ID: <20190418145350.38cQF-jeA9mV8rFBPL-b0da6XP-U_ZcxYTuM2j_yMc0@z>

parse_acl_file() passes char values to isspace().  Undefined behavior
when the value is negative.  Not a security issue, because the
characters come from trusted $prefix/etc/qemu/bridge.conf and the
files it includes.

Fix by using qemu_isspace() instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qemu-bridge-helper.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/qemu-bridge-helper.c b/qemu-bridge-helper.c
index 5396fbfbb6..0d60c07655 100644
--- a/qemu-bridge-helper.c
+++ b/qemu-bridge-helper.c
@@ -29,6 +29,7 @@
 #include <linux/if_bridge.h>
 #endif
 
+#include "qemu-common.h"
 #include "qemu/queue.h"
 
 #include "net/tap-linux.h"
@@ -75,7 +76,7 @@ static int parse_acl_file(const char *filename, ACLList *acl_list)
         char *ptr = line;
         char *cmd, *arg, *argend;
 
-        while (isspace(*ptr)) {
+        while (qemu_isspace(*ptr)) {
             ptr++;
         }
 
@@ -99,12 +100,12 @@ static int parse_acl_file(const char *filename, ACLList *acl_list)
 
         *arg = 0;
         arg++;
-        while (isspace(*arg)) {
+        while (qemu_isspace(*arg)) {
             arg++;
         }
 
         argend = arg + strlen(arg);
-        while (arg != argend && isspace(*(argend - 1))) {
+        while (arg != argend && qemu_isspace(*(argend - 1))) {
             argend--;
         }
         *argend = 0;
-- 
2.17.2


