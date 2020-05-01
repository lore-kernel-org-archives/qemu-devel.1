Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A10C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 16:59:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F367206B8
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 16:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V5HC1zFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F367206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUZ0U-0003NV-BW
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 12:59:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUYz7-0001fs-MB
 for qemu-devel@nongnu.org; Fri, 01 May 2020 12:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUYyK-0007Ux-U8
 for qemu-devel@nongnu.org; Fri, 01 May 2020 12:57:57 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33020)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUYyK-0007OH-Ch
 for qemu-devel@nongnu.org; Fri, 01 May 2020 12:57:08 -0400
Received: by mail-pf1-x444.google.com with SMTP id x77so1823230pfc.0
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 09:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=klP/n18H051c0hraLpoCl9JE9cUEAOVEjZtg8W34xxs=;
 b=V5HC1zFAnSv6uWeKzZ4tiFplYDow50N1syvgUy+0JLHAgkmZ/+O56Tw6D8ixHmhykE
 Aujqe1HbyVC//aZ+S/jp1q7Z6hNvM692smz675xds1Iewb01o56EMxI3ed7NEfXB2B6F
 pIx+j9dJ8O6QdD6fGN2sJzsHOCpWiGhox98J25oE7R9nLUlhcAcS6dx8/sdez5JuhsN2
 5eJI7zS1x9g+YGfyg4LsA/LzE94ZuSt5wyak0S8mg7AzJPzvvlFxAP3IiIKv5aqnkacG
 nPqYLf2BuTRol4hzMnvb2+SUjzslIDPHbT+OqkdFxUSnMadbIXkbfK1ns6VZ7AHQScBn
 B8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=klP/n18H051c0hraLpoCl9JE9cUEAOVEjZtg8W34xxs=;
 b=ktUk2G9vdqDtaPWtMdZVQ46W2QgjulnjOztjpwZM3TVNhAtmzzW30hKuWBnfksAdre
 ClKyrjo0BHaQkFEomG+RBHdSSeZIgrP1LGMsAGXfbdWxEYyLDSZ/YyP23A3k1Diq19cC
 TuqkBMPsz2ONKRjTsYhZSmGQ3uFWDfOuQOsu0kd6dcl01CPyGs2jqsxNbYx4n0gnJDH/
 YO1+72Ip/YC44jYQ8orUxgPsO1fkEoCR1UIgZYDB4MbTbVaulYqx0rLxpFaei29OQKmq
 raNKMKzGleRMeGB4CLMyzCNFJq7P+Dzro/x0lErOrm4LeJwLFKw/pLRLT6/riokcHf48
 s/9A==
X-Gm-Message-State: AGi0PuZsm2hXsC8XypNVpo/Nj3PTMUJOnH/C2JM2xLX3luM8UpQg2W2W
 PJPRvIqjJ7YM3/Y4JvGDNDkjjDF5Adk=
X-Google-Smtp-Source: APiQypJFeINnrHpPpFyPwMY1PKQXy0wWzxvpJFaLgwBDAgR6AqgTLN8vBWw2JtHrorwGUXnlF7qfCA==
X-Received: by 2002:a62:528e:: with SMTP id g136mr5235199pfb.165.1588352224982; 
 Fri, 01 May 2020 09:57:04 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id 14sm2759455pfj.90.2020.05.01.09.57.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2020 09:57:04 -0700 (PDT)
Subject: Re: [PATCH 1/4] softfloat: silence sNaN for conversions to/from
 floatx80
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Joseph Myers <joseph@codesourcery.com>
References: <alpine.DEB.2.21.2005010036120.30535@digraph.polyomino.org.uk>
 <87k11viq9h.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <31b170d0-a879-6de5-a1d5-326711e23b8c@linaro.org>
Date: Fri, 1 May 2020 09:57:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87k11viq9h.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/1/20 9:17 AM, Alex Bennée wrote:
> Ideally we want to
> convert the extF80 and f128 code to use the newer FloatParts code which
> is pretty robustly tested now. However the trick would be finding a way
> to do that that doesn't involve break or regressing the performance for
> the f16/32/64 cases. Just using a union causes all sorts of problems.

Yep.  Doing this conversion is the only way we'll ever fix the issue that
Joseph points out for the difference between m68k and i686 fp format.

> Anyway I'd settle for fixing the old style code and enabling the tests
> we can.

Yep.


r~

