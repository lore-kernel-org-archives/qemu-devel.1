Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F243C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:23:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56F8F2199C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HXK2srHM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F8F2199C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvNmH-00026o-LR
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 11:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52654)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvNlV-0001Rn-NW
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvNlU-0000ae-MK
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:22:13 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41488)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvNlU-0000ZZ-FY
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:22:12 -0400
Received: by mail-pl1-x642.google.com with SMTP id m9so41168786pls.8
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 08:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1hoAsKtF3zqsFQtWBUuvddCQSQZoJ0c/zZDeC2QkDLQ=;
 b=HXK2srHMtJIjFp5zptw4lQ5+DHWBgAnWrlqomT8WAcFnMVk7CryUbiO9gX8xJ4EDUh
 YDxlxZsmnQIgHolL3gqT+aYsxdmCiV7H5pgrxtpdefsfDL6j7rP/AcA3T38jfDH5dxbc
 rB8IH/iQC6jcLQdPxNGni2p0XlBCG6cMwkq3lWlvKoqcAYV/O1kpIO/N5i5hTwc6bdCM
 /Rl0NxLxBcSUzl5ZHMDpy+K1r7yjmz8ZfSWn8G/dAhzJiAbU6TTdlW8oNychR/yxuIcF
 5hP9GTveMBbEnVqOXdxQKcE0JzMW1kvsy/Sk3n70H2jEcUzS38WVn83Wnok2GwVc4hA5
 OuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1hoAsKtF3zqsFQtWBUuvddCQSQZoJ0c/zZDeC2QkDLQ=;
 b=SN36OgH8bTqAx+Mli9MxSCCaHjKgOr70xrm+UM1ctXSINdHvVnkQ8WlBpVhh8rpVJw
 vtrCYT6qbWT/ES5ju+vpbFBGqxPCJBSzcnBTdgX6Xi06PwUy+nQ/XShC4QBoH3jLr91O
 ucuFRvOBnlW6POQlk6I1Y2uBZKdAuNnmzDA4tHiH+0rHihq635zqrSDWWzT7ZZsJr9hO
 JVGXLmPqzhyub2y7uyIAxh12V0WUFRdqiXGFT4EdlkOLFAb+tO5HJx5e1E/7+t8602cq
 qDgSf2ZrjZKAYSAc9KHx6XrVgRO9p47Kbm2+Xci7h9FJ88rIUrOaGbWWjycr7mPEg5qi
 W9bg==
X-Gm-Message-State: APjAAAXSDbhLyaAo1uH0trfLCbrz/8S7GlOpOxu9XElEEON7uKYwsFic
 6NQKZmzTJOt6oO4gcJb7BzLdDw==
X-Google-Smtp-Source: APXvYqyQ2n+QO1FiGZLqliF+OoioFWqgszZxmcr5zeQggc1PTBEXBZK8wsphLrtt/T2nkkS1HQbu2A==
X-Received: by 2002:a65:41c2:: with SMTP id b2mr8140986pgq.320.1565191330521; 
 Wed, 07 Aug 2019 08:22:10 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id s20sm103427419pfe.169.2019.08.07.08.22.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 08:22:09 -0700 (PDT)
To: Andrew Jones <drjones@redhat.com>
References: <20190802122540.26385-1-drjones@redhat.com>
 <20190802122540.26385-4-drjones@redhat.com>
 <d0983bd5-c1a5-adf6-324d-2b199ca0e23c@linaro.org>
 <ec44ddad-c33c-918b-e94b-a534a2519a9e@linaro.org>
 <20190806122144.bb3klk7aaaqdhgwi@kamzik.brq.redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <39a4d205-d291-8962-2693-6bbcce89c332@linaro.org>
Date: Wed, 7 Aug 2019 08:22:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806122144.bb3klk7aaaqdhgwi@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH v3 03/15] target/arm/monitor: Introduce
 qmp_query_cpu_model_expansion
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, armbru@redhat.com,
 eric.auger@redhat.com, qemu-arm@nongnu.org, imammedo@redhat.com,
 alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/19 5:21 AM, Andrew Jones wrote:
> That's a reasonable suggestion. I do like having self-contained
> validation, self-contained, but when cross-dependencies arise, then
> it does make sense to have a master validation function, rather
> than interconnecting too much. That said, for this series we only
> enable the qmp query for aarch64, pmu, and sve* properties. aarch64
> and pmu are independent, and thus self-contained...

Agreed.

> and I consider
> all sve* properties one big entity, so their validation is also
> self-contained. If we add vfp and neon, then indeed I was wrong
> with my suggestion in the commit message. They would need a later
> validation check. Should we just cross that bridge when we get there
> though? Or would you like me to see how that would work within this
> series?

While the sve* properties are handled by one function, they are not handled as
"one big entity".  You examine then apply or diagnose the effects of sve384=on
before you separately examine the effects of sve512=on.

I think it would be easiest to merely record facts while processing sve<N> and
sve-max-vq, with no side effects.  Then in the common validation function see
the required side effects and diagnose errors all at once.


r~

