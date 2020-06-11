Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68489C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 15:06:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33B1A2065C
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 15:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="Au3ymbl7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B1A2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjOn4-0007Hf-9q
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 11:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jjOjH-0004x0-M1
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 11:02:55 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:40948 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jjOj8-00083s-N6
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 11:02:55 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 053AB4C893;
 Thu, 11 Jun 2020 15:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received:received; s=mta-01; t=1591887751;
 x=1593702152; bh=sq8uhQ7nz1BvdO6/bUw8epsRxrpAmJ3guZV9S8Ws50E=; b=
 Au3ymbl7nexfxJVxJSdWzTEmMOhsD1RwVMyf+E0Uitobkgx0jxLx1CngZ8FPFKxN
 +sPOcSnhwYNzii7tavyendrqfuRCPDR5Alku0lDt29/FmeWTMmsm9H+YVNIFk2IT
 6UFCuUYYju4jE/uXhY+1g4i8lBpQjIfVeCX/2XvAUXk=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E3pORXTzJFjT; Thu, 11 Jun 2020 18:02:31 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 839B54C854;
 Thu, 11 Jun 2020 18:02:28 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 11
 Jun 2020 18:02:28 +0300
Date: Thu, 11 Jun 2020 18:02:27 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH 12/13] i386: hvf: Move mmio_buf into CPUX86State
Message-ID: <20200611150227.GA76007@SPB-NB-133.local>
References: <20200528193758.51454-1-r.bolshakov@yadro.com>
 <20200528193758.51454-13-r.bolshakov@yadro.com>
 <d57e48c6-574e-471c-78be-1245d62bc908@redhat.com>
 <3101f615-e1c9-2cf4-7a7b-6e30c7942c53@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3101f615-e1c9-2cf4-7a7b-6e30c7942c53@suse.de>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 11:02:33
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 11, 2020 at 03:24:31PM +0200, Claudio Fontana wrote:
> On 6/4/20 8:27 PM, Paolo Bonzini wrote:
> > On 28/05/20 21:37, Roman Bolshakov wrote:
> >> There's no similar field in CPUX86State, but it's needed for MMIO traps.
> >>
> >> Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> >> ---
> >>  target/i386/cpu.h         |  1 +
> >>  target/i386/hvf/hvf.c     |  5 +++++
> >>  target/i386/hvf/x86.h     |  1 -
> >>  target/i386/hvf/x86_emu.c | 12 ++++++------
> >>  4 files changed, 12 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> >> index 7e6566565a..be44e19154 100644
> >> --- a/target/i386/cpu.h
> >> +++ b/target/i386/cpu.h
> >> @@ -1593,6 +1593,7 @@ typedef struct CPUX86State {
> >>  #endif
> >>  #if defined(CONFIG_HVF)
> >>      hvf_lazy_flags hvf_lflags;
> >> +    void *hvf_mmio_buf;
> >>      HVFX86EmulatorState *hvf_emul;
> >>  #endif
> >>  
> >> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> >> index 4cee496d71..57696c46c7 100644
> >> --- a/target/i386/hvf/hvf.c
> >> +++ b/target/i386/hvf/hvf.c
> >> @@ -533,7 +533,11 @@ void hvf_reset_vcpu(CPUState *cpu) {
> >>  
> >>  void hvf_vcpu_destroy(CPUState *cpu)
> >>  {
> >> +    X86CPU *x86_cpu = X86_CPU(cpu);
> >> +    CPUX86State *env = &x86_cpu->env;
> >> +
> >>      hv_return_t ret = hv_vcpu_destroy((hv_vcpuid_t)cpu->hvf_fd);
> >> +    g_free(env->hvf_mmio_buf);
> >>      assert_hvf_ok(ret);
> >>  }
> >>  
> >> @@ -563,6 +567,7 @@ int hvf_init_vcpu(CPUState *cpu)
> >>      init_decoder();
> >>  
> >>      hvf_state->hvf_caps = g_new0(struct hvf_vcpu_caps, 1);
> >> +    env->hvf_mmio_buf = g_new(char, 4096);
> >>      env->hvf_emul = g_new0(HVFX86EmulatorState, 1);
> >>  
> >>      r = hv_vcpu_create((hv_vcpuid_t *)&cpu->hvf_fd, HV_VCPU_DEFAULT);
> >> diff --git a/target/i386/hvf/x86.h b/target/i386/hvf/x86.h
> >> index 2363616c07..483fcea762 100644
> >> --- a/target/i386/hvf/x86.h
> >> +++ b/target/i386/hvf/x86.h
> >> @@ -230,7 +230,6 @@ typedef struct x68_segment_selector {
> >>  
> >>  /* Definition of hvf_x86_state is here */
> >>  struct HVFX86EmulatorState {
> >> -    uint8_t mmio_buf[4096];
> >>  };
> >>  
> >>  /* useful register access  macros */
> >> diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
> >> index 1ad2c30e16..d3e289ed87 100644
> >> --- a/target/i386/hvf/x86_emu.c
> >> +++ b/target/i386/hvf/x86_emu.c
> >> @@ -187,8 +187,8 @@ void write_val_ext(struct CPUX86State *env, target_ulong ptr, target_ulong val,
> >>  
> >>  uint8_t *read_mmio(struct CPUX86State *env, target_ulong ptr, int bytes)
> >>  {
> >> -    vmx_read_mem(env_cpu(env), env->hvf_emul->mmio_buf, ptr, bytes);
> >> -    return env->hvf_emul->mmio_buf;
> >> +    vmx_read_mem(env_cpu(env), env->hvf_mmio_buf, ptr, bytes);
> >> +    return env->hvf_mmio_buf;
> >>  }
> >>  
> >>  
> >> @@ -489,9 +489,9 @@ static void exec_ins_single(struct CPUX86State *env, struct x86_decode *decode)
> >>      target_ulong addr = linear_addr_size(env_cpu(env), RDI(env),
> >>                                           decode->addressing_size, R_ES);
> >>  
> >> -    hvf_handle_io(env_cpu(env), DX(env), env->hvf_emul->mmio_buf, 0,
> >> +    hvf_handle_io(env_cpu(env), DX(env), env->hvf_mmio_buf, 0,
> >>                    decode->operand_size, 1);
> >> -    vmx_write_mem(env_cpu(env), addr, env->hvf_emul->mmio_buf,
> >> +    vmx_write_mem(env_cpu(env), addr, env->hvf_mmio_buf,
> >>                    decode->operand_size);
> >>  
> >>      string_increment_reg(env, R_EDI, decode);
> >> @@ -512,9 +512,9 @@ static void exec_outs_single(struct CPUX86State *env, struct x86_decode *decode)
> >>  {
> >>      target_ulong addr = decode_linear_addr(env, decode, RSI(env), R_DS);
> >>  
> >> -    vmx_read_mem(env_cpu(env), env->hvf_emul->mmio_buf, addr,
> >> +    vmx_read_mem(env_cpu(env), env->hvf_mmio_buf, addr,
> >>                   decode->operand_size);
> >> -    hvf_handle_io(env_cpu(env), DX(env), env->hvf_emul->mmio_buf, 1,
> >> +    hvf_handle_io(env_cpu(env), DX(env), env->hvf_mmio_buf, 1,
> >>                    decode->operand_size, 1);
> >>  
> >>      string_increment_reg(env, R_ESI, decode);
> >>
> > 
> > It should be possible to get rid of the buffer altogether, but it's ok
> > to do it separately.
> > 
> > I queued the series, thanks.
> > 
> > Paolo
> > 
> > 
> 
> Thanks Paolo, I am waiting for this (and maybe another series from Roman) to be able to do the cpus refactoring.
> 
> Incidentally, would it not be great to have some machinery that automatically tracks which series is already queued where?
> Maybe there is already a mechanism I am unaware of?
> 
> Ciao,
> 
> Claudio

Hi Claudio,

I also had the same question earlier today on IRC but I've just recalled
that PULL requests typically have a reference to the queue repo/branch:

https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg06825.html

I'll rebase on it and prepare the series.

Regards,
Roman

