Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E435DC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 10:23:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF8842071B
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 10:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lv3Va4Gc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8842071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWeBg-0006h6-N4
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 05:23:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iWeAG-0005ED-O1
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 05:21:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iWeAD-0001aU-TF
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 05:21:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50185
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iWeAD-0001ZB-6Z
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 05:21:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574072504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/h5jTaooc6w6I91PXMnHJHijsAUxPefTL59bB9qD/A4=;
 b=Lv3Va4GcLYwir2g/vwCIDh6E8Qi1lt/nuhpGa2UZUZPyvxEBC2Dy3ihCQYQIl0HX+l2gdn
 lKamR9jd4+7oZeTAVT4iNpmEN/pple5bSRtQgfbPj/C5zPuXMQNblJqC2ohnf5AQgo44rx
 VOym21Hbm6mDaqzGBU9qNJ1Bi+coATg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-w79rEzj-Px6as4tIFhB7sg-1; Mon, 18 Nov 2019 05:21:43 -0500
Received: by mail-qt1-f198.google.com with SMTP id v92so11915381qtd.18
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 02:21:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vhDgsN7E1oYZ8Ov1QNwgdLgBq7ApVcGt3xbzxS6Zwrs=;
 b=iagBnf1fJqswRbgksBqE8Chx0sNTcThXqITEFEckxH7Q07VWmH4sK+k/BvomdXFzdj
 Y9kE+k4rJsEkZNkZBJXCQ0zcszvOS1PKM0ACHAhw76otoe7DiHBUjpuggYDc34a9DMQM
 bQyIz2MfPcNiUAF/z3NBAnWxy7a+6Wmhre4KFvAVCPy7caSNdvB4dyZhz+PAV961Fd+U
 Y3YeGOdlpF4cpnMcrTN1FPsF31AZZqxNO+QaJLD6g50e3XGyATM5SpScaPAuneGD9jQ2
 8L+iw3FRVPV0e4kdlitzE4vom6EUpCAyS2eUGXsw0bGqCuQIz3FfvRBb9KOuTDuaVxY/
 YsIw==
X-Gm-Message-State: APjAAAXyRtDFMz+vD8uxb7eXUD/DXNbIP4HoRC2HXTJiYoLc1AbGiLtc
 ZZXusIsFu0TVtMuF+QetMCyL/YoIOkDc0Xr/GtdqyKmwPE2Y2CKr580bjHs3S81E9N6VW1lA7vb
 40RR5gcvkSpf8g4Y=
X-Received: by 2002:ac8:3386:: with SMTP id c6mr26917755qtb.115.1574072502064; 
 Mon, 18 Nov 2019 02:21:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqwyVtf/z+sbv3VTXq2wW4SvB38EuBlZXlZvXc7ikthZi4g2bjSMC3F9c0R/P2ZfE8UkfAH2KA==
X-Received: by 2002:ac8:3386:: with SMTP id c6mr26917738qtb.115.1574072501839; 
 Mon, 18 Nov 2019 02:21:41 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id n21sm10516898qtn.33.2019.11.18.02.21.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2019 02:21:41 -0800 (PST)
Date: Mon, 18 Nov 2019 05:21:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Micky Yun Chan <chanmickyyun@gmail.com>
Subject: Re: [PATCH v2] Implement backend program convention command for
 vhost-user-blk
Message-ID: <20191118052002-mutt-send-email-mst@kernel.org>
References: <20191118064519.16072-1-michan@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191118064519.16072-1-michan@redhat.com>
X-MC-Unique: w79rEzj-Px6as4tIFhB7sg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: michan <michan@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 18, 2019 at 02:45:19PM +0800, Micky Yun Chan wrote:
> Subject: Re: [PATCH v2] Implement backend program convention command for =
vhost-user-blk

subject is not clear to me.

> From: michan <michan@redhat.com>
>

Add patch description pls.
=20
> Signed-off-by: Micky Yun Chan (michiboo) <chanmickyyun@gmail.com>
> ---
>  contrib/vhost-user-blk/vhost-user-blk.c | 102 ++++++++++++++----------
>  1 file changed, 58 insertions(+), 44 deletions(-)
>=20
> diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user=
-blk/vhost-user-blk.c
> index ae61034656..8759b6a5d0 100644
> --- a/contrib/vhost-user-blk/vhost-user-blk.c
> +++ b/contrib/vhost-user-blk/vhost-user-blk.c
> @@ -576,70 +576,84 @@ vub_new(char *blk_file)
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
> +static GOptionEntry entries[] =3D {
> +    { "print-capabilities", 'c', 0, G_OPTION_ARG_NONE, &opt_print_caps,
> +      "Print capabilities", NULL },

It merely seems to print help.=20

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
> +        g_option_context_get_help(context, true, NULL);
> +        exit(EXIT_SUCCESS);
> +    }
> +
> +    if (!opt_blk_file) {
> +        g_option_context_get_help(context, true, NULL);
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    if (opt_socket_path) {
> +        lsock =3D unix_sock_new(opt_socket_path);
> +        if (lsock < 0) {
> +           exit(EXIT_FAILURE);
>          }
> +    } else if(opt_fdnum < 0){
> +        g_option_context_get_help(context, true, NULL);
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
> +        g_printerr("Failed to initialized libvhost-user-glib\n");

as long as you are fixing it, initialized->initialize
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
> @@ -647,8 +661,8 @@ err:
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


