Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C53BC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 15:44:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E867D2395B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 15:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TkRTUaFk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E867D2395B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKkT0-00058h-R3
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 11:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKkPK-0003Lu-Js
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 11:40:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39640)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKkPI-0000kb-5V
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 11:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600789239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2IjsVhHixVorb5yZLVGAwjKoDsijQxFNbUhUKgFsf2k=;
 b=TkRTUaFkABuV+JgeL9llCfVdrTLkV/rPge/Htz9p68F9ztLAog8XDOSD0OWT+5+tJ9l6bp
 2CkrJIOt55c203QBIzawE5mD4dbR9LQxDJVK7K4LmbGZUcWRcBTwjZuupnD3t2XSBg+6Q3
 5wpev3KBkCM/cThZTkfVI6yDdicbJ6s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-gVihcp9CNfGHzVGwBoSznA-1; Tue, 22 Sep 2020 11:40:37 -0400
X-MC-Unique: gVihcp9CNfGHzVGwBoSznA-1
Received: by mail-wm1-f72.google.com with SMTP id m125so1054788wmm.7
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 08:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2IjsVhHixVorb5yZLVGAwjKoDsijQxFNbUhUKgFsf2k=;
 b=nl9e6gNDub2wMTtQfA1I8/fHtlKIjKS3EFK0CA78nkcUcf5LdRQ8WJSZgclbbRSni0
 BvwDwsyW+00+yhSnnHTK5QuCXPybGqU5s7H7n0UobVaemWXEXV2UiKFuO7W5wjf5YToK
 JNk10+F7BjFp53okq+Wh0eT+IL1A7ISKi1WXdP/RzM/izft0KHxITMyVvPOI4AboUX9/
 4EV4Fsi7TuLOc3Ub/Nn0SvFWuoZ41c9eUmxTCI6mqCLjkrHoFhyCEznvy9kra6/a9Ll7
 n72KQXal0+0pylyse5LVM7NTunAfChBMqres4JGbGM1G0ErS0TSHtYlw9mDVTK1uWJmD
 O3SQ==
X-Gm-Message-State: AOAM5305eJbmNgQ4/H1lBHbtr83v8UPyR/yXFc1+RjekTEAwdJcGrvFl
 8rbDkamYlnEcPeWrsEosUIXfejo8Wigrv5WUSmlvK3nDnv41t1Y+qpaVK0rI+rMpLscG9h1NIoe
 /5hXwJevy/LYe4Tg=
X-Received: by 2002:a5d:4a4a:: with SMTP id v10mr6009817wrs.72.1600789235804; 
 Tue, 22 Sep 2020 08:40:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJww3J2Q8NtUrpYhVsmnjdcP6+bOop8IHohZXZUtn1ABYGSgH1eoKI++V4RfknxFKSCZdoeqog==
X-Received: by 2002:a5d:4a4a:: with SMTP id v10mr6009788wrs.72.1600789235464; 
 Tue, 22 Sep 2020 08:40:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec2c:90a9:1236:ebc6?
 ([2001:b07:6468:f312:ec2c:90a9:1236:ebc6])
 by smtp.gmail.com with ESMTPSA id t15sm4811274wmj.15.2020.09.22.08.40.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2020 08:40:34 -0700 (PDT)
