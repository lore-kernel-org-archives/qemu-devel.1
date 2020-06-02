Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38A4C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 03:05:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80AD420671
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 03:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wWMf2Zx/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80AD420671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfxFM-0006js-Pb
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 23:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfxEa-0005lh-FN
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 23:05:00 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:38249)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfxEZ-0003Nk-0b
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 23:05:00 -0400
Received: by mail-pg1-x534.google.com with SMTP id u5so4424053pgn.5
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 20:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sK8y7xhDEF0wbhrDmJJQQ5pcbRsUuAZjohJXLjpoMlo=;
 b=wWMf2Zx/lRqctG6jKRqZGwPyvsLNqZFLUCnRgXJF+8L/5sIMdjjeX7HPp9rlfsaIrJ
 IQ2LirI/fc9uQXbngWjpPJWk2SkVCm0pvfXvLqrYw+wY/droh4jdsg6A+eqEI6QOH7/v
 /31hf9RvP6qu9Ki1QFKUdbIAwtBJ81I7VFHxNm6KnRSZE8WiPwWH4dr8sSOQGNoH34j7
 YMBmiN3wSDp9MbFMLlJcpncYFFeHyq1o81Pa00eFY2p8jQtwqt4JiUWzRjHifiHc7Eov
 eEIWxX/nRFsqxmz+mASgwrmaR+OK0dMGyvVItPAkHQ7/12JARlwENFNi23qkOFRmhOd/
 Cosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sK8y7xhDEF0wbhrDmJJQQ5pcbRsUuAZjohJXLjpoMlo=;
 b=KGOrEQE5S9f5FZGWv/lo1MbVW4eNvegwrbQqpXxlEyhBvK/rdzaKyAhligzSCT99Vw
 ZKV+InL9y0oL+lhMssiG3aHUhfJ6ZPsK6Zvj0mL6fgYfa4xrs7cqtSNAVvb5yPW/eQrn
 fPoJ5leUmk64INgqqcUdqnUDoK/NzynnQ7YlBksPaakt9zMoDyp61qPgRJ6GKwjExnbx
 mazEHynpM6/9ClZ5XnQWpVWJKXK0AEJPQm6D1Kus5mamQS+VAM53ooorjgvjA2h6Pb/i
 efpDId4hDtfEfEA9+nnPPsF9u3qdg8M9p5eY2DGcpBIUylhv5awGORAUDi3DWgcbHpsp
 zL/w==
X-Gm-Message-State: AOAM530W0YqtBys78AtWaR8p3+wWUfu0HG3mmMNfa1pOvhPt0BuLmeq2
 pqR9lbJPUi9wm5LTSYSScLjuuA==
X-Google-Smtp-Source: ABdhPJwYD8LkCJGDEZJ5YOh2yTBuJbwriG3lG7KEKU9o9y+kC0wdxFzaQT+QxSdlTJC4Ls3qqlVlNQ==
X-Received: by 2002:a62:884b:: with SMTP id l72mr8413251pfd.242.1591067096763; 
 Mon, 01 Jun 2020 20:04:56 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id x1sm676531pfn.76.2020.06.01.20.04.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 20:04:56 -0700 (PDT)
Subject: Re: [RFC v2 01/18] target/i386: sev: Remove unused QSevGuestInfoClass
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 brijesh.singh@amd.com, frankja@linux.ibm.com, dgilbert@redhat.com,
 pair@us.ibm.com
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <20200521034304.340040-2-david@gibson.dropbear.id.au>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <66291c37-7804-cfad-4c96-56a0852f09b3@linaro.org>
Date: Mon, 1 Jun 2020 20:04:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521034304.340040-2-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/20 8:42 PM, David Gibson wrote:
> This structure is nothing but an empty wrapper around the parent class,
> which by QOM conventions means we don't need it at all.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  target/i386/sev.c      | 1 -
>  target/i386/sev_i386.h | 5 -----
>  2 files changed, 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

