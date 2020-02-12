Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7821C352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 23:55:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F56E206E5
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 23:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GXqDsuII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F56E206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j21rJ-0005tr-QD
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 18:55:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j21qg-0005H7-5K
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 18:55:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j21qe-0000A3-8f
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 18:55:17 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44433
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j21qe-00009j-4r
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 18:55:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581551715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R4woObnsmSdZMMEHBC68PBlk6yPgGEqa4BBtrfc0mm4=;
 b=GXqDsuIIy+CBJYBZHEfyvEJK2ynUGJCfde/IPU91ZBceW2h5dK25RdWiI+pDr7idxeLNjX
 Why5I2AHh7/KkFDouf32Wtbd5DDfutAvhlFW9j9it2Ubzagos3ty+Mg/fcCOLn3G2xMh2j
 vvCVwBf4OtCPtKsHN7Cj4T1SYnFqoLE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-OHYkU8dgMMG1cILttlQVjg-1; Wed, 12 Feb 2020 18:55:11 -0500
Received: by mail-wr1-f72.google.com with SMTP id w17so1537797wrr.9
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 15:55:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R4woObnsmSdZMMEHBC68PBlk6yPgGEqa4BBtrfc0mm4=;
 b=aYSUC0bmzb5C13/2ZzauU76tyuUgM4CWnUyJl20j5zu1q05J7Wcod/tDA+Xll6tTpd
 U1lI0ABFeIzMMybnvIbLLTUQjVgEgO7Tb8SyTRvjJQSrkr6I5SKM4GMLHdFzOrsj41vB
 Ll8kUNeVpBucwiWxlBbAy00I8K49u1l+9XZkPun1wgwa8+VYm6Xp/5GWIiUpo4NSXig0
 C4io4nLrs8WYiESC0mz6AXuXAW4c5F6dodnV3hH1XzpykygO6pT+ZJLmcdlrZcl7EXBf
 ZW6RftZxgTV3uxvEJbNSDJwnVA84srPHSLzUdEQHClpwVX16/2Lp4fvXugJa1sO/gofU
 Q5Xw==
X-Gm-Message-State: APjAAAUeYHGHtsO2PkOEB0LvqPt3eJ2AVli1HKE/B4mUtcyabtJFtTlH
 YilmwXSVqTJS3c7b0vEneO5BtxEYnwqpKWoLPbX5iU/oJ8t681e/sO67iwZ5x3XCHzg60iQxycr
 /wnLYzoTViulsYNo=
X-Received: by 2002:a5d:4204:: with SMTP id n4mr17481633wrq.123.1581551710468; 
 Wed, 12 Feb 2020 15:55:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqwSxQYQ6FRS7z+9ss8zG6WFoazTCqNvzW0ktjRibnlDOgXYWb+YKqI+KO8ZiMV7uUP7jnkFfA==
X-Received: by 2002:a5d:4204:: with SMTP id n4mr17481606wrq.123.1581551710182; 
 Wed, 12 Feb 2020 15:55:10 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id n8sm463957wrx.42.2020.02.12.15.55.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2020 15:55:09 -0800 (PST)
Subject: Re: [PATCH v5 5/6] hppa: Add emulation of Artist graphics
To: Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>
References: <20191220211512.3289-1-svens@stackframe.org>
 <20191220211512.3289-6-svens@stackframe.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <896a8b05-b3a4-846d-f129-73207282edd5@redhat.com>
Date: Thu, 13 Feb 2020 00:55:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20191220211512.3289-6-svens@stackframe.org>
Content-Language: en-US
X-MC-Unique: OHYkU8dgMMG1cILttlQVjg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Sven,

