Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C5EC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 04:05:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C206820715
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 04:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YkkX46yT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C206820715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihQa8-0008ST-Od
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 23:05:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46380)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihQZ5-0007X0-Pl
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 23:04:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihQZ4-0006pW-Eu
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 23:03:59 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:33025)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihQZ4-0006nr-8B
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 23:03:58 -0500
Received: by mail-pj1-x1044.google.com with SMTP id u63so718406pjb.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 20:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OJ8QuLvs50xb7QgUuuJ4JMKlcPCnwdM0tzFnyDlzGtE=;
 b=YkkX46yTtwelnAvSrtVq4PHU4JjhrCnXLwfY6sTMYSIJhevuoY4msW9HOuh+UzmeWf
 AOnUOkOvfjmJfZ9ggKJkSpWZYQTDM+muLjN7DNYKgkNMnqAbp0PWoCh14RBniIk7C1Pm
 TPF/IhQyzPyAjfHVzUbeZs6tciyr2P/Q/dLyqbfexcXJ3IE+hQEKEFSvPWEi1Rz1uFdr
 honrVN/LZHGilMYicUWqzQPIocPehFWozrc4FuaO1aONgf7prkb1jAsfO03uGpeV8IFc
 5ZKZXbis2K3DTolLDPGNWK0i7qbN5NkgcLgajVKyjPf6yi1PPgrcnKCN8w3TPMtBsj4m
 ptIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OJ8QuLvs50xb7QgUuuJ4JMKlcPCnwdM0tzFnyDlzGtE=;
 b=qqB/YwNGZv6YFvzItInVBYMVqk5GrAC5+P0Ir3FHitUCVp54akVdTv714wNa0uIZ/1
 AiVkfmeCZEkOnbClKnMWU4DDNNimAG+ngsc2zsSM5LR833tvM6NpZcYmS7ewb1u73CBq
 JrswWyAiXyAc31F1Up8FpTHqRNzZ8ZMiusjNXCJWs6VU9DocSFEPPBNgLFhm091TyQSm
 wC5RmjG5EOfsJtByqw3j7sgwTWwNVQDBjwTUAsyu3MNXGcS474WKKZgAsjxhDyq2gvh+
 oODA8JZVCpPs+LLRGkdSgP1Ii0qadmi7WzkZnz9sMglsT/0JuY095N/oX+qOKowhkjpW
 jMdA==
X-Gm-Message-State: APjAAAU3nu0srOHyhDY7RbQHhbbu7PKwdFzPuaUBaNA0PZkyLmXwlzqQ
 J81gqTy4zzYSjlLNmqzERvZkiA==
X-Google-Smtp-Source: APXvYqwDC1aBsDv77pimjQ44fUO/B2pO+POoQ+E72MmFV745VdZtDthWHS+H30uK4dy8VJhTZo/ZFA==
X-Received: by 2002:a17:902:9682:: with SMTP id
 n2mr317283plp.336.1576641837137; 
 Tue, 17 Dec 2019 20:03:57 -0800 (PST)
Received: from ?IPv6:2605:e000:c74f:dc00:6838:d2b2:17e2:8445?
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id u127sm706957pfc.95.2019.12.17.20.03.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2019 20:03:56 -0800 (PST)
Subject: Re: [PATCH 5/6] hw/scsi/megasas: Silent GCC9 duplicated-cond warning
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191217173425.5082-1-philmd@redhat.com>
 <20191217173425.5082-6-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b29f856a-5199-6f62-4aee-5a2cfc9f05a3@linaro.org>
Date: Tue, 17 Dec 2019 18:03:53 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217173425.5082-6-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: Fam Zheng <fam@euphon.net>, qemu-trivial@nongnu.org,
 Hannes Reinecke <hare@suse.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/17/19 7:34 AM, Philippe Mathieu-Daudé wrote:
> GCC9 is confused when building with CFLAG -O3:
> 
>   hw/scsi/megasas.c: In function ‘megasas_scsi_realize’:
>   hw/scsi/megasas.c:2387:26: error: duplicated ‘if’ condition [-Werror=duplicated-cond]
>    2387 |     } else if (s->fw_sge >= 128 - MFI_PASS_FRAME_SIZE) {
>   hw/scsi/megasas.c:2385:19: note: previously used here
>    2385 |     if (s->fw_sge >= MEGASAS_MAX_SGE - MFI_PASS_FRAME_SIZE) {
>   cc1: all warnings being treated as errors
> 
> When this device was introduced in commit e8f943c3bcc, the author
> cared about modularity, using a definition for the firmware limit.
> If we modify the limit, the code is valid. Add a check if the
> definition got modified to a bigger limit.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Fam Zheng <fam@euphon.net>
> Cc: qemu-block@nongnu.org
> ---
>  hw/scsi/megasas.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
> index de9bd20887..ece1601b66 100644
> --- a/hw/scsi/megasas.c
> +++ b/hw/scsi/megasas.c
> @@ -2382,7 +2382,8 @@ static void megasas_scsi_realize(PCIDevice *dev, Error **errp)
>      if (!s->hba_serial) {
>          s->hba_serial = g_strdup(MEGASAS_HBA_SERIAL);
>      }
> -    if (s->fw_sge >= MEGASAS_MAX_SGE - MFI_PASS_FRAME_SIZE) {
> +    if (MEGASAS_MAX_SGE > 128
> +        && s->fw_sge >= MEGASAS_MAX_SGE - MFI_PASS_FRAME_SIZE) {
>          s->fw_sge = MEGASAS_MAX_SGE - MFI_PASS_FRAME_SIZE;
>      } else if (s->fw_sge >= 128 - MFI_PASS_FRAME_SIZE) {
>          s->fw_sge = 128 - MFI_PASS_FRAME_SIZE;
> 

I'm not keen on this.  It looks to me like the raw 128 case should be removed
-- surely that's the point of the symbolic constant.  But I'll defer if a
maintainer disagrees.


r~

