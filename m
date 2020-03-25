Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2BFC10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 01:50:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F13520722
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 01:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F13520722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGvBy-0005bl-Se
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 21:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36019)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1jGvBM-00058R-AN
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 21:50:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1jGvBK-0004Up-W6
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 21:50:11 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:3972)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1jGvBK-0004KD-Da
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 21:50:10 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by
 rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee15e7ab8b8c2a-9996e;
 Wed, 25 Mar 2020 09:49:44 +0800 (CST)
X-RM-TRANSID: 2ee15e7ab8b8c2a-9996e
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
 by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee95e7ab8b0685-52244;
 Wed, 25 Mar 2020 09:49:44 +0800 (CST)
X-RM-TRANSID: 2ee95e7ab8b0685-52244
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3] migration: use "" instead of (null) for tls-authz
Date: Wed, 25 Mar 2020 09:49:30 +0800
Message-Id: <119f539a9f4d198bc3bcced46b8280520d60bc51.1585100802.git.maozhongyi@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 221.176.66.79
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
Cc: quintela@redhat.com, dgilbert@redhat.com,
 Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

run:
(qemu) info migrate_parameters
announce-initial: 50 ms
...
announce-max: 550 ms
multifd-compression: none
xbzrle-cache-size: 4194304
max-postcopy-bandwidth: 0
 tls-authz: '(null)'

Migration parameter 'tls-authz' is used to provide the QOM ID
of a QAuthZ subclass instance that provides the access control
check, default is NULL. But the empty string is not a valid
object ID, so use "" instead of the default. Although it will
fail when lookup an object with ID "", it is harmless, just
consistent with tls_creds.

As a bonus, this patch also fixed the bad indentation on the
last line and removed 'has_tls_authz' redundant check in
'hmp_info_migrate_parameters'.

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
---
 migration/migration.c | 3 ++-
 monitor/hmp-cmds.c    | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 4b26110d57..c4c9aee15e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -790,7 +790,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->has_tls_hostname = true;
     params->tls_hostname = g_strdup(s->parameters.tls_hostname);
     params->has_tls_authz = true;
-    params->tls_authz = g_strdup(s->parameters.tls_authz);
+    params->tls_authz = g_strdup(s->parameters.tls_authz ?
+                                 s->parameters.tls_authz : "");
     params->has_max_bandwidth = true;
     params->max_bandwidth = s->parameters.max_bandwidth;
     params->has_downtime_limit = true;
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index a71de0e60b..dc48e6986c 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -459,9 +459,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH),
             params->max_postcopy_bandwidth);
-        monitor_printf(mon, " %s: '%s'\n",
+        monitor_printf(mon, "%s: '%s'\n",
             MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
-            params->has_tls_authz ? params->tls_authz : "");
+            params->tls_authz);
     }
 
     qapi_free_MigrationParameters(params);
-- 
2.17.1




