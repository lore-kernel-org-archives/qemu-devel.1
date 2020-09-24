Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CCCC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:07:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B48042137B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJSgAIbq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B48042137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLWa9-0003T8-Lc
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLWV1-0007wF-2j
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:01:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47755)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLWUy-0003W2-4L
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600974102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gqLmGCuTZuXJgKV8uPFxnv3RXWmllnwQRQkuGgvWA5I=;
 b=XJSgAIbqEshrGDFVLBZvuqsITaRvtRM2ZBpdBh9WID3JPepXjhI/dxbAxEAgMumgNH7S5r
 EZmSmibE7ttyKLrBqUIPlA2j0X3Z25pmJOBtwYlN3uKajOo9hMqHMEDSDXyYHVTx7redil
 bypi22VKEFuf3dkQ7E5q/rLLUX1XDl8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-rF0EAbeuOVerztevM4SXJg-1; Thu, 24 Sep 2020 15:01:40 -0400
X-MC-Unique: rF0EAbeuOVerztevM4SXJg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A63A188C125;
 Thu, 24 Sep 2020 19:01:39 +0000 (UTC)
Received: from work-vm (ovpn-114-250.ams2.redhat.com [10.36.114.250])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 67AF273692;
 Thu, 24 Sep 2020 19:01:37 +0000 (UTC)
Date: Thu, 24 Sep 2020 20:01:34 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v2] target/i386: always create kvmclock device
Message-ID: <20200924190134.GL2792@work-vm>
References: <20200922151934.899555-1-vkuznets@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922151934.899555-1-vkuznets@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Antoine Damhet <antoine.damhet@blade-group.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Vitaly Kuznetsov (vkuznets@redhat.com) wrote:
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

Thanks; yes that should keep backwards migration happy.

Dave

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
> -- 
> 2.25.4
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


