Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F3BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:58:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D8D1207E8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ck/hcDDr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8D1207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jorgK-0007oK-RZ
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 12:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jorSe-0007KJ-R9
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 12:44:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30781
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jorSc-0007Cz-Km
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 12:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593189858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JHHQF6mkyWRgUe0IWsRd24TZpPx3i5fw+ACFDGTzfv0=;
 b=Ck/hcDDr3uyu+GdSvNCE/FzwpOf1YGLMWPqXuI6Z/yBvI5fqxQNbv5GmmrRXDU44gxujLp
 /c0X1StKLTqMyIa/lpg3xlKC8tqVLKvNXHdh/ZhBResZ/A8mfBaIdI2KJXlh0zW1KaPeGD
 iCn8fheb4XelGnVQzpmKap0JarVoHGI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-2UCQmw4jOF-ApRI5WOHq_w-1; Fri, 26 Jun 2020 12:44:16 -0400
X-MC-Unique: 2UCQmw4jOF-ApRI5WOHq_w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22B557BAC;
 Fri, 26 Jun 2020 16:44:15 +0000 (UTC)
Received: from turbo.com (ovpn-112-91.ams2.redhat.com [10.36.112.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A2E855C6C0;
 Fri, 26 Jun 2020 16:44:00 +0000 (UTC)
From: Christophe de Dinechin <dinechin@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/10] spice: Put spice functions in a separate load module
Date: Fri, 26 Jun 2020 18:43:06 +0200
Message-Id: <20200626164307.3327380-10-dinechin@redhat.com>
In-Reply-To: <20200626164307.3327380-1-dinechin@redhat.com>
References: <20200626164307.3327380-1-dinechin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dinechin@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 03:23:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the MODIFACE and MODIMPL macros to to redirect the highest-level
qemu_spice functions into the spice-app.so load module when SPICE is
compiled as a module.

With these changes, the following shared libraries are no longer
necessary in the top-level qemu binary:

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
 include/ui/qemu-spice.h | 24 +++++++++++++++---------
 monitor/hmp-cmds.c      |  6 ++++++
 softmmu/vl.c            |  1 +
 ui/spice-core.c         | 31 +++++++++++++++++++++----------
 ui/spice-display.c      |  2 +-
 5 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/include/ui/qemu-spice.h b/include/ui/qemu-spice.h
index 8c23dfe717..0f7e139da5 100644
--- a/include/ui/qemu-spice.h
+++ b/include/ui/qemu-spice.h
@@ -24,22 +24,28 @@
 
 #include <spice.h>
 #include "qemu/config-file.h"
+#include "qemu/module.h"
 
-extern int using_spice;
+#define using_spice     (qemu_is_using_spice())
 
-void qemu_spice_init(void);
+MODIFACE(bool, qemu_is_using_spice,(void));
+MODIFACE(void, qemu_start_using_spice, (void));
+MODIFACE(void, qemu_spice_init, (void));
 void qemu_spice_input_init(void);
 void qemu_spice_audio_init(void);
-void qemu_spice_display_init(void);
-int qemu_spice_display_add_client(int csock, int skipauth, int tls);
+MODIFACE(void, qemu_spice_display_init, (void));
+MODIFACE(int, qemu_spice_display_add_client, (int csock, int skipauth, int tls));
 int qemu_spice_add_interface(SpiceBaseInstance *sin);
 bool qemu_spice_have_display_interface(QemuConsole *con);
 int qemu_spice_add_display_interface(QXLInstance *qxlin, QemuConsole *con);
-int qemu_spice_set_passwd(const char *passwd,
-                          bool fail_if_connected, bool disconnect_if_connected);
-int qemu_spice_set_pw_expire(time_t expires);
-int qemu_spice_migrate_info(const char *hostname, int port, int tls_port,
-                            const char *subject);
+MODIFACE(int, qemu_spice_set_passwd, (const char *passwd,
+                                      bool fail_if_connected,
+                                      bool disconnect_if_connected));
+MODIFACE(int, qemu_spice_set_pw_expire,(time_t expires));
+MODIFACE(int, qemu_spice_migrate_info,(const char *hostname,
+                                       int port, int tls_port,
+                                       const char *subject));
+MODIFACE(struct SpiceInfo *,qemu_spice_query, (Error **errp));
 
 #if !defined(SPICE_SERVER_VERSION) || (SPICE_SERVER_VERSION < 0xc06)
 #define SPICE_NEEDS_SET_MM_TIME 1
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 2b0b58a336..6bd9c52658 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -56,6 +56,7 @@
 #include "migration/misc.h"
 
 #ifdef CONFIG_SPICE
+#include "ui/qemu-spice.h"
 #include <spice/enums.h>
 #endif
 
@@ -573,6 +574,11 @@ void hmp_info_vnc(Monitor *mon, const QDict *qdict)
 #endif
 
 #ifdef CONFIG_SPICE
+SpiceInfo *qmp_query_spice(Error **errp)
+{
+    return qemu_spice_query(errp);
+}
+
 void hmp_info_spice(Monitor *mon, const QDict *qdict)
 {
     SpiceChannelList *chan;
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 3e15ee2435..c94b4fa49b 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -22,6 +22,7 @@
  * THE SOFTWARE.
  */
 
+#define MODULE_STUBS
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/units.h"
diff --git a/ui/spice-core.c b/ui/spice-core.c
index ecc2ec2c55..dbc1886b77 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -48,7 +48,7 @@ static time_t auth_expires = TIME_MAX;
 static int spice_migration_completed;
 static int spice_display_is_running;
 static int spice_have_target_host;
-int using_spice = 0;
+static int is_using_spice = 0;
 
 static QemuThread me;
 
@@ -503,7 +503,7 @@ static QemuOptsList qemu_spice_opts = {
     },
 };
 
-SpiceInfo *qmp_query_spice(Error **errp)
+MODIMPL(SpiceInfo *,qemu_spice_query,(Error **errp))
 {
     QemuOpts *opts = QTAILQ_FIRST(&qemu_spice_opts.head);
     int port, tls_port;
@@ -579,8 +579,9 @@ static void migration_state_notifier(Notifier *notifier, void *data)
     }
 }
 
