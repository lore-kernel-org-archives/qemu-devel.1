Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9F5CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:31:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E6320650
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pu+Hf5Sv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E6320650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNcGy-00048O-PQ
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNbIQ-0004H1-EJ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNbIO-0000C3-Pn
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53323
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNbIO-0000Bz-Le
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571916528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K58GGzAip+2dZ/mZYZArAE9ijZ6rn56P+KDGUgMRovI=;
 b=Pu+Hf5SvAYCDOu/s2YnKiVQAeA+wuPAM/XJZQQrpNREt1r6Kg5Snn7sgn8RWCkYh3UQRfz
 xnSrnZxgycYETxuvweceS2TXpwHVwhsc0tOhGaWogRjBSuTpyqAF9lG4aMn+hN676phwcP
 VZ1RLV+sfmWbZmJ0AW3KM2XkNW+Tq9E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-t2R1WiDZOHmLewGpIi7eUQ-1; Thu, 24 Oct 2019 07:28:44 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 726CB800D49;
 Thu, 24 Oct 2019 11:28:43 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-248.ams2.redhat.com
 [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EEDF0196B2;
 Thu, 24 Oct 2019 11:28:35 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, renzhen@linux.alibaba.com, eguan@linux.alibaba.com,
 ganesh.mahalingam@intel.com, m.mizuma@jp.fujitsu.com, mszeredi@redhat.com,
 misono.tomohiro@jp.fujitsu.com, tao.peng@linux.alibaba.com,
 piaojun@huawei.com, stefanha@redhat.com, vgoyal@redhat.com, mst@redhat.com,
 berrange@redhat.com
Subject: [PATCH 19/25] virtiofsd: add seccomp whitelist
Date: Thu, 24 Oct 2019 12:27:12 +0100
Message-Id: <20191024112718.34657-20-dgilbert@redhat.com>
In-Reply-To: <20191024112718.34657-1-dgilbert@redhat.com>
References: <20191024112718.34657-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: t2R1WiDZOHmLewGpIi7eUQ-1
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

Only allow system calls that are needed by virtiofsd.  All other system
calls cause SIGSYS to be directed at the thread.

Restricting system calls reduces the kernel attack surface and limits
what the process can do when compromised.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
with additional entries by:
Signed-off-by: Ganesh Maharaj Mahalingam <ganesh.mahalingam@intel.com>
Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Signed-off-by: piaojun <piaojun@huawei.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Eric Ren <renzhen@linux.alibaba.com>
---
 contrib/virtiofsd/Makefile.objs    |   5 +-
 contrib/virtiofsd/passthrough_ll.c |   2 +
 contrib/virtiofsd/seccomp.c        | 132 +++++++++++++++++++++++++++++
 contrib/virtiofsd/seccomp.h        |  14 +++
 4 files changed, 152 insertions(+), 1 deletion(-)
 create mode 100644 contrib/virtiofsd/seccomp.c
 create mode 100644 contrib/virtiofsd/seccomp.h

diff --git a/contrib/virtiofsd/Makefile.objs b/contrib/virtiofsd/Makefile.o=
bjs
index 67be16332c..941b19f18e 100644
--- a/contrib/virtiofsd/Makefile.objs
+++ b/contrib/virtiofsd/Makefile.objs
@@ -6,5 +6,8 @@ virtiofsd-obj-y =3D buffer.o \
                   fuse_signals.o \
                   fuse_virtio.o \
                   helper.o \
-                  passthrough_ll.o
+                  passthrough_ll.o \
+                  seccomp.o
=20
+seccomp.o-cflags :=3D $(SECCOMP_CFLAGS)
+seccomp.o-libs :=3D $(SECCOMP_LIBS)
diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthr=
ough_ll.c
index c027db64e6..93873bf6f4 100644
--- a/contrib/virtiofsd/passthrough_ll.c
+++ b/contrib/virtiofsd/passthrough_ll.c
@@ -56,6 +56,7 @@
 #include <sys/wait.h>
=20
 #include "passthrough_helpers.h"
+#include "seccomp.h"
=20
 #define HAVE_POSIX_FALLOCATE 1
=20
@@ -1979,6 +1980,7 @@ static void setup_sandbox(struct lo_data *lo)
 =09setup_proc_self_fd(lo);
 =09setup_net_namespace();
 =09setup_mount_namespace(lo->source);
+=09setup_seccomp();
 }
=20
 int main(int argc, char *argv[])
