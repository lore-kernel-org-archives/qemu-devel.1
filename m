Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6B6C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:51:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDB33207C4
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kvo0Z0fA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB33207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXU4N-0005ca-PZ
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 14:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXTc3-0004RM-25
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:22:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35720)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXTbt-00033G-MZ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603822930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fJPWZOb3Nybfh1vMEKfljpSCcGSwnpXztpPXo5K9aJ8=;
 b=Kvo0Z0fAGkX2nmszG9bzquPAdNCa67OjIhBQbWWJ9XQ5RBUTg9SQnnVCWlSmC7jRTFrLst
 A2J+R10A9hsmWekhJJYCWjs8WbKAEPLEYpJwWkgAE+N5C72LCRwS0ARl8vv/BJ+0alwRFZ
 jb+cxO8NTWtIAOmzSOkFQwSF65b93Uc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-TxbR7PkvNoeTCdJhoEBR9A-1; Tue, 27 Oct 2020 14:22:07 -0400
X-MC-Unique: TxbR7PkvNoeTCdJhoEBR9A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20AAF8030D1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 18:21:55 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E155F50B44
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 18:21:54 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 26/29] hmp: introduce cmd_available
Date: Tue, 27 Oct 2020 14:21:41 -0400
Message-Id: <20201027182144.3315885-27-pbonzini@redhat.com>
In-Reply-To: <20201027182144.3315885-1-pbonzini@redhat.com>
References: <20201027182144.3315885-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Combine the RUN_STATE_PRECONFIG and cmd_can_preconfig checks
into a single function, to avoid repeating the same expression
(or its negation after applying DeMorgan's rule) over and
over again.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 monitor/hmp.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/monitor/hmp.c b/monitor/hmp.c
index c5cd9d372b..f13ef455e2 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -213,6 +213,11 @@ static bool cmd_can_preconfig(const HMPCommand *cmd)
     return strchr(cmd->flags, 'p');
 }
 
+static bool cmd_available(const HMPCommand *cmd)
+{
+    return !runstate_check(RUN_STATE_PRECONFIG) || cmd_can_preconfig(cmd);
+}
+
 static void help_cmd_dump_one(Monitor *mon,
                               const HMPCommand *cmd,
                               char **prefix_args,
@@ -220,7 +225,7 @@ static void help_cmd_dump_one(Monitor *mon,
 {
     int i;
 
-    if (runstate_check(RUN_STATE_PRECONFIG) && !cmd_can_preconfig(cmd)) {
+    if (!cmd_available(cmd)) {
         return;
     }
 
@@ -248,8 +253,7 @@ static void help_cmd_dump(Monitor *mon, const HMPCommand *cmds,
     /* Find one entry to dump */
     for (cmd = cmds; cmd->name != NULL; cmd++) {
         if (hmp_compare_cmd(args[arg_index], cmd->name) &&
-            ((!runstate_check(RUN_STATE_PRECONFIG) ||
-                cmd_can_preconfig(cmd)))) {
+            cmd_available(cmd)) {
             if (cmd->sub_table) {
                 /* continue with next arg */
                 help_cmd_dump(mon, cmd->sub_table,
@@ -653,7 +657,7 @@ static const HMPCommand *monitor_parse_command(MonitorHMP *hmp_mon,
                        (int)(p - cmdp_start), cmdp_start);
         return NULL;
     }
-    if (runstate_check(RUN_STATE_PRECONFIG) && !cmd_can_preconfig(cmd)) {
+    if (!cmd_available(cmd)) {
         monitor_printf(mon, "Command '%.*s' not available with -preconfig "
                             "until after exit_preconfig.\n",
                        (int)(p - cmdp_start), cmdp_start);
@@ -1225,8 +1229,7 @@ static void monitor_find_completion_by_table(MonitorHMP *mon,
         }
         readline_set_completion_index(mon->rs, strlen(cmdname));
         for (cmd = cmd_table; cmd->name != NULL; cmd++) {
-            if (!runstate_check(RUN_STATE_PRECONFIG) ||
-                 cmd_can_preconfig(cmd)) {
+            if (cmd_available(cmd)) {
                 cmd_completion(mon, cmdname, cmd->name);
             }
         }
@@ -1234,8 +1237,7 @@ static void monitor_find_completion_by_table(MonitorHMP *mon,
         /* find the command */
         for (cmd = cmd_table; cmd->name != NULL; cmd++) {
             if (hmp_compare_cmd(args[0], cmd->name) &&
-                (!runstate_check(RUN_STATE_PRECONFIG) ||
-                 cmd_can_preconfig(cmd))) {
+                cmd_available(cmd)) {
                 break;
             }
         }
-- 
2.26.2



