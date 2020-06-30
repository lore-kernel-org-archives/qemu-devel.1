Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5B1C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 12:38:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D2942073E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 12:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cx7HYaR5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D2942073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqFWT-0006Qa-Fb
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 08:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqFSS-00005y-BF
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 08:33:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22348
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqFSQ-0004Af-Lr
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 08:33:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593520428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GxySVg17QxVsCAX2jHPs4jI3V5adW/FHNLz9nV4ubTQ=;
 b=cx7HYaR5saR64FSHrdAbfjympjrEgLp++u5ZKvSs4fVna9vtpZwD7tVrNghrhMRSlUU2pp
 bM/p3dhECL5MAHEW3NylcJ7V1WGDZcqy2sGqFGf1L/OVpjjtL+WgiNMf3kvz40Kcapq3KA
 NAmvchNRsdPg3bfzYNCsJwO31SMmV9Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-X7JGm7bwMYuf7_WWZ72XZA-1; Tue, 30 Jun 2020 08:33:46 -0400
X-MC-Unique: X7JGm7bwMYuf7_WWZ72XZA-1
Received: by mail-wm1-f72.google.com with SMTP id s134so20767175wme.6
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 05:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GxySVg17QxVsCAX2jHPs4jI3V5adW/FHNLz9nV4ubTQ=;
 b=JsDcpUmbEt0ywEylhVWCqiLn1BncwjkJE4OBCwKl+r7jC0A/I6eGyuZufy+M2a0Rq1
 n/L46tYLg2GkZ6TIPovNkoodCF8BVilX/k2cpnCNTwxUKLX19PeVtSdD9D56qAxfWrO0
 WExs8gRFM9MfA84/llxKLVfLoTNVPPajmMyit4rj4wEmGghQYerAzioI29ZgvF8bsEnA
 dxqW2QzIc0B6XlrYP9kg9C/d/ApmV5UyWGah+gFcGpcULmGGZF0glPUpOHfQmtWxIyEB
 k2oLm6COU+D0IWh3oi/CFnQtQVmUjD8BJMl+eklMKGMokEqtzNA05eRo/xmj8XUwr31N
 SdHQ==
X-Gm-Message-State: AOAM533Verqs/QQEpRbMIo+M8hD4PznuxIMrkkpBAEr50s2dzw6Ty4Sc
 EpYsoiSvl+nOip/U9xROUpfKQRwAFkQK9Ue6SARhF5h4j9Ur22oBjZbogzpxKi8pKFzeJkemzAX
 06VALZFp/zZOXrqk=
X-Received: by 2002:a5d:504b:: with SMTP id h11mr21218868wrt.160.1593520424438; 
 Tue, 30 Jun 2020 05:33:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvz9jtL/aDK72Vo5NRs/bosAfzIV1iXr6gYv43gO2aPaX+2h+CVP2M+Sbx6ZAZga3g6EFbMw==
X-Received: by 2002:a5d:504b:: with SMTP id h11mr21218855wrt.160.1593520424202; 
 Tue, 30 Jun 2020 05:33:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b0e5:c632:a580:8b9a?
 ([2001:b07:6468:f312:b0e5:c632:a580:8b9a])
 by smtp.gmail.com with ESMTPSA id y7sm3509416wrt.11.2020.06.30.05.33.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 05:33:43 -0700 (PDT)
Subject: Re: [PATCH v2 4/9] i386: hvf: Implement CPU kick
To: Roman Bolshakov <r.bolshakov@yadro.com>, qemu-devel@nongnu.org
References: <20200630102824.77604-1-r.bolshakov@yadro.com>
 <20200630102824.77604-5-r.bolshakov@yadro.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d75c6bd1-b588-796b-e238-21ff41fce60d@redhat.com>
Date: Tue, 30 Jun 2020 14:33:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200630102824.77604-5-r.bolshakov@yadro.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 01:11:03
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

On 30/06/20 12:28, Roman Bolshakov wrote:
> @@ -966,6 +964,20 @@ int hvf_vcpu_exec(CPUState *cpu)
>      return ret;
>  }
>  
> +void hvf_vcpu_kick(CPUState *cpu)
> +{
> +    X86CPU *x86_cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86_cpu->env;
> +    hv_return_t err;
> +
> +    atomic_set(&env->hvf_deadline, 0);
> +    err = hv_vcpu_interrupt(&cpu->hvf_fd, 1);
> +    if (err) {
> +        fprintf(stderr, "qemu:%s error %#x\n", __func__, err);
> +        exit(1);
> +    }

Can a signal interrupt hv_vcpu_run?  If so you actually don't need
hv_vcpu_interrupt at all.  You can also require the preemption time, all
processor that support HVF have it, but never set it by default.  The
deadline can be left at 0 all the time; instead, you toggle the bit in
the pin-based controls.  In the signal handler you do:

	if (atomic_xchg(&env->hvf_in_guest, false)) {
		wvmcs(cpu->hvf_fd, VMCS_PIN_BASED_CTLS,
		      rvmcs(cpu->hvf_fd, VMCS_PIN_BASED_CTLS)
			| VMCS_PIN_BASED_CTLS_VMX_PREEMPT_TIMER);
	}

In the main loop you do:

	atomic_set(&env->hvf_guest_mode, true);
	smp_mb();
	hv_vcpu_run(...);
	atomic_set(&env->hvf_guest_mode, false);

and in the preemption timer vmexit handler:
	
		wvmcs(cpu->hvf_fd, VMCS_PIN_BASED_CTLS,
		      rvmcs(cpu->hvf_fd, VMCS_PIN_BASED_CTLS)
			& ~VMCS_PIN_BASED_CTLS_VMX_PREEMPT_TIMER);

I'll leave out this patch in the meanwhile.

Paolo

> +}
> +
>  bool hvf_allowed;
>  
>  static int hvf_accel_init(MachineState *ms)
> diff --git a/target/i386/hvf/vmcs.h b/target/i386/hvf/vmcs.h
> index 42de7ebc3a..6615365023 100644
> --- a/target/i386/hvf/vmcs.h
> +++ b/target/i386/hvf/vmcs.h
> @@ -349,6 +349,7 @@
>  #define VMCS_PIN_BASED_CTLS_EXTINT            (1 << 0)
>  #define VMCS_PIN_BASED_CTLS_NMI               (1 << 3)
>  #define VMCS_PIN_BASED_CTLS_VNMI              (1 << 5)
> +#define VMCS_PIN_BASED_CTLS_VMX_PREEMPT_TIMER (1 << 6)
>  
>  #define VMCS_PRI_PROC_BASED_CTLS_INT_WINDOW_EXITING (1 << 2)
>  #define VMCS_PRI_PROC_BASED_CTLS_TSC_OFFSET (1 << 3)
> 


