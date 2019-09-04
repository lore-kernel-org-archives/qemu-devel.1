Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBF4C3A5A8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 17:29:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48C272087E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 17:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZHOYMetD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C272087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Z5f-0008CQ-3r
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 13:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5Z3P-0006V3-MB
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 13:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5Z3O-0007Bg-JC
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 13:26:47 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:42982)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5Z3O-0007Ag-Bg
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 13:26:46 -0400
Received: by mail-pf1-x444.google.com with SMTP id w22so5220388pfi.9
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 10:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=51fzCSMIizZHsDkutGQDtvkClUPwgi4bzFKKnOezgX4=;
 b=ZHOYMetDt/m3hT7fa7KmQ9x5GBW3bYOlD65xvmOHGhnDBRT+QQq48KIivOKyatYMpD
 hPFoej9bqc3xlHjUFxRjqs1pmw/9XTQAf9GdQIGldBXNb/EcglEZ0gFbpQXDKvqSCpOK
 EBPnzolfSvBcG2FROkNzY9fuVB7QloPtSi+zSq7mI+Kju6brfKUEeu0agnlnHHh6qFe+
 pNHdjVegAXW/IxE2i0mrqnK87hEaOYAeolDfQF4qzZr2MdQgi40GTdBK0gIWkeYtOJ/F
 7rlsEyGAn/bSRSqFb1K8e0YUJ86ir2jyfI8uF45XEIGrm1WsGIl1GZNdcHPm5QuVfmxi
 69eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=51fzCSMIizZHsDkutGQDtvkClUPwgi4bzFKKnOezgX4=;
 b=VzC7gRFQysHgJgMNaiTdLs3vGgHGF9MKJuI4+ovVdio3hqd4YpRV24f0uMe39E+5uM
 xcYPttCUkuJnu/Q5VoIHxAGECq7o8nWBA9MayZf8KHavbJW7ziHSqt8CBO2gRZplSPOd
 zqQ/g4AaEmr2WlnFg6r3ITM+yAb2QBsP+Lu0lsb8UoIIH+LwSPAxsdCUWRaqrRYsySSA
 TDGeBqMr4BJSpjYHIrA5LpJ96F0mkLwmJ1qH4yF30kLUHhakOjyPpFAgKMt/cTIDz+O1
 /YsPys2TcNzGhFotS4ehWiAar3JNT9CNLLohWCXPXGGA/kABoBHnoPG/r0tN1zPseblG
 nVJQ==
X-Gm-Message-State: APjAAAWLJPLePNhu9vpcoUwsUa4hvTOV54LILZqN4jOrszaqSOXU1NMT
 w589iU5bM+m+Aup4tnXa9b2Q8A==
X-Google-Smtp-Source: APXvYqykBTkUUEo218K2pHwkP30hvdBDhPkzN+FzWu5fhiVJzxpxm2jyVuwwKfD43WQ904fG3ERl2A==
X-Received: by 2002:a63:c442:: with SMTP id m2mr36967896pgg.286.1567618005225; 
 Wed, 04 Sep 2019 10:26:45 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id p2sm30124373pfb.122.2019.09.04.10.26.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 04 Sep 2019 10:26:44 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190820210720.18976-1-richard.henderson@linaro.org>
 <dacbea19-9692-0288-9b64-8500d0cf232a@linaro.org>
 <CAFEAcA8MfTTPrsTQhXUPHWAy_KeC-3ZztFtKM0jyQHZoBYqRJw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a4e45c2d-f2af-25e7-b9ac-8bffcc6621d6@linaro.org>
Date: Wed, 4 Sep 2019 10:26:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8MfTTPrsTQhXUPHWAy_KeC-3ZztFtKM0jyQHZoBYqRJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v5 00/17] target/arm: Reduce overhead of
 cpu_get_tb_cpu_state
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/4/19 3:48 AM, Peter Maydell wrote:
> On Wed, 21 Aug 2019 at 00:54, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> However, while working on this patch set, I noticed that we have a lot of
>> unnecessary overlap between A- and M- profile in the TBFLAGs.  Thus point 4
>> above and the completely separate rebuild_hflags_m32().
>>
>> If we rearrange things like the appended, then we recover 4 bits.
> 
> You can't make the THUMB bit A-profile only: we need it in
> M-profile too, so we can correctly generate code that takes
> the InvalidState exception for attempts to execute with the
> Thumb bit not set.

Yes, IIRC I found that when I went to make this work, rather than merely a
sketch through the header file.

> If you want to make VFPEN be A-profile only you need to
> do something so we don't look at it for M-profile: currently
> we set it always-1 for M-profile so we don't trip the code
> that causes us to take an exception if it's 0.
> 
> Otherwise seems reasonable. My overall question is: how bad
> is it if we just start using bits in the cs_base word?

*shrug* Even then we don't want to waste bits; there are only 32 of them
remaining, and after that there's no room at all for expansion.

> If we try to get too tricky with using the same bits for
> different purposes it opens the door for accidentally writing
> code where we use a bit that isn't actually set correctly
> for all the situations where we're using it.

Thankfully, we don't touch these bits in many places.  We set them in the
generator function, and we read them at the beginning of the translator.


r~


