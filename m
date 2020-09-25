Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E96C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:37:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D588720809
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BRFyrK5H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D588720809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLpnH-0007iG-I8
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 11:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLpbS-0006Dy-0E
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:25:42 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34778)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLpbQ-0005qd-8i
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:25:41 -0400
Received: by mail-pf1-x443.google.com with SMTP id k13so3542732pfg.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 08:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qTh/YbxisuA6cuOhrolcPbdDEEsZMDtFTVQBDGjUSw4=;
 b=BRFyrK5HXk0Z+hFrGJbTGRHe9Sr3zqHRDLLVtD+07D4ZQUMsq16//oqzHm5fXBZUgq
 3tHr1acqxcr8iCWyMQK+ggjUzxXp1thDE6CVF/hA3T/eZ2Ny4T2sSLAuZZPdJqw3B7mL
 6zbHGagymoH6JRU9INexZhELQYs/8mY4nYBNATnpEUd2aJOp5FBbjQgJaasovdf0yxNG
 agGp7dvORVzze9gWtpadB5lev2TYPRMKbEkMNQKfu6UtTNQOexnkfK1+H7wn7T+y6c1B
 NeMhLwjU1HoErmZcC/3amlK977eqTlkMJ29S71OMpxgMiknGuP9+3CfEp5gnAePcfebr
 Ie3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qTh/YbxisuA6cuOhrolcPbdDEEsZMDtFTVQBDGjUSw4=;
 b=h1gF1KO7ajtBSID63AznXGIh1gBdjr7+ipcQD9J69f8enLVXLGkInqfq74WZnRPmJs
 dtHze3+nO8Xwu0ZnToD/hHUJcwvNBIVV/HzTc/7/8jj24DCxk2i1V/NrtxHBPGKQw+EX
 eVFoSsl5hRscRTru4NW5G68izRsoI/1VFhTbFt8zoTiJ4/hhJYf9rPw8B21umeU2i1V7
 E33Kjgc8S3zTvJTIa97ItlL6Nl3Kqsk+bMsFXpsTx8VSZxNbTjemMz8sTAmq8L/7UIlb
 FfxjzHyHE26WtIWmYGtFpYlWJdhvQS24GBfcIzM0J8hgHCu9ANZEdZflYCDUhUYG7i9X
 FSUg==
X-Gm-Message-State: AOAM531gFq35VpcmK3drMTcOYKFvXPpCBVacioiWx0GSHj1R9Ft4KOpk
 kZOCc47LmCplq+V+NWvO6cKzFg==
X-Google-Smtp-Source: ABdhPJwe0AGk1bWvjwme+IOr3Z0qmCG6rqtQaJEDKNhupSGBD9XCflrkK9jI+kfiC/hi+UGJUQyDOQ==
X-Received: by 2002:a17:902:64c2:b029:d2:6356:867e with SMTP id
 y2-20020a17090264c2b02900d26356867emr4497240pli.32.1601047539000; 
 Fri, 25 Sep 2020 08:25:39 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id n2sm2457475pja.41.2020.09.25.08.25.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 08:25:37 -0700 (PDT)
Subject: Re: [PATCH 4/4] qemu/bswap: Remove <byteswap.h> dependency
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200923100220.674903-1-philmd@redhat.com>
 <20200923100220.674903-5-philmd@redhat.com>
 <CAFEAcA9XOpCyWr0QXn6T_y9nh4ZX5Op2ztonefr-pV2oQfU3iw@mail.gmail.com>
 <fd8a9c3e-45f2-caae-25ab-5e1365fd9298@redhat.com>
 <2a2cc60d-2d30-eb38-369e-0a26f0eac9bd@linaro.org>
 <CAFEAcA-+ssh05EdeYLSoF=m8Yvg_ENoChrV6vT6H=NVSPUPFAw@mail.gmail.com>
 <70564f81-d2a6-9bad-b761-40e0d5c69961@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bf531a36-9d1e-10b4-de0e-f53cffd4f949@linaro.org>
Date: Fri, 25 Sep 2020 08:25:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <70564f81-d2a6-9bad-b761-40e0d5c69961@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.238,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Alexander von Gluck IV <kallisti5@unixzen.com>,
 Ed Maste <emaste@freebsd.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/20 2:22 AM, Philippe Mathieu-Daudé wrote:
> Looking at FreeBSD, bswap*() are defined as macro:
> https://github.com/freebsd/freebsd/blob/master/sys/sys/endian.h#L58

That works for me.

> So theoretically they could change the prototype still respecting
> the documentation contract, and undefines wouldn't work anymore.

But we'd be #defining our own macros that would mean that the out-of-line
functions would never be used.  So it still works.


r~

