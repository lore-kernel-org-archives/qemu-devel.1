Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31945C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:45:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E932520780
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZqtOTVjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E932520780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDlM-0006Ot-7x
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqDk6-0005IH-V9
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:43:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25767
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqDk5-0003CO-0c
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593513835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hot+mluM3cHtIHPQHJrUiwN+uYq9MdnBip/MVUQSNFA=;
 b=ZqtOTVjyaofVVODK+o7whnvGzH7cdnhfjLJvclpIdUEDBCji/QSwHZCrMK3Z5qVuF0L9Qo
 OAsIQA8zkN39SE5N8EvF6igspNs4XVyUxuJwWuOERD+eS0z0JUa6SwDTutpFatqc45NjrH
 aoTlrSOkL5vWaDTCnSbhhRiWrb1bDwc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-sG7g712oNnC80xYngCiQaQ-1; Tue, 30 Jun 2020 06:43:53 -0400
X-MC-Unique: sG7g712oNnC80xYngCiQaQ-1
Received: by mail-wr1-f72.google.com with SMTP id p9so18571794wrx.10
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 03:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hot+mluM3cHtIHPQHJrUiwN+uYq9MdnBip/MVUQSNFA=;
 b=VZ7SwM8Vt5MlHa+kO5KLOEEr44Dz71fDSBoJ1/miL9lFz4OG4AyxZcu5En54reBmLZ
 px3V6bISJnDZ5/r70rPjukYMdonyxeNrf4CNkbS3mudEmeIQ/Q7M6nr/F1fZHc83V2W2
 3Diav2eF4sZ2K0cE/6Az4H/FLg7SftCoKsITHXOjxzZrVTFsObhppRRqlKLMYVaMRcru
 Wb9201twXXuJmULGgteymH8lttgz4CQ6b7d3Dy7CU5Y4WqMM8alymN6mPmZ94dsTagb8
 wWk3MiTFHtz203+Qcs20eGiWeJ1ZLuUDk0s72H6KlILvuJebNP5Mve5rl7xzz+kAUqQ8
 JGhA==
X-Gm-Message-State: AOAM530fvsLZC+TF4jGlbFJb5dVkVROQr7Cga78bZWQJ4rWxrN1VrMby
 wdZLiwRfdMMJR48oViNses/CAWMYXYV0XdQzOzC/pj4j2WLMGH2KGxvYlnW79+Fi/JJOwwgGNAP
 PyBWvNqI8aYwgOpQ=
X-Received: by 2002:a1c:9e4c:: with SMTP id h73mr11677770wme.177.1593513831863; 
 Tue, 30 Jun 2020 03:43:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxB74NJWQi3+3JVB1awb3TlReSwbr1f1KuciaxmqEHp/yuuU13sVwB1ImQy+wchhA8Zw4DABw==
X-Received: by 2002:a1c:9e4c:: with SMTP id h73mr11677749wme.177.1593513831596; 
 Tue, 30 Jun 2020 03:43:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:acad:d1d4:42b8:23e4?
 ([2001:b07:6468:f312:acad:d1d4:42b8:23e4])
 by smtp.gmail.com with ESMTPSA id p13sm3368611wrn.0.2020.06.30.03.43.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 03:43:50 -0700 (PDT)
Subject: Re: [PATCH 4/8] i386: hvf: Implement CPU kick
To: Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200624225850.16982-5-r.bolshakov@yadro.com>
 <9d63db4e-25a7-9c77-6f05-e5f808b8b33c@redhat.com>
 <20200625155712.GI25104@SPB-NB-133.local>
 <6508d40b-0142-1b42-2f48-fcd2da66ea4b@redhat.com>
 <20200629113107.GL25104@SPB-NB-133.local>
 <d1d7cf19-d56c-c095-a3b8-45e2be0752ea@redhat.com>
 <20200629132911.GN25104@SPB-NB-133.local>
 <0c8d14fa-e2cf-00e7-135f-d88fda38f31d@redhat.com>
 <20200629140433.GO25104@SPB-NB-133.local>
 <cb4a42b2-5bb7-5f69-64d1-cad6f4bb05df@redhat.com>
 <20200630101228.GA39334@SPB-NB-133.local>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0549a18b-aedf-d88f-1765-65e333ee2e00@redhat.com>
Date: Tue, 30 Jun 2020 12:43:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200630101228.GA39334@SPB-NB-133.local>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 03:55:26
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
Cc: Claudio Fontana <cfontana@suse.de>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ok, I'll review the patch to see what you've implemented.  Thanks!

