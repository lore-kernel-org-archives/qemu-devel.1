Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E94AC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:51:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3807D2074B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFMsj5Gh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3807D2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQngs-0001Il-EH
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 03:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41942)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jQne0-0005yy-JK
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:48:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jQne0-0004MP-6r
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:48:36 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:46905)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jQndy-0004Le-Pu; Tue, 21 Apr 2020 03:48:34 -0400
Received: by mail-lf1-x144.google.com with SMTP id g10so9858134lfj.13;
 Tue, 21 Apr 2020 00:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=DmgR/ol4cIUTE4zV76diVDEM3DGOAl/uYRTRw2Si0hk=;
 b=UFMsj5Gh9sRbXMsNUjoDhou8LVqXb2XE8LDOD1duMv349zPhf15th287k+Ooyoyhdj
 TjUWtFiDfTvgCzKsMaNHabEzQH/6b10cb1mJbW1r9rNp0/kEjgypF/DEcR5rPhpT6pXm
 xGG2E5bGkMgBVa7J9+8FwePXFc+Sx9Sxm/BGktJbo8IU2LMhDuJEpBzMRW6MiYgcO6cP
 agjvJhHCdyYGEdl5tbPNCmmBCtX+yvCk4PRtlljv21RQpJp1WcT15IBUNhFGiuhBNwO1
 uoSYKQtOkQYDH2OsPW4pWla02lvuhgbcYQOREYSH5XsPLREOfDwEaTy0HlL4sIDWhdC+
 Bqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=DmgR/ol4cIUTE4zV76diVDEM3DGOAl/uYRTRw2Si0hk=;
 b=gLh1GaywF+YxpLjTiDqA9twr4Mt+NMryo+JCRNXPWW5QOTlO5pxEu2AxNqb4PjjkRa
 PXLudirnygNrMLgc9If7rkLQ9Ah97X4NZKl4UB2BepNsobr4IeCTTq+bkSOyqcKg6PI0
 by8z/yvlnPnr6E9zGjuWTvhDy+22RxfnmWP9ZN8RJF3xG1oN1m8IPF2Vyi1897+cJplp
 2XPKIIHcnvl/dx883WT47i2Cjni6M6pOnA1Run6CRSSGkho6kKhJIkeiSbg0HTBKVFHR
 X6LrQAIAs61we3RD57tlm+4s/ARKqbzggjXU50gEAGzz5HxxQZV6RA0hxOxam6n1qz+r
 mR5w==
X-Gm-Message-State: AGi0PuZTn/+v1/36euX7LD2nYTA14GxnjgXtoUJ0keGUC3cfvtg0MhjC
 CUyHggw+aOTvA98E5YuJW8Y=
X-Google-Smtp-Source: APiQypIvzehqyfoR6RLAtYlGf0rlrNgYWD/ibnXygUrCvUPf5CpDgtmksbmIrLn41sDW57IabP6wxg==
X-Received: by 2002:ac2:5109:: with SMTP id q9mr12830354lfb.145.1587455311611; 
 Tue, 21 Apr 2020 00:48:31 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id v17sm1439225lfe.34.2020.04.21.00.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 00:48:31 -0700 (PDT)
Date: Tue, 21 Apr 2020 09:49:41 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/4] linux-user/arm: Remove bogus SVC 0xf0002 handling
Message-ID: <20200421074941.GG2669@toto>
References: <20200420212206.12776-1-peter.maydell@linaro.org>
 <20200420212206.12776-3-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420212206.12776-3-peter.maydell@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::144
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
Cc: omerg681@gmail.com, qemu-arm@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 20, 2020 at 10:22:04PM +0100, Peter Maydell wrote:
> We incorrectly treat SVC 0xf0002 as a cacheflush request (which is a
> NOP for QEMU).  This is the wrong syscall number, because in the
> svc-immediate OABI syscall numbers are all offset by the
> ARM_SYSCALL_BASE value and so the correct insn is SVC 0x9f0002.
> (This is handled further down in the code with the other Arm-specific
> syscalls like NR_breakpoint.)
> 
> When this code was initially added in commit 6f1f31c069b20611 in
> 2004, ARM_NR_cacheflush was defined as (ARM_SYSCALL_BASE + 0xf0000 + 2)
> so the value in the comparison took account of the extra 0x900000
> offset. In commit fbb4a2e371f2fa7 in 2008, the ARM_SYSCALL_BASE
> was removed from the definition of ARM_NR_cacheflush and handling
> for this group of syscalls was added below the point where we subtract
> ARM_SYSCALL_BASE from the SVC immediate value. However that commit
> forgot to remove the now-obsolete earlier handling code.
> 
> Remove the spurious ARM_NR_cacheflush condition.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/arm/cpu_loop.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
> index 82d0dd3c312..025887d6b86 100644
> --- a/linux-user/arm/cpu_loop.c
> +++ b/linux-user/arm/cpu_loop.c
> @@ -308,9 +308,7 @@ void cpu_loop(CPUARMState *env)
>                      n = insn & 0xffffff;
>                  }
>  
> -                if (n == ARM_NR_cacheflush) {
> -                    /* nop */
> -                } else if (n == 0 || n >= ARM_SYSCALL_BASE || env->thumb) {
> +                if (n == 0 || n >= ARM_SYSCALL_BASE || env->thumb) {
>                      /* linux syscall */
>                      if (env->thumb || n == 0) {
>                          n = env->regs[7];
> -- 
> 2.20.1
> 
> 

