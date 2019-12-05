Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148ABC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 13:53:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1AC5224F8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 13:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6lfOMjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1AC5224F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icrZ5-0004Mk-BX
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 08:53:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49249)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1icrMB-0007qE-Qt
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:39:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1icrM9-0004hw-Tf
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:39:47 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45925)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1icrM7-0004eN-Vf
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:39:45 -0500
Received: by mail-wr1-x443.google.com with SMTP id j42so3593249wrj.12
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 05:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=BdM0n/nQk6kktthI0wibTMVkn3bLWQjeBHeZaBMxe54=;
 b=V6lfOMjXtDDiHW69bKLM/3jMarICVRMJ5Y3mwBUML7I1RtTSu9KlC9awps4pvV/5mk
 Ogq4fyEHz+t+alfHfne4b99HxKLgv1LV+e0z37XpbBLn/58YnW9jf7ZNzX+zAqTqxHRj
 SWwFCWbxg41mG7dyQtb/1u9HoehNmCOSRBunjLK12ZrhQ7pgNOBZ8fMZrnQ8isme67ad
 z8PuIBA/F2cX0fUSsV8wo3RybPoqyuXHxwlG5xtMF9oGPWERdduGzEcK3FmAefnsmDk3
 Prk9IFHE4pOkvkWt/CiNUo03ISmmCSlUdS0llkSpyIopfZVoB84cMr8SQYpBultMUA2b
 y28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BdM0n/nQk6kktthI0wibTMVkn3bLWQjeBHeZaBMxe54=;
 b=cKNunHIbzbTKyGuV4uhZJ2kQvTNLWUapChBcIRlfJbqbehextAZYdxeGaNOZfGdIyX
 sQBfddQjzhAEsUyhPBMWuu0fHfOjqopGFxNt9EEq1jjZSwerbRYMXbOUTnDhyHwdbRaN
 AAThi6QxWNC6LtQoQxhU5gJy6I9PkmUjuf+yByKIeZhRZq/yO3XmpPnI4JP/KQ6SJpWh
 2Z8BhX3WR13wp2DJf+TNfwXeyIGdrUgGoCnQ52mMvONDQJYouqAaU/qQI0TvbJyAas3I
 meL9pnCWbocoPfjcvfpl5+JIfAVE4Jzgu9qQilycD12Z6IuFXCqzTRpbkUffTcV0Xvym
 PRiw==
X-Gm-Message-State: APjAAAWYQZKGkf6x7ysvrR8ooXOrtLvi326HKfEKpVBrjOzcQ82I3Za7
 COjtGYzcMy8D20drYudkG97QvKRJM59XSBdw7pBB1uJN
X-Google-Smtp-Source: APXvYqx3h9RZNhghYxPymHSo3lnSHB2yCaBb6UGmfrNzdH4GyaZFgxOT1wA2ZSDS+GlQe3G11Ca97pAYEHgC2vZl6F8=
X-Received: by 2002:a5d:6350:: with SMTP id b16mr10431340wrw.132.1575553176950; 
 Thu, 05 Dec 2019 05:39:36 -0800 (PST)
MIME-Version: 1.0
References: <20191125051722.15523-1-chanmickyyun@gmail.com>
In-Reply-To: <20191125051722.15523-1-chanmickyyun@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 5 Dec 2019 17:39:24 +0400
Message-ID: <CAJ+F1CL-h3KrObUyKzGBjVra9EZPZFyK-WbW7=Co1Pn9YbypWA@mail.gmail.com>
Subject: Re: [PATCH v7] Implement backend program convention command for
 vhost-user-blk
