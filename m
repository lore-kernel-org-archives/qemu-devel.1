Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C868DC5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:10:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BC9B21848
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC9B21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiA84-00054x-Tp
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 00:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50493)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hi8aN-0004ye-7V
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:32:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hi8aM-0003hW-93
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:31:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43794)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hi8aM-0003hE-3L
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:31:58 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5EC1E356E8;
 Tue,  2 Jul 2019 02:31:57 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-232.pek2.redhat.com
 [10.72.12.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6F5418B30;
 Tue,  2 Jul 2019 02:31:55 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 10:31:23 +0800
Message-Id: <1562034689-6539-12-git-send-email-jasowang@redhat.com>
In-Reply-To: <1562034689-6539-1-git-send-email-jasowang@redhat.com>
References: <1562034689-6539-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 02 Jul 2019 02:31:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 11/17] net/announce: Add HMP optional ID
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

Add the optional ID to the HMP command.

e.g.
   # start an announce for a long time on eth1
   migrate_set_parameter announce-rounds 1000
   announce_self "eth1" e1

   # start an announce on eth2
   announce_self "eth2" e2

   # Change e1 to be announcing on eth1 and eth3
   announce_self "eth1,eth3" e1

   # Cancel e1
   migrate_set_parameter announce-rounds 0
   announce_self "" e1

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hmp-commands.hx    | 7 ++++---
 monitor/hmp-cmds.c | 3 +++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index d42c09f..bfa5681 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -955,8 +955,8 @@ ETEXI
 
     {
         .name       = "announce_self",
-        .args_type  = "interfaces:s?",
-        .params     = "[interfaces]",
+        .args_type  = "interfaces:s?,id:s?",
+        .params     = "[interfaces] [id]",
         .help       = "Trigger GARP/RARP announcements",
         .cmd        = hmp_announce_self,
     },
@@ -968,7 +968,8 @@ Trigger a round of GARP/RARP broadcasts; this is useful for explicitly updating
 network infrastructure after a reconfiguration or some forms of migration.
 The timings of the round are set by the migration announce parameters.
 An optional comma separated @var{interfaces} list restricts the announce to the
-named set of interfaces.
+named set of interfaces. An optional @var{id} can be used to start a separate announce
+timer and to change the parameters of it later.
 ETEXI
 
     {
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 0fce179..9de3538 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1660,12 +1660,15 @@ void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
 void hmp_announce_self(Monitor *mon, const QDict *qdict)
 {
     const char *interfaces_str = qdict_get_try_str(qdict, "interfaces");
+    const char *id = qdict_get_try_str(qdict, "id");
     AnnounceParameters *params = QAPI_CLONE(AnnounceParameters,
                                             migrate_announce_params());
 
     qapi_free_strList(params->interfaces);
     params->interfaces = strList_from_comma_list(interfaces_str);
     params->has_interfaces = params->interfaces != NULL;
+    params->id = g_strdup(id);
+    params->has_id = !!params->id;
     qmp_announce_self(params, NULL);
     qapi_free_AnnounceParameters(params);
 }
-- 
2.5.0


