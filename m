Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAE1C47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 19:16:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A5432166E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 19:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ilcbAjIa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A5432166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUb9I-0008Bn-Gj
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 15:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jUb84-0006Ya-1e
 for qemu-devel@nongnu.org; Fri, 01 May 2020 15:15:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jUb82-0008Ud-4c
 for qemu-devel@nongnu.org; Fri, 01 May 2020 15:15:19 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60408
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jUb81-0008TD-Kd
 for qemu-devel@nongnu.org; Fri, 01 May 2020 15:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588360516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=odmGtRxQk+EqM/HcvrxgC41O+CKxykuhqQN21kGWGz8=;
 b=ilcbAjIa3zCmHD6rexnlZqweKYrPECqdB/6+HWi/mUysVI2fbR3bl3pUhXT8r96HfvVPrW
 m0Zsm1M0xofP3YLJDR4CFzYO1dE035LOMIwM3yoJGVcuLb+UarJ9tF9ZpjHT+ktbF7oE6c
 iYpX/5FgcHmu9nC8EuikLdAtOYZpZaw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-ZvCHB37WONKomZ4pC32vUg-1; Fri, 01 May 2020 15:15:14 -0400
X-MC-Unique: ZvCHB37WONKomZ4pC32vUg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 743CD45F;
 Fri,  1 May 2020 19:15:13 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-112-191.ams2.redhat.com
 [10.36.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3FEB310013BD;
 Fri,  1 May 2020 19:15:12 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, yavrahami@paloaltonetworks.com,
 mszeredi@redhat.com, mreitz@redhat.com
Subject: [PULL 1/6] virtiofsd: add --rlimit-nofile=NUM option
Date: Fri,  1 May 2020 20:14:55 +0100
Message-Id: <20200501191500.126432-2-dgilbert@redhat.com>
In-Reply-To: <20200501191500.126432-1-dgilbert@redhat.com>
References: <20200501191500.126432-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 12:40:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

Make it possible to specify the RLIMIT_NOFILE on the command-line.
Users running multiple virtiofsd processes should allocate a certain
number to each process so that the system-wide limit can never be
exhausted.

When this option is set to 0 the rlimit is left at its current value.
This is useful when a management tool wants to configure the rlimit
itself.

The default behavior remains unchanged: try to set the limit to
1,000,000 file descriptors if the current rlimit is lower.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20200501140644.220940-2-stefanha@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/fuse_lowlevel.h  |  1 +
 tools/virtiofsd/helper.c         | 23 +++++++++++++++++++++++
 tools/virtiofsd/passthrough_ll.c | 22 ++++++++--------------
 3 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/tools/virtiofsd/fuse_lowlevel.h b/tools/virtiofsd/fuse_lowleve=
l.h
index 8f6d705b5c..562fd5241e 100644
--- a/tools/virtiofsd/fuse_lowlevel.h
+++ b/tools/virtiofsd/fuse_lowlevel.h
@@ -1777,6 +1777,7 @@ struct fuse_cmdline_opts {
     int syslog;
     int log_level;
     unsigned int max_idle_threads;
+    unsigned long rlimit_nofile;
 };
=20
 /**
diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index 819c2bc13c..dc59f38af0 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -23,6 +23,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/param.h>
+#include <sys/time.h>
+#include <sys/resource.h>
 #include <unistd.h>
=20
 #define FUSE_HELPER_OPT(t, p)                       \
@@ -53,6 +55,7 @@ static const struct fuse_opt fuse_helper_opts[] =3D {
     FUSE_HELPER_OPT("subtype=3D", nodefault_subtype),
     FUSE_OPT_KEY("subtype=3D", FUSE_OPT_KEY_KEEP),
     FUSE_HELPER_OPT("max_idle_threads=3D%u", max_idle_threads),
+    FUSE_HELPER_OPT("--rlimit-nofile=3D%lu", rlimit_nofile),
     FUSE_HELPER_OPT("--syslog", syslog),
     FUSE_HELPER_OPT_VALUE("log_level=3Ddebug", log_level, FUSE_LOG_DEBUG),
     FUSE_HELPER_OPT_VALUE("log_level=3Dinfo", log_level, FUSE_LOG_INFO),
@@ -171,6 +174,9 @@ void fuse_cmdline_help(void)
            "                               default: no_writeback\n"
            "    -o xattr|no_xattr          enable/disable xattr\n"
            "                               default: no_xattr\n"
+           "    --rlimit-nofile=3D<num>      set maximum number of file de=
scriptors\n"
+           "                               (0 leaves rlimit unchanged)\n"
+           "                               default: 1,000,000 if the curre=
nt rlimit is lower\n"
            );
 }
=20
@@ -191,11 +197,28 @@ static int fuse_helper_opt_proc(void *data, const cha=
r *arg, int key,
     }
 }
=20
+static unsigned long get_default_rlimit_nofile(void)
+{
+    rlim_t max_fds =3D 1000000; /* our default RLIMIT_NOFILE target */
+    struct rlimit rlim;
+
+    if (getrlimit(RLIMIT_NOFILE, &rlim) < 0) {
+        fuse_log(FUSE_LOG_ERR, "getrlimit(RLIMIT_NOFILE): %m\n");
+        exit(1);
+    }
+
+    if (rlim.rlim_cur >=3D max_fds) {
+        return 0; /* we have more fds available than required! */
+    }
+    return max_fds;
+}
+
 int fuse_parse_cmdline(struct fuse_args *args, struct fuse_cmdline_opts *o=
pts)
 {
     memset(opts, 0, sizeof(struct fuse_cmdline_opts));
=20
     opts->max_idle_threads =3D 10;
+    opts->rlimit_nofile =3D get_default_rlimit_nofile();
     opts->foreground =3D 1;
=20
     if (fuse_opt_parse(args, opts, fuse_helper_opts, fuse_helper_opt_proc)=
 =3D=3D
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 4c35c95b25..f7b9c1d20c 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -2707,24 +2707,18 @@ static void setup_sandbox(struct lo_data *lo, struc=
t fuse_session *se,
     setup_seccomp(enable_syslog);
 }
=20
-/* Raise the maximum number of open file descriptors */
-static void setup_nofile_rlimit(void)
+/* Set the maximum number of open file descriptors */
+static void setup_nofile_rlimit(unsigned long rlimit_nofile)
 {
-    const rlim_t max_fds =3D 1000000;
-    struct rlimit rlim;
-
-    if (getrlimit(RLIMIT_NOFILE, &rlim) < 0) {
-        fuse_log(FUSE_LOG_ERR, "getrlimit(RLIMIT_NOFILE): %m\n");
-        exit(1);
-    }
+    struct rlimit rlim =3D {
+        .rlim_cur =3D rlimit_nofile,
+        .rlim_max =3D rlimit_nofile,
+    };
=20
-    if (rlim.rlim_cur >=3D max_fds) {
+    if (rlimit_nofile =3D=3D 0) {
         return; /* nothing to do */
     }
=20
-    rlim.rlim_cur =3D max_fds;
-    rlim.rlim_max =3D max_fds;
-
     if (setrlimit(RLIMIT_NOFILE, &rlim) < 0) {
         /* Ignore SELinux denials */
         if (errno =3D=3D EPERM) {
@@ -2977,7 +2971,7 @@ int main(int argc, char *argv[])
=20
     fuse_daemonize(opts.foreground);
=20
-    setup_nofile_rlimit();
+    setup_nofile_rlimit(opts.rlimit_nofile);
=20
     /* Must be before sandbox since it wants /proc */
     setup_capng();
--=20
2.26.2


