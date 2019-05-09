Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2B2C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 10:51:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FE9120989
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 10:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5f8ZzAf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE9120989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52284 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOgeJ-0002Mh-Mg
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 06:51:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hOgdS-0001Oj-Sq
	for qemu-devel@nongnu.org; Thu, 09 May 2019 06:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hOgdQ-0006LA-V5
	for qemu-devel@nongnu.org; Thu, 09 May 2019 06:50:46 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1hOgdP-0006Jw-3P
	for qemu-devel@nongnu.org; Thu, 09 May 2019 06:50:44 -0400
Received: by mail-wr1-x443.google.com with SMTP id r7so1737305wrr.13
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 03:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=ZoLEyT/QkH6F9ljzqXms0WrJZcO3GFw1KJXeeM+g5VY=;
	b=F5f8ZzAfPjuoAchOezyoeMhb1/2Tl1u2/bBKuBUO4pnasoBddEWHV0CrE4kw3A3MWg
	Hv+kTZB0ty7Gve51E3ysFbiUXg1YVq2BnbCK8LmENsqh8vXEzE+SjRrWfVGlNRj8IeVv
	AstwLUusBJzi0VZ9Z8PLxBMj/mgEi3mCArbDvP0SpmM4hZDdh3lC08TBjE0v1mEG6Hs7
	hU/acp2PiyY9gIjKQatIbkuvLKtVbB8d0+psgEejeD/RUg5d0auZrFRYU2H/uRlycSkL
	Sx3oAmagXUXgYS/usdZyzeV/HlDguLylLKf9t9tpcqTQHYAVapylRQhXQxmPQRicMTQg
	Kk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=ZoLEyT/QkH6F9ljzqXms0WrJZcO3GFw1KJXeeM+g5VY=;
	b=Ix3AUIu78usZRljMbrShGXHxD2ey1HyuoC8HUJvy2Sgp2869wf2UmmBrC4zvuThbcc
	kRUfb9ZvtkGaa80X8JuRKi4xinJ8WkMzQs3owLGZR206y3HswrlsLv5mpns4i8pmgTO/
	IOIii4i7sTThERx5pvN297s7Z0S/dYlHbMmIB8NOPQj3tx5i9EFJL4fC2fxDi7zvhdp1
	aPhGh9lqJs++mp/c2leNU1PvLsZnzAqUnAAUM3gPYDy5Ea1nTUjFgsJLc4WuFxyJ3w8u
	cae2qNyjVLs5S8ap563dExb5mrfzz6ggQVUZXsJXx9ocdG8nOkXw3fH9btOLTNM9/H+B
	TQrw==
X-Gm-Message-State: APjAAAW0azU23d0yGdcw0Z3M3s3aanDQ42WmLiYKXsQnP+m3Zn1YIwIP
	aTwcrd80waSj/vQYfHqlFv8=
X-Google-Smtp-Source: APXvYqyxwQhG02NSA6hByICnazK6Rph1nFVQPaLd6m+NRVwf7mct9cDtWHdo9xg7x+13kAoCwRNhoQ==
X-Received: by 2002:adf:e5cb:: with SMTP id a11mr2641100wrn.128.1557399041965; 
	Thu, 09 May 2019 03:50:41 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2f0d:c0b:ba00:6fce:9bd8:fb12:6a42])
	by smtp.gmail.com with ESMTPSA id
	c11sm1347946wmb.12.2019.05.09.03.50.40
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 03:50:41 -0700 (PDT)
To: Hou Qiming <hqm03ster@gmail.com>, qemu-devel@nongnu.org
References: <CABSdmrnNW6f=P64PviPP8CTJ5SVfYS8_6kmAtpw9yPObTEkpxg@mail.gmail.com>
	<CABSdmrnocrqLKWncgy_Lak33__GRPYfs-RzSA14e=vh4cRn2ag@mail.gmail.com>
	<20190509064848.wjhchsfov7q6komj@sirius.home.kraxel.org>
	<CABSdmrmm+wJ=+Ccav=X5Gw_oueQvPRejCWVG2SQeCw=K4BM9EA@mail.gmail.com>
	<CABSdmrn073Y6UTbbgs00y5-DCdF1ROK9zAg5JURD4SoUZAk2Mw@mail.gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <eddfe7d6-e362-740e-4775-6d1a093935e6@gmail.com>
