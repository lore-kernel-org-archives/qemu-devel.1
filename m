Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F34C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:49:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 967DD20661
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PI/HTKHL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 967DD20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iucrd-0004dO-MK
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 08:49:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iub9P-0002oS-Iy
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iub9M-0005PF-VC
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36188
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iub9M-0005P1-RY
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KK/7qgjHzoRF+pgAqQJZ36ORUn7lwgLqQgxeveozNWk=;
 b=PI/HTKHL8ZqE4eCqqwHa+vIpzNzgYMLZBTAfSXlR8J4kIttlleKQIlZ4xCpqFTnAr1y5ar
 HwtigEIqvBJsQoei8LtAp47CTiAiVybggbb97FhqLadZCvd5U7huOUaA/byLhchRtUvvmw
 w4Tu7gjd0rEKbQ73QQ5rRvGW9LH8+UI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-szrA5WPTMtW_Oe-8aLLPpQ-1; Thu, 23 Jan 2020 06:59:49 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E96411800D48
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:59:48 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 42F451CB;
 Thu, 23 Jan 2020 11:59:48 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 052/111] virtiofsd: add seccomp whitelist
Date: Thu, 23 Jan 2020 11:57:42 +0000
Message-Id: <20200123115841.138849-53-dgilbert@redhat.com>
In-Reply-To: <20200123115841.138849-1-dgilbert@redhat.com>
References: <20200123115841.138849-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: szrA5WPTMtW_Oe-8aLLPpQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 Makefile                         |   5 +-
 tools/virtiofsd/Makefile.objs    |   5 +-
 tools/virtiofsd/passthrough_ll.c |   2 +
 tools/virtiofsd/seccomp.c        | 151 +++++++++++++++++++++++++++++++
 tools/virtiofsd/seccomp.h        |  14 +++
 5 files changed, 174 insertions(+), 3 deletions(-)
 create mode 100644 tools/virtiofsd/seccomp.c
 create mode 100644 tools/virtiofsd/seccomp.h

diff --git a/Makefile b/Makefile
index 2f81271ee7..ad400f36b2 100644
--- a/Makefile
+++ b/Makefile
@@ -327,7 +327,7 @@ HELPERS-y +=3D vhost-user-gpu$(EXESUF)
 vhost-user-json-y +=3D contrib/vhost-user-gpu/50-qemu-gpu.json
 endif
=20
-ifdef CONFIG_LINUX
+ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP),yy)
 HELPERS-y +=3D virtiofsd$(EXESUF)
 vhost-user-json-y +=3D tools/virtiofsd/50-qemu-virtiofsd.json
 endif
@@ -674,7 +674,8 @@ rdmacm-mux$(EXESUF): LIBS +=3D "-libumad"
 rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
 =09$(call LINK, $^)
=20
-ifdef CONFIG_LINUX # relies on Linux-specific syscalls
+# relies on Linux-specific syscalls
+ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP),yy)
 virtiofsd$(EXESUF): $(virtiofsd-obj-y) libvhost-user.a $(COMMON_LDADDS)
 =09$(call LINK, $^)
 endif
diff --git a/tools/virtiofsd/Makefile.objs b/tools/virtiofsd/Makefile.objs
index 45a807500d..076f667e46 100644
--- a/tools/virtiofsd/Makefile.objs
+++ b/tools/virtiofsd/Makefile.objs
@@ -5,5 +5,8 @@ virtiofsd-obj-y =3D buffer.o \
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
index 0947d14e5b..bd8925bd83 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -59,6 +59,7 @@
 #include <unistd.h>
=20
 #include "passthrough_helpers.h"
+#include "seccomp.h"
=20
 struct lo_map_elem {
     union {
@@ -2091,6 +2092,7 @@ static void setup_sandbox(struct lo_data *lo, struct =
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
index 0000000000..691fb63dea
--- /dev/null
+++ b/tools/virtiofsd/seccomp.c
@@ -0,0 +1,151 @@
+/*
+ * Seccomp sandboxing for virtiofsd
+ *
+ * Copyright (C) 2019 Red Hat, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
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
+#ifdef __NR_clone3
+    SCMP_SYS(clone3),
+#endif
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
+#ifdef __NR_setresgid32
+    SCMP_SYS(setresgid32),
+#endif
+#ifdef __NR_setresuid32
+    SCMP_SYS(setresuid32),
+#endif
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
2.24.1


