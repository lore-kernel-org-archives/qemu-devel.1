Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77ACC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:29:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 718FB20679
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V11rcr9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718FB20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joP84-0005dv-Oa
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 06:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1joP7S-0005Cl-Ao
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:28:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20866
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1joP7Q-0007hV-Aq
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593080911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A1c2PWr3VkUwFsbxg69UEWJu/cPfoEl9kM+hbFlkrNM=;
 b=V11rcr9dogst6oeq6IQv9zMfrtlBMQPJz75NERUXmvj/2Ylxrvqa+Sw3O/GotILelxRWVD
 r6iEOvuAVNFoEJPo/BN0G0odr1SOH9iqkZ9wQlBx0RxTDLSm4C70BKsD//AfnJvrtCtOfq
 3FuD54a4HCwJq2PNb0Ls241YOzcPOnQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-5YrCWVFqMmGNfhtweBgUwg-1; Thu, 25 Jun 2020 06:28:29 -0400
X-MC-Unique: 5YrCWVFqMmGNfhtweBgUwg-1
Received: by mail-wr1-f71.google.com with SMTP id d6so6517014wrn.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 03:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A1c2PWr3VkUwFsbxg69UEWJu/cPfoEl9kM+hbFlkrNM=;
 b=N8wWrHNXhqPny8h3ahv96e2A2khBcgKtQ8CdQBE1p26OcdLCSdt/RzPWMwXoDgx/Ne
 jKLCsDGL61WrG7751uB+y8jGADpY2nryANF4ncg7qSrgGaQ9Zi6OnHRJL8tdF++Aspvq
 K3J+J63jkvIt1s7359QPFOQzrmZkNQ8w1ef+6/bc6YrAQ1H5AWeAUKeCxKpi5vVHcthx
 UQudYWtdJWbl4NNb0x5oP6bD2giA70H1sQKoU1djK/tO59RPkRy3djaBnLUqe3/2aAni
 8IKtElUa2g2kOiKxEHvTxVNWg9EMomMNkOXHXjgHDipAG+9RkWFUn/mmiykfQG+94ZdO
 sdvw==
X-Gm-Message-State: AOAM533L0UiEB2donWytnBwDLAak9cRxoyEYIGNj8FpGSAvcoe8zp/xm
 4IA8NoxBdNtEsdfRjF90AeimVYQ6pvhUXDjuXe0BPqbWGbASI59aYy5rHBmirPVzfLFiKrziAqM
 zN1Xat90w2j9F21w=
X-Received: by 2002:adf:dd4a:: with SMTP id u10mr15947757wrm.169.1593080908415; 
 Thu, 25 Jun 2020 03:28:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKvjk6RJUy632umy+w3J0Y0YwHXWhl5ev82hr4Tqbw/+HrJEDXtzn+A7AMFlK1A8EWxNFGxQ==
X-Received: by 2002:adf:dd4a:: with SMTP id u10mr15947730wrm.169.1593080908157; 
 Thu, 25 Jun 2020 03:28:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:91d0:a5f0:9f34:4d80?
 ([2001:b07:6468:f312:91d0:a5f0:9f34:4d80])
 by smtp.gmail.com with ESMTPSA id u186sm12175114wmu.10.2020.06.25.03.28.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 03:28:27 -0700 (PDT)
Subject: Re: [PATCH 4/8] i386: hvf: Implement CPU kick
To: Roman Bolshakov <r.bolshakov@yadro.com>, qemu-devel@nongnu.org
References: <20200624225850.16982-1-r.bolshakov@yadro.com>
 <20200624225850.16982-5-r.bolshakov@yadro.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9d63db4e-25a7-9c77-6f05-e5f808b8b33c@redhat.com>
Date: Thu, 25 Jun 2020 12:28:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200624225850.16982-5-r.bolshakov@yadro.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 02:30:11
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

