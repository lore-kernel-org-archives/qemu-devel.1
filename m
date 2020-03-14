Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89EFC0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 13:34:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C8C020751
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 13:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4tBhCjI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C8C020751
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD6w0-0005iz-It
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 09:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49635)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jD6v8-00056U-CQ
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 09:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jD6v6-0002t4-QW
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 09:33:42 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40624)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jD6v6-0002pI-K3
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 09:33:40 -0400
Received: by mail-wm1-x344.google.com with SMTP id z12so3978950wmf.5
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 06:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=TgSyHXXA21K5pqEQ9px8rl/x/8vuHDzg3hqKUmIl9xQ=;
 b=S4tBhCjIE8GbeNjr9sfyfinacQuyVaquz68sJ33qiihC2a3MOT0NO5yhqZ3vPZl9CM
 3w7DbkhQI0+FW19cJdcP+5WkLFGx8MGs22Lj/un2y/SrQPoDlj7J29reCBR2IpmmbdIH
 voAfudkeyYJWkhNu1yADomOvWlHo1EhISu9o+2dW/XNay2mIkZVY254cKBxap0sE5Kq/
 Odi3JqZ153dVqtEw0LOVKt28Gln14u+0pi88D9gtbnNpkZxTMnSydWFTIsu1Up+oi494
 cG7l0LyE5oBkoGdhxiPrqps8AwAAMAMgYn77cmhPWQsovUAUtmx9PfL4Bsn22Z9+jcBm
 Znrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TgSyHXXA21K5pqEQ9px8rl/x/8vuHDzg3hqKUmIl9xQ=;
 b=fZ3LhXnZQR7Pnp5uLH9n6QP4BPdyQSITvdL5aLRXgeblhR2uzSpZeoT9qiWqiogsCe
 dL5/ZVcq1xhgPbx2cwQB2TSwK4P3+pEq1mpsh1vOkl8BJ4IylrE5MxkXzsI9qGvQYLhF
 MXdrwoqenPc3c26F52M7JSLJeQd0ggCfepp9mpiDKOfqUfKwzEysiPL81M2d/EXWrW42
 pgDRH8quQv7mmkhAaWQWqhaUx350v8j4OlIEdDsy4ZacQmuAlevVsnXSkePEgeOMcGC+
 kGCa199+DCcOIMmEWbNZ/Nps7Ghv510sKT2x9GORwCUc31BCHPbhDG0Bsysxrrrfej6J
 qflw==
X-Gm-Message-State: ANhLgQ3VmmzTzgNhctAt3JzGZGxLubnkrwuMY0aGhV6MfvZw+esZWyv+
 Xm7GyPlNBrBmPB1VucgOjT/ZLTaRp94K9Tm6/78=
X-Google-Smtp-Source: ADFU+vvQOwp5uXjwIZkok+19fMnWCApyu1g6indaq9GEjMrOxzY8PvhkWcSU84bWEVFpL+7evYC9RD+heH8yUa5hCyM=
X-Received: by 2002:a7b:c153:: with SMTP id z19mr15889220wmi.37.1584192818051; 
 Sat, 14 Mar 2020 06:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200312104142.21259-1-alex.bennee@linaro.org>
 <20200312104913.GB4089516@redhat.com>
In-Reply-To: <20200312104913.GB4089516@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 14 Mar 2020 14:33:25 +0100
Message-ID: <CAJ+F1CJWy2gEHHjzqyqnvHFf6EP4mEGABLt4aA7xptkXDwPGiw@mail.gmail.com>
Subject: Re: [PATCH] tools/virtiofsd: add support for --socket-group
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Thu, Mar 12, 2020 at 11:49 AM Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
>
> On Thu, Mar 12, 2020 at 10:41:42AM +0000, Alex Benn=C3=A9e wrote:
> > If you like running QEMU as a normal user (very common for TCG runs)
> > but you have to run virtiofsd as a root user you run into connection
> > problems. Adding support for an optional --socket-group allows the
> > users to keep using the command line.
>
> If we're going to support this, then I think we need to put it in
> the vhost-user.rst specification so we standardize across backends.
>
>

Perhaps. Otoh, I wonder if the backend spec should be more limited to
arguments/introspection that are used by programs.

In this case, I even consider --socket-path to be unnecessary, as a
management layer can/should provide a preopened & setup fd directly.

What do you think?

