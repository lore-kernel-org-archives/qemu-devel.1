Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31703C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:51:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F072320719
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vZP17B1x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F072320719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHcHE-0006TL-0H
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 19:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHcGK-0005yb-Ts
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:50:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHcGJ-0001cN-Hu
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:50:12 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:43779)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHcGF-0001Za-3s
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:50:07 -0400
Received: by mail-pf1-x443.google.com with SMTP id f206so3587593pfa.10
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 16:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JR62llYmlK3lOfZ0Ts1kjw4vIb48/JN+vpFQXWyBwc4=;
 b=vZP17B1x+rLK1Z2jOfRcwO+v+8ETY9C/vG7A/nkKcXS4duAD8lNS5Rfq86pgw6fGHA
 t0UEPvwHhk9R4HPazP8YeOkMz/+whPT6z6RsFl04uQkfKudhU09AF//2IOqmoVvahPd4
 a5IM7ZyUpYQHHg7AKu5SCR6xxNPg0riPnTACMu5eUV55KXMc8MRab6d9mkWds/kbKHY/
 JM2JiV752wf5FQYJY8LzLIztFs33npiWlLWXmqt38KaLVVwyZrso4ZK4+VBFzPEhPfXC
 krjdLfG3OfRgTPQsDi+y0wtK5z9uL4qvLeNo1PRYhRBmR4nmWGpa2jopwx6TqA/68XQ1
 gSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JR62llYmlK3lOfZ0Ts1kjw4vIb48/JN+vpFQXWyBwc4=;
 b=hWxZOqNKw1dJPUtLdNi4Ny7JeTUZVAPy9cYv6QeANFRuDGyxZbFduDqdMCh7XEB9CD
 sZmSeC4pS3V2pT/v0kkNT8734KmK10Qr3KIxuN0KFEPs073DJLgE+xouCWqeNCTXpQOu
 Q/ZCDz8Q9cUozdwaCfxVYvbdm42gebfl8eazFD2j/5WCRhZIsHPxuYPmFtNsBpZg4Rb4
 av1CJcxR6wJP32JbCPqnB6Efej2+/cQvjgrWODgpbSpgD3GC61HPlxY2FYmpaK8RZgfe
 V5nuOncJm7LUDqeucqRsbS7xLDezdfN1klQd4JICVGgzyoqan6ic/NH2dlAyc0jtRzwU
 9Gzg==
X-Gm-Message-State: ANhLgQ37RBKIRB/ao9PnAIuTCGyhYD1NOonTz4BQxf0P2PUx2DHu8xLG
 Sp3UjVJ09o6mplWgPvEf9bjD2Q==
X-Google-Smtp-Source: ADFU+vu+ZxIy+Gwm0W/tSEaG9pDPF/svz9HVR4lPNw30YQJtIO4WaxxZ5KZ8ABw2xjfjLh0slUbU9Q==
X-Received: by 2002:a63:e511:: with SMTP id r17mr11053956pgh.352.1585266605811; 
 Thu, 26 Mar 2020 16:50:05 -0700 (PDT)
Received: from [192.168.1.11] (174-21-138-234.tukw.qwest.net. [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id f3sm2422547pgg.46.2020.03.26.16.50.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2020 16:50:05 -0700 (PDT)
Subject: Re: [PATCH for 5.0 v1 1/2] riscv: Don't use stage-2 PTE lookup
 protection flags
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1585262586.git.alistair.francis@wdc.com>
 <931db85d6890ed4bc2b527fd1011197cd28299aa.1585262586.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a7f32084-2060-1de5-8308-987bcddf1e6d@linaro.org>
Date: Thu, 26 Mar 2020 16:50:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <931db85d6890ed4bc2b527fd1011197cd28299aa.1585262586.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: alistair23@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/26/20 3:44 PM, Alistair Francis wrote:
> When doing the fist of a two stage lookup (Hypervisor extensions) don't
> set the current protection flags from the second stage lookup of the
> base address PTE.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu_helper.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index d3ba9efb02..f36d184b7b 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -452,10 +452,11 @@ restart:
>          hwaddr pte_addr;
>  
>          if (two_stage && first_stage) {
> +            int vbase_prot;
>              hwaddr vbase;
>  
>              /* Do the second stage translation on the base PTE address. */
> -            get_physical_address(env, &vbase, prot, base, access_type,
> +            get_physical_address(env, &vbase, &vbase_prot, base, access_type,
>                                   mmu_idx, false, true);
>  
>              pte_addr = vbase + idx * ptesize;
> 

Certainly stage2 pte lookup has nothing to do with the original lookup, so
using a new variable for prot is correct.

So as far as this minimal patch,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

However, this bit of code doesn't look right:

(1) Similarly, what has the original access_type got to do with the PTE lookup?
 Seems like this should be MMU_DATA_LOAD always.

(2) Why is the get_physical_address return value ignored?  On failure, surely
this should be some sort of PTE lookup failure.

(3) Do we need to validate vbase_prot for write before updating the PTE for
Access or Dirty?  That seems like a loop-hole to allow silent modification of
hypervisor read-only memory.

I do wonder if it might be easier to manage all of this by using additional
TLBs to handle the stage2 and physical address spaces.  That's probably too
invasive for this stage of development though.


r~

