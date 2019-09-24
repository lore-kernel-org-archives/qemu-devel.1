Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4ABC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:07:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E33214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iIEIjxjP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E33214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCmPN-0001WO-BD
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 11:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iClGS-0008FH-5Q
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:54:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iClGP-00059b-LM
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:53:59 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54233)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iClGP-000594-Em
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:53:57 -0400
Received: by mail-wm1-x341.google.com with SMTP id i16so184835wmd.3
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 06:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=RUHp7JYd4wQ3BQlGDLYgUTpWw1waURP2ZKnZ4+RWTAE=;
 b=iIEIjxjPQRjdKpL7ob2eV2MK8LWt3Nb/YFfa7IsCUvYdRu+9v4JFBARiqCeW979S9v
 GfjT+4YAF7f8LMycIzZk1KIzFZ8g8b0AxJLrKzX+i0nA5HeCva6sPtKYEEbB1J3eAGXQ
 M8WX4ZgY5e7/51d2/cw+qrJ25U7RnXAFBQiu55QiSx6RleqPrSiFBKq7dN/HK0RAxgjS
 x/xdFqs8ay4z0aho8FpiBwDSd88BPzz4NGbbYjQclGkGbgMELYYodFyMyfo6eSuAlgL8
 7z9Oql/1HSAlWSX+Z+07C+ts3JcxhDgC3jNq7hDFG4ZUf4ezfspJczDtttx+dTM0Dz1V
 3cWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=RUHp7JYd4wQ3BQlGDLYgUTpWw1waURP2ZKnZ4+RWTAE=;
 b=pJOOcXNCIRRkuaOJtQzEz1IeBr3d3Ch7AzELs3i2rRw7TDanakmH58Ktla03D+0Q/C
 X8t7QiMk2ExUd1LomFXn9KSioyUKLBPEEMipErAu/Q7127oBKFQwQbt4jASjploNiMKj
 lqVvRY2voNyM5kttOH9xnF9rAwUc6g5EIy7ZApE466ajatjVS/M5DA8Iw9boxPiG/E5K
 Y7TUdDNHvULomxG3mkpByTutGva+8duoNF96Ft7LjmMg9DxmF7fN8EdH3Z8JBuvBeePL
 9fgNC+KuMcmGBCkLR5RdmZ1knvFE4bc/Zan7vKKt2izr3n8Js52LHowSfcjFY9blorLG
 JdTg==
X-Gm-Message-State: APjAAAW6gDiIeZSfARS7TkykjuXYLcHNlFFyxgTXyH8g7xC4U7+D3Fvz
 oxndonspwFpobB9LkkzXmdbmtA==
X-Google-Smtp-Source: APXvYqwH/ga7kqntKyTDB8SyinpVbPsL+Sk0kh4Dl8BWsfEr0IlRVw3VOxv57QyZ0isx16XiPkMK6Q==
X-Received: by 2002:a7b:c108:: with SMTP id w8mr162782wmi.8.1569333235704;
 Tue, 24 Sep 2019 06:53:55 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v16sm1656883wrt.12.2019.09.24.06.53.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 06:53:55 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 538D51FF87;
 Tue, 24 Sep 2019 14:53:54 +0100 (BST)
References: <20190923230004.9231-1-richard.henderson@linaro.org>
 <20190923230004.9231-2-richard.henderson@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 01/16] exec: Use TARGET_PAGE_BITS_MIN for TLB flags
In-reply-to: <20190923230004.9231-2-richard.henderson@linaro.org>
Date: Tue, 24 Sep 2019 14:53:54 +0100
Message-ID: <87a7atby19.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> These bits do not need to vary with the actual page size
> used by the guest.
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/exec/cpu-all.h | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index d2d443c4f9..e0c8dc540c 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -317,20 +317,24 @@ CPUArchState *cpu_copy(CPUArchState *env);
>
>  #if !defined(CONFIG_USER_ONLY)
>
> -/* Flags stored in the low bits of the TLB virtual address.  These are
> - * defined so that fast path ram access is all zeros.
> +/*
> + * Flags stored in the low bits of the TLB virtual address.
> + * These are defined so that fast path ram access is all zeros.
>   * The flags all must be between TARGET_PAGE_BITS and
>   * maximum address alignment bit.
> + *
> + * Use TARGET_PAGE_BITS_MIN so that these bits are constant
> + * when TARGET_PAGE_BITS_VARY is in effect.
>   */
>  /* Zero if TLB entry is valid.  */
> -#define TLB_INVALID_MASK    (1 << (TARGET_PAGE_BITS - 1))
> +#define TLB_INVALID_MASK    (1 << (TARGET_PAGE_BITS_MIN - 1))
>  /* Set if TLB entry references a clean RAM page.  The iotlb entry will
>     contain the page physical address.  */
> -#define TLB_NOTDIRTY        (1 << (TARGET_PAGE_BITS - 2))
> +#define TLB_NOTDIRTY        (1 << (TARGET_PAGE_BITS_MIN - 2))
>  /* Set if TLB entry is an IO callback.  */
> -#define TLB_MMIO            (1 << (TARGET_PAGE_BITS - 3))
> +#define TLB_MMIO            (1 << (TARGET_PAGE_BITS_MIN - 3))
>  /* Set if TLB entry contains a watchpoint.  */
> -#define TLB_WATCHPOINT      (1 << (TARGET_PAGE_BITS - 4))
> +#define TLB_WATCHPOINT      (1 << (TARGET_PAGE_BITS_MIN - 4))
>
>  /* Use this mask to check interception with an alignment mask
>   * in a TCG backend.


--
Alex Benn=C3=A9e

