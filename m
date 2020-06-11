Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F19C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 11:20:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98FAD2063A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 11:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FtlKd7Le"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98FAD2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjLFY-000587-T4
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 07:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jjLCu-0001nD-Vj
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 07:17:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48956
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jjLCs-0003zv-Qt
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 07:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591874233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JZUM30HithXix6eV/zUUUkvVwY9gnckp++ff4Je8OQs=;
 b=FtlKd7LeEral8upcA1aAcIsg7AixxPbpf5f7vM8LyhCtTL0gwUXjh1Sg5C3ux2jOTO/vVv
 LqoYyB5BP87HQ/DTMXmCcra0uHVwhXo8WLjdL3OH6NBngBPgulDq8bxHV5qjBF/t7/jsx9
 lXv2q7huTQkvxga1JzOTwHEcV2aKT3o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-UmxToQNvOwy2iAuiSMW6jw-1; Thu, 11 Jun 2020 07:17:11 -0400
X-MC-Unique: UmxToQNvOwy2iAuiSMW6jw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0610B835B43
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 11:17:11 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-116.ams2.redhat.com
 [10.36.114.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 04A5D60BF3;
 Thu, 11 Jun 2020 11:17:07 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, armbru@redhat.com, thuth@redhat.com,
 quintela@redhat.com
Subject: [PATCH 1/2] qmp: Add 'openfd' command
Date: Thu, 11 Jun 2020 12:17:02 +0100
Message-Id: <20200611111703.159590-2-dgilbert@redhat.com>
In-Reply-To: <20200611111703.159590-1-dgilbert@redhat.com>
References: <20200611111703.159590-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
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

The existing 'getfd' command imports an fd from the monitor via
SCM rights.
This command allows qemu to open the file for itself; this is convenient
primarily in testing, or with simple QMP clients.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 monitor/misc.c | 48 ++++++++++++++++++++++++++++++++++++++----------
 qapi/misc.json | 23 ++++++++++++++++++++++-
 2 files changed, 60 insertions(+), 11 deletions(-)

diff --git a/monitor/misc.c b/monitor/misc.c
index f5207cd242..d538af592a 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -1230,22 +1230,20 @@ static void hmp_acl_remove(Monitor *mon, const QDict *qdict)
     }
 }
 
-void qmp_getfd(const char *fdname, Error **errp)
+/*
+ * Add a named fd to the monitor list.
+ * Returns true on success.
+ */
+static bool addfd(const char *fdname, int fd, Error **errp)
 {
     mon_fd_t *monfd;
-    int fd, tmp_fd;
-
-    fd = qemu_chr_fe_get_msgfd(&cur_mon->chr);
-    if (fd == -1) {
-        error_setg(errp, QERR_FD_NOT_SUPPLIED);
-        return;
-    }
+    int tmp_fd;
 
     if (qemu_isdigit(fdname[0])) {
         close(fd);
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "fdname",
                    "a name not starting with a digit");
-        return;
+        return false;
     }
 
     qemu_mutex_lock(&cur_mon->mon_lock);
@@ -1259,7 +1257,7 @@ void qmp_getfd(const char *fdname, Error **errp)
         qemu_mutex_unlock(&cur_mon->mon_lock);
         /* Make sure close() is outside critical section */
         close(tmp_fd);
-        return;
+        return true;
     }
 
     monfd = g_malloc0(sizeof(mon_fd_t));
@@ -1268,6 +1266,36 @@ void qmp_getfd(const char *fdname, Error **errp)
 
     QLIST_INSERT_HEAD(&cur_mon->fds, monfd, next);
     qemu_mutex_unlock(&cur_mon->mon_lock);
+
+    return true;
+}
+
+void qmp_getfd(const char *fdname, Error **errp)
+{
+    int fd = qemu_chr_fe_get_msgfd(&cur_mon->chr);
+    if (fd == -1) {
+        error_setg(errp, QERR_FD_NOT_SUPPLIED);
+        return;
+    }
+
+    if (!addfd(fdname, fd, errp)) {
+        close(fd);
+    }
+}
+
+void qmp_openfd(const char *fdname, const char *filename, Error **errp)
+{
+    int fd;
+
+    fd = open(filename, O_RDWR | O_CREAT, S_IRWXU);
+    if (fd == -1) {
+        error_setg_errno(errp, errno, "Cannot open file '%s'", filename);
+        return;
+    }
+
+    if (!addfd(fdname, fd, errp)) {
+        close(fd);
+    }
 }
 
 void qmp_closefd(const char *fdname, Error **errp)
diff --git a/qapi/misc.json b/qapi/misc.json
index 99b90ac80b..baec07358e 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -952,7 +952,7 @@
 ##
 # @closefd:
 #
-# Close a file descriptor previously passed via SCM rights
+# Close a named file descriptor
 #
 # @fdname: file descriptor name
 #
@@ -968,6 +968,27 @@
 ##
 { 'command': 'closefd', 'data': {'fdname': 'str'} }
 
+##
+# @openfd:
+#
+# Open a file descriptor.  The file is opened read-write.
+#
+# @fdname: file descriptor name
+# @filename: file name
+#
+# Returns: Nothing on success
+#
+# Since: 5.1
+#
+# Example:
+#
+# -> { "execute": "openfd", "arguments": { "fdname": "null",
+#                                          "filename": "/dev/null" } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'openfd', 'data': {'fdname': 'str', 'filename': 'str'} }
+
 ##
 # @MemoryInfo:
 #
-- 
2.26.2


