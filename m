Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F72C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 16:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AD112065D
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 16:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nh4HWzrW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD112065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYuTl-0002z6-OU
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 12:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYuPn-0006En-RM
 for qemu-devel@nongnu.org; Wed, 13 May 2020 12:39:27 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:42106)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYuPm-0004R7-US
 for qemu-devel@nongnu.org; Wed, 13 May 2020 12:39:27 -0400
Received: by mail-pl1-x644.google.com with SMTP id k19so44862pll.9
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 09:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=OBr73iEUiGBjQ1e5GgJBBBBNVpZDgpmLr3OzsvI20hs=;
 b=nh4HWzrWGbUi24HGXNc9SNrFWhpIYNsNunHEOqJAC0Ht68X+yyWkIYo25Gh48R7IfB
 hA50FEk8uVdOsGT17njo9MbfeB+037mrtU9bhOhOvL7bsbVuwHgWOtV8NMbvJuJGIldK
 PZG7AntHGhvnp5trCUFKCK0JIMFvYnKhetHgK+Oxot7q/oXSEofbkuqr2zPKjwL7PuNx
 AtnP/iJQiqrmdm5HhWqDAU6IVdmXn1Ce7oced/Shv+8S/AjSFL+X3nkiOUxtyljxq6lE
 jVEyaimkEgmm7Pwcp+FWdWqbCodEHktgnbT/JjX3+TyhG2m1pDfr21RAsF0xWjLzyXW2
 ZAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OBr73iEUiGBjQ1e5GgJBBBBNVpZDgpmLr3OzsvI20hs=;
 b=f4lrlSlsFwZI+M2Gc39PPX90gNwreQP230KGnZRE6WbyjHoukogEZoW4e77Y9o+JvA
 an1FaEUJ4BGLvOtWWR0GWaKMCvyz9cISfnG0l3t9pVlqJK7YtDXiNMSFSrXAktnUASp9
 5n1qGExxWClTdIJujQbFOWhovkngEUI4fhYjqXp3C6iCwsf62ttNE2LrJy6/YE2StbkU
 WZI77W+3mejUydaKiGZbAKC6jC6cLsynKwRO6t4mF7Dssqi2zj+VcvsUaEJ4qQwf/gL6
 TKQn6bT96LAjyJO/zmhNH3BBebkqSeMvkcN3uxthUR3ApWK+hHqEoutLqkoZNeyQNEBl
 vNTQ==
X-Gm-Message-State: AOAM532Ues5FkFEim7/eCM6vZClux5fIP7Fe+VOkfaHZpb2cvczCQcfi
 2TsHdRv1PWCNviiaC4i4n0MQnzFUIT4=
X-Google-Smtp-Source: ABdhPJwCxhWV9NrFrjiO2XYkLlzBnylwT2rIJ7zuFA0NySbyLsCRZOw+PTo4EC2C7Q5ZRSvfsyePzA==
X-Received: by 2002:a17:902:b40b:: with SMTP id
 x11mr76691plr.174.1589387965042; 
 Wed, 13 May 2020 09:39:25 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id n69sm15530604pjc.8.2020.05.13.09.39.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2020 09:39:24 -0700 (PDT)
Subject: Re: [PATCH v2 01/17] target/arm: Convert Neon 3-reg-same
 VQRDMLAH/VQRDMLSH to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200512163904.10918-1-peter.maydell@linaro.org>
 <20200512163904.10918-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <caa8fd30-f392-4e8f-029c-c9c66db8efd6@linaro.org>
Date: Wed, 13 May 2020 09:39:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200512163904.10918-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/12/20 9:38 AM, Peter Maydell wrote:
> Convert the Neon VQRDMLAH and VQRDMLSH insns in the 3-reg-same group
> to decodetree.  These don't use do_3same() because they want to
> operate on VFP double registers, whose offsets are different from the
> neon_reg_offset() calculations do_3same does.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> v1->v2: use do_3same() rather than custom do_vqrdlmah() function
> ---
>  target/arm/neon-dp.decode       |  3 +++
>  target/arm/translate-neon.inc.c | 15 +++++++++++++++
>  target/arm/translate.c          | 14 ++------------
>  3 files changed, 20 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

