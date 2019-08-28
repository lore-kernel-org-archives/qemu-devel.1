Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E7FC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 09:39:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 534A620828
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 09:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oMYRKTyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 534A620828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2uPy-00052U-Ci
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 05:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1i2uOJ-0003sW-6V
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1i2uOI-0001i2-0m
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:37:23 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36921)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1i2uOH-0001hg-R6
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:37:21 -0400
Received: by mail-wm1-x342.google.com with SMTP id d16so2098109wme.2
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 02:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=z3CczX7J4T23sB/Bn6aN3O/VnI4ARtIfwzuvtNdRADg=;
 b=oMYRKTyCOeterHCOxpLr5ike5BFaTLUYg5NxdVVM/x5xtG+i/K+Jv1lZ6UOqstjEKZ
 XhDgbsO0N85T/mXQDk0OsMP3s/FdzBVWG1Z0Mt57xzWc8WPe7tKrNUhWhRjl/tZfp6FM
 N7dw5JCLuzqOJwXIdy1xmKatY7OLeFWwvHcoXXwnZc5DxMCIJi+ZIENxtCvbH/1ymi2T
 R6hmmsDYoPyCvRjOEGTVumjbY+GomQ0GFynx/AD2EXrtHw/KyRQGgvplLrhIkzPQUzqv
 Z5nmYZVSBuP9J+W6fJA67SoFUNqL9j+8VmGEt90AIhquPemLNvtlA3vb9U7Z7XMdM0Pd
 w2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=z3CczX7J4T23sB/Bn6aN3O/VnI4ARtIfwzuvtNdRADg=;
 b=gqF/MJpS7BdYL+miDfthkwh0BX99bVklV3lgFO7mntlJ2llM8oX/rlecQsJ/7t4WiI
 QaG2YrviZuGk98qYiBFuIuY+xOboCNArLONBY2FHv/En/KSDvYhGB6P1w1QE3nf7J2KW
 L7EpxNrGJU4XtHCXHseGdvNvy3T6mCzrRKF/Ji6srUwmM3D4GAk8W0pBBTcI//wQQjSs
 cuIhQxWi1nMB1FGVYKjTk82CWQ6+nmrmgMLvg8lfScFCIQNpZUV6Bv+lPZQbxq6hfmOY
 uqm4LrfklOYdKXwnj6wpuugZ5DwHfyZOGhHwettxHemLPrAXoMyKqc3NRBP8fB9bHDzV
 60mg==
X-Gm-Message-State: APjAAAWjmaGd4YyC27/IneojIyauxwFP/D2dK7Mz60VmxDlGPun+a4z8
 TE0H7e5fS+5oi0ZKTcVw3sIoR2T12Pr6TlkflRM=
X-Google-Smtp-Source: APXvYqxBThq0SnDA2nTtk6caiDzpX5Oj8rb4S/AThGJkqrEXaeEyg7rtT/zFYhL8525MCL2/zhNZAcBeTj+9kOwrcSs=
X-Received: by 2002:a1c:f702:: with SMTP id v2mr3768313wmh.114.1566985040389; 
 Wed, 28 Aug 2019 02:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190828083401.2342-1-johannes@sipsolutions.net>
