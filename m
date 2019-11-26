Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D409C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 11:19:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E9D02073F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 11:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoUQR1hx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9D02073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZYsA-0007Ie-CG
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 06:19:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42511)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iZYrJ-0006sk-78
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 06:18:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iZYrH-00062J-1N
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 06:18:17 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37320)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iZYrG-00061m-Ni
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 06:18:14 -0500
Received: by mail-wm1-x344.google.com with SMTP id f129so2845941wmf.2
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 03:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ER1ap+3vJd+U6ftqeuCDYYVNl3g9rnf2XxDUTjuqyww=;
 b=LoUQR1hxOWcCehUsEtZZZu5b+/RXRtKL02TDK73WBZui2LWNx/P2ldH6Of9vkhe/og
 FHSJ+aGtHc8zfT5Szo/MP3+JMGQbgfwPfa9+XyQzCa3Ous/557GJc/qtZoUfkS4QTS6+
 oK9KFXF3kBOQL34+pCg/rD5kEKz0FMeOwoQNUEKTwsmbc15W9Gc1wEu114ULYJsLZ1uT
 DWwvZz8ius2D9V5Gzr25aJnN9I2xn+YAqLDCQ7R8fXshDjTY0BMpNj0uFJQMAZ64Qsd/
 UCnUqAp5sVVaT+/c5P3kqnvk7A4BKolvligwXZIKNmCnqTuDr/rcQGX39YcANJj4w43+
 NgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ER1ap+3vJd+U6ftqeuCDYYVNl3g9rnf2XxDUTjuqyww=;
 b=K3dP4AChjYz1vaWOW+HZQQH/3PdrfpRlhNx6NEzDQEsuGrqb9FQ4xfFsP+egSg2n5+
 3tO80/EjqCMKHtnoLshxkfGv8VwLeGWi6l3apS5bY6TVcJUxbmaS2fxqoLmFSdeNUwPi
 RobwfWAHVMTJZ/fwM/GTggBaA9AoUXeqiXtIHAhx3VkA2AbnfICCKG0byDyp9p+1Q83C
 DzJW70KYF2EOrFkpaOzReOnL6ogzV0NHnnZlOVnUswnIsQQOBfWMLRHZsNjPIfIOuEn8
 S1anpoS+p4WRdXNJKo/h3/RoO/R42K+1zWd1LzVqNWKBzK1TPrIgo91Jg6h7br+v5QHW
 PfKg==
X-Gm-Message-State: APjAAAWlJ6W1lwPxiMNNXgBprhIQNFhFIlU2ZiHo9r7xIKCFz69E9Vha
 Ai0fHZqFV5biFvDESAsCI7T+555lH4lA81KlRBk=
X-Google-Smtp-Source: APXvYqwdMduNCUnC5Dlbs/h0dqgshhQ3pE+5J19OfX/XIPpapKclSgHUXrtkvi1KfYbjnQ2gj4+Fqmyznpg20zYy0Ds=
X-Received: by 2002:a05:600c:20e:: with SMTP id
 14mr3586673wmi.107.1574767093213; 
 Tue, 26 Nov 2019 03:18:13 -0800 (PST)
