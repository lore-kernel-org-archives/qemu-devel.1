Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F11C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 12:07:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 086E2206A2
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 12:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VczEtYPO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086E2206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOgpR-0002kf-4u
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 08:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54909)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jOgop-0002LE-4b
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:07:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jOgon-00046F-62
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:07:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21257
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jOgom-00045h-TR
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586952419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IVcNWyfjmyPMTrhuMHBaNbjyxGvx+I2/uk54HMsRS2A=;
 b=VczEtYPOcynWuVz2w9m3Y0jzIFFaa2UCLWmLLBmMiQO+Icpqsb2siJIbO9vFQgWQGjHscr
 0ejJIW3Fx8mAMLyyS4ju6qj48UnDpB1bTspjUJq9/Y90MeXlMStyr4tb9mk8IaNeLslSom
 iTodDWk6O+UU282aBISVQAmLX7EUeXo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-lgUw7OjDMSi7CdlzxvOYhg-1; Wed, 15 Apr 2020 08:06:58 -0400
X-MC-Unique: lgUw7OjDMSi7CdlzxvOYhg-1
Received: by mail-wr1-f70.google.com with SMTP id d17so9450970wrr.17
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 05:06:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IVcNWyfjmyPMTrhuMHBaNbjyxGvx+I2/uk54HMsRS2A=;
 b=WLex3GC1ePVn3N1uWy56MNz88mu+CoTnKRdgdxNsGG8BGqy2ZkAKlNuS21DMV9Cjci
 Ndd/dmQVMv2nJqsJy+AZ3k+PJyMIZZeP4RAmCSvwX3amQDMSyKTAug3R/lPAf9arNM3V
 57+hlbF71GYHJuHT0P1fJtENhBL/JGw0LJtn74ANgIGGIqcPMT1urKJeF7GMSLNajv4x
 cnGBhHoKmEYojDUjCqOFCsWDGH2OqDks33/OpiPTPj2z/wTqMPbBHAdR/uk4y2tqF9uL
 RInpCaTRQ5l20/RlgXUMB/lIG5fTE2Ews659hYmtY7vO4ZSUi94kkc/4jE37oMVe47v3
 LZJA==
X-Gm-Message-State: AGi0PuYJrMPey7M9fpcoxoH5rhrNXgIisqMZseySlHFTo4fyFR8zVdBL
 j+1J+TqbAenQWOijIjPBPEIXbiGxCVP/eYSEZEZ2ThCuDM/FCHoMXZSsqn2bGHO7pbNul2YpllI
 qGQROD9Fe2gA/icM=
X-Received: by 2002:adf:97cc:: with SMTP id t12mr27439843wrb.261.1586952416803; 
 Wed, 15 Apr 2020 05:06:56 -0700 (PDT)
X-Google-Smtp-Source: APiQypKJxOu30cMDkgZ6OY0KGfSuOooZzUUgUCvGfLJ8CDuesIQPtA3jgJ1gJmwiv87hCwrPF6Ak1w==
X-Received: by 2002:adf:97cc:: with SMTP id t12mr27439820wrb.261.1586952416452; 
 Wed, 15 Apr 2020 05:06:56 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9066:4f2:9fbd:f90e?
 ([2001:b07:6468:f312:9066:4f2:9fbd:f90e])
 by smtp.gmail.com with ESMTPSA id o28sm8516300wra.84.2020.04.15.05.06.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2020 05:06:55 -0700 (PDT)
