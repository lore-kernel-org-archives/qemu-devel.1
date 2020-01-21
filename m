Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30C0C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 19:50:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C51021835
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 19:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KMkD88jR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C51021835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itzXP-0004BV-9i
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 14:50:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itzWf-0003bt-AV
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 14:49:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itzWb-0006Bf-UF
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 14:49:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35020
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itzWb-0006B5-A6
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 14:49:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579636160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9dGgXWissZZzZ6TUPNz/ohQp7l3i67naWHhALm5enTI=;
 b=KMkD88jRxHCwQjutkDCBmUJwllL8OhPzKCBosFLzzVL9rc1clQ9L7/LGHtTWBpMoce0JpB
 SRSzMqNL5nrFuzMpb0C2SlehKho4ZZIa8AbICQ0djBRW1Dzo4P8HBxRSYasmo5uxxthXSZ
 H0kfwKcXUqTzVLzyJ1S2WT5ylIS72AU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-XlXBDQvvNICc721dM5CidA-1; Tue, 21 Jan 2020 14:49:16 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94973800D41;
 Tue, 21 Jan 2020 19:49:15 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C2788858BE;
 Tue, 21 Jan 2020 19:49:06 +0000 (UTC)
Date: Tue, 21 Jan 2020 19:49:03 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 051/109] virtiofsd: add seccomp whitelist
Message-ID: <20200121194903.GQ2929@work-vm>
References: <20200121122433.50803-1-dgilbert@redhat.com>
 <20200121122433.50803-52-dgilbert@redhat.com>
 <ba916575-1496-8c3d-a568-573ebb07d4ec@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ba916575-1496-8c3d-a568-573ebb07d4ec@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: XlXBDQvvNICc721dM5CidA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: m.mizuma@jp.fujitsu.com, berrange@redhat.com, slp@redhat.com,
 qemu-devel@nongnu.org, misono.tomohiro@jp.fujitsu.com, stefanha@redhat.com,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daud=E9 (philmd@redhat.com) wrote:
> On 1/21/20 1:23 PM, Dr. David Alan Gilbert (git) wrote:
> > From: Stefan Hajnoczi <stefanha@redhat.com>
> >=20
> > Only allow system calls that are needed by virtiofsd.  All other system
> > calls cause SIGSYS to be directed at the thread and the process will
> > coredump.
> >=20
> > Restricting system calls reduces the kernel attack surface and limits
> > what the process can do when compromised.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > with additional entries by:
> > Signed-off-by: Ganesh Maharaj Mahalingam <ganesh.mahalingam@intel.com>
> > Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
> > Signed-off-by: piaojun <piaojun@huawei.com>
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > Signed-off-by: Eric Ren <renzhen@linux.alibaba.com>
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >   Makefile                         |   2 +-
> >   tools/virtiofsd/Makefile.objs    |   5 +-
> >   tools/virtiofsd/passthrough_ll.c |   2 +
> >   tools/virtiofsd/seccomp.c        | 150 ++++++++++++++++++++++++++++++=
+
> >   tools/virtiofsd/seccomp.h        |  14 +++
> >   5 files changed, 171 insertions(+), 2 deletions(-)
> >   create mode 100644 tools/virtiofsd/seccomp.c
> >   create mode 100644 tools/virtiofsd/seccomp.h
> >=20
> > diff --git a/Makefile b/Makefile
> > index a87e06ad93..967d59c98a 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -327,7 +327,7 @@ HELPERS-y +=3D vhost-user-gpu$(EXESUF)
> >   vhost-user-json-y +=3D contrib/vhost-user-gpu/50-qemu-gpu.json
> >   endif
> > -ifdef CONFIG_LINUX
> > +ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP),yy)
> >   HELPERS-y +=3D virtiofsd$(EXESUF)
>=20
> Something is weird here, because I got:
>=20
> $ make virtiofsd
>   ...
>   CC      tools/virtiofsd/seccomp.o
> tools/virtiofsd/seccomp.c:14:21: fatal error: seccomp.h: No such file or
> directory
>  #include <seccomp.h>
>                      ^
>=20
> Indeed I don't have libseccomp installed, ./configure reported:
>=20
> ...
> QGA MSI support   no
> seccomp support   no
> coroutine backend ucontext
> coroutine pool    yes
> debug stack usage no
> ...
>=20
> Note also:
>=20
> $ make print-CONFIG_LINUX
> CONFIG_LINUX=3Dy
> $ make print-CONFIG_SECCOMP
> CONFIG_SECCOMP=3D
> $ make print-CONFIG_LIBCAP_NG
> CONFIG_LIBCAP_NG=3Dy
> $ make print-HELPERS-y
> HELPERS-y=3Dqemu-bridge-helper

The same thing happens if you uninstall mesa-libgbm-devel and do a
'make vhost-user-gpu'

These ifeq's don't remove the definition of the target, they just remove
it from the HELPERS-y list, so stop it being built on an unqualified
'make' but don't change the behaviour when you explicitly ask for the
target.

Can you try:

