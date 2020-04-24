Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C92C54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 22:32:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C258E20728
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 22:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VPS+mabz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C258E20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS6rZ-0000Qr-Rm
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 18:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jS6qY-00088H-4f
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 18:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jS6qU-0000cA-SJ
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 18:30:57 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34707)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jS6qU-0000ap-CD
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 18:30:54 -0400
Received: by mail-pl1-x641.google.com with SMTP id s10so4292971plr.1
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 15:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tjydUoN4WhqQPtmCstVePVCAY3LtiQFkXjHbGTN70FI=;
 b=VPS+mabzEV3IJZsyvSnnoY7YtBhV01MvTPPIjDe+UIiJuT212wDg1eIqc3H+BZe+0T
 bdcZiK1o19GZ5jz8m9fEBBUBkfJGJDnKSFUxqd3eMZVYj7m7PDq9ikEnwM0SVKX+R0X1
 SRa0nyMmNE3hir2yK6zQoRhCakLF6I3V11iX5b/ObhE/2arfTqLJGV80qntlUV6DCUhN
 47aeBSIKcLTc6sG/TakUCkriSiIq4LrabG137MP/CBacEMqMBUAokBVEbtMBYCULE7/f
 EZxrOS6W+lc0qxIWKnagYMpcTBY0NLGJKGMWW8fG1eANZfxRF8WMgnEJWXE+a/gGN46g
 1sww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tjydUoN4WhqQPtmCstVePVCAY3LtiQFkXjHbGTN70FI=;
 b=r3SXbm/KkSTcEG3+n22LiWeqaQDr+40tYVYzkXuBSP65qGrgYiJvQafzWiEEM5Hqx0
 OoNTopg0BiVsAfd97UFQGvuQ5nNXHLXnVg3RykVU+3ihuQF5LjBjY/pKBtUSvrRtA4nP
 5OVxcFQWe7CV5qD9M9jWp69IJNWOgGX2vbLuaI/4h5DseGHT4Xi09eaViGabXVJGBI/C
 tenrrn30qofzIlu8dmTyrOV39Br4zSbcNvnHQ2zQQawApZ2xJJOhfnB/0Mm+p/kQb0uk
 aK2gdg6V9Dr0i6lPTYOj8ehfJUlbNB/zR5Gxki9Dp9uQrlGaXrOorKIPfvld3N74Rkbm
 gQ/Q==
X-Gm-Message-State: AGi0PuYTwQeVvihIJ3eivR4LDU+7j+a2duYFDq3W9V8cWJuNBPP/Ltf7
 /jBLjN9w0xAuumMHxg/5CAMXXw==
X-Google-Smtp-Source: APiQypIoSRUmoxgP0ZaPniNajFNR1dzqs+GaX1ZCgw3dt3Nk/Tq+QxZACjKroSCdENjailNctfnbIw==
X-Received: by 2002:a17:90a:315:: with SMTP id 21mr8180056pje.96.1587767452567; 
 Fri, 24 Apr 2020 15:30:52 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id w75sm6675139pfc.156.2020.04.24.15.30.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2020 15:30:51 -0700 (PDT)
Subject: Re: [PATCH RFC] target/arm: Implement SVE2 SPLICE, EXT
To: Stephen Long <steplong@quicinc.com>, qemu-devel@nongnu.org
References: <20200423180347.9403-1-steplong@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cd583722-3d7d-fb2e-4320-5507eea18b54@linaro.org>
Date: Fri, 24 Apr 2020 15:30:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423180347.9403-1-steplong@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: qemu-arm@nongnu.org, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/23/20 11:03 AM, Stephen Long wrote:
> Signed-off-by: Stephen Long <steplong@quicinc.com>
> 
> I'm not sure I can just use the SVE helper functions for the SVE2
> variants of EXT and SPLICE.

Absolutely.   The new insns are functionally identical to movprfx + the old
insn.  I presume the new insns were added for code density reasons, but I don't
know for sure.

> +SPLICE_zpz      00000101 .. 101 101 100 ... ..... .....     @rd_pg_rn
> +EXT_zzi         00000101 011 ..... 000 ... rn:5 rd:5 \

I have renamed these to SPLICE_sve2 and EXT_sve2, since the same suffix applies
to the original too.

Applied to my SVE2 branch.  Thanks!


r~