MIME-Version: 1.0
References: <20191125161356.108054-1-felipe@nutanix.com>
In-Reply-To: <20191125161356.108054-1-felipe@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 26 Nov 2019 15:18:00 +0400
Message-ID: <CAJ+F1CJP_+bcAMgFFv4nS9wNZcAAsT7BTHcyiLFr0yfF0j8XHw@mail.gmail.com>
Subject: Re: [PATCH] fence: introduce a file-based self-fence mechanism
To: Felipe Franciosi <felipe@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Daniel Berrange <berrange@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 25, 2019 at 8:14 PM Felipe Franciosi <felipe@nutanix.com> wrote=
:
>
> This introduces a self-fence mechanism to Qemu, causing it to die if a
> heartbeat condition is not met. Currently, a file-based heartbeat is
> available and can be configured as follows:
>
> -object file-fence,id=3Dff0,file=3D/foo,qtimeout=3D20,ktimeout=3D25,signa=
l=3Dkill
>
> Qemu will watch 'file' for attribute changes. Touching the file works as
> a heartbeat. This parameter is mandatory.
>
> Fencing happens after 'qtimeout' or 'ktimeout' seconds elapse without a
> heartbeat. At least one of these must be specified. Both may be used.
>
> When using 'qtimeout', an internal Qemu timer is used. Fencing with this
> method gives Qemu a chance to write a log message indicating which file
> caused the event. If Qemu's main loop is hung for whatever reason, this
> method won't successfully kill Qemu.
>
> When using 'ktimeout', a kernel timer is used. In this case, 'signal'
> can be 'kill' (for SIGKILL, default) or 'quit' (for SIGQUIT). Using
> SIGQUIT may be preferred for obtaining core dumps. If Qemu is hung
> (eg. uninterruptable sleep), this method won't successfully kill Qemu.
>
> It is worth noting that even successfully killing Qemu may not be
> sufficient to completely fence a VM as certain operations like network
> packets or block commands may be pending in the kernel. If that is a
> concern, systems should consider using further fencing mechanisms like
> hardware watchdogs either in addition or in conjunction with this for
> additional protection.
>
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> ---
> Based-on: <20191125153619.39893-2-felipe@nutanix.com>
>
>  Makefile.objs       |   1 +
>  fence/Makefile.objs |   1 +
>  fence/file_fence.c  | 381 ++++++++++++++++++++++++++++++++++++++++++++

I think it could be under backends/
And a slight preference for - seperated words in filenames over qemu codeba=
se.

