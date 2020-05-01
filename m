Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D534BC47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 14:26:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2E3E208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 14:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DGAz51s/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2E3E208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUWcy-000628-QZ
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 10:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43906)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUWbw-0004f4-7X
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUWbv-0004W9-9O
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:25:52 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43598)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUWbu-0004S9-SB
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:25:50 -0400
Received: by mail-pg1-x542.google.com with SMTP id l12so1761875pgr.10
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 07:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=iR8JMy0SyhUT7oKtYkCN2YhQ6eaJ14Q10CYb7jrvKpQ=;
 b=DGAz51s/R1vAoqiTrJo6OQS7Aw6ov+sGp9Qw4SOexDo27y9QOj9S5WdMg40eQlspLH
 dJd/NznbHeah1e4fTtB4alx//kYExZ/wP+fR/zAJe0D+Z0RXoH0TPxFs5+d8TbrzAGtY
 lEtfI9F9aRLQT3hDEqyL5kFPpmDKS8zfOV/bFE4uH85ZRcNJAhokemncL/zLRt/lldNL
 JwsKADtvOhB7ngQA87NvutMdnC+chq/f9LLpOA1y9LCfsng/vGW8DwoFP2waQ+/sAM7F
 bvmgwvD5yvczE51pY5cSgPpZBrBIVA/g43OVlOfHIHlZzc/OdNZz3NxOyLwLmnKM5SSj
 c3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iR8JMy0SyhUT7oKtYkCN2YhQ6eaJ14Q10CYb7jrvKpQ=;
 b=tL7q6U3cDP7x5qjbPIK61HD5Y5Rr5bpLiyGxHd6wyZWITk5XV1etDKE3oPbnlM+u2X
 rd1ImeJOa7OMmhdGuNcQbe9ONy2IWxhWDm7MH0ynv9KXTyC9vSxl9YzuJuqHtOFhwvJz
 HrDCmEz7caewrrUYb2gPjXrBxjhwPfe4dAWbklVS0stECeKB79aV8HRmxEdOdJpRh/9B
 d+oz2K+cj+JktRn3m9z2NaVOY11NqL1Vop63XM8iwt+dXkoCcsTKIl8ip8wTpHofw6lh
 7FoNpwm9mN0d5aelu//ATMIkH9Zn9EPWy8ybyxizLpOc9ztac57kqg1Hgu7NYKOTCL6h
 7wKA==
X-Gm-Message-State: AGi0PuZFuompiT1ViGfvxJStLQ1g7tWOshA3mBUTtsjdge9gXKiCqHWQ
 qkEA8yTouV0DaAoH7gCOfzV4/w==
X-Google-Smtp-Source: APiQypKFv+EIaab9bfnIOkXfaaXDdupD7VAi2xgvnauTk/nY0kGaJpWKsHNq5mSg8nQkjaG+z8rZKQ==
X-Received: by 2002:a63:1a58:: with SMTP id a24mr4465637pgm.419.1588343149476; 
 Fri, 01 May 2020 07:25:49 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id s123sm2423177pfs.170.2020.05.01.07.25.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2020 07:25:48 -0700 (PDT)
Subject: Re: [PATCH v1 2/4] .travis.yml: drop MacOSX
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200501111505.4225-1-alex.bennee@linaro.org>
 <20200501111505.4225-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <15bf2169-1bfa-3987-4a67-a2b1fdf50cba@linaro.org>
Date: Fri, 1 May 2020 07:25:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501111505.4225-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::542
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
> This keeps breaking on Travis so lets just fall back to the Cirrus CI
> builds which seem to be better maintained. Fix up the comments while
> we are doing this as we never had a windows build.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .travis.yml | 28 +---------------------------
>  1 file changed, 1 insertion(+), 27 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

I haven't had a single green run on Travis for at least a month because of
macos failures.


r~

