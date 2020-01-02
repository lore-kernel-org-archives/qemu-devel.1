Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C45C2D0DD
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 03:49:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5762215A4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 03:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="zDPa1Xl7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5762215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imrUV-0005le-SA
	for qemu-devel@archiver.kernel.org; Wed, 01 Jan 2020 22:49:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59239)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1imrTh-0004nQ-NG
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 22:48:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1imrTg-0003IC-17
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 22:48:53 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:55534)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1imrTf-0003El-Iy
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 22:48:51 -0500
Received: by mail-pj1-x1041.google.com with SMTP id d5so2707763pjz.5
 for <qemu-devel@nongnu.org>; Wed, 01 Jan 2020 19:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xF6SeBm++uRrFnND4L5gEzOUFWNla5oZkqXF0a+EBB8=;
 b=zDPa1Xl7TNsylXSoiISpVDgn4jF2YshIOm9wSZnmK51r/TLGE9zwG9uAQjWepk21n9
 1KZLt5uP1iZ3Fsys65J+yHeymokyhJ9qD65b8YRICd0EALTmU39Hgsu+Oj5GmIESnnnA
 hm8mSGw9rGimYXTuUOTNFj96hhBKRq5dbEG6Jg9TPIc/RCpjkOxlZ14zWFTKwWzwMlDc
 Sq3X9AyCvPpp0YdkJVMmX21w1nwFp7Cpx5MwFlKJ8IPyOg449TpabHzDxYy42fklstmk
 kQm5Nz5ipqo4a5M+Cx2u1DrTorNjuHeIWk2E+FvGDQ3wfdjg+0zdEaHBxv3FW4nZV4M9
 mcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=xF6SeBm++uRrFnND4L5gEzOUFWNla5oZkqXF0a+EBB8=;
 b=XkWyLieB8rSbbHdAqB5i8MgpEPuyGEER+9yD7bTrfCri3FpVqQ6nJ/xOBSbxMq1t9y
 odTwmXHkpYQjVe6zaLAnuS3Pp0V+FcSmam1VBYN9Ji5MIS1M0xwOtz6FViKH0sswPuL2
 ioXxNSg8vv3mWXx2uyYW8NUGFjFNqiLOXsOpBkbzItCb8xaW4d/TdEsgU0UWHHz6yX+D
 gTo+IZK10J0zTBKM5f7PxP1TKL9LbKzt1XWtHAgpCU6idrg26C8+yFI7IaU0mVFqlTL+
 VPCAYRvy/Eob6Yd/3ha8SWGqid72vOwsYWn5qW5hfvkNZ89dfmiCQBgTo8jVuXBTt5H0
 iHHw==
X-Gm-Message-State: APjAAAVBaNTf8zPlxmmJBtQOC3PHfgZEv7ydpRbQOObaOSdTC7PL+v5z
 9VBeOwUcOaHBodi1dlg1KRao9w==
X-Google-Smtp-Source: APXvYqwz63xS/UNpn5w7dGJzmx/GthNFE4gd1M7dTGBOIsP1P5BA/cGKseJoMtb4yTwgCb8b3BNGjQ==
X-Received: by 2002:a17:902:7e4d:: with SMTP id
 a13mr82828507pln.281.1577936929092; 
 Wed, 01 Jan 2020 19:48:49 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id a1sm47918602pfo.68.2020.01.01.19.48.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jan 2020 19:48:48 -0800 (PST)
Subject: Re: [PATCH v4 ppc-for-5.0 2/2] ppc/spapr: Support reboot of secure
 pseries guest
To: Bharata B Rao <bharata@linux.ibm.com>, qemu-devel@nongnu.org
References: <20191219031445.8949-1-bharata@linux.ibm.com>
 <20191219031445.8949-3-bharata@linux.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <7d7fffae-1a1c-f33d-47a7-ca594dd45265@ozlabs.ru>
