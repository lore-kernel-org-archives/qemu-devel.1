Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64ABCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 19:06:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85DAC2070B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 19:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tb+InAKR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85DAC2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLXa8-0002gx-Lw
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 15:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iLXZK-0001xI-Ky
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 15:05:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iLXZJ-0001Su-EZ
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 15:05:46 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39715)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iLXZJ-0001Rw-73
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 15:05:45 -0400
Received: by mail-pf1-x442.google.com with SMTP id v4so4437225pff.6
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 12:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8biK9WMxYlM9W3cj4YS8Ki/FFzg+OwNz8eFKUZJHo2g=;
 b=tb+InAKRbkhiL3W5sNlxors8RjESOdQ5JYYwQTlfXqtWTsgHVXNo4NLD7q1fPBy7Lj
 3JTxee59MolxsodbIYjQJAhBo1ZC0GTeSbT73zuoU9SC85LjXcswsZ+09lbsAC/emNLz
 O11oPZLyevw1UZ1sle2xVrss2Rw1BFkWbHYVG6mvT0bXqIb1IzTa2J5py/aq9TnegLha
 zLgdvKCxHwYIjRs2Yh9ZEAuHRledTGiuvjOgafpyLlw7Sttq56poEExsOrN/HqwgKZ4F
 2i1oKx/b8stMPFnYoeTWO8HTpUc3/XOPISFIHoQw8/FjIsDNN409eTzGkwojB6SoJCob
 d0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8biK9WMxYlM9W3cj4YS8Ki/FFzg+OwNz8eFKUZJHo2g=;
 b=oa/sBqp+E8VOI0Sk1carjDlFAEzw458Qwj9SFN0ILwza/2pvrahh8V/Mlj96XXXzdc
 XNf9bbPasTDkgBFkmzz5k8wodVasGcS/HN1vNGyktIJ8T2iYK4aQw/jmEssanZgeRk8e
 RKMgG/TO+qugKboa1D+k71uHD6SPO3sV1FAuGmxjdMrsAHactBg3S1ifI1TAziHq2S6u
 EgZb5ke3bw3nyHTUkzplrJNUsXqruqexb4cSGcYkSKd+59yW6EaTzTSsHQ5qgKfmj2T0
 ScX/0rjOJRdub3wax511RUn6xv5/q1h+GyPiZLeH/ihzL9p4vXTq1j9D79iQ2S7aSelQ
 F00Q==
X-Gm-Message-State: APjAAAWAGMVzUowU6tUfRetC9feAPMbCmsGXWG5pJftRxuuePTCQdadE
 zAXaYKdv50bdaD6v8LHqKTTpwA==
X-Google-Smtp-Source: APXvYqwJGh/rO5vPfXsgiXe5yLj8zQGNywhvnwisbwhLI7s6xm/gU4nJ1JTBnp+LIisQzPSTN1PI6Q==
X-Received: by 2002:a17:90a:19c1:: with SMTP id
 1mr12906842pjj.52.1571425543800; 
 Fri, 18 Oct 2019 12:05:43 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f185sm9199966pfb.183.2019.10.18.12.05.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Oct 2019 12:05:43 -0700 (PDT)
Subject: Re: [PATCH v1 1/6] s390x/tcg: Fix VECTOR MULTIPLY LOGICAL ODD
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20191018161044.6983-1-david@redhat.com>
 <20191018161044.6983-2-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <6c66db9d-e227-962d-e2cc-ff1bec7ed90c@linaro.org>
Date: Fri, 18 Oct 2019 12:05:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191018161044.6983-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Ivan Warren <ivan@vmfacility.fr>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/18/19 9:10 AM, David Hildenbrand wrote:
> We have to read from odd offsets.
> 
> Fixes: 2bf3ee38f1f8 ("s390x/tcg: Implement VECTOR MULTIPLY *")
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/vec_int_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

