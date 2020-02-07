Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCABC04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:05:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98702214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5cddgPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98702214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j05CJ-0007Qp-OB
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 10:05:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jpewhacker@gmail.com>) id 1j04kx-0006vg-35
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:37:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jpewhacker@gmail.com>) id 1j04kw-0000B2-7O
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:37:19 -0500
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:39584)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jpewhacker@gmail.com>)
 id 1j04kv-000097-WE
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:37:18 -0500
Received: by mail-il1-x142.google.com with SMTP id f70so1874223ill.6
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=dk5ODb3Gj2TYjyKARkYyg25EdfWD4skwXJSnw3qyrb0=;
 b=M5cddgPMHTja5Vgn3UCsynQWsaSw1+QoLZozU3H4Z0U0FpmTkI8Ct9Q8DDQjrdjyqK
 OAuaKhun6z7d6bSQ+8P0GPeILSh84QVCG2x+w8jyw04DPrCw6VWsmNr/TFWGnBkGqRuO
 2vRsU8CKSRpgUXH0sFBGI+wxid+68IT/A3wgm8kz4JTITPFEGmPrjS0gbcQQnEGpYTpa
 TNBtv6Z7Ujbr3uwZa9wTSpvoBajW72Q5kkTfeqMHEvQp989ZVOA0bdoy5TA2od9tdMah
 IwDkGrliN0rU+SHHHBu/vUwoGVrTIIvhhKz4ZXCK+pGXW+/mn2bWS/tdtp6Fh3gGTa2+
 ogLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=dk5ODb3Gj2TYjyKARkYyg25EdfWD4skwXJSnw3qyrb0=;
 b=EQlMWSlDlzGqk2St7ZW+pyn1+Mo1oT+/sqbCMK42LzLnoUW6vlkopP0B6RqKm+XP2c
 sQxxd8RSiAkOqaS4DODf2DH9TB0Nk9JIu5wYUAxtpRBr6Ppevz/Mil7D0STmRsxnrtGY
 qPvahe1CWiFUNzQx2rt77x7zFq7sOz20Td0SWH252/8vwdtrtalxGKoA1TokRx/7EfEU
 84gSzcPRCyRwbm1pXQwo4gQw2a3zjHPfA8MvEo4pE0Y/lrWKjqTZWXohFLJiEVdICPyQ
 wbot8Qxddz70somPVKZiv7nK7VWFWaOd4n+R57QJ4Ut9P9BDeEqwFXQZp6ZjDqprnXTO
 Q5Zw==
X-Gm-Message-State: APjAAAUDiVSPtuMHe7aD8lFsHlhLDMlqoBEEx0tOzw3alNKBWRtGDLf0
 ztmudHIEYknbrKMAKrjp6UI=
X-Google-Smtp-Source: APXvYqzAKso3V9XBOJNuQpXFb4L6TEVFLOyKaG/GW/q/r2V0J4PA5TGFnAnRUKAhVGUqwpy+2dxQng==
X-Received: by 2002:a92:c50f:: with SMTP id r15mr9770993ilg.258.1581086235730; 
 Fri, 07 Feb 2020 06:37:15 -0800 (PST)
Received: from [10.30.196.58] ([204.77.163.55])
 by smtp.gmail.com with ESMTPSA id y11sm1322793ilm.22.2020.02.07.06.37.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2020 06:37:15 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
Subject: Re: [PATCH v3 5/7] ui/gtk: implement show-cursor option
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200207101753.25812-1-kraxel@redhat.com>
 <20200207101753.25812-6-kraxel@redhat.com>
Message-ID: <b0dca00d-5d35-a139-b5d0-1777c92b23a0@gmail.com>
Date: Fri, 7 Feb 2020 08:37:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200207101753.25812-6-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::142
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
Cc: Peter Maydell <peter.maydell@linaro.org>, jtomko@redhat.com,
 libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2/7/20 4:17 AM, Gerd Hoffmann wrote:
> When specified just set null_cursor to NULL so we get the default
> pointer instead of a blank pointer.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   ui/gtk.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/ui/gtk.c b/ui/gtk.c
> index d18892d1de61..a685d1ae0848 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -2243,8 +2243,12 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
>       textdomain("qemu");
>   
>       window_display = gtk_widget_get_display(s->window);
> -    s->null_cursor = gdk_cursor_new_for_display(window_display,
> -                                                GDK_BLANK_CURSOR);
> +    if (s->opts->has_show_cursor && s->opts->show_cursor) {
> +        s->null_cursor = NULL; /* default pointer */
> +    } else {
> +        s->null_cursor = gdk_cursor_new_for_display(window_display,
> +                                                    GDK_BLANK_CURSOR);
> +    }

I think it would make more sense to have all the logic related to what 
cursor is used in the same location, instead of split up between here 
and gd_update_cursor(). This would also match the behavior of the SDL 
and cocoa backends a little better.

>   
>       s->mouse_mode_notifier.notify = gd_mouse_mode_change;
>       qemu_add_mouse_mode_change_notifier(&s->mouse_mode_notifier);

