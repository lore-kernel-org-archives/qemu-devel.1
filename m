Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFB2C4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:22:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3912120679
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Aw17ZCFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3912120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOOlO-0004YS-6u
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 13:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOOjC-00032h-9Y
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:20:21 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37984)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOOj9-0001N4-2m
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:20:16 -0400
Received: by mail-oi1-x243.google.com with SMTP id 26so1934986ois.5
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 10:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RS7Me5rbRQvs4pHxmBUOrRLZOIJtNuM9wVtAI9//W80=;
 b=Aw17ZCFrqIyQB6SLrjuBiMAixCIDmcLEwaHkLKx7rDG0E8IDAvBDF+EuPAglNpoFn4
 cVcAF4fSwL55jyUD/7L3a2ESE9H+Bnl0+BMHixpKEAPGQuRGQOXmX/pZef6JnDaIN40u
 TzKcpisWlHCs4DGpehN63m2x8YSvTe1mAOT5Unuerl0Jx14HReC1x+RFRswD9tvB6Pod
 oTLkBq6D8qrQdZduTlcWOUg3xnhUHYCUgrOy41wHDnH16689aujf9tGlW5tFRxZCrNSz
 fbrXTH4AHqrCoqWy/PT+gqMDBJHVAJsn8IqQZ+mOeWqq7v9iRz3ae5TGZkaXqfkakn0I
 dgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RS7Me5rbRQvs4pHxmBUOrRLZOIJtNuM9wVtAI9//W80=;
 b=buwHliBmFUzsrGMigYupDG/XQR73WBsLZKA4qAO2bcoTzOihtcI4kFrac6LJpp+rUW
 P7zA6vBD8xW9LAjndkZ6fB6n67ckLuyX4FV6+eS8KGx6DMoikIWHs25ITzcw+NTK6pTY
 ElCJPx1nhCaVQS5sCp4tQUv5NTLVcGXndnsPoT8X34h04EHTP/yP+hI3WS9CPP6fmFH5
 32n/Zoo2ZPdsHcnAGyRr7EW2b2JRnufPqO7PyK3Xr4ChkHqR8hFoY+2uy7ysTiMVsNM8
 aIDfLOopVZJv2nuhCNqWisv1A0CTCWPGaULSFqRRzIFhaBoE+IccMb3ZM7luLdVIgIwy
 KMaw==
X-Gm-Message-State: AOAM530zwaNHrP+LAqHu+Vw4tNtMZdwCVB0fdzZC0bBK5srJhse/1JbE
 J5nBicW5GWIHiowPAHJlccNpcg==
X-Google-Smtp-Source: ABdhPJzN2FkrWC13qndq9j0szUgfHW7SVtyylzuF2TI8T4dsOHgJnsw3zh7Ayyscnz2aZ2P16AOmuA==
X-Received: by 2002:aca:df84:: with SMTP id w126mr1908150oig.103.1601659213868; 
 Fri, 02 Oct 2020 10:20:13 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id 109sm487797oty.59.2020.10.02.10.20.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 10:20:13 -0700 (PDT)
Subject: Re: [PATCH 0/4] linux-user: update syscall_nr headers to Linux 5.9-rc7
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200930003033.554124-1-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <27c34cc5-d5e2-2672-1d7a-370f81e14ea5@linaro.org>
Date: Fri, 2 Oct 2020 12:20:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930003033.554124-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.256,
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
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/29/20 7:30 PM, Laurent Vivier wrote:
> Laurent Vivier (4):
>   linux-user: update syscall_nr.h to Linux 5.9-rc7
>   linux-user: update mips/syscall-args-o32.c.inc to Linux 5.9-rc7
>   linux-user: update syscall.tbl to Linux 5.9-rc7
>   linux-user: remove _sysctl

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