Date: Thu, 9 May 2019 13:50:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CABSdmrn073Y6UTbbgs00y5-DCdF1ROK9zAg5JURD4SoUZAk2Mw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 2/3] ramfb enhancement
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/9/19 10:58 AM, Hou Qiming wrote:
>

The subject for this patch may be:

     [PATCH V2 2/3] hw/display/ramfb: don't allow resolution change 
until vm reset

> Only allow one resolution change per guest boot, which prevents a
> crash when the guest writes garbage to the configuration space (e.g.
> when rebooting).
>

It is actually a cool feature, changing the resolution following a 
display window
resize, but sadly is not stable enough. Let's hope it will be fixed someday.

> Signed-off-by: HOU Qiming <hqm03ster@gmail.com 
> <mailto:hqm03ster@gmail.com>>
> ---
>  hw/display/ramfb.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
> index c27fcc7..fa6296b 100644
> --- a/hw/display/ramfb.c
> +++ b/hw/display/ramfb.c
> @@ -31,6 +31,7 @@ struct RAMFBState {
>      uint32_t width, height;
>      hwaddr addr, length;
>      struct RAMFBCfg cfg;
> +    bool locked;
>  };
>
>  static void qemu_unmap_displaysurface_guestmem(pixman_image_t *image,
> @@ -73,11 +74,11 @@ static DisplaySurface 
> *qemu_create_displaysurface_guestmem(
>  static void ramfb_fw_cfg_write(void *dev, off_t offset, size_t len)
>  {
>      RAMFBState *s = dev;
> -    uint32_t fourcc, format;
> +    uint32_t fourcc, format, width, height;
>      hwaddr stride, addr, length;
>
> -    s->width  = be32_to_cpu(s->cfg.width);
> -    s->height = be32_to_cpu(s->cfg.height);
> +    width     = be32_to_cpu(s->cfg.width);
> +    height    = be32_to_cpu(s->cfg.height);
>      stride    = be32_to_cpu(s->cfg.stride);
>      fourcc    = be32_to_cpu(s->cfg.fourcc);
>      addr      = be64_to_cpu(s->cfg.addr);
> @@ -85,9 +86,16 @@ static void ramfb_fw_cfg_write(void *dev, off_t 
> offset, size_t len)
>      format    = qemu_drm_format_to_pixman(fourcc);
>
>      fprintf(stderr, "%s: %dx%d @ 0x%" PRIx64 "\n", __func__,
> -            s->width, s->height, addr);
> +            width, height, addr);
> +    if (s->locked) {
> +        fprintf(stderr, "%s: resolution locked, change rejected\n", 
> __func__);
> +        return;
> +    }
> +    s->locked = true;
>      s->addr = addr;
>      s->length = length;
> +    s->width = width;
> +    s->height = height;
>      s->ds = qemu_create_displaysurface_guestmem(s->width, s->height,
>                                                  format, stride, s->addr);
>  }
> @@ -107,6 +115,13 @@ void ramfb_display_update(QemuConsole *con, 
> RAMFBState *s)
>      dpy_gfx_update_full(con);
>  }
>
> +static void ramfb_reset(void *opaque)
> +{
> +    RAMFBState *s = (RAMFBState *)opaque;
> +    s->locked = false;
> +    memset(&s->cfg, 0, sizeof(s->cfg));
> +}
> +
>  RAMFBState *ramfb_setup(Error **errp)
>  {
>      FWCfgState *fw_cfg = fw_cfg_find();
> @@ -119,9 +134,12 @@ RAMFBState *ramfb_setup(Error **errp)
>
>      s = g_new0(RAMFBState, 1);
>
> +    s->locked = false;
> +
>      rom_add_vga("vgabios-ramfb.bin");
>      fw_cfg_add_file_callback(fw_cfg, "etc/ramfb",
>                               NULL, ramfb_fw_cfg_write, s,
>                               &s->cfg, sizeof(s->cfg), false);
> +    qemu_register_reset(ramfb_reset, s);
>      return s;
>  }
> -- 
> 2.17.1
>
>


