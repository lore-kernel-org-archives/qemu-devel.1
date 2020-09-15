Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1342C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 19:12:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B58E20770
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 19:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jCGWRueu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B58E20770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIGNQ-0000M4-76
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 15:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIGLC-0006TB-CP
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 15:10:10 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:39131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIGL7-0001N9-Rq
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 15:10:09 -0400
Received: by mail-pf1-x441.google.com with SMTP id n14so2507532pff.6
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 12:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YQAdQphGcFqz1FXr4frB2I10to60V3Y7qY6oV5iDR30=;
 b=jCGWRueu/iqCSKdRTTanqQSJ2rTh82Rol0BWTE8O8O89QABwYtTAtmihblFnzVsgMT
 edf+Llrjr45jept08L+czvbXFpreoPaCKPNUpxJhus8DCNUes1YaPlP8V0TI8nyjQqFp
 6W5AfJdbh/k6Wtzfo50wC4G4RQOuOH7qSENBwZ7h+Pqh4v27ZeD9AgJGhMQszakblLO9
 5ZyA+dEbifx36TIYgDSQZRTPn+rWzirCzOkKapc8o2ySDFDtjHNxz32/NDkaah9L874t
 wZyNTqZGT/duVxrBk/kaBMDTAE4epJvYsQ10AJQPgjjxxXSnKHYUyll2UjjoQa1cXU31
 OdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YQAdQphGcFqz1FXr4frB2I10to60V3Y7qY6oV5iDR30=;
 b=hPq5fwZDERmurLIzmJ5GsMpuOfTOtCBR/xEEjItKMdRH6ITGYC5IbIelOIbZn4S8qL
 dOSSXpivTJgCclt+R8ddN3lgUNgGYpQmOgp9LK3woyiHNLRgH49JVRZtPgpah2vth7oZ
 djz+ofA20zKJgzREsdNnVqgr3AwuCypzgXsmGxqgOaJuHVP5hs8Q/CYxw967tGJir/zt
 9QrhqKcJF2GqMWOZl73KTwUJrBvDlLnapgSzgzkLU8fPCtWrBSgDSI2N6JKOJ32JdoGm
 sr9MVrx9/bnV82LVj1LyC2IsK80wu+gqe9ZbcUzirJpKd8y3XMEgO8eaojQsFm63s6LE
 GMZQ==
X-Gm-Message-State: AOAM530Qug+wjMTKZVjGn/pkXhz/QT702cR/r8NYT8iWAc5zUslRUvIG
 2FYzgb0+33CBWXE6ss7to8bInA==
X-Google-Smtp-Source: ABdhPJxkWA//VuA0ZWz8RJ3h8BZYDQ5Yt1duxjmVNMJ9FOSCVRPmxQql1/Wuew5jb5KNOnd5gBUjSw==
X-Received: by 2002:a05:6a00:1689:b029:142:2501:396d with SMTP id
 k9-20020a056a001689b02901422501396dmr3110691pfc.50.1600197002666; 
 Tue, 15 Sep 2020 12:10:02 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y4sm14590467pfr.46.2020.09.15.12.10.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2020 12:10:01 -0700 (PDT)
Subject: Re: [PATCH 1/5] qom: Allow objects to be allocated with increased
 alignment
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20200915174635.2333553-1-richard.henderson@linaro.org>
 <20200915174635.2333553-2-richard.henderson@linaro.org>
 <20200915180736.GB7594@habkost.net>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6d6a80bf-a542-6818-1638-0318f4aab336@linaro.org>
