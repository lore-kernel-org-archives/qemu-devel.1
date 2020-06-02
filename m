Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FEFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 21:09:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACBF1206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 21:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PXdtFCWW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACBF1206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgEAR-0001a9-V1
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 17:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgE9a-000141-QF
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 17:08:58 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:35960)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgE9X-0000FA-3Y
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 17:08:58 -0400
Received: by mail-pg1-x532.google.com with SMTP id t7so155229pgt.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 14:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=K+M6Pvla854LNIgtZ2U/jFfcYaAA3cQ1pNoIep5CpBE=;
 b=PXdtFCWWnw+phUIJEGa+vbNJ3SUg+DZjW+GhH3TwUeWBKzsqYOod0pv+aUvY+xSeT9
 92yChRWNoX2NrHMBpWfjzFNDeMF+CQRMSBLqSXN3aGLFb9LTWWtvffok6w80cgrK1sQv
 JIQTNdHp/UM3QqeS1AtsL88EERk+STTfsVcSy5Kh9J7DatRW0d30HdUKBwK6fmiayeKN
 ivsLiIffrCqTzCCXy7JpJl2p4OaVh/RJJb6N2K96G2UOJYJu/80tJLvuQvJZUcrlo1yI
 ukn5Ic/r6EGPS6laHz0hS+2g6okEfYEfTWDxIJMkCCDEoFuPDFpcki8mqVWzDP5Q9TCv
 KTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K+M6Pvla854LNIgtZ2U/jFfcYaAA3cQ1pNoIep5CpBE=;
 b=HtGvsOiCyD7wea8TJGWcVUCyw+PX9j/wh5K/p0CGnji4DlvWYu1nKW9lyO2V5MQAfb
 O6BJLlPB+o5ey8djXJaXHQQ2roMolufsHI5KEwxoNvOSTtDSZ3Ju2oJxlFpoWjZQEaF/
 Fb6g18tXkbcFgAhHutfwm9DCwvC3b2mPy9o9PzwtUPO+3x/KXzCE2Brr0BdMcKZtaM96
 yMHLqI/CUrCkUpzeJb1/4ewJDy5c1A8oEV9EZ+t4AzgqqivPUmomgvI5IYZtrKN7GjPc
 gfwW+myZGDG63c2HbH3c044dC8/9hNL0EB9KiZ5Tb6QZ36m/XC1Rdkt17hQU6ERGXiX8
 7fpQ==
X-Gm-Message-State: AOAM533O3mW7tYvGM1Uwc1rnHMMe/iXol5hWQOYd7zM6FjC34gtuJRjz
 CA+mHeRiYizxshp9aSthN1uJEw==
X-Google-Smtp-Source: ABdhPJyxDPX5GfWA8XC02MHRAJ65ancd1BLHZdzhmKAXX4UeedwvjszRltDpj2ThJlozEO5rZsnKVg==
X-Received: by 2002:a17:90a:b78e:: with SMTP id
 m14mr1189872pjr.114.1591132133306; 
 Tue, 02 Jun 2020 14:08:53 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id q26sm58606pfh.74.2020.06.02.14.08.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2020 14:08:52 -0700 (PDT)
Subject: Re: another tst-arm-mte bug: qemu-system segfaults
To: Szabolcs Nagy <szabolcs.nagy@arm.com>
References: <20200529120427.GB18623@arm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2382e2e7-5349-22c2-7726-2f13ed510686@linaro.org>
Date: Tue, 2 Jun 2020 14:08:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200529120427.GB18623@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: nd@arm.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/20 5:04 AM, Szabolcs Nagy wrote:
> again i'm using the branch at
> 
> https://github.com/rth7680/qemu/tree/tgt-arm-mte
> 
> to test armv8.5-a mte, now qemu-system-aarch64 segfaults
> and it's easy to reproduce: minimal source and static
> linked binary is attached (should be executed on linux
> with mte support, i used mte-v4 kernel with reverted
> memory property check).
> 
> the __aarch64_memchr function referenced is from
> https://github.com/ARM-software/optimized-routines
> 
> and the bug was originally observed when running the
> test executables built with gcc-10 and a config.mk like

Thanks.  I've been able to reliably reproduce.


r~

