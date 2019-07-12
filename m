Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E74DC742D6
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:50:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E64E204FD
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOKGSu/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E64E204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlzgz-0004hT-Gm
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 13:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43506)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hlzgo-0004HD-6g
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:50:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hlzgm-0002Yv-Lk
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:50:34 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39806)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1hlzgm-0002X7-Dk
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:50:32 -0400
Received: by mail-wm1-x342.google.com with SMTP id z23so5493684wma.4
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 10:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=qskT706SBWedTHKAuSRPZQCg2VRklUMaZQv6iRLaumg=;
 b=oOKGSu/hf63YkWB08PAPRJhcvNwc+0HeNPWWY4ckDqMdJt11vMUhbsFrH/sHBxhIXr
 Gt2R7VPZwuycs6gGNujNivOxL9WV43fv8rqCdtK/aYxVvcyI3Yo/n8FkYg1YWYE01S2p
 ohxWp1XPyNJVRkxH4/c0zadJoTpHRM0SLl3fi0uY4cGeX+SpS/gvovzZDY4e6VYV2/EL
 iykMWYjt58bujE1qa6BS2tYGIiWUOK/7EPZSt5/w4KD1DdMPCTvVF/CLTuAdRsbVDXND
 v/Qiuo7uoC3ix/0Gk/531uSd+gE6zlmDE+xb7LyV4UzWk9NwJAUpGsxSVqpmUg7dUAuy
 gwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qskT706SBWedTHKAuSRPZQCg2VRklUMaZQv6iRLaumg=;
 b=JKMPry949VxJ3xS4rehwTNio6a+8Adci5gL175mFI7rMQEtoflMqNzTcVrLZaBs6pH
 kkjbup+koObq2KHDxQjZyN1ANwYcJcROKOB4mS99+0ENkrZP71JHfQlVCucDwkKloZWT
 SzioUEPiDRX9LXdymwfe+f5M3zxdxSB91uIR3ntdYVvDOSJFrgBjP9xfYy1XzEaK8SPz
 MDe6QQLIpDSoanB1jZHt+lKTh7jNGGh+nOUUlaHqqXptiyO2I0LQE0w35luPBiOUEFTZ
 n0yGHg1pH/hwJ6bGPxawvZ3lReawadMMjDQ0uFUXuZZNRuozIyZmtfkef6/qBhy7PPdC
 4XRg==
X-Gm-Message-State: APjAAAXs7JRvvhEv1JdDArAIU2LuAeSAM8gFWHisJAK688gK4s5t3trD
 FbBXuEl4yWlhMteLIjBpd39Kxn4hve5HhnQWGgA=
X-Google-Smtp-Source: APXvYqyzocZfKrNyDZ2LvfrMtns3d9UWwU9KckQHUKWB8BGajxi5YBLv8Qsyyohsg/qPtuHkOs6xnMcF99HOws+A+Lo=
X-Received: by 2002:a05:600c:206:: with SMTP id
 6mr10626189wmi.91.1562953831017; 
 Fri, 12 Jul 2019 10:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <1562952875-53702-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1562952875-53702-1-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 12 Jul 2019 21:50:19 +0400
Message-ID: <CAJ+F1CKogam_S7=XzEQGMXJ4rDGyfvB6_twbyScp4g-C4CEBMw@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH] util: merge main-loop.c and iohandler.c
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
Cc: QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 12, 2019 at 9:34 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> main-loop.c has a dependency on iohandler.c, and everything breaks
> if that dependency is instead satisfied by stubs/iohandler.c.
> Just put everything in the same file to avoid strange dependencies
> on the order of files in util-obj-y.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