On 25/06/20 00:58, Roman Bolshakov wrote:
> HVF doesn't have a CPU kick and without it it's not possible to perform
> an action on CPU thread until a VMEXIT happens. The kick is also needed
> for timely interrupt delivery.
> 
> Existing implementation of CPU kick sends SIG_IPI (aka SIGUSR1) to vCPU
> thread, but it's different from what hv_vcpu_interrupt does. The latter
> one results in invocation of mp_cpus_kick() in XNU kernel [1].
> 
> While at it, correct type of hvf_fd to the type of hv_vcpuid_t to avoid
> compilation warnings.
> 
> 1. https://opensource.apple.com/source/xnu/xnu-6153.81.5/osfmk/i386/mp.c
> 
> Cc: Cameron Esfahani <dirty@apple.com>
> Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> ---
>  cpus.c                | 13 +++++++++----
>  include/hw/core/cpu.h |  2 +-
>  include/sysemu/hvf.h  |  1 +
>  target/i386/hvf/hvf.c | 11 +++++++++++
>  4 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/cpus.c b/cpus.c
> index 26709677d3..36f38ce5c8 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1783,10 +1783,15 @@ static void qemu_cpu_kick_thread(CPUState *cpu)
>          return;
>      }
>      cpu->thread_kicked = true;
> -    err = pthread_kill(cpu->thread->thread, SIG_IPI);
> -    if (err && err != ESRCH) {
> -        fprintf(stderr, "qemu:%s: %s", __func__, strerror(err));
> -        exit(1);
> +
> +    if (hvf_enabled()) {
> +        hvf_vcpu_kick(cpu);
> +    } else {
> +        err = pthread_kill(cpu->thread->thread, SIG_IPI);
> +        if (err && err != ESRCH) {
> +            fprintf(stderr, "qemu:%s: %s", __func__, strerror(err));
> +            exit(1);
> +        }
>      }
>  #else /* _WIN32 */
>      if (!qemu_cpu_is_self(cpu)) {
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index b3f4b79318..288a2bd57e 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -438,7 +438,7 @@ struct CPUState {
>  
>      struct hax_vcpu_state *hax_vcpu;
>  
> -    int hvf_fd;
> +    unsigned hvf_fd;
>  
>      /* track IOMMUs whose translations we've cached in the TCG TLB */
>      GArray *iommu_notifiers;
> diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
> index 1d40a8ec01..aaa00cbf05 100644
> --- a/include/sysemu/hvf.h
> +++ b/include/sysemu/hvf.h
> @@ -25,6 +25,7 @@ extern bool hvf_allowed;
>  
>  int hvf_init_vcpu(CPUState *);
>  int hvf_vcpu_exec(CPUState *);
> +void hvf_vcpu_kick(CPUState *);
>  void hvf_cpu_synchronize_state(CPUState *);
>  void hvf_cpu_synchronize_post_reset(CPUState *);
>  void hvf_cpu_synchronize_post_init(CPUState *);
> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> index efe9802962..4d254a477a 100644
> --- a/target/i386/hvf/hvf.c
> +++ b/target/i386/hvf/hvf.c
> @@ -966,6 +966,17 @@ int hvf_vcpu_exec(CPUState *cpu)
>      return ret;
>  }
>  
> +void hvf_vcpu_kick(CPUState *cpu)
> +{
> +    hv_return_t err;
> +
> +    err = hv_vcpu_interrupt(&cpu->hvf_fd, 1);
> +    if (err) {
> +        fprintf(stderr, "qemu:%s error %#x\n", __func__, err);
> +        exit(1);
> +    }
> +}
> +
>  bool hvf_allowed;
>  
>  static int hvf_accel_init(MachineState *ms)
> 

The documentation isn't clear on whether hv_vcpu_interrupt is able to
interrupt a *subsequent* hv_vcpu_run, similar to WHPX
WHvCancelRunVirtualProcessor (is it possible to decompile
hv_vcpu_interrupt and see what it does?).  If not, you can reduce a bit
the race window by setting a variable in cpu, like

	atomic_set(&cpu->deadline, 0);
	hv_vcpu_interrupt(...)

and in the vCPU thread

	hv_vcpu_run_until(..., atomic_read(&cpu->deadline));
	atomic_set(&cpu->deadline, HV_DEADLINE_FOREVER);

Paolo


