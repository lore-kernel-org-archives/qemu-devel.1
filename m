Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BAAC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:45:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A64C22074D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGLcNgJs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64C22074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kECy3-0001Sb-SI
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 10:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kECxH-0000IT-Vt; Fri, 04 Sep 2020 10:44:43 -0400
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:40593)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kECxF-0005l4-Us; Fri, 04 Sep 2020 10:44:43 -0400
Received: by mail-qv1-xf44.google.com with SMTP id j3so3103893qvi.7;
 Fri, 04 Sep 2020 07:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jhB8HBPSPBC9/TpHcLtVFREi90f1YZ5Yyc3bSloFVts=;
 b=TGLcNgJsROOpywuxHKBvATD6e6LNaYnRm4kBQY7iaSn0H3ny7oRIz01awRFQPP1LN0
 +n0tcT3lLsd1JsSncEUGGthE4oIyMYhIxW2auEnTxjSLoOcpVScgN4ueC8aq5YXbC+Ik
 f7FgMNX910jMJ5xDvaUkbzrtowoodhYeyYFu2O61oc0Y6LPN948V+LyYr5o/yPXna5BY
 I53pm+rpwI9rbrSkJfMcBwKy30IBFT4wbsjsMz2S2ngDoRYkOFzS1G0+JjHzz0k+DtqT
 5sF9DqcVNDWCZTe+nGfgGo4foEUzTGL8fpiSbNGSknL5p/QTeubWtm9hm1HDRBtQwdxz
 J7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jhB8HBPSPBC9/TpHcLtVFREi90f1YZ5Yyc3bSloFVts=;
 b=WIeWTUR4WtbXFUbr2t4y2rHv5mfdd9ea6dPwLx/tkqThegasevFHJ7MvJFN10AU5OS
 MOb4DGfAP1i09DzblZUYXU9I3Q6cublGFiJJ3ju6/u73GcuWJw9hVxDkF0czdslEV4nA
 OEV+/iXnHiTedjPysthSRCBc/cp/MZpQYuI6Q3hzTh4E6grdXimoC6/ALQaLx16uGNzv
 5qYF31/JrCwWWBaUrnVfaUVmpZsZp0dUfYiUOsnFYsL0KDfP+X2rGNbsrguzOGA0sXnK
 kPqG7tPWkk+ZfgLSUNy6rFgDoBmPLimteZx1WuJR+C7rgRzTG4KsMqtllH3EqYlj/48C
 Gk5A==
X-Gm-Message-State: AOAM531ua1QUINMqw0qV9tZPMeDIofVkOAyaRbwk0SvADMLLYcv/R47S
 vju10XduOD5yrYvXSGLyB1iW2o3qcfw=
X-Google-Smtp-Source: ABdhPJysm4cKBBOyLjG7COv/fB6jmaDh9ScN7mZJq6yZgPNneibk/f1bmAhcP5eVQM4ObeIZCUvZ/Q==
X-Received: by 2002:a0c:a9c6:: with SMTP id c6mr8333367qvb.151.1599230680227; 
 Fri, 04 Sep 2020 07:44:40 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c6:1dc:ffbd:d3fb:97ff:aaca?
 ([2804:431:c7c6:1dc:ffbd:d3fb:97ff:aaca])
 by smtp.gmail.com with ESMTPSA id p68sm4764818qka.78.2020.09.04.07.44.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2020 07:44:39 -0700 (PDT)
Subject: Re: [PATCH v5 2/3] spapr_numa: create a vcpu associativity helper
To: Greg Kurz <groug@kaod.org>
References: <20200904135631.605094-1-danielhb413@gmail.com>
 <20200904135631.605094-3-danielhb413@gmail.com>
 <20200904163503.269ebe77@bahia.lan>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <5d774778-01e0-1b41-4422-2222c3bbabc2@gmail.com>