In-Reply-To: <20190828083401.2342-1-johannes@sipsolutions.net>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 28 Aug 2019 13:37:08 +0400
Message-ID: <CAJ+F1CJrHboX5ROiPP6_gccmWEwn3mc2wG0Ui=rpCPiP3sJSFg@mail.gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v4] libvhost-user-glib: fix VugDev main fd
 cleanup
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
Cc: QEMU <qemu-devel@nongnu.org>, Johannes Berg <johannes.berg@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 28, 2019 at 12:37 PM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> From: Johannes Berg <johannes.berg@intel.com>
>
> If you try to make a device implementation that can handle multiple
> connections and allow disconnections (which requires overriding the
> VHOST_USER_NONE handling), then glib will warn that we remove a src
> while it's still on the mainloop, and will poll() an FD that doesn't
> exist anymore.
>
> Fix this by making vug_source_new() require pairing with the new
> vug_source_destroy() so we can keep the GSource referenced in the
> meantime.
>
> Note that this requires calling the new API in vhost-user-input.
> vhost-user-gpu also uses vug_source_new(), but never seems to free
> the result at all, so I haven't changed anything there.
>
> Fixes: 8bb7ddb78a1c ("libvhost-user: add glib source helper")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  contrib/libvhost-user/libvhost-user-glib.c | 15 ++++++++++++---
>  contrib/libvhost-user/libvhost-user-glib.h |  1 +
>  contrib/vhost-user-input/main.c            |  6 ++----
>  3 files changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user-glib.c b/contrib/libvhos=
t-user/libvhost-user-glib.c
> index 99edd2f3de45..824c7780de61 100644
> --- a/contrib/libvhost-user/libvhost-user-glib.c
> +++ b/contrib/libvhost-user/libvhost-user-glib.c
> @@ -91,7 +91,6 @@ vug_source_new(VugDev *gdev, int fd, GIOCondition cond,
>      g_source_add_poll(gsrc, &src->gfd);
>      id =3D g_source_attach(gsrc, NULL);
>      g_assert(id);
> -    g_source_unref(gsrc);
>
>      return gsrc;
>  }
> @@ -131,6 +130,16 @@ static void vug_watch(VuDev *dev, int condition, voi=
d *data)
>      }
>  }
>
> +void vug_source_destroy(GSource *src)
> +{
> +    if (!src) {
> +        return;
> +    }
> +
> +    g_source_destroy(src);
> +    g_source_unref(src);
> +}
> +
>  bool
>  vug_init(VugDev *dev, uint16_t max_queues, int socket,
>           vu_panic_cb panic, const VuDevIface *iface)
> @@ -144,7 +153,7 @@ vug_init(VugDev *dev, uint16_t max_queues, int socket=
,
>      }
>
>      dev->fdmap =3D g_hash_table_new_full(NULL, NULL, NULL,
> -                                       (GDestroyNotify) g_source_destroy=
);
> +                                       (GDestroyNotify) vug_source_destr=
oy);
>
>      dev->src =3D vug_source_new(dev, socket, G_IO_IN, vug_watch, NULL);
>
> @@ -157,5 +166,5 @@ vug_deinit(VugDev *dev)
>      g_assert(dev);
>
>      g_hash_table_unref(dev->fdmap);
> -    g_source_unref(dev->src);
> +    vug_source_destroy(dev->src);
>  }
> diff --git a/contrib/libvhost-user/libvhost-user-glib.h b/contrib/libvhos=
t-user/libvhost-user-glib.h
> index 64d539d93aba..1a79a4916ef2 100644
> --- a/contrib/libvhost-user/libvhost-user-glib.h
> +++ b/contrib/libvhost-user/libvhost-user-glib.h
> @@ -31,5 +31,6 @@ void vug_deinit(VugDev *dev);
>
>  GSource *vug_source_new(VugDev *dev, int fd, GIOCondition cond,
>                          vu_watch_cb vu_cb, gpointer data);
> +void vug_source_destroy(GSource *src);
>
>  #endif /* LIBVHOST_USER_GLIB_H */
> diff --git a/contrib/vhost-user-input/main.c b/contrib/vhost-user-input/m=
ain.c
> index 449fd2171a5a..a990b3ea9e33 100644
> --- a/contrib/vhost-user-input/main.c
> +++ b/contrib/vhost-user-input/main.c
> @@ -187,7 +187,7 @@ vi_queue_set_started(VuDev *dev, int qidx, bool start=
ed)
>      }
>
>      if (!started && vi->evsrc) {
> -        g_source_destroy(vi->evsrc);
> +        vug_source_destroy(vi->evsrc);
>          vi->evsrc =3D NULL;
>      }
>  }
> @@ -401,9 +401,7 @@ main(int argc, char *argv[])
>
>      vug_deinit(&vi.dev);
>
> -    if (vi.evsrc) {
> -        g_source_unref(vi.evsrc);
> -    }
> +    vug_source_destroy(vi.evsrc);
>      g_array_free(vi.config, TRUE);
>      g_free(vi.queue);
>      return 0;
> --
> 2.23.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

