Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA0CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 17:49:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38796207BB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 17:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZHSyvRTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38796207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyfLc-0001SQ-Ha
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 13:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jyfJS-0005zX-Jz
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 13:47:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46499
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jyfJQ-0004Em-AN
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 13:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595526439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4s0E4sntKbvJMM+adqRledjO1J+SAgFxPLSD8U8vZXM=;
 b=ZHSyvRTVmKIHDo1lmOLePToy7M59NaYCch2YUwSi5VYdCEMa6Bsja32O85zB7CFAsVjM4Y
 TfAqZ6u3329w7ukC8/sHOqbaLusxftDupvRuP7LgsU08gsUGjpXQ17FmSN7nOOAjYzzQab
 FbfFDFOIoEBy9oxR0p6k6mX+2C/3GDs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-8ZLwz8RLMt6xsq9PwCW5kA-1; Thu, 23 Jul 2020 13:47:15 -0400
X-MC-Unique: 8ZLwz8RLMt6xsq9PwCW5kA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 773B0800688;
 Thu, 23 Jul 2020 17:47:14 +0000 (UTC)
Received: from turbo.com (ovpn-113-141.ams2.redhat.com [10.36.113.141])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 10CBB69325;
 Thu, 23 Jul 2020 17:47:11 +0000 (UTC)
From: Christophe de Dinechin <dinechin@redhat.com>
To: qemu-devel@nongnu.org,
	kraxel@redhat.com
Subject: [PATCH 7/7] spice: Call qemu spice functions indirectly
Date: Thu, 23 Jul 2020 19:46:15 +0200
Message-Id: <20200723174615.2370096-8-dinechin@redhat.com>
In-Reply-To: <20200723174615.2370096-1-dinechin@redhat.com>
References: <20200723174615.2370096-1-dinechin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dinechin@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:33:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In order to be able to move all of spice in a shared library that is
loaded dynamically only on demand, this commit puts the functions
called by the main binary in a QemuSpiceOps structure, and use static
inline stubs to preserve the call sites.

With these changes, the following shared libraries are no longer
necessary in the top-level qemu binary when building with CONFIG_MDULES:

        libspice-server.so.1 => /lib64/libspice-server.so.1 (HEX)
        libopus.so.0 => /lib64/libopus.so.0 (HEX)
        liblz4.so.1 => /lib64/liblz4.so.1 (HEX)
        libgstapp-1.0.so.0 => /lib64/libgstapp-1.0.so.0 (HEX)
        libgstvideo-1.0.so.0 => /lib64/libgstvideo-1.0.so.0 (HEX)
        libgstbase-1.0.so.0 => /lib64/libgstbase-1.0.so.0 (HEX)
        libgstreamer-1.0.so.0 => /lib64/libgstreamer-1.0.so.0 (HEX)
        libssl.so.1.1 => /lib64/libssl.so.1.1 (HEX)
        liborc-0.4.so.0 => /lib64/liborc-0.4.so.0 (HEX)

Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
---
 include/ui/qemu-spice.h | 74 +++++++++++++++++++----------------------
 monitor/hmp-cmds.c      | 13 ++++++++
 monitor/misc.c          |  2 +-
 monitor/qmp-cmds.c      |  6 ++--
 softmmu/vl.c            | 28 ++++++++++++++--
 ui/spice-core.c         | 33 ++++++++++++++++--
 6 files changed, 107 insertions(+), 49 deletions(-)

diff --git a/include/ui/qemu-spice.h b/include/ui/qemu-spice.h
index d34cea2e0f..9721d8817e 100644
--- a/include/ui/qemu-spice.h
+++ b/include/ui/qemu-spice.h
@@ -25,21 +25,28 @@
 #include <spice.h>
 #include "qemu/config-file.h"
 
-extern int using_spice;
+#define using_spice     (qemu_spice.in_use())
 
-void qemu_spice_init(void);
 void qemu_spice_input_init(void);
 void qemu_spice_audio_init(void);
-void qemu_spice_display_init(void);
-int qemu_spice_display_add_client(int csock, int skipauth, int tls);
 int qemu_spice_add_interface(SpiceBaseInstance *sin);
 bool qemu_spice_have_display_interface(QemuConsole *con);
 int qemu_spice_add_display_interface(QXLInstance *qxlin, QemuConsole *con);
+
+#if !defined(CONFIG_MODULES) || defined(BUILD_DSO)
+bool qemu_is_using_spice(void);
+void qemu_start_using_spice(void);
+void qemu_spice_init(void);
+void qemu_spice_display_init(void);
+int qemu_spice_display_add_client(int csock, int skipauth, int tls);
 int qemu_spice_set_passwd(const char *passwd,
                           bool fail_if_connected, bool disconnect_if_connected);
 int qemu_spice_set_pw_expire(time_t expires);
 int qemu_spice_migrate_info(const char *hostname, int port, int tls_port,
                             const char *subject);
