Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58A5C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 09:39:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 801292086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 09:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NKKlCIBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801292086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBFNY-00017T-6W
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 05:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iBFEi-0007JK-A8
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 05:29:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iBFEg-0000at-QK
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 05:29:55 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37017)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iBFEg-0000aF-He
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 05:29:54 -0400
Received: by mail-wr1-x442.google.com with SMTP id i1so6014830wro.4
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 02:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=x2KaTDjPeZJHU0g6DHHdIw1QpmDe4SwTMzfo8BdB1Is=;
 b=NKKlCIBNLk3tUvjAlOfEdip80ytm4GkscXeO/jd7aiPo2b77hOl0/UxdqzObepLdfr
 i3RnbZVn6xmTI8Sc1PJPTMHZoDkvDGuRyr7gem1/KxxlYfnyi8c/xzgjmEDI4s3LXMrT
 1G9T3Fe6u3nk4iXbPehhEPo3xFPGZNK1CKdVqF7qI6Lx/ojdApm12S+DZyWA9onv3t7H
 KT5OVQWrW4TyeTH4u1Qvv1puGm6qQWDAHGu8ebCrekB4z5SmvMAn53gKzPtW2H5TVojC
 g7iOyWmoQ0QA+/kMJr+lvKN/ovut3EYdTpv4CghX0BUM/VXTaqW341lphtb3qfIoTg54
 I74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=x2KaTDjPeZJHU0g6DHHdIw1QpmDe4SwTMzfo8BdB1Is=;
 b=cv+lj+LrHr3XUi4pbeZfJWxn6RT8AnMafCDRhWk0LepCWHqzHpGq5Wo9Cj47h/3+VH
 Lhg6gVIfsH0CkrHykrq8KsFnoDkzYovCYjvyjncPusKJC6ztbQyTB/uF7E6TQEnlPlGy
 P5h1eDzc8bzvE0GA0Odw/+faFGA5DkVBrQLEev1m4Hl/5jEeCEQZjypGy8M9zSCzxLn9
 pSMXo2t0Y7lITlBKXKbSrHLHvlIZiS/fnnKSicb2X83A2fzYooF/JOK1c1s3vV419a9K
 0MG9tDfqL4txg6re6xnYE8vfVVbyWdAx3Dgxf5SC9F6ojiXlbB5/4HXG5ZaBnjUhwMa2
 atNg==
X-Gm-Message-State: APjAAAVnmfE08zLWk8TDczGGxv2njtzF26vTkiW5Tod4cBT+/W2MVDQe
 qsK11iK/WfSQ8g9QtZ2w+HHagw==
X-Google-Smtp-Source: APXvYqxm4UC+tw5LLuq8f98Z36IyOU2GYy5nnunRfs3+OFYD2rmghdTJxbxFERYEyPR4IjiZbT4l8g==
X-Received: by 2002:a5d:6302:: with SMTP id i2mr11693215wru.249.1568971792828; 
 Fri, 20 Sep 2019 02:29:52 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 33sm2030532wra.41.2019.09.20.02.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2019 02:29:52 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 298E81FF87;
 Fri, 20 Sep 2019 10:29:51 +0100 (BST)
References: <20190919171015.12681-1-alex.bennee@linaro.org>
 <20190919171015.12681-11-alex.bennee@linaro.org>
 <c6cd971c-e84c-c5c9-b313-2e454e02a1da@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 10/16] tests/tcg: add generic version of float_convs
In-reply-to: <c6cd971c-e84c-c5c9-b313-2e454e02a1da@linaro.org>
Date: Fri, 20 Sep 2019 10:29:51 +0100
Message-ID: <87impnz568.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 9/19/19 10:10 AM, Alex Benn=C3=A9e wrote:
>> This is broadly similar to the existing fcvt test for ARM but using
>> the generic float testing framework. We should be able to pare down
>> the ARM fcvt test case to purely half-precision with or without the
>> Alt HP provision.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

This test seems to be tripping up alpha-linux-user be generating FPU
exceptions. AFAICT we are meant to start with software exceptions
disabled but:

  cpu_alpha_store_fpcr: enabled exceptions: 2000000

from the get go is what causes the eventual trip up.

>
>
> r~


--
Alex Benn=C3=A9e

