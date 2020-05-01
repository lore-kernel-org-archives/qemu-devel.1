Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51DBC47257
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 17:37:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 825282173E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 17:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FV8Lg+Ua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 825282173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUZbL-0000ZF-Jt
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 13:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jUZaD-000846-8p
 for qemu-devel@nongnu.org; Fri, 01 May 2020 13:36:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jUZYo-0000xF-NI
 for qemu-devel@nongnu.org; Fri, 01 May 2020 13:36:16 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51688)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jUZYo-0000x5-A1
 for qemu-devel@nongnu.org; Fri, 01 May 2020 13:34:50 -0400
Received: by mail-wm1-x344.google.com with SMTP id x4so424171wmj.1
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 10:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bHSGO9QJbeL9UuhUa0QzJefmxOmPyQlDkL/UpGqf2XE=;
 b=FV8Lg+UaJtEDx+fywyKTm6wKIp3IUDriMgixKUSwUhtqBLZzcwnGCjadNHlWi3GvbZ
 uW/Ha4Srubf6+fiTKsP2twxaO8jPCmXmk7MM6WROXtpKSNcw0DgYbI74BWY+Xx3M1b3G
 akwoFOf3mnxkZv3f9YV9u5Q+j1TRt1kzlmRvKvJH71DYIDUwOONj+7hFLj4wcZyfkgUa
 7T9CDH5c6hammuTXLqVryAVPj092cibNIP+KIJ8rBLQ92uedi/4afbQPArmuvY9Dkvn2
 bBCcQBv/QC70ye1R2QOjiPHB/N4aytJg8MuscKpt2nN3vubgRikwW0tZtQmAhIGkC51/
 tAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bHSGO9QJbeL9UuhUa0QzJefmxOmPyQlDkL/UpGqf2XE=;
 b=uaJNpaS5SKkTdaiUz+gphyyAV+ldhov/APTxipY/AnLzOU5zgdcLt2bX9USGMeXyAO
 7ODwEleGgWD8JabpKxZJgm2o8NOCfeKb2tCmr73EECsnqzNtOvFpMXCVrGR9WqktTqHU
 4vFteNEeKbIFKWaJ1yp8qb9VBTSiGP8CX+HNv4CylNvAce9cEDQew5eaNgpcBLE4UFWt
 6s3L5auxGRny68XwKDeJGMh6FxICv3tfcFy7TiSkZbgcXrOYt3CQLlUGZtX3DLguUwRE
 NPQMHxY46jLChKnhSI+uTKkxT8zi9QLkEmXk6d/eIlvQrkhZEpmOHT7sy26ejb/2jc7I
 eluA==
X-Gm-Message-State: AGi0PuZwGVFHrLt1NOBqJxXY2LWVo6ATqGHa2C1r1KF52pEFCNOMVgXp
 UadoTJ09gxBVgFfhtFR4oIcS7ybvRzj1lu8f72M=
X-Google-Smtp-Source: APiQypLovNQScF9/H7OQLVsh8Ntq7Vj/bX9X/63d8UWdRRUjH7icZ8f/AfdQEanIeKo1dMojVfMm0zFDS7VTDuNZeUA=
X-Received: by 2002:a1c:1c8:: with SMTP id 191mr527984wmb.37.1588354488134;
 Fri, 01 May 2020 10:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200501172559.6470-1-alxndr@bu.edu>
In-Reply-To: <20200501172559.6470-1-alxndr@bu.edu>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 1 May 2020 19:34:36 +0200
Message-ID: <CAJ+F1CJ6K=zsrmrCeonDGN5BCm3Hr7B9GR2KqkQFT3FFE79Wyg@mail.gmail.com>
Subject: Re: [PATCH] chardev: enable distinct input for -chardev file
To: Alexander Bulekov <alxndr@bu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Fri, May 1, 2020 at 7:26 PM Alexander Bulekov <alxndr@bu.edu> wrote:
>
> char-file already supports distinct paths for input/output but it was
> only possible to specify a distinct input through QMP. With this change,
> we can also specify a distinct input with the -chardev file argument:
>     qemu -chardev file,id=3Dchar1,path=3D/out/file,in=3D/in/file
>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>

