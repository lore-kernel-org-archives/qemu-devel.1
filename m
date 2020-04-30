Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AABC47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:54:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37A3A20731
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IaLBbrMI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A3A20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUFGo-0005kz-B7
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 15:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59986)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUFCd-0002mM-Rh
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:53:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUFAe-0000Ic-SG
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:50:35 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:36551)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUFAe-0000DK-4Z
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:48:32 -0400
Received: by mail-pj1-x1041.google.com with SMTP id a31so1322437pje.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 12:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=UpQjuFQGlXCBka9FDciY5sQW5t2fBEgI7GjM+bWcVwk=;
 b=IaLBbrMInSjLsiNZ+EPTZHxC2WMzgaGrt03xz9Wrty/y9DMxYlG/UJsrFsfyA9z+Fp
 vj6gUZ4Bfp9GkrNn+1isPuTF3YYv7jW2A0mDXzmsSSoZ06dExUPswsbX4XFbEJUFcbm+
 epu/fqS8PX8FTaccGAh9GE0MQ7oh6sm/WRkdyx0wwwVJcL3n0MYwsFGBmF4sdWjie9bV
 CwmpS1G08gNO4Uz7SK1atqVTBF50wb/utNO3TRnP/5ONfS0Ka1wyPKFu7hyd7f6dVPwN
 GmrljZkK7EJ33aifnhPluWSdIxQftilW8nK+z5u/zGLeQJAQvfdZpjCULoQmgTKWg2vP
 TryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UpQjuFQGlXCBka9FDciY5sQW5t2fBEgI7GjM+bWcVwk=;
 b=HCNxB3aIGSrh/CtGD6xWf4oIVI2RbG18374hNKrsQYV0AqJ0agZ4SMlpaTso5aWnai
 UK12flK/JZxz+Vm7vAZYOGi0dw5cmWIGI0gfWnpNV+pBPM2mAfWhgzUbj8R7nUbfdKL0
 gFOvtpo7J+T6qIkpy2jxASKBSolulBTGIK+jlE2aP573zoe1AhWEDidRLlkq1C94VkU0
 jt/fFuEHXH5T6wJK7trJHKk5Ee/RQzxqbWgDzIzIDi+YLSHEG605E+NrYFL1cTcuaqKP
 sRxqsAYK1feI/biJZByvtujVzqg0ykzWIvKDpSXdakPElK7HSaT5GnDW7JeAQAg/3r7H
 camg==
X-Gm-Message-State: AGi0PuY6ucMuc1DBNqfLOgDpS46DYYKIuxcWkM0UMdWIqGuAKmgTJGv3
 Cjmal3q3EapKs9RXb4yeHQItKJUp9dE=
X-Google-Smtp-Source: APiQypL/mfqeoQmE2M0Fo01TocfmR0qlDtAFw4PvLKPd5KwOAFIkPPReLvUDcgExDD3ibd8Jtqz9xA==
X-Received: by 2002:a17:902:c38b:: with SMTP id
 g11mr603256plg.295.1588276109989; 
 Thu, 30 Apr 2020 12:48:29 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id b24sm493496pfd.175.2020.04.30.12.48.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 12:48:28 -0700 (PDT)
Subject: Re: [PATCH 17/36] target/arm: Convert Neon 3-reg-same comparisons to
 decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-18-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ea229f74-243e-ea54-3af9-0b9382af6c20@linaro.org>
Date: Thu, 30 Apr 2020 12:48:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430181003.21682-18-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1041
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
> Convert the Neon comparison ops in the 3-reg-same grouping
> to decodetree.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-neon.inc.c | 22 ++++++++++++++++++++++
>  target/arm/translate.c          | 23 +++--------------------
>  target/arm/neon-dp.decode       |  8 ++++++++
>  3 files changed, 33 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

