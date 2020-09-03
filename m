Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221F5C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 19:56:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E014B206C0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 19:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPifLaxm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E014B206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDvL2-0006Ux-4L
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 15:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDvKA-0005xI-GN; Thu, 03 Sep 2020 15:55:10 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54611)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDvK8-0004bv-Fc; Thu, 03 Sep 2020 15:55:10 -0400
Received: by mail-wm1-x344.google.com with SMTP id s13so4024439wmh.4;
 Thu, 03 Sep 2020 12:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5uKaMbLUcclG5Xr3CzuGSuUiVAqefGkhZSf8/LBKfog=;
 b=lPifLaxmmk8OGJe+DFX8eeB17iYiQkDcGptw9ZdQ3MJRE/gtGNkfbPPWfOvX/K1KYG
 gph/wDuMORqiUYzn+JWftUOI+quqAlArHjYdVf6OFlu+XRRL98mlfN4glkycx1R27hOd
 7iKdeu2CPxD5egy5xBeVukCh6GReA6ULu9q9yPoR/Hu/Rxxc3VQt1ECzA6sxmO6ZYqJF
 QHdjIjBcm2hPlM1X+Hn7cNhKzId4wgsODXnoI1Q1FNduIp1J3eWBChBcgVmV6oewxvVB
 q50EBe2CGaR3bk1N8u3wSdZKZme9f5vkw3BM0rg5nJyMPuc2KVtgdJm3RmHaVmhoFOTT
 C1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5uKaMbLUcclG5Xr3CzuGSuUiVAqefGkhZSf8/LBKfog=;
 b=r9d1WhyBUX4LYKMLH8f/w3OebzjlVyPjoD35sq7GZSgcnl47racApcd1jUHMx/2VMd
 cHAA+RqKzh6oaw51hNfrdJuYMPrJtZfIkuHtbtIa9tkMLIkRsUn3TrLPu0h4ScfhMtjh
 7tD/8G6r08u0Utj6g4XT51mPHAON+G/TTTiTdhKTWp0fZRafkUKheF0G2hvvmKTxtbfG
 YebJ6tznC2KqU8Qbs8jJuX3xpSQwy9hwDB6MhXDv9AiXR8dvgBswWFVQGgwQcYpxBa7P
 56iWT+kQpCm4TwMoEIRr6sJgUSyzdxf6uo+5GxSRxrx2Vm3wo6vO3wlNajByBpqTDxel
 8rFA==
X-Gm-Message-State: AOAM532J9wVFObCwPFsrXfnlzqnIxT9OmI46jgZCZcQvoG/S7D6oECQU
 hjGTyKRWt4kkkqrPrRddDwP1TjvdDBM=
X-Google-Smtp-Source: ABdhPJy08xhRANMMcr+tJZ87ngdLWgdgt3nCfrXKKdjXXSiMRCAT/0Rj5bYTKvVyeyqoo/QzWyHVMw==
X-Received: by 2002:a1c:f605:: with SMTP id w5mr4093026wmc.6.1599162905994;
 Thu, 03 Sep 2020 12:55:05 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id b8sm6148169wmh.48.2020.09.03.12.55.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 12:55:04 -0700 (PDT)
Subject: Re: [PATCH 20/63] pc87312: Rename TYPE_PC87312_SUPERIO to TYPE_PC87312
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20200902224311.1321159-1-ehabkost@redhat.com>
 <20200902224311.1321159-21-ehabkost@redhat.com>
 <2863f7ea-6fde-5a2e-b55f-e805f5db35be@amsat.org>
 <20200903161646.GG4940@habkost.net> <20200903172201.GQ4940@habkost.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9a1fa63c-321f-abf1-736d-f148be89f943@amsat.org>
Date: Thu, 3 Sep 2020 21:55:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903172201.GQ4940@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-2.403,
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
Cc: qemu-ppc@nongnu.org, berrange@redhat.com,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 7:22 PM, Eduardo Habkost wrote:
> On Thu, Sep 03, 2020 at 12:16:47PM -0400, Eduardo Habkost wrote:
>> On Thu, Sep 03, 2020 at 02:45:12PM +0200, Philippe Mathieu-DaudÃƒÆ’Ã‚Â© wrote:
>>> On 9/3/20 12:42 AM, Eduardo Habkost wrote:
>>>> This will make the type name constant consistent with the name of
>>>> the type checking macro.
>>>>
>>>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>>>> ---
>>>> Cc: "HervÃƒÆ’Ã‚Â© Poussineau" <hpoussin@reactos.org>
>>>> Cc: qemu-ppc@nongnu.org
>>>> Cc: qemu-devel@nongnu.org
>>>> ---
>>>>  include/hw/isa/pc87312.h | 4 ++--
>>>>  hw/isa/pc87312.c         | 2 +-
>>>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/include/hw/isa/pc87312.h b/include/hw/isa/pc87312.h
>>>> index a65168a157..da8dc5ddf5 100644
>>>> --- a/include/hw/isa/pc87312.h
>>>> +++ b/include/hw/isa/pc87312.h
>>>> @@ -29,10 +29,10 @@
>>>>  #include "qom/object.h"
>>>>  
>>>>  
>>>> -#define TYPE_PC87312_SUPERIO "pc87312"
>>>> +#define TYPE_PC87312 "pc87312"
>>>
>>> We loose self-documentation. What is a TYPE_PC87312
>>> when reviewing a board setup code? Should we add a
>>> comment /* Create the Super I/O */? The current name
>>> is self-describing...
> 
> I've just realized that TYPE_PC87312_SUPERIO is not used anywhere
> in the code, so I don't understand where exactly this comment
> applies.
> 
>>>
>>> Is it easier to rename the type as 'pc87312-superio'?
>>
>> This is an option.  In that case, I would like to rename the
>> PC87312 type checking macro to PC87312_SUPERIO, if that's OK.
>>
>> The actual string name doesn't matter for the QOM macros, by the
>> way.  We can still rename it if you want to, but we don't have
>> to.
> 
> Based on Daniel's suggestion of keeping the macro names
> consistent with the QOM type name string, I'd like to keep the
> original color of the bike shed and keep this patch as is.
> 
> I will queue this patch on machine-next with HervÃƒÆ’Ã‚Â©'s Reviewed-by
> line.
> 
> If anybody wants to rename the user-visible QOM type name string
> later, that's OK.  But I don't think this should be done as part
> of the QOM boilerplate cleanup work.

Understood, no problem.

