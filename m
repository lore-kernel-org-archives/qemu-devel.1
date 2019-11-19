Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6872BC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 19:58:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32FCF22444
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 19:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mtzgxbFn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32FCF22444
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX9dR-0003x4-Cp
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 14:58:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iX9bh-0002b7-8O
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 14:56:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iX9bf-0006PR-Vu
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 14:56:12 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51424)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iX9bf-0006PI-OG
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 14:56:11 -0500
Received: by mail-wm1-x341.google.com with SMTP id q70so4579895wme.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 11:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+vH32JhdurTQfBi31a9nzuxJjyfD6u+B80YZ/BBo1Y4=;
 b=mtzgxbFnJwhuBgupOOYig9hpzUkpRk6eko/RPFCdasB2eSwmBaTstelQ9ci7fEDzT4
 T/gBR/gVGoqA52Y00f0czUZY0VmTEJ3Zqxa0Jm8S+txFTF9KtVMxIy+1B8Gi+nie2Vv8
 i206Fx1KH10yNsjFkP8znbxtUWy9HctFGiqRZ1p0nS3/EStLUWw/k4AO9dlCbPbeLqA2
 3poln7jA1BUriXkjLcoVW6fm6GIIpVMcvhHgYgLQv1rIySO62hUHiXEWeed8ofTv1a81
 P9aVP6DOHPLcuMb21i4/kIglOAAKGobb8WfO8q6aXatl/wK1Nf9ce2fLv3FLLyesTIhG
 Tkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+vH32JhdurTQfBi31a9nzuxJjyfD6u+B80YZ/BBo1Y4=;
 b=GfXcTrSamrBpe5On+Xf4XoN8zL0BRJav8lTv0/OHBQ6slu8L9NiSsQZicA5ciUESvW
 FmhV0Xfl+/xHrD7LRdPYwh6wJW5M6Nv/2Uj2YZzHHhlrrQrZGB1HsifiBqXvvkUSLDok
 YHJ6DOeVgvr4WRcCFtNUanDB4nzFm8R0R/DJn/tWnujsvWJqHTXk4CEk5vLnB8w5ekQN
 iJF0+8s491McKJzwdX+quooQHWqIcgHJgrYu3LRvlPfMbX3E66tOiap3cspLEM/lZO+O
 9AFKHEldqZlqTE8hIfZOXJ3+TaNZ0jkMgVHbx3bWFzzYx/p9rECNbBnsCkMK2nO6es4w
 JCbA==
X-Gm-Message-State: APjAAAUCQL9nRDvjT15qTBYveHZ8+Lri1z4tTbfpLsr5aJAaNI8Kjapq
 hTk5/57wxVClCc3jz3N7V/tP9A==
X-Google-Smtp-Source: APXvYqwImVlA9a/QbL+8CrNINf31LEM2keGb6EE11yK/ZLc7fVrTku8u144Fc4JOS1ExWpWUyp69jQ==
X-Received: by 2002:a05:600c:2911:: with SMTP id
 i17mr7812764wmd.83.1574193370299; 
 Tue, 19 Nov 2019 11:56:10 -0800 (PST)
Received: from [192.168.8.102] (64.red-79-149-204.dynamicip.rima-tde.net.
 [79.149.204.64])
 by smtp.gmail.com with ESMTPSA id z14sm27798635wrl.60.2019.11.19.11.56.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Nov 2019 11:56:09 -0800 (PST)
Subject: Re: [PATCH] linux-user/strace: Add missing signal strings
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <20191119185153.GA23003@ls3530.fritz.box>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <48097cb5-bc47-e532-fcde-67ca65a2039e@linaro.org>
Date: Tue, 19 Nov 2019 20:56:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191119185153.GA23003@ls3530.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/19/19 7:51 PM, Helge Deller wrote:
> Add the textual representations of some missing target signals.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 3d4d684450..18b57a9ef9 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -146,6 +146,22 @@ print_signal(abi_ulong arg, int last)
>      case TARGET_SIGSTOP: signal_name = "SIGSTOP"; break;
>      case TARGET_SIGTTIN: signal_name = "SIGTTIN"; break;
>      case TARGET_SIGTTOU: signal_name = "SIGTTOU"; break;
> +    case TARGET_SIGIO: signal_name = "SIGIO"; break;
> +    case TARGET_SIGTRAP: signal_name = "SIGTRAP"; break;
> +    /* case TARGET_SIGIOT: signal_name = "SIGIOT"; break; */

Unused commented code.

> +#ifdef SIGSTKFLT
> +    case TARGET_SIGSTKFLT: signal_name = "SIGSTKFLT"; break;
> +#endif

Wrong ifdef.


r~