that can help indeed, thanks Paolo

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  util/Makefile.objs |   2 +-
>  util/iohandler.c   | 135 -----------------------------------------------=
------
>  util/main-loop.c   | 110 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 111 insertions(+), 136 deletions(-)
>  delete mode 100644 util/iohandler.c
>
> diff --git a/util/Makefile.objs b/util/Makefile.objs
> index 3817820..a817ced 100644
> --- a/util/Makefile.objs
> +++ b/util/Makefile.objs
> @@ -2,7 +2,7 @@ util-obj-y =3D osdep.o cutils.o unicode.o qemu-timer-comm=
on.o
>  util-obj-y +=3D bufferiszero.o
>  util-obj-y +=3D lockcnt.o
>  util-obj-y +=3D aiocb.o async.o aio-wait.o thread-pool.o qemu-timer.o
> -util-obj-y +=3D main-loop.o iohandler.o
> +util-obj-y +=3D main-loop.o
>  main-loop.o-cflags :=3D $(SLIRP_CFLAGS)
>  util-obj-$(call lnot,$(CONFIG_ATOMIC64)) +=3D atomic64.o
>  util-obj-$(CONFIG_POSIX) +=3D aio-posix.o
> diff --git a/util/iohandler.c b/util/iohandler.c
> deleted file mode 100644
> index bece882..0000000
> --- a/util/iohandler.c
> +++ /dev/null
> @@ -1,135 +0,0 @@
> -/*
> - * QEMU System Emulator - managing I/O handler
> - *
> - * Copyright (c) 2003-2008 Fabrice Bellard
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> - * of this software and associated documentation files (the "Software"),=
 to deal
> - * in the Software without restriction, including without limitation the=
 rights
> - * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> - * copies of the Software, and to permit persons to whom the Software is
> - * furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be includ=
ed in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> - * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> - * THE SOFTWARE.
> - */
> -
> -#include "qemu/osdep.h"
> -#include "qapi/error.h"
> -#include "qemu/queue.h"
> -#include "block/aio.h"
> -#include "qemu/main-loop.h"
> -
> -#ifndef _WIN32
> -#include <sys/wait.h>
> -#endif
> -
> -/* This context runs on top of main loop. We can't reuse qemu_aio_contex=
t
> - * because iohandlers mustn't be polled by aio_poll(qemu_aio_context). *=
/
> -static AioContext *iohandler_ctx;
> -
> -static void iohandler_init(void)
> -{
> -    if (!iohandler_ctx) {
> -        iohandler_ctx =3D aio_context_new(&error_abort);
> -    }
> -}
> -
> -AioContext *iohandler_get_aio_context(void)
> -{
> -    iohandler_init();
> -    return iohandler_ctx;
> -}
> -
> -GSource *iohandler_get_g_source(void)
> -{
> -    iohandler_init();
> -    return aio_get_g_source(iohandler_ctx);
> -}
> -
> -void qemu_set_fd_handler(int fd,
> -                         IOHandler *fd_read,
> -                         IOHandler *fd_write,
> -                         void *opaque)
> -{
> -    iohandler_init();
> -    aio_set_fd_handler(iohandler_ctx, fd, false,
> -                       fd_read, fd_write, NULL, opaque);
> -}
> -
> -void event_notifier_set_handler(EventNotifier *e,
> -                                EventNotifierHandler *handler)
> -{
> -    iohandler_init();
> -    aio_set_event_notifier(iohandler_ctx, e, false,
> -                           handler, NULL);
> -}
> -
> -/* reaping of zombies.  right now we're not passing the status to
> -   anyone, but it would be possible to add a callback.  */
> -#ifndef _WIN32
> -typedef struct ChildProcessRecord {
> -    int pid;
> -    QLIST_ENTRY(ChildProcessRecord) next;
> -} ChildProcessRecord;
> -
> -static QLIST_HEAD(, ChildProcessRecord) child_watches =3D
> -    QLIST_HEAD_INITIALIZER(child_watches);
> -
> -static QEMUBH *sigchld_bh;
> -
> -static void sigchld_handler(int signal)
> -{
> -    qemu_bh_schedule(sigchld_bh);
> -}
> -
> -static void sigchld_bh_handler(void *opaque)
> -{
> -    ChildProcessRecord *rec, *next;
> -
> -    QLIST_FOREACH_SAFE(rec, &child_watches, next, next) {
> -        if (waitpid(rec->pid, NULL, WNOHANG) =3D=3D rec->pid) {
> -            QLIST_REMOVE(rec, next);
> -            g_free(rec);
> -        }
> -    }
> -}
> -
> -static void qemu_init_child_watch(void)
> -{
> -    struct sigaction act;
> -    sigchld_bh =3D qemu_bh_new(sigchld_bh_handler, NULL);
> -
> -    memset(&act, 0, sizeof(act));
> -    act.sa_handler =3D sigchld_handler;
> -    act.sa_flags =3D SA_NOCLDSTOP;
> -    sigaction(SIGCHLD, &act, NULL);
> -}
> -
> -int qemu_add_child_watch(pid_t pid)
> -{
> -    ChildProcessRecord *rec;
> -
> -    if (!sigchld_bh) {
> -        qemu_init_child_watch();
> -    }
> -
> -    QLIST_FOREACH(rec, &child_watches, next) {
> -        if (rec->pid =3D=3D pid) {
> -            return 1;
> -        }
> -    }
> -    rec =3D g_malloc0(sizeof(ChildProcessRecord));
> -    rec->pid =3D pid;
> -    QLIST_INSERT_HEAD(&child_watches, rec, next);
> -    return 0;
> -}
> -#endif
> diff --git a/util/main-loop.c b/util/main-loop.c
> index a9f4e8d..e3eaa55 100644
> --- a/util/main-loop.c
> +++ b/util/main-loop.c
> @@ -32,6 +32,11 @@
>  #include "qemu/main-loop.h"
>  #include "block/aio.h"
>  #include "qemu/error-report.h"
> +#include "qemu/queue.h"
> +
> +#ifndef _WIN32
> +#include <sys/wait.h>
> +#endif
>
>  #ifndef _WIN32
>
> @@ -525,3 +530,108 @@ QEMUBH *qemu_bh_new(QEMUBHFunc *cb, void *opaque)
>  {
>      return aio_bh_new(qemu_aio_context, cb, opaque);
>  }
> +
> +/*
> + * Functions to operate on the I/O handler AioContext.
> + * This context runs on top of main loop. We can't reuse qemu_aio_contex=
t
> + * because iohandlers mustn't be polled by aio_poll(qemu_aio_context).
> + */
> +static AioContext *iohandler_ctx;
> +
> +static void iohandler_init(void)
> +{
> +    if (!iohandler_ctx) {
> +        iohandler_ctx =3D aio_context_new(&error_abort);
> +    }
> +}
> +
> +AioContext *iohandler_get_aio_context(void)
> +{
> +    iohandler_init();
> +    return iohandler_ctx;
> +}
> +
> +GSource *iohandler_get_g_source(void)
> +{
> +    iohandler_init();
> +    return aio_get_g_source(iohandler_ctx);
> +}
> +
> +void qemu_set_fd_handler(int fd,
> +                         IOHandler *fd_read,
> +                         IOHandler *fd_write,
> +                         void *opaque)
> +{
> +    iohandler_init();
> +    aio_set_fd_handler(iohandler_ctx, fd, false,
> +                       fd_read, fd_write, NULL, opaque);
> +}
> +
> +void event_notifier_set_handler(EventNotifier *e,
> +                                EventNotifierHandler *handler)
> +{
> +    iohandler_init();
> +    aio_set_event_notifier(iohandler_ctx, e, false,
> +                           handler, NULL);
> +}
> +
> +/* reaping of zombies.  right now we're not passing the status to
> +   anyone, but it would be possible to add a callback.  */
> +#ifndef _WIN32
> +typedef struct ChildProcessRecord {
> +    int pid;
> +    QLIST_ENTRY(ChildProcessRecord) next;
> +} ChildProcessRecord;
> +
> +static QLIST_HEAD(, ChildProcessRecord) child_watches =3D
> +    QLIST_HEAD_INITIALIZER(child_watches);
> +
> +static QEMUBH *sigchld_bh;
> +
> +static void sigchld_handler(int signal)
> +{
> +    qemu_bh_schedule(sigchld_bh);
> +}
> +
> +static void sigchld_bh_handler(void *opaque)
> +{
> +    ChildProcessRecord *rec, *next;
> +
> +    QLIST_FOREACH_SAFE(rec, &child_watches, next, next) {
> +        if (waitpid(rec->pid, NULL, WNOHANG) =3D=3D rec->pid) {
> +            QLIST_REMOVE(rec, next);
> +            g_free(rec);
> +        }
> +    }
> +}
> +
> +static void qemu_init_child_watch(void)
> +{
> +    struct sigaction act;
> +    sigchld_bh =3D qemu_bh_new(sigchld_bh_handler, NULL);
> +
> +    memset(&act, 0, sizeof(act));
> +    act.sa_handler =3D sigchld_handler;
> +    act.sa_flags =3D SA_NOCLDSTOP;
> +    sigaction(SIGCHLD, &act, NULL);
> +}
> +
> +int qemu_add_child_watch(pid_t pid)
> +{
> +    ChildProcessRecord *rec;
> +
> +    if (!sigchld_bh) {
> +        qemu_init_child_watch();
> +    }
> +
> +    QLIST_FOREACH(rec, &child_watches, next) {
> +        if (rec->pid =3D=3D pid) {
> +            return 1;
> +        }
> +    }
> +    rec =3D g_malloc0(sizeof(ChildProcessRecord));
> +    rec->pid =3D pid;
> +    QLIST_INSERT_HEAD(&child_watches, rec, next);
> +    return 0;
> +}
> +#endif
> --
> 1.8.3.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

