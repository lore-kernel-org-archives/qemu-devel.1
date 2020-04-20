Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00203C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 18:07:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF5E3206D6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 18:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iuf7sjcI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF5E3206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQapW-0005ZG-Tu
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 14:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39178 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jQaoW-0004uE-Kf
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 14:06:37 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jQaoV-00017s-QP
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 14:06:36 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:39996)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jQaoV-000173-7I
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 14:06:35 -0400
Received: by mail-pj1-x1044.google.com with SMTP id a22so186286pjk.5
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 11:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Y/q97tNUy33Qie7GTOfiL8/EmYLdh4AV+2gMB2fSR+s=;
 b=iuf7sjcImbuaETe3zR0m1Lff/bS8FHaRrwbTRyAULEJZ0Pbruonn+eMCiViT/ht2vI
 wP2d++zo9L/8PwzHEQ5LBAEIYrDr97WlSlQVMotMaRKKWJwygL6owF7IXSbIIT35T1Vs
 3ElkRyfetN1lkomujAnhm01rVaTKIAbuvxcoIKsS+cl1RYD5H+44dBOYR8hbqSB9B2+t
 vi09pA+N4UY9URsnC/gkHYISRwYQWXsa3RPGOVLghFNMI1C12hKWB1f+u8gzAHmiwPH8
 nG9FP6JmG74BYSnndEbVERGn8rfAAsebg1gF3NsdVW6Aw6JXk+yKxaANnMFpH+4xUPRY
 2Dsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Y/q97tNUy33Qie7GTOfiL8/EmYLdh4AV+2gMB2fSR+s=;
 b=c4ZYDJnEH5cxCawBQSTvvbwt2iRYw/MFvjdQID/V3LV8A3wuoMCr2FX/R/V6GcEfcb
 AyOMlNRHKfsLpd88Z8NgD7qi6xzp8C1DavJAjBuVgjZen7cpJqONbUJgWyMlGhUy+Mx6
 ShjUjoFKKAKlPkSEh+m+nSBFn9IiKbvKOlxpoj15wNw2AFUP+bM1of8r6FPMxjOpt0E9
 OKHikvZAkUjKqUp1GgFXOdEk1GOOmZN7rJgHbhtiHabPC70JM2WtgFgsAwh97oSMj6Su
 4ESf4QOe5Q9TtqH+I2OQi2gVvKGBHDZZZCQXmpg45OKEwy9TT2eh2vPBVTElZ/exurYG
 fepw==
X-Gm-Message-State: AGi0PuaOOnAG9rtafxht0cUDbmQCT6L1rkbW0fp6wZhE7aPusqKxpi4/
 jc1bU2vCn1uCoRaHLQX96XMjcYxurfI=
X-Google-Smtp-Source: APiQypJQD2g58zejpfpGVNssYbSp6lfoGeZqAwTd6PX5g5hLdk51KBJ8KepOPHe/5tWOpch4l2MPnQ==
X-Received: by 2002:a17:902:9f93:: with SMTP id
 g19mr17375339plq.208.1587405993293; 
 Mon, 20 Apr 2020 11:06:33 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id l15sm1760208pgk.59.2020.04.20.11.06.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2020 11:06:32 -0700 (PDT)
Subject: Re: [PATCH 00/16] tcg: Better handling of constants
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200418161914.4387-1-richard.henderson@linaro.org>
 <87a736dv3q.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2f020e80-2450-913f-7d40-4b45b93b9b71@linaro.org>
Date: Mon, 20 Apr 2020 11:06:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87a736dv3q.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/20/20 8:39 AM, Alex Bennée wrote:
> The series failed to apply at the first patch. Should it be based on any
> other patches?

While I had split it out of the middle of a branch, I had not realized there
are dependencies.

Best guess is the "tcg: Clean up tcg_gen_gvec_dupi interface​" series is what
you need.


r~

