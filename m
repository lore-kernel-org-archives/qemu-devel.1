Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B63C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:08:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B090120748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FtSxa2H8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B090120748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jblsC-0001Um-QV
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 10:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jblrW-0000VB-PO
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:07:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40368
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jblrV-0003pF-PI
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590070073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NV9NMVIdpGB11HE+YAOa8KzT/xvkPHQiP3Co2iVNVVk=;
 b=FtSxa2H85K1Kp56HLI7fZahQIBO1SKo/WPkhW0uk5/zfL3H4OzEAz34vkmBQqx8FEB3y4N
 7Tv+yKVPjz/Ulc6sBmxEfQrXyzhc0wds+shxShOuE/hXx8wdvUqPGsiNJ4allC8u8+UwnD
 RoPpV+vr22vRUZuZ7aLqMuPJ9m2IMrE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-xleKED2ZMEujRGCh7d6FtA-1; Thu, 21 May 2020 10:07:51 -0400
X-MC-Unique: xleKED2ZMEujRGCh7d6FtA-1
Received: by mail-wm1-f69.google.com with SMTP id m11so1894268wml.5
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 07:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NV9NMVIdpGB11HE+YAOa8KzT/xvkPHQiP3Co2iVNVVk=;
 b=gaVE7ehqX9Y9/Fc6lkXUncFNPYL6+hwhkJ2fZP1JcLGiQTqnhBIkYnszXCt0vyWUrh
 RHbDxwEId4NFR6ROBqAVywmgsQFjOB0s0J9/5vakN6hKAumWb/GL0Srol5q/36PuKWSA
 R6HAZwrHcBNeIjeB9mbHuN6+GGpvgKGoqjvTP/wxMKJ2io7H7230XbYgXNZY56hNW+Pg
 /K4AcUq+fn/khKoRyINoTgChd4JfU9N1UuVszvrE+s6Jn7FQoOYW6QoNjjQnW0g81U6D
 P44v/WprF4D54Ew/wWVbIug/XkmdV6WO28vMtFlAk4+OWWH82n1xfkIjy0MUGCtXVxWX
 nKzg==
X-Gm-Message-State: AOAM533doox60FU+HKV1ugLKS8RIPi3a0eXUEDFceZMa4Gwm4BkuNuXd
 A9JIcjF36BpA2u753vUCoD7os0WXdeCUhhUu2ZOIlyBA+8a7C3vvhPYE+wsLP+OvTxQFTcRoeLj
 Mpp9+4q8SeX6xLUc=
X-Received: by 2002:a5d:6ca7:: with SMTP id a7mr8549120wra.391.1590070070368; 
 Thu, 21 May 2020 07:07:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz48dXYoGh+KfrnUs4Yje9XNIQfiQEs8jaPLRntU6pwr7Tm2GJyrPiKm/UH82wwkiSJ7S6yDA==
X-Received: by 2002:a5d:6ca7:: with SMTP id a7mr8549098wra.391.1590070070135; 
 Thu, 21 May 2020 07:07:50 -0700 (PDT)
Received: from [192.168.1.40] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id b145sm7145524wme.41.2020.05.21.07.07.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 07:07:49 -0700 (PDT)
Subject: Re: [PATCH 1/6] sm501: Convert printf + abort to qemu_log_mask
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
References: <cover.1589981990.git.balaton@eik.bme.hu>
 <90b2648461d57d384823c90fa700cdd81d0b7254.1589981990.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a73bf1f4-c30e-56f8-eb2d-41b4e652f485@redhat.com>
Date: Thu, 21 May 2020 16:07:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <90b2648461d57d384823c90fa700cdd81d0b7254.1589981990.git.balaton@eik.bme.hu>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 06:06:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sebastian Bauer <mail@sebastianbauer.info>,
 Magnus Damm <magnus.damm@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/20 3:39 PM, BALATON Zoltan wrote:
