Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DADCC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:52:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A83C42074B
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DEZVPbLs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A83C42074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZiu-0002nK-Hu
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kNZhe-0001eD-J1; Wed, 30 Sep 2020 06:51:20 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50696)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kNZhc-0000cY-2m; Wed, 30 Sep 2020 06:51:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UAn56Q038385;
 Wed, 30 Sep 2020 10:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 in-reply-to : references : sender : from : date : message-id :
 mime-version : content-type; s=corp-2020-01-29;
 bh=IKW/4AtymLboAV80axrY5U0EAxI0gNEP9fx33t2ezOs=;
 b=DEZVPbLsPejRWnl0qBS5sFOa7UGfGe9uRzP4h4OmOhc1IMSYgOphOTv7ZVb7MnU14Tk+
 Dy5ei974ZVH5GFk0alPG7WWPUTJ/XlHjqFKjFKwtFKEcuR6xqvnkE8rsqHX3Eg+6OfXe
 VDt7Ds19A7ftLmJW+Tt0qGvzjTj4yqi3gRC4wyC+rZxqu2vvvNvNweO558sgc6oaZxca
 9jnA9vBylsqQ94tnxROTvyLa6SGEkUzCdLmMqbVKpiJJRC2HFCEvOdcjg6qVqTM6zhhY
 TFfv5OLhmorTMFiNbObElD1GD4rmUJjTEA3LEa5oKcXOyun41vQxYPcSKOkLx15wFHXg Mg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 33sx9n7r2a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 30 Sep 2020 10:51:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UAottC004316;
 Wed, 30 Sep 2020 10:51:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 33uv2f6cuw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2020 10:51:01 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08UAoxSJ009933;
 Wed, 30 Sep 2020 10:50:59 GMT
Received: from disaster-area.hh.sledj.net (/81.187.26.238)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 30 Sep 2020 03:50:59 -0700
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id e711a0fc;
 Wed, 30 Sep 2020 10:50:57 +0000 (UTC)
To: zhaolichang <zhaolichang@huawei.com>, qemu-trivial@nongnu.org
Subject: Re: [PATCH RFC 02/14] ppc/: fix some comment spelling errors
In-Reply-To: <20200930095321.2006-3-zhaolichang@huawei.com>
References: <20200930095321.2006-1-zhaolichang@huawei.com>
 <20200930095321.2006-3-zhaolichang@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <david.edmondson@oracle.com>
Date: Wed, 30 Sep 2020 11:50:56 +0100
Message-ID: <m25z7vr10v.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0
 suspectscore=1 malwarescore=0 bulkscore=0 mlxlogscore=858 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=873
 suspectscore=1
 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300087
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=david.edmondson@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 06:51:12
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.614, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: zhaolichang <zhaolichang@huawei.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wednesday, 2020-09-30 at 17:53:09 +08, zhaolichang wrote:

> I found that there are many spelling errors in the comments of qemu/target/ppc.
> I used spellcheck to check the spelling errors and found some errors in the folder.
>
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>

Reviewed-by: David Edmondson <david.edmondson@oracle.com>

