Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FED2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:40:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C65320724
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YhtoBpkE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C65320724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqIN1-0006gZ-E2
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 11:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqIM6-0005F6-KI
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:39:30 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33878
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqIM4-0003M9-Lw
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593531568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HG2LXqLNK+K2Yvy9ZHJ7MpukWzVaOXe4pBY0xpd20yw=;
 b=YhtoBpkE+NUHOiGYHRWIcji4ErlaR5vXUoudmhM2X9ufwhIq5EP3f5A9VsGhTieMoWZaNQ
 9URmLTxNeKPQSMv1sDp6K3X9UZYJXn79ir9xigOUHRvfRHKYLl4XF988fWIwiXtgMlr4/u
 P5eADMw3rXaH2u04Co1zXv1rfC9uHSc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-wJNKYDDXNYCVcvtVYpHKow-1; Tue, 30 Jun 2020 11:39:18 -0400
X-MC-Unique: wJNKYDDXNYCVcvtVYpHKow-1
Received: by mail-wr1-f71.google.com with SMTP id p9so18942813wrx.10
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 08:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HG2LXqLNK+K2Yvy9ZHJ7MpukWzVaOXe4pBY0xpd20yw=;
 b=QtgtN09aMtNCE/uQ2w2v6HS6by6ZXNaBKxGI5Upx3BdSXj608M/Ob7OnlOk1mLN5p5
 1+ps5ZXiv/r0FtALRf1gmeGjq25UyWkZicrOkfeiOPyiJiR2/TYfxo2ICbeqq5igz5q0
 JtpnX9kkufrAMTzB8vwA5LV5/+R/97maSH5dQnXV11NNnX3+eoqCG/ZdbzHmcsp8MjAS
 +sZmHbJLSH7V28ymMchHyWkWmlHRCnJ9t7Mv2cPeSsfAoNMW2SyhODq5rpBMy2DilcQa
 OY49d8Gvf8nv2lmG8GWnqFiSjFnUDFEHh52Ki2KpSL3rwRfY8tFcsZrZlpM+gcqeTqps
 8THA==
X-Gm-Message-State: AOAM533ZnC8JVrpJ6e0IwMaZmObq7UjhYQgXjCrisXC0+qXNYNznXXQK
 YQZbugxpA5vD1Ign298Jb2bcF28lw6phkzcSVKGFzy/5Lfin/ngjD0yfLUuPOWvtZr4Ug8Pvctc
 oxUeYwMw3hEnW0gs=
X-Received: by 2002:adf:f6cb:: with SMTP id y11mr21687134wrp.100.1593531556755; 
 Tue, 30 Jun 2020 08:39:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0W1BqBQYRgnPEXlBUZdqrR1b9R7djo5iNDARWlN+xK7/rd+QjWE9JjIeOKeuyaNq/FpPeJA==
X-Received: by 2002:adf:f6cb:: with SMTP id y11mr21687122wrp.100.1593531556484; 
 Tue, 30 Jun 2020 08:39:16 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:acad:d1d4:42b8:23e4?
 ([2001:b07:6468:f312:acad:d1d4:42b8:23e4])
 by smtp.gmail.com with ESMTPSA id n16sm3667346wmc.40.2020.06.30.08.39.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 08:39:15 -0700 (PDT)
Subject: Re: [PATCH v2] coverity: provide Coverity-friendly MIN_CONST and
 MAX_CONST
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200629162804.1096180-1-eblake@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bd658081-ca05-9d22-7486-46379b7577e2@redhat.com>
Date: Tue, 30 Jun 2020 17:39:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200629162804.1096180-1-eblake@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 02:00:02
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/06/20 18:28, Eric Blake wrote:
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

Queued, thanks.