>  qemu-options.hx     |  27 +++-
>  4 files changed, 409 insertions(+), 1 deletion(-)
>  create mode 100644 fence/Makefile.objs
>  create mode 100644 fence/file_fence.c
>
> diff --git a/Makefile.objs b/Makefile.objs
> index 11ba1a36bd..998eed4796 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -75,6 +75,7 @@ common-obj-$(CONFIG_TPM) +=3D tpm.o
>
>  common-obj-y +=3D backends/
>  common-obj-y +=3D chardev/
> +common-obj-y +=3D fence/
>
>  common-obj-$(CONFIG_SECCOMP) +=3D qemu-seccomp.o
>  qemu-seccomp.o-cflags :=3D $(SECCOMP_CFLAGS)
> diff --git a/fence/Makefile.objs b/fence/Makefile.objs
> new file mode 100644
> index 0000000000..2ed2092568
> --- /dev/null
> +++ b/fence/Makefile.objs
> @@ -0,0 +1 @@
> +common-obj-y +=3D file_fence.o
> diff --git a/fence/file_fence.c b/fence/file_fence.c
> new file mode 100644
> index 0000000000..5b743e69d2
> --- /dev/null
> +++ b/fence/file_fence.c
> @@ -0,0 +1,381 @@
> +/*
> + * QEMU file-based self-fence mechanism
> + *
> + * Copyright (c) 2019 Nutanix Inc. All rights reserved.
> + *
> + * Authors:
> + *    Felipe Franciosi <felipe@nutanix.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qom/object_interfaces.h"
> +#include "qemu/filemonitor.h"
> +#include "qemu/timer.h"
> +
> +#include <time.h>
> +
> +#define TYPE_FILE_FENCE "file-fence"
> +
> +typedef struct FileFence {
> +    Object parent_obj;
> +
> +    gchar *dir;
> +    gchar *file;
> +    uint32_t qtimeout;
> +    uint32_t ktimeout;
> +    int signal;
> +
> +    timer_t ktimer;
> +    QEMUTimer *qtimer;
> +
> +    QFileMonitor *fm;
> +    uint64_t id;
> +} FileFence;
> +
> +#define FILE_FENCE(obj) \
> +    OBJECT_CHECK(FileFence, (obj), TYPE_FILE_FENCE)
> +
> +static void
> +timer_update(FileFence *ff)
> +{
> +    struct itimerspec its =3D {
> +        .it_value.tv_sec =3D ff->ktimeout,
> +    };
> +    int err;
> +
> +    if (ff->qtimeout) {
> +        timer_mod(ff->qtimer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) +
> +                              ff->qtimeout * 1000);
> +    }
> +
> +    if (ff->ktimeout) {
> +        err =3D timer_settime(ff->ktimer, 0, &its, NULL);
> +        g_assert(err =3D=3D 0);
> +    }
> +}
> +
> +static void
> +file_fence_abort_cb(void *opaque)
> +{
> +    FileFence *ff =3D opaque;
> +    printf("Fencing after %u seconds on '%s'\n",
> +           ff->qtimeout, g_strconcat(ff->dir, "/", ff->file, NULL));

May be error_printf() instead.

> +    abort();
> +}
> +
> +static void
> +file_fence_watch_cb(int64_t id, QFileMonitorEvent ev, const char *file,
> +                    void *opaque)
> +{
> +    FileFence *ff =3D opaque;
> +
> +    if (ev !=3D QFILE_MONITOR_EVENT_ATTRIBUTES) {
> +        return;
> +    }
> +
> +    if (g_strcmp0(file, ff->file) !=3D 0) {

Does it actually happen? Apparently the code in
util/filemonitor-inotify.c already checks for g_str_equal(filename)

> +        return;
> +    }
> +
> +    timer_update(ff);
> +}
> +
> +static void
> +ktimer_tear(FileFence *ff)
> +{
> +    int err;
> +
> +    if (ff->ktimer) {
> +        err =3D timer_delete(ff->ktimer);
> +        g_assert(err =3D=3D 0);
> +        ff->ktimer =3D NULL;
> +    }
> +}
> +
> +static void
> +ktimer_setup(FileFence *ff, Error **errp)
> +{
> +    int err;
> +
> +    struct sigevent sev =3D {
> +        .sigev_notify =3D SIGEV_SIGNAL,
> +        .sigev_signo =3D ff->signal ? ff->signal : SIGKILL,
> +    };
> +
> +    if (ff->ktimeout =3D=3D 0) {
> +        return;
> +    }
> +
> +    err =3D timer_create(CLOCK_MONOTONIC, &sev, &ff->ktimer);
> +    if (err =3D=3D -1) {
> +        error_setg(errp, "Error creating kernel timer: %m");
> +        return;
> +    }
> +}
> +
> +static void
> +qtimer_tear(FileFence *ff)
> +{
> +    if (ff->qtimer) {
> +        timer_del(ff->qtimer);
> +        timer_free(ff->qtimer);
> +    }
> +    ff->qtimer =3D NULL;
> +}
> +
> +static void
> +qtimer_setup(FileFence *ff, Error **errp)
> +{
> +    QEMUTimer *qtimer;
> +
> +    if (ff->qtimeout =3D=3D 0) {
> +        return;
> +    }
> +
> +    qtimer =3D timer_new_ms(QEMU_CLOCK_REALTIME, file_fence_abort_cb, ff=
);
> +    if (qtimer =3D=3D NULL) {
> +        error_setg(errp, "Error creating Qemu timer");
> +        return;
> +    }
> +
> +    ff->qtimer =3D qtimer;
> +}
> +
> +static void
> +watch_tear(FileFence *ff)
> +{
> +    if (ff->fm) {
> +        qemu_file_monitor_remove_watch(ff->fm, ff->dir, ff->id);
> +        qemu_file_monitor_free(ff->fm);
> +        ff->fm =3D NULL;
> +        ff->id =3D 0;
> +    }
> +}
> +
> +static void
> +watch_setup(FileFence *ff, Error **errp)
> +{
> +    QFileMonitor *fm;
> +    int64_t id;
> +
> +    fm =3D qemu_file_monitor_new(errp);
> +    if (!fm) {
> +        return;
> +    }
> +
> +    id =3D qemu_file_monitor_add_watch(fm, ff->dir, ff->file,
> +                                     file_fence_watch_cb, ff, errp);
> +    if (id < 0) {
> +        qemu_file_monitor_free(fm);
> +        return;
> +    }
> +
> +    ff->fm =3D fm;
> +    ff->id =3D id;
> +}
> +
> +static void
> +file_fence_complete(UserCreatable *obj, Error **errp)
> +{
> +    FileFence *ff =3D FILE_FENCE(obj);
> +
> +    if (ff->dir =3D=3D NULL) {
> +        error_setg(errp, "A 'file' must be set");
> +        return;
> +    }
> +
> +    if (ff->signal !=3D 0 && ff->ktimeout =3D=3D 0) {
> +        error_setg(errp, "Using 'signal' requires 'ktimeout' to be set")=
;
> +        return;
> +    }
> +
> +    if (ff->ktimeout =3D=3D 0 && ff->qtimeout =3D=3D 0) {
> +        error_setg(errp, "One or both of 'ktimeout' or 'qtimeout' must b=
e set");
> +        return;
> +    }
> +
> +    if (ff->qtimeout >=3D ff->ktimeout) {
> +        error_setg(errp, "Using 'qtimeout' >=3D 'ktimeout' doesn't make =
sense");
> +        return;
> +    }
> +
> +    watch_setup(ff, errp);
> +    if (*errp !=3D NULL) {
> +        return;
> +    }
> +
> +    qtimer_setup(ff, errp);
> +    if (*errp !=3D NULL) {
> +        goto err_watch;
> +    }
> +
> +    ktimer_setup(ff, errp);
> +    if (*errp !=3D NULL) {
> +        goto err_qtimer;
> +    }


I would rather return success on the setup functions and write:

  if (!watch_setup(ff, errp) ||
      !qtimer_setup(...) ||
      !...) {
      return; (no cleanup)
   }

Object creation will fail, and finalize function will be called.

> +
> +    timer_update(ff);
> +
> +    return;
> +
> +err_qtimer:
> +    qtimer_tear(ff);
> +err_watch:
> +    watch_tear(ff);
> +}
> +
> +static void
> +file_fence_set_signal(Object *obj, const char *value, Error **errp)
> +{
> +    FileFence *ff =3D FILE_FENCE(obj);
> +    gchar *gsig;
> +
> +    if (ff->signal) {
> +        error_setg(errp, "Signal property already set");
> +        return;
> +    }
> +
> +    gsig =3D g_ascii_strup(value, -1);
> +
> +    if (g_strcmp0(gsig, "QUIT") =3D=3D 0) {
> +        ff->signal =3D SIGQUIT;
> +    } else
> +    if (g_strcmp0(gsig, "KILL") =3D=3D 0) {
> +        ff->signal =3D SIGKILL;
> +    } else {
> +        error_setg(errp, "Invalid signal. Must be 'quit' or 'kill'");
> +    }

Or bail out early for NULL case and use g_ascii_strcasecmp()

> +
> +    g_free(gsig);
> +}
> +
> +static char *
> +file_fence_get_signal(Object *obj, Error **errp)
> +{
> +    FileFence *ff =3D FILE_FENCE(obj);
> +
> +    switch (ff->signal) {
> +    case SIGKILL:
> +        return g_strdup("kill");
> +    case SIGQUIT:
> +        return g_strdup("quit");
> +    }
> +
> +    /* Unreachable */
> +    abort();
> +}
> +
> +static void
> +file_fence_set_file(Object *obj, const char *value, Error **errp)
> +{
> +    FileFence *ff =3D FILE_FENCE(obj);
> +    gchar *dir, *file;

g_autofree

> +
> +    if (ff->dir) {
> +        error_setg(errp, "File property already set");
> +        return;
> +    }
> +
> +    dir =3D g_path_get_dirname(value);
> +    if (g_str_equal(dir, ".")) {
> +        error_setg(errp, "Path for file-fence must be absolute");
> +        return;
> +    }
> +
> +    file =3D g_path_get_basename(value);
> +    if (g_str_equal(file, ".")) {
> +        error_setg(errp, "Path for file-fence must be a file");
> +        g_free(dir);
> +        return;
> +    }
> +
> +    ff->dir =3D dir;
> +    ff->file =3D file;

g_steal_pointer()

> +}
> +
> +static char *
> +file_fence_get_file(Object *obj, Error **errp)
> +{
> +    FileFence *ff =3D FILE_FENCE(obj);
> +
> +    if (ff->file) {
> +        return g_strconcat(ff->dir, "/", ff->file, NULL);

Or g_build_filename()

> +    }
> +
> +    return NULL;
> +}
> +
> +static void
> +file_fence_instance_finalize(Object *obj)
> +{
> +    FileFence *ff =3D FILE_FENCE(obj);
> +
> +    ktimer_tear(ff);
> +    qtimer_tear(ff);
> +    watch_tear(ff);
> +
> +    g_free(ff->file);
> +    g_free(ff->dir);
> +}
> +
> +static void
> +file_fence_instance_init(Object *obj)
> +{
> +    FileFence *ff =3D FILE_FENCE(obj);
> +
> +    object_property_add_str(obj, "file",
> +                            file_fence_get_file,
> +                            file_fence_set_file,
> +                            &error_abort);
> +    object_property_add_str(obj, "signal",
> +                            file_fence_get_signal,
> +                            file_fence_set_signal,
> +                            &error_abort);
> +    object_property_add_uint32_ptr(obj, "qtimeout", &ff->qtimeout,
> +                                   false, &error_abort);
> +    object_property_add_uint32_ptr(obj, "ktimeout", &ff->ktimeout,
> +                                   false, &error_abort);

Make them class properties (this will help with -object
file-fence,help and such). (fwiw, I have pending patches to support
class property description & default values..)

> +}
> +
> +static void
> +file_fence_class_init(ObjectClass *klass, void *class_data)
> +{
> +    UserCreatableClass *ucc =3D USER_CREATABLE_CLASS(klass);
> +    ucc->complete =3D file_fence_complete;
> +}
> +
> +static const TypeInfo file_fence_info =3D {
> +    .name =3D TYPE_FILE_FENCE,
> +    .parent =3D TYPE_OBJECT,
> +    .class_init =3D file_fence_class_init,
> +    .instance_size =3D sizeof(FileFence),
> +    .instance_init =3D file_fence_instance_init,
> +    .instance_finalize =3D file_fence_instance_finalize,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { TYPE_USER_CREATABLE },
> +        { }
> +    }
> +};
> +
> +static void
> +register_types(void)
> +{
> +    type_register_static(&file_fence_info);
> +}
> +
> +type_init(register_types);
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 65c9473b73..995d3d6abf 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4929,8 +4929,33 @@ CN=3Dlaptop.example.com,O=3DExample Home,L=3DLondo=
n,ST=3DLondon,C=3DGB
>
>  @end table
>
> -ETEXI
> +@item -object file-fence,id=3D@var{id},file=3D@var{file},qtimeout=3D@var=
{qtimeout},ktimeout=3D@var{ktimeout},signal=3D@{signal}
> +
> +Self-fence Qemu if @var{file} is not modified within a given timeout.
> +
> +Qemu will watch @var{file} for attribute changes. Touching the file work=
s as a
> +heartbeat. This parameter is mandatory.
> +
> +Fencing happens after @var{qtimeout} or @var{ktimeout} seconds elapse
> +without a heartbeat. At least one of these must be specified. Both may b=
e used.
>
> +When using @var{qtimeout}, an internal Qemu timer is used. Fencing with
> +this method gives Qemu a chance to write a log message indicating which =
file
> +caused the event. If Qemu's main loop is hung for whatever reason, this =
method
> +won't successfully kill Qemu.
> +
> +When using @var{ktimeout}, a kernel timer is used. In this case, @var{si=
gnal}
> +can be 'kill' (for SIGKILL, default) or 'quit' (for SIGQUIT). Using SIGQ=
UIT may
> +be preferred for obtaining core dumps. If Qemu is hung (eg. uninterrupta=
ble
> +sleep), this method won't successfully kill Qemu.
> +
> +It is worth noting that even successfully killing Qemu may not be suffic=
ient to
> +completely fence a VM as certain operations like network packets or bloc=
k
> +commands may be pending in the kernel. If that is a concern, systems sho=
uld
> +consider using further fencing mechanisms like hardware watchdogs either=
 in
> +addition or in conjunction with this feature for additional protection.
> +
> +ETEXI
>
>  HXCOMM This is the last statement. Insert new options before this line!
>  STEXI
> --
> 2.20.1
>

Code looks fine to me otherwise

--=20
Marc-Andr=C3=A9 Lureau

