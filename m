Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCEDC04AAA
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 08:23:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C368E2082F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 08:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/LDx8RA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C368E2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52306 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNYuF-0007tM-1C
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 04:23:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hNYtQ-0007b6-Qt
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:22:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hNYtP-0007xN-T5
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:22:36 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1hNYtP-0007ww-KY
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:22:35 -0400
Received: by mail-wr1-x443.google.com with SMTP id a12so5951493wrn.4
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 01:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=YsWXJLKl1X2RfA7+OdQc43rrGPTF4EV/nOzUPiI+Dxk=;
	b=b/LDx8RAlqFEitGBgpPSU/MzKL9GPcWoDRwlYltiZIG6D5hWw5hpFriz0Bfpu4niXv
	TETgjVVcbWXazcFWVYSaVzx8Ag9NkMxil1vDDt30SaPsa0fo7BDcA+2QEc8Hh1LaVYU6
	765Ow7H/GUR1BMn7LRyAcsdwJ/SjIvERFbC9tcvhg5tg7LYiudp+SZ/dUAuVeORIF2At
	m85vOfIi+7e5sMvJYv/YST9CtKHbc1sx3eWaslc28Zx4Y4i1Cy9Ufgng9g7XqPbP/flH
	sunQHZ03RpcTvYf9a1nOTg3zWPLYA6dWA6rwquZyKTju++iwx+JrJpB8eGHSm3flxqs9
	Ai0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=YsWXJLKl1X2RfA7+OdQc43rrGPTF4EV/nOzUPiI+Dxk=;
	b=n+GHkNaCgJa6E6joUKtIFqfb3Us1XFUs8T1QmnI27eYsn1cZ4qQ378MAaYyc9qrEl3
	Dg7U8Ptr26lzKGtnhgczx8KuSwv6VGZKD/n3a6UrU7Gj7AazryvJadu+dV04uwyyZpO6
	S+It4IJ5c6b1rwqO3gZ+QLGcA4hNF4Zy9MrCgt+31u+VHzUmj8QU8wWFetNqmcw5AMw5
	fcZkJYxw+6zoJDMV54OWc3eJzyy8h/LDi6+oLpxXeYjnJni510FDz4zJBjNgJgI5OAxv
	bYZkle/eRSzW+8SXe1E4rh+NgqQZvtigGUU0yAh+/HUq9bjbWNgNrIWXZM3oeJTOxtQV
	uOsQ==
X-Gm-Message-State: APjAAAWlUNEvaHrxztDNajXhTUEwRnJ5CoBF8+WleUSFn6/HwzlyOqAb
	oiFM0d6Z2A5W9H4VjgCcmasbhAeD
X-Google-Smtp-Source: APXvYqzpIEdelsjJgXLmla6Ij072qnGDysDbLQjAEoPM9n3FVaL+3g1C+/zY8F4YCqX4moUoaP8vQA==
X-Received: by 2002:adf:ea8e:: with SMTP id s14mr15948269wrm.4.1557130953556; 
	Mon, 06 May 2019 01:22:33 -0700 (PDT)
Received: from localhost.localdomain ([141.226.29.227])
	by smtp.gmail.com with ESMTPSA id q7sm9958358wmc.11.2019.05.06.01.22.32
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 01:22:32 -0700 (PDT)
To: Hou Qiming <hqm03ster@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <CABSdmrnNW6f=P64PviPP8CTJ5SVfYS8_6kmAtpw9yPObTEkpxg@mail.gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <481d3407-4312-82f0-f355-d4f807e1e5be@gmail.com>
Date: Mon, 6 May 2019 11:22:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CABSdmrnNW6f=P64PviPP8CTJ5SVfYS8_6kmAtpw9yPObTEkpxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] Patch: Precautionary glBindTexture in
 surface_gl_update_texture
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Qiming,
Thanks for submitting the patch!

On 5/6/19 10:50 AM, Hou Qiming wrote:
> From 48d1f092a7960d711fb2c77ab8d3f9d0a0ca0d5c Mon Sep 17 00:00:00 2001
> From: HQM <hqm03ster@gmail.com <mailto:hqm03ster@gmail.com>>
> Date: Mon, 6 May 2019 15:37:59 +0800
> Subject: [PATCH] Precautionary glBindTexture and surface->texture 
> validation
>  in surface_gl_update_texture
>

The lines above should not go into the patch comment, while the mail 
subject should
start with [PATCH].

I suggest preparing the patch with git format-patch and sending it with 
git send-email.
You can also prepare it "manually" as long the format is correct.

> In a GVT-g setup with dmabuf and GTK GUI, the current 2D texture at 
> surface_gl_update_texture is not necessarily
> surface->texture. Adding a glBindTexture fixes related crashes and 
> artifacts, and is generally more secure.
>
> Signed-off-by: HQM <hqm03ster@gmail.com <mailto:hqm03ster@gmail.com>>
> ---
>  ui/console-gl.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/ui/console-gl.c b/ui/console-gl.c
> index a56e1cd..c1cb3bd 100644
> --- a/ui/console-gl.c
> +++ b/ui/console-gl.c
> @@ -92,13 +92,17 @@ void surface_gl_update_texture(QemuGLShader *gls,
>
>      assert(gls);
>
> -    glPixelStorei(GL_UNPACK_ROW_LENGTH_EXT,
> -                  surface_stride(surface) / 
> surface_bytes_per_pixel(surface));
> -    glTexSubImage2D(GL_TEXTURE_2D, 0,
> -                    x, y, w, h,
> -                    surface->glformat, surface->gltype,
> -                    data + surface_stride(surface) * y
> -                    + surface_bytes_per_pixel(surface) * x);
> +    if (surface->texture) {

I confirm it fixes a boot QEMU crash when the Windows guest i915 driver 
loads.

> +        glBindTexture(GL_TEXTURE_2D, surface->texture);

I confirm it fixes strange artifacts seen on screen (some huge mouse 
icon on the upper left side)
when guest monitor "turns off" or the GTK window gets resized and the 
guest desktop resolution changes.

> +        glPixelStorei(GL_UNPACK_ROW_LENGTH_EXT,
> +                      surface_stride(surface)
> +                      / surface_bytes_per_pixel(surface));
> +        glTexSubImage2D(GL_TEXTURE_2D, 0,
> +                        x, y, w, h,
> +                        surface->glformat, surface->gltype,
> +                        data + surface_stride(surface) * y
> +                        + surface_bytes_per_pixel(surface) * x);
> +    }
>  }
>
>  void surface_gl_render_texture(QemuGLShader *gls,
> -- 
> 2.17.1
>
>

I have no OpenGL background to understand the consequences, but the patch
does solve 2 gvt issues, so:

Tested-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>


Thanks,
Marcel




