Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124C5C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:19:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D421B205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V0LkrVKa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D421B205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifS7v-0007o3-63
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:19:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRW4-0006R2-Gg
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRW2-0002t0-St
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26757
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRW2-0002rn-Ns
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jSVjjnm0/PyMOSmHXzLv1BxPzXRMt4kyEA13porArRE=;
 b=V0LkrVKa8xTFmVeDVIvBJWfhdAHSIxw66cHmHjBEWvjB+nZQx/njd/ij32rF2bS/dcC+dk
 1W5UaxCWpSK++i+lVrZPorg5iIoO9wGpU7TjS4gv3emBI9BaEqCL8oIKCJoOGeIaMjTzao
 rzh2zcnm8BXMEJBCMhw7P4hhIF7jjuI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-Bvv4ns0VOKOdXq-R5KjDQg-1; Thu, 12 Dec 2019 11:40:36 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2243F189CD01
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:40:36 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4587260BF3;
 Thu, 12 Dec 2019 16:40:35 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 057/104] virtiofsd: add --syslog command-line option
Date: Thu, 12 Dec 2019 16:38:17 +0000
Message-Id: <20191212163904.159893-58-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Bvv4ns0VOKOdXq-R5KjDQg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Sometimes collecting output from stderr is inconvenient or does not fit
within the overall logging architecture.  Add syslog(3) support for
cases where stderr cannot be used.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
dgilbert: Reworked as a logging function
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/fuse_lowlevel.h  |  1 +
 tools/virtiofsd/helper.c         |  2 ++
 tools/virtiofsd/passthrough_ll.c | 50 ++++++++++++++++++++++++++++++--
 tools/virtiofsd/seccomp.c        | 32 ++++++++++++++------
 tools/virtiofsd/seccomp.h        |  4 ++-
 5 files changed, 76 insertions(+), 13 deletions(-)

diff --git a/tools/virtiofsd/fuse_lowlevel.h b/tools/virtiofsd/fuse_lowleve=
l.h
index 6c63cb740c..c67677732b 100644
--- a/tools/virtiofsd/fuse_lowlevel.h
+++ b/tools/virtiofsd/fuse_lowlevel.h
@@ -1828,6 +1828,7 @@ struct fuse_cmdline_opts {
     int show_help;
     int print_capabilities;
     int clone_fd;
+    int syslog;
     unsigned int max_idle_threads;
 };
=20
diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index 4c9a3b2fc9..2c64b10ebf 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -55,6 +55,7 @@ static const struct fuse_opt fuse_helper_opts[] =3D {
     FUSE_OPT_KEY("subtype=3D", FUSE_OPT_KEY_KEEP),
     FUSE_HELPER_OPT("clone_fd", clone_fd),
     FUSE_HELPER_OPT("max_idle_threads=3D%u", max_idle_threads),
+    FUSE_HELPER_OPT("--syslog", syslog),
     FUSE_OPT_END
 };
=20
@@ -139,6 +140,7 @@ void fuse_cmdline_help(void)
            "    -V   --version             print version\n"
            "    --print-capabilities       print vhost-user.json\n"
            "    -d   -o debug              enable debug output (implies -f=
)\n"
+           "    --syslog                   log to syslog (default stderr)\=
n"
            "    -f                         foreground operation\n"
            "    --daemonize                run in background\n"
            "    -s                         disable multi-threaded operatio=
n\n"
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 139bf08f4c..9ede80af94 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -57,6 +57,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <sys/xattr.h>
+#include <syslog.h>
 #include <unistd.h>
=20
 #include "passthrough_helpers.h"
@@ -138,6 +139,7 @@ static const struct fuse_opt lo_opts[] =3D {
     { "norace", offsetof(struct lo_data, norace), 1 },
     FUSE_OPT_END
 };
+static bool use_syslog =3D false;
=20
 static void unref_inode(struct lo_data *lo, struct lo_inode *inode, uint64=
_t n);
=20
@@ -2244,11 +2246,12 @@ static void setup_mounts(const char *source)
  * Lock down this process to prevent access to other processes or files ou=
tside
  * source directory.  This reduces the impact of arbitrary code execution =
bugs.
  */
-static void setup_sandbox(struct lo_data *lo, struct fuse_session *se)
+static void setup_sandbox(struct lo_data *lo, struct fuse_session *se,
+                          bool enable_syslog)
 {
     setup_namespaces(lo, se);
     setup_mounts(lo->source);
-    setup_seccomp();
+    setup_seccomp(enable_syslog);
 }
=20
 /* Raise the maximum number of open file descriptors */
@@ -2280,6 +2283,42 @@ static void setup_nofile_rlimit(void)
     }
 }
