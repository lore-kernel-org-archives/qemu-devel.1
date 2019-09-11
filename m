Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1FAC49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 14:53:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9A872075C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 14:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oDnWHXiS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A872075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i83zO-0000Yw-Vn
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 10:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44488)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i83l6-0001ox-0K
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:38:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i83l4-0001aH-Tu
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:38:11 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:39115)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i83l4-0001Zl-QL
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:38:10 -0400
Received: by mail-qt1-x842.google.com with SMTP id n7so25524056qtb.6
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 07:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=U1lA9wncOBtgT7GVhhYKN5KQgMo0cmQt+93HsqJiRRo=;
 b=oDnWHXiSLwTqRnt06/G8NwNgsgeyI1yueNkayzEGSjB+PvmAQpKesZpo7fLtbTOX3Z
 3FGzGhPUUi1BbIu61fqGjU0LGa/oA9UUk+Ilp6Q7kbNjvYB2OB3Wnd4bcTi0DcivBZOv
 hLYUtbVycSjUzPJY8Ozm+hdGK5bLVbW+KI+xlWbrsAuIEbPy1oRs6xG+rL26KUmKnBbp
 Y0/OC6Pax7K8qpKYusgkMPHQ5IYgdEj6ozA8SAFGbhC7RRBETbjZLBBgabo68EVlpwlo
 XSLV2VgHs/fhAj0PcfOOzp9m0GW8QpkfM8O6AYWf2wkQ6xuYZ+STiAbEwq8vKe1P3GNG
 6tUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=U1lA9wncOBtgT7GVhhYKN5KQgMo0cmQt+93HsqJiRRo=;
 b=UBEov6JTp79+3PSFNtE7YQRI6pRnotPnTGeOWKUdd4cmqCFTeXkVVdZsq1gYWsHqR9
 H1JFjU52fdTiTOiy6RMwqr4rXsJyrqUle5eDCH67oFMC7fNVRAqpD/oqEgTKqODxpDzj
 1C9A8rQ9lJHxUhiWjgMpcyZKgPOwryFPNQBMDf4qa6yO4lvEexAzMyOoZVyqcj1c1Hgm
 OPmiFdEWHsrXuDjw4Kdlyta5ACzAgxK2finjH+e/1S4gTtBQPwzgJNN25X7Nk3a5CBe+
 vm7tJ2sU+FI4j0ABpuNSxt9Sji8p/CPctCTIaOQvTDjImvrWLodfa0QZ61JQm1O1AgxM
 DiEg==
X-Gm-Message-State: APjAAAWit7FeKlLAFiAAD5+J2bqNj5hPtA5SzjTQl945rOrBD5FgzZeO
 9MGhTU4ot/zs0etxD+v+bjj5lw==
X-Google-Smtp-Source: APXvYqz3uEOHy226cE+Qm4ByV/yanzuZ3IwewfGMdzMGAJ5049lsYiLUsEGmmNaYohPvWqVZ51Jw4g==
X-Received: by 2002:a0c:add6:: with SMTP id x22mr22579045qvc.203.1568212689893; 
 Wed, 11 Sep 2019 07:38:09 -0700 (PDT)
Received: from [192.168.5.185] (otwaon236nw-grc-01-64-229-69-35.dsl.bell.ca.
 [64.229.69.35])
 by smtp.gmail.com with ESMTPSA id t40sm12904664qta.36.2019.09.11.07.38.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Sep 2019 07:38:09 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190906075750.14791-1-david@redhat.com>
 <20190906075750.14791-2-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0987a21d-262d-ed49-1b37-9ba19e6a7df3@linaro.org>
Date: Wed, 11 Sep 2019 10:38:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906075750.14791-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
Subject: Re: [Qemu-devel] [PATCH v2 01/28] s390x/tcg: Reset exception_index
 to -1 instead of 0
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
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Stefano Brivio <sbrivio@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/6/19 3:57 AM, David Hildenbrand wrote:
> We use the marker "-1" for "no exception". s390_cpu_do_interrupt() might
> get confused by that.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/mem_helper.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

