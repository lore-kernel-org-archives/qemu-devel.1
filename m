Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3258FC38A2A
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 20:18:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01A89206F5
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 20:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGxvVLrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A89206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXsP3-0003Fx-8t
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 16:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXsOF-0002lU-8m
 for qemu-devel@nongnu.org; Sun, 10 May 2020 16:17:35 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39115)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXsOE-0005GB-GR
 for qemu-devel@nongnu.org; Sun, 10 May 2020 16:17:35 -0400
Received: by mail-wr1-x444.google.com with SMTP id l18so8355203wrn.6
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 13:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eLlmz0FqT5gXxswnapOM3qc4OBrkhAlqJ4ZOBm0sFW8=;
 b=tGxvVLrhkxRg61CZCouzAyM/UJrRbRK/OlZWX3P/T/yyjDO6vpcb4pdADr7pl1NqXH
 TlyJ6cPbVyn47oCllBP4yznoEt4ipSCl7MitzfoGJCV1nM4Ne/P78PruS0LNGfThPW5Y
 gDUYoEbnsg1tKpGo6lmJ6rdUM35NIYqJYGj1gyfJaCrBeSiAzykbZ7T7RGNfK++NU9wB
 bI9aXcZ03+44UZgI2TVmdfSKgzDYToTBHdKQ5pniyOrUoC8mea08aqiQm+r6FlJtvIDL
 ZudHlQ2r+y7OPZvGkRDNofMgOqNLurCpCAkruL8AvQC+aJBj3fmoaBLVRgKrl4qqM8qF
 vsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eLlmz0FqT5gXxswnapOM3qc4OBrkhAlqJ4ZOBm0sFW8=;
 b=Xju4LjSutIQMNl5TryR+Y8vYMbn5vsbKF8wT02YLIc+Wt6oVTA1v5ZCK/Xh4nj58d7
 fDTHJtDdkTz/2xjMt0wEkaZDFoG3w0PywRGACLcXbnWLLDhit8Sa4CZzXzsk0WqSPWtj
 zWY11SZ3GMg7Hpyv9+Kz2dxuS4JBtXkPnqlPDrfNTa8kvDrP48aiCFs8vUZXZWU9wpe5
 SlFJB8bHp3aDZaSEUrdIfkcnE/7VDv/atie51d9Sg6NawI87Odd5eONt2r8YvJj8jMyb
 ROCPjx7NqNSv5VNbOxZGR8ARYGS7E8XkAPcaXmT2RJ5ZN2jR39JcK73SuJ/kIDhgErkS
 dxDg==
X-Gm-Message-State: AGi0PuZ1NQiTfO00DUGiRP71b8op49vfkHKgOUtH8t1Yy6484vyAMYVQ
 o2wsCjTRHa9wMqqg50JUyE8=
X-Google-Smtp-Source: APiQypJLGRLcFkAD/fZuvZVfKwzkY/eieCTJttn7ZpPp8PsvTZofu6t0S1bNKyGEcuP/r9SswFCvKA==
X-Received: by 2002:a5d:5642:: with SMTP id j2mr14783479wrw.52.1589141852582; 
 Sun, 10 May 2020 13:17:32 -0700 (PDT)
Received: from [192.168.1.37] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id z7sm14445174wrl.88.2020.05.10.13.17.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 May 2020 13:17:31 -0700 (PDT)
Subject: Re: [PATCH v4 08/10] hw/core/resettable: add support for warm reset
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
References: <20190821163341.16309-1-damien.hedde@greensocs.com>
 <20190821163341.16309-9-damien.hedde@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <762b6429-15af-4f6e-2a31-87e3d3313f86@amsat.org>
Date: Sun, 10 May 2020 22:17:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20190821163341.16309-9-damien.hedde@greensocs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, berrange@redhat.com,
 ehabkost@redhat.com, mark.burton@greensocs.com, pbonzini@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Damien,