-int qemu_spice_migrate_info(const char *hostname, int port, int tls_port,
-                            const char *subject)
+MODIMPL(int, qemu_spice_migrate_info, (const char *hostname,
+                                       int port, int tls_port,
+                                       const char *subject))
 {
     int ret;
 
@@ -634,7 +635,17 @@ static void vm_change_state_handler(void *opaque, int running,
     }
 }
 
-void qemu_spice_init(void)
+MODIMPL(bool, qemu_is_using_spice, (void))
+{
+    return is_using_spice;
+}
+
+MODIMPL(void, qemu_start_using_spice, (void))
+{
+    is_using_spice = 1;
+}
+
+MODIMPL(void, qemu_spice_init, (void))
 {
     QemuOpts *opts = QTAILQ_FIRST(&qemu_spice_opts.head);
     const char *password, *str, *x509_dir, *addr,
@@ -796,7 +807,7 @@ void qemu_spice_init(void)
         error_report("failed to initialize spice server");
         exit(1);
     };
-    using_spice = 1;
+    qemu_start_using_spice();
 
     migration_state.notify = migration_state_notifier;
     add_migration_state_change_notifier(&migration_state);
@@ -945,8 +956,8 @@ static int qemu_spice_set_ticket(bool fail_if_conn, bool disconnect_if_conn)
                                    fail_if_conn, disconnect_if_conn);
 }
 
-int qemu_spice_set_passwd(const char *passwd,
-                          bool fail_if_conn, bool disconnect_if_conn)
+MODIMPL(int, qemu_spice_set_passwd,(const char *passwd,
+                                    bool fail_if_conn, bool disconnect_if_conn))
 {
     if (strcmp(auth, "spice") != 0) {
         return -1;
@@ -957,13 +968,13 @@ int qemu_spice_set_passwd(const char *passwd,
     return qemu_spice_set_ticket(fail_if_conn, disconnect_if_conn);
 }
 
-int qemu_spice_set_pw_expire(time_t expires)
+MODIMPL(int, qemu_spice_set_pw_expire, (time_t expires))
 {
     auth_expires = expires;
     return qemu_spice_set_ticket(false, false);
 }
 
-int qemu_spice_display_add_client(int csock, int skipauth, int tls)
+MODIMPL(int, qemu_spice_display_add_client, (int csock, int skipauth, int tls))
 {
     if (tls) {
         return spice_server_add_ssl_client(spice_server, csock, skipauth);
diff --git a/ui/spice-display.c b/ui/spice-display.c
index 19632fdf6c..90529695fe 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -1164,7 +1164,7 @@ static void qemu_spice_display_init_one(QemuConsole *con)
     register_displaychangelistener(&ssd->dcl);
 }
 
-void qemu_spice_display_init(void)
+MODIMPL(void, qemu_spice_display_init,(void))
 {
     QemuOptsList *olist = qemu_find_opts("spice");
     QemuOpts *opts = QTAILQ_FIRST(&olist->head);
-- 
2.26.2


