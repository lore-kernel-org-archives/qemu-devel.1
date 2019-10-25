Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD6ACA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:49:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9538721929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YX0a/yzE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9538721929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO0u1-0007fE-3h
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 10:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45693)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iO0ZW-0008Rx-9l
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:28:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iO0ZU-0004tn-Nd
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:28:10 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35910)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iO0ZU-0004tE-Gh
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:28:08 -0400
Received: by mail-wr1-x443.google.com with SMTP id w18so2594587wrt.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 07:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=8mFYXdDx7Xf3uxp1Z1U9W4yhEc7cqg6Q2FpuwkjWvfs=;
 b=YX0a/yzEUH1xvx7j7lfIfDgBLEdtwXYAHVjEXcJcw/uLUbTwiloOOnu4tvVo503w7s
 1a9vJfOkeyWa8YSSY+uZDW+Xthy4c0JeehZ4eQBM77A1ugUcmDp8It1hcuKmD8HOT8vP
 I4b9jQJ88eoLMPNjJgM6H4r+vW39Gz6bBhyOfQ0UGbJthmrwRspPgHYiiWY8J3OF6fxz
 OBE3K7u+Q4924XHXWqxsOfDvsXQL84781FMFS8eFFcCrmcis/QPTrLARUYGFiO3nnR9g
 LBaWmIE9btztczOV453DsEBSeUZP7fm+u58ytg9o5N/mZMNUc0LzmPftiEgg7k7rpVvO
 DVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=8mFYXdDx7Xf3uxp1Z1U9W4yhEc7cqg6Q2FpuwkjWvfs=;
 b=jIxnLmrbQqqYs0joX+fJVAL99g4uftZacvfW6L6Ub64a/AJViKcORbtNG3gdosWazQ
 GyQWJnC9ObuIXtDPcFNZsfqxaTRMTXJG2wk+LO6sa/hfOS5duvE0MKjzWFY5SQO6MfwN
 KUSx5IUD1ZNKcyp4OcdGIgcEHjULX2PBXxhlaJ619DtnxDbfXGbr8uAGM/fP9mUhtlFm
 HmNAEz0ymUrtJpkV/3gtO+XyPhFrCLLzA5KEWgo73CxvJNQy4Lgs2gfWZTpx7EJpePBU
 aoeQIJRZWoKb8CZVJFGpwBSImuLf+5iLTj/ujz2/SbV8PsO1HfKZm1GaiC1i1dDHCZRP
 DOyw==
X-Gm-Message-State: APjAAAXm1iuxoqIq9aQCNy9NCcp2ZvCxOJ6mAPMxlULsmWPcg/eEeyD5
 zPdYQIrZH5T7hMV9Mnpuj9PuAg==
X-Google-Smtp-Source: APXvYqzfC72FX7lwuTVZeWANxjIGczjyFmayqJSbGg8lDtfvlDxu7Cc/shwGYMmtvUybzi+4w+Ymrw==
X-Received: by 2002:a5d:614a:: with SMTP id y10mr3251875wrt.164.1572013686809; 
 Fri, 25 Oct 2019 07:28:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i1sm2643608wmb.19.2019.10.25.07.28.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 07:28:05 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9B9C41FF87;
 Fri, 25 Oct 2019 15:28:04 +0100 (BST)
References: <20191023154505.30521-1-richard.henderson@linaro.org>
 <20191023154505.30521-5-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 4/7] exec: Use const alias for TARGET_PAGE_BITS_VARY