On 8/21/19 6:33 PM, Damien Hedde wrote:
> Add the RESET_TYPE_WARM reset type.
> Expand the actual implementation to support several types.
> 
> I used values which can be or'ed together. This way we can what reset
> has been triggered.
> 
> Documentation is added in a following patch.
> 
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
>   hw/core/resettable.c    | 25 +++++++++++++++++++------
>   include/hw/resettable.h | 22 +++++++++++++++++-----
>   2 files changed, 36 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/core/resettable.c b/hw/core/resettable.c
> index b534c2c7a4..80674292b3 100644
> --- a/hw/core/resettable.c
> +++ b/hw/core/resettable.c
> @@ -34,12 +34,17 @@ static void resettable_init_reset(Object *obj, ResetType type)
>       ResetState *s = rc->get_state(obj);
>       bool action_needed = false;
>   
> -    /* Only take action if we really enter reset for the 1st time. */
> +    /* ensure type is empty if no reset is in progress */
> +    if (s->count == 0) {
> +        s->type = 0;
> +    }
> +
>       /*
> -     * TODO: if adding more ResetType support, some additional checks
> -     * are probably needed here.
> +     * Only take action if:
> +     * + we are not already in cold reset,
> +     * + and we enter a new type of reset.
>        */
> -    if (s->count == 0) {
> +    if ((s->type & RESET_TYPE_COLD) == 0 && (s->type & type) == 0) {
>           action_needed = true;
>       }
>       s->count += 1;
> @@ -62,6 +67,7 @@ static void resettable_init_reset(Object *obj, ResetType type)
>   
>       /* exec init phase */
>       if (action_needed) {
> +        s->type |= type;
>           s->hold_phase_needed = true;
>           if (rc->phases.init) {
>               rc->phases.init(obj, type);
> @@ -133,8 +139,7 @@ static void resettable_exit_reset(Object *obj)
>   
>   void resettable_reset(Object *obj, ResetType type)
>   {
> -    /* TODO: change that when adding support for other reset types */
> -    assert(type == RESET_TYPE_COLD);
> +    assert(type == RESET_TYPE_COLD || type == RESET_TYPE_WARM);
>       trace_resettable_reset(obj, type);
>       resettable_init_reset(obj, type);
>       resettable_hold_reset(obj);
> @@ -154,6 +159,14 @@ bool resettable_is_resetting(Object *obj)
>       return (s->count > 0);
>   }
>   
> +ResetType resettable_get_type(Object *obj)
> +{
> +    ResettableClass *rc = RESETTABLE_GET_CLASS(obj);
> +    ResetState *s = rc->get_state(obj);
> +
> +    return s->type;
> +}
> +
>   void resettable_class_set_parent_phases(ResettableClass *rc,
>                                           ResettableInitPhase init,
>                                           ResettableHoldPhase hold,
> diff --git a/include/hw/resettable.h b/include/hw/resettable.h
> index 5808c3c187..1e77cbd75b 100644
> --- a/include/hw/resettable.h
> +++ b/include/hw/resettable.h
> @@ -12,15 +12,14 @@ typedef struct ResetState ResetState;
>   
>   /**
>    * ResetType:
> - * Types of reset.
> + * Types of reset, values can be OR'ed together.
>    *
>    * + Cold: reset resulting from a power cycle of the object.
> - *
> - * TODO: Support has to be added to handle more types. In particular,
> - * ResetState structure needs to be expanded.
> + * + Warm: reset without power cycling.
>    */
>   typedef enum ResetType {
> -    RESET_TYPE_COLD,
> +    RESET_TYPE_COLD = 0x1,
> +    RESET_TYPE_WARM = 0x2,

I'm a bit lost with the various iterations, what is the plan with warm 
reset, is this blocked due to discussion, API, something else?

>   } ResetType;
>   
>   /*
> @@ -107,11 +106,13 @@ typedef struct ResettablePhases ResettablePhases;
>    *
>    * @count: Number of reset level the object is into. It is incremented when
>    * the reset operation starts and decremented when it finishes.
> + * @type: Type of the in-progress reset. Valid only when count is non-zero.
>    * @hold_phase_needed: flag which indicates that we need to invoke the 'hold'
>    * phase handler for this object.
>    */
>   struct ResetState {
>       uint32_t count;
> +    ResetType type;
>       bool hold_phase_needed;
>   };
>   
> @@ -123,6 +124,17 @@ struct ResetState {
>    */
>   bool resettable_is_resetting(Object *obj);
>   
> +/**
> + * resettable_get_type:
> + * Return the current type of reset @obj is under.
> + *
> + * @obj must implement Resettable interface. Result is only valid if
> + * @resettable_is_resetting is true.
> + *
> + * Note: this return an OR'ed value of type if several reset were triggered
> + */
> +ResetType resettable_get_type(Object *obj);
> +
>   /**
>    * resettable_reset:
>    * Trigger a reset on a object @obj of type @type. @obj must implement
> 

