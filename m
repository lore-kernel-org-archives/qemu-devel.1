Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE6EC4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:48:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE89A207DE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3Kvczht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE89A207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNzsY-0004Rr-TY
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 10:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNzpU-0002Xo-Vg
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:45:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56917)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNzpT-0002X9-Ae
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601563506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=I436BEo2flzsWF+SA/gU6shKg5MrNss6rPKIK212dbc=;
 b=G3KvczhtOEnNa89BN4yErgPHxN5bmzvya5S5NA+VHdsyGKxNYYH+scFv26rLRllqwJFN6/
 rJzgOraE4v/4kkYA65diDJ7kLag7LLLkIHI9j6wRyhlY60VDmf/MDj/A6PL0WkVTu63ixc
 +JUyS+6NH/r4ZmHMJfEdezn+hrQf1KI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-3KdPS8yrNdChqyKDozMjCg-1; Thu, 01 Oct 2020 10:45:03 -0400
X-MC-Unique: 3KdPS8yrNdChqyKDozMjCg-1
Received: by mail-wm1-f70.google.com with SMTP id a25so983608wmb.2
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 07:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=I436BEo2flzsWF+SA/gU6shKg5MrNss6rPKIK212dbc=;
 b=R8SWGMc18ysmIoSclmKzJZBv4xmoAwYygNVnbrR/GJBY3H5dllNFMWS3kO7MH2MOHf
 YR8jFsdZhk5AIZBo17TsF9uxAJh44VD+MwTDDCRbGMVgzAH6hJ5XXR5ZGfNJXOT9ysqr
 Mgm+uSBtT2Zaw848rLTdTGi3lA9gysFgLZATTh9GzuYGlWUwZHzEGIDImqRuLfX6313j
 vp/ggn94AQXbcofcC/dHvGE44oJ+Oa34SJG6dyn+lrSReaiTQWH4nlsXw1TYshlt4EZG
 Qj7IVDSa+QWyKo3l2XOMeNFOOYjs24H6OXw8/LpkrdJGyjBOc3vDl3/3E78FVMULAL4K
 0ucQ==
X-Gm-Message-State: AOAM533QMNMqFMQrlovVIvCxhZAvUwIKGfHFR4J3NNIvF12/9CwGCpZm
 jKlO0flDaNc4tjrh/BqqRGveu5tvjnk8IZY+miUT9zjaYsbeevI3L1XCuMV9NhFh9lyVk0uepk1
 gwhSWZlNW3a9LTHs=
X-Received: by 2002:a1c:480a:: with SMTP id v10mr315395wma.141.1601563502455; 
 Thu, 01 Oct 2020 07:45:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyzi3MCNOI0wLNMfldrWm6iixG/5HDdJZRQMNVVyLc8//FY+G2C3cZbSqp41tG4Fp6C6dhWA==
X-Received: by 2002:a1c:480a:: with SMTP id v10mr315374wma.141.1601563502238; 
 Thu, 01 Oct 2020 07:45:02 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id a3sm194787wmb.46.2020.10.01.07.45.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 07:45:01 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] target/i386/cpu: Restrict some of feature-words
 uses to system-mode
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20201001144152.1555659-1-philmd@redhat.com>
 <20201001144152.1555659-3-philmd@redhat.com>
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
Message-ID: <98b0a395-0c49-e742-9985-9543999e6ba7@redhat.com>
Date: Thu, 1 Oct 2020 16:44:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201001144152.1555659-3-philmd@redhat.com>
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
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/20 4:41 PM, Philippe Mathieu-Daudé wrote:
> The feature-words properties are not used in user-mode emulation,
> restrict it to system-mode.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
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

Buh...

>      info->has_unavailable_features = true;

... I guess here goes the:

   #endif

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


