Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CFCC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 23:59:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E7D4206C1
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 23:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hD9vZKju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7D4206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzrYh-0004KJ-Do
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 19:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hzrXx-0003mz-4k
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 19:58:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hzrXv-0000LC-MX
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 19:58:45 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37401)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hzrXv-0000JZ-Cs; Mon, 19 Aug 2019 19:58:43 -0400
Received: by mail-ot1-x344.google.com with SMTP id f17so3379035otq.4;
 Mon, 19 Aug 2019 16:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=dY5LIzHVkbWB9ILL3u0iOEzcA6KWdiMjBLZi2gFgrsk=;
 b=hD9vZKjupenWeyDP1LZDdVFpfYNsfSGp89FZExQxavJws3J+av8anye2abRoGrizgG
 wTIB/69jSO+EXuJZ/lTSVDwzmYE1A5v5r7bsVd3E7yACwiSIP7qz03S6sjpwMwtEniGs
 nP30mu4sD0SIvl6gzW3l1UC/Mtq9hsn8d+betaOzaUBvTaf5l2rjVpbmbj3rZ3OdhjNv
 RwncbyAjGzFHDeUkGaNB34nRopUo+HDMnbdWo19JU8pX2J8rFTFF1AkLUi9c0jclvez9
 SzZ6/0JEcL6eYoydb1P75StjR+lGHbyzzLnG36Qfn/6CVV/LATa8PjvuLXFxp/T4VfXJ
 nE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=dY5LIzHVkbWB9ILL3u0iOEzcA6KWdiMjBLZi2gFgrsk=;
 b=uUBUj1dNZhN+begWI632dkzZiV4KHwepdSyBbnPWkNdZ3NcCJ9JUIDOXtF3tiX4ikZ
 bjWjEi0UcbUkmdJCrqxKb9R8eua0fZBh5qtoxkvdgdP5pgKgL9KQRvKsXkFEgmNrFYRP
 GV/ALC8JJQpYWUYfp/4mPzwuNtIQwp09DvpZMoRonyHxXmDCryqU7f3Ks5fE5P1iXHb8
 EwYNqbZh09DLlJUcLTpzZAi2ykQp49NFnTtrJaZS9C/drG+eyQ3Phk1JBxpfVQe3ME2p
 1UeVkr1k1rc5yyVq/0OVXTLQ6cJ48KOeIJ40sKkB3aNhoJcAk1GwcPDVr8HkhUUkJFt0
 OxJg==
X-Gm-Message-State: APjAAAW4CKyi6NFam0uR+2Bz12IyLQHz5zQFi6C+mUrWPjX00mJaSMVM
 oyHssbZu6vMPk1mcOrnt+PeKWL6iwqyBfY1NTdQ=
X-Google-Smtp-Source: APXvYqw/FnuKq6kfDiwUzKr0mJ6HCzxaUL4W9ypMfRloHMq/x6PNzUlqvvSCZFq9PzuCiFOCHIpo63kBb3exFHhn9Ck=
X-Received: by 2002:a05:6830:15cc:: with SMTP id
 j12mr19470776otr.64.1566259121877; 
 Mon, 19 Aug 2019 16:58:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Mon, 19 Aug 2019 16:58:41
 -0700 (PDT)
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Mon, 19 Aug 2019 16:58:41
 -0700 (PDT)
In-Reply-To: <1566250936-14538-1-git-send-email-pc@us.ibm.com>
References: <1566250936-14538-1-git-send-email-pc@us.ibm.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 20 Aug 2019 01:58:41 +0200
Message-ID: <CAL1e-=i31Ab782y==5HbEwZRS+a+ESnPXok2S55nnPsHOMCnpQ@mail.gmail.com>
To: "Paul A. Clarke" <pc@us.ibm.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v2] ppc: Fix emulated single to double
 denormalized conversions
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
Cc: richard.henderson@linaro.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.08.2019. 00.32, "Paul A. Clarke" <pc@us.ibm.com> =D1=98=D0=B5 =D0=BD=D0=
=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> From: "Paul A. Clarke" <pc@us.ibm.com>
>
> helper_todouble() was not properly converting any denormalized 32 bit
> float to 64 bit double.
>
> Fix-suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
>
> v2:
> - Splitting patch "ppc: Three floating point fixes"; this is just one
part.
> - Original suggested "fix" was likely flawed.  v2 is rewritten by
>   Richard Henderson (Thanks, Richard!); I reformatted the comments in a
>   couple of places, compiled, and tested.
> ---

Paul, the fix looks great, it is also good that it is a stand-alone patch
now, and thrre is a history too, and I just want to bring to your attention
a couple of technicalities to make this patch perfect:

- our standard phrase for fix suggestion is "Suggested-by:" (without
preceeding"Fix-");

- the patch history should be preceeded by a line with three dashes ("---")
- that way it will not become a part of the permanent commit message once
the patch is applied to the main tree, and we want that, since patch
history plays its role only during review process.

Looking forward to your sending even more patches!!

Aleksandar

>  target/ppc/fpu_helper.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index 52bcda2..07bc905 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -73,11 +73,20 @@ uint64_t helper_todouble(uint32_t arg)
>          /* Zero or Denormalized operand.  */
>          ret =3D (uint64_t)extract32(arg, 31, 1) << 63;
>          if (unlikely(abs_arg !=3D 0)) {
> -            /* Denormalized operand.  */
> -            int shift =3D clz32(abs_arg) - 9;
> -            int exp =3D -126 - shift + 1023;
> +            /*
> +             * Denormalized operand.
> +             * Shift fraction so that the msb is in the implicit bit
position.
> +             * Thus, shift is in the range [1:23].
> +             */
> +            int shift =3D clz32(abs_arg) - 8;
> +            /*
> +             * The first 3 terms compute the float64 exponent.  We then
bias
> +             * this result by -1 so that we can swallow the implicit bit
below.
> +             */
> +            int exp =3D -126 - shift + 1023 - 1;
> +
>              ret |=3D (uint64_t)exp << 52;
> -            ret |=3D abs_arg << (shift + 29);
> +            ret +=3D (uint64_t)abs_arg << (52 - 23 + shift);
>          }
>      }
>      return ret;
> --
> 1.8.3.1
>
>
