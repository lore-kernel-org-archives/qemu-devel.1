Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1346C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 09:36:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AB9D20810
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 09:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mkp5LRPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB9D20810
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jebRS-0001qG-Nw
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 05:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jebQX-0001Dz-6H
 for qemu-devel@nongnu.org; Fri, 29 May 2020 05:35:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32124
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jebQV-0005iq-SO
 for qemu-devel@nongnu.org; Fri, 29 May 2020 05:35:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590744939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9cWuygDfGcPxYMuTScj2vsSTxWg7gqcJx+iHuI5nESs=;
 b=Mkp5LRPJf7yBdomeLbozzbaZzSfacOQmr6urejqePqaNFKgRdEsu1Ugrh8N3O1MjUbXukh
 wQQ5vEioXczbhTjxeFtkIvw59EiWyk8Dj6nG6Ib5xv5RhZQ706BCZnszQ86N6yiWtJOHJn
 Xkt1rKkSvy6zoQBurYgLcSh7ITvcD+Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-QC9owwnzPO2HiRpfJ8ElLQ-1; Fri, 29 May 2020 05:35:35 -0400
X-MC-Unique: QC9owwnzPO2HiRpfJ8ElLQ-1
Received: by mail-wr1-f69.google.com with SMTP id n6so812554wrv.6
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 02:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=9cWuygDfGcPxYMuTScj2vsSTxWg7gqcJx+iHuI5nESs=;
 b=nrbRVS6YDe+UIDamWSk7UciGSg4kKXjgolqsOFhN1OXUi1GGO2eHEYS+LrrsMsEOTP
 VxnRwuWNfXHM8M/D4Wg0dFofMLrMbnou4V6IS1BR6DrKX4RbYVb6k+ck/SBXv8GVVk0X
 XBmAP0PBtH8qpI7dEYj5u260NqUDODzEjxKjkgOFN0NZ6LRz7ZBRUD4yFKYVKihENsiM
 xw6cyZKftyJSg5bY1DvzsMf51+PtNloVzOs4KENGLtw5BWKZdfVxG6NcqMg4W07hzdYq
 p9URibuMxgjqr4Vv/8INLeI6s+JDLh+UiKfTjz8w3xARfiexwQaF3aBfc1HbD7jeeiAh
 lTZw==
X-Gm-Message-State: AOAM530duiIySWKDngyx+kUibKg8lVcd8QrOlNaOwVj/WSxDBj/XFT47
 hHOvHKi9yR99d91bxRQE/o6tfOCUxYg0V5pY2Kr5DpTM2EFHj+jxc6mRQxEjYebPWSKKfWoUfSb
 mNusV9cLmLZB54TU=
X-Received: by 2002:adf:df03:: with SMTP id y3mr7502851wrl.376.1590744934487; 
 Fri, 29 May 2020 02:35:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSX30i+8uMjHpwN4OWSN53/O+KJiueDSvDa+5iWbbjkiRsDwda8bUsAtH8cwxDHC/ONqDqOA==
X-Received: by 2002:adf:df03:: with SMTP id y3mr7502834wrl.376.1590744934202; 
 Fri, 29 May 2020 02:35:34 -0700 (PDT)