>
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
>
> >
> > ---
> > v1
> >   - tweak documentation and commentary
> > ---
> >  docs/tools/virtiofsd.rst        |  4 ++++
> >  tools/virtiofsd/fuse_i.h        |  1 +
> >  tools/virtiofsd/fuse_lowlevel.c |  6 ++++++
> >  tools/virtiofsd/fuse_virtio.c   | 20 ++++++++++++++++++--
> >  4 files changed, 29 insertions(+), 2 deletions(-)
> >
> > diff --git a/docs/tools/virtiofsd.rst b/docs/tools/virtiofsd.rst
> > index 378594c422a..5a8246b74f8 100644
> > --- a/docs/tools/virtiofsd.rst
> > +++ b/docs/tools/virtiofsd.rst
> > @@ -85,6 +85,10 @@ Options
> >
> >    Listen on vhost-user UNIX domain socket at PATH.
> >
> > +.. option:: --socket-group=3DGROUP
> > +
> > +  Set the vhost-user UNIX domain socket gid to GROUP.
> > +
> >  .. option:: --fd=3DFDNUM
> >
> >    Accept connections from vhost-user UNIX domain socket file descripto=
r FDNUM.
> > diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
> > index 1240828208a..492e002181e 100644
> > --- a/tools/virtiofsd/fuse_i.h
> > +++ b/tools/virtiofsd/fuse_i.h
> > @@ -68,6 +68,7 @@ struct fuse_session {
> >      size_t bufsize;
> >      int error;
> >      char *vu_socket_path;
> > +    char *vu_socket_group;
> >      int   vu_listen_fd;
> >      int   vu_socketfd;
> >      struct fv_VuDev *virtio_dev;
> > diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_low=
level.c
> > index 2dd36ec03b6..4d1ba2925d1 100644
> > --- a/tools/virtiofsd/fuse_lowlevel.c
> > +++ b/tools/virtiofsd/fuse_lowlevel.c
> > @@ -2523,6 +2523,7 @@ static const struct fuse_opt fuse_ll_opts[] =3D {
> >      LL_OPTION("--debug", debug, 1),
> >      LL_OPTION("allow_root", deny_others, 1),
> >      LL_OPTION("--socket-path=3D%s", vu_socket_path, 0),
> > +    LL_OPTION("--socket-group=3D%s", vu_socket_group, 0),
> >      LL_OPTION("--fd=3D%d", vu_listen_fd, 0),
> >      LL_OPTION("--thread-pool-size=3D%d", thread_pool_size, 0),
> >      FUSE_OPT_END
> > @@ -2630,6 +2631,11 @@ struct fuse_session *fuse_session_new(struct fus=
e_args *args,
> >                   "fuse: --socket-path and --fd cannot be given togethe=
r\n");
> >          goto out4;
> >      }
> > +    if (se->vu_socket_group && !se->vu_socket_path) {
> > +        fuse_log(FUSE_LOG_ERR,
> > +                 "fuse: --socket-group can only be used with --socket-=
path\n");
> > +        goto out4;
> > +    }
> >
> >      se->bufsize =3D FUSE_MAX_MAX_PAGES * getpagesize() + FUSE_BUFFER_H=
EADER_SIZE;
> >
> > diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virti=
o.c
> > index 3b6d16a0417..331f9fc65c5 100644
> > --- a/tools/virtiofsd/fuse_virtio.c
> > +++ b/tools/virtiofsd/fuse_virtio.c
> > @@ -31,6 +31,8 @@
> >  #include <sys/socket.h>
> >  #include <sys/types.h>
> >  #include <sys/un.h>
> > +#include <sys/types.h>
> > +#include <grp.h>
> >  #include <unistd.h>
> >
> >  #include "contrib/libvhost-user/libvhost-user.h"
> > @@ -924,15 +926,29 @@ static int fv_create_listen_socket(struct fuse_se=
ssion *se)
> >
> >      /*
> >       * Unfortunately bind doesn't let you set the mask on the socket,
> > -     * so set umask to 077 and restore it later.
> > +     * so set umask appropriately and restore it later.
> >       */
> > -    old_umask =3D umask(0077);
> > +    if (se->vu_socket_group) {
> > +        old_umask =3D umask(S_IROTH | S_IWOTH | S_IXOTH);
> > +    } else {
> > +        old_umask =3D umask(S_IRGRP | S_IWGRP | S_IXGRP | S_IROTH | S_=
IWOTH | S_IXOTH);
> > +    }
> >      if (bind(listen_sock, (struct sockaddr *)&un, addr_len) =3D=3D -1)=
 {
> >          fuse_log(FUSE_LOG_ERR, "vhost socket bind: %m\n");
> >          close(listen_sock);
> >          umask(old_umask);
> >          return -1;
> >      }
> > +    if (se->vu_socket_group) {
> > +        struct group *g =3D getgrnam(se->vu_socket_group);
> > +        if (g) {
> > +            if (!chown(se->vu_socket_path, -1, g->gr_gid)) {
> > +                fuse_log(FUSE_LOG_WARNING,
> > +                         "vhost socket failed to set group to %s (%d)\=
n",
> > +                         se->vu_socket_group, g->gr_gid);
> > +            }
> > +        }
> > +    }
> >      umask(old_umask);
> >
> >      if (listen(listen_sock, 1) =3D=3D -1) {
> > --
> > 2.20.1
> >
> >
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>
>


--=20
Marc-Andr=C3=A9 Lureau

