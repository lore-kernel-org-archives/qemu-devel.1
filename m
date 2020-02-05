Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8ECC33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 10:25:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC4512082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 10:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/WJXYwf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4512082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izHrv-0007aa-Rg
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 05:25:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1izHrD-00074f-EO
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 05:24:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1izHrA-0004Kj-Vb
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 05:24:31 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43123)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1izHrA-00047Y-ML
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 05:24:28 -0500
Received: by mail-wr1-x442.google.com with SMTP id z9so1954320wrs.10
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 02:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=75P540s/nLMVzalQafNz2LuxxyEAej5TvsaCn0X+T0I=;
 b=A/WJXYwfB55Joqur9gdIh3PL/hQEXSvhuiYBtS24WO4QKtpzBzErUwOCicY96qhmjC
 00/3fvhDm8VAZYDYnhXI8nRV8V1CcZk1Gu85r/nvHmCA1AoyMy1NA8BcVg0B7K3Gn7OS
 RdYfWyR98JCRzx9MTMbTOSYgWlMq8I9OR2Uys16fcpUuH/WIq8e7E9fpg/M1EGmLzUyp
 wLksS+7PQKSPYHE1a6ImNh4nNtL2ckPHxlnWxPoiEp+ETOghy1DMeUot5751RnKuwavj
 SC/1w08XSQ2ME+54kcMyCRPRrxMtQYfyDsTiwbmhO9RmPrHyxmX8T5Hod6OyjWbnX32j
 um6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=75P540s/nLMVzalQafNz2LuxxyEAej5TvsaCn0X+T0I=;
 b=hAv1NWDJFF94Uwo9N0MsLhSP/4wmpFCHCEdh/GrNroz/xSjlyD7MJBHssoxPm0x8H9
 tTTBRm/9AgRfHeJKjEIuRr5FcvVH8VK4shIGb5WjhpOsR+0noBaiBEdDA/CQwcjO5CS6
 paTMRfihx75A86iFDOtqF0zvDbdMBtlfFc9mF1MKs2y6tbP2qks9EnQ+jcspYihgSJUP
 tStMdcr0BmRG8QS+LdNAv7i1btgDiot5NRpdwgTa5Bqn1BJ9M58n4BRXP2LX3epFSQjY
 7R04MbZCaYHAAQaKhnol7wpCAq9xNwPmBz242aqOVaR8LQkyoJBItQSh5kED9dCe6Umd
 k82Q==
X-Gm-Message-State: APjAAAUPNE2fRiJJCrlSb+ulN8HNVekC3TdngxMn2Mf8od2bkfSoZodg
 8XIr6yN9ycbwFgipfd6lu1OQL4P2s8fhIhiyAsc=
X-Google-Smtp-Source: APXvYqzLmOpHBGY2qXe5OaU5ryBRxkDB0vB47DgRKLnb0Sra0vU5DtVgKYn+Oyjg8e5oUiY9qYlVS1rBp4gwYFRXdUo=
X-Received: by 2002:adf:d84c:: with SMTP id k12mr28408885wrl.96.1580898267177; 
 Wed, 05 Feb 2020 02:24:27 -0800 (PST)