To: "Micky Yun Chan(michiboo)" <chanmickyyun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Nov 25, 2019 at 9:17 AM Micky Yun Chan(michiboo)
<chanmickyyun@gmail.com> wrote:
>
> From: Micky Yun Chan <chanmickyyun@gmail.com>
>
> This patch is to add standard commands defined in docs/interop/vhost-user=
.rst
> For vhost-user-* program
>
> Signed-off-by: Micky Yun Chan (michiboo) <chanmickyyun@gmail.com>
> ---
>  contrib/vhost-user-blk/vhost-user-blk.c | 108 ++++++++++++++----------
>  docs/interop/vhost-user.json            |  31 +++++++
>  docs/interop/vhost-user.rst             |  15 ++++
>  3 files changed, 110 insertions(+), 44 deletions(-)
>
> diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user=
-blk/vhost-user-blk.c
> index ae61034656..6fd91c7e99 100644
> --- a/contrib/vhost-user-blk/vhost-user-blk.c
> +++ b/contrib/vhost-user-blk/vhost-user-blk.c
> @@ -576,70 +576,90 @@ vub_new(char *blk_file)
>      return vdev_blk;
>  }
>
> +static int opt_fdnum =3D -1;
> +static char *opt_socket_path;
> +static char *opt_blk_file;
> +static gboolean opt_print_caps;
> +static gboolean opt_read_only;
> +
> +static GOptionEntry entries[] =3D {
> +    { "print-capabilities", 'c', 0, G_OPTION_ARG_NONE, &opt_print_caps,
> +      "Print capabilities", NULL },
> +    { "fd", 'f', 0, G_OPTION_ARG_INT, &opt_fdnum,
> +      "Use inherited fd socket", "FDNUM" },
> +    { "socket-path", 's', 0, G_OPTION_ARG_FILENAME, &opt_socket_path,
> +      "Use UNIX socket path", "PATH" },
> +    {"blk-file", 'b', 0, G_OPTION_ARG_FILENAME, &opt_blk_file,
> +     "block device or file path", "PATH"},
> +    { "read-only", 'r', 0, G_OPTION_ARG_NONE, &opt_read_only,
> +      "Enable read-only", NULL }
> +};
> +
>  int main(int argc, char **argv)
>  {
> -    int opt;
> -    char *unix_socket =3D NULL;
> -    char *blk_file =3D NULL;
> -    bool enable_ro =3D false;
>      int lsock =3D -1, csock =3D -1;
>      VubDev *vdev_blk =3D NULL;
> +    GError *error =3D NULL;
> +    GOptionContext *context;
>
> -    while ((opt =3D getopt(argc, argv, "b:rs:h")) !=3D -1) {
> -        switch (opt) {
> -        case 'b':
> -            blk_file =3D g_strdup(optarg);
> -            break;
> -        case 's':
> -            unix_socket =3D g_strdup(optarg);
> -            break;
> -        case 'r':
> -            enable_ro =3D true;
> -            break;
> -        case 'h':
> -        default:
> -            printf("Usage: %s [ -b block device or file, -s UNIX domain =
socket"
> -                   " | -r Enable read-only ] | [ -h ]\n", argv[0]);
> -            return 0;
> +    context =3D g_option_context_new(NULL);
> +    g_option_context_add_main_entries(context, entries, NULL);
> +    if (!g_option_context_parse(context, &argc, &argv, &error)) {
> +        g_printerr("Option parsing failed: %s\n", error->message);
> +        exit(EXIT_FAILURE);
> +    }
> +    if (opt_print_caps) {
> +        g_print("{\n");
> +        g_print("  \"type\": \"block\",\n");
> +        g_print("  \"features\": [\n");
> +        g_print("    \"read-only\",\n");
> +        g_print("    \"blk-file\"\n");
> +        g_print("  ]\n");
> +        g_print("}\n");
> +        exit(EXIT_SUCCESS);
> +    }
> +
> +    if (!opt_blk_file) {
> +        g_print("%s\n", g_option_context_get_help(context, true, NULL));
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    if (opt_socket_path) {
> +        lsock =3D unix_sock_new(opt_socket_path);
> +        if (lsock < 0) {
> +            exit(EXIT_FAILURE);
>          }
> +    } else if (opt_fdnum < 0) {
> +        g_print("%s\n", g_option_context_get_help(context, true, NULL));
> +        exit(EXIT_FAILURE);
> +    } else {
> +        lsock =3D opt_fdnum;
>      }
>
> -    if (!unix_socket || !blk_file) {
> -        printf("Usage: %s [ -b block device or file, -s UNIX domain sock=
et"
> -               " | -r Enable read-only ] | [ -h ]\n", argv[0]);
> -        return -1;
> -    }
> -
> -    lsock =3D unix_sock_new(unix_socket);
> -    if (lsock < 0) {
> -        goto err;
> -    }
> -
> -    csock =3D accept(lsock, (void *)0, (void *)0);
> +    csock =3D accept(lsock, NULL, NULL);
>      if (csock < 0) {
> -        fprintf(stderr, "Accept error %s\n", strerror(errno));
> -        goto err;
> +        g_printerr("Accept error %s\n", strerror(errno));
> +        exit(EXIT_FAILURE);
>      }
>
> -    vdev_blk =3D vub_new(blk_file);
> +    vdev_blk =3D vub_new(opt_blk_file);
>      if (!vdev_blk) {
> -        goto err;
> +        exit(EXIT_FAILURE);
>      }
> -    if (enable_ro) {
> +    if (opt_read_only) {
>          vdev_blk->enable_ro =3D true;
>      }
>
>      if (!vug_init(&vdev_blk->parent, VHOST_USER_BLK_MAX_QUEUES, csock,
>                    vub_panic_cb, &vub_iface)) {
> -        fprintf(stderr, "Failed to initialized libvhost-user-glib\n");
> -        goto err;
> +        g_printerr("Failed to initialize libvhost-user-glib\n");
> +        exit(EXIT_FAILURE);
>      }
>
>      g_main_loop_run(vdev_blk->loop);
> -
> +    g_main_loop_unref(vdev_blk->loop);
> +    g_option_context_free(context);
>      vug_deinit(&vdev_blk->parent);
> -
> -err:
>      vub_free(vdev_blk);
>      if (csock >=3D 0) {
>          close(csock);
> @@ -647,8 +667,8 @@ err:
>      if (lsock >=3D 0) {
>          close(lsock);
>      }
> -    g_free(unix_socket);
> -    g_free(blk_file);
> +    g_free(opt_socket_path);
> +    g_free(opt_blk_file);
>
>      return 0;
>  }
> diff --git a/docs/interop/vhost-user.json b/docs/interop/vhost-user.json
> index da6aaf51c8..ce0ef74db5 100644
> --- a/docs/interop/vhost-user.json
> +++ b/docs/interop/vhost-user.json
> @@ -54,6 +54,37 @@
>    ]
>  }
>
> +##
> +# @VHostUserBackendBlockFeature:
> +#
> +# List of vhost user "block" features.
> +#
> +# @read-only: The --read-only command line option is supported.
> +# @blk-file: The --blk-file command line option is supported.
> +#
> +# Since: 5.0
> +##
> +{
> +  'enum': 'VHostUserBackendBlockFeature',
> +  'data': [ 'read-only', 'blk-file' ]
> +}
> +
> +##
> +# @VHostUserBackendCapabilitiesBlock:
> +#
> +# Capabilities reported by vhost user "block" backends
> +#
> +# @features: list of supported features.
> +#
> +# Since: 5.0
> +##
> +{
> +  'struct': 'VHostUserBackendCapabilitiesBlock',
> +  'data': {
> +    'features': [ 'VHostUserBackendBlockFeature' ]
> +  }
> +}
> +
>  ##
>  # @VHostUserBackendInputFeature:
>  #
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 7827b710aa..2f0910d515 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -1376,3 +1376,18 @@ Command line options:
>    Enable virgl rendering support.
>
>    (optional)
> +
> +vhost-user-blk
> +--------------
> +
> +Command line options:
> +
> +--blk-file=3DPATH
> +
> +  Specify block device or file path.

Would it make sense to make it optional? Since you have a
corresponding "blk-file" feature already, there is not much to change
but the doc.

> +
> +--read-only
> +
> +  Enable read-only.
> +
> +  (optional)
> --
> 2.21.0
>
>

Looks good to me otherwise

--=20
Marc-Andr=C3=A9 Lureau

