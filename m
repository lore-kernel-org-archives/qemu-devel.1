Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70AAECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 22:13:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B789A218AC
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 22:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PnykuRYv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B789A218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIKDL-0005tG-RP
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 18:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIKCG-0005JR-IL
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 18:12:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIKCF-00075w-6J
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 18:12:40 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:41265)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIKCF-00075K-0a
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 18:12:39 -0400
Received: by mail-yw1-xc44.google.com with SMTP id 129so1409365ywb.8
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 15:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LakPK4CmK4D0XN2rFdBB+i0UJOOrNckxPFzjMv7yqwY=;
 b=PnykuRYv9QPT8quQkJzXsKN4WShPdbCCZzLDc6eEOSE738ctM+VNP5K9yRYofSMvxN
 EKnmumOluc0jUcEfGvZkyhproa5il6ygeeGh+IybVqRZ27m2VW8mH+detJDOWulPcEjG
 VIOEnGBPJksb4VT43CfK4QVyXdTucT2J28W5yP48HzRr3ZMuYFamPqrxm1Dq3uWXHQgc
 cJiwC2+6dR9lAbajZqbk3rsP69aZL3UBswcV03G+gOht5eJj7xQFvlUPs1QyvCdGe8Iw
 1B39KD+yBkcKmzvs5fp9a+fyTheeexOsaje1F2Tun/4b8qJ0RRvu3JllyKmp64L53y1I
 7BVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LakPK4CmK4D0XN2rFdBB+i0UJOOrNckxPFzjMv7yqwY=;
 b=BCpp2n68Q6gN6WoVY86UYUd6uWgCD0mUcKFkQ+XjjwkiUfzhzdbMMfaAI4/1q04diN
 FYObfbwg8jlPCfoVmVmWPKcrDOEDZWAkOJkTJIgtfLzSnyyd+8O8jYIKqQ+7FXJ6edmD
 4edRx8RPR0bXsi0fPHTvwqihrlWwdWBX1SYjHcg/lC/P65cqAOUHW6aGCx2mMrqW2jcu
 7Pk5XTY/deB2YI6OPvYTdTWeNSblvxSrMn/pqnRCNR3zlXLDrJ5vEOLVT7eq3UNuoAuW
 15ey66i3bBi9ICi7OjvTGaUZaqv1k0qgSUbQnWyCvacg0rLOB2aQFrB4muGcbc9MPy1M
 1LCg==
X-Gm-Message-State: APjAAAVTSNDwjHp0h0/vDYDTDcoK4RDWRreDEz++ZHDYS3dRpYd1HYeN
 lNPNYzNG14gUFheGT9LjtVzrQA==
X-Google-Smtp-Source: APXvYqzrNr/LQBabML8VwP3J6WIPJn0hVKvilSQuCQ7faFqNgdgr408x3mK0tgf1JhhpzKqHr9xJTA==
X-Received: by 2002:a0d:dd53:: with SMTP id g80mr4681925ywe.397.1570659157755; 
 Wed, 09 Oct 2019 15:12:37 -0700 (PDT)
Received: from [192.168.1.44] (67.216.151.25.pool.hargray.net. [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id c80sm956979ywa.3.2019.10.09.15.12.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Oct 2019 15:12:36 -0700 (PDT)
Subject: Re: [PATCH v4] s390x/tcg: MVCL: Exit to main loop if requested
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20191009110050.29271-1-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <33fc9e9d-7f26-ae0c-2b92-cde7175b55d5@linaro.org>
Date: Wed, 9 Oct 2019 08:13:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191009110050.29271-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/19 7:00 AM, David Hildenbrand wrote:
> MVCL is interruptible and we should check for interrupts and process
> them after writing back the variables to the registers. Let's check
> for any exit requests and exit to the main loop. Introduce a new helper
> function for that: cpu_loop_exit_requested().
> 
> When booting Fedora 30, I can see a handful of these exits and it seems
> to work reliable. Also, Richard explained why this works correctly even
> when MVCL is called via EXECUTE:
> 
>     (1) TB with EXECUTE runs, at address Ae
>         - env->psw_addr stored with Ae.
>         - helper_ex() runs, memory address Am computed
>           from D2a(X2a,B2a) or from psw.addr+RI2.
>         - env->ex_value stored with memory value modified by R1a
> 
>     (2) TB of executee runs,
>         - env->ex_value stored with 0.
>         - helper_mvcl() runs, using and updating R1b, R1b+1, R2b, R2b+1.
> 
>     (3a) helper_mvcl() completes,
>          - TB of executee continues, psw.addr += ilen.
>          - Next instruction is the one following EXECUTE.
> 
>     (3b) helper_mvcl() exits to main loop,
>          - cpu_loop_exit_restore() unwinds psw.addr = Ae.
>          - Next instruction is the EXECUTE itself...
>          - goto 1.
> 
> As the PoP mentiones that an interruptible instruction called via EXECUTE
> should avoid modifying storage/registers that are used by EXECUTE itself,
> it is fine to retrigger EXECUTE.
> 
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> v3 -> v4:
> - Switch to cpu_loop_exit_requested() and perform the actual exit in the
>   caller

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

