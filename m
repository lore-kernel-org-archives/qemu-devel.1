Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A550AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 12:43:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F20B20885
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 12:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GitIor/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F20B20885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqyYt-0008VE-OZ
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 08:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqyYL-000867-KK
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 08:42:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28246
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqyYF-0007xQ-8e
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 08:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593693770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dZbBizG1eXmsnIIjvVwhdsP0UNZWwQPVIRudKPYczds=;
 b=GitIor/t3MWmWcfgZnRSr7jD6US52N+0wbnZbtMp+RwRN5BsI889sqiTe8bTKrfsrH5edq
 6SRm/a3ZIUzdv3FUsyo4bWcNBEo+51AnF/FPho+ryz4F0IRf9ggn6uLq4ejThaIskL5SI6
 GgDZaYUvmOgujpfB8QHXlb20iYndnKA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-vLiTU4dgOJ2kJG6fJ7t0sg-1; Thu, 02 Jul 2020 08:42:48 -0400
X-MC-Unique: vLiTU4dgOJ2kJG6fJ7t0sg-1
Received: by mail-wm1-f70.google.com with SMTP id o13so28821744wmh.9
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 05:42:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dZbBizG1eXmsnIIjvVwhdsP0UNZWwQPVIRudKPYczds=;
 b=WQMptr73pLdl8uyiIY5wayW1p4GkmnWy0oXJEED3idac1U6vfgYUGpxJ1oarDQt0Qm
 BrQ9SadSHHC5WGBHCCS/jp2x4RktL9BonP3US+dPyIhtU94HXZWpqR3Bq0xrMSxXzRYO
 5iEXqrbtN82Q/GQcf2sDSkY92FVinXUF0XyeSWLnoCcqYLoTqDVtJfDgnBuEziavbPLP
 cExRnWeSORYV9hzEjgORbgw++bMLV+H+i3lygDiFA6HXBUEqkuugWH/JLgasvfX4KMJe
 76cpXIE6gmjHK02owSyslfsE9VBovlX4hsd1A4S6PqE0QersR/DtoVJ8QReoQAXYHhBw
 NSDg==
X-Gm-Message-State: AOAM532InVQtlUEvBRsY8YaCnyz1TvCBH3TC+BSyQ4MfAwR6uqhXZvHK
 jppK8XxSyhWFCSfJbD4lp4yWnAMQJzgkLWjMKKbmQfwvG1lIJKNp1CsTYSNPEqeYTQg7k4cN12h
 Fn9fNI8OIBD5TF9w=
X-Received: by 2002:adf:f9c8:: with SMTP id w8mr30848236wrr.354.1593693767206; 
 Thu, 02 Jul 2020 05:42:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypVQ/f9UHW+fZ9skzQSrsV+rXAE9FcJ4ssJU5KsNMo6/EXsL1Jgh0Ztp/5Inz4nALWj4uC/w==
X-Received: by 2002:adf:f9c8:: with SMTP id w8mr30848200wrr.354.1593693766841; 
 Thu, 02 Jul 2020 05:42:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2cad:376b:7d21:868e?
 ([2001:b07:6468:f312:2cad:376b:7d21:868e])
 by smtp.gmail.com with ESMTPSA id 30sm11532750wrm.74.2020.07.02.05.42.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2020 05:42:46 -0700 (PDT)
Subject: Re: [PATCH v3] i386: hvf: Implement CPU kick
To: Roman Bolshakov <r.bolshakov@yadro.com>, qemu-devel@nongnu.org
References: <20200702105721.75333-1-r.bolshakov@yadro.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fa29e532-a891-cf61-a8a2-af5e36e7834f@redhat.com>
Date: Thu, 2 Jul 2020 14:42:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200702105721.75333-1-r.bolshakov@yadro.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:23:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Cameron Esfahani <dirty@apple.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/07/20 12:57, Roman Bolshakov wrote:
> There's still a small chance of kick loss, on user-to-kernel border
> between atomic_mb_set's just before the entry to hv_vcpu_run and just
> after it.

Good point, but we can fix it.

> -static void dummy_signal(int sig)
> +static void hvf_handle_ipi(int sig)
>  {
> +    CPUState *cpu = pthread_getspecific(hvf_cpu);

You can use current_cpu here.  If it's NULL, just return (it's a
per-thread variable).

> +    X86CPU *x86_cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86_cpu->env;
> +
> +    if (!atomic_xchg(&env->hvf_in_guest, false)) {

Here, thinking more about it, we need not write hvf_in_guest, so:

	/* Write cpu->exit_request before reading env->hvf_in_guest.  */
	smp_mb();
	if (!atomic_read(&env->hvf_in_guest)) {
		...
	}

> +        wvmcs(cpu->hvf_fd, VMCS_PIN_BASED_CTLS,
> +              rvmcs(cpu->hvf_fd, VMCS_PIN_BASED_CTLS)
> +                | VMCS_PIN_BASED_CTLS_VMX_PREEMPT_TIMER);
> +    }
>  }
>  
>  int hvf_init_vcpu(CPUState *cpu)
> @@ -631,7 +650,9 @@ int hvf_vcpu_exec(CPUState *cpu)
>              return EXCP_HLT;
>          }
>  
> +        atomic_mb_set(&env->hvf_in_guest, true);
>          hv_return_t r  = hv_vcpu_run(cpu->hvf_fd);
> +        atomic_mb_set(&env->hvf_in_guest, false);


And here you can do instead:

	atomic_set(&env->hvf_in_guest, true);
	/* Read cpu->exit_request after writing env->hvf_in_guest.  */
	smp_mb();
	if (atomic_read(&cpu->exit_request)) {
	    qemu_mutex_lock_iothread();
	    atomic_set(&env->hvf_in_guest, false);
	    return EXCP_INTERRUPT;
	}
	hv_return_t r  = hv_vcpu_run(cpu->hvf_fd);
	atomic_store_release(&env->hvf_in_guest, false);

This matching "write A/smp_mb()/read B" and "write B/smp_mb()/read A" is
a very common idiom for lock-free signaling between threads.

Paolo


