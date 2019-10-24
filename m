Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1FECA9EBC
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:35:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C19E20650
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/L3E9bz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C19E20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNcL2-0003L2-Q9
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39587)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNbIo-0004zZ-9p
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:29:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNbIk-0000Is-Hy
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:29:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57302
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNbIk-0000IV-7R
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571916549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tct+SO+6uHPLQvjaJ4I4j6zkVeClNwIC/9KN2i8NK6o=;
 b=d/L3E9bzsy2bfMCRhr0UzNf9Ri1rQxzl/0duTV/jFI4UecHYxk4EvdBkoYdkIVV44KPWW4
 Ab1PShJ9s0DB7C1jwF9q7OlpXTfsttZB7zNVTof8ZF2SHZe/MPFPV3qpRnwWAiN3UNBa1f
 JgLS7PRT5Ifv7PGSzvqJ5FNPikujwnk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-pNC4eSWkPmyvE5Li-fqbyA-1; Thu, 24 Oct 2019 07:29:04 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B406B107AD31;
 Thu, 24 Oct 2019 11:29:02 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-248.ams2.redhat.com
 [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 806C64524;
 Thu, 24 Oct 2019 11:28:55 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, renzhen@linux.alibaba.com, eguan@linux.alibaba.com,
 ganesh.mahalingam@intel.com, m.mizuma@jp.fujitsu.com, mszeredi@redhat.com,
 misono.tomohiro@jp.fujitsu.com, tao.peng@linux.alibaba.com,
 piaojun@huawei.com, stefanha@redhat.com, vgoyal@redhat.com, mst@redhat.com,
 berrange@redhat.com
Subject: [PATCH 24/25] virtiofsd: add --syslog command-line option
Date: Thu, 24 Oct 2019 12:27:17 +0100
Message-Id: <20191024112718.34657-25-dgilbert@redhat.com>
In-Reply-To: <20191024112718.34657-1-dgilbert@redhat.com>
References: <20191024112718.34657-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: pNC4eSWkPmyvE5Li-fqbyA-1
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
 contrib/virtiofsd/fuse_lowlevel.h  |  1 +
 contrib/virtiofsd/helper.c         |  2 ++
 contrib/virtiofsd/passthrough_ll.c | 34 +++++++++++++++++++++++++++---
 contrib/virtiofsd/seccomp.c        | 32 ++++++++++++++++++++--------
 contrib/virtiofsd/seccomp.h        |  4 +++-
 5 files changed, 60 insertions(+), 13 deletions(-)

diff --git a/contrib/virtiofsd/fuse_lowlevel.h b/contrib/virtiofsd/fuse_low=
level.h
index 13fd9791d5..112596caaf 100644
--- a/contrib/virtiofsd/fuse_lowlevel.h
+++ b/contrib/virtiofsd/fuse_lowlevel.h
@@ -1798,6 +1798,7 @@ struct fuse_cmdline_opts {
 =09int show_help;
 =09int print_capabilities;
 =09int clone_fd;
+=09int syslog;
 =09unsigned int max_idle_threads;
 };
=20
diff --git a/contrib/virtiofsd/helper.c b/contrib/virtiofsd/helper.c
index 08e00c0d13..b1e45aee05 100644
--- a/contrib/virtiofsd/helper.c
+++ b/contrib/virtiofsd/helper.c
@@ -53,6 +53,7 @@ static const struct fuse_opt fuse_helper_opts[] =3D {
 #endif
 =09FUSE_HELPER_OPT("clone_fd",=09clone_fd),
 =09FUSE_HELPER_OPT("max_idle_threads=3D%u", max_idle_threads),
+=09FUSE_HELPER_OPT("--syslog",=09syslog),
 =09FUSE_OPT_END
 };
=20
@@ -135,6 +136,7 @@ void fuse_cmdline_help(void)
 =09       "    -V   --version             print version\n"
 =09       "    --print-capabilities       print vhost-user.json\n"
 =09       "    -d   -o debug              enable debug output (implies -f)=
\n"
+=09       "    --syslog                   log to syslog (default stderr)\n=
"
 =09       "    -f                         foreground operation\n"
 =09       "    --daemonize                run in background\n"
 =09       "    -s                         disable multi-threaded operation=
\n"
diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthr=
ough_ll.c
index 25f7ad854a..b413687720 100644
--- a/contrib/virtiofsd/passthrough_ll.c
+++ b/contrib/virtiofsd/passthrough_ll.c
@@ -42,6 +42,7 @@
 #include <stddef.h>
 #include <stdbool.h>
 #include <string.h>
+#include <syslog.h>
 #include <limits.h>
 #include <dirent.h>
 #include <assert.h>
@@ -151,6 +152,7 @@ static const struct fuse_opt lo_opts[] =3D {
 =09  offsetof(struct lo_data, norace), 1 },
 =09FUSE_OPT_END
 };
