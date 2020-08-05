Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13884C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 19:18:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8E982068F
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 19:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ztxM5XNE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E982068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Ow6-00055X-3I
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 15:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k3OvQ-0004OQ-8o
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 15:18:08 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33169)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k3OvO-00055l-Ke
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 15:18:07 -0400
Received: by mail-pg1-x542.google.com with SMTP id o13so25134018pgf.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 12:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yaz8pvYT44WdOR13ktOVjPShKbgNLYkguGa+xjaptdg=;
 b=ztxM5XNEmAcDWvi2Au9UO9Z6CJTQC8VCb19cz3M9RoDvhtHN6mtXtWd9yAWoT/RuV1
 EEoXyU6sAlX76/MnpCqIegKN2QTyXlZfb0HNipCbdeFxX33e+fSJgexgh4kSRjfopQrj
 2SMU7PO8n2naReN4m+RSrqKN8G/Q9JzGq47vYuN4c0R0qx74EPinEkEWjMrDI7Uhr4Hk
 i5HPCv2rgawfssbpkiJNBiupXsqddgWqiHeoyyBZ5DZOtpVd+RZ+aTn+nudbxE/UP6q2
 jX8hvxtA/OJcm+0MPZ8embogjWf61cCBAuFtjJiPFlmK3lKoS5PfY0DAE2jBe6uqdO9s
 K5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yaz8pvYT44WdOR13ktOVjPShKbgNLYkguGa+xjaptdg=;
 b=H7c77jUBWKsjN0bFDF2n1zPV2Gd0zFkKUiHDf4JV0PAOEjU2kyJugeXOa97Xp1nvjY
 xqmCqq7Vg5GoZMFlSlGUVCAecXFydgt9ZYr1OmFgGTWhqE12uN4fbxgSEwSyR39D4qov
 zVPBSBP6dB4WP3dP9U+TUcxH7OW15IZHS0YPrUQBDLKXrTpKC2RUSG5DqOphtr1VoDvn
 rVpqbvmOhU+Ofn9WZXrjiD50ZqnpkCosP7qZpZpketqh3dn6SmVCukij2mzD9MD1PtO1
 rhgw08RJftS+QzVYf+Yx92MkzpG9cWbPF8pJzKtvrSbPZYat6URHHROYEMs7OKytGrB8
 kKtQ==
X-Gm-Message-State: AOAM530uMtD6ygLEugZtVZiQxGRWVrqYSK2nUE7LrzVOG3b7w0ZqpIYp
 9z3OUy60HhYZp4EgSstcaohy8Q==
X-Google-Smtp-Source: ABdhPJzjN+3xlJXvdBBAEDDnsRbCWHJ8CbvnJpMDsHdKI8g7H7uRAIjPfW0aLtc9qrOGWYqH9JJCrw==
X-Received: by 2002:a05:6a00:3:: with SMTP id h3mr3166684pfk.163.1596655084517; 
 Wed, 05 Aug 2020 12:18:04 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id mh14sm3851519pjb.23.2020.08.05.12.18.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2020 12:18:03 -0700 (PDT)
Subject: Re: [PATCH v1 01/21] accel/tcg: Change interrupt/exception handling
 to remove implied BQL
To: Robert Foley <robert.foley@linaro.org>, qemu-devel@nongnu.org
References: <20200805181303.7822-1-robert.foley@linaro.org>
 <20200805181303.7822-2-robert.foley@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ca24d2c5-2c5e-eace-4cf2-90011e684485@linaro.org>
Date: Wed, 5 Aug 2020 12:18:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805181303.7822-2-robert.foley@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: peter.puhov@linaro.org, Richard Henderson <rth@twiddle.net>, cota@braap.org,
 alex.bennee@linaro.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/5/20 11:12 AM, Robert Foley wrote:
> This change removes the implied BQL from the cpu_handle_interrupt,
> and cpu_handle_exception paths. This BQL acquire is being pushed
> down into the per arch implementation.
> 
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> ---
>  accel/tcg/cpu-exec.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 80d0e649b2..8e2bfd97a1 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -517,9 +517,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
>  #else
>          if (replay_exception()) {
>              CPUClass *cc = CPU_GET_CLASS(cpu);
> -            qemu_mutex_lock_iothread();
>              cc->do_interrupt(cpu);
> -            qemu_mutex_unlock_iothread();
>              cpu->exception_index = -1;
>  

This patch is not bisectable.  The removal of the lock here needs to happen at
the end, or something.


r~