diff --git a/contrib/virtiofsd/seccomp.c b/contrib/virtiofsd/seccomp.c
new file mode 100644
index 0000000000..df1390d6be
--- /dev/null
+++ b/contrib/virtiofsd/seccomp.c
@@ -0,0 +1,132 @@
+/*
+ * Seccomp sandboxing for virtiofsd
+ *
+ * Copyright (C) 2019 Red Hat, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "seccomp.h"
+#include "fuse_i.h"
+#include "fuse_log.h"
+#include <errno.h>
+#include <glib.h>
+#include <seccomp.h>
+#include <stdlib.h>
+
+static const int syscall_whitelist[] =3D {
+    /* TODO ireg sem*() syscalls */
+    SCMP_SYS(brk),
+    SCMP_SYS(capget), /* For CAP_FSETID */
+    SCMP_SYS(capset),
+    SCMP_SYS(clock_gettime),
+    SCMP_SYS(clone),
+    SCMP_SYS(close),
+    SCMP_SYS(copy_file_range),
+    SCMP_SYS(dup),
+    SCMP_SYS(eventfd2),
+    SCMP_SYS(exit),
+    SCMP_SYS(exit_group),
+    SCMP_SYS(fallocate),
+    SCMP_SYS(fchmodat),
+    SCMP_SYS(fchownat),
+    SCMP_SYS(fcntl),
+    SCMP_SYS(fdatasync),
+    SCMP_SYS(fgetxattr),
+    SCMP_SYS(flistxattr),
+    SCMP_SYS(flock),
+    SCMP_SYS(fremovexattr),
+    SCMP_SYS(fsetxattr),
+    SCMP_SYS(fstat),
+    SCMP_SYS(fstatfs),
+    SCMP_SYS(fsync),
+    SCMP_SYS(ftruncate),
+    SCMP_SYS(futex),
+    SCMP_SYS(getdents),
+    SCMP_SYS(getdents64),
+    SCMP_SYS(getegid),
+    SCMP_SYS(geteuid),
+    SCMP_SYS(getpid),
+    SCMP_SYS(gettid),
+    SCMP_SYS(gettimeofday),
+    SCMP_SYS(linkat),
+    SCMP_SYS(lseek),
+    SCMP_SYS(madvise),
+    SCMP_SYS(mkdirat),
+    SCMP_SYS(mknodat),
+    SCMP_SYS(mmap),
+    SCMP_SYS(mprotect),
+    SCMP_SYS(mremap),
+    SCMP_SYS(munmap),
+    SCMP_SYS(newfstatat),
+    SCMP_SYS(open),
+    SCMP_SYS(openat),
+    SCMP_SYS(ppoll),
+    SCMP_SYS(prctl), /* TODO restrict to just PR_SET_NAME? */
+    SCMP_SYS(preadv),
+    SCMP_SYS(pread64),
+    SCMP_SYS(pwritev),
+    SCMP_SYS(pwrite64),
+    SCMP_SYS(read),
+    SCMP_SYS(readlinkat),
+    SCMP_SYS(recvmsg),
+    SCMP_SYS(renameat),
+    SCMP_SYS(renameat2),
+    SCMP_SYS(rt_sigaction),
+    SCMP_SYS(rt_sigprocmask),
+    SCMP_SYS(rt_sigreturn),
+    SCMP_SYS(sendmsg),
+    SCMP_SYS(setresgid),
+    SCMP_SYS(setresuid),
+    SCMP_SYS(set_robust_list),
+    SCMP_SYS(symlinkat),
+    SCMP_SYS(time), /* Rarely needed, except on static builds */
+    SCMP_SYS(tgkill),
+    SCMP_SYS(unlinkat),
+    SCMP_SYS(utimensat),
+    SCMP_SYS(write),
+    SCMP_SYS(writev),
+};
+
+void setup_seccomp(void)
+{
+    scmp_filter_ctx ctx;
+    size_t i;
+
+#ifdef SCMP_ACT_KILL_PROCESS
+    ctx =3D seccomp_init(SCMP_ACT_KILL_PROCESS);
+    /* Handle a newer libseccomp but an older kernel */
+    if (!ctx && errno =3D=3D EOPNOTSUPP) {
+        ctx =3D seccomp_init(SCMP_ACT_KILL);
+    }
+#else
+    ctx =3D seccomp_init(SCMP_ACT_KILL);
+#endif
+    if (!ctx) {
+        fuse_log(FUSE_LOG_ERR, "seccomp_init() failed\n");
+        exit(1);
+    }
+
+    for (i =3D 0; i < G_N_ELEMENTS(syscall_whitelist); i++) {
+        if (seccomp_rule_add(ctx, SCMP_ACT_ALLOW,
+                             syscall_whitelist[i], 0) !=3D 0) {
+            fuse_log(FUSE_LOG_ERR, "seccomp_rule_add syscall %d",
+                     syscall_whitelist[i]);
+            exit(1);
+        }
+    }
+
+    /* libvhost-user calls this for post-copy migration, we don't need it =
*/
+    if (seccomp_rule_add(ctx, SCMP_ACT_ERRNO(ENOSYS),
+                         SCMP_SYS(userfaultfd), 0) !=3D 0) {
+        fuse_log(FUSE_LOG_ERR, "seccomp_rule_add userfaultfd failed\n");
+        exit(1);
+    }
+
+    if (seccomp_load(ctx) < 0) {
+        fuse_log(FUSE_LOG_ERR, "seccomp_load() failed\n");
+        exit(1);
+    }
+
+    seccomp_release(ctx);
+}
diff --git a/contrib/virtiofsd/seccomp.h b/contrib/virtiofsd/seccomp.h
new file mode 100644
index 0000000000..86bce72652
--- /dev/null
+++ b/contrib/virtiofsd/seccomp.h
@@ -0,0 +1,14 @@
+/*
+ * Seccomp sandboxing for virtiofsd
+ *
+ * Copyright (C) 2019 Red Hat, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef VIRTIOFSD_SECCOMP_H
+#define VIRTIOFSD_SECCOMP_H
+
+void setup_seccomp(void);
+
+#endif /* VIRTIOFSD_SECCOMP_H */
--=20
2.23.0