In-reply-to: <20191023154505.30521-5-richard.henderson@linaro.org>
Date: Fri, 25 Oct 2019 15:28:04 +0100
Message-ID: <87r230lx1n.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Using a variable that is declared "const" for this tells the
> compiler that it may read the value once and assume that it
> does not change across function calls.
>
> For target_page_size, this means we have only one assert per
> function, and one read of the variable.
>
> This reduces the size of qemu-system-aarch64 by 8k.
>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
> v2: Notice CONFIG_ATTRIBUTE_ALIAS, and work around Xcode 9 lossage.
> ---
>  include/exec/cpu-all.h | 14 +++++++---
>  exec-vary.c            | 60 ++++++++++++++++++++++++++++++++++++------
>  2 files changed, 62 insertions(+), 12 deletions(-)
>
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 255bb186ac..76515dc8d9 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -210,10 +210,16 @@ static inline void stl_phys_notdirty(AddressSpace *=
as, hwaddr addr, uint32_t val
>  /* page related stuff */
>
>  #ifdef TARGET_PAGE_BITS_VARY
> -extern bool target_page_bits_decided;
> -extern int target_page_bits;
> -#define TARGET_PAGE_BITS ({ assert(target_page_bits_decided); \
> -                            target_page_bits; })
> +typedef struct {
> +    bool decided;
> +    int bits;
> +} TargetPageBits;
> +# if defined(CONFIG_ATTRIBUTE_ALIAS) || !defined(IN_EXEC_VARY)
> +extern const TargetPageBits target_page;
> +#else
> +extern TargetPageBits target_page;
> +# endif
> +#define TARGET_PAGE_BITS (assert(target_page.decided), target_page.bits)
>  #else
>  #define TARGET_PAGE_BITS_MIN TARGET_PAGE_BITS
>  #endif
> diff --git a/exec-vary.c b/exec-vary.c
> index 48c0ab306c..e0befd502a 100644
> --- a/exec-vary.c
> +++ b/exec-vary.c
> @@ -19,11 +19,55 @@
>
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
> +
> +#define IN_EXEC_VARY 1
> +
>  #include "exec/exec-all.h"
>
>  #ifdef TARGET_PAGE_BITS_VARY
> -int target_page_bits;
> -bool target_page_bits_decided;
> +# ifdef CONFIG_ATTRIBUTE_ALIAS
> +/*
> + * We want to declare the "target_page" variable as const, which tells
> + * the compiler that it can cache any value that it reads across calls.
> + * This avoids multiple assertions and multiple reads within any one use=
r.
> + *
> + * This works because we initialize the target_page data very early, in a
> + * location far removed from the functions that require the final result=
s.
> + *
> + * This also requires that we have a non-constant symbol by which we can
> + * perform the actual initialization, and which forces the data to be
> + * allocated within writable memory.  Thus "init_target_page", and we use
> + * that symbol exclusively in the two functions that initialize this val=
ue.
> + *
> + * The "target_page" symbol is created as an alias of "init_target_page".
> + */
> +static TargetPageBits init_target_page;
> +
> +/*
> + * Note that this is *not* a redundant decl, this is the definition of
> + * the "target_page" symbol.  The syntax for this definition requires
> + * the use of the extern keyword.  This seems to be a GCC bug in
> + * either the syntax for the alias attribute or in -Wredundant-decls.
> + *
> + * See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D91765
> + */
> +#  pragma GCC diagnostic push
> +#  pragma GCC diagnostic ignored "-Wredundant-decls"
> +
> +extern const TargetPageBits target_page
> +    __attribute__((alias("init_target_page")));
> +
> +#  pragma GCC diagnostic pop
> +# else
> +/*
> + * When aliases are not supported then we force two different declaratio=
ns,
> + * by way of suppressing the header declaration with IN_EXEC_VARY.
> + * We assume that on such an old compiler, LTO cannot be used, and so the
> + * compiler cannot not detect the mismatched declarations, and all is we=
ll.
> + */
> +TargetPageBits target_page;
> +#  define init_target_page target_page
> +# endif
>  #endif
>
>  bool set_preferred_target_page_bits(int bits)
> @@ -36,11 +80,11 @@ bool set_preferred_target_page_bits(int bits)
>       */
>  #ifdef TARGET_PAGE_BITS_VARY
>      assert(bits >=3D TARGET_PAGE_BITS_MIN);
> -    if (target_page_bits =3D=3D 0 || target_page_bits > bits) {
> -        if (target_page_bits_decided) {
> +    if (init_target_page.bits =3D=3D 0 || init_target_page.bits > bits) {
> +        if (init_target_page.decided) {
>              return false;
>          }
> -        target_page_bits =3D bits;
> +        init_target_page.bits =3D bits;
>      }
>  #endif
>      return true;
> @@ -49,9 +93,9 @@ bool set_preferred_target_page_bits(int bits)
>  void finalize_target_page_bits(void)
>  {
>  #ifdef TARGET_PAGE_BITS_VARY
> -    if (target_page_bits =3D=3D 0) {
> -        target_page_bits =3D TARGET_PAGE_BITS_MIN;
> +    if (init_target_page.bits =3D=3D 0) {
> +        init_target_page.bits =3D TARGET_PAGE_BITS_MIN;
>      }
> -    target_page_bits_decided =3D true;
> +    init_target_page.decided =3D true;
>  #endif
>  }


--
Alex Benn=C3=A9e

