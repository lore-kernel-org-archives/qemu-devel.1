Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D08FC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 13:55:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27BD3224F8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 13:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c730gtjL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27BD3224F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icrbW-00074w-RU
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 08:55:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1icrRK-0005rX-Kw
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:45:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1icrRI-00053P-TR
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:45:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33151
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1icrRI-00051U-NA
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:45:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575553504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B+4K7Lv6+32d1413V8rOjW+m2OjWEX9HjJjQ/snf2xc=;
 b=c730gtjLuV8OCJuBDfqrxNp1V0oWCxMiQOO9OxHhbzBcASkSBH9LhR08r0kRGhvOjkzVPm
 +QoPGT25jHU0zgaFiuoKCv2vdZUu0r6+7vlj22pXa+U2L0jZQI1yIxgGCR+p0wysQCQPLG
 1iPH9mdbVzbcQRonFCE+X8awbIsz2UA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-0Yc9P9gCPbGgJuFNoGpzOA-1; Thu, 05 Dec 2019 07:44:04 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCE141856A66;
 Thu,  5 Dec 2019 12:44:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B5F5560135;
 Thu,  5 Dec 2019 12:43:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 492371138606; Thu,  5 Dec 2019 13:43:55 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: "Micky Yun Chan\(michiboo\)" <chanmickyyun@gmail.com>
Subject: Re: [PATCH v7] Implement backend program convention command for
 vhost-user-blk
References: <20191125051722.15523-1-chanmickyyun@gmail.com>
Date: Thu, 05 Dec 2019 13:43:55 +0100
In-Reply-To: <20191125051722.15523-1-chanmickyyun@gmail.com> (Micky Yun Chan's
 message of "Mon, 25 Nov 2019 13:17:22 +0800")
Message-ID: <87wobbt01g.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 0Yc9P9gCPbGgJuFNoGpzOA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Marc-Andr=C3=A9 for docs/vhost-user.json expertise.

"Micky Yun Chan(michiboo)" <chanmickyyun@gmail.com> writes:

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
> index 7827b710aa..2f0910d515 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -1376,3 +1376,18 @@ Command line options:
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
> +--read-only
> +
> +  Enable read-only.
> +
> +  (optional)


