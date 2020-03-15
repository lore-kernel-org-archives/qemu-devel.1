Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337ABC10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 19:05:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F16C1206BE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 19:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eMGKJITk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F16C1206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDYa1-0005Ip-U9
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 15:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDYVE-0003qv-In
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 15:00:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDYVD-00038X-Di
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 15:00:48 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:54889)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDYVD-00032s-6C
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 15:00:47 -0400
Received: by mail-pj1-x1041.google.com with SMTP id np9so281602pjb.4
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 12:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:references:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=+xiRzFtTWzfXu/iJWLx+c697oUduiJITs/FIvDVkUW0=;
 b=eMGKJITkzww4kX2U17R6n0Ox+xdZFx6jn0GVb5822oSfDeupUL70iEkU2Fz9Ab2BV9
 4dpAAmGD8+bk4fTnIv0uifLYyf9wc9BkPJaFFWqABGDCt2g8Z7/AKoepxR0QRwhNILHF
 YFLk0A0FiMuA9BTf/rgNy+I+Ln9nv3HkGosKQ5elFCDk5cx5p2tvuVxOF2+Vfi2NLE/f
 +yvfUWp8HhEF4LOolwM1rgoruGN/vRH49hAbrgRXeCX3T3Gdr/QleeEVT5JhnEuXdL4Z
 FPAsjcxtZI003E+1jDRwwM5TdIXhSZyuQmVH1c9sniPIHSdEEcBZgyCsHx+/OOnRnsTO
 qxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+xiRzFtTWzfXu/iJWLx+c697oUduiJITs/FIvDVkUW0=;
 b=cW12byGjjDS6AGsfAwlmU3eusGOHs6n17ILnGy7QcJxUwAaV6BUGmOj7CgYDHH1Iiq
 O6rnIe1Exelg/EaoPtyB2OlTB+46faUFq/LfGiG4BVE5SAgktOJajKe8OZVmyEOj+60u
 AVHZyDCmaIcBsn99iCRBzGCTdPBPESl0gLAPEfqz7BZykYM4aE8EXEcflXbDoRLKznAC
 qNBoafU/tQ9o36ADsCe8aYwhez0vpHI2Zc2UKUpfRgjCvxoJ2y0R8sYuBymvcjFFG/vu
 PmqJtG6yWGy2oBrFNiTa7TkUsqY/QLE3WWlYMAoe9+rLyj42NrumWbHX3M4UUa+PNWB/
 bZKQ==
X-Gm-Message-State: ANhLgQ0GfK4Jva/N6j0+ad1ZD0grT9azYSEZHwSUO5R1JTMtX3qbD4GC
 PO0HapbpKqFHlltBZllTYBsNQCGKqj4=
X-Google-Smtp-Source: ADFU+vtZSykzzu4srwqR1W/t4Nzy6MFzkSfEABszEs2KEJqBbP8MJOT9D0fBDZt8VZIY06xbfWahrw==
X-Received: by 2002:a17:90a:ad97:: with SMTP id
 s23mr3174885pjq.179.1584298845536; 
 Sun, 15 Mar 2020 12:00:45 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 f8sm8148938pfd.57.2020.03.15.12.00.44 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2020 12:00:44 -0700 (PDT)
Subject: Re: [PATCH] tcg/i386: Bound shift count expanding sari_vec
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20200311052145.14004-1-richard.henderson@linaro.org>
Message-ID: <55601ab4-0297-3b29-84f4-a7ebc39d642b@linaro.org>
Date: Sun, 15 Mar 2020 12:00:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200311052145.14004-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping.

On 3/10/20 10:21 PM, Richard Henderson wrote:
> A given RISU testcase for SVE can produce
> 
> tcg-op-vec.c:511: do_shifti: Assertion `i >= 0 && i < (8 << vece)' failed.
> 
> because expand_vec_sari gave a shift count of 32 to a MO_32
> vector shift.
> 
> In 44f1441dbe1, we changed from direct expansion of vector opcodes
> to re-use of the tcg expanders.  So while the comment correctly notes
> that the hw will handle such a shift count, we now have to take our
> own sanity checks into account.  Which is easy in this particular case.
> 
> Fixes: 44f1441dbe1
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/i386/tcg-target.inc.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
> index cdedcb2b25..223dba9c8c 100644
> --- a/tcg/i386/tcg-target.inc.c
> +++ b/tcg/i386/tcg-target.inc.c
> @@ -3391,12 +3391,15 @@ static void expand_vec_sari(TCGType type, unsigned vece,
>  
>      case MO_64:
>          if (imm <= 32) {
> -            /* We can emulate a small sign extend by performing an arithmetic
> +            /*
> +             * We can emulate a small sign extend by performing an arithmetic
>               * 32-bit shift and overwriting the high half of a 64-bit logical
> -             * shift (note that the ISA says shift of 32 is valid).
> +             * shift.  Note that the ISA says shift of 32 is valid, but TCG
> +             * does not, so we have to bound the smaller shift -- we get the
> +             * same result in the high half either way.
>               */
>              t1 = tcg_temp_new_vec(type);
> -            tcg_gen_sari_vec(MO_32, t1, v1, imm);
> +            tcg_gen_sari_vec(MO_32, t1, v1, MIN(imm, 31));
>              tcg_gen_shri_vec(MO_64, v0, v1, imm);
>              vec_gen_4(INDEX_op_x86_blend_vec, type, MO_32,
>                        tcgv_vec_arg(v0), tcgv_vec_arg(v0),
> 


