Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF3CC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 07:53:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79D4D2082F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 07:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOPbg1eT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D4D2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWyKa-00069b-Kk
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 02:53:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iWyJn-0005iS-7m
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 02:53:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iWyJl-0000oK-Ug
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 02:52:59 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37829)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iWyJl-0000nn-Ma
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 02:52:57 -0500
Received: by mail-wm1-x343.google.com with SMTP id b17so2298903wmj.2
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 23:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2OrRiYkItlMKNSSA/GXqJJ5mHUg8MTHm/hT6XJF3qxQ=;
 b=UOPbg1eT4VHm9q9C80873y+0Wqg9DS5U9AXc3qfti5vEiobNZMD0rJYQTQTQzMyYju
 HgC5pheFWdsFbAEZ39WHsDrv5zFU2r+IiOTINIry/3KgJJhzd4zSWtktArSNqRWIQymj
 wk19dRaPjd1neHk5SgQ6mG0xs8stSsojPw1JzI4sj83fWKBKwp07IGbL+nrmCn735XQB
 LDKPa3Ifmj5NzSFCBP2EXbFvSPVDM+XiMHHiAzqKhwphBex/AhOV84rR5WWjy1W4fKP/
 X5ZMtXcSv191qteygZhLNpHtiwhVO67bqatY1S1asOdfiIbSfeRtvQuwqH3RPy/OOnFb
 zCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2OrRiYkItlMKNSSA/GXqJJ5mHUg8MTHm/hT6XJF3qxQ=;
 b=OOxQkhgRnMH2H92xmGD7KTGZ++7P5EluJoMTuUgnRiFhvOySod1FN42D404h2fUwDA
 hjhy9Vx5aFzvlbhngZs370RmCt8mzcE8VAunz/WInFzcHq1kRU/oF6mMukYQQVfGJQ51
 hdBSYHrORp/SU+Jo2zrCAohSsZx8ecWUyV1gWr8gKYDHGAYtKISKOFRnRRSW5SlhwvSN
 T8GBVLAqmbKRDz08TrC4uIVyVpeJ7Qct/r2Ph8h+VvLVvlW9HmQb4/wtVw9/dZl8NGen
 07u+Q3i6Zd2f+i4gsFhi+LQxRrvro3mp8RfRlZmAiX6PcEKuW4Oi09pA8KQ0bPfPSrq7
 M5sg==
X-Gm-Message-State: APjAAAWjPGeQIlUwRuRmORRE5CAw2BYn9UnZMUUAtm6qyoNJxcfwW4by
 1opEc4LYb64z6L+yps4mvsOITRobWsZh9alYw6NZBnBH
X-Google-Smtp-Source: APXvYqzJb0WeeV11wReAQsIok8aLyVQKLlxL3tV+yFirUK5skzH55i3rYYnFZhGCfE2c4ziSPLtB7crWpKTXYsYwNvg=
X-Received: by 2002:a05:600c:20e:: with SMTP id
 14mr3641310wmi.107.1574149975986; 
 Mon, 18 Nov 2019 23:52:55 -0800 (PST)
MIME-Version: 1.0
References: <20191119063911.18888-1-michan@redhat.com>
In-Reply-To: <20191119063911.18888-1-michan@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 19 Nov 2019 11:52:42 +0400
Message-ID: <CAJ+F1CJfX7mQTkdrUHHtDgYdNFsBTgX6F1Z=HJHcCJaUVXtBgA@mail.gmail.com>
Subject: Re: [PATCH v5] Implement backend program convention command for
 vhost-user-blk
To: Micky Yun Chan <chanmickyyun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: michan <michan@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Tue, Nov 19, 2019 at 10:40 AM Micky Yun Chan <chanmickyyun@gmail.com> wr=
ote:
>
> From: michan <michan@redhat.com>
>
> This patch is to add standard commands defined in docs/interop/vhost-user=
.rst

You should also follow and update docs/interop/vhost-user.json

> For vhost-user-* program
>
> Signed-off-by: Micky Yun Chan (michiboo) <chanmickyyun@gmail.com>
> ---
>  contrib/vhost-user-blk/vhost-user-blk.c | 109 ++++++++++++++----------
>  1 file changed, 65 insertions(+), 44 deletions(-)
>
> diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user=
-blk/vhost-user-blk.c
> index ae61034656..96c43bb58d 100644
> --- a/contrib/vhost-user-blk/vhost-user-blk.c
> +++ b/contrib/vhost-user-blk/vhost-user-blk.c
> @@ -576,70 +576,91 @@ vub_new(char *blk_file)
>      return vdev_blk;
>  }
>
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
> +        g_print("  \"type\": \"blk\",\n");

block

> +        g_print("  \"features\": [\n");
> +        g_print("    \"read-only\",\n");
> +        g_print("    \"blk-file\"\n");

We don't yet have a VHostUserBackendCapabilitiesBlock defined in
docs/interop/vhost-user.json


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
> @@ -647,8 +668,8 @@ err:
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
> --
> 2.21.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

