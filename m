Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDF1C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:52:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D083C2089E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m0uVEGHV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D083C2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7CF-00052Y-Vc
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 11:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52605)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hw7Bm-0004Ly-6x
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:52:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hw7Bk-0006kL-Vs
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:52:22 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44815)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hw7Bk-0006jV-P9
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:52:20 -0400
Received: by mail-ot1-x341.google.com with SMTP id b7so84109301otl.11
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 08:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z/M3Z95ldVTYoS2h4aUFqxhH4IZo7mkV0bnMYYG8lnY=;
 b=m0uVEGHVZNSQrrj6Qp8oBm8eUbyWcDMldorCdJPFHGtWDmzO2N8NRkWIHEt7ZnobCq
 rfVwzZlN+Uy6hbfgs3oneYlMNghASSs9JfWbssRlW0et8xuYCq29/mwShDwIFbYNUIQI
 8epP9lqgxMDJ5xu8XaCPBryVy2YEB3e/mOub8vWVVAQPUFohPgabKl1b6NsrRc0eKsIi
 P/YahcGrN5bhAfVcrgaOEj28emQ9Qy5GjSs5AkIfd+onOXoSPhey+tB2DYKHOCC7vG6g
 DZz+bjEHZoND0I7cR75kxxoYAsI0UXp+h8xleReDZZR0tMIOGJD//JDMJBqQNJKnV2Or
 ttuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z/M3Z95ldVTYoS2h4aUFqxhH4IZo7mkV0bnMYYG8lnY=;
 b=IDYTHk83BsbmHMasGxUHTv9UyoBSehJPw9+iXF2Xk9Xtof3/USNNmUBLVfMiMSo1Ws
 j2FcmZRrOWX8klMOnYQn4KIjoFeoTewu5qHANKksdYbE26OxeRrC4vNYQ2rkB5ZcMBuj
 4H6NxqhmEpkKIftURyEKkTYWQB4TdYuqZeKg/1Xr+ZTqeIYarG6VcqGqM1ToWyKrsJ4q
 +5XlGbiLlV3MwquOhbUko9wiVLWrqNg+b2Wb0uSfkeNzgyhtoc3fqmQsrQYs+otfQ92V
 DsEXBbx9K21Om0k0FmHXsGCJWO5f3xdBhPf0cqfAWIO81iUmB0yiOwpbeyDfERsHob3B
 mhag==
X-Gm-Message-State: APjAAAU2xVwM4WgMxzkgYNecSIFE6BN9qjbfdd79iMCmCsdxKWoX20ia
 lYL4aDhXa6AE9KspXZi+F+sLkanNqc78vM7oQmKDuA==
X-Google-Smtp-Source: APXvYqxCVTN4iVXP5PMxRXwxdJVw/waQLLoJW4krZp0S1LK8PRN11mTsTSpE+U65SMr7+oW5O1iKFDwQBbam3TRsjg8=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr19047916otn.135.1565365938986; 
 Fri, 09 Aug 2019 08:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190809154153.31763-1-richard.henderson@linaro.org>
 <20190809154153.31763-2-richard.henderson@linaro.org>
In-Reply-To: <20190809154153.31763-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Aug 2019 16:52:08 +0100
Message-ID: <CAFEAcA_4jCdh94MUbmA9wAxQ7UajC_8TxEeD0tLpZRfn7jMiiw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH 1/3] decodetree: Allow !function with no
 input bits
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-arm <qemu-arm@nongnu.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 9 Aug 2019 at 16:41, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Call this form a "parameter", returning a value extracted
> from the DisasContext.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  docs/devel/decodetree.rst         |  8 ++++-
>  scripts/decodetree.py             | 54 ++++++++++++++++++++++++-------
>  tests/decode/err_field6.decode    |  5 +++
>  tests/decode/succ_function.decode |  6 ++++
>  4 files changed, 60 insertions(+), 13 deletions(-)
>  create mode 100644 tests/decode/err_field6.decode
>  create mode 100644 tests/decode/succ_function.decode
>
> diff --git a/docs/devel/decodetree.rst b/docs/devel/decodetree.rst
> index 44ac621ea8..ce7f52308f 100644
> --- a/docs/devel/decodetree.rst
> +++ b/docs/devel/decodetree.rst
> @@ -23,7 +23,7 @@ Fields
>
>  Syntax::
>
> -  field_def     := '%' identifier ( unnamed_field )+ ( !function=identifier )?
> +  field_def     := '%' identifier ( unnamed_field )* ( !function=identifier )?
>    unnamed_field := number ':' ( 's' ) number
>
>  For *unnamed_field*, the first number is the least-significant bit position
> @@ -34,6 +34,12 @@ present, they are concatenated.  In this way one can define disjoint fields.
>  If ``!function`` is specified, the concatenated result is passed through the
>  named function, taking and returning an integral value.
>
> +One may use ``!function`` with zero ``unnamed_fields``.  This case is called
> +a *parameter*, and the named function is only passed the ``DisasContext``
> +and returns an integral value extracted from there.
> +
> +A field with no ``unnamed_fields`` and no ``!function`` is in error.
> +
>  FIXME: the fields of the structure into which this result will be stored
>  is restricted to ``int``.  Which means that we cannot expand 64-bit items.
>
> diff --git a/scripts/decodetree.py b/scripts/decodetree.py
> index d7a59d63ac..a2490aeb74 100755
> --- a/scripts/decodetree.py
> +++ b/scripts/decodetree.py
> @@ -195,7 +195,10 @@ class MultiField:
>      """Class representing a compound instruction field"""
>      def __init__(self, subs, mask):
>          self.subs = subs
> -        self.sign = subs[0].sign
> +        if len(subs):
> +            self.sign = subs[0].sign
> +        else:
> +            self.sign = 0
>          self.mask = mask
>
>      def __str__(self):

Is this change to MultiField left over from the previous
implementation ? I was expecting a zero-length MultiField
to now be a bug in this python script (ie we should never
try to create one).

> @@ -245,7 +248,7 @@ class ConstField:
>
>
>  class FunctionField:
> -    """Class representing a field passed through an expander"""
> +    """Class representing a field passed through a function"""
>      def __init__(self, func, base):
>          self.mask = base.mask
>          self.sign = base.sign
> @@ -266,6 +269,27 @@ class FunctionField:
>  # end FunctionField
>
>
> +class ParameterField:
> +    """Class representing a psuedo-field read from a function"""

"pseudo"

> +    def __init__(self, func):
> +        self.mask = 0
> +        self.sign = 0
> +        self.func = func
> +
> +    def __str__(self):
> +        return self.func
> +
> +    def str_extract(self):
> +        return self.func + '(ctx)'
> +
> +    def __eq__(self, other):
> +        return self.func == other.func
> +
> +    def __ne__(self, other):
> +        return not self.__eq__(other)
> +# end FunctionField
>

thanks
-- PMM

