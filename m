Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36350C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:16:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0244B21841
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0244B21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiADV-0002VV-7i
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 00:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50463)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hi8aJ-0004pZ-8k
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:31:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hi8aI-0003g7-3i
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:31:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45828)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hi8aH-0003fB-RL
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:31:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 21DC6C0586D8;
 Tue,  2 Jul 2019 02:31:53 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-232.pek2.redhat.com
 [10.72.12.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 802C260C43;
 Tue,  2 Jul 2019 02:31:51 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 10:31:21 +0800
Message-Id: <1562034689-6539-10-git-send-email-jasowang@redhat.com>
In-Reply-To: <1562034689-6539-1-git-send-email-jasowang@redhat.com>
References: <1562034689-6539-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Tue, 02 Jul 2019 02:31:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 09/17] net/announce: Add HMP optional interface
 list
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
Cc: Jason Wang <jasowang@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add the optional interface list to the HMP command.

i.e.

   All interfaces
        announce_self

   Just the named interfaces:
        announce_self vn1,vn2

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hmp-commands.hx    |  6 ++++--
 monitor/hmp-cmds.c | 38 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 8b7aec3..d42c09f 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -955,8 +955,8 @@ ETEXI
 
     {
         .name       = "announce_self",
-        .args_type  = "",
-        .params     = "",
+        .args_type  = "interfaces:s?",
+        .params     = "[interfaces]",
         .help       = "Trigger GARP/RARP announcements",
         .cmd        = hmp_announce_self,
     },
@@ -967,6 +967,8 @@ STEXI
 Trigger a round of GARP/RARP broadcasts; this is useful for explicitly updating the
 network infrastructure after a reconfiguration or some forms of migration.
 The timings of the round are set by the migration announce parameters.
+An optional comma separated @var{interfaces} list restricts the announce to the
+named set of interfaces.
 ETEXI
 
     {
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index c283dde..0fce179 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -27,6 +27,7 @@
 #include "monitor/monitor-internal.h"
 #include "monitor/qdev.h"
 #include "qapi/error.h"
+#include "qapi/clone-visitor.h"
 #include "qapi/opts-visitor.h"
 #include "qapi/qapi-builtin-visit.h"
 #include "qapi/qapi-commands-block.h"
@@ -38,6 +39,7 @@
 #include "qapi/qapi-commands-run-state.h"
 #include "qapi/qapi-commands-tpm.h"
 #include "qapi/qapi-commands-ui.h"
+#include "qapi/qapi-visit-net.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/string-input-visitor.h"
@@ -67,6 +69,32 @@ static void hmp_handle_error(Monitor *mon, Error **errp)
     }
 }
 
+/*
+ * Produce a strList from a comma separated list.
+ * A NULL or empty input string return NULL.
+ */
+static strList *strList_from_comma_list(const char *in)
+{
+    strList *res = NULL;
+    strList **hook = &res;
+
+    while (in && in[0]) {
+        char *comma = strchr(in, ',');
+        *hook = g_new0(strList, 1);
+
+        if (comma) {
+            (*hook)->value = g_strndup(in, comma - in);
+            in = comma + 1; /* skip the , */
+        } else {
+            (*hook)->value = g_strdup(in);
+            in = NULL;
+        }
+        hook = &(*hook)->next;
+    }
+
+    return res;
+}
+
 void hmp_info_name(Monitor *mon, const QDict *qdict)
 {
     NameInfo *info;
@@ -1631,7 +1659,15 @@ void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
 
 void hmp_announce_self(Monitor *mon, const QDict *qdict)
 {
-    qmp_announce_self(migrate_announce_params(), NULL);
+    const char *interfaces_str = qdict_get_try_str(qdict, "interfaces");
+    AnnounceParameters *params = QAPI_CLONE(AnnounceParameters,
+                                            migrate_announce_params());
+
+    qapi_free_strList(params->interfaces);
+    params->interfaces = strList_from_comma_list(interfaces_str);
+    params->has_interfaces = params->interfaces != NULL;
+    qmp_announce_self(params, NULL);
+    qapi_free_AnnounceParameters(params);
 }
 
 void hmp_migrate_cancel(Monitor *mon, const QDict *qdict)
-- 
2.5.0


