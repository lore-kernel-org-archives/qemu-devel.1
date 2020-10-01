Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB574C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:31:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DBEB20759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xZroER+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DBEB20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO1Uf-000231-1t
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 12:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kO1Ki-0006u7-0l
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:21:28 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43525)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kO1Ke-0002FR-TN
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:21:27 -0400
Received: by mail-ot1-x344.google.com with SMTP id n61so5983311ota.10
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 09:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=L1xb5SFOCXA4bWgV6QiO/XT0SFZohLNyVxUl7O47BWQ=;
 b=xZroER+0eZY3J5Nhl/XBp6h6EBjidxxdXuSEODmyuehYma0inOyVyRSsD8ViK4Frbd
 AmCHZk6yf/NzuUSW130Mg4yCIcrywW10ffj3hqPnN2VjuVigVqZSvAwMDjJr6Eygrtkz
 xsAieSW5IRU7cwXQodABUc/4F+itb9ENHUvxCnRphL9YhCHflQ+Owa6JMVPm4+VWXt6b
 C8eI3HZ1fMSiobAw+enAfIQZViT8hKRrl/14EhxFJpUo39KO0OV4Yy7tMRAvbXOCmBkB
 jvTdF2Tgcc5d8uHGM5gp6YCPgHOncMYmicYmMyYNhZw6m34OJrlJecU5JOf0KtqSxA5F
 PcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L1xb5SFOCXA4bWgV6QiO/XT0SFZohLNyVxUl7O47BWQ=;
 b=pmEAUFL6uDfH26rsr9489972a8mTJ798FYTW+yF4Q3chqs6u6FyOZaGuYR7rspVLU3
 2PJNpZPCu94wqB5srjPRP4suY96EqXLU5Ll4iBHVmGfpD3C5l+tLKY85wKk+mrHJ/ieZ
 6+WMQv40yrXPZekvY0RjYQdZTF/frKcdaMVUB7ZRlmZGov4Iiuegaj0W8muJA9/1jh76
 0gThZrQVFoHS94TirrzWft0Ri3x458CZxANkePsz8iSlcWfHnS03ifoEkJtQYCvMSF1G
 PIn8Y7heVkelJkfd8FMh9/Sb7eoS4bh/EsR3KJqgOllVE2EytFcz8TXsrrF8Oa/Okzh8
 em4g==
X-Gm-Message-State: AOAM532tVjgVHIPMiSoIMo/VLpijYc+uANtCa2XfKBf4a0d3rSYJytHy
 JAW3Pm6QtT861biq2P96AKSFJA==
X-Google-Smtp-Source: ABdhPJz5Hn1wMU2Ex1D2hyQpL75hDnDVMQWTMOB7ZzWN7TJKJjTzg/aK0Dv4yoWvSPN1SeKSF4IPaA==
X-Received: by 2002:a05:6830:10d5:: with SMTP id
 z21mr5641753oto.292.1601569281901; 
 Thu, 01 Oct 2020 09:21:21 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id w7sm1431817oon.2.2020.10.01.09.21.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 09:21:21 -0700 (PDT)
Subject: Re: [PATCH v1 12/20] s390x/tcg: Implement 128 bit for VECTOR FP LOAD
 ROUNDED
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200930145523.71087-1-david@redhat.com>
 <20200930145523.71087-13-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f6fa4862-dc54-c943-9bd8-a8b838397304@linaro.org>
Date: Thu, 1 Oct 2020 11:21:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930145523.71087-13-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.26,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/20 9:55 AM, David Hildenbrand wrote:
> 128 bit -> 64 bit, there is only a single element to process.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  1 +
>  target/s390x/translate_vx.c.inc | 11 ++++++++++-
>  target/s390x/vec_fpu_helper.c   | 19 +++++++++++++++++++
>  3 files changed, 30 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


