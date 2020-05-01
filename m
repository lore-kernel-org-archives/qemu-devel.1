Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EE6C47254
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 03:59:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23A282073E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 03:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CPG8tIRy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A282073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUMq4-0001a3-B9
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 23:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUMpR-0008Pc-58
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 23:59:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUMpQ-00048I-D6
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 23:59:08 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:42478)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUMpP-00044m-VY
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 23:59:08 -0400
Received: by mail-pf1-x444.google.com with SMTP id f7so1071601pfa.9
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 20:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=fum976EvjZXqcQsSO3m2Ob/cYuX/rk8gkGArfM1NSdE=;
 b=CPG8tIRyJwJodLsMYjYBKiiJ98Hc6w22kPaUFexU9Omqob7C7HZOeJEad0ubF6NSYE
 QoRbljy5sX9CCT5ione625Xf4R2EYQfyl/TdO5pQLAZ5Rizu1Skad9MeI/awOT8DmiGc
 ls7PXdH0Q1gOF5PQA0ATbBZdKkxji2UrOZGc9hKkrIPgX6fqjtPYBw1wswW/sRBnDNSH
 caZ7PJrJsbjyrJewj5spcxZsD4YHjL+prpx9RW0IPog9z84EimH6LC7hToN1npdiYrRH
 1W/6N/11H7LeVhch7I+uYEV6RrQOgGvxUmOiVZIolwOHq7ShSx3h7cdUNZ+DoG/iJhvU
 Xsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fum976EvjZXqcQsSO3m2Ob/cYuX/rk8gkGArfM1NSdE=;
 b=tpT/98D+FjZ2SQNjNMRcL52eDFMnohQUPXMCmW6PtQ0x4KQkTgYkB2bh565NJ4UmY0
 IjzCcsj9EjyAYkyXEVjlAb+E1XS9uW3lJ8N39ajAWWIDVtRuZZMeTa/2L0OeKYeQqrOG
 t2mkKLRIaKHFa4dGMQnwPjlvHzBrNqYloCBeIw2zNr4C5M+fO1MBQYiq+7bUpF8lXusd
 f7ESZqaXZvzy1Ydpc3aLAJBs6dTS4I1mDOsUMCqNFu4RYanZ6B+r0Vb10dsEd4UaBn8z
 6Af4TegU1r6v38y1CUdlGRu124opX6T1NXTghpJDwsjrGxdrcWVJMwUuzo3B/1WArQpv
 Y6ww==
X-Gm-Message-State: AGi0PuZbksS4OJTCXAcJJ92x17L3y+Xb4o42Z9rnfKufiW0Z0kDGm+d9
 nqZvczkGjWKpY76+NBxygIoa8Vi9Bmc=
X-Google-Smtp-Source: APiQypLClX31Kxa45aVwBpwlVbAsnSZUpjJsvq+LMJrcnNYKtCJajODOjkaX/s1IUzaxNdhg4HPqvA==
X-Received: by 2002:a62:1b87:: with SMTP id b129mr2234795pfb.162.1588305546208; 
 Thu, 30 Apr 2020 20:59:06 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id 7sm975889pga.15.2020.04.30.20.59.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 20:59:05 -0700 (PDT)
Subject: Re: [PATCH 32/36] target/arm: Convert Neon VPMIN/VPMAX/VPADD float
 3-reg-same insns to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-33-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f53f01a2-61f7-31e1-ae01-a98ee52abe3d@linaro.org>
Date: Thu, 30 Apr 2020 20:59:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430181003.21682-33-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::444
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 11:09 AM, Peter Maydell wrote:
> Convert the Neon float VPMIN, VPMAX and VPADD 3-reg-same insns to
> decodetree. These are the only remaining 'pairwise' operations,
> so we can delete the pairwise-specific bits of the old decoder's
> for-each-element loop now.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-neon.inc.c | 63 +++++++++++++++++++++++++++++++++
>  target/arm/translate.c          | 63 +++++----------------------------
>  target/arm/neon-dp.decode       |  5 +++
>  3 files changed, 76 insertions(+), 55 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