Date: Fri, 4 Sep 2020 11:44:35 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904163503.269ebe77@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f44;
 envelope-from=danielhb413@gmail.com; helo=mail-qv1-xf44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.107,
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/4/20 11:35 AM, Greg Kurz wrote:
> On Fri,  4 Sep 2020 10:56:30 -0300
> Daniel Henrique Barboza <danielhb413@gmail.com> wrote:
> 
>> The work to be done in h_home_node_associativity() intersects
>> with what is already done in spapr_numa_fixup_cpu_dt(). This
>> patch creates a new helper, spapr_numa_get_vcpu_assoc(), to
>> be used for both spapr_numa_fixup_cpu_dt() and
>> h_home_node_associativity().
>>
>> While we're at it, use memcpy() instead of loop assignment
>> to created the returned array.
>>
>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>> ---
>>   hw/ppc/spapr_numa.c    | 33 ++++++++++++++++++++-------------
>>   include/hw/ppc/spapr.h |  7 ++++++-
>>   2 files changed, 26 insertions(+), 14 deletions(-)
>>
>> diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
>> index 368c1a494d..674d2ee86d 100644
>> --- a/hw/ppc/spapr_numa.c
>> +++ b/hw/ppc/spapr_numa.c
>> @@ -71,31 +71,38 @@ void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
>>                         sizeof(spapr->numa_assoc_array[nodeid]))));
>>   }
>>   
>> -int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
>> -                            int offset, PowerPCCPU *cpu)
>> +static uint32_t *spapr_numa_get_vcpu_assoc(SpaprMachineState *spapr,
>> +                                           PowerPCCPU *cpu)
>>   {
>> -    uint vcpu_assoc_size = NUMA_ASSOC_SIZE + 1;
>> -    uint32_t vcpu_assoc[vcpu_assoc_size];
>> +    uint32_t *vcpu_assoc = g_malloc(VCPU_ASSOC_SIZE * sizeof(uint32_t));
> 
> CODING_STYLE recommends g_new(uint32_t, VCPU_ASSOC_SIZE)

Guess I can't rely solely on scripts/checkpath.pl anymore ....


> 
>>       int index = spapr_get_vcpu_id(cpu);
>> -    int i;
>> +
>> +    g_assert(vcpu_assoc != NULL);
>>   
> 
> g_malloc() and friends only return NULL when passed a zero size,
> which is obviously not the case here.

This was my attempt of trying to cover the case where g_malloc() might fail,
but reading the docs again I believe failure in g_malloc() would result in
application terminationl. What I did there makes sense for g_try_malloc().

I'll change up there for g_new() and drop this g_assert().



> 
>>       /*
>>        * VCPUs have an extra 'cpu_id' value in ibm,associativity
>>        * compared to other resources. Increment the size at index
>> -     * 0, copy all associativity domains already set, then put
>> -     * cpu_id last.
>> +     * 0, put cpu_id last, then copy the remaining associativity
>> +     * domains.
>>        */
>>       vcpu_assoc[0] = cpu_to_be32(MAX_DISTANCE_REF_POINTS + 1);
>> +    vcpu_assoc[VCPU_ASSOC_SIZE - 1] = cpu_to_be32(index);
>> +    memcpy(vcpu_assoc + 1, spapr->numa_assoc_array[cpu->node_id] + 1,
>> +           (VCPU_ASSOC_SIZE - 2) * sizeof(uint32_t));
>>   
>> -    for (i = 1; i <= MAX_DISTANCE_REF_POINTS; i++) {
>> -        vcpu_assoc[i] = spapr->numa_assoc_array[cpu->node_id][i];
>> -    }
>> +    return vcpu_assoc;
>> +}
>> +
>> +int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
>> +                            int offset, PowerPCCPU *cpu)
>> +{
>> +    g_autofree uint32_t *vcpu_assoc = NULL;
>>   
>> -    vcpu_assoc[vcpu_assoc_size - 1] = cpu_to_be32(index);
>> +    vcpu_assoc = spapr_numa_get_vcpu_assoc(spapr, cpu);
>>   
>>       /* Advertise NUMA via ibm,associativity */
>> -    return fdt_setprop(fdt, offset, "ibm,associativity",
>> -                       vcpu_assoc, sizeof(vcpu_assoc));
>> +    return fdt_setprop(fdt, offset, "ibm,associativity", vcpu_assoc,
>> +                       VCPU_ASSOC_SIZE * sizeof(uint32_t));
>>   }
>>   
>>   
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 9a63380801..e50a2672e3 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -107,13 +107,18 @@ typedef enum {
>>   
>>   /*
>>    * NUMA related macros. MAX_DISTANCE_REF_POINTS was taken
>> - * from Taken from Linux kernel arch/powerpc/mm/numa.h.
> 
> Heh a good opportunity to fix the "from Taken from" typo I guess ;)
> 
>> + * from Linux kernel arch/powerpc/mm/numa.h. It represents the
>> + * amount of associativity domains for non-CPU resources.
>>    *
>>    * NUMA_ASSOC_SIZE is the base array size of an ibm,associativity
>>    * array for any non-CPU resource.
>> + *
>> + * VCPU_ASSOC_SIZE represents the size of ibm,associativity array
>> + * for CPUs, which has an extra element (vcpu_id) in the end.
>>    */
>>   #define MAX_DISTANCE_REF_POINTS    4
>>   #define NUMA_ASSOC_SIZE            (MAX_DISTANCE_REF_POINTS + 1)
>> +#define VCPU_ASSOC_SIZE            (NUMA_ASSOC_SIZE + 1)
>>   
>>   typedef struct SpaprCapabilities SpaprCapabilities;
>>   struct SpaprCapabilities {
> 
> With the comments on g_malloc() addressed, feel free to add:
> 
> Reviewed-by: Greg Kurz <groug@kaod.org>

Thanks! I'll change g_malloc() and so on like you suggested and send
this as v6.



DHB

> 

