Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07474C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 13:33:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6E2F20707
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 13:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Si0TeV68"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E2F20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixWQA-0001HA-W8
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 08:33:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57161)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixWP5-0000js-56
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 08:32:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixWP4-0002jF-2E
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 08:32:11 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41813)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixWP3-0002iU-Sf
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 08:32:10 -0500
Received: by mail-ot1-x343.google.com with SMTP id r27so6529386otc.8
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 05:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=X3oak3I5x2qcKyM9o7o7AucOda6RH8Eho0VwIkg7pG8=;
 b=Si0TeV68kylwZ4d1MN0cA/vf8crcZmsvwTh+ETQmboCm+xfBy1NfTqwhCAdBQthzg6
 1OpstV5gAKuf8aiNbJ3p5eaiIFlvAGTNgjYlJJpkMrrALw1cmQ/T5C5CoWHChTPTLStJ
 FZYdwKRXxlV9mI5WTrSO+PQGMrPG6uc/YQfOa/m8gXjok1HdTWa2qGT0QJ/m7PLvJKqs
 51N36NJcUwEgTXyEzGa7TFbS36+OJWKv1O5FD8TEAjGluWpw3QTaXtdHg/ICZo8UB8CP
 CF86adk6jdHxHBEvrPjM5qj4B6zv6EBeAVSUgGgHk36sdJNnQI6ZqtmWZqg0Z5Sj9uUq
 FsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X3oak3I5x2qcKyM9o7o7AucOda6RH8Eho0VwIkg7pG8=;
 b=TdM5r7YdEmUvWAY6s5NLdtwwOl/HitcbZozSfE99BIXkgCd3B9lrKjg98nVgikOvPu
 cvUK8zqjEY9cPMWl5tPs7YT1IvpT/8ddQO2yoH6zivz+ba5e3cmEBn2z2XdI0se929+o
 RTV1WgB8UnvKktl8FXmKzSHQoUMsU8l9Gsn8fdhgoSlWCHdlqRj0mo/Z1tqWuE1ZHGxc
 owJ1zXG/QuZIEBfESMkrttZjwhVzHapAU/h2MYDM52Gez6Z5lmUORwmQ94sBHLUpn3e0
 btcAZWbzi8rnbS7ZHV2hCW1k6ZaINo9kaDGgHpGJRVoVWaTXqHAMSAn/OTcD+xGKhBv9
 SMyA==
X-Gm-Message-State: APjAAAVrUUctzJ8r/9Gb+v5aDhKE8Jl2SMrvabSu/zqRixdOuUPHmnM3
 g73/jGnZhsVBXi+wYT/NdBZmO9CKRioqRsyDXdQzAQ==
X-Google-Smtp-Source: APXvYqylG4zeNNQW+QDs13UfEugPrXYE3YfCuI1ZH/4xIwsDHRcmWRB5SOYAnzDC7gBgIp+q+M5A6c5+wcLsBj9jHTI=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr7581158otd.91.1580477528930; 
 Fri, 31 Jan 2020 05:32:08 -0800 (PST)
MIME-Version: 1.0
References: <20200129235614.29829-1-richard.henderson@linaro.org>
 <20200129235614.29829-29-richard.henderson@linaro.org>
In-Reply-To: <20200129235614.29829-29-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Jan 2020 13:31:58 +0000
Message-ID: <CAFEAcA-Cau97Z_ZnfCcre+yojuSJFmptQRvZiBSTdr1JnWk7Xw@mail.gmail.com>
Subject: Re: [PATCH v5 28/41] target/arm: Add VHE system register redirection
 and aliasing
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 Jan 2020 at 23:56, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Several of the EL1/0 registers are redirected to the EL2 version when in
> EL2 and HCR_EL2.E2H is set.  Many of these registers have side effects.
> Link together the two ARMCPRegInfo structures after they have been
> properly instantiated.  Install common dispatch routines to all of the
> relevant registers.
>
> The same set of registers that are redirected also have additional
> EL12/EL02 aliases created to access the original register that was
> redirected.
>
> Omit the generic timer registers from redirection here, because we'll
> need multiple kinds of redirection from both EL0 and EL2.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v5: Drop unioning in ARMCPRegInfo with bank_fieldoffsets[].
> ---


> +    for (i = 0; i < ARRAY_SIZE(aliases); i++) {
> +        const struct E2HAlias *a = &aliases[i];
> +        ARMCPRegInfo *src_reg, *dst_reg;
> +
> +        if (a->feature && !a->feature(&cpu->isar)) {
> +            continue;
> +        }
> +
> +        src_reg = g_hash_table_lookup(cpu->cp_regs, &a->src_key);
> +        dst_reg = g_hash_table_lookup(cpu->cp_regs, &a->dst_key);
> +        g_assert(src_reg != NULL);
> +        g_assert(dst_reg != NULL);
> +
> +        /* Cross-compare names to detect typos in the keys.  */
> +        g_assert(strcmp(src_reg->name, a->src_name) == 0);
> +        g_assert(strcmp(dst_reg->name, a->dst_name) == 0);
> +
> +        /* None of the core system registers use opaque; we will.  */
> +        g_assert(src_reg->opaque == NULL);
> +
> +        /* Create alias before redirection so we dup the right data. */
> +        if (a->new_key) {
> +            ARMCPRegInfo *new_reg = g_memdup(src_reg, sizeof(ARMCPRegInfo));
> +            uint32_t *new_key = g_memdup(&a->new_key, sizeof(uint32_t));
> +            bool ok;
> +
> +            new_reg->name = a->new_name;
> +            new_reg->type |= ARM_CP_ALIAS;
> +            /* Remove PL1/PL0 access, leaving PL2/PL3 R/W in place.  */
> +            new_reg->access &= 0xf0;

That seems like it would be more clear written as
   new_reg->access &= (PL2_RW | PL3_RW);

(strictly there the PL3_RW is useless as PL2_RW implies it but
it captures the intent better I think)

> +
> +            ok = g_hash_table_insert(cpu->cp_regs, new_key, new_reg);
> +            g_assert(ok);
> +        }
> +
> +        src_reg->opaque = dst_reg;
> +        src_reg->orig_readfn = src_reg->readfn ?: raw_read;
> +        src_reg->orig_writefn = src_reg->writefn ?: raw_write;
> +        if (!src_reg->raw_readfn) {
> +            src_reg->raw_readfn = raw_read;
> +        }
> +        if (!src_reg->raw_writefn) {
> +            src_reg->raw_writefn = raw_write;
> +        }
> +        src_reg->readfn = el2_e2h_read;
> +        src_reg->writefn = el2_e2h_write;
> +    }
> +}
> +#endif

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

