Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9C9C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 11:18:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C62820835
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 11:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MkezIBAB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C62820835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjLEW-0003RT-JH
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 07:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jjLCx-0001nd-2J
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 07:17:19 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44584
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jjLCu-000406-KK
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 07:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591874235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xBfgtz5cZqbDBoicdnCS+gGmYNw/8M9z8Tjjd4WiQSU=;
 b=MkezIBABelTvQ6WCorioz6h/2NgS48tujiv0eWaAittPTD1+XZkIj8WNGDfvzEuRUPZTeu
 MNZq0MoZLggIRdoAgKDHBkaH8xhsRTooJWy5mArlhtXUOnPp74ia8bQrHVZeNk5JgVaeOd
 Hjw1Hn1zi710ufFJ8h7aZ3yvvRgXRI4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-_59sli9GNLWTJnybuanikQ-1; Thu, 11 Jun 2020 07:17:13 -0400
X-MC-Unique: _59sli9GNLWTJnybuanikQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54DFF80572E
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 11:17:12 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-116.ams2.redhat.com
 [10.36.114.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5270960BF3;
 Thu, 11 Jun 2020 11:17:11 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, armbru@redhat.com, thuth@redhat.com,
 quintela@redhat.com
Subject: [PATCH 2/2] hmp: Add 'openfd' command
Date: Thu, 11 Jun 2020 12:17:03 +0100
Message-Id: <20200611111703.159590-3-dgilbert@redhat.com>
In-Reply-To: <20200611111703.159590-1-dgilbert@redhat.com>
References: <20200611111703.159590-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Wire up the hmp 'openfd' to open a file and add it to the monitor's
fd stash.
Example usage:

(qemu) openfd mig "my.mig"
(qemu) migrate -d "fd:mig"

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp-commands.hx        | 16 +++++++++++++++-
 include/monitor/hmp.h  |  1 +
 monitor/hmp-cmds.c     | 10 ++++++++++
 tests/qtest/test-hmp.c |  2 ++
 4 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 28256209b5..c10d5b3668 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1606,7 +1606,7 @@ ERST
         .name       = "closefd",
         .args_type  = "fdname:s",
         .params     = "closefd name",
-        .help       = "close a file descriptor previously passed via SCM rights",
+        .help       = "close a named file descriptor",
         .cmd        = hmp_closefd,
     },
 
@@ -1617,6 +1617,20 @@ SRST
   used by another monitor command.
 ERST
 
+    {
+        .name       = "openfd",
+        .args_type  = "fdname:s,filename:s",
+        .params     = "openfd name filename",
+        .help       = "open the named file (read write) and assign it a name",
+        .cmd        = hmp_openfd,
+    },
+
+SRST
+``openfd`` *fdname* *filename*
+  Open the named file and store it using the name *fdname* for later use by
+  other monitor comands.
+ERST
+
     {
         .name       = "block_passwd",
         .args_type  = "device:B,password:s",
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index c986cfd28b..7beaf3eab7 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -83,6 +83,7 @@ void hmp_netdev_add(Monitor *mon, const QDict *qdict);
 void hmp_netdev_del(Monitor *mon, const QDict *qdict);
 void hmp_getfd(Monitor *mon, const QDict *qdict);
 void hmp_closefd(Monitor *mon, const QDict *qdict);
+void hmp_openfd(Monitor *mon, const QDict *qdict);
 void hmp_sendkey(Monitor *mon, const QDict *qdict);
 void hmp_screendump(Monitor *mon, const QDict *qdict);
 void hmp_chardev_add(Monitor *mon, const QDict *qdict);
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 9c61e769ca..62a3a8a514 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1659,6 +1659,16 @@ void hmp_closefd(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, err);
 }
 
+void hmp_openfd(Monitor *mon, const QDict *qdict)
+{
+    const char *fdname = qdict_get_str(qdict, "fdname");
+    const char *filename = qdict_get_str(qdict, "filename");
+    Error *err = NULL;
+
+    qmp_openfd(fdname, filename, &err);
+    hmp_handle_error(mon, err);
+}
+
 void hmp_sendkey(Monitor *mon, const QDict *qdict)
 {
     const char *keys = qdict_get_str(qdict, "keys");
diff --git a/tests/qtest/test-hmp.c b/tests/qtest/test-hmp.c
index b8b1271b9e..66a4f34348 100644
--- a/tests/qtest/test-hmp.c
+++ b/tests/qtest/test-hmp.c
@@ -57,6 +57,8 @@ static const char *hmp_cmds[] = {
     "o /w 0 0x1234",
     "object_add memory-backend-ram,id=mem1,size=256M",
     "object_del mem1",
+    "openfd null \"/dev/null\"",
+    "closefd null", /* purposely after openfd */
     "pmemsave 0 4096 \"/dev/null\"",
     "p $pc + 8",
     "qom-list /",
-- 
2.26.2