On 12/20/19 10:15 PM, Sven Schnelle wrote:
> This adds emulation of Artist graphics good enough
> to get a Text console on both Linux and HP-UX. The
> X11 server from HP-UX also works.
> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>   hw/display/Kconfig       |    4 +
>   hw/display/Makefile.objs |    1 +
>   hw/display/artist.c      | 1450 ++++++++++++++++++++++++++++++++++++++
>   hw/display/trace-events  |    9 +
>   hw/hppa/Kconfig          |    1 +
>   hw/hppa/hppa_hardware.h  |    1 +
>   hw/hppa/machine.c        |    9 +
>   7 files changed, 1475 insertions(+)
>   create mode 100644 hw/display/artist.c
> 
> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> index c500d1fc6d..15d59e10dc 100644
> --- a/hw/display/Kconfig
> +++ b/hw/display/Kconfig
> @@ -91,6 +91,10 @@ config TCX
>   config CG3
>       bool
>   
> +config ARTIST
> +    bool
> +    select FRAMEBUFFER
> +
>   config VGA
>       bool
>   
> diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
> index f2182e3bef..5f03dfdcc4 100644
> --- a/hw/display/Makefile.objs
> +++ b/hw/display/Makefile.objs
> @@ -40,6 +40,7 @@ common-obj-$(CONFIG_SM501) += sm501.o
>   common-obj-$(CONFIG_TCX) += tcx.o
>   common-obj-$(CONFIG_CG3) += cg3.o
>   common-obj-$(CONFIG_NEXTCUBE) += next-fb.o
> +common-obj-$(CONFIG_ARTIST) += artist.o
>   
>   obj-$(CONFIG_VGA) += vga.o
>   
> diff --git a/hw/display/artist.c b/hw/display/artist.c
[...]
> +static void draw_line_size(ARTISTState *s, bool update_start)
> +{
> +
> +    int startx = artist_get_x(s->vram_start);
> +    int starty = artist_get_y(s->vram_start);
> +    int endx = artist_get_x(s->line_size);
> +    int endy = artist_get_y(s->line_size);
> +
> +    trace_artist_draw_line(startx, starty, endx, endy);
> +    draw_line(s, startx, starty, endx, endy, update_start, -1, -1);
> +}
> +
> +static void draw_line_xy(ARTISTState *s, bool update_start)
> +{
> +
> +    int startx = artist_get_x(s->vram_start);
> +    int starty = artist_get_y(s->vram_start);
> +    int sizex = artist_get_x(s->blockmove_size);
> +    int sizey = artist_get_y(s->blockmove_size);
> +    int linexy = s->line_xy >> 16;
> +    int endx, endy;
> +
> +    endx = startx;
> +    endy = starty;
> +
> +    if (sizex > 0) {
> +        endx = startx + linexy;
> +    }
> +
> +    if (sizex < 0) {
> +        endx = startx;
> +        startx -= linexy;
> +    }
> +
> +    if (sizey > 0) {
> +        endy = starty + linexy;
> +    }
> +
> +    if (sizey < 0) {
> +        endy = starty;
> +        starty -= linexy;
> +    }
> +
> +    if (startx < 0) {
> +        startx = 0;
> +    }
> +
> +    if (endx < 0) {
> +        endx = 0;

If negative, set to zero.

> +    }
> +
> +    if (starty < 0) {
> +        starty = 0;
> +    }
> +
> +    if (endy < 0) {
> +        endy = 0;

Ditto.

> +    }
> +
> +
> +    if (endx < 0) {
> +        return;

Here Coverity points:

 >>>     CID 1419388:  Control flow issues  (DEADCODE)
 >>>     Execution cannot reach this statement: "return;".

> +    }
> +
> +    if (endy < 0) {
> +        return;

Here again.

> +    }
> +
> +    trace_artist_draw_line(startx, starty, endx, endy);
> +    draw_line(s, startx, starty, endx, endy, false, -1, -1);
> +}
> +
> +static void draw_line_end(ARTISTState *s, bool update_start)
> +{
> +
> +    int startx = artist_get_x(s->vram_start);
> +    int starty = artist_get_y(s->vram_start);
> +    int endx = artist_get_x(s->line_end);
> +    int endy = artist_get_y(s->line_end);
> +
> +    trace_artist_draw_line(startx, starty, endx, endy);
> +    draw_line(s, startx, starty, endx, endy, update_start, -1, -1);
> +}