+static bool use_syslog =3D false;
=20
 static void unref_inode(struct lo_data *lo, struct lo_inode *inode, uint64=
_t n);
=20
@@ -2103,13 +2105,13 @@ static void setup_mount_namespace(const char *sourc=
e)
  * Lock down this process to prevent access to other processes or files ou=
tside
  * source directory.  This reduces the impact of arbitrary code execution =
bugs.
  */
-static void setup_sandbox(struct lo_data *lo)
+static void setup_sandbox(struct lo_data *lo, bool enable_syslog)
 {
 =09setup_pid_namespace();
 =09setup_proc_self_fd(lo);
 =09setup_net_namespace();
 =09setup_mount_namespace(lo->source);
-=09setup_seccomp();
+=09setup_seccomp(enable_syslog);
 }
=20
 /* Raise the maximum number of open file descriptors to the system limit *=
/
@@ -2142,6 +2144,27 @@ static void setup_nofile_rlimit(void)
 =09g_free(nr_open);
 }
=20
+static void log_func(enum fuse_log_level level,
+=09=09     const char *fmt, va_list ap)
+{
+=09if (use_syslog) {
+=09=09int priority =3D LOG_ERR;
+=09=09switch (level) {
+=09=09=09case FUSE_LOG_EMERG:   priority =3D LOG_EMERG;   break;
+=09=09=09case FUSE_LOG_ALERT:   priority =3D LOG_ALERT;   break;
+=09=09=09case FUSE_LOG_CRIT:    priority =3D LOG_CRIT;    break;
+=09=09=09case FUSE_LOG_ERR:     priority =3D LOG_ERR;     break;
+=09=09=09case FUSE_LOG_WARNING: priority =3D LOG_WARNING; break;
+=09=09=09case FUSE_LOG_NOTICE:  priority =3D LOG_NOTICE;  break;
+=09=09=09case FUSE_LOG_INFO:    priority =3D LOG_INFO;    break;
+=09=09=09case FUSE_LOG_DEBUG:   priority =3D LOG_DEBUG;   break;
+=09=09}
+=09=09vsyslog(priority, fmt, ap);
+=09} else {
+=09=09vfprintf(stderr, fmt, ap);
+=09}
+}
+
 int main(int argc, char *argv[])
 {
 =09struct fuse_args args =3D FUSE_ARGS_INIT(argc, argv);
@@ -2179,6 +2202,11 @@ int main(int argc, char *argv[])
=20
 =09if (fuse_parse_cmdline(&args, &opts) !=3D 0)
 =09=09return 1;
+=09fuse_set_log_func(log_func);
+=09use_syslog =3D opts.syslog;
+=09if (use_syslog) {
+=09    openlog("virtiofsd", LOG_PID, LOG_DAEMON);
+=09}
 =09if (opts.show_help) {
 =09=09printf("usage: %s [options]\n\n", argv[0]);
 =09=09fuse_cmdline_help();
@@ -2260,7 +2288,7 @@ int main(int argc, char *argv[])
=20
 =09fuse_daemonize(opts.foreground);
=20
-=09setup_sandbox(&lo);
+=09setup_sandbox(&lo, opts.syslog);
=20
 =09/* Block until ctrl+c or fusermount -u */
 =09ret =3D virtio_loop(se);
diff --git a/contrib/virtiofsd/seccomp.c b/contrib/virtiofsd/seccomp.c
index df1390d6be..77bc405bdc 100644
--- a/contrib/virtiofsd/seccomp.c
+++ b/contrib/virtiofsd/seccomp.c
@@ -88,11 +88,28 @@ static const int syscall_whitelist[] =3D {
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
@@ -107,13 +124,10 @@ void setup_seccomp(void)
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
diff --git a/contrib/virtiofsd/seccomp.h b/contrib/virtiofsd/seccomp.h
index 86bce72652..d47c8eade6 100644
--- a/contrib/virtiofsd/seccomp.h
+++ b/contrib/virtiofsd/seccomp.h
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


