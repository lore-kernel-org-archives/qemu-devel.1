Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F5CC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 09:38:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D92CB22527
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 09:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+kuHjKD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D92CB22527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifhOZ-0004dL-2L
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 04:37:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ifhNm-00042L-Tm
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 04:37:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ifhNk-0003vm-6C
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 04:37:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59779
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ifhNj-0003ts-LY
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 04:37:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576229826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E/sBuMjiKiBhOYDNznmGKWDX66F9pjhWYI5MYOXorIA=;
 b=b+kuHjKDDnLycCeSz0yCecPToQf1ee9MAXHfNh02JqTsAlnaCcPIMEbNIMMlhAolQ96Rxo
 u//iw9vTNqldZvPZM6gy3va+HD+QL96vnqcyxzOGg9If/dxEzsqKmJtzUfhd5FHYgRDR/O
 G9XStu5mcccS/NduCu3ThFrFlUu/nYg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-BgHcj35vNLit_0VMrdtvUw-1; Fri, 13 Dec 2019 04:37:00 -0500
Received: by mail-wm1-f71.google.com with SMTP id t4so2129973wmf.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 01:37:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=E/sBuMjiKiBhOYDNznmGKWDX66F9pjhWYI5MYOXorIA=;
 b=WsGgo4EkqldVhwIkr1wPBBHRj6lVP57XMGCMa2DlmWPuceLNJwpeYq6pvhTlI4E0UG
 FDGCzKmZqXTmHngfuxvzjWM/KDnO9LsV+AveJ+YYSSU0nw+SeT4IglrEBxiKcxylGBk6
 TL7NOSJj+jnJEUVFMYnSSnNA6cSqY6WSOiJt2i/H55X7K0Muv67q2nGzh31Hzh0cy0mQ
 MJfuZ2VEnmILL1xV6WMjN0gatgxI/auoNX+2Dpjj0MuBqYatukJPiH2wzXotJdIQDc8Y
 SLlapCZU7MMATPSiI4ZwEbMqV1kpHt/wMgIRKH0tSbnO5ZcLz87g5UhKkWHt5sC03FrM
 RFFg==
X-Gm-Message-State: APjAAAVIty5mipDgmFPpdTZC7m6K2oHnjD1JhhyXSbaavEpATSCv37Qn
 sjH94s69WT3WXKLrStDDB47D2Cs+86zTRUeJVX7PPe+bp0pfxAg342i1S6xDLGDgfvNoPsgcMF8
 DHYSHVk6N136+7DY=
X-Received: by 2002:a7b:cf26:: with SMTP id m6mr11460208wmg.17.1576229819770; 
 Fri, 13 Dec 2019 01:36:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqyPmwbkuia1EmK2N0D1+JcuNcfP/lLxh09OOruxi5vjVW3KvBvxkPGUgW7isYkngB4TzcwaxA==
X-Received: by 2002:a7b:cf26:: with SMTP id m6mr11460185wmg.17.1576229819489; 
 Fri, 13 Dec 2019 01:36:59 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id n3sm9786566wmc.27.2019.12.13.01.36.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2019 01:36:58 -0800 (PST)
Subject: Re: [PATCH] mos6522: remove anh register
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20191212194359.13508-1-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5df4edad-e603-de11-ced8-0556b021976b@redhat.com>
Date: Fri, 13 Dec 2019 10:36:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212194359.13508-1-laurent@vivier.eu>
Content-Language: en-US
X-MC-Unique: BgHcj35vNLit_0VMrdtvUw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/12/19 8:43 PM, Laurent Vivier wrote:
> Register addr 1 is defined as buffer A with handshake (vBufAH),
> register addr 15 is also defined as buffer A without handshake (vBufA).

Maybe add "IOW both addresses access the same register."

> 
> Linux kernel has a big "DON'T USE!" next to the register 1 addr
> definition (vBufAH), and only uses register 15 (vBufA).

I agree with David, the Linux reference is confusing. I'd omit it.

> 
> So remove the definition of 'anh' and use only 'a' (with VIA_REG_ANH and
> VIA_REG_A).
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   hw/misc/mos6522.c         | 12 ++++--------
>   include/hw/misc/mos6522.h |  1 -
>   2 files changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
> index cecf0be59e..86ede4005c 100644
> --- a/hw/misc/mos6522.c
> +++ b/hw/misc/mos6522.c
> @@ -244,6 +244,7 @@ uint64_t mos6522_read(void *opaque, hwaddr addr, unsigned size)
>           val = s->b;
>           break;
>       case VIA_REG_A:

Maybe add:

        /* As we do not model handshake, fall through no handshake. */

> +    case VIA_REG_ANH:
>           val = s->a;
>           break;
>       case VIA_REG_DIRB:
> @@ -297,9 +298,7 @@ uint64_t mos6522_read(void *opaque, hwaddr addr, unsigned size)
>           val = s->ier | 0x80;
>           break;
>       default:
> -    case VIA_REG_ANH:
> -        val = s->anh;

Oops, default was buggy.

Maybe worth:

Fixes: 51f233ec92c

> -        break;
> +        g_assert_not_reached();
>       }
>   
>       if (addr != VIA_REG_IFR || val != 0) {
> @@ -322,6 +321,7 @@ void mos6522_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
>           mdc->portB_write(s);
>           break;
>       case VIA_REG_A:

        /* As we do not model handshake, fall through no handshake. */

> +    case VIA_REG_ANH:
>           s->a = (s->a & ~s->dira) | (val & s->dira);
>           mdc->portA_write(s);
>           break;
> @@ -395,9 +395,7 @@ void mos6522_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
>                                 qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
>           break;
>       default:
> -    case VIA_REG_ANH:
> -        s->anh = val;

Buggy again.

> -        break;
> +        g_assert_not_reached();
>       }
>   }
>   
> @@ -439,7 +437,6 @@ const VMStateDescription vmstate_mos6522 = {
>           VMSTATE_UINT8(pcr, MOS6522State),
>           VMSTATE_UINT8(ifr, MOS6522State),
>           VMSTATE_UINT8(ier, MOS6522State),
> -        VMSTATE_UINT8(anh, MOS6522State),

Don't you need to increase .version_id?

>           VMSTATE_STRUCT_ARRAY(timers, MOS6522State, 2, 0,
>                                vmstate_mos6522_timer, MOS6522Timer),
>           VMSTATE_END_OF_LIST()
> @@ -460,7 +457,6 @@ static void mos6522_reset(DeviceState *dev)
>       s->ifr = 0;
>       s->ier = 0;
>       /* s->ier = T1_INT | SR_INT; */
> -    s->anh = 0;
>   
>       s->timers[0].frequency = s->frequency;
>       s->timers[0].latch = 0xffff;
> diff --git a/include/hw/misc/mos6522.h b/include/hw/misc/mos6522.h
> index 493c907537..97384c6e02 100644
> --- a/include/hw/misc/mos6522.h
> +++ b/include/hw/misc/mos6522.h
> @@ -115,7 +115,6 @@ typedef struct MOS6522State {
>       uint8_t pcr;
>       uint8_t ifr;
>       uint8_t ier;
> -    uint8_t anh;
>   
>       MOS6522Timer timers[2];
>       uint64_t frequency;
> 


