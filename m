Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A98C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 13:25:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2CF42078D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 13:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2CF42078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjNDB-0003yS-0O
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 09:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jjNCB-0002zZ-KJ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 09:24:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:57592)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jjNCA-0000OO-90
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 09:24:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 5E69FAF92;
 Thu, 11 Jun 2020 13:24:37 +0000 (UTC)
Subject: Re: [PATCH 12/13] i386: hvf: Move mmio_buf into CPUX86State
To: Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, qemu-devel@nongnu.org
References: <20200528193758.51454-1-r.bolshakov@yadro.com>
 <20200528193758.51454-13-r.bolshakov@yadro.com>
 <d57e48c6-574e-471c-78be-1245d62bc908@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <3101f615-e1c9-2cf4-7a7b-6e30c7942c53@suse.de>
Date: Thu, 11 Jun 2020 15:24:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <d57e48c6-574e-471c-78be-1245d62bc908@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 00:13:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/4/20 8:27 PM, Paolo Bonzini wrote:
> On 28/05/20 21:37, Roman Bolshakov wrote:
>> There's no similar field in CPUX86State, but it's needed for MMIO traps.
>>
>> Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
>> ---
>>  target/i386/cpu.h         |  1 +
>>  target/i386/hvf/hvf.c     |  5 +++++
>>  target/i386/hvf/x86.h     |  1 -
>>  target/i386/hvf/x86_emu.c | 12 ++++++------
>>  4 files changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> index 7e6566565a..be44e19154 100644
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -1593,6 +1593,7 @@ typedef struct CPUX86State {
>>  #endif
>>  #if defined(CONFIG_HVF)
>>      hvf_lazy_flags hvf_lflags;
>> +    void *hvf_mmio_buf;
>>      HVFX86EmulatorState *hvf_emul;
>>  #endif
>>  
>> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
>> index 4cee496d71..57696c46c7 100644
>> --- a/target/i386/hvf/hvf.c
>> +++ b/target/i386/hvf/hvf.c
>> @@ -533,7 +533,11 @@ void hvf_reset_vcpu(CPUState *cpu) {
>>  
>>  void hvf_vcpu_destroy(CPUState *cpu)
>>  {
>> +    X86CPU *x86_cpu = X86_CPU(cpu);
>> +    CPUX86State *env = &x86_cpu->env;
>> +
>>      hv_return_t ret = hv_vcpu_destroy((hv_vcpuid_t)cpu->hvf_fd);
>> +    g_free(env->hvf_mmio_buf);
>>      assert_hvf_ok(ret);
>>  }
>>  
>> @@ -563,6 +567,7 @@ int hvf_init_vcpu(CPUState *cpu)
>>      init_decoder();
>>  
>>      hvf_state->hvf_caps = g_new0(struct hvf_vcpu_caps, 1);
>> +    env->hvf_mmio_buf = g_new(char, 4096);
>>      env->hvf_emul = g_new0(HVFX86EmulatorState, 1);
>>  
>>      r = hv_vcpu_create((hv_vcpuid_t *)&cpu->hvf_fd, HV_VCPU_DEFAULT);
>> diff --git a/target/i386/hvf/x86.h b/target/i386/hvf/x86.h
>> index 2363616c07..483fcea762 100644
>> --- a/target/i386/hvf/x86.h
>> +++ b/target/i386/hvf/x86.h
>> @@ -230,7 +230,6 @@ typedef struct x68_segment_selector {
>>  
>>  /* Definition of hvf_x86_state is here */
>>  struct HVFX86EmulatorState {
>> -    uint8_t mmio_buf[4096];
>>  };
>>  
>>  /* useful register access  macros */
>> diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
>> index 1ad2c30e16..d3e289ed87 100644
>> --- a/target/i386/hvf/x86_emu.c
>> +++ b/target/i386/hvf/x86_emu.c
>> @@ -187,8 +187,8 @@ void write_val_ext(struct CPUX86State *env, target_ulong ptr, target_ulong val,
>>  
>>  uint8_t *read_mmio(struct CPUX86State *env, target_ulong ptr, int bytes)
>>  {
>> -    vmx_read_mem(env_cpu(env), env->hvf_emul->mmio_buf, ptr, bytes);
>> -    return env->hvf_emul->mmio_buf;
>> +    vmx_read_mem(env_cpu(env), env->hvf_mmio_buf, ptr, bytes);
>> +    return env->hvf_mmio_buf;
>>  }
>>  
>>  
>> @@ -489,9 +489,9 @@ static void exec_ins_single(struct CPUX86State *env, struct x86_decode *decode)
>>      target_ulong addr = linear_addr_size(env_cpu(env), RDI(env),
>>                                           decode->addressing_size, R_ES);
>>  
>> -    hvf_handle_io(env_cpu(env), DX(env), env->hvf_emul->mmio_buf, 0,
>> +    hvf_handle_io(env_cpu(env), DX(env), env->hvf_mmio_buf, 0,
>>                    decode->operand_size, 1);
>> -    vmx_write_mem(env_cpu(env), addr, env->hvf_emul->mmio_buf,
>> +    vmx_write_mem(env_cpu(env), addr, env->hvf_mmio_buf,
>>                    decode->operand_size);
>>  
>>      string_increment_reg(env, R_EDI, decode);
>> @@ -512,9 +512,9 @@ static void exec_outs_single(struct CPUX86State *env, struct x86_decode *decode)
>>  {
>>      target_ulong addr = decode_linear_addr(env, decode, RSI(env), R_DS);
>>  
>> -    vmx_read_mem(env_cpu(env), env->hvf_emul->mmio_buf, addr,
>> +    vmx_read_mem(env_cpu(env), env->hvf_mmio_buf, addr,
>>                   decode->operand_size);
>> -    hvf_handle_io(env_cpu(env), DX(env), env->hvf_emul->mmio_buf, 1,
>> +    hvf_handle_io(env_cpu(env), DX(env), env->hvf_mmio_buf, 1,
>>                    decode->operand_size, 1);
>>  
>>      string_increment_reg(env, R_ESI, decode);
>>
> 
> It should be possible to get rid of the buffer altogether, but it's ok
> to do it separately.
> 
> I queued the series, thanks.
> 
> Paolo
> 
> 

Thanks Paolo, I am waiting for this (and maybe another series from Roman) to be able to do the cpus refactoring.

Incidentally, would it not be great to have some machinery that automatically tracks which series is already queued where?
Maybe there is already a mechanism I am unaware of?

Ciao,

Claudio

