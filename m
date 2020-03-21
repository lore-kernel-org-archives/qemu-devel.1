Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5F0C4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 13:38:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27EB920780
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 13:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27EB920780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFeKy-0000xp-8B
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 09:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1jFeKB-0000Yy-2K
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 09:38:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1jFeK9-0007tR-Nm
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 09:38:02 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:2590)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1jFeK1-0007S5-Iv
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 09:38:01 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.1]) by
 rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee35e76189272c-5359c;
 Sat, 21 Mar 2020 21:37:23 +0800 (CST)
X-RM-TRANSID: 2ee35e76189272c-5359c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from maozy-host.localdomain (unknown[117.136.68.181])
 by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee15e76188d843-6c9b5;
 Sat, 21 Mar 2020 21:37:23 +0800 (CST)
X-RM-TRANSID: 2ee15e76188d843-6c9b5
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] migration: use "" instead of (null) for tls-authz
Date: Sat, 21 Mar 2020 21:37:15 +0800
Message-Id: <0a9dc2fcb78da13eb326992384bc4e57de83d9f9.1584797648.git.maozhongyi@cmss.chinamobile.com>
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
Cc: armbru@redhat.com, berrange@redhat.com, dgilbert@redhat.com,
 Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, quintela@redhat.com
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

Also fixed the bad indentation on the last line.

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
---
 migration/migration.c | 3 ++-
 monitor/hmp-cmds.c    | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index c1d88ace7f..b060153ef7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -790,7 +790,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->has_tls_hostname = true;
     params->tls_hostname = g_strdup(s->parameters.tls_hostname);
     params->has_tls_authz = true;
-    params->tls_authz = g_strdup(s->parameters.tls_authz);
+    params->tls_authz = s->parameters.tls_authz ? \
+                        g_strdup(s->parameters.tls_authz) : g_strdup("");
     params->has_max_bandwidth = true;
     params->max_bandwidth = s->parameters.max_bandwidth;
     params->has_downtime_limit = true;
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 58724031ea..f8be6bbb16 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -459,7 +459,7 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH),
             params->max_postcopy_bandwidth);
-        monitor_printf(mon, " %s: '%s'\n",
+        monitor_printf(mon, "%s: '%s'\n",
             MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
             params->has_tls_authz ? params->tls_authz : "");
     }
-- 
2.17.1