Subject: Re: [PATCH v2] target/i386: always create kvmclock device
To: Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
References: <20200922151934.899555-1-vkuznets@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <22f8d2ac-9ffa-3b91-7c97-b2c5a7927de7@redhat.com>
Date: Tue, 22 Sep 2020 17:40:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200922151934.899555-1-vkuznets@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Antoine Damhet <antoine.damhet@blade-group.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/09/20 17:19, Vitaly Kuznetsov wrote:
> QEMU's kvmclock device is only created when KVM PV feature bits for
> kvmclock (KVM_FEATURE_CLOCKSOURCE/KVM_FEATURE_CLOCKSOURCE2) are
> exposed to the guest. With 'kvm=off' cpu flag the device is not
> created and we don't call KVM_GET_CLOCK/KVM_SET_CLOCK upon migration.
> It was reported that without these call at least Hyper-V TSC page
> clocksouce (which can be enabled independently) gets broken after
> migration.
> 
> Switch to creating kvmclock QEMU device unconditionally, it seems
> to always make sense to call KVM_GET_CLOCK/KVM_SET_CLOCK on migration.
> Use KVM_CAP_ADJUST_CLOCK check instead of CPUID feature bits.
> 
> Reported-by: Antoine Damhet <antoine.damhet@blade-group.com>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  hw/i386/kvm/clock.c    | 7 +++++--
>  hw/i386/microvm.c      | 2 +-
>  hw/i386/pc.c           | 1 +
>  hw/i386/pc_piix.c      | 7 +++++--
>  hw/i386/pc_q35.c       | 5 ++++-
>  include/hw/i386/pc.h   | 3 +++
>  include/hw/kvm/clock.h | 4 ++--
>  target/i386/kvm.c      | 5 +++++
>  target/i386/kvm_i386.h | 1 +
>  9 files changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
> index 64283358f91d..30cf53393ee1 100644
> --- a/hw/i386/kvm/clock.c
> +++ b/hw/i386/kvm/clock.c
> @@ -328,11 +328,14 @@ static const TypeInfo kvmclock_info = {
>  };
>  
>  /* Note: Must be called after VCPU initialization. */
> -void kvmclock_create(void)
> +void kvmclock_create(bool create_always)
>  {
>      X86CPU *cpu = X86_CPU(first_cpu);
>  
> -    if (kvm_enabled() &&
> +    if (!kvm_enabled() || !kvm_has_adjust_clock())
> +        return;
> +
> +    if (create_always ||
>          cpu->env.features[FEAT_KVM] & ((1ULL << KVM_FEATURE_CLOCKSOURCE) |
>                                         (1ULL << KVM_FEATURE_CLOCKSOURCE2))) {
>          sysbus_create_simple(TYPE_KVM_CLOCK, -1, NULL);
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index 81d0888930d1..fd0b84109154 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -119,7 +119,7 @@ static void microvm_devices_init(MicrovmMachineState *mms)
>  
>      ioapic_init_gsi(gsi_state, "machine");
>  
> -    kvmclock_create();
> +    kvmclock_create(true);
>  
>      for (i = 0; i < VIRTIO_NUM_TRANSPORTS; i++) {
>          sysbus_create_simple("virtio-mmio",
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index d11daacc23cf..0e036ef9c15f 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1956,6 +1956,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
>      pcmc->acpi_data_size = 0x20000 + 0x8000;
>      pcmc->linuxboot_dma_enabled = true;
>      pcmc->pvh_enabled = true;
> +    pcmc->kvmclock_create_always = true;
>      assert(!mc->get_hotplug_handler);
>      mc->get_hotplug_handler = pc_get_hotplug_handler;
>      mc->hotplug_allowed = pc_hotplug_allowed;
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 32b1453e6a82..1a68338c737b 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -158,8 +158,8 @@ static void pc_init1(MachineState *machine,
>  
>      x86_cpus_init(x86ms, pcmc->default_cpu_version);
>  
> -    if (kvm_enabled() && pcmc->kvmclock_enabled) {
> -        kvmclock_create();
> +    if (pcmc->kvmclock_enabled) {
> +        kvmclock_create(pcmc->kvmclock_create_always);
>      }
>  
>      if (pcmc->pci_enabled) {
> @@ -440,11 +440,14 @@ DEFINE_I440FX_MACHINE(v5_2, "pc-i440fx-5.2", NULL,
>  
>  static void pc_i440fx_5_1_machine_options(MachineClass *m)
>  {
> +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
> +
>      pc_i440fx_5_2_machine_options(m);
>      m->alias = NULL;
>      m->is_default = false;
>      compat_props_add(m->compat_props, hw_compat_5_1, hw_compat_5_1_len);
>      compat_props_add(m->compat_props, pc_compat_5_1, pc_compat_5_1_len);
> +    pcmc->kvmclock_create_always = false;
>  }
>  
>  DEFINE_I440FX_MACHINE(v5_1, "pc-i440fx-5.1", NULL,
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 0cb9c18cd44d..0dd59bd765b1 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -185,7 +185,7 @@ static void pc_q35_init(MachineState *machine)
>  
>      x86_cpus_init(x86ms, pcmc->default_cpu_version);
>  
> -    kvmclock_create();
> +    kvmclock_create(pcmc->kvmclock_create_always);
>  
>      /* pci enabled */
>      if (pcmc->pci_enabled) {
> @@ -366,10 +366,13 @@ DEFINE_Q35_MACHINE(v5_2, "pc-q35-5.2", NULL,
>  
>  static void pc_q35_5_1_machine_options(MachineClass *m)
>  {
> +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
> +
>      pc_q35_5_2_machine_options(m);
>      m->alias = NULL;
>      compat_props_add(m->compat_props, hw_compat_5_1, hw_compat_5_1_len);
>      compat_props_add(m->compat_props, pc_compat_5_1, pc_compat_5_1_len);
> +    pcmc->kvmclock_create_always = false;
>  }
>  
>  DEFINE_Q35_MACHINE(v5_1, "pc-q35-5.1", NULL,
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index fe52e165b27c..6b22671434b9 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -118,6 +118,9 @@ typedef struct PCMachineClass {
>  
>      /* use PVH to load kernels that support this feature */
>      bool pvh_enabled;
> +
> +    /* create kvmclock device even when KVM PV features are not exposed */
> +    bool kvmclock_create_always;
>  } PCMachineClass;
>  
>  #define TYPE_PC_MACHINE "generic-pc-machine"
> diff --git a/include/hw/kvm/clock.h b/include/hw/kvm/clock.h
> index 81c66b230207..7994071c4fee 100644
> --- a/include/hw/kvm/clock.h
> +++ b/include/hw/kvm/clock.h
> @@ -15,11 +15,11 @@
>  
>  #ifdef CONFIG_KVM
>  
> -void kvmclock_create(void);
> +void kvmclock_create(bool create_always);
>  
>  #else /* CONFIG_KVM */
>  
> -static inline void kvmclock_create(void)
> +static inline void kvmclock_create(bool create_always)
>  {
>  }
>  
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 4a8b3a41c1bc..20b31b65307b 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -143,6 +143,11 @@ bool kvm_has_adjust_clock_stable(void)
>      return (ret == KVM_CLOCK_TSC_STABLE);
>  }
>  
> +bool kvm_has_adjust_clock(void)
> +{
> +    return kvm_check_extension(kvm_state, KVM_CAP_ADJUST_CLOCK);
> +}
> +
>  bool kvm_has_exception_payload(void)
>  {
>      return has_exception_payload;
> diff --git a/target/i386/kvm_i386.h b/target/i386/kvm_i386.h
> index 064b8798a26c..0fce4e51d2d6 100644
> --- a/target/i386/kvm_i386.h
> +++ b/target/i386/kvm_i386.h
> @@ -34,6 +34,7 @@
>  
>  bool kvm_allows_irq0_override(void);
>  bool kvm_has_smm(void);
> +bool kvm_has_adjust_clock(void);
>  bool kvm_has_adjust_clock_stable(void);
>  bool kvm_has_exception_payload(void);
>  void kvm_synchronize_all_tsc(void);
> 

This was added in 2.6.33, I think we can assume it to be there.  But
feel free to do it on top of this patch.

Paolo


