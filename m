Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDE2CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 19:08:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA8A02070B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 19:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="manCcpZq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA8A02070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLXbV-0004cc-3t
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 15:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iLXaG-0003SS-CO
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 15:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iLXaF-0001yP-0x
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 15:06:44 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:40721)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iLXaE-0001xn-Pp
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 15:06:42 -0400
Received: by mail-pg1-x542.google.com with SMTP id e13so3856300pga.7
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 12:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=S1RAgHxhg77LeITQTVx60LSfHhMfdjluWCL2SKKiAY4=;
 b=manCcpZqGZVGAzZhvhgPkf0ZI4qUM3LtuKd3gA4OgoO4n5mlcsT7IIhVNY/ztCFPWM
 idL+W6hWIICpy/85uL2gxXT9jA9B8FOxS3kHIOHiux/HGympKFfYqCsywEYBMtcq9G1/
 Yn0tgWLs81sRhnNXNDE0/0vAdvYgEanXr3HPLceN1D/oVzQIbrDQYwIYcfnnI8kq9U8p
 v2pP+3nAw3+Npf2RpKxHePWi4LMW6YjkE7lvlPac+3FePIIHa5Yh91SgyaEue/BlK/AY
 NfvXucQWN6kqm9wXOVisEV1r2A1rqHGHchZkvm/2F86iDtkURmw3eA4Xk33tJTwpZNqN
 XUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=S1RAgHxhg77LeITQTVx60LSfHhMfdjluWCL2SKKiAY4=;
 b=uYlwJBaZ1NGgsQYby+X1rtV8TyqRQf2CBCneA5e5ses7w6V+NnU3lP2IlwrDOOD3Qz
 r0zBkA/jHBP9mNwbDZ+pwFmZcNhMYDTdqK7oUuTRT3Zj18V4Xjy1V62+SVYRKAlqxXSI
 LshN2ignx+iMHzBkmToGuDW5wB8UQ4h1lAquajhoJPgR4lizooS7pn6bXREtfSvEzt9a
 ToeyC+aq+TJ8yOwMZy85fOqbSjk1hyi6xUPUxTYTnB3JeIj8p111zSNtwSe/XNA2IF+K
 zNkMTYlkU6FYIDW0of+3RzM+s3ikhfdK66wiRDcVzyYB7wo54F5F4KSfIg8J58tTMXXy
 FafQ==
X-Gm-Message-State: APjAAAXBBOIQI91BfLoUKwzgY10ZxCQarbiv1msd4Pf93MO+cV+Pf3b2
 jfO1KK5Gl7sDRY+H3SdDQ1qW8A==
X-Google-Smtp-Source: APXvYqzGIvs7IxmpXUYdflaucaapnvO3kPp0B60Y0EJDcK8iYk80qUBk2WimUQdGq7wESxYZ+GXz6A==
X-Received: by 2002:a63:6506:: with SMTP id z6mr11542454pgb.65.1571425601788; 
 Fri, 18 Oct 2019 12:06:41 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id m123sm8483929pfb.133.2019.10.18.12.06.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Oct 2019 12:06:41 -0700 (PDT)
Subject: Re: [PATCH v1 3/6] s390x/tcg: Fix VECTOR SHIFT RIGHT ARITHMETIC BY
 BYTE
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20191018161044.6983-1-david@redhat.com>
 <20191018161044.6983-4-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <581455a2-2000-81fe-dfeb-9e6c2a108983@linaro.org>
Date: Fri, 18 Oct 2019 12:06:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191018161044.6983-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
> We forgot to propagate the highest bit accross the high doubleword in
> two cases (shift >=64).
> 
> Fixes: 5f724887e3dd ("s390x/tcg: Implement VECTOR SHIFT RIGHT ARITHMETIC")
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/vec_int_helper.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


