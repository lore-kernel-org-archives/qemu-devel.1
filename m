Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2746C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:32:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25480206D8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+V40dDk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25480206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc8Dh-0002lk-1G
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 09:32:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kc8B1-0000rD-A5
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 09:29:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44660)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kc8Az-0000jJ-Dw
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 09:29:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604932184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yt9RHEnl6S+jO0PexpG+/9I29yVsoTM1GQpu2G9TTZM=;
 b=f+V40dDkWpZuMN+L3/1EEC6zAm2JPg9Yfz+/znnu2XlEYorioEG3NMLFVKtNDu/wk3Yag2
 7pe/XJtgywXslhEtg4wC3UH9Tk3FjUCllAc4efJpfGOjmFuz8+VuKLdIoW0HrzXq53Brnl
 nk5Vi/EQcLaZP9zO3S11nZOw8zbxwTU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-HgZmmrZoM_e-EN3_oFl6ZQ-1; Mon, 09 Nov 2020 09:29:42 -0500
X-MC-Unique: HgZmmrZoM_e-EN3_oFl6ZQ-1
Received: by mail-wm1-f72.google.com with SMTP id y1so2042000wma.5
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 06:29:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yt9RHEnl6S+jO0PexpG+/9I29yVsoTM1GQpu2G9TTZM=;
 b=jAnSlL6EOI9PP05DATPC9QYas3+0wWI4xFEUFzhlE9/dTdv1YuAS/MJ4WC3aZ1RsAl
 tAMT+4xAvpHvN1SezGVjXY+G3TwxhMVNVKnPnIaKp9Z1/1YlkIPl9eeR6x8UbRu49zzF
 JkAfxxjfQr21qr5TJVjaHNBmJpaj4qR2+kphzVo/NytugAWpVGD4myRkJrlbUPUbhUPW
 BcyRIw7ZBCHK9ox9OTOL4A1QmFXsBYeHFMbzKOH6+Vth7AR7wKAo5s7dSjYN+WEIUNrF
 BYeI+6EYxwQdqgLVqTZrewp3OPAOqHCVCI3LQlpQOpwgW5Cam8sCJpn5u74Nqa5z6nW3
 EjnA==
X-Gm-Message-State: AOAM532JUVNf+Hgjh8LGz1iHTNDKp4GwmibnwehSo3hz5UQexGV58/30
 8baKpcieJXV45jfUJVu/8Ci7BTY8zlA8kf6zTeQhfH/mB1I8T161VRrHkfyxCo20rxUSqGkObev
 EDMhJhxmY9qfqefA=
X-Received: by 2002:a5d:530c:: with SMTP id e12mr12210229wrv.355.1604932181560; 
 Mon, 09 Nov 2020 06:29:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyUhmnhLWslF1fmr4oNowneHZenkLqm0b1jIesecXhdgCrLTS/qfCMZGP2UAVhJUU0tU2cNmQ==
X-Received: by 2002:a5d:530c:: with SMTP id e12mr12210215wrv.355.1604932181430; 
 Mon, 09 Nov 2020 06:29:41 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id s4sm6589736wro.10.2020.11.09.06.29.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 06:29:37 -0800 (PST)
Subject: Re: [PATCH-for-5.2 2/4] hw/display/cirrus_vga: Fix hexadecimal format
 string specifier
To: qemu-devel@nongnu.org
References: <20201103112558.2554390-1-philmd@redhat.com>
 <20201103112558.2554390-3-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d7953f0d-1eb3-26cc-5f1f-64bf0ac9f6ac@redhat.com>
Date: Mon, 9 Nov 2020 15:29:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201103112558.2554390-3-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Dov Murik <dovmurik@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gerd,

On 11/3/20 12:25 PM, Philippe Mathieu-Daudé wrote:
> The '%u' conversion specifier is for decimal notation.
> When prefixing a format with '0x', we want the hexadecimal
> specifier ('%x').
> 
> Inspired-by: Dov Murik <dovmurik@linux.vnet.ibm.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/display/cirrus_vga.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
> index e14096deb46..fdca6ca659f 100644
> --- a/hw/display/cirrus_vga.c
> +++ b/hw/display/cirrus_vga.c
> @@ -2105,7 +2105,7 @@ static void cirrus_vga_mem_write(void *opaque,
>      } else {
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "cirrus: mem_writeb 0x" TARGET_FMT_plx " "
> -                      "value 0x%02" PRIu64 "\n", addr, mem_value);
> +                      "value 0x%02" PRIx64 "\n", addr, mem_value);
>      }
>  }
>  
> 

This patch (and previous one) missed your latest ui pull
request. As there is no qemu-trivial@ pull request during
freeze/rc, can you queue these patches via your tree?

Thanks,

Phil.


