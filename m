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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC9DC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:50:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A4682074B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmtFLLSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4682074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQnfT-0007gO-BF
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 03:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jQncl-0004cm-Uk
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jQncl-0003HP-Ft
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:47:19 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:36791)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jQnci-00039Q-Jt; Tue, 21 Apr 2020 03:47:16 -0400
Received: by mail-lf1-x143.google.com with SMTP id w145so10320166lff.3;
 Tue, 21 Apr 2020 00:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=xfhIKdHs7m1jDBOFfnAgfme0YalFSd3WwpqXIfEBcCI=;
 b=TmtFLLSo5SWPYL7dDh2qYQSqtq4Z8KVaLrIAA1uewvBIDFBHW+RUJ3uIL8S7dgF5K/
 kU82DWFGXGy+AhNSMW5TIteeHxGvEJSX/3ov7bnI1O3TPlckFUeKJ/7RnfeXqa/wBG0t
 hjFnNwLR8Gd5dlQwOhLZBYYDBphCGO+ihiiczhKvMWxpLXlZAeSV2rgAV30wd9Sqg37T
 5AtOr6B0QGV+NIfoi9gPkkiu6k7P3iEUF+6NWpGlWxH6NqYyFYgbSAcBeSAhXf/kFK+F
 TnvsyGTdkXeaLKmdWmy84qhYkSkSFU9wN63C2CDlZiZtWjPhtAEwwCC9EpIgcLzRSFRb
 1bUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=xfhIKdHs7m1jDBOFfnAgfme0YalFSd3WwpqXIfEBcCI=;
 b=HPcN8MLpg/JfqFPTSRJVkgkPvkQgOhoXaxLiV0+r2xeSVoWqRjAv8psD5+TwklZcCC
 /L/3zotTH6e+Bl93F3bSoj+sX5AE4JGJoYfLDVEcYUliXhCVB20vsQzxntM5cfAEdaeC
 sYtY9mUe+xOq2r5RDE3K3+g9I/OmA1cbpphfXAwg3bbtmIA/C/8ImElZ52zNKnqvUu/2
 A+xiowBzlNkAJUZjFFlz7z7Y50dwn1xiaoLIdo8a1PLRsoB6hxL2oJfN0bdw4v4BOHRf
 3LfeZrfwT5JGgksptMHQhmbgBgvumPvFycfc5d8N4ElF02nNLeCOBvF8KqTH/Ln5ujAM
 A30w==
X-Gm-Message-State: AGi0PuaJTuG60H6oawtRMsTy0zPm1sra5EnrfPfgiGylUp2yNWMAXw9w
 txweGXLzOlAzCGvN6DqtoC4=
X-Google-Smtp-Source: APiQypKMnATv5pSEAbDCPdUMbsUxR5lxSDv0hy2ZkfEAMHQxTWcxh/voN+vNsxlbwnrjKhVgHAxrcA==
X-Received: by 2002:ac2:4187:: with SMTP id z7mr12941684lfh.113.1587455234510; 
 Tue, 21 Apr 2020 00:47:14 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id t8sm1475806lfe.31.2020.04.21.00.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 00:47:13 -0700 (PDT)
Date: Tue, 21 Apr 2020 09:48:24 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/4] linux-user/arm: BKPT should cause SIGTRAP, not be a
 syscall
Message-ID: <20200421074824.GF2669@toto>
References: <20200420212206.12776-1-peter.maydell@linaro.org>
 <20200420212206.12776-2-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420212206.12776-2-peter.maydell@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::143
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

On Mon, Apr 20, 2020 at 10:22:03PM +0100, Peter Maydell wrote:
> In linux-user/arm/cpu-loop.c we incorrectly treat EXCP_BKPT similarly
> to EXCP_SWI, which means that if the guest executes a BKPT insn then
> QEMU will perform a syscall for it (which syscall depends on what
> value happens to be in r7...). The correct behaviour is that the
> guest process should take a SIGTRAP.
> 
> This code has been like this (more or less) since commit
> 06c949e62a098f in 2006 which added BKPT in the first place.  This is
> probably because at the time the same code path was used to handle
> both Linux syscalls and semihosting calls, and (on M profile) BKPT
> with a suitable magic number is used for semihosting calls.  But
> these days we've moved handling of semihosting out to an entirely
> different codepath, so we can fix this bug by simply removing this
> handling of EXCP_BKPT and instead making it deliver a SIGTRAP like
> EXCP_DEBUG (as we do already on aarch64).
> 
> Reported-by: <omerg681@gmail.com>
> Fixes: https://bugs.launchpad.net/qemu/+bug/1873898
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>


Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
>  linux-user/arm/cpu_loop.c | 30 ++++++++----------------------
>  1 file changed, 8 insertions(+), 22 deletions(-)
> 
> diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
> index cf618daa1ca..82d0dd3c312 100644
> --- a/linux-user/arm/cpu_loop.c
> +++ b/linux-user/arm/cpu_loop.c
> @@ -295,32 +295,17 @@ void cpu_loop(CPUARMState *env)
>              }
>              break;
>          case EXCP_SWI:
> -        case EXCP_BKPT:
>              {
>                  env->eabi = 1;
>                  /* system call */
> -                if (trapnr == EXCP_BKPT) {
> -                    if (env->thumb) {
> -                        /* FIXME - what to do if get_user() fails? */
> -                        get_user_code_u16(insn, env->regs[15], env);
> -                        n = insn & 0xff;
> -                        env->regs[15] += 2;
> -                    } else {
> -                        /* FIXME - what to do if get_user() fails? */
> -                        get_user_code_u32(insn, env->regs[15], env);
> -                        n = (insn & 0xf) | ((insn >> 4) & 0xff0);
> -                        env->regs[15] += 4;
> -                    }
> +                if (env->thumb) {
> +                    /* FIXME - what to do if get_user() fails? */
> +                    get_user_code_u16(insn, env->regs[15] - 2, env);
> +                    n = insn & 0xff;
>                  } else {
> -                    if (env->thumb) {
> -                        /* FIXME - what to do if get_user() fails? */
> -                        get_user_code_u16(insn, env->regs[15] - 2, env);
> -                        n = insn & 0xff;
> -                    } else {
> -                        /* FIXME - what to do if get_user() fails? */
> -                        get_user_code_u32(insn, env->regs[15] - 4, env);
> -                        n = insn & 0xffffff;
> -                    }
> +                    /* FIXME - what to do if get_user() fails? */
> +                    get_user_code_u32(insn, env->regs[15] - 4, env);
> +                    n = insn & 0xffffff;
>                  }
>  
>                  if (n == ARM_NR_cacheflush) {
> @@ -396,6 +381,7 @@ void cpu_loop(CPUARMState *env)
>              }
>              break;
>          case EXCP_DEBUG:
> +        case EXCP_BKPT:
>          excp_debug:
>              info.si_signo = TARGET_SIGTRAP;
>              info.si_errno = 0;
> -- 
> 2.20.1
> 
> 

