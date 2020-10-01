Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3B3C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:18:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADC65207F7
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C2Z4yrW1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC65207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO0LV-00011W-K8
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kO0Hc-0005mc-JY
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:14:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55495)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kO0HZ-0007gb-T4
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601565248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ErXrq1Qxd/KCQTO9mhhx/WLKLdDbsSAU1USGV/RH6jM=;
 b=C2Z4yrW1wYBb7YNA2CuayJbq58B3Snsi/DzcA89NQnEKK5+xAE12wTzyheePGsVb/aqYVD
 c/NCLkCkr+re2G97ssKGX/FFWdX1+PFUXth4e8VFXpI5Pbb85PYuWJRClL8eJkEtMdHYk8
 xyRdacGq/unbzHoH6sxA+7uU/1hJNBk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-Dqrza8AiPeGCwZ9eYXAhLA-1; Thu, 01 Oct 2020 11:14:07 -0400
X-MC-Unique: Dqrza8AiPeGCwZ9eYXAhLA-1
Received: by mail-wm1-f70.google.com with SMTP id 13so62780wmf.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 08:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ErXrq1Qxd/KCQTO9mhhx/WLKLdDbsSAU1USGV/RH6jM=;
 b=r1UhtGernuGJTvVEwLq6wZnT1KDMMIvMI9SQ22cN6JxRFWsS1YxMfFFKrHM7Cr6ocB
 Q4djTN2/qN+hPZxRskU7KWQ3tQCHi4gyGJpHnoCHalEGejGyAFv4CZGK9NNvmknkkugF
 KYF6Nl+s/+/mv23wX/hGcFovMOVnGCKODE2qlU7X98aUadQThFmv9JMgJuRXaUafAZXp
 pMx5ZhX2DQXPb+Z4Zz8HtJpeltTl/qEgO+3UhWDcmAcwGhvDK9BJHID331iPa1NAYcx/
 0lH2ye0LUed2Bc43m0yFS7nyI0nlHCFbw+NfG4fpLCkNXwbo1O1zdjrfiz6HHQXk5R2f
 uWYw==
X-Gm-Message-State: AOAM532KANHB1QNsJus4RmzBb0itRwgcbLizTN3urIfrC1/20Q8YMcYu
 13MgqBDqqM8Q8gXy2AVMdFEZDUp+XpI0yS9J6A3fdDN0SPrL4XBVgvAAUFnkz0V+iN0W97eImkA
 56yFN4AeJ6KfMYAQ=
X-Received: by 2002:a5d:4c88:: with SMTP id z8mr9470373wrs.218.1601565245861; 
 Thu, 01 Oct 2020 08:14:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzleR/4PnbFPelvjE0zQQidtmG+WB/O7Zi5qDZhjtXNK6gAcv3Zv2jqDfjQakG8XC5zwJE9bw==
X-Received: by 2002:a5d:4c88:: with SMTP id z8mr9470339wrs.218.1601565245571; 
 Thu, 01 Oct 2020 08:14:05 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:86de:492a:fae3:16f2?
 ([2001:b07:6468:f312:86de:492a:fae3:16f2])
 by smtp.gmail.com with ESMTPSA id t202sm443873wmt.14.2020.10.01.08.14.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 08:14:04 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] target/i386/cpu: Restrict some of feature-words
 uses to system-mode
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20201001144152.1555659-1-philmd@redhat.com>
 <20201001144152.1555659-3-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <933089b7-a088-d142-bf0c-55cae3e9bd70@redhat.com>
Date: Thu, 1 Oct 2020 17:14:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201001144152.1555659-3-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 04:25:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.26, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/10/20 16:41, Philippe Mathieu-Daudé wrote:
> The feature-words properties are not used in user-mode emulation,
> restrict it to system-mode.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

This seems a bit pointless honestly.  It's going to be a few KBs of code
at most.  I would end the work with the patches that have already been
queued.

Paolo

> ---
>  target/i386/cpu.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 2eec53ca22..9f72342506 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -4607,6 +4607,7 @@ static void x86_cpuid_set_tsc_freq(Object *obj, Visitor *v, const char *name,
>      cpu->env.tsc_khz = cpu->env.user_tsc_khz = value / 1000;
>  }
>  
> +#if !defined(CONFIG_USER_ONLY)
>  /* Generic getter for "feature-words" and "filtered-features" properties */
>  static void x86_cpu_get_feature_words(Object *obj, Visitor *v,
>                                        const char *name, void *opaque,
> @@ -4666,6 +4667,7 @@ static const char *x86_cpu_feature_name(FeatureWord w, int bitnr)
>      assert(bitnr < 32 || !(name && feature_word_info[w].type == CPUID_FEATURE_WORD));
>      return name;
>  }
> +#endif /* CONFIG_USER_ONLY */
>  
>  /*
>   * Convert all '_' in a feature string option name to '-', to make feature
> @@ -4783,6 +4785,7 @@ static void x86_cpu_parse_featurestr(const char *typename, char *features,
>  static void x86_cpu_expand_features(X86CPU *cpu, Error **errp);
>  static void x86_cpu_filter_features(X86CPU *cpu, bool verbose);
>  
> +#if !defined(CONFIG_USER_ONLY)
>  /* Build a list with the name of all features on a feature word array */
>  static void x86_cpu_list_feature_names(FeatureWordArray features,
>                                         strList **feat_names)
> @@ -4853,6 +4856,7 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
>  
>      object_unref(OBJECT(xc));
>  }
> +#endif /* CONFIG_USER_ONLY */
>  
>  /* Print all cpuid feature names in featureset
>   */
> @@ -4987,7 +4991,9 @@ static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
>  
>      info = g_malloc0(sizeof(*info));
>      info->name = x86_cpu_class_get_model_name(cc);
> +#if !defined(CONFIG_USER_ONLY)
>      x86_cpu_class_check_missing_features(cc, &info->unavailable_features);
> +#endif
>      info->has_unavailable_features = true;
>      info->q_typename = g_strdup(object_class_get_name(oc));
>      info->migration_safe = cc->migration_safe;
> @@ -6941,6 +6947,7 @@ static void x86_cpu_initfn(Object *obj)
>      object_property_add(obj, "tsc-frequency", "int",
>                          x86_cpuid_get_tsc_freq,
>                          x86_cpuid_set_tsc_freq, NULL, NULL);
> +#if !defined(CONFIG_USER_ONLY)
>      object_property_add(obj, "feature-words", "X86CPUFeatureWordInfo",
>                          x86_cpu_get_feature_words,
>                          NULL, NULL, (void *)env->features);
> @@ -6957,7 +6964,6 @@ static void x86_cpu_initfn(Object *obj)
>                          x86_cpu_get_unavailable_features,
>                          NULL, NULL, NULL);
>  
> -#if !defined(CONFIG_USER_ONLY)
>      object_property_add(obj, "crash-information", "GuestPanicInformation",
>                          x86_cpu_get_crash_info_qom, NULL, NULL, NULL);
>  #endif
> 


