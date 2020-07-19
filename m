Return-Path: <SRS0=x6dg=A6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67527C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2020 13:53:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 330212080D
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2020 13:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yx4DLQCx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 330212080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jx9km-0002Dr-HQ
	for qemu-devel@archiver.kernel.org; Sun, 19 Jul 2020 09:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jx9jn-00014y-MV
 for qemu-devel@nongnu.org; Sun, 19 Jul 2020 09:52:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40172
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jx9jk-0000JV-VM
 for qemu-devel@nongnu.org; Sun, 19 Jul 2020 09:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595166733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RrqRYutXoXp9yhJpjSxvnnEa3x2dFnF1brfHYNUFls8=;
 b=Yx4DLQCxb12brOcxPGpMG+u1r+C/Dp0NZzf+JTa3CukCpUg6wTRZvGOhmB05+5+gkKeCAo
 +tWy01DiUpW9TW4IU5D+xdw5bRQ/nLhBMhe0nPZ6bVuoLNNbnu/JlWVrt76pJjiKez9KBY
 JsJKV97+fNcLzl63q1boB6+O0FgHSUU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-1NYOCCgPNZ2IjlyjSImoqg-1; Sun, 19 Jul 2020 09:52:12 -0400
X-MC-Unique: 1NYOCCgPNZ2IjlyjSImoqg-1
Received: by mail-wm1-f71.google.com with SMTP id b13so13159159wme.9
 for <qemu-devel@nongnu.org>; Sun, 19 Jul 2020 06:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=RrqRYutXoXp9yhJpjSxvnnEa3x2dFnF1brfHYNUFls8=;
 b=IEQZHZkf7wvvgASWSHZoXx+8KRIckOa/7V5U0R6mr36PtAgfDMVKT6RpqGSICML9GO
 Z0u3i/nLU4M9rsZN9TGBDOrgBIALsoIk007vgORmWQ9AjSvWYCcycIhDu1heTvYLuMmm
 IWVLt1af02o3EtyhnUKwzjBuXjaKdGqk6zP9aSIpiQDi2s408PV9YHK65AKUTeBeqF9A
 5ed2FcFt8nUwbi5uF/vToQNmWGxi0VOwqEJKM2jhl1SCoPZczQauxEwmY/810yHMtYfI
 96Fg2TR/EE4MLhJE/7CE8yKmdtbaTEbYPWZUiHJws0mfRIlzhOtfv+K51DWJciVBeK9q
 HfgQ==
X-Gm-Message-State: AOAM531TYLZOI+0IR8jdYs20m3WGbylnPMfxzZ2t47/CJHVThVXJS2r7
 N+G1C6CU6CMlBbiMH9doQ77mt869W7bKNVEhAkYK2vEZFr5xrUdZsW5QZENjQIvjUIs9M4khJws
 TWxLzp1JVl6F4N08=
X-Received: by 2002:adf:a4cf:: with SMTP id h15mr19794327wrb.229.1595166730861; 
 Sun, 19 Jul 2020 06:52:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxP8OpYgtS75y9NWBmJeIYpx0kISeATSyKO3XqrxUwMzk5P/RdWY280gjz48fITw8roXCqXqA==
X-Received: by 2002:adf:a4cf:: with SMTP id h15mr19794310wrb.229.1595166730567; 
 Sun, 19 Jul 2020 06:52:10 -0700 (PDT)
Received: from [192.168.1.43] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id e23sm24619824wme.35.2020.07.19.06.52.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Jul 2020 06:52:09 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] scripts/tracetool: Fix dtrace generation for macOS
To: Roman Bolshakov <r.bolshakov@yadro.com>, qemu-devel@nongnu.org
References: <20200717093517.73397-1-r.bolshakov@yadro.com>
 <20200717093517.73397-2-r.bolshakov@yadro.com>
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
Message-ID: <34c236c5-e047-6f15-6bb6-d0df65129622@redhat.com>
Date: Sun, 19 Jul 2020 15:52:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200717093517.73397-2-r.bolshakov@yadro.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/19 06:55:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/20 11:35 AM, Roman Bolshakov wrote:
> dtrace USDT is fully supported since OS X 10.6. There are a few
> peculiarities compared to other dtrace flavors.
> 
> 1. It doesn't accept empty files.
> 2. It doesn't recognize bool type but accepts C99 _Bool.
> 3. It converts int8_t * in probe points to char * in
>    header files and introduces [-Wpointer-sign] warning.
> 
> Cc: Cameron Esfahani <dirty@apple.com>
> Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> ---
>  scripts/tracetool/format/d.py | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/tracetool/format/d.py b/scripts/tracetool/format/d.py
> index 0afb5f3f47..353722f89c 100644
> --- a/scripts/tracetool/format/d.py
> +++ b/scripts/tracetool/format/d.py
> @@ -13,6 +13,7 @@ __email__      = "stefanha@redhat.com"
>  
>  
>  from tracetool import out
> +from sys import platform
>  
>  
>  # Reserved keywords from
> @@ -34,7 +35,8 @@ def generate(events, backend, group):
>  
>      # SystemTap's dtrace(1) warns about empty "provider qemu {}" but is happy
>      # with an empty file.  Avoid the warning.
> -    if not events:
> +    # But dtrace on macOS can't deal with empty files.
> +    if not events and platform != "darwin":

or?

>          return
>  
>      out('/* This file is autogenerated by tracetool, do not edit. */'
> @@ -44,6 +46,17 @@ def generate(events, backend, group):
>      for e in events:
>          args = []
>          for type_, name in e.args:
> +            if platform == "darwin":
> +                # macOS dtrace accepts only C99 _Bool

Why not do that for all platforms?

> +                if type_ == 'bool':
> +                    type_ = '_Bool'
> +                if type_ == 'bool *':
> +                    type_ = '_Bool *'
> +                # It converts int8_t * in probe points to char * in header
> +                # files and introduces [-Wpointer-sign] warning.
> +                # Avoid it by changing probe type to signed char * beforehand.
> +                if type_ == 'int8_t *':
> +                    type_ = 'signed char *'
>              if name in RESERVED_WORDS:
>                  name += '_'
>              args.append(type_ + ' ' + name)
> 


