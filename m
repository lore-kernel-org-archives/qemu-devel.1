Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CF8C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 15:55:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9BAE2073A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 15:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZR0sxUML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9BAE2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itvsY-0002ru-SX
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 10:55:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itvrh-0002KS-Du
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:54:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itvrd-0002W2-5Q
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:54:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31074
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itvrc-0002Vo-Uh
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:54:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579622088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4yvgPzOHElh+bWN5gFGsuirmCoXBat7wDxocb+WB/jQ=;
 b=ZR0sxUMLMhSkG2cPT6K9V7F/19xXf5g3sHqMud7jf+4o/rr055QJau5LVT+TqP39eBVR+u
 aip+aLGbxpOrlewPZpewaZPC90oAC+5I30YDYhz9dTo5KnhGQQsQjk1M8FuV2Ktfenm830
 SAs4oLsOFtRnJHrDUPS6fI9WpuwIzoo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-5v99KJzZO2yT_z2xtVpMaA-1; Tue, 21 Jan 2020 10:54:44 -0500
Received: by mail-wm1-f72.google.com with SMTP id t4so787148wmf.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 07:54:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4yvgPzOHElh+bWN5gFGsuirmCoXBat7wDxocb+WB/jQ=;
 b=CWJynsWCvxlI8ZZiaMXFyi2xOot32M2CjSHvSO9HIizxmEfhV0S6e2bvsoE97NoYan
 uzjNn+p+gvy1KTdYOepFX5KekplK5rwBgGoZEEB4GC+3B+hfxWgMhuMC+k8FR1jsW+xI
 xTorKqcugVNbRMthHpkquurUdYxhwXD/PMtAhV5NBjgdrlMTdbLYQ+riBC5harByfPgw
 s0y5XORn/sEVPrRIWqIeMB+QMx+mvIAPPkds3p+JF8Wy4q874T1sbQAcLRHjU19JTSaN
 jOaBUx16vOEPSmy0TzDjXVsbbKbbLmF9pIvZb2WPSEBJeDE12p519QM1UTHCjX/K8HfV
 NPrA==
X-Gm-Message-State: APjAAAXZ01K6Y0ZJZ/mU9csuxGdCd+ama0AWKg/cMadgDdW1h830hwL4
 ITmX4+HZoogWsbTJOOdurvz6HOPg08wrv0gPanymQsJ+fZ74KmXpDyL12KJwtL3EwJCtnBZoKY5
 qptnIErtCbM8zit8=
X-Received: by 2002:a5d:6191:: with SMTP id j17mr5578575wru.427.1579622083274; 
 Tue, 21 Jan 2020 07:54:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqxFu5QrJJVNRJy8Avl1YFiTFc1LuZzaM1CkuVZydU6rH5mWsmNMdX7JSQuNj9BgyazAABtO7w==
X-Received: by 2002:a5d:6191:: with SMTP id j17mr5578551wru.427.1579622082840; 
 Tue, 21 Jan 2020 07:54:42 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id t131sm4707925wmb.13.2020.01.21.07.54.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2020 07:54:42 -0800 (PST)
Subject: Re: [PATCH v2 051/109] virtiofsd: add seccomp whitelist
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, slp@redhat.com
References: <20200121122433.50803-1-dgilbert@redhat.com>
 <20200121122433.50803-52-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ba916575-1496-8c3d-a568-573ebb07d4ec@redhat.com>
Date: Tue, 21 Jan 2020 16:54:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200121122433.50803-52-dgilbert@redhat.com>
Content-Language: en-US
X-MC-Unique: 5v99KJzZO2yT_z2xtVpMaA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: m.mizuma@jp.fujitsu.com, misono.tomohiro@jp.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/21/20 1:23 PM, Dr. David Alan Gilbert (git) wrote:
> From: Stefan Hajnoczi <stefanha@redhat.com>
> 
> Only allow system calls that are needed by virtiofsd.  All other system
> calls cause SIGSYS to be directed at the thread and the process will
> coredump.
> 
> Restricting system calls reduces the kernel attack surface and limits
> what the process can do when compromised.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> with additional entries by:
> Signed-off-by: Ganesh Maharaj Mahalingam <ganesh.mahalingam@intel.com>
> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
> Signed-off-by: piaojun <piaojun@huawei.com>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> Signed-off-by: Eric Ren <renzhen@linux.alibaba.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>   Makefile                         |   2 +-
>   tools/virtiofsd/Makefile.objs    |   5 +-
>   tools/virtiofsd/passthrough_ll.c |   2 +
>   tools/virtiofsd/seccomp.c        | 150 +++++++++++++++++++++++++++++++
>   tools/virtiofsd/seccomp.h        |  14 +++
>   5 files changed, 171 insertions(+), 2 deletions(-)
>   create mode 100644 tools/virtiofsd/seccomp.c
>   create mode 100644 tools/virtiofsd/seccomp.h
> 
> diff --git a/Makefile b/Makefile
> index a87e06ad93..967d59c98a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -327,7 +327,7 @@ HELPERS-y += vhost-user-gpu$(EXESUF)
>   vhost-user-json-y += contrib/vhost-user-gpu/50-qemu-gpu.json
>   endif
>   
> -ifdef CONFIG_LINUX
> +ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP),yy)
>   HELPERS-y += virtiofsd$(EXESUF)

