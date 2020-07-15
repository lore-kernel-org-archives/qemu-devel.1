Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731F0C433E4
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 22:09:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3720D2065F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 22:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LFw4EeTO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3720D2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvpb3-0006uY-EB
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 18:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cdupontd@redhat.com>)
 id 1jvpaU-0006VT-LT
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 18:09:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49774
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cdupontd@redhat.com>)
 id 1jvpaR-0004vP-Mk
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 18:09:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594850949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6lDzg2tnLJ9OZ/Fxw8x+tGLZweJbgIrUzMUexvb9Pnc=;
 b=LFw4EeTO4VzhFSFm7RaSo+k1zrI8oJj3CJTXscCytTf5vzYlprhMH54kCbpNQJDXBUrATX
 O6/XG18DKtqLIxlLpgLOLgclhMQshtvvQTFFVbivcxymV1a27Fcwa+rTAKdxF16mTyiCyk
 j/a6i2eldTZKExUZXEr7XXF798KTDqs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-c24cgqz8MRiLko13wjrbqg-1; Wed, 15 Jul 2020 18:09:05 -0400
X-MC-Unique: c24cgqz8MRiLko13wjrbqg-1
Received: by mail-wm1-f70.google.com with SMTP id g138so2407035wme.7
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 15:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=6lDzg2tnLJ9OZ/Fxw8x+tGLZweJbgIrUzMUexvb9Pnc=;
 b=JdNSPuBYCHQxYbhs4D2aaE6vX4htH//xoGjqocJZ9dC/6Vb6YB76fb9oN+84svllif
 8SZV7XeQxkNDdBx6PklXHcTbe4uh0gvDXZKfDJihEobFmap44EClmXVCrkupuhioPsAC
 Abh9LJQJDubwEC63l9JlLzifOA5Pv8KTnoKS6AKX6qyKlBTwDP/NCuzaxddgD5Abe5vr
 okIoeVl5pcn24g4ZHK2oXW3N4SQiaGqhNMIpUnQn6BBvLzmiV8VwbzzJbsE+Pm+8AkA3
 zfcTEep7cMnOlP0RD8DMH+lAAZ5lvRiSRwm31Ywedl7ue8njOcGhrQUSlv8ZT40PpsCF
 Sufg==
X-Gm-Message-State: AOAM5316NWXq4MXPombDrpTFI4ia9Sdba7egj3vMNf8xrOP/BQb/MYSp
 50SeuUUxy+a6HeBiFzVfIF7q6Ynqa42NzBWjnkoAwZ5XWDmrDKxtwjrb5du71PaOsX4kNXEclGM
 hcLsrQ03aYmAgGzM=
X-Received: by 2002:adf:c986:: with SMTP id f6mr1760543wrh.168.1594850943548; 
 Wed, 15 Jul 2020 15:09:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMk3644isf2iLNLkomvbXy9UKqBNAcAaiyd/W1FIhTqpnzo5of+OdhJWXOVvBqrHFICLoQ+A==
X-Received: by 2002:adf:c986:: with SMTP id f6mr1760513wrh.168.1594850943170; 
 Wed, 15 Jul 2020 15:09:03 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:466:71c0:860:fcaf:c937:d7cb?
 ([2a01:e0a:466:71c0:860:fcaf:c937:d7cb])
 by smtp.gmail.com with ESMTPSA id z6sm5065027wmf.33.2020.07.15.15.09.02
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Jul 2020 15:09:02 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: build: haiky system build fix
From: Christophe de Dinechin <cdupontd@redhat.com>
In-Reply-To: <CA+XhMqyTLP5_Jf=t8OCsMifrme0DgimM8-D=Y0RRR+779052Bg@mail.gmail.com>
Date: Thu, 16 Jul 2020 00:09:01 +0200
Message-Id: <5834A3E7-BB4D-4F5F-8D24-268C32EE0506@redhat.com>
References: <CA+XhMqyTLP5_Jf=t8OCsMifrme0DgimM8-D=Y0RRR+779052Bg@mail.gmail.com>
To: David CARLIER <devnexen@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cdupontd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 18:09:09
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

nit: typo in the mail subject (haiky instead of haiku)

