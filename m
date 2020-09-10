Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB76C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 05:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AA59207FB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 05:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOBb4cYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA59207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGF9W-0005Dk-G8
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 01:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGF8z-0004nZ-LP
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 01:29:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21133
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGF8w-0007lQ-Rn
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 01:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599715749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BzCTD+737iSkAhb26fhXVnQY93vOjWfEqm6fLMI8zmg=;
 b=SOBb4cYGXo2jQQb44rmPDUjvPD9XQIpThhbaH15WQn4W0nKrxmLdzj11yskKFbHCiXILHH
 jXhJeZEXN2XxmXVfAGD5Vrq22DKBB2TPZ64NdUBU5NMOanrW56Q4MZQj1yqyhMmlNLzpRE
 EdKbkq5WjNtLWXpIRw3bX5UZuDg8NMk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-eULmCLm6Okyr-yGPFoZ7zQ-1; Thu, 10 Sep 2020 01:29:07 -0400
X-MC-Unique: eULmCLm6Okyr-yGPFoZ7zQ-1
Received: by mail-wm1-f69.google.com with SMTP id x81so1234048wmg.8
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 22:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=BzCTD+737iSkAhb26fhXVnQY93vOjWfEqm6fLMI8zmg=;
 b=MGBOZgKzX9N19Dqym7aJQDQAz+hdlJgj8vmhKvW0AGd+LHP18V0W8eKDp7zIQ9XOjp
 +CCZHIm0QQZNduehxNGEXHRzSa5eB+JpQbqK7+sH3MrUywS2UcGbsm2c1d+Hm92IPpzZ
 ciWGKN10VmtJmxUlegBHBbTWwTPgGWMSbodClqNYBbMfZk0u8WogKt431EKjSJWstDsz
 3yYTPcLQBE8/saZNaWY2IySBcxmRZlo6MNuQ7Nu5FzGf5R/RN60hi8eeFXzImVk9GRaZ
 Jq37ikJOdHC3ruUnD0lQkJ15ElHLl911p0jaa5e2setdri621TzKLlP7uw5KxbqttWPQ
 iRXA==
X-Gm-Message-State: AOAM532qhhq9qHjhE34zGXsj0eYvTMrokXccknG+sd2DbYylPCpAoGc5
 prbkgQUwNMM+fCU0wvfuuoQU6qY7K3Ngh/xl3wtZhGdFOw/klS+GAwgNYR+qAXzJkf6hQgiFl5S
 jXWFYsX6BPL3UbSU=
X-Received: by 2002:adf:82cb:: with SMTP id 69mr7175376wrc.222.1599715746263; 
 Wed, 09 Sep 2020 22:29:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRGgpSR8yLYx6ssSfBjx7GI5+gydmDjxqf6Hw/7hP+k1hVoJAqaY7qe1NZ6H/OUFIa0XL+nA==
X-Received: by 2002:adf:82cb:: with SMTP id 69mr7175355wrc.222.1599715745930; 
 Wed, 09 Sep 2020 22:29:05 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id a85sm1892858wmd.26.2020.09.09.22.29.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2020 22:29:05 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] Introduce (x86) CPU model deprecation API
To: Eduardo Habkost <ehabkost@redhat.com>,
 Robert Hoo <robert.hu@linux.intel.com>
References: <1591843676-102054-1-git-send-email-robert.hu@linux.intel.com>
 <20200909181506.GM1618070@habkost.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <3f823308-149c-6759-35ae-4df7d0116cb6@redhat.com>
Date: Thu, 10 Sep 2020 07:29:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200909181506.GM1618070@habkost.net>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 00:49:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: armbru@redhat.com, xiaoyao.li@intel.com, chenyi.qiang@intel.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, robert.hu@intel.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/9/20 8:15 PM, Eduardo Habkost wrote:
> Hi,
> 
> Thanks for the patch, and sorry for taking so long to review
> this.  I'm finally getting to the patches that were postponed to
> 5.2.

Sorry I missed that patch too.

Why restrict this to CPUClass, and not provide this feature to
all ObjectClass?

