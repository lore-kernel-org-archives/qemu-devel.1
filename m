Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCCEC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 10:41:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58C97222ED
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 10:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NUl6sw1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C97222ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX0wu-0002fa-Gc
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 05:41:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iX0wF-0002ED-LF
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 05:40:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iX0wD-0002jD-R8
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 05:40:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50161
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iX0wD-0002iT-Ca
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 05:40:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574160047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HiIYls+a8CGUpHVgzskVar6M+47ZpH5X+x1/Zsss8tw=;
 b=NUl6sw1b9rgfJVf8uvtDHSz7VOGvaC98zYc4yewcUUL1FGHSzTUStEfu6Rvxo08+1dvL5s
 1pVsieEuOgaNLVtDrGb0AOvKvg9aCSt9NZ8V2lLAfRxVr43PCqgmrXmKgl5arJh2yc+9x5
 JS9sdoqHRlzUXfa/Dfn89U0gRU5L828=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-w7PGP4kxNieVfxBPQnfLmQ-1; Tue, 19 Nov 2019 05:40:46 -0500
Received: by mail-qk1-f200.google.com with SMTP id 22so13292242qka.23
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 02:40:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=swit2IlMaaXMY5KxMhMGxVmxg2LrVHvr5WXF9+E/Ccw=;
 b=lX1tA8RC7FRWDdtvFUgryWRDlmoodX2jXEUFSmPoDFQuXbAEoXw1Y3DodlFZyQSbd9
 Ah+DuX5FyyvCFyRDnp7I044qt3/TJeVADjpw7BDi802d7sr4doGtC1PkqrtFslczEYpT
 ccazyvT6o8D+1zp23bgf+/Xd0rX1ROrNQyeVqHUPpcmVA6NDxetVqJ88ep/NvHyVjPY/
 zVFP4OxOLVV/A0HRkdP6S2t/k8C/x77rTttvZd3Z+Utuo+9VTjVmUuJb2q+vUE99L5Uc
 UcksvWpzDw8N3dwUL/lDU+qpU3X79pspfOGom2jYCENIgTRZYoFn95gbu6XclZ0dMfrr
 OW9w==
X-Gm-Message-State: APjAAAXDf1QpEdVbeeWt/QYN3x0cXPRp5LwOg6mROLFIkSqhX1BB80M3
 xrc1cMI+OdupA7Dliz4lhfXZBSj+PXWIrr4tuQ6zSAfMsZhm9e3BMPcw8lZnfjJ6BxUwVRN4sBs
 8EoEz9htvBYFUoqY=
X-Received: by 2002:a05:620a:a91:: with SMTP id
 v17mr28135418qkg.281.1574160045628; 
 Tue, 19 Nov 2019 02:40:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqzufaLnJgO+rgZc8hSqbh7l92YpnlpH5EJeicsMPV4sHlh0Y5Clkxmy2o3VD0uRQQnKla3wCA==
X-Received: by 2002:a05:620a:a91:: with SMTP id
 v17mr28135397qkg.281.1574160045252; 
 Tue, 19 Nov 2019 02:40:45 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id 11sm11852488qtx.45.2019.11.19.02.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2019 02:40:44 -0800 (PST)
Date: Tue, 19 Nov 2019 05:40:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Micky Yun Chan <chanmickyyun@gmail.com>
Subject: Re: [PATCH v5] Implement backend program convention command for
 vhost-user-blk
Message-ID: <20191119054004-mutt-send-email-mst@kernel.org>
References: <20191119063911.18888-1-michan@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191119063911.18888-1-michan@redhat.com>
X-MC-Unique: w7PGP4kxNieVfxBPQnfLmQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: michan <michan@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 19, 2019 at 02:39:11PM +0800, Micky Yun Chan wrote:
> From: michan <michan@redhat.com>
>=20
> This patch is to add standard commands defined in docs/interop/vhost-user=
.rst
> For vhost-user-* program
>=20
> Signed-off-by: Micky Yun Chan (michiboo) <chanmickyyun@gmail.com>


lots of comments by others already, just adding a minor nit:

> ---
>  contrib/vhost-user-blk/vhost-user-blk.c | 109 ++++++++++++++----------
>  1 file changed, 65 insertions(+), 44 deletions(-)
>=20
> diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user=
-blk/vhost-user-blk.c
> index ae61034656..96c43bb58d 100644
> --- a/contrib/vhost-user-blk/vhost-user-blk.c
> +++ b/contrib/vhost-user-blk/vhost-user-blk.c
> @@ -576,70 +576,91 @@ vub_new(char *blk_file)
>      return vdev_blk;
>  }
> =20
> +static int opt_fdnum =3D -1;
> +static char *opt_socket_path;
> +static char *opt_blk_file;
> +static gboolean opt_print_caps;
> +static gboolean opt_read_only;
> +
> +

single empty line please.

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
> +        g_print("  \"type\": \"blk\",\n");
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
> @@ -647,8 +668,8 @@ err:
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
> --=20
> 2.21.0