Date: Tue, 15 Sep 2020 12:09:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200915180736.GB7594@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/15/20 11:07 AM, Eduardo Habkost wrote:
> On Tue, Sep 15, 2020 at 10:46:31AM -0700, Richard Henderson wrote:
>> It turns out that some hosts have a default malloc alignment less
>> than that required for vectors.
>>
>> We assume that, with compiler annotation on CPUArchState, that we
>> can properly align the vector portion of the guest state.  Fix the
>> alignment of the allocation by using qemu_memalloc when required.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: "Daniel P. Berrangé" <berrange@redhat.com>
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> ---
>>  include/qom/object.h |  4 ++++
>>  qom/object.c         | 16 +++++++++++++---
>>  2 files changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/qom/object.h b/include/qom/object.h
>> index 056f67ab3b..d52d0781a3 100644
>> --- a/include/qom/object.h
>> +++ b/include/qom/object.h
>> @@ -770,6 +770,9 @@ struct Object
>>   * @instance_size: The size of the object (derivative of #Object).  If
>>   *   @instance_size is 0, then the size of the object will be the size of the
>>   *   parent object.
>> + * @instance_align: The required alignment of the object.  If @instance_align
>> + *   is 0, then normal malloc alignment is sufficient; if non-zero, then we
>> + *   must use qemu_memalign for allocation.
>>   * @instance_init: This function is called to initialize an object.  The parent
>>   *   class will have already been initialized so the type is only responsible
>>   *   for initializing its own members.
>> @@ -807,6 +810,7 @@ struct TypeInfo
>>      const char *parent;
>>  
>>      size_t instance_size;
>> +    size_t instance_align;
>>      void (*instance_init)(Object *obj);
>>      void (*instance_post_init)(Object *obj);
>>      void (*instance_finalize)(Object *obj);
>> diff --git a/qom/object.c b/qom/object.c
>> index 387efb25eb..2e53cb44a6 100644
>> --- a/qom/object.c
>> +++ b/qom/object.c
>> @@ -50,6 +50,7 @@ struct TypeImpl
>>      size_t class_size;
>>  
>>      size_t instance_size;
>> +    size_t instance_align;
>>  
>>      void (*class_init)(ObjectClass *klass, void *data);
>>      void (*class_base_init)(ObjectClass *klass, void *data);
>> @@ -114,6 +115,7 @@ static TypeImpl *type_new(const TypeInfo *info)
>>  
>>      ti->class_size = info->class_size;
>>      ti->instance_size = info->instance_size;
>> +    ti->instance_align = info->instance_align;
>>  
>>      ti->class_init = info->class_init;
>>      ti->class_base_init = info->class_base_init;
>> @@ -691,13 +693,21 @@ static void object_finalize(void *data)
>>  static Object *object_new_with_type(Type type)
>>  {
>>      Object *obj;
>> +    size_t size, align;
>>  
>>      g_assert(type != NULL);
>>      type_initialize(type);
>>  
>> -    obj = g_malloc(type->instance_size);
>> -    object_initialize_with_type(obj, type->instance_size, type);
>> -    obj->free = g_free;
>> +    size = type->instance_size;
>> +    align = type->instance_align;
>> +    if (align) {
> 
> If we check for (align > G_MEM_ALIGN) instead, we will be able to
> set instance_align automatically at OBJECT_DEFINE_TYPE*.

I agree a value check would be good here, as well as setting this by default.

As for the value check itself...

I see that G_MEM_ALIGN isn't actually defined in an interesting or even correct
way.  E.g. it doesn't take the long double type into account.

The usual mechanism is

struct s {
  char pad;
  union {
    long l;
    void *p;
    double d;
    long double ld;
  } u;
};

offsetof(s, u)

since all of these types are required to be taken into account by the system
malloc.

E.g it doesn't take other host guarantees into account, e.g. i386-linux
guarantees 16-byte alignment.  This possibly dubious ABI change was made 20+
years ago with the introduction of SSE and is now set in stone.

Glibc has a "malloc-alignment.h" internal header that defaults to

  MIN(2 * sizeof(size_t), __alignof__(long double))

and is overridden for i386.  Sadly, it doesn't export MALLOC_ALIGNMENT.

Musl has two different malloc implementations.  One has UNIT = 16; the other
has SIZE_ALIGN = 4*sizeof(size_t).  Both have a minimum value of 16, and this
is not target-specific.

Any further comments on the subject, or should I put together something that
computes the MAX of the above?


r~

