Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF0CC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:12:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68DD020840
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="enI3afwj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68DD020840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52309 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxWar-0003Gp-PM
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 09:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57518)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hxWaU-0002r2-D3
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:11:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hxWaT-0000C6-Bp
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:11:42 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43701)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hxWaT-0000B4-4R
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:11:41 -0400
Received: by mail-wr1-x441.google.com with SMTP id y8so1762224wrn.10
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 06:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WvOXG2ZUr0B31YGHB/tHYYCmtFhyhBy9nOHkj6RRJ1w=;
 b=enI3afwjGTSScqQbhvYP+k60nIG5npP0EQUyZMH/sls0JamJS/KwGjjlafVaye1Qbh
 WoXqdd7vqGNHbX71wrCuSgNFqQNvpPBTWKDXFNXVmCa2Tt6XU86ZJWKlGB1piTNmGpfu
 EZorEzn9laPQdi+WRpD3ZPDHpd4o+q0cRShyCXpnnUdovY4B6onvIhpw+xyIvR7+KdH9
 FwQG2xdiuUxxpyxufOSdeSkU16WVrpiq+3JTmoV1LtJif5WC/ATK4s7jQaoXoUma6G9S
 /VctyQ1PyBMfbXWRDgd2b/jmfwdeG23z+CM1arMo0AGlkcu0bWQtLzmtXP0zvUgYJCwF
 1S8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WvOXG2ZUr0B31YGHB/tHYYCmtFhyhBy9nOHkj6RRJ1w=;
 b=IeAJ5pUbYQs8cl80rIqsV8deApx3cYkym11XCcmpDWg9BjyCYfEhzloYJkD28bN1Bx
 2iWLJuH/KCrS9ZT4xRDoTe6VdAhH2/OBPF+fTVT0NbSAnB3eCl5ux+egCbpYpvit/PGT
 VTNd15u21ufTSR3xZggJbtMaoX9OxStNaoMwm3Mq9XbX6AFsPRt5OqAfXdMXyHseVdw1
 QEy9Qp2ujux2liMiYWiSmckG03jxU/ZDOmb8UOdyc5j2uQF3YZrxymoOSSAfF8cwO32k
 tqCKtkHojjZDkkxp/vzGxsGfQE7yRM4yLaiYzt3wdZW8n6BFa4UkvOKiDXHp8gEMHgEg
 RF/A==
X-Gm-Message-State: APjAAAXBqE3N/oOdQKX8DPMFqeh9EP7K0siyFFDzBiuosYYC/hPMZOjg
 RocvFmWdJlEi1Fm8PkRj5UpwUA==
X-Google-Smtp-Source: APXvYqwkPGeBLFqLIZANgkjFSP7p3QlMNr9Fhw3ERs2/7EUq2WV20qE4rq0tHMJFYng8caax0Xs/rQ==
X-Received: by 2002:a5d:4250:: with SMTP id s16mr31078802wrr.318.1565701899330; 
 Tue, 13 Aug 2019 06:11:39 -0700 (PDT)
Received: from ?IPv6:2a02:c7f:a69:1700:8897:9507:94c2:b98d?
 ([2a02:c7f:a69:1700:8897:9507:94c2:b98d])
 by smtp.gmail.com with ESMTPSA id f10sm95409450wrs.22.2019.08.13.06.11.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Aug 2019 06:11:38 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190813124946.25322-1-alex.bennee@linaro.org>
 <20190813124946.25322-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <02e9e013-da2d-38cd-6d92-035023f0d963@linaro.org>
Date: Tue, 13 Aug 2019 14:11:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813124946.25322-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v3 02/13] fpu: convert
 float[16/32/64]_squash_denormal to new modern style
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
Cc: Peter Maydell <peter.maydell@linaro.org>, armbru@redhat.com,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/13/19 1:49 PM, Alex Bennée wrote:
> +static FloatParts parts_squash_denormal(FloatParts p, float_status *status)
> +{
> +    if (p.exp == 0 && p.frac != 0) {
> +        float_raise(float_flag_input_denormal, status);
> +        p.frac = 0;
> +        p.cls = float_class_zero;
> +    }
> +
> +    return p;
> +}
> +
> +float16 float16_squash_input_denormal(float16 a, float_status *status)
> +{
> +    if (status->flush_inputs_to_zero) {
> +        FloatParts p = float16_unpack_raw(a);
> +        p = parts_squash_denormal(p, status);
> +        return float16_pack_raw(p);
> +    }
> +    return a;
> +}

Hmm.  Maybe avoid the re-pack in the likely chance that we can?

static bool parts_squash_denormal(FloatParts p, float_status *status)
{
    if (p.exp == 0 && p.frac != 0) {
        float_raise(float_flag_input_denormal, status);
        return true;
    }
    return false;
}

float16 float16_squash_input_denormal(float16 a, float_status *status)
{
    if (status->flush_inputs_to_zero) {
        FloatParts p = float16_unpack_raw(a);
        if (parts_squash_denormal(p, status)) {
            return float16_set_sign(float16_zero, p.sign);
        }
    }
    return a;
}

