Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74931C00307
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 07:54:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41179218AC
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 07:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjB+ckJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41179218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7EUr-0002Ut-ER
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 03:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1i7EUB-00023k-Az
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 03:53:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1i7EUA-0005wM-4J
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 03:53:19 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:52962)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1i7EU9-0005vy-Ub
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 03:53:18 -0400
Received: by mail-wm1-x336.google.com with SMTP id t17so12593146wmi.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 00:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=w9NpNnJaNREvdBFT4q+JQ7KpUAzVh7iCnPjg0jSy4CA=;
 b=BjB+ckJfjah+oKV8qBDhHfpvsF2T8N6o1lYJgHH4mff1IrsgU4xeugbRNIJCFWvMJT
 brVI6mDLUkXw4pa1oHJRZPN+9fy6mRMEHCZUlfA1dYD6oIGiOPyg0h3bguGRHe+wDafa
 sTzk552pG9Z9XZGLrMFR+8T1JYiUC+fV0KBcsyMQgjlzMrlHd//3qb6DqvKEUZm/s8ru
 1SVLRegdxOvFVHQgRPIbMMteuY96tR+3XwfWgxEvCswE55v0FbVapElMDFc4ilBLTxId
 GKH3WDYBGh01rvo2KyL3RJfaYpx15NK1zg7MABG+Hj9ezhQHi1+rvkg8rMTn9XgU+QBd
 H4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=w9NpNnJaNREvdBFT4q+JQ7KpUAzVh7iCnPjg0jSy4CA=;
 b=MlrUjdbQKiy/cOaWzl/X1Ruiabos7euQRf/1Wrw10jdYWey/jrQ4fUuKocVFv1ONPS
 lHM/sEKFM5NaPPtqboP3QxArw+KjrSS0eVDa+5doBAmn23XrLayy3rpvEt6pFsp7qZYQ
 pdpEabJ8uzn833pS8dz6G3a0ubyJ4ogb78puu26Xfk273CdvKMydPTFUGDvai8WKxGW6
 BKDCEwi/Nj2VbWnZAcZvtyG+Ek0uXZrpwVhNASuLWyIBri/CDJEBWBunI77O1kDtC/3P
 B9FakCGveSCcDhy6DoWdcjFkS/vimXoxAqyji0lBiPzGJfYLNXhl5aZH+UGubBIjeHxo
 FEfA==
X-Gm-Message-State: APjAAAVon2v3+OCysAV2UoWO+/xl4pStXt3hNvX8eM38+4ql5cPrX16p
 pK4beYkQa14J3Wpzek3Uunb/H6DU0TwSkOXWGi4=
X-Google-Smtp-Source: APXvYqx3uQdsV+T+cniLcqsaw/GI6whASPlYMm0hhyZn6kLa59rtHG0e7R1YwzesfPxaSlYhFLxcEKNHjAKxFxFmrnI=
X-Received: by 2002:a1c:9615:: with SMTP id y21mr13182404wmd.5.1568015596279; 
 Mon, 09 Sep 2019 00:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190909073911.24787-1-kraxel@redhat.com>
In-Reply-To: <20190909073911.24787-1-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 9 Sep 2019 11:53:03 +0400
Message-ID: <CAJ+F1C+8YeNYQQEoYGYHpMro=QXQki2Pni4x5Y-dJwhu7k71Mw@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
Subject: Re: [Qemu-devel] [PATCH] ui/egl: fix framebuffer reads
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Sep 9, 2019 at 11:40 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Fix egl_fb_read() to use the (destination) surface size instead of the
> (source) framebuffer source for glReadPixels.  Pass the DisplaySurface
> instead of the pixeldata pointer to egl_fb_read() to make this possible.
>
> With that in place framebuffer reads work fine even if the surface and
> framebuffer sizes don't match, so we can remove the guest-triggerable
> asserts in egl_scanout_flush().
>
> Buglink: https://bugzilla.redhat.com//show_bug.cgi?id=3D1749659
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

And if the the destinaton surface is larger than the source:
GLREADPIXELS(3G)
"Values for pixels that lie outside the window connected to the
current GL context are undefined."

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  include/ui/egl-helpers.h | 2 +-
>  ui/egl-headless.c        | 4 +---
>  ui/egl-helpers.c         | 6 +++---
>  3 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
> index dad19e9873fb..94a4b3e6f3bd 100644
> --- a/include/ui/egl-helpers.h
> +++ b/include/ui/egl-helpers.h
> @@ -25,7 +25,7 @@ void egl_fb_setup_for_tex(egl_fb *fb, int width, int he=
ight,
>                            GLuint texture, bool delete);
>  void egl_fb_setup_new_tex(egl_fb *fb, int width, int height);
>  void egl_fb_blit(egl_fb *dst, egl_fb *src, bool flip);
> -void egl_fb_read(void *dst, egl_fb *src);
> +void egl_fb_read(DisplaySurface *dst, egl_fb *src);
>
>  void egl_texture_blit(QemuGLShader *gls, egl_fb *dst, egl_fb *src, bool =
flip);
>  void egl_texture_blend(QemuGLShader *gls, egl_fb *dst, egl_fb *src, bool=
 flip,
> diff --git a/ui/egl-headless.c b/ui/egl-headless.c
> index 05b2e7d7b17f..fe2a0d1eab98 100644
> --- a/ui/egl-headless.c
> +++ b/ui/egl-headless.c
> @@ -133,8 +133,6 @@ static void egl_scanout_flush(DisplayChangeListener *=
dcl,
>      if (!edpy->guest_fb.texture || !edpy->ds) {
>          return;
>      }
> -    assert(surface_width(edpy->ds)  =3D=3D edpy->guest_fb.width);
> -    assert(surface_height(edpy->ds) =3D=3D edpy->guest_fb.height);
>      assert(surface_format(edpy->ds) =3D=3D PIXMAN_x8r8g8b8);
>
>      if (edpy->cursor_fb.texture) {
> @@ -149,7 +147,7 @@ static void egl_scanout_flush(DisplayChangeListener *=
dcl,
>          egl_fb_blit(&edpy->blit_fb, &edpy->guest_fb, edpy->y_0_top);
>      }
>
> -    egl_fb_read(surface_data(edpy->ds), &edpy->blit_fb);
> +    egl_fb_read(edpy->ds, &edpy->blit_fb);
>      dpy_gfx_update(edpy->dcl.con, x, y, w, h);
>  }
>
> diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> index edc53f6d3464..7c530c2825be 100644
> --- a/ui/egl-helpers.c
> +++ b/ui/egl-helpers.c
> @@ -102,12 +102,12 @@ void egl_fb_blit(egl_fb *dst, egl_fb *src, bool fli=
p)
>                        GL_COLOR_BUFFER_BIT, GL_LINEAR);
>  }
>
> -void egl_fb_read(void *dst, egl_fb *src)
> +void egl_fb_read(DisplaySurface *dst, egl_fb *src)
>  {
>      glBindFramebuffer(GL_READ_FRAMEBUFFER, src->framebuffer);
>      glReadBuffer(GL_COLOR_ATTACHMENT0_EXT);
> -    glReadPixels(0, 0, src->width, src->height,
> -                 GL_BGRA, GL_UNSIGNED_BYTE, dst);
> +    glReadPixels(0, 0, surface_width(dst), surface_height(dst),
> +                 GL_BGRA, GL_UNSIGNED_BYTE, surface_data(dst));
>  }
>
>  void egl_texture_blit(QemuGLShader *gls, egl_fb *dst, egl_fb *src, bool =
flip)
> --
> 2.18.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

