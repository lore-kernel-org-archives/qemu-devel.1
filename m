Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C98C00454
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 16:02:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C74502073D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 16:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5bcBplO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74502073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if4R4-0007es-Ja
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 11:01:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39203)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1if4Oy-00060N-NW
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 10:59:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1if4Ox-0005XI-3C
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 10:59:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25693
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1if4Ow-0005Wj-UM
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 10:59:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576079986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gtMHkdFg9el+TZC9Ty4EySCbSaf+M0hWeUGCmxKyr1k=;
 b=N5bcBplOVfr1uR/NiBSlwuWd+5RimNscZRH1XaePpbupAedpPMZKLjsSPGqfyXcWK6LRAb
 wabsJtPkeB67/KkrlO0va6L6wA8EItybMdh8YxzDUiheaHFdBPuDfnUtTivnUFOcf9sSiM
 wJQb0M99A77Zdymw/Gm//5Y+ERZM/JM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-7nBYftxPOGK4wVlLDcD9uw-1; Wed, 11 Dec 2019 10:59:45 -0500
Received: by mail-qv1-f70.google.com with SMTP id g15so9348315qvq.20
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 07:59:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wbENiEGzH6MA0xqiUoIWB82AkIC5fLaqVGVHU1z/V8I=;
 b=fpLJknH8uWixIFEO1XDPDFqFEzB4vumywYm5sP0E0pfBCj30YpbbUBpeoShzDut+uK
 V8wp6xXie8tiYydMAlE/U4KIJukBAEyOln3zRWQ/4ofACVl6n3+1n6v03c/nFqyJRXUL
 S04rPkdiEW8+b78DKB2O2hGC8QbknJCwJuzB+o1hOTtqoESz4yBcjmf+yJb9CmMsTkAF
 F1c1JxS5d47dalesUGrPm9a7uMHt8t30PBNnJa7j4wIop2d6zWB1iDYDvfxEB3/BLi9R
 HNlZ9UOR+PGexWimiW1Ga5V/QUpcx0DDXX7VEZVHSeKqaQmCPrhRmtrav5VCZ/Ion1Cc
 BhPQ==
X-Gm-Message-State: APjAAAWV/K5yVId9cyJWo1ocJWktRYrMI25Ogl1nSL7tk2tSax8Xodvh
 f6eSjSYD1jLlMnFGTJftSX8zC3MOxnDEap88ZaE0yJwA6IvzPS3wNhwo6UiWYZcvwUCFU1/wcB9
 FtAQtijsKR1Zgep8=
X-Received: by 2002:ac8:34d0:: with SMTP id x16mr3499396qtb.127.1576079983272; 
 Wed, 11 Dec 2019 07:59:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqx4KYdm6JO/gJIZMrVLILoV+tcazevzybZRpfbpaLLl7Njn2iKmCRoQ8vmpObqjLua9rRSOAw==
X-Received: by 2002:ac8:34d0:: with SMTP id x16mr3499381qtb.127.1576079982998; 
 Wed, 11 Dec 2019 07:59:42 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id i8sm1026968qtr.24.2019.12.11.07.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 07:59:42 -0800 (PST)
Date: Wed, 11 Dec 2019 10:59:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Micky Yun Chan(michiboo)" <chanmickyyun@gmail.com>
Subject: Re: [PATCH v8] Implement backend program convention command for
 vhost-user-blk
Message-ID: <20191211105916-mutt-send-email-mst@kernel.org>
References: <20191209015331.5455-1-chanmickyyun@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20191209015331.5455-1-chanmickyyun@gmail.com>
X-MC-Unique: 7nBYftxPOGK4wVlLDcD9uw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Dec 09, 2019 at 09:53:31AM +0800, Micky Yun Chan(michiboo) wrote:
> From: Micky Yun Chan <chanmickyyun@gmail.com>
>=20
> This patch is to add standard commands defined in docs/interop/vhost-user=
.rst
> For vhost-user-* program
>=20
> Signed-off-by: Micky Yun Chan (michiboo) <chanmickyyun@gmail.com>

Thanks!
I'll queue it for merge after the release. If possible please ping me
after the release to help make sure it didn't get dropped.

> ---
>  contrib/vhost-user-blk/vhost-user-blk.c | 108 ++++++++++++++----------
>  docs/interop/vhost-user.json            |  31 +++++++
>  docs/interop/vhost-user.rst             |  17 ++++
>  3 files changed, 112 insertions(+), 44 deletions(-)
>=20
> diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user=
-blk/vhost-user-blk.c
> index ae61034656..6fd91c7e99 100644
> --- a/contrib/vhost-user-blk/vhost-user-blk.c
> +++ b/contrib/vhost-user-blk/vhost-user-blk.c
> @@ -576,70 +576,90 @@ vub_new(char *blk_file)
>      return vdev_blk;
>  }
> =20
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
> =20
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
> =20
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
> =20
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
> =20
>      if (!vug_init(&vdev_blk->parent, VHOST_USER_BLK_MAX_QUEUES, csock,
>                    vub_panic_cb, &vub_iface)) {
> -        fprintf(stderr, "Failed to initialized libvhost-user-glib\n");
> -        goto err;
> +        g_printerr("Failed to initialize libvhost-user-glib\n");
> +        exit(EXIT_FAILURE);
>      }
> =20
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
> =20
>      return 0;
>  }
> diff --git a/docs/interop/vhost-user.json b/docs/interop/vhost-user.json
> index da6aaf51c8..ce0ef74db5 100644
> --- a/docs/interop/vhost-user.json
> +++ b/docs/interop/vhost-user.json
> @@ -54,6 +54,37 @@
>    ]
>  }
> =20
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
> index 7827b710aa..015ac08177 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -1376,3 +1376,20 @@ Command line options:
>    Enable virgl rendering support.
> =20
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
> +
> +  (optional)
> +
> +--read-only
> +
> +  Enable read-only.
> +
> +  (optional)
> --=20
> 2.21.0


