Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA9EC2BBD1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:47:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1B5421D7B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RMfY/5wb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1B5421D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIx4c-00084h-UM
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 12:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kIx3f-0007Az-UX
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:46:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51129
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kIx3d-0003TO-E9
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600361211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MVBdWjTL0qbbnnHx4Pq910SY+VQTNVPxgmO0+InTW3g=;
 b=RMfY/5wb3Wus66VLJ3vuYzKc97dOiMIRIahX3QLZZPqaHyb/DY4cBiUGNgQ3EKIigo+9/f
 2/D9MeZTA8AZfi5IZDoh9grTiJCVPal/OyIQnf44d09ormrs9G/Q5EQ5x67uLSSfCvXvEn
 8v+reYl1vvp7LBk5rPRghx9/7zWBMcQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-a-6vknJcOmmUSmp6HQvp-A-1; Thu, 17 Sep 2020 12:46:45 -0400
X-MC-Unique: a-6vknJcOmmUSmp6HQvp-A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC5B81091066;
 Thu, 17 Sep 2020 16:46:43 +0000 (UTC)
Received: from work-vm (ovpn-114-108.ams2.redhat.com [10.36.114.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5997260BEC;
 Thu, 17 Sep 2020 16:46:37 +0000 (UTC)
Date: Thu, 17 Sep 2020 17:46:35 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 3/5] sev/i386: Allow AP booting under SEV-ES
Message-ID: <20200917164635.GQ2793@work-vm>
References: <cover.1600205384.git.thomas.lendacky@amd.com>
 <9d964b7575471f45c522eea9ea3a7d84ed4d7d2b.1600205384.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d964b7575471f45c522eea9ea3a7d84ed4d7d2b.1600205384.git.thomas.lendacky@amd.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 08:56:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Brijesh Singh <brijesh.singh@amd.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Connor Kuehl <ckuehl@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Jiri Slaby <jslaby@suse.cz>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Tom Lendacky (thomas.lendacky@amd.com) wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> When SEV-ES is enabled, it is not possible modify the guests register
> state after it has been initially created, encrypted and measured.
> 
> Normally, an INIT-SIPI-SIPI request is used to boot the AP. However, the
> hypervisor cannot emulate this because it cannot update the AP register
> state. For the very first boot by an AP, the reset vector CS segment
> value and the EIP value must be programmed before the register has been
> encrypted and measured.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  accel/kvm/kvm-all.c    | 64 ++++++++++++++++++++++++++++++++++++++++++
>  accel/stubs/kvm-stub.c |  5 ++++
>  hw/i386/pc_sysfw.c     | 10 ++++++-
>  include/sysemu/kvm.h   | 16 +++++++++++
>  include/sysemu/sev.h   |  3 ++
>  target/i386/kvm.c      |  2 ++
>  target/i386/sev.c      | 51 +++++++++++++++++++++++++++++++++
>  7 files changed, 150 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 63ef6af9a1..20725b0368 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -39,6 +39,7 @@
>  #include "qemu/main-loop.h"
>  #include "trace.h"
>  #include "hw/irq.h"
> +#include "sysemu/kvm.h"
>  #include "sysemu/sev.h"
>  #include "qapi/visitor.h"
>  #include "qapi/qapi-types-common.h"
> @@ -120,6 +121,12 @@ struct KVMState
>      /* memory encryption */
>      void *memcrypt_handle;
>      int (*memcrypt_encrypt_data)(void *handle, uint8_t *ptr, uint64_t len);
> +    int (*memcrypt_save_reset_vector)(void *handle, void *flash_ptr,
> +                                      uint64_t flash_size, uint32_t *addr);
> +
> +    unsigned int reset_cs;
> +    unsigned int reset_ip;

uint32_t's ?

> +    bool reset_valid;
>  
>      /* For "info mtree -f" to tell if an MR is registered in KVM */
>      int nr_as;
> @@ -239,6 +246,62 @@ int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len)
>      return 1;
>  }
>  
> +void kvm_memcrypt_set_reset_vector(CPUState *cpu)
> +{
> +    X86CPU *x86;
> +    CPUX86State *env;
> +
> +    /* Only update if we have valid reset information */
> +    if (!kvm_state->reset_valid) {
> +        return;
> +    }
> +
> +    /* Do not update the BSP reset state */
> +    if (cpu->cpu_index == 0) {
> +        return;
> +    }
> +
> +    x86 = X86_CPU(cpu);
> +    env = &x86->env;
> +
> +    cpu_x86_load_seg_cache(env, R_CS, 0xf000, kvm_state->reset_cs, 0xffff,
> +                           DESC_P_MASK | DESC_S_MASK | DESC_CS_MASK |
> +                           DESC_R_MASK | DESC_A_MASK);
> +
> +    env->eip = kvm_state->reset_ip;
> +}
> +
> +int kvm_memcrypt_save_reset_vector(void *flash_ptr, uint64_t flash_size)
> +{
> +    CPUState *cpu;
> +    uint32_t addr;
> +    int ret;
> +
> +    if (kvm_memcrypt_enabled() &&
> +        kvm_state->memcrypt_save_reset_vector) {
> +
> +        addr = 0;
> +        ret = kvm_state->memcrypt_save_reset_vector(kvm_state->memcrypt_handle,
> +                                                    flash_ptr, flash_size,
> +                                                    &addr);
> +        if (ret) {
> +            return ret;
> +        }
> +
> +        if (addr) {
> +            kvm_state->reset_cs = addr & 0xffff0000;
> +            kvm_state->reset_ip = addr & 0x0000ffff;
> +            kvm_state->reset_valid = true;
> +
> +            CPU_FOREACH(cpu) {
> +                kvm_memcrypt_set_reset_vector(cpu);
> +            }
> +        }
> +    }
> +
> +    return 0;
> +}
> +
>  /* Called with KVMMemoryListener.slots_lock held */
>  static KVMSlot *kvm_get_free_slot(KVMMemoryListener *kml)
>  {
> @@ -2193,6 +2256,7 @@ static int kvm_init(MachineState *ms)
>          }
>  
>          kvm_state->memcrypt_encrypt_data = sev_encrypt_data;
> +        kvm_state->memcrypt_save_reset_vector = sev_es_save_reset_vector;
>      }
>  
>      ret = kvm_arch_init(ms, s);
> diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
> index 82f118d2df..3aece9b513 100644
> --- a/accel/stubs/kvm-stub.c
> +++ b/accel/stubs/kvm-stub.c
> @@ -114,6 +114,11 @@ int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len)
>    return 1;
>  }
>  
> +int kvm_memcrypt_save_reset_vector(void *flash_ptr, uint64_t flash_size)
> +{
> +    return -ENOSYS;
> +}
> +
>  #ifndef CONFIG_USER_ONLY
>  int kvm_irqchip_add_msi_route(KVMState *s, int vector, PCIDevice *dev)
>  {
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index b6c0822fe3..321ff94261 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -156,7 +156,8 @@ static void pc_system_flash_map(PCMachineState *pcms,
>      PFlashCFI01 *system_flash;
>      MemoryRegion *flash_mem;
>      void *flash_ptr;
> -    int ret, flash_size;
> +    uint64_t flash_size;
> +    int ret;
>  
>      assert(PC_MACHINE_GET_CLASS(pcms)->pci_enabled);
>  
> @@ -204,6 +205,13 @@ static void pc_system_flash_map(PCMachineState *pcms,
>              if (kvm_memcrypt_enabled()) {
>                  flash_ptr = memory_region_get_ram_ptr(flash_mem);
>                  flash_size = memory_region_size(flash_mem);
> +
> +                ret = kvm_memcrypt_save_reset_vector(flash_ptr, flash_size);
> +                if (ret) {
> +                    error_report("failed to locate and/or save reset vector");
> +                    exit(1);
> +                }
> +
>                  ret = kvm_memcrypt_encrypt_data(flash_ptr, flash_size);
>                  if (ret) {
>                      error_report("failed to encrypt pflash rom");
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index b4174d941c..f74cfa85ab 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -247,6 +247,22 @@ bool kvm_memcrypt_enabled(void);
>   */
>  int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len);
>  
> +/**
> + * kvm_memcrypt_set_reset_vector - sets the CS/IP value for the AP if SEV-ES
> + *                                 is active.
> + */
> +void kvm_memcrypt_set_reset_vector(CPUState *cpu);
> +
> +/**
> + * kvm_memcrypt_save_reset_vector - locates and saves the reset vector to be
> + *                                  used as the initial CS/IP value for APs
> + *                                  if SEV-ES is active.
> + *
> + * Return: 1 SEV-ES is active and failed to locate a valid reset vector
> + *         0 SEV-ES is not active or successfully located and saved the
> + *           reset vector address
> + */
> +int kvm_memcrypt_save_reset_vector(void *flash_prt, uint64_t flash_size);
>  
>  #ifdef NEED_CPU_H
>  #include "cpu.h"
> diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
> index 98c1ec8d38..5198e5a621 100644
> --- a/include/sysemu/sev.h
> +++ b/include/sysemu/sev.h
> @@ -18,4 +18,7 @@
>  
>  void *sev_guest_init(const char *id);
>  int sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len);
> +int sev_es_save_reset_vector(void *handle, void *flash_ptr,
> +                             uint64_t flash_size, uint32_t *addr);
> +
>  #endif
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 6f18d940a5..10eaba8943 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1912,6 +1912,8 @@ void kvm_arch_reset_vcpu(X86CPU *cpu)
>      }
>      /* enabled by default */
>      env->poll_control_msr = 1;
> +
> +    kvm_memcrypt_set_reset_vector(CPU(cpu));
>  }
>  
>  void kvm_arch_do_init_vcpu(X86CPU *cpu)
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 5055b1fe00..6ddefc65fa 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -70,6 +70,19 @@ struct SevGuestState {
>  #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
>  #define DEFAULT_SEV_DEVICE      "/dev/sev"
>  
> +/* SEV Information Block GUID = 00f771de-1a7e-4fcb-890e-68c77e2fb44e */
> +#define SEV_INFO_BLOCK_GUID \
> +    "\xde\x71\xf7\x00\x7e\x1a\xcb\x4f\x89\x0e\x68\xc7\x7e\x2f\xb4\x4e"
> +
> +typedef struct __attribute__((__packed__)) SevInfoBlock {
> +    /* SEV-ES Reset Vector Address */
> +    uint32_t reset_addr;
> +
> +    /* SEV Information Block size and GUID */
> +    uint16_t size;
> +    char guid[16];
> +} SevInfoBlock;
> +

Is that all signed off and happy from the OVMF guys?

>  static SevGuestState *sev_guest;
>  static Error *sev_mig_blocker;
>  
> @@ -833,6 +846,44 @@ sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len)
>      return 0;
>  }
>  
> +int
> +sev_es_save_reset_vector(void *handle, void *flash_ptr, uint64_t flash_size,
> +                         uint32_t *addr)
> +{
> +    SevInfoBlock *info;
> +
> +    assert(handle);
> +
> +    /*
> +     * Initialize the address to zero. An address of zero with a successful
> +     * return code indicates that SEV-ES is not active.
> +     */
> +    *addr = 0;
> +    if (!sev_es_enabled()) {
> +        return 0;
> +    }
> +
> +    /*
> +     * Extract the AP reset vector for SEV-ES guests by locating the SEV GUID.
> +     * The SEV GUID is located 32 bytes from the end of the flash. Use this
> +     * address to base the SEV information block.

It surprises me a bit it's at a fixed offset.

Dave

> +     */
> +    info = flash_ptr + flash_size - 0x20 - sizeof(*info);
> +    if (memcmp(info->guid, SEV_INFO_BLOCK_GUID, 16)) {
> +        error_report("SEV information block not found in pflash rom");
> +        return 1;
> +    }
> +
> +    if (!info->reset_addr) {
> +        error_report("SEV-ES reset address is zero");
> +        return 1;
> +    }
> +
> +    *addr = info->reset_addr;
> +
> +    return 0;
> +}
> +
>  static void
>  sev_register_types(void)
>  {
> -- 
> 2.28.0
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