Subject: Re: [PATCH v2] hvf: use standard CR0 and CR4 register definitions
To: Cameron Esfahani <dirty@apple.com>, qemu-devel@nongnu.org
References: <a31c1c7f7a7b4f537be9d307ccddc6e17761f1b0.1586927010.git.dirty@apple.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ff9da4e6-97df-bdbe-025d-a04465bd8c18@redhat.com>
Date: Wed, 15 Apr 2020 14:06:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <a31c1c7f7a7b4f537be9d307ccddc6e17761f1b0.1586927010.git.dirty@apple.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: r.bolshakov@yadro.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/04/20 07:12, Cameron Esfahani wrote:
> Signed-off-by: Cameron Esfahani <dirty@apple.com>
> ---
> 
> v2:
> + Fix duplicate line Roman Bolshakov <r.bolshakov@yadro.com> found in review.
> ---
>  target/i386/cpu.h          |  2 ++
>  target/i386/hvf/hvf.c      |  2 +-
>  target/i386/hvf/vmx.h      | 15 ++++++++-------
>  target/i386/hvf/x86.c      |  6 +++---
>  target/i386/hvf/x86.h      | 34 ----------------------------------
>  target/i386/hvf/x86_mmu.c  |  2 +-
>  target/i386/hvf/x86_task.c |  3 ++-
>  7 files changed, 17 insertions(+), 47 deletions(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 60d797d594..1286ec6e7a 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -225,6 +225,8 @@ typedef enum X86Seg {
>  #define CR0_NE_MASK  (1U << 5)
>  #define CR0_WP_MASK  (1U << 16)
>  #define CR0_AM_MASK  (1U << 18)
> +#define CR0_NW_MASK  (1U << 29)
> +#define CR0_CD_MASK  (1U << 30)
>  #define CR0_PG_MASK  (1U << 31)
>  
>  #define CR4_VME_MASK  (1U << 0)
> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> index d72543dc31..48f3ef050c 100644
> --- a/target/i386/hvf/hvf.c
> +++ b/target/i386/hvf/hvf.c
> @@ -455,7 +455,7 @@ void hvf_reset_vcpu(CPUState *cpu) {
>          wvmcs(cpu->hvf_fd, VMCS_GUEST_PDPTE0 + i * 2, pdpte[i]);
>      }
>  
> -    macvm_set_cr0(cpu->hvf_fd, 0x60000010);
> +    macvm_set_cr0(cpu->hvf_fd, CR0_CD_MASK | CR0_NW_MASK | CR0_ET_MASK);
>  
>      wvmcs(cpu->hvf_fd, VMCS_CR4_MASK, CR4_VMXE_MASK);
>      wvmcs(cpu->hvf_fd, VMCS_CR4_SHADOW, 0x0);
> diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
> index 03d2c79b9c..8ec2e6414e 100644
> --- a/target/i386/hvf/vmx.h
> +++ b/target/i386/hvf/vmx.h
> @@ -121,9 +121,10 @@ static inline void macvm_set_cr0(hv_vcpuid_t vcpu, uint64_t cr0)
>      uint64_t pdpte[4] = {0, 0, 0, 0};
>      uint64_t efer = rvmcs(vcpu, VMCS_GUEST_IA32_EFER);
>      uint64_t old_cr0 = rvmcs(vcpu, VMCS_GUEST_CR0);
> -    uint64_t mask = CR0_PG | CR0_CD | CR0_NW | CR0_NE | CR0_ET;
> +    uint64_t mask = CR0_PG_MASK | CR0_CD_MASK | CR0_NW_MASK |
> +                    CR0_NE_MASK | CR0_ET_MASK;
>  
> -    if ((cr0 & CR0_PG) && (rvmcs(vcpu, VMCS_GUEST_CR4) & CR4_PAE) &&
> +    if ((cr0 & CR0_PG_MASK) && (rvmcs(vcpu, VMCS_GUEST_CR4) & CR4_PAE_MASK) &&
>          !(efer & MSR_EFER_LME)) {
>          address_space_read(&address_space_memory,
>                             rvmcs(vcpu, VMCS_GUEST_CR3) & ~0x1f,
> @@ -138,17 +139,17 @@ static inline void macvm_set_cr0(hv_vcpuid_t vcpu, uint64_t cr0)
>      wvmcs(vcpu, VMCS_CR0_SHADOW, cr0);
>  
>      if (efer & MSR_EFER_LME) {
> -        if (!(old_cr0 & CR0_PG) && (cr0 & CR0_PG)) {
> +        if (!(old_cr0 & CR0_PG_MASK) && (cr0 & CR0_PG_MASK)) {
>              enter_long_mode(vcpu, cr0, efer);
>          }
> -        if (/*(old_cr0 & CR0_PG) &&*/ !(cr0 & CR0_PG)) {
> +        if (!(cr0 & CR0_PG_MASK)) {
>              exit_long_mode(vcpu, cr0, efer);
>          }
>      }
>  
>      /* Filter new CR0 after we are finished examining it above. */
> -    cr0 = (cr0 & ~(mask & ~CR0_PG));
> -    wvmcs(vcpu, VMCS_GUEST_CR0, cr0 | CR0_NE | CR0_ET);
> +    cr0 = (cr0 & ~(mask & ~CR0_PG_MASK));
> +    wvmcs(vcpu, VMCS_GUEST_CR0, cr0 | CR0_NE_MASK | CR0_ET_MASK);
>  
>      hv_vcpu_invalidate_tlb(vcpu);
>      hv_vcpu_flush(vcpu);
> @@ -156,7 +157,7 @@ static inline void macvm_set_cr0(hv_vcpuid_t vcpu, uint64_t cr0)
>  
>  static inline void macvm_set_cr4(hv_vcpuid_t vcpu, uint64_t cr4)
>  {
> -    uint64_t guest_cr4 = cr4 | CR4_VMXE;
> +    uint64_t guest_cr4 = cr4 | CR4_VMXE_MASK;
>  
>      wvmcs(vcpu, VMCS_GUEST_CR4, guest_cr4);
>      wvmcs(vcpu, VMCS_CR4_SHADOW, cr4);
> diff --git a/target/i386/hvf/x86.c b/target/i386/hvf/x86.c
> index 3afcedc7fc..668c02de6e 100644
> --- a/target/i386/hvf/x86.c
> +++ b/target/i386/hvf/x86.c
> @@ -119,7 +119,7 @@ bool x86_read_call_gate(struct CPUState *cpu, struct x86_call_gate *idt_desc,
>  bool x86_is_protected(struct CPUState *cpu)
>  {
>      uint64_t cr0 = rvmcs(cpu->hvf_fd, VMCS_GUEST_CR0);
> -    return cr0 & CR0_PE;
> +    return cr0 & CR0_PE_MASK;
>  }
>  
>  bool x86_is_real(struct CPUState *cpu)
> @@ -150,13 +150,13 @@ bool x86_is_long64_mode(struct CPUState *cpu)
>  bool x86_is_paging_mode(struct CPUState *cpu)
>  {
>      uint64_t cr0 = rvmcs(cpu->hvf_fd, VMCS_GUEST_CR0);
> -    return cr0 & CR0_PG;
> +    return cr0 & CR0_PG_MASK;
>  }
>  
>  bool x86_is_pae_enabled(struct CPUState *cpu)
>  {
>      uint64_t cr4 = rvmcs(cpu->hvf_fd, VMCS_GUEST_CR4);
> -    return cr4 & CR4_PAE;
> +    return cr4 & CR4_PAE_MASK;
>  }
>  
>  target_ulong linear_addr(struct CPUState *cpu, target_ulong addr, X86Seg seg)
> diff --git a/target/i386/hvf/x86.h b/target/i386/hvf/x86.h
> index c95d5b2116..bc0170b2a8 100644
> --- a/target/i386/hvf/x86.h
> +++ b/target/i386/hvf/x86.h
> @@ -100,40 +100,6 @@ typedef struct x86_reg_flags {
>      };
>  } __attribute__ ((__packed__)) x86_reg_flags;
>  
> -typedef enum x86_reg_cr0 {
> -    CR0_PE =            (1L << 0),
> -    CR0_MP =            (1L << 1),
> -    CR0_EM =            (1L << 2),
> -    CR0_TS =            (1L << 3),
> -    CR0_ET =            (1L << 4),
> -    CR0_NE =            (1L << 5),
> -    CR0_WP =            (1L << 16),
> -    CR0_AM =            (1L << 18),
> -    CR0_NW =            (1L << 29),
> -    CR0_CD =            (1L << 30),
> -    CR0_PG =            (1L << 31),
> -} x86_reg_cr0;
> -
> -typedef enum x86_reg_cr4 {
> -    CR4_VME =            (1L << 0),
> -    CR4_PVI =            (1L << 1),
> -    CR4_TSD =            (1L << 2),
> -    CR4_DE  =            (1L << 3),
> -    CR4_PSE =            (1L << 4),
> -    CR4_PAE =            (1L << 5),
> -    CR4_MSE =            (1L << 6),
> -    CR4_PGE =            (1L << 7),
> -    CR4_PCE =            (1L << 8),
> -    CR4_OSFXSR =         (1L << 9),
> -    CR4_OSXMMEXCPT =     (1L << 10),
> -    CR4_VMXE =           (1L << 13),
> -    CR4_SMXE =           (1L << 14),
> -    CR4_FSGSBASE =       (1L << 16),
> -    CR4_PCIDE =          (1L << 17),
> -    CR4_OSXSAVE =        (1L << 18),
> -    CR4_SMEP =           (1L << 20),
> -} x86_reg_cr4;
> -
>  /* 16 bit Task State Segment */
>  typedef struct x86_tss_segment16 {
>      uint16_t link;
> diff --git a/target/i386/hvf/x86_mmu.c b/target/i386/hvf/x86_mmu.c
> index 65d4603dbf..8f38eccffc 100644
> --- a/target/i386/hvf/x86_mmu.c
> +++ b/target/i386/hvf/x86_mmu.c
> @@ -130,7 +130,7 @@ static bool test_pt_entry(struct CPUState *cpu, struct gpt_translation *pt,
>  
>      uint32_t cr0 = rvmcs(cpu->hvf_fd, VMCS_GUEST_CR0);
>      /* check protection */
> -    if (cr0 & CR0_WP) {
> +    if (cr0 & CR0_WP_MASK) {
>          if (pt->write_access && !pte_write_access(pte)) {
>              return false;
>          }
> diff --git a/target/i386/hvf/x86_task.c b/target/i386/hvf/x86_task.c
> index 1daac6cc2b..5e41d09b89 100644
> --- a/target/i386/hvf/x86_task.c
> +++ b/target/i386/hvf/x86_task.c
> @@ -174,7 +174,8 @@ void vmx_handle_task_switch(CPUState *cpu, x68_segment_selector tss_sel, int rea
>          //ret = task_switch_16(cpu, tss_sel, old_tss_sel, old_tss_base, &next_tss_desc);
>          VM_PANIC("task_switch_16");
>  
> -    macvm_set_cr0(cpu->hvf_fd, rvmcs(cpu->hvf_fd, VMCS_GUEST_CR0) | CR0_TS);
> +    macvm_set_cr0(cpu->hvf_fd,
> +                  rvmcs(cpu->hvf_fd, VMCS_GUEST_CR0) | CR0_TS_MASK);
>      x86_segment_descriptor_to_vmx(cpu, tss_sel, &next_tss_desc, &vmx_seg);
>      vmx_write_segment_descriptor(cpu, &vmx_seg, R_TR);
>  
> 

Queued, thanks.

Paolo