Received: from [192.168.1.34] (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id n19sm9356644wmi.33.2020.05.29.02.35.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2020 02:35:33 -0700 (PDT)
Subject: Re: [PATCH 1/8] decodetree: Remove python 3.4 check
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200518164052.18689-1-richard.henderson@linaro.org>
 <20200518164052.18689-2-richard.henderson@linaro.org>
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
Message-ID: <5a80fd73-d60a-0ba5-8d04-936aa8f75acf@redhat.com>
Date: Fri, 29 May 2020 11:35:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200518164052.18689-2-richard.henderson@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 23:43:13
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 6:40 PM, Richard Henderson wrote:
> We are now guaranteed python 3.5 or later.

FYI this has been addressed by John Snow:
https://www.mail-archive.com/qemu-block@nongnu.org/msg66830.html

> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  scripts/decodetree.py | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/scripts/decodetree.py b/scripts/decodetree.py
> index 46ab917807..f9d204aa36 100755
> --- a/scripts/decodetree.py
> +++ b/scripts/decodetree.py
> @@ -75,13 +75,6 @@ def output(*args):
>          output_fd.write(a)
>  
>  
> -if sys.version_info >= (3, 4):
> -    re_fullmatch = re.fullmatch
> -else:
> -    def re_fullmatch(pat, str):
> -        return re.match('^' + pat + '$', str)
> -
> -
>  def output_autogen():
>      output('/* This file is autogenerated by scripts/decodetree.py.  */\n\n')
>  
> @@ -428,18 +421,18 @@ def parse_field(lineno, name, toks):
>      width = 0
>      func = None
>      for t in toks:
> -        if re_fullmatch('!function=' + re_ident, t):
> +        if re.fullmatch('!function=' + re_ident, t):
>              if func:
>                  error(lineno, 'duplicate function')
>              func = t.split('=')
>              func = func[1]
>              continue
>  
> -        if re_fullmatch('[0-9]+:s[0-9]+', t):
> +        if re.fullmatch('[0-9]+:s[0-9]+', t):
>              # Signed field extract
>              subtoks = t.split(':s')
>              sign = True
> -        elif re_fullmatch('[0-9]+:[0-9]+', t):
> +        elif re.fullmatch('[0-9]+:[0-9]+', t):
>              # Unsigned field extract
>              subtoks = t.split(':')
>              sign = False
> @@ -488,11 +481,11 @@ def parse_arguments(lineno, name, toks):
>      flds = []
>      extern = False
>      for t in toks:
> -        if re_fullmatch('!extern', t):
> +        if re.fullmatch('!extern', t):
>              extern = True
>              anyextern = True
>              continue
> -        if not re_fullmatch(re_ident, t):
> +        if not re.fullmatch(re_ident, t):
>              error(lineno, 'invalid argument set token "{0}"'.format(t))
>          if t in flds:
>              error(lineno, 'duplicate argument "{0}"'.format(t))
> @@ -621,13 +614,13 @@ def parse_generic(lineno, is_format, name, toks):
>              continue
>  
>          # 'Foo=%Bar' imports a field with a different name.
> -        if re_fullmatch(re_ident + '=%' + re_ident, t):
> +        if re.fullmatch(re_ident + '=%' + re_ident, t):
>              (fname, iname) = t.split('=%')
>              flds = add_field_byname(lineno, flds, fname, iname)
>              continue
>  
>          # 'Foo=number' sets an argument field to a constant value
> -        if re_fullmatch(re_ident + '=[+-]?[0-9]+', t):
> +        if re.fullmatch(re_ident + '=[+-]?[0-9]+', t):
>              (fname, value) = t.split('=')
>              value = int(value)
>              flds = add_field(lineno, flds, fname, ConstField(value))
> @@ -635,7 +628,7 @@ def parse_generic(lineno, is_format, name, toks):
>  
>          # Pattern of 0s, 1s, dots and dashes indicate required zeros,
>          # required ones, or dont-cares.
> -        if re_fullmatch('[01.-]+', t):
> +        if re.fullmatch('[01.-]+', t):
>              shift = len(t)
>              fms = t.replace('0', '1')
>              fms = fms.replace('.', '0')
> @@ -652,7 +645,7 @@ def parse_generic(lineno, is_format, name, toks):
>              fixedmask = (fixedmask << shift) | fms
>              undefmask = (undefmask << shift) | ubm
>          # Otherwise, fieldname:fieldwidth
> -        elif re_fullmatch(re_ident + ':s?[0-9]+', t):
> +        elif re.fullmatch(re_ident + ':s?[0-9]+', t):
>              (fname, flen) = t.split(':')
>              sign = False
>              if flen[0] == 's':
> 


