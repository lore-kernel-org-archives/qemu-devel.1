Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B11C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:42:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCFFD206C1
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WEUGdE8B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCFFD206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO0io-0003T7-Nl
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO0Ul-0005V7-OR
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:27:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26889)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO0Ui-0001bk-HW
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601566058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rDbrGsP+eWDjvRMkBQEcWdLfKDLXamrlogewfUgHBY0=;
 b=WEUGdE8BUVquoT/z+GWkfrHZ5f/3XlX5HrQ/ve50PnuXtH2gae8gqh5LI43zrek++AgUEl
 CqpdBaDUDSgET5DqY4ZUcEkqbxDYK+gYbckflgpN9lUqSLbh7vfpmwSETdnCaYJTN+Dqpw
 JOOOfHjNeW2Zd31QlU11fuyf38X6kSY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-MZOFW3ooOeGPs3fhEOklDg-1; Thu, 01 Oct 2020 11:27:37 -0400
X-MC-Unique: MZOFW3ooOeGPs3fhEOklDg-1
Received: by mail-wm1-f71.google.com with SMTP id 73so1306608wma.5
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 08:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=rDbrGsP+eWDjvRMkBQEcWdLfKDLXamrlogewfUgHBY0=;
 b=XEtUT6NZa4b3ZZ+sNOHu1Aw0asytLeCpWwMlRJHmSb2hUjqKqEBiOAsKBOSBaOUqaY
 zzoIzZjrWU7aHCf9cT4RyAZiwxzREJEi6DYzThIX9o1i4oB9nu9MNKhMiCUmh9VppEuh
 EkEKClfmjoQlF6uM6VC6KiiYAx+zUV6voMoFBrbJAFGo5+2/HreNeUzVd4bMOp5QA71m
 p7t6atgkkTHjATtUrxkejdqinmbD8GeTHxKIdvpmpbaSTcZb07ocnzfgGCV7jkdW2ETF
 +mCp9PmGfC0RNR6ksz+M/P0rmtIrBDpoPtBsqkgUwZqzJj7Y52sXxTsUzGdUQJkX/qH0
 4tUg==
X-Gm-Message-State: AOAM5333AwTQWqR+BjDod9DL5gs8GKLryw86NU8zPcpcea6m21luEFzC
 t1QZU3Exw84dlCO3YSl4g0Rc6hN0yq/myw1rjDVygi0QsRZWrzolFKbyfnD38aVGIKL8hLGbIde
 g1ql6PSx+NWmSHIc=
X-Received: by 2002:a5d:630a:: with SMTP id i10mr9392984wru.137.1601566055067; 
 Thu, 01 Oct 2020 08:27:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcGBmUYhgyyMQ9ksLAztR1y7MllwV9BgqSl2VS8H403Ydao7q12zuYU3rB2ybUSf0jQ8AkJg==
X-Received: by 2002:a5d:630a:: with SMTP id i10mr9392954wru.137.1601566054789; 
 Thu, 01 Oct 2020 08:27:34 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id y1sm409321wmi.36.2020.10.01.08.27.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 08:27:34 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] target/i386/cpu: Restrict some of feature-words
 uses to system-mode
To: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
References: <20201001144152.1555659-1-philmd@redhat.com>
 <20201001144152.1555659-3-philmd@redhat.com>
 <933089b7-a088-d142-bf0c-55cae3e9bd70@redhat.com>
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
Message-ID: <53758e35-f596-8e17-12cf-58b1a81f98e3@redhat.com>
Date: Thu, 1 Oct 2020 17:27:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <933089b7-a088-d142-bf0c-55cae3e9bd70@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.26, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/20 5:14 PM, Paolo Bonzini wrote:
> On 01/10/20 16:41, Philippe Mathieu-Daudé wrote:
>> The feature-words properties are not used in user-mode emulation,
>> restrict it to system-mode.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> This seems a bit pointless honestly.  It's going to be a few KBs of code
> at most.  I would end the work with the patches that have already been
> queued.

I'll let Eduardo and you discuss that, as he suggested the #ifdef
instead of the stub. The two options are on the list, whichever
you guys prefer :)

> 
> Paolo
> 
>> ---
>>  target/i386/cpu.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 2eec53ca22..9f72342506 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -4607,6 +4607,7 @@ static void x86_cpuid_set_tsc_freq(Object *obj, Visitor *v, const char *name,
>>      cpu->env.tsc_khz = cpu->env.user_tsc_khz = value / 1000;
>>  }
>>  
>> +#if !defined(CONFIG_USER_ONLY)
>>  /* Generic getter for "feature-words" and "filtered-features" properties */
>>  static void x86_cpu_get_feature_words(Object *obj, Visitor *v,
>>                                        const char *name, void *opaque,
>> @@ -4666,6 +4667,7 @@ static const char *x86_cpu_feature_name(FeatureWord w, int bitnr)
>>      assert(bitnr < 32 || !(name && feature_word_info[w].type == CPUID_FEATURE_WORD));
>>      return name;
>>  }
>> +#endif /* CONFIG_USER_ONLY */
>>  
>>  /*
>>   * Convert all '_' in a feature string option name to '-', to make feature
>> @@ -4783,6 +4785,7 @@ static void x86_cpu_parse_featurestr(const char *typename, char *features,
>>  static void x86_cpu_expand_features(X86CPU *cpu, Error **errp);
>>  static void x86_cpu_filter_features(X86CPU *cpu, bool verbose);
>>  
>> +#if !defined(CONFIG_USER_ONLY)
>>  /* Build a list with the name of all features on a feature word array */
>>  static void x86_cpu_list_feature_names(FeatureWordArray features,
>>                                         strList **feat_names)
>> @@ -4853,6 +4856,7 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
>>  
>>      object_unref(OBJECT(xc));
>>  }
>> +#endif /* CONFIG_USER_ONLY */
>>  
>>  /* Print all cpuid feature names in featureset
>>   */
>> @@ -4987,7 +4991,9 @@ static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
>>  
>>      info = g_malloc0(sizeof(*info));
>>      info->name = x86_cpu_class_get_model_name(cc);
>> +#if !defined(CONFIG_USER_ONLY)
>>      x86_cpu_class_check_missing_features(cc, &info->unavailable_features);
>> +#endif
>>      info->has_unavailable_features = true;
>>      info->q_typename = g_strdup(object_class_get_name(oc));
>>      info->migration_safe = cc->migration_safe;
>> @@ -6941,6 +6947,7 @@ static void x86_cpu_initfn(Object *obj)
>>      object_property_add(obj, "tsc-frequency", "int",
>>                          x86_cpuid_get_tsc_freq,
>>                          x86_cpuid_set_tsc_freq, NULL, NULL);
>> +#if !defined(CONFIG_USER_ONLY)
>>      object_property_add(obj, "feature-words", "X86CPUFeatureWordInfo",
>>                          x86_cpu_get_feature_words,
>>                          NULL, NULL, (void *)env->features);
>> @@ -6957,7 +6964,6 @@ static void x86_cpu_initfn(Object *obj)
>>                          x86_cpu_get_unavailable_features,
>>                          NULL, NULL, NULL);
>>  
>> -#if !defined(CONFIG_USER_ONLY)
>>      object_property_add(obj, "crash-information", "GuestPanicInformation",
>>                          x86_cpu_get_crash_info_qom, NULL, NULL, NULL);
>>  #endif
>>
> 


