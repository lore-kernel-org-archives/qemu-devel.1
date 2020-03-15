Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1920EC10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 23:08:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D63E620674
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 23:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FksMBoYt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63E620674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDcMW-0001lj-P4
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 19:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDcI7-00019o-PM
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:03:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDcI6-0005cz-GH
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:03:31 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:40048)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDcI6-0005TP-8O
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:03:30 -0400
Received: by mail-pj1-x1044.google.com with SMTP id bo3so6113685pjb.5
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 16:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vsjQv/Iz831Zq7s4B7GP84/rnESVy+Sr5ugJZ/BH+8o=;
 b=FksMBoYtKEjUbmONB93hqTIRF8GEE7DjkhubBRbfXLmZvFVKGGInXCgXZtutnF2K+e
 8Owl3MtLphtPWLyMMuhePkLaMCx4GF2QBbCg8TKu+r41jzb4Sy9gE1YvfzBT/pKmOcCP
 K6kNLyTVk39t+IBTKx9+jH5GO0uH5apj3K2pvawXoobHq8bV28CRYdKFtDaABwhVgu70
 Xq1+ddddmYkuqFnfvOKgMqectaYBN7GxqfmfJ6W5kvFQWPmItrzpdGsAUxsJNGbTfAvn
 AUNezvX12xAoWFvRyHPpj9cAZkWiNrX3tjOYh/8+FXypdrMUrSEG3jHHQySgOf7uC1DX
 lC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vsjQv/Iz831Zq7s4B7GP84/rnESVy+Sr5ugJZ/BH+8o=;
 b=PzI2FSRUnA6MxwELJCU3NaAdKWtBVhgZ+U4BaT4h3phP634CONOYYqgde5LJgbcH5d
 b77JyUqbNsmygwft0IbIZZPCQhs5FIfqLEX9uTcS36rznHQMVGCTFisMnj3IjrRnY1lB
 5nulD7t9Vm/qkly+phKtmiLT7sjUSn4hyxnOLFg6wBEcuAMSdAyO748bSdgvxe130/K0
 L/Goo2Or9c5J+M3WzueyRirWusF+bL7pvoixyAAHnuiTvwZYmm9fb7gHu3RO+UG9mAZY
 7KCRlWCvmWbpNFb7kQxNOG+U/1W25QKhe7MG8vXhybUBoKVHyVidHPrKps0eY9n/nK/C
 TSxQ==
X-Gm-Message-State: ANhLgQ2+geHj+qME9Tcu7XwT36kbSDXX23XN5zfe1hLQRWNulRYgh+6f
 /QY5JU18gRvaESGLyQP904D+SA==
X-Google-Smtp-Source: ADFU+vs2nOp4HzkguExzNjy9npQ/Ys3fmSjdReXXszPmtQbBrNkzu9mwz6DsJq9k0Ow0euW+1i7iXw==
X-Received: by 2002:a17:90a:a102:: with SMTP id
 s2mr21915453pjp.46.1584313409050; 
 Sun, 15 Mar 2020 16:03:29 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 a13sm9297759pfc.46.2020.03.15.16.03.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2020 16:03:28 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] linux-user, aarch64: sync syscall numbers with
 kernel v5.5
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200314113922.233353-1-laurent@vivier.eu>
 <20200314113922.233353-3-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cb435fae-f170-f387-b52a-bd771d5c018f@linaro.org>
Date: Sun, 15 Mar 2020 16:03:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200314113922.233353-3-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Taylor Simpson <tsimpson@quicinc.com>, Riku Voipio <riku.voipio@iki.fi>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/14/20 4:39 AM, Laurent Vivier wrote:
> Use helper script scripts/gensyscalls.sh to generate the file.
> 
> This change TARGET_NR_fstatat64 by TARGET_NR_newfstatat that is correct
> because definitions from linux are:
> 
> arch/arm64/include/uapi/asm/unistd.h
> 
>   #define __ARCH_WANT_NEW_STAT
> 
> include/uapi/asm-generic/unistd.h
> 
>   #if defined(__ARCH_WANT_NEW_STAT) || defined(__ARCH_WANT_STAT64)
>   #define __NR3264_fstatat 79
>   __SC_3264(__NR3264_fstatat, sys_fstatat64, sys_newfstatat)
>   #define __NR3264_fstat 80
>   __SC_3264(__NR3264_fstat, sys_fstat64, sys_newfstat)
>   #endif
>   ...
>   #if __BITS_PER_LONG == 64 && !defined(__SYSCALL_COMPAT)
>   ...
>   #if defined(__ARCH_WANT_NEW_STAT) || defined(__ARCH_WANT_STAT64)
>   #define __NR_newfstatat __NR3264_fstatat
>   #define __NR_fstat __NR3264_fstat
>   #endif
>   ...
> 
> Add syscalls 286 (preadv2) to 435 (clone3).
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> 
> Notes:
>     v2: add comments suggested by Taylor

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