Date: Thu, 2 Jan 2020 14:48:41 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191219031445.8949-3-bharata@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: paulus@ozlabs.org, qemu-ppc@nongnu.org, linuxram@us.ibm.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 19/12/2019 14:14, Bharata B Rao wrote:
> A pseries guest can be run as a secure guest on Ultravisor-enabled
> POWER platforms. When such a secure guest is reset, we need to
> release/reset a few resources both on ultravisor and hypervisor side.
> This is achieved by invoking this new ioctl KVM_PPC_SVM_OFF from the
> machine reset path.
> 
> As part of this ioctl, the secure guest is essentially transitioned
> back to normal mode so that it can reboot like a regular guest and
> become secure again.
> 
> This ioctl has no effect when invoked for a normal guest. If this ioctl
> fails for a secure guest, the guest is terminated.
> 
> Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
> ---
>  hw/ppc/spapr.c       |  1 +
>  target/ppc/kvm.c     | 15 +++++++++++++++
>  target/ppc/kvm_ppc.h |  6 ++++++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f11422fc41..e62c89b3dd 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1597,6 +1597,7 @@ static void spapr_machine_reset(MachineState *machine)
>      void *fdt;
>      int rc;
>  
> +    kvmppc_svm_off(&error_fatal);
>      spapr_caps_apply(spapr);
>  
>      first_ppc_cpu = POWERPC_CPU(first_cpu);
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 7406d18945..5e24ae701f 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2900,3 +2900,18 @@ void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset)
>          kvm_set_one_reg(cs, KVM_REG_PPC_TB_OFFSET, &tb_offset);
>      }
>  }
> +
> +/*
> + * Don't set error if KVM_PPC_SVM_OFF ioctl is invoked on kernels
> + * that don't support this ioctl.
> + */
> +void kvmppc_svm_off(Error **errp)
> +{
> +    int rc;
> +    KVMState *s = KVM_STATE(current_machine->accelerator);


Crashed when TCG:

Thread 1 "qemu-system-ppc" hit Breakpoint 4, 0x00007ffff79c1068 in
__GI_abort () at abort.c:51
51      abort.c: No such file or directory.
#0  0x00007ffff79c1068 in __GI_abort () at abort.c:51
#1  0x0000000010752f70 in object_dynamic_cast_assert (obj=0x10f84a90,
typename=0x109d4da0 "kvm-accel", file=0x109d4c88
"/home/aik/p/qemu-killslof/targe
t/ppc/kvm.c", line=0xb59, func=0x109d5a40 <__func__.32829>
"kvmppc_svm_off") at /home/aik/p/qemu-killslof/qom/object.c:791
#2  0x0000000010344c2c in kvmppc_svm_off (errp=0x10dd56a8 <error_fatal>)
at /home/aik/p/qemu-killslof/target/ppc/kvm.c:2905
#3  0x00000000101d4ebc in spapr_machine_reset (machine=0x10f72870) at
/home/aik/p/qemu-killslof/hw/ppc/spapr.c:1621
#4  0x00000000103bccf8 in qemu_system_reset (reason=SHUTDOWN_CAUSE_NONE)
at /home/aik/p/qemu-killslof/vl.c:1427
#5  0x00000000103c720c in main (argc=0x19, argv=0x7ffffffff228,
envp=0x7ffffffff2f8) at /home/aik/p/qemu-killslof/vl.c:4277
(gdb)



> +
> +    rc = kvm_vm_ioctl(s, KVM_PPC_SVM_OFF);
> +    if (rc && rc != -ENOTTY) {
> +        error_setg_errno(errp, -rc, "KVM_PPC_SVM_OFF ioctl failed");
> +    }
> +}
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 47b08a4030..9a9bca1b72 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -37,6 +37,7 @@ int kvmppc_booke_watchdog_enable(PowerPCCPU *cpu);
>  target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
>                                       bool radix, bool gtse,
>                                       uint64_t proc_tbl);
> +void kvmppc_svm_off(Error **errp);
>  #ifndef CONFIG_USER_ONLY
>  bool kvmppc_spapr_use_multitce(void);
>  int kvmppc_spapr_enable_inkernel_multitce(void);
> @@ -201,6 +202,11 @@ static inline target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
>      return 0;
>  }
>  
> +static inline void kvmppc_svm_off(Error **errp)
> +{
> +    return;
> +}
> +
>  static inline void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu,
>                                               unsigned int online)
>  {
> 

-- 
Alexey

