Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C66FC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:28:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B36E2173E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQcHw9TG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B36E2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSGZ-000480-Up
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:28:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52703)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRVw-0006Cx-KR
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRVu-0002cK-Lm
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:32 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39254
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRVu-0002bf-HR
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0PgdZCyw8sY7AIHCYCuBhgOjNpGmvh6jgIw8FLDcjig=;
 b=WQcHw9TG2Ho+WvOLNdmvRJ7QXmCNL7ArlhRRRBPrpXxFhR5WGZh8JNR/YCJroJz/OtNnTf
 5fqxkrKWulnMyn3fWMc9IEtiz6+1anz/RM6hRwOr7HiIqF8QuFj/504zEYb3EiAxUzqJw7
 JBIQJ5i4ADC4l/fce3lIp8qqK+/QZts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-KJx-_6ZPOFCD6Ssrh1euww-1; Thu, 12 Dec 2019 11:40:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A743800EB5
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:40:28 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C2AD60BF3;
 Thu, 12 Dec 2019 16:40:27 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 050/104] virtiofsd: add seccomp whitelist
Date: Thu, 12 Dec 2019 16:38:10 +0000
Message-Id: <20191212163904.159893-51-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: KJx-_6ZPOFCD6Ssrh1euww-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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

Only allow system calls that are needed by virtiofsd.  All other system
calls cause SIGSYS to be directed at the thread and the process will
coredump.

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
 Makefile                         |   2 +
 tools/virtiofsd/Makefile.objs    |   5 +-
 tools/virtiofsd/passthrough_ll.c |   2 +
 tools/virtiofsd/seccomp.c        | 141 +++++++++++++++++++++++++++++++
 tools/virtiofsd/seccomp.h        |  14 +++
 5 files changed, 163 insertions(+), 1 deletion(-)
 create mode 100644 tools/virtiofsd/seccomp.c
 create mode 100644 tools/virtiofsd/seccomp.h

diff --git a/Makefile b/Makefile
index 8a5746d8a0..3f5d04e1f7 100644
--- a/Makefile
+++ b/Makefile
@@ -322,8 +322,10 @@ HELPERS-y =3D
 HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) =3D qemu-bridge-hel=
per$(EXESUF)
=20
 ifdef CONFIG_LINUX
+ifdef CONFIG_SECCOMP
 HELPERS-y +=3D virtiofsd$(EXESUF)
 vhost-user-json-y +=3D tools/virtiofsd/50-qemu-virtiofsd.json
+endif
=20
 ifdef CONFIG_VIRGL
 ifdef CONFIG_GBM
diff --git a/tools/virtiofsd/Makefile.objs b/tools/virtiofsd/Makefile.objs
index 67be16332c..941b19f18e 100644
--- a/tools/virtiofsd/Makefile.objs
+++ b/tools/virtiofsd/Makefile.objs
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
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 754ef2618b..701608c6df 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -58,6 +58,7 @@
 #include <unistd.h>
=20
 #include "passthrough_helpers.h"
+#include "seccomp.h"
=20
 #define HAVE_POSIX_FALLOCATE 1
 struct lo_map_elem {
@@ -2073,6 +2074,7 @@ static void setup_sandbox(struct lo_data *lo, struct =
fuse_session *se)
 {
     setup_namespaces(lo, se);
     setup_mounts(lo->source);
+    setup_seccomp();
 }
=20
 int main(int argc, char *argv[])
diff --git a/tools/virtiofsd/seccomp.c b/tools/virtiofsd/seccomp.c
new file mode 100644
index 0000000000..6359bb55bb
--- /dev/null
+++ b/tools/virtiofsd/seccomp.c
@@ -0,0 +1,141 @@
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
+/* Bodge for libseccomp 2.4.2 which broke ppoll */
+#if !defined(__SNR_ppoll) && defined(__SNR_brk)
+#ifdef __NR_ppoll
+#define __SNR_ppoll __NR_ppoll
+#else
+#define __SNR_ppoll __PNR_ppoll
+#endif
+#endif
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
+        ctx =3D seccomp_init(SCMP_ACT_TRAP);
+    }
+#else
+    ctx =3D seccomp_init(SCMP_ACT_TRAP);
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
diff --git a/tools/virtiofsd/seccomp.h b/tools/virtiofsd/seccomp.h
new file mode 100644
index 0000000000..86bce72652
--- /dev/null
+++ b/tools/virtiofsd/seccomp.h
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


