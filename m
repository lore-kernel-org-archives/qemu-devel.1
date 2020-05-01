Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BB7C47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 14:31:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D61C920708
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 14:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zcHrYp7q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D61C920708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUWhT-0004Sk-1l
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 10:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUWgi-0002kQ-QE
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:30:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUWgh-0006Cl-OD
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:30:48 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:40831)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUWgh-00062d-9T
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:30:47 -0400
Received: by mail-pj1-x1044.google.com with SMTP id fu13so2400728pjb.5
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 07:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4Sz/N04yeBseEuTHRhTVGF+VHbwpVg2wGTNQ9DwZYfU=;
 b=zcHrYp7qcMdEQRe617KjHeDUvGqbvv+GlOmF2Wq0O6Ayiz++RZHa8h2b0ma6eqM28f
 jxcrhXbHK2BRCJsIQq3VdrE7vn2x/+5h8j1BPQoyZJslrc6bYVG4vH4Pkr6TQGu8Vfg+
 R9nma6KzbLcUopvZC7sHHeHe7YLugkT1CzNGGDaCIJ87EtNyNUm8Alnea4jdPB7vbwkf
 t8o+DPP8SJcODhyfKzfDi9pKuSm8UtL2GgEfvSxs7rJhiNn9g7OG2YjUgXAVNZVCxbWw
 QMBqiElIo7t+3XW7Rk9ifvvGC/PUByQZAdiGblE4L4BbeQth54n/3dAZw4b5KDmdV4yU
 10eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4Sz/N04yeBseEuTHRhTVGF+VHbwpVg2wGTNQ9DwZYfU=;
 b=g4c9Lm7Gohj0GaS1wTXg4b55JWc7KmwpTf4JSMH+QjM49dC20rUno+5LHG9I8o2ihQ
 zdmiIW3oVFn5WQ3W1QAbs32PqmoPi9xT7o7d4xWzRL3Kt8vEUE0cyWVUTu49M4ytDmgS
 +BEGxOfQ8DTnQr7LrdWFOawZhpK7KtHHnqWB6fnO3wh893CvAo3i2wpL+KNAyboNpdIk
 0rO/m2FViaEfrQq/8Dc9pO8F+Ay5ybBkfVCLHL1vTGWncmk33YfS+h/J28F8lioYpU9/
 Yigx6pLrb2IavhvoIrZ1r3ctQSX0WeTlUzSAcWevDjHRXIDE3wUFXAFM6+cmUGHjTR3x
 5giQ==
X-Gm-Message-State: AGi0PuamrdLsmxELwO4Y986urbOtw9aI2HCb8NvlwqTr+bVuEO4NnxpV
 BgiAC3JaCgZC0y/xsMcFIlsHVA==
X-Google-Smtp-Source: APiQypL9QjSrtwllqHMWR0C3GxPEbzyTHW+jRXHnkXvVC/OqActpf2DVR2ILbkMerMzdW0r5Ww5OFg==
X-Received: by 2002:a17:90a:71c3:: with SMTP id
 m3mr4800062pjs.17.1588343445625; 
 Fri, 01 May 2020 07:30:45 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id c59sm2260020pje.10.2020.05.01.07.30.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2020 07:30:44 -0700 (PDT)
Subject: Re: [PATCH v1 4/4] .travis.yml: reduce the load on [ppc64] GCC
 check-tcg
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200501111505.4225-1-alex.bennee@linaro.org>
 <20200501111505.4225-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <191f1fcc-950a-a35b-5c32-015906bd19fa@linaro.org>
Date: Fri, 1 May 2020 07:30:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501111505.4225-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/1/20 4:15 AM, Alex Bennée wrote:
> This seems to be timing out quite often and occasionally running out
> of disk space. Relegate it to light duties.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .travis.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

