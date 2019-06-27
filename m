Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CCDC48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:44:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F00A6208CB
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i/IqEhIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F00A6208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgSop-0006Tj-9K
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 07:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35708)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hgSks-0004Ma-L3
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:39:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hgSkq-0005b4-0n
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:39:54 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33708)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hgSkp-0005aI-Jb
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:39:51 -0400
Received: by mail-wm1-x344.google.com with SMTP id h19so6873292wme.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 04:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=drASMurGZmMU7RstNuoOyLVE8vIm/LJOj83sEuTLfj4=;
 b=i/IqEhIRobOdBcgiaS0fuTtdQ73ulZFclcvIFAPfoKm0isgiaH5/LMJgnA0Hhx0KFk
 onDWvgu0+vxzxSYMy1pBKr/d+15EQlUOSzXoFlx64YJNld54THhm/wBclBdGtFRURRRH
 cY1ot38aR7u2jq5gdgkQR6iJLKLMYeqiZFdZe6ro7qCrWn2F4QgHjfqbTksi3Dj2QkW0
 u5gt8g4DDLP6uYtPaj0+yRcV7hsQvOxw5F/6iESVQnOXl8fteadf41VaLhGpoLgDkpBj
 wn/oh0T2M5ZzdyclddOyk2QOIQrrG3cTvdudhLWKofmaVvX+lLY+7+Ln+/fQ8pBPa0iW
 ZG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=drASMurGZmMU7RstNuoOyLVE8vIm/LJOj83sEuTLfj4=;
 b=kCu3vN3Fzhj3DFSCWDlsVrEQR5pfb/B5qlQOqVFW5oJAXBzX6dtOkfA4/YarEpal3I
 3jenGIIpQz1Ot9MzWIE1y7WIJjSjUEyYSR6WCsSUsNRRg6KyaukPamyKf8JnvEFIAbgM
 HS52G8xEPP5gypOVYpD+DKigvhe1ObiRMQMUIAvu6OYyLxNXlZzYwcIv1Pdd2g/r3eHh
 2HRHFh3r+Z0/xKyn5EooNJ8nsHc3fg3ejA7DqfAU06ZVIxjbnKjsi7HTcfUs5eeCXeH+
 5fOXG18sxD+yuPpNYMS+gW3g0ObL42tMgP1yo3VM1VycmFKdRq40Ugf8v2RZMJepaFoE
 OA0w==
X-Gm-Message-State: APjAAAWd+v4vbCNSSwKLw77oWih2mc28kz7lsWSGFS9PUL+zouRlAemT
 c9NFbfeQJjHrGJd+klOpCF/jZw==
X-Google-Smtp-Source: APXvYqwPzpP2dDIs55v+vnTZ+wBMlwC1HQNvzs2tTqmIZE8ITjpRj5tStOXelDexITgLM6gyb+vDww==
X-Received: by 2002:a1c:9dc5:: with SMTP id g188mr3042156wme.93.1561635590435; 
 Thu, 27 Jun 2019 04:39:50 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id x3sm2020775wrp.78.2019.06.27.04.39.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Jun 2019 04:39:49 -0700 (PDT)
To: Stefan Brankovic <stefan.brankovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1561632985-24866-1-git-send-email-stefan.brankovic@rt-rk.com>
 <1561632985-24866-9-git-send-email-stefan.brankovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <fe916cb6-ecc4-dd46-6a65-b4a048321ac0@linaro.org>
Date: Thu, 27 Jun 2019 13:39:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1561632985-24866-9-git-send-email-stefan.brankovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v4 08/13] tcg: Add opcodes for vector vmrgh
 instructions
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
Cc: hsp.cat7@gmail.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/27/19 12:56 PM, Stefan Brankovic wrote:
> +void tcg_gen_gvec_vmrgh(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
> +{
> +    static const GVecGen3 g[3] = {
> +        { .fniv = tcg_gen_vmrgh_vec,
> +          .fno = gen_helper_gvec_vmrgh8,
> +          .opt_opc = vecop_list_vmrgh,
> +          .vece = MO_8 },
> +        { .fniv = tcg_gen_vmrgh_vec,
> +          .fno = gen_helper_gvec_vmrgh16,
> +          .opt_opc = vecop_list_vmrgh,
> +          .vece = MO_16 },
> +        { .fniv = tcg_gen_vmrgh_vec,
> +          .fno = gen_helper_gvec_vmrgh32,
> +          .opt_opc = vecop_list_vmrgh,
> +          .vece = MO_32 }
> +    };
> +    tcg_debug_assert(vece <= MO_64);
> +    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);

By the by, you've missed out on the 64-bit operation, which your assert allows
(and should be available, if this is supposed to be a generic operation).

Also, because this operation does not move data in strict columns between the
input and output vectors, you can't use tcg_gen_gvec_3.  You'd need to write
custom code in order to allow 2 VEC128 to implement the merge for a VEC256 (or
any other combination allowed by MAXSZ).


r~