Paolo

On 30/06/20 12:12, Roman Bolshakov wrote:
> On Mon, Jun 29, 2020 at 04:18:46PM +0200, Paolo Bonzini wrote:
>> On 29/06/20 16:04, Roman Bolshakov wrote:
>>> My approach is based
>>> hv_vcpu_run() and should hopefully work almost anywhere where
>>> Hypervisor.framework is available because Hypervisor framework exposes
>>> timer value
>>> (https://developer.apple.com/documentation/hypervisor/vmcs_guest_vmx_timer_value)
>>> since macOS 10.10.3+.
>>
>> There are a few other constants for which it would be unwise to write
>> from userspace, so that's not a big consolation. :)
>>
> 
> Hi Paolo,
> 
> So, I've tried Big Sur Beta and it has exactly the same performance
> issue with hv_vcpu_run_until() while hv_vcpu_run() works as good as it
> worked on 10.15.5. I've submitted FB7827341 to Apple wrt the issue.
> 
>>> I can also test how hv_vcpu_run_until() performs with HV_DEADLINE_FOREVER
>>> on the Beta. And if the performance issues with VMX-preemption timer and
>>> hv_vcpu_run_until() are fixed there.
>>
>> Thanks!  The main thing to test on Big Sur would be: 1) whether the
>> preemption timer bit in the pin controls "sticks" to 0 after setting it
> 
> It does not. If it's set, it stays there.
> 
>> 2) whether the bit reads back as zero after
>> hv_vcpu_run_until(HV_DEADLINE_FOREVER).
>>
> 
> Likewise, it's not cleared if set.
> 
> As far as I understand, hv_vcpu_run_until(HV_DEADLINE_FOREVER) works
> like hv_vcpu_run() without VMX-preemption timer. Otherwise
> hv_vcpu_run_until() implicitly sets VMX-preemption timer Pin-based
> control and sets the timer value.
> 
> Thanks,
> Roman
> 
> Here's the patch over v2 that adds support of hv_vcpu_run_until() on Big Sur:
> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> index 317304aa1d..ad202f7358 100644
> --- a/target/i386/hvf/hvf.c
> +++ b/target/i386/hvf/hvf.c
> @@ -72,8 +72,12 @@
>  #include "sysemu/accel.h"
>  #include "target/i386/cpu.h"
>  
> +#if defined(__MAC_10_16) && __MAC_OS_X_VERSION_MIN_REQUIRED >= __MAC_10_16
> +#define HVF_MAX_DEADLINE HV_DEADLINE_FOREVER
> +#else
>  /* Maximum value of VMX-preemption timer */
>  #define HVF_MAX_DEADLINE UINT32_MAX
> +#endif
>  
>  HVFState *hvf_state;
>  
> @@ -693,6 +697,7 @@ int hvf_vcpu_exec(CPUState *cpu)
>      CPUX86State *env = &x86_cpu->env;
>      int ret = 0;
>      uint64_t rip = 0;
> +    hv_return_t r;
>  
>      if (hvf_process_events(cpu)) {
>          return EXCP_HLT;
> @@ -718,10 +723,22 @@ int hvf_vcpu_exec(CPUState *cpu)
>          /* Use VMX-preemption timer trick only if available */
>          if (rvmcs(cpu->hvf_fd, VMCS_PIN_BASED_CTLS) &
>              VMCS_PIN_BASED_CTLS_VMX_PREEMPT_TIMER) {
> +#if defined(__MAC_10_16) && __MAC_OS_X_VERSION_MIN_REQUIRED >= __MAC_10_16
> +            r = hv_vcpu_run_until(cpu->hvf_fd,
> +                                  atomic_read(&env->hvf_deadline));
> +        } else {
> +            /*
> +             * Equivalent to behaviour of hv_vcpu_run() with VMX-preemption
> +             * timer disabled, prone to kick loss.
> +             */
> +            r = hv_vcpu_run_until(cpu->hvf_fd, HVF_MAX_DEADLINE);
> +        }
> +#else
>              wvmcs(cpu->hvf_fd, VMCS_PREEMPTION_TIMER_VALUE,
>                    atomic_read(&env->hvf_deadline));
>          }
> -        hv_return_t r  = hv_vcpu_run(cpu->hvf_fd);
> +        r = hv_vcpu_run(cpu->hvf_fd);
> +#endif
>          atomic_set(&env->hvf_deadline, HVF_MAX_DEADLINE);
>          assert_hvf_ok(r);
>  
> 