> ---
>  target/ppc/cpu.h                | 6 +++---
>  target/ppc/excp_helper.c        | 6 +++---
>  target/ppc/fpu_helper.c         | 2 +-
>  target/ppc/internal.h           | 2 +-
>  target/ppc/kvm.c                | 2 +-
>  target/ppc/machine.c            | 2 +-
>  target/ppc/mmu-hash64.c         | 2 +-
>  target/ppc/mmu_helper.c         | 4 ++--
>  target/ppc/translate_init.c.inc | 2 +-
>  9 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 766e9c5..ba5ebb1 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -615,7 +615,7 @@ enum {
>  #define FPSCR_VXCVI  8  /* Floating-point invalid operation exception (int)  */
>  #define FPSCR_VE     7  /* Floating-point invalid operation exception enable */
>  #define FPSCR_OE     6  /* Floating-point overflow exception enable          */
> -#define FPSCR_UE     5  /* Floating-point undeflow exception enable          */
> +#define FPSCR_UE     5  /* Floating-point underflow exception enable          */
>  #define FPSCR_ZE     4  /* Floating-point zero divide exception enable       */
>  #define FPSCR_XE     3  /* Floating-point inexact exception enable           */
>  #define FPSCR_NI     2  /* Floating-point non-IEEE mode                      */
> @@ -2331,13 +2331,13 @@ enum {
>      /* Internal hardware exception sources */
>      PPC_INTERRUPT_DECR,           /* Decrementer exception                */
>      PPC_INTERRUPT_HDECR,          /* Hypervisor decrementer exception     */
> -    PPC_INTERRUPT_PIT,            /* Programmable inteval timer interrupt */
> +    PPC_INTERRUPT_PIT,            /* Programmable interval timer interrupt */
>      PPC_INTERRUPT_FIT,            /* Fixed interval timer interrupt       */
>      PPC_INTERRUPT_WDT,            /* Watchdog timer interrupt             */
>      PPC_INTERRUPT_CDOORBELL,      /* Critical doorbell interrupt          */
>      PPC_INTERRUPT_DOORBELL,       /* Doorbell interrupt                   */
>      PPC_INTERRUPT_PERFM,          /* Performance monitor interrupt        */
> -    PPC_INTERRUPT_HMI,            /* Hypervisor Maintainance interrupt    */
> +    PPC_INTERRUPT_HMI,            /* Hypervisor Maintenance interrupt    */
>      PPC_INTERRUPT_HDOORBELL,      /* Hypervisor Doorbell interrupt        */
>      PPC_INTERRUPT_HVIRT,          /* Hypervisor virtualization interrupt  */
>  };
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index a988ba1..d7411bc 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -231,7 +231,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
>      }
>  
>      /*
> -     * Exception targetting modifiers
> +     * Exception targeting modifiers
>       *
>       * LPES0 is supported on POWER7/8/9
>       * LPES1 is not supported (old iSeries mode)
> @@ -1015,7 +1015,7 @@ static void ppc_hw_interrupt(CPUPPCState *env)
>           * This means we will incorrectly execute past the power management
>           * instruction instead of triggering a reset.
>           *
> -         * It generally means a discrepancy between the wakup conditions in the
> +         * It generally means a discrepancy between the wakeup conditions in the
>           * processor has_work implementation and the logic in this function.
>           */
>          cpu_abort(env_cpu(env),
> @@ -1191,7 +1191,7 @@ void helper_rfi(CPUPPCState *env)
>  void helper_rfid(CPUPPCState *env)
>  {
>      /*
> -     * The architeture defines a number of rules for which bits can
> +     * The architecture defines a number of rules for which bits can
>       * change but in practice, we handle this in hreg_store_msr()
>       * which will be called by do_rfi(), so there is no need to filter
>       * here
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index ae43b08..9b8c8b7 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -1804,7 +1804,7 @@ uint32_t helper_efdcmpeq(CPUPPCState *env, uint64_t op1, uint64_t op2)
>  
>  
>  /*
> - * VSX_ADD_SUB - VSX floating point add/subract
> + * VSX_ADD_SUB - VSX floating point add/subtract
>   *   name  - instruction mnemonic
>   *   op    - operation (add or sub)
>   *   nels  - number of elements (1, 2 or 4)
> diff --git a/target/ppc/internal.h b/target/ppc/internal.h
> index 15d655b..b4df127 100644
> --- a/target/ppc/internal.h
> +++ b/target/ppc/internal.h
> @@ -1,5 +1,5 @@
>  /*
> - *  PowerPC interal definitions for qemu.
> + *  PowerPC internal definitions for qemu.
>   *
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index d85ba8f..e85ef2e 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -487,7 +487,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>              /*
>               * KVM-HV has transactional memory on POWER8 also without
>               * the KVM_CAP_PPC_HTM extension, so enable it here
> -             * instead as long as it's availble to userspace on the
> +             * instead as long as it's available to userspace on the
>               * host.
>               */
>              if (qemu_getauxval(AT_HWCAP2) & PPC_FEATURE2_HAS_HTM) {
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index 109d071..f6a24a9 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -337,7 +337,7 @@ static int cpu_post_load(void *opaque, int version_id)
>  
>      /*
>       * If we're operating in compat mode, we should be ok as long as
> -     * the destination supports the same compatiblity mode.
> +     * the destination supports the same compatibility mode.
>       *
>       * Otherwise, however, we require that the destination has exactly
>       * the same CPU model as the source.
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index c31d21e..977b2d1 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -883,7 +883,7 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr,
>      /*
>       * Note on LPCR usage: 970 uses HID4, but our special variant of
>       * store_spr copies relevant fields into env->spr[SPR_LPCR].
> -     * Similarily we filter unimplemented bits when storing into LPCR
> +     * Similarly we filter unimplemented bits when storing into LPCR
>       * depending on the MMU version. This code can thus just use the
>       * LPCR "as-is".
>       */
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index 8972714..50aa18a 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -179,7 +179,7 @@ static inline int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
>              }
>              /* Compute access rights */
>              access = pp_check(ctx->key, pp, ctx->nx);
> -            /* Keep the matching PTE informations */
> +            /* Keep the matching PTE information */
>              ctx->raddr = pte1;
>              ctx->prot = access;
>              ret = check_prot(ctx->prot, rw, type);
> @@ -2176,7 +2176,7 @@ void helper_store_sr(CPUPPCState *env, target_ulong srnum, target_ulong value)
>          env->sr[srnum] = value;
>          /*
>           * Invalidating 256MB of virtual memory in 4kB pages is way
> -         * longer than flusing the whole TLB.
> +         * longer than flushing the whole TLB.
>           */
>  #if !defined(FLUSH_ALL_TLBS) && 0
>          {
> diff --git a/target/ppc/translate_init.c.inc b/target/ppc/translate_init.c.inc
> index bb66526..3e0810f 100644
> --- a/target/ppc/translate_init.c.inc
> +++ b/target/ppc/translate_init.c.inc
> @@ -792,7 +792,7 @@ static void gen_spr_generic(CPUPPCState *env)
>                   &spr_read_xer, &spr_write_xer,
>                   &spr_read_xer, &spr_write_xer,
>                   0x00000000);
> -    /* Branch contol */
> +    /* Branch control */
>      spr_register(env, SPR_LR, "LR",
>                   &spr_read_lr, &spr_write_lr,
>                   &spr_read_lr, &spr_write_lr,
> -- 
> 2.26.2.windows.1

dme.
-- 
You took the words right out of my mouth.

