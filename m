Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071C6C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:55:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C478920838
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y8jlFshG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C478920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1AuK-0006Oq-Po
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 11:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1AdW-0007cN-9c
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:38:26 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50228)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1AdQ-0002CJ-MH
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:38:25 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFXR5g007530;
 Thu, 30 Jul 2020 15:38:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=/bBMFyHn6buXcDgFeO/yrjY+ou4q0vlnEUE5DvXf+LI=;
 b=Y8jlFshG4yXOqZePVb8gyXnHbUjn+P4CQxQmtkKgEd5zeUs42PPhN7q4yEZi+gfHYqBl
 n3J3lP25+tvcyj+UE4YwVwUC4v/aMJ3OjLbbyzRmJar0A7qVU9JRQEWfqfzGi1Qta067
 3tRqpdxQMVLb3FOlgp8RAkMFo/bVS8pwGDfwSZNIHkZuiBCkzDDqbKnRlf1kNNwlF393
 gZwS7yrer37JihXNcO0QuHz7e9LrbXMY+rOjYcF0t6rLvlwzB+yd/iMQzUcf8clewgUA
 EBi1yPa6Dr+kcLx6oDhggBXmczUkbkOeVTxvZQcHNX+TeQ5YFexyZ+/2sX0RAasP/sRI ig== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 32hu1jmfg1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Jul 2020 15:38:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFWp1N188439;
 Thu, 30 Jul 2020 15:38:15 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 32hu5xja5u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2020 15:38:15 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06UFcDTx014628;
 Thu, 30 Jul 2020 15:38:13 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 30 Jul 2020 08:38:13 -0700
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V1 25/32] char: save/restore chardev pty fds
Date: Thu, 30 Jul 2020 08:14:29 -0700
Message-Id: <1596122076-341293-26-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007300111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 clxscore=1015
 malwarescore=0 spamscore=0 suspectscore=1 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300111
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=steven.sistare@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 11:37:58
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Save and restore pty descriptors across cprsave and cprload.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 chardev/char-pty.c     | 38 +++++++++++++++++++++++++++-----------
 chardev/char.c         |  2 ++
 include/chardev/char.h |  1 +
 3 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index 1cc501a..0785429 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -30,6 +30,7 @@
 #include "qemu/sockets.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
+#include "qemu/cutils.h"
 #include "qemu/qemu-print.h"
 
 #include "chardev/char-io.h"
@@ -183,6 +184,16 @@ static void pty_chr_state(Chardev *chr, int connected)
     }
 }
 
+void save_char_pty_fd(Chardev *chr)
+{
+    PtyChardev *s = PTY_CHARDEV(chr);
+    QIOChannelFile *fioc = QIO_CHANNEL_FILE(s->ioc);
+
+    if (fioc) {
+        setenv_fd(chr->label, fioc->fd);
+    }
+}
+
 static void char_pty_finalize(Object *obj)
 {
     Chardev *chr = CHARDEV(obj);
@@ -204,18 +215,23 @@ static void char_pty_open(Chardev *chr,
     char pty_name[PATH_MAX];
     char *name;
 
-    master_fd = qemu_openpty_raw(&slave_fd, pty_name);
-    if (master_fd < 0) {
-        error_setg_errno(errp, errno, "Failed to create PTY");
-        return;
-    }
-
-    close(slave_fd);
-    qemu_set_nonblock(master_fd);
+    master_fd = getenv_fd(chr->label);
+    if (master_fd >= 0) {
+        unsetenv_fd(chr->label);
+        chr->filename = g_strdup_printf("pty:unknown");
+    } else {
+        master_fd = qemu_openpty_raw(&slave_fd, pty_name);
+        if (master_fd < 0) {
+            error_setg_errno(errp, errno, "Failed to create PTY");
+            return;
+        }
 
-    chr->filename = g_strdup_printf("pty:%s", pty_name);
-    qemu_printf("char device redirected to %s (label %s)\n",
-                pty_name, chr->label);
+        close(slave_fd);
+        qemu_set_nonblock(master_fd);
+        chr->filename = g_strdup_printf("pty:%s", pty_name);
+        qemu_printf("char device redirected to %s (label %s)\n",
+                    pty_name, chr->label);
+    }
 
     s = PTY_CHARDEV(chr);
     s->ioc = QIO_CHANNEL(qio_channel_file_new_fd(master_fd));
diff --git a/chardev/char.c b/chardev/char.c
index 8fd54cc..da75a04 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -1180,6 +1180,8 @@ static int chardev_is_socket(Object *child, void *opaque)
 {
     if (CHARDEV_IS_SOCKET(child)) {
         save_char_socket_fd((Chardev *) child);
+    } else if (CHARDEV_IS_PTY(child)) {
+        save_char_pty_fd((Chardev *) child);
     }
     return 0;
 }
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 80a9cf8..c18bda8 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -294,5 +294,6 @@ void qemu_chr_parse_vc(QemuOpts *opts, ChardevBackend *backend, Error **errp);
 
 void save_char_socket_fd(Chardev *);
 void load_char_socket_fd(Chardev *);
+void save_char_pty_fd(Chardev *);
 
 #endif
-- 
1.8.3.1


