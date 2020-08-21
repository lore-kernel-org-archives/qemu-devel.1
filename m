Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929A6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:34:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6217C20720
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="csLI32PN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6217C20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k95Jc-0005Qc-LH
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 07:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k94dj-0007Ld-V7
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:51:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21452
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k94dg-00056k-HW
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598007075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gDjoGraokWvDw6WeO/Ilabe6thW/R3AW97b5+0TZ3BM=;
 b=csLI32PNDVPjakQyXgho13jyDRSyKdveqbV5s32G8L+h0aPTfPdUGvUnMOYZnItGTmvU43
 xpGXqRSvtN/pfZzBDzyVoZCGR0TlH+fgZwLa7TbnQO/vCRu3m6O275LVv5MEs1EiTXz3QA
 /BBWoxQUvyzU1TUsyIWp031fGE9nIJA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-iw8xGmkgPQaAwXDeMnr75w-1; Fri, 21 Aug 2020 06:51:11 -0400
X-MC-Unique: iw8xGmkgPQaAwXDeMnr75w-1
Received: by mail-wm1-f71.google.com with SMTP id c186so800762wmd.9
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 03:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=gDjoGraokWvDw6WeO/Ilabe6thW/R3AW97b5+0TZ3BM=;
 b=KxQDn/EyiuuHxxf0jktEri9vG/qeQbWPteJX7TZaeRCqzNJMfyav0Vm3CD/C6vd8/C
 8lNT6YNoHeOwA5stWWDG9ZkeiC+KZ9uSxj0YAiop9Fb+8077Dk4RU+fWzlqNBRZxN2B/
 tFI3lBb7I62HBpX6TTPMUsyMnOnNNsrHA2UkSHw19KmhR9LLAAkZCbsN0FK+6skYP40S
 60LzZ4FSftCk2IKRTaQHsXoT9eIJo1u4mrtiXD8ritDFCpc9HjkCOh6Phc3tCucMtHtZ
 r9+pWr7O6HCKknq87Z8YZXK578SznE8tPMxydD52qfNRsTZjBsC7Euu0dTlYrRxSVyD8
 Lthw==
X-Gm-Message-State: AOAM530gmIfiwTepeIaRoi0p1u864ou9MeYc9XHu6paGOb9Hga0Jd8HI
 LhRPGUe4PyUuIUHUdKxn+Oyz/aNBCJ9m7VA+ZkFRmbzj83diQ0Dlh5Yorz5b6ME/P4g+uisFit3
 9KRXT77WcmEEOWR4=
X-Received: by 2002:adf:b302:: with SMTP id j2mr2172531wrd.294.1598007070186; 
 Fri, 21 Aug 2020 03:51:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXG60OZPiAbWPAAf5z6w4TetreHSPc4aGjoeWSBehmhOicYDnWCZ0ynQw9k10IWwnZyrHj3A==
X-Received: by 2002:adf:b302:: with SMTP id j2mr2172517wrd.294.1598007069922; 
 Fri, 21 Aug 2020 03:51:09 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id f6sm5376635wme.32.2020.08.21.03.51.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 03:51:09 -0700 (PDT)
Subject: Re: [PATCH] cirrus: handle wraparound in cirrus_invalidate_region
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200821082622.7169-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <0fb2b10e-320f-9b33-6812-f1c5d06b0563@redhat.com>
Date: Fri, 21 Aug 2020 12:51:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821082622.7169-1-kraxel@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 23:41:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Li Qiang <liq3ea@163.com>,
 Prasad J Pandit <pjp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/20 10:26 AM, Gerd Hoffmann wrote:
> Code simply asserts that there is no wraparound instead of handling
> it properly.  The assert() can be triggered by the guest (must be
> privilidged inside the guest though).  Fix it.

Thanks for fixing this!

> Buglink: https://bugs.launchpad.net/qemu/+bug/1880189
> Cc: Li Qiang <liq3ea@163.com>
> Reported-by: Alexander Bulekov <alxndr@bu.edu>

Well, I reported this one 3 months ago to secalert, not Alex.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/display/cirrus_vga.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
> index 212d6f5e6145..b91b64347473 100644
> --- a/hw/display/cirrus_vga.c
> +++ b/hw/display/cirrus_vga.c
> @@ -640,10 +640,15 @@ static void cirrus_invalidate_region(CirrusVGAState * s, int off_begin,
>      }
>  
>      for (y = 0; y < lines; y++) {
> -        off_cur = off_begin;
> +        off_cur = off_begin & s->cirrus_addr_mask;
>          off_cur_end = ((off_cur + bytesperline - 1) & s->cirrus_addr_mask) + 1;
> -        assert(off_cur_end >= off_cur);
> -        memory_region_set_dirty(&s->vga.vram, off_cur, off_cur_end - off_cur);
> +        if (off_cur_end >= off_cur) {
> +            memory_region_set_dirty(&s->vga.vram, off_cur, off_cur_end - off_cur);
> +        } else {
> +            /* wraparound */
> +            memory_region_set_dirty(&s->vga.vram, off_cur, s->cirrus_addr_mask - off_cur);
> +            memory_region_set_dirty(&s->vga.vram, 0, off_cur_end);
> +        }
>          off_begin += off_pitch;
>      }
>  }
> 


