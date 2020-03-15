Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD95CC10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 20:23:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A112E205C9
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 20:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qsbw76KH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A112E205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDZn8-0008Ad-Jc
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 16:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDZi1-0006Lm-MN
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 16:18:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDZhz-0000QY-Q0
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 16:18:04 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:38514)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDZhu-0000Bl-Pe
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 16:18:03 -0400
Received: by mail-pj1-x1042.google.com with SMTP id m15so6659865pje.3
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 13:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AhOq4VxYKsC1Jgb2Uc4npHOr2Sarvt2ZXKSUnRDtBtY=;
 b=Qsbw76KHjfoL6NG8zpM2gYqVJf7m5qJiaKIS2u8TTbT634TvTmTkGB0lhgLLbtc1F4
 1YftFaFHxss8PStF3Ovuq0s9RGsk3uifG3PhSTwDeI9onSZEQsXGfgk0U0pIWUP3wU5b
 9qDBDvRAN+Vs6g81T4CBKyLDnc5f91lnqB1N8WSNcA2jlEvgPLvu8dOE5IjSMZVo4Pf2
 9Csm6fx/qZ6pOcDV8lOhF7D2oGBNve6HNPz28GbOY0UzfScQAqijGRz5fQ6IWohQy+nE
 UgDcrIm5DSkbk5giYTDu2cHecWLyN7HW/bK9CAQD38YSmscVwetwrkaihbvbK+zWYlVu
 fhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AhOq4VxYKsC1Jgb2Uc4npHOr2Sarvt2ZXKSUnRDtBtY=;
 b=oRSWkpf8PL40JzrtORpusX7lZq2qck/vkSVFrIPHVIOaZr983+n5dCX58CEGcNOBMo
 ZsaurU/jsHDppxsutMEfrkvlfj2dTRwV69AfXBxXT8UquCx9D4T8zsjFgV58yjvm9ciO
 lDvM9JH3VjyG9tegqW5I3eqpxdhsb2vvOt2kHyl9eEfSuivq4QF87YTIZu1fR6/eVS/U
 AWEYNoXsu3BAjxiD0IZtG2LtzYbJiz3w5bwIUhT2Y/bOOVgoscfv2Or5Qc1dj9u+4Iub
 81GU0IbglApQWR8b8fq95DH+YCjY14XBsEAB8adB3qLrnexxYJVZ/QPosRWzkM8g9cxl
 uq6Q==
X-Gm-Message-State: ANhLgQ1zvPqm9nPHuzZTXme6HyWJsk1xx6F9DORYtfVfDdrg6sJMV9ZC
 F2W1/ZQpmS5C2hVmGGZMV3zVqQ==
X-Google-Smtp-Source: ADFU+vsRBAdAFKUNCyqTXhNmdMR8ILJNAGjnDYK+VeeFZ60mSUdnTys3f42VhTgSoUm5VL4pIzgDIw==
X-Received: by 2002:a17:902:be03:: with SMTP id
 r3mr23402910pls.137.1584303472735; 
 Sun, 15 Mar 2020 13:17:52 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 j21sm17288919pji.13.2020.03.15.13.17.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2020 13:17:52 -0700 (PDT)
Subject: Re: [PATCH 05/14] stubs/Makefile: Reduce the user-mode object list
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200313183652.10258-1-philmd@redhat.com>
 <20200313183652.10258-6-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <24e2d723-cd4d-aebb-65f8-e4fedaab8926@linaro.org>
Date: Sun, 15 Mar 2020 13:17:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200313183652.10258-6-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/13/20 11:36 AM, Philippe Mathieu-Daudé wrote:
> These stubs are not required when configured with --disable-system.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  stubs/Makefile.objs | 52 ++++++++++++++++++++++++++-------------------
>  1 file changed, 30 insertions(+), 22 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

