Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C025C432C3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 18:46:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E537D20717
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 18:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rSLWJGXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E537D20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibqi1-000728-3q
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 13:46:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34648)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibqgp-0006FL-8b
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:44:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibqgn-0003OH-Qi
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:44:55 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:38006)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibqgn-0003Nt-Iv
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:44:53 -0500
Received: by mail-pj1-x1044.google.com with SMTP id l4so113940pjt.5
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 10:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HWDGnAwwg81AxYaByamp6Musnv8ydCk1iaAOmLWCwrE=;
 b=rSLWJGXb+1EonvOcABrla7OAsCYaMeVKhgbWx2DrzHkhqMhrA5ThHU3rjD1jCRemnL
 L8lDdlhmIJVoHMJzqk7zyWO8Ws6OuCV3Kgj/1nXz4QKckwPGdwVy/F5YkjeVacP6FXm3
 IM8ZV60Sce4kYfUMdpeLahuiC1C26cAOsZgtRCR793Y7jnFzQidKZ8lcTWMknmo1GqpS
 FsZLTexy2ANHeb1Sh4Eurna5nf8wPblC8W1imp3KBsxJeUVFdEsFtz+D7fu+3+cj0ssh
 7CjHWw4cG7zWfR3D1FuvmIrYjftYZDGeKp9hv1F0Un6qaBkuYlNm3sn5TJIn059svLS5
 lHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HWDGnAwwg81AxYaByamp6Musnv8ydCk1iaAOmLWCwrE=;
 b=FRZ+GKeuem51P94Z0Fymm7B5ciJZF1PZtI5MBw8Ff90EEaGKudMTCSz1yTLB1BwRod
 erHLkvByQwS2y8VGmKJceD3AlL3LZA/sPkVHsqyY2i8SGgR39bIbJXMXYFI1LGJQsE/a
 +GJSp/4N46S6yMDwNO/1siBnj9V/IgJyfxrYDRH/zaKeSRMIzroMVB/7ScqZRTDxZ63a
 jynpbUga3Uz+4OEdNBKkirw1pCUsAkERuYsHOKHCcV0YHgfBVVEM+oJkxHDE1hUFD4FE
 p8Kz6TFWiNRQVdzU4eA5vKi/ewzOl8MbEQZ8+GqpCtAn81i82qWuJvSuI22vg6NYgmiB
 OiiQ==
X-Gm-Message-State: APjAAAWPmwmw/uz3iGFR8plUBUMW3+FNABGsBIvJ/5XZOrKJ22JbyWj3
 Aqb/QMSb902rxwhebbMJZoQnCg==
X-Google-Smtp-Source: APXvYqwfGoV4Eei6umuPI1vB+vYJebvtTioHWlPD277zk+ea6P4XzzXOIzRXazT9wXW9z6tQ2ETiPQ==
X-Received: by 2002:a17:902:7784:: with SMTP id
 o4mr672107pll.176.1575312292289; 
 Mon, 02 Dec 2019 10:44:52 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d1sm213069pfo.31.2019.12.02.10.44.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2019 10:44:51 -0800 (PST)
Subject: Re: [PATCH v2 12/14] target/arm: generate xml description of our SVE
 registers
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191130084602.10818-1-alex.bennee@linaro.org>
 <20191130084602.10818-13-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f0bf23c3-3bbe-ede2-3446-4ed2622d3b40@linaro.org>
Date: Mon, 2 Dec 2019 10:44:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191130084602.10818-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: damien.hedde@greensocs.com, Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, luis.machado@linaro.org,
 alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/30/19 8:46 AM, Alex Bennée wrote:
> +struct TypeSize {
> +    const char *gdb_type;
> +    int  size;
> +    const char sz, suffix;
> +};
> +
> +static struct TypeSize vec_lanes[] = {

static const.

> +    for (bits = 128; bits >= 8; bits = bits/2) {

Mind the spacing in the binary /, or bits /= 2.

> +#ifdef TARGET_AARCH64
> +static int arm_gdb_get_svereg(CPUARMState *env, GByteArray *buf, int reg)
> +{
> +    ARMCPU *cpu = env_archcpu(env);
> +    DynamicGDBXMLInfo *info = &cpu->dyn_svereg_xml;
> +
> +    /* The first 32 registers are the zregs */
> +    if (reg < 32) {
> +        int vq, len = 0;
> +        for (vq = 0; vq < cpu->sve_max_vq; vq++) {
> +            len += gdb_get_reg128(buf,
> +                                  env->vfp.zregs[reg].d[vq * 2 + 1],
> +                                  env->vfp.zregs[reg].d[vq * 2]);
> +        }
> +        return len;

This is tricky.  The "standard" ordering of sve vectors is a stream of bytes,
in little-endian ordering.  This is how the hardware handles things, even in
big-endian mode.

I'm not sure how gdb is set up to handle this.  Probably it
doesn't matter for now, since almost no one uses BE, and can
fixed later if needs be.

> +    case 2 ... 19:
> +    {
> +        int preg = reg - info->data.sve.fpsr_pos - 2;
> +        int vq, len = 0;
> +        for (vq = 0; vq < cpu->sve_max_vq; vq = vq + 4) {
> +            len += gdb_get_reg64(buf, env->vfp.pregs[preg].p[vq / 4]);
> +        }
> +        return len;
> +    }

The byte ordering of the predicate registers is similar.

This output does not appear to work for vq % 4 != 0.  The vqp type is defined
as a vector of uint16, so you'd need to output in units of reg16, extracted
from the uint64_t as

  extract64(env->vfp.pregs[preg].p[vq / 4], vq % 4 * 16, 16);


r~

