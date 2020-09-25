Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E542C4727F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 21:40:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 797F02064B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 21:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e6b5XEnj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797F02064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLvSH-0007PV-K3
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 17:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLvRI-0006ln-1x
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 17:39:36 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:39718)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLvRF-00041z-Tt
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 17:39:35 -0400
Received: by mail-pj1-x1041.google.com with SMTP id v14so168772pjd.4
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 14:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7nB2gI7JHDpZimQ2W2y6qD51o/dpisDDTJeQuwtw2AY=;
 b=e6b5XEnjjYOf5QYDcIbcK4sxw4dJrt1h90PMFJXtZ9epCFz0rUP/5AQ98T7Ono99yc
 XnZuvNaKPqe5pOS2UMNJFXzXGIuL17tRHZKY+MImAWZBRtfor8cJzmw5b47fCK4jhiz2
 FJyfFPow1K0Q0U79a3eQMOemtZ1KUhGpqGxS6Ox+4cZsXZQfZvTt4DR8XASFzdfW6a6/
 u4ZzLJ6TZtUp22VK6FLWHq/LeO4kzYTwfrxQnvnZ8MtVM78kqfAh4wmE5lXGUw9sKHev
 6HVg6etS4nJ+suworfbqyPe8N0fel8/eA2/nDu5FF7B2wI8tUd7QLKTyKQqNlhizs3k6
 EFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7nB2gI7JHDpZimQ2W2y6qD51o/dpisDDTJeQuwtw2AY=;
 b=rhs60G553LO/wW0uMU/jD40Oreem6DRI/rhFL/pVmnctREyaDGqoDF/RhIvKSjXHNK
 xyjrFeEyIv4dgvWQAFwOFMn0K+pDoxuxb1SINJmRZTM/UyjW0tiQrbb0kF13YXRU0Bi1
 cUlkLlrKzl+hr6zQpZ0hJMfUUPMs1aUIsIHGUX6Up6nU6+RSQLfU3Cjj/eoJ9drA3IWX
 Rn0+3xkcpyaOou/W/ZvmuGBIIEaqds49fTrx5bq+m1b/jcp+G+OSmKSTSzacrKia+FBi
 vb9UQ/4uIT8gplz5xPK6Z4YQVwycIdMFB4P/Nywpqp3qGOoVLfCl42Ot6//yWxKyy/JV
 KQbw==
X-Gm-Message-State: AOAM531HZNB94//LfQoSHBpU4bQhtNEXSZPG2A6OuxOs42psaEDZfv8e
 +vjDy1nRWbgJA6QSB7iLqcX3Ag==
X-Google-Smtp-Source: ABdhPJzqRrYEbDV+ZUWM1vm92tCO1yW3bWd5KcKP4TMP8BGHJYSv3ZTWYAkQuPpUrJipvnSMyqfGsw==
X-Received: by 2002:a17:90a:1905:: with SMTP id 5mr448695pjg.169.1601069971939; 
 Fri, 25 Sep 2020 14:39:31 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id ep24sm140980pjb.2.2020.09.25.14.39.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 14:39:31 -0700 (PDT)
Subject: Re: [PATCH v1 4/8] s390x/tcg: Implement MULTIPLY HALFWORD (MGH)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200922103129.12824-1-david@redhat.com>
 <20200922103129.12824-5-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <03f6183c-b136-87de-1c3c-6a33fec5feb0@linaro.org>
Date: Fri, 25 Sep 2020 14:39:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200922103129.12824-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.238,
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

On 9/22/20 3:31 AM, David Hildenbrand wrote:
> Just like MULTIPLY HALFWORD IMMEDIATE (MGHI), only the second operand
> (signed 16 bit) comes from memory.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


