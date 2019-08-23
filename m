Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E2EC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 11:53:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A29E022CE3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 11:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zH8EApw2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A29E022CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i188M-000228-TR
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 07:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53047)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i187B-00015V-K0
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 07:52:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i187A-0005oN-KL
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 07:52:21 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40353)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i187A-0005ns-F6
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 07:52:20 -0400
Received: by mail-oi1-x243.google.com with SMTP id h21so6784224oie.7
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 04:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NEVZyY35ydBxPQPnhIBNcI9GoxoiRc7bDiBdrglHNzY=;
 b=zH8EApw2L7rqCBDWDiYy3DiI2hfUA014SzG4fKnclCqzz3VafaoqQB+Jl9390lipfO
 xFxPHoWfflH7Svt6JxknckssFRBq5Jf0fLhdC4D0t/A9m+Nf1zXiCHikvLC9OPFe4Ux0
 LOCKmlbwXYZPO7ZpW9W8T7DkJIErVQPvqRq5vSL6T5l0AjCAtexUxS2NGTRaS1xjmOAQ
 2V4IN1wy22YSpQBQeHD1/BLhn789i85tebZKcQCJdV0sSnJ3vJftvxk+ksbTngBtnlRM
 Vb4Ymqs/mBEgSmiYxkRhHazuu9fc2uHTIfFk5M1p2n3N6kr9NdQSdPdDC0ecujn2FAcq
 Mw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NEVZyY35ydBxPQPnhIBNcI9GoxoiRc7bDiBdrglHNzY=;
 b=YMUByQY6WFojPmk+GeyuTSLm1ajPd1RcyEGg/hH4ip+rkJnaWcGFIrEZk3/8tRGclA
 LgUV6qKuqCTNsNJ0D4zr3gIRyz7Ud80DRvyxx0s6PLrE7AIAHgedFAIMy1/rrTNh6L0O
 9KbIKdOp0RNTefEw54gq2NxX0BswJADAoPusSP3rtAbLclRNACk/acFflKY1cv/GLO4/
 oCxEyGetgA21/kClOhFT+DpFDj91TWNZTxyi5iGRAKRD9fIvHRgpNLii+cnQLbmbGDkW
 UB7qJ5Jdis/fyXWsiLu88oLp/oIUmr/vvdx+Ok1etFud4FKbXkqtNg3O5Ft52MS7RTIT
 7FSw==
X-Gm-Message-State: APjAAAWXV1Q33n/C39PPSgpsHED7EfV9Nxqh78srMwfpg5zdJ1hPjkiW
 kl74msRqrDDVx53dQRmNJ9Wjr6V1u1ASHvNvBpHaDw==
X-Google-Smtp-Source: APXvYqy9e58hpiJ0gS5BbV1LsaZKoqTth1DVZfguJwVPXd+/I4x7BQ5yZZKIbIZT0mjnMy7mm7zFiCtC6AlZYPX/dNM=
X-Received: by 2002:a54:4718:: with SMTP id k24mr2733466oik.146.1566561139584; 
 Fri, 23 Aug 2019 04:52:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-17-richard.henderson@linaro.org>
In-Reply-To: <20190819213755.26175-17-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Aug 2019 12:52:08 +0100
Message-ID: <CAFEAcA_wTzuPfQSDQizi+GAwpLMWp-=vu4+OUCHCtbWuEMhe_Q@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH v2 16/68] target/arm: Convert CLZ
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Aug 2019 at 22:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Document our choice about the T32 CONSTRAINED UNPREDICTABLE behaviour.
> This matches the undocumented choice made by the legacy decoder.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> diff --git a/target/arm/a32.decode b/target/arm/a32.decode
> index 6cb9c16e2f..182f2b6725 100644
> --- a/target/arm/a32.decode
> +++ b/target/arm/a32.decode
> @@ -29,6 +29,7 @@
>  &s_rrrr          s rd rn rm ra
>  &rrrr            rd rn rm ra
>  &rrr             rd rn rm
> +&rr              rd rm
>  &r               rm
>  &msr_reg         rn r mask
>  &mrs_reg         rd r
> @@ -197,6 +198,7 @@ CRC32CW          .... 0001 0100 .... .... 0010 0100 ....      @rndm
>  %sysm            8:1 16:4
>
>  @rm              ---- .... .... .... .... .... .... rm:4      &r
> +@rdm             ---- .... .... .... rd:4 .... .... rm:4      &rr
>
>  MRS_bank         ---- 0001 0 r:1 00 .... rd:4 001. 0000 0000  &mrs_bank %sysm
>  MSR_bank         ---- 0001 0 r:1 10 .... 1111 001. 0000 rn:4  &msr_bank %sysm
> @@ -207,3 +209,5 @@ MSR_reg          ---- 0001 0 r:1 10 mask:4 1111 0000 0000 rn:4  &msr_reg
>  BX               .... 0001 0010 1111 1111 1111 0001 ....      @rm
>  BXJ              .... 0001 0010 1111 1111 1111 0010 ....      @rm
>  BLX_r            .... 0001 0010 1111 1111 1111 0011 ....      @rm
> +
> +CLZ              .... 0001 0110 1111 .... 1111 0001 ....      @rdm

Same question about ---- vs .... for the cond field.
Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