> On 25 Jun 2020, at 20:36, David CARLIER <devnexen@gmail.com> wrote:
> 
> From 25adbdcdc17ef51a41759f16576901338ed8a469 Mon Sep 17 00:00:00 2001
> From: David Carlier <devnexen@gmail.com>
> Date: Thu, 25 Jun 2020 19:32:42 +0000
> Subject: [PATCH] build: haiku system build fix
> 
> Most of missing features resides in the bsd library.
> Also defining constant equivalence.
> 
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
> configure            |  4 ++--
> include/qemu/bswap.h |  2 ++
> os-posix.c           |  4 ++++
> util/compatfd.c      |  2 ++
> util/drm.c           |  2 ++
> util/main-loop.c     |  3 +++
> util/oslib-posix.c   | 20 ++++++++++++++++++++
> util/qemu-openpty.c  |  2 +-
> 8 files changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/configure b/configure
> index ba88fd1824..3732ad4e35 100755
> --- a/configure
> +++ b/configure
> @@ -901,8 +901,8 @@ SunOS)
> ;;
> Haiku)
>   haiku="yes"
> -  QEMU_CFLAGS="-DB_USE_POSITIVE_POSIX_ERRORS $QEMU_CFLAGS"
> -  LIBS="-lposix_error_mapper -lnetwork $LIBS"
> +  QEMU_CFLAGS="-DB_USE_POSITIVE_POSIX_ERRORS -D_BSD_SOURCE $QEMU_CFLAGS"
> +  LIBS="-lposix_error_mapper -lnetwork -lbsd $LIBS"
> ;;
> Linux)
>   audio_drv_list="try-pa oss"
> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> index 2a9f3fe783..1d3e4c24e4 100644
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -8,6 +8,8 @@
> # include <machine/bswap.h>
> #elif defined(__FreeBSD__)
> # include <sys/endian.h>
> +#elif defined(__HAIKU__)
> +# include <endian.h>
> #elif defined(CONFIG_BYTESWAP_H)
> # include <byteswap.h>
> 
> diff --git a/os-posix.c b/os-posix.c
> index 3cd52e1e70..ca07b7702d 100644
> --- a/os-posix.c
> +++ b/os-posix.c
> @@ -42,6 +42,8 @@
> #include <sys/prctl.h>
> #endif
> 
> +#include <sys/mman.h>
> +
> /*
>  * Must set all three of these at once.
>  * Legal combinations are              unset   by name   by uid
> @@ -339,10 +341,12 @@ int os_mlock(void)
> {
>     int ret = 0;
> 
> +#if !defined(__HAIKU__)
>     ret = mlockall(MCL_CURRENT | MCL_FUTURE);
>     if (ret < 0) {
>         error_report("mlockall: %s", strerror(errno));
>     }
> 
> +#endif
>     return ret;
> }
> diff --git a/util/compatfd.c b/util/compatfd.c
> index c296f55d14..ee47dd8089 100644
> --- a/util/compatfd.c
> +++ b/util/compatfd.c
> @@ -16,7 +16,9 @@
> #include "qemu/osdep.h"
> #include "qemu/thread.h"
> 
> +#if defined(CONFIG_SIGNALFD)
> #include <sys/syscall.h>
> +#endif
> 
> struct sigfd_compat_info
> {
> diff --git a/util/drm.c b/util/drm.c
> index a23ff24538..8540578c09 100644
> --- a/util/drm.c
> +++ b/util/drm.c
> @@ -38,9 +38,11 @@ int qemu_drm_rendernode_open(const char *rendernode)
> 
>     fd = -1;
>     while ((e = readdir(dir))) {
> +#if !defined(__HAIKU__)
>         if (e->d_type != DT_CHR) {
>             continue;
>         }
> +#endif
> 
>         if (strncmp(e->d_name, "renderD", 7)) {
>             continue;
> diff --git a/util/main-loop.c b/util/main-loop.c
> index eda63fe4e0..1ce3081ced 100644
> --- a/util/main-loop.c
> +++ b/util/main-loop.c
> @@ -85,6 +85,9 @@ static int qemu_signal_init(Error **errp)
>      * by sigwait() in the signal thread. Otherwise, the cpu thread will
>      * not catch it reliably.
>      */
> +#ifndef SIGIO
> +#define SIGIO SIGPOLL
> +#endif
>     sigemptyset(&set);
>     sigaddset(&set, SIG_IPI);
>     sigaddset(&set, SIGIO);
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 39ddc77c85..a18d90a68a 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -38,7 +38,12 @@
> #include "qemu/sockets.h"
> #include "qemu/thread.h"
> #include <libgen.h>
> +#if !defined(__HAIKU__)
> #include <sys/signal.h>
> +#else
> +#include <kernel/image.h>
> +#include <signal.h>
> +#endif
> #include "qemu/cutils.h"
> 
> #ifdef CONFIG_LINUX
> @@ -390,6 +395,21 @@ void qemu_init_exec_dir(const char *argv0)
>             }
>         }
>     }
> +#elif defined(__HAIKU__)
> +    {
> +        image_info ii;
> +        int32_t c = 0;
> +
> +    *buf = '\0';
> +    while (get_next_image_info(0, &c, &ii) == B_OK) {
> +            if (ii.type == B_APP_IMAGE) {
> +                strncpy(buf, ii.name, sizeof(buf));
> +            buf[sizeof(buf) - 1] = '\0';
> +        p = buf;
> +                break;
> +            }
> +        }
> +    }
> #endif
>     /* If we don't have any way of figuring out the actual executable
>        location then try argv[0].  */
> diff --git a/util/qemu-openpty.c b/util/qemu-openpty.c
> index 2e8b43bdf5..c29fc2cbf9 100644
> --- a/util/qemu-openpty.c
> +++ b/util/qemu-openpty.c
> @@ -35,7 +35,7 @@
> #include "qemu/osdep.h"
> #include "qemu-common.h"
> 
> -#if defined(__GLIBC__)
> +#if defined(__GLIBC__) || defined(__HAIKU__)
> # include <pty.h>
> #elif defined CONFIG_BSD
> # include <termios.h>
> -- 
> 2.26.0
> 