diff --git a/Makefile b/Makefile
index ba7e2e5ebc..346a981f0e 100644
--- a/Makefile
+++ b/Makefile
@@ -676,8 +676,9 @@ vhost-user-blk$(EXESUF): $(vhost-user-blk-obj-y) libvho=
st-user.a
 rdmacm-mux$(EXESUF): LIBS +=3D "-libumad"
 rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
        $(call LINK, $^)
-
-ifdef CONFIG_LINUX # relies on Linux-specific syscalls
+#
+# relies on Linux specific syscalls
+ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
 virtiofsd$(EXESUF): $(virtiofsd-obj-y) libvhost-user.a $(COMMON_LDADDS)
        $(call LINK, $^)
 endif


> >   vhost-user-json-y +=3D tools/virtiofsd/50-qemu-virtiofsd.json
> >   endif
> > diff --git a/tools/virtiofsd/Makefile.objs b/tools/virtiofsd/Makefile.o=
bjs
> > index 45a807500d..076f667e46 100644
> > --- a/tools/virtiofsd/Makefile.objs
> > +++ b/tools/virtiofsd/Makefile.objs
> > @@ -5,5 +5,8 @@ virtiofsd-obj-y =3D buffer.o \
> >                     fuse_signals.o \
> >                     fuse_virtio.o \
> >                     helper.o \
> > -                  passthrough_ll.o
> > +                  passthrough_ll.o \
> > +                  seccomp.o
> > +seccomp.o-cflags :=3D $(SECCOMP_CFLAGS)
> > +seccomp.o-libs :=3D $(SECCOMP_LIBS)
> > diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthr=
ough_ll.c
> > index 752beb459a..8748e64f33 100644
> > --- a/tools/virtiofsd/passthrough_ll.c
> > +++ b/tools/virtiofsd/passthrough_ll.c
> > @@ -58,6 +58,7 @@
> >   #include <unistd.h>
> >   #include "passthrough_helpers.h"
> > +#include "seccomp.h"
> >   struct lo_map_elem {
> >       union {
> > @@ -2090,6 +2091,7 @@ static void setup_sandbox(struct lo_data *lo, str=
uct fuse_session *se)
> >   {
> >       setup_namespaces(lo, se);
> >       setup_mounts(lo->source);
> > +    setup_seccomp();
> >   }
> >   int main(int argc, char *argv[])
> > diff --git a/tools/virtiofsd/seccomp.c b/tools/virtiofsd/seccomp.c
> > new file mode 100644
> > index 0000000000..2aa4d3cc66
> > --- /dev/null
> > +++ b/tools/virtiofsd/seccomp.c
> > @@ -0,0 +1,150 @@
> > +/*
> > + * Seccomp sandboxing for virtiofsd
> > + *
> > + * Copyright (C) 2019 Red Hat, Inc.
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#include "seccomp.h"
> > +#include "fuse_i.h"
> > +#include "fuse_log.h"
> > +#include <errno.h>
> > +#include <glib.h>
> > +#include <seccomp.h>
> > +#include <stdlib.h>
> > +
> > +/* Bodge for libseccomp 2.4.2 which broke ppoll */
> > +#if !defined(__SNR_ppoll) && defined(__SNR_brk)
> > +#ifdef __NR_ppoll
> > +#define __SNR_ppoll __NR_ppoll
> > +#else
> > +#define __SNR_ppoll __PNR_ppoll
> > +#endif
> > +#endif
> > +
> > +static const int syscall_whitelist[] =3D {
> > +    /* TODO ireg sem*() syscalls */
> > +    SCMP_SYS(brk),
> > +    SCMP_SYS(capget), /* For CAP_FSETID */
> > +    SCMP_SYS(capset),
> > +    SCMP_SYS(clock_gettime),
> > +    SCMP_SYS(clone),
> > +#ifdef __NR_clone3
> > +    SCMP_SYS(clone3),
> > +#endif
> > +    SCMP_SYS(close),
> > +    SCMP_SYS(copy_file_range),
> > +    SCMP_SYS(dup),
> > +    SCMP_SYS(eventfd2),
> > +    SCMP_SYS(exit),
> > +    SCMP_SYS(exit_group),
> > +    SCMP_SYS(fallocate),
> > +    SCMP_SYS(fchmodat),
> > +    SCMP_SYS(fchownat),
> > +    SCMP_SYS(fcntl),
> > +    SCMP_SYS(fdatasync),
> > +    SCMP_SYS(fgetxattr),
> > +    SCMP_SYS(flistxattr),
> > +    SCMP_SYS(flock),
> > +    SCMP_SYS(fremovexattr),
> > +    SCMP_SYS(fsetxattr),
> > +    SCMP_SYS(fstat),
> > +    SCMP_SYS(fstatfs),
> > +    SCMP_SYS(fsync),
> > +    SCMP_SYS(ftruncate),
> > +    SCMP_SYS(futex),
> > +    SCMP_SYS(getdents),
> > +    SCMP_SYS(getdents64),
> > +    SCMP_SYS(getegid),
> > +    SCMP_SYS(geteuid),
> > +    SCMP_SYS(getpid),
> > +    SCMP_SYS(gettid),
> > +    SCMP_SYS(gettimeofday),
> > +    SCMP_SYS(linkat),
> > +    SCMP_SYS(lseek),
> > +    SCMP_SYS(madvise),
> > +    SCMP_SYS(mkdirat),
> > +    SCMP_SYS(mknodat),
> > +    SCMP_SYS(mmap),
> > +    SCMP_SYS(mprotect),
> > +    SCMP_SYS(mremap),
> > +    SCMP_SYS(munmap),
> > +    SCMP_SYS(newfstatat),
> > +    SCMP_SYS(open),
> > +    SCMP_SYS(openat),
> > +    SCMP_SYS(ppoll),
> > +    SCMP_SYS(prctl), /* TODO restrict to just PR_SET_NAME? */
> > +    SCMP_SYS(preadv),
> > +    SCMP_SYS(pread64),
> > +    SCMP_SYS(pwritev),
> > +    SCMP_SYS(pwrite64),
> > +    SCMP_SYS(read),
> > +    SCMP_SYS(readlinkat),
> > +    SCMP_SYS(recvmsg),
> > +    SCMP_SYS(renameat),
> > +    SCMP_SYS(renameat2),
> > +    SCMP_SYS(rt_sigaction),
> > +    SCMP_SYS(rt_sigprocmask),
> > +    SCMP_SYS(rt_sigreturn),
> > +    SCMP_SYS(sendmsg),
> > +    SCMP_SYS(setresgid),
> > +    SCMP_SYS(setresuid),
> > +#ifdef __NR_setresgid32
> > +    SCMP_SYS(setresgid32),
> > +#endif
> > +#ifdef __NR_setresuid32
> > +    SCMP_SYS(setresuid32),
> > +#endif
> > +    SCMP_SYS(set_robust_list),
> > +    SCMP_SYS(symlinkat),
> > +    SCMP_SYS(time), /* Rarely needed, except on static builds */
> > +    SCMP_SYS(tgkill),
> > +    SCMP_SYS(unlinkat),
> > +    SCMP_SYS(utimensat),
> > +    SCMP_SYS(write),
> > +    SCMP_SYS(writev),
> > +};
> > +
> > +void setup_seccomp(void)
> > +{
> > +    scmp_filter_ctx ctx;
> > +    size_t i;
> > +
> > +#ifdef SCMP_ACT_KILL_PROCESS
> > +    ctx =3D seccomp_init(SCMP_ACT_KILL_PROCESS);
> > +    /* Handle a newer libseccomp but an older kernel */
> > +    if (!ctx && errno =3D=3D EOPNOTSUPP) {
> > +        ctx =3D seccomp_init(SCMP_ACT_TRAP);
> > +    }
> > +#else
> > +    ctx =3D seccomp_init(SCMP_ACT_TRAP);
> > +#endif
> > +    if (!ctx) {
> > +        fuse_log(FUSE_LOG_ERR, "seccomp_init() failed\n");
> > +        exit(1);
> > +    }
> > +
> > +    for (i =3D 0; i < G_N_ELEMENTS(syscall_whitelist); i++) {
> > +        if (seccomp_rule_add(ctx, SCMP_ACT_ALLOW,
> > +                             syscall_whitelist[i], 0) !=3D 0) {
> > +            fuse_log(FUSE_LOG_ERR, "seccomp_rule_add syscall %d",
> > +                     syscall_whitelist[i]);
> > +            exit(1);
> > +        }
> > +    }
> > +
> > +    /* libvhost-user calls this for post-copy migration, we don't need=
 it */
> > +    if (seccomp_rule_add(ctx, SCMP_ACT_ERRNO(ENOSYS),
> > +                         SCMP_SYS(userfaultfd), 0) !=3D 0) {
> > +        fuse_log(FUSE_LOG_ERR, "seccomp_rule_add userfaultfd failed\n"=
);
> > +        exit(1);
> > +    }
> > +
> > +    if (seccomp_load(ctx) < 0) {
> > +        fuse_log(FUSE_LOG_ERR, "seccomp_load() failed\n");
> > +        exit(1);
> > +    }
> > +
> > +    seccomp_release(ctx);
> > +}
> > diff --git a/tools/virtiofsd/seccomp.h b/tools/virtiofsd/seccomp.h
> > new file mode 100644
> > index 0000000000..86bce72652
> > --- /dev/null
> > +++ b/tools/virtiofsd/seccomp.h
> > @@ -0,0 +1,14 @@
> > +/*
> > + * Seccomp sandboxing for virtiofsd
> > + *
> > + * Copyright (C) 2019 Red Hat, Inc.
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#ifndef VIRTIOFSD_SECCOMP_H
> > +#define VIRTIOFSD_SECCOMP_H
> > +
> > +void setup_seccomp(void);
> > +
> > +#endif /* VIRTIOFSD_SECCOMP_H */
> >=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


