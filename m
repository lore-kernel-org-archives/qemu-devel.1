Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9370EC48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 18:47:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F4F520663
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 18:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CndLwFoW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4F520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgCxJ-0001vS-Hb
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 14:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44352)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hgCfn-0001iO-Mb
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:29:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hgCfl-0008C3-NY
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:29:35 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51520)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hgCfj-00088j-LQ
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:29:31 -0400
Received: by mail-wm1-x342.google.com with SMTP id 207so3119907wma.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 11:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=A46Hpmb0H66Rk2WS0TVzfFJH8LvfoXnQh8E86a/0j0U=;
 b=CndLwFoWxryuT+syMpNFHIaAUh1jPwSZSOpw5U7UhHIXU75LI5fEeLM0Dv6qjruVpN
 wn39OKnZVIIGIV7u8+V3SVDkDK+nl87N6nZAOuxum8/SNITf95o1cBHTpOjei6BAmqxm
 4d+QqD97F4a/X5heJPdFYZ7/L1rCzaRYwgzUqRlg/7BDRUUsAvqM/NcdPLIcVdAFzjb4
 gOyGjOpm1Pzv/L2766nHH61fSGgkmMsEgwUAr7kHV1u0nYsnSefDS0bgoRIU27UG/cuV
 1RWvuTCVFFOD9K7rkg9v5RffOLfZzwu56t8xCXiASG9gpYwqg6w2r4umwN7MLfINpBZz
 oqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A46Hpmb0H66Rk2WS0TVzfFJH8LvfoXnQh8E86a/0j0U=;
 b=Kg8rrJeNyksu8n79KEMDKUTEeCkHEi5XA8FXg1fkFptwn+9qjHPv+GpB41j/gnmZYQ
 25GFk42sG8jq8xXsOxbGzm4pNtSUdHegyQ8p4g28MDS2aSWq2lPku7sRaf880rhVi8kP
 iwLz9rgpzKmhZu8josjDwdQC9rGuk82/RGwj9EWJTojnMmayG9Ns0I2faT0sJLGbWvBC
 aG5ma8/t76rn//MuNgKyABiXzn2xFQ90eWpTKLYVhtW84fkhcQvuxcPj2ofN0o5q4OkW
 9LUP/5Hn1OZpgQEp3jddyzdFmzVb0D2L2EUs0fR2EE/SS5pykV+wqTQ1u1rYsqx/mdp0
 FhUQ==
X-Gm-Message-State: APjAAAXXucZhc7bscYqpsHNTzGPnHg/NhsF/kjJnTQCPKl/ku0PCV6rG
 Ce+fA+AS8qGr8L7j8wX1L6o+6TyDSjt3tQ==
X-Google-Smtp-Source: APXvYqzPhsB98Xghu+9qWcshSZcY16xNyA5mac45ebzqRpi/IgNtmpW6r5B3LhL2pus/2/VTiKhxPg==
X-Received: by 2002:a7b:c8c3:: with SMTP id f3mr272529wml.124.1561573769177;
 Wed, 26 Jun 2019 11:29:29 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id v204sm3368331wma.20.2019.06.26.11.29.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Jun 2019 11:29:28 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1561038349-17105-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1561038349-17105-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <31b602e7-bf33-ec29-d6e3-6a61abefa866@linaro.org>
Date: Wed, 26 Jun 2019 18:02:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1561038349-17105-2-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v2 1/4] target/mips: Fix emulation of
 ILVEV.<B|H|W> on big endian host
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
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/20/19 3:45 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Fix emulation of ILVEV.<B|H|W> on big endian host by applying
> mapping of data element indexes from one endian to another.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
> ---
>  target/mips/msa_helper.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
> index be059a3..215d8af 100644
> --- a/target/mips/msa_helper.c
> +++ b/target/mips/msa_helper.c
> @@ -1737,6 +1737,24 @@ void helper_msa_ilvev_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
>  
>      switch (df) {
>      case DF_BYTE:
> +#if defined(TARGET_WORDS_BIGENDIAN)

The commit message talks about the endianness of the host, whereas this check
is for the endianness of the target.


> +        pwd->b[8]  = pws->b[9];
> +        pwd->b[9]  = pwt->b[9];
> +        pwd->b[10] = pws->b[11];
> +        pwd->b[11] = pwt->b[11];
> +        pwd->b[12] = pws->b[13];
> +        pwd->b[13] = pwt->b[13];
> +        pwd->b[14] = pws->b[15];
> +        pwd->b[15] = pwt->b[15];
> +        pwd->b[0]  = pws->b[1];
> +        pwd->b[1]  = pwt->b[1];
> +        pwd->b[2]  = pws->b[3];
> +        pwd->b[3]  = pwt->b[3];
> +        pwd->b[4]  = pws->b[5];
> +        pwd->b[5]  = pwt->b[5];
> +        pwd->b[6]  = pws->b[7];
> +        pwd->b[7]  = pwt->b[7];
> +#else
>          pwd->b[15] = pws->b[14];
>          pwd->b[14] = pwt->b[14];
>          pwd->b[13] = pws->b[12];

FWIW, avoiding this sort of duplication is why other targets define helper
macros like

PPC:
#define VsrB(i) u8[15 - (i)]
etc

ARM, S390:
/* Note that vector data is stored in host-endian 64-bit chunks,
   so addressing units smaller than that needs a host-endian fixup.  */
#ifdef HOST_WORDS_BIGENDIAN
#define H1(x)  ((x) ^ 7)
etc


r~

