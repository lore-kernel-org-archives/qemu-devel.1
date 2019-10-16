Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1BEFA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 19:03:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 951D621E6F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 19:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951D621E6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKoaP-0002vI-Ow
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 15:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58371)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iKoZN-0001zn-S6
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 15:02:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iKoZL-0006mq-MN
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 15:02:49 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36943)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iKoZH-0006io-Os
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 15:02:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id p1so14829733pgi.4
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 12:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=VoUAelHoI5V1dDOgS0kCadoKVsKPF3UKMPiydVe91WA=;
 b=mzAgwziSwRkLyJUNlzouNYBoy8A4agYsD2CLsfO4+Nj/lF5e63fwNP8Ajw1iiIJe96
 0qhz/eA+ZaRA6rJAQPiVavPTsK5idb4+jQf24njs+rbDOVSnG42vnr48XTg11xo11jy7
 /OUpnCkyUSNrhNdm3Q6UrHlxx2U07dz5PWMhyUbkzuimv6ze6qW/HSCZD7wMAbcv4tBT
 iT628rv8U+AlF8qYmXG6vjhItG3SkQ5sgYuZssluc9K4NaTaHo+rSWo4MB1ZbjRoNZXX
 dvO7gv1Z+LgZUiN8/uLJWjakv8riF6lt7TgPtyRb14Px6ABMWgiwFJJ7r448JXtdZ2ah
 dzJA==
X-Gm-Message-State: APjAAAUFBcs56MSAO1NPb3DALu4pqAv9gwInFCgI+mUe9RDS4mOumRtw
 0aHie5Q1mZWdHfEd6MdtgovjxQ==
X-Google-Smtp-Source: APXvYqzyn64nwbUQaFXJFN0zNxjeU3uva0H9KzIOUOJsapQy1O0csL+s73+oNNBZy0TUUaT5Sw3U7A==
X-Received: by 2002:a17:90a:2ec1:: with SMTP id
 h1mr6881400pjs.96.1571252559100; 
 Wed, 16 Oct 2019 12:02:39 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id s36sm26596156pgk.84.2019.10.16.12.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2019 12:02:38 -0700 (PDT)
Date: Wed, 16 Oct 2019 12:02:38 -0700 (PDT)
X-Google-Original-Date: Wed, 16 Oct 2019 09:36:47 PDT (-0700)
Subject: Re: [PATCH v1 22/28] target/riscv: Allow specifying MMU stage
In-Reply-To: <CAKmqyKOV0J3w3fPUF3CGAip=j_+D_M+7X9r+2TwEZwkapsQZMQ@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: alistair23@gmail.com
Message-ID: <mhng-8a742b0f-e79f-4da0-81fc-b91d184b6279@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.193
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
Cc: qemu-riscv@nongnu.org, Anup Patel <Anup.Patel@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org,
 Atish Patra <Atish.Patra@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 07 Oct 2019 11:05:33 PDT (-0700), alistair23@gmail.com wrote:
> On Thu, Oct 3, 2019 at 8:53 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> On Fri, 23 Aug 2019 16:38:47 PDT (-0700), Alistair Francis wrote:
>> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> > ---
>> >  target/riscv/cpu_helper.c | 39 ++++++++++++++++++++++++++++++---------
>> >  1 file changed, 30 insertions(+), 9 deletions(-)
>> >
>> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>> > index 098873c83e..9aa6906acd 100644
>> > --- a/target/riscv/cpu_helper.c
>> > +++ b/target/riscv/cpu_helper.c
>> > @@ -318,10 +318,19 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
>> >   *
>> >   * Adapted from Spike's mmu_t::translate and mmu_t::walk
>> >   *
>> > + * @env: CPURISCVState
>> > + * @physical: This will be set to the calculated physical address
>> > + * @prot: The returned protection attributes
>> > + * @addr: The virtual address to be translated
>> > + * @access_type: The type of MMU access
>> > + * @mmu_idx: Indicates current privilege level
>> > + * @first_stage: Are we in first stage translation?
>> > + *               Second stage is used for hypervisor guest translation
>> >   */
>> >  static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>> >                                  int *prot, target_ulong addr,
>> > -                                int access_type, int mmu_idx)
>> > +                                int access_type, int mmu_idx,
>> > +                                bool first_stage)
>> >  {
>> >      /* NOTE: the env->pc value visible here will not be
>> >       * correct, but the value visible to the exception handler
>> > @@ -518,13 +527,23 @@ restart:
>> >  }
>> >
>> >  static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
>> > -                                MMUAccessType access_type, bool pmp_violation)
>> > +                                MMUAccessType access_type, bool pmp_violation,
>> > +                                bool first_stage)
>> >  {
>> >      CPUState *cs = env_cpu(env);
>> > -    int page_fault_exceptions =
>> > -        (env->priv_ver >= PRIV_VERSION_1_10_0) &&
>> > -        get_field(env->satp, SATP_MODE) != VM_1_10_MBARE &&
>> > -        !pmp_violation;
>> > +    int page_fault_exceptions;
>> > +    if (first_stage) {
>> > +        page_fault_exceptions =
>> > +            (env->priv_ver >= PRIV_VERSION_1_10_0) &&
>> > +            get_field(env->satp, SATP_MODE) != VM_1_10_MBARE &&
>> > +            !pmp_violation;
>> > +            riscv_cpu_set_force_hs_excep(env, CLEAR_HS_EXCEP);
>>
>> It might just be email, but the indentation looks wrong here.
>
> Yep, fixed.
>
>>
>> > +    } else {
>> > +        page_fault_exceptions =
>> > +            get_field(env->hgatp, HGATP_MODE) != VM_1_10_MBARE &&
>> > +            !pmp_violation;
>> > +            riscv_cpu_set_force_hs_excep(env, FORCE_HS_EXCEP);
>> > +    }
>> >      switch (access_type) {
>> >      case MMU_INST_FETCH:
>> >          cs->exception_index = page_fault_exceptions ?
>> > @@ -551,7 +570,8 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>> >      int prot;
>> >      int mmu_idx = cpu_mmu_index(&cpu->env, false);
>> >
>> > -    if (get_physical_address(&cpu->env, &phys_addr, &prot, addr, 0, mmu_idx)) {
>> > +    if (get_physical_address(&cpu->env, &phys_addr, &prot, addr, 0, mmu_idx,
>> > +                             true)) {
>> >          return -1;
>> >      }
>> >      return phys_addr;
>> > @@ -613,7 +633,8 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>> >      qemu_log_mask(CPU_LOG_MMU, "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
>> >                    __func__, address, access_type, mmu_idx);
>> >
>> > -    ret = get_physical_address(env, &pa, &prot, address, access_type, mmu_idx);
>> > +    ret = get_physical_address(env, &pa, &prot, address, access_type, mmu_idx,
>> > +                               true);
>> >
>> >      if (mode == PRV_M && access_type != MMU_INST_FETCH) {
>> >          if (get_field(*env->mstatus, MSTATUS_MPRV)) {
>> > @@ -640,7 +661,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>> >      } else if (probe) {
>> >          return false;
>> >      } else {
>> > -        raise_mmu_exception(env, address, access_type, pmp_violation);
>> > +        raise_mmu_exception(env, address, access_type, pmp_violation, true);
>> >          riscv_raise_exception(env, cs->exception_index, retaddr);
>> >      }
>> >  #else
>>
>> I don't think it makes sense to split off these two (23 and 24, that add the
>> argument) out from the implementation.
>
> The goal was just to make it easier to review. If you want them
> combined I can easily combine them.

It's making it harder to read on my end :)

