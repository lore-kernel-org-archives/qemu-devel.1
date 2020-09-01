Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9D7C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 21:50:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E825206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 21:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aQfMjrnq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E825206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDEAH-000680-95
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 17:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDE9T-0005fi-90
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 17:49:15 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38999)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDE9R-0005Ya-AV
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 17:49:14 -0400
Received: by mail-pg1-x541.google.com with SMTP id v15so1418573pgh.6
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 14:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=K8FuNBLBg5QtS5NxsuD0X3MZfcEoRHekQWMMYCiq5dE=;
 b=aQfMjrnqRR7sAR1ILLEZfJcKdUAoWuB+PpPzOzhlxDF4m7nUYG1Eo1MHHFzCVO1Bmi
 h8CidRYgr3mEhK1AGHQ6j/M6bQVBjrj8bkJpS4hsMowhw/aez/8pAlvtR4JQYacQ4gOU
 TuHf8WBCmswAhshLDSrFvhkUzWykl5CJbOxElJ1RkLt/JKJ29Fdpu+apT8lEjZVBQlNi
 j5yWfl1t3KajPlDUexoECxAI1WqBGGU2obiSHeSgjGpQtg5kIGM0w0SegiQj3iQOUSak
 VQseThvcmAzl2wIKMfsfLd9ndkdC0C+uL+lw9W3vTviSEFcfhDiQ2cnLGRJuOauW5D/t
 90tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K8FuNBLBg5QtS5NxsuD0X3MZfcEoRHekQWMMYCiq5dE=;
 b=HWN5xSUJ8irTMmRij26b2A9fx7xOWIVefyaWbtneQVcYQvDfz4bgLx6XftQpKsBE3f
 XT8kK+WVo7fAIx5MRfHW12e3d1uCQYgC86j0kcKyiBR3sKcUYl2K8EyAdiUA84rgqlZq
 GV1vCyrXfPr6PM5mpTPhICWZLafCJ2CNbgcgRhigv5LGZyO1TETMztY77jpriwaggLyR
 WUZQvz6/qL4zevq7GAKJVbYrNaZLq6VT8uwCnNntblJ4X4EES1qLY2+IfHwRkgWXUBc3
 D+M4JoB/CX23gfz7DtoYq4ymcmkDybj5ZW8i8u4sXgsXqoOZTPLayjyY+6yHS3DmdPO8
 j6qg==
X-Gm-Message-State: AOAM531Nxih9PrYiChz+lXpG71qnHHfhxRjlvHP/yScRC+KKkYe72kct
 v3TEMKOHe1t7AplGPm5Ax24oYQ==
X-Google-Smtp-Source: ABdhPJyu8thTi5x/DX16trD40irHcVEQ350efmZMhl5fYCiFzOaKajZzlZEIgdJy2dMeWiVdrjQHzQ==
X-Received: by 2002:aa7:9551:: with SMTP id w17mr185615pfq.167.1598996951543; 
 Tue, 01 Sep 2020 14:49:11 -0700 (PDT)
Received: from ?IPv6:2607:fb90:27d2:4b79:8545:2b44:3b48:7db9?
 ([2607:fb90:27d2:4b79:8545:2b44:3b48:7db9])
 by smtp.gmail.com with ESMTPSA id l24sm3001144pff.20.2020.09.01.14.49.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 14:49:10 -0700 (PDT)
Subject: Re: [PATCH 6/7] hw/display/artist: Fix artist screen resolution
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <20200901183452.24967-1-deller@gmx.de>
 <20200901183452.24967-7-deller@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <65284ae3-f0fe-336e-a205-0494abb20f08@linaro.org>
Date: Tue, 1 Sep 2020 14:49:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901183452.24967-7-deller@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.13,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 11:34 AM, Helge Deller wrote:
> Artist screen size is limited to 2048 x 2048 pixels and x/y coordination
> addressing needs to be done by OS via an uint32 value which is based on
> a 2048 byte line length, independend of the real screen size.
> 
> Since HP-UX seems to ideally need at least 640 pixels in width, this
> patch ensures that the screen size stays between 640x480 and 2048x2048
> pixels and fixes some pixel glitches were visible before on STI text
> consoles due to the 2048 line length limitation.
> 
> Cc: Sven Schnelle <svens@stackframe.org>
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>  hw/display/artist.c | 37 +++++++++++++++++++++++--------------
>  1 file changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/display/artist.c b/hw/display/artist.c
> index 71982559c6..98bee6d61c 100644
> --- a/hw/display/artist.c
> +++ b/hw/display/artist.c
> @@ -192,6 +192,10 @@ static const char *artist_reg_name(uint64_t addr)
>  }
>  #undef REG_NAME
> 
> +/* artist has a fixed line length of 2048 bytes. */
> +#define ADDR_TO_Y(addr) (((addr) >> 11) & 0x7ff)
> +#define ADDR_TO_X(addr) ((addr) & 0x7ff)

extract32()

> +
>  static int16_t artist_get_x(uint32_t reg)
>  {
>      return reg >> 16;
> @@ -348,13 +352,13 @@ static void artist_invalidate_cursor(ARTISTState *s)
>                              y, s->cursor_height);
>  }
> 
> -static void vram_bit_write(ARTISTState *s, int posx, int posy, bool incr_x,
> +static void vram_bit_write(ARTISTState *s, int posy, bool incr_x,
>                             int size, uint32_t data)
>  {
>      struct vram_buffer *buf;
>      uint32_t vram_bitmask = s->vram_bitmask;
>      int mask, i, pix_count, pix_length;
> -    unsigned int offset, width;
> +    unsigned int posx, offset, width;
>      uint8_t *data8, *p;
> 
>      pix_count = vram_write_pix_per_transfer(s);
> @@ -366,6 +370,8 @@ static void vram_bit_write(ARTISTState *s, int posx, int posy, bool incr_x,
>      if (s->cmap_bm_access) {
>          offset = s->vram_pos;
>      } else {
> +        posx = ADDR_TO_X(s->vram_pos >> 2);
> +        posy += ADDR_TO_Y(s->vram_pos >> 2);

Do you in fact want to fold the >> 2 into the ADDR_TO_X/Y, like

#define ADDR_TO_X(POS)  extract32(POS, 2, 11)

?

> @@ -881,16 +886,12 @@ static void artist_reg_write(void *opaque, hwaddr addr, uint64_t val,
>          break;
> 
>      case VRAM_WRITE_INCR_Y:
> -        posx = (s->vram_pos >> 2) & 0x7ff;
> -        posy = (s->vram_pos >> 13) & 0x3ff;
...
>      case VRAM_WRITE_INCR_X:
>      case VRAM_WRITE_INCR_X2:
> -        posx = (s->vram_pos >> 2) & 0x7ff;
> -        posy = (s->vram_pos >> 13) & 0x3ff;
...
> -    int posy = (addr >> 11) & 0x3ff;

Is it a bug that these Y were using 0x3ff and not 0x7ff?
Because it's pretty consistent...

You should make that a separate change, for sure.

> @@ -1374,6 +1377,12 @@ static void artist_realizefn(DeviceState *dev, Error **errp)
>      struct vram_buffer *buf;
>      hwaddr offset = 0;
> 
> +    /* Screen on artist can not be greater than 2048x2048 pixels. */
> +    s->width = MAX(s->width, 640);
> +    s->width = MIN(s->width, 2048);
> +    s->height = MAX(s->height, 480);
> +    s->height = MIN(s->height, 2048);

Was the original values chosen by the user?  Should we be giving some sort of
error for out-of-range values?


r~