> Some places already use qemu_log_mask() to log unimplemented features
> or errors but some others have printf() then abort(). Convert these to
> qemu_log_mask() and avoid aborting to prevent guests to easily cause
> denial of service.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/display/sm501.c | 57 ++++++++++++++++++++++------------------------
>   1 file changed, 27 insertions(+), 30 deletions(-)
> 
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index acc692531a..bd3ccfe311 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -727,8 +727,8 @@ static void sm501_2d_operation(SM501State *s)
>       int fb_len = get_width(s, crt) * get_height(s, crt) * get_bpp(s, crt);
>   
>       if (addressing != 0x0) {
> -        printf("%s: only XY addressing is supported.\n", __func__);
> -        abort();
> +        qemu_log_mask(LOG_UNIMP, "sm501: only XY addressing is supported.\n");
> +        return;
>       }
>   
>       if (rop_mode == 0) {
> @@ -754,8 +754,8 @@ static void sm501_2d_operation(SM501State *s)
>   
>       if ((s->twoD_source_base & 0x08000000) ||
>           (s->twoD_destination_base & 0x08000000)) {
> -        printf("%s: only local memory is supported.\n", __func__);
> -        abort();
> +        qemu_log_mask(LOG_UNIMP, "sm501: only local memory is supported.\n");
> +        return;
>       }
>   
>       switch (operation) {
> @@ -823,9 +823,9 @@ static void sm501_2d_operation(SM501State *s)
>           break;
>   
>       default:
> -        printf("non-implemented SM501 2D operation. %d\n", operation);
> -        abort();
> -        break;
> +        qemu_log_mask(LOG_UNIMP, "sm501: not implemented 2D operation: %d\n",
> +                      operation);
> +        return;
>       }
>   
>       if (dst_base >= get_fb_addr(s, crt) &&
> @@ -892,9 +892,8 @@ static uint64_t sm501_system_config_read(void *opaque, hwaddr addr,
>           break;
>   
>       default:
> -        printf("sm501 system config : not implemented register read."
> -               " addr=%x\n", (int)addr);
> -        abort();
> +        qemu_log_mask(LOG_UNIMP, "sm501: not implemented system config"
> +                      "register read. addr=%" HWADDR_PRIx "\n", addr);
>       }
>   
>       return ret;
> @@ -948,15 +947,15 @@ static void sm501_system_config_write(void *opaque, hwaddr addr,
>           break;
>       case SM501_ENDIAN_CONTROL:
>           if (value & 0x00000001) {
> -            printf("sm501 system config : big endian mode not implemented.\n");
> -            abort();
> +            qemu_log_mask(LOG_UNIMP, "sm501: system config big endian mode not"
> +                          " implemented.\n");
>           }
>           break;
>   
>       default:
> -        printf("sm501 system config : not implemented register write."
> -               " addr=%x, val=%x\n", (int)addr, (uint32_t)value);
> -        abort();
> +        qemu_log_mask(LOG_UNIMP, "sm501: not implemented system config"
> +                      "register write. addr=%" HWADDR_PRIx
> +                      ", val=%" PRIx64 "\n", addr, value);
>       }
>   }
>   
> @@ -1207,9 +1206,8 @@ static uint64_t sm501_disp_ctrl_read(void *opaque, hwaddr addr,
>           break;
>   
>       default:
> -        printf("sm501 disp ctrl : not implemented register read."
> -               " addr=%x\n", (int)addr);
> -        abort();
> +        qemu_log_mask(LOG_UNIMP, "sm501: not implemented disp ctrl register "
> +                      "read. addr=%" HWADDR_PRIx "\n", addr);
>       }
>   
>       return ret;
> @@ -1345,9 +1343,9 @@ static void sm501_disp_ctrl_write(void *opaque, hwaddr addr,
>           break;
>   
>       default:
> -        printf("sm501 disp ctrl : not implemented register write."
> -               " addr=%x, val=%x\n", (int)addr, (unsigned)value);
> -        abort();
> +        qemu_log_mask(LOG_UNIMP, "sm501: not implemented disp ctrl register "
> +                      "write. addr=%" HWADDR_PRIx
> +                      ", val=%" PRIx64 "\n", addr, value);
>       }
>   }
>   
> @@ -1433,9 +1431,8 @@ static uint64_t sm501_2d_engine_read(void *opaque, hwaddr addr,
>           ret = 0; /* Should return interrupt status */
>           break;
>       default:
> -        printf("sm501 disp ctrl : not implemented register read."
> -               " addr=%x\n", (int)addr);
> -        abort();
> +        qemu_log_mask(LOG_UNIMP, "sm501: not implemented disp ctrl register "
> +                      "read. addr=%" HWADDR_PRIx "\n", addr);
>       }
>   
>       return ret;
> @@ -1520,9 +1517,9 @@ static void sm501_2d_engine_write(void *opaque, hwaddr addr,
>           /* ignored, writing 0 should clear interrupt status */
>           break;
>       default:
> -        printf("sm501 2d engine : not implemented register write."
> -               " addr=%x, val=%x\n", (int)addr, (unsigned)value);
> -        abort();
> +        qemu_log_mask(LOG_UNIMP, "sm501: not implemented 2d engine register "
> +                      "write. addr=%" HWADDR_PRIx
> +                      ", val=%" PRIx64 "\n", addr, value);
>       }
>   }
>   
> @@ -1670,9 +1667,9 @@ static void sm501_update_display(void *opaque)
>           draw_line = draw_line32_funcs[dst_depth_index];
>           break;
>       default:
> -        printf("sm501 update display : invalid control register value.\n");
> -        abort();
> -        break;
> +        qemu_log_mask(LOG_GUEST_ERROR, "sm501: update display"
> +                      "invalid control register value.\n");
> +        return;
>       }
>   
>       /* set up to draw hardware cursor */
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


