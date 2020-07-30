Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1C1C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 16:02:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15FFD206F5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 16:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lpsd5iZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15FFD206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1B0r-0006iN-4n
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 12:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1AfQ-0001Vv-Uk
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:40:24 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52020)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1AfJ-0002Va-NE
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:40:24 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFXPL6007495;
 Thu, 30 Jul 2020 15:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=Nv/b2PUDoqsO8F4DqZ6z7ZSgREh1Dj6LffZizWf6DgQ=;
 b=lpsd5iZB4zS7RfTSXqVLdGdu12hG/QHJ21uZjJif1qyYI7ULZ0ZRPwOmyB6no+Cp3XxQ
 HM+58KDyZ310qMlS7xdz+r11iDR47qaMcGYqvX39GsIea/V7BfrImKqMGPG+3zdSdm71
 TSJJFkM823g5vejzOEzMkrQIMUUWTgGzC758EvTicU/XT9l32yDWQ5Xaeag569S8Hg3v
 JJRtmOsJ1ZDUzfCF2CPn2aZgbZl97NJSCl2LQtKlwAa/6UKKkysdt44xVDkDqSjpFbp/
 FhLlkREJG+iOCocyyPrVetiAxt8tprwG9Y9DttZfxS7muDzDnf+k+NF7QxRFvfy4JNCc iw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 32hu1jmfv3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Jul 2020 15:40:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFXSM4130705;
 Thu, 30 Jul 2020 15:38:13 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 32hu5wwh1a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2020 15:38:13 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06UFcCfo001915;
 Thu, 30 Jul 2020 15:38:12 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 30 Jul 2020 08:38:12 -0700
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V1 23/32] char: save/restore chardev socket fds
Date: Thu, 30 Jul 2020 08:14:27 -0700
Message-Id: <1596122076-341293-24-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 mlxscore=0
 suspectscore=3 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 clxscore=1015
 malwarescore=0 spamscore=0 suspectscore=3 bulkscore=0 priorityscore=1501
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

From: Mark Kanda <mark.kanda@oracle.com>

Iterate through the character devices and save/restore the socket fds.

Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 chardev/char-socket.c   | 35 +++++++++++++++++++++++++++++++++++
 chardev/char.c          | 14 ++++++++++++++
 include/chardev/char.h  |  5 +++++
 include/sysemu/sysemu.h |  1 +
 migration/savevm.c      |  8 ++++++++
 5 files changed, 63 insertions(+)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index ef62dbf..e08e7e1 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -36,6 +36,8 @@
 #include "qapi/qapi-visit-sockets.h"
 
 #include "chardev/char-io.h"
+#include "sysemu/sysemu.h"
+#include "qemu/cutils.h"
 
 /***********************************************************/
 /* TCP Net console */
@@ -400,6 +402,7 @@ static void tcp_chr_free_connection(Chardev *chr)
     SocketChardev *s = SOCKET_CHARDEV(chr);
     int i;
 
+    unsetenv_fd(chr->label);
     if (s->read_msgfds_num) {
         for (i = 0; i < s->read_msgfds_num; i++) {
             close(s->read_msgfds[i]);
@@ -1375,6 +1378,9 @@ static void qmp_chardev_open_socket(Chardev *chr,
             return;
         }
     }
+
+    load_char_socket_fd(chr);
+
 }
 
 static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
@@ -1517,3 +1523,32 @@ static void register_types(void)
 }
 
 type_init(register_types);
+
+void save_char_socket_fd(Chardev *chr)
+{
+    SocketChardev *sockchar = SOCKET_CHARDEV(chr);
+
+    if (sockchar->sioc) {
+        setenv_fd(chr->label, sockchar->sioc->fd);
+    }
+}
+
+void load_char_socket_fd(Chardev *chr)
+{
+    SocketChardev *sockchar;
+    QIOChannelSocket *sioc;
+
+    int fd = getenv_fd(chr->label);
+
+    if (fd != -1) {
+        unsetenv_fd(chr->label);
+        sockchar = SOCKET_CHARDEV(chr);
+        sioc = qio_channel_socket_accept(*sockchar->listener->sioc, fd, NULL);
+        if (sioc) {
+            tcp_chr_accept(sockchar->listener, sioc, chr);
+        } else {
+            error_printf("error: could not restore socket for %s\n",
+                         chr->label);
+        }
+    }
+}
diff --git a/chardev/char.c b/chardev/char.c
index 77e7ec8..8fd54cc 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -34,6 +34,7 @@
 #include "qapi/qapi-commands-char.h"
 #include "qapi/qmp/qerror.h"
 #include "sysemu/replay.h"
+#include "sysemu/sysemu.h"
 #include "qemu/help_option.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
@@ -1174,3 +1175,16 @@ static void register_types(void)
 }
 
 type_init(register_types);
+
+static int chardev_is_socket(Object *child, void *opaque)
+{
+    if (CHARDEV_IS_SOCKET(child)) {
+        save_char_socket_fd((Chardev *) child);
+    }
+    return 0;
+}
+
+void save_chardev_fds(void)
+{
+    object_child_foreach(get_chardevs_root(), chardev_is_socket, NULL);
+}
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 00589a6..80a9cf8 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -250,6 +250,8 @@ int qemu_chr_wait_connected(Chardev *chr, Error **errp);
     object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_RINGBUF)
 #define CHARDEV_IS_PTY(chr) \
     object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_PTY)
+#define CHARDEV_IS_SOCKET(chr) \
+    object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_SOCKET)
 
 typedef struct ChardevClass {
     ObjectClass parent_class;
@@ -290,4 +292,7 @@ GSource *qemu_chr_timeout_add_ms(Chardev *chr, guint ms,
 /* console.c */
 void qemu_chr_parse_vc(QemuOpts *opts, ChardevBackend *backend, Error **errp);
 
+void save_char_socket_fd(Chardev *);
+void load_char_socket_fd(Chardev *);
+
 #endif
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 4dfc4ca..fa1a5c3 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -27,6 +27,7 @@ void qemu_remove_machine_init_done_notifier(Notifier *notify);
 
 void save_cpr_snapshot(const char *file, const char *mode, Error **errp);
 void load_cpr_snapshot(const char *file, Error **errp);
+void save_chardev_fds(void);
 
 extern int autostart;
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 2902006..81f38c4 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2700,6 +2700,12 @@ static QEMUFile *qf_file_open(const char *filename, int flags, int mode,
     return qemu_fopen_channel_input(ioc);
 }
 
+static int preserve_fd(const char *name, const char *val, void *handle)
+{
+    qemu_clr_cloexec(atoi(val));
+    return 0;
+}
+
 void save_cpr_snapshot(const char *file, const char *mode, Error **errp)
 {
     int ret = 0;
@@ -2761,6 +2767,8 @@ void save_cpr_snapshot(const char *file, const char *mode, Error **errp)
         if (qemu_preserve_ram(errp)) {
             return;
         }
+        save_chardev_fds();
+        walkenv(FD_PREFIX, preserve_fd, 0);
         qemu_system_exec_request();
         putenv((char *)"QEMU_START_FREEZE=");
     }
-- 
1.8.3.1