> 
> Comments and questions below:
> 
> On Thu, Jun 11, 2020 at 10:47:55AM +0800, Robert Hoo wrote:
>> Complement versioned CPU model framework with the ability of marking some
>> versions deprecated. When that CPU model is chosen, get some warning. The
>> warning message is customized, e.g. telling in which future QEMU version will
>> it be obsoleted.
>> The deprecation message will also appear by x86_cpu_list_entry(), e.g. '-cpu
>> help'.
>> QMP 'query-cpu-definitions' will also return a bool value indicating the
>> deprecation status.
>>
>> Changes in v2:
>> Move deprecation check from parse_cpu_option() to machine_run_board_init(), so
>> that it can cover implicit cpu_type assignment cases.
>> Add qapi new member documentation. Thanks Eric for comment and guidance on qapi.
>>
>> Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
>> ---
>>  hw/core/machine.c        | 11 +++++++++--
>>  include/hw/core/cpu.h    |  1 +
>>  qapi/machine-target.json |  7 ++++++-
>>  target/i386/cpu.c        | 45 +++++++++++++++++++++++++++++++++++++++++++--
>>  4 files changed, 59 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index bb3a7b1..9318964 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -1083,6 +1083,8 @@ MemoryRegion *machine_consume_memdev(MachineState *machine,
>>  void machine_run_board_init(MachineState *machine)
>>  {
>>      MachineClass *machine_class = MACHINE_GET_CLASS(machine);
>> +    ObjectClass *oc = object_class_by_name(machine->cpu_type);
>> +    CPUClass *cc;
>>  
>>      if (machine->ram_memdev_id) {
>>          Object *o;
>> @@ -1102,11 +1104,10 @@ void machine_run_board_init(MachineState *machine)
>>       * specified a CPU with -cpu check here that the user CPU is supported.
>>       */
>>      if (machine_class->valid_cpu_types && machine->cpu_type) {
>> -        ObjectClass *class = object_class_by_name(machine->cpu_type);
>>          int i;
>>  
>>          for (i = 0; machine_class->valid_cpu_types[i]; i++) {
>> -            if (object_class_dynamic_cast(class,
>> +            if (object_class_dynamic_cast(oc,
>>                                            machine_class->valid_cpu_types[i])) {
>>                  /* The user specificed CPU is in the valid field, we are
>>                   * good to go.
>> @@ -1129,6 +1130,12 @@ void machine_run_board_init(MachineState *machine)
>>          }
>>      }
>>  
>> +    /* Check if CPU type is deprecated and warn if so */
>> +    cc = CPU_CLASS(oc);
>> +    if (cc->deprecation_check) {
>> +        cc->deprecation_check(oc);
>> +    }
> 
> Why do we need target-specific code here?  A CPUClass::deprecated
> field would be much simpler.
> 
>> +
>>      machine_class->init(machine);
>>  }
>>  
>> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
>> index 497600c..1ca47dc 100644
>> --- a/include/hw/core/cpu.h
>> +++ b/include/hw/core/cpu.h
>> @@ -218,6 +218,7 @@ typedef struct CPUClass {
>>      void (*disas_set_info)(CPUState *cpu, disassemble_info *info);
>>      vaddr (*adjust_watchpoint_address)(CPUState *cpu, vaddr addr, int len);
>>      void (*tcg_initialize)(void);
>> +    void (*deprecation_check)(ObjectClass *oc);
>>  
>>      /* Keep non-pointer data at the end to minimize holes.  */
>>      int gdb_num_core_regs;
>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>> index f2c8294..c24f506 100644
>> --- a/qapi/machine-target.json
>> +++ b/qapi/machine-target.json
>> @@ -285,6 +285,10 @@
>>  #            in the VM configuration, because aliases may stop being
>>  #            migration-safe in the future (since 4.1)
>>  #
>> +# @deprecated: If true, this CPU model is deprecated and may be removed in
>> +#              in some future version of QEMU according to the QEMU deprecation
>> +#              policy. (since 5.1)
> 
> Next version needs to say "since 5.2".
> 
>> +#
>>  # @unavailable-features is a list of QOM property names that
>>  # represent CPU model attributes that prevent the CPU from running.
>>  # If the QOM property is read-only, that means there's no known
>> @@ -309,7 +313,8 @@
>>              'static': 'bool',
>>              '*unavailable-features': [ 'str' ],
>>              'typename': 'str',
>> -            '*alias-of' : 'str' },
>> +            '*alias-of' : 'str',
>> +            'deprecated' : 'bool' },
>>    'if': 'defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS)' }
>>  
>>  ##
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index ba05da3..0d8638a 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -1599,6 +1599,7 @@ typedef struct X86CPUVersionDefinition {
>>      const char *alias;
>>      const char *note;
>>      PropValue *props;
>> +    bool       deprecated;
>>  } X86CPUVersionDefinition;
>>  
>>  /* Base definition for a CPU model */
>> @@ -1638,6 +1639,11 @@ struct X86CPUModel {
>>       * This matters only for "-cpu help" and query-cpu-definitions
>>       */
>>      bool is_alias;
>> +    /*
>> +     * If true, this model is deprecated, and may be removed in the future.
>> +     * Trying to use it now will cause a warning.
>> +     */
>> +    bool deprecated;
>>  };
>>  
>>  /* Get full model name for CPU version */
>> @@ -4128,8 +4134,7 @@ static X86CPUVersion x86_cpu_model_resolve_version(const X86CPUModel *model)
>>      X86CPUVersion v = model->version;
>>      if (v == CPU_VERSION_AUTO) {
>>          v = default_cpu_version;
>> -    }
>> -    if (v == CPU_VERSION_LATEST) {
>> +    } else if (v == CPU_VERSION_LATEST) {
> 
> Why is this change necessary?
> 
>>          return x86_cpu_model_last_version(model);
>>      }
>>      return v;
>> @@ -4975,6 +4980,7 @@ static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
>>      info->migration_safe = cc->migration_safe;
>>      info->has_migration_safe = true;
>>      info->q_static = cc->static_model;
>> +    info->deprecated = cc->model ? cc->model->deprecated : false;
>>      /*
>>       * Old machine types won't report aliases, so that alias translation
>>       * doesn't break compatibility with previous QEMU versions.
>> @@ -5411,6 +5417,7 @@ static void x86_register_cpudef_types(X86CPUDefinition *def)
>>          m->cpudef = def;
>>          m->version = vdef->version;
>>          m->note = vdef->note;
>> +        m->deprecated = vdef->deprecated;
>>          x86_register_cpu_model_type(name, m);
>>  
>>          if (vdef->alias) {
>> @@ -5418,6 +5425,8 @@ static void x86_register_cpudef_types(X86CPUDefinition *def)
>>              am->cpudef = def;
>>              am->version = vdef->version;
>>              am->is_alias = true;
>> +            am->note = vdef->note;
> 
> Is this extra line related to the deprecation feature?
> 
> It doesn't seem related, and it doesn't seem necessary as the
> `note` field is already ignored for alias CPU models.
> 
>> +            am->deprecated = vdef->deprecated;
>>              x86_register_cpu_model_type(vdef->alias, am);
>>          }
>>      }
>> @@ -7233,6 +7242,37 @@ static Property x86_cpu_properties[] = {
>>      DEFINE_PROP_END_OF_LIST()
>>  };
>>  
>> +static void x86_cpu_deprecation_check(ObjectClass *oc)
>> +{
>> +    X86CPUClass *xcc = X86_CPU_CLASS(oc);
>> +    X86CPUVersion effective_version;
>> +    const X86CPUVersionDefinition *vdef;
>> +
>> +    if (xcc->model == NULL) {
>> +        return;
>> +    }
>> +
>> +    if (xcc->model->version == CPU_VERSION_LEGACY) {
>> +        /* Treat legacy version as v1 */
>> +        effective_version = 1;
>> +    } else {
>> +        effective_version = x86_cpu_model_resolve_version(xcc->model);
>> +    }
>> +
>> +    vdef = xcc->model->cpudef->versions;
>> +
>> +    if (vdef == NULL) {
>> +        return;
>> +    } else {
>> +        if (vdef[effective_version - 1].deprecated) {
>> +            warn_report("Effective CPU model '%s' -- %s",
>> +                    x86_cpu_versioned_model_name(xcc->model->cpudef,\
>> +                                                effective_version),
>> +                    vdef[effective_version - 1].note);
>> +        }
>> +    }
> 
> Why do we need this extra logic?  Isn't it simpler to just add a
> bool CPUClass::deprecated field, and set:
> 
>    cpu->deprecated = model->deprecated;
> 
> inside x86_cpu_cpudef_class_init()?
> 
>> +}
>> +
>>  static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
>>  {
>>      X86CPUClass *xcc = X86_CPU_CLASS(oc);
>> @@ -7291,6 +7331,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
>>      cc->tlb_fill = x86_cpu_tlb_fill;
>>  #endif
>>      cc->disas_set_info = x86_disas_set_info;
>> +    cc->deprecation_check = x86_cpu_deprecation_check;
>>  
>>      dc->user_creatable = true;
>>  }
>> -- 
>> 1.8.3.1
>>
> 


