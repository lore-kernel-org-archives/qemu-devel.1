Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2882C388F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 21:06:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 219F821481
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 21:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0fyptWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 219F821481
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVhmj-0007jX-3I
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 17:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVhlW-00075q-GY
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 17:04:56 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34699)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVhlU-00062R-I5
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 17:04:54 -0400
Received: by mail-wr1-x441.google.com with SMTP id i1so5087703wro.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 14:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WwGmdYUJPuVvuY0nFGDSznf0+DInFcGSC1/EvDyVCII=;
 b=k0fyptWQf/JEr8IuciC7i72r5bnP25xcnToUT5sJRlvgaxK7cB4D0rpA1oRUbkJjef
 8F2f4TO3LZJXYQDazgAFD2XLKBF7ZKm/cnLtSppzj1WSnxMOX3g+WEzs7Kek26RVpZ/G
 8GSPy1MF8f6QBEQg1EvPk5wZ4kipvFsc7djE/qZqrLAmo/+58q6eC4RC6unUg21Z/OlD
 +QC15AweZ19eP0z0p4bR859SL3l8gnLIqVcQBT6Y5YZMc4X9jXbfiCCnHhOvPZRhkNJJ
 uaxSuIzVFlHpqwn6Pnodrf9m8s5YzIRzaXtd+3Y5xdX03WFlrQKBenflHwylLQvMg6Px
 jdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WwGmdYUJPuVvuY0nFGDSznf0+DInFcGSC1/EvDyVCII=;
 b=b37NK9QE7gqxJtIhTeEWlQBBfOb1Pqxp03FyiUa5LxmbTU2lgbu3hWIztksQv5+u8G
 3RlnsfrFZpNGzuLNq2Hcr//QMVDq+dOAigDwXFX0syYmpHxev+VGGL1LCp0VoUY3r1gu
 faaIm6/DxNSvo+DQzqY69DcVq9CX8Z1C4swE5I3Abu0AlfudQQmIhC1vrYcL3jZKj0S2
 9FEnJa2tKPhW3/tyYyybYHpSPdTqH7TqB8LgNST0/P8UarA8OxwJ+VpbrroBc4Ut+KkJ
 NTJxmmlmc7nMPlFt0iLLMvv6QyDODxR/blJKPljhcIQbO0QkArbMTOkEog74w8tj5KaO
 O93g==
X-Gm-Message-State: AOAM531f94eIXRNDwFWTdESVDOGm2jORabnwxAB3QOf1dK+LBoNuDS5p
 nkw7B+wOSLpdSdjTPQwMZXSjQ7xZx/0=
X-Google-Smtp-Source: ABdhPJwk3lgRaIwMs3vZUDS79CIPs/uihaC1IO5q67y5NZcdyi7sH+iRSlTNE+RAsehSwU1SdH6d7w==
X-Received: by 2002:a5d:4c4f:: with SMTP id n15mr4408013wrt.137.1603400690875; 
 Thu, 22 Oct 2020 14:04:50 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id x15sm6711645wrr.36.2020.10.22.14.04.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2020 14:04:50 -0700 (PDT)
Subject: Re: [PATCH 1/2] target/m68k: remove useless qregs array
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20201022203000.1922749-1-laurent@vivier.eu>
 <20201022203000.1922749-2-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <772c0f4d-38d2-f51d-2179-250cc3d74d4f@amsat.org>
Date: Thu, 22 Oct 2020 23:04:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201022203000.1922749-2-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.107,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/22/20 10:29 PM, Laurent Vivier wrote:
> They are unused since the target has been converted to TCG.
> 
> Fixes: e1f3808e03f7 ("Convert m68k target to TCG.")
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   target/m68k/cpu.h | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> index 521ac67cdd04..9a6f0400fcfe 100644
> --- a/target/m68k/cpu.h
> +++ b/target/m68k/cpu.h
> @@ -33,8 +33,6 @@
>   #define OS_PACKED   6
>   #define OS_UNSIZED  7
>   
> -#define MAX_QREGS 32
> -
>   #define EXCP_ACCESS         2   /* Access (MMU) error.  */
>   #define EXCP_ADDRESS        3   /* Address error.  */
>   #define EXCP_ILLEGAL        4   /* Illegal instruction.  */
> @@ -139,8 +137,6 @@ typedef struct CPUM68KState {
>       int pending_vector;
>       int pending_level;
>   
> -    uint32_t qregs[MAX_QREGS];
> -
>       /* Fields up to this point are cleared by a CPU reset */
>       struct {} end_reset_fields;
>   
> 