=20
+static void log_func(enum fuse_log_level level, const char *fmt, va_list a=
p)
+{
+    if (use_syslog) {
+        int priority =3D LOG_ERR;
+        switch (level) {
+        case FUSE_LOG_EMERG:
+            priority =3D LOG_EMERG;
+            break;
+        case FUSE_LOG_ALERT:
+            priority =3D LOG_ALERT;
+            break;
+        case FUSE_LOG_CRIT:
+            priority =3D LOG_CRIT;
+            break;
+        case FUSE_LOG_ERR:
+            priority =3D LOG_ERR;
+            break;
+        case FUSE_LOG_WARNING:
+            priority =3D LOG_WARNING;
+            break;
+        case FUSE_LOG_NOTICE:
+            priority =3D LOG_NOTICE;
+            break;
+        case FUSE_LOG_INFO:
+            priority =3D LOG_INFO;
+            break;
+        case FUSE_LOG_DEBUG:
+            priority =3D LOG_DEBUG;
+            break;
+        }
+        vsyslog(priority, fmt, ap);
+    } else {
+        vfprintf(stderr, fmt, ap);
+    }
+}
+
 int main(int argc, char *argv[])
 {
     struct fuse_args args =3D FUSE_ARGS_INIT(argc, argv);
@@ -2318,6 +2357,11 @@ int main(int argc, char *argv[])
     if (fuse_parse_cmdline(&args, &opts) !=3D 0) {
         return 1;
     }
+    fuse_set_log_func(log_func);
+    use_syslog =3D opts.syslog;
+    if (use_syslog) {
+        openlog("virtiofsd", LOG_PID, LOG_DAEMON);
+    }
     if (opts.show_help) {
         printf("usage: %s [options]\n\n", argv[0]);
         fuse_cmdline_help();
@@ -2406,7 +2450,7 @@ int main(int argc, char *argv[])
     /* Must be before sandbox since it wants /proc */
     setup_capng();
=20
-    setup_sandbox(&lo, se);
+    setup_sandbox(&lo, se, opts.syslog);
=20
     /* Block until ctrl+c or fusermount -u */
     ret =3D virtio_loop(se);
diff --git a/tools/virtiofsd/seccomp.c b/tools/virtiofsd/seccomp.c
index 6359bb55bb..33ec309fc8 100644
--- a/tools/virtiofsd/seccomp.c
+++ b/tools/virtiofsd/seccomp.c
@@ -97,11 +97,28 @@ static const int syscall_whitelist[] =3D {
     SCMP_SYS(writev),
 };
=20
-void setup_seccomp(void)
+/* Syscalls used when --syslog is enabled */
+static const int syscall_whitelist_syslog[] =3D {
+    SCMP_SYS(sendto),
+};
+
+static void add_whitelist(scmp_filter_ctx ctx, const int syscalls[], size_=
t len)
 {
-    scmp_filter_ctx ctx;
     size_t i;
=20
+    for (i =3D 0; i < len; i++) {
+        if (seccomp_rule_add(ctx, SCMP_ACT_ALLOW, syscalls[i], 0) !=3D 0) =
{
+            fuse_log(FUSE_LOG_ERR, "seccomp_rule_add syscall %d failed\n",
+                     syscalls[i]);
+            exit(1);
+        }
+    }
+}
+
+void setup_seccomp(bool enable_syslog)
+{
+    scmp_filter_ctx ctx;
+
 #ifdef SCMP_ACT_KILL_PROCESS
     ctx =3D seccomp_init(SCMP_ACT_KILL_PROCESS);
     /* Handle a newer libseccomp but an older kernel */
@@ -116,13 +133,10 @@ void setup_seccomp(void)
         exit(1);
     }
=20
-    for (i =3D 0; i < G_N_ELEMENTS(syscall_whitelist); i++) {
-        if (seccomp_rule_add(ctx, SCMP_ACT_ALLOW,
-                             syscall_whitelist[i], 0) !=3D 0) {
-            fuse_log(FUSE_LOG_ERR, "seccomp_rule_add syscall %d",
-                     syscall_whitelist[i]);
-            exit(1);
-        }
+    add_whitelist(ctx, syscall_whitelist, G_N_ELEMENTS(syscall_whitelist))=
;
+    if (enable_syslog) {
+        add_whitelist(ctx, syscall_whitelist_syslog,
+                      G_N_ELEMENTS(syscall_whitelist_syslog));
     }
=20
     /* libvhost-user calls this for post-copy migration, we don't need it =
*/
diff --git a/tools/virtiofsd/seccomp.h b/tools/virtiofsd/seccomp.h
index 86bce72652..d47c8eade6 100644
--- a/tools/virtiofsd/seccomp.h
+++ b/tools/virtiofsd/seccomp.h
@@ -9,6 +9,8 @@
 #ifndef VIRTIOFSD_SECCOMP_H
 #define VIRTIOFSD_SECCOMP_H
=20
-void setup_seccomp(void);
+#include <stdbool.h>
+
+void setup_seccomp(bool enable_syslog);
=20
 #endif /* VIRTIOFSD_SECCOMP_H */
--=20
2.23.0


