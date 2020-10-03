Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA21BC4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 09:53:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E702206CA
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 09:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AVr+lCE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E702206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOeDz-00026Q-IL
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 05:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOeDO-0001Yo-O6
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 05:52:30 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40637)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOeDN-00022W-6K
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 05:52:30 -0400
Received: by mail-ot1-x344.google.com with SMTP id l4so393858ota.7
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2020 02:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dI6MSQceoyGQyNafcDDo8z39Xp3NtkmKrboZO4BdFlk=;
 b=AVr+lCE/snv+lozpJPbVz/EkxCcF0kdHV3N5+gfeT20nS0trBBohCQvjOAEqCH4Sv1
 sWJ0AQbReEfOZw+0K2ysVziBRY9bm53Z+ea9MUOPxph+oNNMgQz1m0qsLLtB9fyeJyHg
 MIjd55Yoag32Grnx7P/N64EciS/fDgCMkvA/LVgaxPRuJEjQpD9yBUaCLtGN3ZT/blsl
 2fCU8a02Aq+ukFN6WzYxtG6U8dKqegI4GjzYtKmz+i+p7daZLRBEgFz9Kwrd29u5ke++
 I1kCMXfkektIkmbnFAqOQlo3Y/vEyhuXvHeL+jSL5OfFOAImYo+x9RPMlWnAeFnzbkKB
 U1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dI6MSQceoyGQyNafcDDo8z39Xp3NtkmKrboZO4BdFlk=;
 b=Rd/8p5y2R67m2Owt211JPx9wTykO4Hr0fR6NKfUe4QqhKsNrw8DX/JI6xxC4Er4Wi3
 1LrzS6lTmtP0z+a/qOfLkrAcVH3MGuzm0ccAYbfP9XDr105mfY7CkQ3+PxRYUAiPMS75
 crR74BW3qo8m6Vf7PmDu03BB+JqN2VBRcBtYyUIT+HnQVILkdQN6vN9LoaODTqmTMYT1
 bp1fcpNI+ffeQJ34ZumYN5TL7UfCjTyCurZPPqe9lIOlsTuFu6W6JDZmIL20BE2p0C5Q
 WEyFoB7XfEeJBJB8qOD2asOLAZsh2i6xpPY0bdicx/6ieQ4k6eQax10uRdBLR2ANG616
 qpBg==
X-Gm-Message-State: AOAM532QqtV76VyZ0M2+dt5WWe/Me02fSEyW34k2ubU/oqpGcjDbR8LJ
 Rkih1gyxCqnmMTpbWRL7fnu4DA==
X-Google-Smtp-Source: ABdhPJxD+MErIQ5oDaFwq19v45SWlpim50VTqiCPIanBQsgODnWQ97qXiW4/uYJQvwb9yxEZEhm4Wg==
X-Received: by 2002:a05:6830:188:: with SMTP id
 q8mr5046280ota.278.1601718748230; 
 Sat, 03 Oct 2020 02:52:28 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id i205sm882668oih.23.2020.10.03.02.52.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 02:52:26 -0700 (PDT)
Subject: Re: [PATCH v4 10/12] target/arm: Do not build TCG objects when TCG is
 off
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200929224355.1224017-1-philmd@redhat.com>
 <20200929224355.1224017-11-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <59ecbee0-3f6c-d63a-13c8-01b47de4c78a@linaro.org>
Date: Sat, 3 Oct 2020 04:52:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200929224355.1224017-11-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x344.google.com
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>,
 kvm@vger.kernel.org, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/29/20 5:43 PM, Philippe Mathieu-Daudé wrote:
> -arm_ss.add(when: 'CONFIG_TCG', if_true: files('arm-semi.c'))

Aha, so you remove the line in the next patch anyway.
I suspect that you can not add it in the previous.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

