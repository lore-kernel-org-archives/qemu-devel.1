Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9F2C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:05:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 660C020720
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+fCxXN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660C020720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqHpN-0002gL-Mn
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 11:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqHlm-00086H-3D
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:01:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51194
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqHlk-0004FC-Bn
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593529312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZUXakE3b/7vUMkh9NzniLV8kHc1obJfWQ6LnVqPlCR8=;
 b=a+fCxXN6VeyVUtUtVPULhJQa7wElRw+ntj2fwSzhlAPtoBmaZZkLP77RA+VP6rF4MqOl8A
 FqCFYSujowO0dqicTOMZkkb+jjbVjC7Lw0yyxx0OYAp4BLXBy5bfcfC6UclK8fO23E1fxM
 XYUfyEtIevV6TbEavwTGLfB6p1jaMkc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-by9DIO5YPlelzvlP2NlLZg-1; Tue, 30 Jun 2020 11:01:43 -0400
X-MC-Unique: by9DIO5YPlelzvlP2NlLZg-1
Received: by mail-ej1-f71.google.com with SMTP id y10so7361455ejd.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 08:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ZUXakE3b/7vUMkh9NzniLV8kHc1obJfWQ6LnVqPlCR8=;
 b=db6iawVnT4LzlWnujhJJz1c109R4Hgemq+cJ+V8iJ6dX+UdWJJG8C019G3CJeCRVa+
 jJ/C6EFysK+xAXIpsoWxcgj8FzxJ5kUxjvZUh8KnNPchW9rdZ3YsXGWMJ7RY9UO/NmX+
 4FucKb2X6uaHCsgsqdpA1uS5cWUfbHlTMt3xATY77qZfFrV3JIuehREQJO21CoJzSdgY
 Xk+InM0IRnpf/jXNLf7tNX8Js1DG1DaXsM5WcWy1SXKCWQlAjq5DMwMV6iNAeUHpRAxu
 5R9RFmm7Z1KEFJ1FzzA8m0olwQS/h4Qboweexh+czDNc+YLHtvm3jsct3cpnhS704F51
 +PAQ==
X-Gm-Message-State: AOAM532OjH059fCe9kOEjPhMRgcmgfUaRQQeSPNJCsdh4o5hsjjSTtGw
 zTSUmGV5CrwRDjFv8LLPG37cE+oMT4CbRooeblgPMcXcPH11Zz3YxObEmBmLwtDZQNGsD35wrde
 4XM77FyLPty82x+U=
X-Received: by 2002:a17:906:4341:: with SMTP id
 z1mr13357269ejm.392.1593529302042; 
 Tue, 30 Jun 2020 08:01:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXStioSS0LSzxVIkY9HCejgg7L2AzC49Ex2Bevo5BfPzAuwxZ3OaGIFRX320MxPTvtC4kDsw==
X-Received: by 2002:a17:906:4341:: with SMTP id
 z1mr13357241ejm.392.1593529301758; 
 Tue, 30 Jun 2020 08:01:41 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id b4sm2974860edx.96.2020.06.30.08.01.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 08:01:41 -0700 (PDT)
Subject: Re: [PATCH v2] coverity: provide Coverity-friendly MIN_CONST and
 MAX_CONST
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200629162804.1096180-1-eblake@redhat.com>
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
Message-ID: <1cc63c60-72c3-9b0b-757e-0065f9be5588@redhat.com>
Date: Tue, 30 Jun 2020 17:01:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200629162804.1096180-1-eblake@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 01:11:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/29/20 6:28 PM, Eric Blake wrote:
> Coverity has problems seeing through __builtin_choose_expr, which
> result in it abandoning analysis of later functions that utilize a
> definition that used MIN_CONST or MAX_CONST, such as in qemu-file.c:
> 
>  50    DECLARE_BITMAP(may_free, MAX_IOV_SIZE);
> 
> CID 1429992 (#1 of 1): Unrecoverable parse warning (PARSE_ERROR)1.
> expr_not_constant: expression must have a constant value
> 
> As has been done in the past (see 07d66672), it's okay to dumb things
> down when compiling for static analyzers.  (Of course, now the
> syntax-checker has a false positive on our reference to
> __COVERITY__...)
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Fixes: CID 1429992, CID 1429995, CID 1429997, CID 1429999
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> 
> Improvements over Paolo's v1:
> - proper use of ()
> - add comment explaining the COVERITY section
> - add indentation for easier read of #if/#else flow
> 
>  include/qemu/osdep.h | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 0d26a1b9bd07..0fc206ae6154 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -250,7 +250,8 @@ extern int daemon(int, int);
>   * Note that neither form is usable as an #if condition; if you truly
>   * need to write conditional code that depends on a minimum or maximum
>   * determined by the pre-processor instead of the compiler, you'll
> - * have to open-code it.
> + * have to open-code it.  Sadly, Coverity is severely confused by the
> + * constant variants, so we have to dumb things down there.
>   */
>  #undef MIN
>  #define MIN(a, b)                                       \
> @@ -258,22 +259,28 @@ extern int daemon(int, int);
>          typeof(1 ? (a) : (b)) _a = (a), _b = (b);       \
>          _a < _b ? _a : _b;                              \
>      })
> -#define MIN_CONST(a, b)                                         \
> -    __builtin_choose_expr(                                      \
> -        __builtin_constant_p(a) && __builtin_constant_p(b),     \
> -        (a) < (b) ? (a) : (b),                                  \
> -        ((void)0))
>  #undef MAX
>  #define MAX(a, b)                                       \
>      ({                                                  \
>          typeof(1 ? (a) : (b)) _a = (a), _b = (b);       \
>          _a > _b ? _a : _b;                              \
>      })
> -#define MAX_CONST(a, b)                                         \
> +
> +#ifdef __COVERITY__
> +# define MIN_CONST(a, b) ((a) < (b) ? (a) : (b))
> +# define MAX_CONST(a, b) ((a) > (b) ? (a) : (b))
> +#else
> +# define MIN_CONST(a, b)                                        \
> +    __builtin_choose_expr(                                      \
> +        __builtin_constant_p(a) && __builtin_constant_p(b),     \
> +        (a) < (b) ? (a) : (b),                                  \
> +        ((void)0))
> +# define MAX_CONST(a, b)                                        \
>      __builtin_choose_expr(                                      \
>          __builtin_constant_p(a) && __builtin_constant_p(b),     \
>          (a) > (b) ? (a) : (b),                                  \
>          ((void)0))
> +#endif
> 
>  /*
>   * Minimum function that returns zero only if both values are zero.
> 