Looks ok. Please consider writing a test.

> ---
>  chardev/char-file.c | 5 +++++
>  chardev/char.c      | 3 +++
>  qemu-options.hx     | 7 +++++--
>  3 files changed, 13 insertions(+), 2 deletions(-)
>
> The naming here is awkward, with path=3D really turning into "out" when
> in=3D is specified, though i'm not sure about what is a good solution.
>
> diff --git a/chardev/char-file.c b/chardev/char-file.c
> index 2fd80707e5..cc742cc234 100644
> --- a/chardev/char-file.c
> +++ b/chardev/char-file.c
> @@ -100,6 +100,7 @@ static void qemu_chr_parse_file_out(QemuOpts *opts, C=
hardevBackend *backend,
>                                      Error **errp)
>  {
>      const char *path =3D qemu_opt_get(opts, "path");
> +    const char *in =3D qemu_opt_get(opts, "in");
>      ChardevFile *file;
>
>      backend->type =3D CHARDEV_BACKEND_KIND_FILE;
> @@ -110,6 +111,10 @@ static void qemu_chr_parse_file_out(QemuOpts *opts, =
ChardevBackend *backend,
>      file =3D backend->u.file.data =3D g_new0(ChardevFile, 1);
>      qemu_chr_parse_common(opts, qapi_ChardevFile_base(file));
>      file->out =3D g_strdup(path);
> +    if (in) {
> +        file->has_in =3D true;
> +        file->in =3D g_strdup(qemu_opt_get(opts, "in"));
> +    }
>
>      file->has_append =3D true;
>      file->append =3D qemu_opt_get_bool(opts, "append", false);
> diff --git a/chardev/char.c b/chardev/char.c
> index e77564060d..797574f205 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -849,6 +849,9 @@ QemuOptsList qemu_chardev_opts =3D {
>          },{
>              .name =3D "path",
>              .type =3D QEMU_OPT_STRING,
> +        },{
> +            .name =3D "in",
> +            .type =3D QEMU_OPT_STRING,
>          },{
>              .name =3D "host",
>              .type =3D QEMU_OPT_STRING,
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 292d4e7c0c..bbb091872f 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2938,7 +2938,7 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
>      "-chardev vc,id=3Did[[,width=3Dwidth][,height=3Dheight]][[,cols=3Dco=
ls][,rows=3Drows]]\n"
>      "         [,mux=3Don|off][,logfile=3DPATH][,logappend=3Don|off]\n"
>      "-chardev ringbuf,id=3Did[,size=3Dsize][,logfile=3DPATH][,logappend=
=3Don|off]\n"
> -    "-chardev file,id=3Did,path=3Dpath[,mux=3Don|off][,logfile=3DPATH][,=
logappend=3Don|off]\n"
> +    "-chardev file,id=3Did,path=3Dpath[,in=3DPATH][,mux=3Don|off][,logfi=
le=3DPATH][,logappend=3Don|off]\n"
>      "-chardev pipe,id=3Did,path=3Dpath[,mux=3Don|off][,logfile=3DPATH][,=
logappend=3Don|off]\n"
>  #ifdef _WIN32
>      "-chardev console,id=3Did[,mux=3Don|off][,logfile=3DPATH][,logappend=
=3Don|off]\n"
> @@ -3137,13 +3137,16 @@ The available backends are:
>      Create a ring buffer with fixed size ``size``. size must be a power
>      of two and defaults to ``64K``.
>
> -``-chardev file,id=3Did,path=3Dpath``
> +``-chardev file,id=3Did,path=3Dpath,in=3Din``
>      Log all traffic received from the guest to a file.
>
>      ``path`` specifies the path of the file to be opened. This file will
>      be created if it does not already exist, and overwritten if it does.
>      ``path`` is required.
>
> +    ``in`` specifies a separate file as the input to the chardev. If
> +    ``in`` is omitted, ``path`` is used for both input and output
> +
>  ``-chardev pipe,id=3Did,path=3Dpath``
>      Create a two-way connection to the guest. The behaviour differs
>      slightly between Windows hosts and other hosts:
> --
> 2.26.2
>
>


--=20
Marc-Andr=C3=A9 Lureau

