Return-Path: <SRS0=fVwN=XJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C358C4CEC9
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 15:55:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55B122081B
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 15:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UhhGqSnF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B122081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9AO9-00015M-1D
	for qemu-devel@archiver.kernel.org; Sat, 14 Sep 2019 11:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i9AMH-0007fJ-2G
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 11:53:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i9AMF-0005bi-LD
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 11:53:08 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:33531)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i9AMF-0005ar-Ck
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 11:53:07 -0400
Received: by mail-ed1-x542.google.com with SMTP id c4so767310edl.0
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2019 08:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=i45Wi1jeYhYFpNz+2IXLaY6w4HIOvN+kqymRjs2dzXw=;
 b=UhhGqSnF3BSxTnNGLEOZ1v4m+cuPepV7pPNurGwQ0+6BE++8+PW+WnTquTZWILwiel
 UximVJA+qUq8eueZ5U8aqstcZvcBFQZp3LJCahL/ZxpPwb0/atU3I+9gV0NYfCclXobj
 uQXilX8eVs90xjEI463rTujcIQehNrJ/CbSWVBJ3FRwj4orBCPxs75a/xWLMInl96qh2
 Sfle6sky7+Az+rGli8Deddnvi+jZil5dRi3ROSRMzFDb+X0pmg4Nzyiuhi9SsBhZVzgh
 67B+GgMe9MEDKJk2Fgb+ZnGMOehFggqW8vmwclepVe73XS/841mYe5Jb/QY7q35bwZNd
 stKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i45Wi1jeYhYFpNz+2IXLaY6w4HIOvN+kqymRjs2dzXw=;
 b=oJX/7TZhQq6PuDIu4kdkIS/WVJk83lJN3yYGrS/+d0iu1Ka0sc+h6espDB9sEJBcLi
 oi6fNq9NyZknwIxXDIxWdx9DRgf8proIBvMUP/F4opDRQnTu0+DDLV4rhSQ4OuB9TxJ4
 ohjnvFEg0aPcfWWVsqLBhxGLBrvSA2uKbHVW3tUAzvA1Ubzysw+NWIg5ikO/SgpvvXnT
 eRwjmPL95/Knbjd9dY/tKqHvIkmcjx24ubNifFNde2z/G+zVIFXon65bzVY+Znbmvrf1
 BIw5IoOAOP+C8Do3URovgBjMeO1dfLrePKqkqy8zuKDMBlCPLcNqsIqwQyRwp5Se2MSD
 h1OQ==
X-Gm-Message-State: APjAAAW9hKIhgl2+eQwQEFVvvCkrQ7tQnwjrSugNi0ubJegpQV+tGIIO
 F6/AE9shkx6wXnE1l1Sd+xJ5jg==
X-Google-Smtp-Source: APXvYqz5FSh+cmsAN3EuJv0y6STgbeegym7IS4xMQSas+eqw6eJ5nr4zFH09f34imhlX6hfgJph3fA==
X-Received: by 2002:a50:934c:: with SMTP id n12mr45773462eda.12.1568476385634; 
 Sat, 14 Sep 2019 08:53:05 -0700 (PDT)
Received: from [192.168.44.107] ([185.81.138.18])
 by smtp.gmail.com with ESMTPSA id r18sm6016614edl.6.2019.09.14.08.53.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 14 Sep 2019 08:53:05 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190910193408.28917-1-alex.bennee@linaro.org>
 <20190910193408.28917-5-alex.bennee@linaro.org>
 <CAL1e-=giNc1e+kN04KqHFQGkJbP4BKziQyxVd3-RTtL+UOfSoQ@mail.gmail.com>
 <874l1j18vm.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <5880b9c9-969f-fa79-f7f4-a45a6568635e@linaro.org>
Date: Sat, 14 Sep 2019 11:52:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <874l1j18vm.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v1 4/4] elf: move ELF_ARCH definition to
 elf-arch.h
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
Cc: peter.maydell@linaro.org, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/11/19 5:26 AM, Alex Bennée wrote:
> 
> Aleksandar Markovic <aleksandar.m.mail@gmail.com> writes:
> 
>> 10.09.2019. 21.34, "Alex Bennée" <alex.bennee@linaro.org> је написао/ла:
>>>
>>> This is preparatory for plugins which will want to report the
>>> architecture to plugins. Move the ELF_ARCH definition out of the
>>> loader and into its own header.
>>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> --
>>
>> Hi, Alex.
>>
>> I advice some caution here
>> . For example, EM_NANOMIPS, and some other EM_xxx constants are not
>> included in the new header.
> 
> EM_ARCH was never set to EM_NANOMIPS. In fact I can see e_machine is
> checked against it so I guess it is only ever used to checking the
> loading elf directly.
> 
> In fact EM_ARCH is only really the default fallback case for checking
> the elf type if there is not a more "forgiving" check done by arch
> specific code (elf_check_arch). The only other cace is the fallback for
> EM_MACHINE unless PPC does something with it.
> 
>> I am not sure what exactly you want to achieve
>> with this refactoring. But you may miss your goal, since some EM_xxx will
>> be missing from your new header. Is this the right way to achieve what you
>> want, and could you unintentionally introduce bugs? Can you outline in more
>> details your intentions around the new header? Is this refactoring the only
>> way?
> 
> As mentioned in the other reply maybe exposing a value from configure
> into config-target.[mak|h] would be a better approach?

I think using EM_FOO to tell a plugin about the architecture is just going to
be confusing.  As seen here wrt EM_NANOMIPS, but arguably elsewhere with
EM_SPARC vs EM_SPARC64.

You need to decide what it is that you want the plugin to know.  It is just be
gross architecture?  In which case QEMU_ARCH_FOO is probably enough.  Is it the
instruction set currently executing?  In which case neither EM_FOO nor
QEMU_ARCH_FOO is sufficient -- e.g. arm thumb -- and you'll have to invent
something new, because no two architectures handle this in the same way.  The
closest you might be able to get without invention from whole cloth is the
capstone cap_arch+cap_mode values from cc->disas_set_info().  But that only
handles the most popular of targets.

In any case, a single header that every target must touch is the wrong
approach.  If you want to do some cleanup, move these defines into e.g.
linux-user/$TARGET/target_elf.h.  (And I wouldn't bother touching bsd-user in
its current condition.)


r~

