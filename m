Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E2BC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 17:16:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA729206CB
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 17:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nztLmPU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA729206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPU64-0000Ip-7C
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 13:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kPU51-0008G4-9f
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 13:15:19 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35767)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kPU4z-0004T0-Km
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 13:15:18 -0400
Received: by mail-ot1-x344.google.com with SMTP id s66so9356283otb.2
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 10:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nVJIyap9/XZr9vJyTLMl0cL4j8xu1l5/Yffka7gkt8w=;
 b=nztLmPU3zfRbhQ8O43Wh79p7RnjsHlUsXzENttECuH+SmKoLmI2Zu9Fr6vI6oTq7MM
 7X+R1dTOFMrrjL2pCUHWj7jaYDeGjwyXbXjUaZGpRBAb9hVgbM+mwlm+9mlhpmYDJssP
 lLfd3tw+bg0gfTgMtI8pZAo+4ypJBa8neMXbFJ7JHuCuZiwbP6olrtx3Ul2QJZeLiRRK
 /lZi8/uTNwtDpxRHN8GGqgQB9N8sDH/gRay7mXKnUREN+3DuLRQ/xX+dMuHD9mCSBDaT
 WR7Waue1R00g1BJ24BiR4XINQtHclgERRGWQvqdzJrwoLbcRSeZ2nHTVjZ8yniRWlZYy
 fYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nVJIyap9/XZr9vJyTLMl0cL4j8xu1l5/Yffka7gkt8w=;
 b=UnE/yE1Jh1vNkF3qOAIsOBs5VLhjGCcJ1/iVcf0FI4WdLBvkCqe4HUQ3tR/cdAryny
 v3qep/oo10jtWvV8UR5ELsUuN4w+3np3f4UoVB60MY59tZgoOIdt80VT5vnh5UnxLqx5
 p6pvbz9ooIAXW7wNbVUF9MRvIlFFfID7xJo3RwlOUdS7XZX2+VYJJa85QA5M4dWdlvBf
 lprorq+DmM8etY9HoGe0j4AOZAGrht+EXnobz9AbB4tGZSMJY5zCloosQxYkLC6jt7LZ
 2BnbQ56pfXMreBMYilJiRZMS68LpcwQVwxYdXOPGSRgR5NEiDI8NgdLxcJKPXJOaQiXf
 hEgw==
X-Gm-Message-State: AOAM531fQPw7s4Xl72imJKz5QIWcMG0Hq3AEoTGefw458s5IsHwcm1hI
 90K3wmZWFlnjK76ZF5hhElMaTA==
X-Google-Smtp-Source: ABdhPJw0IgQlySyTZZe0IC9sRE2bTTQamklspsxMkH7PD+QjFib9mOp8UwzdYqK8HPFBBs6toMD4wg==
X-Received: by 2002:a9d:929:: with SMTP id 38mr247144otp.324.1601918116108;
 Mon, 05 Oct 2020 10:15:16 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id n23sm158995oon.14.2020.10.05.10.15.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 10:15:15 -0700 (PDT)
Subject: Re: [PATCH 0/4] Convert remaining submodules to meson, cleanup env
 var handling
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20201005135613.435932-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <148b5429-5668-2ae1-6506-53bc47160408@linaro.org>
Date: Mon, 5 Oct 2020 12:15:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201005135613.435932-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/5/20 8:56 AM, Paolo Bonzini wrote:
> The main purpose of this series is to have a correct and consistent
> handling of CFLAGS/CXXFLAGS/LDFLAGS environment variables:
> 
> - correct: avoid that the -pie flag, used for the compiler checks in
> the configure script, ends up being passed to Meson if an LDFLAGS
> environment variable exists (patch 3)
> 
> - consistent: ensure that CFLAGS that are set in the configure
> script are persistent even if Meson is restarted; to do so,
> make the configure script store them in the cross file it generates.
> 
> In order to avoid having to deal with recursive make, patches 1
> and 2 integrate the Meson-based build system with the build of
> embedded slirp and libfdt.  This follows the lead of Richard's
> patches to do the same with Capstone.
> 
> Based-on: <20201003093851.324923-1-richard.henderson@linaro.org>
> Supersedes: <20200923092617.1593722-1-pbonzini@redhat.com>
> 
> Paolo Bonzini (4):
>   slirp: Convert Makefile bits to meson bits
>   dtc: Convert Makefile bits to meson bits
>   configure: do not clobber environment CFLAGS/CXXFLAGS/LDFLAGS
>   configure: consistently pass CFLAGS/CXXFLAGS/LDFLAGS to meson

Tested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