+struct SpiceInfo *qemu_spice_query(Error **errp);
+#endif /* !CONFIG_MODULES || BUILD_DSO */
+
 
 #if !defined(SPICE_SERVER_VERSION) || (SPICE_SERVER_VERSION < 0xc06)
 #define SPICE_NEEDS_SET_MM_TIME 1
@@ -47,46 +54,33 @@ int qemu_spice_migrate_info(const char *hostname, int port, int tls_port,
 #define SPICE_NEEDS_SET_MM_TIME 0
 #endif
 
-#else  /* CONFIG_SPICE */
-
-#include "qemu/error-report.h"
-
-#define using_spice 0
-#define spice_displays 0
-static inline int qemu_spice_set_passwd(const char *passwd,
-                                        bool fail_if_connected,
-                                        bool disconnect_if_connected)
-{
-    return -1;
-}
-static inline int qemu_spice_set_pw_expire(time_t expires)
-{
-    return -1;
-}
-static inline int qemu_spice_migrate_info(const char *h, int p, int t,
-                                          const char *s)
-{
-    return -1;
-}
+#else /* !CONFIG_SPICE */
 
-static inline int qemu_spice_display_add_client(int csock, int skipauth,
-                                                int tls)
-{
-    return -1;
-}
+#define using_spice     0
 
-static inline void qemu_spice_display_init(void)
-{
-    /* This must never be called if CONFIG_SPICE is disabled */
-    error_report("spice support is disabled");
-    abort();
-}
+#endif /* CONFIG_SPICE */
 
-static inline void qemu_spice_init(void)
+/* Module high-level inteface for SPICE */
+struct QemuSpiceOps
 {
-}
-
-#endif /* CONFIG_SPICE */
+    bool (*in_use)(void);
+    void (*init)(void);
+    void (*display_init)(void);
+    int (*display_add_client)(int csock, int skipauth, int tls);
+
+    int (*set_passwd)(const char *passwd,
+                      bool fail_if_connected,
+                      bool disconnect_if_connected);
+    int (*set_pw_expire)(time_t expires);
+    int (*migrate_info)(const char *hostname,
+                        int port, int tls_port,
+                        const char *subject);
+    struct SpiceInfo * (*query)(Error **errp);
+};
+typedef struct QemuSpiceOps QemuSpiceOps;
+void qemu_spice_ops_register(QemuSpiceOps *ops);
+
+extern struct QemuSpiceOps qemu_spice;
 
 static inline bool qemu_using_spice(Error **errp)
 {
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index ae4b6a4246..8e10af188f 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -57,6 +57,7 @@
 
 #ifdef CONFIG_SPICE
 #include <spice/enums.h>
+#include "ui/qemu-spice.h"
 #endif
 
 void hmp_handle_error(Monitor *mon, Error *err)
@@ -573,6 +574,14 @@ void hmp_info_vnc(Monitor *mon, const QDict *qdict)
 #endif
 
 #ifdef CONFIG_SPICE
+SpiceInfo *qmp_query_spice(Error **errp)
+{
+    if (!using_spice) {
+        return NULL;
+    }
+    return qemu_spice.query(errp);
+}
+
 void hmp_info_spice(Monitor *mon, const QDict *qdict)
 {
     SpiceChannelList *chan;
@@ -599,6 +608,10 @@ void hmp_info_spice(Monitor *mon, const QDict *qdict)
 
     info = qmp_query_spice(NULL);
 
+    if (!info) {
+        monitor_printf(mon, "Server: not started\n");
+        goto out;
+    }
     if (!info->enabled) {
         monitor_printf(mon, "Server: disabled\n");
         goto out;
diff --git a/monitor/misc.c b/monitor/misc.c
index e847b58a8c..88f8915734 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -443,7 +443,7 @@ void qmp_client_migrate_info(const char *protocol, const char *hostname,
             return;
         }
 
-        if (qemu_spice_migrate_info(hostname,
+        if (qemu_spice.migrate_info(hostname,
                                     has_port ? port : -1,
                                     has_tls_port ? tls_port : -1,
                                     cert_subject)) {
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index 864cbfa32e..9f9822b3f3 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -196,7 +196,7 @@ void qmp_set_password(const char *protocol, const char *password,
         if (!qemu_using_spice(errp)) {
             return;
         }
-        rc = qemu_spice_set_passwd(password, fail_if_connected,
+        rc = qemu_spice.set_passwd(password, fail_if_connected,
                                    disconnect_if_connected);
         if (rc != 0) {
             error_setg(errp, QERR_SET_PASSWD_FAILED);
@@ -242,7 +242,7 @@ void qmp_expire_password(const char *protocol, const char *whenstr,
         if (!qemu_using_spice(errp)) {
             return;
         }
-        rc = qemu_spice_set_pw_expire(when);
+        rc = qemu_spice.set_pw_expire(when);
         if (rc != 0) {
             error_setg(errp, QERR_SET_PASSWD_FAILED);
         }
@@ -339,7 +339,7 @@ void qmp_add_client(const char *protocol, const char *fdname,
         }
         skipauth = has_skipauth ? skipauth : false;
         tls = has_tls ? tls : false;
-        if (qemu_spice_display_add_client(fd, skipauth, tls) < 0) {
+        if (qemu_spice.display_add_client(fd, skipauth, tls) < 0) {
             error_setg(errp, "spice failed to add client");
             close(fd);
         }
diff --git a/softmmu/vl.c b/softmmu/vl.c
index bc0dcc4f58..8defda56c9 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -173,6 +173,30 @@ int icount_align_option;
 QemuUUID qemu_uuid;
 bool qemu_uuid_set;
 
+static bool qemu_is_not_using_spice(void)
+{
+    return 0;
+}
+
+static void qemu_spice_init_no_op(void)
+{
+}
+
+/*
+ * Only two fields are initialized, that can be used even when SPICE
+ * is not configured or not loaded. Other functions are protected by
+ * checking if using_spice.
+ */
+QemuSpiceOps qemu_spice = {
+    .in_use             = qemu_is_not_using_spice,
+    .init               = qemu_spice_init_no_op,
+};
+
+void qemu_spice_ops_register(QemuSpiceOps *ops)
+{
+    memcpy(&qemu_spice, ops, sizeof(qemu_spice));
+}
+
 static NotifierList exit_notifiers =
     NOTIFIER_LIST_INITIALIZER(exit_notifiers);
 
@@ -4128,7 +4152,7 @@ void qemu_init(int argc, char **argv, char **envp)
     /* spice needs the timers to be initialized by this point */
     /* spice must initialize before audio as it changes the default auiodev */
     /* spice must initialize before chardevs (for spicevmc and spiceport) */
-    qemu_spice_init();
+    qemu_spice.init();
 
     qemu_opts_foreach(qemu_find_opts("object"),
                       user_creatable_add_opts_foreach,
@@ -4424,7 +4448,7 @@ void qemu_init(int argc, char **argv, char **envp)
 #endif
 
     if (using_spice) {
-        qemu_spice_display_init();
+        qemu_spice.display_init();
     }
 
     if (foreach_device_config(DEV_GDB, gdbserver_start) < 0) {
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 37dd68f2ab..9d7ac70d92 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -48,7 +48,7 @@ static time_t auth_expires = TIME_MAX;
 static int spice_migration_completed;
 static int spice_display_is_running;
 static int spice_have_target_host;
-int using_spice = 0;
+static int is_using_spice;
 
 static QemuThread me;
 
@@ -503,7 +503,7 @@ static QemuOptsList qemu_spice_opts = {
     },
 };
 
-SpiceInfo *qmp_query_spice(Error **errp)
+SpiceInfo *qemu_spice_query(Error **errp)
 {
     QemuOpts *opts = QTAILQ_FIRST(&qemu_spice_opts.head);
     int port, tls_port;
@@ -634,6 +634,16 @@ static void vm_change_state_handler(void *opaque, int running,
     }
 }
 
+bool qemu_is_using_spice(void)
+{
+    return is_using_spice;
+}
+
+void qemu_start_using_spice(void)
+{
+    is_using_spice = 1;
+}
+
 void qemu_spice_init(void)
 {
     QemuOpts *opts = QTAILQ_FIRST(&qemu_spice_opts.head);
@@ -796,7 +806,7 @@ void qemu_spice_init(void)
         error_report("failed to initialize spice server");
         exit(1);
     };
-    using_spice = 1;
+    qemu_start_using_spice();
 
     migration_state.notify = migration_state_notifier;
     add_migration_state_change_notifier(&migration_state);
@@ -1000,3 +1010,20 @@ static void spice_register_config(void)
     qemu_add_opts(&qemu_spice_opts);
 }
 opts_init(spice_register_config);
+
+static QemuSpiceOps qemu_spice_ops = {
+    .in_use             = qemu_is_using_spice,
+    .init               = qemu_spice_init,
+    .display_init       = qemu_spice_display_init,
+    .display_add_client = qemu_spice_display_add_client,
+    .set_passwd         = qemu_spice_set_passwd,
+    .set_pw_expire      = qemu_spice_set_pw_expire,
+    .migrate_info       = qemu_spice_migrate_info,
+    .query              = qemu_spice_query,
+};
+
+static void spice_register_ops(void)
+{
+    qemu_spice_ops_register(&qemu_spice_ops);
+}
+type_init(spice_register_ops);
-- 
2.26.2