Something is weird here, because I got:

$ make virtiofsd
   ...
   CC      tools/virtiofsd/seccomp.o
tools/virtiofsd/seccomp.c:14:21: fatal error: seccomp.h: No such file or 
directory
  #include <seccomp.h>
                      ^

Indeed I don't have libseccomp installed, ./configure reported:

...
QGA MSI support   no
seccomp support   no
coroutine backend ucontext
coroutine pool    yes
debug stack usage no
...

Note also:

$ make print-CONFIG_LINUX
CONFIG_LINUX=y
$ make print-CONFIG_SECCOMP
CONFIG_SECCOMP=
$ make print-CONFIG_LIBCAP_NG
CONFIG_LIBCAP_NG=y
$ make print-HELPERS-y
HELPERS-y=qemu-bridge-helper

>   vhost-user-json-y += tools/virtiofsd/50-qemu-virtiofsd.json
>   endif
> diff --git a/tools/virtiofsd/Makefile.objs b/tools/virtiofsd/Makefile.objs
> index 45a807500d..076f667e46 100644
> --- a/tools/virtiofsd/Makefile.objs
> +++ b/tools/virtiofsd/Makefile.objs
> @@ -5,5 +5,8 @@ virtiofsd-obj-y = buffer.o \
>                     fuse_signals.o \
>                     fuse_virtio.o \
>                     helper.o \
> -                  passthrough_ll.o
> +                  passthrough_ll.o \
> +                  seccomp.o
>   
> +seccomp.o-cflags := $(SECCOMP_CFLAGS)
> +seccomp.o-libs := $(SECCOMP_LIBS)
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> index 752beb459a..8748e64f33 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -58,6 +58,7 @@
>   #include <unistd.h>
>   
>   #include "passthrough_helpers.h"
> +#include "seccomp.h"
>   
>   struct lo_map_elem {
>       union {
> @@ -2090,6 +2091,7 @@ static void setup_sandbox(struct lo_data *lo, struct fuse_session *se)
>   {
>       setup_namespaces(lo, se);
>       setup_mounts(lo->source);
> +    setup_seccomp();
>   }
>   
>   int main(int argc, char *argv[])
> diff --git a/tools/virtiofsd/seccomp.c b/tools/virtiofsd/seccomp.c
> new file mode 100644
> index 0000000000..2aa4d3cc66
> --- /dev/null
> +++ b/tools/virtiofsd/seccomp.c
> @@ -0,0 +1,150 @@
> +/*
> + * Seccomp sandboxing for virtiofsd
> + *
> + * Copyright (C) 2019 Red Hat, Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "seccomp.h"
> +#include "fuse_i.h"
> +#include "fuse_log.h"
> +#include <errno.h>
> +#include <glib.h>
> +#include <seccomp.h>
> +#include <stdlib.h>
> +
> +/* Bodge for libseccomp 2.4.2 which broke ppoll */
> +#if !defined(__SNR_ppoll) && defined(__SNR_brk)
> +#ifdef __NR_ppoll
> +#define __SNR_ppoll __NR_ppoll
> +#else
> +#define __SNR_ppoll __PNR_ppoll
> +#endif
> +#endif
> +
> +static const int syscall_whitelist[] = {
> +    /* TODO ireg sem*() syscalls */
> +    SCMP_SYS(brk),
> +    SCMP_SYS(capget), /* For CAP_FSETID */
> +    SCMP_SYS(capset),
> +    SCMP_SYS(clock_gettime),
> +    SCMP_SYS(clone),
> +#ifdef __NR_clone3
> +    SCMP_SYS(clone3),
> +#endif
> +    SCMP_SYS(close),
> +    SCMP_SYS(copy_file_range),
> +    SCMP_SYS(dup),
> +    SCMP_SYS(eventfd2),
> +    SCMP_SYS(exit),
> +    SCMP_SYS(exit_group),
> +    SCMP_SYS(fallocate),
> +    SCMP_SYS(fchmodat),
> +    SCMP_SYS(fchownat),
> +    SCMP_SYS(fcntl),
> +    SCMP_SYS(fdatasync),
> +    SCMP_SYS(fgetxattr),
> +    SCMP_SYS(flistxattr),
> +    SCMP_SYS(flock),
> +    SCMP_SYS(fremovexattr),
> +    SCMP_SYS(fsetxattr),
> +    SCMP_SYS(fstat),
> +    SCMP_SYS(fstatfs),
> +    SCMP_SYS(fsync),
> +    SCMP_SYS(ftruncate),
> +    SCMP_SYS(futex),
> +    SCMP_SYS(getdents),
> +    SCMP_SYS(getdents64),
> +    SCMP_SYS(getegid),
> +    SCMP_SYS(geteuid),
> +    SCMP_SYS(getpid),
> +    SCMP_SYS(gettid),
> +    SCMP_SYS(gettimeofday),
> +    SCMP_SYS(linkat),
> +    SCMP_SYS(lseek),
> +    SCMP_SYS(madvise),
> +    SCMP_SYS(mkdirat),
> +    SCMP_SYS(mknodat),
> +    SCMP_SYS(mmap),
> +    SCMP_SYS(mprotect),
> +    SCMP_SYS(mremap),
> +    SCMP_SYS(munmap),
> +    SCMP_SYS(newfstatat),
> +    SCMP_SYS(open),
> +    SCMP_SYS(openat),
> +    SCMP_SYS(ppoll),
> +    SCMP_SYS(prctl), /* TODO restrict to just PR_SET_NAME? */
> +    SCMP_SYS(preadv),
> +    SCMP_SYS(pread64),
> +    SCMP_SYS(pwritev),
> +    SCMP_SYS(pwrite64),
> +    SCMP_SYS(read),
> +    SCMP_SYS(readlinkat),
> +    SCMP_SYS(recvmsg),
> +    SCMP_SYS(renameat),
> +    SCMP_SYS(renameat2),
> +    SCMP_SYS(rt_sigaction),
> +    SCMP_SYS(rt_sigprocmask),
> +    SCMP_SYS(rt_sigreturn),
> +    SCMP_SYS(sendmsg),
> +    SCMP_SYS(setresgid),
> +    SCMP_SYS(setresuid),
> +#ifdef __NR_setresgid32
> +    SCMP_SYS(setresgid32),
> +#endif
> +#ifdef __NR_setresuid32
> +    SCMP_SYS(setresuid32),
> +#endif
> +    SCMP_SYS(set_robust_list),
> +    SCMP_SYS(symlinkat),
> +    SCMP_SYS(time), /* Rarely needed, except on static builds */
> +    SCMP_SYS(tgkill),
> +    SCMP_SYS(unlinkat),
> +    SCMP_SYS(utimensat),
> +    SCMP_SYS(write),
> +    SCMP_SYS(writev),
> +};
> +
> +void setup_seccomp(void)
> +{
> +    scmp_filter_ctx ctx;
> +    size_t i;
> +
> +#ifdef SCMP_ACT_KILL_PROCESS
> +    ctx = seccomp_init(SCMP_ACT_KILL_PROCESS);
> +    /* Handle a newer libseccomp but an older kernel */
> +    if (!ctx && errno == EOPNOTSUPP) {
> +        ctx = seccomp_init(SCMP_ACT_TRAP);
> +    }
> +#else
> +    ctx = seccomp_init(SCMP_ACT_TRAP);
> +#endif
> +    if (!ctx) {
> +        fuse_log(FUSE_LOG_ERR, "seccomp_init() failed\n");
> +        exit(1);
> +    }
> +
> +    for (i = 0; i < G_N_ELEMENTS(syscall_whitelist); i++) {
> +        if (seccomp_rule_add(ctx, SCMP_ACT_ALLOW,
> +                             syscall_whitelist[i], 0) != 0) {
> +            fuse_log(FUSE_LOG_ERR, "seccomp_rule_add syscall %d",
> +                     syscall_whitelist[i]);
> +            exit(1);
> +        }
> +    }
> +
> +    /* libvhost-user calls this for post-copy migration, we don't need it */
> +    if (seccomp_rule_add(ctx, SCMP_ACT_ERRNO(ENOSYS),
> +                         SCMP_SYS(userfaultfd), 0) != 0) {
> +        fuse_log(FUSE_LOG_ERR, "seccomp_rule_add userfaultfd failed\n");
> +        exit(1);
> +    }
> +
> +    if (seccomp_load(ctx) < 0) {
> +        fuse_log(FUSE_LOG_ERR, "seccomp_load() failed\n");
> +        exit(1);
> +    }
> +
> +    seccomp_release(ctx);
> +}
> diff --git a/tools/virtiofsd/seccomp.h b/tools/virtiofsd/seccomp.h
> new file mode 100644
> index 0000000000..86bce72652
> --- /dev/null
> +++ b/tools/virtiofsd/seccomp.h
> @@ -0,0 +1,14 @@
> +/*
> + * Seccomp sandboxing for virtiofsd
> + *
> + * Copyright (C) 2019 Red Hat, Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef VIRTIOFSD_SECCOMP_H
> +#define VIRTIOFSD_SECCOMP_H
> +
> +void setup_seccomp(void);
> +
> +#endif /* VIRTIOFSD_SECCOMP_H */
> 