MIME-Version: 1.0
References: <20200205095737.20153-1-felipe@nutanix.com>
In-Reply-To: <20200205095737.20153-1-felipe@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 5 Feb 2020 11:24:14 +0100
Message-ID: <CAJ+F1CJPp82O713x-UDkVYeZwUAVUpdyAtpStN0Pfc2iHyutnw@mail.gmail.com>
Subject: Re: [PATCH v2] fence: introduce a file-based self-fence mechanism
To: Felipe Franciosi <felipe@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
 Stefan Hajnoczi <stefanha@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Feb 5, 2020 at 10:57 AM Felipe Franciosi <felipe@nutanix.com> wrote=
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
> heartbeat. At least one of these must be specified. Both may be used, in
> which case 'ktimeout' must be greater than 'qtimeout'. Setting either to
> zero has no effect (as if they weren't specified).
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
> hardware watchdogs either instead or in conjunction with this for
> additional protection.
>
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> ---
>  backends/Makefile.objs |   2 +
>  backends/file-fence.c  | 374 +++++++++++++++++++++++++++++++++++++++++
>  qemu-options.hx        |  27 ++-
>  3 files changed, 402 insertions(+), 1 deletion(-)
>  create mode 100644 backends/file-fence.c
>
> Changelog:
> v1->v2:
> - Publish patch in https://github.com/franciozzy/qemu/tree/filefence
> - Rename file_fence to file-fence and move to backends/
> - Use error_printf() instead of printf() when fencing
> - Replace a check already done by filemonitor-inotify with assert
> - Add return value to _setup() functions to simplify error logic
> - Use g_ascii_strcasecmp() to simplify logic in _set_signal()
> - Use glib memory allocation helpers in _set_file()
> - Fix bug to allow using qtimeout without ktimeout
> - Clarify usage of q/k timeouts in commit message
> - Clarify usage of hardware watchdogs in commits message
>
> diff --git a/backends/Makefile.objs b/backends/Makefile.objs
> index 28a847cd57..da2a589bdf 100644
> --- a/backends/Makefile.objs
> +++ b/backends/Makefile.objs
> @@ -9,6 +9,8 @@ common-obj-$(CONFIG_POSIX) +=3D hostmem-file.o
>  common-obj-y +=3D cryptodev.o
>  common-obj-y +=3D cryptodev-builtin.o
>
> +common-obj-y +=3D file-fence.o
> +
>  ifeq ($(CONFIG_VIRTIO_CRYPTO),y)
>  common-obj-y +=3D cryptodev-vhost.o
>  common-obj-$(CONFIG_VHOST_CRYPTO) +=3D cryptodev-vhost-user.o
> diff --git a/backends/file-fence.c b/backends/file-fence.c
> new file mode 100644
> index 0000000000..3dbbed7325
> --- /dev/null
> +++ b/backends/file-fence.c
> @@ -0,0 +1,374 @@
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
> +#include "qemu/error-report.h"
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
> +    error_printf("Fencing after %u seconds on '%s'\n",
> +                 ff->qtimeout, g_strconcat(ff->dir, "/", ff->file, NULL)=
);
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
> +    g_assert(g_str_equal(file, ff->file));
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
> +static gboolean
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
> +        return TRUE;
> +    }
> +
> +    err =3D timer_create(CLOCK_MONOTONIC, &sev, &ff->ktimer);
> +    if (err =3D=3D -1) {
> +        error_setg(errp, "Error creating kernel timer: %m");
> +        return FALSE;
> +    }
> +
> +    return TRUE;
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
> +static gboolean
> +qtimer_setup(FileFence *ff, Error **errp)
> +{
> +    QEMUTimer *qtimer;
> +
> +    if (ff->qtimeout =3D=3D 0) {
> +        return TRUE;
> +    }
> +
> +    qtimer =3D timer_new_ms(QEMU_CLOCK_REALTIME, file_fence_abort_cb, ff=
);
> +    if (qtimer =3D=3D NULL) {
> +        error_setg(errp, "Error creating Qemu timer");
> +        return FALSE;
> +    }
> +
> +    ff->qtimer =3D qtimer;
> +
> +    return TRUE;
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
> +static gboolean
> +watch_setup(FileFence *ff, Error **errp)
> +{
> +    QFileMonitor *fm;
> +    int64_t id;
> +
> +    fm =3D qemu_file_monitor_new(errp);
> +    if (!fm) {
> +        return FALSE;
> +    }
> +
> +    id =3D qemu_file_monitor_add_watch(fm, ff->dir, ff->file,
> +                                     file_fence_watch_cb, ff, errp);
> +    if (id < 0) {
> +        qemu_file_monitor_free(fm);
> +        return FALSE;
> +    }
> +
> +    ff->fm =3D fm;
> +    ff->id =3D id;
> +
> +    return TRUE;
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
> +    if (ff->qtimeout >=3D ff->ktimeout && ff->ktimeout !=3D 0) {
> +        error_setg(errp, "Using 'qtimeout' >=3D 'ktimeout' doesn't make =
sense");
> +        return;
> +    }
> +
> +    if (!watch_setup(ff, errp) ||
> +        !qtimer_setup(ff, errp) ||
> +        !ktimer_setup(ff, errp)) {
> +        return;
> +    }
> +
> +    timer_update(ff);
> +
> +    return;
> +}
> +
> +static void
> +file_fence_set_signal(Object *obj, const char *value, Error **errp)
> +{
> +    FileFence *ff =3D FILE_FENCE(obj);
> +
> +    if (ff->signal) {
> +        error_setg(errp, "Signal property already set");
> +        return;
> +    }
> +
> +    if (value =3D=3D NULL) {
> +        goto err;
> +    }
> +
> +    if (g_ascii_strcasecmp(value, "QUIT") =3D=3D 0) {
> +        ff->signal =3D SIGQUIT;
> +        return;
> +    }
> +
> +    if (g_ascii_strcasecmp(value, "KILL") =3D=3D 0) {
> +        ff->signal =3D SIGKILL;
> +        return;
> +    }
> +
> +err:
> +    error_setg(errp, "Invalid signal. Must be 'quit' or 'kill'");
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
> +    g_autofree gchar *dir =3D NULL, *file =3D NULL;
> +
> +    if (ff->dir) {
> +        error_setg(errp, "File property already set");
> +        return;
> +    }
> +
> +    dir =3D g_path_get_dirname(value);
> +    if (g_str_equal(dir, ".")) {
> +        error_setg(errp, "Path for file-fence must be absolute");

g_path_is_absolute() ? why such limitation ?

> +        return;
> +    }
> +
> +    file =3D g_path_get_basename(value);
> +    if (g_str_equal(file, ".")) {
> +        error_setg(errp, "Path for file-fence must be a file");

I think you would get "." if value is "".

I am not sure you need extra error handling here, since watch_setup()
will fail if it can't open the file.

> +        return;
> +    }
> +
> +    ff->dir =3D g_steal_pointer(&dir);
> +    ff->file =3D g_steal_pointer(&file);
> +}
> +
> +static char *
> +file_fence_get_file(Object *obj, Error **errp)
> +{
> +    FileFence *ff =3D FILE_FENCE(obj);
> +
> +    if (ff->file) {
> +        return g_build_filename(ff->dir, ff->file, NULL);
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
> +                                   OBJ_PROP_FLAG_READWRITE, &error_abort=
);
> +    object_property_add_uint32_ptr(obj, "ktimeout", &ff->ktimeout,
> +                                   OBJ_PROP_FLAG_READWRITE, &error_abort=
);

You could make them all class properties, right?

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
> index 224a8e8712..5ea94b37af 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4974,8 +4974,33 @@ The polling parameters can be modified at run-time=
 using the @code{qom-set} comm
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


--=20
Marc-Andr=C3=A9 Lureau

